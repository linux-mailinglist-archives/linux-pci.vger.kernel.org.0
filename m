Return-Path: <linux-pci+bounces-15245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40F89AF3EB
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 22:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84033282F7A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FAD2185BC;
	Thu, 24 Oct 2024 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OTmoVbSS"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2053.outbound.protection.outlook.com [40.107.241.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C92185A0;
	Thu, 24 Oct 2024 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802562; cv=fail; b=ZumEclf1sypJHZyiL4v2/i2uq8dN3pJDi8XSwm/uWr9E5LFWD6UESdjIOyxAmCIivVXfTqo8sec/utxkcgFlqayyycQM+Iw0A6WZ2722Xb2z5+0Mcddnh8bVYGI9iKRsE0z2hUfrh0E/VY+JC57zaykKHZ5M9p4JLbyVbtOWaIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802562; c=relaxed/simple;
	bh=i4d7sd3yQU/0Cg6+DkY2bKY+7qcWwb5wLX8OMJ1co/w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aABoXAM9zR6ryyXFTYzwr2ZAaYBVdAq52bVfzUiQ+REkDElMovFLljGvPtB+b1srmoHzV5rDTRySfJpjRxCx4kGak9VmoRKRdDMhp1FKTjIVpvUsHMTEA1dDx3AbeofUR5INe59MsQM7gAznGPBhq9+e5REsU4gNVfmp/so434s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OTmoVbSS; arc=fail smtp.client-ip=40.107.241.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gifn+qoJuVMTh8ayl2p8U9HO9/sgBTlQbOHDco33+GrLkSSXZ2DkkE0fUVuZxqjiav+I9/MEpBiJ8rui2CgebUyX++VR1fo13AJcnOyJdjMBQilN2JfqC6cRdr8XA55d4MBtSpEHm8ArWHNbP6QEEGcIxc2HuZsNdxCLb8BHUTjqOPeBAbN4RXeqY9h4+AEDiUzflTQdovtknAz2JiH9mus0QsMOvMKBgaMBm77lLzCOMbiVy2Ng7TjMEBD+a2cpteDD/dpwr8dGmDzuGSzgeoUEZ/l/oNTwOvHte8wlw51BXBZQF9QXXS6h4T+OnyxNBD5yv/D2Y5jpdubyceTfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Aii/uNy6ZXcLmek1tL8aJJUKXUMsseRVTsqG7jcHas=;
 b=ZOeoSSMPQ5Sot6qOL8kJ6EJCJ+koRkhXI/gwjy3KAGsEwJGg7BPDxAq2U3IsE6o5d+TNztsFGRMSW65DUHKERTENRJm6mI5Pk4DrC9WDufe0OHNbCuwv9BFbkSVqVJgNyTKRNCMoqdhOIAc3d4h3MyXEV+g7JrqGgI8Vm+MotLvCBmtoL8Gr9RmPrawipsJkd3u6LoJgyCuE5TXCsA1YOWUPvP0WKw3qYHrs74mAl7ORYqtrbdRw9Z0rekO9pgZ5VNyZ8RWf+T8xnSKoNds+lDyunU4QvLIt6U5ySoIdB7MGazEp/N/cqiNV0+haf2eCYYaY18jPF4jA/5dvuMv5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Aii/uNy6ZXcLmek1tL8aJJUKXUMsseRVTsqG7jcHas=;
 b=OTmoVbSSQH09c/0KQycUIjriY/RkD2LpQlhKUElrI80UenfQkamrMbtuFD3DyAD4TyiojImkmgCLOVMYYr3ulA5Yn2Fs00vZwex8o0K4786GuRtdi+l7tfT3kJbRi5rKApnf/MgfQM9qrLwosET3aYkXbZfkgVbl79QF+6kzq8LanAl4Olk6G5uFro4xB8kWXMITGh0w/2oVwWouMP2T4Yg9DyXK27lIuDcw5VuUKm7aoGgj2PUJjzFVTwmIBLWZb6b1vEGrBruF2HF/iNbStHYjVFBhZtUjQTqHzLx+wswArOFm2u5A+rxs0NT3IdNFur1/NT4NXDcdxsoWKkWCQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 20:42:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Thu, 24 Oct 2024
 20:42:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 24 Oct 2024 16:41:46 -0400
