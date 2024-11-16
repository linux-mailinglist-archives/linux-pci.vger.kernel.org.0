Return-Path: <linux-pci+bounces-16973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54909CFF51
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC61B2692D
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282062B9C6;
	Sat, 16 Nov 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a34Q5pii"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013051.outbound.protection.outlook.com [52.101.67.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36622BB13;
	Sat, 16 Nov 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768081; cv=fail; b=vEXRAKUwSRZVBFFa+jEQzzCJ++RbO01b7D96jFVUwdJAPnhRmxM0hUZYBluriiFZKNikvJt9lvsNYomIJu5qo3mAubP3FuBdeKSvkN7rO5gbYSat+xcEzhjxXzYplD1dbmWCXl1MqTuEkjR2X9mYvZ+8IpYK4AOy6LwAiLJkpd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768081; c=relaxed/simple;
	bh=4vKx2rPx2m7XWgRxYUh6kb9XgUf/PMkH85+H1/AB+sM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ABO8ulXy/GY94dgUX2E3YbrPKzpGnIKtWyl1JkQYgFwz5VNAO+oraH26Atdw5wSQ4pAsJY76KiMjWCO4rFa5sjCIhl+trNsP+d0Z5oKdUfxISk1rCLgZ70IcHVmOY8QicSMleN9U0YJuPgKnC23PLwkiRL6eDKspB1Cx6/AOIXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a34Q5pii; arc=fail smtp.client-ip=52.101.67.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMoY2i0eUKmk54rBAvn91rFyjdWFgnLwbKUXaPfsbtxLVBjPb/AN4i/O/MsT3Hf+hVxw/GXGW/LWNjd+Hf/U89tX+luS9yPNjsNBb9hAHzg+trAFco7r1HpUuK8Pm96C2Fdpz2R0cgdYi4VGRkKk4uV3P08KLMTbm2BPKqSTCadOY2VgNBbKKjVqetbs/xMKpja7D7HV84Z6Nj214SAU8FXXwqm0AF9qWoz5+nAwP1nyac8/pQ/6hbZu7o/3SY8G8xdS8q8gSp22Agy+ZHjoJGc6pq0aViPCmUbioMCGasGZsIssZI+3RJJ6dZaTlr8mneSvViOT8EyE3bgMkFAbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ22JWiQxp/Dsr6tuhGS3SeKCcsaE199Pas5L1A5Z/k=;
 b=gupbtZb4kROgRKjpwTf9q79RnzDbmLSHY9qKpZ1xbIsiC15xBDMoWzvyd1tydJ/A048g1Psp6/TJ7D0gb3xxfLA88BKxLkgUoPQY6VB3Rvq1Jz8evwh6MAG8F1EjVpJyWHsSQ11X46NUrlligCn96VOfcWGdRqqXLderKC4NYXCcqgUagBDBGyz0iBAiPM3YOCrMqWifeYiQAQnL/6kq7pZOuEJ5olqInRjWVrOWcgB1byzGpcHtSxT+vunRMuZ2tEwD+Z+UKb1omx6GsXweNvBKYoqfRC+SMupLwaRamzB79h/fZqiu1OrJKMHuxj+twDC66AACLQW6xumC1pE+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ22JWiQxp/Dsr6tuhGS3SeKCcsaE199Pas5L1A5Z/k=;
 b=a34Q5piiA4DrLGgONnQjt7iRkD1fj6vJIDRZqGUODznLa70MPv4MceZpg6/Fwjd7WUpdoi1x1BEHeUF0ZrsQ17/uaesJenu78TiM10iwZw4GzsPr3cRbyI1nT0WT0jhmbvzQzQj6VQ7I4IMw6Biez8RPYgp51Puvbju+f+rSseaqB4yYOHcrMzDHATtMxNPpGa3RQltciSA5OylF2/RW8+8072qXZjBy/lKZb7DcyUabkDHFGiKllfQBwLOC+CPuuRqpjL/HxvJQyWDyqDe6jPUs1kvk5yJ1eM/HlriBo0NEXE+6kKXgOENLGBbd8nVwrtB3Dfmb12ho7ubL/HXd4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7265.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Sat, 16 Nov
 2024 14:41:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Sat, 16 Nov 2024
 14:41:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 16 Nov 2024 09:40:44 -0500
