Return-Path: <linux-pci+bounces-7765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76688CCA40
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 03:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F81B21B7F
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 01:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9C17F7;
	Thu, 23 May 2024 01:10:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872AD15A8;
	Thu, 23 May 2024 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426608; cv=fail; b=HqvofBFVpdTVZD1zXyB1hbJbLtZUJO/uEWGe6VBwugS5kTdsxiTeLpgeALQkGdCaycLBDAr+qJ0doBpy87GxBvcOC9Y68dGDZeUReFqlOUQ8PcN/0aiEf61JUmT8ij/tXys44KMkMMMY6LjSyltqnN8/qH2ZO7vVYHsrF8Yis5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426608; c=relaxed/simple;
	bh=gjPu70iGYBRG6YflReTRN7jFdAG4Zs7t47Pzm+1tT8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N8UYjyhdROqTmhU5VMxw6ICsnOYQsQLWQXX1FTnd4HB45/bxlvmo+IFOnOXs6gZMm2RJbjDUqe+EG/4uov0iRqH8PP+OUG8qqw1ZZaXOG4H1ikMIwajL6G/01XfpcDMR1SfKFIkenLgTpcGas03MVlNwVh6fqZ+YHUNWvX9ZCVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1tSzDYBnOso1oTTAdIY7k6L4w6JFf51grDFVkfDnhiQGoGANbYoZhr9dWTHC5w2aJAcainMZ2OJzwrJc5YQ02g1T6t3rjuMbWdjoRuWRYihtRLMuUOmAVsPCpcjXlkZcNMzYlCB/sfoFXmBg1oZcN2aOYdODcbnZFI1FlvStyzkBFK8iNa6UwlKEdyEeGkYxc+F9XBVlWITF//GAT/Dl8uEtLCKQ47FdccniRQH1ny0z3xVqYbzc8S136DvG1Dp4T6zGNriupjrZjHYBjKqgci0A3RIk4uDgAPUXLCkjo9bKNcjfdZSGXr8Nhuz7G/ZfXdDqHkLBraQWKQkmEGuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR7V7Wf9ftGLsYFJvhFWzhlvRZyiiWHjVvpQJJ8HiwU=;
 b=JPlDCscK+mThF2qiJenSuKzkurdc3rJDh46C7t1Ga2iUKlWOlr4mLcGh8rXbaq0VXmisGUvpjaLQ7fmyzXUWEnOGo7jQYAgmsW5p4qbMzRw29asEsDIco3ChEBpl9bozrq0Y4m1gVrawcFl32tcVh641kc81IJbUfH5Am6ZlymY2fiOhrQOUQdGfjObr2mLDWOul8K5w8BBO25Z4hK7cdKs3TjPS0SpMFJZmJBE4rVU+BBkPWjf6iO0QbGD33YYLsKi7NDz/L++16YgtSwprTL3t3iUNBZiaH8AvKeJs56Jy/S3CYAzNbXSyazcwJEKjYp061sKKNJd9jiTNKkxL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0542.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 23 May
 2024 01:09:59 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7587.035; Thu, 23 May 2024 01:09:58 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Conor Dooley
	<conor@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Philipp
 Zabel <p.zabel@pengutronix.de>, Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, Kevin Xie
	<kevin.xie@starfivetech.com>
Subject: Re: [PATCH v16 08/22] PCI: microchip: Change the argument of
 plda_pcie_setup_iomems()
Thread-Topic: [PATCH v16 08/22] PCI: microchip: Change the argument of
 plda_pcie_setup_iomems()
Thread-Index: AQHarK3uyefc+SM1B0in6DqZmUwbsA==
Date: Thu, 23 May 2024 01:09:58 +0000
Message-ID:
 <SHXPR01MB086345C911E227889E3A4211E6F42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References:
 <SHXPR01MB086351396027D8A443BB6068E6EB2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <20240522221034.GA83828@bhelgaas>
