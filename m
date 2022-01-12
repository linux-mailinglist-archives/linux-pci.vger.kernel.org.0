Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9EA48CA87
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 19:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355866AbiALSAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 13:00:34 -0500
Received: from foss.arm.com ([217.140.110.172]:34086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348662AbiALSAU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 13:00:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28A4B6D;
        Wed, 12 Jan 2022 10:00:19 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2E23F766;
        Wed, 12 Jan 2022 10:00:18 -0800 (PST)
Date:   Wed, 12 Jan 2022 18:00:11 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     james.quinlan@broadcom.com, linux-pci@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] fixup! PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <20220112180011.GA1319@lpieralisi>
References: <20220112013100.48029-1-jim2101024@gmail.com>
 <20220112175106.GA267550@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112175106.GA267550@bhelgaas>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 11:51:06AM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 11, 2022 at 08:31:00PM -0500, Jim Quinlan wrote:
> 
> What's this connected to?  Is this a fix for a patch that has already
> been merged?  If so, which one?  If it's a standalone thing, it needs
> a commit log and a Signed-off-by.  Actually, that would be good in any
> case.  Maybe a lore link to the relevant patch?

I was about to reply. It is a fixup for one of the branches I am
queueing for v5.17 (pci/brcmstb), I can either squash that it myself or
you can do it, provided that Jim gives us the commit id this is actually
fixing (or a lore link to the patch posting so that we can infer the
commit to fix).

Lorenzo

> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 8a3321314b74..4134f01acd87 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -1392,7 +1392,8 @@ static int brcm_pcie_resume(struct device *dev)
> >  err_reset:
> >  	reset_control_rearm(pcie->rescal);
> >  err_regulator:
> > -	regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
> > +	if (pcie->sr)
> > +		regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
> >  err_disable_clk:
> >  	clk_disable_unprepare(pcie->clk);
> >  	return ret;
> > -- 
> > 2.17.1
> > 
