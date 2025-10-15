Return-Path: <linux-pci+bounces-38236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0696BDF57F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 17:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63FB434942C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A5F2FD1BA;
	Wed, 15 Oct 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BoCr2Drx"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E42FCBEB;
	Wed, 15 Oct 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542077; cv=fail; b=DnNiCCewehpVDjDBT4hCHb56zyWGZSgDZTEveZaKoeClHivO7UcJZDTXzjOv9WweigQYt5D31Y5QzBfMBh03rWgOTKEL7D8TrsORnLcFt/fCPFx9ltz+ByJB5zv8OC8w7wHt2qwSkmrFKhNf9C2vRSSok2kiBgXJ7DxyY4OFEqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542077; c=relaxed/simple;
	bh=pzLcGLIsPRWguor8y1/TSOPrkBJvAnX7+40O3Kn5TDY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZyTGxSNh667W2j28zuGSxOjRtrAcSpKDpXe4IwLakBK7wtwNnO1gnogmgqPXENf3OSQxJLHx8pInnVOzdZCxbsaxJqiZp3nFfDqnQgYRIU61h8ROWYZBiOnNovl0Nu1tddeTrKDwClfTq9ddqJL5Ab6FIXPoOz0IVZNt32EC71Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BoCr2Drx; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0MPcV6uxGprr+T4kHdUZqBl9RThLmQ2i9IPUGHvr/VDisVIXCSAHgb4bc8GKYAiIeeqg1WZBuAoFfv3p+890ljGev5VlTCE9gXRWboGk8+BDd3GjRTDxFJI2a/e5M31GTH44YapDiusIMOC6Ob5w5A2rCPUSPEmD+wfh+HeNPcgpiG3aWAN8NwkVU69P19qOoawZLw2PRfC2b9CDEDcZdbYaP8PLlQVG0kYi5iiiIB1jrKdYJJem3qkS/rTX7sgAr1BQSsVvkihT4MfAG/Fbb8hNPjKTPE03pwQFxouradWdzkhrcZ0rYmK5CTIQiOcjXd2P9U5zXE9WN6OcCA5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gZrYiWqtpd9/KrCTTrkyrQLR1Og3EO7JmzTqwHlFyc=;
 b=rCIU86nQz0hrCORIHZ5kn60VHQhBQe0n7uuHwed52X4QaRam9UfIRArpALmyl1770FgW68yqt9HF0BZdHI6n/2Q3KV6gFGWnjlFIVx62VonIeTXdw4KYq9jRO2HEAu1B4f4dF4BGiCQAhxx5JTwt4wdm5L+qfwaZx2+3y1KHsKSPOLrIUGk+y1SOnsGKIEXjZ0er/JznnPgMc93df9pjpEBxmaIG9fUQVPbtePp8slFpqmJCELXcEQVm80JSiAHnjIV4kvwp18+7cvVEvRzJBEb9OWGvs82lV71ismZby9rxqYkISVR3uzvJn729q3u3jrAG4PLSntgDszXi44GKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gZrYiWqtpd9/KrCTTrkyrQLR1Og3EO7JmzTqwHlFyc=;
 b=BoCr2Drxyz35/n9nUJ0ddVl2TPYB8bRgzYo6WyfhxPFxGBE6aG0ZBIPLqgAkYxhgsFe+TIOjNy2aaWs1BGGmyiVE3QhrfLVYAlPYAP7i4+zGX2UINvle8ILV8/RtydHh0xL2dbzrsMHPbKt1TOIKYtds12DlFVxbXUujcX30pslOvPUPlJyr7C6a7mTf7pPq4pY1mjPR+/qNz58mzn2/BP+/yLz7TSykawtA5mU5K6SPkTFCoJjQXR5kKpGBk7UVNbQ+TyselAjqTWJZPzX/EpirzRQsoZlYXQhmG9LUzmc/ULJ2HfE4jPHeBj62CYi2M0KLDP6cSg2arMCZ/UPgSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM0PR04MB6993.eurprd04.prod.outlook.com (2603:10a6:208:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 15:27:50 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 15:27:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 11:27:28 -0400
Subject: [PATCH v6 1/4] PCI: endpoint: Rename aligned_size to mem_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-vntb_msi_doorbell-v6-1-9230298b1910@nxp.com>
References: <20251015-vntb_msi_doorbell-v6-0-9230298b1910@nxp.com>
In-Reply-To: <20251015-vntb_msi_doorbell-v6-0-9230298b1910@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Niklas Cassel <cassel@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760542064; l=3769;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pzLcGLIsPRWguor8y1/TSOPrkBJvAnX7+40O3Kn5TDY=;
 b=fyUZuxRJgcW5hZntNyhw2vCGIPt0d+VfTDXTzSBTYX0WnZprQIOOCK41vo3HHt7/IDN0euITo
 zXASBUHrzLLC7x83MWX6ePY2r32AygrC2lX0ofRZeEgd3bpFQADKlnm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:217::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM0PR04MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5dafa5-5cea-4223-c98a-08de0bff671d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXNVWThmWGtUSUt5UTFxN2VtdTZibDVmS2RnbU14NWtSSVhmYXZnUklic1R0?=
 =?utf-8?B?Ynl2SGFZdkE5STM0UFpuY2JobU4xYUZXc2hkL1RCSG82WUFtYnJmcFFMSklF?=
 =?utf-8?B?NXRuZVZRVUF0QktQZ0dkUWhrTjM0MWlHU3VlWi9pa29GQWJRQlpWS2MrSSto?=
 =?utf-8?B?U3NVQjZtaTV1b04yWG8wdzE3Nm0wUklRWWUvcGQyVmtMWkJlajdVWmxqUkZp?=
 =?utf-8?B?QUpyeXBVV3lsYm1MVjl1cHd6WkI3dXJDVlFURGtLbDBna1djdHhDYjhPQUJM?=
 =?utf-8?B?WmVDQ1pPTGdXV0tIdGxmSTdtZHE4N1c3WXR5UkdhQlRCajFXN2sxUG1DM0lP?=
 =?utf-8?B?eU1zRUM4MHNONGlTUStmZ0x1Rit6UVhZcHF1bW9FOWRsaDMrYUtVTjJuWE5X?=
 =?utf-8?B?eHp4VmVzYlQxRlB4YmNZL3V6eDFWYm1PV2VmNHRpZVFxRW1wVWdTaE0vQWt4?=
 =?utf-8?B?MndndUtmUTNrRkwzRVlnR1QwblZkY0tGWUFyNWxDK1kyTGd3SkJlYndZQ09h?=
 =?utf-8?B?VHFQeUh2a1Y1WFB1MWFRcGp0dFhXTmZjZDU5amVZS2dybVBrNVBxOHc1aDk1?=
 =?utf-8?B?UGhqZFcyVmRUZUt3TTJVVmlUWmJCOHpHb0pJUUlhcTZwek1GZXEwemt1aDEv?=
 =?utf-8?B?YndyR2hiQTZYWnZVNTlxQmEva0hoZjhWRzJKeU9KVUpJTkRnK3o0V3lUbi9E?=
 =?utf-8?B?QUtYT0c3UFhNWk9mNjlLUGlCMXA5RjBFNGRqSGVSbkpYNWNFRm1UeUtBb2Rj?=
 =?utf-8?B?Q1hkajRHMXFaYU9xWGJZSTNIQTdWdngyODhVVE5VK0pmT256ckROU2ROR0RS?=
 =?utf-8?B?aHpMKzgvOXV6Kzg3aDZpdDBSbUlIVWtKdllDS0NkN3RCNjFId2FjVmZva0cz?=
 =?utf-8?B?N1FEQzVGQlZua0F3ZFJyQ1IwNFQ0cjNYWmtVWjA4cGE4MXZRWUhEc2FNVkVQ?=
 =?utf-8?B?cEZzMDdlcEhmUWdCenJQblRwSmpocHM0ZHJxMGpqcTdVZG0xSkVxaHljaTBL?=
 =?utf-8?B?UG9RYUZDWDcyb0dUUnNCTm1oZUU2VmJEY3RYYlJnUWR2UW1sajZscmprby8x?=
 =?utf-8?B?Q2dFWm9tdk9VVUtrZlU1R0p6RnQyV0wzb3YxTzl2ODQ0RzZsUWNPMjBYTS9n?=
 =?utf-8?B?MElnSnZOS2ZodGMxRGxzQ3hnSDM0b0JPQnJoL3JrTDlDVURjZFJ4cWhyQ2ds?=
 =?utf-8?B?ZkIweXB5VnFZVkI4ZzRmVENab1AvSFkxaDdiNk42b1M2SUVOMk45SXdHRVZI?=
 =?utf-8?B?ZTJ1OHc3QXV2aXB2d3FCc1B3T25Zd1hmcHlVQ3hKdWFpeHZNcXoyd2pQQ3R3?=
 =?utf-8?B?Rkg0MUkwNFJvMFFFU005RnZxem01SVhWbURjc2FoTURxRTdWL1ZQQkFyQWhK?=
 =?utf-8?B?cEdGTFRBdVZMM21ycWtveVM1dnFOVGVMZnFSMndtdXZ4SDVMMjRtWkV4Uy9O?=
 =?utf-8?B?bHZtQTdBbm9MVGYrUjUxSUFKTkdGSld6MkxsMHplNzd3M0V2VG5qeWkyYW1L?=
 =?utf-8?B?V0VxR3lGT2xaT1hhWXdKZWV4TkJTR2pvKzRObEZYOUo3bUtBSE9OUDNKV1lU?=
 =?utf-8?B?YTlVaUwrRHg1V1I2K1JrWjNaeDBGb05qTmhpdnpsMDVwY0d4S1FYRXZkYXRV?=
 =?utf-8?B?eU02UnQ3RFZtaHd0Ui9IWU1ZZy9IYUY5bTJiRGJmYVhOOEVsdHRMWEs4amhZ?=
 =?utf-8?B?VGVzY3BvZ0ZSVktGTkhicG15Z1EzZHg1TnFiVzBORHl1TXRoSUpZZ1h3bHBp?=
 =?utf-8?B?RnB3czZwN1E3YkI3VlY4OFpCSVE3UDFMOHpvU2pwMmhZWm4xN05rQkxFbmFu?=
 =?utf-8?B?T3VsWDM5ZmNzUHZQZTdscURrTDJDY2NLU1l6dlk5MGdrNjBhM1VFMzJOOE84?=
 =?utf-8?B?Y3EvcDBVOEU5RE9ZTHIvNk9IS0VvZGpRZDhjc0lZOVQ1RG5EUk92QzhpK1Bq?=
 =?utf-8?B?dzVjUXo1ZVRYeWYrWUpCR2E3SXNjUmFkT3FhLzBnNmRpN2tiNHNRWExySk9h?=
 =?utf-8?B?d2Urbm5WaEUya2tJMTBpLzRnNUExTlk0WFIxb2hlMGduVE5HaHpBdVlrM3NS?=
 =?utf-8?Q?BYUlO8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEhoS1VNNnFyRXU0SHllaFBiSjFpQzNJUEdTc3UwZnhjNmxtQWpPK2x5MGRX?=
 =?utf-8?B?OGd2NGhRY3FxRGJWN3VVRkwrTGRzYXVZdlR6TjlCZTBiN1ZrSkhSbXlMaGQ1?=
 =?utf-8?B?L1c0L0lCMkh6bmF5aWJnWXl2bUF4MTZVemgyNW1wTHdxN0prTFcyQ3VwVlZD?=
 =?utf-8?B?MlJwU1lsZW5iWW9yZE9EVzVmTS95djA5NEVtZHZPc1h2TW5uTmJhdmtEbm9R?=
 =?utf-8?B?akpWWWtpQmZuN2dJSHpzMW9SNXhIbWNSY056MVRZb3luMnN0SzFtQVFvNEhx?=
 =?utf-8?B?NVIxbmZxZHRVd0dROG9QQ0IvdFhiUmxuYmlxZjkyWlVYMnlTT0tNczVZcURl?=
 =?utf-8?B?TmpMZ0UwRjhxaGVUaFBUbnkzOXU2Y1pOaFlJZVdhS3F5cU5hSlk4L3hqeUps?=
 =?utf-8?B?MWRsT3RRYTRVUEdjZFB3dVFTUCtaMngrSTZLazlQTVdDZlJxREdrVFpsNlBB?=
 =?utf-8?B?RXZ0L0xKUXV6WlVjN2JaUHZyelZZZHcrcmRFTnVZQzZuZFhNVy9RU3VqWHg3?=
 =?utf-8?B?REN6NkEwK2ZxYk40ZlE0eE1XMHNlSUN6empPUE5LZGJzTlZtQksrTUNoZDhw?=
 =?utf-8?B?Rm9ZYVRTbmxla0orU2hxeUdqTnlZcHhDcGxlcnBGdG44LytEQmcxZDUrbnEv?=
 =?utf-8?B?Yk9hZUkwc243ZEloY2wwRnMxSEg0OEYvQW81UVQ0WEVJdUgvOWxsV2M2eEls?=
 =?utf-8?B?bEs5RkVMaWFlUHZRekk3bnVEVXhsa1hUeTFpRGFQMFgzMUlOSmErTXNlejE0?=
 =?utf-8?B?OUlkdVdFR1Arb0lNMDh0WkQ0WnVaaTBKanBLeDhxamdWNGRlakU0dy9Pb2RT?=
 =?utf-8?B?U0xTcVYrdFRKbWlRZzRjTmJrbFZ1MjZBQU9FZmRwd2V0em5iVytuL3Yzbm5G?=
 =?utf-8?B?QTh4cnhnNVVkTmlIckN3aGpSODUybVd1OEFBRkh0WjQ2aGdoNTRHZ2cwZUVa?=
 =?utf-8?B?U1IyVVFWaVJGWWM3a01UK1Vrc0ViZytxNHlDZlQweFhHa3hNV2ZTbDVhYWF0?=
 =?utf-8?B?SkpFbTJvNE9UTTFWR3F0TXJzbW5PcnoxTUVsU1NhSXZvTzJIMmlqSVBybms4?=
 =?utf-8?B?RkowNWRTanBvWE1ON2JtckwvQlJEb2thcWwxWVgzUlB6emxIYUhac0grYncx?=
 =?utf-8?B?Tk10dDhVTHpTZkEwOGNFUEhQWlltalRKVXU2dkVJdXVoVEdVNEU2dmw3NW1O?=
 =?utf-8?B?ZXZSc1VDNkZqbWJpSDZvUGoyd0E5ekRUbmdDTy9pbncyTHFKWG9TK2crK0V2?=
 =?utf-8?B?dXVZd01CVUh3MytjVjA1TGR4aEdOeFNYQndzTlhicDVnSUNscFdlOC92SjBU?=
 =?utf-8?B?TkZTTEtXTXBiVyszcUNJUUVLSXlIZVhGMXlCNndyZTVSMVhxRGFxZkp6SEpC?=
 =?utf-8?B?eFpvd1FLMkZJT1Y1c0VPdk9aYjdJRW5NSWdjVG91ei9CWFNLd2hTL0dnSEt0?=
 =?utf-8?B?MnRpay9aOXArYzRUYnB0QU9nOWJ6Vnllclp6Mm4wVkdIYVM0bk1OL3ErdWRI?=
 =?utf-8?B?YWJiOHMwZUZyNFRQWXB5RHhlZWE5R0VpRzYrNDJVYTM2WUNhV0tzaTJydlJ5?=
 =?utf-8?B?VGJOOXMzWVZZcGdCT2lnWHorZys3RGdHR0c5UTFqZkF4d01KTTR4dWtsSHJm?=
 =?utf-8?B?eUhsWTlxZVVyNkRscW5seXRXV25HVE5zNlFnQll5ZGVQZ2pRZXZtck4xQlY5?=
 =?utf-8?B?MVh1cVNGS25yUmUzQktyUjlFWnZpdDBiQ2dheUp5bTJ5c1gyK3VFelArSEdj?=
 =?utf-8?B?QlB5SVlBdDF1clFQLzRMU093ZnkxZDl4ZmxHMVg2VW5BQzJxK2huSHhtbkxy?=
 =?utf-8?B?ajg0aENVcVZSTzlQUWxTQ1AvdUNLV3RUdnEwQW5jSCtOdXIvSUlFY3VJcXNv?=
 =?utf-8?B?RUNOOVVNdFNob3pYVzAyd1dPejhZNnBRdnN6QnJDU2piOTVxZkVKZlF3ZmI5?=
 =?utf-8?B?OSs3SlVMV0dBN1JRc21SNlgrb0M1UFZrZENJamhBWTRQL2Y1QXluQjNyaDZI?=
 =?utf-8?B?VGFBa3VPRnhReXI2Z0RVSktVd2NqTnVPQURaQStjcEJkbzVWcVl4bjhDQm1v?=
 =?utf-8?B?d0tsbUREOWFjak5TVUtma3hRV3pPTjJRN2t4MHVIU215aDFvbXZCRVUxVGor?=
 =?utf-8?Q?Wp5WQK03kySqkZH8BNagso7T1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5dafa5-5cea-4223-c98a-08de0bff671d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:27:50.8860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNAKtYXZ1qB2McUoH810kwxJXAwrd7ianC6YlfWrLrPcOBhViiTxR1N81Lf/+a7kMqYoo/0HMv1e7PNDML3hmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6993

Rename the variable aligned_size to mem_size to better reflect its purpose.
'aligned_size' was misleading, as it actually represents the backing memory
size allocated for the BAR rather than an alignment value.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v5
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 12 ++++++------
 include/linux/pci-epf.h             |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index d54e18872aefc07c655c94c104a347328ff7a432..214e3f6e6d0d5a216c3469b8ff47908414cd1286 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -236,13 +236,13 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	dma_free_coherent(dev, epf_bar[bar].aligned_size, addr,
+	dma_free_coherent(dev, epf_bar[bar].mem_size, addr,
 			  epf_bar[bar].phys_addr);
 
 	epf_bar[bar].phys_addr = 0;
 	epf_bar[bar].addr = NULL;
 	epf_bar[bar].size = 0;
-	epf_bar[bar].aligned_size = 0;
+	epf_bar[bar].mem_size = 0;
 	epf_bar[bar].barno = 0;
 	epf_bar[bar].flags = 0;
 }
@@ -265,7 +265,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type)
 {
 	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t aligned_size, align = epc_features->align;
+	size_t mem_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
@@ -297,7 +297,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	 * it might be different if, for example, the fixed size of a BAR
 	 * is smaller than align.
 	 */
-	aligned_size = align ? ALIGN(size, align) : size;
+	mem_size = align ? ALIGN(size, align) : size;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;
@@ -308,7 +308,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
+	space = dma_alloc_coherent(dev, mem_size, &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;
@@ -317,7 +317,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	epf_bar[bar].phys_addr = phys_addr;
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
-	epf_bar[bar].aligned_size = aligned_size;
+	epf_bar[bar].mem_size = mem_size;
 	epf_bar[bar].barno = bar;
 	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 2e85504ba2baf93827224884ca19ae2bd0e6906b..4022dd080e20f2959f3a5faf4cfe054ddb5856a7 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -115,8 +115,8 @@ struct pci_epf_driver {
  * @phys_addr: physical address that should be mapped to the BAR
  * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
- * @aligned_size: the size actually allocated to accommodate the iATU alignment
- *                requirement
+ * @mem_size: the size actually allocated to accommodate the iATU alignment
+ *            requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
  */
@@ -124,7 +124,7 @@ struct pci_epf_bar {
 	dma_addr_t	phys_addr;
 	void		*addr;
 	size_t		size;
-	size_t		aligned_size;
+	size_t		mem_size;
 	enum pci_barno	barno;
 	int		flags;
 };

-- 
2.34.1