In-Reply-To: <20240522221034.GA83828@bhelgaas>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0542:EE_
x-ms-office365-filtering-correlation-id: 4a7d7a01-9aae-4ff6-ebf9-08dc7ac510cf
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 33We4VLr0HBst6/BAZiCAcoAEATt/nQ6YL9+or81AnvuK0x56KviueZGnMcT4A+3AgVOF5A1Fe35c+nRs34wRSDYl+UBlgkVHo4Jp98ND5cPR1GpAr6yAO0einibeNWv2BkBsinbRBCN8eXPNBtpiRvNddRXVmf1LbrHhFl+UIabKHzX+DR1Rt/ufX7rnUOO8V5uBZkb6B+42z1StRWd3AqixU9MPybfJJ5UDIf2Z2H1jFNzLxGvESktMFfJ3yd6vbREz0WlUza8FvoFL5Cu8+rVjN6ZOA8mmwXxvjkK+Ly/uaiKt8t3uwibOLZdVzF23NtbRhUbCLaMm/8HQm0LWwvZB8m3REnSYK7rYMLORzNVD15nElmzQRUTByKgbKSIctDjR0MLH+PEkwHp3iQKuMVm8QgVCMbAszGK7u262wisedii9Fx+IOXbZl/Qo3c/g+rxn/DFoE28BHa+4KFROJupvx4RdYtcaGK/NsjqR74b87yzpj3MVzdAoHy0vTIFsBJOXiDYdDxnSk/OxGpaMB5quv3oCZDHdfSWZpQzGOX5Lh3APRrMiTkiqWtEY/KhFjpGzaF3X1RTNdo+x+nb7gmgJsni9I7s8LXqETS9W6ttjoEoGLzcGzLizG78nv0M
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?oPddVnVOL7McEaujIywdFyolPKkFdo7cvR0dGH/iRg5a90wtBEATIlihOp?=
 =?iso-8859-2?Q?lxRIGhw9u38UonwfkgDdobBKebGVdX5Df6Dm0v6oQ4bCfTk53VNOlv46NU?=
 =?iso-8859-2?Q?qlNkRohHFkH7oMotDp/dHtdwI9oct0GW6AwhcqY6EgaT1fgIAv4Td/oEdZ?=
 =?iso-8859-2?Q?Qpe04enpaDieoURwxzRK1X+xwR2yueGf8omqa1upx2NUcx+Nr/4MS/ozJo?=
 =?iso-8859-2?Q?CyPLYvAK6Cx/V0gS/iBMTPV+mPMDviV+rtslhMuq3SZK4EgUZAxB4G/Bss?=
 =?iso-8859-2?Q?hRK9fl+irvMcZEagPadFhI1b4u5ZTTxdrfRCMFiUDId1Z+AYblSClDinGm?=
 =?iso-8859-2?Q?uSFY1uTQhCzKKVFgoIEU49hO3Ojx3tCwzlvCYH2KVC2QPI4H4u6sZHwhWU?=
 =?iso-8859-2?Q?cKEAbHUWE8TOeRoi/G7Usa8GglgOXoK4DMjOGe1Zr69LwflsvPSBRDm0dk?=
 =?iso-8859-2?Q?K6JP7I7JGm8E3vBgNo7E9d5WHR6CY8yy17bFTvkSCOENIiE830wg6AWTvK?=
 =?iso-8859-2?Q?igTigz+8+LOMMRlQjk7XETEnOOql/2n33C1aQ9OjjMVQ1A9B9p/rAdF/p7?=
 =?iso-8859-2?Q?TClUA9YPWUHtJCZnLCcJX3LdvKOkzV26dznxoDDx7zZvR/cOXXtLqEaUhQ?=
 =?iso-8859-2?Q?gSDAHvGIIbVqnbNxhjAlRQ9r4qpahhMH66rbfTcQQPOWzWkhMc2CSJE5id?=
 =?iso-8859-2?Q?fWTOMeaLwtciwO30gwFtA07NyZ3gx2BNfX7IwFOZQeoJJdw8jcDqhR9T8L?=
 =?iso-8859-2?Q?WIdVZed94dU18TgU3dXuKbr1Vpf0rhTm8ct729cEru9vHXAw41rpoHDRNj?=
 =?iso-8859-2?Q?Z9zsR05S5NNJJD6jtPiSyTEksyYJR+wdSLSW6Nd4CCxi3U8e/tcWDJaHu8?=
 =?iso-8859-2?Q?CxhDKy68OxdPMfOo4iG2Inys3suno8VRvzkisRGq4d87Pes/xY2P+pliJb?=
 =?iso-8859-2?Q?6M0QEjLzqBvHhqNooxKrQOPDy6vc+mV7d2W0SPUJY9Y/eIj8IgygjWRLvu?=
 =?iso-8859-2?Q?48EjJJV9lxZ0bfInODgbGia90D0iRTLcuNrDnt9qtbG2wq1Jldpk1sW0Dr?=
 =?iso-8859-2?Q?mAyd8JGn7MwMbIxyfXaFvI+9Rn3/i7yciJTCGSioybkcrAVE+JnLHZeY6i?=
 =?iso-8859-2?Q?srPDAUUNGX7ae45bKH8N3IJBZ5Ni5vBWLmMMmlTAwxBsLph06vZOzaHCdy?=
 =?iso-8859-2?Q?md6/ezHzvR8n3qPhWH1LexyKBRSxx1O8NPftdlcnPFUtp7k5zXDYJQelTd?=
 =?iso-8859-2?Q?a4ulTTzyg3Z0xHHWU/ysCaOZl3vsV8mSAdrMsz9iEHqsWTpkCa+fx54Ny/?=
 =?iso-8859-2?Q?+umrbZVBEbH7mrRJ5+2IAzTTLY0717KwIPaCj4VyxbD7GL83nIlk1B/vVn?=
 =?iso-8859-2?Q?UxhpPwzWjjFwqkzJL0oJCw7gAs3BA8fcbJbXaDYPiatHaPm4wjYsJ4U9Mg?=
 =?iso-8859-2?Q?4z9vRXVhfIRud0B4UL2/9hAX2YDS7U577mEN73cORg9SSxqVluaoC6qUgz?=
 =?iso-8859-2?Q?DvTQ4/e4O2n6bXeY1BG8nAbe/av3bKoBkMgzhAZuj+td1wzGWE4CdZrJQP?=
 =?iso-8859-2?Q?M6SRG7hCWk/iPPD6lRdDIy5KyK60Nil9MczGj+h8Bz2hdkqEcHIgOi4LtR?=
 =?iso-8859-2?Q?GdvroNgHL67MS7XKtespD27TJvkBEB0+qLDiJSTABgmCEsH0jb4roYEA?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7d7a01-9aae-4ff6-ebf9-08dc7ac510cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 01:09:58.8460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrSpnd0dl97aDHv4n6xP63JM3vkbe0KkSUl1QEEcOJjtW9+ZaALziD0TC5oJDuGY9AR2kGOyypV9HFrbg1Xj46IEoywdXWzFS7BtjmvCrY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0542



