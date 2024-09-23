Return-Path: <linux-pci+bounces-13388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCC697F0F1
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 21:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9861F223AE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94281A2559;
	Mon, 23 Sep 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gT9hV9x9"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013008.outbound.protection.outlook.com [52.101.67.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F601A2543;
	Mon, 23 Sep 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118029; cv=fail; b=QdqPVmcHRLOm4lW91JnjXseGLVOmBluTnAQTsYTpkYMUSbOpT9l03wf4aMtoc17rkhNw7o0iEL4JCjOpA4W3TOB1pphRMI+WIcNSPplnxQkz+1BvFXhnu+yakEzGczWDGKYYxdXnHAuv+mijBcVL3BOQRpKkUsKHf2xByQSVf6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118029; c=relaxed/simple;
	bh=dDCIqEiGeYvyy7IOr9TuFKqg1ZZuhKUnDbXG/Msug68=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UbM3mXuq96kR1gLVy3OpHPzMA2VDyzlxV9H7oLxuOxWZMownWmOPCDXzAUIAarNumDGuxzjSObJcC3gVynB34lZX7SauG4f7H+Ksi7yz5VwhVfVrR9jn726aANLebVPgvw28qu2eHnOSvQWVB3SFhnJt24CA84qXfB9hQN1rvtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gT9hV9x9; arc=fail smtp.client-ip=52.101.67.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXiCGVkznm3koyteshdKsNTaQg5KJAlmhenxd+h9wxuUlSRx7jRTXijw4YJgSMT7DGG+1DfDViK8qrqMIUrbZcZaH5wYnbAl/VaTDnybMysxc1CDqutp2skQyQRTWUauiD2sBEDL2lH6EN2h3xq3MBNuI6komeY0iINN6L8l+73W4gIPnsZQmMLRtEUeLdnHvOD3zN2X7gme49o1bJPM/UxLxHNoeR2slTUKOXv7/XB5klDV2M3IdHHRguNoFtDYNZcLnCsV3QSG3yj/tm+noVRcyrXMDLRpNKfJUnvf+788d4X+uNSOLLL42FCdhgEc/9kb8TkaF5+PSP1QBITwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuX1Jv44F0T7Lrz9ExIWNFVs/gpRUetjCUAmSbU5G+M=;
 b=KRsLFmUcmHcnDyAe6td8YVICb9ZZA/XF3mFqrrpt6BZ6JIZhxzJVWI3FwOvoqmqon4JiygP8q2OwWObdYEBDHWdR53Dt7PbVKUEqeeusWPcxlVxjchKche70UDm3UqyKxGk1BpqCNzt1DId8XYTaf4t6Qmz7If/XEqdMYEO13gzo/3ahwRijAY/o9j0NPrHIri5BbZ3anhijHTkA2u727wsK+HkexUZE9WuXGW+coziQGVnffPAnaBGRjRWYF6PaUNFf9fTr5JuKbQemHeKn0bmSaMozhpS5UqGIH46PuvQ42Sc5+NiY9ItevzwQ2RUVlIhSFIb5AENTl3KRA88eFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuX1Jv44F0T7Lrz9ExIWNFVs/gpRUetjCUAmSbU5G+M=;
 b=gT9hV9x9aSH4d+7eMpQD8Jlg/n0b2XU1t8VHZa3u8G/K4aDGobr00EANWrzaJ080DRbwo3j/+YtYf3EEB5VoFh5nkqZeYoyUeCx8H1qV6gw+Go8/wffYB4IbiEMpQ0N2IehVSSkU6bzR0BvF4grOCyIYuq6WDTeq85CoBopeZaSO/uJpELvsfcfLkiW0WN8pe2Tg8lGbvPZM82antPsOMN3vJjhcQYvAkWUmINCFuqlLAmsFNpWJEh4zZaXQcET7y/4wnFTeTM5gh3QmZlSFSXz1TQWxdfXKVodpK62SlfZ/y/LqUh3k3+rvMRyes0ULZJReOn22yhtzhON4Z6/uZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9562.eurprd04.prod.outlook.com (2603:10a6:10:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Mon, 23 Sep
 2024 19:00:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 19:00:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 23 Sep 2024 14:59:21 -0400
Subject: [PATCH v2 3/4] PCI: imx6: Pass correct sub mode when calling
 phy_set_mode_ext()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-pcie_ep_range-v2-3-78d2ea434d9f@nxp.com>
References: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
In-Reply-To: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727117997; l=1068;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dDCIqEiGeYvyy7IOr9TuFKqg1ZZuhKUnDbXG/Msug68=;
 b=/Y9KjyUCvxV19RYudfpxSe7Hy+SWQwkyz4riQ6BB9QVAcN0+WiLQTEdcLDjHshODM9yMe8tKv
 24Mw1YdnHwZBg0+nrYAeHh/mg0h6WGrl2puyXge7st+dOMS9gPZcMRK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca9e344-a40f-4e6c-5768-08dcdc01f8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEhBMGZvaDU3WHBITU5wT2R1c0pScmRsWjh6cUkxM3hGLytnL2tEbGRib3Zl?=
 =?utf-8?B?OEtxQXBTSWhzYk01WE1SUlV1WjlRZ2dUL05CK1hsL1RWTWJyNldlMzJWUHNm?=
 =?utf-8?B?dW4rcGdWOURIRjBQWE5vWDFUcHdEV1JRaDR3M25FR0J1aUNySUZEdUNDMU5j?=
 =?utf-8?B?OS9jaWF4c1FLSmljaldISlJNeUg3MTB0dHdjZjJ3MU9Ga3FCdFh2dytETEcr?=
 =?utf-8?B?Y0ZDS204SU53SmtWS0NwUHFJa1BXcml2aHJodjVZdFd3QzRFYnI3NFEyUUdw?=
 =?utf-8?B?RjlSc3o1MTkyaFgrdVY4R0NFREFuT0F4VU94eUJFWm5rSnYveG1FRmtLYWVG?=
 =?utf-8?B?UkQzMHZ3b1hKckV6VXEwb25kT3dOUnh4WW1VMXliVWtBT2lkS0NjVHNkYzlG?=
 =?utf-8?B?M3hNUU50RWpCaVMwSUE2R0VNK0pwcmFjbnBHMm15Yzd0YjZHWVJaVVM3QVdo?=
 =?utf-8?B?dlcrc3dEMkcxQ01QMVNWaHdIZTBRNUtQS2NKK0dYdUttbzNScTg3cmpKR3JP?=
 =?utf-8?B?UGMxTm9BMnlsT0JoZXdvVEs4bVVudzN3V0VRVFR6Z1dLNWxqRDNxbFBBWDRo?=
 =?utf-8?B?VC9Jd0l1eDRIeUh4b212aDRGV3VhdE9abkd4R25YY2lRRkN2ajhOVjhZcVcw?=
 =?utf-8?B?a25pS00yY3MvbzQ2aTE0dGpXTVNlTTc5cnBGQTJ3a0x1SjY1WnN3R0RYQW11?=
 =?utf-8?B?SWhXNXVvK29EUVBRdSsvWGwwdkpUcWdVV01XVTFFdjdFdGdXY3V2RFhIRTFu?=
 =?utf-8?B?aFRaN3FhcXZMOTdZaEtMRUNmVVc2dDJuM1dJdkM4Ry9nYmYvOVFqdDRGWXlS?=
 =?utf-8?B?b0xjZlpUYURqNW5sZDRxVGhKc081b3NSSWpEalFZV0dmMllKeHRJNEhEdmJa?=
 =?utf-8?B?YlpsL2krc1pMNWZVRzBPWVpCbFl5NUE2cW1UNnNtUERMYmpHVm9wNkdLRkhJ?=
 =?utf-8?B?amcrOHVRYlJrR1V0YVh6dGtIK3FpcVllck5xNVVCeDFQTTdxN2I3SHh0WkRl?=
 =?utf-8?B?cG95YW1PL2NyczlMT3kxL21HNUFlTlduamEvSWJhSEEvdGswQWF6ZnczWlll?=
 =?utf-8?B?blRaNk5oeEhmL2FTcjlXNEU1REdnYlFxdFZ4VFV6RS9TLzRReHhpUmhFUWh1?=
 =?utf-8?B?MG9OR2oyOVpLOVNqT3FKRDQ0RXhHWFdkY2lZc3RycUxpcEpHZHdXMUxDZVUz?=
 =?utf-8?B?ajhYRkNzQ1VvaWJtcVliOTU4bUdWYldHVGFGWjJqamNBSzJSK3d0TUdqVzVK?=
 =?utf-8?B?eVNmVG45bVQ4UzZYWjlJTkFnbGNESzdrbkk0UmRQamlNN29CbHh2dDI2TDVm?=
 =?utf-8?B?K0JJSURCWFNtMnJ6aHpVaWdPQWZQcWtVV0Jxc2MzNEFZKzl1MFNBMjJuRnFF?=
 =?utf-8?B?NHRhVkNWRGU2bFhjMVIvaWtuUktNUUthSCs0WVJ2WTRaQzh6RFRySWd5Z0Y0?=
 =?utf-8?B?Zk5SYUdPamVabjZUakg0U1Nma090SnFTQkpPZXZGKzR3cmlJQWNTWE5lV0lI?=
 =?utf-8?B?T2pPYmtKNWRzN3pWblN4ZE5udjlNSEc2K3JjOVVFdkVyS3owNHJ6cWZjUlV6?=
 =?utf-8?B?RjlwcWZLY0cxTzNSZmNOeU1Fa2tlK25HMHdDRURUR2FoYnluZVZxdXo4OVhq?=
 =?utf-8?B?RVdWWFFVazd5Wkl5U0U0UTlvVnZ1RHdPeHBGcXhkK1dDeXNvQ1drS1BzdHc5?=
 =?utf-8?B?aEdNTU90QlZXMDIzeVk0dlVtMnE4V2hvbjE2Zm5XRkhZSVVZUWsvMmJuWlZR?=
 =?utf-8?B?UGtkQ25JaFRRSlJxK3RHNFpiSjdoRmFZME1MeTJIdTA1OXN4TFJZRVFqTHlV?=
 =?utf-8?B?UHVCUVc2enhocllDZk4vUDBFV1R3dzhOQjhxQS9aS0JmeHo3VzJXdTV1ak9N?=
 =?utf-8?B?ME0xcUdLVXlxVHpsZ0phYUw1enFNam01UEZSdTFZWFB2dmVQOXZ4bkZEdDZR?=
 =?utf-8?Q?Wu7wNQ4JTnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2lLa1lma3YveDE1VEVLeVpiWW1aT3V6a05hNzBTbktYZTJ0bXdLNVI2azhu?=
 =?utf-8?B?WlZsTzdqV0VZdTczdEFJc1c1OTlqVkZlWDFHTm1yK2F1VkRGUVlWcWVEdUZ5?=
 =?utf-8?B?dy9lWS9Mc2Q1UXVmVDlZb1dhaG56amNkUEpXUTZjM0I5Rnd3eHAzdXprOUpM?=
 =?utf-8?B?Vyt4Y1F5TnZiRzkySjRUL2NDQWhIWVFHdHJ3VEtOeDhNbUpFbHBRSkhIY2ky?=
 =?utf-8?B?VUtDcFl5UXk4Lzc0dk1MMEZwdTZDT2F2V3dJWXUzWVl6WEZWL2FJQVhmSGxq?=
 =?utf-8?B?elZzWXYxT1VZWUNwa2NScTN6RmlHemRmUzh3M0llM1l3YjhDL2o1T0RqUnJk?=
 =?utf-8?B?TnAxN2Q3WlZ3emZxejR6T095ZGdKOTNDelpsbFpiNE5ocFZlLzZHcjVhZWVa?=
 =?utf-8?B?YUkrZks5ekJFUXd6Q2NRd0d2d1R6cWVET1lEaTRIY0NoQWZDRHJNZUgxVVN6?=
 =?utf-8?B?czRJazFaN2xWWldCRUdNZGdtZVcySzJ1NU1tQU5MOHBOTWY0VkRycDZNblJl?=
 =?utf-8?B?TGhPMjZ5Ui9RL1JZUXQ0Y1R4ckxYT2w1UFZubzM2ay9Qa0RKUjJHYlVYcHZp?=
 =?utf-8?B?WGIzM25pMFk4ZDNCaWppRW5BRHh3bVI5TEJzVHFpMEg2Mk5RMllhSzR4MWdB?=
 =?utf-8?B?c3hqcWgwa0paNmVwV2s0bDhpUGtBT2o1RmljYVU3cmdiNTNqdEs4bk04b3Js?=
 =?utf-8?B?ZExmTjBIVGJXczU2N0xKMHpXZDJIYW8yRTFyV0YvYkxNSzBCY05RU0xRM1Zo?=
 =?utf-8?B?TWE1c2pFYUExK29heW1seWJONWVmVlUwdjRtV2V1U3VWMTMvQ0wwYzA5bms5?=
 =?utf-8?B?NGMwZ0JqZXd2VnQyR1pSYXdKK1BDSFBHV21tUUJwVWFMWUwvUW05TW0zZUFi?=
 =?utf-8?B?OGhxNXhTaDRiVkhJRjh4WFlZNGpJZmhxNmJsbjNUMXBuOG9UTzZYSXp6ZUFJ?=
 =?utf-8?B?YkEvZFB1YW43ZlZENVRXc1AwU0N1UFdkRFVZRkdUUENxSU9nMnJNMElPWmlz?=
 =?utf-8?B?a0ViekF1Mit4aVJXcFpiMk5yWUFGSk1sblYyMXBqTXlibGVmTHR3QlRsU29P?=
 =?utf-8?B?QkpOTUZBQ2FCYkxhZjRORVB2YVArbDYvMXlvMXhjQTFCK2V5R3NyUW92WVhn?=
 =?utf-8?B?Wml3Q2tFVEVSc1RxS0kwT2lHSVArUUJDQ1ZHME9obUx6UVk5MHdkbXpXcTRi?=
 =?utf-8?B?ZGV3V0ZLajZJdlZpbGlSYllVZHE1ZmFGbzJMYWswRGZ3M0pKVE5RcWxGM3hl?=
 =?utf-8?B?eit0UzlwQ3FSWkFtZ21qMGo1SloxcTVmWWFmUWZpRXdhV2Q4anJoWGdUeEdz?=
 =?utf-8?B?WWcwV0hjUklFNStPcXpLSjFtbm0zTFNXd1lnR0lvUm5rUHFEUnU5Uzl3am1O?=
 =?utf-8?B?eEVpVTM1K2ZQNWF2RGxFdDZYSjVUMktXbkxpdld5UC9tNEc4MXlraVdJZXFu?=
 =?utf-8?B?MkkxVDZEKzhtWEFHd2tNcHVSYy84WWo1NGhiTHFNR1luRmRKYlJlVXNHWUFi?=
 =?utf-8?B?MDJab1lHZUZ2dkUwNGFhZHExYnZWbURReDhWUUFIREdBaFZZTWluMExmandx?=
 =?utf-8?B?VmdRMVMzanY2dHJ5bk1WWmhvaHpWUjdLcXh5OGhqMUtycEU1aWRLS0tHaGFo?=
 =?utf-8?B?TEdqUHhXR0pqNDNIY1R6YmpPT0FSYThFcmhYdFVQbHl4ZFJjWjMydEdkSWFw?=
 =?utf-8?B?S1NsWFBNVjdlMHpudGZnMElxMmFNc1BaYWhpa2dubXFQbVJsREhxT1UxY1pI?=
 =?utf-8?B?cTJ1UjRxSjhpemExcVdJL2ZRajlkSXVQQ1JkazM3OXIydnNucVRjLzMvTXln?=
 =?utf-8?B?NnR3elVudHBUYWd3ZHpqbEZubEQrYUhDWEZhMzg3UHowQzRWcC9SaXVkN2JJ?=
 =?utf-8?B?VjRCcG9zalJjMEhzSkEwTFcvMkZFL0pZdVFieXZVM0t5TU1lNXlhQmJSbHdW?=
 =?utf-8?B?emUvblppcytMU1Q2UUJ0WEhXNXBwOHl3a0hkM0MwYk4vNTlUNVh0bENPWVRU?=
 =?utf-8?B?WWxhQWVaU1JmN21IUE52ekthQjN1TU9NVDZCblQ4c3pHZEFzSUZqcGVGZTJj?=
 =?utf-8?B?MFdhWFdjYjcxaVZ4cmZWN0ZqOURoQjFxUVBrVkZlK3pMQlhlWmhKZlVGOFNF?=
 =?utf-8?Q?WBug=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca9e344-a40f-4e6c-5768-08dcdc01f8ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 19:00:20.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+GvNtdACe2V3hUdxNdTTWolJTcyCMq5t/UfM/WasXXDbIWv1tVit9XuKHd8k0y6zqtNWqumu4LvE5BaW0qUKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9562

Fix hardcoding to Root Complex (RC) mode by adding a drvdata mode check.
Pass PHY_MODE_PCIE_EP if the PCI controller operates in Endpoint (EP) mode.

Fixes: 8026f2d8e8a9 ("PCI: imx6: Call common PHY API to set mode, speed, and submode")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 808d1f1054173..bdc2b372e6c13 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -961,7 +961,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
-		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE,
+				       imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE ?
+						PHY_MODE_PCIE_EP : PHY_MODE_PCIE_RC);
 		if (ret) {
 			dev_err(dev, "unable to set PCIe PHY mode\n");
 			goto err_phy_exit;

-- 
2.34.1


