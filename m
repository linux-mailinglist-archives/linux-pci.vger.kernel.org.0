Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA71859610F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 19:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiHPR0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 13:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiHPR0K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 13:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F07647F7
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 10:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5BE76130C
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 17:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121B2C433C1;
        Tue, 16 Aug 2022 17:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660670768;
        bh=7+D/Fd897jbtRX87eukYnaRbxfO31nS3UiIy5e8bbGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3DbA3ZSVPw3rD4R3xOkw5s+gwolWBhU3nvbIVMMdyTNvJunlSptweTCcbBj26+o8
         tRrAhsRhKsa6b+GniexmVwuUDByFVY1pXHwMzVtVPupzOMf0ZbNK4aPkR7WXCanIB8
         nmMdq+RQQObUhT3AVFwV8AJonEt6Qzvzf8asQHA5gfe+2CK1vb3JRNSeTF31F1qEFq
         ZJ+sKF71uSJJQHWRScjZD9a3onWD90AoJC8YBNnOPmWi5n/YxtazKSmRg8U7AIQxHY
         9I+Yxw8yROrS5CSxagSjc1MH2SARjMJCth+pSW5qJ9UvWLH7NDwdEZFNeAGTHz/75Y
         +ExafvaAoRcGA==
Date:   Tue, 16 Aug 2022 18:26:02 +0100
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
Message-ID: <YvvTKkR4sOIsFxA4@sirena.org.uk>
References: <62eed399.170a0220.2503a.1c64@mx.google.com>
 <YvEAF1ZvFwkNDs01@sirena.org.uk>
 <deda4eb1592cb61504c9d42765998653@walle.cc>
 <YvEEidOZ62igUYrR@sirena.org.uk>
 <CAGETcx_JSViBcySNp+Rany2osBiKL7ON+tooPKW8TOTP6+t_HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wnWXUIn0S/B1fPrj"
Content-Disposition: inline
In-Reply-To: <CAGETcx_JSViBcySNp+Rany2osBiKL7ON+tooPKW8TOTP6+t_HA@mail.gmail.com>
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


--wnWXUIn0S/B1fPrj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 12, 2022 at 04:54:25PM -0700, Saravana Kannan wrote:

> While you are here, I'm working towards patches on top of [1] where
> fw_devlink will tie the sync_state() callback to each regulator. Also,
> i realized that if you can convert the regulator_class to a
> regulator_bus, we could remove a lot of the "find the supply for this
> regulator when it's registered" code and let device links handle it.
> Let me know if that's something you'd be okay with. It would change
> the sysfs path for /sys/class/regulator and moves it to
> /sys/bus/regulator, but not sure if that's considered an ABI breakage
> (sysfs paths change all the time).

That *does* sound like it'd be an ABI issue TBH.  I thought there was
support for keeping class around even when converting to a bus (though
TBH given how entirely virtual this stuff us it seems odd that we'd be
going for a bus).

--wnWXUIn0S/B1fPrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL70ykACgkQJNaLcl1U
h9CE4wf/RZ6bzFwIFNXvaq9zI11tH5FFwJfQNFSR41A+SMzApIPgfatUKKTTJ5qR
6NqJFf88+mYxq2SIi/KUPrDxW9nAtMw99Iohk6c/h7VJ4J6iOU0O8aIstaae7dRp
c6CpxqxvNX7Z3L/05cYzp6DsnO/wCZkP1qJ8OyM6ftavlQKvmvQl+R5kdwdwVJVa
Mq07LZuP4/oosUSb/mEs1er2pc1VGjhI0Yu2dL9s+isMRGomat6fLA+PHZXP+VZD
b2RNV9QHBYsULs7UXvaljyi5xv9Hgh+M5G81RHu+XkLSaYOdRp7c6b/6YGw6mtv3
uChDCnSq6KCp3Ep4SVeHRReUqqXrMA==
=UJKO
-----END PGP SIGNATURE-----

--wnWXUIn0S/B1fPrj--
