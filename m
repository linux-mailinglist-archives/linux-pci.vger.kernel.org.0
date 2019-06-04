Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B318347CE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfFDNOm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:14:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40868 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfFDNOm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:14:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id u16so9447504wmc.5;
        Tue, 04 Jun 2019 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pM0+ZOxK21I9kyFb64a16kuCVY86e3jD2J+CvCmtyzE=;
        b=Fh5emEx3sNSF7oaywOSEsw0FslUghebvXgQwprje4AGLRzDvqJS1CvHexP6ayX5nxj
         y0T/zumGCPwLFxZ6gObZBRypRwMdjfWLz4Tocih2OmLXNuVBPWcO7Ynfw33vv2UVUp1C
         Zp+qkUGlFgwy6jRklCNrD8eCmO9r9QssAfFIUJUs0IkG89bWWAoDd/kzJSh78vWWJJrY
         JHVMKeqldq2cQePXa3roaRcH+DqBopXBPISPhI+Ftuy1/9xGGG630MvBZfcBgb5N862h
         9gpZhE4N2ws/XPyapdWP5uwPLlrCYbKq7w6v0rBJRf6wekFgBBsJtSh1yP/UynDfAimJ
         p0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pM0+ZOxK21I9kyFb64a16kuCVY86e3jD2J+CvCmtyzE=;
        b=gsyVCcShMTUSXAQucht+w49zBm9B1zEGj2ST2J6INH/0iAEpf6n9W3J/Y7Qrq+G0ca
         F2r0JPiXaZSJeWm7IRiIuEvpjqYnnx1KN3ftUGPPOEiviBolT/QwPLCRBtAVBFKPuOz1
         CinIJXYD9ZlCSTqhKKXSBjtZuC3q69G57LxKbUMFVLVIe16OhhRA9+0r0nMEfIGH7pVK
         Qn6cKbmoWmW+91q8qDnkmPv+6qZnVzD5HJRNfI3OJ8mb3Y77QHjikcjifIJHWwPoMMun
         GykYg+8SZq+yjMQwApoo8sFujZ+5LoJVqHijY13i8ZfO2HSxzla1jIrJtLpvD+JYTi4U
         7C0A==
X-Gm-Message-State: APjAAAWaD1PU5eLnJKg2wv5DN3OhdSs7nNEpssRhfu7uQRKpCCVUI/H9
        K+y+uqg4Kbdm3h3tgpzjNlo=
X-Google-Smtp-Source: APXvYqzFzzksBFnt4ZoMZt1SnJdXD9GN/IamZ//QfDA3hsPtR1vBhQQEE5R4d4cBxTLnImvbWowu+A==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr4439190wmc.89.1559654078797;
        Tue, 04 Jun 2019 06:14:38 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id l15sm16003757wrb.42.2019.06.04.06.14.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 06:14:37 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:14:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if PCIe
 link is up
Message-ID: <20190604131436.GS16519@ulmo>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-23-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8DtChEGCcMdSgkU2"
Content-Disposition: inline
In-Reply-To: <20190516055307.25737-23-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--8DtChEGCcMdSgkU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 11:23:01AM +0530, Manikanta Maddireddy wrote:
> Few endpoints like Wi-Fi supports power on/off and to leverage that
> root port must support hot-plug and hot-unplug. Tegra PCIe doesn't
> support hot-plug and hot-unplug, however it supports endpoint power
> on/off feature as follows,
>  - Power off sequence:
>    - Transition of PCIe link to L2
>    - Power off endpoint
>    - Leave root port in power up state with the link in L2
>  - Power on sequence:
>    - Power on endpoint
>    - Apply hot reset to get PCIe link up
>=20
> PCIe client driver stops accessing PCIe endpoint config and BAR registers
> after endpoint is powered off. However, software applications like x11
> server or lspci can access endpoint config registers in which case
> host controller raises "response decoding" errors. To avoid this scenario,
> add PCIe link up check in config read and write callback functions before
> accessing endpoint config registers.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V4: No change
>=20
> V3: Update the commit log with explanation for the need of this patch
>=20
> V2: Change tegra_pcie_link_status() to tegra_pcie_link_up()
>=20
>  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

This still doesn't look right to me conceptually. If somebody wants to
access the PCI devices after the kernel has powered them off, why can't
we just power the devices back on so that we allow userspace to properly
access the devices?

Or if that's not what we want, shouldn't we add something to the core
PCI infrastructure to let us deal with this? It seems like this is some
general problem that would apply to every PCI device and host bridge
driver. Having each driver implement this logic separately doesn't seem
like a good idea to me.

