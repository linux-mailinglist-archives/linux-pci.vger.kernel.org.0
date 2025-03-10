Return-Path: <linux-pci+bounces-23365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A874CA5A4A3
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF83D170597
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889911DEFE6;
	Mon, 10 Mar 2025 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f+AYrJld"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433E1DED5B;
	Mon, 10 Mar 2025 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637854; cv=fail; b=aFCadMAZWdS9mdQ8+77/OYxWFTY01xuiXrB4uf2MgUabrxjd3OYeRt+uZvxLU5bgtd52IEJAJO/sbZwk38Lqyfur4gtpPqJxg18btONsfOQkSPK1EA0ST/l5gv54CWPtRnY4p6iKR0KojrKOrmQHP5MhhTWrCPpvrWVkjxK28qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637854; c=relaxed/simple;
	bh=0KsQBqHbfFNCq9QD/+whO422n6pj/IJVLtfGCE2rv7c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eyIY447ptQquUA79o7AhVUB/p0+fDOgmZfD5s4oeRKb9GiE4afaPaCdE3w2WmmocFpj1Hvw4htRm3aSQlsO31jv4u+9QSUaNta8J40zZRkTg1NtxRbrgQxJq8PPshYSaLXtIWn1opl69uc9VfjG6QqLkJdbfGyb+ZDU+y9GUVWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f+AYrJld; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBkcj/1v0P4PLi1fLVbQNHakQy6EPb2y9dzrfwVLo4TORQZZVrmWoZepzDXT5eXKHjcOFhWp5jz5RMos4lwVCP6xwKqTBMdnQQGgq1KBqY3OV4svfQkVOpCjurK/9QUtcpzRgMMitaUCfKEAXr7ZLEEJtT//+0j+26c8b0vJoF1tdilsr5+CympNYQqH8yrW91M/04knUMsjg1O12H5a69KQJX6s7/4psPk7PzaWGBly710Bj8SwplZjnydi3Pqyn01CIWbL9kl6Sw/ERCQckZgdvJXl6nU2hl+59fz1j5fFA8muf75VZRqVm1/QJag8jYaaS45jw5xCZqhfJRC9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b00wJ8U6+8e+wjMwEgaC2piKfj4aomHf12Y98O3/aY=;
 b=hsFIWGOk5nS2PoiVN608x+Czy5lVldG1TctVzbLJm4aNmFUx6wgbRFVEcYe6FdGohhswwfvAY482e3IhVDXM8KZH79mwdGJC5LaGP4ETvWkdZlwvg43hkfv071RT052CJJGJ9RH1rOIrQDtt4xW1O2OySLZ9BWx71PKz6hfbW4EJ5Y0y1/V/TTgjYhsVb8vdk1C4hKfEB6xyI23Ke2U3pDgFyV09a4LDoJd8oETtJMLXOpcJaCvPjCV8QmFhC7gtYnL0cdkaQFZ+SJuiXFSnF2ZkuryOinYsIe000QgrOS73BOpawPkQIzmtEAjC0cAOQuHMR4FUdQHJZB9HUr6+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b00wJ8U6+8e+wjMwEgaC2piKfj4aomHf12Y98O3/aY=;
 b=f+AYrJld7Oq4vvgguWG4Bd7GphHHe/MjdFiiQgvZzZ5zGRSFyK23XcO8te+MgMm7zxK1TBXLh91XUTBBdCrTpN1PKf6SiztAPo2vOWQdYJRzOVPZE7BgT8QP83NgcaDnaIlQQAwnRFmgSu6XaK4Xfn9UUg1qSxnLqdKfz4Swd97YCaigajcX0tnTpVlk1eZWGkkG3NV8jlYNTudRrWalGUSvyOIJikDnXnLIIDAold2bplsgPl13OzlvvszABUFp6Lalk11cwfSz5QWT2COtL82FfTZCkjG7EBxMKEVYae/eFkJTkxPqY0FfD/CKogCHztYMpyU3OkD7tVB2aDZdxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10682.eurprd04.prod.outlook.com (2603:10a6:150:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:17:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:17:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Mar 2025 16:16:40 -0400
Subject: [PATCH v10 02/10] PCI: dwc: Rename cpu_addr to parent_bus_addr for
 ATU configuration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-pci_fixup_addr-v10-2-409dafc950d1@nxp.com>
References: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
In-Reply-To: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741637834; l=9694;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0KsQBqHbfFNCq9QD/+whO422n6pj/IJVLtfGCE2rv7c=;
 b=ql1vAlbXaA+SsVxAkTqL9u5LO9TPROTP64+cuOWA/uORXxTAbyJmeHGR4jQFAo08mAItPb3oU
 R5K0ysp94noDNFmPVo2aTjM+uhyVJ8FYH5gkVjI1hyoIOLG6uTnmrA0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10682:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eff8700-1c8f-48f5-e456-08dd601094e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzhsdE5ZQ0J4dzBOSXRBam9IcFJ6bmQ3QXJDaFFLMExnTkJvaVU1SW44YmV6?=
 =?utf-8?B?amJzUWl3Sm9kOTdGTWdwOUZxRVg0Y0dEMVh2RU9FNSthbWM3MGZZWnRNZy90?=
 =?utf-8?B?Z1RpVnVHUStzU1FoNVJISXFudzJzcHNXeW9tOFRmb3VkdFh2c2FQbGRrREtm?=
 =?utf-8?B?aEhFRERKZ3V4Yy9ucElmZEpsRHhaM2pScFpJcmMrQ1RSa3ZwZmYxNE0xZEpM?=
 =?utf-8?B?eXlmNWhsWEgrRUE1a3pjSGpUUGZGeHAvYTl5Uldqb2VWckNvb0cvNy96eDVP?=
 =?utf-8?B?bkRzdHJUM0JZNW9HSnNaTjljbFk5aDZ5Yy82eGIzMEpTV3YvWno1enBzMUtE?=
 =?utf-8?B?YVFMVmh4NG1lM1hSRDM5cC91dWttU21RZ3k5aXdHRGc1YzhSUFJncS90Snds?=
 =?utf-8?B?ejd5YVJHeSsrKzB3ZDA2M0V1YXpEcXhxeUw0Q3FITlZ4UUEzNDFMYm5CVEgr?=
 =?utf-8?B?ZDYvb0ppdTJtK3NRaWo2Q2FQcU9oRDBFb2xiaUFnMFdjYi9MY0hMb0p0bDZ0?=
 =?utf-8?B?YkNzSm5LQ05JT2FGZmZ6K1Q1SlRwOGNzSythQmtVTHMrbFVTWVpUQVhGTlJ3?=
 =?utf-8?B?T3FDVGNxdXBhYWZwVXRHcm9CMFlNNi9SLzNtNk9FS0FBdXIvQ1hocENFb0lJ?=
 =?utf-8?B?aUJuNjI0RTV4NGJWZzVvQWY5dWxvMXRvRG1wY3d2UEZrdURJQWlIRU9HVjFs?=
 =?utf-8?B?WHYrbWxsK3poRWJpb3ZBMG10WEUzZEtXSkNaN3Y2QkZma1krc1ZQTjN6Wnp0?=
 =?utf-8?B?RFhXQm9RRUhEMDd6YWN5S1ppM1FWblc3UWxvV1Jsd1NlVjNVazFHL3RwMkpi?=
 =?utf-8?B?QVladTc4UU52SFJzYmYvWEJpWGE5L0RuTkZlRGZlbnZDY3JRb2ZLTEQvRGFK?=
 =?utf-8?B?cllvVlNJS2tQNFo2RmtpaFJ6QmxTeEJTMmkyQjNLM1hNRUkwenZRVCs4ZDFU?=
 =?utf-8?B?cWYvSkhBVHkvc01uQmlnT0pISHlyem1jZkRQODg4ZEVWU2pSaFpZTitIOU94?=
 =?utf-8?B?b1ZuYUltNFlwTDlLc09YK0dINm5penR4WGl2YUUzZENpejUyS1E3TlM1WUww?=
 =?utf-8?B?K3F0MkdEYXpyQlVSU0NGRnRoeDVibi9aUG1CbzhVYzlIeGxxTzdOOFVnUXNK?=
 =?utf-8?B?eFNtNGNQRnEvUnpkZHNWQXBET3BMZG1iUThjVXRGMFdQQWFPbkVjUG1GUEdw?=
 =?utf-8?B?K1crbjlNak9MWkRxa2pVUmNXZDd0akQ2ZWU3eXJna0h2ekc4dFltcnE4ZXQ4?=
 =?utf-8?B?K2pGVUF3dnNTOU9tZC82VVBTMW9MRnpqYnUwL0ZhSmk4Y3JJWmg3UWhncVJ4?=
 =?utf-8?B?ajZLdnVDVDE3WVNNdEgxOHFSa0RhYTdlOWNLQUVMbzFzNUQ1cEc1ZGNEckV2?=
 =?utf-8?B?ZDRLWTRyeFlDMVgxM2VJdy9jZ1pLTVhlWFVKYUhkVmxGVXEyOVpHbUYwbVM0?=
 =?utf-8?B?dUgvV0ZFMHNaaHRVM0M3c0NoSklSRHRUZVEwMm9DbnJNczJlTTN2ZlUrZ3Fm?=
 =?utf-8?B?VzlodDEya0dOelJvK1BBdVRrdGJpTk55N3ZqRXI0SGZSNXVvajlQeHkyYi9V?=
 =?utf-8?B?T3RRcThRdG1zeUxTYjhEaEkwUFFzdVA0YmJ3Q3JBYnF6cDcybTRLL0xkVXJm?=
 =?utf-8?B?OWtqZ2hhNWZNZ0x6elhTRGJGeGVQWFRkRHh1dDhUOXQrWThkUUVQM2ZRNU1Z?=
 =?utf-8?B?WVZnQTlUbkkrT1k0bUhjRDdCMUVrNE9oakJzZzgzNFFsTE1OcmZiVjI2Q0NG?=
 =?utf-8?B?dlA3blcyKzNCZTFlVUZPWFZ0UEZUbjM5a2JPek00aXBUOFovazVCNWZMV3g3?=
 =?utf-8?B?YU1sQVk2dkwvbnlVSC9KNHVsWHU1L0t0dUxvWmdYZnVsMTI1d3FDOUE3bTFk?=
 =?utf-8?B?czhlRE9CUG14ZWhaakN3N0lLS1dDQlJOS3M5UHdwK2tGQzBwWk1JUWhrMlRD?=
 =?utf-8?B?emFQaHJoSFBpRFhQK3czNUllT2I5OXRvbVBBSWVza0ppcG5ZUDMxWVdkb0Zi?=
 =?utf-8?B?TG16Ukt4NWpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFFsbW9Yckdna1dkVjE2ZVY0eHV1WXR5WXg4R2F3S1lnWTdobWY0WHRtUjdy?=
 =?utf-8?B?VjZFUzFDZGVldHVQUmpQMUNYME5UZytUb2NOWHRRdDBYYXpwUEx6VjhQTjFC?=
 =?utf-8?B?NkFOWDRKeGRFL2c1N3FrdGJuRmZMdVRHSHF3NUxISkZ6dWREZklNV042Z2Jx?=
 =?utf-8?B?bDRQRWVOQTBMQmk5TVd2ZHEzbjlmSktYNlBENzBqTUo2QTlkcXJYNFA0UWV4?=
 =?utf-8?B?OXpVcG9sVlJJU2UxdzZPTk1UVjVQWHA5VDFKc2x5QjduUytoM2hBS1BGNHhC?=
 =?utf-8?B?QUpMbXVqRWV3OW9GYVFFRExnVWh4TVUzYytKaVZuVytneU9SN0xCRkdwM0RD?=
 =?utf-8?B?cHk0eTluOE9rdzFMZ2plWkJidDhJWTlCZUFHT3Y3MDROK3RIa3lpczNyTDQw?=
 =?utf-8?B?NzhadXpEL3dsVElZV3VERjI4akpqTmlBMEk1UkJFNXJ1Z0JNODdLOWZvY2xP?=
 =?utf-8?B?b3Qza0tOQ25IQ2lua2c1bnh2TFAxZzVubUZNb0dGTUZyUTNQaFBYT2FCK1NT?=
 =?utf-8?B?RHNyZUJGajVCWVd0N3JoVFpSM1VaV0RaMmd3d3VOZmx1R2hZZjBxUm42Tk5x?=
 =?utf-8?B?YWh6NDZnYjZ5Nm1mc2svaXFYdjVLTVg1NlVRUUJCcDRrNXZNTnZmNGdKYTBt?=
 =?utf-8?B?UStPa2RFSUdtSFhGVlNaTzUvanArVkUwRi9hVzdpd3BPRTJxOVBpbVM1UlB0?=
 =?utf-8?B?M1o5N1VmU1dOeHk3M1MyRzNPWUZNa3JKa1cwdjBGMUNoWDBSRlZCTC9SdTRU?=
 =?utf-8?B?K2FaV25tZEIvRlJZZnR1V0FTay9BcGxIYnQxemFPRGJtMHorenlXYi82Smk0?=
 =?utf-8?B?YWVOTGsxSkZvQ2Zxbkxyd2Y4ZzFHalVoK0lzclFWWEo5UmhjNnFFenlubFRl?=
 =?utf-8?B?Y0hDQ3NtbU55NFh6T2VmbHE0M2p2ZktHTXdOTFRPTVVQZmhBWXNhMm9jdXd6?=
 =?utf-8?B?V2lTNXJ5YjA1QkxoM2lpdXRpUG92aUJhM29FVjRnR1VETjNzdzlMUTdyS05E?=
 =?utf-8?B?M3E2aGlZRTdzeHlIdklKSEF4cVpaWFZHMHBkeGxGTzdicjM5Y0NmMStBV1Va?=
 =?utf-8?B?RWJtbzM1aFJvM1BsU0ExY2ZxZnVyTFoxMk1ucVBkT1lpT1E2WWVsQkVNUjB2?=
 =?utf-8?B?WE51L1VJT1VSaTBTVjFyelE4MThnVlpWTjZSUUQyZk9yV21xaXhEMCtJS2Ju?=
 =?utf-8?B?aUhDaytDUnhXZlgvMCtpV2E3RU5Fc0RreFpUV3Y1RXlDTDFydlIwWm02amdl?=
 =?utf-8?B?UVNVRlF1UG9zUHBtVld5SXd1TURMWmMxbjB5SGdCUlc0ajRhdzBxTFZ4eEVU?=
 =?utf-8?B?anJ5U1ZWMmx1NVllUGZoaDgzZFNVcEZ6U2ZQamIvaXV3emRlTlczTG1XcVo4?=
 =?utf-8?B?MllkYk5RNC9XVEFCZlhsZTlFSkxCRHl4OE4rb0dHTE9DQzl5VXczRUZ3VFBq?=
 =?utf-8?B?cndFUWdYOWwrMW80M3BDQWdFVERvcFBib0lwVXMreHh1ckJDT25OTVpJU1Jo?=
 =?utf-8?B?WkxoQkVkMkdWK0M5eFQwYTkwSjFBRHM4eXY5MHRibTM1LzVjSWVkVGNhL0po?=
 =?utf-8?B?THloTnM1cUFaVWhUQzJwYlBtZWJXcjI2YmZpSUdLNFV4RjlKWE5YZHB2bms3?=
 =?utf-8?B?V3oxU1NwR2prTURSNGoxVXdkZVBJV2ZVRGxLZ1lJWXB2NUFheTdiZkM1L1I1?=
 =?utf-8?B?N1FNRlNmK2llcy9ZYzVia3JKMkpJSGFScTIrUHdUQnBtek5XREJ5WGg5MEVU?=
 =?utf-8?B?SVlmZjIveStFNW5GZzU4cXN4ZG00TUYvTVUvNWUySWNra1kweXEvSVVqWmZr?=
 =?utf-8?B?UDVhcjdoNDVHZ0xpKzJrcWpPd0NPWm94SXU5T1VJOEFWOHJUeTRNb25FTTIx?=
 =?utf-8?B?dkxJT1RMV0QyL1RVWlhjOVN3ako2MlY1U0paUS8vZUV1WmQvT1hTcU82WjE4?=
 =?utf-8?B?Q3JxZnBianVWazRIckcxcmRKV09lM1VSR29HWmxZandJZnBSRG1OUFZBK0Jp?=
 =?utf-8?B?V1hPalRRK0ZHaE9lM0dFMXJDbTBXNzdhTmRHZHVGa1MwTzQwUlB3d3UvdUpK?=
 =?utf-8?B?QXMrYnlxc0thempaUkwrL29HSzRFTU5FRmN4UXZpbUhEYVBQTnBHWlFnbmth?=
 =?utf-8?Q?leQ4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eff8700-1c8f-48f5-e456-08dd601094e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:17:29.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZGNDRLNUSlAYRzkFiOzwE9ZFVh6nYguGoQuFWmJdCwX/gL1Ol32KQLKYnqyRLfi5Biqkhuy/elIGtyvJPSTIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10682

Rename `cpu_addr` to `parent_bus_addr` in the DesignWare ATU configuration.
The ATU translates parent bus addresses to PCI addresses, which are often
the same as CPU addresses but can differ in systems where the bus fabric
translates addresses before passing them to the PCIe controller. This
renaming clarifies the purpose and avoids confusion.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v10
- rename header file's cpu_addr for dw_pcie_prog_inbound_atu() and
dw_pcie_prog_ep_inbound_atu();

change from v8 to v9
- new patch
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 +++---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++----
 drivers/pci/controller/dwc/pcie-designware.c      | 34 +++++++++++------------
 drivers/pci/controller/dwc/pcie-designware.h      |  7 +++--
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8e07d432e74f2..80ac2f9e88eb5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -128,7 +128,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 
 static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
-				  dma_addr_t cpu_addr, enum pci_barno bar,
+				  dma_addr_t parent_bus_addr, enum pci_barno bar,
 				  size_t size)
 {
 	int ret;
@@ -146,7 +146,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	}
 
 	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
