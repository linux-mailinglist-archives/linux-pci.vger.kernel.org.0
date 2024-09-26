Return-Path: <linux-pci+bounces-13576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE99877C4
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 18:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBD41F2223A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7B81581F4;
	Thu, 26 Sep 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XkshRa7Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1D3F9D5;
	Thu, 26 Sep 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369267; cv=fail; b=j67qlRX6QQA7oZL6wHdavTKmqB7ZmZtAMLeoya573xjKlsYralBFcw2okYV7elBPUhhgpiG8PkMy4mYL4jbRMZyTZp/1vnOv3yBfHoA1BGcF6a3XUDR+EDto8kGn6t1WQpJv8x0QrGI5XT4JunVCpHYFyxVhIjbwxXJWFKJaa6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369267; c=relaxed/simple;
	bh=FpkrPa2VP22uAr6FMuItNQ2iXonduMIYVJxmxwL5tnw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=o36TwwhPLxNuzt+5aQ8hltuEGAVq3N38LAhjoYyy/xC9X0//pUxNgnYQX39eoqFcDcJmwlE3m22bGYIpauSaFHjuQiWA80k6Lwr9ToyzoLYurdSrKrNUPExI8sieqNRVFtax0LbETDkcGhJr0LaNE5u0CFSSvofGT2RKAs02xeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XkshRa7Q; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4tG7ssT/TCQdv9N2XQQ8e2fB0I3rIW/oj8y5u6CXhXTiHfzco10BnT4BYEYm5k733kRWVg0BajrPYJY+FLrea78H6BZIGuZqASkHtq8YGPHeLeTZRRu7SXUdahTKyrhnlddXHryc+F/rCPZl2DJVnSF9gmnziSYRtOZHzQMUCHc52aYiYPEoRb4XInPxURhanEbuyVlJJAet0eT0i3oTIm0USnWt/EocGBclaTl8GcTYTrshdcSZ4z43+Z67eU8Wry38K0Y6fIXm3C/pGrxrA05g20Vwi5UjkKjE57Fsw1n05BQGJ7xN2BI8htvL4+bW2wD1SKeZKmKdw3cEapLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g89bNhf3rvaawhUmL+454hBG5uyRA2EDI3gF4CjBLiw=;
 b=o3Tu1niirkdFBnMmjda/1MB7SyYcYTKCOoiEO3+0bNikVKvWtqPdBXri4kCACbdSHw9loG8230bq2blv8uT+2JJx9duDDzrkeu26ybBpKnqfxvzbFabpMDp7hci1w3CvfHgPKw1ierUbvnS689pQ+ZIvqIUuXuZxoSZvf1o0xi7J0G6r/iphV2pf8spSiV0mTZrfpdQhSjsKSXBB5QmhM5CllmRbL6LD629hTDSRPWgwuONRx0tH0zP2B2Xdri59/ioDef1lhKqp1x9+X0JZDDuPqil83jrxMfWRoDEVU9tpcExjo12uLEzMirukZeZkl0aPwTfJWqqtnv9UgZRCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g89bNhf3rvaawhUmL+454hBG5uyRA2EDI3gF4CjBLiw=;
 b=XkshRa7QUzfI2ieekNvnEaS1+wIaKp4n73EQEAArIiccZ4p4p79P6dRrLblGxehz91OkFNOcQvRMMYBJJdyQfuvMeTLKx50ieIGpxOa2vqEXmvdGnm9i4gXWJC/dbT8G8aTZaak/T8HGCMQ1tBNrzunWrTbOWjP+BOVTsRD2FrOan/9Q8ccBtbfRyUHzYSnjzbtu97a54b5rpgdwjGmCUSuSSoD6M5DRB5/edMDSTpHiAQ6qvOARLItUohPaj93cEc8JJjWdFFYtVlqpotDtDsyxtBY2xGGNzPrUpB2vECSoZstHvUH4Y6MRl+4pcy5EVfzl1ara9ZGrKpPqhtAz6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 16:47:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 16:47:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/3] PCI: dwc: opitimaze RC host pci_fixup_addr()
