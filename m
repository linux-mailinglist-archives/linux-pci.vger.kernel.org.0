Return-Path: <linux-pci+bounces-34432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E637AB2EDB0
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 07:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5778179AB2
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 05:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1545F24676E;
	Thu, 21 Aug 2025 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NVTjRR1u"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053442A8C;
	Thu, 21 Aug 2025 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755360; cv=fail; b=ORnD+js1Gl5uHRRU9a1nrPlMEs+6fYnvOfC34usZiSVLPJxocVhXV6czysi7YmU9sDy7sL2AFlZXmv8WzIYiAmtJOi/n+rMoEpdi+MpDmO3vWQnY1dDjcpL84ftppaJsCMhTgYvKG+niTv1tJZg2aOFtZlq6+12oW69g8D0tA84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755360; c=relaxed/simple;
	bh=et9FYEkmOns2Mk2WNhjjcYVW+Xl5e2jtIH8z3IJGj7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZrUdHihx9BuvyltRq8Q2hcS/4uZvo9UCiRJHOMKzaMqanSIdga34EmOYpoAWedHS0h/OnqKUVSKuTJX/jE2gR1JBaF2urZiLPoTAxoCMKljphsh3XZamuRUUfLeSRIScXkFmJFe51D/7gmj+yTu3m+s+l/zo8ityWBSCRyAwDaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NVTjRR1u; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBJhMwEL2uU2be3RQI6GhN6BXEQAwaPeLAuSDUJvcSE8Gyi8e6H2T2RQleAz78CyrnG12tW7RgDhlpEd5TsALoj14BFQYNEwNwp17p8XRgeSbAe3uhXqjyhKBv59SzlSa6nJWSLqx+rOt7iOwUYFEsOgQ7hPICsHr9LbKMpb5yH4KeHakaAfVmBOTL4hsX/lZ7OPFIXdbHNuWvVIpoYvULQ7gKVY3cDbet35LHYMgVLGREcZtYEf6qgZQ02FKFZl0HKM6d3P53roKwacUEC5Sxi5ty6efqsBvCtBHOV6KLseT0sZrEaiJb95su+L01LERzb0IjTNQy9P5an6Bc3Ucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et9FYEkmOns2Mk2WNhjjcYVW+Xl5e2jtIH8z3IJGj7A=;
 b=GVa3/y7Ysz9QhhoTj8IOR9blA8Lpav/nAwDH5Lc/lVpszg4zrk6n6Sbqx8GhnqaqIb1IPUrSnyzM9I5JOkiT/mdB32KtFaQMCGkPB7bM1ADfuByaEhkeKtHsVvMWjeZS+a67AUHwH/f2gFZlJtI84A+7eIOKjk56qUP6ILga4vdentgrKh+X8YIYJFfYmKdVE1K/CYmOpBbOdsQPd5O1zKMocxKjMX7PKgn/3TIzycF5LSuRsHQn4OeR9uzzyqfzsT3OCxwp6gKjPBQRcs2coWAqkAduO/cxmnokGrHHodhkNuxxFEgGMVkCDA7vVlCA0qtNQpx1C8PFZQXkMsBaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et9FYEkmOns2Mk2WNhjjcYVW+Xl5e2jtIH8z3IJGj7A=;
 b=NVTjRR1uokCJZPdWLrV3IbYV159asTNznpktfHFY+I0UV2FQez4VHHOgjozx/cmry+rfccB6ZDNCfFfsb1Ah+34g/T5xxzHysSfFOGcucwYtUni6J70tQ2BLLcO85O+fvkEtyDBgkbRnb5K8BGuQn0nmIxzTCJT4yahvrwYjqOmeb2kJ0zl08upbnwMN60hTdOQfpkzHzbtI04KCtyUDtBb8k7aS0PzOrA8LN6xBcG3JYe2FVP5vyCi1/m0KeXBTPPBslumOt9ADa1PHvtFbxHDSTPVN0mWpWEsD+0xbK/iyH+b+p4K033N2tUS6mTC91Q6J/7/VGWkRicLFE9egBQ==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PR3PR04MB7418.eurprd04.prod.outlook.com (2603:10a6:102:8b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 05:49:14 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 05:49:14 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Thread-Topic: [PATCH v1 1/2] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Thread-Index: AQHcEaoI47lMqBduP0aS9EbLY1kIrbRrswSAgADnDpA=
Date: Thu, 21 Aug 2025 05:49:13 +0000
Message-ID:
 <AS8PR04MB8833CA96A5311F5CCFD87BD48C32A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250820081048.2279057-2-hongxing.zhu@nxp.com>
 <20250820155747.GA628315@bhelgaas>
In-Reply-To: <20250820155747.GA628315@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PR3PR04MB7418:EE_
x-ms-office365-filtering-correlation-id: 2d0b96c8-c17d-4b5a-d73d-08dde0767592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?K09RaDFLL2dUSmE2aDNqeXJITmJiRkora0xUVjdpZitWT3RNQSt4UjZyNEtl?=
 =?gb2312?B?MjZqNjJzaEczNVNLemt0aS9DMHZ4T2MxRWpCMEhZOHU1Uy9sOVRpQldwaDNy?=
 =?gb2312?B?RXRzMVFpemtaWm1BNUJBU3NCLzFCUGsxWWdkcmlXbVk5MFNQd1pYNkgxcmNJ?=
 =?gb2312?B?eXlhN3hSQ21xYkJaR2lma0J1SER5OTAyZS9VRnVaSFFHRUx1cnRWS2hYQ3NV?=
 =?gb2312?B?RGZCUzZOZ3VuWnhxN0MvTXRXR0g5MVZjMWQ2MnZ6UVk4WFZKcU1HTW9oS3hD?=
 =?gb2312?B?d1NPYTd6TGM3RzFVTEFYNmh2eWF3d0VYQjYreHA2T3oxZjJnYzhBa09oTVYv?=
 =?gb2312?B?VDJSMEpJR0NUOG5walN5TERKYnBJdWV5YjR3dytxS2ZnRi84eXFwOWxWR3dt?=
 =?gb2312?B?RGRNbEFzT081MldJTGt4V2laVmhwQzVBNkVqdnJENzYzWWpDVll2YU9Mb1JL?=
 =?gb2312?B?UFNIa2t0Z0g5dlFORWw3WmdtT1V0dTltSnhNT05XdHM3Y0EyVEhzcHc1V2I1?=
 =?gb2312?B?VHRDY2pnZm5oRWJwQjhtZWhIZ0pFRVJXMnphZ2JRdklRK1gydnB3TE5uRSs5?=
 =?gb2312?B?cGVYWGc1ZWhDbzVtUUxGa3RHWWFHdXNxaENKa3RGU2E2c1F6anNZSDA0dUY3?=
 =?gb2312?B?RzYvQmp1aG56UUE0cWQ4UW5OUS9FcW93a0tPK1l5dWJHSnUxWldmR05OVFZC?=
 =?gb2312?B?eTdMc3k3MzRjUG4ySXYyU0JXUHAzMFJTa1VkL1hoUERuQWFyRUttdnN0TmNI?=
 =?gb2312?B?ZFA0SlhGMUtWcXl0Vm5wZEJlYVFLQmVyTVBlRWVSeURZcEJOUU9rTjB1dkor?=
 =?gb2312?B?OWRsc0U1VjlKQmcrTHRLSjVORzdPWER6cDQ3WHVKbStIOGUwNkh0MlB2S0pa?=
 =?gb2312?B?Y3huYUZaRTZoZ0pIL3FVYi94T2RjaWdkcFg2VzYyL1RCM09lQ045eW1UR2Zy?=
 =?gb2312?B?QU5rNHRQamdlU2puV2pSVG1icG8vaFVVMktFTllMTkJaWWxqQXF2OWpoQ0Jo?=
 =?gb2312?B?ZFIzT3R4V2ZEdmJSaVhRTXpQdTlJbU5Fb3NxOVJIeFdJZUFjM3M5c2xWUm9y?=
 =?gb2312?B?aDV4eGpYMzhWWVVXT3F2c1psREQ5Z0lWSU9RdkxWdVNlc2RxdWN3R1lCTTRT?=
 =?gb2312?B?OHgzbERvQXdKaWVsWjArUmpZcnBrYmMvRmJnb3RNSFB2aU85T2R3cHVCWVVq?=
 =?gb2312?B?WmJIVU1PR21vWUZ4UTRIQ3g0ajV5SjhYMEtOd3JsUXk0WHlLNklaRU9jRXVj?=
 =?gb2312?B?V3JpSkxqWjNBanE2V1VPb0l3V29DMXNhMFg1bjR1UVR1Q3RYaThMQlhEaTBv?=
 =?gb2312?B?QTdjeXdtREpXMzgzRkJUb0hxY3FYZUtsUW44VWI0Yjg2TUFUdGtKbkMySTh6?=
 =?gb2312?B?Y0ZHaXVTU24xTVdCNGNhY2JVU0dBcXkwMkt6dzc1UG5MdDd3K3grcVUwSUIw?=
 =?gb2312?B?SVFzUlZFeHFFc2hCNXFUWW5UV1hFRHIzZlFVMU1XRFFyeUQvMjlWMnA2SnR3?=
 =?gb2312?B?UmdyTlJ0MXpVU3BvTEJlVFdNb2swb3dkU2pWQk9oeEJuZ2daUmNINmpKTGZD?=
 =?gb2312?B?RjVjSXFHR0lpUmJzWUYzUFl3WWt3ZmsxS0V2RFR0c0xVekU2VmZaRU9aVE5x?=
 =?gb2312?B?NVRPNUNiRDJUNFdka2N3RHc1elg2VSt1dTFPaWJoVGFiTG4yS3JwMmF2THpH?=
 =?gb2312?B?SE13NmV5RXROQ0g1VjZTbUNIK2J2eHZrOHdKR2wyZFVGYWJMNGFWeWlLVThO?=
 =?gb2312?B?TFdEdG9Lamt1U3RVeVkwbTN0a1o2cm55YnhXRUYvQjc5QUVGa3ZwYlIxd1lo?=
 =?gb2312?B?NzZDaUtDeGlHUHlNbXZaS1liVmJhQnVVMFIyN1JRbWtxWUFLaHJpT2FlV1g5?=
 =?gb2312?B?OXFYaVNjTDFidnhTbXFWYkt2OUxSdU5NUFYwSHNUK1NvWnc2YVRLalpmSG5N?=
 =?gb2312?B?NGZwd250cml4QUJ0THZPZjVNYTZjK1dFc0dqaXNjS05vVm56cGhJVnRwSDY1?=
 =?gb2312?B?QnhnNzR6Zlp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UzhUb2VhSmIvT2ZEb3MrVW5xejcrRVJ2dVM4VHpZejJVcTgzTnF3d1ZIWjh4?=
 =?gb2312?B?TUNIeFBtK05xTXdFMjdTRWEvSU4zUDFKSzVjRmtMWXZNTUlKeDM4ZHd1Q1RO?=
 =?gb2312?B?dmhWM2U1NzJYSW1ZSHBkZktzK3VQbzVXc21ML3YvUkV2TDdwSXVEa29rWmMw?=
 =?gb2312?B?RXh2WHZMeFNqZHZZWHJlU3ArZEVsZExVZjRTWTlIUnYyN0VjRkVxNnY5Mnd6?=
 =?gb2312?B?cjh0SDdXU2hHWlBNczJjWEFtbnl6Y3dhWE0zNHZOaXQxNnhPWEo1dUNXQzN5?=
 =?gb2312?B?aXR2T3hCekJGNHVOK3d1UkFOQmJseHprWC9iU1QwaUdjR1U1Y3VubDBwMEM5?=
 =?gb2312?B?VmNuNlg2a09rVkovaTNDUTFORTNDaVp4TWJzVXJXSnJTcStlRU5CczZxTjhI?=
 =?gb2312?B?aWNvZTErZjdLc29hVTlwWExTTVQrMDdMbjV0SVJKbFVaWWluOGdBdGpIVEpl?=
 =?gb2312?B?VG1ZYXppWXFpam1jU0FBci93SGVBNDhpL3NRT3Njc2tSa0VML0llcVBQNFds?=
 =?gb2312?B?WlpXa0hpRlI5THlhK0QxUFJiMHNtT3VjZGYrZ091MThxcGtUVUhBYnJmUFBt?=
 =?gb2312?B?a3FLNklmRSt6Z0hRSGdHcFp3R3FnS2EzMHJFVDdlbENKVFd1SG1tWDhDdnBq?=
 =?gb2312?B?MWEwQUNwYTlZa2lXdm9pZkkyMG8rTjR6SmxGRUlGMTV3emc3N2tVOCtUdTlC?=
 =?gb2312?B?ZmtWa0U1NjNTVWYzdzdRSGhxY1ZyZ0Z2OVVlUXdGd3ZjU2FBTmxmNE5QenUz?=
 =?gb2312?B?bFlUR1lLd21HZ0hCSndNbzV0NmhRd3NFMkZyVXAvWGVKVUY2dldKZHIwYnVX?=
 =?gb2312?B?OEpaNDdQZEl6RzR5emJLTURTSWJtcnFHTmVrUGhJREp5NVlubC9yQWZCN0lo?=
 =?gb2312?B?MTdaQ0JSZlRPN0wvaWNkTmVUd2tUaU9EYjcySm9jRVBxY1ZNOXdVNG9NZ05I?=
 =?gb2312?B?UEsxVzZyVU1vajhVa2MzcGF2dHhEcDQvV1lEVnVoNFRDejJzeXZTUkxJQith?=
 =?gb2312?B?eTc5NXF6ekJyWHM5M3BYVWZMMzh6b1dHRms3OWgxS1ArT1pzRmNKR1BjRzVl?=
 =?gb2312?B?YlBEMW42aXV3cUZkZmN3akJwY3VuL0VtRUZ1cXFmZzVOUDJtU1d4ODdBQmo5?=
 =?gb2312?B?ZXI2QzJCUUQvKy9vQkE3d0taR2VNcHo5NGRZVWZWeFdoQ0VZTjVQVjNKdzhZ?=
 =?gb2312?B?VkgxT0pUY2E2Si9FMEU4YkFkYWRCa3QxOWZlRi8vN2I2S3YrL1F2SkVHSUFS?=
 =?gb2312?B?amVBMHB1eTYvL3Rpay8yeHZXeTRyLy8zZkptNnpVWTJMcmF6L3pudkd0dzlw?=
 =?gb2312?B?Z0cyeUtUL3F5S0Q3ZHBCRVJMM0Vtd0hsdVlLTnM1dmNVbnlINzFST2tuRWxD?=
 =?gb2312?B?emxuaTd1ZSt4TW1KSHkvVUFoUlFMZks1ZmJJS3hUWll5WDMxVWhYSFhTTktq?=
 =?gb2312?B?dXBVMUVzbDhUeTdsTVFpaWNUYmhCb0tXMnFOMmhNWDlrakJFT3hjSnVCamd2?=
 =?gb2312?B?RjRxRFptWUNFYlZ2YVh6U0pLWmFUSUNDemE1VzBCSmpFQnAvbFNhNVJLVkdj?=
 =?gb2312?B?S0VDbHNRcFJCbUJabWVQR0xFeW5Kd2xKckRLRURFd1NhOHlJM2ZQMWVQNE8w?=
 =?gb2312?B?cVNiTW1qOERjKzNVWThPdWhKaGt4dzJJVUtMWGdvUS9PRFFvU3h5ek5LcTYy?=
 =?gb2312?B?NW5LcDJ2T2IrcXVWVVVtT0t5MHh6QUdMb3llZVNDL2thN3lnU1dybEpBZklH?=
 =?gb2312?B?VStPSTROUDdrUnJxaWZnb1B2eXdqb0p2OENFa0hQdWFuT1hGVEk4ZXdKeXJP?=
 =?gb2312?B?SlM0Q2x4OGNvZ0l2SkRsUmt5YUZGSnR2UDJDbWpraTU4NXNXNGJVN2lMemJJ?=
 =?gb2312?B?Sm8zeExUZ2Qvbkx2SUkycW9EbERObjIwZEpXV040SjZwV1RjWkpuaHRjeExt?=
 =?gb2312?B?M0NZeStrZkdQRWdnUzFyVVdNOWJmNFJVRkxmcVcyYjI4aW15K2hFbjBJWWMz?=
 =?gb2312?B?KzdIZnRJdmdKalRJY1pvVDhpWkpHWEJKODJiWndhWjhWei9FNWRKSXBtc09x?=
 =?gb2312?B?OGZhVUprOEJwV25yNTZwUlNBWlU5ZklPaEZYT2VZWU5KVnJvZnN2TUpBTTFj?=
 =?gb2312?Q?MIYI=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0b96c8-c17d-4b5a-d73d-08dde0767592
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 05:49:13.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Pn69K/3Ao5XJdjlhOA6DYeimVCL+wA2kGli9YyIQmx6O7bCAQ0CxyPhDdTqRLRlsttkA+sGeekM6YD/ahvbpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7418

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jjUwjIwyNUgMjM6NTgNCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+IGxwaWVyYWxpc2lAa2VybmVsLm9y
Zzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgbWFuaUBrZXJuZWwub3JnOw0KPiByb2JoQGtlcm5l
bC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwu
Y29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzJdIFBDSTogZHdjOiBJbnZv
a2UgcG9zdF9pbml0IGluDQo+IGR3X3BjaWVfcmVzdW1lX25vaXJxKCkNCj4gDQo+IE9uIFdlZCwg
QXVnIDIwLCAyMDI1IGF0IDA0OjEwOjQ3UE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+
IElmIHRoZSBvcHMgaGFzIHBvc3RfaW5pdCBjYWxsYmFjaywgaW52b2tlIGl0IGluIGR3X3BjaWVf
cmVzdW1lX25vaXJxKCkuDQo+IA0KPiBDYW4geW91IGJyaWVmbHkgZXhwbGFpbiB3aHkgLnBvc3Rf
aW5pdCgpIGlzIHJlcXVpcmVkIGhlcmU/ICBCcmVhZCBjcnVtYnMNCj4gYWJvdXQgdGhlIHB1cnBv
c2Ugb2YgLnBvc3RfaW5pdCgpIHdpbGwgaGVscCBvdGhlciBkcml2ZXIgd3JpdGVycyAoYW5kIG1l
ISkNClRvIGVuYWJsZSBMMVNTIGlmIGl0J3MgcG9zc2libGUsIHRoZSBjbGtyZXEjIG92ZXJyaWRl
IGFjdGl2ZSBsb3cgc2hvdWxkIGJlDQogY2xlYXJlZCBhdCB0aGUgZW5kIG9mIGR3X3BjaWVfcmVz
dW1lX25vaXJxKCkuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgMyAr
KysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMN
Cj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMN
Cj4gPiBpbmRleCA5NTJmODU5NGI1MDEyLi5mMjRmNGNkNWMyNzhmIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+
ID4gQEAgLTEwNzksNiArMTA3OSw5IEBAIGludCBkd19wY2llX3Jlc3VtZV9ub2lycShzdHJ1Y3Qg
ZHdfcGNpZSAqcGNpKQ0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+DQo+
ID4gKwlpZiAocGNpLT5wcC5vcHMtPnBvc3RfaW5pdCkNCj4gPiArCQlwY2ktPnBwLm9wcy0+cG9z
dF9pbml0KCZwY2ktPnBwKTsNCj4gPiArDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4g
IEVYUE9SVF9TWU1CT0xfR1BMKGR3X3BjaWVfcmVzdW1lX25vaXJxKTsNCj4gPiAtLQ0KPiA+IDIu
MzcuMQ0KPiA+DQo=

