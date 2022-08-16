Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344B75961A4
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiHPRyd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 13:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiHPRyT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 13:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197A82D37
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 10:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0D7161355
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 17:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE9FC433B5;
        Tue, 16 Aug 2022 17:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660672438;
        bh=sd0N3GpCtoHr6PNCJL7lD/3hyqVAKM0+dVc0en5bb9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TBMgjL4AcOE87Xnuj7GRpI/ZZL+My0+dw5Mwbzpn/7CVEjVn12aKs4G5NVXCPS4Hl
         ICscvOB5WH8JgFb62v+uzJCGuhrNJBP48/1M4thFIlc/Jx8bPp8XAAXNAYSqUdMgpv
         7g1rarZf5CJMkcEONfYj3ua/3Rfxd61YiCeS+ifmRZKKtwxzib1hlP534AVfssRFK4
         Xhl8Ri82twklWAfCPegTybItHeb2rxTBMeyT/lGlS9Tsz8U//NjxUrEOYUso+uqQ3u
         qrvKPoZIWpcE4kfXElxa51CIfKAFg5JPnoIq/uHWhvOQGSgeJh4F7P/pvwTEBzL6pX
         O9Xsq5b9Lsf/w==
Date:   Tue, 16 Aug 2022 18:53:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Michael Walle <michael@walle.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.bootrr.intel-igb-probed on
 kontron-pitx-imx8m
Message-ID: <YvvZsPcUPND6ZC9e@sirena.org.uk>
References: <62eed399.170a0220.2503a.1c64@mx.google.com>
 <YvEAF1ZvFwkNDs01@sirena.org.uk>
 <deda4eb1592cb61504c9d42765998653@walle.cc>
 <YvEEidOZ62igUYrR@sirena.org.uk>
 <CAGETcx_JSViBcySNp+Rany2osBiKL7ON+tooPKW8TOTP6+t_HA@mail.gmail.com>
 <YvvTKkR4sOIsFxA4@sirena.org.uk>
 <CAGETcx8vwDd3m3DZFJK7h0jjHMZhOfChRKHPt5qj8O8cJ_ReHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OAPSWxIHyD6yCwgr"
Content-Disposition: inline
In-Reply-To: <CAGETcx8vwDd3m3DZFJK7h0jjHMZhOfChRKHPt5qj8O8cJ_ReHA@mail.gmail.com>
X-Cookie: A bachelor is an unaltared male.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--OAPSWxIHyD6yCwgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 16, 2022 at 10:48:04AM -0700, Saravana Kannan wrote:
> On Tue, Aug 16, 2022 at 10:26 AM Mark Brown <broonie@kernel.org> wrote:

> (though
> > TBH given how entirely virtual this stuff us it seems odd that we'd be
> > going for a bus).

> I'm going for a bus because class doesn't have a distinction between
> "device has been added" and "device is ready if these things happen".
> There's nothing to say that a "bus" has to be a real hardware bus.

Sure, but then there's the push to stop using platform devices for
virtual devices - this feels similar.

--OAPSWxIHyD6yCwgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL72a8ACgkQJNaLcl1U
h9BtIggAgaN14n/MpOWjAxYbKsQXQIJexioTjKQtcGbbmBExvXf1jIHbUDt8tDlP
jDcMjR66q6WF4zOTBjsWg1wFIMgcSjMzgMOlT2TttJ/el0JvCvRdwc9f1MVLcMrV
WUqNQPa1IC/0JifRLCCVPyzjOCKL6N2l0gak4h8SL2X+OEn9dJDmqMs0wJ26JrCS
fBklVVDufwaEV9NWPSnu7WXy2qMafFoaFyrGMydSOiooKLjgdtkEZK7PhzsJM004
ixlALhEbB41sPrz+NhAOKJVOMAcoy5zOyj241BQ78H+95djSSh5VYW33ZE3QT9oX
t+2L8VWN0mkK8bLetkcmeOO1CAokLA==
=zI2k
-----END PGP SIGNATURE-----

--OAPSWxIHyD6yCwgr--
