Return-Path: <linux-pci+bounces-15241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4FA9AF3D8
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 22:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E248228202D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54B5B658;
	Thu, 24 Oct 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jz5yW+jU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C022B67B;
	Thu, 24 Oct 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802536; cv=fail; b=qQk2YEKTxEA5HcpEUlOE+0kKhmFsjrSK9p2kgNwUYYAgE9JYrDhi3YOlEg6vA5Fptu/EjxQWjNfboWYXlEK5wRRxcH5oAZURjkeue5fm+3tXlNozBcifUVvTez+WtltC9jKRo/XuhxvXk4V4koNYU3Axd97dErS80L95Wg0sRGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802536; c=relaxed/simple;
	bh=oT3gxxagqRsY7q7VQPyUwzk3q661/v7HN91w0psa1WE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=g3jJdqgndpTPIJNZIvTTaJEs7C/PcbEYnwc4kWjCS9L2tw/rcbdzvQTBDq9zjc8tiOcXS/BCfBNz0HVvKuBSHyU+mSyrz5OESoF61/Bm0X92kLcAMEQX0la8YGl7MGk8+aJ5vN4lVL/Wrkp8bfICYKcpcjcSL1d+qLhIeqYRZuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jz5yW+jU; arc=fail smtp.client-ip=40.107.105.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Esnu1vYeSKcbob7IoT++ds/A2NIOs4aU1STCRcrOVpGA1gE7jncYbkaxYi2kpLq1l1LYVhc2epRODCN3u2yj9Q9UfDIigYbrYPpqexl1vOlACurreXr0xZuMV3BmJamrkrYnLh0LXa5AwW2fu+A2pGpnBYh4U7MRYUd5sNecFIKElmWVbIWgUQCt4WPn4AbkgExH7i0dYwr/rEQ11bLNGv2S9OegMi5mYvP/FAz3FMnnnv5WFs8sOEIn2JClE4LbuN+u7MpFuqSNdIB4SyBnTHUDnUtma3GP2c0Ji9jhkp8GenEG24+Z1+Gz+3SHKHYavnHDbWxTEFLFcY391DQdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W3ihuEq3NAOF0+3B2WpQgD5+PcokkeILQ0gE3aTRcs=;
 b=IEzr4n37ZRomF2B7nuhFUYp474B26UkOC7zVj3TflOEXlYr2TBuBwwHljq+dTmOucFMAQaw8wi4PQpLLu5wa9rKfN5ZoDwD+8Q+Q2ow7T78f/xQ1iSfb/+i/fn2zapWGHjxc/Li4G6S4J0u17SYkpSgNdN7Kmg1VizyY6kztVulu9LmXjB126UIAvP6NALY6zsOKkB79R8O+WGnBoVogI4oy0Euc2kmzTz276MGV7SlcFKm2qcwXeTwKin5BhYyeQs2eXyUgfRIKVtcVReBVCDiGH2QVJqdmX19INaE2JClyQ4DthSQroV0oaMUHgqyBRO+e37TIL4QIL2/slnIdnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W3ihuEq3NAOF0+3B2WpQgD5+PcokkeILQ0gE3aTRcs=;
 b=jz5yW+jURSLfdzxaMXh405ppgc3nrsXA6jc0b8dX5448IWJA2h5d61YoVniJBL5UxZYKDK1tkImM4i9gsspayIm9sFHRSb6zVFKuJC/LYWOY+W5Etq0OeD4wY8KHk6lWLyLcIQ9wfqJIZYjiwmmZB+WgxhBsoNvvy/Kj7fJr11Y8PiMjwQMEm4rqk2xuIW/WEVvVEDkpNaOr/c4eK/Gy9T/GYG+ZVmOhgmwt2zTA/CDaqJTcHuFP2/inNVmEdNcD4laD0ErZytJxo8rVcsPUtR7an7kRFJLAL35KRgzZtd6jyoL6QAXb1zjJqrTm0XeRLtgBlEx+oyM2VBTe1klRWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 24 Oct
 2024 20:42:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Thu, 24 Oct 2024
 20:42:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/4] PCI: ep: dwc/imx6: Add bus address support for PCI
 endpoint devices
