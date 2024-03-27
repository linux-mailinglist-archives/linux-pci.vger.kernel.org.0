Return-Path: <linux-pci+bounces-5215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C8388D5E3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 06:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D621C2341B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 05:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02DFC1D;
	Wed, 27 Mar 2024 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nNZkFzgZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477721C11;
	Wed, 27 Mar 2024 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711517583; cv=fail; b=DZ5LqLeS90OouxvhveBOFfv2QA4RM4dT/NXTQGz1Fq2m1DHlIP6IQ+rdgX+3ioFp4vSoiqzbTZu57GSOltw1AWOvpHtOnycTBo/VdpguWSQIdrjlRRDVZ0sr53/R5FDaZZmjj1hsxqdrXm7x0LC+YBIw0K5kE8686GnPxUVYWNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711517583; c=relaxed/simple;
	bh=veDVQsrF3uy8JszmgVsCGUnHlKg9mUIEaokApMtftws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QEk7PkcFNmS1vAdeJaPsAIb3zhlxybI0tHtxGtflgR6UdN3znNIgKr6zJSKz6LFmXL59kqQPiJk3siAgKxfXDmIxYy0cMljqgv3C+uHX1VmvHCwHPzal2obJHNB1hSYEGHArr9NllPTrWHKy8DDBTim/GE9u8J4JyrrLKkZ3Nto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=nNZkFzgZ; arc=fail smtp.client-ip=40.107.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mzos2VZ1eXau6SMb4I30tp8jSZw4+ttXjkpZFVCWkW3hLmo/HnM9mA+wR/DEWfuj6dWbIFY1alAOKI/TM3zElvat8Qb2EW+CCpRtfSqN7UtEoOnDRXUixrUvMBZfJJBzZTOUiOrrud3D9aXavvNTDVr3PnojOcE5aTZglbgDJLAdP8y2XPlFmJYoxPYo4SbwLLqhCDGcvo3R4J9ngNoOKvewEka4d4WCR7ta9qEU09UMcpIR0mQ7pIu93zIS8LDrW5EymJxJTqZrOXvAZiDNOkOU8DU4svKUrbrKy05jCeChBc9Rr56Q695EjrSAf+KzC5pkQzrKYInxrKnPF84zdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmIn3fRQGTHbu1fu67aEaK90TwDEtxOJK+eU92yluSI=;
 b=UnWjS80RtXnCs1f7bvc5rSWMj+flKJHRrlQ/MTRDAdD4/HiKxCnVNW8m9GMiNQNStVKtqlvMmBcnAKoXWXoYXvblUc57BQ6x34os+VwW8feMs36be2XPUofYGGpAFndhoOAVGnFcOLoo0yI1ru7AE/aJHw/acHgSyzT/Ci0II57/oDp5sXbDCTYZu33W136tFyqrBzTfMYSYVG/rYsNitnPUN43ti1RhvisK/zDa6r/Dz0VFWimwQcH0kLG3Un2MGhapcbxKQ/fewb0T0zCZATW9fneIekY5FUPHkENhlfzhV0LuQLU0/iWs7VBbZdfHQOxmc7BVJKjp3CgHcLZVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmIn3fRQGTHbu1fu67aEaK90TwDEtxOJK+eU92yluSI=;
 b=nNZkFzgZ9cL0SogIvl7X9cyluLhZ1XEj7gsfpXxROe6jaJNRwvfLRCkoT8NnQZ5o0vKJKZP5lypPQIs4y/KRq2TQNZ9h2Jd1EwHS8uf07xk3KzaSQmoYTLR5Cj+qB/rHxdBUZyGinqZpBzp3EFUCcDpwh293RT97baPOmx9ntc0=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYCPR01MB9466.jpnprd01.prod.outlook.com (2603:1096:400:193::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 05:32:57 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f%3]) with mapi id 15.20.7386.023; Wed, 27 Mar 2024
 05:32:57 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"mani@kernel.org" <mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 5/6] PCI: dwc: rcar-gen4: Add support for other R-Car
 Gen4 PCIe controller
Thread-Topic: [PATCH v2 5/6] PCI: dwc: rcar-gen4: Add support for other R-Car
 Gen4 PCIe controller
