Return-Path: <linux-pci+bounces-17095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A47A9D2F03
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 20:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9AFB2555D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC3D1D3628;
	Tue, 19 Nov 2024 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HHoDgQH5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9DF1D3588;
	Tue, 19 Nov 2024 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045494; cv=fail; b=CqA+3gTdQr7E25eYABsBOK14UWtS+l3zXlNZco+/XApJCeapF1dn3yUe5Qt3Uoxd5B9qi6DqRWmkGGW5DRGhpY6dSoeucZ1aGK/kn0kwuX+Sr+bck8RhdPX4JrJbsJlAAllkiDhqOBna+quxKHK379AVN5cu1v6WqULnDyG9x3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045494; c=relaxed/simple;
	bh=aXXX11evuoHeJzI2romv1WKj3Ah+7csb/vVjNpesoog=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C1ly7GVfyfRU7quqzeTXH+NeCzjAG7zzkCdilb8N9hznTFqSslPeufLbM2X6UNIS7OkJJRpqdMPggrSouU9imVD4aPSp8NzgUKMNhqI4o4dhbXyxiOExyJ3xv3KpJollaUl67Ti4F+nCHl/Wl71aqVkXtxCsvHZaEmhD8kRyInE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HHoDgQH5; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+wPI0HzNlq+7iBN35nCWAB86weCdsa8GiVhpSD5fNaJCr60k03hk20/LtjT9A+wNwFySzEHQzj2DZY/h4mjgO7Ks+Wk/gGmTJdfHtGNN64YiG01ib+31yT7H5nb+IwblahauvCSlfuAvYz4+STPyNlBW7TP2eEqW9KzuGmLOyJmzV49OOxsmEcd9bd6YX8IRYR7RRMMB7X5uLNX36Po+VDkoIsDvBZ4OBsWkzi5hQdhrxUTUdQ0nR2RTQNCHBi/+k3DGQpMPLSSYclh+NpIIwCMtBa0P5TbjR8Mmp9jHbXXnQ4s/hWSy4RpgooGs0IpjPHiD6Ftfd96tsso5ktHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Slmhx3u+CKxItrsOA2x6YrotWMug+CZlJbr0no/5ac=;
 b=aeJRrBlMNi19CMrNuigFkbjlvcI03IXMEnkhwOzySw7seFhVUyQjybmduU2oGmXou4vo2JQBjxFkUvsZnbt9f46IwtjhMUx4sZhCXoPuYfrjSsNXGp+drapvY+U55xbq2WqduFVRiU+uIFYsrRF6j5PZkUyWp4hzEgDyIFA8nyAqmuNowu1pESD35cgJDMGnzdC5vQ6+rqrjtIAzLyXSvG8HjNdGVIxrF2ek9zUS7ZdYd8N0YXjnrVUEK+3e76FmWfJCIkpBVCAn/yIPZu8guKujQ/UdG7K75hTaE0yTlnkOL6bz+AkfYn47bJwFvVGHqaPdCNTo6Z4X0fvq7ilJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Slmhx3u+CKxItrsOA2x6YrotWMug+CZlJbr0no/5ac=;
 b=HHoDgQH52Jtiv9D2AyZohgH2cQdx/h+uSghtSWxpL9jk/FrRyt1e9pd5pE3F1iDChj8TGct13cBD/eRWxk49rd6dbipsCMVZbgZILbRkcYp/WLl47ic+BLV997Uv6RWjQvv8UvevGuSzISGlPX4ktZFlkcRTo/QooDwQ9ilj6wz9S8+AJ1OG+YtA0BUjIkpbXMmFe3//ZjkCRnnHV3duoy37V2/8wzOQRwRJZ+g8tPZiB5r0HawEZOHB2XoEDItTtEv6q2/KksfQBuDVNRTMQyTcTlK6orBEVIuJWXPpKjK04CT/m7XWpcov0fZUNabVH1/02sGUzIXqjVkcN5wyYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11068.eurprd04.prod.outlook.com (2603:10a6:150:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 19:44:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 19:44:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Nov 2024 14:44:21 -0500
