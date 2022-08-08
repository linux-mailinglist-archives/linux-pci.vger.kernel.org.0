Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA758C87D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Aug 2022 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbiHHMl5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242779AbiHHMl4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 08:41:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E31CCE06
        for <linux-pci@vger.kernel.org>; Mon,  8 Aug 2022 05:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B53AB80E81
        for <linux-pci@vger.kernel.org>; Mon,  8 Aug 2022 12:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACDEC433C1;
        Mon,  8 Aug 2022 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659962511;
        bh=/ktSfYVpCaY+7duPsiHpjoWiP1uM3neu1QaK12vVDUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6/4us3UdRaKL9SKbNqraURNFYA50IpPNxShoNuwK0M3mE/0BMrUnxwS+CzAtUTpr
         PrM81NrqtMJ2LNUeiYOtIxMgQBiQW+/fxm0Iwieguo+FeLHrlrV1iqtdhB1Bh77dUa
         JNL1TasC8xovACHxdLTY4iYIPacj6s1+8/+h4Kh8cnFRGcN27BtR3mmSBLCygNs8n7
         pTjZdDxFrUn5Ltc4fcNCq8Hd0rBNTTKhr4wShrTC8URmARTFkCGwZP2cWhSO1jlTfi
         PeSru1QIZgveDTUzK9UWxcok5K+rTyle9vyJ2PsNsrshek1zizelWhh9ZAvIYOJPFH
         eDNsKrb5/nCKw==
Date:   Mon, 8 Aug 2022 13:41:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.bootrr.intel-igb-probed on
 kontron-pitx-imx8m
Message-ID: <YvEEidOZ62igUYrR@sirena.org.uk>
References: <62eed399.170a0220.2503a.1c64@mx.google.com>
 <YvEAF1ZvFwkNDs01@sirena.org.uk>
 <deda4eb1592cb61504c9d42765998653@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ET9yCxFeYqmqtbSA"
Content-Disposition: inline
In-Reply-To: <deda4eb1592cb61504c9d42765998653@walle.cc>
X-Cookie: Are we running light with overbyte?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ET9yCxFeYqmqtbSA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2022 at 02:35:38PM +0200, Michael Walle wrote:
> Am 2022-08-08 14:22, schrieb Mark Brown:
> > On Sat, Aug 06, 2022 at 01:48:25PM -0700, KernelCI bot wrote:

> > The KernelCI bisection bot found that 5a46079a96451 "PM: domains: Delete
> > usage of driver_deferred_probe_check_state()" triggered a failure to
> > probe the PCI controller or attached ethernet on kontron-pitx-imx8m.
> > There's no obvious errors in the boot log when things fail, we simply
> > don't see any of the announcements from the PCI controller probe like we
> > do on a working boot:

> I guess that is the same as:
> https://lore.kernel.org/lkml/Yr3vEDDulZj1Dplv@sirena.org.uk/

Looks plausible, yes.

--ET9yCxFeYqmqtbSA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLxBIgACgkQJNaLcl1U
h9AXiwf+LRp6BWqj9vWDx94TW59NeSXaukJvcM69SgL9SQIbG9oVrGAjCXdX3CBi
kV37FRPbye0Cl87v9jha8+A17yi5LeAExH5AxW4ISx3+3fm8+8Zgyk8ZKuoVnfpc
iWmexS7RdtR3eJkiceUhkgscuVlWxVbVDg4Sdbb3j2VFZ6V8IfgiknXrV+GoIdgB
I9Z14vDPA5dP+jLJI+t37az3wof3/PfKPZx9Sg8xzq5BMrTvmrZjhvKDg0GHlefN
rOJ7A+MSrakjPRal8ATA9ZIHK8HMBP+rXqnaFQEvpZYCkbY4rU9Q8PR7CAH9SBwk
69vYdFrsxRvaZblao0N087NObziC2g==
=bIQn
-----END PGP SIGNATURE-----

--ET9yCxFeYqmqtbSA--
