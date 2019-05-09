Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92B18BE8
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEIOe7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:34:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36834 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIOe6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:34:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so3519621wmj.1;
        Thu, 09 May 2019 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=akduR5R/6egEiW8VfzOYweMZiUf2uvp3/1Wd5aITFoA=;
        b=Fq5wXr/a9XHuiwoZEs60eqS/FPisSR/XuOcb18Yn6Mq1uM40082yv7REZ4Bj+ctg02
         xzq8cSPRv8ZD3CUV656iSrAsFfYn4/kagOb9+5z10SV/jo95Dydcc5BddheQeSzQ0cxs
         YzcmnJtiXGCA7Jb4mbnWyHC0cbb59YnoUSBBcbVFIVzOCf72licKLNlAAaIKZOQ0WDIG
         EZammsQfPRDbJAMBkAziHq8KwFnJM81Ky8uA/1eGLIU4jck0TbLUmWTwAWICdzb61xaj
         HUVpr+F0r/PiSSWftinjUTOeCHPYSftj0rH4ENb8h00pdxOTsCGPOE4UUOBiVs7pZr4O
         YK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=akduR5R/6egEiW8VfzOYweMZiUf2uvp3/1Wd5aITFoA=;
        b=NfgclTLdgZfcRISX9c+vPmRVxX9/LkwC6m53uV+oHS4ZOya1IvCbJ+rGE7OLATOCI2
         7boXqc5a2wfcsj6ytJhi/TwF73RP1qgiQ0tP5+hdg6lsXZwcqzqBPUKxUwmK39Y1oiIc
         sgUPHYNjF5H1U3K/dqfUhszeJuXHqalNZHhWGgENc+f2FDfP69gkASGgBIKO3DiS2rzI
         AiHBRtgOvA5SlaYM8xzGnSJaLpEMawlNInhRE/EmGfRZ+RHK+kcdWfRxPA0xqZ0xuvR6
         +2GhN3fV5TYlxsbKtLFdW5KSW2fDXWmfpAGtskVWvJlr6gIlPpoUIDHHFxEY/WuV+u83
         AvEQ==
X-Gm-Message-State: APjAAAW4v9ebSZVVVPZnHitHcyNOM2Aqpo2ZvSl8AgvzY+SqEafIwmC/
        fucYeAQ63jWLmXQEPfKi4oQ=
X-Google-Smtp-Source: APXvYqzYST1n/Yw50iaSWpfGoo4tanup2T5RwVSYjl+p7pKsWSMxoqYx1bsntTihO8SB5df7OjKKqw==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr3157284wmj.88.1557412495823;
        Thu, 09 May 2019 07:34:55 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id h16sm3985335wrb.31.2019.05.09.07.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:34:54 -0700 (PDT)
Date:   Thu, 9 May 2019 16:34:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 23/28] dt-bindings: pci: tegra: Document PCIe DPD
 pinctrl optional prop
Message-ID: <20190509143453.GS8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-24-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+nLR7g8KNfrRqv5t"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-24-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--+nLR7g8KNfrRqv5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:20PM +0530, Manikanta Maddireddy wrote:
> Document PCIe DPD pinctrl optional property to put PEX clk & BIAS pads
> in low power mode.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Using standard pinctrl names, default and idle
>=20
>  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt       | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.tx=
t b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> index 145a4f04194f..7939bca47861 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> @@ -65,6 +65,14 @@ Required properties:
>    - afi
>    - pcie_x
> =20
> +Optional properties:
> +- pinctrl-names: A list of pinctrl state names. Must contain the followi=
ng
> +  entries:
> +  - "default": active state, puts PCIe I/O out of deep power down state
> +  - "idle": puts PCIe I/O into deep power down state
> +- pinctrl-0: phandle for the default/active state of pin configurations.
> +- pinctrl-1: phandle for the idle state of pin configurations.
> +
>  Required properties on Tegra124 and later (deprecated):
>  - phys: Must contain an entry for each entry in phy-names.
>  - phy-names: Must include the following entries:
> --=20
> 2.17.1
>=20

--+nLR7g8KNfrRqv5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUOo0ACgkQ3SOs138+
s6Gc2Q/9Hij/GDFHZDNoiDPFsx/57/eFWGTCouIYLoDXk08VWpubGSl2sD+jksB3
OHYY7LaaXH72gI1xgRAPxEmoklwFUVldTP3NjBFxn0g0h6eorrsTOwBedUqOZxoC
pcDnfQ+WiOPXMJzHXae/21cTVv+/4zYmChGai48nMaRu16GvYPANre/welPJxFBM
BDqXImcvWJnORttaDRVfOkP2RgZT2TTwi4OOs+BeraczXNKyXPHlwYeN+4ZaSHRt
3jn69q3+7LplLQNEdCUc1toKzAjDR6NSM8H4HLwkRyNQRKRsDbGw2v6b1R0qm8gc
0QhUi0tC15s24z/iEl0+30+Kh2qe9ql0d8KdBXsxmQD9vFd/WE1qNCHHPBBjXUBu
VzJ+TmrF2assLlxagjAQdwxEV+BAX/UW5y3VbBl/l6jJ+VorAsaif+x5qYRc+2AF
sUHzMzQN7EhbVz43y52vuS7pTzV443KKbGcVKxuO+SGZC4OMRDeibvB4A9mDRQ7a
RzV1z5fqH6+0qJMi6YKVjuTnPlC7bw3RIHALM1SbfOLCU2O7dBIAApNrHgOjiYLV
Wtps3Na4c9dq6qVBrfQizN8BNGNko25oTgfrekh0glFD5Uqhu/MzxNYJ4oeIu0Zm
5YEos99KzjUA4z79Ron5WgAM1GoJ7aJiS9H0XYphm61tFHDP0Nw=
=w2IF
-----END PGP SIGNATURE-----

--+nLR7g8KNfrRqv5t--
