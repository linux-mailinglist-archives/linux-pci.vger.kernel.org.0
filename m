Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334FC2C82A7
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 11:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgK3Kwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 05:52:55 -0500
Received: from foss.arm.com ([217.140.110.172]:52356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgK3Kwz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 05:52:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D50230E;
        Mon, 30 Nov 2020 02:52:09 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 479DA3F66B;
        Mon, 30 Nov 2020 02:52:08 -0800 (PST)
Date:   Mon, 30 Nov 2020 10:52:00 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Update comment about disabling link
 training
Message-ID: <20201130105200.GA16758@e121166-lin.cambridge.arm.com>
References: <20200924084618.12442-1-pali@kernel.org>
 <20200924151106.GA2319992@bjorn-Precision-5520>
 <20200924152232.ecoxpmxdc5iyrz76@pali>
 <20201011172149.x7crspugv2xne6ui@pali>
 <20201129231741.yfhf3y42mfnbp4xb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201129231741.yfhf3y42mfnbp4xb@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 12:17:41AM +0100, Pali Rohár wrote:
> On Sunday 11 October 2020 19:21:49 Pali Rohár wrote:
> > On Thursday 24 September 2020 17:22:32 Pali Rohár wrote:
> > > On Thursday 24 September 2020 10:11:06 Bjorn Helgaas wrote:
> > > > On Thu, Sep 24, 2020 at 10:46:18AM +0200, Pali Rohár wrote:
> > > > > It is not HW bug or workaround for some cards but it is requirement by PCI
> > > > > Express spec. After fundamental reset is needed 100ms delay prior enabling
> > > > > link training. So update comment in code to reflect this requirement.
> > > > > 
> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > ---
> > > > >  drivers/pci/controller/pci-aardvark.c | 7 ++++++-
> > > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > > index 50ab6d7519ae..19b9b79226e5 100644
> > > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > > @@ -259,7 +259,12 @@ static void advk_pcie_issue_perst(struct advk_pcie *pcie)
> > > > >  	if (!pcie->reset_gpio)
> > > > >  		return;
> > > > >  
> > > > > -	/* PERST does not work for some cards when link training is enabled */
> > > > > +	/*
> > > > > +	 * As required by PCI Express spec a delay for at least 100ms after
> > > > > +	 * de-asserting PERST# signal is needed before link training is enabled.
> > > > > +	 * So ensure that link training is disabled prior de-asserting PERST#
> > > > > +	 * signal to fulfill that PCI Express spec requirement.
> > > > 
> > > > Can you please include the spec citation here?  In the PCIe base spec,
> > > > PERST# is only mentioned in PCIe r5.0, sec 6.6.1, and I don't see the
> > > > connection there to 100ms between de-assert of PERST# and enabling
> > > > link training.
> > > 
> > > Hello! I copied this "comment" from other place in pci-aardvark.c where
> > > that timeout 100ms is already applied. Timeout with explanation comment
> > > was introduced in following commit:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4c7d053d7f7
> > > 
> > > Here are links to discussions about that patch:
> > > 
> > > https://lore.kernel.org/linux-pci/20190313213752.1246-1-repk@triplefau.lt/T/#u
> > > https://lore.kernel.org/linux-pci/20190522213351.21366-2-repk@triplefau.lt/T/#u
> > 
> > Bjorn or Lorenzo, do you need something else for this patch? It just
> > updates comment and basically clarify why PERST does not work for some
> > cards when link training is enabled.
> 
> PING?

Apologies, I marked it as "changes requested" following Bjorn's reply.
Would you mind please adding a link to the relevant PCI specs in the
comment ?

I understood you copied the comment, it is worth adding that link to all
of them if you don't mind, it can be a preparation patch if you wish.

Thanks,
Lorenzo

> > > > Sec 6.1.1 does talk about 100ms before sending config requests (for
> > > > ports that support <= 5 GT/s), and 100ms after link training completes
> > > > (for ports that support > 5 GT/s).
> > > > 
> > > > Maybe there's more language in a form-factor spec or something?
> > > > 
> > > > > +	 */
> > > > >  	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> > > > >  	reg &= ~LINK_TRAINING_EN;
> > > > >  	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> > > > > -- 
> > > > > 2.20.1
> > > > > 
