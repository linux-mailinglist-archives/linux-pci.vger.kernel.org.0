Return-Path: <linux-pci+bounces-13463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE24984D1B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 23:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD4B1F2459F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE09146D6F;
	Tue, 24 Sep 2024 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="diXVmmxm"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62559146D57;
	Tue, 24 Sep 2024 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214893; cv=fail; b=pRXKPx4PcE8uyc0t81wgG6kWPtitPEoo8vtf02LuAsr2UgWTxSuCj1wN268W6GmE+dPg6o6mNfeD+tFisk5OgTnnh2N38o05gQe3yIvlc83t8T6OdfPMsIQnwqk0/Zc4j00dVYvjm7zV6EoHkYYvurgJ0+6euegVNkmvuPoGS5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214893; c=relaxed/simple;
	bh=BeyPTbzXB0p83a1iDoPE8wdWVX5cIR92xtr2AQREEaE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Zxg+E7wcMZBgJkFfk8YKH3leqApD+uK/XWekFPUZhXZnFmbw3TwOsXgCg9KKh+yINssTYrUnDoFYiPVMlfHwmWtLJnfhhUsl1idowbadrkZp6wnvbBRe1Wt/C7VBLgc9FIgoXChOtifjQiTj2dRgda0DCgDelK4N/wzqt37Cnyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=diXVmmxm; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sViUq7u7Q6RhWZLo9CvP97FGi6ZY/JJblpxQ0HKyG46yHiJRO4FvPHIcjDijZfEspJqVBDTAQkXh3cGOmVVe7A9PsSC4V1O3AfFEiKQM7oX6EJCkoaM59Wm5zLNMZsvmvmK8Tsy2iAsntgZzF+ExI5SCsgtNHE862AxCNXKujmHXjZc9ji/wB5M/jXqLLHLi+r7+mowZ/KaGYrQZLS0+pWocfzbebyg5Evk/7QZHCA4uiv/JCc9nX6HrB0aUXUa4yWKyQC7P4CUK0Z2WS0IdHfyn1ch3GgbC9mRQ8nWCVJC/8xci7WJjSPDevVd7l+va8oJzl2qPizenwgu2gWqV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RoEzTNJc4n8DQOkJda0OBl5sxDTOoJ+3O175i+1cbc=;
 b=iYU6tXLW7tZntx8acZTEMEqyudMYSe3yAlrB5Yg2O8UgxeUNI1E+jVbPdRcjsUrgb+wD3+Fg9XryVJMHgzns7Q/2p47tq9k53vx6vCBA1kgbKyfcVnEBBmwEDeU/66qXSTOsnTDQpgK8SzJyltFb+d+46T4Ufswi4/4Tv0YJ3vIjSyRxDek8ozvBJUAtFvItZt7eHqemDrv6Cuqpa2zUP/go29sGdUUSDPOzLEed9mthzpdTCrHUl9O1DbfQrnOi7A04jvPrL6/z9WY1ciTgIkVd+1UwlzGhTHWhMYtZgRK6F9nXZh3umuGp4bifn/0J6vax/d2d5QR6Crg7GwrzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RoEzTNJc4n8DQOkJda0OBl5sxDTOoJ+3O175i+1cbc=;
 b=diXVmmxmK1e7bNZKL2ojrCJH+/vOmt0DLLydt7ulAGbyqbY2kS6VfD92Tj05UKrfBMNNGgiqVy2NPQ5nWVuRwrFjue7oDqiTnxlLaADtiUnFlV27TgZvM+s71Ux79GLNmJwCHUo/cra9uDvkllAEwIlqp2iX7F6TLQrHSAL475/E6053kGVsjMoiyKZYUxnB88JInxsTO0CnKVUmqgDjNU/8yPKVFE565qoEFbhMyuX9oTkk+rhdlF1EmSCrOCTKO5cP8jOB+bOyzZZuqdziXNTf6OuvFSKkaUbZi2YldO8zNqtaQnWERCtqlp/vNlTOC3UJFDUC8pswh6YW4FU5SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7953.eurprd04.prod.outlook.com (2603:10a6:20b:246::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 21:54:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 21:54:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 24 Sep 2024 17:54:20 -0400
Subject: [PATCH 2/3] PCI: dwc: Using for_each_of_range_untranslate to
 elminate cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240924-pci_fixup_addr-v1-2-57d14a91ec4f@nxp.com>
References: <20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com>
In-Reply-To: <20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727214875; l=5033;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BeyPTbzXB0p83a1iDoPE8wdWVX5cIR92xtr2AQREEaE=;
 b=SsLwtq0uV9JmndeiSrDufhL7glkNzted4mzPwT6wF9YqeWfdiK+eHUohpQUakGQN7DMKaEWmZ
 xh0vrE7ikq4BsPtrmSGqbXHbN/F341JaWHyMQTKIJevviXQZFIN+mv7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: d6223548-0c59-4bed-adeb-08dcdce382ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVV2T1pKdzIrWHd2L1NnUzJ0R1Jkb3ZFUHFUOHI2Sk1JWXFYUWxIYkNhZi8x?=
 =?utf-8?B?alF5cUdBR0YxMTArVjJOUkM3UEN3NlFhRDFXeTZjb2VhM1NxbVVpR2ZVZStT?=
 =?utf-8?B?dElyVEFRbGVHZDd4Z0FDelNWcHBOdE5rNjVONjAvZTA5bUNKTnQwR0tpcDMy?=
 =?utf-8?B?QjZoQUtIbjFUWlVJN3NhZ2tNOS85UGh4NXl0STgyZEZWVnRVelZ1MHdxTlhZ?=
 =?utf-8?B?Wm1XWnZlc0lDZXEvd1BhWDREdEdUSkxnbmpvdTR1V0ZhViswVTJiNUkyYVZO?=
 =?utf-8?B?M3JmTC9YSEhqQlJtTzNBSHVpb2N3NE1jSGtiS1BiaWxhakFjUlRGNWtmWExz?=
 =?utf-8?B?T1NUMzFPWG50U0ZPVitnalh3ZUpIdXF2S2oxeUlmbENyVkQvM05uK05MRTQr?=
 =?utf-8?B?eWk0SGxUbUZGZlNOUjlmUkI2cTUxRjZMRVE5SmdjN293QzJWTkVSSngzQWxY?=
 =?utf-8?B?d2dGTWFGUHpTRjRYS3VFN2FTSUV6RWt2UTJpd2pHTkVmeFdaYXRiWk1udXZu?=
 =?utf-8?B?enVLMTJSdXlTeEc3M291UWZrTW12UXpEUzEyOWhqUkI2aFFOb0x1RGRwenFz?=
 =?utf-8?B?YURIYXNLMGRTamlPOUx0VXVYQVQ3NDV6NmpQQnlCWVppMW9PeGcwOUY5bThH?=
 =?utf-8?B?ZWJFMW1zY0ptNkNIU0xicjNqUXo1OVlOV21yY2JXbzl5S0o2T3lKRmlYalB1?=
 =?utf-8?B?c3Y5SDRUZWxsMmZzenFucXVRZDQ2TTRXM1M5NlNWTWYreDFNd1UxVHZJeElz?=
 =?utf-8?B?K282L29PaGJBSnhweWZ1V0l3cUphQnRWeFpQbjNySk9nbnRXK2dxQlhuTHFs?=
 =?utf-8?B?dWlYU3ZvV3RlVjZGaHhpQ3lRdVU0S0ZjS25FbWdzQ2FETXJGSnl3MHh2aWcx?=
 =?utf-8?B?VWw3UXd0MStBaHJrR1Jqbm5NK3BNaTVlN0cweUZpTkl3dTlFdGhOUmRNdUtx?=
 =?utf-8?B?UmlvL2RjTEt0RGJTTEpsdFpzWWl4dlgyU0UrYklzTncvbkFSS2VQRmZZenM3?=
 =?utf-8?B?bWltVzBhVXp3R0FjRzdpeVJYUE4wazU1UjFNbDdqU3VnMlo5R2Y5aEdQYXVq?=
 =?utf-8?B?MFlSZWpyREhvM3h1Q3BNbjZDK3RUTUJZU04yblFCZU95OFVjaFNaY2hHaEVx?=
 =?utf-8?B?OEJmSkhlQnpmSVhobEl3VHhiRGRCM0N0MjBJdnorczl3S2QxREVpTFFxZEpS?=
 =?utf-8?B?VzN0cFlGemd5NFBlV3VCeS80b1RjQ01kUC9HV203LzVMRUxWMHh4KzZVVG1k?=
 =?utf-8?B?cEc4dm1vRGJ2cXVFeStPUkg3bVh0aS9manBZMGxzM0RrbGtMOGpXaXp2YzZl?=
 =?utf-8?B?aXlKblBHZHpQV1U2UllPb0NEc1FSemRIT3NmTkdDNm5KODVWZGJ6TWlMRFRh?=
 =?utf-8?B?ajY3V2dtZUVST0NZcnhBZXVrakp5dVp4SWVrbUdVNDQ4andiWW1TSXRUYmtj?=
 =?utf-8?B?NWc1TjNLaUZ5MHp2L094UFFsZnFBblEzY2h0Q0IwanRqMWF4QnZXVTY2TUdS?=
 =?utf-8?B?c2pEZWZQQllpdzAzL2hoZWxaTFBvcGdIOWk2TW41WlBvU09QS0owOFpWMG1G?=
 =?utf-8?B?UnZtWEVGVGxUWlRqWFVNSHVqUlEvdzROU2U4S2lrR0ZQWHBaLzBXa1FIWWQx?=
 =?utf-8?B?N2lyaGozTUZyY0tScXhCZ1lzL2d4UkFBOFNGWFhMcVkweFhxbHRIdlNtYjNJ?=
 =?utf-8?B?SWx2MG9mRmcvQXRVaVliT1Vrbzc0UG8vaHhSZk16ak1uRXRMK25McERTVEtw?=
 =?utf-8?B?WWhmMUhteVdMcitUWTNsMEVPWTg1RlVFUFA0R1RZN0w4M1JXYkVhbkE4bTBN?=
 =?utf-8?B?MmxlZThaYTA0dVRBOTNQdUJ6dk8wOHN0SVhyM0lVQ2FlS1M0QTZSTDFUQUt1?=
 =?utf-8?B?SkRRMjhBK1l5bnFublJqNW5seWdSaGY3NWZDV3BBcU9DU045bkloQUZJTnhs?=
 =?utf-8?Q?ZUzHRraQ8no=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU1TNkd3cW1RVUZ5cFU2VWtyeGdqMWtsbVNhRWZpdnluL0pOMFRnVXlsRG5x?=
 =?utf-8?B?aFRTTExQTHVVaExHTnFLQzlCVUFYZmRCV1dNWnZBZVRTVkErSHRWcTZTbFAr?=
 =?utf-8?B?bTJXZkUrV2xncXpYZ0VGTWV4Y1pEdm83L2dkRmpkVVpTbXNxVGRMNnhXUVAr?=
 =?utf-8?B?UHl1YmRTVW9uek03Yk80d3czN21PanpvQTd1V2RSV291Y1VOYUUyZ09QOHRs?=
 =?utf-8?B?cWRTTTkrVmE5TG9DNnRvWnM0TWNXMWJuSzFNK0VZNWg0TDFpeVdjdTN1bDE3?=
 =?utf-8?B?VmsrMmdBM0lmZ0RGdDZBQmpSUkJ4MmFkT29iWjFxYWlCdWRIY2FLRUYxVHBk?=
 =?utf-8?B?aTVVY0ZScFo0UG1sTFlZTzhvdDJ1L01VMC9qUE5EYWpqaThjeGVNMDFTeisx?=
 =?utf-8?B?eXMzUlZiSVJmeWhRRkdMOExHZXZWajdWRVlvTU5rT21zNnBNK1c0ZjBvcXNB?=
 =?utf-8?B?QmY3ME1pVUVIblh6VU1YWDJ6aHZyN1o1aU0rL242cXQybTEvR0Y1WXpwMFM5?=
 =?utf-8?B?TGF0NVRHNkNnczhiOWJ3bjFFQW1IcjFsNW5qMFNObFBrVG12NmZBOS94dHBH?=
 =?utf-8?B?YzYvK3AxcVVkOFppVU10bFdWQmswN2RQV2haNHVaZWRwb214VTlSM0xEeGZy?=
 =?utf-8?B?VjlKTmxnMEFKM284N3VteklkbHNvdzk5c0lDaTNrL2ZFQVNDN2NUQVdtRzZq?=
 =?utf-8?B?S1owcjRwMytBMGdCbVBSbGRsU0tQNGZsMitwaVVUS3JCaCttSlZoUlNBQkpr?=
 =?utf-8?B?WGtvZFhwM2FWQ3p0dDNra04vQ2s5bmFqNTJsNUN3V3pmL0RFSUZDV3BJejZW?=
 =?utf-8?B?UjRvOEtWMzMvS1VicmtDK0plRFJuSEl4ajZOSHBJUkZ2WDFFWWNObHdvQS90?=
 =?utf-8?B?SmNRYmRLOGlGNGVBSHBocEludm5qa3d5eUNSNnNseHN3Qm4wdkJ2UFBaNXJB?=
 =?utf-8?B?SGtqVGwvRE1YL0lXMG1IUXJOMWxmcTNVcmZZSS9qdEpLZ1kyaDVYYlpsZmkr?=
 =?utf-8?B?SjlmcmxHVEFVYmNWcnNuN3d3UzQ1ZHFibHhEWDl3cmNNSGRYOGxuWENrQ1lh?=
 =?utf-8?B?cldWWkFkWVpIamYwMlZSNGlVMmc0Ymt3ellhazdIaFN6TkIvQjl1SmtHRXY3?=
 =?utf-8?B?YkNVRjdzRHNQNlExR1YvM2dXdzgxYTNLZGhRM3BXL0R1UENnYUtLVE9YanpS?=
 =?utf-8?B?cHF6M3NFOEdCSVBrOVdlOFpCYzZaU3o0eThmYWNzSUJMUDN3VlRhcUZFSzgy?=
 =?utf-8?B?UXpBQVIvWEJPYk1oaUNKRjNhY1UraHROdDZmMzRDeGpvN3NKMmRFQXNtMEpq?=
 =?utf-8?B?UENaZVphc1RVelRsMlRyMTNqZk4zUGNJUElZNG8yYlpScHNkMVZhR2tqaFA1?=
 =?utf-8?B?SEhvbE02Tlcwc0NscjEzeGhteXVGN202b29JVVVxdEFvYzFXNjVIclYySWxp?=
 =?utf-8?B?RkY4WVBGQ0pCTTQ3VFFEcVcvdmF4YXlWVFdHSmplL2g2Zi9QUDJHbE5pUnYy?=
 =?utf-8?B?QXFhUzIvbVZHWWJDQ2ZDdGxyZnFlMUV4R2tBMG9jdCtXZlRhYUxqa05LeXRB?=
 =?utf-8?B?VFBUaWRNaTZab1Bjb0tSaktqd1BNUllCQ2g0Tm16U0E5Q3BvZ3NBZFdvbk9D?=
 =?utf-8?B?UUNxUzIweHZ4Nlk4a1lHbThCaTlOUUsyZnI0dngvM21xejdRVkF6UjdPakdh?=
 =?utf-8?B?Nlpud1FBcUVvbTRqR0o1Mk1CZ3dGaTFacEdqUVo2UWFLZ1o2NE83Z3UwM2dy?=
 =?utf-8?B?K05lMDZ6WnVmVVBIQ1RjSXYzV1o5MHl3Tno4R3FHc01pR2F5ZWZZdGtlL0RN?=
 =?utf-8?B?Q01OUitjU052RXAyaExIV0RkZVZ3M1RxbVRuaTAwcTV6U1VLcldJYkc5MzNP?=
 =?utf-8?B?WldxQ0RwMStlNVJuTDZzWkF3ZnJkZGtPUlpUYnhxblRqVm1tN2NLdzVHYi9O?=
 =?utf-8?B?RzhQemo1S0szM2g5WlVrVHVkRDdlT1BBRmZCQlorb3JZbE52WlhGVGZuY2cw?=
 =?utf-8?B?RHRtRExLRGFFZ2ZBQnVta1pablZKNjZmaWNEN094ZlFYWWdQVjRhSHBxT29D?=
 =?utf-8?B?STZMeG01dEF3THk0dWJKdUsvMVB2bi9UVUJ3VmtOTHUxRUJJaUI5TVQvZ0Y0?=
 =?utf-8?Q?Hzd8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6223548-0c59-4bed-adeb-08dcdce382ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 21:54:48.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmLY7S02ij7hTB2IHCeZu+4jGHBSra3YDtyWwINU5DtjPa8K5Z2zd8wdgr6manIv6REClXZxZJQ9WSwDUYW1vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7953

for_each_of_range_untranslate() can get address informaiton just ahead of
PCIe controller. Most system it is the same as CPU address, but some
hardware like i.MX8QXP convert it to difference address by bus fabric. See
below diagram:

                ┌─────────┐                    ┌────────────┐
     ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
     │ CPU ├───►│ BUS     ├─────────────────┐  │ PCI        │
     └─────┘    │         │ IA: 0x8ff8_0000 │  │            │
      CPU Addr  │ Fabric  ├─────────────┐   │  │ Controller │
    0x7000_0000 │         │             │   │  │            │
                │         │             │   │  │            │   PCI Addr
                │         │             │   └──► CfgSpace  ─┼────────────►
                │         ├─────────┐   │      │            │    0
                │         │         │   │      │            │
                └─────────┘         │   └──────► IOSpace   ─┼────────────►
                                    │          │            │    0
                                    │          │            │
                                    └──────────► MemSpace  ─┼────────────►
                            IA: 0x8000_0000    │            │  0x8000_0000
                                               └────────────┘

bus@5f000000 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
		 <0x80000000 0x0 0x70000000 0x10000000>;

	pcie@5f010000 {
		compatible = "fsl,imx8q-pcie";
		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
		reg-names = "dbi", "config";
		#address-cells = <3>;
		#size-cells = <2>;
		device_type = "pci";
		bus-range = <0x00 0xff>;
		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
	...
	};
};

