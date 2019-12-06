Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37F51156FC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 19:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFSKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 13:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfLFSKx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Dec 2019 13:10:53 -0500
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74025206DF;
        Fri,  6 Dec 2019 18:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575655852;
        bh=OWgFhYdmZZYA9Z/mXIp73nDYXY6T6f4+haPDZ7UWdN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qUZFjWIWKHPZoiK9Eu5agqQ7ZxSvezxZ6eAOBqcPJQ12RnGKnAtmez6TYsXyC2c3L
         ry6QPPsH6Lbzx0HGrIfGPvmET/lxcfHii3hKEIdndmsd+UMtLW7NUdhlUFO+zxFI+t
         CuyR21BKfKCTbGhL+EvtTy/7LeFhpwYU/Xe/ACtw=
Date:   Fri, 6 Dec 2019 12:10:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     andrew.murray@arm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        huawei.libin@huawei.com, guohanjun@huawei.com
Subject: Re: [PATCH v2] PCI: Add quirk for HiSilicon NP 5896 devices
Message-ID: <20191206181051.GA121021@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575615705-30716-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 06, 2019 at 03:01:45PM +0800, Xiongfeng Wang wrote:
> HiSilicon PCI Network Processor 5896 devices misreport the class type as
> 'NOT_DEFINED', but it is actually a network device. Also the size of
> BAR3 is reported as 265T, but this BAR is actually unused.
> This patch modify the class type to 'CLASS_NETWORK' and disable the
> unused BAR3.

"NOT_DEFINED" is not the value in the Class Code register.  The commit
message should include the actual value.

> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/pci/quirks.c    | 29 +++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4937a08..b9adebb 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5431,3 +5431,32 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>  			      PCI_CLASS_DISPLAY_VGA, 8,
>  			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
> +
> +static void quirk_hisi_fixup_np_class(struct pci_dev *pdev)
> +{
> +	u32 class = pdev->class;
> +
> +	pdev->class = PCI_BASE_CLASS_NETWORK << 8;
> +	pci_info(pdev, "PCI class overriden (%#08x -> %#08x)\n",
> +		 class, pdev->class);
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
> +			quirk_hisi_fixup_np_class);
> +
> +/*
> + * HiSilicon NP 5896 devices BAR3 size is reported as 256T and causes problem
> + * when assigning the resources. But this BAR is actually unused by the driver,
> + * so let's disable it.

The question is not whether the BAR is used by the driver; the
question is whether the device responds to accesses to the region
described by the BAR when PCI_COMMAND_MEMORY is turned on.

> + */
> +static void quirk_hisi_fixup_np_bar(struct pci_dev *pdev)
> +{
> +	struct resource *r = &pdev->resource[3];
> +
> +	r->start = 0;
> +	r->end = 0;
> +	r->flags = 0;
> +
> +	pci_info(pdev, "Disabling invalid BAR 3\n");

This quirk clears the Linux *resource* related to the BAR, but it
does nothing with the hardware register itself.  There is no way to
disable an individual BAR; all we have is PCI_COMMAND_MEMORY, which
enables/disables all memory BARs as a group.

If this is a device defect, where the config register at 0x1c *looks*
like a BAR, but it actually isn't a BAR and doesn't cause the device
to decode any address space, a quirk like this might be OK.  But if
the device does decode address space described by that BAR, we need
more than this.

Can you provide "sudo lspci -vvxxx" output for this device?

> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
> +			 quirk_hisi_fixup_np_bar);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 2302d133..f21cd8b 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2558,6 +2558,7 @@
>  #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
>  
>  #define PCI_VENDOR_ID_HUAWEI		0x19e5
> +#define PCI_DEVICE_ID_HISI_5896        0x5896 /* HiSilicon NP 5896 devices */
>  
>  #define PCI_VENDOR_ID_NETRONOME		0x19ee
>  #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
> -- 
> 1.7.12.4
> 
