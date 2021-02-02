Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4625F30C4DF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 17:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhBBQFQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 11:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233312AbhBBQDq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 11:03:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50E4F64E9C;
        Tue,  2 Feb 2021 16:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612281785;
        bh=7iQVk30xqGz7oh/+t2UzNMka+0TYG4P9cu4Sz5uw44U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGVczdi5TLvWclKzomnm6cyIJ3HcZ+w7vfYsz1MHUEUiQatmYgA2zNeQvlXYuBfuy
         kTTdgHUOfaDhTbmcXXDBNA7IwFv21TKX7KYvcHjZdJyRUf1agJdHjVdmibIHR5tXgT
         MysVD/n4KdIZzTm1sOYZh7s4c2wjqTTs5dlLCjXSsQNlmK/0XAFRXOLPSdfavbXZFf
         hiD1vngA5T4+2Lj2s5ss+WWIpLloYnzdtI9jePtK01Zrxtf3TXUUg/PramnSVy74m5
         Hs6QTRWpzm8z7KVPlJ4R7EMjv8ZLM+CNlBTAV9Hkd31SZaGwe84yaZwD0ezxo/VQWT
         l+m/BczKA2F9g==
Date:   Tue, 2 Feb 2021 16:02:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 09/13] pci: dwc: pcie-kirin: allow to optionally require
 a regulator
Message-ID: <20210202160217.GC5154@sirena.org.uk>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
 <7f4abd1ba9f4b33fe6f66213f56aa4269db74317.1612271903.git.mchehab+huawei@kernel.org>
 <20210202134101.GB5154@sirena.org.uk>
 <20210202155028.28b0cf94@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <20210202155028.28b0cf94@coco.lan>
X-Cookie: Only God can make random selections.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2021 at 03:50:28PM +0100, Mauro Carvalho Chehab wrote:
> Mark Brown <broonie@kernel.org> escreveu:
> > On Tue, Feb 02, 2021 at 02:29:54PM +0100, Mauro Carvalho Chehab wrote:

> > > As this is device-dependent, such regulator line should be
> > > optional. =20

> > Supplies should only be optional if they may be physically absent from
> > the system,=20

> That's the case. On Hikey 960, the PCIe hardware supported by this
> driver doesn't require any regulator.

> On Hikey 970, the PCIe hardware is more complex. Some components
> are outside the SoC, and those require a regulator to be powered
> up.

That's not an optional supply, that's a required supply for a different
device.  The driver should select which supplies it is requesting based
on the hardware it's controlling.

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAZd4kACgkQJNaLcl1U
h9COtwf/dNvTdqU99ibQk82bdFJxdWofc46BUTLIq+yKgtyLLWwcERh5WQHggaoD
9E1nXpB2MkifqUkKyQ7KGOooDTiQsilpPrR7Doxn/svILexLmCO/zNtqomromkt3
B5PS19a5NEVbi+tZDGYLVMnhiJw7OOrNWUVihsLCJ+Xdz5EfO7TerB8AhGngog0h
TrYYofWJYKjMTSKoxottsGdrt/fuhdYEevtEHFdfDhnE4EcfixFB5GN/eP/2fyga
XDzjVbzJ+Psxkf1SjbljSD3FsGBB8Lfek6tlQuHYi3CGT4hYgW64Q+0vYepCxQKv
E5Cq7YqSSba0fdXYPOKMmIIO5Y4xlw==
=AM6x
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