Term 'IA' here means the address just before PCIe controle. After ATU use
this IA instead CPU address, cpu_addr_fixup() can be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c72904..68c679a2e1737 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,6 +418,27 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_get_untranslate_addr(struct device_node *np, resource_size_t pci_addr,
+					resource_size_t *i_addr)
+{
+	struct of_range_parser parser;
+	struct of_range range;
+	int ret;
+
+	ret = of_range_parser_init(&parser, np);
+	if (ret)
+		return ret;
+
+	for_each_of_pci_range_untranslate(&parser, &range) {
+		if (pci_addr == range.bus_addr) {
+			*i_addr = range.cpu_addr;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -427,6 +448,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
 	struct resource *res;
+	int index;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
@@ -440,6 +462,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->cfg0_size = resource_size(res);
 		pp->cfg0_base = res->start;
 
+		index = of_property_match_string(np, "reg-names", "config");
+		if (index < 0)
+			return -EINVAL;
+		of_property_read_reg(np, index, &pp->cfg0_base, NULL);
+
 		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 		if (IS_ERR(pp->va_cfg0_base))
 			return PTR_ERR(pp->va_cfg0_base);
@@ -462,6 +489,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
+	if (dw_pcie_get_untranslate_addr(np, pp->io_bus_addr, &pp->io_base))
+		return -ENODEV;
+
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;
@@ -733,6 +763,9 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.cpu_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
+		if (dw_pcie_get_untranslate_addr(pci->dev->of_node, atu.pci_addr, &atu.cpu_addr))
+			return -EINVAL;
+
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
 			atu.size = resource_size(entry->res) -

-- 
2.34.1


