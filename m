Return-Path: <linux-pci+bounces-16804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82A49C956F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 23:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5CE1F233A7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 22:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA161B6539;
	Thu, 14 Nov 2024 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M/q3eAz5"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013010.outbound.protection.outlook.com [52.101.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B231B4F32;
	Thu, 14 Nov 2024 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624798; cv=fail; b=frZXUZGxgYNLms5WdibHTL2KbQuHyqi7sGCNOThU3o+c1Bc8j4MudfYsgCFysdWgPSqOw0fYfEJx2QrUwWM7UNKDWxHSkdxs42JiA+RNxjJmH9Hqmuwho1TyJ7L9QESpP4XXsOV8vGT3pkJBjvRGUJYLVua2IuK+5hWk1B818UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624798; c=relaxed/simple;
	bh=oknEewV2xVMtzJTDODMiOCPDBkOTwQAdC4P3/r2BxdI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gZNb/lxh9R+NdRquq3uKpSvjOzZTKPri8feugf7MpAxODW/i3fM9JDXkaUTZoiYtiKKqvxrCzIWPqcEIXdZFi0NAysLH3f+R/tMG+fIypCN8iJZtsU9pKnuUvg4UL2WGLuT9QfVIjJJQDisXf97LjYwGR/XuNMSzu12LDXQYIuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M/q3eAz5; arc=fail smtp.client-ip=52.101.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bim/R/MIQz3nQD+OPU6mZEsrHczy/f2NNb5+5/g55MNV9dN70P1WZTELW1Dmfp0sv2Kgu+lzeECL7kjWpVP2STQtiXW0mLqyKDUpLHiEC4Z3jiPJfRsy0BZ2+DwdqI5OAQATHfl0E5bXD9STY0XbfTTuZu4QZh/0QUjq3oszqX/PCVg5NZsWSyg8Y/fb15MEhAwWzA6ErdZ2LXbQA2nm5y6/laqFrn+qFtyQCC2WcBUtbWqnhDJ6lLwFW0CXuDzhtPDOoOgauHf19tV22GnrwWX/0FKCLBGqU6r6bbAzn4nk9h1DbTie4D/IbT8RGO9fzt072GDBIuIlhzjKmB8CgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0okuXE5bsrRrOlA41c2rexmWqw6sMQqJ3MoKe+r0Ws=;
 b=JdwaH6aogcLvESBeaAM25AWtLfkINg3ySUAq8AEFjD2V12lNvqNbCb7hL3hZq4bGeT+pv+U0z6FRO1vJwXgJ5RY0Xry7OS2YpKt6p9mInrlDS6kOu2u3s28y3EbsoFCufmM1kChktjk6nA3ozEs1BRokiJV2sAAkp/unp8uVn+OCqsBCX2QVo645g4lu++/O5vr7uKbn9e3uBIcGdVjXuNz7xJsBzxaITuqDUT8lYlz/LBPyw5ZRTzPvjCHQKOSC3NgU/eS3R8ZSFff5NyndKKk5x1BQvG7nervZw4CjppWY3bwp+io/iX9TEYJXyUEOvDJ0paJQQ94s8vTvmDn+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0okuXE5bsrRrOlA41c2rexmWqw6sMQqJ3MoKe+r0Ws=;
 b=M/q3eAz5CMimhbmjhfobDajo0uxzV2UlLUikN9RyLJ+COn2pOvivLi6e3rEpNDHF/RvwoXYgfpr4XpMUfBAQXqx0Y0mqHMeKBB5OI+aF2oLbKA1qQaZmQHxrx+zBiivOusl7RFANlAF1SN7DyRhHMgoDje2upyDoP7oZNPchUtYq5RNoOPPaLdm5BEBKj3fmBChGEjR1CQxaBrjV/mYk8xIE4Mfk+Mv3tojHCds71NwpWhCOaK7rnJmm3IoJ9po97+z4qlKnAFcxtrVdN5RwmVYxvJjFWmqI1/ckEhqbmr4qWF0mwOkWifPN2zyvrK/eqi/UWwjIA15NjjFPoOBEXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9967.eurprd04.prod.outlook.com (2603:10a6:10:4dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:53:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 22:53:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 14 Nov 2024 17:52:42 -0500
Subject: [PATCH v7 6/6] tools: PCI: Add 'B' option for test doorbell
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-ep-msi-v7-6-d4ac7aafbd2c@nxp.com>
References: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
In-Reply-To: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731624768; l=1850;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oknEewV2xVMtzJTDODMiOCPDBkOTwQAdC4P3/r2BxdI=;
 b=9k/vJr6UUB9pNZzPDpHLHIM0mezAXfMKXbugs9YpjsSgJjN+MFI/oSSFlf5lys+74e3Jkh3q9
 k9Yx5SJu2KlBdklaDsa/tIv++BjhbR3QETAJ6uEYExaTrc2CCHrhExi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9967:EE_
X-MS-Office365-Filtering-Correlation-Id: dd25aa24-1480-4fb6-0de7-08dd04ff1f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnhOQnFOM09DcVF5Szd5cWMwU2s5MGsrZG9zalRwNmJPcjlkYjJnR3Z1ZlJK?=
 =?utf-8?B?alVxeFBnOTBWUDNLSXV4bDIwV252RHMvRHFmUGd6L0M4MjNicU1lVHNYYXZX?=
 =?utf-8?B?MGNDMkZ1Wmd3S0s0Wmt3bm5LV09SUUl3KzhPa0xGY3ZVa0VvTUg3bVJNc0l5?=
 =?utf-8?B?cXF5V25Jd0FnbGxTVG1EM0Rwc0ZXdng2TjRRbkdmZkszc2RydEVBRnRSc1Yr?=
 =?utf-8?B?OWhCRGhFMnFVZi9EYWh2OTNsaENrL2JpSWhZVWtaRDU0ais0YlkvMnlKTWJy?=
 =?utf-8?B?ZjMzYThDNkU5UW1YTDdsZkRESzVVMzd2RnBQSnhRamI3Z1MwbXlWd1BxUGRN?=
 =?utf-8?B?Rmp1MDJZQzZEM0t0R3JmWWZRd05zYUdyMG1veGZyVTVxWm9EVXo1UTcwZ3ND?=
 =?utf-8?B?ZENFazBBNVBwaS9sdkFPVi9TSEhLOU4wTXBNYzZzSnBrMFRiWU5jT2ZHeVBP?=
 =?utf-8?B?Y3BrNHJNa2pDWUFOVC9RK29NVU5KYmdpY3J4dUxNUzRuZWdHN1crOXB5OXZD?=
 =?utf-8?B?dDR6cWZyK0xoVDcxbkJLYjZvVEh5OE5rNG9FOTJLcnpJTCtTaU5HeENJT0dB?=
 =?utf-8?B?M0VVYWRmc0YrY0YxcVpta2RBOXYyVWFlSW0zNnJ3eXZvK2ZCTHJwOU9zYXZr?=
 =?utf-8?B?S01oSzVDVC9DemZEN05waVBlY3gyc1BoVXhSWmhpR3FoMEZiRjdCNG9pSlh0?=
 =?utf-8?B?ZXBVS29nOEJGelBPQ2t5SWJkSWtnbDhLcnNzTDlTWWg4aDN6WmUxeDgvb3Zp?=
 =?utf-8?B?K0RKYnJlU2NhSXpUcVpnMEJHa2Yzd1hZRy9TbUU0UmlnWDd5U0F5cmRLc294?=
 =?utf-8?B?QWp3Ymd2bHVjek80bm5iTVl1cUJQdnJaWHArMG5PNm9qL00xM2RzN2FRQzhO?=
 =?utf-8?B?QlBQKytyMWw1MVQvT3pBQkRQYW9mK3JBbG1SZFFtR3hlcFMxa25WWER6cG9j?=
 =?utf-8?B?RWtFSmVZRDkxbU90TFEwaFFUZEt5dWpNb0hXSkd6bE9Ua0lmQkVKd2RUS2xL?=
 =?utf-8?B?WHcxQk9ZS1BicFVtMXRPQk96S0d0V25YWXdXUzJmbURqM0NaajZmOTZEZVQz?=
 =?utf-8?B?djg1YThtSysyY05SVURpeU1Ja1VaWHFWb1FLN3dEVnVtR3lxSDRUeGttUUdR?=
 =?utf-8?B?eklBOGJYVytaZndTdjdiTG84Nk5MY0luZjhseDcrR3Q1WE9qZWx2Z3BnYmxt?=
 =?utf-8?B?TmxFc1FLNjJkN1lwS29rNXFOY1pVNjZZQStaQlRCMjJyeU9ZMVhXaGpxNUlr?=
 =?utf-8?B?cHBMSkZlL1lIZ3ZpOFdWWG9rZzlOOFNxcFlBM3ZjR243RWpEeVhXS1YxUmRa?=
 =?utf-8?B?V0lwNTdUanplRTNSaTQ2Q2tOemVRb0V6WDBrbGZSOGRMaTVWckovbUJ2OElK?=
 =?utf-8?B?YkZoWWU2WXd1c2IvdlNzUjVFU0JPSmI1cGFlUnhadmNHZzNZL0UvVDJzd0xV?=
 =?utf-8?B?TXIxUUtmL3NYS2ZZa2gycThiS01lTjZ6M1pvUWFyYVJkOC9maCtvaUoyVTd0?=
 =?utf-8?B?ZnI0L3A2NEZCMlkyMmpxTUZKeWJ1OTFzL21KVkZsRlVhSFBoWkZaYm1qVkdB?=
 =?utf-8?B?eE1BMkk1K0xiWE9hWDNGY3BkbjFxUzVETEl0RzZDZ3ZmRk5SWlROYWNpMDJq?=
 =?utf-8?B?aXJvanZnUUdQSFFXYUFEWTJZbmdLY2NEUTkwY2p0dHlTOUozcU9uZDBqMzhL?=
 =?utf-8?B?WlJ6bW1Tc0NkUXFDV1RzbnFKZ0Y0R2JOekphNzdENXh6NnJwaXJ2VlJHNklE?=
 =?utf-8?B?bW1wcmhGRitmR0ErWG5kVmVzOURoUE51SFN5R09sa0RiUnIrWHhhQmNjdVpC?=
 =?utf-8?Q?HL/ALBUtWfoOj7vQrhBg/Ub56HiHVP52PKba4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXYyb0R4RGhYNng2VjlJZHhaeko0T0RyMWliWEZESmk5MVhieW5ON2F6WHZq?=
 =?utf-8?B?Tzg4aHEwci9SejFJMlFGRXBLdys3MFlqb3hjdGV1N2ExWnNOeHNGcEs0c0VN?=
 =?utf-8?B?a0MwQkZlOHJlUjl1cmRmZ0hpenVING9WVVpZQUR4cEp2YlhmNG0wYUI0eFBF?=
 =?utf-8?B?QmdxbktpL3pLQzdDQWt1R0xXQWxYNk5zTndaWjF3Z0s1QmFNamNWY0NRRS9y?=
 =?utf-8?B?SlVUbGt6b0ZyUnc5OHdVYlJvOFBVYlBaMmhvSHkvYklWQW9iU2l6KytwZjlJ?=
 =?utf-8?B?RlpNNEc4dXFwTUlRa1MxbGM5VUY2V1gzKzgwL1o4aGJRN1JKMzNNTVJGZnh2?=
 =?utf-8?B?eEJucHVOZjlyREtEYnMrQ3BLQmV0djdRdEkzL2ZWcUtwYmxjU0hHU2tIREJI?=
 =?utf-8?B?SDhBU05oNHpLSDRUaUNyV3Y2Q0p2QXFDNUJIWHpLOVlMZ0I3LzhUcWVYcnhF?=
 =?utf-8?B?YXRDT1lHSTQ5SWdCZmxHWjZUZnBncjJmNVJDMERCaEM3L1FzVW1KOUJyVFFZ?=
 =?utf-8?B?L21zODlrVXlZempkdHkvakljeDNRWmdxcjk2MHdwekdVOHREWEgwSjhES0Np?=
 =?utf-8?B?cThIYzhDd0FVNk81OHFhY01tR0lmc295OE9xSHpoOVR1c3pwRlF1WDFNY3FH?=
 =?utf-8?B?ZHRBdldlQmNObkErWVJ3MWRXV0VvbG1UVnhPdkhHM29vN3Q3Z3QyajU3UXox?=
 =?utf-8?B?Mkoyc3Q2a0VWb1IzSUc4SzV4ZENxeVlzSy91dTh6VjNVVUxBSGJjU3FjT2Ey?=
 =?utf-8?B?dFpPVFZmaTFoeVM4azR0SlJiZm9HQ0VQS1NOdm43bjRnckk4cTNtS2NQK29i?=
 =?utf-8?B?c2VvZEczSTFuRXIzREhyRVlZVVoxR040TG1MS3Q2b3ZUaWNPS1ErbkFXVFVv?=
 =?utf-8?B?VzdHRCttdjRPRGtqZkllVHJRaGw2cWx0UWtZU1pycnFhSW04Ylh2WUNDa0FG?=
 =?utf-8?B?S1AydGxMaGpBQ1J6K0JwMmU4dU1kaVI1c0llUXg4YmtycmdhK1p3aEJqeGN6?=
 =?utf-8?B?Y3diNTgvSTNOQ04zWXZSU0V2Q2xYTXpKdVFheWRmSFkvS25pSW9XUGFyN0hx?=
 =?utf-8?B?MXdhSndxMXhGdys1cERmSTRGUjlRVmJwMFR5VHlvOXJxVUprTjhxWTZEZ05E?=
 =?utf-8?B?N2hGYkYzMitZQ2haWXU2VUNIb0Q5V25NZjEzUi81RkZwMmNrTVlSS3JQckc0?=
 =?utf-8?B?RmdoVVNlM0dLR2ZneTZvZXJQZ3pjMFVJYy95WGExZWxwODZZSnVjV0lCcnhj?=
 =?utf-8?B?ck9oZlc0bGpaU0NRaldieXJvMmowZEhIem91SStFeWowdytKTXV1YmRFQnRH?=
 =?utf-8?B?aUpadnJSNzkwY2x1TDk2eGl5YXJ5YU9qRFprK3FmeGZHR2VNY2hrZ2ZLSVJp?=
 =?utf-8?B?bWEvMk1OblRybWs0VUtOUjhKRVc4OEE3K0RaQjVkQ1BSVWwxMktMOGVTVUdo?=
 =?utf-8?B?Njg0aG9DTDdUK1UwbGM2UGRIRGNMM2V2bnh4L3B0MnZJK2Z4dTZYM3lqcVZQ?=
 =?utf-8?B?dEFOZ1BFZHhqNDRpU094UG9IZW1pRVh6QTNnY2RRZVNQZk1udmJsUVVjWGdj?=
 =?utf-8?B?S1B6cUcwc1Z4UGJkaVBzRk1ZZEIxcVoxSm43WUM1bDh3VXU1L0ExK3V2QXZ3?=
 =?utf-8?B?bEZPc3cxNDM5c2pQMExGQm9BMWEyVmY4Q3RsU3ZuNU9rRWtXZDdqRTRYMDZU?=
 =?utf-8?B?MHJFRzlwVS9DV1NaYkt4VjNJWEFwbzZSSEdHM1BNNjRVb1lQd0VRN3FFeHlz?=
 =?utf-8?B?cUMvN0JNVnBpQWM0YlNSYXhQb085c3BXUFJYekpmZmhVZWJKMlFpRytBeC9y?=
 =?utf-8?B?d2RuN0dDOVJxVnAyakhVS1kxU3Z4VFNmVnJpU3RDL01raVFZbVRGSzZrSDJ6?=
 =?utf-8?B?TlNKdXNGbW9Pa1NPRlkzc2RmYVA2NUZ1Qi8rMEpCRHFFZVIrVTZiakZ1emFh?=
 =?utf-8?B?THBmRjNMTGhpVjQrVUM1ckt3N2FnM1NrMkdRYmxRRDdSM1ZvN05aMmtGN1Za?=
 =?utf-8?B?WjBYcmgxKy93SmVTWHFQS3ptcW4zNWtyWFQ3RlVlZGRpVXE1MEZHS01KZ3pB?=
 =?utf-8?B?Tys2cmtqa3lRU0xsOEZWbXdtTjRTcit0ZisvYkwvTHUvQ29TMjVHdVlJK2dk?=
 =?utf-8?Q?PnZc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd25aa24-1480-4fb6-0de7-08dd04ff1f5c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:53:14.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzELQ5OxVBQ+sNN5x6IdbyW3SK/GY8pkAy+pficpgLFMmkux3sy+bBMYljvJcWCVqeBtin3/3hJp0xRd+C/0Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9967

Add doorbell test support.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v7
- none
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 470258009ddc2..bbe26ebbfd945 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -34,6 +34,7 @@ struct pci_test {
 	bool		copy;
 	unsigned long	size;
 	bool		use_dma;
+	bool		doorbell;
 };
 
 static int run_test(struct pci_test *test)
@@ -147,6 +148,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->doorbell) {
+		ret = ioctl(fd, PCITEST_DOORBELL, 0);
+		fprintf(stdout, "Ringing doorbell on the EP\t\t");
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	fflush(stdout);
 	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
@@ -172,7 +182,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:BdeIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -222,6 +232,9 @@ int main(int argc, char **argv)
 	case 'd':
 		test->use_dma = true;
 		continue;
+	case 'B':
+		test->doorbell = true;
+		continue;
 	case 'h':
 	default:
 usage:
@@ -241,6 +254,7 @@ int main(int argc, char **argv)
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n"
+			"\t-B			Doorbell test\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;

-- 
2.34.1


