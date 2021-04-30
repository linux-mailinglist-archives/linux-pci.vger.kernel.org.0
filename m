Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FF636FEA8
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 18:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhD3Qfk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 12:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhD3Qfk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 12:35:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 881D860233;
        Fri, 30 Apr 2021 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619800491;
        bh=CTKqzMvOc6YCJvRdNUuExGC6a82/6LKQAJ0WVAxwTHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HcVnRRoN6PJV0PZxkh2SBFKELhCNx2XmJ+OJDu3mRyWzYHMRNkMciQVXCumFAekqC
         YCz6QclpGMiYgurI5/ZjQrZ9zmHcdXaeyiKGLpfyUTpMM7OMPMgwdK2TDpGcDd8kAc
         XUQ9koyWLfJaF7xjXZDy2tW/LjUkZCdLu71d/NtQXmv0brxgoTVAyDHIwHzc7XOL9F
         jTn2O6wUqTjEGEUSVBFo8aJRlP74s1/s7K3xkGcYSNVrurbvKkboyKRAHgNOFB1rhn
         FexsQ7BigHsIs+5nRzS8RgccqusV/3IgXfVj7yy+xYxJKdC2RcqNpxHvJBn4DBru9b
         4yeikauXWCrbg==
Date:   Fri, 30 Apr 2021 11:34:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Colin King <colin.king@canonical.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: mediatek-gen3: Add missing null pointer check
Message-ID: <20210430163450.GA657994@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a512e3a-2897-ac12-ac6e-06be28735279@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 09:47:06AM +0200, Christophe JAILLET wrote:
> Le 29/04/2021 à 13:00, Colin King a écrit :
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The call to platform_get_resource_byname can potentially return null, so
> > add a null pointer check to avoid a null pointer dereference issue.
> > 
> > Addresses-Coverity: ("Dereference null return")
> > Fixes: 441903d9e8f0 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   drivers/pci/controller/pcie-mediatek-gen3.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> > index 20165e4a75b2..3c5b97716d40 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -721,6 +721,8 @@ static int mtk_pcie_parse_port(struct mtk_pcie_port *port)
> >   	int ret;
> >   	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
> > +	if (!regs)
> > +		return -EINVAL;
> >   	port->base = devm_ioremap_resource(dev, regs);
> >   	if (IS_ERR(port->base)) {
> >   		dev_err(dev, "failed to map register base\n");
> > 
> 
> Nitpick:
>    Using 'devm_platform_ioremap_resource_byname' is slightly less verbose
> and should please Coverity.

Not a nitpick at all.  Jianjun is correct that devm_ioremap_resource()
does check "regs" for NULL and it fails gracefully before trying to
dereference it, so the extra check shouldn't be needed.  And most
cases in drivers/pci/ look like this, without the extra check:

  res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
  base = devm_ioremap_resource(dev, res);
  if (IS_ERR(base))
    ...

If devm_platform_ioremap_resource_byname() keeps Coverity happy, I
think that's what we should be doing across drivers/pci/.  Coverity
false positives are a hassle.

Seems like something for next cycle since we're in the middle of the
merge window.

> Also, which git repo are you using? On linux-next ([1)], your proposed patch
> is already part of "PCI: mediatek-gen3: Add MediaTek Gen3 driver for
> MT8192".
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/pci/controller/pcie-mediatek-gen3.c

I think this is because Lorenzo already squashed Colin's change in.

Bjorn
