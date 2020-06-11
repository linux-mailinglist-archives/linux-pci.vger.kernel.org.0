Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9760A1F6EB3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 22:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFKU0G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 16:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgFKU0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 16:26:06 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971A220720;
        Thu, 11 Jun 2020 20:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591907165;
        bh=s47z8lODBzSm0LZKYlLpBvi6N/wT478JfS72hrNSu1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=00oOcSWlCfib9RUNo8m5N2YbMdb+1mowLfPOPN3aLBNMexXrZu9fXAXAfqzEenB3d
         O8VVs2P2rjucOThQS6dNZLG4hW/ARdyRXmfqITAk/VBtaRbHRx/DBJYuLmjIIxUhR1
         OkZGoq4u2Vcac8TQdYBzxMlclx8+Q1Iipuqw2PFU=
Date:   Thu, 11 Jun 2020 15:26:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] PCI: Loongson: Use DECLARE_PCI_FIXUP_EARLY for
 bridge_class_quirk()
Message-ID: <20200611202604.GA1607130@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591756790-12081-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Subject line:

  PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for bridge_class_quirk()

(Driver names are conventionally lower case.)

Lorenzo will probably silently fix this when applying, so this is
mostly just a reminder in case you need to revise this or for future
patches.

On Wed, Jun 10, 2020 at 10:39:50AM +0800, Tiezhu Yang wrote:
> Use DECLARE_PCI_FIXUP_EARLY instead of DECLARE_PCI_FIXUP_HEADER
> for bridge_class_quirk() in pci-loongson.c, otherwise the fixup
> has no effect.
> 
> Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> This patch is based on mips-next tree.
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