Subject: [PATCH v8 3/7] PCI: dwc: ep: Add bus_addr_base for outbound window
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241119-pci_fixup_addr-v8-3-c4bfa5193288@nxp.com>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
In-Reply-To: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732045469; l=5694;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=aXXX11evuoHeJzI2romv1WKj3Ah+7csb/vVjNpesoog=;
 b=qSrTkruYBvzE9sSni5f6eei2fmbhebzWj/98M3g1QQaBKtAYEoh0RQW17+6ziD0eBc56BsCry
 DVIq028IQf5Dqapv2Xn5Jx4tVQhrVkr76jseqgyHA4lqU226iE+iMqU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11068:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c717f2-5ac8-4eb6-4aec-08dd08d2a168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVJCa0xzNXlUQ0VrZ3BoaGZKQVlhdEVubEFRR3JmakwzdXhoVTQxS1lZVkZP?=
 =?utf-8?B?TmpxWlNVazc5b05KYTUzM2N1ZTB4aGhGcG5FR1Y5M0Zpazk4eDJKQXhyMTFj?=
 =?utf-8?B?OW4yUGd5ZEw4eXJaUEFRWkZEL2cvZDhrTENwZTQ3WlIvckJOSTBXZUwyVzZS?=
 =?utf-8?B?QnZja2JKN3NrMFduNWtuZWtCbkdxWVIzZkg1N2l0K1dMWFpYZEx5OVpTTTI4?=
 =?utf-8?B?ODZTUHpTS1NiTG5rWFM5bmtqVEcrNm4xV3hhdlFNMkIrR3RXTVVMUEpoVVhw?=
 =?utf-8?B?OVllaXlDRmpwbmFEajBLZGR6aU5hWHZlY01MYU1ZdGh1eEtMWUFnbDgrQmNj?=
 =?utf-8?B?OFZkano3bXNQRm1iWWQrTysrbGIveU9LMkN1NzVjMTlrcGJDVms3OG81aWY3?=
 =?utf-8?B?RGFmWkxDS2VuT3RlK0tQTldMZVhJM1ZsSFJ3T1AxL29OR0FwTDBveGJMYmJV?=
 =?utf-8?B?OXlHbTVCOHczcXB2Z29JRXlMSTdxM0lpcm5zL2l4eUZRRFowL1FHZ0xRdHUz?=
 =?utf-8?B?U21wZEpFd1RFQTV5cGE2aS9zZjVPSE5pYWJaUER6aGpqYXc2bmI4QloyRjE3?=
 =?utf-8?B?QzRBUXlaRUF1ZCtrc09EZ0FtbmpUazR2MVBCS0QrM0pTbCs2TmRhVFZCNE5B?=
 =?utf-8?B?Q3BuelQwT1VKb0pNTG1OK3pxZmpnaFdobmlKOHF5dkQrbkhjYUdZL0RSdVZI?=
 =?utf-8?B?SXlsUGRtaGExREJQeTE5VVdRdGgyU3VXRUI2NFR0bjBZRjF6elEwTkpxejZp?=
 =?utf-8?B?aUpsYXpDcUNsSEtCT2FuaG1YZ0wvNHBRakJESnBMbk5FT2Q4UFFuZCtkcEhh?=
 =?utf-8?B?aXhQeHFPTTVaSWg3NVM5NGxBeHhBTmthdEp1TUZaSU55amZMYUtoeHlScW5R?=
 =?utf-8?B?dERaUTVQdGV1b3hZUEx3bkZ2aUcvRTJzY1Z6Q0syWUxHd1lYQnBJMlVYckd1?=
 =?utf-8?B?N0JlNG9jaHQwM0VxVElrdTJ1SDJOZHJpNStSMndPRDVCNng4MWFFMmpOVFgy?=
 =?utf-8?B?NHN3RmJ1UXhFaTdkcmpwbVZ4RlFrM3FPV3orU2V6dlZFN2RLaHJkQXhkNlAv?=
 =?utf-8?B?QzBSSlN2MzVNZ1EwQ1VPUkNnQzkwNVM2aExKWUlwVi9hL3BnV1FMb0VteExF?=
 =?utf-8?B?Yytuc3NTL3pQZmhRTjYrdnNwSEsyNDFJVjNYRDFTS3BsRXl5ZSswSEt3dFV1?=
 =?utf-8?B?MFlyVllHTVg0YUhlN1dzWFhZNVBZWTlIMU83eElTbGROSFVjdEFSY0VhemtV?=
 =?utf-8?B?Smo3RDFVWWpHU1V6QVBKQlBRc1dDWmdHYWZKNzJPR1VCWW5aeTdlWUVHaDN6?=
 =?utf-8?B?Q1JrWG01UnZ1TlAwWXhpYytFaVh3Wk5tYTJKOU9RSE5CSlVKMVQ2ZGZ2VkFX?=
 =?utf-8?B?V0E4RndlS2tIalhsVDloWmduMUw3TUtxM3FJVnhrZm5SOGlsY2hnbEo5UGRv?=
 =?utf-8?B?ZzFUeElzaHNtTzJoVWxhVThNeGFNK2JGb1BSMWhuMlQxV2wyWVpvWW1hdExO?=
 =?utf-8?B?dTl2ejdGb1p6S2ZqOTdEdDlLbHR1cmkzTnVobm9OMiszanRlcWxsKzhPL1By?=
 =?utf-8?B?NTBCMDFIYlNmbzVFVXUweHphdWsvazBiRHVxbHhXQThyazBWOXpXSTBMazl6?=
 =?utf-8?B?VkxadHkzbEZlaEJ2TUdxS2pLNTRjVERiVFRjNm9aS280SFhiRmViZXRKZUdw?=
 =?utf-8?B?dmwyaUdBYkRaeFVIMk9EQkZsTG5HNmRKTzFOdU8rV1lpTUI1dmExQzFVekU2?=
 =?utf-8?B?S3VWZ0dKNE9hZU1BOW44cXFuaUovR0VRdElsT1d3OWpWc3hvdHd5OURBR1ZY?=
 =?utf-8?B?a2pZemE0Y1ZvQXFiT1BMbWIrVXdTanBGaThvNDJVMmtrVVRCTXhGb0FWY3VK?=
 =?utf-8?B?dzhjU1FSWUx5SmlZUHhjQkZ3R2N4QStmZlBKM3lsRDA2TWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFROY0k1WGJINkV3ZnYxY2hjNDFvb2xuQjh3bkl0ODUweDhhaXpPbjVrakZp?=
 =?utf-8?B?YkVKZzNKd0Y0U0dzM2FUM1JGQmpYN2V3cGMxeEVpZVNXc1NRLzRlenNwRWY4?=
 =?utf-8?B?TllDUFJaV2YxaVVDMnJXdFlKYnJEUS9LaDFjUUkzWHlESHlFVE4rR3ltR2tT?=
 =?utf-8?B?QkphMGljTzZSaDhLUEZGNDE1S2lHdm5iSi8rTklRK1NqVWpGMDIzRTBFL0FL?=
 =?utf-8?B?NFFXRnB5SWE3azZ0NTF1QU5wdFE1RGhoZ3g2dW9xeTRvcWs0VU5QUlkwNXVZ?=
 =?utf-8?B?TEJKVEljKzc5b1NFa2xhcFhIQ2c2TnF4ODhNMzQ3TXFydUhXWno1bG5VUmdN?=
 =?utf-8?B?bUM2bDZjcDU2Z2lvMkFIMHM3dEhnaTZNcUpMMVVUTVM4Q0tQaVd4MG1hM3Vr?=
 =?utf-8?B?cGVYcWI5Z2Eva1k5cFVSV2xneWVxNXJCQ3pHQlk5S1NxcFA2S1FlREZtQW1m?=
 =?utf-8?B?bFgzT3FjRnJ2ZzVoUW5wQ0F0ajRWNVF5MnprbzR0cWw2Y04xQW1uWEhuK3Zp?=
 =?utf-8?B?YTlidWJQZ3E1V1VnNVBLTjFNZWkzUy9mVFBjbFo5SUt3YkgxY0R2NzRrekNR?=
 =?utf-8?B?RTZ6dkNSZC9WVXlibXo2L1RTa0FpNmRiYlJmbjh2VkpoS2JiUWxQd2NRMEE0?=
 =?utf-8?B?U3BoR0NlVUFkQTdIZDcrcWl6eXlQQmZjakVnREFLdjdzMHMvV2VDRW1XazB3?=
 =?utf-8?B?NzRjR0RyV1o3elJyOS82NUVyVi9zMzlkeDV3UXVTdUI0dlNDdnBadUZnV1Nv?=
 =?utf-8?B?Vll3UCsrT1pqd0dQNitVUERIdUhROFJVdXNuaTBQV2oxeE1HZDBjTmJDb3hT?=
 =?utf-8?B?c0FXbDIvSWZwZFZob1p6Y1BSR3BMZDQ5ZVI0bmxmSGs3TXJVTTBUL0gzdGVN?=
 =?utf-8?B?T1I0NUtwcnc4dHlDVGRUcUU5Mi9yNnRPaVk2Y1RzMEpIZTNvVU95SmcwSUJC?=
 =?utf-8?B?cFYzSnNwOXg1QSsyWG44SVpsMzUxalo1cEhQVURyT0UrbXNJeUhHSlNxU1JH?=
 =?utf-8?B?SmdLSk90ckp3cnFoQ01TbktQZzBudmgxQUE3ekMwaU42bjZYdUZ4NFUvZU0z?=
 =?utf-8?B?YVBpYkxMSThzTU00QW1kKzE4MXVKTWZmWkZTeHNpbWtHOGRiSUVDN1g5aHcy?=
 =?utf-8?B?YWQ0cEROYmpHcjU2UEtEZGNuWUdkUnlJckdFRWM2TDR2akJyKzY5bEVZaENX?=
 =?utf-8?B?Z3ZiUGVXR2FDWE5JMFdQOE5GOXF3TWpPTi9ua2NkZEpWOFh4dmtxalJSbUcy?=
 =?utf-8?B?V0M1V1dpOVdnTlV2aGtSVUswT2NRaVhBTm83bTZ1R3pQRTNKaU9teW1nYWxv?=
 =?utf-8?B?bmpmNkFaU0ZnTTdYUDRZbHJyaWtNOE9EZlcxaWx4TUtkWHg3Ym9scTRQUjgr?=
 =?utf-8?B?bDR1VG9rdU5EM0xrVEQwcXNjSXN3VEFKZk4vbERTbVFYS1NqbnBkM2pRZkRj?=
 =?utf-8?B?YnZPS2hwOEhaZ1dBVmhQZmJGNTNWQWRNRDdTN013U2dIbVE4cU5PcThDc0VZ?=
 =?utf-8?B?MGRMTUxwWnQxV1VCMmcvdUpGc1dDcXVVVmQyOFh5V21NN3dUUGpBUlJLMmFp?=
 =?utf-8?B?WUJtVjluKzhqZkd4d1dNVDN3Wm1aVGlnT05HL1ZxSXpCLzFlUHBKdFBBYkhm?=
 =?utf-8?B?cmVLOGxtWDdnMGhvRzI3cmx4eVUySlNyTTl5cGIzVUIxZlJMU2FTdVpRdlAr?=
 =?utf-8?B?eWtjTEpOWjJacDJRTlNzcFEwa3N2VDY0S0Zabnh5RnQ2SlRwMW5NY29MVWgw?=
 =?utf-8?B?d1ZwR1l2bHI4OEtmM1V3aWFkMVZNODBSdzhsNGYzcXArVlI3cis2SVJxeWRo?=
 =?utf-8?B?Z2dVRlJySUUwSS9pUllSMXROdHFNSnhkeGpmQnNvVGZoamVEZzlXMStHeHM5?=
 =?utf-8?B?L1NiNXpIellZRHZGZkRMZUd1UU9FM0ZPRjYzOHVtbytLN1F5U1o5Tm4zZ3FO?=
 =?utf-8?B?MEF1ZXVvY09OTTZyQjVZMEQ5RGZIOWxtZ0M5WGVONFdxZlQxZ2w2WGFwU3Uy?=
 =?utf-8?B?UFVMclpGU0d0bXJBK3N0d0FDbHVzeDErWk80YmltZVI0ZzlyVWNycEVYUGNI?=
 =?utf-8?B?aXZTQ0syNlpDWWYwbnFLZFg3Q3cxUFN5NTFYbE9CVzVDeXJYbHFiZFB5Y2dO?=
 =?utf-8?Q?bsqM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c717f2-5ac8-4eb6-4aec-08dd08d2a168
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:44:50.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/e0QEdPud2YhDTNNP4pXV4dlDdQUXde98+yGjX3wyyFn+xSyitXFDUMSvTk3s9kYOIX4t4H3Jd/1fM3n7+czw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11068

                   Endpoint
  ┌───────────────────────────────────────────────┐
  │                             pcie-ep@5f010000  │
  │                             ┌────────────────┐│
  │                             │   Endpoint     ││
  │                             │   PCIe         ││
  │                             │   Controller   ││
  │           bus@5f000000      │                ││
  │           ┌──────────┐      │                ││
  │           │          │ Outbound Transfer     ││
  │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
  ││     │    │  Fabric  │Bus   │                ││PCI Addr
  ││ CPU ├───►│          │Addr  │                ││0xA000_0000
  ││     │CPU │          │0x8000_0000            ││
  │└─────┘Addr└──────────┘      │                ││
  │       0x7000_0000           └────────────────┘│
  └───────────────────────────────────────────────┘