Thierry

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index d20c88a79e00..33f4dfab9e35 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -428,6 +428,14 @@ static inline u32 pads_readl(struct tegra_pcie *pcie=
, unsigned long offset)
>  	return readl(pcie->pads + offset);
>  }
> =20
> +static bool tegra_pcie_link_up(struct tegra_pcie_port *port)
> +{
> +	u32 value;
> +
> +	value =3D readl(port->base + RP_LINK_CONTROL_STATUS);
> +	return !!(value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE);
> +}
> +
>  /*
>   * The configuration space mapping on Tegra is somewhat similar to the E=
CAM
>   * defined by PCIe. However it deviates a bit in how the 4 bits for exte=
nded
> @@ -493,20 +501,50 @@ static void __iomem *tegra_pcie_map_bus(struct pci_=
bus *bus,
>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int devf=
n,
>  				  int where, int size, u32 *value)
>  {
> +	struct tegra_pcie *pcie =3D bus->sysdata;
> +	struct pci_dev *bridge;
> +	struct tegra_pcie_port *port;
> +
>  	if (bus->number =3D=3D 0)
>  		return pci_generic_config_read32(bus, devfn, where, size,
>  						 value);
> =20
> +	bridge =3D pcie_find_root_port(bus->self);
> +
> +	list_for_each_entry(port, &pcie->ports, list)
> +		if (port->index + 1 =3D=3D PCI_SLOT(bridge->devfn))
> +			break;
> +
> +	/* If there is no link, then there is no device */
> +	if (!tegra_pcie_link_up(port)) {
> +		*value =3D 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
>  	return pci_generic_config_read(bus, devfn, where, size, value);
>  }
> =20
>  static int tegra_pcie_config_write(struct pci_bus *bus, unsigned int dev=
fn,
>  				   int where, int size, u32 value)
>  {
> +	struct tegra_pcie *pcie =3D bus->sysdata;
> +	struct tegra_pcie_port *port;
> +	struct pci_dev *bridge;
> +
>  	if (bus->number =3D=3D 0)
>  		return pci_generic_config_write32(bus, devfn, where, size,
>  						  value);
> =20
> +	bridge =3D pcie_find_root_port(bus->self);
> +
> +	list_for_each_entry(port, &pcie->ports, list)
> +		if (port->index + 1 =3D=3D PCI_SLOT(bridge->devfn))
> +			break;
> +
> +	/* If there is no link, then there is no device */
> +	if (!tegra_pcie_link_up(port))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
>  	return pci_generic_config_write(bus, devfn, where, size, value);
>  }
> =20
> --=20
> 2.17.1
>=20

--8DtChEGCcMdSgkU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2brwACgkQ3SOs138+
s6G6Iw/+IQz1vYysRtpqgy+xN2cWGTm9Dlq/iEFagrSuC3ryrIF5GQnXTZxfEsG/
vlr3VtKlbofo9fsEIpt7rtYtPvtTNX5ueHOE3rlKipcIUxKfc68U77rR6G3xZ9VA
Qol0AQMYEs/E6SKS4i9ashv+wVRMLzv5hT4ScC3dLPjoycQru3qs0OU6WvOpf5Ag
aMF/XmcNJojmJ8WP1byEG9fXoC4OChJDjM3o4r8kbW0x/cIhbcry9P7HB/pvKMDA
7nd3XhVfjlcG246ftmvskHfrvRwA7LFykUfkCQDJlTVQVnsXFfieLtp41zDA+YY2
6hZ+2WWEGf4HBGJo1urQF/yFe3qErAEDjTVRhrgkKG6kdCSmYYqvN17i53EZSbhi
H0O2r4qTeKiExRve/AKywiYYJbn0VM0inSxk96CY9ZynIygUJ1p+cVs++5IKcczv
51nNXhabNh6644X7tnoz2vmDd/fA8njdwakV2NxGbENpKpgP7bT1UuAokdJzXccF
BqMejvYtinFNbpi/WGWz082XauSgeXA0iWD8wqMXthnvfn0U0bgxFYNgB1jAIB0w
HWo6o25/aELWBHLiSDE9SdhDN8Emgd7/v11vJ+EErcXG6jATbkrty02Sm/NCTDeM
z8itU1p9+FyWpwgRYKogoyIdRBrZgwJos2HP888DANLMsvgVGTQ=
=DFTR
-----END PGP SIGNATURE-----

--8DtChEGCcMdSgkU2--