Date: Thu, 24 Oct 2024 16:41:42 -0400
Message-Id: <20241024-pcie_ep_range-v4-0-08f8dcd4e481@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAaxGmcC/13NTQ6DIBCG4asY1qUZBlToqvdoGqM4VhZVgo2xM
 d69aNI/l9+Q52VmAwVHAzslMws0usH1XRzqkDDblt2NuKvjZgiowAjNvXVUkC/C9qhsalOSACQ
 Mi8YHaty09S7XuFs3PPrw3PKjWK/vktmVRsGBV5JMnWGuocrP3eSPtr+ztTPij0W5txhtrmukU
 klVm+bfyo8VgGJv5fqvkClmVAFo87XLsrwAynZkKyABAAA=
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
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729802524; l=6028;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oT3gxxagqRsY7q7VQPyUwzk3q661/v7HN91w0psa1WE=;
 b=WOokAsUpWT/hYUWliXK8rbq0l4KXm7lJ8ceYmSnvYkb9HcfKXi7/Up5ifrLA+PDn+EfORufuM
 o6oTL0ExDpBCEUY537zdckgI8jcGNdS89mRgX3+hvDt3OyvaNwxDR5Y
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7e5d9f-65ab-4d41-cd7e-08dcf46c5585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFBTQWJ1U2dIN0xvWDI4Rytsby9wT1kvNFVFQkVzbnlMUmJYaTVpN29xYURI?=
 =?utf-8?B?cDkrNEFTVlJjRXhOWEdCZTlWL1kya25NY1hHK3RpQnd1Q3pLL21vM2NpZGxS?=
 =?utf-8?B?UVgwVVRwNzdxa3BxWG53TTN6ekhjbGJaNFN5VDdacit4VE5RN0phWjBxbzEz?=
 =?utf-8?B?cVUrYXNLell2eis2Q1E4bmlINHhja3VJUDNRWU1LbGdoTWxjeW1JT2xScXFq?=
 =?utf-8?B?b2FnOEdqdENoV2I3VExHS3VhNUtQTVpVMjV2SjRRd2cwbXNnR0Z3NGtURitL?=
 =?utf-8?B?c2N3MCtYTDYwSWlCSFhoYXVveTVCWVZoRmRCOVBCOFptWFNiY0JFZkxBM0dX?=
 =?utf-8?B?bXk4aVdzaWZsMW1YdFBBWmtaRUJ2d0hYY3dwclI0UU5DZE9UWVNvRUNqbzc2?=
 =?utf-8?B?OUxWdTh1YkFBYXlLcFdubWFLM0l3bGIzeWJiVHlFb1RCUngyVlF4WktZNEVh?=
 =?utf-8?B?OHp3aDlqM2pGTDRYNitHeE11YW5QMTN2UHlzRVRNMnFtd0x6QVlUclZKQUNR?=
 =?utf-8?B?eDF5bHdhY2YxbnpTU0hnT0pXbHI3NDI2Z0svYzlIUW5rZDNKMnRBVUVPNk9v?=
 =?utf-8?B?ZTczSTg4Y2dHSUluRHY0OFpGRzNZZ0RsT0t2aWVKWnd0ZUNnTlhEN2pHQWZK?=
 =?utf-8?B?UlFDV1BVZjN0M1hBVUU3QXJiaUx4cGl1bWt3V2g3TWx2c29iNWpBeDd6RG5y?=
 =?utf-8?B?SzJkeGpaOUhraW5mQzdlR1I5enk2c0VvdjNvcUJkdjdpWGZZYzFZeG9Db2Za?=
 =?utf-8?B?cm5lajFDVHEzclBIOEZrdlI0SldpdWhYb3IyTWxQaDhlVkJIckZxU3hVS0c1?=
 =?utf-8?B?UjNxVXd2NWsweE5FOFlWZUVKTlBqeGdubHFkeEpKaHVVSnc5SXVUWEQyNTkv?=
 =?utf-8?B?c05XMVk1bHQ1c1dGSm0yb3VsdC95dHZJZmY2NW1UL1E5NUlVZGhXVFlvZjg0?=
 =?utf-8?B?TGFsQW80N3lGekF0NE1HN1NPb2toeW81cGErc3Z6ZlNLVm1YUjNuUmwxVWw1?=
 =?utf-8?B?RUltU3NFTmVNTS9sb2IxRTRhVUFZcUNxNndHVjlxUXNnc2NGSnBHa1RIdnQr?=
 =?utf-8?B?Z3pHVGtvbGlINk9qUXYzTlQ1L2VXMC9QazlLRkdjU1FDajZvd0JTZEE2NjdW?=
 =?utf-8?B?ZXJzZjNGbCtDRUtQN3o4MGxTSGc2L0VNd09lLzZJQWxWSWpiaGM4SzVoTENN?=
 =?utf-8?B?cFhEVDRubm45b1BDbEJuMmUvdnhka3FoOTJJSGxVRFdtTFd6S3lydFFHTWw3?=
 =?utf-8?B?akJadm9nQm5xWmM3NmZxbFI3Q0dsa2xqRTNJRk9KT1ExeTNLSW00YjhMR0hq?=
 =?utf-8?B?TmVCVnQvQ0g4YjdCR2hFeGlZa292Y2FpcjVnM052OCtneTdNVmp6TTdYNlB4?=
 =?utf-8?B?cm9HcjBYOG1Zend4QS9ZNVYzTk43N3U5NmJpdFhJWTlxTWNsa0tOTjhHV0ds?=
 =?utf-8?B?eEpob1Z3QzRoN21sWm5RZzN5NzV0MnNQWldpRzQ5U0pMODNnRkh6RlJWOWV5?=
 =?utf-8?B?SXRkMWJEVWROcHRtdHlHV01XaFR6OFhEUnd2c0oxZE5lbEVtLzB4YURzeWFV?=
 =?utf-8?B?TllmakJNNnI4RUUzeWhnZ1RHaE8wcHhTT0ZCUjVzdng4dGJ0NGl2N0dDaVY5?=
 =?utf-8?B?Q3lyU1R4VzdLN3VMREZybU1leXYzNS9oTy9wUzBjSkx1MDZhNkw4ai9OdW0w?=
 =?utf-8?B?ei9yRVhQdmRNcVpPcVdUL0lJcW1MSS9GOVZVWTBvNWpzc0MvL3ViMVM3UjZj?=
 =?utf-8?B?OUZrRE9VakJuWGlVaUpqYUxTTHJDV0JzRVM2Y2IwMWhEL1lteWpIaDB6WXlU?=
 =?utf-8?B?VkVWU2ZHMmVZbVJiOFpLZ0FzTEZmTHpCWDNLSUFxQ1R2cllwRGUvM3VEb05m?=
 =?utf-8?Q?IUoRYkw+KIzAX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXhvVTUvM2lZSzd2aUQvN2tJNmloVERYSHVRdnZidEtlcDlaK1NrMmRpNDBl?=
 =?utf-8?B?SnI5eVUyNFBobDVzN2h0Z0NOUkl3UXJjblI1anorWXVocFVwY3dwZWlmeWxj?=
 =?utf-8?B?V0xQdzNzNUk5OFhpemg4VDlId2xmN2o2OEVwL3JnaG1CdXQ0djBGRE1hd1NF?=
 =?utf-8?B?S2ZTaUtDbFVsVi95NXE5cURwREltTldtTE9HVTBpREsxcEdkTFIrOWx5Q0xn?=
 =?utf-8?B?bENaSmpDaE0yc2J1Ykp2QzdpMlVrYnMyMGpSMFE2K3Zxb2UwckxGWnRsMm4z?=
 =?utf-8?B?bHJtQlU0cEJZTFFsNW5ma05WTWdXQjl4Uy9TRHV3TllBR3VIUzRnRlV3RVJE?=
 =?utf-8?B?TWdPMWNPY0ZVOHhJbXBOL1RVcDZ5SG94TjZiOUhCMlhTeFB0VEpnd1BVYUxR?=
 =?utf-8?B?SWVJdkdCdStwbXYwY2hWaVdkQXdNWW1CQ3F4eFVGbWN2aTJYall5VDVEdUpJ?=
 =?utf-8?B?blUrYUQ0MklnOXlOeTZyOWNhVWdWRTg1eW9lU2R0V1ZWQ2lDOUFoelNkaVBE?=
 =?utf-8?B?emR0Wnc5eUxLcUdsRGwyUC9VQmc4MUgvcTJDVWs2SjNvZlI3MUJUR1Rpdi9r?=
 =?utf-8?B?dmVuT3Bib3JHWDdKK0EzeXRBTXhmNkxuNTVJRFZ0OC84SmhqUXdSb0hGdEh2?=
 =?utf-8?B?MnRnd0ZiclZLY3BNOHhaWFhQcWt6WWdxVDVDb1I4NEZXMXF0a3dKSE1oRXox?=
 =?utf-8?B?cUtNZVVpOUVXd2RsVHdjSm9IK05GUWNZRUNUazBETmlEVkFhTjRMN2dYME5j?=
 =?utf-8?B?L0VlSTlMbGFOck5KcHQ5aFFhUlcvYkpxU1k5a1hEa0diTmtGTSs2YUgweERR?=
 =?utf-8?B?QlVzbG56SWNrSDBuRmwzNFBJWjhpTjA2bWpLT3IzdVk4cU50eFhHOVZGeDQ3?=
 =?utf-8?B?cFZ1UjBhRVhoR256blhUMkNCaWIyZERYajk0L1NXQ0dpWC8vL0pPMWFna2sy?=
 =?utf-8?B?bVBpNENlOXd2YlRWcFdSV1dLSlRTekphS054S0s4emxZZUtwWi9kQW9wMEh5?=
 =?utf-8?B?U0RWTkNkVmZJdW1Ib2ZXUFBJYS9SQmZ5UjliZ2FrU2lFVEVUNGp0eFlBRktJ?=
 =?utf-8?B?VkVQbnFpOWNrUi9WcGQ1MWtHaXhCM0p0b1RDemx2TTVJWXNHQjRaNkpuTktM?=
 =?utf-8?B?SW0xc0x5T0g3NjdXc3ZyZGdpQzEvQmUxb0IvODFsSG1xVmo5b2dKczIrTTF6?=
 =?utf-8?B?Z1ZhT0pMQTZHdWVtZERHNjUwRVlJdGNQN1BpNnJ3T0Ric3FZWXI5b1dEcDRU?=
 =?utf-8?B?NXk4Y2dKWWorem9veWRPVEZlL1BpMkRVZ0lLNjJXOVdOb3hNQ2RWYjBBNkNa?=
 =?utf-8?B?a2FBSW1teDFPUzVGZktCOCs0R1dwMzNRYXJub0xsTFhjS1RVTkkzRWRsQ3RG?=
 =?utf-8?B?eitQMFJCM3MrQ2pxcGs4VmNPanhYSEcyM3VpcEdnSXo2bCtqNklLMHFJS2t1?=
 =?utf-8?B?eDlLRkJYaUFBaGozZjB4WWFNdUtnc3RkS0dBZVVtSzhlcE0zL3l6aXNvTnFI?=
 =?utf-8?B?WjdPWDh2ek1OZXloUFp1UG02amFDdmFNTnFQamJKMmFLbVhvSUF4ZXRCOWlN?=
 =?utf-8?B?Y2FSMTJTZTRWUUY2Z25Hb0pJOTJCOVZsTkhGb0c4dG9oRU1IZVJOMFNKaDJS?=
 =?utf-8?B?NGFNOHM1QWVTMXgvM3k5eFFFTTQweEFDTWFBeERIUmRjVE5sTGhqcjFhU3pB?=
 =?utf-8?B?Z3cwalFNUlIrK1kwYXhuN2NyZmJCN1RXY2lWMjJFNHFuNCtlb1hLNFpuMHI0?=
 =?utf-8?B?MWVrMENtYlBHV0FxdHNpUDNoVTVxNEtHVmZhaDJOQzgwM3piVlczd2RKc01B?=
 =?utf-8?B?REtlODc3dHdnb3c2UkROTjN5SFdqQkxhcTE1dFViK2lvdGhyRTlWV1UzU2lB?=
 =?utf-8?B?TzVrUTVVRnlKOXE4VzEyc0JHN2paaHcyQ3pEelRkVEFPSWZReU9kMExTZFpl?=
 =?utf-8?B?S3ZXSFFTSWZ1cjA5NVhiZytlTHVYei81MGhIODRZa0NHQkc3MXI3THlRcUNO?=
 =?utf-8?B?RXdzQjRWZjBhTjRQTTZkY3NGYkJnUjQzMGpXRmk4NnJCd0pVdmg2ZE5xNmov?=
 =?utf-8?B?RUFUNklPVFR6dkV3WGRKYlNPNVNHelpaRndqMHJIMEhnY2dkSjcyVUNoYnhm?=
 =?utf-8?Q?x2zWQdQdYr7BxxQY7sny4S28M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7e5d9f-65ab-4d41-cd7e-08dcf46c5585
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 20:42:10.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCCppSe1nupoEUKq+3SoobwRywrGc6ryzzTUypkRWa5LrgG6l7Gqj4iH8n+ggYo9afC+cEJVfar6AW6sGlToLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517

