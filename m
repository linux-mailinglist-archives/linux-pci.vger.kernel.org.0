Return-Path: <linux-pci+bounces-24478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A1A6D44B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFCD188FF39
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628E536D;
	Mon, 24 Mar 2025 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yek/6zND"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64544171C9;
	Mon, 24 Mar 2025 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797900; cv=fail; b=GOArtQMeYk6S4lXnupsy5XJd8T8BJiMrMvgGmDu9PsrweQwVQGXrNnWcWKfMzWb9INAGH8ZpSTrvHNRQFVEJ3PwCSQ1iGNBIZB1/1Rpo01AdBOiiMYMS9RRKOe+FAeTUaBHrD3+hSy03oK4gTKVLxVKhJXv439YVgjTcbAdg6qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797900; c=relaxed/simple;
	bh=5viLkDaV0OCOoopSReBCWctj+jGE5DMg11LXNrHDh/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pi2OH5hSztNggtvfoA0SNc7VJrA+hhheMIQb9/4PnJxEt4xPTHWBVLqXCF14GsJTdxDkB7B1aikA3d39Dhusg197i4SZoVYKAAiMXF6lxi7fuVb2TYl2Hu73cJvWTLo4t0YlvBa1ynYehSB7txUTW0mb3iM34jgS4SlJZe/xgNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yek/6zND; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgu37K8dH5r0YPIrhd3po11nI4+zErzZoA4tNH8cXE+KOCHEJWatoMzxTBbjFJ0U4Ll+Mcq+x+065qFcBsjkgy5+jcQOcHSD0WX0MeNWM5TVkG0t2HSfmEP+3yoKfCbcDQPptLe2qVsUHijhuYReT3q8eGWh2PLStRZ25k4bHtvGAbbbUdnGAdc7C6JPrMLr/wOnbGW8KGcR3WACEXRx4/ZaSOkAL7tdpUB6Wf4/pkBYI93+sFT7BoHMNMb547ZqB370DVG6SSzeG8fDzyi/XHN2ZU93PLrH9B8P63uS4+YnWRIGzH4Y+XWfODGoQ9yGbT/TdYb0cWrWG6OuR6ezhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5viLkDaV0OCOoopSReBCWctj+jGE5DMg11LXNrHDh/Q=;
 b=eWyo5ALBq/jSdkjETSj19+1mtmZ5jRCEkNwAuVaWYsvm5vXdv7LA8cMnhwOUpOu9E6eAj7+S+BBVYtjP0ayBXVd+TZUxVkfO57EDwSdvybrYScCKkSi26CU9Pt46u2mxzhw6tVFS6Kc7qDf43GwZ0a8yl8EDOhD6O8DWJcbd7fmiMhxa4lqlx5NL2aDJ7PmQfVkHI/3TRR4p0vY++U5fSPCGtF+fyhtmDH/nweMzz/mdpYWyDHe/dCM26Q7wJE3XpCwOTDEMm7Fk9K2pnM80QNrnpS/wXZqoRcZHFmNZuZAVUP666eSy/rfi/ROqSPALhcaMV81SprVAe4QAzeWR2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5viLkDaV0OCOoopSReBCWctj+jGE5DMg11LXNrHDh/Q=;
 b=Yek/6zND/L0dVzbdJZ8dYhZ6Hn8wmPhjnwieOhomcOAYt7UPLIJWp8TddTikBzhRnwh2Z0BpNgn1trJ5NY3Vbo3MslzPD9RR94cEiwp92ptRgJFo2+qlg1rDfGm3ecLItr+CjYOoYzU9l0LSxK2VbXa+x1h58qPfXi/nxWEmnq91A8TWINpNFwlkr6aNlxPh2+jO4EMMhVCTpsihCgasQaaYHOVHVQXtUfYRqYysVuGBYAhyINmPRvEbY0YCnkK9CToTtlyYjTO8yVRXnQwRmzFWXg6TrYqdrFp8iEeXG2f1Y+G7o4D5jo9JMb85TliqI3NAgw3i6tx+NTvJMCPqFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:31:35 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 06:31:35 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] Add some enhancements for i.MX95 PCIe
