Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6E4E6A95
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 23:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiCXWVD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 18:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241989AbiCXWVD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 18:21:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548947CB20
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 15:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18482B8250D
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 22:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F265C340EC;
        Thu, 24 Mar 2022 22:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648160368;
        bh=epz6WS11anM7dgEmdIw5kK894Jpyd/LXevilN/Hp3f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MApF8/dHNjZHHsHretJGKIwSej6wgFRlQr7mbicRQWV6GOCmVm9msyGA1XikgeVcb
         pKvVzvbBq4O2aiEGzdsnA436Tqn2+ZJOVlrVkRownYeUzqL7lyiWUTqTT/fuUwHzFA
         kFuxj5avCgPKb4IhBm7zBayWNtskqE7PxwPRggwrOBtFKskeag0c+xJglmlooAgXoz
         JfkW+lzwE5B8AZ2i7llgamizj5tvrYTsBD/MXKGJQbfGew5z4s4JLm2wdi6Ktt59GD
         CgT0Lvwd2hA87xnDfSEVLY/k97EcfTwiwYgpoHtadrdRq0enbKYAUBvGncozx990IG
         dxDjbyD4cPguA==
Date:   Thu, 24 Mar 2022 22:19:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Message-ID: <Yjzua8Wye/3DHBKx@sirena.org.uk>
References: <623c13ec.1c69fb81.8cbdb.5a7a@mx.google.com>
 <Yjyv03JsetIsTJxN@sirena.org.uk>
 <4e9fca2f-0af1-3684-6c97-4c35befd5019@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gKXeS8yd8BxBqR7N"
Content-Disposition: inline
In-Reply-To: <4e9fca2f-0af1-3684-6c97-4c35befd5019@redhat.com>
X-Cookie: Orders subject to approval.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--gKXeS8yd8BxBqR7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 24, 2022 at 09:34:30PM +0100, Hans de Goede wrote:

> Mark, if one of use writes a test patch, can you get that Asus machine to boot a
> kernel build from next + the test patch ?

I can't directly unfortunately as the board is in Collabora's lab but
Guillaume (who's already CCed) ought to be able to, and I can generally
prod and try to get that done.

--gKXeS8yd8BxBqR7N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI87msACgkQJNaLcl1U
h9Ak2Qf+I8fn2G5idH0xTHkB7uSNSm9XnHDVepInrM7xRgJmhMmmDimWNWWbp6Ex
veGuY1PBjmO9pkuPhblSO8WWW0xonJ5qjvgfq8v/pb9o9m20y9AKTMHzix807RJN
qprKI3HYIwDEeppsHq9X0VrkAkibfljbsidMFFj/mkYzblLOjpbHzAI65uS2cRZm
nwGQ6fV1mIuAyO2zdN1KrVvgjCO6aKn2X8jntuZsgwhauGiArih2De9E31MtpNIL
o2zG/p0Hc2RE3EOeYqiICD1LEGT0kzO7k6nIgVBm9tFJaVjETT5eLboswdD4MHnd
TaAv7c9GJMCAokXQ1Gd8x4d+coRWsg==
=BsS/
-----END PGP SIGNATURE-----

--gKXeS8yd8BxBqR7N--
