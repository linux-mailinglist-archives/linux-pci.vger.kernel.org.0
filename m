Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884FA355986
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 18:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhDFQrg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 12:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232032AbhDFQre (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 12:47:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D19C613CD;
        Tue,  6 Apr 2021 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617727646;
        bh=RR6kcUa5PzJFbUkRw8yao0Ic9pH7NeQRccRbZh4Aoy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bF73RoRjeTQuX67bN8v8T+azFdmn5c7r8wo8a9WpqbOO14EYwjT5DfLVu/SPtSAKA
         4U00AZuk25Or4dEnP5HNVVYtBGEv+lkdO1Q3F0uUCbgg6UH9QCVrmDu2w7kPNNeuvu
         OKQiTQioKd5uvX1jghKMkx5L4lZZweZUyo5W1QAc+933oAUk3SocByQiS76IxXhNgj
         gQ7bblTd+fweF3koHSO9kGQyXDWu0J1VQMXtSU5avalLeyHKiYv4YCGaJBPQoBN1R+
         7Xbl2NgJQQV7/Ql/5DRGsO0y1RhGz2ce8FdcE63tlg8h1eHqN069N2YxJ1o3Y2eRw/
         AIU0PWKlkbgeg==
Date:   Tue, 6 Apr 2021 17:47:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
Message-ID: <20210406164708.GM6443@sirena.org.uk>
References: <20210401212148.47033-1-jim2101024@gmail.com>
 <20210401212148.47033-3-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4oQnj4jcM03NhqPN"
Content-Disposition: inline
In-Reply-To: <20210401212148.47033-3-jim2101024@gmail.com>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--4oQnj4jcM03NhqPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2021 at 05:21:42PM -0400, Jim Quinlan wrote:
> Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> allows optional regulators to be attached and controlled by the PCIe RC
> driver.  That being said, this driver searches in the DT subnode (the EP
> node, eg pci@0,0) for the regulator property.

> The use of a regulator property in the pcie EP subnode such as
> "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> file at
>=20
> https://github.com/devicetree-org/dt-schema/pull/54
>=20
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/D=
ocumentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index f90557f6deb8..f2caa5b3b281 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -64,6 +64,9 @@ properties:
> =20
>    aspm-no-l0s: true
> =20
> +  vpcie12v-supply: true
> +  vpcie3v3-supply: true
> +

No great problem with having these in the controller node (assming it
accurately describes the hardware) but I do think we ought to also be
able to describe these per slot.

--4oQnj4jcM03NhqPN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBskIsACgkQJNaLcl1U
h9CuRQf+PPRLBZm2k5aRqKu6YzjzBHgwKCDShu3P6RVk2NFkxe6LK68rU8YVuhaM
NHNO2GFEQjgIFuIhBl6Gf5PjKfHYlFlIif9uJ8WF63oh06TpxkPdXXN0owL+WyOs
+TR3XMqnNEZd5ESCeEvs9Tm+HUunfb2LE1Sjz6dgYd5Y4R9Xec5ImuSw/B0fPduw
+iqcSKC+4bhWo1OV+9r/OeuBZsU5vTQOSAjZOj0cF4QZH1RbYmEVDDiTJh6CrB9I
MbH1yITFOtzMnSAS9PB08RbrxPRwEs+arhdUTj3akupkM5k7Nndr5RHeto9sDTyQ
u9GZXTKa3pr9GPoaERDZhx6l8XEhUg==
=TxRf
-----END PGP SIGNATURE-----

--4oQnj4jcM03NhqPN--