Use 'ranges' property in DT to configure the iATU outbound window address.
The bus fabric generally passes the same address to the PCIe EP controller,
but some bus fabrics map the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000, Bus
fabric map it to 0x8000_0000. ATU should use bus address 0x8000_0000 as
input address and map to PCI address 0xA000_0000.

Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
the device tree provides this information, preferring a common method.

bus@5f000000 {
	compatible = "simple-bus";
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie-ep@5f010000 {
		reg = <0x80000000 0x10000000>;
		reg-names ="addr_space";
		...
	};
	...
};

'ranges' in bus@5f000000 descript how address map from CPU address to bus
address.

Use `of_property_read_reg()` to obtain the bus address and set it to the
ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

Add 'using_dtbus_info' to indicate device tree reflect correctly bus
address translation in case break compatibility.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v7 to v8
- Add Mani's reviewedby tag
- s/convert/map in commit message
- update comments for of_property_read_reg()
- use 'use_parent_dt_ranges'

Change from v6 to v7
- none

Change from v5 to v6
- update diagram
- Add comments for of_property_read_reg()
- Remove unrelated 0x5f00_0000 in commit message

Change from v3 to v4
- change bus_addr_base to u64 to fix 32bit build error
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/

Change from v2 to v3
- Add using_dtbus_info to control if use device tree bus ranges
information.
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 18 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df1..42719ad263b11 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -294,7 +295,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.cpu_addr = addr;
+	atu.cpu_addr = addr - ep->phys_base + ep->bus_addr_base;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
@@ -861,6 +862,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	int index;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -873,6 +875,20 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -EINVAL;
 
 	ep->phys_base = res->start;
+	ep->bus_addr_base = ep->phys_base;
+
+	if (pci->use_parent_dt_ranges) {
+		index = of_property_match_string(np, "reg-names", "addr_space");
+		if (index < 0)
+			return -EINVAL;
+
+		/*
+		 * Get the untranslated bus address from devicetree to use it
+		 * as the iATU CPU address in dw_pcie_ep_map_addr().
+		 */
+		of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
+	}
+
 	ep->addr_size = resource_size(res);
 
 	if (ep->ops->pre_init)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 4f31d4259a0de..5c14ed2cb91ed 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -410,6 +410,7 @@ struct dw_pcie_ep {
 	struct list_head	func_list;
 	const struct dw_pcie_ep_ops *ops;
 	phys_addr_t		phys_base;
+	u64			bus_addr_base;
 	size_t			addr_size;
 	size_t			page_size;
 	u8			bar_to_atu[PCI_STD_NUM_BARS];

-- 
2.34.1


