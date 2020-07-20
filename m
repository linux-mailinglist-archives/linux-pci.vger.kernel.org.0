Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4462261A3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jul 2020 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgGTOKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jul 2020 10:10:43 -0400
Received: from foss.arm.com ([217.140.110.172]:49004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgGTOKm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Jul 2020 10:10:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EBFB113E;
        Mon, 20 Jul 2020 07:10:42 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 101573F718;
        Mon, 20 Jul 2020 07:10:40 -0700 (PDT)
Date:   Mon, 20 Jul 2020 15:10:34 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v5] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for
 bridge_class_quirk()
Message-ID: <20200720141034.GA26850@e121166-lin.cambridge.arm.com>
References: <1595065176-460-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595065176-460-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 18, 2020 at 05:39:36PM +0800, Tiezhu Yang wrote:
> According to the datasheet of Loongson LS7A bridge chip, the old version
> of Loongson LS7A PCIE port has a wrong value about PCI class which is
> 0x060000, the correct value should be 0x060400, this bug can be fixed by
> "dev->class = PCI_CLASS_BRIDGE_PCI << 8;" at the software level. As far
> as I know, the latest version of LS7A has already fixed the value at the
> hardware level.
> 
> In order to maintain downward compatibility, use DECLARE_PCI_FIXUP_EARLY
> instead of DECLARE_PCI_FIXUP_HEADER for bridge_class_quirk() to fix it as
> early as possible.
> 
> Otherwise, in the function pci_setup_device(), the related code about
> "dev->class" such as "class = dev->class >> 8;" and "dev->transparent
> = ((dev->class & 0xff) == 1);" maybe get wrong value without EARLY fixup.
> 
> Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v2: Modify the patch subject used with lower case "loongson"
> 
> v3: Update the commit message
> 
> v4: Update the commit message to describe the bug
> 
> v5: Remove "due to" in the commit message suggested by Sergei Shtylyov
> 
>  drivers/pci/controller/pci-loongson.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to pci/loongson, thanks.

Lorenzo

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
