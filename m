Return-Path: <linux-pci+bounces-23656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE0CA5FA35
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908DE19C5A71
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EEE269B0E;
	Thu, 13 Mar 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NolOB7eI"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D42698AC;
	Thu, 13 Mar 2025 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880357; cv=fail; b=FJ8xE+ia9WkPCsvM8rdkxjueB2gzSYzBPqKA82rrIbcGSQzjDmf+jO3uXzddJ9qvr4xfBAxbpl2ppPa0/YVTGURj7RKw0xaenOqB45E1nRj8XJdEnCXnxYuiYelLMc2Rq0avW/QhYaR1ia/Q8bV+qdTzp5F2yphuOevKPHh18pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880357; c=relaxed/simple;
	bh=AUXtC8H/FTHPcXtiN3EH1E52WI5BlzetCri0vzeowoA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RxQ//0b2YxX9+GYlHRW4CiwguyjXEIRjbtYrJBK/r3QXPoaDsz9unxg8LkRMdipXUK4+DTnlzUsKXEd2HjIKgZpv8cNbjm4NOYJqh4+ptpJ4wTcXmO1hYWNCftnzy4qL+DmqRXaG3cW8tJR9q4PH8xQfD1p9zIYeV1UQqQs7PnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NolOB7eI; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zfn8MvGaPhvvtf+QrRo744IfarHruhDfz+umV5cE8tkYoeZ2G1d9xMNa4eIBNPzQijBzzomvihmPkYg+1YA2tTICM2vWYVxZwX041UZv4JGJaWHoAIB2IdcTxSukio9POR1CdeJH+n+fgbwBjFRVpmUs0ZwSZGJWnuZ84rN4PUUwBnD1upXj7xrnZeDUeBu5vJfFvJb4FpHPgzCdrQJZ4t0vCb/sBC6xOZwUEej5i4S9uVLtnAF5YMyVHnthYFY1KZiBz+l2dT9kHuckNL26No4YTUygLLeETq0JzQ8QhFnlXMo3NHy1bOXry2Lv7+4IT4j5u9q3PveCLa16NSq85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZfCysn5S4+XnUcPLACOvSajhoolaGVZluObBWMpN4A=;
 b=o90LUKJPLpuRk3/YExmoYZbYOzO+YHIGLYoXUAnLFoYXJY6dr0x7upn9SJPyrxY5ZeMWN9s5U6e8vlIrS/9QkloZlReLgtQMHh/EyUu7iyuX4KU4meM5qUOaBBMDbNvUGFSzq1uflnDmbX+5TvjLNdCd10L8vK5fS+ZU+Lc5HlHfgRkvKmHHviGg42VqvcIFROyqEBqIkM73Ulm2xBymqPkMrffAANEx+KTNWTgqyC0sMmcEuv5MEW/7MwgGDkKO+JuTwqPUZstAS11O1c5xeaK6AcW9koxbXYUZkDrEPqYz3OzWH9CdqqS7+nqcmcfziGFXpgmrVjJwiR1bQcwFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZfCysn5S4+XnUcPLACOvSajhoolaGVZluObBWMpN4A=;
 b=NolOB7eIH/wPC1QcQvJvCMJrkM9Wglg+6DXB65cev9e47He1+yrsnwqDStDqguUjwYFmxOFPh8ogPtDeUG/2WQ1b8vCNxubSwmNeemlOFVsm5rxZT0fKwFyqwoPahOVHRr/cjlYqpeGc0GEDsL+mJn64DyiBJbgRsMkVyzXDqr2guu1YuHrDeygeVZpwfQrR3AzOAua59q0LLWgMlntzBsBjLLi/L3VnYPS97IMAe0tmPcCgfGnephZYxAx8GWe00yT2pV3/PS6+ArtuO/uZppjZomFWWHl/REW8u6U9ShtuL53xIpRWHqaa1dI0tDX+/7U0Fekiam1dpxM2r3z73w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8119.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:39:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:39:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Mar 2025 11:38:40 -0400
Subject: [PATCH v11 04/11] PCI: dwc: Move devm_pci_alloc_host_bridge() to
 the beginning of dw_pcie_host_init()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pci_fixup_addr-v11-4-01d2313502ab@nxp.com>
