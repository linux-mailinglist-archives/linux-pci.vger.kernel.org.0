Return-Path: <linux-pci+bounces-5987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A280B89E6E6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 02:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBC11F24BE7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 00:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF904372;
	Wed, 10 Apr 2024 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="k06zBxH7"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125928C09;
	Wed, 10 Apr 2024 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709164; cv=fail; b=b1/Co5/rSfLr9wigGEWGhtS9Iv5wgHzCZbT1w5JvR7Q2FBkqjvRn8VkCf1EbPbKA3zrnoLAiA127h43L28CYzF6HOwT7R1og2K6Gm6oqDQugNYoCNnmqM6qZFsFKMbRXYgNMKJmTR69cmXVgTq325JWZ2xoObe7iDDgB/nnIB0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709164; c=relaxed/simple;
	bh=tFh28x0cRjDmoIWFKYsnO/fCcyohrKus0NbuXGIAhnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=egzEeroPdNTJ1h2iGP7Ji/BxEy/1BDYefwHaCq4HXqlcs3HRV+X6FkMAnu94M0bGAz0H6HhvVgWhh3HQybRZ3DQ+PTaumvfcsi8sBc4pwFyOGnMlD25v1AxjEBPC5Tit92maLvxlBHyrzMjs3zCJpAnTqBKmqvHx6sEVINzgoSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=k06zBxH7; arc=fail smtp.client-ip=40.107.114.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E78ImIqhWW9mF8mLQPnnkjLo+NYOnXNbeER8onOumR7c2v/5PBL1wVfKvHT9qUaYP8UHHwBuiDLKGneUjYbcVvH6o9MsuujpitEZ6nP2ZEfAIU3bGq+uzZK9mKlG+VxMkkbZrteNmgZSTYDMJbfXb3o8MZvJt/zWVm09yhPPgsGH541Uywjgh5LgepjyZcZ8nDL83dv6Dvevogb05vcmm//iMsm8cE8wImYUf7TTpv77hyOXFVK4o5k5M3ZzE3KnIpCTCDnRH4YEJqL6RfvNwtJJL57xP7Maix7Qd6OvoPrTM/XDp+2cvx210BydVq8bX0tT1nqJfrYpZ1+qi1aRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9f+ps574U/oSAk/3DSsKLH55tLw/R2jVPDIthXJWAw=;
 b=PwgmISqymmn3wGQfVxD3c9R7vHD2RhwbqB+ADEk6nIZF4rFAz4ixnUXm4MUv7gJE/jgbGjW0FFkpXsLguNNdl5pETdvqaIfy9UoRil2LOm4s+bKpEUG1ZK/Kwocd5z5nBE2fvaq4ETjDYHg/IQlJ46H5ot/ZHkvcIg8bCOgCMDYpZ3snoJoAgz28ZGuCi6KtbO4OM0Htwq7NQsuPPEh8nTho0YP9pAfqoGb4j5vYi5qOML122K8yt5ykDrPdwp83Aa886j0kxw0/+3JFIBrFrpq3ZPrRQU3UVAJ+UfGlr8rtZTgrXtEN2X0OBJrEeMFqbjkM8kEOYD3KYHDeJcmAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9f+ps574U/oSAk/3DSsKLH55tLw/R2jVPDIthXJWAw=;
 b=k06zBxH7DVqnTG787r+ivx5hC8DKrlMa0iMg+0ZcQCymilNvSL4oijzBwK1xiX9QZQi2iT/m5uuhCSXtkuHWi6pqKFRYKO9Zbe4//NIRa+PpmsXkMzIb1NY0r9GriujYVVgPX0ZditoyMucMYmpYXF1S7D7n4e9IsL9YALqlTns=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by OS3PR01MB9412.jpnprd01.prod.outlook.com (2603:1096:604:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 00:32:35 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774%5]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 00:32:35 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"mani@kernel.org" <mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 0/7] PCI: dwc: rcar-gen4: Add R-Car V4H support
Thread-Topic: [PATCH v5 0/7] PCI: dwc: rcar-gen4: Add R-Car V4H support
Thread-Index: AQHaiVOTjWVgEjKSOE2LtEqpFeX0arFf8N0AgAC5cqA=
Date: Wed, 10 Apr 2024 00:32:35 +0000
Message-ID:
 <TYCPR01MB11040F55F3AB462346F1E9832D8062@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240408012458.3717977-1-yoshihiro.shimoda.uh@renesas.com>
 <20240409132808.GA2071934@bhelgaas>
