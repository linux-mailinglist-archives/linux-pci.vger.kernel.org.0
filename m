Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE62C7BF8
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 00:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgK2XSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Nov 2020 18:18:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgK2XSY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Nov 2020 18:18:24 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112912076C;
        Sun, 29 Nov 2020 23:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606691864;
        bh=UvFn/A9Lhl6h/HurzfA5JdUxziEQn3qtGTpb20WsY6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bspa2U/Ap8tZ1jfyB6+xdKT/lg5kDu6sDGQLH0q4VS62XFvpkOjWDiBN3VlbFEL9g
         TtcfJviWttGWpimnhVB8Tt3rBmdbwehLOUXkZRIsS+4isIH5pdxhDyln4rsZMADUsA
         lpYLW1cHwg3cUr9Ac2j7JMhbgyzeUX7ch/EInZT0=
Received: by pali.im (Postfix)
        id E048B765; Mon, 30 Nov 2020 00:17:41 +0100 (CET)
Date:   Mon, 30 Nov 2020 00:17:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Update comment about disabling link
 training
Message-ID: <20201129231741.yfhf3y42mfnbp4xb@pali>
References: <20200924084618.12442-1-pali@kernel.org>
 <20200924151106.GA2319992@bjorn-Precision-5520>
 <20200924152232.ecoxpmxdc5iyrz76@pali>
 <20201011172149.x7crspugv2xne6ui@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201011172149.x7crspugv2xne6ui@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 11 October 2020 19:21:49 Pali Rohár wrote:
> On Thursday 24 September 2020 17:22:32 Pali Rohár wrote:
> > On Thursday 24 September 2020 10:11:06 Bjorn Helgaas wrote:
> > > On Thu, Sep 24, 2020 at 10:46:18AM +0200, Pali Rohár wrote:
> > > > It is not HW bug or workaround for some cards but it is requirement by PCI
> > > > Express spec. After fundamental reset is needed 100ms delay prior enabling
> > > > link training. So update comment in code to reflect this requirement.
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > ---
> > > >  drivers/pci/controller/pci-aardvark.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > index 50ab6d7519ae..19b9b79226e5 100644
> > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > @@ -259,7 +259,12 @@ static void advk_pcie_issue_perst(struct advk_pcie *pcie)
> > > >  	if (!pcie->reset_gpio)
> > > >  		return;
> > > >  
> > > > -	/* PERST does not work for some cards when link training is enabled */
> > > > +	/*
> > > > +	 * As required by PCI Express spec a delay for at least 100ms after
> > > > +	 * de-asserting PERST# signal is needed before link training is enabled.
> > > > +	 * So ensure that link training is disabled prior de-asserting PERST#
> > > > +	 * signal to fulfill that PCI Express spec requirement.
> > > 
> > > Can you please include the spec citation here?  In the PCIe base spec,
> > > PERST# is only mentioned in PCIe r5.0, sec 6.6.1, and I don't see the
> > > connection there to 100ms between de-assert of PERST# and enabling
> > > link training.
> > 
> > Hello! I copied this "comment" from other place in pci-aardvark.c where
> > that timeout 100ms is already applied. Timeout with explanation comment
> > was introduced in following commit:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4c7d053d7f7
> > 
> > Here are links to discussions about that patch:
> > 
> > https://lore.kernel.org/linux-pci/20190313213752.1246-1-repk@triplefau.lt/T/#u
> > https://lore.kernel.org/linux-pci/20190522213351.21366-2-repk@triplefau.lt/T/#u
> 
> Bjorn or Lorenzo, do you need something else for this patch? It just
> updates comment and basically clarify why PERST does not work for some
> cards when link training is enabled.

PING?

> > > Sec 6.1.1 does talk about 100ms before sending config requests (for
> > > ports that support <= 5 GT/s), and 100ms after link training completes
> > > (for ports that support > 5 GT/s).
> > > 
> > > Maybe there's more language in a form-factor spec or something?
> > > 
> > > > +	 */
> > > >  	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> > > >  	reg &= ~LINK_TRAINING_EN;
> > > >  	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> > > > -- 
> > > > 2.20.1
> > > > 
