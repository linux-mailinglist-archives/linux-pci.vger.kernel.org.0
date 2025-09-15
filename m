Return-Path: <linux-pci+bounces-36210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9CB5876A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 00:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E48201A53
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7AA2C1591;
	Mon, 15 Sep 2025 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZmOQ5taj"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53864296BDA;
	Mon, 15 Sep 2025 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975000; cv=fail; b=pUmYn3xokzNYryiJvXLSD6i7xkqqijzcxrCgkLdMnUbjg6vrkT+pGYQ7SGUMuaCDO5PFX1pzgm66Izn6uJekbcMJrN4WQcT9PUF5WJ0VNwAeZLYjBJx/Wd5K0hogLeQFapZl62zwvKGGKAVmzhnXLQUOq2gqNOSYRP0DKDw80Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975000; c=relaxed/simple;
	bh=BT6+zgjAtVSKd9hVY5H/jnZBBk6w9ntHvRBhofAzFo4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sRyNOrdhvPlDgDwORWY6J7penV9y2gF5m0TiQfH8KsZ5hy5jxXVfhfPfsGAfasC8hGHAROSQEOn4hQQ4kDQWlV7lavFT6FDOR5vixNLMy/dixStUBJtdtPkjxnB7Qhy2GTcVhiY7XALQK89OdKnjPoc+fWBEfpI+nfH/o4zhy10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZmOQ5taj; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzZVbAGDl2XI0loC8MBlRiVDgBbnxTpL3h6H/c73zV1OxpUPAKxlKQhsaB46t/6JghuXEqmcRzALPV9iXuRZ1sagO8AJ09jAwPMg+kq6Jj6olNIML1aACYlCt+hSg1+3gB+fORBTIrlSAqogcouz/kGp5iZT79YodST20Zo7oZqnWVEiiVHP06/KNKG35ZAiljf96XuI+Q8QyDt8qOXEh5taCny+u1HmWhQkX7pJROndNx0SGRniz/OKNLQTBvl4y2Bb3MdZxgHRDT/SyEvLerMFhPJLWTmqXPMlB5MW/akUVguJABS/tF/Go+V0xw9ebHJL71EMbZnmnVIuqfglKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXftkPJM2cg4ITOWzR8KUYwGKlXrqnf+OUEgQftV2AI=;
 b=DgqKFKf3k+mBSyxPPxOVwh+QDSi6XmcWKHXFfR612C4E6dg1f5TC2RBwjXnbPnLx8iRiYlEMq0JOyn6fK36lwnq34Tq3VuGboQe6VyHorQLps7izbzWb/LttxKU8kNZIvIC/fGPB7G5noBRFOpmneZ7MP8fAxY+MSf0SiOYdd8S+JgC/GPVG8I52A5XEJ7omxcXmRnvm5p0TbEPQfXUGyV4/hhpjnnpRcEQaLnSG2ZOfXKgHJZq1Uu0Be6k2kAJHuJ9lUVtZ3MOGSmaVYBmqrWpfyH606Xy5INeRRHrzmEy8Ddpw+n+snNZDfqUk65Kp4hrfinY0hb0GRTv7x/4LgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXftkPJM2cg4ITOWzR8KUYwGKlXrqnf+OUEgQftV2AI=;
 b=ZmOQ5tajuTXqi0E+w55EZLcXL3jPXy3nqjOeEakTDqIOIuQgPVKgyHl+QThCixgAfQ1jOjzHVEE8rbHFfBBP/+TSbaDy9lteZOh9O5554FXx35jieMl6IkI4ZqZHFKnZKgfmUXXfM9XNaMsuZ+Nr/8W1DTYpsDjgvAS02lwyJ6YJMZfXbcuMG4TCui8FEv5NUZozitRsAaIwfH65HYaxjM5ImOIOWA/nngp2l4DQiwUeG30+j5lpeJSMeGCsYvAGMLjyl8KDoXpO32Hkehu1Aqlnqve+7A2LGZ6Tud7I4KBbEtj43Jsi7OeDi5DXoSN+20c6oi5zEY+8sFl4h1SRqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 22:23:15 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 22:23:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Sep 2025 18:22:44 -0400
