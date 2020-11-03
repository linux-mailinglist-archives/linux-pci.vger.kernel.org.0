Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1992A589C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 22:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgKCVxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 16:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733285AbgKCVxG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 16:53:06 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1647420780;
        Tue,  3 Nov 2020 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604440385;
        bh=yoBMHGcgRu6treiQlSwNvpxiAT/18A01oukKu7Eg8Co=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vHJ3YSUnWQcayJDc4n52S8eMzMfoUSY4xVboDBfH25nai0+liUgeyDVB3BO+u/TFx
         39fHwXM5ktxZFadWuWTVZzF4PLYNs6ne4tnbGC8oS8GinPMMyBH5F/FDJG4+U+OomR
         lYriSuuiytYA+rr+KvvkgdR/AGK20v8r2wzGWJDM=
Date:   Tue, 3 Nov 2020 15:53:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] pci: mediatek: fix wrong operator used
Message-ID: <20201103215303.GA267664@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2418edb8c8c81bc646ce9c508939dc27e848dcd7.1603817008.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  $ git log --oneline drivers/pci/controller/pcie-mediatek.c
  ...
  0cccd42e6193 ("PCI: mediatek: Add controller support for MT7629")
  6be22343cc54 ("PCI: mediatek: Get optional clocks with devm_clk_get_optional()")
  ff7a5a0a8562 ("PCI: mediatek: Fix a leaked reference by adding missing of_node_put()")
  cbe3a7728c7a ("PCI: mediatek: Enlarge PCIe2AHB window size to support 4GB DRAM")

Make yours match in capitalization and sentence structure, e.g.,

  PCI: mediatek: Fix ...

On Wed, Oct 28, 2020 at 12:51:48AM +0800, Ryder Lee wrote:
> Fix the issue reported by Coverity:
> Wrong operator used (CONSTANT_EXPRESSION_RESULT) operator_confusion:
> (port->slot << 3) & 7 is always 0 regardless of the values of its operands.
> This occurs as an initializer.

The important thing here is *not* fixing the Coverity warning.  The
important thing is fixing the *bug*.

The bug is that we computed "func" incorrectly.  The commit log should
mention what bad things happened because "func" was incorrect.

  #define PCI_FUNC(devfn)         ((devfn) & 0x07)

  func = PCI_FUNC(port->slot << 3);

So "func" was always 0 before, and from the code, it looks like that
means we only configured FC credits and FTS for function 0, so any
other functions may not have been configured correctly.

And it looks like this only affects MT2701 and MT7623, since those are
the only devices that use mtk_pcie_startup_port().

This is all info that should be in the commit log so users can tell
whether they are affected.

It's nice to still *mention* Coverity since it gave us useful
information, but all we need is a reference like this:

  Addresses-Coverity-ID: 1437218 ("Wrong operator used")

> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index cf4c18f0c25a..1980b01cee35 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -760,7 +760,7 @@ static struct pci_ops mtk_pcie_ops = {
>  static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
>  {
>  	struct mtk_pcie *pcie = port->pcie;
> -	u32 func = PCI_FUNC(port->slot << 3);
> +	u32 func = PCI_FUNC(port->slot);
>  	u32 slot = PCI_SLOT(port->slot << 3);
>  	u32 val;
>  	int err;
> -- 
> 2.18.0
