Return-Path: <linux-pci+bounces-37013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D9BA0BC2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 19:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79DB3266BA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E37C3081A9;
	Thu, 25 Sep 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TNmAfhnS"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFBE30C604;
	Thu, 25 Sep 2025 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819738; cv=fail; b=EKORWDg0j6Ltsfq8/J6rUjk6IWO7qnFOqARfEmeJjZci7P2xqszixDCXkMbLFDoT/p8wqSEGtV5NIu+CVWhR3WqaFygn2pIheZRPdtIdeXgy5/1GowOmvlZSqirz/GSHBbjiUbcAuooTDq3Ef6vGVxkKSbXI3dwZrN1g2OoGmzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819738; c=relaxed/simple;
	bh=Nd4XpE7/0j9KIEWK5Qkml7AvuVRhcxYwKi7CApeTj00=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qXaQD5m2T/mANPFr0UOReerGtrpg634+mmvaXevCZJQrKbjqR4Cpcxl1ylfoWI7MG+ZqU6jGSYAgjXNFolDhBULyZOvWjTepayvd2UP26kjC6emS3QNlSpFdNnS4wh+IYk8ZfVBETmT2eCFGKY4J6nRE0ZrJNXri5uh6PZ+oZt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TNmAfhnS; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHCmLaysnCSDBJmihAjU7CBpYgsY7x9cWz1ZXc/YYovw3ssChlywLarFfTePaU7XbPNcjchNBUwykCV6g+tV89MXHd3fwKPxLFv7echH/nhLrCIdPP2/wl6+wmIEzxUFMiRIysI9cAL1L+s6oI6yFCf+0vw/DgDqL/Cx6QDBo+vttfabwI6tWvhEZEmn6IJ+LiXpHii9KxZVA4/oGJcKPmJ6FeVf4oJVA72wMSKjywfh8uYMGuEFByB/afpxBoXW5k6Oirc2vpHMEOvUx+GJKxnTzCWOhEuMbvviQ9ZL1Ux97qrcoBx8NWqvbZxXH2HkknZIniKqUmC6mM7z4o0tKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmBaGKDznjN2pxUGivK/QScu8mk9xNFnhlV5Q6S33Jc=;
 b=BMR+NZtsaPmJ+ZmBmMZAabXvIEm6RWjYvTre1Al5rTw4F+y2qEzzAAsK4xMOY4pvc/nORwiiE3ab59n5iwQAIEhqQMby3W6bjxXbRT0APaOaXlLdBcUnW9BlZgN2G+ugaDJ8DgcLI9NYKuoF6pa/XEzw5dvcLKmxGga5Scyl0A1OEwespFqpklLTVtxaaQQKk3C71JJthliYZhyQ7B55CZ5ITn/F8zlJHmQQYIh7LlV89B+ariGw/BqR1xA9o/n4tUOhRKNczlJm8JIfEXSPiG7jxRt9G9221Ytd7hzrI1r49JpNg0gmQxez0KP0KSFqBIWttdbAfBcXKne+tnkHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmBaGKDznjN2pxUGivK/QScu8mk9xNFnhlV5Q6S33Jc=;
 b=TNmAfhnSNp/aYKXbFUiT8C3r+Hovb34iyElmf/laLRmtsJmfGIc18Y/ki6rDZW5J85i2M0C0WuOdRV538c6DR0BfR0f/Y3+5KcHutw8xSAJVY7FeMxWgfRSSmfS/Nv88KLj1G9JP5uSyXan6kSgfuhXoS3eCkZPdYckTsi1zxc5PWJvEFFdwAiGBfcS3JbzXv3tygVh1bKwJ1C4cjJQmFOOOqbWjeXZadhMA3e7+RPAusAvR4gi0+/RHeJoh5vRWdlHssaqtnI9l9MtNNkX9N73im1+t2hDTB+zL46XCfXYU6t/2liCNMQU3pSlcHI6jrq4c4FbIhBlcmYPZs0c2KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 17:02:14 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 17:02:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 13:01:49 -0400