Thread-Index: AQHafye+eT6AlZmhy0218gL98LfreLFKf6kAgACLGuA=
Date: Wed, 27 Mar 2024 05:32:57 +0000
Message-ID:
 <TYCPR01MB110402EB3E15B3471C7F526C7D8342@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240326024540.2336155-6-yoshihiro.shimoda.uh@renesas.com>
 <20240326204842.GA1493890@bhelgaas>
In-Reply-To: <20240326204842.GA1493890@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYCPR01MB9466:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YFe3ik9iE3unWEdXFOhwAwy+ZINSHwEs0y8FqXXosJDHC+wurD5AEFJhQTqvMrPeoQL6w4CCioEaLvLSxSGCkKMaumeZKRz6iPtC/18ohTFGhHdY4AO7dfs/4YCBD2l0YyWbTJ85X05btjb5i+TzaAlUNyRcmAonjjVE1RDj/SQ2DcJEzZGRfX7q1Tdz2gdmF4ZaKTrSoBBGLagYRWPoHLGTATutDrMUI7T3iPKFtpocHPu3u9PAvOVLfSWQN2sSZKRExK35UrChtmxK0GBLUNLnKR+mQS/Erdk/HJuYaK0iaZi5xMAJ6yiMDG2eXCfu81+Zwpfyy0dQE0n9ITLn0VkHmSURw7MAywZnggyQuVdIlF5HBHSnoohiQi1vbHhA6op3FYfLZ8FgxtB6eiJLuGaQZaphJ7aS+CoKa6SmPv1Gr3akYL3W6zfklJzz0eWves5n1tQ5WzOg7f0eVktQ0pr5l5E3V8OZudfE4JQk/Og4jvQByQNqJ7hq1flUcNIHmjvyJxQ8YMnGNrkb38zrEQL13zHuoI2qdoAkNe+nmbuYjkTW1hbdto8kJxfzHFEpnOwTohCnd7LSCfZpwmq4o3hDpCgj1L2Ynd9QM85HGVnEyt339E/2fgQY8J9oVsKA3PD/qoa72hLm3s0yZCzgew==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A0rfyQv0HzgGxPpZMN4LpJifM5N2SVJHdyVAGVApBnSwyVKLp2jTZrg8dGB8?=
 =?us-ascii?Q?LOgESl59yUNymokfwYNqjrXnMVtjm+jfcSSyh0Zpm5ImGrXlxGi8be/4uhF4?=
 =?us-ascii?Q?07icajRhUKHEfIpFmqgSpPucCRPX/71BslhjeaNVRSUO7bW4ARrCmTZ1b1gD?=
 =?us-ascii?Q?yOqc+nXfOEugXZSYkBcbJ8VpG/A8byAN/rKXqSmXzIkFj8YqPERasESwU+JF?=
 =?us-ascii?Q?7dXwNu/ltfUdJbDaYXKxGt2/KBDHyxAzP6PLBW60WuyHTFvKhKUkWdnj5Q0t?=
 =?us-ascii?Q?xvp+S3jwbOMT9RrJNCjYz6myAMWQNNnwf60qXIh13V/YyWoND7HxFjDu8EcP?=
 =?us-ascii?Q?Oju9EZaNJa0TnqQDwsUCDqUTmmfy5EZz6Gl85UrmXu9iDgVaKn8Jm1Sf6fHB?=
 =?us-ascii?Q?yJti2wSvWHLzFmAbkqsqRBXf4xdn+JvGjdUMpd1O9D3fRuawvTdbgjw5GQOt?=
 =?us-ascii?Q?6IGGSa6nx0sRR1cGP6wgkeRdS5e2GlqkqQ5qGy4vw3djYrKVzkzDVVymdrE8?=
 =?us-ascii?Q?ESEmwqJWnnF6M4K047xBjoFOnx0xrGtn4QJGbTJNfwVN0tIeQnNBarRGOCsc?=
 =?us-ascii?Q?Y1ymZasoobX+ctHQgnv8sNDq6pYDpVz9tlpW1AIiYQnx++1dj2H5ctC7U6O/?=
 =?us-ascii?Q?80HeaRI6TWyyZ2r/VFNAhLdfAZLxdA/IzBwZ/bw6098iI+WKmgj3IwmyAl63?=
 =?us-ascii?Q?RLJJ5zaxyKEiW9HNqe21ZTs5DKz4PrkUVdaC7MhJLC/X/zqkDK5fidir6A9/?=
 =?us-ascii?Q?fWszbwqKkH0Zf/QKtpi3A/TNq1IcBs1CTQ2L3TwkruYp2md0/9O66axAQ2s8?=
 =?us-ascii?Q?152hqNZqr+i5P8m0jlhTjsxxA566609jVb1D9vGwTb6RdZeP13etB6haHbYA?=
 =?us-ascii?Q?CalRk4VgDLLfrv/KK3ETIteXgrVTMGHK2v81dencQxWQ3rFYeSnEGrKk4Pg8?=
 =?us-ascii?Q?smRnGEqzwG8lxhv331jOeVNphL2ATyUelZvjyAoTxWmzKYzMYL2E7zlR0BH4?=
 =?us-ascii?Q?zFa3C40UYSXwPnWV4K4VetVCR6adtQuK25p1ndr6LNIoakc5ze0Eb2iEyh0/?=
 =?us-ascii?Q?mkeCj/ND80RH1UGgZgur4OwymA9BrUZ9Pl6mO3qw8Z2Cfa0r25klEMMpezbD?=
 =?us-ascii?Q?Ov1wZEwGFlGP6+/EGCuTjsFzRi9q4M3SNUBO5VBwWsikh/CY+a42H7PxUPJM?=
 =?us-ascii?Q?0BmTGrrFztechMWj1F0Pw22r6yVUzFQtMBuoy6GTjBvkkZL6iw5SCOvKXEsm?=
 =?us-ascii?Q?ebiMz4vvuHHNnpFVsN01i+FM5t7W70Qzpbs1eYPrr5gRE3B3rnmZf7x1G24O?=
 =?us-ascii?Q?0CDgtx8m9yfm6MWMeJ+9kszZlQgsLqIp6ASoRVC1Sx6wuOZv0Sq4TM2bis2W?=
 =?us-ascii?Q?7uQpffHgwOPQSUApVRN9ym2aF2/wmvTPx4un/vBIp5FHmmlaUFoVFKfVWkUW?=
 =?us-ascii?Q?GXb+sjCwXnLLQL+YD4Un8wYEznORvhHqGgG/BlXyzHsH5SiXnRHAcfn5+kHT?=
 =?us-ascii?Q?bDyQXd0zEfcFjcyG04G42tYOK0Bf8uDH0wglJN6HUsbrJrA1tA7AJFYRsDsD?=
 =?us-ascii?Q?H3PcP3vCH+kjcBlGaPocndYJQdfewfDn0/sy/aiuJJCJdWj343D/TMtPqMBG?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5850aeff-1fe8-4f28-92fe-08dc4e1f5c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 05:32:57.4275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xLZZogMiKGlXm4q2XBMCEYyZA1r2EZN7rr0WTcxXr0XpQ1nPzyOLrRliWAKzrAOvle2bWONAJO3UZp7ckQ4bRLZesbuumA1eOSRP4su8PZBa3EQQweS8EPd1MrwdVeT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9466

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Wednesday, March 27, 2024 5:49 AM
>=20
> The subject line should specify which controller(s) this adds support
> for.