Date: Thu, 26 Sep 2024 12:47:12 -0400
Message-Id: <20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABCQ9WYC/3WMyw7CIBQFf6W5azGAVIsr/8M0DU97FxYCSmoa/
 l3s3uWck5kNskvoMly7DZIrmDEsDfihAzOr5eEI2sbAKRdUckGiwcnj+o6TsjYRNfTnwUut9Ul
 Ak2Jy7d2D97HxjPkV0mfvF/Zb/6YKI5T0F8uEkswZ4W/LGo8mPGGstX4BnB9VfqoAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727369253; l=4311;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=FpkrPa2VP22uAr6FMuItNQ2iXonduMIYVJxmxwL5tnw=;
 b=WvjshxrzRCkYJ6yfl5FN0KS676f0DXj6HgJqpPvUDeqF8+VlSBg/zKSqR0wDarfY9nnVq+pSy
 MvY+Sd9Os6kAnTdG4CwqyeppS3LWLvuxI2faLN9Ea2TgF4cPvTGYAn+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: c48966b2-e334-4426-1b57-08dcde4aedc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1FVUWpaaDNXQTUzcHd2RkJ5SXoxQnZBclFGb0Z5bTJwRityeGN5d1VLeUNU?=
 =?utf-8?B?dU9pcGxnK0dMdkRuZnNoSHNWSlZhZW5sdUVTMzBZbHdFai9Rc2RGM2ZlSWlR?=
 =?utf-8?B?RjV4Y3JSTFFjdkNLbm40UlcvTldINmhndWt1R2lDbW1TaHpib3BabXVYRVJE?=
 =?utf-8?B?Mm1FWmZWNFkvOUJkcXBDR1c0TWJLemtkTmNZNXVHYmprUzUxaCtxZkk3cDhO?=
 =?utf-8?B?RnZDeXRXUE1iQVhUS0RHWGVjQ1paYy9qU1NLQ1VZcGVnMWVENkpBZ0ZzUFdO?=
 =?utf-8?B?N0VBNmFtQ2pIM0FSWnJuY1V3dVUvMVorTVUwcVkrRWpyT0tpRmdyQVhKMTRK?=
 =?utf-8?B?dkJ2S01yUDl0Wng4cGJhK01wK2wwbmNuWmxJeFA2SSttTnRnTEZiQnpFMW56?=
 =?utf-8?B?Wjg1VmJXSThvVDNQeGl0cnRSUnc1d2RBZlZJZ01aOEI0QXZyR2JSYlFaQ3lK?=
 =?utf-8?B?cGZVdlpjNE1pVWlvNysxRTQzTnczT1F2aE1jYTVvam83RFN4cyt3UFFEMWEz?=
 =?utf-8?B?VEo4NVdHUk8wclQ1bkdLLzhqSi95dVlzOXlzSmYyT0pUZzgwNjFOd0RoOXZz?=
 =?utf-8?B?cUgyRm9RYzhDVHNCSHRORm9YV2VjR2crTEdDZTFMMSt4Uk9LeUdxckJPcWZS?=
 =?utf-8?B?MWZTRDgxOGVHTlNHcytwcVh2UmlQNUlhTTY5UWZiWDRrVnJxdWZxWm9DMjg3?=
 =?utf-8?B?Y3FWUFMyRlpnQTI0ckpmVzJVNnlCaExBRVlhdDhhUW02TE9xWE9vbjRmYnRz?=
 =?utf-8?B?N0lndnRMQjdnMjF4U0NLYW12TFFKYTJhVFBvaVRodm1uclg4cWlUaWdhMU1v?=
 =?utf-8?B?bzFKWTJ3TEJaMWh3Q2FDSm1uc1VTUUFXWFVTM3JPdVJiTU1RMXNkbTF3QjVP?=
 =?utf-8?B?MytOQ1NtNlpRaHFsaHY3Slp1VjRhaUdNb0RKZnJNUkZVZkloTjUrUnlrcGNr?=
 =?utf-8?B?WnNsU1RIdWRyUkRPaWpSNjBvanc0NTRCVVhWU3d3Y3VlY3JsbEpuM0dXcFkx?=
 =?utf-8?B?VENzZUdVV1dPSU50VXRBR0UySURQd2kyRzR3VFZVTjdtNEYyYkhBQzFSM0Y5?=
 =?utf-8?B?OXk2UUtBWnAyUVNIT3lyVmRPTkk1b1Yzci9wcDhLSTRqU25xbC9weE1VYktF?=
 =?utf-8?B?eTdPU25nWkFGWkpqWUlycURaeFZ1ekJnZUs4cDd4OXBta3dQVDMrbHVMRVdl?=
 =?utf-8?B?UENRUnZMUVRrK1hIUVY0QUkwWU1sRWxMakZXZkQ5WmVDUjNOS0hPajB0S2tJ?=
 =?utf-8?B?ZDVxZVZWRG1UK2VOZHV1T2JzZ2VLQWhQWXljS3FLRzZ2eFRNbUZ3QzZhSlRo?=
 =?utf-8?B?enlBSWNoV3NiRWt3UDBhbG5ML2dKdnlkK29URk5TTUwraVZNNXRZSmZ4b0RP?=
 =?utf-8?B?NDIxVEUwWnQxRGtWZFQyaEl2elQ0aXhOTFRWYjh4VDcxLzdOSUcxN2xkY0Rh?=
 =?utf-8?B?Z1pRTGw3Y0NiSllZU2ZTVjk5SlA0cE95T2pvR0hxeDBHL2xEUGdSeGJaYTVj?=
 =?utf-8?B?RnpBK0Z3a2lvbGNPSE5MK213a1gzUDBIMnVEYWxzT1ovWFpkbFI2WnBnZTFu?=
 =?utf-8?B?TUltYzBUaEwyb1A1Q2UrMEh3dDlTY2k1aEIwdmZHRGx3MFczQ1hJVlFmNFdP?=
 =?utf-8?B?ZEJ2cjc4dDRXRXJSOTlHa1pISlRTRkd0NEZySW96Mk0wQStMQ2ZobnhaS0dw?=
 =?utf-8?B?VlF1REhpaVlZMjVUb0FwYzJsQjFpZys3bEd6MDIzWnVJeUxjYzdjWHRSTFBO?=
 =?utf-8?B?a244OTZabk9ydmgzK3hDajFHZDd4dXhxQlBza2txcjAranpLMlU0MmlMaUpv?=
 =?utf-8?B?UWU3cW0vUWNvckVBTllOQjVFbDRpc1JSckxqRzlBSjBKRjV3Q2F4T1pac1NE?=
 =?utf-8?B?S1p5c2JaTW0rTVY1VWNUZWdaU0dBejZuVzVZMlZXelZFcjc5cnloNGlvTWRC?=
 =?utf-8?Q?+DuSv90B0ek=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sy9MekN6M2p3TmFBcjMvNnZlTkdXeEgwaG9ESHN4Y3NOWlpNMDNJZThSOUNG?=
 =?utf-8?B?dUdNaGV4R3JiM0d1dWlhcEFmUGYxWnExZE9vOUE0d1RrRis5bWNDeGZBdlRs?=
 =?utf-8?B?eUxRV0dTNTFnMWhRNjNqNmhqaTMrSFBaWWc3cGtiRlJBeWdBdUNubFZ3L29x?=
 =?utf-8?B?dnVRTXlGeTlvSm5KYnM3U0JHU2Q2NFh5NmpURE1taFNOSzNjbXZ2bEZDRDVj?=
 =?utf-8?B?YXo2TEZTUlFqaGFRVFBqWkdKVnFobytYbWk5THB3cklqVjllMVRpZUh5UG9k?=
 =?utf-8?B?bTd4a1JVcmt4NnFZTDBMelhpNlFzZ2lkR0c4SGsrS29RZDhFemJuVmpmSHZB?=
 =?utf-8?B?czJMdWNYam9LNzJ5ZE9DNUhPUytocmdOUEI4Z2E1Y3RXWTl5VzN1S1YrYU9o?=
 =?utf-8?B?eFBva3RGanZmcXdnVlU0NEYxTHpDQTc1N2ZUaXFtTFhoZy9hcTJtNDRDRHpv?=
 =?utf-8?B?dzk2R1VCekpMWWExQW13ekdXODdDYkg5RjdKUDNDemVrVUpEM3FqMFBJUFlI?=
 =?utf-8?B?aWdiL3Y4YzJQTCtyMG5YUHFOenZYbktCNWEvaWQyTHlOMnVENXJsWnMyc2R3?=
 =?utf-8?B?Z0VwVkpaWUZhRFRtN0FZS2p3cXlGZmV1d2F4OWdIUVY3MGNOTWFYemNoTUhM?=
 =?utf-8?B?a1g3RDhLbFdENkI4OVNLVThLQWgzTG9oci9ENnBXcHRSNy9URTZCYzJNZWtG?=
 =?utf-8?B?dDJPd054aUl4bm53MGkyVEQ0SmFYeGlaUG1VODVONm56S1U5U3hKL2FDaThl?=
 =?utf-8?B?NkVENzNOQ1JIYmJGaGlieHQ1NmcvQ1J0amt0RXgyVTBkZWhhSkFNaUZXaU0r?=
 =?utf-8?B?WVNjSkJFR05SakZlQ0xDblhEbU5jNHB2dzhyRzZ1NS83N2NSa3NXeXZHQnA4?=
 =?utf-8?B?WlIzUjF5ZjFmYXplVnZ5Z1N2ZzZsRGFXdyt2c2RuaHZPR2xFVlp1TWpZVFBD?=
 =?utf-8?B?OGEzK2FobHRHRkpFcnJkSW9GWVJXQk1LMFQ2U3NkdmdDb2kxYU1QYlZGU0d3?=
 =?utf-8?B?UXVNQ0FnSzR0UVNGN0lxRCtOSzVtWElTR0NBSjNqR3F2R1VRZVl6SVNlVmRU?=
 =?utf-8?B?ekUyWiswM1BkN051bWhXVlpFbDVnQTI3aklBRXpGbnRzUzcxZStxeWJmUlgv?=
 =?utf-8?B?anZsVEg5VDBlL213eU80ZUMwSXhGZmV3Ri9YeFpHVTlsUGY0aEZlVEJiMUo5?=
 =?utf-8?B?ajhXMFQ2emNZb0dFZC81V0dYWHhFTHRKNi9IOUJ6L3lSL1dSTHYyUnp1aFVl?=
 =?utf-8?B?djI3L242aGYyZTJyRVVST2VxblFnelltNUFuYlE4SVVuTVhrV1U5RnFKZy9y?=
 =?utf-8?B?UkVHKy80S0QrQm5qc0o1Y1dIY2E0SlEwVXd4S3pZdGNVRWZ2NFFIVWNlN1RY?=
 =?utf-8?B?aVBPL2dIb2YrTUN6M0NuZ1ZHT2JXSDJPMXZPQm4rZHkxUzhQT0xySWhQMFI0?=
 =?utf-8?B?T3hpV2F2M0s0cHd6dFZ0cmFmSFFUVUpqYUJvd2RaamY1UEVEVW1SYkphNmcz?=
 =?utf-8?B?VnVGSm0rM2EwRWlLR1cwbjQySlFvMWF2czFtcnRoUXc0MUp5dHN6ZE5yQVR6?=
 =?utf-8?B?OHB3K1NpYmNra0xNTjB5YThxN0FjanB1K1ArcWZucDlnN1phR2NWT0hBMTlw?=
 =?utf-8?B?R2d1ek5qWnlpYXBjc2VORU1NQnV0L2NOdFJLN1kvQVFlUmVWdlVNNlVMUWc0?=
 =?utf-8?B?c1JpTW9OUWN3ZmlSMGM5MDBMYU05OXdkMVpZRjRDcjZ6ZE82TjVaOFZYdGlV?=
 =?utf-8?B?bEFvTnJhQUpmL1lvc29JeWVKb1hmdjAzd0JmRktianpJNFY4aFNRWHJQMnpH?=
 =?utf-8?B?YWVqNEdTdXVHZGx4NlZzNE16NjJoK29pQ0lRZExFelJYcWh1WWFwUVYwcmhE?=
 =?utf-8?B?OVBpYjFaVjQ1TnprS05CZVBjdXkvbXFWS1Y5ZkduRlMrTTBPbzVJZXZGZ1Y5?=
 =?utf-8?B?WTRXTjFDQmZoSEg1Z1hEclBKQ2FqWW8wYlhEVXZmVHpJQ1I4ckQ1bkdraHlD?=
 =?utf-8?B?bi9VMnJyNWZaQzI1N2g3VEFtQzdrWFJ2VUh6TGt1QWw2OGdKZlo4dUdQNFVQ?=
 =?utf-8?B?Mk80ME9MVkJxWDJIUlVCc3dOYWo4cGY0alp4bGJQd2tPYUExTW9XM0VWcmpQ?=
 =?utf-8?Q?6HgBdvD9D0L5MRXz4AdUooOtS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48966b2-e334-4426-1b57-08dcde4aedc9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:47:37.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ad9LHK1B1MWOoBJ+XP+zIb5MJFNynF1duG3ewH93S2t8ZU2W00k6zDV3VmKgwYnYzMs0d5oq4Y9tnVEv31LX2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768

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

Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
fabric convert cpu address before send to PCIe controller.

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

