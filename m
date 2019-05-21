Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15324CD9
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfEUKgf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 06:36:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40087 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEUKgf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 06:36:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id 15so2328404wmg.5;
        Tue, 21 May 2019 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s2IM3ZE8ODzpRagkoqqzQK54sUQjKZc2JHhz8V5RObU=;
        b=Z0XG4sSZF5JHXuLMcZ5YxjA9J4SuMnIYkei3Z6Y55JOS7YdFyWj75eMV/H3CoQ7S64
         f66Zbdubw6XtFPbgFxmbLdkd0AAdVEIM6F+pRugNUyLPLW8Mf3URbYZmOFBgBvwc7HMn
         H7YWii70vEzEdswFBrExT2mrItuRsYAJnhyIV5SV23vfi1SAn/YOJRcJxG8W8/YhgAJT
         krEWDPPN6VQHU8Nlw6QKlOPZ3wa8TTzbBgPtrJOl6SRi2hRc/mKBEQhDsU5RVf+BtulB
         ufWBW4woz44gjVh04+TGVKYhzic6cy9mlGsX2xgqHwgMpvUQhJHsm76ZmGyPpF3zjjI3
         LMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2IM3ZE8ODzpRagkoqqzQK54sUQjKZc2JHhz8V5RObU=;
        b=P6XPw/TYnKcEY9LU1Q/nu9qQMqv3sR1eTiIhrfZNmra43QehRwyxIGPNDFre2mrXHR
         jXdZod/NI4PsTtUbwaAA61/hIDWp6qynNLtplA/qPhl0veJnG7sFcXNy4MTL3EW6Mke7
         dfvoAiAL55w/ORpN0RlM6rBBmfvneuZgxibwFPv/qbdR0EAA4PB3rHf9gBFENFLNv6Q6
         ZHTMYVNn6qcnZkcI4r37f9O4VKx/EEcNNGJp0r3nHuukxPQl/+YWr4Xzyy1D2zt9YGUK
         S6QYL1NA6gxk+ygS6rKqnoQquuJsh7J1K1sRl+kGHzVPbUOmsJYchptqHheGwD4qhqLP
         t08Q==
X-Gm-Message-State: APjAAAWgi+W1ZjBGSWAs19UBKLLW5/UZAfzfUyYnhpcill9FXOKy21xR
        ejWWnmpB4iPcTXAvuu0NqnA=
X-Google-Smtp-Source: APXvYqxHktRf5rZ8QFK+DuWsj6B/g4usmi5nDqgeTDiJTvlktbKs/Ju/VpRX9wgMAQ587L+UC1/IfQ==
X-Received: by 2002:a1c:d14b:: with SMTP id i72mr2887854wmg.4.1558434991573;
        Tue, 21 May 2019 03:36:31 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id h11sm26592314wrr.44.2019.05.21.03.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:36:30 -0700 (PDT)
Date:   Tue, 21 May 2019 12:36:29 +0200
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
Subject: Re: [PATCH V7 05/15] PCI: dwc: Add ext config space capability
 search API
Message-ID: <20190521103629.GE29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-6-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-6-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:36PM +0530, Vidya Sagar wrote:
> Add extended configuration space capability search API using struct dw_pc=
ie *
> pointer
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes since [v6]:
> * None
>=20
> Changes since [v5]:
> * None
>=20
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * None
>=20
> Changes since [v1]:
> * This is a new patch in v2 series
>=20
>  drivers/pci/controller/dwc/pcie-designware.c | 41 ++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  2 files changed, 42 insertions(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 8f53ce63d17e..3b7d50888caa 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -54,6 +54,47 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
> =20
> +static int dw_pcie_find_next_ext_capability(struct dw_pcie *pci, int sta=
rt,
> +					    int cap)

Perhaps make this more consistent with the existing regular
configuration space capability search API? Something like this perhaps:

	static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci,
						    u16 start, u8 cap)

? I guess your variant above is consistent with the existing generic
capability search API, so another alternative might be to make the old
dw_pcie_find_capability() API consistent with everything else. It's
confusing if we keep having to jump between the two variants.

Thierry

> +{
> +	u32 header;
> +	int ttl;
> +	int pos =3D PCI_CFG_SPACE_SIZE;
> +
> +	/* minimum 8 bytes per capability */
> +	ttl =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> +
> +	if (start)
> +		pos =3D start;
> +
> +	header =3D dw_pcie_readl_dbi(pci, pos);
> +	/*
> +	 * If we have no capabilities, this is indicated by cap ID,
> +	 * cap version and next pointer all being 0.
> +	 */
> +	if (header =3D=3D 0)
> +		return 0;
> +
> +	while (ttl-- > 0) {
> +		if (PCI_EXT_CAP_ID(header) =3D=3D cap && pos !=3D start)
> +			return pos;
> +
> +		pos =3D PCI_EXT_CAP_NEXT(header);
> +		if (pos < PCI_CFG_SPACE_SIZE)
> +			break;
> +
> +		header =3D dw_pcie_readl_dbi(pci, pos);
> +	}
> +
> +	return 0;
> +}
> +
> +int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap)
> +{
> +	return dw_pcie_find_next_ext_capability(pci, 0, cap);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
> +
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>  {
>  	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 6cb978132469..fff284098117 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -252,6 +252,7 @@ struct dw_pcie {
>  		container_of((endpoint), struct dw_pcie, ep)
> =20
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> +int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap);
> =20
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> --=20
> 2.17.1
>=20

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj1K0ACgkQ3SOs138+
s6HTgQ//aJr7a1P9iSYJK5pv2YoM6D33S9R3ezA6+xgoGLr8Kc0/or1z4iDwNpfh
u08lYHkPxU8cIl5I9LFY8gxFvQu1ZVm3P9PDhMeyiR6TXnTa7FPJT28xY/bTQzyY
g/Y6rkKxoN5V+ZQ/bRyzlbZIRKbQJtEXEs8AE859u/B3EGiBw2aEYJ22/TZfrfhM
CIHyXaQGrTevCcBoKYp4B+qiYOH9sxLBdlDe1v6ZDhG4ulPpxpIT6fT8yuVxZhs+
1hOIjVM5N9m8jI8t4ZCiN1Qen1xK2M/saa1y5+JJt6pssb7xUa3YjX4ESGSH68GX
3/jcqOLAnRk+ZXrRwxRSrZtyCmuX1P+clOTrVV2QCYbf0VYHFD0kz3AD4IJcPjZ/
pouAXmXETl2PQQJs/My08Dc5ICYba5+/JYKvxJL9kPXDsMyuTAahoSXuomu/TKIU
Qy8VtWwAxo4oPlKQDxiRir2Qrh85R7Yg7uqDBZ9+WdQRW1z9Y5JuQFrryHClssfl
6Lehxkw0YH4ubcZ0h+qWHPBE8nhIOHNtSv6rvgKd/A0mF97DaCKiqRx29VU+ywgh
bdfDqEjzUa6wNykNB6Iz8QT8J29ayymgxBcU1cJy9UDrf1t/jX3nt/7R7G9Yst1h
exQop1nRDInzw2kEnw17lfJjj12b7izfI/J12l/j0bK4Ay9InDc=
=4jiK
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