In-Reply-To: <20240409132808.GA2071934@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|OS3PR01MB9412:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eEFhjvqLb1/8Icotx+q/Il7G3goxVtR4loq13N5M+J8TV7vGxOi5Qoy06aYAw+h9cH1l85yX2kjcbXW8SE63PViUW3kRFe0vdsyRSFhhYZv5SLABIji4FrbRRrKf54DB0J/Y6ws0ttM5D+1OGob57dvbId80cjnJAEv5m/xSQyBMjxw6p29yLdRhEzi+ena07D/eUjwyqswCAaJTJL2yVxju+M4QUoHhbHeokR6D/6RJ8LAAHm7cR/2k9W90FZqf03JbEl75t9rn8H4JbiIZPhp1y4PcF/J8s95m+Lp/qxfQyDuY3//sdqc5wW5A5PQW90vYZY6+dSqkMOrBNx02vbnqdLk8cxc15fwerX8xFnNsbBUZOAkf+1Fg8hm2812C1C0wayOU2DmYih2qeu4L/VRYTRsApqQKEFOF1Ei27Ioz3Ol0cDZV7FQFJLy0bF4kxJMYCI3SNBBk7lvnW05cF7XWO98XEksLQw7CF+Zr9hE3xhhKSB/YolXOVQp2uwjtpyQ4bV6vKJLI9phYWnINOYZY+b76WDBEq8hmYXnsiiEKABTsZd74zQiaOYBmGbEMCrxRvl9vB3bdtIiKajond7w3ksR5WBLDLGwJPArmmM7gzaBXYl2ObaymRs5xSU7NH64598TKMjLLunmOU/EHrnJsrGgFqPf3Sg2KJLMwrTE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9r+tkf1adCAqjjTsYGoWigjdMxBJe+qffJ38h12mAXg8QtOqZPE9xmumSis7?=
 =?us-ascii?Q?86PJoP14mCJbmd9bo8Xrh9Hd5jcdy1mT76JX54Y7J8BURTeU96muFzUpT7u3?=
 =?us-ascii?Q?/4MNdWOA16stFZWyZjAuE/4WiL80OiL5h9zHZXX7Ti0JKde4LOYXGdT/IAtw?=
 =?us-ascii?Q?Klrn8JGPwWavguAeDYgS0Vz4RdoJinylNplD3zWlJcTJOTfa8jMMkgmMjR5e?=
 =?us-ascii?Q?zWYXp7CrOoQieLYu2P9Wuz4pyYAbL3BaYRv5AizlrOyuniFNPAwe2bSXjoaL?=
 =?us-ascii?Q?U//4HWBOVxsjmO8D/bhot0gXwjczLcF0pht66h0OJWrWHWiBVuCQy8+68aog?=
 =?us-ascii?Q?638zb4/GeTDEUSh2W4RdeyOnHr/orMJGX5Jr/08OJOLOQgqwvoi8E7Bv0Pox?=
 =?us-ascii?Q?/1yhcsKKmgZsfsOpiF7hLiJxbanKJmTYy3dya4PZsOj36NqZ5QzXjSOByYDY?=
 =?us-ascii?Q?PMl/KgjsjV+lcpN4lTIZfkxXZV94Zof2IjHToM1kOOUGo10wqGSiGjRgNggv?=
 =?us-ascii?Q?dfSEpNJpuFu5oCbYCJlZnUlTqyW/agkw6OdPquv2CWa31Kwmxlh2BFiOYDN2?=
 =?us-ascii?Q?IR2PwlawlkjOKTqyIunNcKhfyZtpy76i199B3RLwmlshrBBvGaaY7o+cUSvQ?=
 =?us-ascii?Q?2FzgwgSPlDnXL6g+/eJ3AUlrtakQBoV+9cHKG8/q21YTGoczlXx3OgXkqF+N?=
 =?us-ascii?Q?Zrfu4ql4Iq1jcLkQXhRuMSSemCRbLp0Qo74m5YzNbtWznlSqgGyqxzX/4/Ka?=
 =?us-ascii?Q?wV5g/qztexVbWazECbxg6GBcz+az76UYz6LEjpByZ9GDRJx5fMORzC406Ggg?=
 =?us-ascii?Q?Jh2SGK783iiA7lb4r/wMH8He0PhUKEUnrT7fQ8/+SSYyUNzoBs3/qXZ5Nsil?=
 =?us-ascii?Q?mFwRGZqpP/o19kwFYkOjvOHbCgHwysms5TGHU3nBu9NyCgZmhcZPyJ0qcrFb?=
 =?us-ascii?Q?Cfj1pEhkdAKkuB4asqALJisWVkAYiGBVrqYFyISM1RmR2/G9KMg8fyWB0/2S?=
 =?us-ascii?Q?65E1it5xbQAQuS6pweyaW71mjfwiSLgJUJLTxvos/5jeuaVv6dIKvm5w6feI?=
 =?us-ascii?Q?sM/j84sCA+u5dkwktNtmNbau5S67+ySPogSDGbtL1Mb40zIdWrkz3AHjlLh2?=
 =?us-ascii?Q?SKeF12GDRVzGtHt+um0j4XbQRV27S8Bzc2MXWdyZ/Q0uTZA8t1k6yG1HDTyS?=
 =?us-ascii?Q?2jjV4ZoKER1MBx/uxieM7O3f6FMWenwy+HyVLzczcS/krHI5rNZbiDqcyW6c?=
 =?us-ascii?Q?MmrOFRGQD/x9BYTiH0phxl0uqiLr5VtXJB0f4vmehQ4NooZdJFtVkMVh7Vqu?=
 =?us-ascii?Q?qLyeSHxLT83G+8hULQAzEfOM5qHlsfJmM500P1qRGorhnwjdhFGJYZNIWXbg?=
 =?us-ascii?Q?YIbDg28e+tIx+GA+YRBnBsATnVMHLJrOsOAy4pLGW7bV/Jr9wXMzoMMmrrXF?=
 =?us-ascii?Q?DsGsaA4/oEA/CJ3klE/WvhqfRg9dY6/9AoMMt/Hogvs6SWunuTCfFCImeNDM?=
 =?us-ascii?Q?A2WI1ycDGQ2cIgxKUK/RIXSTQfGxrKWRuVaexGISUDa85PBxfQADNOuTOv8g?=
 =?us-ascii?Q?7YmlgoZ6QkVsooJjDmdMf3wsYAhomgjnYm5qPb+TbVDeEKqTubnPbLdW4qTu?=
 =?us-ascii?Q?ZQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97757f13-0663-49ba-fb92-08dc58f5b7fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 00:32:35.6854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEuvJ4VXiSRuWsv3F3lhOCzGV0bJa7zxlApXHLHDzHjl41Qacbqg+tCeyuGa035YIEZwy9KG3ygtIQkYQbKJVli2oj5bEsXrRNeuNqKxM3dV9CUN8ldNU8ABFrlSLVOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9412

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Tuesday, April 9, 2024 10:28 PM
>=20
> On Mon, Apr 08, 2024 at 10:24:51AM +0900, Yoshihiro Shimoda wrote:
>=20
> > Yoshihiro Shimoda (7):
> >   dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
> >   dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible
> >   PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
> >   PCI: dwc: rcar-gen4: Add rcar_gen4_pcie_platdata
> >   PCI: dwc: rcar-gen4: Add .ltssm_enable() for other SoC support
> >   PCI: dwc: rcar-gen4: Add support for r8a779g0
>=20
> Previous history for this file uses a "PCI: rcar-gen4: " prefix
> (without "dwc:").  I don't think we need to replicate the whole file
> path here in the precious subject line space, so "PCI: rcar-gen4: "
> should be enough.

Oops. I'll fix the subjects.

Best regards,
Yoshihiro Shimoda

> >   misc: pci_endpoint_test: Document a policy about adding pci_device_id
> >
> >  .../bindings/pci/rcar-gen4-pci-ep.yaml        |   4 +-
> >  .../bindings/pci/rcar-gen4-pci-host.yaml      |   4 +-
> >  drivers/misc/pci_endpoint_test.c              |   1 +
> >  drivers/pci/controller/dwc/pcie-designware.h  |   6 +
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 272 +++++++++++++++++-
> >  5 files changed, 270 insertions(+), 17 deletions(-)
> >
> > --
> > 2.25.1
> >

