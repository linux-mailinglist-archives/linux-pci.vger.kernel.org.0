Return-Path: <linux-pci+bounces-16587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DED09C5F7E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A8BABA5023
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A342213EFC;
	Tue, 12 Nov 2024 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B+n51rI4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF5217476;
	Tue, 12 Nov 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433740; cv=fail; b=WbUJ4+Z/HKmTXKmxoAZePjULPwTEGq0inZGvqTAuR93uWgCGfrFg45anE/XS+Er0gARzWkRgA+x9EVueRw4LmTWl6Nz87gaQGhplbFZifskEaSyZCc2EPlhVx+H1gelT+0WaT7RLe3vXqGW5knbvtv1K59GlsCKn0Gxqpsp9mDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433740; c=relaxed/simple;
	bh=rzBqaC20gv5zajeNqMjcGQwQsIkiSRC77uox8VWftBw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BNzy2toFU0F0IMH1cnprpSeIhJ7vHaPVGrHDsfTSZ4aHuYIUKmnnViNDIbU8ve8uL8OJHM4KDiIHbrV1A827JW9F+UbxOCCb4cZ5JIzRvC604i8wlWVQXRRXRUFmBpYkC9yFc6WKWwp7WINQM4CqOcrEwoTPz3gYLavSjPNF4Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B+n51rI4; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDaJTbh7ig3+VMhGSjYy0AUCDQY9Gxb2HrmZ0UPd86shbs3KNg5/MVrVj5QIiKOSxyylrJQN0ZFnsogAIdk2IvhqyhpRdKOieaFPWLPoJN8XqfmHktb0Zw4hjPf7Yfpq7+nlVOXe+BFKgVWkFhi2iuy89tXSU96p8BF/nyOj5FrMEOUCMxmukYftt7W8gDYK5LyZNoA9YEAFLAZuPRmE6jJ5QUm6MhDnwKzkikIzVm8yoCWXpY1ZYQo3M8DQWMbn0At0ZMSHS9Ci4hxakVkGw2aa7+9ConcgNUT2F4RDEo8JkbRGRe45NdEZAOCn2aAF5IvBLWpQUsg4kOdnHrVXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBY2RxtR8ubrdRv0IDfaOqn0Ih86F4aKaUUYok1m864=;
 b=UtBAsphfxsfgxHNQfVQSxPeGfUPRdye+Vb4e/EwP3gG3CsnNN09sUhFfU3vo9SirEpuu3Irdqv3+0lWcSIgfg4PvoersruE211ZrJOGm87Nmhw4/PbBSeReTvc23khGuzDzfmwn031xkeGT8svYZcKaWM9+WeKUxjI8tbKAAygAM/D9/e7oSh0DeNA4o5jGAOYAYKSmsV/wH7jVWaX25KccdWFtIfKqf51y6MjQ62yuw4sVpvrjHLIonB9Wir7EdTx92Eww/7Ar7pVJRxUv5tHRjMLJeyRcuWYo+23IMIhUgyYtixYc0mNDBgyJvWhTjTgneG1hF5hmUz0/sB9pE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBY2RxtR8ubrdRv0IDfaOqn0Ih86F4aKaUUYok1m864=;
 b=B+n51rI4FCqYkSq35UH4v/6UT/YT8agBmql3B9vIXAjKf+eoPIMqZR9TC0HAX8osZXujAyU1R5hHBFC9V8MKYv/Xvbf46k36BGMErZzdA44CB2gLCG4odBPuCMdC4nICv8NXTrltV4xuA4GIPj17v0vbFUd295o6fNa+B7H+V2ro4+n0Qe6AmqDvHYXDc5+nSTIL7nrlgMRYNiHHAcAnQjTn8shr3KsDLhwpo/g0boV+DJpAwHbvXWeeXtp7YHvAlgAmrH7G5FCn3IgNRS5RGh5VO1Q3PKKu12vdPZr7Q3etLc2BQupd9a4Nn1M0EbAaG+sOY0meWnW0fP1FaJMJhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 17:48:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:48:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 Nov 2024 12:48:18 -0500
