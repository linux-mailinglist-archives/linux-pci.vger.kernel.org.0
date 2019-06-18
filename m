Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665BD49E9B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 12:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfFRKvM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 06:51:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33429 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfFRKvM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 06:51:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so13458705wru.0;
        Tue, 18 Jun 2019 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0L/YJOCqKTNjOy3j+yONHu2Sd1slD94QcBd0x/bwi9w=;
        b=imCaRx5tVV1jvVcij15BUfdyua6BYkQZ1T0SZyYQuUzQYyVufF1RcCTwyLvhKnmImj
         LIW1XXbrzxkB3W9rl0wX1wTDkpora3rRhsUJmreqr5eUWMOXL+EyemRIGLrkDXLXNw+R
         i+ZnyMJi/fWyxxQjk+3IRjV41shkqupKTicX2HQnrVf+NTGqQmPOJE+vfhZG95aEnGch
         ONnsWkuC2x7b0GyZzrVGgHcSxRpP7UZjeDTGZvC81iBiI1WHLM/c3bF4LlBz+W5H9eiG
         tUAfnHsfDjsjpEQI4wg2cu+sTByl3ovLcTK8ZvnHi2VJZPzkzm/Wok5xz4PnBNqskVIj
         bA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0L/YJOCqKTNjOy3j+yONHu2Sd1slD94QcBd0x/bwi9w=;
        b=Ysh65x6wpvb9RlOj7lnH7EJ47aXtjgzw7aypmDkhu/9nmOFW6u0Pz5bmtyDUVa2PUJ
         AoSE6Dj1YYdvEpRhIEDWH/QfLW1sOwADKogZOsdOZo1wpBacIj/xPOUwzEjluEZ2U/A6
         ytZkAvKkt/lL2NfS1pRvFfIIUEcHBv1jcOq3lMXCQ25YSq6OLbLLIfR7DTB1NWpnPk5S
         cs5PcOfLFnAgC4mJjI2r1HRGDUShneOwMfrpO+oXfpLzyAzy+SCEpewMgbNYN3MDDC5n
         t1Vrz/Zkh3LTX9EkAVIIxKj1s2KtN4e4Mmmjnk0mtbL8ZRtXCecJgVlSjrdpkUN6aT8l
         h8mw==
X-Gm-Message-State: APjAAAXb5fNB1HPXflEFJFIis0X5bK18YVNF4ENUipU0UDhE1OKPMudH
        mpr4qE33+jks/Mi9HHk2gJ0=
X-Google-Smtp-Source: APXvYqzecsMceZupbxhk55Bnmp/fJ3V6IooAyGrRG/hXVs0ksCoetm2Fhug+oKKQthgDFoopirOkiw==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr68682576wrw.138.1560855069697;
        Tue, 18 Jun 2019 03:51:09 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id s8sm19722556wra.55.2019.06.18.03.51.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 03:51:08 -0700 (PDT)
Date:   Tue, 18 Jun 2019 12:51:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 26/27] PCI: tegra: Add support for GPIO based PERST#
Message-ID: <20190618105107.GB28892@ulmo>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
 <20190617173952.29363-27-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20190617173952.29363-27-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 11:09:51PM +0530, Manikanta Maddireddy wrote:
> Tegra PCIe has fixed per port SFIO line to signal PERST#, which can be
> controlled by AFI port register. However, if a platform routes a different
> GPIO to the PCIe slot, then port register cannot control it. Add support
> for GPIO based PERST# signal for such platforms. GPIO number comes from p=
er
> port PCIe device tree node. PCIe driver probe doesn't fail if per port
> "reset-gpios" property is not populated, make sure that DT property is not
> missed for such platforms.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V5:
> * Updated reset gpio toggle logic to reflect active low usage
> * Replaced kasprintf() with devm_kasprintf()
> * Updated commit message with more information.
>=20
> V4: Using devm_gpiod_get_from_of_node() to get reset-gpios
>=20
> V3: Using helper function to get reset-gpios
>=20
> V2: Using standard "reset-gpio" property
>=20
>  drivers/pci/controller/pci-tegra.c | 45 ++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0IwhsACgkQ3SOs138+
s6GcGw/+Pi6zDjLmsQQqPGMkvQfxr5DbOJxPtZ0K4fWTvoUmoCrw2KAigmmfKupP
vxeKJWlwhTsfe80GMyNaGrCld5QXDb3UuZ1RRd9i24FOymTALu9I3MdFyYBXAuqv
4+xQFl2N/q4/aoBiSgYe2tGAoXYQc0gHDqqKKmCeZfx3/srE0H27fvzH8XUNC1ku
1ZjhYQcNW7y1w1CpRBVjVpxBDweQJ50suyk4kIMMgxXpmYzbB7qWh1lghDaSIMqg
UFKWmjr88p3otYMBDMxxu0U+gYniYApM7+pH4KfV2uf+H8rksF9P9a64IyRsYOL0
9VAM608wGdxvpoZo0PXFbrzz/ABnEBjFd9qX55493zxF0yEwwSWtl4ARFdSggjn+
gBlh6TqFxYvdWU30R4fT1QjHRXTCZEZNeznyXJReRfO/4XKK4VAvJpmlKJTcN5QI
eAmJwnBae9mjZM9VxRGWt171dlkk0FGNcO6xgci51/C8B9LyYzgwtHbB8DBFijCL
hhSc/0WbzPxy+l8T/blPDxeinGxLh8VIY/kzwClySuqOqWt4OJEhlrOdEB9X3KKe
27CT9HK/2PgTyeNOpkSStZl3vr6jgcYhYzDR4lG+NtZGA1oTfmaB2R4HEITA+zzC
tjFIsRf93HLWj5YZNH+NnawThLejWhF3/4Rw5UYBZP+VXYkju+I=
=l/xN
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
