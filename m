Return-Path: <linux-pci+bounces-13305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47E97CF1D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 00:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA18B23AA3
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 22:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC47C1B3F0B;
	Thu, 19 Sep 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LldW8aq7"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013012.outbound.protection.outlook.com [52.101.67.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33681B3730;
	Thu, 19 Sep 2024 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783456; cv=fail; b=ZUHIIS3WGADIy5uxS5eVn6oXngo1+7f1+HDzVMxAeTzz1KJJ481QsJa3aTNVfberFT3XB0fD43D91foUsiZBIcxF9a1U/JvrirVkMho4BdE8vDtyd1WIjwQZ7RzA7g94mA++avQlLLeFOl7CKQA0V6Q0UeojDvlBF0iQGY99y5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783456; c=relaxed/simple;
	bh=IvDSx+5i049oIIKoV7c+Nt9hoWVe30sf6LUsRsEVyts=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dFtL1+6tR4kDHaGRpoNS832mTZBW7vl/mwZa3zWBOzabqK3Oy55rug66wJP6ny1joLNmpRWJ7PYopXRD695H1RHP5SVMmZLg2Kzb4bMEwU4PSEJbFY0uAsUk/Xo93i2LrKiks+G1enVPbRz9V9jTYx4G0GT6VdiaDnHdY609M9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LldW8aq7; arc=fail smtp.client-ip=52.101.67.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlzelnPjjmiENpC0U0nFzvje4TJJhDVcVbEcDJjYqKVA1DGQIejUGvTiI8YsCCxST/KfatNfv6e3roIPma+OpDta9n1DXEUJUtXF6TmLbNhvDrjPUMDt0yRaCIQxefbcW3XE2FVre+dsoMAqnE+r/9fNAHBzx3nDsrB96mIa+Lp8phWwvueJJzv/xC/NgohfjzXExJNQU3atAwW7Qoi4R9CjIv+EUfiaSHCsCjeIqQj6RtQlUjphHLzpnjpU//n+a8ZAZotRSLXbFZsn1+GpvcT3TxO9VaNScZMfPMK8vxGrJxjUavJh1cplmQk0hS9DJgQ+R5zPzcmFxAjf67lqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7Ha+PhzSPk6i0O0WiL73tZPl+bDGRz4gAUcUjnaIKQ=;
 b=Fd0NowaE6VpwPCzfKujkbt0yjzFTa9TOZW+TBYBqhOMTCMy0gRJDHOX12AloP98XSRG51MHQETlD4tJPPhtgXJOQA9EQ6LbzCUjkcst5iQFOdecFwaMeu2BW321lVWd7MvoPaur8uIHZh6/tvBwzsW2sBsWkJ3PpfBNStG8DwCrTm+kbVeGyJ/X1KFkhglnScqJMHYBhCQaXDZlspAbI0U9KAbwqdTcOkSiym7F7Jx+upUHy3rTB7SicJLdEEcacr9muB/LT4FQ9b11Oz79TsQ+9ni/PMQ+HlvtdSmxIyGdDwlrT5nbHTd9uh2n9Z5xOniAqUP6wVCG5rpmDQkuEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7Ha+PhzSPk6i0O0WiL73tZPl+bDGRz4gAUcUjnaIKQ=;
 b=LldW8aq72zRis632/wB7V1MgdWR7LSpSriHHQQskTkcPJC19RB7ASDEY3US3ad6fBOUXt0Ts2nGA9/AXZL6lUN+s+sYq1Wl2q7+leYYYHnVfZzUzxVgIzbYhZ2f11UX5etkOrh1fSiZH3rgtqW5cS1OiARc4otTgxvYeZ3McxnEYomb93hIgklc3vIsxrEpwDf/SLmlj9gIZrRdKehwZkUPjrNH4cytt5FXTfx4D8IUx3t5ArE3fR9wGwfX1yCjaH7SbE0DeclTrB9jGxutAk8KjEMz4TjvEQCF0BDqZ8iodJsOOxw2eZuftza8wloO4c28Xi8k8OtyiNcFVonXU/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 22:04:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 22:04:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 19 Sep 2024 18:03:06 -0400
Subject: [PATCH 6/9] PCI: dwc: ep: Use 'ranges' from DT if 'addr_space' is
 missing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-pcie_ep_range-v1-6-b3e9d62780b7@nxp.com>