References: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
In-Reply-To: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=1299;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AUXtC8H/FTHPcXtiN3EH1E52WI5BlzetCri0vzeowoA=;
 b=QlC3jIKCFYtP52F64pUzrd/DKyz66z/Cx8FMqRBKXWB5nYKToVIdl9GQjKzpcgUfkPS/f6682
 Zpso90T3+7KBJz6RVcLvTAP2iTBouGYgJQLEjKL4qkQj/junDAnDFZf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:806:22::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 775f0dd4-b825-486f-d259-08dd6245342f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVVZN0J5b1lrMUpENWFFc1lOMnRZcHlyZXBRNnh6R29yVHlGeGJaNWVySndL?=
 =?utf-8?B?cGl5OEkvRzVZdjJjdTIwd0dhRGJjVG9lcWFKQmhsU0FRTzN3ZGRLcHRNYUNv?=
 =?utf-8?B?S1VtanVrZ2I1bXh1cWNDRSs5bThBd2w0Yzl5bVBBQk8xYXcwTlVEbEZtWTR5?=
 =?utf-8?B?d2ZySklVa1RFeXExVzdpeTNINXlZM25hbEpsT3oxcTVYNENFRmc1aFBKQklO?=
 =?utf-8?B?MjFZcFdsckFVVG5iOXhXR2hBNE9yemdpZWNoMmFZb255SkxNdk00c2VOUG1G?=
 =?utf-8?B?enhWMmdDd2RSOW9haFE1S3k3K1BlTVNnbG9SRTk0UjlhZjBLT3owNFlsc2Y4?=
 =?utf-8?B?dEoyaXVHankzTFYxdTJzblhlbUdRWWd3ZmZvb0ZPelhTdHFSQzhMUlQ0Z2p6?=
 =?utf-8?B?OTE4blpnL3lRYklyTDBDbDF3NTlkbXE3WTdRVmxrT3Y2WEtneDA0TkJEbHBn?=
 =?utf-8?B?ZWtsNTZGeWZNb3E2enpFdC9hQ2NUOFpJaXhTTUp2cHQwMGU5NWVYaHNXVlJh?=
 =?utf-8?B?Q3RPeVQrRm1nMjhER1lSQmVRMytSMWZxQVVVbEZFZURFaVdnZGdOWExxUHRM?=
 =?utf-8?B?S2lKNXpuMlBGNFRnUlB3b2MxbG1YS3A5ZlJYTUtoSGJaVVVoZnM0OGw2OVdr?=
 =?utf-8?B?UHZvOElodVA0ekpBU0czWGxSS1dwOTVGak91MXlPRk5TM0FGWUs3V0FBOXdn?=
 =?utf-8?B?M2hWYm9yVGhxV1VOUE1UYVQyRkx3WFd3MHlxemhnSkE5TU1CTlJUMThoU1lx?=
 =?utf-8?B?dGRpV25lZDNWYklZdDFKYU56L3l1RS85dm9ESlNaRU1tR0dpM1IvZ084T1h4?=
 =?utf-8?B?eXUvUzZhSTB4cWxPQjVzcmQ5dTBOYzQ3SzVNbDRudE95TXVIbFNTejF1UXVF?=
 =?utf-8?B?MG56UXdlTlFrTURDcXZTWEo3bmM2YXRaVGFDckZyVlJ4SFRpTnJMaDZVN21U?=
 =?utf-8?B?NkNuNkZHWlpQWURPWWVsOGY2cEFTQnl6T1hMeUxCN0tMZ3N4eVE4VElhM3gr?=
 =?utf-8?B?V2NyRmNYZ0szdEk3dXJjemkyM3RhSFpCUmF5YUpGRmFLZEdnbW5PTzFuZDdT?=
 =?utf-8?B?U0RMWmVnNlpsaFkrRC94ajNUWFdqc2M0OEhlODJTY1JMOWNXR0lRN0VZMHpI?=
 =?utf-8?B?ZTBFdW92RzZVQmNBazBHSFkwVWFxaXZOV3kxdFBHMWEvTGpwWEFKcTRSR3N4?=
 =?utf-8?B?amdkN0xVS1VOZ0xXbFd2SkRNQ1BqODUycXVTTzJsaTV2c0ZqWDl1MFFVR0V6?=
 =?utf-8?B?YnNRZkNUM2NicjlSZWlHVGQ3Z2RuS3lUZEltY0E0RXBDajFOUEZNdmhPdmF4?=
 =?utf-8?B?N3F0My9vZFNnZ1lNY1IveWY1SGhrRUNHamJYamVibHdCbWV0ZXFpUU50cldL?=
 =?utf-8?B?NWRLOERZazJyenhFR0FVTzBRZEladDcvdFROSGxMUkhRTW9WMlJldFBZbUJY?=
 =?utf-8?B?N0pEd0hFMlRvcktzaGovcGsrWFRtR1hLNVRDenZMbkpmb3hudnMvSXZYeFhB?=
 =?utf-8?B?YjRjejRYYi9lQm5ndVNMVUZTQ0lqNGNLdGhIMjNNSVRVUGNsV2QzMUlUMS9m?=
 =?utf-8?B?K3hFRWJUTVdSTDhSUkZkV2FtWnQ3T1owVDA1R3kyUlA2RlhRM1RUWFkxM0Rs?=
 =?utf-8?B?QWhPZ3ExVVNvelpZWWIreEN4OGF2QkFxUDl2cXh4eG1sR3hMeEdCQnVhQmtk?=
 =?utf-8?B?ZlZaT2RDQTBUUEt3alFpQ1dvejgxak0yRTIvTy9CUituRUN1eFFxdCtNTDF3?=
 =?utf-8?B?dGFuVG1wRGYxY25WYnpGK3NKVWJhc3c1eTVSVXhBN2pxQzM2ZXhQQTFSWmx1?=
 =?utf-8?B?Z3FKSlczM0VmRzIvaVM5dFNxenhRWU0wdnVETG95UGFrNzhiNTV6bUs0Z1V4?=
 =?utf-8?B?M2dDZXFEUWx1Qm5RY1luNkJXQVJqbUVqUW04SDVCc0RnbWdLZGxCb082aHk4?=
 =?utf-8?B?b0lTalZVWW9UV09RNS8xYTZGTEhuRCs3VEpMaGtWck1kZi9WckZ6SmpYK21X?=
 =?utf-8?B?dWRnOGFESGpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGdPcWZuZnFOUTczT29USlhHODY3bXR1cUlTTmJ5d0J3OWVnQUx3VFpiYVh1?=
 =?utf-8?B?bkNzRkpUaXVOWkh1WFptQ0hZUGgvbm5FVTNVc0xhdzFqVFRhMWczTXpsc2NU?=
 =?utf-8?B?dnBHVjVXd3htVVZxbFpSejEza2dYRFZadnpINkVGTnJkVXRGdjcyWThwWHk3?=
 =?utf-8?B?d1FUV2xJcnkwR2gwRi84cUpXWjlCTjJNYWk5bk51aTdkWU5zOXN3Y2d6RExO?=
 =?utf-8?B?YnpJNEU3TTI2YXdEeEF1K0VFaHRlNzIrWGk5VmZlTmovMG5xV3g0U2tJdDJw?=
 =?utf-8?B?WHl2UGZUZW9XeXVhay9LbUlaTHJDL2lOVDM3ZGcrS093TnhZRlUvUkxjTXBh?=
 =?utf-8?B?WWVOYkJvSmk0d0tVekMydmx6bUFSbU1IbHZMSmlqL2xwdTMvWWdQSWtPU1F1?=
 =?utf-8?B?K0JCSVVvS0MxTFh4Z3VtMXdGL000ZHJlVWtkMUVkdURYUmZ0eEFiRG9OU2FM?=
 =?utf-8?B?QlM3cUE3djAyVFdVTG0vem4rUUsyQnlhSFltY1hnbVJabDlyOWhCMjBDaG9s?=
 =?utf-8?B?WTJ5RjVMR3B0QnFsU0pVQzJBK1JDZWZZVjY2RGNNbW45VUZGWWY0c2g5a3JK?=
 =?utf-8?B?WUsrc0UveC9wL3ZPeCtic3NBcEJOUWNrZUg5UWVEUUNQL0ZpNURHSlJYdzho?=
 =?utf-8?B?UlQ4WmZDY2E0bzZZTTdidlo2NC8zRkJuYXZ1Z3UvQTJmUEhqTXJuVklqYzhy?=
 =?utf-8?B?WWQwd3c0NTNxQzhRWHViYlVvd01ZeXM4VGg0bUlNanQrQksvMitwUVNkRlBy?=
 =?utf-8?B?V1V5emVrVVFxRVVVNGJ3QWpPaTJIRFhMczRRSXFYekRXQnNGVW5SWks0TFhx?=
 =?utf-8?B?blRlZ2hNNkJiL003TTR6TW44RklGKzZucGFraG5vaXpVdVp3TldrZUV5Tkk2?=
 =?utf-8?B?dkIvZVlwV0ZteGgrM1VPVmJKcFlpNElHRFRJS0xwc2doS0N1MzBocFhlbzcv?=
 =?utf-8?B?SW1TL1IxSkJueHRlbzVlTUN5OHJMM2kyVXJjOU5sVHV0SENqN2dwL0JJM1Ix?=
 =?utf-8?B?N25ZVG5WWWNnRUxkWHdoS2dnTWRMeHRhRFRZL3QwMGlJWDE2UVZrRTVPSTJR?=
 =?utf-8?B?WXE3akF3eWVuMmlmZ2ltTFB2VGYwZjFyQys2blRRT1J1VmZYS2tUZ1Vkclg2?=
 =?utf-8?B?YVl4S3VqNTZ5aHhUVkozTDlPQzJlWm1sSzBqaUU3cnFWeFVic3dKMGFHeVJH?=
 =?utf-8?B?VTRPWEVYY0M0NVRWMlVyK3Y5L0NsVGRlNmhhQXVJd0FNNkNwdFgzdGdLNmE1?=
 =?utf-8?B?Y0w5SkRuMlBqWlpmQVc3RWs2N1FqMGo0M25nOVpPa0UrV1RxenVhWWVzYm45?=
 =?utf-8?B?V2kyNHY4aytUTmloNVdqNmUyK3ZLUkhDL1hGNStNMFhDbk1BZ09IRmEyckN3?=
 =?utf-8?B?M3EwejVodE5aV2E0dG5hVElIVzRpcU5SQjMxMUNtSWdWUGZMOFFWZ3NUZE9Q?=
 =?utf-8?B?a1AzMkY2bmUwTVVOT2RGQUgvSDhMeHJzaVN3RGRublcydWIvN1BkMTFueEx0?=
 =?utf-8?B?UUpkVG1wSHg0WE9VT2NQZDE1bFNnNThQNUF2cDhhUzhYa1V6YlVOV0lyOW51?=
 =?utf-8?B?L3BIUzJIMzFOWk5pUGZXcnBWNHNrTFgxZHQ0aUp3VXdnOUNMcnI4V3lwUlgv?=
 =?utf-8?B?aDRhSEo5UkVvMmVPODVZVjhNdmlKdHg5K002SkxSbW0zYldaOUlJU1pVcERQ?=
 =?utf-8?B?eVRxSzlkdEdwZFhjYlJkWU9qQ0trcFBrNmhUck1GdThtMkNNUnVJN2FCV1Z2?=
 =?utf-8?B?TnI2N0J4aWQwWmdlUjh1N0s1NXkvTFlyd2RVNEZUTXRDREZkamZkVzZMRFkx?=
 =?utf-8?B?R0FsZTlzSXV2QTlGU29EZGJMN2xqaGkvS1hmRFNhSm5LUVdneXFVWldHSm9p?=
 =?utf-8?B?QkVDa1pTdzh3SEwvSk13WTRONkd2QWlKdlJMM3U2ZWx4YUU3VncyR3NCeGNt?=
 =?utf-8?B?d1JMcWI1eWU3RUI4TjgycmZrTWlCbVFndTNXdUJFVFl3MjgvWVF2bmZTY1lN?=
 =?utf-8?B?TVZnMnQ5TkJuazZuZTlmNTUwSHlrTEF2RjdTcitXNlhTWEo3SkVHbW5tQkpT?=
 =?utf-8?B?UkVteDc4bVdUbEZuQmFnUG1SVXdxc1UxT0tTYXVjMDJ4bDJTY2xyWFJIVzVp?=
 =?utf-8?Q?AzUhHkPdhZQRfEwa5dJiHXHSi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775f0dd4-b825-486f-d259-08dd6245342f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:39:12.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KFmNpIImgNhjhIyashhjzCPHktP06ReCk8skmWV+AfN/LkicGBoYqTeKfzESJkpBAlqu0C2GbHVmnvpQKJ09w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8119

Move devm_pci_alloc_host_bridge() to the beginning of dw_pcie_host_init().
Since devm_pci_alloc_host_bridge() is common code that doesn't depend on
any DWC resource, moving it earlier improves code logic and readability.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c57831902686e..52a441662cabe 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -452,6 +452,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	raw_spin_lock_init(&pp->lock);
 
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
+	if (!bridge)
+		return bridge;
+
+	pp->bridge = bridge;
+
 	ret = dw_pcie_get_resources(pci);
 	if (ret)
 		return ret;
@@ -460,12 +466,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	bridge = devm_pci_alloc_host_bridge(dev, 0);
-	if (!bridge)
-		return -ENOMEM;
-
-	pp->bridge = bridge;
-
 	/* Get the I/O range from DT */
 	win = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
 	if (win) {

-- 
2.34.1


