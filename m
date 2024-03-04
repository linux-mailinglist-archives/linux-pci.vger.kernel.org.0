Return-Path: <linux-pci+bounces-4476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC7E870B81
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 21:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F901F2241C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9CB7AE4F;
	Mon,  4 Mar 2024 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J2uL9NOS"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200384AEF9;
	Mon,  4 Mar 2024 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583942; cv=fail; b=NZDJ9W2yjspxZxpTRbpp2nvreAYHFbNRoLuXljllJTgSvmS7OiMYcZkwXP1BqTvGPKavwl9iGB9Y68Me9kuTHgyvfIqKy7bhab53cBy0E2TFDwIr5yKsyrYvGpaH83DV2zYVsp7dFwLRg707fUT0KkOzHIdskvumeQKMQwVg3AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583942; c=relaxed/simple;
	bh=kSZuJ7yjz0SmRaBg2SqUCXkBSOFoRX5eYh3tDSgjj2M=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=jmqjQTGWlO7SF1JLbg3wNdKHC7gT1410Th+kCrNiI0ySbGfgket67bgwZt1XPSx+IHD31d20uVHYkwhttHW/RW6S68y+A2lXhpzFbfHCoiQoPr7mlW07ll9tu0/mawB/UhPzjru28mXbTmAh0CyL2c7xaMXMtDW5K8XT0sKzS4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J2uL9NOS; arc=fail smtp.client-ip=40.107.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaUGSHTy7o6WTKGK8EYWqqEB057HZP/KhyP2AF+46reMaa2OHWyElBVxNfV2O1N2BfxB22zmSqdGvjBKtg5MqwYiou8sIsb9mI6rMkiuRJZNF4oxsH13hkYuovS+cloq9fjZrZu2yiuamYe9VzvMqcPhSpmtT4hFB/xVlyXTeQR8ikJ1R9/G4F7Loiaqbj4KqP2cyJEWkZCbYkw+/9sm7NLxuckjz7nsK38GBEPIBoPfg3pDsDCvYu12MU1h6ZLPvnuCF6gk9l6yvtdrdnPBVcg19hb66h396ZYMSa4LYplv01zZ0TN1zoUS7KiFvv2X6E0YXVV+a0NxYcpAH8WqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5daHgqslTggQTuwBIrtuq8GRDm/QytOmJQJcHi1Wrc=;
 b=Mp34FJIdcJ/Q6W9d6z7t8r0PWnRM6vFLMLVoYxiFl9bviAdiq0ZVe5kZ0W+bjBou28GvUpwOmVilko37U1jWs8tn/xE/e24m5WU+j0QLeWjC9LoSU6Tn+ujvwlzomEHdURtACr7d9a9dWqNDZg1PHFnHC3pzZw7VidmhWO6G02LwYiLT2fFP0+mAlIf4aFbImAum1sQ59k8Eq8xpc8fK50HKI0XA0+3ZVF8fGr46gsOfZZ9SDQL2ePwGWiRWnkD4JKvQdWme7BgoZ/1Xicad2Eeh61TsJt9pCsc8f6mXGLmRpOFW7fduAvlh7P/5gaSHa4Qqi2e701a6K+kwi69+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5daHgqslTggQTuwBIrtuq8GRDm/QytOmJQJcHi1Wrc=;
 b=J2uL9NOSkXeX8Zj6Hp+JaYUvkc+sq1frq9JdTRnPcsyGCpDdmbPWWPxrYys6x3rRwSyEmjBZD9v8qhdkwp6lTENmrMaIE4PFXAFkeBcG88S1EeyeR7yj6ZlWw6yiUnCpEodW8QkZSrj8rZzUr7CxIS/3fAtsFLu8mCYRRxajr0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 20:25:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 20:25:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/6] PCI: imx6: rename\clean up and add lut information
 for imx95