Subject: [PATCH v3 3/3] PCI: endpoint: pci-epf-vntb: Add MSI doorbell
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-vntb_msi_doorbell-v3-3-ae0b0c93caae@nxp.com>
References: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com>
In-Reply-To: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758819722; l=7393;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Nd4XpE7/0j9KIEWK5Qkml7AvuVRhcxYwKi7CApeTj00=;
 b=36XNU4rt8/djLCTogmBInHpFei93KuxsDpEWdqVBq0IaxWCUVQgEwfcrO30iDeXjGmUNxSJec
 yGanAxpOmiBCeN0UPHAP2Q76TyL6U+Ybtf/2bwJk0GT8D9lSl4RafNY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4fbd7e-0c97-4041-c644-08ddfc554664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0NrQWZFWjluZFp6QTRYY01UdERUL3hlZnQzNFczdHZqRjB6WnlqUlhYb24r?=
 =?utf-8?B?NTJIUURIWlcyZG53UHFwdWlBZGhjVjRYZE5zam1NQTBvbHlwL2FSR25XUlFo?=
 =?utf-8?B?WUhyV0haMGJ5SmJ0a05MV2lxNDgya1dUUWVGTXkrTnpCeFNHNDh0dHlUT1dt?=
 =?utf-8?B?dktieGR6MWFCNWFLaWh1T3Zvb2M4QzgwejlPR1RETzZWcVUweThqVmdZTkVs?=
 =?utf-8?B?dTFSRDFyK3lDUFI5VGdneVFTWFcvYzNwc0VLb1hzZW5pQVpsdVpxVHUzcDlY?=
 =?utf-8?B?dmVkN2lKbENpbVgwNFNMbHMxNkZSRFhTR1FsSVhzenA5anU0Tm1KbmhvQVk0?=
 =?utf-8?B?eWI1YUZJaVliV21SSTVkeHpIcmdFQXhQU0RDZnh5bU02ZGVsTGpXdHpHL1Q5?=
 =?utf-8?B?MVl0VXZJRjVNU1NTQ3VxYlNTVmhzUnZmSzNXWGlkb092TlNyOHhWcWFzZ2Z2?=
 =?utf-8?B?VDVvTlBRalVIZXZpTzQ5and2c3BRVmx5YWl1bk5xR2hLSmxKdnNXdkRQQzAz?=
 =?utf-8?B?cUZKcWdzN3FsUWRaS0R6TGYvT3IxZS85bGZqL0x0KzVuVTl3SGFqV2EwakZw?=
 =?utf-8?B?OVRSZnFSK2ZMRDlrTHlGUFBKK3JsdFYrbFlRUVNNWUlRajZLYTlVSU9nK1pT?=
 =?utf-8?B?VVNwd3YyUGZUTWcwS3E5WVR6QVBYd2cxaXkxenB2R2w1TnFlTW8vb0VweENs?=
 =?utf-8?B?SUxScjRua3haMDBFcEZpT3A4a25iZkJwci9yUzcrYTVPVjB1cXA4bXJXR0Jn?=
 =?utf-8?B?QUlHUWx3S0N1ZldPQ2NKZzlQVW1ReFMraDFFSm1KUlpoa1kxem5RTEZXZUlj?=
 =?utf-8?B?T0JFajFNSEQxbEIxYkV5R3B1WjJrSWg0V3lrRHdhZkIvSEJCd1FGRTRHbWlS?=
 =?utf-8?B?ZzlOZmE1OHhKTVVyZTBtRVhzc1RJTTJma2NQeE9oWDMyMVl4UWpKZSsyaWxi?=
 =?utf-8?B?RGxTQlkxSmRUbkpONHY5NjBWckt5QXpCVEFyK0Z5VFc1T0FLb0JKWHAwaXpY?=
 =?utf-8?B?VFZtbDR6V3djL2VJbVNLandCbk9rMndUK3NDZXJPRmZ2T0I4K3pNaFVRaFps?=
 =?utf-8?B?WHNLZ3VwK1k5eG14Ri94LytWd0ZYR0tTNTBJa2JiSTRSdVpsNkl1L1ZPa0NM?=
 =?utf-8?B?K2s2TmJMOTFDMkhYRTZsTUp2bUFGcjVhd0JSeWR2cS9pVzBTdXlHOVd5bUtF?=
 =?utf-8?B?WnU0TDFSUEFZeUJlalU5anVBT0prakVSTVVQRFBYMTY3WlQ3UDE0U2ZjQW9I?=
 =?utf-8?B?MzBFRGNEYlZ4TVBaanlhL2tpTGhYbmRCcEdnV0hSaHlYYk1YSWw3M3BLV3hY?=
 =?utf-8?B?MkJVWDR1M3A0UzZhNlJ3VWNQWW1NNEoyTXJDTjY1K1ozL21FSDZ1NE9SZzVx?=
 =?utf-8?B?S1AvUEdvc2JMa3lldjJvSE11bjNpVGJOanRIL0NVajlCZlJNWlg5UTNhdHdV?=
 =?utf-8?B?WkRrZWNmSDJQUHpMSEVUVTJ6MmdPcjJVUFBZcjlXaUtWTmNrL2thZ2tWd21q?=
 =?utf-8?B?NTU5L3J2Y1dGOFFlallNaXIyVHRVdEZEdkFJQzFyTmxpTy9iYUhzM1VqOElp?=
 =?utf-8?B?YUdOVmpjZzhUaENIQzZscmRiVm1rcjBzZDB0aE8vTWFLSEljRFJqNVgwWG1H?=
 =?utf-8?B?ellVRjI1NE5iTXQ4VmYxYkVNU3BlUk0rK1U2NjBmclU5RUE3WGdDeW5Hc1l3?=
 =?utf-8?B?S2hQdWtiVzVocm9CcnRrNVBzM0p2eVlTaUlQR3ZjUWJXZ1QrdHhkQ05TVGl0?=
 =?utf-8?B?MTJTVHFZeGJGaE5EK3BBNlBUUVB3a2llajZIRXVTbTErbzRiQk9nVldSaCta?=
 =?utf-8?B?OGRpeGZiVEFkWGJ5LzVqTERJREJ1THlIamQxMDJjRDArRUg4RU1QamZCQjBK?=
 =?utf-8?B?bnFVZXkrbWJYTGtRR3hIK2xGU2NwRnBtZWFBNFJTenZNcC9iUFcxMEpOV09F?=
 =?utf-8?B?dFgrUk9oQU9xOHJWOHVkaGJGUk9XQXdVMUdzRmxwNWEzb2JIdDFVTUptN1ZF?=
 =?utf-8?B?TjJRZ0lGeGJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU93bDNWc1NGMWNqSnV3VnhkemFLaTY4R1NZUmJTTVJVdDRuMWdvYy81c2l6?=
 =?utf-8?B?MkZ6cE5UZUhNa3ZCSXBqQTh2UWVDQjdqWGd6MmFIVGZLR1BnR1h1Q1hoNEFT?=
 =?utf-8?B?NkFQUTdzYXJ4c2IwYjQxRVFTVG9SSmZ1N0F0UDVnejQwVU5BdmVRbnBtSEtt?=
 =?utf-8?B?Y2xxZUpxaFNCRDk1NGRvSm0wK3MxWWJiUWFiQm9PTzBxV0QrTkwzUXVYWiti?=
 =?utf-8?B?eVo3RC9wR08vTTYxOVdoMnc1MU4yZ0hZNkZXRFcvVXpMS0gyY1QxOFhhM21y?=
 =?utf-8?B?eVBqUHd0OExHMzBwM2RlSEFIZXJoVlNpazlTRUczeGF6VHI2eDZwVVRqeS94?=
 =?utf-8?B?QnVEMXl2UHk4ZDUvb0I4Wkd1ZnoxT0pad0haeEJFdWZKdDV4QXZGQlB6cUY5?=
 =?utf-8?B?Y2lnVGtadzJUY0taNVQwbTl2MHViVFIrOHNTdlgxRm9PODlwVjErKzR1dGFz?=
 =?utf-8?B?aWZKdkoxMlllSnlTa3BlRVdVSStVSmRXV2FGZGZheVovWm5oK2o4Qi9TUDVa?=
 =?utf-8?B?QmpFdHVQK0FzR01LdTBYK1JZNFlwS2pWdlJibVV2T0MrUXAzZGh6bFpvWEVI?=
 =?utf-8?B?ZVhkLzkySTRKNUxLUGRsbGEvd1M0eGFXVXpDS0p4dDg2RW1SZWJYejFqc3BW?=
 =?utf-8?B?dmprWWdaWi9XL2JNVGxjNExnVVp2WEtxejBUb01jcWY2Nk92elZZQTFSQlpT?=
 =?utf-8?B?cWl2aUJ6THovN2tMeWxJVGhsd1lrbnJGbG5SZTEvbnc0bHgwSkFIU093aDhQ?=
 =?utf-8?B?RjhzelV4Y3g5NEZLTlZFdFhMWmJZMGpWbGVjNkgveUZETkozTi9RandPWGpP?=
 =?utf-8?B?Nm8vbFNQeG9QUGwyL2lQMVlBRGhid0p5Z1FCby80YzU4S2JvWjBpLzY5a2N3?=
 =?utf-8?B?bVhEWDNZV3B1aTZRVkEwUGdKNUQ4TmZvWXY1R3o4VWNuQWdqV0VxNVRGNVor?=
 =?utf-8?B?dkRzTkllUlJyZG9RbGh6ZDJSUzUwZGtNZjdrREFKZ3YxNUxrNU13T3pXSFkr?=
 =?utf-8?B?VWdLaFdMZTZJbDZVZk5GNDFnTG84Z2lGb1hhUFZQaWJWdHEwaDlTWmo3Qnpj?=
 =?utf-8?B?S3hVTFBoNUFRQkl2dTdYQkJjUVB0RkFDeUlFZlI0ZThTSkdpN2ZLeGh3M1Jy?=
 =?utf-8?B?dVdBL1JNTGhoV3drWmdRQlllVUNjVEZGWUN6Y1dPYjZYU0ZnTWVJeEp6QXdI?=
 =?utf-8?B?S25samRFaVR3V3VQbGhZQ1V1TGsrZmI0d3pHem1YUlJVWGNFRVo1bTZQUlRn?=
 =?utf-8?B?U0MyeUVsWTZ1SnluSW5aTFVHbmhFZ1d0TmpjTCszc2dXVEpYc01Ra253Wlcr?=
 =?utf-8?B?TVcwTzM0OVdzWjlIQk1QUzQ0Z2JkOEZyeXRGWUw1eElJdUMzdTlTd29xNE5n?=
 =?utf-8?B?aTFsTEdlOTlBaGJTaW5ieE4vZzNtS2tsK1NwSVNFanAzVy91eXN4Zjhpdnc4?=
 =?utf-8?B?bytraEVlZmo5MzM0MEZRWkFMV05aZldzSHdqc2RHbUt2Um5TYUF5Sk8ya0Ft?=
 =?utf-8?B?azJ0UDZWaWx1aGtvZTNENDVRL2RVQzdHNXZJM2JlalI1QlA4SmVuT0ZiWkpu?=
 =?utf-8?B?dU1Va0ZJaldHeXFWUkhVbVNWK2NmTGhmQ0U5c3ZTNEtublRIbjduY2wrM1hS?=
 =?utf-8?B?M0hiZmszdUpZa0JLVm1kbWJMVVJhL0pqN3U5bTJnZ29DRGpjSTNSL1p0MTdm?=
 =?utf-8?B?TFZYZjR2SlV1dWd3YmpxMTBqNCsxb3ZodFo4R0xHWCtPOUk4THhINzhybzdB?=
 =?utf-8?B?Z2hLZ2s1QzNpbkp5NW5oS0h2cGkwWFVrSUFEd3VuU0lSNTZ2L2Rtb25RQnZv?=
 =?utf-8?B?TzVJcUtzSXF6TGxsWXo3Rm9NUnRQSFhZM28xSzVvRVAzYzhPWUVKYTdBRDRN?=
 =?utf-8?B?anc1SWIzUnVtT09VRGRROTRqZ2dJdWExenk5L1hnSDBCOVlOdXo4V2U4cDFP?=
 =?utf-8?B?N1lDOHcwRnJzTG9WWXVtZUtrRXJ1QUJGdjNPb203R3pNQnZtRVY1QndmOUNs?=
 =?utf-8?B?V0hrOWVSazlma0lWQmVXTkVyYU5iampzOHZWcDFEY2p0R2hJZmpLaEJNaUht?=
 =?utf-8?B?cm00VlVrcVRSQi9TeTVxajVucldNQmZvQ1NEemFrMGM4RGVldmkwb1ZMS1dI?=
 =?utf-8?Q?WMQUXN7GfpAn9fcP36/35kfSD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4fbd7e-0c97-4041-c644-08ddfc554664
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:02:14.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/wkNiWdp0MPBPSHKy0Rewxj9Knmdr9HH6JBn0bx30CGyMMg5laqeVo23bhq/Va8/yxWTqy4amfSlqU+QHOmnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871