>=20
> On Wed, May 22, 2024 at 01:50:57AM +0000, Minda Chen wrote:
> > > The patch is OK, but the subject line is not very informative.  It
> > > should be useful all by itself even without the commit log.
> > > "Change the argument of X" doesn't say anything about why we would
> > > want to do that.
> > >
> > > On Thu, Mar 28, 2024 at 05:18:21PM +0800, Minda Chen wrote:
> > > > If other vendor do not select PCI_HOST_COMMON, the driver data is
> > > > not struct pci_host_bridge.
> > >
> > > Also, I don't think this is the real problem.  Your
> > > PCIE_MICROCHIP_HOST Kconfig selects PCI_HOST_COMMON, and the
> driver
> > > calls pci_host_common_probe(), so the driver wouldn't even build
> > > without PCI_HOST_COMMON.
> > >
> > > This patch is already applied and ready to go, but if you can tell
> > > us what's really going on here, I'd like to update the commit log.
> > >
> > It is modified for Starfive code. Starfive JH7110 PCIe do not select
> > PCI_HOST_COMMON
> > plda_pcie_setup_iomems() will be changed to common plda code.
> >
> > I think I can modify the title and commit log like this.
> >
> > Title:
> > PCI: microchip: Get struct pci_host_bridge pointer from platform code
> >
> > Since plda_pcie_setup_iomems() will be a common PLDA core driver
> > function, but the argument0 is a struct platform_device pointer.
> > plda_pcie_setup_iomems() actually using struct pci_host_bridge pointer
> > other than platform_device pointer. Further more if a new PLDA core
> > PCIe driver do not select PCI_HOST_COMMON, the platform driver data is
> > not struct pci_host_bridge pointer. So get struct pci_host_bridge
> > pointer from platform code function
> > mc_platform_init() and make it to be an argument of
> > plda_pcie_setup_iomems().
>=20
> OK, I see what you're doing.  This actually has nothing to do with whethe=
r
> PCI_HOST_COMMON is *enabled*.  It has to do with whether drivers use
> pci_host_common_probe().  Here's what I propose:
>=20
>   PCI: plda: Pass pci_host_bridge to plda_pcie_setup_iomems()
>=20
>   plda_pcie_setup_iomems() needs the bridge->windows list from struct
>   pci_host_bridge and is currently used only by pcie-microchip-host.c.  T=
his
>   driver uses pci_host_common_probe(), which sets a pci_host_bridge as th=
e
>   drvdata, so plda_pcie_setup_iomems() used platform_get_drvdata() to fin=
d
>   the pci_host_bridge.
>=20
>   But we also want to use plda_pcie_setup_iomems() in the new pcie-starfi=
ve.c
>   driver, which does not use pci_host_common_probe() and will have struct
>   starfive_jh7110_pcie as its drvdata, so pass the pci_host_bridge direct=
ly
>   to plda_pcie_setup_iomems() so it doesn't need platform_get_drvdata() t=
o
>   find it.
>=20
OK, Thanks.=20

