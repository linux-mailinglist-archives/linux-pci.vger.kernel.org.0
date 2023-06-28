Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9882A7411DE
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 15:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjF1NBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 09:01:07 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:50392 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjF1NBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2023 09:01:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AC9361328;
        Wed, 28 Jun 2023 13:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AE7C433C8;
        Wed, 28 Jun 2023 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687957264;
        bh=2Y00wv8k2zeA83pKwDQ0+f0MQm1Vo3HU23NOR7nc/K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZpxB2upZeStM/+zsI4GTnz6y7pPZiv3bTGZVGP1AYAEmWtE42tKhS6Rv8k2+I13f
         hhpQyoUb/MhYmnfA8zzwdKTX23t5SBXPaIYRMMgUagzwYTWwlGfUm8pIyk0jWTQezB
         2pEC/BGq8sV/DRQ7RkRqHkkJrjbIWrXPIqUTNHeyLZYYbKq10dVObhXR2nomA/8Boy
         w68yKaXAO9VxzlrymNs37HVgCnNVjSVGB8+yhXJGkolukx0DQSRyjlO/tJ1JoYtARS
         B2PCckymx1q/0MeyaI2aAbDB57tkJETjgL/UYY/a9tVtHqE7nkkW2B/8HQJDN8afUE
         TOjpM5+3oqArA==
Date:   Wed, 28 Jun 2023 14:00:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH 0/8] PCI: Define Intel PCI IDs and use them in drivers
Message-ID: <f4baf2d6-5fb8-4a28-acdb-ec838b0e2568@sirena.org.uk>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ivVRextVhQTuygq"
Content-Disposition: inline
In-Reply-To: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--2ivVRextVhQTuygq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 10:51:27PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
> PCI IDs for Intel HDA are duplicated across quite a few drivers, due to
> various configurations and historical reasons. Currently almost all uses
> of HDA PCI IDs have corresponding comment telling which platform it is.
> Additionally there are some inconsistencies between drivers about which
> ID corresponds to which device.

Acked-by: Mark Brown <broonie@kernel.org>

--2ivVRextVhQTuygq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmScLwoACgkQJNaLcl1U
h9C14Qf/enTslOfeuoQE3sEiC7/D5fPrkfXHo5SpklR5QWR22KGn23Mr0UqCdSUa
PJaY1aUhKtpPW/x1rP8LK0b7Hsb6zI+MW8FT+oNXIHveJRBgevnDB3MbHkv9betY
FnBfa3gRALg0kPKxrpSYSGef1Tbg/F1m3YgtpTwBbTf5UBoRQVBhFOPw/ghLVmqt
GRlu5kU6zBIEbEg9jTJ5eP6qFpmkYIWYMXJnuc6kA2IbDRXhtECItlWjSAs82bMY
w9XyPZMPCY4KYbMeGAB/L1KlZvmLCsLQEDRUIva/0Ml6ty97cX67+9e+bgsqRtEC
XtmEQX5+/sSnbrCZzUgJ1K6cMEYgXQ==
=loPF
-----END PGP SIGNATURE-----

--2ivVRextVhQTuygq--