Device tree already can descript all address translate. Some hardware
driver implement fixup function by mask some bits of cpu address. Last
pci-imx6.c are little bit better by fetch memory resource's offset to do
fixup.

static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
{
	...
	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
	return cpu_addr - entry->offset;
}

But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
although address translate is the same as IORESOURCE_MEM.

This patches to fetch untranslate range information for PCIe controller
(pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().

EP side patch:
https://lore.kernel.org/linux-pci/20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com/T/#mfc73ca113a69ad2c0294a2e629ecee3105b72973

The both pave the road to eliminate ugle cpu_fixup_addr() callback function.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com

---
Frank Li (3):
      of: address: Add cpu_untranslate_addr to struct of_pci_range
      PCI: dwc: Using cpu_untranslate_addr in of_range to eliminate cpu_addr_fixup()
      PCI: imx6: Remove cpu_addr_fixup()

 drivers/of/address.c                              |  2 ++
 drivers/pci/controller/dwc/pci-imx6.c             | 22 ++----------
 drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  8 +++++
 include/linux/of_address.h                        |  1 +
 5 files changed, 55 insertions(+), 20 deletions(-)
---
base-commit: 69940764dc1c429010d37cded159fadf1347d318
change-id: 20240924-pci_fixup_addr-a8568f9bbb34

Best regards,
---
Frank Li <Frank.Li@nxp.com>