Subject: [PATCH v4 4/4] PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-pcie_ep_range-v4-4-08f8dcd4e481@nxp.com>
References: <20241024-pcie_ep_range-v4-0-08f8dcd4e481@nxp.com>
In-Reply-To: <20241024-pcie_ep_range-v4-0-08f8dcd4e481@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729802524; l=2809;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=i4d7sd3yQU/0Cg6+DkY2bKY+7qcWwb5wLX8OMJ1co/w=;
 b=n/QBCb8gXv8fK+/RmW+tOA/Iv/5x6pK3TBnUbHuZgoyU3+BeQJf9sj7HTQfn8cvvfG4OSPbKX
 zPGv/lkpaGqCBe1sMS9bPhdGGVVCWnubxf1Z1Fmui94v4KieIR/ZlRL
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a75c20d-9326-4e58-30d1-08dcf46c645d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkF3bWpmL2Q1SlIzakRDZ0gwd3BuSk1hWTBSeHIyZnJkT2o5ZlpDZ1lBRzRo?=
 =?utf-8?B?NU96a3dVSUwvazlrc1FqTGdZWTZIVXIyd1hOcG15YUpwWWo4MDFGRzViZEJQ?=
 =?utf-8?B?OTBLRTVxT3VOcGt6SGNYSXpuRjVRMElyMSt5Y3JVT0tXcU95R1FxaTFzc2ls?=
 =?utf-8?B?RTlvancyaFlOMlhXT0ZPMXVnMWpoTDlZcVQvWDZaZWs0S0VtSkF1SDFlSmxP?=
 =?utf-8?B?VEhKWlJaNUNYZjVjK0FXQ2hHQWhlbHZ4VWdEZkFqN3BpcWhPVldJeHBCM3VG?=
 =?utf-8?B?NCtKQ1h2Z3FsOUkxU3lweDVwcGNsbG1SWWV2V0xuL1JTS09oeEhFVHVXNzYx?=
 =?utf-8?B?eXN6OFZsM3NKeTl4NVlZcVhFclhxVnJXZEprUk9DalFKQ3lKanFDQXBqdTJz?=
 =?utf-8?B?bXE1cGgzVllVTk5xQjQvYk1KTWdhcXFnb0tzQy9kVkpvamFhMHVGNjV1ZlBC?=
 =?utf-8?B?YlRCVjlLVGZlQXVZNG5YaWRNN0xuMDV3V0NYSmFzRFcrOTFwZUk2bmxxcVBD?=
 =?utf-8?B?K1pYaUIzdmluVkRvcjM5QmhnK0R5ZVFpYk5xSkEwK0VUbC9UVEg0R1Bhczhv?=
 =?utf-8?B?c2ppaHYybFg4b25FeU1qOFRvbUs1akFLekpNaTFsTjIrMUljVnNhbnE1cjZR?=
 =?utf-8?B?TWR5bUxIZTF3dmtiL2Jta2pyM1FoMGdXWHNXeUlPQ1REM2NMTjlOWGx0NUNh?=
 =?utf-8?B?bVliTzdVQ0FpN1QzQ0JWMVlEWlhFZGhhWExMQ09kWnFVSFVTdnNna0swdGZE?=
 =?utf-8?B?ZHVYbUxOODZ1em1qbS9JSUlnckZmMGc0VkYvMFVMTkV5bGpsKzN2UkFhSXNR?=
 =?utf-8?B?cThKaDh6QmdLZzFQbVQ1ZzJySFRqMTRQb09XZXBjMUpMUG1pYkRaM3c3RFJZ?=
 =?utf-8?B?Zi9SUGpuQkc5U0U1OFNDRk40dEtHVmVKczRCN1lIcjUxbGhNZmFSNGRFWjUv?=
 =?utf-8?B?dldxaFlPTXJkajZmLzB2Z21SRFFwRmxkL2N5YzFDQnlRSjFGUTdUVWg2aGJ1?=
 =?utf-8?B?SGE0Ty9OQWU4eGRxYTNKYmNKVjlINEY5TUZ4SUxFS0JXN2hrZisvUmlSWUdS?=
 =?utf-8?B?U3U2SjZmZkpqbUlORVUySW5QbXY1RE0raXEyZTh0UkM5U29CN2o4Rlp2bDli?=
 =?utf-8?B?THY5elFiUnFTM2k1V0hFM2g1RG1pQWRabE82cjV4NFlKcEFOWGRRS2hZRFhC?=
 =?utf-8?B?NlVhSUF2QlBhOUpJV01HOGloVkJnQlh4K0dhd2dlcUZGcGc2M3MySU93dW5O?=
 =?utf-8?B?cThOQ0xISktpeWNzNUNZSkd0QmdWMWtpUVJneVB5d2J6OHZXRldNQzhtVFhJ?=
 =?utf-8?B?N3cyOGh0MG00WGllOUdlOEVMeTNUbG9xSFhYeCt1ZjQ0Sk5TWGJrQ0kwbGQ3?=
 =?utf-8?B?Z2loTWJreisvaWhHVHhLZGlGYXl4a05ZQk1jZ1JzdDE1VEFGUFZCYlB0OXY1?=
 =?utf-8?B?OUErWEhvbUdwd2pTZmpzbXk1QkNYaHFaZ09rMGtuc0tjZFNSNkxJMDJQek1G?=
 =?utf-8?B?MEFDMmdYaWdlTkdvNjE1VTFjM09jbHB6Y0h2NkhYZzFmbzJXV1R6eXh1OVJa?=
 =?utf-8?B?V1E1eFZENjh0cXhCL1ZhZGdXUW1XQkRkSDBsanNlY21Rb2ZWeGRhTFQvKzFB?=
 =?utf-8?B?VWRNQ00yS0EvTWdwNlVvRHltcDdrMWlBZFBSeXBOTGRocVgzMExSOXluVUNB?=
 =?utf-8?B?ZjZBaVpZcVp2WnJmSmUrUWMveitPQkdpdG5RR0JsQTcyZzB0bW1WdUVBZU8v?=
 =?utf-8?B?cHM4NmlvSHNPZjFOa3ZsMHYvVTNBTkxaODV5WVNyT3YvbThnb3lxQkl4QmtB?=
 =?utf-8?B?aW92WWtKMjJwSWhxZzZQUEZYU0tkV0pPZXRCL2dkUGZDK0xWd1FKeWpjcytx?=
 =?utf-8?Q?Tj1sDirOs6YVt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3ZYWXFGR3hoWlVyTXJ1Slc3K3NVYlJuRDM5OHZqTC9ZTjVQY2hrLzhVb2R5?=
 =?utf-8?B?S2FBZXpEd1AwdGducFZjTzM5YzZJQTQ5WHNHMWhnOFFEMzVqT3FsY055cWhC?=
 =?utf-8?B?NTF3cFNMeWEzMUIyYkFqRDRtN053bzNRbEJyZzY2NjRxNjI2RGVGSnVkRVAy?=
 =?utf-8?B?WjFFeUhVOHdvRlA4Wklzc3RwS3dMZmpVRVZoUElPR2RwV1Z4WGZxck8vdVcy?=
 =?utf-8?B?Q21iVWh5emJNd1NENlBpc1Q4U01kczBpSDltRHJjc0UzRmlqTTdSMnl2bXJL?=
 =?utf-8?B?RTV1a3FQNWRGV05aZXJLclNlSFpORnh2bmkxdXQ2ZklQdU5kc1J6WHlEbDhi?=
 =?utf-8?B?WkxMOGo4Y21ndmEvZUJMdWw2NkpmUDZoSVlTZElmYm9FSFozejNvTndLWTZ4?=
 =?utf-8?B?MkJPZEVjdVdJRGhvR2xzd1BHMEhpMkZRbzdBZ042MlRwTUZ6b1l1NjNyYTFm?=
 =?utf-8?B?ak9laytndGI5TnRvS1NJaHdiUUxDNk04UEFTQnluYnFPemYvZXplRDhwWVVl?=
 =?utf-8?B?a1BDZlRTWWtJSW9KTm9QenBOZHp2N2pad0hUTm9IcmtWSGIyU3N4S09hbFNn?=
 =?utf-8?B?RzhIRjgyUDFHNmZEbDB1YUt5L3I1V1U1dFExMjBjeFpNNVpQYWREOUt2bGZa?=
 =?utf-8?B?SWNSbTlGbXVZQVB5L3lBa1VDZjRRSzgvS2s5YU52RnQwUloyRVg1d3A2N2dD?=
 =?utf-8?B?ZFNzUS8vU056NHNuTlJJUUFKWkphQjBYZ2hFU0w1cFNJYTFnZjlYZ3Z1Z3d4?=
 =?utf-8?B?QnVwQlpPQ0tJYW1wMWhjejNpMGhBNnlzYmZXNHNKSkxyblRsMUdraUxPVjBo?=
 =?utf-8?B?c2NsVEs0cHBCcDNubkUydHh1c1oyZVpKV1ZOU1ZsYlpRRnY0MWlsdU9QSzVN?=
 =?utf-8?B?SitsWkFhNmQwYkt4eW4ycXZBY0pQeGVSSmN6cDhLamNwcnRFY2Rsb2FGUkx0?=
 =?utf-8?B?MndhR1FUUVBSNGp2eU5ZNFhNMnVCc20xYzB2eTl0YWtvUTc1czlVcFcycG9K?=
 =?utf-8?B?bmhtZWQ2aldCS2ExRm1RV2NPd0Y3dmdTN1hKV0ROaC8rUS9sQ2grUE5sZC8w?=
 =?utf-8?B?RkYxM25qSjNHYkwxNHlFUmxQcFVOK0dnRHljZjJ2b2ZaTEVGVWVzMVlrdE14?=
 =?utf-8?B?OENFbkx4MDU5YjhldDZVdGtiRndvYk93LzZmbkwvay9MQS9CQ0lNZXVhZVJx?=
 =?utf-8?B?ZU40M1d6cHVNNnlRS2MvQWdtOUxrMUQrV1RZaTM3M3NoQjR3ZDdZQjg2MXg5?=
 =?utf-8?B?Y3BzWUc1VnA4eDlNam1Ic1psRVh0UEc2cFNnMjF0UVdoTUJmc2tvM0VUV0l1?=
 =?utf-8?B?VmtVWks0OGIxNjFzMEd6dG4yZk5jbTRjSWZKcHF2Qi82Tks4Z0Qxb1kyQUVh?=
 =?utf-8?B?NXd1dWVVUE9iaUw0b0hyZ3Y3djY4Zmlydk5UWUhWcFpRLzE1UU1LOVM5UU00?=
 =?utf-8?B?RWREbEY2ZUMyeHNVVEJaMkhPNk1qaG5LdlV0c01nNkQ3SjVxVGg1c0lFaGh2?=
 =?utf-8?B?a3FsajF1Mmk1OWdQUHRRZ3NMZEQrQ0h6dUEvT2RLajBqWlBZUGViUTNpS1NJ?=
 =?utf-8?B?eWN1K3A4TlAya1RTK1NlT1ErZ1d1eGZBOXZkaDJDU0IxcVhabTBqK0F3Z2gr?=
 =?utf-8?B?cjY4bkdOeVd1b3FQUmVkQ3hQSHBIS21xQ0dwVE92a2pNTjZlSzVZbGVGa3Jy?=
 =?utf-8?B?N2RqaW1JUWh2Qm55cWZIaGVnazY4cU9Ycm5NWEk0TEQ2SnpBaWdRWXJSRTdq?=
 =?utf-8?B?ejVKMjJpZllNc3lOV0hIdWgwS2dSWXFuTWJoMENDTmJmZWU0V1R3ZTZBeU93?=
 =?utf-8?B?dTFTMUZFTk84d0s1dnJFM0NtNUNhbXdhSnRwUGVrYmo2aWxFc1FEMW11SmRn?=
 =?utf-8?B?M2ZFcUdlQkpnWERlU1dBcWczSEJLL040OVlCK1gyNTJYdjNlUzRucEwzSU9D?=
 =?utf-8?B?OFhNL1Jlc0VPY0tPL200cjNjNHBLdU5mWnlhVlVvKzUxSlREaGZ3d0lXSEpY?=
 =?utf-8?B?QWo4YVE2bVR0UU9La09hdUlyVnJGajNQVENhVWM0WDBrRnZ0SU5PZ3EwWUF1?=
 =?utf-8?B?MkRBaTdxK3g2U042RkQ2bmRlVmJqYWxiWE9LWG5YWE1SQWRQemYyQUJWdU43?=
 =?utf-8?Q?9RCGnZl3oLKF2ebp4EyB27va1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a75c20d-9326-4e58-30d1-08dcf46c645d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 20:42:35.8805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suGZ4zzq1NFUkGXoBoOx8sBQM8VckFKgsFmhawgacTE0GXfatWzmDmkLXQuHAjBlwXU3MGqCTdoj4GKbe/cqPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8223

Add support for i.MX8Q series (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe
Endpoint (EP). On i.MX8Q platforms, the PCI bus addresses differ from the
CPU addresses. The DesignWare (DWC) driver already handles this in the
common code.

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v3 to v4
- none
change from v2 to v3
- add Mani's review tag
- Add pci->using_dtbus_info = true;
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bdc2b372e6c13..5be9bac6206a7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -70,6 +70,7 @@ enum imx_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX8Q_EP,
 	IMX95_EP,
 };
 
@@ -1079,6 +1080,16 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.align = SZ_64K,
 };
 
+static const struct pci_epc_features imx8q_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.align = SZ_64K,
+};
+
 /*
  * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
  * ================================================================================================
@@ -1448,6 +1459,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->using_dtbus_info = true;
+
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
@@ -1645,6 +1658,14 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.epc_features = &imx8m_pcie_epc_features,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
+	[IMX8Q_EP] = {
+		.variant = IMX8Q_EP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
+		.mode = DW_PCIE_EP_TYPE,
+		.epc_features = &imx8q_pcie_epc_features,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
@@ -1674,6 +1695,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx8q-pcie-ep", .data = &drvdata[IMX8Q_EP], },
 	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };

-- 
2.34.1


