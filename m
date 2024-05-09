Return-Path: <linux-pci+bounces-7276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98A8C0909
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 03:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95B4282FCC
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 01:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346ED13C668;
	Thu,  9 May 2024 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nQrIQG/Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D526AC7;
	Thu,  9 May 2024 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715217891; cv=fail; b=dtJ3ozKcyeAd3cDtR1bMbwkIhnk6iN5s24YhKWJuPEL4qPah0U7Sqn7FTi/eWlc8X4j9ICn45PORqMPtPUnFZHbgB5W+jgozvbbh+Irdl1u7qKqmtHAdAfQgzw+Y590kS8NZ4r/KWWZ3w+h6I4FTSgvrKnpE3fruDgLt8+5TigQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715217891; c=relaxed/simple;
	bh=dxTTUpp1cBaB+N5LBid+pA7A/3QlZWdWxkeRVstTwxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iGuWB59p7szzx9LGluILqDY5LjH3d1Zq/2F/vy/6aByKpszNG7DfMmR0HsNHzfH/kwfxyZLSzE1eOYrXU/Viv2YT/yEMz8yGbms3AE2sfeQUgIjR8wY92Asng6P7zcEIl4ym075KkOuiLOZKkKcXzeSmpfiigJhQTQPJBfdCyjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nQrIQG/Z; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEejdifmaDxAewTkgxyg48BVAllMTqKI0L8I/TzszDrVfmUk6IkcbFs03YSiFXD878Ma1wfZbFekpLA4uMWTy66gMDWykhCXd3qXk0BT2wwxXaKHRgCDclLfPR+NrjR7x/SQMLMZY7aGcXn6SUMfOgisVNauiuGTOuDX3dCmZ0rJbfl5sbbfgFuHdYCQi4tCj+uCl0KNifyxb+155ytzD27OJ8imBMjY+96H3zegcnKEHLy90gC5nt1lXi7On4vaMUmR7Gs5dDJmR6upwEYb76+PxyiaELj8gz9MmCFBw/tD5DRYkPUUxFU9lLKggneeC8zjY5jgrJgWdsEY3rcRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxTTUpp1cBaB+N5LBid+pA7A/3QlZWdWxkeRVstTwxk=;
 b=HR3h7zyCWqgsRIcLRBdGdj6na3uku01jzs/hNnrIiOLCT9/pOOmUqi/0ArXMUMQ3yOKsMxiMBIksv7oFZBDt08F9YA7gqAoFBQXg0ZvcLVS7OvLiQ3ZAFxZ+vdHrYXqv82w5pGunfQGC6QIoO+uxKwpY1ogKiVHWD4StMqQ6mFu3QS/GSrxKeWI0EMJLXWVFXgg5cygNX2EDVwPhJNvzExS3xJVwxfuHWOVLfAtiJW9LGaN7uhxOXVsHWueSD41hXOL5/fMa0aXygvS+NuZGw/3TFpsZeSQBuNAqoR/rCE/VN+Yf7mm1lTCrIfeZ2xN9VRhB0+jeAoJ/Pbdjjbp9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxTTUpp1cBaB+N5LBid+pA7A/3QlZWdWxkeRVstTwxk=;
 b=nQrIQG/ZzE6NWd3mWD6f0xoUdi50HpbiOe4Iy8mGDlFTrz5iNYlM7TZFuFpPgATV4AvK9kDJFK0A4dKhiAecJnRR+gQ6HciAnTQtYvef1gOBszWildL5BhwQKqgAvl9Om+C1IhCHyMgOE9nulfzYXkqXJT6QSYT1MoGswCTpSIQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8263.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 01:24:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 01:24:45 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Frank Li <frank.li@nxp.com>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kwilczynski@kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lucas Stach
	<l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@Amlogic.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Xiaowei Song
	<songxiaowei@hisilicon.com>, Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
	<jonathanh@nvidia.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?gb2312?B?UGFsaSBSb2ioonI=?= <pali@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>
Subject: RE: [PATCH v4 4/5] PCI: imx6: Convert to agnostic GPIO API
Thread-Topic: [PATCH v4 4/5] PCI: imx6: Convert to agnostic GPIO API
Thread-Index: AQHan8DCFZs/i9bMv0Kr1anoQAozg7GOG6Ig
Date: Thu, 9 May 2024 01:24:45 +0000
Message-ID:
 <AS8PR04MB867668870DD2DC029C8B98048CE62@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
 <20240506142142.4042810-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240506142142.4042810-5-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8263:EE_
