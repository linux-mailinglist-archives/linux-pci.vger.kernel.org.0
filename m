Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB01D24CB4
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfEUK3I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 06:29:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33563 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEUK3I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 06:29:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so1995093wme.0;
        Tue, 21 May 2019 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i0as0vN7D4i2ID/z1L3403i8uDeXi4TTz+AjZfb51fM=;
        b=SnrP67dbJsJ5V/2SMxKmpCWHPheHYf3g6WgtG7WT71f6kpPPXZwA+A5+5Nd3RsOrp1
         Eqxp6unRSFoqJaHdU7UsA7xY/OSljTB8gN8xFw/REQdXGIS7ymFcqUivgkHfsN4QNqJO
         sp+SqLTbkhWI+yVRiiFJndtjdQ31C1wGDR0MIC4DbWfNXu2G2bOsnM/Sy5SvZrLfBpsu
         wk4RIzfJWuGXf+PvLQCg7VaQf4LS111TUgf1Lmw8+2qQ8g/gu/Wmh1bQOCX8PxtOEvB8
         YDwZJGPBR6V6119l5vXPhRDj2rPbSFbwqUHfraY6r9x4hizhSFic9McgKdX9QdAs9xVe
         7wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i0as0vN7D4i2ID/z1L3403i8uDeXi4TTz+AjZfb51fM=;
        b=mv3GJjm3WsAfnQfjrPGFCY2y/ZTx+If5cMrbOWadndGnJ1xHXxApccTPr+9WL2rCaP
         6uxHcDpZ/s/eVN1Tl3JFtqmoVgqkAwiz6dvD7cGWPDIpMuASB4TVphJqyO1VE1d4256x
         BEuBDfd3izG6aQTJJkH2+ePBt1YA2TqvDqLyyYl6YM+w4s8wAg5fFgAnv5XJB0Ygmoam
         qrGhN+66c83aP0exYTkAOMJkDZgI8itr4/19W8eLN4sHU48LPzxpVFBRmeWt4MfKxX8H
         XfKiHMBHEr7lD9SpM5rsanpQrvZ1j2vOyrTxYy5rEJOcglVS1VyP/S9Q1vBfrcNk8y68
         zZ5Q==
X-Gm-Message-State: APjAAAUd5pi8ZxPhNReopFZwBK+nsms9z8iftEfhDgXxKAW2LEvKbgs/
        +lpyICMxqaDBUwuLSghUSy0=
X-Google-Smtp-Source: APXvYqzFY2W87G2XKblwh9OOAK6rHD5rjloo7s4t8aFeVEtSUWaJ/9tLang+7WHGIvY7iFcgQ7pUbQ==
X-Received: by 2002:a1c:c104:: with SMTP id r4mr2834393wmf.133.1558434545301;
        Tue, 21 May 2019 03:29:05 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id t6sm5239538wmt.34.2019.05.21.03.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:29:04 -0700 (PDT)
Date:   Tue, 21 May 2019 12:29:03 +0200
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
Subject: Re: [PATCH V7 03/15] PCI: dwc: Perform dbi regs write lock towards
 the end
Message-ID: <20190521102903.GC29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-4-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-4-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:34PM +0530, Vidya Sagar wrote:
> Remove multiple write enable and disable sequences of dbi registers as
> Tegra194 implements writes to BAR-0 register (offset: 0x10) controlled by
> DBI write-lock enable bit thereby not allowing any further writes to BAR-0
> register in config space to take place. Hence enabling write permission at
> the start of function and disabling the same only towards the end.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v6]:
> * None
>=20
> Changes since [v5]:
> * Moved write enable to the beginning of the API and write disable to the=
 end
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
> * None
>=20
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Looks good to me:

Reviewed-by: Thierry Reding <treding@nvidia.com>

Thierry

>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index f93252d0da5b..d3156446ff27 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -628,6 +628,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	u32 val, ctrl, num_ctrls;
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> =20
> +	/*
> +	 * Enable DBI read-only registers for writing/updating configuration.
> +	 * Write permission gets disabled towards the end of this function.
> +	 */
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
>  	dw_pcie_setup(pci);
> =20
>  	if (!pp->ops->msi_host_init) {
> @@ -650,12 +656,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
> =20
>  	/* Setup interrupt pins */
> -	dw_pcie_dbi_ro_wr_en(pci);
>  	val =3D dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
>  	val &=3D 0xffff00ff;
>  	val |=3D 0x00000100;
>  	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
> -	dw_pcie_dbi_ro_wr_dis(pci);
> =20
>  	/* Setup bus numbers */
>  	val =3D dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
> @@ -687,15 +691,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> =20
>  	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> =20
> -	/* Enable write permission for the DBI read-only register */
> -	dw_pcie_dbi_ro_wr_en(pci);
>  	/* Program correct class for RC */
>  	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> -	/* Better disable write permission right after the update */
> -	dw_pcie_dbi_ro_wr_dis(pci);
> =20
>  	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
>  	val |=3D PORT_LOGIC_SPEED_CHANGE;
>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> --=20
> 2.17.1
>=20

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj0u8ACgkQ3SOs138+
s6EJCxAAnfv9ugCWZBC133ybiQYMaRJDUdLgGhyHZVX1/ZdmY5GToImZM6vjRujM
WlozE5s76t1gP0g6h1EhQqKoayUTSpKsqYHN8/H6SqPOZNlJLxELi2ZeIj66fcAC
/CahfKX4LFBR1Nb8QESoVaKPz0luor5SfwJmZsxHJTbfI+kXgs/4CYfXuhI3mRRU
NHSNushq/sxYks4IXV9oaMq4G8VVcmzGilKTiU65mYaQLYmFUpvkYLnBZlsig7qT
wYx1X34PPcO1/hg+dy55Kb2+TPU+tiMbIWKhhD/7efmoTobK77eNe3kcvylMier5
h6rzvmY8Vg2yJUlz498PO/0Vt6KTDC09fbTIQCELwak64CEfdIaR1K+gUXAp2YaL
lgjJFZtMpwGd8/DiC3gaIaiJQaYEMYj0cVyE+zpvDYTrue7l4ohkQjoyE/VbFhv+
PkIvP49aEiu0cm6FOEn1o64d7rzuXHUAK14ePYB5zmaovQ+7dEnS8NTo7cxAB5TB
EqkeWiHLrC32T/q0S01MO07/+3uX4sRUByRUgCjxPcgI2pJQM28SzxoQDGiozdYC
DiQW/JxNkL8+VWvPaZxBW6ywShWqzfXk9j8XoNOs0GLoArxiokfBjpigxJpF//Fs
CxDzv0ERBk2rPlTXg3GitfuOjs7H1wdZzHjJmLwfaQx1oPPaHL4=
=ZY4e
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
