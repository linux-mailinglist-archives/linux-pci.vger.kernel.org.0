Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5DE1A9BF6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 13:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896851AbgDOLSB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 07:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896766AbgDOLRj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 07:17:39 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 487BB2074F;
        Wed, 15 Apr 2020 11:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586949459;
        bh=q259KxH2q7pbnJdEn1Xf2TZf8jBmlCkBNfRyEI2QXTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=liaeeLXbvho627HRyhpbE6uPk7cy6JLb+l1ATY8xSiWqR3MpTDoRbkFzck83ds1U6
         8VOFumLNGtVr2//XZ+crpQImqeN8TTEEZkWtg+vZF39fGL7BZgXwxEtssBzBiaDNKR
         7I21Nzck1MyCBCxr44CrkHtWfp4bQgE5Y6Efsyhg=
Received: by pali.im (Postfix)
        id 0D7C4589; Wed, 15 Apr 2020 13:17:37 +0200 (CEST)
Date:   Wed, 15 Apr 2020 13:17:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix reporting GPIO error value
Message-ID: <20200415111736.czeh7a3iqmmasow6@pali>
References: <20200414102512.27506-1-pali@kernel.org>
 <20200414113104.GA27984@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414113104.GA27984@qmqm.qmqm.pl>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 14 April 2020 13:31:04 Michał Mirosław wrote:
> On Tue, Apr 14, 2020 at 12:25:12PM +0200, Pali Rohár wrote:
> > Error code is stored in rp->reset_gpio and not in err variable.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/pci-tegra.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> > index 0e03cef72840..378d5a8773c7 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -2314,8 +2314,8 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
> >  			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
> >  				rp->reset_gpio = NULL;
> >  			} else {
> > -				dev_err(dev, "failed to get reset GPIO: %d\n",
> > -					err);
> > +				dev_err(dev, "failed to get reset GPIO: %ld\n",
> > +					PTR_ERR(rp->reset_gpio));
> >  				return PTR_ERR(rp->reset_gpio);
> >  			}
> >  		}
> 
> You can use %pe directly on the pointer for added benefit of translation
> of the error to a name.

Well, I do not know what is the current preferred style of error
messages. On lot of places I see just numeric error numbers.

I did not wanted to change behavior of driver, I just fixed code to
report correct error value.

I do not have this hardware, so I cannot test this change. I just
spotted this problem when I was looking at other PCI controller drivers
how they issue PERST# signal to endpoint cards.
