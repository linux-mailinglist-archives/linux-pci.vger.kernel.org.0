Return-Path: <linux-pci+bounces-10717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C5293AF60
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053AF1F21729
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799B615252B;
	Wed, 24 Jul 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lhk2FzCp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861312D20D;
	Wed, 24 Jul 2024 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814614; cv=fail; b=A1oInp54NpDCXSPVrvghrnYK5hDNSOOW606our8XRfSCWIm9ErI28AgNMxQjfKr4A8nv62q4si7rAAAhTFiGePs41MnN71KFtGO3hA+vfYT0qdPYsGEv+8Y5I2A/95xXRtIwcVzYCo84H420ZTvVizcNXdvVwurpvo3PUzvhIpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814614; c=relaxed/simple;
	bh=8xpjORgviKIFhkIvPpdYTOYXSwFTMl/1gtHvyBJfppM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6247TtW++21Azj19G6+7wMDKMSpP/mf8yP0XAiJQxvUDSqGjqyMZeaz8e1FINzJLLXdyS7CKUIOZOwwyBhrj6e7XzKB7x0wIC1+UvIIuT9/5VEcXkSDN0KNg6XQExRyEw2uoVw/r4owlIh80no6zOorPPsDSFH/GTdstv2dotM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lhk2FzCp; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ng1OxVc1jms9/AERSETS41cP/gcNq1NJSAsPjMA5/ZPvISt2Pwc9pG6KAedddv7si3ImzWlr/6pYJV9pOXXnWzJiCjZDOUrY2zLJaZRBEROOLKfpDB5dnrxKVo1Urc5uoGgGvaMYsUyIrXe1gCbe8TcYyMah3B3bjLfr8H4Dkni4p64HovMBp9bA8qy24b4F2NCZBtvApbJx6WyaAwlLzBV89zwmpDNyPRZkyGAelHnwDslybAtvUQwuSWk4BlMv3zqoU0wnRJTYvQFGq/hht/Yl02H6qcq8HudQdBnk332kj0cZ1chu4aVkwcy4USY9P7oj2EXwvvDLLPUYguyGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJ0cHPQbY8dJdkSkfonXmSgZjLyR5/CvEUKkw8o1BYQ=;
 b=pxdzkFPpKd1T72XqGZlH5DDPVHJLBWK6p9vW59UFYP0WH6XbKQjdKQ6lLns4BFerHJEHVQkGERtK0p9/7+DdvHTk0CIlR2BDXBPCnu6Ya0DsoZ20ltrmVbDSidArPwpoazTG62vMTh+CakSlLrk7w8lwT0udcUhDAKdhK95zE0g8kYGHGfPx8Kywrlutf1cfS7HIfZKRvsONcj/39KVosnHuUIWM/n+4L2289MsHswBO72NoTNOVHmh/aknJ0FtTrpQEc4Zh7tVWqmQRvkS5fXwtYfrYDLa8dk9IxOdfcS46BaIgSB206l9mDIXJR9EnXH+qqad+jf2g7GYc6+NDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ0cHPQbY8dJdkSkfonXmSgZjLyR5/CvEUKkw8o1BYQ=;
 b=Lhk2FzCp4oNZKXylmVIxmOAXnp7qNZk8G/pcKIvxCszbXazAK+g0DFuKJOCndkHQu5YJGbaV1Kesq9vvqiiLyNDgOAL5XVx6OhaBGz54bJ4FL9bhVkK516lv4NWRNFV0pk3R3DIkcYFjAoihZOmfCQtYjOANnJc00iSzGdLwQ0E=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 24 Jul
 2024 09:50:10 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.7762.032; Wed, 24 Jul 2024
 09:50:09 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Simek, Michal"
	<michal.simek@amd.com>