Date: Mon, 04 Mar 2024 15:25:05 -0500
Message-Id: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACEu5mUC/3XMQQ7CIBCF4as0sxYDg0XrynuYxiBQO4sCgdrUN
 Nxd7N7l/5L3bZBdIpfh2myQ3EKZgq+BhwbMqP3LMbK1ATmeOOKZRUP4eMc8J6cnxo21otOiFUp
 C/cTkBlp3797XHinPIX12fhG/9Z+0CMbZs2txuEgpFVc3v8ajCRP0pZQvzAyl2agAAAA=
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709583932; l=1486;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kSZuJ7yjz0SmRaBg2SqUCXkBSOFoRX5eYh3tDSgjj2M=;
 b=UnsqG/eFANVjuUcZODJ7yDIMsFKqWvf+sqG7cjIUROAMRVwgAP6M8C3FOedot+cXt6Gm1T/Zp
 t40bUIslJKsB/n4ssK80ffKecZ6tGtfk9iUjBgWxkEfEd9jgDYgFhLs
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:806:122::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a555078-7859-420f-2854-08dc3c893fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wP8bjdMzNWktJbn3ImaTx/RtRF+pXWfbHfJUHmoqj7ncRTYRadRrG/yRVs6aEGP7gWamUdWUy2xl/TjiEFWb8regw7yDY7dMzhDpl9FDng4HyScGH44H20SQiV/gPKgkZeMc6qbTIdmls/FnW5CiT+BBqom24TP0ktiLOvuLxxoBBuLC9w6sA8ZbitjGdrAwl1mpn/JoTfRy3MNRf0Qr5KmLqiajpJdb0QIju1wDyqP0/JxrlXtML6zvuKQ0gYBKQKemoEDW09Sdpscf23qVD3du0an5obLLSYJq0EXdPBgxKJuLm+A74qVq3X4F+LgM90oxlzZtEBTKssZz9ASgZgzzut1KZcNVpKgcp8fHwD6OUi88eA7RVHB8jHXeTOSVSnRogSZKixsDczQIAnNrJrj/5WEM9s3o6UK1BP69jJIfqP3xR6PIAblrysPZTKUZOsaT80spZ9hGBh0IF3p/1e2bXOm1DystFV3KkCf3ploHc5JBsV31nXJ/CSt7oFBFASMPKz1TGhQGVUli5WFqSjeetUfP9ybdcxIllRo50+177kxu9yEvJHyXUt4B8GYu6+dQDhQGLqvLhS3cRPryDBczaUKWwoESagwudyVp2aVDCymKG5/wOFmbdLiULMKDHn3wk+5jYnoJTgsARZ06Aw+zZkZFizqJw1LnXwCsbUhQ3qNmZkPiakcdRc4+9NGO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW5zUVdvWmUrN2NRa3YyTWlqUGV2d0tZMHpVRzhVYmYzRXdqV0hrZ1FmUUpz?=
 =?utf-8?B?VlZMRjIxM2ExUStjUHNtRnk4NVRBVGxiVkY3NHczeFJ5NXNoenY5K3hyS3FE?=
 =?utf-8?B?SlEvZ2VBMENpV1hKMEdCSEhjTFJkNlFRcUgxV1VTZ3IrS2lXazZSU2toRGZQ?=
 =?utf-8?B?RDR2N00ydjFxeTBXZ2xzZWNIRFFWMWs5VEtJemtTUVg2ek9hRU5xOHhXUXh3?=
 =?utf-8?B?Ym43dElvaitKeFdPdi9rbXpmRXFWL3dRZGRBUEQ4Z1lLQjlQb1pjVDFLYUhi?=
 =?utf-8?B?WkI2a3hGc0pKVGxaamlVMW93UFQ3bnZKWFZsSHZPRlJRcUZLd0xrQldDTmUr?=
 =?utf-8?B?YjQ1dy9zMUFzS3RaNzNpY0xqVmZaR0tsSmxIVldwaFcvZ2ZneXJhME9Tdm91?=
 =?utf-8?B?NzRwbmxWRjBKRlc3UEQ2RHBZUnVseHVTWHVxMG9iTjJ4ZHI5UXBFaFIvbk9v?=
 =?utf-8?B?Snpkc3JSYStjcXVqQmkzMU13b3Ixd20rYVVjYmlGd21oSnYraDNaaHliaGRK?=
 =?utf-8?B?M3BZZjFKUFF6T3padis2N3NBZzJtZnhnVEY2ZHZXdnlERmI1UXFlWGF2SFpY?=
 =?utf-8?B?Y2REalhSZHNic3dnMWVJYVhkVnlQa3p3cXRQTlJuVmZuSENsL0piTHR3L0dU?=
 =?utf-8?B?aDBwUjBvSEkveUdtT2VHV0RFcHFBSnQ3K0Y1QnF6TVEvQUs1U3lNdHkrVTR5?=
 =?utf-8?B?Wk5nT1laeElJV2tMbjlZeGVzREZvZHlnajYvMFlvOCtFNEdRd2lLeElnWTNi?=
 =?utf-8?B?dE14MW1sN2lVWWg0VFBlUGlrRExScHMxUFg0NjFhQmgvZTVMZEp4d2V2cFdv?=
 =?utf-8?B?Z2dVSkREL3EyaXdMOGRzT1ZGTkNNY1VWdjVNL1VjTjBGTUp1ZVV6bW53M1VW?=
 =?utf-8?B?S0pDUXVKVXdUblR2R1dFRHc1M0NFcU9IdkNIbG5qMCtMa05RN3N0ZGVvWGJk?=
 =?utf-8?B?eDVqZ043dllHWjJ2WEY0SURidklGTEVSaE41SFdGTXQyTFFCVVk4aktQc2Nl?=
 =?utf-8?B?T1haZTk4NmdzR1hrMVcva2VXU0ZVR3NoNnVISlJJTExrMnZUYTVOb3NYeG1n?=
 =?utf-8?B?YzFTSFJkUVUyT0pLWnpTRExPcXlyb0duRnFrRU5RUFBKK0Fza2FpRkYzRHZz?=
 =?utf-8?B?cWMxeTdkcktVZE90UkRZdGgyVWNieXV6UWpNcDRMMkowQTdJZW5mUTk4VWdC?=
 =?utf-8?B?TmRicEd5WVNwU0FIdThjblQraW1tOTBQZnAzVkFGRmVEcjh0NXJqNS9PS2o1?=
 =?utf-8?B?bVI2Mnp5UXhwQTROUGJmWkVoWkh3RmtMUWZmZUQ3cUxaRms4V2V4SmlCcjNs?=
 =?utf-8?B?TExrMEUxVERQRHUybmpmdVRnbGJReUxURTlOL1RGakJIdHRldHFBL210TWZm?=
 =?utf-8?B?TER3eWJyelJaeGZXcGt4ZFhwRWdhbFh1ZXhkZzVsczRGWmdZc3RWRzZoWHpt?=
 =?utf-8?B?TytaUHlheVR4cDhmM2NjU05XN09PNXUxQW1XeG50THBaVmIvKzJ2SlFQNGFP?=
 =?utf-8?B?OUtZNkhScFlMNHVWTlhOMGJVaGVFNUJhWjdlNWZkbldsUW4rMXgrSHlUVzgw?=
 =?utf-8?B?NnkzczgrOUxQL0JUT0NoQjFLeDEzY2RKRHFKc0xZN25NeGdGY2Y0bmpJQnVq?=
 =?utf-8?B?VEZiME5VdTd3TThNeFJ1RVpUM2tTMHRYRWhZdnpXcTZLMWUyRlY0MlUyRlVG?=
 =?utf-8?B?VHdDcVZXNmljeTdJZjhjSElqNzZELzBNY3NyekNuK3VHNFB1V2NMYkRVMitn?=
 =?utf-8?B?cjMrVmhGek1Od1BzVzA1U2toY0FYT0F5V09nMkJQU1U3eVB1bmxkWVdOeEFy?=
 =?utf-8?B?Y1hNM0Z2enNCY3BsUkNzWEpOUkJ6Wk0rZEVRZ1R3cmVBVjFOWGZpcHdydmR2?=
 =?utf-8?B?cm1rOWJiUkdRMEZXd1YyT29vOFY0b2RxZGhsWnlVWE5SVjBtUWJ6YXJKTlhx?=
 =?utf-8?B?TlU3RXgzWTlGaUNNWFRDd2ZsdVNGYXNXajdHSmFCUkRoZjdZdU5BSGg0ZTV6?=
 =?utf-8?B?WFBBLy9zYW03RnBVTm1Uc1pBaG54bzFZeW5Ka2dlWWg1SXRrcTJaU29WQVZx?=
 =?utf-8?B?MWJKOEJUUHp0QlVpTkNpUTBnTGlyWE44TmdXRUZzVFZDaHZwSXN2WDlkR3R4?=
 =?utf-8?Q?BpDg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a555078-7859-420f-2854-08dc3c893fdb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:25:36.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAlchNrOqHTKo8O+3kVlzoQa253T2oNiInLD13oMdYsoopQXqusdDrEwgWa0EttFopz0eW4YvDYbFTkD7chGWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
pci-imx.c to avoid confuse.                                                

Using callback to reduce switch case for core reset and refclk.            

Add imx95 iommux and its stream id information.                            

Base on linux-pci/controller/imx

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- remove file to 'pcie-imx.c'
- keep CONFIG unchange.
- Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com

---
Frank Li (6):
      PCI: imx6: Rename imx6_* with imx_*
      PCI: imx6: Rename pci-imx6.c to pcie-imx.c
      MAINTAINERS: pci: imx: update imx6* to imx* since rename driver file
      PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
      PCI: imx: Simplify switch-case logic by involve core_reset callback
      PCI: imx: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95

 MAINTAINERS                                        |    4 +-
 drivers/pci/controller/dwc/Makefile                |    2 +-
 .../pci/controller/dwc/{pci-imx6.c => pcie-imx.c}  | 1115 +++++++++++---------
 3 files changed, 647 insertions(+), 474 deletions(-)
---
base-commit: 0a580c33494a7d293ff0d34cf4db4af107070ccf
change-id: 20240227-pci2_upstream-0cdd19a15163

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


