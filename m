Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA612C50
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 13:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfECL0m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 07:26:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44586 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfECL0m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 07:26:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so7392070wrs.11;
        Fri, 03 May 2019 04:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j9Bj+Dr7WyGv/rMCkmt5BFQpG8uQuF0RuguMoXtRvS0=;
        b=KhcmV8O0dVPoB8tdfI0z+kSjdn0vdYUoQOtCSIuzIFMc9Aa4HDUEnrmw8ciYUvNEJy
         cvtUtn9J7f0xcQIm9oTTSb1CPbKpiYTi63Up+RBnqOLRJEy3mB75iZM3JjDoGR8dg2in
         MMdZCcNPKdneA1jqG0wBS25E0In2g/NgyNJcxSAzkGzuQF/bnPJ9sYywS8i0ErLThyoP
         q8Z9/bTw4J4LJDR1aGodbcw9SXlS+YrsYzComoXB45V24RjcJN6pzGoMIUd3Kf/g0kFo
         JBhZoShu8+BzKxJtAFo+zvIyY5YFvWbaE2SwEA+I/0YifEKenih8ayBtbD5eUv1s6Eoo
         Mmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j9Bj+Dr7WyGv/rMCkmt5BFQpG8uQuF0RuguMoXtRvS0=;
        b=dEQmtHp+toHLJ8h/5h9m1N8nJ+1FPwCUyLS7g+9h8e3QJ8PVMt3fVuteZgX1OggOFw
         mYZProyh2bA8r856178FlOAfs//des2PNBWC0uKQ54MYlSF01SgaJFLn90LS2ItCnJ/o
         +XbeuuWmfK5XcFWHKiKB93bEQ/Fdh0nJHhUHFEBm55nXMBzHYCjcDZWXP4DuiKtqchnG
         NP02JsP4ZlUvOKuB0BddW790is8ZDRYD1uueB3HaJx0C0T6x+sCDF/EEOOPOzy8C5Pzx
         icggykp/599UuMmjS2TQNxFmGzjUIG5JCTUiVwRxIeROnBdRqGUK2A6bhrVYijvZkB8g
         pBRg==
X-Gm-Message-State: APjAAAWlsMNSRenQd2PINlUcjEi4xcZ+rFT5P10xvtCeLhRPRf7iU2PN
        BdM6OgzAHoRk9M4hcCLKR0S9ZRJeDns=
X-Google-Smtp-Source: APXvYqw2hvhDgJ3VCDJcQcuW3ahQwR7R2Mg91+rWb9Y8oVcliDb9EpMX8XcPO53tP0nhm0GQTpf37g==
X-Received: by 2002:adf:e9cb:: with SMTP id l11mr6376382wrn.114.1556882799909;
        Fri, 03 May 2019 04:26:39 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id t27sm4332288wrb.27.2019.05.03.04.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:26:39 -0700 (PDT)
Date:   Fri, 3 May 2019 13:26:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 12/16] arm64: tegra: Add P2U and PCIe controller nodes
 to Tegra194 DT
Message-ID: <20190503112637.GF32400@ulmo>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-13-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline
In-Reply-To: <20190424052004.6270-13-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 10:50:00AM +0530, Vidya Sagar wrote:
> Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
> The Tegra194 SoC contains six PCIe controllers and twenty P2U instances
> grouped into two different PHY bricks namely High-Speed IO (HSIO-12 P2Us)
> and NVIDIA High Speed (NVHS-8 P2Us) respectively.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * Included 'hsio' or 'nvhs' in P2U node's label names to reflect which br=
ick
>   they belong to
> * Removed leading zeros in unit address
>=20
> Changes since [v1]:
> * Flattened all P2U nodes by removing 'hsio-p2u' and 'nvhs-p2u' super nod=
es
> * Changed P2U nodes compatible string from 'nvidia,tegra194-phy-p2u' to '=
nvidia,tegra194-p2u'
> * Changed reg-name from 'base' to 'ctl'
> * Updated all PCIe nodes according to the changes made to DT documentatio=
n file
>=20
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 449 +++++++++++++++++++++++
>  1 file changed, 449 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index c77ca211fa8f..dc433b446ff5 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
[...]
> +	pcie@14180000 {
[...]
> +		ranges =3D <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000  /* prefe=
tchable memory (13GB) */
> +			  0x82000000 0x0 0x40000000 0x1B 0x40000000 0x0 0xC0000000>; /* non-p=
refetchable memory (3GB) */

Please be consistent in the capitalization of hexadecimal numbers. You
use lowercase hexdigits in one place and upprecase in others. Just stick
to one (preferably lowercase since that's already used elsewhere in this
file).

> +	};
> +
> +	pcie@14100000 {

Also, entries should be sorted by unit-address, so controller 0 above
needs to go further down.

Thierry

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzMJW0ACgkQ3SOs138+
s6E+CxAAl1IP5hPwNub+ynrfDHIlvS8wnANVpXA+TBShMg1rBrA2c7ErQwRKFKrH
nt0A/GAU1JPp+Ugy6Rvesx1f+mNpHl3ueZY9DnlY7FRjfgv39qKvFuCRAPHR2YDk
CCgNJjCBroY3+OvmMxtK0b46pB7xtAwDXVBp0DbUGibGU+6wQ5XplqmwqQONu9YU
tmMCy2vpr1PNzwgLGfhC7owYfz4vQVzJDWeSfUVbuf0uuhaYg9Lak5cfPJqEPPEF
husujx86GqI+xk4zhAN/mvoMN9OoJplO7icUXCJRrB9lHOycZOA3SZwDFZm/rRmA
q7AwE+bXW0FIX6Zel+6wAxBdpwvqc/RJmsRAe1efSh88NuTFn3AWW8Fc4K+4mOn/
royxYh3z7Z/91PmfgoF9Ku6xtpeZVmD63lDQ+LHbTgrDb2lEjZ66Wcque1mYn4pt
N6ko8YOVjwSEu0kVTk36j7Qyrk7VMTzuloelaaplcXY8iX0ClplKPTYH8+FbzXgQ
W3itYlLXLNJQpfEceRZwuqWCcerLyURykmeVOih1n8PLuK0yEK8fr8GvyGP2JMvG
hoF0m1QDdjnm1G7LvfLCBrngb6Bze4wQ+wLqn2u3ydi0m1gU5vJ0ac1oKIhMm6Si
ntXZJ7cuJbnw4M3fkL8zHz+2HPyVZ+ZmZV/1GNX6KMKocNI8A6o=
=IZEE
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--
