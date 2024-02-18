Return-Path: <linux-pci+bounces-3697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED6C85974B
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 14:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98ACBB2101A
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308026BB53;
	Sun, 18 Feb 2024 13:56:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A86BFB4;
	Sun, 18 Feb 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708264612; cv=fail; b=WJk2GA2eTW7VhCZr8tp1LDdvMlHOB+BfIpv/ZDO7m3RB/D8ZDPZTeHtnHAiUixTBbcQhFBFrxGwB7woUMPjwDmJDFOe4J1HB1MmCYnNRzUJJ7/7R8g14EBvcKj/VYRO0GXsXOMPALE9JxSO8Vc/IRyohz+xtbE1GLOgPq3I+02E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708264612; c=relaxed/simple;
	bh=EHPcSj9sR7PdM2cnaBEbCcyVix+pV/iYqVG8akqgkw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oDSWfldsAJL9uhycaXOE1Sbs0ufQDuSEGYtLjdfPDoejrGseWi8lhl38TmyztX7Yc/3jspdJdUn+iEd7ig1qUer6sRaJm06zop1XO5owAVGW3ubx2MIU89sRWwFa2I93Br0J7Kd7FdY9iTePCReQdhg8Z5Jlx89Wg/sInZbBMGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSFKgMz9SLtBOWgLZMwmzsBMsaKTtHY+sEoaJ47hR1F+rmZPdqEVaj3aWMBC4sDQ3znItof1C8TGS2fVAff/UPb4ro1hneaOnNf4yqRFNuD0WHL0xmEPqVfuxgbyj7nK8tcLmdeIAfrAAQmwNVkd8BC0ACRojqi0FuFCGuPJA6ZrQMM4Qrit3aoqRxW7ld8W4oN1gQWaFdDYA0GfTy1TKWEMFeIZxwyIN1yMdHkj+oHGPI9SZxZc6Zv4FH8bQJkemDLu6/SRfuWlP8wvd53/vKX5vkeLBSmbE8726hlxW6cn2uyKvSyNKaRncItw0FogK1nJ8d132twUADV7HTVTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0+ut9cZnMaNFheeqwtU0iLAGDDkHh3yE1QguZZMOuY=;
 b=iIiAieaa8q9zGMmhPIf4iHJ55BWKCoFfG3Szdo+L2Rw6dzSB12/f/MwQbp3kS5e9YiBIb9ZftlLA57stN/iQJPxCOBzHZ6tSZHJZpOiRPxdxBQrohM20rw/lktLsdBbx+BKkwQDMnNuJ9UiAAm6MXCXW/PCBX5dZiEy+WRzCua6BcjLPmD+lzlhDa0IQINQdRsAfQenjPzmWb28litf0E3yhSpEsNt6QdCAflHhbxMj9l9MXcmeIGY/IGk8ceS/ukZE79bFUrkkjUVvLu2oOsZHiBTpF7ZeCV5C1Sc4jXItYALsQRrYYRxIiT3Ll5VGx1X8MHiSsBsi+LlqbTNQCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0464.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.50; Sun, 18 Feb
 2024 10:23:20 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:23:20 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Daire
 McNamara <daire.mcnamara@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Kevin Hilman <khilman@baylibre.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v15 22/23] PCI: starfive: Offload the NVMe timeout
 workaround to host drivers.
Thread-Topic: [PATCH v15 22/23] PCI: starfive: Offload the NVMe timeout
 workaround to host drivers.
Thread-Index: AQHaYlP4rHGw8vZ4EUmOCs3FPdp69rEP5FTw
Date: Sun, 18 Feb 2024 10:23:20 +0000
Message-ID:
 <SHXPR01MB0863B1FE2434D02FC221FF73E652A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240218101921.113528-1-minda.chen@starfivetech.com>
 <20240218101921.113528-7-minda.chen@starfivetech.com>
