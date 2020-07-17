Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D7C22393D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 12:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgGQK2u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 06:28:50 -0400
Received: from foss.arm.com ([217.140.110.172]:50922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQK2u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jul 2020 06:28:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A68A1D6E;
        Fri, 17 Jul 2020 03:28:49 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56D223F66E;
        Fri, 17 Jul 2020 03:28:48 -0700 (PDT)
Date:   Fri, 17 Jul 2020 11:28:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v3] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for
 bridge_class_quirk()
Message-ID: <20200717102842.GA4353@e121166-lin.cambridge.arm.com>
References: <1594865946-15188-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594865946-15188-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 16, 2020 at 10:19:06AM +0800, Tiezhu Yang wrote:
> According to the datasheet of Loongson LS7A bridge chip, the old version
> of Loongson LS7A PCIE port has a hardware bug about PCI class. As far as
> I know, the latest version has already fixed this bug.

Please define the bug and how are you fixing it, that's it.

> In order to maintain downward compatibility, use DECLARE_PCI_FIXUP_EARLY
> instead of DECLARE_PCI_FIXUP_HEADER for bridge_class_quirk() to fix it as
> early as possible.
> 
> Otherwise, in the function pci_setup_device(), the related code about
> "dev->class" such as "class = dev->class >> 8;" and "dev->transparent
> = ((dev->class & 0xff) == 1);" maybe get wrong value due to without
> EARLY fixup.
> 
> By the way, we can see that the PCI class fixup of other controllers are
> all EARLY fixups:
> 
> [root@linux linux.git]# grep -rn -A 3 "PCI_CLASS_BRIDGE_PCI << 8" drivers/pci/controller/ | grep EARLY
> drivers/pci/controller/pcie-tango.c-327-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0024, tango_fixup_class);
> drivers/pci/controller/pcie-tango.c-328-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0028, tango_fixup_class);
> drivers/pci/controller/pci-tegra.c-775-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_fixup_class);
> drivers/pci/controller/pci-tegra.c-776-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
> drivers/pci/controller/dwc/pcie-qcom.c-1442-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class);
> drivers/pci/controller/dwc/pcie-qcom.c-1443-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0104, qcom_fixup_class);
> drivers/pci/controller/pcie-iproc-bcma.c-23-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8011, bcma_pcie2_fixup_class);
> drivers/pci/controller/pcie-iproc-bcma.c-24-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8012, bcma_pcie2_fixup_class);

This is irrelevant information, please remove it.

Thanks,
Lorenzo

> Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v2: Modify the patch subject used with lower case "loongson"
> 
> v3: Update the commit message
> 
>  drivers/pci/controller/pci-loongson.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 459009c..58b862a 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -37,11 +37,11 @@ static void bridge_class_quirk(struct pci_dev *dev)
>  {
>  	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>  }
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_PCIE_PORT_0, bridge_class_quirk);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_PCIE_PORT_1, bridge_class_quirk);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_PCIE_PORT_2, bridge_class_quirk);
>  
>  static void system_bus_quirk(struct pci_dev *pdev)
> -- 
> 2.1.0
> 
