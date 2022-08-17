Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9B596EDC
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 15:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbiHQM6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbiHQM62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 08:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356AEB9A
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 05:58:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B76536120B
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 12:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F254EC433D6;
        Wed, 17 Aug 2022 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660741095;
        bh=+gJYoyXt5OMBpQgeN13u6YB5N1o6vkwmOFRgwf+woY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhVC1j8oztw12CTPM7Zny4HWmu36sL0EIyeaY8K5KwA512Wgn23xK7A2W0yWHaql4
         PTOruWSrMv2879p2A88IjavGSbtp7ZkPpJiD631GXzENd4RxHn/gulK2FjVLZQjEHp
         Qf2XdLMZ725BNSH2iBqbu1Tq4GuF7Po5bwdXG2IMOi+I74t1pHklDqSr3Mwx7s1xne
         aPhrPq6PD9uo2fqsTaM4jttfvg2ZcVwwckTmk7lfOBd6J/V7IZaQrtQc2p2jwc5xXk
         c8KZDxxLqrYbNHzwcgZepR79ENtwAw9Fwp8e17QqWyQgkB9e3yIU3R4F95hgu331qq
         E4Qlk+qTmqaDA==
Date:   Wed, 17 Aug 2022 13:58:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Michael Walle <michael@walle.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.bootrr.intel-igb-probed on
 kontron-pitx-imx8m
Message-ID: <Yvzl4XK1QDfTbshr@sirena.org.uk>
References: <62eed399.170a0220.2503a.1c64@mx.google.com>
 <YvEAF1ZvFwkNDs01@sirena.org.uk>
 <deda4eb1592cb61504c9d42765998653@walle.cc>
 <YvEEidOZ62igUYrR@sirena.org.uk>
 <CAGETcx_JSViBcySNp+Rany2osBiKL7ON+tooPKW8TOTP6+t_HA@mail.gmail.com>
 <YvvTKkR4sOIsFxA4@sirena.org.uk>
 <CAGETcx8vwDd3m3DZFJK7h0jjHMZhOfChRKHPt5qj8O8cJ_ReHA@mail.gmail.com>
 <YvyOOWB6rBq0ZEpF@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7MHo0+k7zjP7SV49"
Content-Disposition: inline
In-Reply-To: <YvyOOWB6rBq0ZEpF@kroah.com>
X-Cookie: Use extra care when cleaning on stairs.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--7MHo0+k7zjP7SV49
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 17, 2022 at 08:44:09AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 16, 2022 at 10:48:04AM -0700, Saravana Kannan wrote:

> > Ah, this is news to me. I'll poke around to see if the path can be
> > maintained even after converting a class to a bus.

> Which specific path are you worried about?

The various files in /sys/class/regulator.

> > (though
> > > TBH given how entirely virtual this stuff us it seems odd that we'd be
> > > going for a bus).

> > I'm going for a bus because class doesn't have a distinction between
> > "device has been added" and "device is ready if these things happen".
> > There's nothing to say that a "bus" has to be a real hardware bus.

> busses are not always real hardware busses, look at the virtual bus code
> for examples of that.

Sure, but the less things correspond to the concrete concept of a thing
the more chance there is that things will be redefined later, and in
this case I'm struggling to see this matching even the abstract idea of
a bus.

> Classes are "representations of a type of device that userspace
> interacts with" like input, sound, tty, and so on, that are independant
> of the type of hardware bus or device it is.  Do all regulators need to
> interact with userspace in a common way?  If so, it's a class, if not,
> maybe a bus would work, but that takes more code than a class so it
> should only be done if you really need it for some odd reason.

My understanding is that people are using the current class interface
for monitoring of what the framework is doing, there's regular attempts
to add a write interface too though that isn't happening.  It kind of
corresponds to the write side of hwmon in some ways.

--7MHo0+k7zjP7SV49
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL85eEACgkQJNaLcl1U
h9Du6gf9EbQvNMKVM1UA0r7Y5G6Wfr5fX/MgxivkoAVlJEChzTJIOere8rIW4FCz
2aTXZSGgpJ+UdHlHEjH6hfFiJH55yWFKP81G5G9Er2jZgvgk6+8orVL7qONJMhl8
9yhyIEbjV9e82MacOXtmGy3NMhf2J4ERAjn+WCPGPnXgENQ/el98aZSHD84Gamam
xz96UcQwPTk64NlEnrnm8HN6nUhYsnNfEjSIJODUve4qZvDPH+OV3nWGU/HMFla3
7boW0Ds4l6H11JAlBzubZPq9r9cW75L2UQNt9P1W8oDMQNCLDlOBWcn+WYOjlnIN
TxTRHZSyiQVlBGV/AVr9ze+ywSFLRA==
=0pRn
-----END PGP SIGNATURE-----

--7MHo0+k7zjP7SV49--