References: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
In-Reply-To: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726783409; l=2289;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IvDSx+5i049oIIKoV7c+Nt9hoWVe30sf6LUsRsEVyts=;
 b=jz60UOGw+jLEXYfe4F9c3vtcL5GqAwzNZpasMWSInrFNVVaw8bWcSDvN4hpdlGnKkASZVxNE+
 BZImx7+vWQ3Cft3dXQei5jNMSdV0b/4x2ZH6kZXt9iyieTR8p9Yttnw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: a433eefb-3742-4fde-6785-08dcd8f6fe1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUk5Vms4VUk3Qk9qM3g3dmZEN1Vub0dmNUtweWtJVnpKa040eXI5TmFpNW9R?=
 =?utf-8?B?VVZaRTZ4aTNMQXdRSmgvaDNnK2dOZUl1V3c2LzhSVDlnR21CODQ0TUZnaUh4?=
 =?utf-8?B?bU1wZk82cUdTRlVyaVU2OHFxK1lIdnFUeStoYkplcGkybURhTXhUNllCTjJn?=
 =?utf-8?B?Ri9uWTVpa0FyTHdqNjdqVldUM1dQVFBKbzdTSUVFRllqQzVrcmhudmZHOUV1?=
 =?utf-8?B?Q0lMR0xmdmdnT0M2RHUzMENHMXZtUHJGMy9nSUo1NUt1VEJDdGhocGlmRldu?=
 =?utf-8?B?Q2hqa05wVTVEOHlSVi83eERyMXVOYkNaWUp5YTZYQW5JckFnTklPRGZ4b0dX?=
 =?utf-8?B?SGlycnQremRNcysyRElBdDRGOUduTklGZ1k5cHVRTHZ5UTExNlhMZWNKV0FD?=
 =?utf-8?B?alc5Y1hGSlJJeUQ5S2ErR2d3dEVCOGZ6UzJaa1M4SDNCYnBuMFN5TGQrczdI?=
 =?utf-8?B?RFVQSWFwRmNjdTdKVE5qQ1cxNVRCb0FmRm0yb2VUVnRkK1phb2hWelN4Z2RD?=
 =?utf-8?B?OTZPMnA0dXdyWnFsL1k3R2dRajBwd3ozT2NUWHM4Tk1GT0RIMjBrQlA1Nk9J?=
 =?utf-8?B?dER3Y1FmdkZUdWJldFNLeFpRaW5ocHA2L0Q4Vk56eXJLRjVTQk9MVXVKc2NS?=
 =?utf-8?B?QWNuQjh3R212QUJNYWpKVzNVblJWaUpuOGY2RlRwcCtESFFsektOMWVyWUVO?=
 =?utf-8?B?YkRxMUZURERUdGV6Y09nUVVxTEZUV3hxQW5hbExZd2ZsMGdlVUlHajF2V1p5?=
 =?utf-8?B?Mlh2YVYvQXVIMUkwaFIzcXR2QmpjTk9GeENxUGxQU1BXU2J1VGdFektqVkV5?=
 =?utf-8?B?bXJiVVZEdHl6ek52MW1tMitVR0JlYXJvVWFJOXZGWlBXYkM3Um5XQ2ozZEJZ?=
 =?utf-8?B?YXc3TlUxaW5IalB2TTFGSHFaTGQzMGN5OVE2RUZ0dnZiTitoRXpaZkU3bmg3?=
 =?utf-8?B?MytyS01abk9EcEs5TmdPdG5tQUd4dGJPR2VIR1FacVdqajhCaVhpdWRaZGRI?=
 =?utf-8?B?YmtZb044d2ZDRnIvQVhqOW9IT0JIK3JQS25FZ1dxVlVpN3R4Q3hOaGZOZ09Z?=
 =?utf-8?B?Nzl4Rm1XQ2dvODFNdmlNY0tZSFRaSG4zTGVrZ0dIL2xMMUhYbm1wbDBwMGQw?=
 =?utf-8?B?VmN2Snl2c0V1eDc1dnYyWVlORzZKa0FaVGNGa0lJTzNDSmFlb09OMHo3aWp5?=
 =?utf-8?B?Qk9zWEJwV1lWRXRKZTRpMGhDZitrUk1qVXRPeGxaTDIvWC9wcnYwcjl6eTBB?=
 =?utf-8?B?amd4TUpFR1RoRWlkQ2ZGM1NEMlRXdHQ4d2NqODlvUDNLT05xamNYdkQvd3JV?=
 =?utf-8?B?aVo5OTBreDd1dTQyNmdtckNKb1hEbEVzUXVkVHFLQ3AzcDdkTDFDank4VHBY?=
 =?utf-8?B?WXNyZW0yNkdUMDBCR2NkV3dzU0NiakJPazQvOGgxNEdxVmpxOXovRjNTcEwx?=
 =?utf-8?B?UEVENGxST0VEbzBsbC9kOW1SL0tRMnhVOVZBSE1yZEpRTzB1QnoyU08vYmJt?=
 =?utf-8?B?UjAzekQ4NDVLTktNT1J4RTRmQXZBUGVOR1ZIb3pyWGE5OXdkS2w2Vi9UaEdx?=
 =?utf-8?B?Y3BqZnJ3NmtNUEE4d1VDN0NrRXdUQ3l1RVVyOU9ZUVhUMlBFT3NJT290K1V1?=
 =?utf-8?B?aFFjbUppNWJKZDRDdER0S3BFcmltSHB6N1BMY2lXMng0RURZVE15MHdzWWZo?=
 =?utf-8?B?YUV3Zmt4TmcxS1Q0QXJBZ3RRWmVrMHMrbVY3UHVTV2pMRXpRVURwL0R3R1F4?=
 =?utf-8?B?U2FvaUR3NHR3S0hrYmhjeng5dGpIY3ZyRG9ObytJa2VuSDBBNW43NHlabXBR?=
 =?utf-8?B?MWFkNnF1UE5rWmhjTVAwOG1kTU41N3ZobjF3N1lIR2tiei9qbENTYmNNaVZ3?=
 =?utf-8?B?ejRxT2YyZ21iSHJhSTlycVNEVm5nN2JGam5XdVlZZXAzK3VZSjRBeDExVmtC?=
 =?utf-8?Q?58v+wzrY0as=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXNIMG5hQnhqbUxieGNpa3Nyclo0N2YxQWhuR2FEcXh3dk5ob1ZaQThMQko1?=
 =?utf-8?B?aTVqcllQcHBMbU1xb1dDZldvWGk2ejBybVdGcGJiWkR3Qk9SU1RTNkkwOWZZ?=
 =?utf-8?B?anEyMXJ5aGhLcGJjMDdMOFFJRG1uZGJXWUNDWDJLamZYQk1zZXFmOVd3K3Bu?=
 =?utf-8?B?WW1iM3Zxci9hUGNtSXlPV0JjNWRoN28rUGI2REoxQktPUW9CYTlWbDBqRXNP?=
 =?utf-8?B?TEh6NThpdDllenQydHhlOXgrNkNiNnd3RVozajFJWm1DSG9uNG5xOUk5YlEv?=
 =?utf-8?B?NVpxT2Jvei9HZ2lTdzcyZy96YzMxZ2x2M0VGODBmd0VUVEQvSWxTZnNVcFgz?=
 =?utf-8?B?ckp5Q1BUcS9vVUJuQ1p1dWJrZDNETTAyLys1OGpTWU9LaUJ0RnZrSWhxcUlT?=
 =?utf-8?B?bG9iM09QbzJ3QnRhNHp5aVVyWThHTllNcFRZQ2VDMFB0czZHaHRqc2xOOUJ0?=
 =?utf-8?B?TXJWdXBCNWFUOGxzc3FaM01yK1NVbXQzTWw3TVRvdmVMR0xQUWhCa1VZdUc5?=
 =?utf-8?B?SVYrekdRaTVuNFNUZUVyK2FYcWdONFR2UUdlY1p0UVorTGlhNVBkYzQ1K25J?=
 =?utf-8?B?T3ltSStFeElHMHpIeFI1M2tVSDhWM3dVMExBR1lpaS95TEI2SWZmNUZRQ1Jl?=
 =?utf-8?B?dHZUcFNlR2hkemNBNHZsWWQ3UHN4RWFxR2FTZksvZDZMc2FNWW1rZzdsaXZr?=
 =?utf-8?B?MGhsRHRodnZWM1VzSWljdVlnT2dRdnBscVgzdUR5MEZySklNSHo2ZS9rRlN6?=
 =?utf-8?B?WEVXeGRRS0toc1FtYVpKZWoyYjdrQ0lLTXh1QVUwTUVTbDIycnFjWXQ3cHRJ?=
 =?utf-8?B?aFdZeXVmc2gvTFp0T0tBMGFGVVdUa21DQ3dlMGxhdUhHek55RWNwYURJMGZB?=
 =?utf-8?B?VmVvR2haWkpmalJnTE5jTWNaaG9ZSGFSYklJZEMvZDlrWDlJYlFzLyt3OVlm?=
 =?utf-8?B?WWoyYnNLZi81SDFuTHhLSy9QcHhiQUU0RHl6bWNkaDN2dkhiaFJBTHhEZlQ4?=
 =?utf-8?B?U0xoY084dDY5VHk5OUtCRXpNWThvdklvdG1SanhubUl3a0w3QTcxQ3BzRUJx?=
 =?utf-8?B?RGM5K296WDRwOFRmcWRKQ1dVbTFETVJ6UUEvcEFTUU1ENW1YZEpOL2VLRE96?=
 =?utf-8?B?WkJhM1JnMWh4dWl3b1ZraFFmWEJ6V0pRbUhaNWUrWWtkdHpyamNkd3FrTEo5?=
 =?utf-8?B?dEFBWDhtTkRXSE1CWE4vTldLdE0rdG0zZk4rdGNEWmVsYWNOaGdlTFVyU1cv?=
 =?utf-8?B?NHRsUUUweFc4SVp2WU4yZUxaaFo5SzloenFCK3RrdFZ1UVRLUXhxbk1iblZH?=
 =?utf-8?B?NGVIVGRQVUVJSlYzUEJ3Rko4aFpDTmNRc2lOb1lRTVlCWnRVUUl0Mk5MQ29j?=
 =?utf-8?B?eVNuTktDbEhsWWRoaXF6b1JzM1hZWlZyMDQ3bVVaRnhXQW1aWTJvVGNzOSs1?=
 =?utf-8?B?dDE4WHpJdmY1RE1lYTN0S0xyV09jTWZ6Rk1KNG5qek5LK1IrSGQ3QWdFbTFo?=
 =?utf-8?B?c2M1Wm1lV3M4NUJNTDdrUFUveFJ6SU1PTHQxTFRLMzVGRTdBZWh4d0VSbzlh?=
 =?utf-8?B?c1ZGUTZiandyRFlwMy83R3B5T3dxUTQ1OVR5Vm1OVFlHTTIyS1hxa1FvOUU0?=
 =?utf-8?B?M05wQ0JhakFibTdKam5JaGx2MmJCblhMYVJTRnVabEwrRkk5TGQvbVdwRHlK?=
 =?utf-8?B?Yys4ZTRSWlNnNkxmTGRuektxWVlzVlFpQ1NDQUpoRU9sSERRMDRFVFpyM3pO?=
 =?utf-8?B?aVF5K3JLZmhiQkwwa0hsSXlqR1c4eVdFZUpWQTBVMnBiZ0J0QjJNOHBibVBl?=
 =?utf-8?B?alRQbFJJNlFKSVhSbTFmRjZFMWVIb3crdEt0RmR4Q0Q3YzBmWTMyQ1hxK2pF?=
 =?utf-8?B?OEVHbUJ5S3h6K3RXeDI1ejlLMFV3TjVQelFRZFRtM1ZIUDFpdFp3aitjeGpM?=
 =?utf-8?B?dXd5WTlQMUNwWTVkSkY5T2YzbU1NaWJyeDV3Z1dvTVVKZDVIVTk0RGhHQWJm?=
 =?utf-8?B?VG5qVE5xVmVxZldOSjB0dFREdDhXYnUwRmZDUkxwSjI0elVyVGc2QkVqTDlE?=
 =?utf-8?B?TFAzYjBtQVhHZWVZRk8wZEo0Y0tlVXBtdUs5cGR2c3pGd2NnZmN3Ym9ZaU9L?=
 =?utf-8?Q?er4T+Eh5Adho0uUCJgXd9xcBi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a433eefb-3742-4fde-6785-08dcd8f6fe1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 22:04:11.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnQlMB0pO35G2L7K+t095RhmL8kKLAEVhnb3rhJWsfXmrKmnFHwwtRxDNSND2QDPOlZgX6hCULJbtzEoNitGjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849

