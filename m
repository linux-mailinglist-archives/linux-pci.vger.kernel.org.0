Return-Path: <linux-pci+bounces-12816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60796D031
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 09:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A701C22CDB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 07:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5DF192589;
	Thu,  5 Sep 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="D2OELaVV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87819309A;
	Thu,  5 Sep 2024 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520574; cv=fail; b=CjE58x5e9yZGciAr4tcReKklBkiD3MNZ4iILzoj+MLwg3eX2ozalKiW/ImG3OH7gIUAKDBatzCvtqMzdp60jA8DjeAQGas9gz0TEBamslvhtpA1JkOjmBXuRyZppweW8aItyVBPh02BdCSfR/STVA2Usv3DJsZPkpsCOmMtNgE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520574; c=relaxed/simple;
	bh=HAi25eY8chA4gqnBKSxrik+5n0KhAcZmx4GwTfqTc1s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NX8Yhfbk054NYooyZgiWPcF/cUxw89n1pliqvtT4NLapc26Url0j7qY5LzcrZq2p7Cqxb6KrBMFK3bEYU14hdbXtpbXmrlPuQV13V1D0QS2f/AkaYc/kN0jopq9vblyAe8EEIj6JTKdW52QA3KqQcKAQHD+/8wHSH/J1wzuM8Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=D2OELaVV; arc=fail smtp.client-ip=40.107.247.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teOo6XSUlaBrpDiXIbkRzeVNhdfE+R2DhCrayQok5k5eISCthJd7FDyQNMf6NJf8WDq9ebbhZzw940LuPgtES82hZrYiow/VoSUnlJBa6HerI3UeFBLFQdqHcY1lGLMINFOGyomliZ+XJvqdiHeE5Hf1Fpc2Ct73eFIP1H9nF5ZGeyL1/p6KvZf91oXP8UVN2ZZaciMwnH5v71gxJi7N5rSFhkeqPuhpmqoRo/Lv41+ltUZsCSmrcdwTJqy8TnHPgya8tVBIy6PWuZyRWj7zGs2NvVp3mz1OLspleICk+h4T+7bH/k0PjI59R4whW7qsrFCpEdgRn/fbXnV6Mfn6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sirEwKQu50Ltra3nHGYzc57y8yqAEhr7/CL99s/1cM=;
 b=WupCqxYlSf84jbi9RCjc5X2+SEeGaaojvG2sOK0WzlnBSbnuh9NVEWEk29uw2ZnA2ScQN+7z1/jcFOV6VTQ+uE+BdepNaahD/TXGrP274aq4BuPQ0Acq1vjsjewyUF9vZg+Pf6yCm7F+7GfoShuVnJsBwp73v+5tFOKPIq1UZ6AKWzuMZKwKwJPJtK7J71Z9K0QS5Ly8Zkls34Y2KchZzcXutoR7tndKevIBhUqLxizZ4REX3hZwU4ObRz9M+LXyTNaH1RxbxLnQfL7tthG+5v5eTyTqOF1s0j7uhWSX7gyJ/mMCz0+fquzBklqd1/wfTbtVjC6it2J+Ui2z1qAm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sirEwKQu50Ltra3nHGYzc57y8yqAEhr7/CL99s/1cM=;
 b=D2OELaVVl81VZDzfKfDeKnFoiD0Jk1k0g8f+Ua5p0V/KiMkpoHtm7X6wsR9PR2tHM+753vJnhDBK3/CRmlnKxHaFmP2bxbFeuoXtr/W39czWdxTkBLPAw946Ke7BYhADUZytYjH4Rap/NsAAUy2mdN5ZmhO1IctWPOARL9LEyrXUCtWVl3WBIs/ytBfruwN1frd0GQuCa8dSFPNlhfHrxPqmBTctWCauL+Ug/bOs72ziZU67v9n9MiNEUpzwLDoDT5pNn2o9X8s1QJGEtttt4HtSgtmIwrd54yEQUmW3WN0m/1OoYCK+Ap5nM7J9dqYtiAWWqUOouVQYzkJRFCMaeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 07:16:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:16:08 +0000
