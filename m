Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDED24CA2
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfEUK1e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 06:27:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45212 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUK1e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 06:27:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id b18so17902049wrq.12;
        Tue, 21 May 2019 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0u/cElypM0FGg3NqoZhyM4kF6/Suy0Ma6wulSB8WXxk=;
        b=D8LItHFK56peyyh2BjRqAE0QSAEGdSuOdY3ELK8p1Hhn5BM9FXVbU86E6K/HZsME4Q
         kHxex2HC0xFWg1SKMIR4tfPjBRgdVtKvZrgxhcFOegMcSlR6PXY1ltWAeq30PVJW+5pr
         JyGEHwl5V5uQgY8SL3EobnEVHoXBqeCE+qrDisHX2aNXlYhLWWBe2pFQ0Pdv+YfVLUa+
         DjCnkr7yZEpXOUcbGJ2XDk7rxsCR7+0WMQH4rHinDXNYEg7lkKw9htiyCO5h/M8RKIHU
         bzpH+S2sOLpNaDPHgHaMqdCRpquZokbZZ5HGDmMmeP4MNYNkdDvDntLPD1bS6T1SYkY0
         UtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0u/cElypM0FGg3NqoZhyM4kF6/Suy0Ma6wulSB8WXxk=;
        b=K+7ej3yHs+pI2QTaIDdwaG2hE3Rjk5eef5dv4Kc3WGglfFKk+vlmJjtf7GzGcU+Oy9
         Ep7AiMSDh2gaWyDlmVFeLZ8zOMm7bMs59MuIvMimUa7PtYaa9YAmB04I6UWlOt2SXTys
         cu2koDkztSyBS5JVaVcOP4TRrz/merRF8zLjv9vpviPub5va9V5yeVueuWhrqY6EOr64
         DgO1CZQtFroHEpRUZ0VpaW7qtc/ZhYlqhrusRQcVuih823vyPku1ZfKuIrAWD7yPo+2+
         hK4TKd1dpHyqSJuKlRZE9GVP99VGuTIOi2+4unFuq3zRcowk+wf5JpP9GpmZdDcMD5va
         nCXw==
X-Gm-Message-State: APjAAAV0mJM76Nng3mBv8OCP7zexnhyWlfcCmhGnHDQgflJLQRY30xaF
        zB2rnz12symFsFgta0iaQ+E=
X-Google-Smtp-Source: APXvYqzN0aFxhFPXBCSNKpdXBwYkCaswfe1f/2Sol7iXRMG9CaRzPkEF9jISqZ9I4geyOBywAICB0Q==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr34219199wrj.262.1558434451659;
        Tue, 21 May 2019 03:27:31 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id k8sm7135873wrp.74.2019.05.21.03.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:27:30 -0700 (PDT)
Date:   Tue, 21 May 2019 12:27:29 +0200
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
Subject: Re: [PATCH V7 02/15] PCI: Disable MSI for Tegra194 root port
Message-ID: <20190521102729.GB29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-3-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:33PM +0530, Vidya Sagar wrote:
> Tegra194 rootports don't generate MSI interrupts for PME events and hence
> MSI needs to be disabled for them to avoid root ports service drivers
> registering their respective ISRs with MSI interrupt.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v6]:
> * This is a new patch
>=20
>  drivers/pci/quirks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0f16acc323c6..28f9a0380df5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2592,6 +2592,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
>  			PCI_DEVICE_ID_NVIDIA_NVENET_15,
>  			nvenet_msi_disable);
> =20
> +/*
> + * Tegra194's PCIe root ports don't generate MSI interrupts for PME even=
ts
> + * instead legacy interrupts are generated. Hence, to avoid service driv=
ers
> + * registering their respective ISRs for MSIs, need to disable MSI inter=
rupts
> + * for root ports.
> + */
> +static void disable_tegra194_rp_msi(struct pci_dev *dev)
> +{
> +	dev->no_msi =3D 1;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad0, disable_tegra194_r=
p_msi);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad1, disable_tegra194_r=
p_msi);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad2, disable_tegra194_r=
p_msi);
> +

Later functions in this file seem to use a more consistent naming
pattern, according to which the name for this would become:

	pci_quirk_nvidia_tegra194_disable_rp_msi

Might be worth considering making this consistent.

This could also be moved to the DWC driver to restrict this to where it
is needed. In either case, this seems like a good solution, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj0pEACgkQ3SOs138+
s6GqcxAAjaEUM9FTNPbKl4kQsquEnKIrVyDWV9lxJqFh1YaQGK005Nk/f1oJcuOn
CEP8HrtYIpZk1wn1cUsT+ec9j7qxlu9ihEhKBXxsFOf6njXoBnc+QjscO28UJ4tu
HYHDpvEK98bDBRMJhaZuBEClqBuFAH5Zrp8909NaUgaka7ut6PZqQC6XymRa6aX8
5z8GSfR/FSNdUnhJ0gboYdliYQc+/co73YJUPVWKimKkRKnfD6OYNjR9+YfncIPU
cFkBWnqCFzLVg6NIIOXpcEftFstLcTSJeC4XZ4bVa442Wbnz2dsgqHJMBy2wuR1z
vwtnw+94Coa8E7Zsa5NCwTOiqyqhjsJGsS5IcI3OEbjh2aue7ScypriufK4Dyept
hITWFgp0ZX1UxT2/QCLHfue3qNgSdOTYtomYFATqyHPD3BrgDAG8XZKKSDUVty8h
PE7MLQfsgWWdqFn0SaHeiCGMlc/1n5JvBRzfO04dPNH62G80YoJ5/WqkZ15pTQFW
FCbfApM2DekXpRsJaQvkPuXOAJOsUhR//WSLEMJQWfTl2pfRq2HPwWbSAgriL++k
VnsA4LBL4dKx8eqQJO/6SGJHmeHEjEnugbm9vsxQmiajUFl3LdVt6PfGeaSMq9oy
ggLSXlC+pTaWmPnBKEKh5aLNtSCCz+lT2cKkLq24YbX3YnLaC4g=
=PTXE
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
