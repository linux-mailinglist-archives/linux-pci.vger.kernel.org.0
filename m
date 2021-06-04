Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7930E39BD1E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 18:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFDQb1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 4 Jun 2021 12:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFDQb1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 12:31:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0348610A8;
        Fri,  4 Jun 2021 16:29:40 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lpChW-005WHH-Ru; Fri, 04 Jun 2021 17:29:39 +0100
Date:   Fri, 04 Jun 2021 17:29:36 +0100
Message-ID: <87o8clzj7z.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/42] PCI: aardvark: Check for virq mapping when processing INTx IRQ
In-Reply-To: <20210604162451.lzumwctjj6yoigey@pali>
References: <20210506153153.30454-1-pali@kernel.org>
        <20210506153153.30454-13-pali@kernel.org>
        <87h7jeq4zo.wl-maz@kernel.org>
        <20210604162451.lzumwctjj6yoigey@pali>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pali@kernel.org, lorenzo.pieralisi@arm.com, thomas.petazzoni@bootlin.com, robh@kernel.org, bhelgaas@google.com, rmk+kernel@armlinux.org.uk, kabel@kernel.org, repk@triplefau.lt, contact@xogium.me, tmn505@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 04 Jun 2021 17:24:51 +0100,
Pali Rohár <pali@kernel.org> wrote:
> 
> On Friday 07 May 2021 10:15:39 Marc Zyngier wrote:
> > On Thu, 06 May 2021 16:31:23 +0100,
> > Pali Rohár <pali@kernel.org> wrote:
> > > 
> > > It is possible that we receive spurious INTx interrupt. So add needed check
> > > before calling generic_handle_irq() function.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Reviewed-by: Marek Behún <kabel@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/pci/controller/pci-aardvark.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > index 362faddae935..e7089db11f79 100644
> > > --- a/drivers/pci/controller/pci-aardvark.c
> > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > @@ -1106,7 +1106,10 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
> > >  			    PCIE_ISR1_REG);
> > >  
> > >  		virq = irq_find_mapping(pcie->irq_domain, i);
> > > -		generic_handle_irq(virq);
> > > +		if (virq)
> > > +			generic_handle_irq(virq);
> > > +		else
> > > +			dev_err(&pcie->pdev->dev, "unexpected INT%c IRQ\n", (char)i+'A');
> > 
> > Please don't scream like this. This is the best way to get into a DoS
> > situation if you interrupt rate is high enough. At least rate-limit
> > it.
> 
> Ok, I will fix it!
> 
> Just to note that this code pattern is used also in other drivers.
> So other drivers should fixed too...

"We should fix the kernel" is a common theme. Please go ahead.

	M.

-- 
Without deviation from the norm, progress is not possible.
