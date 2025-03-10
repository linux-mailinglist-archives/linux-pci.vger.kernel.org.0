Return-Path: <linux-pci+bounces-23367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C51BBA5A4AC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF81171EF2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1E11E0DCC;
	Mon, 10 Mar 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ML5z24e2"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012008.outbound.protection.outlook.com [52.101.71.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D11DFE0B;
	Mon, 10 Mar 2025 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637863; cv=fail; b=UfYifTFQBNgx2UhuhO1bqHQLf2sobhf3cWf3rmF+FoGxU4EFJwea13v84gBmbQVniCtR3zv8IyH2fWu1N9tx+/iajqCkiZOvXY4nhIFol1MJRwXlWyc+7soh3MrquiDYr2ZEX/EtuPEcUo29VJNc2YtzhHVLLs53Do4VWhzE+wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637863; c=relaxed/simple;
	bh=wt7jA4Qo0h0Ostv9EeckEVLf37SjEKcLfPRtg0Wn7HE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Mha0dJD3vPk7IkyTRQROBhm1mlX954JAQj9JYh9hzWaTZul4l7X5+jz3PLNY1FoJCKUhjeJY26oP0TgRPxgJHT5m0+nBHekuhlWhUX5AdDOHkNT/1FhGdrR0V9e59TALWbeb71E84jtNvYy/PYlQt5deayDow6YL8yYQZ0FOsYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ML5z24e2; arc=fail smtp.client-ip=52.101.71.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtHktoh+t4TsbNfSF2V9nCm/Slw1qCK6T0wmaglIBIk5/5mCBqvWEx6hm4VRhVLC21qUObCPdpWUxWxbd/aWF+YpADRZW9Y28d9X0jU2tCs1/564B1AyHYLQWxLlgEzdGcbztjw/qZKsHVOa6t6O/8RKkLRDkq1qfHec/UVz7+mOGycWGSbwuzy1ON9ad9gpdMl/hvmJZM+/vYHJmld/5paWPtewnWbhHB1YK3PQ0Wt4Df4kHNSryf6XRKEsuBZ/aFZAT/m/I+DWqXm/QKEXYmPZ8sWVu6hd7RevTn7wZbSicYerGLvlzRJOC5CpPZL1InUgfuLN2r4J3IGxdJh1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkUUith3lCTaKzBGlHcayPTbQSKqnnP97ibVcnry8a8=;
 b=DwHSQv/pNePQPg7GrFDSvTURlujaETaHSjj1Oq1lyhyb4djRtnKFGAxoi4haqd5ws31C3lylsVsvh8GTCZbqSwbk3ADq5838ygykJgspwo44TyD7Yuk/MElDzFyy2FuyRNCVdJEvuB5ODlRnmjEeitm7dhgcvCKZrdgV6B7lWugSyfdNhou2BrcN3q6JJMnYTJfHPSVPjE7pjaPaoMMKol9M8SutviYhh4fjsGsreax6aY/kZ4skOMzs4SDwQMZgAZiulOeIChVvmTpg7UzHp//gKWMrppALMShqCtUB7zBQ+ZoxO8+rtt6BEkQLxMO37g0NPDWKNOKZi//Xi4+vrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkUUith3lCTaKzBGlHcayPTbQSKqnnP97ibVcnry8a8=;
 b=ML5z24e2287iKQS9fh+uYbx839mvYtuhvAqbKMlDQ/2sZckK/YdVK67oqn01j83OjNPZArB5JUq7lS8a1DV2uzq8CMGjF+VjDDXCHE6qDxBll8Y0H1tdobzOP2fuw8St0dvzeWQp02Hk2vs8Ku1qOw2zKk7oBBRSaJpyTMrOoCfEP8iHQc6KKxegLQnxACg0UanPsRMdsUFXF3oNilQ3ltgMlQJ3r9MQIViyZnPwHKj3DbuzwiGVVhiIoX321XHBLRt/F3GTEexokOl1IAs+F5QIfEdOjKroQp8PQ5vAM4+zUIHl6tdfoyfDdpwV/nxijiQoyOUCK9c8+DVDIcRCcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:17:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:17:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Mar 2025 16:16:42 -0400