Add MSI doorbell support to reduce latency between PCI host and EP.

Before this change:
  ping 169.254.172.137
  64 bytes from 169.254.172.137: icmp_seq=1 ttl=64 time=0.575 ms
  64 bytes from 169.254.172.137: icmp_seq=2 ttl=64 time=1.80 ms
  64 bytes from 169.254.172.137: icmp_seq=3 ttl=64 time=8.19 ms
  64 bytes from 169.254.172.137: icmp_seq=4 ttl=64 time=2.00 ms

After this change:
  ping 169.254.144.71
  64 bytes from 169.254.144.71: icmp_seq=1 ttl=64 time=0.215 ms
  64 bytes from 169.254.144.71: icmp_seq=2 ttl=64 time=0.456 ms
  64 bytes from 169.254.144.71: icmp_seq=3 ttl=64 time=0.448 ms

Change u64 db to atomic_64 because difference doorbell may happen at the
same time.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- update api pci_epf_assign_bar_space
- remove dead code for db 0.

change in v2
- update api pci_epf_set_inbound_space
- atomic_64 should be enough, which just record doorbell events, which is
similar with W1C irq status register.
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 149 +++++++++++++++++++++++---
 1 file changed, 132 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4fc2b485d5463faa2172500f12999..efa00752eba0585426e18e52028101fb4e7d2570 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -36,11 +36,13 @@
  * PCIe Root Port                        PCI EP
  */
 
