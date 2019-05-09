Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A0618BF8
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfEIOis (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:38:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53140 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIOis (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:38:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id g26so1669364wmh.2;
        Thu, 09 May 2019 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m4fgq+LFH8COx/RVqdvaf/++0F11ap24aKygbbJdzsY=;
        b=IVq7sj6qNKKNZJnsBADX02ZoOsCu2UokncYE5l72lAgWNl+OaFAv7l03YfQ5g6eaVP
         pAGl6sumO1L8RN4fTVsvdE6zOvP5PW8MWE4uRog2bZLzlnjIVmeVy/7v5fB+HGultqS7
         SeZywf61+UscuY56eQR/Ii6T9z/eMrkxb4R7wdPdxGDHsGn9An8I+Qt/WT4tLs/LQ0sw
         6keDZJQxxmHh4sSS+Ecwsffe/Sz2RgUvHy9nw0TL2WMcqD6eeX6oNV3kpEiCqtLghiw1
         IL0t9SGOXKhDnKhq9Jjth0rp9HiS6X2JEJjhuDV46PiKD+t7FLxO/VhvJEa0DXQPJT4E
         s3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m4fgq+LFH8COx/RVqdvaf/++0F11ap24aKygbbJdzsY=;
        b=Gs+uAd9cNXFoPf9kZYdWCa/OW2N225TTvngbSBfYET15Ezraxj+KPqg92dIBFbnJ70
         x8PgcuiRECNfaExxs1deLtgbV1i7E0hVYgleKiijQ4mHCMAiSw7LPwfz9/bX+Kf3TGLr
         OnmtOEJSNzIygDqbGuGRcz1E6svCNgdX7Al3psnJFmNgfZ5M3nK4VCGIYbLlU4BfoWO2
         52eWzVMlt7decL4rI1eKHKkxAzWlhnR/xkAAz1F7AZOnYnEqWxHOARVMUFjXLBkXLkjI
         NQkQ2o1AwRhbmKgDcMmq8f9cDQm4y2dZHj5RZ4ON8yhS55YS4qUCmvCbxU1LAo2pzKw2
         0AfQ==
X-Gm-Message-State: APjAAAUXuY+CchVRXYeI6oEk/FQARrA73t3c9TEFYzeVs2/Kj5SkXLIa
        r+Qdw8xBn+6b2SoE6nVr3vo=
X-Google-Smtp-Source: APXvYqzlS62YDqXiJ1FwLRrXkUUOGSsZMKto6TwWzIVpUC3rwdCnjprJ6inuw6RTkIaCBl5saqGgVw==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr3366253wmc.1.1557412725793;
        Thu, 09 May 2019 07:38:45 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y7sm7532201wrg.45.2019.05.09.07.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:38:44 -0700 (PDT)
Date:   Thu, 9 May 2019 16:38:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 24/28] arm64: tegra: Add PEX DPD states as pinctrl
 properties
Message-ID: <20190509143843.GW8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-25-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j2Klb18PAKd8hQ5U"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-25-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--j2Klb18PAKd8hQ5U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:21PM +0530, Manikanta Maddireddy wrote:
> Add PEX deep power down states as pinctrl properties to set in PCIe drive=
r.
> In Tegra210, BIAS pads are not in power down mode when clamps are applied.
> To set the pads in DPD, pass the PEX DPD states as pinctrl properties to
> PCIe driver.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Using standard pinctrl names, default and idle
>=20
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

I'll pick this up into the Tegra tree once the rest of the set has been
merged.

Thierry

--j2Klb18PAKd8hQ5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUO3MACgkQ3SOs138+
s6EqPg/9Hf1Lj2EaSE+1o808c0caXI47Ve9zySckGhNFOIJ+dmvrAs0CI0ZXWXuV
F03ZGRR9OqCx9rh8LXzPraHx2iPHR9sG5vsbCRTpddiH6ye9nQ0E+bvwapADwHNF
7pu1VD5F8tXXjd6FAblVKd2kBhej0e0pZySh4nNKjRe/kiyOisVOSDWV2qFc5xEI
KlFUcdDIe6lDIxfvVVobdcqxb4jA6ln4Coghefv9WiwvrTtQsFkTQoRIa2fIvffC
DgD2GxxkLC0P87iIbIhl3NPNgKavAQ12kEh5bD8wVuoDH1qCgTXMQYNyUZ4SOcwN
c+7jIVI2SiKlt5A55aBpz0Zn+jPNDH3pX2D3cjFigNM4OJwpam2Qd1said6C8CWu
mr4vcUv1kRwo4BmqtDoSs7cI42EaXclJBqG8LKHaSVUcMGYH4jIVzfpOrhgECcYL
xe18d2tWUv+OTJxLf1LXZFfu1sTx6fkltqODIsEsw2PPdYglXyZhqx/0yAbLSqAN
eIvlsI9gZY5jH5zq84BWaQTcsRhYKx+qwTyQqnigfEjnA9yVhLTdKxjODNjycImk
paqk29gGDtohGN8o9RfBTWbhq04UFSAyVeBYDtqMeMkTBIz9mezAtNoR4v33WHwf
Go5Nsipm6Wg/liA4+vB1lNti8GU7eVJItmJhxFxe+8QfZXmd6lQ=
=LNbR
-----END PGP SIGNATURE-----

--j2Klb18PAKd8hQ5U--