Endpoint          Root complex
                             ┌───────┐        ┌─────────┐
               ┌─────┐       │ EP    │        │         │      ┌─────┐
               │     │       │ Ctrl  │        │         │      │ CPU │
               │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
               │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
               │     │       │       │        │ └────┘  │ Outbound Transfer
               └─────┘       │       │        │         │
                             │       │        │         │
                             │       │        │         │
                             │       │        │         │ Inbound Transfer
                             │       │        │         │      ┌──▼──┐
              ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
              │       │ outbound Transfer*    │ │       │      └─────┘
   ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
   │     │    │ Fabric│Bus   │       │ PCI Addr         │
   │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
   │     │CPU │       │0x8000_0000   │        │         │
   └─────┘Addr└───────┘      │       │        │         │
          0x7000_0000        └───────┘        └─────────┘

Add `bus_addr_base` to configure the outbound window address for CPU write.
The BUS fabric generally passes the same address to the PCIe EP controller,
but some BUS fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use BUS address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
the device tree provides this information, preferring a common method.

bus@5f000000 {
	compatible = "simple-bus";
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie-ep@5f010000 {
		reg = <0x5f010000 0x00010000>,
		      <0x80000000 0x10000000>;
		reg-names = "dbi", "addr_space";
		...
	};
	...
};

