Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C241140AB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2019 13:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfLEMPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Dec 2019 07:15:32 -0500
Received: from foss.arm.com ([217.140.110.172]:60562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfLEMPc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Dec 2019 07:15:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C64031B;
        Thu,  5 Dec 2019 04:15:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9E563F68E;
        Thu,  5 Dec 2019 04:15:30 -0800 (PST)
Date:   Thu, 5 Dec 2019 12:15:29 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        huawei.libin@huawei.com, guohanjun@huawei.com
Subject: Re: [PATCH] PCI: Add quirk to disable unused BAR for hisilicon NP
 devices 5896
Message-ID: <20191205121527.GL18399@e119886-lin.cambridge.arm.com>
References: <1575546041-50907-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575546041-50907-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 05, 2019 at 07:40:41PM +0800, Xiongfeng Wang wrote:
> Add pci quirk for hisilicon PCI Network Processor devices 5896.

Can you capatalise HiSilicon correctly (capital H and S), both here and
in the subject line?

s/devices 5896/5896 devices/ ?

> The size of the unused BAR3 is set as 265T wrongly. This patch disalbes

s/disalbes/disables/

> this bar.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/pci/quirks.c    | 29 +++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4937a08..7dfb272 100644
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

Why is this in here? This is completely unrelated to the commit message.

> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
> +			quirk_hisi_fixup_np_class);
> +
> +/*
> + * Hisilicon NP devices 5896 BAR3 size is misreported as 256T. Actually, this
> + * BAR is unused, so let's disable it.

Does this mean that the existing driver doesn't use this BAR? Is a better fix
up the BAR to report the correct size?


> + */
> +#define HISI_5896_WRONG_BAR 3

I'd suggest this define is possibly not required.

> +static void quirk_hisi_fixup_np_bar(struct pci_dev *pdev)
> +{
> +	struct resource *r = &pdev->resource[HISI_5896_WRONG_BAR];
> +
> +	r->start = 0;
> +	r->end = 0;
> +	r->flags = 0;
> +
> +	pci_info(pdev, "disable BAR %d\n", HISI_5896_WRONG_BAR);

It might be more helpful to describe why, e.g. "Disabling invalid BAR 3"
or similar.


> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
> +			 quirk_hisi_fixup_np_bar);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 2302d133..56e2b91 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2558,6 +2558,7 @@
>  #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
>  
>  #define PCI_VENDOR_ID_HUAWEI		0x19e5
> +#define PCI_DEVICE_ID_HISI_5896        0x5896 /* Hisilicon NP devices 5896 */
>  
>  #define PCI_VENDOR_ID_NETRONOME		0x19ee
>  #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000

Thanks,

Andrew Murray

> -- 
> 1.7.12.4
> 
