Return-Path: <linux-pci+bounces-21669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE477A38C25
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 20:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819841890761
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 19:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71618236A6B;
	Mon, 17 Feb 2025 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O4lfIddJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A062236A70;
	Mon, 17 Feb 2025 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819578; cv=fail; b=BkkeRh1BFyPBmiFB6VIRfXqHl9E+UYH97lFKgGul8n5hXlLI1aYI4XJJ/DLbnwPKaWDNDYHZrIi2s55R/PvDSGtTomCx+GK1LSYSLYqRJS/f5YUi+FWCa3K2KIKPi4mWB1fIKgqkSmPpp9yQ65Y0VG1/uyix82kKjWfQLD1MsLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819578; c=relaxed/simple;
	bh=jdYR+iHo7BCCc+W15lBy6i9E7+KgZ6UiiA44H0cXHR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nt+gWoaWjLr791/YXOieoxLJJffThj69ALYiQgPrRYmAKLPKxLSP3iiDg+ox03du5eLOrZBsCGc3JTwm8NxjhP88V/FepAVEikD2VwI+RNAuUVZQx4UBH4188o63EnB8gZgDO5JqW4imFHQUVD86raXeSmiNJdzKjNeqdfWx0vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O4lfIddJ; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/sB4lU0+vCAZrFcjMhA4L+B/J3IEPdyWH4p+JC3kZjtyJ1qUuYgbN+NQ1jXynSjgAh5JIxSTKhxVWnmHPZT/50fNU3HVNt/7AuRvPR500W3EG+DDL+ktvbV7jgau32a1nqc4620WglRvHPaEe4ryBnsORD28ztWDswrMQqbswOBARhFPhlsVZgTurQRtT5xQLghy0xUJ9HEDZBmdVZ8txs5DqjPWC0hrLkvSlgoITWqs+eRwnaze0TLGLZSdddgtN01GgI4T7hyMN6hbgydON8mm151Tnuetuwm6X1d+HHKzVv4MTjyVaIElfXQYBV/OOW85orFumqSSjJlc5LvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw+vg2+asw7Ima/jqWalCNfNDhnsHJEw+ZB3zXMkfNo=;
 b=HKlQ0h3syHYR68nN7N9sR3gyBefMNtDOa15k3cQjmr0bRU1ev/YVYbzjnk+kQ5YA3bTFwtph5dauZxw+x644nkKErOQfoKi0xIqkZfh9B4w+0GjOqsNK3R9MsTyVQq60gm5Hjwb21OqgW2laGLYWtd/4U3V4VSNB/ZVfRX9p0Am+sg9sy8+lmu9iyEw2bwNIRUiUOlUMl/wfxJO7jn3zJFrhozaMIQHw3PLuCT5ZRG8mEcd0xhfQ4j8rSQGrm5XWAiSKYAADt1yLAv7mF1tc9du8CvRnokUF18gKkLJ06hDjb2s2HIx+FUDm3lpUaBPjKgaSuSFenKh1rxJi7Y5r/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw+vg2+asw7Ima/jqWalCNfNDhnsHJEw+ZB3zXMkfNo=;
 b=O4lfIddJv9vbTmyr/5sugxtP1dMrwVhlU8yN+KwntSI0SrNt95Xume2bSMRc4viXtFI7jm48HKlQgWYAAITGP6BhDeZzWs4yD35DortfgNwjyVeuLtRu52odr1KVzKaztJYrv+L2+mU6wcMEHFvxOYS+2QGYoqcwpKPZRQ05Ni4=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::623) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 19:12:53 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 19:12:53 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>
Subject: RE: [PATCH v11 0/3] Add support for AMD MDB IP as Root Port
Thread-Topic: [PATCH v11 0/3] Add support for AMD MDB IP as Root Port
Thread-Index: AQHbgT0R5VqloKywf0eVzOv5nsz4BrNL3OlA
Date: Mon, 17 Feb 2025 19:12:52 +0000
Message-ID:
 <SN7PR12MB720157DD806CC9B2A4F945F58BFB2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250217130828.663816-1-thippeswamy.havalige@amd.com>