Subject: RE: [PATCH v2 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
Thread-Topic: [PATCH v2 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port
 driver
Thread-Index: AQHa3AAboIgN/iJ3ckGYFHO38rdqEbIDUS8AgAJUVwA=
Date: Wed, 24 Jul 2024 09:50:09 +0000
Message-ID:
 <SN7PR12MB720146D04E0794B5A50B69BB8BAA2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20240722062558.1578744-3-thippesw@amd.com>
 <20240722221500.GA739438@bhelgaas>
In-Reply-To: <20240722221500.GA739438@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DS0PR12MB7702:EE_
x-ms-office365-filtering-correlation-id: db8f10b3-b2e8-442d-c9fe-08dcabc601a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yYNhCoWIfQykIWqDD1jGPGIea+YLwBfD7Tto373IpFBG8Z6Bh+joQ79TnxAs?=
 =?us-ascii?Q?VIexokvYOLgX0Fp6FZ0G3LJrhrFXJXdxADF9EJ2s94eEwPXtYsz/pGaqZoee?=
 =?us-ascii?Q?Ojo4WHoMhc5qYPC+wDwlLfcmt2Z9QG4vqOMrjks3niqhzjlhYgycl+gU5dOy?=
 =?us-ascii?Q?dwlAf8pzNl6bZIyfnl6u6QwN3pFU7eZa3cLjrNxDLtaP7N70CCJdJWZjaxX7?=
 =?us-ascii?Q?Ox00MxNc6A1RKJlHEB8+Bm8viD2+JGK8tb9uEG5p35xvNEphlxNo9C+Bn9mu?=
 =?us-ascii?Q?h39KXfM0NnR+aEReLOju6sf1rRwftHPZhUeQInaVeDZtD1/JSEHCy9RVKzJq?=
 =?us-ascii?Q?o23DkzLp+RLYpG9UyJb0WjbVSi+giSAqDibUXcjS9kSYYLJHKoBzsJTQqUBg?=
 =?us-ascii?Q?B9FOsumfObrGkrGw+8I+jqpHtoRgXm37aMbrERG3yvOW+He8MRkdnEyyjE1f?=
 =?us-ascii?Q?krJSdcjWEsYfrx/cPSKty4pOmG7A8knZSG6pCaDy8z/UzaZCc0nuL6jZEE1h?=
 =?us-ascii?Q?tnEZgzfKqkwa6xx9luhOJtWXk8BNbA6+h/kV4aiGxuHKPPnRFvCWMAc5AJ0G?=
 =?us-ascii?Q?v6o/4ly2kfFcxy6Q9Er9FPaz80c1rGPsvTMprYYQ4G7rvuo2WcNDETaxlZSi?=
 =?us-ascii?Q?TiRqCuVVI35Hts8NXYg8QrRzPqn7xT9PFLw09yk85LtcdCckOj/gBBPq9uEm?=
 =?us-ascii?Q?Fmm4SHmzPIidTkEDtywxZ7LYFfP31oQYECBSgPyBMEV7O3Za25ACgKxlvYw1?=
 =?us-ascii?Q?GcnTTtEufN88OSsMhDPA1ZFPkJI8ST5PZt9uumLjwOQggtxN2I+TdBpnYs7x?=
 =?us-ascii?Q?X5Uoch8DjKmaG4mt4l79ugFdD7+S5EnQlU1D3qtHIVWJ4FeIcbUoiocvCUKr?=
 =?us-ascii?Q?x7fjxHZfMLg2ffY2XMVAl5XkGCUBd4KjqGdrxsgPhnvcsV6gqvKbqHxlDcAK?=
 =?us-ascii?Q?UlzXc+jCkQbexPXnCtOcQrEmeuEhNMicpd0iN3jK2UPAg3YFBa/tk41wkG2U?=
 =?us-ascii?Q?+p/GefvIBeQttJJRuTiZme0klwxHPQUwSS9u6G+7XZvEbeIh7fR+CMbNBLA8?=
 =?us-ascii?Q?XXzOZIfSADXqeiWxazcN+tSEoWmmfDjIl2ZB/BInjIXUReM+I4pYSqpaKJtN?=
 =?us-ascii?Q?tIjntPbNp70QcMZbpw10jWPf4QfZo3xtGnQduX4vmiMDAhBLsqJ+6oTb2xyi?=
 =?us-ascii?Q?91h/M2xC0vzUQx4A2FKJG4fryOvaCS1NR+gd8VOX9QXdi0oTbwx5RhxNo7HA?=
 =?us-ascii?Q?oacmEM2uFjdY2qQsRpdCkg/yIkr09C5kpNO+2mA3R4Ea0gsfXbNLK+0Jztat?=
 =?us-ascii?Q?hSZ/IJmJQOhND6jQGcy63k/NrxaqPQDQ/a4GlnVviAO0eJbgpx7ZggyVygxd?=
 =?us-ascii?Q?UOBMv4Yaipi+0WfueFNPDBeCl8Tj+FbqOhQWpUyYSSi6sRnEXg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j9DcXQbF2WajqQnxGo9KSK+26m6cn/O9912c2RQ24CynFuqr3iunn3OZtWGb?=
 =?us-ascii?Q?Xrso/nbRkTybcQergHTs8/hF/qyvMiFo1wwJFhfGc2jENnUJ9sL7IU3A5MtB?=
 =?us-ascii?Q?ETs49CiBBIhKROZoTvgEPM5HUmvhpjPqZrlIvmI9WMng/hdHc8h1K07u0uJM?=
 =?us-ascii?Q?OROfhx7RIitOxdhZi56mid81C/fyo7NMmzh9s0nXtmZ8L46qBLe4XQKpPZgi?=
 =?us-ascii?Q?XEQz+3q4Vp1p9vH+Dl2xeFpL96yieGeP1h+JaOtRuUXDXYAz4ogd0tqchCwO?=
 =?us-ascii?Q?el13QuLabJbnvG2G1Hm25+Ne1HRV+v0O6YVo4YUFhEA+VRU/FCIHyX6XiUSH?=
 =?us-ascii?Q?0TFMh/0f9bVHhqD5kfQDOs/X5fBBBaFnNEfTakBpsquxeQgLBIUKPKPnGKvW?=
 =?us-ascii?Q?P+Lg+yROFtxGr+9qbaOWGMOZgL7wvHU24H7pWhag9BjANm7VlpzijEN2a1LS?=
 =?us-ascii?Q?txJV3mt9RjKlUgjPA+bGZ8fCaqqkbkmj3X0SdhWmffe0EZeN5/a6xElYKCrw?=
 =?us-ascii?Q?EUFkTtuDruH7CdP+/mnjMlqgJEzdF94FMnhatpI6Lp4sPtZl+lZw5OfS08Y2?=
 =?us-ascii?Q?2cYySXc5NV9s7Bjo4bJxYv2XJvaVSLKF2DYyrGDdRGScnhSt6vnsHSRgBdzm?=
 =?us-ascii?Q?4OeNDIWbiRkZVdAQiKuib6Z7lUtdZHb+oJ5NICZhPfE1JmxZLkGogGodXiKv?=
 =?us-ascii?Q?K2R/OnyCEHq0ng9dPzuefY9rm0Z8vFfXXEHkyKuhzlUufbwy0bC8XuO1X/nI?=
 =?us-ascii?Q?9NklqrWt+d3k8QFKvnwzQIme62FGBZQO+memNpIG8alW4QBrvX54+dTvv/7T?=
 =?us-ascii?Q?o2Zk91WlszLBil4QNAIrIN3j80cAq+LtcTUVXE+LEXwocu21Y1zDmoBUs/mr?=
 =?us-ascii?Q?i/JcGC2Xy5FolgKWHSd3Mrx4df224J9Oq9sAFuXXvq7bw8EVHuSNFpeKdajb?=
 =?us-ascii?Q?KlegCWg8aS5qy1n/HsEuHkX1SOu4HQHLb8O0EAyNyBR9hIehKaAeH6/NDA91?=
 =?us-ascii?Q?LXgKKZ5UoOK7hTVUwE/NB0c0XXDJjeWC+cfmDF7aVm1i+eRHM15KHBippuXp?=
 =?us-ascii?Q?WWLpQ6zNbnROWo+FcgBedN1tO2WIdbmUOspdtbVQf+oDGR9XyXRb94rN1DDS?=
 =?us-ascii?Q?Dm2BkJvkK4gQJHoZTnC1BF1CxUhfb8/pITtyOblhwV8tZOOZcc7GOzhO8sa3?=
 =?us-ascii?Q?OiQQEjBmgkfN6TtIje6DRpKH1x3yXlcwmGxw50o78HDgvzF2KjTdYeGTAUJr?=
 =?us-ascii?Q?Fdf0s1IA1tQEPipRsZXEym3PTJ89poL/WCyMqOH+KBEHrnC2B7fs8/aYQ5P+?=
 =?us-ascii?Q?wMCs43/mGrkz+p1sFs8WMcFrCrXSe82Ococ8Pbl6CElm8ERYMSx0CJQEYQvm?=
 =?us-ascii?Q?m9bEpCEwa2+1nzs9Ivkg8WIxKF+OuvLhEYvblNcyp3BZaG27Sw3eXpqmw4fb?=
 =?us-ascii?Q?v12L5S5gFd33uTObZswPgiTSdRAMLZQ421zJzmwf52LCAwaZWVASLo2J/u0J?=
 =?us-ascii?Q?EJJ6ZudB/Hbzc/JS0Xf6UfxYlZ3aYmyjwQjEyuVcM1aEE7qw4nWzk4GBErhA?=
 =?us-ascii?Q?MBo4SXvLlDy8wjK/Rzk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8f10b3-b2e8-442d-c9fe-08dcabc601a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 09:50:09.9162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEnwSjj6rEyPc1APuL67OuCd7b1sZzPhH1DUA1gzAwrA5PdKP3w1ePCVxrT0puVOGma1qBOaVk85l2iQVh592w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

Hi Bjorn,

Thanks, will update all your review comments and resend patch.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, July 23, 2024 3:45 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; krzk+dt@kernel.org; conor+dt@kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>; linux-arm-kernel@lists.infradead.org;
> Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v2 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port
> driver
>=20
> On Mon, Jul 22, 2024 at 11:55:58AM +0530, Thippeswamy Havalige wrote:
> > Add support for Xilinx QDMA Soft IP core as Root Port.
> >
> > The versal prime devices support QDMA soft IP module in
> > programmable logic.
>=20
> Capitalize brand names.
>=20
> > The integrated QDMA Soft IP block has integrated bridge function that
> > can act as PCIe Root Port.
>=20
> Rewrap to fill 75 columns.
>=20
> > +#define QDMA_BRIDGE_BASE_OFF		0xCD8
>=20
> Other #defines in this file user lower-case hex; please match them.
>=20
> >  static inline u32 pcie_read(struct pl_dma_pcie *port, u32 reg)
> >  {
> > -	return readl(port->reg_base + reg);
> > +	if (port->variant->version =3D=3D XDMA)
> > +		return readl(port->reg_base + reg);
> > +	else
> > +		return readl(port->reg_base + reg +
> QDMA_BRIDGE_BASE_OFF);
> >  }
> >
> >  static inline void pcie_write(struct pl_dma_pcie *port, u32 val, u32 r=
eg)
> >  {
> > -	writel(val, port->reg_base + reg);
> > +	if (port->variant->version =3D=3D XDMA)
> > +		writel(val, port->reg_base + reg);
> > +	else
> > +		writel(val, port->reg_base + reg +
> QDMA_BRIDGE_BASE_OFF);
> >  }
> >
> >  static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie *port=
)
> > @@ -173,7 +198,10 @@ static void __iomem
> *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
> >  	if (!xilinx_pl_dma_pcie_valid_device(bus, devfn))
> >  		return NULL;
> >
> > -	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn,
> where);
> > +	if (port->variant->version =3D=3D XDMA)
> > +		return port->reg_base + PCIE_ECAM_OFFSET(bus->number,
> devfn, where);
> > +	else
> > +		return port->cfg_base + PCIE_ECAM_OFFSET(bus->number,
> devfn, where);
>=20
> If you rework the variant tests above to use
> "if (port->variant->version =3D=3D QDMA)" instead, they will match the on=
e
> below, and you won't need to touch the existing code at all, e.g.,
>=20
>   + if (port->variant->version =3D=3D QDMA)
>   +   return port->cfg_base + PCIE_ECAM_OFFSET(bus->number, devfn,
> where);
>=20
>     return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
>=20
> >  }
> >
> >  /* PCIe operations */
> > @@ -731,6 +759,15 @@ static int xilinx_pl_dma_pcie_parse_dt(struct
> pl_dma_pcie *port,
> >
> >  	port->reg_base =3D port->cfg->win;
> >
> > +	if (port->variant->version =3D=3D QDMA) {
> > +		port->cfg_base =3D port->cfg->win;
> > +		res =3D platform_get_resource_byname(pdev,
> IORESOURCE_MEM, "breg");
> > +		port->reg_base =3D devm_ioremap_resource(dev, res);
> > +		if (IS_ERR(port->reg_base))
> > +			return PTR_ERR(port->reg_base);
> > +		port->phys_reg_base =3D res->start;
> > +	}