-					  cpu_addr, bar, size);
+					  parent_bus_addr, bar, size);
 	if (ret < 0) {
 		dev_err(pci->dev, "Failed to program IB window\n");
 		return ret;
@@ -181,7 +181,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
 		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
-	ep->outbound_addr[free_win] = atu->cpu_addr;
+	ep->outbound_addr[free_win] = atu->parent_bus_addr;
 
 	return 0;
 }
@@ -333,7 +333,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.cpu_addr = addr;
+	atu.parent_bus_addr = addr;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ae3fd2a5dbf85..1206b26bff3f2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -616,7 +616,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 		type = PCIE_ATU_TYPE_CFG1;
 
 	atu.type = type;
-	atu.cpu_addr = pp->cfg0_base;
+	atu.parent_bus_addr = pp->cfg0_base;
 	atu.pci_addr = busdev;
 	atu.size = pp->cfg0_size;
 
@@ -641,7 +641,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.cpu_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -667,7 +667,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.cpu_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -736,7 +736,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
-		atu.cpu_addr = entry->res->start;
+		atu.parent_bus_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
@@ -758,7 +758,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows > ++i) {
 			atu.index = i;
 			atu.type = PCIE_ATU_TYPE_IO;
-			atu.cpu_addr = pp->io_base;
+			atu.parent_bus_addr = pp->io_base;
 			atu.pci_addr = pp->io_bus_addr;
 			atu.size = pp->io_size;
 
@@ -902,7 +902,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.size = resource_size(pci->pp.msg_res);
 	atu.index = pci->pp.msg_atu_index;
 
-	atu.cpu_addr = pci->pp.msg_res->start;
+	atu.parent_bus_addr = pci->pp.msg_res->start;
 
 	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072c..9d0a5f75effcc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -470,25 +470,25 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu)
 {
-	u64 cpu_addr = atu->cpu_addr;
+	u64 parent_bus_addr = atu->parent_bus_addr;
 	u32 retries, val;
 	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
-		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
+		parent_bus_addr = pci->ops->cpu_addr_fixup(pci, parent_bus_addr);
 
-	limit_addr = cpu_addr + atu->size - 1;
+	limit_addr = parent_bus_addr + atu->size - 1;
 
-	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
-	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
+	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
+	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
 		return -EINVAL;
 	}
 
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
 			      lower_32_bits(limit_addr));
