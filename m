Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CD837AA9B
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 17:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEKPZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 11:25:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2778 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhEKPZ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 11:25:28 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfhT656hWzmg1f;
        Tue, 11 May 2021 23:20:58 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 23:24:15 +0800
Subject: Re: [PATCH V2 5/5] PCI: Enable 10-Bit tag support for PCIe RP devices
To:     <helgaas@kernel.org>, <hch@infradead.org>,
        <linux-pci@vger.kernel.org>
References: <1620745965-91535-1-git-send-email-liudongdong3@huawei.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <791a5af6-bcbb-a824-ecd7-504abe7194e2@huawei.com>
Date:   Tue, 11 May 2021 23:24:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1620745965-91535-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch is based on the patchset [PATCH V2 0/5] PCI: Enable 10-Bit 
tag support for PCIe devices.

I use "git send-email" report "4.4.2 Message submission rate for this 
client has exceeded the configured limit" lead missed [PATCH V2 5/5].
Current I send the [PATCH V2 5/5] separately.
I have not figured out the "git send-email" issue :(. sometimes it's ok.

Thanks,
Dongdong
On 2021/5/11 23:12, Dongdong Liu wrote:
> PCIe spec 5.0r1.0 section 2.2.6.2 implementation note, In configurations
> where a Requester with 10-Bit Tag Requester capability needs to target
> multiple Completers, one needs to ensure that the Requester sends 10-Bit
> Tag Requests only to Completers that have 10-Bit Tag Completer capability.
> So we enable 10-Bit Tag Requester for root port only when the devices
> under the root port support 10-Bit Tag Completer.
>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 76 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index c7ff1ee..19e6e62 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -90,6 +90,79 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  #define PCIE_PORTDRV_PM_OPS	NULL
>  #endif /* !PM */
>
> +static int pci_10bit_tag_comp_support(struct pci_dev *dev, void *data)
> +{
> +	u8 *support = data;
> +
> +	if (*support == 0)
> +		return 0;
> +
> +	if (!pci_is_pcie(dev)) {
> +		*support = 0;
> +		return 0;
> +	}
> +
> +	/*
> +	 * PCIe spec 5.0r1.0 section 2.2.6.2 implementation note
> +	 * For configurations where a Requester with 10-Bit Tag Requester capability
> +	 * targets Completers where some do and some do not have 10-Bit Tag
> +	 * Completer capability, how the Requester determines which NPRs include
> +	 * 10-Bit Tags is outside the scope of this specification.  So we do not consider
> +	 * hotplug scenario.
> +	 */
> +	if (dev->is_hotplug_bridge) {
> +		*support = 0;
> +		return 0;
> +	}
> +
> +
> +	if (!(dev->devcap2 & PCI_EXP_DEVCAP2_10BIT_TAG_COMP)) {
> +		*support = 0;
> +		return 0;
> +	}
> +
> +
> +	return 0;
> +}
> +
> +static void pci_configure_rp_10bit_tag(struct pci_dev *dev)
> +{
> +	u8 support = 1;
> +	struct pci_dev *pchild;
> +
> +	if (dev->subordinate == NULL)
> +		return;
> +
> +	/* If no devices under the root port,  no need to enable 10-Bit Tag. */
> +	pchild = list_first_entry_or_null(&dev->subordinate->devices,
> +					  struct pci_dev, bus_list);
> +	if (pchild == NULL)
> +		return;
> +
> +	pci_10bit_tag_comp_support(dev, &support);
> +	if (!support)
> +		return;
> +
> +	/*
> +	 * PCIe spec 5.0r1.0 section 2.2.6.2 implementation note
> +	 * In configurations where a Requester with 10-Bit Tag Requester capability
> +	 * needs to target multiple Completers, one needs to ensure that the
> +	 * Requester sends 10-Bit Tag Requests only to Completers that have 10-Bit
> +	 * Tag Completer capability. So we enable 10-Bit Tag Requester for root port
> +	 * only when the devices under the root port support 10-Bit Tag Completer.
> +	 */
> +	pci_walk_bus(dev->subordinate, pci_10bit_tag_comp_support, &support);
> +	if (!support)
> +		return;
> +
> +	if (!(dev->devcap2 & PCI_EXP_DEVCAP2_10BIT_TAG_REQ))
> +		return;
> +
> +	pci_dbg(dev, "enabling 10-Bit Tag Requester\n");
> +	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> +				 PCI_EXP_DEVCTL2_10BIT_TAG_REQ_EN);
> +}
> +
>  /*
>   * pcie_portdrv_probe - Probe PCI-Express port devices
>   * @dev: PCI-Express port device being probed
> @@ -111,6 +184,9 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	     (type != PCI_EXP_TYPE_RC_EC)))
>  		return -ENODEV;
>
> +	if (type == PCI_EXP_TYPE_ROOT_PORT)
> +		pci_configure_rp_10bit_tag(dev);
> +
>  	if (type == PCI_EXP_TYPE_RC_EC)
>  		pcie_link_rcec(dev);
>
>
