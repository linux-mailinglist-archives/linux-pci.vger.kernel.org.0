Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FA8753B8A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 15:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjGNNJu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 09:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGNNJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 09:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B4E1BF9;
        Fri, 14 Jul 2023 06:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE3FF61CD5;
        Fri, 14 Jul 2023 13:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A7CC433C8;
        Fri, 14 Jul 2023 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689340188;
        bh=ny38HQfzLtwX6eC1kMXhNy8LoU8DEUZBxECFrSVYZxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TeCruyktizhsn3RRcqBgwcwYKhK5HBVN9SqIoukDP7r3IcFnbT62h7nMR+B866S5Z
         m1gm2ahVAYA55Pz7QLumONFJPHG9XyT4i00t2f/oubjmEJLEu11p0rKIp3QJsWWGSb
         55XZ+oaScV61sgWiY0KNpHkUuOhISob48AmIaGMWfeUMzaZkDOIrKkRVKgdRxQyyEN
         vSCwnWRU5sE3Xy5bD4dFfI6LcbueBi6BRmB2Z+Je/JWMsW8fr0B7jGjddcT06ILidP
         UbKCdCJwxoH5pug8qqMG9hXyq2juFWpbPHGcgRiurPTiVpzzMJ6Mf1IHKukSMhgSKk
         Sb+jjIZvLJx7g==
Date:   Fri, 14 Jul 2023 14:09:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 00/15] PCI: Define Intel PCI IDs and use them in
 drivers
Message-ID: <ee3e4d29-48bf-4c8d-b792-f37088a335c5@sirena.org.uk>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x5BNYJ4xdMioPl+C"
Content-Disposition: inline
In-Reply-To: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--x5BNYJ4xdMioPl+C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 10:24:42PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
> PCI IDs for Intel HDA are duplicated across quite a few drivers, due to
> various configurations and historical reasons. Currently almost all uses
> of HDA PCI IDs have corresponding comment telling which platform it is.
> Additionally there are some inconsistencies between drivers about which
> ID corresponds to which device.

Acked-by: Mark Brown <broonie@kernel.org>

--x5BNYJ4xdMioPl+C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSxSRUACgkQJNaLcl1U
h9C59Qf9FkyMHBDgbumQQ0gR+FbQau1VozGcoVek/v377CiS+IGIFgjP7GBr/Uxo
z7uNKJZrTAoIKshbyAf60a14D+6KAXIOxzzQMmM/HMivWa6ihhN1aw1fBsLeGLRW
1xNElcQ05bgdd+Aoo9u3a9Rx4r4shPRJ3KsWY9MmJNZSqlWpdMUsc4oLZR0GfGlj
jThtICxLcJ90UXBomYvrccM6nghuSpb4FSFV6xTjcPpBkG23MfAaWUPNbZWhZmcz
AfbWu0WFS8Om7sRGBalfbWDag1Qikwjh2q8j1vNYX9J9Fq6Pro4Su5bvqQRwWxVP
zAz+X73daUaOVTo8nyGtwTdnmUJtXQ==
=FErE
-----END PGP SIGNATURE-----

--x5BNYJ4xdMioPl+C--
