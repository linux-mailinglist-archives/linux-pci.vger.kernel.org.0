Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1470D979C1
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 14:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfHUMnn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 08:43:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40646 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfHUMnn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 08:43:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id c5so1791744wmb.5;
        Wed, 21 Aug 2019 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lRUmeZkZP/Okav86pMnI5msjxJq756sD1Md11UkW10Q=;
        b=M/U8Rn5H/vzvj9u02bNKbrAwSEgzepOgy7KpgvdjpIn7rtTnns5etUIDKaLzODa3XO
         H3mTzzhS/AQPXnyn8m3yVyqM6SXnA6PJjqEoQl205pufGlZA9cOvfe1jWTawuVdDkVzg
         HNPk4oL3Uw55LAUdH28PhpvTp1cBrpsoz+bGi2+9DPdUoX0TeuUgAVgtZAqj3NxBOF0X
         SnZNo90gytM83lNdnoVHFs/cyqSJI/tcsnfmNiMXvG132HuBReJ34N/TUubgj6JPthA3
         HlN04lsscJSM62VO0+YEeZDfC+AvS0JDGWBxQnizEbxwARgChSCpDuyc9Qy1qIlvXmzI
         fx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lRUmeZkZP/Okav86pMnI5msjxJq756sD1Md11UkW10Q=;
        b=YzJ/4U+V2AV2KJ8/fWkvoTq4D0aGQbbfyFnk4/OI6e5wx96fSw0Ah5iwrVzl+6mee6
         DbK7Y28CxBt31vzicUYA0M0fUpc5Z62NpYfVQL714dBXmalpgc0OESXYP0SoVPqOD4YL
         4eqqZ/8dOHAagHQeGzW0eSdMRR/YMQBHt2WRsJGwjXtZzsR9IBll6iWJR9brFPXSmGwP
         qQhYabwGQT061aBpSbHpVBlsbOBTNo/JeEwA7J9mc4HQOGCstoZmW2opQi+xfDsr5mEb
         yY8natNWjBSqHAnpMW7RVzyQyPVrrpvkCviIPcuStG6br9JVrlUrOka3K1dhK5Qu5Sxn
         0g/A==
X-Gm-Message-State: APjAAAXC8xd/MOVGJnRqQ7hpEbwO3MaLrnSzVKhaWx3Odm9rUmUkoe4q
        EYSVFgLMJUC5afKxktAHIvs=
X-Google-Smtp-Source: APXvYqwaq1Yy4wokzmvl6Eg9zpUcD3xgJLsczGSFflfUptDZe2PuC0S6zpYoPCC69O2e8WFtVnwZSQ==
X-Received: by 2002:a1c:1a56:: with SMTP id a83mr5974279wma.44.1566391420467;
        Wed, 21 Aug 2019 05:43:40 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id g7sm4842135wme.17.2019.08.21.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 05:43:39 -0700 (PDT)
Date:   Wed, 21 Aug 2019 14:43:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: tegra: tegra194: fix phy_count less than zero
 check
Message-ID: <20190821124337.GB21839@ulmo>
References: <20190821120123.14223-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <20190821120123.14223-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2019 at 01:01:23PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The check for pcie->phy_count < 0 is always false because phy_count
> is an unsigned int and can never be less than zero. Fix this by
> assigning ret to the return from of_property_count_strings and
> checking if this is less than zero instead.
>=20
> Addresses-Coverity: ("Dead code")
> Fixes: 6404441c8e13 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Good catch!

Acked-by: Thierry Reding <treding@nvidia.com>

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1dPHIACgkQ3SOs138+
s6Ho9xAAwUKuZi8iVfSdVTIm8t3Z0hjhCUBry2XL8mKbnYiq3Bb7U6+PwonQ34xY
EEY29C7cEjDhFWugnN1kS5unXAYdPZRu1VC6E89/rBkFOLogQcBBl4X1b/ziGEkC
zq3J5xkmakn/8O2vxvvEFFkYmXYdBZaEIG8kIg/by6ONb5wwIv/jzdIuhDhAAVSl
SikW0Gz2uDXiNev7cNnEFOgbGeAix9Y6w4nfAELuYn4kRLKul11avGyRf/t02FwB
vkyW5D3iyGTe5eJ9dANXIDVxUZhk8dy04X+rbs4q6Y+O3IYOE6dJ9K/8U9v2a6WM
U0uBDfrwsuDwOEyviarkQhaTin+51wbdx9dv7cgIaELb66pm6wq08IYKORPBe2J/
YAQxxlzjwlcLUZ2eHv1XH4Ra5mxdK3wWwO31WHB9/gIMsQgRhVF8aywjewYesJje
6AQcE7WvPcw3quTEiln1muXbJRDJY0zxBGDMdhB90x0n/60afHPwSNvlIzTJtQ6u
jHbKgfw1/ay4A9TY3O8KW8AdVWZLP/5qKQF4uvjapwNRWBHKwHQ7DFJGD/aUTWrz
EZL06MO809iUSFjS63LJo+oLhWs+g7gvzH4NSZchHJsuT86rS8qUQH8P9z2dLYlO
/PmMNaOcASfxYT2vMskY9xKO6Dq7PV7SFNe2DKRQpsRQj4swqN8=
=JGRC
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