In-Reply-To: <20240218101921.113528-7-minda.chen@starfivetech.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0464:EE_
x-ms-office365-filtering-correlation-id: 2a26c880-8617-4841-e51c-08dc306ba164
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MrxrABSImBd8nFsGU8nHUmmp/noxJaQR8eOGjGxaNtOpURH3nN6dYpOqyMlRPAnaYZe5z0ZzOD5V5svpkTKjHonLVffR8GKEY9emaKKN+lPBKBYRXK6tdyQ4ub8LjyTlh6pRRyTWzKmWXwLX8HOTB0zOhskT2rrFaz3bgTBVcd/0KK/zg4PQJSF8YRpm6VOa0WMO7wLxU4hYRa9F0HvhiHJjvl4Qvj82M7iANsi5QtQE41sj+x204jVpTLWoCrdp5DXGUDDhV7Sb6yhInAJDbg5KnxdgA1Ov4AFiWVA6gt7RnXv+56/yUU69qApJuUilJ2o5+C2X40DC0/qeVgBIMeLmxc+H2R8R2v5qNGrWUHSW08x2yUAcRin0rHOcPCCSLZ8yVBdWRfRFpVFvG6PV+FYyzN6mTghF+qVLnVOs4OVhNp/ysdCUQVfCP0pEcfKydcWqoKR4Rkp0rKqNCqpt1B9utz7f2MQSzlPtPq3D6Y+7BP0AEuEBOOCee7l858MQYlfCKhkipPHU6W1qMGt/IxFx8zO5ElTb+h97+Y0UC1ySKfUyqn1KfgsqWEagflYY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(33656002)(55016003)(86362001)(83380400001)(122000001)(40180700001)(40160700002)(38100700002)(5660300002)(41320700001)(7416002)(2906002)(66946007)(4326008)(7696005)(38070700009)(44832011)(54906003)(76116006)(66446008)(66476007)(64756008)(41300700001)(8936002)(66556008)(8676002)(26005)(508600001)(71200400001)(110136005)(9686003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?WtwyofcqpL7czQU4qlGOj1oHFgdt1rxH37HuvX1Tw24R5w8wqrsphx9Bnt?=
 =?iso-8859-2?Q?9Eq0y2jNMJhtrmlnF4fFO0bYIMK2mXSk09x0/3aA3BwGVXu8iotn3rUMub?=
 =?iso-8859-2?Q?z+VnCVyRzaHDZNaBxtHE4oTFyjXcVS+EogmYoZLIMjCda2sdSr35dMVfwm?=
 =?iso-8859-2?Q?ySWfsUvFiMRnUwV+WyHKgmAnJf1Sap6ApqGTubU+TA+BLU9dCAfXhOLZyH?=
 =?iso-8859-2?Q?631WzmAd/ydWWFzF0hiLI+PQs/GaPUZEeMJSq2oGVuHAaiQa9Q6CXjjFXM?=
 =?iso-8859-2?Q?3xHztmme4PMr1ZKJHSpu55ZQlTcV/0sfShk4T20Oi0PXWTPZde+WEKbRAl?=
 =?iso-8859-2?Q?akfPsIx1WLbCC5+sJme5s3WDQG/4k+FTNY5eZB9marMS+X7IuwyIp67n5H?=
 =?iso-8859-2?Q?dJOEzNQ2vjk1v2iLHBAvm15G5XcmvrymJHtFT57aYXOElcvtHlhqcUZEC5?=
 =?iso-8859-2?Q?Cojhpam8cCX5cgN5iUcn2c8GV4VstwwtHoWsxDr7nNLlY47H2o+9BYdfvJ?=
 =?iso-8859-2?Q?oRS1ItWxi3HI2TdEpnLfxcx+Xmvo3Lq0A2m4szMICb63H33iB4UmsBrut9?=
 =?iso-8859-2?Q?+jZQ01pTPbF0ieAM292FgQw+CquVQsW4w+/0xsSAZdELilDWgkz8N0L+P7?=
 =?iso-8859-2?Q?jXUPVzNhdgLy0a+Bjb/Sx0QnjXyKygL9OqSILweWc4cXvCEWihHrCslTsJ?=
 =?iso-8859-2?Q?W6SJ2FTgswIhioeYXwJsnbMu2x/fP4pieIxeFi4Hq7jWD69aG9fbuVeAF6?=
 =?iso-8859-2?Q?kJEdVS6bHw7A5D8Ls+YwUaQDCXaTjSgWV0LMU7juqtADiU7Ar32O1mUnNq?=
 =?iso-8859-2?Q?7FVoBBVz52g2Ogbnujv+JXChDzAXpKidYqdC9mxQ22oSoaK99mpmzsMke/?=
 =?iso-8859-2?Q?M9pWyvF1O8GutaJH+4i49Fl17TjdNNzpx17VvaU7VC9VDJXncchGlE1gw+?=
 =?iso-8859-2?Q?xBlbJ5RfiWzoz1LB2oqN9cKAxIv0lo3/pvn21cuqfYR47ONYOrVUuG3P8T?=
 =?iso-8859-2?Q?6GQcD6saIRjTqBoHxuq6/3mo5CRZQztHn69fdFCYPOvqilgAOeiu0OtpKL?=
 =?iso-8859-2?Q?AylK1X/QTL6ANR4k/EYWXQReYkD+Z9jSMCVgietchfvUhjhHsmsNfco+Gz?=
 =?iso-8859-2?Q?qiZQBo2uJFRzQUJm35AoJeEw83kfr6QY9bCIvfa4mVGUV9iv87mpE1HI9q?=
 =?iso-8859-2?Q?7h30aU9bP9mY22rrnqS7RZE2jZx3aBDs54nNpidJm53UUtYDLgrYkMD7Nd?=
 =?iso-8859-2?Q?4T+m50wy/P8hCk4tB9hk/RXsDfODLkld9ZaeSBPcBxRgS1KjrfRpzktmZg?=
 =?iso-8859-2?Q?uVUtD8J39KpGNsYmbttSD7yOGWlXY1DJdusIohRXiVx1qhag9M33vik4PA?=
 =?iso-8859-2?Q?qvcBa+J97fOV0mcCevW7QR17aLAfY+vY9O3NVSkCmdjQuoNjOc7vJ91LRX?=
 =?iso-8859-2?Q?uqbrNV4WTYGiJK9lwHn4qvqRdpS5zI/gPs3JLs8twJAvq0VGCmzlOI7W78?=
 =?iso-8859-2?Q?yJRCtfTAGaPmZ9QiKS4RObSseiyAnHp+gAkrLt6+kOcMJlLneG8T1CnXga?=
 =?iso-8859-2?Q?OI0G0yp7MaLjvFaZMBHUeRD76ZH2MkI3+dptrWiixw0nhdAPTmhbGqIvnD?=
 =?iso-8859-2?Q?mWp3psZRcCp7Do3d78ZxHYoQcX+BfkMSbUH1l26bOtPRMR6wZJau7zRg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a26c880-8617-4841-e51c-08dc306ba164
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 10:23:20.6638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKSAaozEglzH42xwzucXHBr2bxtVJxt0t0z+5TdsumeO9BZnx7e7vxBo3uHhjSaaXNJb2tzoLQZO+9i5ZZmmI1fAHMYnYL9kKXOfCyQzyq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0464


>=20
> From: Kevin Xie <kevin.xie@starfivetech.com>
>=20
> As the Starfive JH7110 hardware can't keep two inbound post write in orde=
r all
> the time, such as MSI messages and NVMe completions. If the NVMe
> completion update later than the MSI, an NVMe IRQ handle will miss.
>=20
> As a workaround, we will wait a while before going to the generic handle =
here.
>=20
> Verified with NVMe SSD, USB SSD, R8169 NIC.
> The performance are stable and even higher after this patch.
>=20
> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/pci/controller/plda/pcie-plda-host.c | 12 ++++++++++++
>  drivers/pci/controller/plda/pcie-plda.h      |  1 +
>  drivers/pci/controller/plda/pcie-starfive.c  |  1 +
>  3 files changed, 14 insertions(+)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c
> b/drivers/pci/controller/plda/pcie-plda-host.c
> index a18923d7cea6..9e077ddf45c0 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -13,6 +13,7 @@
>  #include <linux/msi.h>
>  #include <linux/pci_regs.h>
>  #include <linux/pci-ecam.h>
> +#include <linux/delay.h>
>=20
>  #include "pcie-plda.h"
>=20
> @@ -44,6 +45,17 @@ static void plda_handle_msi(struct irq_desc *desc)
>  			       bridge_base_addr + ISTATUS_LOCAL);
>  		status =3D readl_relaxed(bridge_base_addr + ISTATUS_MSI);
>  		for_each_set_bit(bit, &status, msi->num_vectors) {
> +			/*
> +			 * As the Starfive JH7110 hardware can't keep two
> +			 * inbound post write in order all the time, such as
> +			 * MSI messages and NVMe completions.
> +			 * If the NVMe completion update later than the MSI,
> +			 * an NVMe IRQ handle will miss.
> +			 * As a workaround, we will wait a while before
> +			 * going to the generic handle here.
> +			 */
> +			if (port->msi_quirk_delay_us)
> +				udelay(port->msi_quirk_delay_us);
>  			ret =3D generic_handle_domain_irq(msi->dev_domain, bit);
>  			if (ret)
>  				dev_err_ratelimited(dev, "bad MSI IRQ %d\n", diff --git
> a/drivers/pci/controller/plda/pcie-plda.h
> b/drivers/pci/controller/plda/pcie-plda.h
> index 04e385758a2f..feccf285dfe8 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -186,6 +186,7 @@ struct plda_pcie_rp {
>  	int msi_irq;
>  	int intx_irq;
>  	int num_events;
> +	u16 msi_quirk_delay_us;
>  };
>=20
>  struct plda_event {
> diff --git a/drivers/pci/controller/plda/pcie-starfive.c
> b/drivers/pci/controller/plda/pcie-starfive.c
> index 9bb9f0e29565..5cfc30572b7f 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -391,6 +391,7 @@ static int starfive_pcie_probe(struct platform_device
> *pdev)
>=20
>  	plda->host_ops =3D &sf_host_ops;
>  	plda->num_events =3D PLDA_MAX_EVENT_NUM;
> +	plda->msi_quirk_delay_us =3D 1;
>  	/* mask doorbell event */
>  	plda->events_bitmap =3D GENMASK(PLDA_INT_EVENT_NUM - 1, 0)
>  			     & ~BIT(PLDA_AXI_DOORBELL)
> --
> 2.17.1

Hi Kevin Hilman
   Will you try this series patch? Maybe this patch can fix the NVMe timeou=
t print issue.
If this patch can fix it, please notify us. Thanks

