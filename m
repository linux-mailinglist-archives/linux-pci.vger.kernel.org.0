Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9D33589D3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 18:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhDHQeP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 12:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:32808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232334AbhDHQeO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Apr 2021 12:34:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC066610CF;
        Thu,  8 Apr 2021 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617899643;
        bh=P34rZqQzi+uzqbnqI1xrfto1c/3g6EjqvX+IANZ0Ldw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3PgvK+HL3hhMHpBbsVGb9/zZ3wV9TxxzbAhXOCQjM08rdJsEMsBMd56D8f5OOItb
         maNBjXrmHn0TMYzrXQ/S/0l7z0aXUr4mDfHxTnN8FEmEIU7ep5q9MeVIXrU8S/b8ZG
         sKqi4l1yopBc32AYxD5bxlInwWaw90VRNI/dEa3rV2W465ed6VgxyLarwPw9pr0oep
         mI2zLugITmI57b/s1Ep/ePTMN+t0IX+DcL10FNBxf9U5X+dSmVL8dEUV9V1oAc09Tu
         mAjNfmGmR3MGK8izPTsV8eUjIjis2jv0ZyRuUdKHMyGckWatEWhhsKYx4ynpl657YY
         /RMp+9gevqvXA==
Date:   Thu, 8 Apr 2021 17:33:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
Message-ID: <20210408163345.GO4516@sirena.org.uk>
References: <20210401212148.47033-1-jim2101024@gmail.com>
 <20210401212148.47033-3-jim2101024@gmail.com>
 <20210406164708.GM6443@sirena.org.uk>
 <CANCKTBsiujTkOdh60etBqF_hE8exg6m9TDxkGHVVAGVS2SFCcQ@mail.gmail.com>
 <20210406173211.GP6443@sirena.org.uk>
 <CANCKTBv63b4bGepZbDp1wmFrOeddiDikoXbheMjHhbguAbR2sA@mail.gmail.com>
 <20210408162016.GA1556444@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tzZdJ4yHDV5r1Akt"
Content-Disposition: inline
In-Reply-To: <20210408162016.GA1556444@robh.at.kernel.org>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--tzZdJ4yHDV5r1Akt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 11:20:16AM -0500, Rob Herring wrote:
> On Tue, Apr 06, 2021 at 02:25:49PM -0400, Jim Quinlan wrote:
> > On Tue, Apr 6, 2021 at 1:32 PM Mark Brown <broonie@kernel.org> wrote:

> > > > On Tue, Apr 6, 2021 at 12:47 PM Mark Brown <broonie@kernel.org> wro=
te:

> > > > > No great problem with having these in the controller node (assmin=
g it
> > > > > accurately describes the hardware) but I do think we ought to als=
o be
> > > > > able to describe these per slot.

> PCIe is effectively point to point, so there's only 1 slot unless=20
> there's a PCIe switch in the middle. If that's the case, then it's all=20
> more complicated.

So even for PCIe that case exists, and it's not entirely clear to me
that this is all definitively PCIe specific.

> > o After some deliberation, RobH preferred that the voltage regulators
> > should go into the PCIe subnode device's DT node.

> IIRC, that's because you said there isn't a standard slot.

I recall some message in the thread that said both cases exist even with
this specific system.

--tzZdJ4yHDV5r1Akt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBvMGgACgkQJNaLcl1U
h9CUJAf+Nh0zP3iQ9+LL3Pr4m5J6LT5Fgs87NVCBediwBRM7EedTFDAFkspKdppU
Vwvd3CFuyzGrWppnMDgDC6bchMMoeGeryDpGanZWbWgsNBb9B8Kdf7auVwuOOKNe
fLN37q0+Gb0gpwNFmRQUnwCCNCOTvo1Bt5I2cuIMdEy4LmsU0sRvtXVtlAeJBNQU
5sx0opfkCgPp2zeodCt4CVV4HlUOc2GaxiFpdMQV6s9irjyVX3UnfxYToR5MqBJO
4Si9uDN7QAdgQnxvLi47LtT+4MzL84wFqHTjgf9++Yyxr2vBEvaGgz6O0iHpMVHs
iwhnfagNwF+dn6zPIMO40a+2o2XgWQ==
=b2of
-----END PGP SIGNATURE-----

--tzZdJ4yHDV5r1Akt--