Subject: [PATCH v8 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-ep-msi-v8-4-6f1f68ffd1bb@nxp.com>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
In-Reply-To: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731768057; l=7742;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4vKx2rPx2m7XWgRxYUh6kb9XgUf/PMkH85+H1/AB+sM=;
 b=Jy4o0qZTn0v5n8B1dAPRcLp2iYSVwNri5rxx4sVkbNfB4zlzngT9PCf95RinIkM9JM7xNXYyL
 aw5yWDOuiMxD33SVtRLQj5WhtiCnPevt0aVOW3/zTEOAN211kdT581I
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: e820607b-6aaf-4abc-14e2-08dd064cb9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkRKclVsVzl2Z1NHUU91TFgzSm1YWkpVQVN4V3pHd05xVjdyck5WS2QzaFlY?=
 =?utf-8?B?Q0FIeU1FZEgrTzhnV2JTNXRXaDVQUVM2RHNXS054MC9uR04vRCs5cnRqem9T?=
 =?utf-8?B?TWFvUWN1MlRQOHR3UFRycGwzVys3RTZRbDFBcEJIc2orakFESlNyb3NWSzRq?=
 =?utf-8?B?Ulc4K3hBd3ZlSG9KTWRLZ2xIMXJkS0JzbmVaNmQ2cHM4dFdtY2pTRXYvVFVr?=
 =?utf-8?B?SVEzMnhQRGdSOFJPTnBGTy96aW1hME42b0VIdVo5N3ZxMEFkNFJNMlErSnZy?=
 =?utf-8?B?Z3k4ZFE5b1NQa1FDZzg4cEpoQ2xrOEJRb3RJMFBPMzhLekZ4SzIwN09NaUMr?=
 =?utf-8?B?SVM0RElFcjZZZjhyaDBYQktZNDQvd3ZYNk45M1NvUlRZL1ZaKytoNXhMbTc4?=
 =?utf-8?B?SklFamFhNGJWdlNIUmdpVlY3SkRSVDh5S2Vmd09SV21oRFBsUFZ2RTF5Q0h6?=
 =?utf-8?B?YWtmUGhzd2R2WEwyeG85cG1WQm0xK2QxbUlWVlV0MnB1d245ZGpPU25ZdHd5?=
 =?utf-8?B?NU5ZbjJ6R3p2c3IzN1c0d21uSGFGT013ZmJQY3ZKQkZkaFZIRklvR1dtbHdv?=
 =?utf-8?B?SWkvcEpKS0VTdXYxUE1Sdk5DaURpM01QNFJadndTYlk2VFNjZFlUL0pvc1Bn?=
 =?utf-8?B?ZE1FRzRsYVhoclc1NWdNZTJiZHdDbnNzaFhJZy81YzVScXlVbVFUWjczR1pL?=
 =?utf-8?B?WjhlYnhJSXNtNkpWKzA0c0hGSS9pM0hkMVpPbUhRcm5pVnB3T0Q3QmFOUE5E?=
 =?utf-8?B?WDU5NmYxUFNtV2taejlybWRUZXcwcDMwaDlMR041YVQ0SUpaUnB3K0R2YXFT?=
 =?utf-8?B?VEhpZXM3eldpWnFCMWJaamkvbTY5cS9SN1VjcDJDK20vMkNWc3dqcXplbENJ?=
 =?utf-8?B?M1RRazVjRWVrREhzRzVnU0RxN2tjd1prTE5XUWlEb21tRlA4R3p2TGxmK05D?=
 =?utf-8?B?a01WcTcrZHprM1V1YW5rWE0rbVc2L2hjZlNvY1NaL29MQVZpZWtYK2JhUHBJ?=
 =?utf-8?B?T0V2cWlwTkRscW9FeEpTekFxUnZpRFJvMGNrRFQ4d1ZSdUZvaTUzckVibHpF?=
 =?utf-8?B?SzZVbVF2SXR5RWpGcnU2VTF6clFSbUlGODBaMGhObWJ5RW5jeFZQY3ZLZTBy?=
 =?utf-8?B?NGlwZFhTdHpwT29Hc1IxNmNWUXkzdUpPUkw5WWgrTngwSUprSlhmTzZVS1Bo?=
 =?utf-8?B?YnRlTzlNbVRMV3U0bG42b1MrTU5rbVo1TDVJNTBCRDdDa1czMGxoRlNJRktQ?=
 =?utf-8?B?RDNiQXZKSVdYR1NJYWwrZktZcE5aZFIxbVNEcDFtMENoU1BadUJUdXRuOXZV?=
 =?utf-8?B?WGNKTjhSZ0dMTk8rRStuZzFBQ004aFlYVHpqbC95YmJ5N3h0bWFOK3dLVHQv?=
 =?utf-8?B?eTl4NzdKeWtRbHVhRmhQTGkyRHJ0K1ZlZGtEYVF1NjBmT2xJRWJWL0ZpYno1?=
 =?utf-8?B?czhHMUxFK1grNUloMEc4TUZZSDRuSzN6QVRuTzNQbnFjc0M3MzYxMXJjcHRK?=
 =?utf-8?B?TS9aZytSakxER1VHYXkySUxMbElxWERGYWYxQ3l4aCtucHZvU2RYeG5zaGhs?=
 =?utf-8?B?Q1FBOUQyZksvdWJiSS9NSWVuclBPRjFONEc1RCtOcEVQNGRoNWtJZ1ZZY21H?=
 =?utf-8?B?ODk0V09HY2ViMGJmWXVGSDhFMTU3bjF3MGF6Sm5xR1VmbGJqWDhYTXJUUmwy?=
 =?utf-8?B?bzhrdWkzVjQwZDNqb2x1OFNHcWhqL2hRRGkzY20rNnNISnhwM0pYcTJsaU9l?=
 =?utf-8?B?cForRGhUMHRUbERlNXF3VzlLK2k5cE9HWDhvZVIyV1Bxb0plUFpwZ2RrMER1?=
 =?utf-8?Q?FhGt75Z5PaAu8kmAURMN/Ibqwk36oj4Twpgd8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEQ4V2ZxYU9ZUm50alJyUU1leDNDMHFLUGlGUG1IMCtja2VwVERNMmlxa0tR?=
 =?utf-8?B?VUZMTkhLWVFzOU56S0p5UVkrTDZkSnVxOW02anF0UlVxeE1UWU1EVUVrNlc5?=
 =?utf-8?B?Nk1FdndFbGdCWnFpbEZOeVZUaWlNY2ZGU3V6OFBxVnBiRStsazZna0NLQmZM?=
 =?utf-8?B?c2twYXdaUjl0TnlGbE11eUlneUlGZFRrak9OVFRRc1pDM3NTVHFYMVVpVUhB?=
 =?utf-8?B?djMyZ2RpeVd6SmorSEczVFh3M21NTDZob1Z4cXNIQXdBV2JzT3pGWDVGN3VK?=
 =?utf-8?B?M2ZHVjBIa2FkWCtOTzdhdmxNbVdRNlpRYzc5TXMxd080VDlXMUhEa1hYTnJl?=
 =?utf-8?B?UEMvb21hNk5ja1JqK3NYOTRCYjRPcDJqK3QxSWMzNkxrVk1SSnYxbHVnelhM?=
 =?utf-8?B?MkxMVGdyQURpbm56L01YR1htM0t4ZUVCQ0dydEdKWEttU3pULzhGUXhSMmdZ?=
 =?utf-8?B?MXdBUmpGa2Y0cHlDb1hPaVMzMytYM0tCWnhpWFVmMU5JT3l4bWxKYkNZY21B?=
 =?utf-8?B?TC9LZndmSERlekVhbjZ2dFBmZkF3MGhZVFRQQmI3V2UwYUFXaGI0c29YTFhz?=
 =?utf-8?B?TXRTeDZvWkVvT0lPcnV0SVRXMCsxNUJ5NjZmUXJPMXNSRXRjNWJjQ3M0QjBV?=
 =?utf-8?B?SFZ4R2I2cU1sUHRNZTJ6UVdtbFFDSGc5WGlMcDk0QmJ0M3VmK0VLeG1VK2FC?=
 =?utf-8?B?S3ZMY1pnSkF6MGhiUjlnMmRBUGpySktFeUhzampJa0RaaDhSRzRHd2dMeUtD?=
 =?utf-8?B?Y2dGNkhRZ3dqdE9ickd0bkVpVC9xNXAycU1uWlp0Tk45ZnJFVXpHZi9nRnBm?=
 =?utf-8?B?YVQ3OFpLT2JVZjhENGxOT0N6SnZsTmF0V2J1emMyT0R0SytkQkRiQzE1cGZ5?=
 =?utf-8?B?eThQei8vL3ZMRVNTL3F3N3p0NUdpcWdjMC9QZlJRRjVSUEJGN2ROVEh4MEhi?=
 =?utf-8?B?eTdwNlp2bUlDb0prRlI4N1pIbUdjNTRROFNUMDFuMkZKUDRXUStEazl1QzRm?=
 =?utf-8?B?Nmp5L25NQ1FIcUQ2U2JXdXNkWlBIT0E3Y0ZXbVdEZzhXc1JveGtCcTQzOFgw?=
 =?utf-8?B?WEpnbzYrZGhKTTZ3bmFEWjk3eENMM1E5TSsvRkNRNUJWTGNTZGR0ZUFOakpx?=
 =?utf-8?B?SUZMUzVaU1R5bXFEa3J6aEwvNTRyZFBMQk05TFJ0RzNNVkE0YndqelVPdmlr?=
 =?utf-8?B?Yk8yVmE4SVNKbTg2NUJ0OFU2cUdvemw2T3ZoVytzQVB4K0JVcFVRYlphd01r?=
 =?utf-8?B?VUlwKzRGM3Flc29JWk9RSDE5dEcrMGtvalVsbE1wWDBLYmtCMEVsUHpBMGRt?=
 =?utf-8?B?OCtQY3ZuZVhJbWkvUDlKWjNmUWljRnY2YmZxV2xXS3ZiUVhBWTBZY1hXbjNY?=
 =?utf-8?B?dnNsMVJZM0tScDVNamc2SDR0N1RrVjY4ZU0wcnVqMUx4bXJXbFQxZE83SW9m?=
 =?utf-8?B?OVczQ050R0NnRGtIZXp6aW5YZ3dWUzcxQzVBUzVuNW42ejlNdlRQNWRTNm41?=
 =?utf-8?B?bis5dGlNVGlHaTR2aUJ2bFMvT1NTMHdMSityRmloRnh3SGloM25hK2ZabjZM?=
 =?utf-8?B?Z0dnUjl2U21Dc1Q3MU4xQ1IwMmxnOGhOU2tjOGxtOWxVV2hadEZ0WmNqeURx?=
 =?utf-8?B?TlJJM1pkTFZ6K05tbXpPdWZBeE1rMEwzS1JMbWNvTzAvR3RQOXJHYVlmT2tB?=
 =?utf-8?B?Ym5pR2h3ZE43YnVxQVgweHljaGhUeXZYeXBZNDQ4R2FLMHVUSVJYdFkxRWhi?=
 =?utf-8?B?cUZFNXJjMEFZNUZwMHE2QnhCY2NkV2Mvb3YvbDQ0QXZmcG1COTBqemdwd2wv?=
 =?utf-8?B?eGY0NmZxOVFyNTRnZmNlOElqdnY1VnV0bkwwZ0hPTmhSUHltNjVTTXYyUmxG?=
 =?utf-8?B?V1RCeEh1cFU4NHVSQVBSK2tZT0RXL0N5bVYwQ0RZaWZCUzRkZjV3NDF3RnRD?=
 =?utf-8?B?VnhIYXJKazQ3US9qVVFJa25acnErSGF5Y0hYc2xDdVk4SEd1b1g5U2RKMHl4?=
 =?utf-8?B?akxNbFIzUUdoWVArZW1qc0I2U0VidTcwaDFDVTRWWlk2OHVrdnhIT1FuYVhH?=
 =?utf-8?B?Z0d3eW5KenZvdzJzaFJ5NXdZNXhhaUhxbk1vci9ZNHNheWkyT0lNZ3huaHBV?=
 =?utf-8?Q?L0WQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e820607b-6aaf-4abc-14e2-08dd064cb9f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 14:41:16.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybkk0/tJOnwHSzvDL/ZxIUQtgr0dWwXoBt7/0GVZ8QE5iRV0gdN6z7Xnyn8yVpI/sA9KPfru8xJaRGF45OKSvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7265

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set doorbell_done in the doorbell callback to indicate completion.

To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
to map one bar's inbound address to MSI space. the command
COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
 drivers/pci/endpoint/functions/pci-epf-test.c | 117 ++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116e..410b2f4bb7ce7 100644
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
@@ -642,6 +654,63 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct pci_epf_bar db_bar;
+	struct msi_msg *msg;
+	size_t offset;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr_lo_hi(epf, bar, msg->address_lo, msg->address_hi,
+					       &db_bar.phys_addr, &offset);
+
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	reg->doorbell_offset = offset;
+
+	db_bar.barno = bar;
+	db_bar.size = epf->bar[bar].size;
+	db_bar.flags = epf->bar[bar].flags;
+	db_bar.addr = NULL;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
+	if (!ret)
+		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	else
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+}
+
+static void pci_epf_disable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
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
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -688,6 +757,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -822,6 +899,18 @@ static int pci_epf_test_link_down(struct pci_epf *epf)
 	return 0;
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
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
 	.epc_init = pci_epf_test_epc_init,
 	.epc_deinit = pci_epf_test_epc_deinit,
@@ -921,12 +1010,34 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (!ret) {
+		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+		struct msi_msg *msg = &epf->db_msg[0].msg;
+		enum pci_barno bar;
+
+		bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
+
+		ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+				  "pci-test-doorbell", epf_test);
+		if (ret) {
+			dev_err(&epf->dev,
+				"Failed to request irq %d, doorbell feature is not supported\n",
+				epf->db_msg[0].virq);
+			return 0;
+		}
+
+		reg->doorbell_data = msg->data;
+		reg->doorbell_bar = bar;
+	}
+
 	return 0;
 }
 
 static void pci_epf_test_unbind(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
 	struct pci_epc *epc = epf->epc;
 
 	cancel_delayed_work_sync(&epf_test->cmd_handler);
@@ -934,6 +1045,12 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+
+	if (reg->doorbell_bar > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		pci_epf_free_doorbell(epf);
+	}
+
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


