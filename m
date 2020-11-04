Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97AA2A64DC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 14:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgKDNK6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 08:10:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgKDNK5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 08:10:57 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8787B2071A;
        Wed,  4 Nov 2020 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604495456;
        bh=kn+yF28RMt7e0fZL7+4iW/OsXTskEYiuJM+B99/2Rvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hkPQO35pDKivkQ2XEOBVSDGBv3gl9uJk1HuP9Sl7/yndTFGdm9AQQaP5IXcODiauE
         HB2VRZHr4lRlZDaph8PQFmo0aKybpWVsA5lLrdc8+UOasvb2f7VGhompqVWYTb+cMk
         y50qT45u76PoctQVAMqjgK9n5WAmVmJNb6uYyxMk=
Date:   Wed, 4 Nov 2020 07:10:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] PCI: mediatek: Fix wrong operator used
Message-ID: <20201104131054.GA307984@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f722bb80c440b69dd350b48f86cd7d076a8adf.1604443256.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The subject needs to say something about the user-visible problem
you're fixing, e.g., functions other than 0 aren't configured
correctly.

On Wed, Nov 04, 2020 at 07:10:11AM +0800, Ryder Lee wrote:
> SoCs like MT2701 and MT7623 use mtk_pcie_startup_port() to compute "func",
> but from the code, the result we get is incorrect.

This affects precisely "MT2701 and MT7623", not "SoCs *like* MT2701
and MT7623".  How about this:

  PCI: mediatek: Configure FC and FTS for functions other than 0

  "PCI_FUNC(port->slot << 3)" is always 0, so previously
  mtk_pcie_startup_port() only configured FC credits and FTs for
  function 0.

  Compute "func" correctly so we also configure functions other than
  0.  This affects MT2701 and MT7623.

> 	#define PCI_FUNC(devfn)         ((devfn) & 0x07)
> 
> 	func = PCI_FUNC(port->slot << 3)
> 
> The "func" is always 0, which results in other functions may not have been
> configured correctly. (i.e. FC credits and FTS)
> 
> Addresses-Coverity-ID: 1437218 ("Wrong operator used")
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> V2 - revise commit log
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
