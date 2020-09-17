Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968C826E1E4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 19:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIQRLy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 13:11:54 -0400
Received: from [139.28.40.42] ([139.28.40.42]:52588 "EHLO
        tarta.nabijaczleweli.xyz" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726861AbgIQRK4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2020 13:10:56 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 13:10:55 EDT
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 25D75360121;
        Thu, 17 Sep 2020 19:02:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nabijaczleweli.xyz;
        s=202006; t=1600362127;
        bh=8qpIQskXTGZ2tOSx4v5TTL/yi7t2/A/G0HV/o17EDr8=;
        h=Date:From:To:Cc:Subject:From;
        b=LWT4bzAE2mglpruTuz3BQrKxL0VQbmQ8xnafhJgvWa4mSH6mk/URI1NW76x4qVgBb
         NLUGBkYnVi9P9ogh0O7vs66QEpPB9JipwqmubdGd47dzUIyQuQLWgDPs5ZSSTzTl7s
         QgKcQnrf+xZbzmqaXBLUxuJlgJxEWJWL3Zpb4hnyRvxTXI47nxWi1mXaJROYHi8Vqr
         HZCG2gVBvF4Qwf14kHcVaQ7COZqqYNKVOuFf8pFErQExL0NRzcNAiCPMyHh3P4PcCG
         lP6ffwS6Ln1hM6gIkpMIbZRvFZzjhcWATSalomIEerUE9gusesbXyYa/5eY45yF5/p
         KWij1l31X0mMQ==
Date:   Thu, 17 Sep 2020 19:02:06 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: pci=nocrs required on HP rp5700 Business System
Message-ID: <20200917170206.z6iobcrac5wowdcb@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jwmh3go2fgenq7iu"
Content-Disposition: inline
User-Agent: NeoMutt/20200821
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--jwmh3go2fgenq7iu
Content-Type: multipart/mixed; boundary="ymnfgxyhloz3vxsa"
Content-Disposition: inline


--ymnfgxyhloz3vxsa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I needed to set pci=3Dnocrs for my rp5700 to detect a PRO/100 PCI card,
so I'm reporting here as instructed by the dmesg.

The DMI line when booting is:
> Sep 17 17:55:06 szarotka kernel: DMI: Hewlett-Packard HP rp5700 Business =
System/0A80h, BIOS 786E4 v01.24 08/23/2016

I'm also attaching zstd-compressed dmidecode output.

If that matters, I'm on kernel 5.7.17-1 from Debian.

Best,
=D0=BD=D0=B0=D0=B1

--ymnfgxyhloz3vxsa
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="e100.dmidecode.zst"
Content-Transfer-Encoding: base64

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
+xAeAeHiq4dFse4BhLakBQ==

--ymnfgxyhloz3vxsa--

--jwmh3go2fgenq7iu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAl9jlooACgkQvP0LAY0m
WPFMkRAAjx1saYPi+hqctcxXKiFpYVG4g5wC2fDemJToEWjzQoo9ZU/P2tVKMXes
VUf1SFxRsmhTz3M0+PWcrCSzxRMMvWTfr3iPqiMa5/EPS4rg7+8lM5uW2RaNhnwB
14nt9Bc8p+ri38KG5lSWhMjF8nlrotv4j50mNSLtNbR+JqSuEfmImseGcIlWcfM/
FhZIFi27/oKH+DR/4jc54q+a282fPG89ZeadkJTZcz4wReWriUJUGZ5IqiPF0h8m
3MgKLKaXTza0Sxo+ib8CHizhofAxGIveIq6IRIlB1GGWBI95/C93EXiLim/bjL8+
ANoBnXo+xa51Z014r0LXKQhVmqKEgB30vkDMzFg6FKakUS7aAP8vMuG6LlXouCEf
MpZrpfstWMLmLsNWkY212Mde4gAksGDnGe1xWsJN7j0/xuemSDkL/jkg713a3ahA
8ck2FurBX42SxhNv2bDFRXjUnfAF3x7tI9Yw+yT/j0Z0lRFqrrdDecgKnCu89SNT
pQfuD2aR4n1b+4ZNL/1qVJxJtQ/WnXZ/fa6cC3CGl4GT/lctlvjIRRouys/NJoCQ
L2lrS+QY0978mYYBzFKfT5I9g3w834F+Xrnkv9zmeG37Y5acf4uQ6tySKRuM1I1Q
iCqe4vT+yonD+QQfUnMqEIo/8QyTPdiDV0fVZnI1lHA+e/tO/Dw=
=lLC8
-----END PGP SIGNATURE-----

--jwmh3go2fgenq7iu--
