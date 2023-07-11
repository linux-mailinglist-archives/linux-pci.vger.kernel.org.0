Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DA974F3B0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjGKPhY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 11:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjGKPg5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 11:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574E919B9;
        Tue, 11 Jul 2023 08:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E94F36142E;
        Tue, 11 Jul 2023 15:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101EFC433C8;
        Tue, 11 Jul 2023 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689089785;
        bh=3yGJUv7mG9w66QWvUDiFCAxpjPym06sfQHYY0aD+gSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtCM+nu/ST2wx6EMLwwyQNSq47eBjxkB5xPshmtwN7aZSIBvA5JPxYL4RY6P5WAIy
         NmY0PZC+/lTrZWkJCg+CP5ZG53KLiv6co4gXdLxBwKsVjUo473qGbqNI2hr69F+5ce
         O7dADWw+IEZjXGU1plNOK9mbtucA0yU73dxlDASu7WYXr0be3zkIWhAep8GxTRD5v2
         J2P5031nNIjI11JtKPIUt2NqfrZv7zNZ656/HadyzqnKRGLj5TuJ3abccwENp5Pxi5
         U0RXUVcexPFn1VKQCGYVbo+ARY/5rx5vL0aWf2H0E52eK5ZLmR1exzEm4L8WwMN9RU
         k8mIGvP/kvzTw==
Date:   Tue, 11 Jul 2023 16:36:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 00/13] PCI: Define Intel PCI IDs and use them in drivers
Message-ID: <46d612f4-24a4-4493-aa9f-0ace5225a38b@sirena.org.uk>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <bc2484ba-3bb2-7d74-fcd1-55c9ec253b9c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ugnuzEbNXZzUGQ5Y"
Content-Disposition: inline
In-Reply-To: <bc2484ba-3bb2-7d74-fcd1-55c9ec253b9c@linux.intel.com>
X-Cookie: marriage, n.:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ugnuzEbNXZzUGQ5Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 05:24:07PM +0200, Pierre-Louis Bossart wrote:
> On 7/11/23 14:57, Amadeusz S=C5=82awi=C5=84ski wrote:

> > Simplify things, by adding PCI IDs to global header and make use of them
> > in drivers. This allows for removal of comments by having IDs themselves
> > being self explanatory. Additionally it allows for removal of existing
> > inconsistencies by having one source of truth.

> I'd like to hear from Takashi and Mark on how this would work, we have
> to provide new PCI IDs for both trees using a common 'pci_ids.h' file.

We can probably just agree on a tree to apply things and work from
there.  It does make for a bit more friction though, you're right there.

--ugnuzEbNXZzUGQ5Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmStdvMACgkQJNaLcl1U
h9AQowf/frH4ZuVWxLoHCFW2XNC+zViR9SfL0G/UaMowMZGcAe9fQFOpcTfXCw+8
0LcnZKN2gPtOqRGuIDyD9ybZs8HPwXAYNysA+gz6l9uCXVeDDYo5NHxFP7D9DW3G
pfBPQIY7O5MQNw6GThz/RCmlxUtxTBt/Lct+BWtaPAqofAlWWoSdhtimxBxEi0Qo
t+hiE1R6Nnnn1hKMnag4Lv7S1xANiDUmU8+ZJ31cnaq1fod2MDk2mAo2X1BNmy5U
OS1f5KaOOjcJkRK1FHA/aFiwfXDUG9hyNHWTp6BrcmBvEZxDQANh7Qrot2rBZUAs
TfMxDv+4m47o6doA8eWgHQOcS+c39w==
=y0s8
-----END PGP SIGNATURE-----

--ugnuzEbNXZzUGQ5Y--