Subject: [PATCH v2 1/3] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-vntb_msi_doorbell-v2-1-ca71605e3444@nxp.com>
References: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
In-Reply-To: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757974988; l=3036;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BT6+zgjAtVSKd9hVY5H/jnZBBk6w9ntHvRBhofAzFo4=;
 b=zCwgGT80nBxj3WwonDIBG09noe8Ph/l49qxqpTIcmKSgr7/ZMVUC4Al0mFi+Vetq+DFUJhmGT
 rqcvb50vLjqCtE3vUQbbRLGKGhomrBLRtJZ4EoX5pJHK9bTBDtVu+24
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 6032f36c-2dab-4c9a-05ee-08ddf4a676b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVNaRWlJcnYraktBY3lVZithY1BnS0ttY3Vuc0I2dU8rWmxmSVhTaW42b0Nm?=
 =?utf-8?B?MmxseThVSmRXczJoSStSV3FRc1A2alJVd215RDJza3dqUS8vNmxkZFNyWWdi?=
 =?utf-8?B?M3pndEI0cGNxTm9RWkZ6a3o1T2pmNlpMOUkwN0ZYRTFYMjNoMlRoTnBaZnlZ?=
 =?utf-8?B?b1FsR015WkZNLzkzQi9BTVh3cm5KcEpKU1loS0lZRnl3NG5GQ3NsZ3pFMjVW?=
 =?utf-8?B?czNNKzJXRytoRFVqaXFIUzczTWpQN1FDbUN3K0hLVnlUaFhFY0JZOEJPS0tt?=
 =?utf-8?B?TEY5ZXN2ZnRXdmpHMDVWTFpVUjUxNzFXMmNCQmtBSjVLdlJ3TjNoQitHRmRv?=
 =?utf-8?B?UDJpaUtnL21kS2Y4TFh5c1F4VXV1WldZRzVSSElyb3BFZWlKdWRPUS9FeDZQ?=
 =?utf-8?B?d3g0Mnl3VWRTWU1aNCs3dnZVRVdEZzc5U09vOWFBRUtIY0djUXk0SWZvb21q?=
 =?utf-8?B?YmdkQTQ0MWNHVHg0cDk4aHpjUlpFQUdBWDBPTngvYWtTWk9OMURRSW9HUlhQ?=
 =?utf-8?B?R2NJSG5pL0RwanZ0aXJ0bXFyZFhVY216bk4zZnhtMUJHcUhxTUZobEZLNjZC?=
 =?utf-8?B?aXArbnM4UW9uOGxqK2JYeE41WmJYaUR0d0FxM1pkOC90OUErbFo2dWcvVlFE?=
 =?utf-8?B?c2RZb3RqS25lSmJOQWhYandKQkZvNkdFUE1BUlpCd2E0bVEzdjRnVWRFQkpw?=
 =?utf-8?B?RDlDYm01UnVJSE96ZDRJREZHRm9GQ1dUWGFvY2VHV0FBaXF5V1RnTDZBajNn?=
 =?utf-8?B?eU5heGRMRTVTckNsTkdPSEtDVVIweUtBNVZQdkJIM1VlVi9lT294YWVTVGZF?=
 =?utf-8?B?WlFqeXNCN2kwQWduZDFFbkZGdWUrRG5kc3VCUk51SU94ODhRWE96aXFBOUlG?=
 =?utf-8?B?TFNDcUlFdjhuWGd2NW5OaEZaQSsydmlJbWUvdmFONEZlZGdsTElVZ2t0L0l3?=
 =?utf-8?B?dU15L3NCdCt2YStmcHhxaGdOcytzZ3dYZ1gwb3ZEUFN6SHM3MVhmb01NN0Nq?=
 =?utf-8?B?S1JvbEFlMi9LQjgyVmx5c2ttUlhCTVhnbmJWYWVFbjd3Rlo1NnVWcVhmU0tM?=
 =?utf-8?B?THVzSzFISXhsSUNHNFdBRnViSjlwTkQ1RExYVVFQbjNtbk5lV01lWlc0STdl?=
 =?utf-8?B?U2ZTaWYvc2h1THUxMXNDc3gvcTVDci9LNldacFhBdkMxYjYwaEpqY045VE95?=
 =?utf-8?B?Y2c1NVA0YXl4UFpKOHBiMDltWnRXYXltcmp6cUtvR2RyUkQ3c1o0Yll1cFVU?=
 =?utf-8?B?RVd0Y3FDVVBnUnBxRGVHcjYyRUxNZzc1ZnNucG00MGtqNUVKWkVoaUU1dUZt?=
 =?utf-8?B?VzYrRjJJUmhDVGQxeWJ1Rk5VaysrWXN3cWp4Y3cyKzF4MmUzT3MwRmxTcHlS?=
 =?utf-8?B?bzBHSk1rZXR1Q3JyTE9qemE0R1kzRnBKa2JHRGJiYjZ6SDkwK2V5VElPOUwy?=
 =?utf-8?B?QTJzWnhQZHM1a0didHpHRThWTHpuckRDSUpUZ1oxU25IVnlUTlZEcHd2WUJO?=
 =?utf-8?B?MnNRWUh2WXhBWFBoU2p5aUdwcnVudHdzamZ2ZGkxMWlwbDFOR3l3RXhqK2li?=
 =?utf-8?B?TTAyeVhTcHpDeE5MbmYvZnNoMzR2VkRSSFUzMTdjRlNERkh1S3VhS1hYazY0?=
 =?utf-8?B?TTV5Yk9vb0FtV2FxY1NKUUtCOXVUSXVIdmU5VU95SDV3QzhTTksyN3V5aDZZ?=
 =?utf-8?B?SytQTFdJUDFLRU9YV3BTemp3M3FVTVJJRm5aVkdwdjE3eXpWdDQya2tqeEJE?=
 =?utf-8?B?UFczcW1BRUZyZnBUMjQ1ME96ODl5dU1xMHNpcGZSLzFyUks3cVVHVGtqbCtP?=
 =?utf-8?B?RlBTaWlPbS9DVVpyZExVaFJwYmFZNklLbFNGcDZFVmVNZms2K1FTK3RGYkNT?=
 =?utf-8?B?Wkt4OEdyRTZhZkhtb04yeTdGaUR1L1lTaGdoTDY3bXJ4SzFieTI4MlhhVktu?=
 =?utf-8?B?Y0dQZ3dBbHFndHBhQ1hNL25ucFhjdm5KSHhLVGltK085VlllZWI5Y2FEeDhz?=
 =?utf-8?B?T3VKcEpNMC9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RERJZTkrK2I5aksrSTdCdkExRnVZamluZ2JhMkJZVVJRMmJzZE9tWmtkbHhn?=
 =?utf-8?B?N2ZMU2owZXRyU3lwN3lBZkI3cTU1Z3ZES1FXK3dtOEJTT0VhbldubS90Z0FY?=
 =?utf-8?B?NzNBZGpzcFBzU0diY3VrazgrYVpCcm1OL1pRVUpKRi9iRndQQ0lrb1lBZG8x?=
 =?utf-8?B?V2l0d3owMUhuZHA4SUJkS0JnK1g4N1RPYUoxYTdXWmJaUXVFRmJqbEdVUVRw?=
 =?utf-8?B?YUJUcVJFeHc2V2tmYlB6a3VNOXIvWEI5SU9HT0trR2FPdmQvSkJnNWhRRWZO?=
 =?utf-8?B?TjJPSlM1czV0MDZZQ3l0eUNkdFVpbllGblNHTEtWU2x2MmZsVDI5RWVCWU94?=
 =?utf-8?B?clQ3bGhvUmYxRTNnUEV0anp2dDdjaXZOeWlaVFZWcXc3TEMwREczTjVXMnRG?=
 =?utf-8?B?NWQ2NG82Vytqb2EvZGNTZFB2QmtZN3RHQ0VGSWlVS3pJcGtJQjdncUR0cWpv?=
 =?utf-8?B?dC9FNFM2UzlqdW9ibVVQMUdreTVGVGlHNURMQVdOdERTNFZoQkRnU2ZrN2ts?=
 =?utf-8?B?MUg3KzBteUxoV2FzRVhDeDBjVlZqcEV2V2Z4U0xPZlNhNHBTaExqMFkwRm1n?=
 =?utf-8?B?YXZQUmRicWpLNFk1ZXBDL0RFMmRPR3hhT3U0VU5YYUQzM0NjUGs1MmxtSVZa?=
 =?utf-8?B?K2RPbEsvNHRLUlppZSsyQXNjNkZycmJWY2Z3NlRScTM4ZHd2c3NITDZaTjdh?=
 =?utf-8?B?RFpoWmF5MElvaHVySU9ab25DZTlYTHJJdVFBQy8yY09SN1h2bDdRWEhLaXFY?=
 =?utf-8?B?VnNHRjlXcFBtOHRPRHd6WHRheERPaWc1RWVsQlFNNXhpL3NIKzhscXhuS1pE?=
 =?utf-8?B?TXk4RW9KbC92OXFOdE1yNDYwd2NkUk44c0h2NkNDQm5kVW1WUS91b3YvZHg1?=
 =?utf-8?B?RzliNzd4R2V5OFJPbGFsQVoweVFiV2tYaXVtbDBudjIwQW1naytiZWl5a2Rs?=
 =?utf-8?B?aGRPOVNySk0rSzZ3cVpDelZQSndRWlEzYW92c0szNWVwL1g0UHVBZVUyMmlr?=
 =?utf-8?B?MmJ1UENyRHRSb1k3cDlOOGc2dlJuMXp2MWY1b08yL1ByT1pLdWJzMlJlMXhL?=
 =?utf-8?B?bGQvNExPVnhraUVZd2hSZlRqWXhJdTdJaWttQkNxbUtIR2hhUFZTcTNtM3pm?=
 =?utf-8?B?dktwb25zWXBXTDV3VFhiNWtOMjcyN0xrVWVkYzRMWk5SUG5NallpNVhoaTFO?=
 =?utf-8?B?SnBSRk94NnUyeVhMU1Jpa0k2b1FERS9udm1WWG13VmcxZk1TTEx5S3JlUXh5?=
 =?utf-8?B?bE9wakNDeDN0MFpyVVFLait5WkhtS0lRVzZ3eEY4T01JRUFjU0RwUjlPZUk4?=
 =?utf-8?B?NTlaemxsUW1IWWhkaWxvOEwrK3c1ZllXSllUYzBhQWEvbDU4ZlltQzFuZUJQ?=
 =?utf-8?B?TVpjRUV6UUllaVlWZEFrZXNvTmZrdTdtQ1c2VkxsRUlGSGxGN3VpWnMxeGlL?=
 =?utf-8?B?d0U0eHBUWTZYaVc0NWJVbVNtRXU0WmwyOSs1Z1VVbU56a1pVVzIxUThIUlhq?=
 =?utf-8?B?b203TUlJbEdxZW5IYWl5ZDR0dlVuZEJVRUNkSkpqQ04xSk5xRVRlUjFBakc0?=
 =?utf-8?B?MS9PZXAwNGNqbzdJaGpTSCs1WUE2TWtVODN2UjY0VGVyZkhrMUc5ZGRjRmxw?=
 =?utf-8?B?NGErOFJWdC9WNU1nZ0E2UDVQVGhxSmIwYnFUTVZsT0ZHai9HdnMwb3V0Ynhy?=
 =?utf-8?B?RldPZFZqM2pqNC9TbnFIbyswMkhXbzlKYlpSSHFUcW9HanBpUktlWnZzdGVU?=
 =?utf-8?B?WFNZVDMwVjY3VXg0RW9DditwTVlua3ArcVpoQmpycFNIYm5tejFPaHhhc3Rx?=
 =?utf-8?B?dHFyUCtCSHVHekt4NWpmSDcxZy9Gd2FJSVlXNGZLQ212ZFJJTlBNbG1xeHMy?=
 =?utf-8?B?dmtoMFgwNUhVQ1JjUUlHb2docWxCdkc0ZThMUWdGU1FuVU9DTjZqKzBTZHRn?=
 =?utf-8?B?OUZHR2d5N2grMm1tMXFUbWdvRytNOXBqSmJLbmk3Q0Z2N2FCT1E0SW9zcndM?=
 =?utf-8?B?eCtBaGlrNHY2b1FGYkNpTThvOHIzSHlmSjE5Q1h5YkNEUjdlbUxSRW9oZ1E3?=
 =?utf-8?B?dzJJdmNRT01nSkdKeHFDUmozWjBqa1V2WTNjejNuTmhvZkFIdllYYXovTEFF?=
 =?utf-8?Q?ps0u2kjGkwW7Y4pOY9aRhMEhr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6032f36c-2dab-4c9a-05ee-08ddf4a676b9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 22:23:15.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tYwap7GgAkbdZQgmo3D7zDTnUUUrXIWTXz2OWyvmcuKWk0moqfmj+qOCfj5g7MLJr7VGHUtD81l7RfNK6BC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
