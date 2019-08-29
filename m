Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A459DA1BB6
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfH2Nnt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 09:43:49 -0400
Received: from foss.arm.com ([217.140.110.172]:45080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfH2Nnt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Aug 2019 09:43:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3BB428;
        Thu, 29 Aug 2019 06:43:48 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185A03F246;
        Thu, 29 Aug 2019 06:43:47 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:43:46 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 5/5] PCI: iproc: Properly handle optional PHYs
Message-ID: <20190829134345.GL14582@e119886-lin.cambridge.arm.com>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
 <20190828214901.GM4298@sirena.co.uk>
 <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
 <20190829111728.GC4118@sirena.co.uk>
 <20190829114603.GB13187@ulmo>
 <20190829120824.GI14582@e119886-lin.cambridge.arm.com>
 <20190829131603.GF4118@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829131603.GF4118@sirena.co.uk>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 29, 2019 at 02:16:03PM +0100, Mark Brown wrote:
> On Thu, Aug 29, 2019 at 01:08:35PM +0100, Andrew Murray wrote:
> > On Thu, Aug 29, 2019 at 01:46:03PM +0200, Thierry Reding wrote:
> 
> > > If regulator_get_optional() returned NULL for absent optional supplies,
> > > this could be unified across all drivers. And it would allow treating
> > > NULL regulators special, if that's something you'd be willing to do.
> 
> > > In either case, the number of abuses shows that people clearly don't
> > > understand how to use this. So there are two options: a) fix abuse every
> > > time we come across it or b) try to change the API to make it more
> > > difficult to abuse.
> 
> > Sure. I think we end up with something like:
> 
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index e0c0cf462004..67e2a6d7abf6 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -1868,6 +1868,9 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
> >                 }
> >  
> >                 switch (get_type) {
> > +               case OPTIONAL_GET:
> > +                       return NULL;
> > +
> 
> Implementing returning NULL is not hard.  How returning NULL discourages
> people from using regulator_get_optional() when they shouldn't be using
> it in the first place is not clear to me.

I think this is the part I haven't understood until now.

There are many consumer drivers that will not have a regulator specified in
the DT - this may be because they are optional (possibly a rare thing) or
because they don't need to be specified (because they are always on and
require no software interaction)...

Where they are not specified, because there is really no reason for them to
be described in the DT - then these drivers should use regulator_get and
be happy with a dummy regulator. This gives a benefit as if another hardware
version uses the same driver but does have a regulator that needs software
control then we can be confident it will work.

Where regulators are really optional, then regulator_get_optional is used
and -ENODEV can be used by the caller to perform a different course of action
if required. (Does this use-case actually exist?)

I guess I interpreted _optional as 'it's OK if you can't provide a regulator',
whereas the meaning is really 'get me a regulator that may not exist'.

Is my understanding correct? If so I guess another course of action would
be to clean-up users of _optional and convert them to regulator_get where
appropriate?

Thanks,

Andrew Murray