I got it. I'll change the subject.

> On Tue, Mar 26, 2024 at 11:45:39AM +0900, Yoshihiro Shimoda wrote:
> > The PCIe controllers of R-Car V4H (r8a779g0) and one more SoC require
> > different initializing settings than R-Car S4-8 (r8a779f0). So, add
> > specific functions for them as "renesas,rcar-gen4-pcie{-ep}" compatible=
.
>=20
> I can't tell from this what's being added.  This should say something
> like "this driver previously supported r8....  Add support for r8...."
> so it's clear what was existing and what is new.

I got it. I'll modify the description.

> Hmm... the first use of request_firmware() in drivers/pci/.  That
> warrants a mention here as it's a pretty significant change.

I got it. I'll add such a description.

> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 188 +++++++++++++++++++-
> >  1 file changed, 187 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > index a37613dd9ff4..7f3b5e9ca405 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -5,8 +5,10 @@
> >   */
> >
> >  #include <linux/delay.h>
> > +#include <linux/firmware.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/pci.h>
> > @@ -20,9 +22,10 @@
> >  /* Renesas-specific */
> >  /* PCIe Mode Setting Register 0 */
> >  #define PCIEMSR0		0x0000
> > -#define BIFUR_MOD_SET_ON	BIT(0)
> > +#define APP_SRIS_MODE		BIT(6)
> >  #define DEVICE_TYPE_EP		0
> >  #define DEVICE_TYPE_RC		BIT(4)
> > +#define BIFUR_MOD_SET_ON	BIT(0)
> >
> >  /* PCIe Interrupt Status 0 */
> >  #define PCIEINTSTS0		0x0084
> > @@ -37,33 +40,179 @@
> >  #define PCIEDMAINTSTSEN		0x0314
> >  #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> >
> > +/* Port Logic Registers 89 */
> > +#define PRTLGC89		0x0b70
> > +
> > +/* Port Logic Registers 90 */
> > +#define PRTLGC90		0x0b74
> > +
> >  /* PCIe Reset Control Register 1 */
> >  #define PCIERSTCTRL1		0x0014
> >  #define APP_HOLD_PHY_RST	BIT(16)
> >  #define APP_LTSSM_ENABLE	BIT(0)
> >
> > +/* PCIe Power Management Control */
> > +#define PCIEPWRMNGCTRL		0x0070
> > +#define APP_CLK_REQ_N		BIT(11)
> > +#define APP_CLK_PM_EN		BIT(10)
> > +
> >  #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
> >  #define RCAR_MAX_LINK_SPEED		4
> >
> >  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
> >  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
> >
> > +#define RCAR_GEN4_PCIE_FIRMEARE_NAME		"rcar_gen4_pcie.bin"
> > +#define RCAR_GEN4_PCIE_FIRMEARE_BASE_ADDR	0xc000
>=20
> s/FIRMEARE/FIRMWARE/