size. Prepare for adding support to set an MMIO address to a specific BAR.

No functional changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 52 ++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index d54e18872aefc07c655c94c104a347328ff7a432..4281067d4a62da6fbf6c2fb807b0f1b5afd1f45b 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -248,6 +248,36 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 }
 EXPORT_SYMBOL_GPL(pci_epf_free_space);
 
+static size_t
+pci_epf_get_bar_required_size(struct pci_epf *epf, size_t size,
+			      enum pci_barno bar,
+			      const struct pci_epc_features *epc_features,
+			      enum pci_epc_interface_type type)
+{
+	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
+
+	if (size < 128)
+		size = 128;
+
+	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
+	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
+		size = SZ_1M;
+
+	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
+		if (size > bar_fixed_size) {
+			dev_err(&epf->dev,
+				"requested BAR size is larger than fixed size\n");
+			return 0;
+		}
+		size = bar_fixed_size;
+	} else {
+		/* BAR size must be power of two */
+		size = roundup_pow_of_two(size);
+	}
+
+	return size;
+}
+
 /**
  * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
  * @epf: the EPF device to whom allocate the memory
@@ -264,7 +294,6 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  const struct pci_epc_features *epc_features,
 			  enum pci_epc_interface_type type)
 {
-	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
 	size_t aligned_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
@@ -272,24 +301,11 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	struct device *dev;
 	void *space;
 
-	if (size < 128)
-		size = 128;
-
-	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
-	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
-		size = SZ_1M;
+	size = pci_epf_get_bar_required_size(epf, size, bar,
+					     epc_features, type);
 
-	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
-		if (size > bar_fixed_size) {
-			dev_err(&epf->dev,
-				"requested BAR size is larger than fixed size\n");
-			return NULL;
-		}
-		size = bar_fixed_size;
-	} else {
-		/* BAR size must be power of two */
-		size = roundup_pow_of_two(size);
-	}
+	if (size == 0)
+		return NULL;
 
 	/*
 	 * Allocate enough memory to accommodate the iATU alignment

-- 
2.34.1