@@ -502,7 +502,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      upper_32_bits(atu->pci_addr));
 
 	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
-	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
+	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (dw_pcie_ver_is(pci, 490A))
@@ -545,13 +545,13 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
 }
 
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
-			     u64 cpu_addr, u64 pci_addr, u64 size)
+			     u64 parent_bus_addr, u64 pci_addr, u64 size)
 {
 	u64 limit_addr = pci_addr + size - 1;
 	u32 retries, val;
 
 	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
-	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
+	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
 		return -EINVAL;
 	}
@@ -568,9 +568,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 				      upper_32_bits(limit_addr));
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	val = type;
 	if (upper_32_bits(limit_addr) > upper_32_bits(pci_addr) &&
@@ -597,18 +597,18 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 }
 
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				int type, u64 cpu_addr, u8 bar, size_t size)
+				int type, u64 parent_bus_addr, u8 bar, size_t size)
 {
 	u32 retries, val;
 
-	if (!IS_ALIGNED(cpu_addr, pci->region_align) ||
-	    !IS_ALIGNED(cpu_addr, size))
+	if (!IS_ALIGNED(parent_bus_addr, pci->region_align) ||
+	    !IS_ALIGNED(parent_bus_addr, size))
 		return -EINVAL;
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL1, type |
 			      PCIE_ATU_FUNC_NUM(func_no));
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea163..d0d8c622a6e8b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -343,7 +343,7 @@ struct dw_pcie_ob_atu_cfg {
 	u8 func_no;
 	u8 code;
 	u8 routing;
-	u64 cpu_addr;
+	u64 parent_bus_addr;
 	u64 pci_addr;
 	u64 size;
 };
@@ -491,9 +491,10 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci);
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
-			     u64 cpu_addr, u64 pci_addr, u64 size);
+			     u64 parent_bus_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				int type, u64 cpu_addr, u8 bar, size_t size);
+				int type, u64 parent_bus_addr,
+				u8 bar, size_t size);
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);

-- 
2.34.1


