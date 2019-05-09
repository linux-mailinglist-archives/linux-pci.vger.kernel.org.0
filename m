Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A696718BF3
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEIOiE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:38:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54129 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIOiE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:38:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so3569017wme.3;
        Thu, 09 May 2019 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2V+iazoAa2OYyc42k+i0pl0UGNWkLVDU4vONXRmArzc=;
        b=mKLGcQUCJYqmHX+LIfCeHd5lGsVJMe4zAvJLv0qk1lFl7IRNiIyE5xS4P7xWrXlufa
         /fNsovYXUtF99g6IROy3IwZ46bgHcJK5rwiiFce/KGkPP5qLCiGgnqS5eSkkfrQ8uspe
         EoO7xVsIOr20SpSyMD3bqj4ZFGCgk43zjSvoUOtyejo3FH1f24R1qZh6Wglu+krmU+1j
         jHFuzORFsFi0BEmmBxzZDIavW3bpHQOh9ycX+T/P88Wcqukorew6BrqcUOOmljCpm7MX
         IcnUyQvj36O0+u+qOgx5Q37w63uuAx0/Rv9Kg6zkhBfXG49kvUHTCeQyo4asY+RIQUNa
         HXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2V+iazoAa2OYyc42k+i0pl0UGNWkLVDU4vONXRmArzc=;
        b=oJLCDXQXu/7i+6RISVTADBrEekfnpl4AGIFloQQYg4tC1D0DQgsuYDkv6D2WbezpBY
         nBsRWuGTBOR3bjFlCLc95iD5EWmYDwQxktXTnccTEaN+ZhO32ZWT6BJPT0xmTze/zNBe
         Uh7JOokkhkrcrEEpTXcOPCr2aDyfR3Ds1JZsVAGbnt05TuhPgnYzbnRkYRswObbPJW9x
         Kd7pxLWxJ7d26ItQj4yWPDF8gig/zToxpba4VTMXMpHGSm8pVMZns4L1xbt90cjhFpx8
         Xj21MEmJqnP1dgMprEE8Z8qlGAyXmQLPwSWdClVlCZcOKonEB7f0UCNF8b43oNfWbQ+b
         B5cg==
X-Gm-Message-State: APjAAAW3VXMdpJJj565FPLqehXJPBAnOc6d6wPcfdzAIXfLReTC+Ubd2
        83NpKhnfv29F49nqxwGTmR8=
X-Google-Smtp-Source: APXvYqzOfVPWdhSdEL6PHABdytNmW4EPAZVYp5tHjJjj9Y+Qv6iR6qNKtMlLKZwkfcJia7yD/rE6Aw==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr3308309wma.53.1557412681879;
        Thu, 09 May 2019 07:38:01 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id f2sm8376165wmh.3.2019.05.09.07.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:38:00 -0700 (PDT)
Date:   Thu, 9 May 2019 16:37:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 26/28] dt-bindings: pci: tegra: Document reset-gpio
 optional prop
Message-ID: <20190509143759.GV8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-27-mmaddireddy@nvidia.com>
 <20190509143729.GU8907@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SZSwH5G1FJ2Fz+jP"
Content-Disposition: inline
In-Reply-To: <20190509143729.GU8907@ulmo>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--SZSwH5G1FJ2Fz+jP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 04:37:29PM +0200, Thierry Reding wrote:
> On Tue, Apr 23, 2019 at 02:58:23PM +0530, Manikanta Maddireddy wrote:
> > Document "reset-gpio" optional property which supports GPIO based PERST#
> > signal.
> >=20
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > ---
> > V2: Using standard "reset-gpio" property
> >=20
> >  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt          | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.=
txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> > index 7939bca47861..4e75e017f660 100644
> > --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> > @@ -162,6 +162,10 @@ Required properties:
> >    - Root port 0 uses 4 lanes, root port 1 is unused.
> >    - Both root ports use 2 lanes.
> > =20
> > +Optional properties:
> > +- reset-gpio: If GPIO is used as PERST# signal instead of available
> > +  SFIO, add this property with phandle to GPIO controller and GPIO num=
ber.
> > +
> >  Required properties for Tegra124 and later:
> >  - phys: Must contain an phandle to a PHY for each entry in phy-names.
> >  - phy-names: Must include an entry for each active lane. Note that the=
 number
> > @@ -626,6 +630,7 @@ SoC DTSI:
> >  			ranges;
> > =20
> >  			nvidia,num-lanes =3D <2>;
> > +			reset-gpio =3D <&gpio TEGRA_GPIO(A, 3) 0>;
>=20
> Nit: it's customary to put vendor-specific properties below generic
> ones.

With that:

Acked-by: Thierry Reding <treding@nvidia.com>

--SZSwH5G1FJ2Fz+jP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUO0cACgkQ3SOs138+
s6FkTg//Zi66AcXJEL2Znr9udLX0M3wfqYQt5QP+O9HT3fPBBWZTDHe6h5Dp3q6o
c8HOcL7XwCaktAyVNIfGCAP+DxL1xj4YLWcngWJJ9PLKYdXIaJccG47bn+YDSOLZ
ZQIfYCFX33/iR2nirr7ORoXGQAurgX5kw7NDTBtiEY9JAIfPyozIAsN53YT4fCnC
4vMOd2A0xUc2XNBuu0jREXhB+IxmlHZyy1Tcf4wDjorYGlhkUkREgv2Jx1pkPMlR
dnVX/7LhkGhYHFbR9LdFOCFtm4p3ZI4iTAq+JLQs1D318jG+HR8kpP5jBxwhk0ix
/9kcZP95mjlIRRr7gs9BLicMP44OddEhQWxtHT9hfLzIhchfK+lEPfb2G+oUPXV+
erOta2eJwyrMvua4JFwtLMVnq+zlWBI+BdSckJd4tTmHpplXh9+ziJLCUZwD0QHZ
RDfztDZSR7TDDDkhYXbUYNVmnm6lsfhOvy8nHbW8TG6ZBsnnLLHVu3cN4Gf/5lqE
bhYOYwXCOMiJpulDBOtFmLqTQTX7eylOQuaN/K2mqIYqGU6M7pY7XraP2UmITEOm
shWjcJcw+gcNQMXK+98Om2biu6AExXPwvNfN0hC8kfiQf6EiYkQvV507BzkTbT7S
yMTC1uxEL2RddM8xl43xOEDdUxtJoORxLuIWMleQVeW+HPVHV2w=
=jUgq
-----END PGP SIGNATURE-----

--SZSwH5G1FJ2Fz+jP--