Some systems (such as i.MX8QXP) have different CPU and PCI addresses,
requiring address translation. If 'addr_space' is missing, retrieve the
address translation information from the 'ranges' property in the device
tree. This allows support for systems where CPU and PCI addresses differ
without relying solely on 'addr_space'.

Update the driver to use 'ranges' from the device tree when 'addr_space' is
not provided, keeping compatibility with existed systems.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index feac1a435f764..1b013d2fe694a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -294,7 +294,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.cpu_addr = addr;
+	atu.cpu_addr = addr + ep->range.bus_addr - ep->range.cpu_addr;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
@@ -861,6 +861,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	struct of_pci_range_parser parser;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -869,11 +870,21 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
-	if (!res)
-		return -EINVAL;
+	if (!res) {
+		ret = of_pci_range_parser_init(&parser, np);
+		if (ret)
+			return ret;
+
+		for_each_of_pci_range(&parser, &ep->range)
+			if ((ep->range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM)
+				break;
 
-	ep->range.cpu_addr = ep->range.pci_addr = res->start;
-	ep->range.size = resource_size(res);
+		if (!ep->range.size)
+			return -EINVAL;
+	} else {
+		ep->range.cpu_addr = ep->range.bus_addr = res->start;
+		ep->range.size = resource_size(res);
+	}
 
 	if (ep->ops->pre_init)
 		ep->ops->pre_init(ep);

-- 
2.34.1


