Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5891546901
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbiFJPGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 11:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiFJPGc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 11:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C652236B2;
        Fri, 10 Jun 2022 08:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F6CE61F65;
        Fri, 10 Jun 2022 15:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731D3C34114;
        Fri, 10 Jun 2022 15:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654873590;
        bh=3uuDhje8ELn016hXFyWA5qrL2Lj+z/ERGf9V7lR/k3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NLYBr3jo9J9+dTpGc1Fali1XUKgOqU3hJ1oEKKtiqYvSP+nDaivUuqJq5tvWxHcRj
         H0jt3C1Cjjct0Y+Lu0oxxjiChxlUblOhZ1gLHXOAuL0R9kkd9LtHq0J3RbaKjlho4I
         Q4RSkdTvKqqs2NNJyLqNIbC+obEykiswg0oyFC4OW8Vl+H9lc45cNdGsskwrdRh2gU
         lPsjOyaMumFzeRpU6GynPeSWX4eDZx8Of+VQkdWVMZsGe78WtroQd4cQKf5IBfubDf
         LqGGB8VdHdufQG0z6nxMPvl6yqYNA+N8XNYFyq+4lKa34fT3sgArfA6IAm4d1gSV0C
         V4Ftop6Q26NCg==
Date:   Fri, 10 Jun 2022 10:06:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PM / wakeup: Unify device_init_wakeup() for PM_SLEEP and
 !PM_SLEEP
Message-ID: <20220610150628.GA599243@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqNYSBQWtwVUSJ+d@kroah.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 04:42:16PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 06, 2022 at 10:51:58PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Previously the CONFIG_PM_SLEEP and !CONFIG_PM_SLEEP device_init_wakeup()
> > implementations differed in confusing ways:
> > 
> >   - The PM_SLEEP version checked for a NULL device pointer and returned
> >     -EINVAL, while the !PM_SLEEP version did not and would simply
> >     dereference a NULL pointer.
> > 
> >   - When called with "false", the !PM_SLEEP version cleared "capable" and
> >     "enable" in the opposite order of the PM_SLEEP version.  That was
> >     harmless because for !PM_SLEEP they're simple assignments, but it's
> >     unnecessary confusion.
> > 
> > Use a simplified version of the PM_SLEEP implementation for both cases.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/base/power/wakeup.c | 30 ------------------------------
> >  include/linux/pm_wakeup.h   | 31 +++++++++++++++++++++++--------
> >  2 files changed, 23 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index 11a4ffe91367..e3befa2c1b66 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -500,36 +500,6 @@ void device_set_wakeup_capable(struct device *dev, bool capable)
> >  }
> >  EXPORT_SYMBOL_GPL(device_set_wakeup_capable);
> >  
> > -/**
> > - * device_init_wakeup - Device wakeup initialization.
> > - * @dev: Device to handle.
> > - * @enable: Whether or not to enable @dev as a wakeup device.
> > - *
> > - * By default, most devices should leave wakeup disabled.  The exceptions are
> > - * devices that everyone expects to be wakeup sources: keyboards, power buttons,
> > - * possibly network interfaces, etc.  Also, devices that don't generate their
> > - * own wakeup requests but merely forward requests from one bus to another
> > - * (like PCI bridges) should have wakeup enabled by default.
> > - */
> > -int device_init_wakeup(struct device *dev, bool enable)
> > -{
> > -	int ret = 0;
> > -
> > -	if (!dev)
> > -		return -EINVAL;
> > -
> > -	if (enable) {
> > -		device_set_wakeup_capable(dev, true);
> > -		ret = device_wakeup_enable(dev);
> > -	} else {
> > -		device_wakeup_disable(dev);
> > -		device_set_wakeup_capable(dev, false);
> > -	}
> > -
> > -	return ret;
> > -}
> > -EXPORT_SYMBOL_GPL(device_init_wakeup);
> > -
> >  /**
> >   * device_set_wakeup_enable - Enable or disable a device to wake up the system.
> >   * @dev: Device to handle.
> > diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> > index 196a157456aa..77f4849e3418 100644
> > --- a/include/linux/pm_wakeup.h
> > +++ b/include/linux/pm_wakeup.h
> > @@ -109,7 +109,6 @@ extern struct wakeup_source *wakeup_sources_walk_next(struct wakeup_source *ws);
> >  extern int device_wakeup_enable(struct device *dev);
> >  extern int device_wakeup_disable(struct device *dev);
> >  extern void device_set_wakeup_capable(struct device *dev, bool capable);
> > -extern int device_init_wakeup(struct device *dev, bool val);
> >  extern int device_set_wakeup_enable(struct device *dev, bool enable);
> >  extern void __pm_stay_awake(struct wakeup_source *ws);
> >  extern void pm_stay_awake(struct device *dev);
> > @@ -167,13 +166,6 @@ static inline int device_set_wakeup_enable(struct device *dev, bool enable)
> >  	return 0;
> >  }
> >  
> > -static inline int device_init_wakeup(struct device *dev, bool val)
> > -{
> > -	device_set_wakeup_capable(dev, val);
> > -	device_set_wakeup_enable(dev, val);
> > -	return 0;
> > -}
> > -
> >  static inline bool device_may_wakeup(struct device *dev)
> >  {
> >  	return dev->power.can_wakeup && dev->power.should_wakeup;
> > @@ -217,4 +209,27 @@ static inline void pm_wakeup_hard_event(struct device *dev)
> >  	return pm_wakeup_dev_event(dev, 0, true);
> >  }
> >  
> > +/**
> > + * device_init_wakeup - Device wakeup initialization.
> > + * @dev: Device to handle.
> > + * @enable: Whether or not to enable @dev as a wakeup device.
> > + *
> > + * By default, most devices should leave wakeup disabled.  The exceptions are
> > + * devices that everyone expects to be wakeup sources: keyboards, power buttons,
> > + * possibly network interfaces, etc.  Also, devices that don't generate their
> > + * own wakeup requests but merely forward requests from one bus to another
> > + * (like PCI bridges) should have wakeup enabled by default.
> > + */
> > +static inline int device_init_wakeup(struct device *dev, bool enable)
> > +{
> > +	if (enable) {
> > +		device_set_wakeup_capable(dev, true);
> > +		return device_wakeup_enable(dev);
> > +	} else {
> > +		device_wakeup_disable(dev);
> > +		device_set_wakeup_capable(dev, false);
> > +		return 0;
> > +	}
> > +}
> > +
> 
> Why are you moving this to be inline?  Why not just drop the "other"
> version and stick with the .c version?

That would definitely be simpler but drivers/base/power/wakeup.c is
only built when CONFIG_PM_SLEEP=y, so a .c version there by itself
isn't sufficient.  I should have mentioned that in the commit log.

Bjorn
