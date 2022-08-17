Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3560D5969CC
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 08:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiHQGoR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 02:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiHQGoQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 02:44:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792034CA2F
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 23:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 158DA6117D
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 06:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D298C433D6;
        Wed, 17 Aug 2022 06:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660718654;
        bh=IEC1gV3N39NMhQ3mBHUUZstUlnMF4Nl/M3D+D2V5PZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0yeE7NWJFfwDWUMDymU+v0vOrH/cHwVCu4ocahR+kYd7KmHGvwvfFcDR0sItdoin
         mRJpcZwVbm/F76zIGzeNKT2nsMEE8b49Nl7JolX8seOXpugiYaMq8B795GB0BDdqoK
         zTcMZTShe8kFxzTHeXIXa06upQAtZoI2HiuapC34=
Date:   Wed, 17 Aug 2022 08:44:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Brown <broonie@kernel.org>, Michael Walle <michael@walle.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.bootrr.intel-igb-probed on
 kontron-pitx-imx8m
Message-ID: <YvyOOWB6rBq0ZEpF@kroah.com>
References: <62eed399.170a0220.2503a.1c64@mx.google.com>
 <YvEAF1ZvFwkNDs01@sirena.org.uk>
 <deda4eb1592cb61504c9d42765998653@walle.cc>
 <YvEEidOZ62igUYrR@sirena.org.uk>
 <CAGETcx_JSViBcySNp+Rany2osBiKL7ON+tooPKW8TOTP6+t_HA@mail.gmail.com>
 <YvvTKkR4sOIsFxA4@sirena.org.uk>
 <CAGETcx8vwDd3m3DZFJK7h0jjHMZhOfChRKHPt5qj8O8cJ_ReHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8vwDd3m3DZFJK7h0jjHMZhOfChRKHPt5qj8O8cJ_ReHA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 16, 2022 at 10:48:04AM -0700, Saravana Kannan wrote:
> On Tue, Aug 16, 2022 at 10:26 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, Aug 12, 2022 at 04:54:25PM -0700, Saravana Kannan wrote:
> >
> > > While you are here, I'm working towards patches on top of [1] where
> > > fw_devlink will tie the sync_state() callback to each regulator. Also,
> > > i realized that if you can convert the regulator_class to a
> > > regulator_bus, we could remove a lot of the "find the supply for this
> > > regulator when it's registered" code and let device links handle it.
> > > Let me know if that's something you'd be okay with. It would change
> > > the sysfs path for /sys/class/regulator and moves it to
> > > /sys/bus/regulator, but not sure if that's considered an ABI breakage
> > > (sysfs paths change all the time).
> >
> > That *does* sound like it'd be an ABI issue TBH.  I thought there was
> > support for keeping class around even when converting to a bus
> 
> Ah, this is news to me. I'll poke around to see if the path can be
> maintained even after converting a class to a bus.

Which specific path are you worried about?

> (though
> > TBH given how entirely virtual this stuff us it seems odd that we'd be
> > going for a bus).
> 
> I'm going for a bus because class doesn't have a distinction between
> "device has been added" and "device is ready if these things happen".
> There's nothing to say that a "bus" has to be a real hardware bus.

busses are not always real hardware busses, look at the virtual bus code
for examples of that.

Classes are "representations of a type of device that userspace
interacts with" like input, sound, tty, and so on, that are independant
of the type of hardware bus or device it is.  Do all regulators need to
interact with userspace in a common way?  If so, it's a class, if not,
maybe a bus would work, but that takes more code than a class so it
should only be done if you really need it for some odd reason.

thanks,

greg k-h