+#include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <linux/pci-ep-msi.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
@@ -126,12 +128,13 @@ struct epf_ntb {
 	u32 db_count;
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
-	u64 db;
+	atomic64_t db;
 	u32 vbus_number;
 	u16 vntb_pid;
 	u16 vntb_vid;
 
 	bool linkup;
+	bool msi_doorbell;
 	u32 spad_size;
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
@@ -258,9 +261,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
+	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
 		if (ntb->epf_db[i]) {
-			ntb->db |= 1 << (i - 1);
+			atomic64_or(1 << (i - 1), &ntb->db);
 			ntb_db_event(&ntb->ntb, i);
 			ntb->epf_db[i] = 0;
 		}
@@ -319,7 +322,21 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 reset_handler:
 	queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
-			   msecs_to_jiffies(5));
+			   ntb->msi_doorbell ? msecs_to_jiffies(500) : msecs_to_jiffies(5));
+}
+
+static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
+{
+	struct epf_ntb *ntb = data;
+	int i = 0;
+
+	for (i = 1; i < ntb->db_count; i++)
+		if (irq == ntb->epf->db_msg[i].virq) {
+			atomic64_or(1 << (i - 1), &ntb->db);
+			ntb_db_event(&ntb->ntb, i);
+		}
+
+	return IRQ_HANDLED;
 }
 
 /**
@@ -500,6 +517,89 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
+					    struct pci_epf_bar *db_bar,
+					    const struct pci_epc_features *epc_features,
+					    enum pci_barno barno)
+{
+	struct pci_epf *epf = ntb->epf;
+	dma_addr_t low, high;
+	struct msi_msg *msg;
+	size_t sz;
+	int ret;
+	int i;
+
+	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
+				  0, "vntb_db", ntb);
+
+		if (ret) {
+			dev_err(&epf->dev,
+				"Failed to request doorbell IRQ: %d\n",
+				epf->db_msg[i].virq);
+			goto err_request_irq;
+		}
+	}
+
+	msg = &epf->db_msg[0].msg;
+
+	high = 0;
+	low = (u64)msg->address_hi << 32 | msg->address_lo;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		struct msi_msg *msg = &epf->db_msg[i].msg;
+		dma_addr_t addr = (u64)msg->address_hi << 32 | msg->address_lo;
+
+		low = min(low, addr);
+		high = max(high, addr);
+	}
+
+	sz = high - low + sizeof(u32);
+
+	ret = pci_epf_assign_bar_space(epf, sz, barno, epc_features, 0, low);
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, db_bar);
+	if (ret) {
+		dev_err(&epf->dev, "Doorbell BAR set failed\n");
+		goto err_request_irq;
+	}
+
+	for (i = 0; i < ntb->db_count; i++) {
+		struct msi_msg *msg = &epf->db_msg[i].msg;
+		dma_addr_t addr;
+		size_t offset;
+
+		ret = pci_epf_align_inbound_addr(epf, db_bar->barno,
+				((u64)msg->address_hi << 32) | msg->address_lo,
+				&addr, &offset);
+
+		if (ret) {
+			ntb->msi_doorbell = false;
+			goto err_request_irq;
+		}
+
+		ntb->reg->db_data[i] = msg->data;
+		ntb->reg->db_offset[i] = offset;
+	}
+
+	ntb->reg->db_entry_size = 0;
+
+	ntb->msi_doorbell = true;
+
+	return 0;
+
+err_request_irq:
+	for (i--; i >= 0; i--)
+		free_irq(epf->db_msg[i].virq, ntb);
+
+	pci_epf_free_doorbell(ntb->epf);
+	return ret;
+}
+
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -520,22 +620,27 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_DB];
-
-	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
-	if (!mw_addr) {
-		dev_err(dev, "Failed to allocate OB address\n");
-		return -ENOMEM;
-	}
-
-	ntb->epf_db = mw_addr;
-
 	epf_bar = &ntb->epf->bar[barno];
 
-	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
+	ret = epf_ntb_db_bar_init_msi_doorbell(ntb, epf_bar, epc_features, barno);
 	if (ret) {
-		dev_err(dev, "Doorbell BAR set failed\n");
+		/* fall back to polling mode */
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate OB address\n");
+			return -ENOMEM;
+		}
+
+		ntb->epf_db = mw_addr;
+
+		ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+				      ntb->epf->vfunc_no, epf_bar);
+		if (ret) {
+			dev_err(dev, "Doorbell BAR set failed\n");
 			goto err_alloc_peer_mem;
+		}
 	}
+
 	return ret;
 
 err_alloc_peer_mem:
@@ -554,6 +659,16 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
 	enum pci_barno barno;
 
+	if (ntb->msi_doorbell) {
+		int i;
+
+		for (i = 0; i < ntb->db_count; i++)
+			free_irq(ntb->epf->db_msg[i].virq, ntb);
+	}
+
+	if (ntb->epf->db_msg)
+		pci_epf_free_doorbell(ntb->epf);
+
 	barno = ntb->epf_ntb_bar[BAR_DB];
 	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, 0);
 	pci_epc_clear_bar(ntb->epf->epc,
@@ -1268,7 +1383,7 @@ static u64 vntb_epf_db_read(struct ntb_dev *ndev)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	return ntb->db;
+	return atomic64_read(&ntb->db);
 }
 
 static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
@@ -1308,7 +1423,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	ntb->db &= ~db_bits;
+	atomic64_and(~db_bits, &ntb->db);
 	return 0;
 }
 

-- 
2.34.1