Subject: [PATCH v10 04/10] PCI: dwc: Add helper
 dw_pcie_init_parent_bus_offset()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-pci_fixup_addr-v10-4-409dafc950d1@nxp.com>
References: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
In-Reply-To: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
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
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741637834; l=4967;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IPCgPMxURCT5SP4DmpiD1a/kBvD5HOawwcntFnZ2L6w=;
 b=Q7cI6XnU5mrbda5d67jfiZJ8MOB/6zdDKZOgtpHFx8IF7kOhAJzqcdMy+/3bRxjMGQB5WmLec
 f3dc+03VlQeBRtvk8LS/HNM9Suy9KMQWepqqjeU+7HeW8hdYFjlVHSZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 66eca2ab-5f3a-4819-4ff2-08dd60109aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckdHa2I1ZWxZQ2NFc2FCQk42N3hxVldsSDVZSUxkNkZEM0JRWm53amVLTDQ5?=
 =?utf-8?B?WnBGYXg4aFB5NGVjZVk1QkRWb0lVMnlXdHZlbWZTZ0RraUJuMWtVZlhiTU9t?=
 =?utf-8?B?R2szUFFMekp3MmVrcnpBcUs2bWJBWnUwSFUvK3pybFRhMXYvVnA2WFZPdERq?=
 =?utf-8?B?L1dvWElpNGtVN1pmOHVyaEo5RENCTUM4enc2UEgyaEZCU2puTmNMSWNQNjdj?=
 =?utf-8?B?UDZvdXNvZVFoeDVpTUtzenJmQ2V4NGRlRWFtYVM4eFVLeTdUa2EvdUVkWkNL?=
 =?utf-8?B?WU1SbFg2Mnpaem82aGpQSExaVkZmd29GWkVFck9ONDV3RHlyQTZsU240ZWd3?=
 =?utf-8?B?Zzg2Ukhhc0Z6R0xGZE9uajM0MW9KdEU0MlJGY0NxcElNUitQMFRkTmhWZEZM?=
 =?utf-8?B?QVRHc2JYVlpaT01oVU14cm5XNU5PbVNPc1NsODdteXJUelI1dklmMXNkdFIv?=
 =?utf-8?B?TDdKeGJzRzRvS213TnpDYmk2Sk9uOUJuRWNUelhMNC9rd2s5R0w3TlFlWWww?=
 =?utf-8?B?aEFESGZjZ0Z2NXNFenNaQzQ3QXd1WFg0WDcvYU9sT1JlYjNSNzFGaEY4djFq?=
 =?utf-8?B?Z2NJajlVK0M2ZndRUWVMd0NSTDNlcHBTQXhIYmpsWnZBTTFyL05mQll3TjFq?=
 =?utf-8?B?WTdDdVNEdWVIWmw1Y0NWL3dXbWNhaWNLMWs5R1NmTTJXaUpNcXV0SDhvMXYr?=
 =?utf-8?B?dk1jT28vRmJnSHZrQ29SOTZuTnhDU0ZKYjNRdHEzdnVrQXZWbzBuWk5wWTMw?=
 =?utf-8?B?L3E1bmcvKzVpMmhOMXJ2ODFOMnkxM3gyWEs1S3NMTE1iYTg0WFlTa0Y0MDd4?=
 =?utf-8?B?MVd6eWlydGg5L2VodDZIT0p5QWVDUFBLT1lHdDVRbWZkc2NtM0dLczQzN3N3?=
 =?utf-8?B?UVl2dnllV1FpVjc1blpJdVBJdXJMbW1rWm4yZlJYc3ZPYXhFSVJiMElyL2p0?=
 =?utf-8?B?K2R0M3dXUWVYYkR4cElQdGxmZW5jSVVnZlhGVHJQRzBqdnFxeVluRVllWTEv?=
 =?utf-8?B?RndWVDhoNjU0T2lOSXFkSHhMa1hBbUlSWWtHa1h1eHgyNU1wTFZuU0pyOEVH?=
 =?utf-8?B?bmpScmF1T3hscTlXRHFaQ0ZOck9WUlBvRVQxVmI4bWQ0MnFPd3RtUWRSTHJG?=
 =?utf-8?B?MTNJTmZ2YXY3Q0tmckNrV3YrbmJDdGFQUXM3OUMwaVBleitvNGppRy9tbXZV?=
 =?utf-8?B?UGlvdHhPbkEyQnEvRXhacGlBSGhJRW9iNEh2RWdMZGRXWmpCcDZSVDFleDhE?=
 =?utf-8?B?TmxwR3JaU0g4TGRqU0ppTEZ6Y2hkOXV4THhxeFpvdnhWT2FNZUE0dzR4ZkpS?=
 =?utf-8?B?Wm1uL01MY2Z1MjRHdGxKblBMUjFkdmt2V1Zhb0NmZnFqcDAwUHJHbU42OStO?=
 =?utf-8?B?QUdZUlFJdm9SOW5CZEd2VVAwSXlhWTJtU3BadnlKMWdEbS9XQXpnWkg3MkVX?=
 =?utf-8?B?eTNIWnFZdEpSZ3FyZGIvR2x5a1VCV2FtdFU3SGhxZVBjcjBtelVIK2RBOFRF?=
 =?utf-8?B?eWdQVWpkbngvcmRINXV4ZG92QndkSEt5ZEptMjJQWDBLUytEODlnM0I3SHNO?=
 =?utf-8?B?NlhxdzN6cVpIWEx5MG9FVkNNVDZZbWdiWGVwN2Q4NHVET0hDOEJUeWN1MDhm?=
 =?utf-8?B?c01SekUycXRwUUMzdHI4TmErT0dSamRyQ2dEaFhaUU5hdlBrZklxNXVkM05n?=
 =?utf-8?B?WW92VEpoNUNOQXBrZ1dmVXRPZFRwUEhwL0VEUlBJN2RndU0zUS9hWFpFL2hv?=
 =?utf-8?B?ZnkvNzZqbHNXeHI3VnM1elkxOHJEblNxM1BZTjhlUEVVTVpKVGUxUzExRko5?=
 =?utf-8?B?REpNQlgxaCtrd251ZnI0ZXBiaDZWY2IzWVZNMUowRFNoVndoMVBJRkZ1Z2Rn?=
 =?utf-8?B?U2ZXT3ZOWEhqbnJycHkvSGxNeE9WcVVIby8yTndtcnpXR3RNZVFmNXVPaEc0?=
 =?utf-8?B?Q2xiTk05ZjhGeVVSdGZ4bmNva3RLU2lEbFkyWHpVT1ZXMzlLSUtucHRCY0wv?=
 =?utf-8?B?NXFmNXhVS3FnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUlUUUJWdWN2blNJZW00NHZCQVV0eGoreHBqS2lXeGJMZkZsTUhmRWNFSVdV?=
 =?utf-8?B?eGo4QWdETnhiV20yUmRpbWx1bjRQeXc2dWZUNi8xMHV5QmpkTXkyQmdobVZz?=
 =?utf-8?B?TlJBNFZVcWUvdXJVRXVtdjF4YkZJYTF3b1ZxNFU1OHhDeXZ3WDZWc1ZvcWZE?=
 =?utf-8?B?anJyUGVEeUpKN04yMEEwUFZDQ20vM04rNGt2dzVVWlJGclJaaUhZNmtvSUQz?=
 =?utf-8?B?azlUMVhVa21iZEh0SnNObW1zN3VGcHBHMEtmMy9RbDBaL0VReGlLN1BkTjR6?=
 =?utf-8?B?eHk1OUZydzhNN0FoNEdldCtWdFNhcmR1RTV1RklwRFVQU0k1Y2tUa3l6eUM3?=
 =?utf-8?B?RXVNNkxvUVMrY2U5bEp3eDlPaEpBbnJYNGRBZEd2ZkNwQk1BdFJ1TU8rMExW?=
 =?utf-8?B?YXlaMkNhYnFsUGlVWUprek05bU13akxZekpXdHhKcisxN2FHdzJXWENQbXlt?=
 =?utf-8?B?cDZUS05xb25LaUszbWErRWMrcmxuU05UV2FVdC9MTGgySFkzZjFEd0xieVZy?=
 =?utf-8?B?VXgxTUpSUU5UN1Zxd1hESWJXcGZTMVJ4N1JDTjdKU2RFclpRT3RmQitIZXB5?=
 =?utf-8?B?S1hCTGw4Y282cDFjSmlVSjlaaWh4Y2ZTamp0VFhoK2d2UURaRVM4eVorTER6?=
 =?utf-8?B?dWl2d0FXYXNOM1BGTE1XY3NCcTlLd05VOFE3VVJ3NHY4aDF3NU9FdHJZNCtW?=
 =?utf-8?B?Z2xrRk1YVXRoYlBiVjJjeW8wL3pMemlyNGF1RUFpVmVqQVkrdExhekd0bWhy?=
 =?utf-8?B?SVh5NFZscFBoeWwzT3NyRmNzYUhBZVJRSkUwZ0FmK1J6Q1NaRGZPSzhldVcx?=
 =?utf-8?B?em1hWU1rc0JDVlN2M1M4djY1ZnYxbDNxeTNMM3RTYUFzakxCeEdnRngwaW52?=
 =?utf-8?B?SnNCM1hGcmJncCs3bDFvTFdBM0NkcExGc3orblo1UWJORGs2bEJhZDdvR0RS?=
 =?utf-8?B?ZmtYTWUwUmpOZHBmYzQ1NXhqMG4rRjdvUU9ZclpsL2JySVcwQ1pRSFVyTjRJ?=
 =?utf-8?B?Tlh5MzhFNXd2dldGVitWWStzTUNFUkduSEpoMzlOMDVYRjJaSDBKaHFXWlNE?=
 =?utf-8?B?QytLdEpkaWJNbS8vb3gvWXM4ejBJOWo5WTc1aFR0ZFZXV2NhRTNyK0RUSkNX?=
 =?utf-8?B?NEZGVnYwakNhbXZtMkx2NzJQQjNVeDZJaThXT0VBclVDdGRkVWphZjIrd3Fs?=
 =?utf-8?B?ckFiWHlSLy9MMXlEcTJTbDJtU1dUVWxGNU9rdFFqditoQ1R4TDNlK3NvWEt5?=
 =?utf-8?B?eDFsTFNnVi9hSFFuKzRSMFdwNFVVL1JIdGNJcWc3b0dPZFJFNEhCNWZUcGF5?=
 =?utf-8?B?bDdXWHlTTUYyMCtLME91eVArclZoRldMTnkwOUNMSXh1RnMzK2pJZkFiUmVQ?=
 =?utf-8?B?ZWhQUitBV1NBbjRrKzV4aTdBNy9xckh4K3c3SEU4NGpuOWVFcndNOCtMVkJZ?=
 =?utf-8?B?dzlieG5GOVJ5UzBwaFhLbEFRZ1d1OEp3ZVdmUmliZFRwdFNsbWFRdGh3TDZZ?=
 =?utf-8?B?OW9oNUtSMGdKOFRpRFlEcmE2cXduUHR1K2R6bmk2RUg5Q2s5OU10MmRaYWcw?=
 =?utf-8?B?aWw4WkJzVW1TUk1GcThuVlUzcGdQRzloc0NVR0dFL3dRbVpQdnNpK1BTOC9x?=
 =?utf-8?B?dTlvRVNINzhPdGFSTGMzSGpqVURSMXIrdzE5T2dlZG9va1h2Nnc5TEhqSlIy?=
 =?utf-8?B?c2FvL1g1b241U0I3YlVWdWc5L1dNL3dvNUpkRXM2SUtJTkxCZSsyYnlTQjdK?=
 =?utf-8?B?N0Y2QUJFUU5USlo3SzQ2UXk1L3YzRksyc25SZ2lWSGlhWTU4UlVWRnloZXli?=
 =?utf-8?B?amlCeVhWMXk4WU1ITVZJSU9HSmh5cUFuKzNQL1ZzaE5pRzA4dTdTTlFnN2JB?=
 =?utf-8?B?Rk9uSWdKQUtYMStPR2pQTXpMME0weHJNcVZQZ1BwRG82N2lFOU9DNnh0NmVj?=
 =?utf-8?B?dk5UV0lyMlQyK3dGdTFINWdRdnBqUWxjL3hFSTNSa3hYR0dQZnZXUXh1MkdZ?=
 =?utf-8?B?ZUxTOWNOOHVabWRtQk9SUFZRY29QMnZvZzhITE1vZ0tFbzliaVVPeVJ5MWs2?=
 =?utf-8?B?clhMOVZwQU0xdkVsT2Y3WU8veGUzTnZFK29wWHAzVW9SVU1FNG55Yzd5S3NG?=
 =?utf-8?Q?IaZI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66eca2ab-5f3a-4819-4ff2-08dd60109aac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:17:38.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZ/Jv6hNweJW2gtP2Tk0XjVvMjWRLCQJnQdrb5cDMvY6B2ZZ7iDLwUi5T6aE6+TeXDHmnTwA/KtAPWCDvBksRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

