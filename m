Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEDB463C42
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244431AbhK3Qxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 11:53:39 -0500
Received: from foss.arm.com ([217.140.110.172]:43334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244521AbhK3QxX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Nov 2021 11:53:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0C0D1042;
        Tue, 30 Nov 2021 08:50:03 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94D4C3F694;
        Tue, 30 Nov 2021 08:50:02 -0800 (PST)
Date:   Tue, 30 Nov 2021 16:49:57 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>, bhelgaas@google.com
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: apple: Fix REFCLK1 enable/poll logic
Message-ID: <20211130164957.GA4920@lpieralisi>
References: <20211117140044.193865-1-marcan@marcan.st>
 <87v90q7jk3.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v90q7jk3.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 17, 2021 at 05:56:12PM +0000, Marc Zyngier wrote:
> On Wed, 17 Nov 2021 14:00:44 +0000,
> Hector Martin <marcan@marcan.st> wrote:
> > 
> > REFCLK1 has req/ack bits just like REFCLK0
> > 
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > ---
> >  drivers/pci/controller/pcie-apple.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> > index b665d29af77a..420c291a5c68 100644
> > --- a/drivers/pci/controller/pcie-apple.c
> > +++ b/drivers/pci/controller/pcie-apple.c
> > @@ -42,8 +42,9 @@
> >  #define   CORE_FABRIC_STAT_MASK		0x001F001F
> >  #define CORE_LANE_CFG(port)		(0x84000 + 0x4000 * (port))
> >  #define   CORE_LANE_CFG_REFCLK0REQ	BIT(0)
> > -#define   CORE_LANE_CFG_REFCLK1		BIT(1)
> > +#define   CORE_LANE_CFG_REFCLK1REQ	BIT(1)
> >  #define   CORE_LANE_CFG_REFCLK0ACK	BIT(2)
> > +#define   CORE_LANE_CFG_REFCLK1ACK	BIT(3)
> >  #define   CORE_LANE_CFG_REFCLKEN	(BIT(9) | BIT(10))
> >  #define CORE_LANE_CTL(port)		(0x84004 + 0x4000 * (port))
> >  #define   CORE_LANE_CTL_CFGACC		BIT(15)
> > @@ -481,9 +482,9 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
> >  	if (res < 0)
> >  		return res;
> >  
> > -	rmw_set(CORE_LANE_CFG_REFCLK1, pcie->base + CORE_LANE_CFG(port->idx));
> > +	rmw_set(CORE_LANE_CFG_REFCLK1REQ, pcie->base + CORE_LANE_CFG(port->idx));
> >  	res = readl_relaxed_poll_timeout(pcie->base + CORE_LANE_CFG(port->idx),
> > -					 stat, stat & CORE_LANE_CFG_REFCLK1,
> > +					 stat, stat & CORE_LANE_CFG_REFCLK1ACK,
> >  					 100, 50000);
> >  
> >  	if (res < 0)
> > -- 
> > 2.33.0
> > 
> > 
> 
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Acked-by: Marc Zyngier <maz@kernel.org>

Hi Hector, Bjorn,

if this is a fix we can aim at one of the upcoming -rcX.

It would be nicer though to explain a bit better what it is
fixing in the commit log (and what's broken if we don't merge it),
as it stands it is a bit terse.

Thanks,
Lorenzo