Date: Mon, 24 Mar 2025 14:26:42 +0800
Message-Id: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DBAPR04MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 655f2be8-370b-48de-e010-08dd6a9d860c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?icoxfQN9ESqgPv5yGJvg0Y5Po/EF6EO/ROIPbqVPAleS7wBcXu3f/CDHirU5?=
 =?us-ascii?Q?YDzN/lvzZFSuyUJWqLWqA/VziGF9VxCBntmPJAkhNQX1oBP380Yh0WARFieC?=
 =?us-ascii?Q?pTi8u3hheaqMficQOBBWEiJMV6J9M9iW4Jlpxg+SaKCSE5HtY5XGRRHC1T3p?=
 =?us-ascii?Q?H9a32grnN4nZp2a/t/8jB9L1MSGohz1O+eeeZaH6mYePWMVSBs7Y7Ih0naLV?=
 =?us-ascii?Q?TSR8eH25Xi3jR9NpZ/44nFznhhOdtbVQjadzag9h56mskhkJ7hhbutYI+2yx?=
 =?us-ascii?Q?1gKEHNyl1mlomBPcjO6FOoFzPE5gEZ/NWaQLHVF4BRvfYGdBEVaCaxr1CFCC?=
 =?us-ascii?Q?00RRpcO+JF87al7NuYd22ObGoFdGo5/Y+O5Pw5jb4zv6rPXiFE5Wb4ti7RKU?=
 =?us-ascii?Q?Pz5w3ys+rMKpvhIzJg1P33P71RDj9Iq0Sx5CrMzNtKYz9/iJwPozg6GfFOTT?=
 =?us-ascii?Q?zL1PpCiX652jV4RutfdmaiSQpXIBuqkU9icv2nTMDtpdOnyu4pXncQNN6TRW?=
 =?us-ascii?Q?Rqsq2mfWEaCDpN2EkCOSn2sysFRuoCAjrBvSbG5L+qUOEjjFQcTP95GTdkkc?=
 =?us-ascii?Q?BlJWKyDRT1OxldJOjO5OcDXWcXL7fH1MAKutyVqMPPaOX1FLW5A+bTLhKN6K?=
 =?us-ascii?Q?StRNTK+zUGpL6APg3b7fq+0TtJaBA57TXju6Fklh62RgqrNmCD8DkH7nT4v9?=
 =?us-ascii?Q?M6RvKdCOkikxYhk7W7pGEGT9OXHxgQqpqFX2RVjRHL9GKNcOmZOzKUkeFPj9?=
 =?us-ascii?Q?fAFfe2TR/mXhNoDnAcmgIR22o9hoqXvscTMqA/rKi+GyFhY+hNpmlpmBdarM?=
 =?us-ascii?Q?5mrkzOZSyzQXPmmBCQflRLtQU5JXol7iqWeeQKQKnoqkTHpUF8AzCXIctet/?=
 =?us-ascii?Q?juC3TiISPQQxgzdoFvRhDy2f4CSnUttYwiHCCpxuQ1+PeBpCxQqWWwnuAxoU?=
 =?us-ascii?Q?ILFqvwTuPlU6G/mSMrCmc4zyYtNm3bGXwSBKI/ny9gOB4mGPO9uGqN4P797N?=
 =?us-ascii?Q?yK+CcP6Llz4rCJzWbi0SFw9ok8G4QALZrOpw23I8vWItC1J2JbYYCck+4OKA?=
 =?us-ascii?Q?I9dmyXwVn151lfXnEqh8Ucp/jWfB/dPtH2igrEq9OJIkHA2QiJEtRXGN5Int?=
 =?us-ascii?Q?BFGt+/oSalU2aqi2VaKVdu/zgLAidJNwGKbD8f0YNZ2C7dip+x5tyL645rss?=
 =?us-ascii?Q?XWdmlFLMzQWNuFjYZcgnNmxLEwz2W/qMPqeYziWuDQhUfubJn/G2hR4pMMty?=
 =?us-ascii?Q?IgkA0z1ojZj4ONDfwbvMC8f1G8pEa77GP47cF/jOOZWYN+OUNU14zyoikhjU?=
 =?us-ascii?Q?P4tCLA7tn58cMgJJO/xQaxvqGM4lR1lahAmspq5VjMICOtKI8HC0ck7uz5Wz?=
 =?us-ascii?Q?G1xwfT6P8lMtsU+OaItctv2tnJEtBsBQT3EtO770OV0m7/viho1rnZMUgK5N?=
 =?us-ascii?Q?b7dkbhO3F/qZdlYfClCKq6I6rIpYoJum?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?745UkW0BVHbhB9gapgPIHF9YypqR7G2Kfy20f2ZHHMZ2RUKjdXHU57vdxJe5?=
 =?us-ascii?Q?pO1n3uYSIB43ai5wJBeuB+J8jo4NTHLaFXwqFPuJVpAALBW9wZ071sXZKz0l?=
 =?us-ascii?Q?uhOsOGBNyMC8dX8z7SdlnJAh529u7xJKyxNuHxw7pKBmtBQ6K5pO26XmgpVj?=
 =?us-ascii?Q?DpXmECDiI58MhNVYhFmyhZGdPftR5ETHVRTggSXujurjyg6ej4YuM7IAsXMW?=
 =?us-ascii?Q?7af9IVVdvorEzOaJbknAe20Oa+dP8Ye4hQvnffqlYrlqGsTPezGLG0PUqfhd?=
 =?us-ascii?Q?T0jneWQ+YlrqQwUwsibKIrA5rUZ+J/p3cnr03oOLBMXYzW9QTYFfC3bvlLKU?=
 =?us-ascii?Q?it+wRPRk/caRPOwihJFtIKGmDHLRMLq8w3ZrGt7KohbHg3b892hVIyi/yVrH?=
 =?us-ascii?Q?ABEX3TAork/LelOjdwnBvp/5wU0QFO7xN1UA4oAc4xy/12iMeVfNVcXljFBD?=
 =?us-ascii?Q?4GwGD0SIDR7ztGIzuBp4cV9nz/KVnUJm2KcYQh85nf7ZF1BM0f/AwgGUkDh+?=
 =?us-ascii?Q?NGgHuxBVkGcOA8/myviOKDoCIhGcTaPybWYQORnON6mEsG9TQQ2zQi/jCTFY?=
 =?us-ascii?Q?8MBTVO1MkHG1XiGeiO9u8an8K7z27rNU48hQz2DZy52yu9iz/GKRDTwU7mh3?=
 =?us-ascii?Q?uoQxTCkr1630QTQPXe0wk4CUtqOIpKrggo/7KDeAofDbX0ZXXbsvL3ml8Uz6?=
 =?us-ascii?Q?2xARGmDg09mTM75l9y6v8DSx7+3TD2zqjSYqxgaadYGS2lVAk6mIeqdACGoE?=
 =?us-ascii?Q?7BEatogT0dSvGkeWiZ/GQNQIuX96HqkwdVRhveVNiVvAly0LeQ/4BXZF12kz?=
 =?us-ascii?Q?nNWB6sFPAYryeh+iibHS1aleqGmaFUZ2ANj1sqZCT4eyvswTV5+vsVC81kJx?=
 =?us-ascii?Q?g8zCKHtf+UaDJvBc9QKzTpIrbCl9wJC38dQ+1PNNYRB1s4C+In4LjRgT+BvT?=
 =?us-ascii?Q?shljqhZ7JUb+EXP590B13vbx0J+RQ8y0fYchNfAmxBbMy5vCs55EOSxityMy?=
 =?us-ascii?Q?saoR6T03ugV2qJIV3Fh7vFu+JSQE5GsXGZGENr7ut5dSO+1ce7+wxz8oAWv2?=
 =?us-ascii?Q?69p3XQcjcRuFRsF+LlfD0qS+6QS9daMpMubP+G3M5FV7X/TmxaFU1Xr1p4ri?=
 =?us-ascii?Q?P3ilcoOF6rcmmvaP3Xez/K+pcCl2sPlJtta14pl1/YDdJzHOMSb0Amrgcbc/?=
 =?us-ascii?Q?LEnhRvCjUBU/e1F84ik6r2WXL4YjitezAwlXmzV9b6W1JpkV5hno/IZLGAZk?=
 =?us-ascii?Q?34HRT1ijmKDMee9l4e57J2qSfJksoWXev2UOv5ZSSAJyXkfb2tLuOjLvrm7/?=
 =?us-ascii?Q?sjxV8SD+JJeJgjyjn9XX4QNMaeXYpFM9jEVItY+XK8amkgYyIPo7ais70oFM?=
 =?us-ascii?Q?0TuGH/8JsuMGVIju1MQXC8gWeL6BSRpI8fVqRpCWihTgngchOSwS8NY2SZDK?=
 =?us-ascii?Q?+bTtSJwqeLdhaUSKmq9MDXXRQ1kBWStHUN6dsaRS6p1FmbTyO7klSEV4jxyw?=
 =?us-ascii?Q?jmu/tZUTwGsXLMv8+1O9289mjD5MAxtuaCylGOX+wItPv0wh/cZfFeNBWJh+?=
 =?us-ascii?Q?W/txWhj5jPt6An97+0pMNh81Z13gnQCp5kz5OUYK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655f2be8-370b-48de-e010-08dd6a9d860c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:31:35.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Swfi2CPMlvffQ/12JCXWwZzOJbS2tF0FMEx2SH8oCVC44azW3AvE6eyla990u9WMF5J+3XmLV6ZYNeUnMkU5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366

Add some enhancements for i.MX95 PCIe.
- Refine the link procedure to speed up link training.
- Add two ERRATA SW workarounds of i.MX95 PCIe.
- Beside Power On reset, add COLD reset for i.MX95 PCIe.
- Save/retore the LUT table in supend/resume callbacks.

[PATCH v1 1/5] PCI: imx6: Start link directly when workaround is not
[PATCH v1 2/5] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
[PATCH v1 3/5] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
[PATCH v1 4/5] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s
[PATCH v1 5/5] PCI: imx6: Save and restore the LUT setting for i.MX95

drivers/pci/controller/dwc/pci-imx6.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
1 file changed, 135 insertions(+), 20 deletions(-)