Message-ID: <3b8ff45e-28d8-4180-a46d-f507fa0bb65c@siemens.com>
Date: Thu, 5 Sep 2024 09:16:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Krzysztof Kozlowski <krzk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1725444016.git.jan.kiszka@siemens.com>
 <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>
 <acd72984-4c04-40f1-9e0e-f84f6c566b37@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <acd72984-4c04-40f1-9e0e-f84f6c566b37@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2b47bc-b1a0-46c2-8e95-08dccd7a9d3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWJVNVJxMHZzTFl2NC9yYnZFUFRhb09Fd0IwRnVtaDFJU1duVktCelkvL2Qw?=
 =?utf-8?B?N3RYVWU5dFc0NXBGZnNlVzcrcE5Ba1g2QWxkTGJxTTFRWitOcnpxTEFwajRD?=
 =?utf-8?B?Y0djRGNhN1N3OFMzZ3FnTUE4S0VVSDYzeTRqMld4TXM3RUFjdDZDZEtrUGo4?=
 =?utf-8?B?SzhzVkZCa3ozVUVPbGxrcnZjWGhvSEdPN3hJRFQ4VDBPQUNvQVlOcFBWTlA5?=
 =?utf-8?B?OUVVVE5ialRWanpueGFWS01Hc1JoeXQ5bFc0eDhKL0FKTEh1N2N5UTVNNjVD?=
 =?utf-8?B?cXFqaGpQYUxwaWlKNE9lTkVHanpaRmpISS9xaTczNUVCTXBIUkloSnFQaXRI?=
 =?utf-8?B?SmVlRGJ1UXYxOGlhcEhPRXdqc3RXV21wcEpMUkdwQXFMaUlocE90ckRQY0RY?=
 =?utf-8?B?VmJWUnMzZ0hJdGR1TnVpdkNJcG8wY0czcE5tSjFDUjJJdXY0a1F4KzBDSUtV?=
 =?utf-8?B?YTVKdDcxNFdNdFd6ZTR4bDhFdXl5NXdLelk3TExWV0lXTWlHYzVtNUhZeUlZ?=
 =?utf-8?B?RnFEbTZ4MGRYbm9PS3RkYmE5a281eHRyZnM0aUtuanNwRzVtYW9QcXd5ckVx?=
 =?utf-8?B?V1YwZEVpYXBPb3VxQVdCUjMwMU5zQ3p0OXVVbUNsZDRPcU9URzc2Ui8rNXRV?=
 =?utf-8?B?OWI3RWdleWRmZTllYUNPbnpENG5zRlViT1lQSWVlYXNHaWlBb0E1NFVLSm0z?=
 =?utf-8?B?azQ3QmUzWElidFIweEVMRGcvck1uVStzaEtqZlZiY0xiUVFKK0pMcWhsVmk2?=
 =?utf-8?B?eEpWaW9ka1RNejloM1ZPMUZSdEtTNm1nSVc4LzZlSjE2QUYrR2dCMElYMWxU?=
 =?utf-8?B?WTNXTHRqQ3FYRzZCeVBiWTZ0dHQ3ZjVqVGJRejlTcHhxRXdJNDBPc3VDYm9W?=
 =?utf-8?B?UHhESkJUMkFFN2ZoSVZiUUg5bFltMFBjdGJ0V1pjQ3M4TTlJVmRMdzNLb0VQ?=
 =?utf-8?B?T0NtQUhUZ2tsT0FJQ1B3dzN0dlQ0TnJuNTNoTDJaWHlBZWRPUld3VWptcStN?=
 =?utf-8?B?UzRyVStTNDRKblA5R1pITFl0YkJJellaV1BxVS94bmJqRndUVm4vMlhVV21k?=
 =?utf-8?B?M3Rsa0dQd3dJOTNsaDdxUVJsWVZ6RG1Ua095ZXpDRmthNmdHSVZKV05EelR5?=
 =?utf-8?B?UUVBTW9oYWpqQ1Z2ZE1VR3RJVmo4aHBOUWhpRzNEUUpWSGVEcDQvQUw5S3A1?=
 =?utf-8?B?ejNBdnBqSXMzS2dveVlrbEVNOG5nQU1tcUQzbUcrSTd3Si91bmsvZk8zT2sz?=
 =?utf-8?B?N3hiUVFsSVNIdW8wNEVhVjF0UFU2dkFwb2RDYXlDRFhPUDF4bnk2anZIVTVi?=
 =?utf-8?B?dkxiOUhSV2MvbEoxUlJtUHprMkNxRlQyVEJWcjl3bkRiWWdHMmtpNXVyVG5M?=
 =?utf-8?B?NGxhYmQ1Z3JwN2ZtYzhyYkxpRGpSWE4yTXlQM0tGRVRLTlRuU3ExYk85YXYv?=
 =?utf-8?B?aHVBSng3ZVViVzRXVk41L3k5NlJyd2RROCtJaTd6ZXNtME1iVndhY20vU0JV?=
 =?utf-8?B?OXV0clptTi9SK08yWU9YOU1rcnEyWnd4VDNybVluL3ZSbE5nTm5ldXNCZGIy?=
 =?utf-8?B?Z2VLNytINjlGZlpzV3JNYVdodWtFcFd1OWtZTi9kZnRyY0M0S2Z2RndCTG9E?=
 =?utf-8?B?c0dIWjFyQkNqL3haTzlNREZEeFk5NlRJdFFFbk5jbzNjYXovZ0svSWhhZUhZ?=
 =?utf-8?B?VXRqdCt6RWxvSmRnckdFcEpIN1pwT3lUbnJTVllBV1oyRTdBTzQ4WnpPOGF4?=
 =?utf-8?B?Y2U3WHlodmVYS3UrYTdjR0s5YlQ2dFZWTmFFREdPV1ZhZmV6aFpjNm1LbkF0?=
 =?utf-8?B?QVk1VmZFZ1lVYzIxblNYMlQ4KzlPZTBmUStkZjBZdzkvWkFscHhTcVhuWm11?=
 =?utf-8?Q?YZBY++X6bvy2L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzU1UnpObzl2bVdsbWhVci81SUR2SDhqWHVRU05BZEs2RjhnaGRGOGI3UW84?=
 =?utf-8?B?Y1FJZGpvQ3BmRkhMOUowb2JJdU01L3YwL054Vkl3aUMxNis5bGg5UTJNa2pG?=
 =?utf-8?B?SWhkYnFrZ2RLQkExUmU1TnpkTmNCd0pDQkhBTUFoditZMGh2MU9uNmlMNEZR?=
 =?utf-8?B?Z1lzWm93c2V5Mk9vOGtXcFZvRkdCbnZyTDVaNHNoTXpQd1NNUE1QQ0lpQ0dv?=
 =?utf-8?B?dTQ5aVRFUVFUWjIwb1BwZFBaTFNMWmRkRmRieEdNdThpU29WNk50bndwTC9M?=
 =?utf-8?B?QktFcXdoTnZCamtQbkNFQ3V1UmxiY0l6MkVvZjRGVnArZGZMYSthUUpPZEl0?=
 =?utf-8?B?SkZtTDZ2M095dlNEWUZDWTdnZXhGOXF4aHdRVGZNWGlhOWRTWTErZVp3WDBB?=
 =?utf-8?B?aVY0dkJ2d3JzQndBK1dhL05EMUxJMllNYVdnS2EraTRLZDFPeDRkN1QrM1hF?=
 =?utf-8?B?WUdQUUVzTkVjeVVhZER1cmtSQ2Fna1lxaHZpMFF0TXFNTnlzRVlaL3N5Q3gz?=
 =?utf-8?B?SnJuakF2RU5vREZrTTNObzFhQUQxb04rTGVoWFZpckZOTDJwV0U3ZXpxN3pQ?=
 =?utf-8?B?dTBtYWpEL2EwSXR6Y09NbVFrNGdpZ29zVWcxZnBFMUkvSXVJaWhYSHQzMEli?=
 =?utf-8?B?c2pCa3JTSVY5R1JzWTdrZ2t2MmhFT3FjZUl5aVNzT3N0ak9ETG5MNjZlellW?=
 =?utf-8?B?Nk1ReFJQb0hIdjRZaFo0dnc1SXd1dnJ5c3VmMStHQVpOUTFGVitNYkliVzUw?=
 =?utf-8?B?YmZON0poMjYzVHM3MWRqVmJZMXlZOGVBb255bU9yRFZJcHByLzF3UHRwWlQv?=
 =?utf-8?B?clhMNm5vWnoyOVNldmllSkxSNDh6eVVDMDd4MzA0NGhPNTFPUHNkanBvN2N5?=
 =?utf-8?B?QlRTUVI0b2ZvVk9nZ0RDL0h1MGUybWdTZnpON1JBM1FqWWNSQm5idEI5WWhQ?=
 =?utf-8?B?WW0rcy9iNXpKZUJoVzZFVnFGellSanpOZjVYb3QvS0JPSzM0SGlsZnhpckRC?=
 =?utf-8?B?QTBJai8wamp5dFkwa0VMd2FvSlJhOWc5ZVIwZE9DM0VZM1lrMXh5RzhuUHFa?=
 =?utf-8?B?RktLeWwzMTc2ODlBU0dMWXBSckU0eUdzTVhNcTQ4L3I2U2pDWS9mWmhFTlky?=
 =?utf-8?B?WWQzWG8wcTUvM0U5R2lEY2NPcVAzdzJCSDI1UVdCczB2YzJ6em9FUnBMbWNT?=
 =?utf-8?B?UzNVTmppcnRab0EvdTE4ZGFxcXMzOFRnbzI4UGxoYUxjaWR4TGxGbE5URnZy?=
 =?utf-8?B?MWpxcVFYMVQwd2pHMFlYNFlyNWtsM1h6NUlnMk9YUFFaKzU2amdsVlplRk5S?=
 =?utf-8?B?NXl6TThicjE2d29VcFVzaUsrRWxYeEthQ2xUS3FId0pVbnVtZnFPZWNPU241?=
 =?utf-8?B?UTNpck5ia3FXWG1WVnZCWC84RUF4SWxlc3lncm9SdVM3S2FSTnRvYmpmbXNx?=
 =?utf-8?B?SFNCWDNNQm51bnZwL21mZlFhQjZXbk10NTQ5Z2NnOC9tYXpvbVcxeGx1UkE1?=
 =?utf-8?B?S2VNdDVCczhmcm1SY0MzOUFmOStjZGY1d2s1dUhXVktnOUV4bXpkWHVXU09Z?=
 =?utf-8?B?SGxmakJiN3Vob2cyT205R3E1TkFxZ0Jlc1k5VFo1cXVVSjZ0Yk1hN21iT0pp?=
 =?utf-8?B?dm8yYWpIODlmTTE2TGloVDNSSHdtc3o0UVcyRzQ3anN1ZHJqQzNuZ29IQXdM?=
 =?utf-8?B?SzJqV09oRWorYlh0alVlUkFDVHVoUC92RWwyYnhuQ0x6WTZrWklwUUNRTDgz?=
 =?utf-8?B?YUxuZmkzM21GNUMwa1FyK0hORk92NHhPT3Uvays1L0Z2NGJ1MkNBbGdCUHdK?=
 =?utf-8?B?VDc5VG9xSTk0ZTBoSjE5NHFEQS9udzREenVYMVBTbk1HcDQ1M0RnUFNIOUpw?=
 =?utf-8?B?eEE5NHpFVWFMVTEwZE5DOXhRU2RKWVgvT2J2Wis0MjdmVm94Q3FDQmJnUWNB?=
 =?utf-8?B?Rkw3U3FEODRsRDZPM3Rwb3c3bG5TWnVRVThWckNJOXl2b1BWcGsvTTVVSmho?=
 =?utf-8?B?cFFrcFhYeGlrMGZYWnVmWDBycW8zeDZkcjlmWG9CZm5YY2VzQnd4ZGJIeEJL?=
 =?utf-8?B?RVhuL29JUTBTUndGaUsvUktNK2tYUzZZQmVjRVB5QzFFNTJCcjhLSkMyazBR?=
 =?utf-8?B?OE5SRjFoejkvNXNUbGUzaVlIeldXWEY0SkRNTXNuVTRla2FpUjg4b3B4SUJG?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2b47bc-b1a0-46c2-8e95-08dccd7a9d3a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:16:08.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8G2Lx0i9zlIM66Wa8Cdvdq8fAAf/454HY2cJ+g/xBhKPvIawcJS91LHSOnmw0O+/Yp2HtBtF615WTHYH4cVIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6776

On 05.09.24 08:57, Krzysztof Kozlowski wrote:
> On 04/09/2024 12:00, Jan Kiszka wrote:
>> +
>> +    reg-names:
>> +      minItems: 4
>> +      items:
>> +        - const: app
>> +        - const: dbics
>> +        - const: config
>> +        - const: atu
>> +        - const: vmap_lp
>> +        - const: vmap_hp
>> +
>> +    memory-region:
> 
> This also did not improve. You did not address any feedback from v3.
> 
> Missed feedback:
> 
> This *must* be defined in top-level.

Answered in the other reply.

> I still think this must have some sort of maxItems. I accept your
> explanation that you could have multiple memory pools, but I don't think
> 2147000 pools is possible. Make it 4, 8 or 32.

Can do - if you can explain the benefit of that.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


