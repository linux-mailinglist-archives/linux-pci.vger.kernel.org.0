Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9011B1D3E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 06:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgDUEI3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 00:08:29 -0400
Received: from mail-eopbgr1400100.outbound.protection.outlook.com ([40.107.140.100]:6217
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbgDUEI2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Apr 2020 00:08:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJwFGPastrR2JWBPGup4NrfeaMVD9ova2NtX5jQqcQhYV6toPbe8YCjRl+Eb0gZ7cCQAsF/HI6StRL9brzfwy+XqJ2tT6dTUReBC1q83KHEHOHbIfvz5khkbYOd6FdW3ejeqR46eFdkCYYlW3xfp3GDUzxskKaahCw381D3149TTdtGXgW1a3I3VQIj51ld84diVK3CnKy80ieRfLujWduhc43zgUcTvjcCSSKekVxt5v2G1xSZ/Eh7WFqoxM7P4z2hR8B37gh/vqXaMusH8TsicKODZKoQ+1zdRZLgfnY3VlDz/j14/lAJGNDILSfxdGDcpW/jH6cL8azqfUSsAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN4cOInVuNmRfQwylAIhOs+9y0SJ0ZJIA+yvdwlKHbU=;
 b=JLGkB/o3dVJTiyPFtuy/Dx838qpQvmrqUNWSPSOO0i22rkYP1hkxd9uzROBEUIJ0ep5IimuKP3ajcRzCMag3lqnaQ25BpFSRKUwC0/mLkRhPPbyy2FLs+c2Kn5P7W3bP66omw9RLxwENFiWHwhrAa04pY9+GSnvaaea8lR9fmb7CJdW3ObbIWrX+yKdXcdCiDhiUTWA4WYV40YNsNf7HkoXYHMPPD1vK6HVcbkeWVEZAb5cp0gsD/rFchVPqameJR28UwCDAAB9RKNDsNz2vguazZPsVfpVAI32Mi+sLoDuYjQMNxsZbzk4OgKqMLSxn91ecKDaBHWpwEqiMBhHAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN4cOInVuNmRfQwylAIhOs+9y0SJ0ZJIA+yvdwlKHbU=;
 b=Nf+li6LFpmwyGcb7Y6yLrtKICU1+ymSK43QDus5XtuaOz0+V6GkEHYgWYiB9jlRjSZlt9I70o1uoxI7FQ02nE0LnbVKUWtmxLYZIfkuKSthbkxW8oEL3hfXAsdvaU9pNHnoh7LTggRrcjqZ/01PT48ObXwJ/KUZvnL9dP69N1V8=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB5248.jpnprd01.prod.outlook.com (20.179.174.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.30; Tue, 21 Apr 2020 04:08:23 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 04:08:23 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: RE: [PATCH v8 7/8] PCI: rcar: Add endpoint mode support
Thread-Topic: [PATCH v8 7/8] PCI: rcar: Add endpoint mode support
Thread-Index: AQHWFk5UE11qUHPutkuEmSFrk6X2U6iC38QQ
Date:   Tue, 21 Apr 2020 04:08:23 +0000
Message-ID: <TYAPR01MB45443972F88BDA1134628342D8D50@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1587302823-4435-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587302823-4435-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587302823-4435-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5bb79bb-d33a-40a8-389a-08d7e5a9a27d
x-ms-traffictypediagnostic: TYAPR01MB5248:|TYAPR01MB5248:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5248CD01A7A4DEC358EB080FD8D50@TYAPR01MB5248.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(54906003)(71200400001)(6506007)(478600001)(316002)(7696005)(9686003)(66946007)(55016002)(64756008)(2906002)(186003)(76116006)(5660300002)(81156014)(7416002)(4326008)(8936002)(66556008)(55236004)(6862004)(33656002)(86362001)(8676002)(26005)(66476007)(52536014)(66446008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFPoZmcYpfzrbnSlAGC4qFDkSLRID8ucTNH70chzN+ZUpeiGHSs684IxAF8qDRwepWGXJzIWQ8KYp+f4Q7eitb9yZgMnQRG/Ez7qA/4CFamAKaUg2rbiZoV/k9wEOktkLQok+lqryRdchvfo7TkRp6GPN5OowHBj6ILxbrjLJ33onebSIUyV5i8uF73kMSRnrwjfIoQ4boGc7psmH0AWUpUpUd3KTzx7xxXzsvPFLEUWGn497tZsUT9sgB50PSYUlnyWiFRunY/KNBAa9VS4y8He8InVRdGavtGgINMaxrjE42rH57iYZMH6w44FyO1jYxNoFhlBVjGTAG1Rdln1oaIZ0JuUp2GgjWmb3Q62lwhhUd/M5TrzCzekmLIbiLigcX+0ETDdCSvKyVrJX2j81BI4q0Rg7aqN+JRDzxynaKKxySZtdidYv6eUSpihR4yJ
x-ms-exchange-antispam-messagedata: 0RzlOZiI0tQB864WUBjjsvDWQs0eEXpJfiPNfTGH/G/9vqmUXlotOB0gGD2HuOM4BpWPjY6SiwM7pOJH+39qC9AbjXreTMs4BjwkMV59R9TqKYfxUj2r6Pyh3KhXhiOTKWUP8EDfBdGnJ1DgkxAqMg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bb79bb-d33a-40a8-389a-08d7e5a9a27d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 04:08:23.2734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/x75n/5U6Nw1Lx6lCfzP1a/BhD81DR5nWYxy9KMiR1xDqFwTPLoTDWUZ0yPGp+2Uzxr2bruAmGXisMtP7uX6P4BjOz4cb7ICxod/IlfhhwCj2OwzX/h5iDl3cs1mq8u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5248
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

Thank you for the patch!
I'm sorry I should have mentioned on previous email. But, I have some comme=
nts.

> From: Lad Prabhakar, Sent: Sunday, April 19, 2020 10:27 PM
>=20
> Add support for R-Car PCIe controller to work in endpoint mode.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
<snip>
> +static int rcar_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 interrupt=
s)
> +{
> +	struct rcar_pcie_endpoint *ep =3D epc_get_drvdata(epc);
> +	struct rcar_pcie *pcie =3D &ep->pcie;
> +	u32 flags;
> +
> +	flags =3D rcar_pci_read_reg(pcie, MSICAP(fn));

The argument of MSICAP() should be 0. Otherwise, if the fn is 1 or more,
the code reads a wrong register.

> +	flags |=3D interrupts << MSICAP0_MMESCAP_OFFSET;
> +	rcar_pci_write_reg(pcie, flags, MSICAP(fn));

Same here about MSICAP().

> +
> +	return 0;
> +}
> +
> +static int rcar_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
> +{
> +	struct rcar_pcie_endpoint *ep =3D epc_get_drvdata(epc);
> +	struct rcar_pcie *pcie =3D &ep->pcie;
> +	u32 flags;
> +
> +	flags =3D rcar_pci_read_reg(pcie, MSICAP(fn));

Same here about MSICAP().

> +	if (!(flags & MSICAP0_MSIE))
> +		return -EINVAL;
> +
> +	return ((flags & MSICAP0_MMENUM_MASK) >> MSICAP0_MMENUM_OFFSET);
> +}
> +
> +static int rcar_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
> +				 phys_addr_t addr, u64 pci_addr, size_t size)
> +{
> +	struct rcar_pcie_endpoint *ep =3D epc_get_drvdata(epc);
> +	struct rcar_pcie *pcie =3D &ep->pcie;
> +	struct resource res;
> +	int window;
> +	int err;
> +
> +	/* check if we have a link. */
> +	err =3D rcar_pcie_wait_for_dl(pcie);
> +	if (err) {
> +		dev_err(pcie->dev, "link not up\n");
> +		return err;
> +	}
> +
> +	window =3D rcar_pcie_ep_get_window(ep, addr);
> +	if (window < 0) {
> +		dev_err(pcie->dev, "failed to get corresponding window\n");
> +		return -EINVAL;
> +	}
> +
> +	memset(&res, 0x0, sizeof(res));
> +	res.start =3D pci_addr;
> +	res.end =3D pci_addr + size - 1;
> +	res.flags =3D IORESOURCE_MEM;
> +
> +	rcar_pcie_set_outbound(pcie, window, &res);
> +
> +	ep->ob_mapped_addr[window] =3D addr;
> +
> +	return 0;
> +}
> +
> +static void rcar_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
> +				    phys_addr_t addr)
> +{
> +	struct rcar_pcie_endpoint *ep =3D epc_get_drvdata(epc);
> +	struct resource res;
> +	int idx;
> +
> +	for (idx =3D 0; idx < ep->num_ob_windows; idx++)
> +		if (ep->ob_mapped_addr[idx] =3D=3D addr)
> +			break;
> +
> +	if (idx >=3D ep->num_ob_windows)
> +		return;
> +
> +	memset(&res, 0x0, sizeof(res));
> +	rcar_pcie_set_outbound(&ep->pcie, idx, &res);
> +
> +	ep->ob_mapped_addr[idx] =3D 0;
> +}
> +
> +static int rcar_pcie_ep_assert_intx(struct rcar_pcie_endpoint *ep,
> +				    u8 fn, u8 intx)
> +{
> +	struct rcar_pcie *pcie =3D &ep->pcie;
> +	u32 val;
> +
> +	val =3D rcar_pci_read_reg(pcie, PCIEMSITXR);
> +	if ((val & PCI_MSI_FLAGS_ENABLE)) {
> +		dev_err(pcie->dev, "MSI is enabled, cannot assert INTx\n");
> +		return -EINVAL;
> +	}
> +
> +	val =3D rcar_pci_read_reg(pcie, PCICONF(1));
> +	if ((val & INTDIS)) {
> +		dev_err(pcie->dev, "INTx message transmission is disabled\n");
> +		return -EINVAL;
> +	}
> +
> +	val =3D rcar_pci_read_reg(pcie, PCIEINTXR);
> +	if ((val & ASTINTX)) {
> +		dev_err(pcie->dev, "INTx is already asserted\n");
> +		return -EINVAL;
> +	}
> +
> +	val |=3D ASTINTX;
> +	rcar_pci_write_reg(pcie, val, PCIEINTXR);
> +	mdelay(1);

Since pci_epc_raise_irq() calls mutex_lock() and then this function,
we can assume this function also can sleep. And, according to
Documentation/timers/timers-howto.rst, we should use
usleep_range(1000, 1000) instead of mdelay(1).

> +	val =3D rcar_pci_read_reg(pcie, PCIEINTXR);
> +	val &=3D ~ASTINTX;
> +	rcar_pci_write_reg(pcie, val, PCIEINTXR);
> +
> +	return 0;
> +}
> +
> +static int rcar_pcie_ep_assert_msi(struct rcar_pcie *pcie,
> +				   u8 fn, u8 interrupt_num)
> +{
> +	u16 msi_count;
> +	u32 val;
> +
> +	/* Check MSI enable bit */
> +	val =3D rcar_pci_read_reg(pcie, MSICAP(fn));

Same here about MSICAP().

> +	if (!(val & MSICAP0_MSIE))
> +		return -EINVAL;
> +
> +	/* Get MSI numbers from MME */
> +	msi_count =3D ((val & MSICAP0_MMENUM_MASK) >> MSICAP0_MMENUM_OFFSET);
> +	msi_count =3D 1 << msi_count;
> +
> +	if (!interrupt_num || interrupt_num > msi_count)
> +		return -EINVAL;
> +
> +	val =3D rcar_pci_read_reg(pcie, PCIEMSITXR);
> +	rcar_pci_write_reg(pcie, val | (interrupt_num - 1), PCIEMSITXR);
> +
> +	return 0;
> +}
<snip>
> diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/=
pcie-rcar.h
> index cec7768b4725..0fbeff3d7b78 100644
> --- a/drivers/pci/controller/pcie-rcar.h
> +++ b/drivers/pci/controller/pcie-rcar.h
> @@ -17,6 +17,7 @@
>  #define PCIECDR			0x000020
>  #define PCIEMSR			0x000028
>  #define PCIEINTXR		0x000400
> +#define  ASTINTX		BIT(16)
>  #define PCIEPHYSR		0x0007f0
>  #define  PHYRDY			BIT(0)
>  #define PCIEMSITXR		0x000840
> @@ -55,12 +56,20 @@
>=20
>  /* Configuration */
>  #define PCICONF(x)		(0x010000 + ((x) * 0x4))
> +#define  INTDIS			BIT(10)
>  #define PMCAP(x)		(0x010040 + ((x) * 0x4))
> +#define MSICAP(x)		(0x010050 + ((x) * 0x4))
> +#define  MSICAP0_MSIE		BIT(16)
> +#define  MSICAP0_MMESCAP_OFFSET	17
> +#define  MSICAP0_MMENUM_OFFSET	20
> +#define  MSICAP0_MMENUM_MASK	GENMASK(22, 20)

s/MSICAP0_MMENUM/MSICAP0_MMESE/ ?

Best regards,
Yoshihiro Shimoda

>  #define EXPCAP(x)		(0x010070 + ((x) * 0x4))
>  #define VCCAP(x)		(0x010100 + ((x) * 0x4))
>=20
>  /* link layer */
> +#define IDSETR0			0x011000
>  #define IDSETR1			0x011004
> +#define SUBIDSETR		0x011024
>  #define TLCTLR			0x011048
>  #define MACSR			0x011054
>  #define  SPCHGFIN		BIT(4)
> --
> 2.17.1