From: Bjorn Helgaas <bhelgaas@google.com>

Set pci->parent_bus_offset based on the parent bus address from the
"config" (Root complex mode) and "addr_space" (Endpoint mode).

.cpu_addr_fixup(cpu_phy_addr). (if implemented) should return the parent
bus address corresponding according to cpu_phy_addr.

Sets pp->parent_bus_offset, but doesn't use it, so no functional change
intended yet.

Add use_parent_dt_ranges to detect some fake bus translation at platform,
which have not .cpu_addr_fixup(). Set use_parent_dt_ranges true explicitly
at platform that have .cpu_addr_fixup() and fixed DTB's range. If not one
report "fake bus translation" for sometime, this flags can be removed
safely.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v10
v9: https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-4-3c4bb506f665@nxp.com/

- use help funtion dw_pcie_init_parent_bus_offset() because both EP and RC
use simular logic.
- still use use_parent_dt_ranges to detect fake bus translation for
no .cpu_addr_fixup()'s platfrom incase block exist platform.
---
 drivers/pci/controller/dwc/pcie-designware.c | 47 ++++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h | 13 ++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9d0a5f75effcc..70b4d3369158a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
@@ -1105,3 +1106,49 @@ void dw_pcie_setup(struct dw_pcie *pci)
 
 	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
