Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BED9480B1
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 13:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfFQLan (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 07:30:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35219 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFQLan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 07:30:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so8713249wml.0;
        Mon, 17 Jun 2019 04:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jIYD7jJxsMMsTeHkkeCxMxS+0nX8dsWeFEB3Kc26fV4=;
        b=FWn6W/gC3fdxxuSgp1fRdDeiWM2BCvQ9xV2rp5teav4B85NGUEfqOz+oRize2Y1XCA
         OHGceD6AtS5nS5ovmjw1g7xoJAstFCjDFnqR/uGaexmJyohMiYiUzOgEfq6qRXyVfESx
         zR6H40iW4g24+TjlQZA+H3Q5mHRtqG2aUW34gKGf9hyuKfUhSrpOTgmiBBU9t5nRARPx
         qZRDl50ZJ6s6ZVsUM+bBpOGhIzov3FuzT2VdAwZYq2tjtCQMOq3W89kMFYwDGvfcpTWx
         lmHhEVHPcZVtsNAtqoFakW92ayY4igS2efO6n2XFNRTCfP71QM8hIV3s9juUwOIdeTsp
         qAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jIYD7jJxsMMsTeHkkeCxMxS+0nX8dsWeFEB3Kc26fV4=;
        b=Czb2bqRuJAvwLjNEKp8lLQpNxK/oLy9OFwWMT6vsAr4yeV9sjlAwPNZOBrkYZGWDNP
         /Niz6Sr6FHFOkDO0mXVI4nO5Lv91TWAmTQZclnEcmr+q0JZwaqFqlL244E0JkjnFcpVh
         eG5LpEtVJAUjqXGocDAcoFO9TUIgoC8o0i47w/u1DheVI1WwTx6rB5oyCSRIxMkwc42a
         pMfUablOEIcg52x2qynVR75xWC7YQKpUlbz2+8qTjXvAP3U7ujq3gnP81iCqNYkG8pWH
         U8l3N8r/9WpMrPdxM/OenVxNgbejckESD2s/YLYhr6dSAGRp2At000r5YKOQkm2fEgTF
         WBrw==
X-Gm-Message-State: APjAAAXTbHPYKxCi/ZU9VC2zbBLgsuAn/krCyxr7n5SNclJNy+8An+Z6
        uLjZXFD5xf4sAi14gGUlWE0=
X-Google-Smtp-Source: APXvYqwVLYUonvELBilcmxHMeuj7eJzkoNFZm9J24vZ4RPQ0HEqEXmKWTJ4zBLjk3HQFtRCXXBpgsA==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr19666176wmc.151.1560771040522;
        Mon, 17 Jun 2019 04:30:40 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id x11sm14548936wmg.23.2019.06.17.04.30.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 04:30:39 -0700 (PDT)
Date:   Mon, 17 Jun 2019 13:30:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 26/28] PCI: Add DT binding for "reset-gpios" property
Message-ID: <20190617113038.GK508@ulmo>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-27-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3D7yMlnunRPwJqC7"
Content-Disposition: inline
In-Reply-To: <20190516055307.25737-27-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--3D7yMlnunRPwJqC7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 11:23:05AM +0530, Manikanta Maddireddy wrote:
> Add DT binding for "reset-gpios" property which supports GPIO based PERST#
> signal.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V4: No change
>=20
> V3: Moved to common pci binding doc
>=20
> V2: Using standard "reset-gpio" property
>=20
>  Documentation/devicetree/bindings/pci/pci.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentatio=
n/devicetree/bindings/pci/pci.txt
> index c77981c5dd18..79124898aa5b 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -24,3 +24,6 @@ driver implementation may support the following propert=
ies:
>     unsupported link speed, for instance, trying to do training for
>     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
>     for gen2, and '1' for gen1. Any other values are invalid.
> +- reset-gpios:
> +   If present this property specifies PERST# GPIO. Host drivers can pars=
e the
> +   GPIO and apply fundamental reset to endpoints.

As mentioned in patch 27/28, maybe mention here that this is only a
workaround for bad board designs and that it shouldn't be necessary in
the majority of cases.

Thierry

--3D7yMlnunRPwJqC7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0Hed4ACgkQ3SOs138+
s6G9tw/+J+LMeHS55p4zNY4O9TsQ67a70Q0zY5+3zr9vtsRGlukvCDgLOn2x00r6
j8vTyJNxIwgZzQjE5tC/zt67Sp9fqi/5tVgMe+0sh9GWIvl0m/3SrdIfkLPNsBWQ
5leiPp92Hvipghscn1EavmWmizQHz9FaXsNnaYALAdW/SWp8fRwukUcuJ5kW+cam
110qZJL+LIqINrS6nHFlmCz5yIjIyQYq3z5rLuGDWl47jGW1cIRfM5KT++23w/vC
MzJxw6MLMTGlqa4CXRN4Gtmvx30ki1O30HVX6CshS1qlZ6/2skzrOWxI+glxV/kY
YK7bv+UV5a+cmwh5pcBi2RZImNRSJQUBzDITT/mERLYghBvIqIJ1FToKlGkCpdhe
CkSdC66puoUAAacbebioJBp8NDG4bDDLZq4NnUqk3X9yAuQ6iTrnMNSFaefmDKWw
0fAdX8U1vNWv5e5gaCXJVAMz53Rqbc6Tjvx1cxt4YEXCSkHbxgz+AdKa/hDJzRn7
dFJnkpPyTXYWtOrsOEgUTy9VLUhnDbKB7fK/vpAlfD+8S77zd3Te6HKqJUS/5Ylx
ldcdblTV9kja5xuweZF9MVIHEL0q/XDfDis7oTCUCr227XMSw39718HXnWRg/+Or
Qy+Tg00yZQ4dSfZ9uonRxWmMnfacpZb1mU4qwH8l2qvzKiGd2ik=
=S/ir
-----END PGP SIGNATURE-----

--3D7yMlnunRPwJqC7--