Oops. I'll fix it.

> >  struct rcar_gen4_pcie {
> >  	struct dw_pcie dw;
> >  	void __iomem *base;
> > +	/*
> > +	 * The R-Car Gen4 documents don't describe the PHY registers' name.
> > +	 * But, the initialization procedure describes these offsets. So,
> > +	 * this driver has "phy_base + magical offset number" for it.
>=20
> Make up your own #defines for the offsets.  That would be better than
> magic hex offsets below.

I got it. I'll add #defines for it.

> > +	void __iomem *phy_base;
> >  	struct platform_device *pdev;
> >  	enum dw_pcie_device_mode mode;
> >
> >  	int (*start_link_enable)(struct rcar_gen4_pcie *rcar);
> > +	void (*additional_common_init)(struct rcar_gen4_pcie *rcar);
> >  };
> >  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie=
, dw)
> >
> >  struct rcar_gen4_pcie_platdata {
> >  	enum dw_pcie_device_mode mode;
> >  	int (*start_link_enable)(struct rcar_gen4_pcie *rcar);
> > +	void (*additional_common_init)(struct rcar_gen4_pcie *rcar);
> >  };
> >
> >  /* Common */
> > +static void rcar_gen4_pcie_phy_reg_update_bits(struct rcar_gen4_pcie *=
rcar,
> > +					       u32 offset, u32 mask, u32 val)
> > +{
> > +	u32 tmp;
> > +
> > +	tmp =3D readl(rcar->phy_base + offset);
> > +	tmp &=3D ~mask;
> > +	tmp |=3D val;
> > +	writel(tmp, rcar->phy_base + offset);
> > +}
> > +
> > +static int rcar_gen4_pcie_reg_check_bit(struct rcar_gen4_pcie *rcar,
> > +					u32 offset, u32 mask)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +
> > +	if (dw_pcie_readl_dbi(dw, offset) & mask)
> > +		return -EAGAIN;
> > +
> > +	return 0;
> > +}
> > +
> > +static int rcar_gen4_pcie_update_phy_firmware(struct rcar_gen4_pcie *r=
car)
> > +{
> > +	const u32 check_addr[] =3D { 0x00101018, 0x00101118, 0x00101021, 0x00=
101121};
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	const struct firmware *fw;
> > +	unsigned int i, timeout;
> > +	u32 data;
> > +	int ret;
> > +
> > +	ret =3D request_firmware(&fw, RCAR_GEN4_PCIE_FIRMEARE_NAME, dw->dev);
> > +	if (ret)
> > +		return ret;
>=20
> It looks like a failure here leads to a probe failure, so I think this
> needs a diagnostic message so the user has a hint about what went
> wrong.

I got it. I'll add such a code here.

> > +	for (i =3D 0; i < (fw->size / 2); i++) {
> > +		data =3D fw->data[i * 2] | fw->data[(i * 2) + 1] << 8;
> > +		timeout =3D 100;
> > +retry_data:
> > +		dw_pcie_writel_dbi(dw, PRTLGC89, RCAR_GEN4_PCIE_FIRMEARE_BASE_ADDR +=
 i);
> > +		dw_pcie_writel_dbi(dw, PRTLGC90, data);
> > +		if (rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC89, BIT(30)) < 0) {
> > +			if (!(--timeout)) {
> > +				ret =3D -ETIMEDOUT;
> > +				goto exit;
> > +			}
> > +			usleep_range(100, 200);
> > +			goto retry_data;
> > +		}
> > +	}
> > +
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x0f8, BIT(17), BIT(17));
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(check_addr); i++) {
> > +		timeout =3D 100;
> > +retry_check:
> > +		dw_pcie_writel_dbi(dw, PRTLGC89, check_addr[i]);
> > +		ret =3D rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC89, BIT(30));
> > +		ret |=3D rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC90, BIT(0));
> > +		if (ret < 0) {
> > +			if (!(--timeout)) {
> > +				ret =3D -ETIMEDOUT;
> > +				goto exit;
> > +			}
> > +			usleep_range(100, 200);
> > +			goto retry_check;
> > +		}
> > +	}
> > +
> > +	ret =3D 0;
> > +exit:
> > +	release_firmware(fw);
> > +
> > +	return ret;
> > +}
> > +
> > +static int rcar_gen4_pcie_enable_phy(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	u32 val;
> > +	int ret;
> > +
> > +	val =3D dw_pcie_readl_dbi(dw, PCIE_PORT_FORCE);
> > +	val |=3D PORT_FORCE_DO_DESKEW_FOR_SRIS;
> > +	dw_pcie_writel_dbi(dw, PCIE_PORT_FORCE, val);
> > +
> > +	val =3D readl(rcar->base + PCIEMSR0);
> > +	val |=3D APP_SRIS_MODE;
> > +	writel(val, rcar->base + PCIEMSR0);
> > +
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x700, BIT(28), 0);
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x700, BIT(20), 0);
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x700, BIT(12), 0);
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x700, BIT(4), 0);
> > +
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(23, 22), BIT(=
22));
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(18, 16), GENM=
ASK(17, 16));
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(7, 6), BIT(6)=
);
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(2, 0), GENMAS=
K(11, 0));
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x1d4, GENMASK(16, 15), GENM=
ASK(16, 15));
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x514, BIT(26), BIT(26));
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x0f8, BIT(16), 0);
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x0f8, BIT(19), BIT(19));
> > +
> > +	val =3D readl(rcar->base + PCIERSTCTRL1);
> > +	val &=3D ~APP_HOLD_PHY_RST;
> > +	writel(val, rcar->base + PCIERSTCTRL1);
> > +
> > +	ret =3D readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(1=
8)),
> > +				 100, 10000);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D rcar_gen4_pcie_update_phy_firmware(rcar);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val =3D readl(rcar->base + PCIERSTCTRL1);
> > +	val |=3D APP_LTSSM_ENABLE;
> > +	writel(val, rcar->base + PCIERSTCTRL1);
> > +
> > +	return 0;
> > +}
> > +
> >  static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
> >  					bool enable)
> >  {
> > @@ -201,6 +350,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_g=
en4_pcie *rcar)
> >  	if (ret)
> >  		goto err_unprepare;
> >
> > +	if (rcar->additional_common_init)
> > +		rcar->additional_common_init(rcar);
> >
> >  	return 0;
> >
> >  err_unprepare:
> > @@ -242,6 +394,10 @@ static void rcar_gen4_pcie_unprepare(struct rcar_g=
en4_pcie *rcar)
> >
> >  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
> >  {
> > +	rcar->phy_base =3D devm_platform_ioremap_resource_byname(rcar->pdev, =
"phy");
> > +	if (IS_ERR(rcar->phy_base))
> > +		return PTR_ERR(rcar->base);
>=20
> I don't get it.  This imposes a new requirement (presence of "phy"
> resource) on the existing SoCs.  That doesn't sound right.

