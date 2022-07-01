Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E841562FAF
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiGAJQy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 05:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGAJQx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 05:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAD245784;
        Fri,  1 Jul 2022 02:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69993622C1;
        Fri,  1 Jul 2022 09:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD02BC3411E;
        Fri,  1 Jul 2022 09:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656667011;
        bh=DhfNjTp7qTEx9mtRGoA+910GZOE/wNjja5y2DtCrT2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMGxohcSVomi7bpYODVdfH3TtjqunHREFt56QiK6mBbNiS9f7Ry99A11I4zeB9egu
         uiaqGep0w54PJL5/ZZSuCNh9VJ+anwFs8SEjZ7qxCiXQkTCOaIwnX/7SkVfPKECgN9
         7Whz6w9oBrgN8rf9RIuzE6znRQpxsbv+Vc0bHyA9MNAkb/diTupmmaes9m4GQ8VVt5
         nsRmId7abF2mVLYgHSbsBrHdpbWQVGj8q2Po5TAEP+r0zh4Vf7S5Ai3BGuSG42RbSp
         uc9JUPmwQ35JY2g8oqvw16X0LzAqryK4r/VRCtNwXluBa1VSocN52X0kUF4eyW9XWh
         XAHBYzY5Lussw==
Date:   Fri, 1 Jul 2022 10:16:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, Michael Walle <michael@walle.cc>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: next/master bisection: baseline.bootrr.imx6q-pcie-pcie0-probed
 on kontron-pitx-imx8m
Message-ID: <Yr67fvEPKmDTQfGz@sirena.org.uk>
References: <62bdec26.1c69fb81.46bc5.2d67@mx.google.com>
 <Yr3vEDDulZj1Dplv@sirena.org.uk>
 <CAGETcx88M3Use8crFMTU=By3UVjjaJuP1_Ah7zsy_w=pNxc+6w@mail.gmail.com>
 <CAGETcx_s+ui9wWA7OawojPbY95bLZE5pSmpK-34_kLZTzjf9Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4P/NYrk0ideGd8Y7"
Content-Disposition: inline
In-Reply-To: <CAGETcx_s+ui9wWA7OawojPbY95bLZE5pSmpK-34_kLZTzjf9Ew@mail.gmail.com>
X-Cookie: Who is John Galt?
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--4P/NYrk0ideGd8Y7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2022 at 06:02:04PM -0700, Saravana Kannan wrote:

> The patch attached to that email will probably fix this issue. I
> haven't dealt with Kernel CI bot before. Is there a way to get it to
> test a patch?

It is but I don't have access to do that - either the lab owner
(Michael, CCed here) or Guillaume (also CCed) should be able to help
there.

--4P/NYrk0ideGd8Y7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK+u30ACgkQJNaLcl1U
h9A0+Qf/eopE5aUapP2CKHQW0RBjoOvDwM9pk+eFkBZteYfcdBeS4fmthUZsmACM
6tvIWbACmUJOtsS1g4DvVxiDcmFeKLFeEEkCRWRo3JECKKaw9/KeCx6HDhx0SGW1
LUvqjpfTfb/W6VEHZtckdjlmvWD5BK4i7vp6dIoY5RIMWlSJcTDRUt/qNxpCVh3N
W1iVN7TbRF2ymzIm70wHUTsFd4bguXZOiscYfoFC3nCY27T8j2tkyLg76w+DLYIa
WhaSlAFoXcWuw10cxP2tLd/PbRxvhLkvu50hZ0W1f3wJx9xZ5NkRB7FHlU58hcTr
djuOop95iGaKeAA6Li3ydrfT+HetJw==
=kk6Y
-----END PGP SIGNATURE-----

--4P/NYrk0ideGd8Y7--
