Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598698A26F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 17:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfHLPik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 11:38:40 -0400
Received: from foss.arm.com ([217.140.110.172]:52044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfHLPik (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 11:38:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C1CB15A2;
        Mon, 12 Aug 2019 08:38:39 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB2143F718;
        Mon, 12 Aug 2019 08:38:37 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:38:33 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Message-ID: <20190812153833.GA30794@e121166-lin.cambridge.arm.com>
References: <1565135484-31351-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565135484-31351-1-git-send-email-haiyangz@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 06, 2019 at 11:52:11PM +0000, Haiyang Zhang wrote:
> Currently in Azure cloud, for passthrough devices including GPU, the
> host sets the device instance ID's bytes 8 - 15 to a value derived from
> the host HWID, which is the same on all devices in a VM. So, the device
> instance ID's bytes 8 and 9 provided by the host are no longer unique.
> 
> This can cause device passthrough to VMs to fail because the bytes 8 and
> 9 is used as PCI domain number. So, as recommended by Azure host team,
> we now use the bytes 4 and 5 which usually contain unique numbers as PCI
> domain. The chance of collision is greatly reduced. In the rare cases of
> collision, we will detect and find another number that is not in use.

This is not clear at all. Why "finding another number" is fine with
this patch while it is not with current kernel code ? Also does this
have backward compatibility issues ?

I do not understand if a collision is a problem or not from the
log above.

> Thanks to Michael Kelley <mikelley@microsoft.com> for proposing this idea.

Add it as Suggested-by: tag.

Thanks,
Lorenzo

> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Acked-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 92 +++++++++++++++++++++++++++++++------
>  1 file changed, 79 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 40b6254..4f3d97e 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2510,6 +2510,48 @@ static void put_hvpcibus(struct hv_pcibus_device *hbus)
>  		complete(&hbus->remove_event);
>  }
>  
> +#define HVPCI_DOM_MAP_SIZE (64 * 1024)
> +static DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
> +
> +/*
> + * PCI domain number 0 is used by emulated devices on Gen1 VMs, so define 0
> + * as invalid for passthrough PCI devices of this driver.
> + */
> +#define HVPCI_DOM_INVALID 0
> +
> +/**
> + * hv_get_dom_num() - Get a valid PCI domain number
> + * Check if the PCI domain number is in use, and return another number if
> + * it is in use.
> + *
> + * @dom: Requested domain number
> + *
> + * return: domain number on success, HVPCI_DOM_INVALID on failure
> + */
> +static u16 hv_get_dom_num(u16 dom)
> +{
> +	unsigned int i;
> +
> +	if (test_and_set_bit(dom, hvpci_dom_map) == 0)
> +		return dom;
> +
> +	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
> +		if (test_and_set_bit(i, hvpci_dom_map) == 0)
> +			return i;
> +	}
> +
> +	return HVPCI_DOM_INVALID;
> +}
> +
> +/**
> + * hv_put_dom_num() - Mark the PCI domain number as free
> + * @dom: Domain number to be freed
> + */
> +static void hv_put_dom_num(u16 dom)
> +{
> +	clear_bit(dom, hvpci_dom_map);
> +}
> +
>  /**
>   * hv_pci_probe() - New VMBus channel probe, for a root PCI bus
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> @@ -2521,6 +2563,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  			const struct hv_vmbus_device_id *dev_id)
>  {
>  	struct hv_pcibus_device *hbus;
> +	u16 dom_req, dom;
>  	int ret;
>  
>  	/*
> @@ -2535,19 +2578,34 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hbus->state = hv_pcibus_init;
>  
>  	/*
> -	 * The PCI bus "domain" is what is called "segment" in ACPI and
> -	 * other specs.  Pull it from the instance ID, to get something
> -	 * unique.  Bytes 8 and 9 are what is used in Windows guests, so
> -	 * do the same thing for consistency.  Note that, since this code
> -	 * only runs in a Hyper-V VM, Hyper-V can (and does) guarantee
> -	 * that (1) the only domain in use for something that looks like
> -	 * a physical PCI bus (which is actually emulated by the
> -	 * hypervisor) is domain 0 and (2) there will be no overlap
> -	 * between domains derived from these instance IDs in the same
> -	 * VM.
> +	 * The PCI bus "domain" is what is called "segment" in ACPI and other
> +	 * specs. Pull it from the instance ID, to get something usually
> +	 * unique. In rare cases of collision, we will find out another number
> +	 * not in use.
> +	 *
> +	 * Note that, since this code only runs in a Hyper-V VM, Hyper-V
> +	 * together with this guest driver can guarantee that (1) The only
> +	 * domain used by Gen1 VMs for something that looks like a physical
> +	 * PCI bus (which is actually emulated by the hypervisor) is domain 0.
> +	 * (2) There will be no overlap between domains (after fixing possible
> +	 * collisions) in the same VM.
>  	 */
> -	hbus->sysdata.domain = hdev->dev_instance.b[9] |
> -			       hdev->dev_instance.b[8] << 8;
> +	dom_req = hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
> +	dom = hv_get_dom_num(dom_req);
> +
> +	if (dom == HVPCI_DOM_INVALID) {
> +		dev_err(&hdev->device,
> +			"Unable to use dom# 0x%hx or other numbers", dom_req);
> +		ret = -EINVAL;
> +		goto free_bus;
> +	}
> +
> +	if (dom != dom_req)
> +		dev_info(&hdev->device,
> +			 "PCI dom# 0x%hx has collision, using 0x%hx",
> +			 dom_req, dom);
> +
> +	hbus->sysdata.domain = dom;
>  
>  	hbus->hdev = hdev;
>  	refcount_set(&hbus->remove_lock, 1);
> @@ -2562,7 +2620,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  					   hbus->sysdata.domain);
>  	if (!hbus->wq) {
>  		ret = -ENOMEM;
> -		goto free_bus;
> +		goto free_dom;
>  	}
>  
>  	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
> @@ -2639,6 +2697,8 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	vmbus_close(hdev->channel);
>  destroy_wq:
>  	destroy_workqueue(hbus->wq);
> +free_dom:
> +	hv_put_dom_num(hbus->sysdata.domain);
>  free_bus:
>  	free_page((unsigned long)hbus);
>  	return ret;
> @@ -2720,6 +2780,9 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	put_hvpcibus(hbus);
>  	wait_for_completion(&hbus->remove_event);
>  	destroy_workqueue(hbus->wq);
> +
> +	hv_put_dom_num(hbus->sysdata.domain);
> +
>  	free_page((unsigned long)hbus);
>  	return 0;
>  }
> @@ -2747,6 +2810,9 @@ static void __exit exit_hv_pci_drv(void)
>  
>  static int __init init_hv_pci_drv(void)
>  {
> +	/* Set the invalid domain number's bit, so it will not be used */
> +	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
> +
>  	return vmbus_driver_register(&hv_pci_drv);
>  }
>  
> -- 
> 1.8.3.1
> 
