Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 496381241F9
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 09:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfLRImA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 03:42:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbfLRImA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Dec 2019 03:42:00 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9772F88D824058336E49;
        Wed, 18 Dec 2019 16:41:57 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Dec 2019
 16:41:47 +0800
Subject: Re: [PATCH v2] PCI: Add quirk for HiSilicon NP 5896 devices
To:     <andrew.murray@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>,
        <guohanjun@huawei.com>
References: <1575615705-30716-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <60c0001e-3753-6e3f-b114-ddc62e5d50ac@huawei.com>
Date:   Wed, 18 Dec 2019 16:41:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1575615705-30716-1-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019/12/6 15:01, Xiongfeng Wang wrote:
> HiSilicon PCI Network Processor 5896 devices misreport the class type as
> 'NOT_DEFINED', but it is actually a network device. Also the size of
> BAR3 is reported as 265T, but this BAR is actually unused.
> This patch modify the class type to 'CLASS_NETWORK' and disable the
> unused BAR3.
> 
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

It should be  pdev->class = PCI_CLASS_NETWORK_ETHERNET << 8;
I will change it in the next version.

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
> 