+
+int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
+				   resource_size_t cpu_phy_addr)
+{
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
+	u64 reg_addr, fixup_addr;
+	int index;
+
+	/* Look up reg_name address on parent bus */
+	index = of_property_match_string(np, "reg-names", reg_name);
+
+	if (index < 0) {
+		dev_err(dev, "Missed reg-name: %s, Broken DTB file\n", reg_name);
+		return -EINVAL;
+	}
+
+	of_property_read_reg(np, index, &reg_addr, NULL);
+
+	fixup = pci->ops->cpu_addr_fixup;
+	if (fixup) {
+		fixup_addr = fixup(pci, cpu_phy_addr);
+		if (reg_addr == fixup_addr) {
+			dev_info(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
+				 cpu_phy_addr, reg_name, index,
+				 fixup_addr, fixup);
+		} else {
+			dev_warn_once(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; DT is broken\n",
+				      cpu_phy_addr, reg_name,
+				      index, fixup_addr);
+			reg_addr = fixup_addr;
+		}
+	} else if (!pci->use_parent_dt_ranges) {
+		if (reg_addr != cpu_phy_addr) {
+			dev_warn_once(dev, "Your DTB try to use fake translation, Please check parent's ranges property,");
+			return 0;
+		}
+	}
+
+	pci->parent_bus_offset = cpu_phy_addr - reg_addr;
+	dev_info(dev, "%s parent bus offset is %#010llx\n",
+		 reg_name, pci->parent_bus_offset);
+
+	return 0;
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d0d8c622a6e8b..5f941eab57110 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -445,6 +445,7 @@ struct dw_pcie {
 	void __iomem		*atu_base;
 	resource_size_t		atu_phys_addr;
 	size_t			atu_size;
+	resource_size_t		parent_bus_offset;
 	u32			num_ib_windows;
 	u32			num_ob_windows;
 	u32			region_align;
@@ -465,6 +466,16 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	/*
+	 * This flag indicates that the vendor driver uses devicetree 'ranges'
+	 * property to allow iATU to use the Intermediate Address (IA) for
+	 * outbound mapping. Using this flag also avoids the usage of
+	 * 'cpu_addr_fixup' callback implementation in the driver.
+	 *
+	 * If use_parent_dt_ranges is false, warning will print if IA is not
+	 * equal to cpu physical address. Indicate dtb use a fake translation.
+	 */
+	bool			use_parent_dt_ranges;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -500,6 +511,8 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
+int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
+				   resource_size_t cpu_phy_addr);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {

-- 
2.34.1


