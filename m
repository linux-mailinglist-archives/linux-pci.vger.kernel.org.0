Return-Path: <linux-pci+bounces-16582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EFB9C5F6D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B64282708
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AAE214406;
	Tue, 12 Nov 2024 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d4KnvO/v"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A482141A6;
	Tue, 12 Nov 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433721; cv=fail; b=pdHJ54gK8IxruELV2nPvEPpzp+NA7Ttk6oE89QoPw2f8gsYkeI+8+rC9nbKWBhqOJ/8r5LsKHSrc0OJPdGTml4x0ZHQOiVYE5GL149S8gGFa+TIloRKtVpJJvZeg3GdSWuGaORv0ulB44plBDYtu620zM4QZF1AIkOacxT0klVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433721; c=relaxed/simple;
	bh=s7YA9k95gePGlrukCgg8t7xSR4rhzh9vJYZCUX7nc+8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Qde9Reeqeg8O7Bf3LjnjQMFlz0JrsdQzT047dme1qjmJj8ymtzko1LxwwdZv7E6+dopZc1ucpp2yQ8rnKdrayNB1YiFb06W5or6yd8gFQsz4uIOvKTupH29jwU4dZPnUZfMuDboaDbUbjXX41zxDbB39bpdFPjLcYgSYfqCwXJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d4KnvO/v; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuyrGUhsTcLaei//4aIhJGWD8va6dh4/9Ta1maT+nWEBss4TyOQq0sKUa9xoFpLSwTX6QcTCfuaFNC9GxnZUlXuEIPQwN9JzxDnSdQVa9cstjHs8Y6kl2UV4j5yV4RpEqEz7P97TfPZZIlW6rqSgY+qK66/BxC7Z9yCcywfSxRh+VvOa3jFALuv+YU+TV7Q7jZopf85PDoS6IHsdQB+g7ER5bifqpuyTXCjZTTOW3D99hdenkMv2JrHopys05IUBL9aVM0P2V+aM6eSA1GjkpbeMW7wVBaInEQ/YZtn2XQ7xX2Mb5rZRmjPm4XvpgWV01+H+nrHi68di6joS7rsUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWIv2PzhaS+Jt/HY1K+wJQOwISmpbW/M7FrtGt+j5P4=;
 b=mfXbtl+NqpI3hxIcnK0GBYoVMOZOlYf7f4JvDtPAirIfnFtrfBboKQsh096WD77R9bMBurRoHlB2FQAUwomgrX8ETKoHxD7KQ8dCKi+PPqCp4MNwvBigDFxIAfHN3UZmvuDsbbKu3GO06O2Y/rENt4vGMYmhBY75OfRbovuhA3opcn+5jtaLpTGhxx1BDtdRYGTjhckYw8fYeGBYhGgDIfZwRcA14qVWU6rbSlqzZDHP9Rj2ftI/bmCnQ96GNVdJO4l450nXrxwKxvF4u8hqoGZsH8Bc7GLRg+fg8LI67+CCpG0Rh0ElN+V8ViS+/juFltQdAca/WTWTXK2r+zIRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWIv2PzhaS+Jt/HY1K+wJQOwISmpbW/M7FrtGt+j5P4=;
 b=d4KnvO/vh5B3gL4mDHXf+KERhBh381RtR6m/M6YRmjJ0RtZAKeYDKQ53bUADHxQUUC4SR32FHE/uuCB6wWwcZU5WJywqV7x2mnmgowHCz9bIoy64RwnfawPfQo6KGZ+LJsI6hWriF4ebouMvk5W/nwRVxx9zCpV7vwsK+42cBPuGvQ2/kaJAodJm03oY/7rDRwOi0iqYLVYaDMbWSaKB7Gjik3X7d/U5xZWLJLDl1/TJpTRyLQocNSe/aDc4PARNhi0g1nkaPIqmwfJb0z5G14COW62o/Gxe2czMHgm//gJO+xnkL3TI9ze/kOFurqg3z5BX4CUUOTYY/0k159SxuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 17:48:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:48:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 0/5] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Tue, 12 Nov 2024 12:48:13 -0500
