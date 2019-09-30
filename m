Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC123C2292
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 16:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbfI3OCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 10:02:21 -0400
Received: from foss.arm.com ([217.140.110.172]:55002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbfI3OCU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 10:02:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DDF028;
        Mon, 30 Sep 2019 07:02:20 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B2C13F706;
        Mon, 30 Sep 2019 07:02:19 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:02:17 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     bhelgaas@google.com, zenglu@loongson.cn, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add Loongson vendor ID and device IDs
Message-ID: <20190930140217.GB38576@e119886-lin.cambridge.arm.com>
References: <279cbe32-a44b-3190-aaf7-a277a1220720@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279cbe32-a44b-3190-aaf7-a277a1220720@loongson.cn>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 12:55:20PM +0800, Tiezhu Yang wrote:
> Add the Loongson vendor ID and device IDs to pci_ids.h
> to be used in the future.
> 
> The Loongson IDs can be found at the following link:
> https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/pci.ids
> 
> Co-developed-by: Lu Zeng <zenglu@loongson.cn>
> Signed-off-by: Lu Zeng <zenglu@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  include/linux/pci_ids.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 21a5724..119639d 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3111,4 +3111,23 @@
> 
>  #define PCI_VENDOR_ID_NCUBE            0x10ff
> 
> +#define PCI_VENDOR_ID_LOONGSON                 0x0014
> +#define PCI_DEVICE_ID_LOONGSON_HT              0x7a00
> +#define PCI_DEVICE_ID_LOONGSON_APB             0x7a02
> +#define PCI_DEVICE_ID_LOONGSON_GMAC            0x7a03
> +#define PCI_DEVICE_ID_LOONGSON_OTG             0x7a04
> +#define PCI_DEVICE_ID_LOONGSON_GPU_2K1000      0x7a05
> +#define PCI_DEVICE_ID_LOONGSON_DC              0x7a06
> +#define PCI_DEVICE_ID_LOONGSON_HDA             0x7a07
> +#define PCI_DEVICE_ID_LOONGSON_SATA            0x7a08
> +#define PCI_DEVICE_ID_LOONGSON_PCIE_X1         0x7a09
> +#define PCI_DEVICE_ID_LOONGSON_SPI             0x7a0b
> +#define PCI_DEVICE_ID_LOONGSON_LPC             0x7a0c
> +#define PCI_DEVICE_ID_LOONGSON_DMA             0x7a0f
> +#define PCI_DEVICE_ID_LOONGSON_EHCI            0x7a14
> +#define PCI_DEVICE_ID_LOONGSON_GPU_7A1000      0x7a15
> +#define PCI_DEVICE_ID_LOONGSON_PCIE_X4         0x7a19
> +#define PCI_DEVICE_ID_LOONGSON_OHCI            0x7a24
> +#define PCI_DEVICE_ID_LOONGSON_PCIE_X8         0x7a29

Hi Tiezhu,

Thanks for the patch - however it is preferred to provide new PCI definitions
along with the drivers that use them. They don't provide any useful value
without drivers that use them.

Thanks,

Andrew Murray

> +
>  #endif /* _LINUX_PCI_IDS_H */
> -- 
> 2.1.0
> 
> 