I see PCIe 6.10 changed have been merged to main line.=20
Should I resend this patch set base on 6.10-rc1?=20

> > > > Move calling platform_get_drvdata() to mc_platform_init().
> > > >
> > > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > >  drivers/pci/controller/plda/pcie-microchip-host.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c
> > > > b/drivers/pci/controller/plda/pcie-microchip-host.c
> > > > index 9b367927cd32..805870aed61d 100644
> > > > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> > > > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> > > > @@ -876,11 +876,10 @@ static void plda_pcie_setup_window(void
> > > > __iomem
> > > *bridge_base_addr, u32 index,
> > > >  	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);  }
> > > >
> > > > -static int plda_pcie_setup_iomems(struct platform_device *pdev,
> > > > +static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
> > > >  				  struct plda_pcie_rp *port)
> > > >  {
> > > >  	void __iomem *bridge_base_addr =3D port->bridge_addr;
> > > > -	struct pci_host_bridge *bridge =3D platform_get_drvdata(pdev);
> > > >  	struct resource_entry *entry;
> > > >  	u64 pci_addr;
> > > >  	u32 index =3D 1;
> > > > @@ -1018,6 +1017,7 @@ static int mc_platform_init(struct
> > > > pci_config_window *cfg)  {
> > > >  	struct device *dev =3D cfg->parent;
> > > >  	struct platform_device *pdev =3D to_platform_device(dev);
> > > > +	struct pci_host_bridge *bridge =3D platform_get_drvdata(pdev);
> > > >  	void __iomem *bridge_base_addr =3D
> > > >  		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> > > >  	int ret;
> > > > @@ -1031,7 +1031,7 @@ static int mc_platform_init(struct
> > > pci_config_window *cfg)
> > > >  	mc_pcie_enable_msi(port, cfg->win);
> > > >
> > > >  	/* Configure non-config space outbound ranges */
> > > > -	ret =3D plda_pcie_setup_iomems(pdev, &port->plda);
> > > > +	ret =3D plda_pcie_setup_iomems(bridge, &port->plda);
> > > >  	if (ret)
> > > >  		return ret;
> > > >
> > > > --
> > > > 2.17.1
> > > >

