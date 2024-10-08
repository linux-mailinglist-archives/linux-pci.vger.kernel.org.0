Return-Path: <linux-pci+bounces-14001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8136E9957E8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 21:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A529C1C21CD4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448D021500A;
	Tue,  8 Oct 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LwYHvNR5"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF92213EFB;
	Tue,  8 Oct 2024 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417272; cv=fail; b=oAzxqKfD7nPXfgHKkHchdyTCyqy1OhOE2rVqpMl/ngkt4UFKslT5t4IffYzms3na0Q7aytacpD82N219S4zHnTs1PeUkhUyw3QV1YH2vr+a0w1jf0PZHtyG4STjKW/jXpHM9XZVo6TgbUVYi0OcMmHSaQVyI40/lvWD4OQI8EOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417272; c=relaxed/simple;
	bh=6lzXCmq3a0nuDAFW89s/3o0ihCyVHX43B4MeidRoOSk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Xacquz0oNBxRVlsj2/ppW8ETsW0uHvaZUZ4c3mT2rXeOZN+ja197Fgsx6ZMa8fT+DRO7QyieNnfN1oKmD3heQlpPvQ1RBH7kzZNHvV4Bo9rxrVsTjZ2TNUunY4WCW0FHNg0bE+7iQwSRfZYVWMcj77+6p6qyOPmeT16fQNEOe+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LwYHvNR5; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHFZK2cYIVChOGZd4oig+D50cGf64cvl6Ya9atQXEQ8fpSGala58NMc7FMG9EccVO4X8vZc6TItxYVyVKS/XoimhFXd26D7nGutGYuq5u3IThel1s8jZNUKzpXOQskfw65yI3Nne1s1rvOM23uW9eiizNMe/q3tPSzY0LjtDS7n7ceLbNVhgAtpPrWyDFpWpTIj85xfXIy4ei0wlbyTpvKmqhtWbySjNj4bxwN8/0vSyeX6UAlNSMjP75uYARFJA2orEH3KVaqZ2p9fCq5i2Gq7yq4b76ojP+zPRlkx13yxmwsW1OTGMSlulrVYuSwqdx73Tq//BP9RMsqoAPbUC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33uAPZwvH7h5pgdZmtVwE3KTxsUxxUoGDbfjmVnW3NE=;
 b=JNN7f2gK5sHcx+OR7FaE980t7x0Wa78Z7GRCd7OhyOGC/RIHXdmvXYfLhQZV7mR4RSFxlBEIDmzCPftL90B1VQ+ZNTp170E1m9tU/Qxb/z9VeWDZ60MoRVJY7qX0ZXO7QcNCe5jKIgPyVIuTaJKxJN/k4vDpl8F/r9mvubuvHKNV//nHKQhSgxv8Xgr/FzBe7ZkT3W4bvQMLgrrg2i8P1x+Eu+dVdaPfPtBfnFmON7HlKAMvOZOOpcouEUKtChQpZYtu1UyztVgrr0AnARVIhZ7W1dG4jwf1k1uumNRfOibLyKZip7E0qtdHa7iGd7W420T2gR/eSU6oSCrmA9Crmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33uAPZwvH7h5pgdZmtVwE3KTxsUxxUoGDbfjmVnW3NE=;
 b=LwYHvNR5Et7Jy50c8YCBwgHZffigIH0+kwc77VVMkyi10o3m9JO+YL+TKxdgr6abnp4c9sozlhc20C/BQh4Gtj9Zze1TIxiyDKnNgOnwJ5jEOIFI7KIbAV27M0wJAiYekqrMSgF8lMH0ErDX2TU+4m4+3GTrbfLXkYkiH7abMWBXrSpfekHavRj6CxFEg6zCdY8XwyMfqYoC7bRZkVWgTAq+2ZwvaLoH9suuyHiuu+lvCJQ+phMgONuAgM8sj3bk7MdvdDzq8xVwcSrqmDiEdDNJ9sseJU/pEY0I1K61OaQ5rCaypgiQDlGseuhZvd1g44xJwRL/KELuHk7YGv4Trw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10577.eurprd04.prod.outlook.com (2603:10a6:102:493::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 19:54:29 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 19:54:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 08 Oct 2024 15:53:58 -0400
Subject: [PATCH v4 1/3] of: address: Add parent_bus_addr to struct
 of_pci_range
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241008-pci_fixup_addr-v4-1-25e5200657bc@nxp.com>
References: <20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com>
In-Reply-To: <20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728417259; l=4582;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6lzXCmq3a0nuDAFW89s/3o0ihCyVHX43B4MeidRoOSk=;
 b=l47AOoAmiJoxrDG5/o4piSsM3sOyKS5HTVtwlyfdahw1RGw5bzy1NEL6FKAIS6md/pN2jNFLU
 6dKtMIieij+DiKgmDTsWQ6qfQA5WB0e/9ocaj3fKfu/md2yijG5h/RT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10577:EE_
X-MS-Office365-Filtering-Correlation-Id: afaceb21-3007-4e12-1eba-08dce7d304fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGF6M245cllWd2VlNm9BdHpXRzg2bWNUUnV4UDZHMFFQVStxSnVCakZNNnFG?=
 =?utf-8?B?RXFCQzdXcHV2bnVxeThrSDBuNit2NGVKaUp4NDVBSXFJYVVEa0Y4dmt2TlZE?=
 =?utf-8?B?ekpSeVJJYURpSnVxeUIycWFSN3NvcHhGVFFrbHJ3SWQrYW43Wnd4eEkrdWp2?=
 =?utf-8?B?b082TDdFZDRjUEdiNVJsREtoQTNSY3BxdG9yWm00NE5nRUVuUXBvaS9WL010?=
 =?utf-8?B?ZXdPeDNKSWNGcDhvdVY2SU01dkt6ZmZaNHZqYkkyK0h4N3RLVWxrdDNjTTFH?=
 =?utf-8?B?NktyTVhDUlpkU3ZhdDAxZjhvRjVRbjRNWHZGVTR5d1BjU3NWYmxjcDRBbEVr?=
 =?utf-8?B?YmxjaFMzM2p4R2FHVzJTbXBBRm9yd1BHNjRadlZudEFMcEpnMHhIZGpHekF2?=
 =?utf-8?B?S2d4WDVvUUNBRXZRVnJXRlQxcXdJRWczdC9YYjQwK1ZvVWNMb2tuVThGTTlh?=
 =?utf-8?B?OExMUWs4NTA4VGNpa3VZWWlWOHRiM29KdldKR1RXMXpHa2dWWEVqY1VjdmZQ?=
 =?utf-8?B?anh6WWQ3SkNKWldyT05nWDRtTWFLQ2o4MDhMNTNaQmZheGlHNkZPYnJGVVE2?=
 =?utf-8?B?WlVGa0pWaCtudDlJY3ZjYzNWRlJiVFI3VkR2QVRRZHI5N3NZRDZ1eXBIaGhw?=
 =?utf-8?B?cTJUcUhVTmdVbGVYWk1ONVFxdTBCSktLclViU05EeUR4dTZDbDExOXpkSEtY?=
 =?utf-8?B?U0h5bWVjbEFlc2sxdm85MzdjdXZld2VEMW5GMnBHbFltbitHWTMzSU5HVUpo?=
 =?utf-8?B?M3FSV3JLMWs4Yzh4UEpKdUc2Wlc2V3ExY3c5dTB5TjBiOXhMbHAxUDUrZ2Fo?=
 =?utf-8?B?OWRxeVBINGxkdExCMDBoUDhqdXluaWVZYUlFOTA5OS9WYmJNOUx3ZzEvdjAw?=
 =?utf-8?B?NGhOSUo1bWJOQWFKUnNGVExScHg0eDEydHhJVXRwcXNXZ3oxUks1bHVqZ1Y5?=
 =?utf-8?B?ZkJnVEozWGNjc0FkUFc2SjRNUmRCOGVrQWJnWnJwZExYSkFDMC8wVnZuemw0?=
 =?utf-8?B?eDZTL2ZLNUZobWJBWTAxTHVLODVGcWdFRkh0bTRXdmYyeEEvOXRyMkJFbGV1?=
 =?utf-8?B?U3FkWTdOakkxRWRaSitmZmhuTi93SWlndDE0Wm5udko3SEFueGtnRHpJYjFC?=
 =?utf-8?B?cHl1TW9rRWdXdXJzSTZhZFlvc0ZnSEFJc2pyUHpXYStSa25WSzBBTHgvUzcw?=
 =?utf-8?B?bUNEWmphTjAxZVhLaHJhSXR6WGhtQnBxdVJxZmY5N2NITGJtcmFtYVByTkVa?=
 =?utf-8?B?bWRIZDJOZ2ZFd0IwTlMxMTQzZDBtZzV6Y1gybjZkZmdOR1hTUlRqTWpSUnlw?=
 =?utf-8?B?TVR1eEpGY0s2SkE1SWNsK296aHUzLzJ2UGZqMEhSWUt6R0U1Y3FCSlBUSnA1?=
 =?utf-8?B?VWRVcXN0VVhlRzRWQW1DY3piR2IyYUlLaEp0L0ZjcWt3b1U5QnA4L0tkbGpR?=
 =?utf-8?B?aFBGOVBCNzUrSy9RTTFrZGlsM2FtcnZ1QTNPc3ZhUW1XRGRiUW1DQWV4aXNC?=
 =?utf-8?B?VXhKNXFpT2dOd3hrdjMwWmlUSENyRVpUR1NCVzRHUGZ0Q2pHb2txUVFyanVQ?=
 =?utf-8?B?SlpNN1pzTGZPblhySTFIVk96YTVGWHNkcDE2aitpK2NUb2ROL1BQMGtjR2dX?=
 =?utf-8?B?NnlJbzVaM3Z1ZjNrTDdJbzFBZTlVUDI5VXVUZGo4bUs1MlMzNnNZZEsvY1li?=
 =?utf-8?B?UDVvT1NlcjJxTjY3ZUhMczVtc2FrcTVQU2ZtRWxGcUVhbVdWM0VsVnhqOVZP?=
 =?utf-8?B?OHBvNUYxbGZ4MTEzSWFiQ05sN3h4OWUzYlpEK2R6WDZHcjd2TEJCek01dWZ6?=
 =?utf-8?Q?DTvgzKU5WPYGqqmQbLpUCeedGVqN8CpWRa0gg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUpQanUwdzJxSERZZ2dUOWY0RkgvUjk0a2t6WGdzQzZYMjkvYlpaSWxFVXRH?=
 =?utf-8?B?ZGhRSnhPZnlFdGY1UFBadkVIVFI4SjhzSXBtL2kwdkZ5Q3FBdVo4aGNGT1la?=
 =?utf-8?B?cThMRWJGZ2FQZnY4OER4ekJvd3ArQk5WZ01Lb005ZU8xWGIxYXd0emNJWlRv?=
 =?utf-8?B?NkdObkdIczRHRlU3dm82djd1WmQxWFU2eS85eDNmQWpQZkQzMEtTRklWZWRj?=
 =?utf-8?B?elV1V2hOSkthVkpPVFp3MTRrcERJdENyajhxMk85SlJYRDh1elNQKzkxVWZz?=
 =?utf-8?B?Z1A1ay84YVlBanlSSWZGMVpCekRGcFZrRHloYTRKVi8zS1pkYUpkRmFXZU5m?=
 =?utf-8?B?RWEzOUhlODI4bi9aRDVRQVBZZENMUlRuZ0tXeElrMzFnNlN1QktIVUVia3g0?=
 =?utf-8?B?MFdOWmJZYzdmZkNuUWZQMHYwZVRwQkRQbDNkWGxDQ1BrSGYzQ2ZFZzZRNlla?=
 =?utf-8?B?eFpIajVLdS9IcEpvbVRaY081WTBCaG5oekpva0poOVpiNnpzQ0pFbHl2bVBJ?=
 =?utf-8?B?eWRodThkOGNQbXlkdm5VTFZ0Rm9HaGdUdnA3Vk1WOVh3UzJkTk9XTWtONDBE?=
 =?utf-8?B?UWF4UVZkR2xpdHdmQkEvZHppOFNTSXpoVWxOdDdFWXo4QTFlYUw4SFVkbFha?=
 =?utf-8?B?eU5tS0YrampJeWpNS1hNR1BIS09iWndWZW55NlROTW1SbGcvdG8vM2pCeU41?=
 =?utf-8?B?NVJhZHQ0T1lIUnprQUo1bTJnbUhIRUM4dnNWbG40cXVUeDUwTzRiendjUVN4?=
 =?utf-8?B?RlhUNVE3WFd6M1B1UXJZUjBTanBDeFFKS0xUcFErckFDalV3S2FLdTdmUENt?=
 =?utf-8?B?ZkFNQTY5TVFVSkowWUZ1alJ2ZWl6cytSeEUzdGdyQmEzVDdwVVlRMiszbWdx?=
 =?utf-8?B?eXlISFllcFJvYmMxaWNPZXhXbE1oOHhJNUZXcnNhRGhVb2xmSTFON1dtT1FU?=
 =?utf-8?B?MmpaQXFJekVZdmFKeFpwMGdOZVFMLzlTUlRaV29na0VuR1VkYVN4YjlqYXZF?=
 =?utf-8?B?ZGdOb3lXMXJHMWs3bnUrWXFDM1NYM3NTcmpJdXIzSzk3WDhqV3I2VDdTUWNz?=
 =?utf-8?B?aFBlWDZaUE1KTW9LVlhzZ3NBN0ZLckxoR0ovUm5FY1IzbTl6UU4xSkFkakdG?=
 =?utf-8?B?MWpBOUdtUk00Vm91UEo5cFhyNjBGWkk4TnYxaG5EOTlFbkpQWlEwMEI0OUZS?=
 =?utf-8?B?emVQSGxWUncxUTRhSkZxTFZoT0EwaUgxcm4wTVdOd0F4VEVNZlViVG94ZnBW?=
 =?utf-8?B?YTZDbkx0YSt3WnJVZjg4QlVqSWhVMXVVWFE2dWIrVExEcW9YWkxsWDhxcHJV?=
 =?utf-8?B?S3FyQWE4b3RBYWN6V0ZGVnNxOWc4MjRTRno2c2xJd3drUmo4RlUwQTZKaElM?=
 =?utf-8?B?enFEYm90UVFJdjZtaTNZd3ZMQ2JORE90eXRKSnV4b1A4UlNHVGFzRVNKN3gv?=
 =?utf-8?B?c01RQVRPYXlxcmJtdkNrdFFya2lhWXQyVU5Rb1J0NVF4TTY3UzBJdEJHNmta?=
 =?utf-8?B?WVdRRkRpUlV0OEk4bGY2Y2ovaElKNHZndDhNQUd1ek16VWtYYURMaGV2bENa?=
 =?utf-8?B?Mk1Tb2VIS0Q2WU44L2locXdpRDdOQXQxZFZWWVBwQ0EyNGx5WXVObmxSMG82?=
 =?utf-8?B?L21HQVNjMmZWNTQxYytsY3hwb1V6eTRDYlBiTWxKeTFGbmpkcGd1bVIrRDNm?=
 =?utf-8?B?Y1dSc01LbFlRYTlrTW4vL3lQU1FvVXZ1MVVqYnVzSG1pZ3d4bjFwbmpuMWNG?=
 =?utf-8?B?aCtRemRabnRIck9kWHZGd0lkSGd2dzJGOXdnbFpyVDM2WGR4QXp4VUZ3UEo3?=
 =?utf-8?B?VTR1TkNvbCs3bTZ3dzkzaGpJUzBSdk0zcjlkZk01TkpzcHBqMWd4QTgxVHY5?=
 =?utf-8?B?NnVqZ1UxMzN2TXZtSURqbEZEN2pJQngwaGZWSWNua0k5YTRxb2pjMExmcEdx?=
 =?utf-8?B?Y1JTYnZsK1phNmRsb1BiTHlZVlBFbi94STk0d2NWMHdpL2VhM3l4YVBGT09C?=
 =?utf-8?B?cUZGT2JZY0tDT04vd3ZJT0M1OGFSaFN0T25JMm1OSnNBVDV1NUdSMkpUOHdR?=
 =?utf-8?B?NHZMbEJkYVN4Z25FSU91L3JYSmVhelJLTTJqQWNiRmZDTTNtVXloN09kRzZi?=
 =?utf-8?Q?qrMyS/7RdkJh1kEgIapT4HOzL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afaceb21-3007-4e12-1eba-08dce7d304fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:54:29.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVcQNdLmntIybsrBmYkwFNESf9oKZzm0DzcKQOveY8w/JOsppZzRO96nDmWxcwUUkYrRlCiPJH9lbQNx6xfTlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10577

Introduce field 'parent_bus_addr' in of_pci_range to retrieve untranslated
CPU address information.

Refer to the diagram below to understand that the bus fabric in some
systems (like i.MX8QXP) does not use a 1:1 address map between input and
output.

Currently, many controller drivers use .cpu_addr_fixup() callback hardcodes
that translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR"
(drivers/pci/controller/cadence/pcie-cadence-plat.c),
"cpu_addr + BUS_IATU_OFFSET"(drivers/pci/controller/dwc/pcie-intel-gw.c),
etc, even though those translations *should* be described via DT.

The .cpu_addr_fixup() can be eliminated if DT correct reflect hardware
behavior and driver use 'parent_bus_addr' in of_pci_range.

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff8_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff0_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff8_0000─┼──────┘  │             │   └──► CfgSpace  ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► IOSpace   ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

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

'parent_bus_addr' in of_pci_range can indicate above diagram internal
address (IA) address information.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- improve commit message by driver source code path.

Change from v2 to v3
- cpu_untranslate_addr -> parent_bus_addr
- Add Rob's review tag
  I changed commit message base on Bjorn, if you have concern about review
added tag, let me know.

Change from v1 to v2
- add parent_bus_addr in of_pci_range, instead adding new API.
---
 drivers/of/address.c       | 2 ++
 include/linux/of_address.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 286f0c161e332..1a0229ee4e0b2 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -811,6 +811,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	else
 		range->cpu_addr = of_translate_address(parser->node,
 				parser->range + na);
+
+	range->parent_bus_addr = of_read_number(parser->range + na, parser->pna);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
 	parser->range += np;
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 26a19daf0d092..13dd79186d02c 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -26,6 +26,7 @@ struct of_pci_range {
 		u64 bus_addr;
 	};
 	u64 cpu_addr;
+	u64 parent_bus_addr;
 	u64 size;
 	u32 flags;
 };

-- 
2.34.1