Message-Id: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN2UM2cC/1XMSw6CMBSF4a2Qjq3p7QNaR+7DOOhL6UAgrWkwh
 L1bSAAdnpv7/RNKPgaf0KWaUPQ5pNB3ZdSnCtlWd0+PgysbUUI5ECDYD/iVApaGW20YM2A8Ks9
 D9I8wrqHbvew2pHcfP2s3s+W6JcSWyAwTbL2zUmmoLehrNw5n27/QEsj8BzHYES+ogcZp6pQyV
 P4jcSAgckeiIA1cCbDEEdIcaJ7nL32uBOAEAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731433711; l=6467;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=s7YA9k95gePGlrukCgg8t7xSR4rhzh9vJYZCUX7nc+8=;
 b=cKELdhYPRgdy7l1CrZ0GGqbiKBhl82po+E7jkmWzhLSMR5hjTgcNIAlaDBeHCSHyNhCib4pKY
 j70meHwH+AKCwrLdZ7JPuiSOhQgca1IVPjoil/tT3vUTNeGoXve2OGR
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
X-MS-Office365-Filtering-Correlation-Id: 67493726-9531-4503-cfc3-08dd03423b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXo1czd0U0JWZ284UW9SSWRoeW5hRVMzV1BkaUM3V3dQYW9DR0ltaUNMTWNp?=
 =?utf-8?B?ZUVjalYvTEkxSG9YSUhkUDdmdHo2aGIyMVNRQkRDWXZwWnN4QjZnT2FBdWtK?=
 =?utf-8?B?MnpycnRwWEFHcXR1UW5heTg3MlpjSnVHZTRtYW5uSUZoMDRoaVlrcHhsaGl3?=
 =?utf-8?B?K2pxTXVMampBWGZ6aGIrT1dFR1JDMStxdnZTbnBBUnZGYkZrWndrMGNKV1Vx?=
 =?utf-8?B?anRuSTVvWXg1YUYrd0NzSEZhdWNRc2dmN1NISEEyR0VRZGpoSFZLMmRiN1U1?=
 =?utf-8?B?dFFiOHNsYjAyaVZxMzZwdEZTbFR0Y2Y5cmtTQjkrMHBZMWVORlBXOW9yQWYw?=
 =?utf-8?B?bUg5WWpoZnpZbEJ6SlVna29nU08yeWsxUHBmbnlzSG9VUDkxc2IvbzMxVjlx?=
 =?utf-8?B?V3BhZkkvV2VRbTcyNUV6N3E2QnI3MkJkL2p0TWNaZG9GMHVnMzhYbWVxZHJT?=
 =?utf-8?B?ZzQ4Nm9HSHBPdFh4SGtVUWFFV1ZscFlMemxYMXYxa2VCQ080QW02THRlVHM4?=
 =?utf-8?B?b1kvZFd6L21TR1k3Q21NbG1mbkhEUzRMNU9yYVN1KytsTXo4U01XQit4OFdq?=
 =?utf-8?B?ZU5VdE9zcHcza0NSRG5YbFNXZ3BtczcyQTJqZnJEeHpMUVRIbkFBR3dLeWNp?=
 =?utf-8?B?ME82dHRBcTJOdHdLeS84N2FYRXNvUHRRS1AzbFQ0Mll2ak11TXN6cmFPQmhJ?=
 =?utf-8?B?MmpTVnpoeGJNY1p4c0dnQUEybjZ0SjhlMGpnOERDWnNyalFlY3Bxa1VFYjd2?=
 =?utf-8?B?Q2NsdVhvb2k2L1NOazdqeXUxdFFPbHFPb1Q0ZFF2ckgxclI5UkVQQXU5bjRw?=
 =?utf-8?B?djArSUFydFRnRnFXaTB1WlhmeldKd0ZmNEdoc3ZONGpHY21aQWY5VVlCYjZm?=
 =?utf-8?B?WE41VHo1WG5UTnkyYXV1TytkNUdJdU1kNHBMeXNmWG4xK3IxenRxdXV4TGxo?=
 =?utf-8?B?R0J3ZGpuMFd4eEpTNDVBYWZGM1p5d0NnSlRnc1ZXK1duUHBValRuc2dVdHl5?=
 =?utf-8?B?N2FkMjE4MHUyS1dldHNhb1BaOWwvTlIzTmpDMFRWOU4zUGExN3ZWZ0hpZTBH?=
 =?utf-8?B?dlJjeHNvVnBqQy96SlR6cUtraUdYUkRTWGp3dVNDYmhmS1lTT0RCR2RBNVl2?=
 =?utf-8?B?NW05c2VXNXprSW12bFBVRHJqSVNaaC9Zb3h2VDU4Q1dGSGlnQW82dWFhRkVV?=
 =?utf-8?B?Rnpqa2cxeG1IT2h1N2E2L01VdENKZlJIcjI5K3BGNk0weFFYK3dnUDZOVHRN?=
 =?utf-8?B?bDVHeXhMM0JYeHl1NUJyTHdVdFU0eFdXQTlLQjQyWGFMbUZtdzVZZ1RIbTFa?=
 =?utf-8?B?S0lhK0FIalJ3M0hLNVI5L0tCM0g0VjBvaXVCQzE1aWh6YWRDYUFDYTMzczBP?=
 =?utf-8?B?d3Z2VEgyc1pCemlZK3NMMDZnYVlhVlpSMkt0VFd3UWFyblhscmFyYWZPZDl3?=
 =?utf-8?B?UDdiWjBaSmwvOVlLUWJYbTd6eGkyU1J5ZHptTU1RcXpZWHJ3WWs4WmQ4ek1a?=
 =?utf-8?B?Y2ZiZDdFOXpnVlJqcGVLM1UwUnE0YWxmK2k2a2dSRVpLcmc2UkFYellta29h?=
 =?utf-8?B?MUVMR1ZvWDVZUDBpci80V2ErMjJrU1NVdHdwbE9HNm1UMlQzS0ZtM1lraTNh?=
 =?utf-8?B?Uyt2OWpNRHlKTmpDd0lWQUJ5UjZVMW9QT281Zkd5OE9Xa2VrSkl3Sng5T0hM?=
 =?utf-8?B?cEhPTEU2bTVMcUUwcTRMSHFTWGZXU0dMUXd1MXlFZ1ROUVJmYzBEQlkzZkVF?=
 =?utf-8?B?NHBBcTRzU3NaYm90QWxCL2I5TTRZTWpzRHhiQnpyeEVRai9vaU5ja2pwYzE3?=
 =?utf-8?B?RzBLNllhUzFpbUtNeElVbWt2L2Z3L1F3Ky9lSC9LUUdTZzl4enEvRnE0anh5?=
 =?utf-8?Q?nh1qpqi1pRfyC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGFEVmJ1NVJZZHJ1c3FNSlJzd2s0UE1xWnRVOW5nN2VrQTVCa1p6WXQxUzFS?=
 =?utf-8?B?RmJjSVIzM3ZYbEh3WWdZWTZGUzF3YzhXNEczZndvejZXNlFOeVVTdXJsSVJt?=
 =?utf-8?B?UTZQV3lHZE95WEhSbUpxN0tBaXRRUDg1dzc3RFQ0cmFXbmltWC84QnV2TmNV?=
 =?utf-8?B?OFNVR2ZlTU5Id2grSnEva0VQSFpRR04yS1FqRGZEQ2IyeXphN2srcWNFOWJt?=
 =?utf-8?B?MEo4SHFzaGVZaDVkS2tBK1VGdDQ0TTNVeURJVHhjUHV3RkhXNmh0ZC9QWFlJ?=
 =?utf-8?B?VzRjOHRnR0ttRTFUTTN1eU92Ly82MFdORGFNZ2ZqTFl6WjJNUDY1YzM4MVVF?=
 =?utf-8?B?M05mc3owOHNVTlpDNHBITHJOTTk1YUlNRVhhRjR4WFEzbFNoNDRONENzZzJ0?=
 =?utf-8?B?VTRCMUliZlV1OHQ1dFRzbWxoYVVXSnRRbUxsdVo4ZCtuS0wvR1lIZ0lxR0Fx?=
 =?utf-8?B?ZEFMTWhxTjYza21DcWJhZ0hJWXFyQi9ObkNzZnFiUi83cGEvN09IOCtob0F0?=
 =?utf-8?B?ckNielBsb3FGbjdTaEVmeWVGQjNNWm43UnNUOXc3bWN0b3dLcXg3QnpaRWRj?=
 =?utf-8?B?YU9JYlptVnhsdEo0cmFDNy9RWWY1bHBFNFJCbnUyM3hpQjJYQ242N2l3YVJE?=
 =?utf-8?B?NlFCSitFSzc5anIyMzZhUU9NYnNCV3FNOFpkTGFSZHBMdkZrc1ZET0grU0FV?=
 =?utf-8?B?eWd4QUlXUHc0bnJpaWExeUNiRFh0dk9NOStEUUdvY0RuaDdTcGl4RUVLeG9F?=
 =?utf-8?B?a0xXdHl1eFlsaERUVFphb2MvQmFlOGN0aHlVN0oycEM1bjFvK2JaRkpvejky?=
 =?utf-8?B?QXFVVFp0MExqelh4OEwyUnd4dHQra3dUcFQyVnZhUG1UbE1tUW5aNkRxZVNR?=
 =?utf-8?B?cVhFUUt4UEZielRnVWNqR3lGTFdDRWFaMndOMEoreUp4dGdXNUxIV3VrVTFQ?=
 =?utf-8?B?SEFKOXhoTGVCcGFhM3JXNCtzbFgwR1BXaXlEbkFjTFAwMVJhNm8xVnRUVi9Z?=
 =?utf-8?B?d0MyMHZhbExwemlGSTM4dWJDazhDdGx3akkzekwwZkZNK3dZYlVDQ0RUWEUy?=
 =?utf-8?B?RW82dGw0dVhXWkorSFRJU3V1QkEzN3o3bG1rMlROOHJxSnFWMExFbTRLeUFO?=
 =?utf-8?B?MTRtQTM4OWU1K3kvektnczlOcldXSGRJN2FhaGxUUUpERXNCR1NBYVE4S2Fh?=
 =?utf-8?B?MkdseGdUM1BiOVN1MUdJSUNlVEx0empLdml6dVc5d0IzVEw0MU5ncHZsTVhq?=
 =?utf-8?B?d2EvaDltMHVHV0l1S2NJM3hCNXFNV2FmcHp5cExJZDA3Rlh2MjYraE1oZlVJ?=
 =?utf-8?B?bnRaRnZRcTBpQnc5cnlqT1FWSXp6b3Z0TGc3NUpxSjdjZklGckZCZ3ozcWxi?=
 =?utf-8?B?UnI3NzBNNUJvb3dPVm9sOXBYbTdnMUZEY3lxbEZZL0p3T1VqaTNKenEwVDVI?=
 =?utf-8?B?d0VyVDFyUTZWMUszNFhMVDdSRURUeUlDTzlYajRvT0RoSSsyYVErWm5sOGdO?=
 =?utf-8?B?YXlUWm1Ra0d3dkt3Skg1ODlaQjhGOFpGaVBPaFdPRDVFNmJpanVxT0VSQnJo?=
 =?utf-8?B?UGp5aWRjcytxU1YyQVM2VmtMUWdWZTMyVkV1Q0k5R1kwUzJvWVRWNlFLQjNj?=
 =?utf-8?B?WGh4RzZkclgzRjd2akxmd2pZYjZkSWwvcERsMXRPTW5kSm5mRVhiR2tSYXg3?=
 =?utf-8?B?WlZXVzdvUE4rOGNlQVFPMEJXekpoVjR2QWRaUWQ3RXUrTHg3QmxqaXVoKzhW?=
 =?utf-8?B?U05SUnpucThCQzRTZnhtVTlaNFhsMWRkNjUybUQxNjIyVHFUbGpTcnVydU5V?=
 =?utf-8?B?Vno1Z0hVSUpBY3doUERRdnJGbmEyK1Z4dDlVL0VZa21nNEp4RW4zRHo4bWRl?=
 =?utf-8?B?WnVCckdIdExSKzFMV2xJOVJvd3VkcWhFTjJ6RE5zK0VnVDdoa1RWTzRlSGh1?=
 =?utf-8?B?ZXJlRWcvaXAvVGczeHAva1l6aGNpb0E5a05wMnFHM1ptekVlNW0yQTdkd1JP?=
 =?utf-8?B?WmVNeHZud2VraFRMNGRGUFZSTFB0TGhXZmorUVRDbTUvakF0Y3lqYUhxVGdB?=
 =?utf-8?B?QXdwUXNzbUJ2UGlUMGNEbFlpek5EVWNBekNOaE9BUENzTTBnYXBPeGVjQVU5?=
 =?utf-8?Q?xZGA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67493726-9531-4503-cfc3-08dd03423b4a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:48:35.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BilsbOo9RD6uOPquw8akEE8YM8LV5d+V3UdBpMxwU/cEVzBTi3GI8d5Q3NmyLLVwa1tOaN+MbpixkgUiDbuDmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: Niklas Cassel <cassel@kernel.org>
Cc: cassel@kernel.org
Cc: dlemoal@kernel.org
Cc: maz@kernel.org
Cc: tglx@linutronix.de
Cc: jdmason@kudzu.us

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (5):
      PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      tools: PCI: Add 'B' option for test doorbell

 drivers/misc/pci_endpoint_test.c              |  71 ++++++++++++++
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 129 ++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c             |  99 ++++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           |  23 ++++-
 include/linux/pci-ep-msi.h                    |  15 +++
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |  16 ++++
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 +++-
 10 files changed, 370 insertions(+), 4 deletions(-)
---
base-commit: f5373677e13177cfc7875f44a864f9a1db751df9
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


