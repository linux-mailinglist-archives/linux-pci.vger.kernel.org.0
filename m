Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F06A1998
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfH2MIj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 08:08:39 -0400
Received: from foss.arm.com ([217.140.110.172]:44214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbfH2MIi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Aug 2019 08:08:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA0C7360;
        Thu, 29 Aug 2019 05:08:37 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F15C3F59C;
        Thu, 29 Aug 2019 05:08:37 -0700 (PDT)
Date:   Thu, 29 Aug 2019 13:08:35 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 5/5] PCI: iproc: Properly handle optional PHYs
Message-ID: <20190829120824.GI14582@e119886-lin.cambridge.arm.com>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
 <20190828214901.GM4298@sirena.co.uk>
 <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
 <20190829111728.GC4118@sirena.co.uk>
 <20190829114603.GB13187@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829114603.GB13187@ulmo>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 29, 2019 at 01:46:03PM +0200, Thierry Reding wrote:
> On Thu, Aug 29, 2019 at 12:17:29PM +0100, Mark Brown wrote:
> > On Thu, Aug 29, 2019 at 11:09:34AM +0100, Andrew Murray wrote:
> > 
> > > But why do we return -ENODEV and not NULL for OPTIONAL_GET?
> > 
> > Why would we return NULL?  The caller is going to have to check the
> > error code anyway since they need to handle -EPROBE_DEFER and NULL is
> > never a valid thing to use with the regulator API.
> 
> I think the idea is that consumers would do something like this:
> 
> 	supply = regulator_get_optional(dev, "foo");
> 	if (IS_ERR(supply)) {
> 		/* -EPROBE_DEFER handled as part of this */
> 		return PTR_ERR(supply);
> 	}
> 
> 	/*
> 	 * Optional supply is NULL here, making it "easier" to check
> 	 * whether or not to use it.
> 	 */

Indeed. This way the error path is only for errors (if you consider that
requesting an optional regulator that doesn't exist isn't an error - and
if you also consider that -EPROBE_DEFER is an error, or at least a reason
to bail).

> 
> I suppose checking using IS_ERR() is equally simple, so this mostly
> boils down to taste...
> 
> The PHY subsystem, for instance, uses a similar approach but it goes one
> step further. All APIs can take NULL as their struct phy * argument and
> return success in that case, which makes it really trivial to deal with
> optional PHYs. You really don't have to care about them at all after you
> get NULL from phy_get_optional().

I can see how this makes everything very convenient for the driver, though
this doesn't smell right.

> 
> > > Looking at some of the consumer drivers I can see that lots of them don't
> > > correctly handle the return value of regulator_get_optional:
> > 
> > This API is *really* commonly abused, especially in the graphics
> > subsystem which for some reason has lots of users even though I don't
> > think I've ever seen a sensible use of the API there.  As far as I can
> > tell the graphics subsystem mostly suffers from people cut'n'pasting
> > from the Qualcomm BSP which is full of really bad practice.  It's really
> > frustrating since I will intermittently go through and clean things up
> > but the uses just keep coming back into the subsystem.
> 
> The intention here is to make it more difficult to abuse. Obviously if
> people keep copying abuses from one driver to another that's a different
> story. But if there was no way to abuse the API and if it automatically
> did the right thing, even copy/paste abuse would be difficult to pull
> off.

That's the motativation here.

> 
> > > Given that a common pattern is to set a consumer regulator pointer to NULL
> > > upon -ENODEV - if regulator_get_optional did this for them, then it would
> > > be more difficult for consumer drivers to get the error handling wrong and
> > > would remove some consumer boiler plate code.
> > 
> > No, they'd all still be broken for probe deferral (which is commonly
> > caused by off-chip devices) and they'd crash as soon as they try to call
> > any further regulator API functions.

regulator_get_optional would still return -EPROBE_DEFER and this would be
caught in the above example set out by Thierry.

> 
> I think what Andrew was suggesting here was to make it easier for people
> to determine whether or not an optional regulator was in fact requested
> successfully or not. Many consumers already set the optional supply to
> NULL and then check for that before calling any regulator API.
> 
> If regulator_get_optional() returned NULL for absent optional supplies,
> this could be unified across all drivers. And it would allow treating
> NULL regulators special, if that's something you'd be willing to do.
> 
> In either case, the number of abuses shows that people clearly don't
> understand how to use this. So there are two options: a) fix abuse every
> time we come across it or b) try to change the API to make it more
> difficult to abuse.

Sure. I think we end up with something like:

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e0c0cf462004..67e2a6d7abf6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1868,6 +1868,9 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
                }
 
                switch (get_type) {
+               case OPTIONAL_GET:
+                       return NULL;
+
                case NORMAL_GET:
                        /*
                         * Assume that a regulator is physically present and


Of course there may be other approaches.

> 
> > > I guess I'm looking here for something that can simplify consumer error
> > > handling - it's easy to get wrong and it seems that many drivers may be wrong.
> > 
> > The overwhelming majority of the users just shouldn't be using this API.
> > If there weren't devices that absolutely *need* this API it wouldn't be
> > there in the first place since it seems like a magent for bad code, it's
> > so disappointing how bad the majority of the consumer code is.
> 
> Yeah, I guess in many cases this API is used as a cheap way to model
> always-on, fixed-voltage regulators. It's pretty hard to change those
> after the fact, though, because they're usually happening as part of
> device tree bindings implementation, so by the time we notice them,
> they've often become ABI...

Thanks,

Andrew Murray

> 
> Thierry