Subject: [PATCH v6 5/5] tools: PCI: Add 'B' option for test doorbell
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-ep-msi-v6-5-45f9722e3c2a@nxp.com>
References: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
In-Reply-To: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731433711; l=1850;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rzBqaC20gv5zajeNqMjcGQwQsIkiSRC77uox8VWftBw=;
 b=5FmLkMranxnVo7GgjBazbOI4ML8SkJP0I+HYFwOFwUaNYE3Fy66ZH1fXI8Hq9cxnin7N46eBE
 hZZgOxH2tjhBVUHstusghXmo45HX7PbYV1p3KYRFwsCNQx97iOXMPkL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 617b773c-ec7c-461d-8b18-08dd034246c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlJJNnNnZzdIWjNyTnpub0UwcmFMcWRhTlNjQThOeG53YmcrM04wQlVPLzl6?=
 =?utf-8?B?ZERaMlk4RUxiSVpuSnV6aVF5QjgybHNUdkRpMmd3SDVscmlEOUV3TFlDMXEr?=
 =?utf-8?B?QS9RRDV5RCtmaDBXY3h2RVBlVkg1bi9wWVlHVEJlMG5xVlZIaDR0RTBENURM?=
 =?utf-8?B?RWY4Mmh3cFpQQXJadWx4TkswVlV6QzR6RGxwVmptSlF4c3NIbDB1alZZOWxW?=
 =?utf-8?B?UDl5K3RJeEU2SGlmSllncWhDTW53UU4vdHFEdmxvbHBQVWlsVWZvR3JVT21H?=
 =?utf-8?B?N0REcXJDbFc0NGxOUTZPdnVJYmdhV0tGVUtYZnYxZDFUbHFMcEM2S1V5cW0w?=
 =?utf-8?B?MFp0NUdXU2ovOFVrOXY0Ky9UWDhpVEhlSDQvN3R1Sm1oUnJ2U3JjbENBeUV1?=
 =?utf-8?B?dmdNNzhTTllBVldhRFR2U3R3S1FzMW16N3Fad1hFVXNjM3JUVnBJZS9xSEY0?=
 =?utf-8?B?aGVsc3BQV2hMMC9CV3M1bkx4bWt0dS82bjdCNmtwblByLzhlaWhXQVdERFMz?=
 =?utf-8?B?N0NlUGlQL3c1TVJXbnBhOVkwZ1BHMmo5UklPRWNjQnprdURiZldQQ3NLVGh4?=
 =?utf-8?B?WlE3U3FWd2NmZVFCSEhTZFI4dzJJaWhZRm5TRCtOcVJ2amdTbkJWQXNINjNB?=
 =?utf-8?B?WE9TT2ZHaUY4R2ZXVHU3MVlVNmFJVkZuRkVPUEJoRWlXRjZrRkpJT1gyQXl3?=
 =?utf-8?B?VmF0N21KSkJwMk9WeFZIbXVoRTNWNWg0S1hPQmNoRkV4WDBlVDFQd0xPcXl4?=
 =?utf-8?B?NDNYVGNzTWJpUWtMN1dLMnErQmJJejQxb3Ryb0tJT1JSaTl4ZW5oSXlkbk4z?=
 =?utf-8?B?WmxUejluTjdzeXIrUGJrL0Z0MDc4T1ZocEZRR0NkeXIwRFJQTTltVkFzaE0x?=
 =?utf-8?B?Yk81YTd6S0N5Y21tVHgyeHVRd0F1WE1DMSswV0xKSDBudWN3aHFTcWRQclQ0?=
 =?utf-8?B?UDdQUURHY1RiaDd1cWd1dDM5Q2ZOdkhqblA0T1NYT0dBMUoxMExvbjFEdkRt?=
 =?utf-8?B?Z2U4S1RrcDRoY0N3dVVFLzg1cVdtWVAydCtsSkQxNW9HM0J3MUlHa0RxbWdF?=
 =?utf-8?B?RmI5U2Z3UE9pbU9SL0JXVDUyTm44Z0tocnJreS95bHJsWHBXMk03TkJjTUYr?=
 =?utf-8?B?NzhjcW9KcUNVaDhsMzdFNG53Vk1CNk56eEZ2R3lCUHJyeEQrNGVJSlU2Y2JC?=
 =?utf-8?B?WGF4WXBVU3RaaEpZNlV1Smo4Mjc4UmVjYmVPekFHdW5oa3N4Q25SdHV4MVNi?=
 =?utf-8?B?TE15MFFvckh2Sm51OUU2NVZFZlN6RFp1MHlqQ3UvSXlEZk1MNnhOZUhWOEZ0?=
 =?utf-8?B?eHhkeWFZK1gxMC9WanpiMTl0WHRsbnR2TUcvSG83SmxmbWd5T3plU2ltYlFk?=
 =?utf-8?B?VlhrczVVSDh2VHQ5bk9yOXJETlhvSnloaUE4SithODdPTDYxdVRuQ2FqelBr?=
 =?utf-8?B?OE42MmhKYTRvekJ1U1QxWFVYckNvcE0yOE16SlRVbnM3OFc4c1hCY1kycVRR?=
 =?utf-8?B?WEF5c0gwT0JKMXBiOC9rM01HMFYybUVOMkU4RWVoNzZXQUNQMnZvc01NL0hs?=
 =?utf-8?B?d2wwcVlxYTJBVmRhWFlyVVYxVEtGc3dJWmhUMFdva0lXUDNRd3BqSHhhM3A5?=
 =?utf-8?B?WE1oTFFDWDBiRUpRMldjcVB4dzI2RVNzMTY3VEdDWFVSQkdUUGRmeTRoV2J4?=
 =?utf-8?B?YUNicVRrSE1ld2g2aTk0R0VvMDZsYTFIblZXczZBd0NsZk04MEUzRW5DelpB?=
 =?utf-8?B?ODhNZXVYejJUcldPOU1BL3hJdVF3S3lPVDJKd0tKMDQ5NFgwREp0Zm9sZ2xG?=
 =?utf-8?Q?eJoWV121mKzaCD0p68U4EdSH9UM+toazeTCBA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFJmSVJMVGtsbkZQeWp3NjRkRXUrK2pSYkZNdVBpYzR0Tk5ucXNaWkY0QnFQ?=
 =?utf-8?B?aWk5bllLNll5c1NYSHM1cUNRQkJyeWwxT2JYZkplZmI4a05rb0UwRTFrTkJZ?=
 =?utf-8?B?aWpBSWF1L1Y1U1BkVW03bHBxSUQveENKRzhuSFhwTkUySnFEWXRISlFNVVEv?=
 =?utf-8?B?TG5KOUpqcEF3T2s5TUNYWjJEU1UwSWFDZHRVK01EZmlOZ0pxUWxGQVFDV3Er?=
 =?utf-8?B?a2R4Slg1YXpib2dDUHp0dFFRSnJiOGs0Y3crSTd1T3F1K01LNlZKNVB1cFVr?=
 =?utf-8?B?SGxpUGJrUkJGeGRWdDQ0OVVkY0g0Q3Y3N3Y0T0F3VGoxVVFmMW1VdGRlb3Vw?=
 =?utf-8?B?VmMybWI5ZDZvM2RFdElHbEcvVVNBeDRqT1Bjb3N2VzNOZDhRL2pCRUJTeGVD?=
 =?utf-8?B?ZnRNV2Q2QUloemFwK0pyblRMK2JDdGQraXRKNitVc1Zqa3FqTFViaWxycFFG?=
 =?utf-8?B?c05IZHlxRlhHQzd6ZkUwTmxpOWdNWlp3dllwM2orZjY2K3dtV21rR2ZOVGRw?=
 =?utf-8?B?aG9kTkk1MnluVkFjSHY3VHAzMUE2REtHNHpqQVl3V1JaQjNOeWJvR3RqVVBZ?=
 =?utf-8?B?NWJPanVaSlRTZTFySmVsMURoelZZMWlyT3RRanhNMVJMU1gxWU9DMDl6Qlg0?=
 =?utf-8?B?dWdxWGZDRE5RVjlveG4wKzZyclNITlhTejNCc3BWbEVjQUxudlMxU2dEeDlo?=
 =?utf-8?B?VEtWdFZMcjVocTJTT296dWZxaGphMjMvdzlTcVNsRFJuK0x5cFhUR1BvNVlG?=
 =?utf-8?B?MzVySisxQVZHVTZkT0pBckxndk1BWFVYUnhaWEJYcHhDZ2dqU1BPdlZnTDNH?=
 =?utf-8?B?R0txWFJBOXJ3L2Q4K01EQUdFSFhhUnc2d05QZXhjaTJLNUYwaE5ZL1liMXo2?=
 =?utf-8?B?TE9OUUt2V3JlZ0N0aUdnbWtsQVlvUVZ4VnZxK0wwakM3MDRhY2l1RmF1RFZ5?=
 =?utf-8?B?ck9vNUx6dVdzZ1U4OTZGNnVia055alJLWk9iUkxUOWt5ejRrRjNUd2JMbFlQ?=
 =?utf-8?B?UklFTkZxZ0l4YnB2ajFsYU05OW5aMXBHS0N1dUhNZVYzTUxsM2t4WGFiOFNx?=
 =?utf-8?B?bWdzTGNLd2htMTllbnZCa1E4cVp5Q0YySXk3OFlWb3h3WVVZS080RUpheDZz?=
 =?utf-8?B?ZFdiWmFWZis2NFB3M2huL3FuaC9sa1pxS21lNytVNngwSzU4a2xwUUJKVGV1?=
 =?utf-8?B?Vm1rTlFMczRWNFpYQ1FNRHBSZkp3Skw4KzdZSGY3S3dKUVZJVFFKanpXaWxQ?=
 =?utf-8?B?WEhUM2c1TFZOeDZ2eERRTGlrTndPRW5lbWV6a1lOdi9XMm41UlFpRmpHdnM4?=
 =?utf-8?B?VjdYcUd0eDBSVjhvMUY4UlRnSDRva3NDYXE1YmpyL1JyK1JZdEpXbXB1WVoy?=
 =?utf-8?B?SHZ5SkdxUWVzT1BVRFBlMml5eFUvdm9zTS9MbHp6R1BNdGZvV3RTQkZFNVNq?=
 =?utf-8?B?ck5aSGJIWEV4YXZONWpDMVY1TkhpTEN4dnVRTnF0cVF5QThNNGovNXNCU2JK?=
 =?utf-8?B?MXZBMjVrRTNZR0doT0tFYnpGV1Y5WjF6d2lTN29Xd3ZUa0czZEdHN21ySEdF?=
 =?utf-8?B?b0JhN2hFVG9TSC9xOWY3QVpVYkVQdlY1Tm5GRXVSS09DVk85aytwcHRRM2tM?=
 =?utf-8?B?TTVMNWpySituaFpsS2N5VW10OEdPSDR2a2oyQWlKaVk3T0ovcWpxdzZFVTJI?=
 =?utf-8?B?Y2hOL0svKzFzWFZZL0FoMDg0bjNoOFpSTnI5NDdoWGsxUW0rOVozRk8zNnRW?=
 =?utf-8?B?ZW96cFpOdFE1V0JNb3VoQ0FXdWxCOVltOHR4U0o0WEZTY3BxRWIyYUd6SHMx?=
 =?utf-8?B?YUlseXBWcCtucWNmamVpbHJpWnovZFpVK214WlFzOHdheDA3WFk0OHJ1cC9U?=
 =?utf-8?B?ZnoxU3ZsK01CRi9UWnNVTWU5VEQyZGc1bVFZTDNJRmRDK3hzemJmN2hTbjI0?=
 =?utf-8?B?d0p5bnRHaWlnbkxHNEwxVkUzZTVQVk9qTUlwU3NwZzZ6a1VLRDk4N3VtOGI3?=
 =?utf-8?B?czA3dGdJdysydWYyVDZ6Mldqc1pGbk5MQUd2TDlqVnFqT0o5Z2tleDUrYmtQ?=
 =?utf-8?B?VFQxRndzTWVNUEFWR1dmMlZYYm1IZ2gvSFhFYk02R21YM0J3MWFGaWorMkx4?=
 =?utf-8?Q?oqYc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617b773c-ec7c-461d-8b18-08dd034246c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:48:54.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0AOf9R8RwFvzpKJ/zK0Ej/MA9jIrmsjA+HfUQfUf/x2rpVocFgS9MI9RscyAmokBTAaNl7sLKBU5sdTg/iwuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Add doorbell test support.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v6
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


