Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 244601312A3
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 14:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAFNOV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 08:14:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56265 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgAFNOV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 08:14:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so14898830wmj.5;
        Mon, 06 Jan 2020 05:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LrWoGYPQhmVuVZJ2chuTv8wabYF1cEdpWPnR/3AObmI=;
        b=Tor+9VLbD7Zc0d9dWTQ0qbqi2gIK9SgGkqe6Px5lL21j9bsRAy4aai5nJAi0j4r9g9
         wpYhaVOZc6YfHSwHCk/Z0G62gebtmK3ONeAvqNVFuAtZFuL6urTbCd43yMF2jD0y3Hcq
         F3/0Ysb8OfXt5KCdVi5aTAzN8g6MkrQ1Dq43XhiOHE9vhora4MjjcqS5hutXVTzDnLUm
         l6dsW8sqYjGIi3B1nM59QyeUY1UPo4TYMkKAbnrGsa8yWYrtWaC/1yYERtl9i5gCk8tX
         ZjgAdNwQ3cZV4ivBs6lzf8W/O/NiUEsusmmpoWSWiJTtVJop3LNc8q415YJkw9/bD9YF
         26SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LrWoGYPQhmVuVZJ2chuTv8wabYF1cEdpWPnR/3AObmI=;
        b=qTPtss7oLqaxOC7DGUmaszTy3CnjvjcWab1he6IDyruXHo8R6+GRvcCcGpAoNPCvPv
         1eWVIiWPIBiFZAsNPGzs4Ta3zUWKrTN/Khtkp3UPdyFd1OYil0xGe60p8PJimMU/3iG/
         qokRWNht6TpL6yPdGZVFUDfAjBrbKcvyO9V+Q7UR/ZPjNyOm5r2BO5X0djMc2Cytw8tR
         1Z+SQiUPVb9WNAavAEcbKk9BH3vCuzQ0K//XEyU6VxrxmH2symJtVDPRs3UW0z5Uc4J8
         XcgLBDGeRWc3u0t9hMYGJk3uh03I7z1Y0gZUXBJ663FwnAx4myu9VszcmMNYMDB+26Q9
         UTbg==
X-Gm-Message-State: APjAAAUplyfk8B0wt++79EP6NlKAj66UDaxPrFgpoZaajKNl2LuSI0nZ
        T0s8x8Ey1VpVPJFI/WYHivo=
X-Google-Smtp-Source: APXvYqxNvAqB5fDsO76GWUOtJXB7v4lpojthI3YAMdCJtc4OE+SxwUanVxHbhH7I6AagyWwIAy6qGQ==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr36486858wmb.42.1578316458683;
        Mon, 06 Jan 2020 05:14:18 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id v62sm22970179wmg.3.2020.01.06.05.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 05:14:17 -0800 (PST)
Date:   Mon, 6 Jan 2020 14:14:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 3/5] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
Message-ID: <20200106131416.GD1955714@ulmo>
References: <20200103124404.20662-1-vidyas@nvidia.com>
 <20200103124404.20662-4-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <20200103124404.20662-4-vidyas@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 03, 2020 at 06:14:02PM +0530, Vidya Sagar wrote:
> Add support for the endpoint mode of Synopsys DesignWare core based
> dual mode PCIe controllers present in Tegra194 SoC.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Addressed Bjorn's review comments
> * Made changes as part of addressing review comments for other patches
>=20
>  drivers/pci/controller/dwc/Kconfig         |  30 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c | 782 ++++++++++++++++++++-
>  2 files changed, 796 insertions(+), 16 deletions(-)
>=20
[...]
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index cbe95f0ea0ca..6621ac79efee 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
[...]
> @@ -1427,8 +1620,553 @@ static int tegra_pcie_config_rp(struct tegra_pcie=
_dw *pcie)
[...]
> +static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
> +				struct platform_device *pdev)
> +{
[...]
> +	ret =3D devm_request_irq(dev, pcie->pex_rst_irq,
> +			       tegra_pcie_ep_pex_rst_irq,
> +			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +			       name, (void *)pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to request IRQ for PERST: %d\n", ret);
> +		return ret;
> +	}
> +	disable_irq(pcie->pex_rst_irq);

I just came across this while reviewing another patch: it looks like a
better way to handle "disabled by default" interrupts is to do this:

	irq_set_status_flags(rtc->irq, IRQ_NOAUTOEN);

before calling devm_request_irq(). See here for an example:

	http://patchwork.ozlabs.org/patch/1217944/

Thierry

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4TMqgACgkQ3SOs138+
s6GNwg//eoYbBqRW7zBR5KGrZcKbRD3VPCZru7iK4ARTdjfc4up0xfWPooDjX0ns
a/jL8FztSb++YHsLIWsH3B4/IguatB0jQrajT6Dduco7gPifJuJz6S2IyTufgba7
FzAgJQX4sFkqa7fIpZhJASjSpyMg9907eSXM/FEKqjcmE8w3/xHKrpFV/uGWDOC0
9r2fAX7432kmmKaiIPWlMLo/CjSvuaOb1GHHkxBZmh+pV7zvCfyw3o8h3+6sdyJB
MSGuG17DCT9/MgBfSEQCO4ZqKbB8LcnsIgOyDsEp9h6iKPjdLvOV5aiGbn5I7Ett
SdOsISrYFgcl6jVIhz+osfOmadoBWpJAYvRMVJH1BKQ0RqKRXtMk6lC95k96WdNm
iw1tUajyBQzSdPN02Uu+IamwacrYv1VP/35HHF5E0qWpE/HcUOAVp0ASPaG9WlI5
OlIBc6Ysh7G4de/bberj5eZ012GtEVdE+uetC+G4Mx3BDhhIjHNOYFGGbkQb5dRB
yQTA792ZrYow2jYkz9WbnB5MXtYrZDAwA0J1lSSsNqUfq16X1jq31mmCmS7jlOS2
HZr3LkEaKLcqqWQXMke1MA4xLB0RcOJd2jFFPUYztBZKRbZ+/sFnquP1qk5rtAnt
jUgJNeQ15mLQE2GwhmUQbUSLI3PCVr6FBfWY8XsndLkfAZU4jWw=
=JFHB
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