x-ms-office365-filtering-correlation-id: ba890bc4-6ea5-4495-0b9b-08dc6fc6cf91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009|921011;
x-microsoft-antispam-message-info:
 =?gb2312?B?UmNhTXZzZUUvZ2o4eWRVYWdCTmlFdys5MEgzTTZ0YUdiemEzaC9lTHRuUjFG?=
 =?gb2312?B?dWpZNkQ0M29rMlNNWDhzR0N3UEx6eDRVRi9EdDdORXlqWjJXL1IzQVA3U0pw?=
 =?gb2312?B?VWZQQVdWY0hKSk9sZDVoNnloZXh4WUhzZXI0Z3Fnczk5TllNKzJmM3c0Y2lt?=
 =?gb2312?B?WGNZQzc4eThrUjg5MmtMaXc1aFRQQ3NqRzR0OU15V0tQTkNXSDU3WHJRVHEw?=
 =?gb2312?B?YXhjU1EybTNHYXJEVHY1SlZid0VPc2ljZGxsamprQ2plUEVYVkJpN3BLYzhI?=
 =?gb2312?B?bFpwUytIb1pya1JwcStGTE44cTZGSS9IZ3ROV2Jla3czWm1lSlFZeUVpdUpq?=
 =?gb2312?B?WEhRaWRzUjllNmpSeHhmQTNZODY3VEdWNUY0NzhUNHNyWmJTWmVKWDZmdE1l?=
 =?gb2312?B?VUFIQTZJdGdMdGU3K29KMk5waDBiR3FudkpyZEVvaHRYVS9PRklYbnhIRnFX?=
 =?gb2312?B?TVZSV0dBUVpNUTV2azFtWVZvL0Y3SU5hUUlkVERJcVJuWWJ0blZod0tQaThj?=
 =?gb2312?B?czNGMWpqaGttNXJPYkVrdmtMbzJUenZTakN3R01pUEUraks2aFZPanhHdnNM?=
 =?gb2312?B?ZnpxUUNnMU94ZzU0TVZ6bkRxSklzYzljUVQwcGZnc3BZMDlUSlA2aTdCVGJU?=
 =?gb2312?B?QmRNVVVUbXVHVWtkTjFBbGFWRWQ1NEl4ck9jV1E4encvZkk4cXZwT2lLQmtw?=
 =?gb2312?B?aUR4WUxkekZINDFqbzRrVy9iZUMyT0dGT0RBbFlpRWRIS0s3djlhWmI5VktD?=
 =?gb2312?B?M0Q4NHRqZXVzSGJ0MUNNREI1bU8xak1MNHczL2l4ZElrSkV5dzBMLzNuN0Rj?=
 =?gb2312?B?MW1paDkzOElaY1J2VlZIM2hhOUNHV2J4VUFsMFhQWFpEdW41bTNhWDlCLy92?=
 =?gb2312?B?alNNeDI0ckgxSFB3NkJnRzgrUEdxbWF2M2I0WG8wcFdIWWl2NFlSS0ZhS1dQ?=
 =?gb2312?B?ZkNGWTBoNDY5TjJwVm5zd3NadGJYQkEvVVU2NGpydFVySzYzYVdsdkRva0Jk?=
 =?gb2312?B?UFRBL1FsbElneXhCLzlIejlzeGdxamJFSURxZ3EvRzEwUFVFakV4RHh0d3Q2?=
 =?gb2312?B?MHJQOXZiODdkZXl0Q2wrWG5HR3ZVaFlVakdFN05ORzJCem5qZ05GeCtwSm0x?=
 =?gb2312?B?dk9pQkxZS2h6aFVXdEJvb08xcGNCMU0zaEx4eWgxRVJ3Y1Y1U0xWTkI5WFZO?=
 =?gb2312?B?TEJVbTNQZ1dBQm14dHFmM3NacDM4bDMzM1ZPMTJ4QXlmU2dYR05xeEhIbTYv?=
 =?gb2312?B?Q2t1NnRRdVpFV01HWHZQZHdYRXF1WlM1MjNSaGFKc1V2cGpKRDRWQWMrSGZG?=
 =?gb2312?B?aU92bGp5K25rSWxrN1NrMFBTbTlmQ2lyUkY4Vzd5S1dJS1A4ZlhzaWZtbitY?=
 =?gb2312?B?dHpyakFvQmVwd3VQRDIwWnlCRk1FcGtPbmVzRFZtbzlmWDZSeVZwVFJPV2Fw?=
 =?gb2312?B?MERlWERQUGhvUTgza0NoUkZXTVpPeFhWcXN2N0ZKUzJFZys1TkhHTVVHMFFh?=
 =?gb2312?B?dlBIcnVhd09oVDd1Wi92anozbXZMblU3dXlYTVFvZGpsSFdkc0RTUXpTLzM1?=
 =?gb2312?B?ZUhsbzBOblhKQlJMbGFwdTh5ZlZTWWpwMVdZWk12Qnl1SmZKK1haMmMrMzI0?=
 =?gb2312?B?NXA4SkhCalJwRUhzR0R3SEZrMHoxVksxMzlLbEpKajhGK2x5WEJiSklMRTRN?=
 =?gb2312?B?MVFUbU1FWFdPTEdhcmpqZnNxc1RiL2h0RkpNQjh2U3FaZXU0elg0SVJsNnhu?=
 =?gb2312?B?UmgyRy9TeG4zc1Y3VGQvM2YxakYwK3BMaDBURGxJNnVEZjg0UHd3NWJtY1JQ?=
 =?gb2312?Q?FE4QByEfkylcWXfWi7QWtMhdOM67W+UXDdoG4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RUVwdnJsci9QSnpxS3AyYVhhZTFUaU1jNzBtMHQrZmkvU0pqRGFDRWJGZHp6?=
 =?gb2312?B?MFpqSHdmdGVYTEwrdmpFRUVWQ3E2S3ZqR1B3S1Q1SHd5VFNPMC9oYzVvaDZj?=
 =?gb2312?B?MzRTdXpOY2R5SkVCMHMrZ0cxUHlLQ21Qdk5FN2tIUUtsUzV4ZDIvbjFPcXFu?=
 =?gb2312?B?RGdpa3I0WHR3Y3ZjT3NUaWZhN3FPV1VjQktST1QzWTlEU2VqaTVMQSt0TGdl?=
 =?gb2312?B?TGloRnZlT3V0L1VKakE4a3RHNWVHYzh4TmJQRlNpMFBBRzRwWHBBbURLcHYw?=
 =?gb2312?B?eXQyVkMxekxPTGcwQWprZW1Rdm5SKzdFY3pKYlpYZDR4V2plKytMbWVQWlUr?=
 =?gb2312?B?cFRZMkdvVk0yZU5QdE1DemJiMjFqVzFwdXRIcW8wcWVtdHB6TWNHQnNUZ0xT?=
 =?gb2312?B?UDM1TGRKQVI4T3RKUXlZbFlpWUhIeml4QjdtN0M2M1B2SnFsdXdhdjlBeTBO?=
 =?gb2312?B?SUtvZGlJYmMwNjFOeDVjc0hwMnlCeHV4RXl3ZmR1UWVtWUVLWFVXdjVCY3lR?=
 =?gb2312?B?V0o4cVhpRVNzQTNkMytqaHUza2g4V3hDNzZmbE1xVGlkVzkyM0R4ZnYveFAz?=
 =?gb2312?B?WDNiaHVOdFZhWnF4QWcyYk9JQnhJdU9oL3JSU0VOVGt0S1FzK3pMWFhYcUhy?=
 =?gb2312?B?SDJGUHp6V0phdjZ1enF1UWZZendRN2NJM3UraWhqbm5XY2cxRXEzQVBlMmVH?=
 =?gb2312?B?V3dDdE85aUpUZWZXb1RDODlaejdaeVV2dndDQUlRbWo1ajVzUHU3K3o5K2xp?=
 =?gb2312?B?d3FISVA3Wkg4MVlWRzVmVHJRVllOWGFyMFp0RldGRGszYmNRK1RYd3E4N1JZ?=
 =?gb2312?B?M1ZndExvT3NqbU5rWm1yTTZQS3NZK2NZQy84UHJxTkM2bEtoUkFUZk1ybWhR?=
 =?gb2312?B?TkU1dG0wQW1Ob28xRGhLWmV1RmFRdWhWYVZGSXBsNVp4emdMRzg1T3JaZGNS?=
 =?gb2312?B?VHY5a05TcUNwRjFvamxvMEtPODhPNFVkb2RmSHRJZk9RSW1BbzFOUjNWVXlS?=
 =?gb2312?B?M3BpVzM0d3Nxd1ZwTWhuTkRVM2VVQ0VFMTFPSms0Y3VLU0pyd2hyVWdTbkFo?=
 =?gb2312?B?WTJjTkFqRXZjcG5NUkp5TCtmclBBN3JxaTZVK1E5eThvb0VyRHluS2djeVhq?=
 =?gb2312?B?Vi9yb3o4UFVheWRKRlRuT011c003ZTloRm81SXZkbVZnMmJwaGxGMjJLbXRh?=
 =?gb2312?B?M05tRmFTclNjMjlpSjRpVmVJZDd1M1ZmSythR3plZld2MFAxRzdxdmtYTVRL?=
 =?gb2312?B?Q2h2N2M4Q1huU01jamFQNTR6eHA1UHl6Vy9zUE9od0FNcjZkUFR1dC9lR3cy?=
 =?gb2312?B?cFh2WXVQanZLRnc2dEhnbWtiRnR4S21mTlRLQm5KZ0RKS1hvcGZ3NVVLTVdV?=
 =?gb2312?B?UWl0ME1ENklVUTA5cHVzWkhXbktUYlQ0WkMvaHUrRmYrQndNS2c4clNvTUQx?=
 =?gb2312?B?K2tNajJ6TGgxYWhMNy81dmlDN0k1YWZUNXZPNUpuYjNuUkxqNGh3V2daRHl5?=
 =?gb2312?B?SC9ZUE9pRWxheXI4RWI5VnJlNEhxTm93YnZiWnBJNU9WckluNXkycGxqS3dh?=
 =?gb2312?B?R0xWaytQUFkrcUx4N1B6cVRodFpYQ2szTUVnSk51b2hIZUpyRlBUeDQrczdm?=
 =?gb2312?B?YVZHOEIya3FvSUFJdTh4YllRczBxbE9aQWl0ZE1rZjFacHZBaUFCSUFjRHQ1?=
 =?gb2312?B?dW1oWXpCQjJWTFFJanRwOHY2Y3Z3TkJWY2dPeTVoZFkrZTExZGlFWThiQUI1?=
 =?gb2312?B?amFWZURrbGVxbFJJV212Z2t4RjZUQk4rOEhPdzRmWnFWdWlsWDBialZxVVNR?=
 =?gb2312?B?ZEtPeHFwd2xTTTE4Zkp0SjlQcjVHRUoySlRSSFplRjVXTjRhMThjUHhWWG1X?=
 =?gb2312?B?S3hOaTdXdlV4V2pLbUw2eDNobTFJM0l5VlRnYWRycmI3cGV4WnplUWlvTGpz?=
 =?gb2312?B?NTdNcmZOdXZqYXpqL2RRUmpvUHVqdGJRZ29OL2IrOC9qWmJudU9jdWV6dmYw?=
 =?gb2312?B?WGxVc0FCUFFEL3c4cGRtY0lhcEJPaVBnNFBLYWMwL1Frd1RCRGJDQjZqUlF2?=
 =?gb2312?B?Y3pKcnZKV0RndUl0OFpJZmRRSHNobzRZL0h2ZW9Qa09MYjh4bFJjc01qT3lU?=
 =?gb2312?Q?+h+YkeywxguwaiOY4rfd1nAvK?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba890bc4-6ea5-4495-0b9b-08dc6fc6cf91
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 01:24:45.5938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVmWx+e6IdAEY9wyjfzj+6xrSOg9ECcuJqYJybqyDmA5fam9wP8cjWoVrMhZ7yc7jVMsaBxzH7npB0R/hO9n5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8263

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogMjAyNMTqNdTCNsjVIDIy
OjIxDQo+IFRvOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBs
aW5hcm8ub3JnPjsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+OyBLcnp5c3p0b2YgV2ls
Y3p5qL1za2kgPGt3aWxjenluc2tpQGtlcm5lbC5vcmc+OyBBbmR5DQo+IFNoZXZjaGVua28gPGFu
ZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0
cy5saW51eC5kZXY7DQo+IGxpbnV4LWFtbG9naWNAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
YXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZw0K
PiBDYzogVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGkuY29tPjsgU2lkZGhhcnRoIFZh
ZGFwYWxsaQ0KPiA8cy12YWRhcGFsbGlAdGkuY29tPjsgTG9yZW56byBQaWVyYWxpc2kgPGxwaWVy
YWxpc2lAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiBXaWxjenmovXNraSA8a3dAbGludXguY29t
PjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEJqb3JuIEhlbGdhYXMNCj4gPGJoZWxn
YWFzQGdvb2dsZS5jb20+OyBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgTHVj
YXMgU3RhY2gNCj4gPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+OyBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBQ
ZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgWXVlIFdhbmcgPHl1ZS53YW5nQEFtbG9naWMu
Y29tPjsNCj4gTmVpbCBBcm1zdHJvbmcgPG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmc+OyBLZXZp
biBIaWxtYW4NCj4gPGtoaWxtYW5AYmF5bGlicmUuY29tPjsgSmVyb21lIEJydW5ldCA8amJydW5l
dEBiYXlsaWJyZS5jb20+OyBNYXJ0aW4NCj4gQmx1bWVuc3RpbmdsIDxtYXJ0aW4uYmx1bWVuc3Rp
bmdsQGdvb2dsZW1haWwuY29tPjsgWGlhb3dlaSBTb25nDQo+IDxzb25neGlhb3dlaUBoaXNpbGlj
b24uY29tPjsgQmluZ2h1aSBXYW5nIDx3YW5nYmluZ2h1aUBoaXNpbGljb24uY29tPjsNCj4gVGhp
ZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT47IEpvbmF0aGFuIEh1bnRlcg0K
PiA8am9uYXRoYW5oQG52aWRpYS5jb20+OyBUaG9tYXMgUGV0YXp6b25pIDx0aG9tYXMucGV0YXp6
b25pQGJvb3RsaW4uY29tPjsNCj4gUGFsaSBSb2ioonIgPHBhbGlAa2VybmVsLm9yZz47IExpbnVz
IFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj4gU3ViamVjdDogW1BBVENIIHY0
IDQvNV0gUENJOiBpbXg2OiBDb252ZXJ0IHRvIGFnbm9zdGljIEdQSU8gQVBJDQo+IA0KPiBUaGUg
b2ZfZ3Bpby5oIGlzIGdvaW5nIHRvIGJlIHJlbW92ZWQuIEluIHByZXBhcmF0aW9uIG9mIHRoYXQg
Y29udmVydCB0aGUgZHJpdmVyIHRvDQo+IHRoZSBhZ25vc3RpYyBBUEkuDQo+IA0KPiBSZXZpZXdl
ZC1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJv
Lm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVs
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwg
MzYgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gaW5kZXggOTE3YzY5ZWRlZTFkLi42MmE0OTk0YzU1MDEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gKysrIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBAQCAtMTEsMTQgKzExLDEz
IEBADQo+ICAjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9j
bGsuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L2dw
aW8uaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1bWVyLmg+DQo+ICAjaW5jbHVkZSA8
bGludXgva2VybmVsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbWZkL3N5c2Nvbi5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L21mZC9zeXNjb24vaW14NnEtaW9tdXhjLWdwci5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L21mZC9zeXNjb24vaW14Ny1pb211eGMtZ3ByLmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9v
Zl9ncGlvLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L3BjaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiBA
QCAtMTA3LDggKzEwNiw3IEBAIHN0cnVjdCBpbXg2X3BjaWVfZHJ2ZGF0YSB7DQo+IA0KPiAgc3Ry
dWN0IGlteDZfcGNpZSB7DQo+ICAJc3RydWN0IGR3X3BjaWUJCSpwY2k7DQo+IC0JaW50CQkJcmVz
ZXRfZ3BpbzsNCj4gLQlib29sCQkJZ3Bpb19hY3RpdmVfaGlnaDsNCj4gKwlzdHJ1Y3QgZ3Bpb19k
ZXNjCSpyZXNldF9ncGlvZDsNCj4gIAlib29sCQkJbGlua19pc191cDsNCj4gIAlzdHJ1Y3QgY2xr
X2J1bGtfZGF0YQljbGtzW0lNWDZfUENJRV9NQVhfQ0xLU107DQo+ICAJc3RydWN0IHJlZ21hcAkJ
KmlvbXV4Y19ncHI7DQo+IEBAIC03MjEsOSArNzE5LDcgQEAgc3RhdGljIHZvaWQgaW14Nl9wY2ll
X2Fzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gIAl9
DQo+IA0KPiAgCS8qIFNvbWUgYm9hcmRzIGRvbid0IGhhdmUgUENJZSByZXNldCBHUElPLiAqLw0K
PiAtCWlmIChncGlvX2lzX3ZhbGlkKGlteDZfcGNpZS0+cmVzZXRfZ3BpbykpDQo+IC0JCWdwaW9f
c2V0X3ZhbHVlX2NhbnNsZWVwKGlteDZfcGNpZS0+cmVzZXRfZ3BpbywNCj4gLQkJCQkJaW14Nl9w
Y2llLT5ncGlvX2FjdGl2ZV9oaWdoKTsNCj4gKwlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoaW14
Nl9wY2llLT5yZXNldF9ncGlvZCwgMSk7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGludCBpbXg2X3Bj
aWVfZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUpIEBADQo+
IC03NzEsMTAgKzc2Nyw5IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVz
ZXQoc3RydWN0IGlteDZfcGNpZQ0KPiAqaW14Nl9wY2llKQ0KPiAgCX0NCj4gDQo+ICAJLyogU29t
ZSBib2FyZHMgZG9uJ3QgaGF2ZSBQQ0llIHJlc2V0IEdQSU8uICovDQo+IC0JaWYgKGdwaW9faXNf
dmFsaWQoaW14Nl9wY2llLT5yZXNldF9ncGlvKSkgew0KPiArCWlmIChpbXg2X3BjaWUtPnJlc2V0
X2dwaW9kKSB7DQo+ICAJCW1zbGVlcCgxMDApOw0KPiAtCQlncGlvX3NldF92YWx1ZV9jYW5zbGVl
cChpbXg2X3BjaWUtPnJlc2V0X2dwaW8sDQo+IC0JCQkJCSFpbXg2X3BjaWUtPmdwaW9fYWN0aXZl
X2hpZ2gpOw0KPiArCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoaW14Nl9wY2llLT5yZXNldF9n
cGlvZCwgMCk7DQo+ICAJCS8qIFdhaXQgZm9yIDEwMG1zIGFmdGVyIFBFUlNUIyBkZWFzc2VydGlv
biAoUENJZSByNS4wLCA2LjYuMSkgKi8NCj4gIAkJbXNsZWVwKDEwMCk7DQo+ICAJfQ0KPiBAQCAt
MTI4NSwyMiArMTI4MCwxMSBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihwY2ktPmRiaV9iYXNl
KTsNCj4gDQo+ICAJLyogRmV0Y2ggR1BJT3MgKi8NCj4gLQlpbXg2X3BjaWUtPnJlc2V0X2dwaW8g
PSBvZl9nZXRfbmFtZWRfZ3Bpbyhub2RlLCAicmVzZXQtZ3BpbyIsIDApOw0KPiAtCWlteDZfcGNp
ZS0+Z3Bpb19hY3RpdmVfaGlnaCA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChub2RlLA0KPiAtCQkJ
CQkJInJlc2V0LWdwaW8tYWN0aXZlLWhpZ2giKTsNCj4gLQlpZiAoZ3Bpb19pc192YWxpZChpbXg2
X3BjaWUtPnJlc2V0X2dwaW8pKSB7DQo+IC0JCXJldCA9IGRldm1fZ3Bpb19yZXF1ZXN0X29uZShk
ZXYsIGlteDZfcGNpZS0+cmVzZXRfZ3BpbywNCj4gLQkJCQlpbXg2X3BjaWUtPmdwaW9fYWN0aXZl
X2hpZ2ggPw0KPiAtCQkJCQlHUElPRl9PVVRfSU5JVF9ISUdIIDoNCj4gLQkJCQkJR1BJT0ZfT1VU
X0lOSVRfTE9XLA0KPiAtCQkJCSJQQ0llIHJlc2V0Iik7DQo+IC0JCWlmIChyZXQpIHsNCj4gLQkJ
CWRldl9lcnIoZGV2LCAidW5hYmxlIHRvIGdldCByZXNldCBncGlvXG4iKTsNCj4gLQkJCXJldHVy
biByZXQ7DQo+IC0JCX0NCj4gLQl9IGVsc2UgaWYgKGlteDZfcGNpZS0+cmVzZXRfZ3BpbyA9PSAt
RVBST0JFX0RFRkVSKSB7DQo+IC0JCXJldHVybiBpbXg2X3BjaWUtPnJlc2V0X2dwaW87DQo+IC0J
fQ0KSGkgQW5keToNClBsZWFzZSBjb3JyZWN0IG1lIGlmIG15IHVuZGVyc3RhbmQgaXMgd3Jvbmcu
DQpUaGUgInJlc2V0LWdwaW8tYWN0aXZlLWhpZ2giIHByb3BlcnR5IGlzIGFkZGVkIGZvciBzb21l
IGJ1Z2d5IGJvYXJkIGRlc2lnbnMuDQpPbiB0aGVzZSBidWdneSBib2FyZHMsIHRoZSByZXNldCBn
cGlvIGlzIGFjdGl2ZSBoaWdoLg0KSW4gdGhlIG90aGVyIHdvcmRzLCB0aGUgUEVSU1QjIGlzIGFj
dGl2ZSBhbmQgcmVtb3RlIGVuZHBvaW50IGRldmljZSB3b3VsZA0KYmUgaW4gcmVzZXQgc3RhdCB3
aGVuIHRoaXMgZ3BpbyBpcyBoaWdoIG9uIHRoZXNlIGJ1Z2d5IGJvYXJkcy4NCg0KSSdtIGFmcmFp
ZCB0aGF0IHRoZSBQQ0llIHdvdWxkIGJlIGJyb2tlbiBvbiB0aGVzZSBib2FyZHMsIElmIHRoZXNl
IGNvZGVzDQogYXJlIHJlbW92ZWQgdG90YWxseSwgYW5kIHRvZ2dsZSB0aGUgcmVzZXQgR1BJTyBw
aW4gbGlrZSBiZWxvdy4NCi4uLg0KZ3Bpb19zZXRfdmFsdWVfY2Fuc2xlZXAoaW14Nl9wY2llLT5y
ZXNldF9ncGlvLCAwKTsNCm1zbGVlcCgxMDApOw0KZ3Bpb19zZXRfdmFsdWVfY2Fuc2xlZXAoaW14
Nl9wY2llLT5yZXNldF9ncGlvLCAxKTsNCi4uLg0KDQpCeSB0aGUgd2F5LCB0aGlzIHJlc2V0IEdQ
SU8gcGluIHNob3VsZCBiZSBoaWdoIGF0IGVuZCBpbg0KaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVf
cmVzZXQoKSBpZiB0aGUgaW14Nl9wY2llLT5ncGlvX2FjdGl2ZV9oaWdoIGlzIHplcm8uIA0KDQpC
ZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gKwlpbXg2X3BjaWUtPnJlc2V0X2dwaW9kID0g
ZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoZGV2LCAicmVzZXQiLA0KPiBHUElPRF9PVVRfSElHSCk7
DQo+ICsJaWYgKElTX0VSUihpbXg2X3BjaWUtPnJlc2V0X2dwaW9kKSkNCj4gKwkJcmV0dXJuIGRl
dl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGlteDZfcGNpZS0+cmVzZXRfZ3Bpb2QpLA0KPiArCQkJ
CSAgICAgInVuYWJsZSB0byBnZXQgcmVzZXQgZ3Bpb1xuIik7DQo+ICsJZ3Bpb2Rfc2V0X2NvbnN1
bWVyX25hbWUoaW14Nl9wY2llLT5yZXNldF9ncGlvZCwgIlBDSWUgcmVzZXQiKTsNCj4gDQo+ICAJ
aWYgKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+Y2xrc19jbnQgPj0gSU1YNl9QQ0lFX01BWF9DTEtTKQ0K
PiAgCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIC1FTk9NRU0sICJjbGtzX2NudCBpcyB0b28g
YmlnXG4iKTsNCj4gLS0NCj4gMi40My4wLnJjMS4xMzM2LmczNmI1MjU1YTAzYWMNCg0K