'ranges' in bus@5f000000 descript how address convert from CPU address
to BUS address.

Use `of_property_read_reg()` to obtain the BUS address and set it to the
ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

The 1st patch implement above method in dwc common driver.
The 2nd patch update imx6's binding doc to add fsl,imx8q-pcie-ep.
The 3rd patch fix a pci-mx6's a bug
The 4th patch enable pci ep function.

The imx8q's dts is usptreaming, the pcie-ep part is below.

hsio_subsys: bus@5f000000 {
        compatible = "simple-bus";
        #address-cells = <1>;
        #size-cells = <1>;
        /* Only supports up to 32bits DMA, map all possible DDR as inbound ranges */
        dma-ranges = <0x80000000 0 0x80000000 0x80000000>;
        ranges = <0x5f000000 0x0 0x5f000000 0x01000000>,
                 <0x80000000 0x0 0x70000000 0x10000000>;

	pcieb_ep: pcie-ep@5f010000 {
                compatible = "fsl,imx8q-pcie-ep";
                reg = <0x5f010000 0x00010000>,
                      <0x80000000 0x10000000>;
                reg-names = "dbi", "addr_space";
                num-lanes = <1>;
                interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
                interrupt-names = "dma";
                clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
                         <&pcieb_lpcg IMX_LPCG_CLK_4>,
                         <&pcieb_lpcg IMX_LPCG_CLK_5>;
                clock-names = "dbi", "mstr", "slv";
                power-domains = <&pd IMX_SC_R_PCIE_B>;
                fsl,max-link-speed = <3>;
                num-ib-windows = <6>;
                num-ob-windows = <6>;
        };
};

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- Fix 32bit build error
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/
- Link to v3: https://lore.kernel.org/r/20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com

Changes in v3:
- Add mani' review tag for patch 3,4
- Add varible using_dtbus_info to control use bus range information instead
cpu_address_fixup().
- Link to v2: https://lore.kernel.org/r/20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com

Changes in v2:
- Totally rewrite with difference method. 'range' should in bus node
instead pcie-ep node because address convert happen at bus fabric. Needn't
add 'range' property at pci-ep node.
- Link to v1: https://lore.kernel.org/r/20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com

---
Frank Li (4):
      PCI: dwc: ep: Add bus_addr_base for outbound window
      dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
      PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
      PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
 drivers/pci/controller/dwc/pci-imx6.c              | 26 ++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 14 +++++++-
 drivers/pci/controller/dwc/pcie-designware.h       |  9 +++++
 4 files changed, 84 insertions(+), 3 deletions(-)
---
base-commit: afb15ca28055352101286046c1f9f01fdaa1ace1
change-id: 20240918-pcie_ep_range-4c5c5e300e19

Best regards,
---
Frank Li <Frank.Li@nxp.com>


