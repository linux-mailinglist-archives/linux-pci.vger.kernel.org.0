Return-Path: <linux-pci+bounces-15734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB50C9B8015
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3054B1F223B5
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8531BD515;
	Thu, 31 Oct 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eMGmy3BH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED91BC9FC;
	Thu, 31 Oct 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392055; cv=fail; b=IDBUdbkPaOOqOyD1jLTfcer5CIWH/GNy5fI172bdohGZwF15xO/QsNzUVckt0l0itOauFBPVI9GIm6JyrU1qFr0NU+nUG9KpYD6mNilQelx93peBpIqoc7gp/YEpujDa6ZCnB3RnPH08yMpE5hmvcW4v4kfMURu0pBjaECd2ZCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392055; c=relaxed/simple;
	bh=JYWf7Ivf0hxPXaDhUGKHvnfXMpLlf1E7XiPYVstdBQk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PMS5uysOhHUHj4YTv9647sMvwr6hCRYgP5uOD548C4WHzlJlDUE6Nrm33/4e5//q+leYXW2A0/B8v5yigBbR0pTdpdkhIhCHoUxw8blJroVYF42EiZJ7hURFH5w1EGzv9ygAGnNL5U6gnX4pLKuw2+K/f3J/2Zk5mJ8GpaB096w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eMGmy3BH; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rst8UucvP2zB3S+01x9o/LesiTsMhT6gOiA75G/kBIkDqidqFKJfm0Ru8ZlxXsApWADvE5KugjJnswC8z7TCdSqqkBvm9MoHHx5Q16UIPNhcyPmrOlclr/YpMmheolXlKAF7HmJA/0ahIjUUKJ5BTcClckabo8n+9MJDH46wpNBRRiofI8N3zuKKPoAxQb6fQVn3aRdppymKGup6Sy4jqOned7G8MFeO9oEmKDHB+ZaeW0lLb4SAB9YB8fbfMSnMJ8yaQJdAAGfEBAanWzPTuN5C+7khKoLKjCjHj1Qfe/iDGn+W/hfGUwsdVVZba/Wu26Qgn/SZaKEihiMbl6C/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSHhGQNj+pSFlSAACu8GErRxT1442ZWIsPF1u4YQz+A=;
 b=aao/Y9NalEB2TlHKMUhd0FFrSJEX2QDAEZT80PSXQfcWXJ9ZyBdEkNsAHLj9rNrU7g+Sd1HEy7lLg50PUv6C/ahtuwxVL+ZsjjwnJTus0tR93QdJ5rfrcOcUfsp7PULdMdM3AkIz5yMQgaAzqHHXt6Ifvp4CBOuUS/NFvZvqDYGG8NEjRuYRH6o0OlrYkcfiiTGKXE9AOJicB77l8DCxtdvSxCLeXCxR9bAXXdBxNyJUmc2uSEtpOE1Vt6MPZNnpylgWs73G5roYNSZ3xgGcq/WAMLLe8sDnUHNzmleScviYbHv/J86KQpDH/AhpvgFTk4o35GJtpnXsBZV0yWw2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSHhGQNj+pSFlSAACu8GErRxT1442ZWIsPF1u4YQz+A=;
 b=eMGmy3BH8LF/YEXD0foZZGCT62ZoKBwX/2KGTdEqilBl30s1qQvmjLxSo+nnHmNg0lakVtMRUmVzXrrr0P4jynRmBpnLPdjZ7snNOZEuazj2gRmNlLH080zLz4Z5PARN/mk3XNHitifschAApwN5X4QBRae8EVCI9yAgiMDTuLS7SpVbVxuaad/3tZXge+wbteoyLnAfmo7FYubu2zGDYMFVewFkICdtqmayANGt3QETQJoASR41ZCSHn+C24mioZcIiVgTNTRkp/yISdLu93vMybafORoxlYm+fcUjIZnRt/2p5mK7xRIJNoconspObjWuWvlsEmT7xsAqy9gu/Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11081.eurprd04.prod.outlook.com (2603:10a6:102:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 16:27:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 16:27:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 31 Oct 2024 12:27:02 -0400
Subject: [PATCH v4 3/5] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-ep-msi-v4-3-717da2d99b28@nxp.com>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
In-Reply-To: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730392028; l=6630;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JYWf7Ivf0hxPXaDhUGKHvnfXMpLlf1E7XiPYVstdBQk=;
 b=OeCLCcpHihO4JQsIb48Ao7gjrAZLLw/jpot03X9xaFEBbgSjRF6gQfbIE8OMXTIo99EeQR2S3
 m548nd/NW42AxAH2xW8nHiU1wImcEA8E+jKaxz8S+4gLd4d+xxwf2it
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11081:EE_
X-MS-Office365-Filtering-Correlation-Id: 519c698d-5aa3-4e35-579c-08dcf9c8e695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1M1Um9RdXNCaUh2ZUFKSytSTGtrU3NzTEh6b1g5T1l2MVJaaVdOUXphemdu?=
 =?utf-8?B?T0gwM0d1cUxGc05BYlMrNGxkc2NCY3dRNGJoQ0JhTEJSdWpuYTU5T25yUGZG?=
 =?utf-8?B?cE5wSUdnL3ZYUmJMVDI4RXMxZ2VvcDdpbjZYS2dUc2V6cDArc0szRnNhZm9a?=
 =?utf-8?B?dktHUzhJRlBIaGVsTXpQaFd6UlptM0JsN3FIU0hQcFhjbWhRVEMrYzYvMGtK?=
 =?utf-8?B?enI4M25GdTlKWU5ISHFQOWkweS9FRGJQR21WSWIyOHE0K2tISnhJeHFIcmkx?=
 =?utf-8?B?d25odjJ4S3k0QzNYYkRmK0Z4ekhhNG11djMzRm1DUDVqVmRSOUQ3bU1NcUd2?=
 =?utf-8?B?enZYREhxaysvSGdwRVBNbHZZZHhPZXJFNUxtVmd3NTFjQTh5cEtvL1R1blFk?=
 =?utf-8?B?MWNYTGowTVl6NzF4YTVKYTBmeGVBcDNLaGdGbEJqcTZoTVY0NlV6cFVnNlhw?=
 =?utf-8?B?NjRieWFFRk8ya3FyK1ovdEplM1hwRGw4S3piU0Nnd2lSU3ZDTDlzOUU0WmNo?=
 =?utf-8?B?NGJlbXlEdGVVWTl6cXdNa1ZzVG9YZDNHQmlTYk9FR3d5Wmc3aEVrdVpqek1s?=
 =?utf-8?B?ZHZhUGdDRmJCRy81WHhvSXdpYW1wdHZvQkNBVFZia1lZbzNNTE8rTGxBVlYw?=
 =?utf-8?B?WHROMGo2NWhCV09Za2lFRGZRckZsTStyS3R2ZnlqUUdCNGhXZ1NzdkdFd3hi?=
 =?utf-8?B?WjU0bjkrUHFIbi9sdkpxeEZ3VXNVS0Fkdk5ZM1dSZEdybTdSVzVqdU90NDRq?=
 =?utf-8?B?Ulh1RDYxNzRESG5VMnl4RkI2ZzRnaFJKZ2RvSk5XWng5R2V4elBkOEErNjdS?=
 =?utf-8?B?Q3puZ1locCtyT2hRQStuYXNudm9QTkZVaDFmRmJ5VXArZko1bHd6NWxuUTBH?=
 =?utf-8?B?RlZEZk1aR2lNWEZHMUF0N29ab0lTSHNWanR3UEM5VXIzYlk2cjBHaDRGRGk5?=
 =?utf-8?B?a1c2VE13UmppaWNRR0lzeEN1aEVndWR1MWJhQ1c3YVRkYUVsbWJOYm9CeTZZ?=
 =?utf-8?B?aURlUnhuRVlUb1l3UnJ3VkoyNlZFd0J4ak9NZzlQaDQzbWwxT29RSThhUDEr?=
 =?utf-8?B?ZThQMjBVSmZUa3ppYVluV00rRU9IUGR6RWhUTE5oV0JsSG1zSFF4Y3JZek9s?=
 =?utf-8?B?eWRwSzNkVkRPdkkxNVRIczQ1RTdDa1l4NS9wK0QxUndIMStCd2VaMHZaL2xB?=
 =?utf-8?B?WVVNUTZyalJZVHRLTklCaXprMlFXOXBieXVqSWF1TGVNNXc4UTJ0dDNSSmxG?=
 =?utf-8?B?b0xXNWU5alBKQ2tXZkhsTmxpV0NJb3IwWnIvR0YzbTh2ekNIQ2ZuVVBRUm0y?=
 =?utf-8?B?Y2xxUGFoWjdhNTJWbXFja3hRSHNoa0ZPSUVCM1E1RHJvSlFybGFMNnBYRGRp?=
 =?utf-8?B?SjB5L0prQlZmY2ZQTU9wWmp1YTNtUnczbnhHbmFnQ0QrM21XYnREYU5FTjJi?=
 =?utf-8?B?ZDQ0alhnc3hzRzYxc0FINmp3WmpKdWVMY25LZzhwZ21jd3FuSW52QmNjcHJ0?=
 =?utf-8?B?a3k4OU42eWtwNlZ5U1VVWDNqYjVuSG54NEVpRjJKRndRTDc1WjlKR09YK0hv?=
 =?utf-8?B?Q2Fzbmd4V1NsUDN4SWhnNlZCMFUyVytDL2dEYk9MZEgxczdETW9EVFp4UmpP?=
 =?utf-8?B?azhLL0lxUEhNSmZNcFhvUmJUVXRueFo5bVlhaEhNaXZXNExkNWJsVXBLY1pC?=
 =?utf-8?B?TStkSFcvVTA5cUdiSFdJUkdiQ2F4L1VOdk52dXJtRzI2am1SRWxTME5qbjgw?=
 =?utf-8?B?SVpnM0RXbi8yYnQycXFMRHo0RlVFRnUxVGw1eVkyc09YRW05RkpRdmI1bTB5?=
 =?utf-8?Q?lGHCHcqgeC0hWC03VeudusS00qkJGNEQ4btNA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODFZZjdUcHFkUFFVSG14Z3V4RlAvUW1lb2hmQ25qa081Vk1Ea21sNEladGxK?=
 =?utf-8?B?WmFCTUdrTE8zaStOSmF3Rm5na2F0cmhGZWxCTXcxcjBmbmovaHdrUGVkZ2dv?=
 =?utf-8?B?ZHdrWXpTa2w5ZHhKeHc2TFJIazhmdlFaaU9RbzFaVVo4eFU2U21PNmV3VXRo?=
 =?utf-8?B?Ty9RWFl3dVZUU0dUY1ErUExNcWRZa1pPVmdYUDF3YWZlMEpVTHRoOWNwSGdS?=
 =?utf-8?B?RG91MEl5SU95ZGkxQkExQVJKYytpdXo2OXNMS093MnV4U0Y4WWFWeWJIc3pR?=
 =?utf-8?B?ekR0NCtsZWNtMnFNV00zcFQ4cUtkSHdtaU9pSjl5b1RFb1hhRGVNUUZVbnFB?=
 =?utf-8?B?cXhDR1B0MkhXaWVNTkdpMjRZQ0cyVUhuZzhCRFUrVE0vSjZKdDJNMU1STk1O?=
 =?utf-8?B?R2tQeUM5WXhzZWZXcytNNFFaekZGRkNQMU5sQUN4L2V2OUJoVFVoYWZ0ZHd1?=
 =?utf-8?B?U2ozdnJRdFJVdnlLSFlxYm5WamR0ZWhUMFlrNlMydXYvb1c4Y3RyUEs1Rlp3?=
 =?utf-8?B?OW5sdlNhejlSQ1RJTFhGcEVXNWk1WTM1YVZvcVpsZHMwMFMvTUpaTk5Tck5l?=
 =?utf-8?B?N1JGZ0dYUEtITXBLUmVIT2w5T2xXQ2U0aDBJQmlvZHhGZ0pWaHVkS0p6N2dP?=
 =?utf-8?B?NHlRT3k1ZFBOd21leVI5WUhGZWxhRkpGcktBOEh4TXJZQkRPeUZoanJ3WUdO?=
 =?utf-8?B?RDhQSjJQRGRzbC96Y3FlTFJodDNNdFlmMGNOK2pHYnFXZC9WeUJhZUF3L1VZ?=
 =?utf-8?B?OUF1SVJqZzd6UTJza1lkQmhpYkQrRk9GYi9FNFkzdDhIajdHUWt5VnN2dUFU?=
 =?utf-8?B?bnBENzNKcnFSdTV2bHNaSUtvSnZWNWZwNmpzcHZZblFrT2gzVEpVaDgrYlpv?=
 =?utf-8?B?UDEyd09yVHQ4c3lJdmxKUkNPVTBmVndkNVY2VFcwN05KeDYraktTWlRkc0x5?=
 =?utf-8?B?L2lQQzhtUUc0TnBzY2lrMVVNVmJ5a0RrU3NIdnF0d2pDbkE1K0NyU2oyV1FN?=
 =?utf-8?B?bnlMVGFET2ZULy9Lb2dZanUzVU15UHVLRDZWWi9nYy9hVHJGUUs4ekk5QS81?=
 =?utf-8?B?NXdrVWY0dm5RQ2lSQUhTYnZ6cjVaTlhYb2RUMGgxRnlFNVk3eHZ5aXFjMitR?=
 =?utf-8?B?UU0rZ0VlelYvS214VUpUL3JCR0pyanIwTHJjR0tYS0loNk0rZXpvc0NEQytH?=
 =?utf-8?B?cjljTzY3TWJpcW8wUmhpWnZPVnpCV3VNUDEvbzkyYW1UUU5NTTQxQ01IclVC?=
 =?utf-8?B?dWVkVkJ0QlA1b09YQUJQNVlBR2hqM0xzNWQ3Q1c5U0JIUm1XaU5YNDB0UVdI?=
 =?utf-8?B?VVlLMzZWcDZxaUdSdGFxYlRjSmh0NVBGaEFpTlpLNzlRTnBlMnlURytwYmNi?=
 =?utf-8?B?YTBPaVJ1d2VVaDRnbkRVekNKTGJVcUFUMUdBTTZmT25YczBxRGQ2Tk83d1V6?=
 =?utf-8?B?RU84Q2twY1E2SnN0aFNMNDJnVkJWSE95SS9KN1RScktaSE1OeTdJVTl0cDdz?=
 =?utf-8?B?QnRxMzFlTHJ5eHFPakRxTyt2RHh6b0M0SDJObCtkVEQ5TktxLy9tcVdiakNm?=
 =?utf-8?B?ZzM5QitJS1Jvc0p4UTVJR3lEWlVoTU43bkY1UVRvZ3U1anhFTk93VEJjMWN3?=
 =?utf-8?B?N01tcCs0R1pUUVRLWnJRM0VrV0pGYno3T1VKSnZhWC9qby9BTHJUMVMxWWFY?=
 =?utf-8?B?ZmwzbHcwQUNPTVZiWmp3VmtQd3NGZlExKy9wTVUrS2FRS3RxMk1OZTVadzlC?=
 =?utf-8?B?TUdrZzdybFhqbThqbWZ4c2dTU09Ga2VmUGgxYSt6WVdXajRPdm9lUnBaYXps?=
 =?utf-8?B?SURvRkJ3L3J5UXhnWDFHdnh1bjZKdC9zZnBrU3lFanFyYWZVdEZJbDNFUStr?=
 =?utf-8?B?MFFyVnRpeEFzU0RxcWlTenpibVpVQmsyNlJGSy8zWlRreEplWHgwSUtIRFdS?=
 =?utf-8?B?TDlKKzRocVJOODZaWUFCUVlqWnVQUWNRYXY0VVV5SUdMOG5ycWhJb2kvZzcw?=
 =?utf-8?B?VVU1Ylo1dDk3V25hNTg2OGpWZVNlNW0zTmJiZUd1OW1oeVI5WjEyc0h6blFz?=
 =?utf-8?B?cjhONzFLcitueGxXRWpvUHB2MlZVVGVuS0NQMVV0MUdKM0dnMGIwQVdhZDBX?=
 =?utf-8?Q?ji0k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519c698d-5aa3-4e35-579c-08dcf9c8e695
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:27:23.7961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pT1r3NF/laGZcn/LH6azim2vKAanO8vDhBu6aua1+1Y2g4JRsHNhc015jqKjJU5yjFuAELzRDKKERlnVcRJMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11081

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set doorbell_done in the doorbell callback to indicate completion.

To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
to map one bar's inbound address to MSI space. the command
COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 104 ++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7c2ed6eae53ad..dcb69921497fd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -74,6 +83,9 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	doorbell_bar;
+	u32	doorbell_addr;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -630,6 +642,60 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct pci_epf_bar db_bar;
+	struct msi_msg *msg;
+	u64 doorbell_addr;
+	u32 align;
+	int ret;
+
+	align = epf_test->epc_features->align;
+	align = align ? align : 128;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	doorbell_addr = msg->address_hi;
+	doorbell_addr <<= 32;
+	doorbell_addr |= msg->address_lo;
+
+	db_bar.phys_addr = round_down(doorbell_addr, align);
+	db_bar.barno = bar;
+	db_bar.size = epf->bar[bar].size;
+	db_bar.flags = epf->bar[bar].flags;
+	db_bar.addr = NULL;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
+	if (!ret)
+		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+}
+
+static void pci_epf_disable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+		return;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -676,6 +742,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -810,11 +884,24 @@ static int pci_epf_test_link_down(struct pci_epf *epf)
 	return 0;
 }
 
+static int pci_epf_test_doorbell(struct pci_epf *epf, int index)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return 0;
+}
+
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
 	.epc_init = pci_epf_test_epc_init,
 	.epc_deinit = pci_epf_test_epc_deinit,
 	.link_up = pci_epf_test_link_up,
 	.link_down = pci_epf_test_link_down,
+	.doorbell = pci_epf_test_doorbell,
 };
 
 static int pci_epf_test_alloc_space(struct pci_epf *epf)
@@ -909,6 +996,23 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (!ret) {
+		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+		struct msi_msg *msg = &epf->db_msg[0].msg;
+		u32 align = epc_features->align;
+		u64 doorbell_addr;
+
+		align = align ? align : 128;
+		doorbell_addr = msg->address_hi;
+		doorbell_addr <<= 32;
+		doorbell_addr |= msg->address_lo;
+
+		reg->doorbell_addr = doorbell_addr & (align - 1);
+		reg->doorbell_data = msg->data;
+		reg->doorbell_bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
+	}
+
 	return 0;
 }
 

-- 
2.34.1


