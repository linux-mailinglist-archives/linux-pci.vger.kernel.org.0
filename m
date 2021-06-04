Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8396839BD0C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 18:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhFDQ0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 12:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhFDQ0k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 12:26:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BBD461009;
        Fri,  4 Jun 2021 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622823893;
        bh=tGEhtfMeMa1I2VdnXeJu3t/MFpJB5vTP0886/BmM/04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/C3vsg1oweCRt+elPVzxhp2DgSa2/3jYJ9+mcooqQhbTHLs6F+T0swU150kiPlNY
         6qZQNLrg2ZwA5Ph6LLSR2doDH2oEpt4CKpMpRL3O31Tudj88EztoRN0Fe+T92S2Grx
         DhZSJaogoJURs3QYSxaOJj4+TG72VEqJyHG3cIzBCngzPtYWL6LmV3DLSLzJkjvB1F
         pMGStlcsYnW8XRXVzzgDooK0j3thLobM08fHupcW1xF4McWqwZiSU6zJWOv2bpPTfC
         Wj554+kX2eFKhdxj8dclc/HxW6ibXE4/qe9Dqtff6KvMS8g0yyt0mALAy6RWZvuVgR
         BNFqD9TORL8gw==
Received: by pali.im (Postfix)
        id 512D9990; Fri,  4 Jun 2021 18:24:51 +0200 (CEST)
Date:   Fri, 4 Jun 2021 18:24:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/42] PCI: aardvark: Check for virq mapping when
 processing INTx IRQ
Message-ID: <20210604162451.lzumwctjj6yoigey@pali>
References: <20210506153153.30454-1-pali@kernel.org>
 <20210506153153.30454-13-pali@kernel.org>
 <87h7jeq4zo.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7jeq4zo.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 May 2021 10:15:39 Marc Zyngier wrote:
> On Thu, 06 May 2021 16:31:23 +0100,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > It is possible that we receive spurious INTx interrupt. So add needed check
> > before calling generic_handle_irq() function.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 362faddae935..e7089db11f79 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -1106,7 +1106,10 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
> >  			    PCIE_ISR1_REG);
> >  
> >  		virq = irq_find_mapping(pcie->irq_domain, i);
> > -		generic_handle_irq(virq);
> > +		if (virq)
> > +			generic_handle_irq(virq);
> > +		else
> > +			dev_err(&pcie->pdev->dev, "unexpected INT%c IRQ\n", (char)i+'A');
> 
> Please don't scream like this. This is the best way to get into a DoS
> situation if you interrupt rate is high enough. At least rate-limit
> it.

Ok, I will fix it!

Just to note that this code pattern is used also in other drivers.
So other drivers should fixed too...