In-Reply-To: <20250217130828.663816-1-thippeswamy.havalige@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|CH1PPFC908D89D1:EE_
x-ms-office365-filtering-correlation-id: 1dcda424-d031-4469-2873-08dd4f8713ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FNi1kU6zIYGm0S3KL2NeOIAW98drrS4zG4OlFkEldQSjZdTpsLd2PteE+r1+?=
 =?us-ascii?Q?puYYEIG8UXlnATsYIAv7O/aRdsuV3BTFelmnNZaCNFLS8W/8FyoccAVxnHKf?=
 =?us-ascii?Q?dS1nz3aC7tebZyq20n2hQrh485AL7kGVqM8o8qWaN/Nzyw1KDUpp+RSzfaTj?=
 =?us-ascii?Q?hBj8WO3WU/ZHl1W/l+A1qCm+HPt56xVoisfL5pRTnqG2ZCzKtX/gOQFGcNEV?=
 =?us-ascii?Q?t8pfxK/p/vAqICt3HAy+fUIdVilkPn1WkSDP+L3LH45YErbZefzXOR2JFbmo?=
 =?us-ascii?Q?u3fSagHZA/hTAI0lUBEuV3j/wuXnpwcAEykxPpjodsvt7sCoSumED3SFeLge?=
 =?us-ascii?Q?YlPOGhOok/ZeHfvmhnq/O5N+0fuhY0WPJv3MIGDXY2NZ924votDBnM+ZPWk1?=
 =?us-ascii?Q?UqkKvfeYPzcaOh/3mrXGUTRSw0l95gOwQEL8kYlkxEtlKrpzcfD7Pn/pPO13?=
 =?us-ascii?Q?DB71gA9de0WRIIrj/S9uGnkVpkvFbTLQjwNaF9dpmLZQUtb++zg5TyWUuAds?=
 =?us-ascii?Q?PEgPQa+CQl9wu/l4u119UkO1RDcvdfIZuI+U0BeG4dN9g9S/X2zMgq895WXH?=
 =?us-ascii?Q?sVcHt45pNvE6a7tjIpXhx7ZZ+wouZNyDlwzCwl/JhZ2mvEQTHmPnpUAMoaEW?=
 =?us-ascii?Q?r43OJbIuG6WIqDXLOuzVtS9BoNsgSRm8l7VeqdwTIVuElNB6aZnuLJcuw+uK?=
 =?us-ascii?Q?Y0Bmvo70zhdVP63ZSQtroZDA3iNGouQwZ0BMfNLcXn0Epw9BJ71Ql+dNMEFl?=
 =?us-ascii?Q?LYdirN+6IQ4qHdm5pX1t0yGu1vb6YzTQLJ0Pmc3qqZoeKM1XnLKM4unWuSOB?=
 =?us-ascii?Q?THPnGT304vZ7UhXLF9bvLtBx7YTRNt/AB1iQ/1IP9S/kV8mrc5goZ8K8Hpx9?=
 =?us-ascii?Q?5k3Yu5WxF5/cYEbI1AwAIbSwOcx+2SQK2dbiJqO10ntZFie6H5WHGzpza0C0?=
 =?us-ascii?Q?Xb4ylOy7c81Gfpj6FnFSky9R69PdA8fz3tRlc47w/NIo0nSd0zyaQcWN6/ur?=
 =?us-ascii?Q?L4RYh6rRiZ1j/SYpKIxNO1BxqUb5tASZndTdEBobBkROWOgp0peBe/ASiVzw?=
 =?us-ascii?Q?GJR/F7y7y055oUHN1KmWA4jHeI2JgKMllYcvdrtyLhldBHRVwWp3XnHedX12?=
 =?us-ascii?Q?Kh9wcvotfDl+aGJi8yNFrMbtOTMPkfUzhOIT01PNI3eyO3ayzIv+U1Ny+ohX?=
 =?us-ascii?Q?kaPS/qKgCqGMV142yVTuLF47/YdPy5O91MQjI3ihPHNMswAqTIZIOt0Vv603?=
 =?us-ascii?Q?BxRpBtAkImC4zjx93Jyi4ExBL9JiSMx82yPnXPS+9rXvK8OFVehdMGmbc3mL?=
 =?us-ascii?Q?5nsWY3zrDoNbrXl+wwYVy307pVY8mguh3IccuedZczKwwWdwCmubtlQLDTWm?=
 =?us-ascii?Q?GbUrKoGuXBwQWv8rvftG34KHk0vThnGENW0AdM3fY0SsknDn8YmwcucbkVL9?=
 =?us-ascii?Q?li3UpbLOAkwDYJNw/i8kkjHaAD8y6cQg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XVQtxawFpnIdDS0nC/NpvPQRn6Em8FB8LI3V2n+BJPoYtsmO4C49wdZlAmLq?=
 =?us-ascii?Q?6hpH21J+8uhkLeLEH+FUO7M33mdFoQ5Lhl4zHjMxbQpTcVgbC1yxwYls6g5b?=
 =?us-ascii?Q?ctakv+UtkYM6Nzo1NxTeerUeMLYIKQE4kvOp1vzY+RNmjXVdQi6iDq4y3C5G?=
 =?us-ascii?Q?IRGw/t1IoryY0tSlQHWjxuYeqpbi1t2yKwwQNcrpeY7XjU5iNEiukiU1Ze4/?=
 =?us-ascii?Q?dye8YhpQGt8chX58RuWt07TRsFeAiMBvDVx/jdaEUpDJMvzD3sQjLC6MTel2?=
 =?us-ascii?Q?J0GMXNVnBADSMd1cL795p0p/HOcUJnUHELr5C2uhllNLNAL014n2Hg+4Gwlu?=
 =?us-ascii?Q?DqbXzoqBSQZgjoiSD08ZWw954Aw36xTUQmo6Xs1xexUwbDqMAVBoeMJCW5fJ?=
 =?us-ascii?Q?RZcLSM6Vk4CQK5EvoQjzKyr0J0bzct6ZZvbWrOO90nHBxYz+2yX0mOmuOlbA?=
 =?us-ascii?Q?USOiAH+iKl/022c1FTzWSfiAxNLAFVR90F54rfGVUn7CfOBNjy+2tbtV7ls7?=
 =?us-ascii?Q?x3wGJolA3c61eQ+au14seTGkd1pks0zTXdryOnWThDv1vVXF0wF1dW2fAlO+?=
 =?us-ascii?Q?L2v02egSlY2gWGvhvkfm81sg58ouZe8FzwisfWErAm+U+MKKnr0Fx5eeDpxY?=
 =?us-ascii?Q?9dTvq+NBlCCPtj+FBBp253X7iB2Q4z0jSWDYYxKMWgTMl03MNw2mNLjCqyPO?=
 =?us-ascii?Q?9TrT7/HxtWRwmrwQDMtm13IP76Fqyjve+xMIsjd+PBDu2sIEda6s23S7NpIY?=
 =?us-ascii?Q?dEo7jJhMsX4pgWEV3gFS7yNUT52UAA21HaheSyYFUey0Bs4eGU3iNXF5lrsB?=
 =?us-ascii?Q?xorzphAT/KytvrhVECN61j/SH/oAelipdQQv725UrO7LxKGucj/ucaWUYDgE?=
 =?us-ascii?Q?7vZAmzS6QcPt61/JPsN1WZq++G5I57lZnaQmHJdt80ZKWjR5xYxXlm3Jsyjo?=
 =?us-ascii?Q?2+/+9SXGC26JJbSU1KEeIdrcRCiKvQyjICX25a7a6ES1qUYTHikO8Yf1XTOk?=
 =?us-ascii?Q?1tP+UbsmhsW6cpLByN5wj8QAnWyL5NA7E2zVurjYyr1AfjD3ix4u7vMwEdTY?=
 =?us-ascii?Q?OzoHNqCdvdqKvpiJc+V8PwmtKh+va+2FX3HwrrpDGjsDhNf3fxPuLkFI3RA9?=
 =?us-ascii?Q?kC5hkCkzJRg/WBvC2+BhR2ypzNMshUKgEbSuSyxRjsI6bhreszFccwDIgifN?=
 =?us-ascii?Q?8G5Qw1T/OtfCLCe7Z1pgJcja5CFWG3oDpv3zv0ND8jDMr0RneFaCzS8Uhm0k?=
 =?us-ascii?Q?dSppfoqet4JTJRvLFi5xn82Te9epko3DyO3mdqMeoX6dVyd1pafvPE5F3GsI?=
 =?us-ascii?Q?QAJbw86Qgk2oykjcg4ysz34DuXiGG/MwutDcN6r9g4FCE1XG5b6mq5EpHNML?=
 =?us-ascii?Q?U9InLQ6NjYmvCxrbK4rjHDLaHKi/4i6bqZs3Be2fQOXRXf+Vp3Xd++Sp6GTq?=
 =?us-ascii?Q?QozVfSNTPT3ctrz84uDSyWCZwWX3mHtxRQWeT5z7/SLB1iVabU8lxtH3COcv?=
 =?us-ascii?Q?3AkPsXcqC+AZtgJEdqR7dPfo8pwKV5e5UcR1EXngymxLRqdx+l/do8TUcQxy?=
 =?us-ascii?Q?veeRYpSDQIzVcub4RBk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcda424-d031-4469-2873-08dd4f8713ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 19:12:52.9484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jav1CvpPJeF1+OnWgnh7fgsxLnVXiwZIUDfnKCOSV4Zq2GT/3K7qGZ0r6/mqdw4u+dj2EjqL3hl24V9OEvOEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1

Please ignore this patch series. A few modifications have been made to the =
driver to handle legacy interrupts, and an updated version will be sent soo=
n.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Sent: Monday, February 17, 2025 6:38 PM
> To: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada,
> Bharat Kumar <bharat.kumar.gogada@amd.com>; jingoohan1@gmail.com;
> Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Subject: [PATCH v11 0/3] Add support for AMD MDB IP as Root Port
>=20
> This series of patch add support for AMD MDB IP as Root Port.
>=20
> The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
> As Root Port it supports MSI and legacy interrupts.
>=20
> Thippeswamy Havalige (3):
>   dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
>   dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
>   PCI: amd-mdb: Add AMD MDB Root Port driver
>=20
>  .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 +++++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
>  drivers/pci/controller/dwc/Kconfig            |  11 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-amd-mdb.c     | 474 ++++++++++++++++++
>  5 files changed, 609 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-
> mdb-host.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
>=20
> --
> 2.43.0


