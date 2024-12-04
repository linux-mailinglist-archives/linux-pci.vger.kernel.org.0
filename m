Return-Path: <linux-pci+bounces-17719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBFD9E4900
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F2D16971C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABD120D513;
	Wed,  4 Dec 2024 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rk6XlC57"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4120D4F8;
	Wed,  4 Dec 2024 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354801; cv=fail; b=HBZdIfsA4wfQkLGcwrha7DUXR9IuOHhxdLH25PLmAbUcusDGJNShmhW/xY0j8YGcraHuNCy36puuIYUCBP13cE/6k1TvOZfGIZeJLg7t+mKAPSm4zaDviEPY8lz9PaU8RFDu5Fxm3Wzy7sG6J6HBrYAkbMfUTollJWbAl/AE6hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354801; c=relaxed/simple;
	bh=jquS+fkORuaDI0V6B3sVnjDD5bRTRvh+jlQ8JabJKoI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ljcVR+OaxBr1JM2SvmAe0xM5NuCEJ4ssDRkmdruvd9Vr3XS55KI0Fmbj1F7C01cCXLUigB7V5ndCU4rZ3/qVZO/oPeCeMBkycGG2487ktR0hCOvicmCloXHFJLg3ZhNlgy+DCgJHZ5k4za/iawruBDj6Q8aFY00o/CHywD8t/q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rk6XlC57; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFGfQgJnryOxM2LL8CelRq0izRvc4xcjS/jKuimam295rxQkryjEGN6OK3USkLGUiJ1UM2FzGfqtLOQBTel7X8XHmwiu5toc6hCgAtgF8mTHZ5efH8lG3eOhKyEv38B/V1Q1H2LYNE2//YhzhlnoIhdR2m84cHTFPINsNgOsjwJkoJJ1RlvnfeDN2bKrRjmYzyMn54eKQXPtKTlGYfBDYlQvybi5y7q6pGX7eV7VIWj6Ilf/c8WloetMax22IqIB6xeweSo/u++yxcf12rgzpYqdj18BqoHltLrdfu+5St/umQjxWiGNaNIcvuqOvjq/TQLXffSvHKKVfZka50I3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TmAzFSRs/v5m1fkHfAiLGwO4KW6dmerf3DMnppfYHQ=;
 b=hQX1eAFfe5AE7M4Ri9TU8rGIKEc0Xuco/7V1dFWepIgqRZxzu+qHXseg83iaowpECPwmpqcdueBl2DivOb5dRsUA5ONlR4AW7ozLyM+r7j3u4wMMIuXObI8DeYwbALs50Xo8iyCwyrnPB1h4bUOqgVbalsZsPo/rAdysUOC2hu7fupebvkhAGMR5HTp87B3ska3aNIVUBlarZqr2W0KzDfsM1ZfV70HGzetLoYujtxtkrq28paZwSsllzQsmuH+XEylKLtxm2w9dXKTLr9zAJgF9bOogmmW/ZiUQuMDvQur44scfg8ES52iqllkOD+7Sod8tN+fthwoIuJSO+pbVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TmAzFSRs/v5m1fkHfAiLGwO4KW6dmerf3DMnppfYHQ=;
 b=Rk6XlC57E+brjVP+cCp1xCjY3QuUTLKFnRwaJzl9y7sj0ScZ97wFsmbFin3jmsqOHjUKK6Fq9U+Zid+sss+p8d56ycdK/RwU5y7lQs9N3cnjPl+btULqQ5E6PQngwvDmegZYWuM6fMeUk0dDVPTTMD48hO5ZWBqqU5poffahyIuRSC0+CKA4smL8sUA/DTb4H4yu34fXK9uLDretu77Oxh2Zt4RJDFyxQKAnyi2JpKTRruzZ38XcqhT+m1H4H5B6V8Vmze59GX7BvwGpphXI3Du/pW5Iw+OhPB+XbIem7VBgo1puobW54gdbkkMBep+IUOVNYhuaPsoVei+BvlK4Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11006.eurprd04.prod.outlook.com (2603:10a6:10:58a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 23:26:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:26:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 04 Dec 2024 18:25:55 -0500
Subject: [PATCH v10 5/7] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-ep-msi-v10-5-87c378dbcd6d@nxp.com>
References: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
In-Reply-To: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733354769; l=7892;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jquS+fkORuaDI0V6B3sVnjDD5bRTRvh+jlQ8JabJKoI=;
 b=1CNbkwrByCgtoyf57mJ/pWLaEDnijc0Yl8FZCRRvijPzsHsYRcSNpV2xQIQRag+vTzZQDs/PW
 jc65noXZrOZBwWUMAR451WurunySukstJJgyqke27wpYosa1xRlruJU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11006:EE_
X-MS-Office365-Filtering-Correlation-Id: 78dc9732-163f-40c8-6068-08dd14bb1881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEdERUI1QlJWVnRkZVREdjVCMUI3aXhkZjIxYU8xdEI2eDJzRExoN3pzdnNs?=
 =?utf-8?B?YUlRYUI1bCs5T3JVdTRGdjgwcnQ5Z09Lc3JzLy8rS012Q1EzMVVhbDQ0THQ4?=
 =?utf-8?B?bUZOblB6TEtBcnVRWnVtQVlDaStIZllqQzhoZDNQL0VtbStDVUZNWWZyZ0FD?=
 =?utf-8?B?RUFzT1ZtWHJFMEs1TGRLZ3ZZYzBaZWxuOWZjU3l1S0VDQW1wUTJGRi9Cd0p2?=
 =?utf-8?B?bnNub0kycXpQWjVNdVVuOStQejZ3RGdoNDVrcnBZVzBQQVpVaTRITDh0QytH?=
 =?utf-8?B?ZHFqSW1DRVZrdzZsdGZyUlJFTXFDdml5VEFISWF1RWllSGE0UmtFU3A3VUUx?=
 =?utf-8?B?T0d5RUNzeXZaZzg1YUVBK0xwTDZEZDV6UkVkbXRoNEhVeTZRcHV0RzJERGRM?=
 =?utf-8?B?aEd4a0ErZnpBS2N0WVBvNWNLbUVQb1kyUVpkbVRnUEJuRnUxUk5YZVBTTW5G?=
 =?utf-8?B?RGpONm16ZzhKaVlaQ1VUelJibFEvdHV5bnZmUFp3SDRDcFFTam1Dc3hFejcv?=
 =?utf-8?B?MmpCcHY5ZUZyK29Ka0RhenJ6cU8xNjNxQzY4RExVS2dPNUFXWjRyTGpUelRF?=
 =?utf-8?B?aGoyQjUzdXZTLzd3NDR1WUdoeDQ3UFRrZFpFdTd5QkZyZEJXamtHTmJDQXRR?=
 =?utf-8?B?YWdqWmdxbkR1MEVGT0dJTGlzZW4vRlh6SzVGNmVoYmdmaDVlRG1raFNSQ0Ez?=
 =?utf-8?B?WDVFUjBnVjRwcW1lOHA2WDFrZ0lBZVcycXRxQ09kd1IxU29OOStmM2hoYmR6?=
 =?utf-8?B?eURJdEhIblhlSDFhTk9YMmh6aW1reDdTU2hNSmdxaWFjQmR2ZE9KQ2dRR1o1?=
 =?utf-8?B?N3JPQW9EaVdDRWhwUlBqKzNUeDZnNmMycDJybnc1WlBrTDdadExOb3Z1dUNU?=
 =?utf-8?B?TkppQWNVTDBOdktLZFNoUHhWZkpNbnpsN0dxOWdXQ3NMYnZoT1Z4dVZ4L1lR?=
 =?utf-8?B?ZGpHZGY4VE9CNFUrVUtmcjdwaFdvZ1RidGhybDI3OTA3R0Q5NUpqdzhybjc3?=
 =?utf-8?B?bFlTMllLVEQvVTA3a2lkQXNXMWIvQVcycHBUSzhhSFc5ZXA4dkR0cCsrMWIz?=
 =?utf-8?B?U3l3bGk1cDNGbXFmK2NjUEFXNzhVZGFVUHp5aHdpU0hJaGJPeWdnT1pEbzMy?=
 =?utf-8?B?Rldabkk3VTh5RzJpWVJ6TkFSdzVHS1JTb0xRRFJkUmw2Ti9FVmFYWmVObW41?=
 =?utf-8?B?TG9HM0t5dkNyQmR3RWZXRmdmWTd2R2VGOHpCZ1dGYTNzTXF6TnV0N0d3RVdo?=
 =?utf-8?B?QlRzTTMvYyttaHFNa2FuWGVCQUxBZm1idlEwaXMvYXNwdG91a0xEa1hZNUdV?=
 =?utf-8?B?cXFKNTF1S242dHpvVlFPQ1hKRGNXbE5yOEU0U3llbWNpOUV6aityWExrUGVL?=
 =?utf-8?B?YVJMOHoxVlV6ZEZZWEJrSk1udE1vRnhLdlRxbkloR1hadmJsblNjUmNyUFpS?=
 =?utf-8?B?WGxveTJpRzlIVnNSd0E2T3JJTXJtSjJzakFlNnNLK0lZbUxZWTdQUVJHZVJX?=
 =?utf-8?B?YitlZ1BMcDN0QUNvU1pMdlRuNG5LY2JSYlZVOXlkRDljZ2p1TzVtVXJVU3oz?=
 =?utf-8?B?M1NZaEpMa0ZwbFI4SzQ5elhicGd0WEJqUG11REhjL1EzRlh0d0FtMWlvcm43?=
 =?utf-8?B?VFp5Z1daY2w3T240SG5HdENzRXVIMkN2TlRZVEFHd2FHYSs0TkZpaXUySEJq?=
 =?utf-8?B?NWQyQ1hWcnY1eXhmUFBidi9DTXo2M25YUGZuRWVQZHUwUS9Wd2I2cFV0NE0w?=
 =?utf-8?B?NU9iL3l2aXlxZmxWeDF4anQrUGluUzJxV2JpODJ5Q2o0eklyZTIxazl0a3Jm?=
 =?utf-8?B?MEd6K2dseW5lQy9kWlZRM3BRSW1QbGE1aDFqSURWNHZqYi9zSlFBY1B5Vjhn?=
 =?utf-8?B?bFVRS3Ywbmlqbnk4eVFrY2I4S1VieVk4SkNuMmR3U0pXTmtzWWN3TTZPOUtN?=
 =?utf-8?Q?sekLBzCPikQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUp1TFdKK0pNcHFFc2ViQ1h2Q3ltUGI4aWw2cWMzSE9Gdjg0bmh1S2MwYTJX?=
 =?utf-8?B?TFEreXZYUE9xUWJ2VlpZTDd1M0RBTkZoYjM5L0w1aFZyOHd5YzZZd3RnTFp2?=
 =?utf-8?B?eEZkV1p6UmZpWmdqazI5K2gyVXltRncySmFSNjNKUFVHRWo0QStXNXFHc2ZG?=
 =?utf-8?B?Wlg4RlZibk4rZnR4Rk9LZmpmVnlJZi9mY3lrVXVBSTJZQWdWNlhBRWhWOHg0?=
 =?utf-8?B?QU9NNXQ1dVRCd3VWZVo3ZXB4SEdtRys0L2FMYXNTK0h6TlIzbmsrVEs3amgw?=
 =?utf-8?B?QjNuV0NrQ0ZuRU9lSkZZTlFCZEJTSUhDZEFPd25TQ0VOQWV6NVJxQ2t5WjZy?=
 =?utf-8?B?OTF4dXJJUVVMWHlYMXdEcERCNjd3eVBLaGMzenRrM3lMRXpUV1U1R3ZPbHJh?=
 =?utf-8?B?SmpGNjl3OHdnYmt4ZlNwM25oUVFxL3ZUQmlyb2VId0pzUHJ0Ynl3ZEl0U29K?=
 =?utf-8?B?ZkxWSkJ4aFZsTlBobmtwbFZBNTM4bGNFT3B2aVFPQXR5QjZoOWhqYm5BUmpi?=
 =?utf-8?B?eHFrOVdLR2hya3lrOUx2RDZ6VWZDNGJCTXB6TjZmcWJkZFVNeUI4eHQ0UXI1?=
 =?utf-8?B?Si9xcjFXWmZXVlRFU0k1WFhNb1JVWmtDOHJlOEZQbjFXMEREMXFTUEVTMnoy?=
 =?utf-8?B?U0lNMVYvcWRnd2dVUytWbkNiZ0VmZHk1Ykphc3FRT2N1ZDd4NGdNaUpQSTNY?=
 =?utf-8?B?a0VoTitQYXpFejM1TndSM0RqQ3cxaDlzZURIYzJKRlZNQ3U2SzNBTXdkcFIz?=
 =?utf-8?B?Rm80ejlHT0s1bWpaYkEwaVhYM3hJRWlrQi9jRjVrRzlnMERsbnNSMUx1aVcw?=
 =?utf-8?B?QlY5SFhVTFdadm1RQWhZU0twRk1mZ2d5dC8xbTNVZXQ1NHNVSUljS1ZjRW5l?=
 =?utf-8?B?MHlIc0N6L3RDVHhsRzhKYTBaZ0hKaVkzL24xVTVBMVN2SnFoUzYwcVA4OW1G?=
 =?utf-8?B?bGZxSkliMDJXWnpWd2xzMG9IbU1YcWJPb0RzMG83UDVNeXdvUTJ1R3hOYkU1?=
 =?utf-8?B?MlhHYjNnSUIrWEhaUm5wcTFMMWVDOFZoQ2tnQmhMV1dJSFh3TTdab1JDTFFQ?=
 =?utf-8?B?ZVpZZVYzTUlRQUlJVjdBcy9MN2JPZzRtY2dTMGdnU0Vldm9PYnh5VHZUcWJU?=
 =?utf-8?B?QnAxSkRGbVU4V20vQTJFa1k0bXdDRlVRVmZkQ3V4bFFLam5YdVZISStLaHRx?=
 =?utf-8?B?d25mYzd6VTBLWXpPeHpCUHpjNlpxRXZtYUViTG9oRDF2ZlJyRjJyemlZMTZr?=
 =?utf-8?B?aElFYXlZU3pySG5mWHBpQ01QL1hSYnNRbFNlK25DdzRaamw2Nkw3Qmh5Wmx1?=
 =?utf-8?B?TFBmV0ptRTR4Q1A4ekVzc1k2VmtnTm51cVljMnNLZk9uamFGeitvbUpwZmpF?=
 =?utf-8?B?NVozVUl1bERBVlR0K3U4QTZEWFVrM2Y0Y09sZUE2eWRWZzJRbDNyTXdZMjJ1?=
 =?utf-8?B?QVdKV2lOaVR1SWRMekIzMGhPdWo5blJFTnRETFc4OXBvUjdPNmdGdXlyVitv?=
 =?utf-8?B?RGhEOVBoVk5PV252MEpOMW1NZTdZampwNjY3bGxnbUlGeWErUXJDMHZuOEtJ?=
 =?utf-8?B?UUUvSG11S0YrT2U3MHdielV5RjBrSnlJTU5GQkJCdUp4OUVuT1ZWQVBrVWhK?=
 =?utf-8?B?L2V1aVBsbWovaHQ2SUg3bjI2VmhiQjFZZm9OSUJSVVloazJGcUZmWkg0Zm10?=
 =?utf-8?B?ZUVaTnR6TWZuSU9YUGUzc3AxdS9HTlZueWdyOWlRWUpaRnRiNmFpRFVDcGI5?=
 =?utf-8?B?emZ3SWZ1c3B1dWJPTFQxTWVCQTBQMi9mK0txY0hmcmtWSGR6TEdHbFUwNGth?=
 =?utf-8?B?bXJIZG8rZVU1NVZsNVhMaWZIOUx3VzFydmFoTUZ2TmtIeUNrWkwzdW9IdDg5?=
 =?utf-8?B?RW1POWlURjZYRm1EMHlBSkdNRUovYUVETUd3SitQWDd6aDFtQ2l2cTJ1YWEv?=
 =?utf-8?B?OU5OMVFJTTZuQTFGRmZOWlI5LzA2OFM1WHYrYjlYYjJSSXRqbmY0TUQ1OFZM?=
 =?utf-8?B?aHRHd0pJOGM4Z05jVjc0RTV5WklqcFNyanFsRkF4U3lxRDJVZGVwU1JYNW83?=
 =?utf-8?B?Y1VVTnRxcmVjeXB5M0NSMVlXRkhBWW1xaDFlOEFhaUpKa1pDMERLQVpRS1NZ?=
 =?utf-8?Q?iVBrhgeR0Op0L8gE6pdnZvAEO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dc9732-163f-40c8-6068-08dd14bb1881
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:26:35.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0g3aA09ic9tLv4Q1SvGJoEb8b8G9SpboSJOfQyM6TRKTsKGt0eFzFkYdwbGKn+bIjPIm4ivRAA1cpOhwtjplUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11006

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data. Use
pci_epf_alloc_doorbell() to allocate a doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set STATUS_DOORBELL_SUCCESS in the doorbell callback to indicate
completion.

Avoid breaking compatibility between host and endpoint, add new command
COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL. Host side need send
COMMAND_ENABLE_DOORBELL to map one bar's inbound address to MSI space.
the command COMMAND_DISABLE_DOORBELL to recovery original inbound address
mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v10
- none

Change from v8 to v9
- move pci_epf_alloc_doorbell() into pci_epf_{enable/disable}_doorbell().
- remove doorbell_done in commit message.
- rename pci_epf_{enable/disable}_doorbell() to
pci_epf_test_{enable/disable}_doorbell() to align corrent code style.

Change from v7 to v8
- rename to pci_epf_align_inbound_addr_lo_hi()

Change from v6 to v7
- use help function pci_epf_align_addr_lo_hi()

Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 132 ++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116e..a0a0e86a081cb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -74,6 +83,9 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	doorbell_bar;
+	u32	doorbell_offset;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -642,6 +654,117 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
+{
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
+	struct pci_epf *epf = epf_test->epf;
+
+	if (reg->doorbell_bar > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		reg->doorbell_bar = NO_BAR;
+	}
+
+	if (epf->db_msg)
+		pci_epf_free_doorbell(epf);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epf_bar db_bar = {};
+	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	enum pci_barno bar;
+	size_t offset;
+	int ret;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+			  "pci-test-doorbell", epf_test);
+	if (ret) {
+		dev_err(&epf->dev,
+			"Failed to request irq %d, doorbell feature is not supported\n",
+			epf->db_msg[0].virq);
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_data = msg->data;
+	reg->doorbell_bar = bar;
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+					 &db_bar.phys_addr, &offset);
+
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_offset = offset;
+
+	db_bar.barno = bar;
+	db_bar.size = epf->bar[bar].size;
+	db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+	} else {
+		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	}
+}
+
+static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
+					  struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+		return;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+
+	pci_epf_test_doorbell_cleanup(epf_test);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -688,6 +811,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_test_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_test_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -934,6 +1065,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+	pci_epf_test_doorbell_cleanup(epf_test);
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