According to the dt-binding doc, the existing SoCs are also required for th=
e "phy".
That's why I didn't add any condition to simplify the code.

> >  	/* Renesas-specific registers */
> >  	rcar->base =3D devm_platform_ioremap_resource_byname(rcar->pdev, "app=
");
> >
> > @@ -452,6 +608,7 @@ static int rcar_gen4_add_dw_pcie(struct rcar_gen4_p=
cie *rcar)
> >
> >  	rcar->mode =3D pd->mode;
> >  	rcar->start_link_enable =3D pd->start_link_enable;
> > +	rcar->additional_common_init =3D pd->additional_common_init;
> >
> >  	switch (rcar->mode) {
> >  	case DW_PCIE_RC_TYPE:
> > @@ -521,6 +678,31 @@ static int r8a779f0_pcie_start_link_enable(struct =
rcar_gen4_pcie *rcar)
> >  	return 0;
> >  }
> >
> > +static int rcar_gen4_pcie_start_link_enable(struct rcar_gen4_pcie *rca=
r)
> > +{
> > +	return rcar_gen4_pcie_enable_phy(rcar);
> > +}
> > +
> > +static void rcar_gen4_pcie_additional_common_init(struct rcar_gen4_pci=
e *rcar)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	u32 val;
> > +
> > +	/*
> > +	 * The SoC manual said the register setting is required. Otherwise,
> > +	 * linkup failed.
> > +	 */
> > +	val =3D dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
> > +	val &=3D ~PORT_LANE_SKEW_INSERT_MASK;
> > +	if (dw->num_lanes < 4)
> > +		val |=3D BIT(6);
> > +	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
> > +
> > +	val =3D readl(rcar->base + PCIEPWRMNGCTRL);
> > +	val |=3D APP_CLK_REQ_N | APP_CLK_PM_EN;
> > +	writel(val, rcar->base + PCIEPWRMNGCTRL);
>=20
> I don't get this either.  You do this "additional_common_init" part
> only for the existing "renesas,rcar-gen4-pcie" and
> "renesas,rcar-gen4-pcie-ep", but PCIE_PORT_LANE_SKEW and
> PCIEPWRMNGCTRL do not appear in the driver prior to these patches.  I
> must be missing something.  Or this is backwards and you meant to do
> this for the *new* SoC?

I'm sorry for the confusion. This is for the new SoC.

I should have explained before though, existing support SoC is:
- r8a779f0 as "renesas,rcar-gen4-pcie" and "renesas,rcar-gen4-pcie-ep".

After we applied the patch series:

- r8a779f0 as "renesas,r8a779f0-pcie" and "renesas,r8a779f0-pcie-ep".
- r8a779g0 as "renesas,rcar-gen4-pcie" and "renesas,rcar-gen4--pcie-ep".

Also, I have a plan to add r8a779h0 support in the future:

- r8a779f0 as "renesas,r8a779f0-pcie" and "renesas,r8a779f0-pcie-ep".
- r8a779g0 as "renesas,rcar-gen4-pcie" and "renesas,rcar-gen4--pcie-ep".
- r8a779h0 as "renesas,rcar-gen4-pcie" and "renesas,rcar-gen4--pcie-ep".

And r8a779[gh]0 need this additional_common_init.

> If you need to limit some functionality to existing SoCs and add new
> functionality for new SoCs, do those in separate patches if you can.

I got it. I'll make such a patch if I can.

Best regards,
Yoshihiro Shimoda

> > +}
> > +
> >  static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie =3D {
> >  	.mode =3D DW_PCIE_RC_TYPE,
> >  	.start_link_enable =3D r8a779f0_pcie_start_link_enable,
> > @@ -533,10 +715,14 @@ static struct rcar_gen4_pcie_platdata platdata_r8=
a779f0_pcie_ep =3D {
> >
> >  static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie =3D {
> >  	.mode =3D DW_PCIE_RC_TYPE,
> > +	.start_link_enable =3D rcar_gen4_pcie_start_link_enable,
> > +	.additional_common_init =3D rcar_gen4_pcie_additional_common_init,
> >  };
> >
> >  static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie_ep =3D {
> >  	.mode =3D DW_PCIE_EP_TYPE,
> > +	.start_link_enable =3D rcar_gen4_pcie_start_link_enable,
> > +	.additional_common_init =3D rcar_gen4_pcie_additional_common_init,
> >  };
> >
> >  static const struct of_device_id rcar_gen4_pcie_of_match[] =3D {
> > --
> > 2.25.1
> >

