Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07CD12E631
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2020 13:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgABMi0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jan 2020 07:38:26 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6331 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgABMi0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jan 2020 07:38:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0de4320000>; Thu, 02 Jan 2020 04:38:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Jan 2020 04:38:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 Jan 2020 04:38:25 -0800
Received: from localhost (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jan
 2020 12:38:24 +0000
Date:   Thu, 2 Jan 2020 13:38:22 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Manikanta Maddireddy" <mmaddireddy@nvidia.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1] pci: tegra: fix afi_pex2_ctrl reg offset for tegra30
Message-ID: <20200102123822.GA1924669@ulmo>
References: <20191230005209.1546434-1-marcel@ziswiler.com>
MIME-Version: 1.0
In-Reply-To: <20191230005209.1546434-1-marcel@ziswiler.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577968690; bh=+gSZA+gTUQa3mHgLv41Z4ncluKFa/RYi+d8qcUwlke0=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=F62h7BtBAtksNCieWvQ/XnVY45rjnZZl0yl95zm7PY0a+aQTWDABa6CN+ijLRzGHP
         5FInZvAIFCb7NWZUNY2shN8VK5RuZ2nasiP1O5Al3CvMtHzNem2TcpuOsUF1moeQ/C
         Qmpq9uNbiZTGsvjaNxPaSDbirX5DMkXqofctzLGRPI/o7HsjtHoYIoGV9418G+Q4df
         XQTPMiWk7ZEllOr5BD6Imx2OInvJ6GXwWV98j8AB76Ilze6DWsQeJ8A13BN7n233e8
         z9ivb1Mz0EcA0WC2gTrQVTTheql70T1yBz8wGnp5fpvw4ivulSldUoQixOfE4xhx3r
         WMzbarmv0b+6g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 01:52:09AM +0100, Marcel Ziswiler wrote:
> Fix AFI_PEX2_CTRL reg offset for tegra30 by moving it from the tegra20
> SoC struct where it erroneously got added by commit adb2653b3d2e
> ("PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of SoC struct").
> This fixes the AFI_PEX2_CTRL reg offset being uninitialised
> subsequently failing to bring up the third PCIe port.
>=20
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
>=20
> ---
>=20
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Marcel,

the recipient list looks somewhat odd. Mailing lists typically go into
the Cc: line and subsystem maintainers into the To: line. That way you
increase chances of people's filters catching important emails.

You may also want to fix up the subject line to use the more standard
"PCI: tegra: " prefix. Also, maybe capitalize "fix" -> "Fix" to match
standard formatting rules for commit messages. In the subject and the
commit message, also, please spell "tegra20" and "tegra30" as "Tegra20"
and "Tegra30", which can help when searching logs.

With the above fixed, this looks good, so:

Acked-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 090b632965e2..ac93f5a0398e 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2499,7 +2499,6 @@ static const struct tegra_pcie_soc tegra20_pcie =3D=
 {
>  	.num_ports =3D 2,
>  	.ports =3D tegra20_pcie_ports,
>  	.msi_base_shift =3D 0,
> -	.afi_pex2_ctrl =3D 0x128,
>  	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA20,
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_DIV10,
>  	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
> @@ -2528,6 +2527,7 @@ static const struct tegra_pcie_soc tegra30_pcie =3D=
 {
>  	.num_ports =3D 3,
>  	.ports =3D tegra30_pcie_ports,
>  	.msi_base_shift =3D 8,
> +	.afi_pex2_ctrl =3D 0x128,
>  	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
>  	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
> --=20
> 2.24.1
>=20

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4N5DoACgkQ3SOs138+
s6GoXw//XWzpxQnZQRdUIVGFTrjlaiqkRclRzJOtoa+mYwAOKZT86xbgsJ+na3KU
rY2wuNZOzNfYYJDvKOloYZDMoTCsbO65uW8fXAoma7lc0JMWa0J5OnGEJKlbMQtd
xAEFOMwSqt2m+ym5RT59Jzm/hWh6W0aYaaaT3c6TGgDfq+wyQqiOfGOTrWrZ6rRR
EpCy7JMZ1p92nxDZDCsLUlTylc0ISJHGNy7rz7N7Xr4JNUwMMSvZ450cqQ5EwSf9
bXsMiZIiyoO4d2gG0bkSzfBnvJMRupLCd8MDuAC0P226IXR/9lMTfl0/+1YWOQl0
kv/osH1h+5vliuMAmlprPcERBedaNxruauTW2TJquMjvkAr4g2CJcXJzS14wOrG7
qifI22vEyYGcOHTVt9baP2idovjO3T1w3Ba3YaEjo64MrdZNFqRZoTZY6/wEU4PD
YocvvmP+GPjz6NLdG7DtCM9ZgGvG6iA9o6BNr85srvvJuf5DNb8u/myIywvqU/yr
LUVwl907q8kBRpbNGhrBkltBEILRCxoaB2Aes8nNYkDFWz84MQTU664+noC7F3rt
lD6mUfAuKDx98AR3vQSNnrxLtbAcnzWd3kHwXLSv9E4806g6+kfvdAZKsjZY7OY2
p70Eu3q/M/0RWstQLPm5OuLB8nco/PjGf7SDu/jSyKIuDdl4xGk=
=FH42
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
