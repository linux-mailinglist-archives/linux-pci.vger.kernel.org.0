Return-Path: <linux-pci+bounces-12884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F4896EB64
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 09:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27BF1C2102B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 07:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BBC184E;
	Fri,  6 Sep 2024 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="J6zvZfp9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669F328DB;
	Fri,  6 Sep 2024 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606068; cv=fail; b=XagoJqqYjL/ryVfIzXaVFUzvwjx74MvKsOphlV98eYwM2XicSGeiQbjcc8aK8pVwWkMiS9JZps1DdK0AVS12VV9mh9RZ1h4/tlqMNjQDYtMuOszUizgu6pIfJLrq49knI3u1cq6qciDOn2toqSJyN0NDX19ShuGI2EEBm3Iyybw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606068; c=relaxed/simple;
	bh=yEv01KtKe4zZCWVy4+c/EX1ZRqss6O2jFHYdB5mwijU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PzreNmrbsGophdmC59CqwhegfGQUmaGpGYDWjW1XsC6XJD0GA7Ev17IfaJ7z0ZjCS6KJL84BXf5iUjNTK1AgFsnG5gy49GVWW/bsowphHIpAj34uhvtguB9GINxrYmWZoCopsnCEnK/iky7gzNGh4HISA4EOrb603uQ9KqcZ9TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=J6zvZfp9; arc=fail smtp.client-ip=40.107.104.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUm/jAAZCYO2ZwKWIEuzbhOk9cfPsybpY8Pb2DKS8pApaBjmpzrAooqVwS9aBHIPUXlDHni/etlxCJSikYS9K8zeWe1cYi0Seroowe9N9SuYfcjGHhXrigA39t9XAYs+rOM0GOOMAZmn6pkr96KzeTJgyaTBqGtUW/nn/DiXSRjnKRaxognlMc2R3V7suNdfziAyBOIfWf59TA17JedgQJnh4THuTjD26WCoaVomROytU8CeAYoGrEGl+R6gNvkhNwqFJXC0ovPBS/93L+9mWEUVeAwzllM4iMsqXa/gO9UCO51LPIz1/adfeiHI6L9i/mQjT4hPeGfgwdwjQIi2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jptRK+nsAIInLn3wvb5vULI05w7GbUzleVjidIPbhJQ=;
 b=CHkuT1b7tux1s27nRGZxbPHr7X3yJ8DXbc4OLYqwHUGg6lkYPOIo45ktfUkv0TcTmqHcBjnwFY/0WMptqWuoxISsu00vu4wbgO2d9opKS5D+q0y8ytrakyX3/Uk5l/OQuslNrbSuZ9PquWh0y+ovoDEFpFCiBKdYkVZqKSQlz2QG8YJni+D81rww3IcdL8zqc8HlaL3FIoKxTEVIwQzkSNi3OWoSvffUUqVGN1gWMlxDfGu20pkU1AIFABmkRncxVYHkjzMs9dB1yF2V5NALKNv0RB/MmYyFtx17rqfRu3/eEYjpDkPvrH5oClc17t5GP46dR3Mk09DP6Mjcd+iHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jptRK+nsAIInLn3wvb5vULI05w7GbUzleVjidIPbhJQ=;
 b=J6zvZfp9GPwBTkU7F3Es+YSYZ6XR1Bts0dD18fRYR/TiDC8OfAumFDMcWslBzNBEc5Em/aR0jM/sFxnvlZTO+rHq2X/CIFbUHNgX/G1im1sJ9R04HCuUTrXoHOltmTwMy3SAv7yI7KmxtKMugEKN89DFhMm8CtlOx824EmVKI9WpTaG0ZTI+ydVC+0tdH6nIpWfJfsvO2R2jB6O/N/3MCts2+1SpX+poTLSqJHjQmPm+Yoz6mhNfec1sXM98P/Km1hN6y3iVxH/VZ2tw+4KqdTfRpeO/35KrCrqAoJ2tamCVd7buBW9464TnIwd3xkNUVVrKB6SFkeacGOOJHrj/pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7222.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 07:00:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 07:00:55 +0000
Message-ID: <b662067b-2bb0-477b-a2bc-cbaa7d84126d@siemens.com>
Date: Fri, 6 Sep 2024 09:00:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1725444016.git.jan.kiszka@siemens.com>
 <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>
 <t2mqfu62xx5uztlintofp4pquv6jalzace6w5jpymyyarb2wmn@vvo23e4cmu57>
 <4fd1d6e8-8a66-4eff-a995-5f947a4b707d@siemens.com>
 <669fa971-05f2-43f2-8c7b-d9de68d8910f@kernel.org>
 <50ee7c83-7dd2-44b7-ad80-649db9a76077@siemens.com>
 <69f16e78-218f-4e03-aeca-05be5844d656@kernel.org>
 <ba883b6e-7d64-483d-8125-efe10ff9195c@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ba883b6e-7d64-483d-8125-efe10ff9195c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fecb7aa-6caf-4f24-8a65-08dcce41a73a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUpJaFJZbDNFclJMc0wrdFRCclVuaDV5M3BIVFJtSDhlUmx5SjJsQ3YxT1FQ?=
 =?utf-8?B?SkxMMkEvRXJ3ekY5R0ZsYm9uTkM2MzExQ2ZxVlpYZk1RMUNuR2RpclZNTTli?=
 =?utf-8?B?SGQ3NDNFWGxIb3MzMEIzMTFUWDBZTjhUN1dqVll4SkdTaDFtbURmTnZJQlVj?=
 =?utf-8?B?dTZpeWtvTmtqQ3Z0YlFhakY2ZGhpK09OUE1OVFVCekpnQXJza2dJYzg3MUZX?=
 =?utf-8?B?dTNYMjNwNUFlcTFuUS9NVTFKRndBV2lPMy9DM3Y3VjZ4MTNpSXFMSS9Sdmo3?=
 =?utf-8?B?aE5jMmEvZHMzZENkR0JtZlVrbk1ZTThhdDhmWDF6bTJHK2VLd1NpNjA1Q09C?=
 =?utf-8?B?NDZJU0s5eTB4M0NVNlZvV0ZDbEJ3c2lXSkIvN01DUFk1VFlCNDZ3TE1UQlA1?=
 =?utf-8?B?RjIzY0hrN2x3Y1BMS0JweFRmUG51OC84YlpBTUt6ZlRuWGhhUVJkMTJsdkRI?=
 =?utf-8?B?eEsrY0Q5emVJNUcyNEpmVU9YZVNoYkV2RVFVbGVyWXQwa0ZRaDNEOUJmeTdp?=
 =?utf-8?B?R0tFV0ZGcVorbjlBZzN2YStrVW16bVBGZURyWVZycis5ZUtqd0NGenFQQUdW?=
 =?utf-8?B?SkpoaDd4N3FpeUQraFIrRWlFd2ljelNuTDIxd1pOZmd1ZU9iTHZPamtzb2FE?=
 =?utf-8?B?SW9CNUtTTk9jN1pJV2VCeXdxODhvVlVCVE5qT3NJOHM4bVJRQVZxMHNLR2Ns?=
 =?utf-8?B?NHJSTFpub2JraVByL09haWI0K0JYQ2d4NE5SMVVwVHM4TnRYYnZCNnMzakZy?=
 =?utf-8?B?aW40NXVOMEs0MUM0Nk5CZlg4VE1KMXl2akxLTkxpS0MrempMK0EvSlNyUFpa?=
 =?utf-8?B?SEc1Ym5RMmVHT1hYMVd2cGdYMFlXNzlRL2xJOHNOYm1USkV6NCs4V1lWa3Q1?=
 =?utf-8?B?VkVvb1VDYWlySHZHSU1JYi9ZbWdrM2R5SUxJWGNPMXVlNTVYN0ZQbURac0FH?=
 =?utf-8?B?TWxnQmJRb0dQTVNVdS9XSWw3ZW9EZ2duUWV1YkhvdVFRK3ZmcSs4MFJFQTFw?=
 =?utf-8?B?QVFETzI0ZUNPUENFcVBUL2NhaEs4a3BZaCtmK3V2aUc1alVGOWp2WVFCMm9s?=
 =?utf-8?B?VmdqQ3NXWkVnUXFuN2Ixb1JlY3RsdFpjVzhLdWNET0VwYUUyNTIwYXdpSGRk?=
 =?utf-8?B?Ulo0dzVhZU9hV1FoZmhZK3hWWENGbXdQanBXWldyd1NJZlNvTC9Ed1Exazhj?=
 =?utf-8?B?MnNkVHprQlI3VVZUUEduQmVJOW5QdlhwdDh4Q0tiYnNwL0E0c3pBYUF5ZjRp?=
 =?utf-8?B?ZktjU2gxSSt4VmpDVVZEc3QvSjJyTmxoSUJFbVNEVytwQlprcmVEci9ZNlRZ?=
 =?utf-8?B?VnhZN3c4M3lSRjVzeWMxU2MweUVVL3JxQ2ZlNmwxUE9vRHdLQWh6bnVlQ3lq?=
 =?utf-8?B?SUtiNmMyTllISzRBYStFS0hhTDVrZ3NCRHVIUzlwTVlueUNDMzdId0g5NUZm?=
 =?utf-8?B?T3lpS1M2WXJkeTExbmlab1RUTE8yaHAwb3BaVytVR3l0ZkNpYTNiYjYyeW1P?=
 =?utf-8?B?dnFOamdWaVRodzZCNDBZYnBNQzE3RUJZWUdzWUVKVnk5eWhDTWJ3ZDRVV1Bs?=
 =?utf-8?B?SGlRR2N0SXpWYngxOWE5VWpLWDhFdlJwWldyQlF3VzhlN29BQVhjVXpSR2tj?=
 =?utf-8?B?U1hoTlp0VXFnTENURGtISmxvZHRzTi9jUzBTTkJLOUhEdWNJeklOZzd6bHBw?=
 =?utf-8?B?REVYcjZLWGhtV1EzdVFGRUZ3aGhmY0x1Nkp2RDlmQ2Jtb3hMYWQzWkhEY1V5?=
 =?utf-8?Q?6qza3hxh0Lc5xpapMs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3JtSGtRdXFTUzdjeUphajhxNmwvQjMwRzB1ampEZ2Q3N3dpL0lqK2I4YmpB?=
 =?utf-8?B?ckY2OUdoUTM2Rk9rSC9Xa0dmMlNEb3d1aVhKR1FQRmxlMVdKUzcwUWFCeGlT?=
 =?utf-8?B?YkEvc21DWWhiRTlUK3kycHlSRnp0TnF1eEZWb0V5dVR2cGVPQk91ejhwOURF?=
 =?utf-8?B?TGd6Yy9jcFlhOU01R1I3Z21sUzQxKzIxbnBBWU1MUFdqK0dkK0ZkamtrQ2xJ?=
 =?utf-8?B?OS9XblFBUnhHNGdFSkxTcFEwbUsyUDdKbkdsNEVRaUx6RkFlRU0wQ2dyU3dy?=
 =?utf-8?B?STY4V1RHUTFSVnJEVVJkWWVJb1dUUlpPT0R1b0FkbW8rdHNmL1Zlc1YySFNP?=
 =?utf-8?B?aGJ0WXZJbjE1ODJYclRTT0FkRlBxcVFzNVNTUCthVW1HVWJZUGlzVGloeW8z?=
 =?utf-8?B?ZWowRmZZT29mWVoyclNBa3RuRDZSYzVtZ2pCdWVIMjFLWEs0MHcvRWJSTjg1?=
 =?utf-8?B?NW1qN0syNXQ0aXN5bU9ZSlFCbmFjUmZUSkVzU2wrdTJTMmR1N1g0Umt0RHd0?=
 =?utf-8?B?TmxObHRnSFZLRUhNMGtISTRlY05uV0JreUJqZmMvNUx3b29VdTFabzRMZTRW?=
 =?utf-8?B?b3hHcEtuMURCT3Z6MUlhbDB1UTcvOFg0R3Q3cW5rSFVUSDlaWWN5bzhHVXFL?=
 =?utf-8?B?MlF3ZnNpaUhpMU1lUDIzZi9NYnB2OUdsTXphbXA2MndVNU1IelBLVjYzeWJI?=
 =?utf-8?B?VkNjWmQzQ2JPSlBEMVI0WWNvQXJ6QUQ2K0RSUUExTzNFOHBoMVo3c2wvdHpV?=
 =?utf-8?B?RlM0TVI4TGQ0Ujg0dEY3TXBhNWJCZUtRdVF6b0JUZGxOdC95Q3A1VlVqK3FL?=
 =?utf-8?B?OEtCc0Qvb1FmMndDR0w1WVJQK0dEUUhwSzlXT2NYemFHWmR1T3hqa2J0N3l6?=
 =?utf-8?B?Rm1oQ081Z2xIU3JaQWpiSFBjd2xQdEcwWDhFVVdLTjNXMTROd013WEd3N2RY?=
 =?utf-8?B?VHZqZFN3Q1pxUWNRSVhJUk55bXNKQTl5T1BCVzA3U0gySlJHbzVTUHBMZTNs?=
 =?utf-8?B?R3VvclpQZERoSlNrdzdMU1czVW1VYmNXUlBTQm9LWW95ZHNXYWFRbUtOT2J3?=
 =?utf-8?B?RmlQZCs4bmdmU2h3N3NEcEpITG1MZG5UZHBWLzRmTjhaQ2lYa3EzbVVOdU4v?=
 =?utf-8?B?eXlVOCtFZzhINWExdXBNVmJhc1dYNG5CdXRDYTlLUGdmSWZacmxqamJlUmNP?=
 =?utf-8?B?QVNSYjl4Rmx6VHNRODBCMlFvU2ZDbmRrbzRvSGJsUGQ0LzFkV0g3bysrQzVK?=
 =?utf-8?B?TWo4Wkxtc1ozVEI2cU1sWkpUYSs0c2g2VnRWOXRjVWh4USt6U2laalAzUlZN?=
 =?utf-8?B?UGZwcnN4OS94TGZ0Ym1LNFBoQUpyQzVMNHFBYU9FZ2NDVGFzK25GblpOc0dD?=
 =?utf-8?B?czk0b2dnQ1hTOE91bDRwL0owVU5oS05sUUZNQVYzRkEvb05xaG9HR2VDUHJ6?=
 =?utf-8?B?aWl5cktrWE5WTXdVVWlQVDhMM00xUmFGam9laE5RVjB4MHIrL2xQMHExYjRF?=
 =?utf-8?B?M3VyRlZadzVoWHQwcGJaS05DWFhlSE9SMTF1NHJWa04vQXEyU2k2aklTaVhM?=
 =?utf-8?B?aXZEMjJGMmpmK3dPNWNJYWJkM3B1QkNZK0pLK2JTeWVrdUdtc3pjMEdIcjFl?=
 =?utf-8?B?amRvOERMMVlCcTY1Z1RQQXlyeGczeEpyQ3BuQ1B6d202Yk84bmhpSzVmR2lQ?=
 =?utf-8?B?bitWUkVMdXBGVXdEUEhUVEVEMWZ6VDZEbW5malVwN0s4ekh3WmpjdEZ1WElw?=
 =?utf-8?B?aXBOcmlhMlhyZzNqbXZlcm1kVXNsOWl4K2NUT0hvMFN6bEwxa1pyZWFaMVFp?=
 =?utf-8?B?dnluOTFYSWVBdDZKTkZ5VVpaZ0wwNEEyWG0wLzZjSDV4UURXMDJuelF4a0Ny?=
 =?utf-8?B?NUZ0bHBGUTUyY2xOMDRDbW5hTm9rZXBucytVK1pJMDRNVVB3WFZQZXNkc1lQ?=
 =?utf-8?B?OHpFOGN3bUpsYkNLa0pEd2ZmeHpsbFA3dUxsSW5LK3piR2tPWnVGWmRjMVR4?=
 =?utf-8?B?TllVMSs2MXd6ckNZS3BYNEJVR2tMYU9DeFVUenhtaURWaWlUYTQ5U2JucS9B?=
 =?utf-8?B?RzJiUjFwVEpzbHBydnliMk1yU0lYb2k1ZWhsSHJ3Ujh4U2hmUnN0ckttY0JE?=
 =?utf-8?B?VkxQOCtLZWh0WVJjOGZUNUd1RVdpb3hyOXlsb3FxY0hoYTg1SjcvMjVDTWIz?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fecb7aa-6caf-4f24-8a65-08dcce41a73a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 07:00:55.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hi44JOsU6bz0cCA7JF/e2yKOKO8d3niojOiezfglaYIty0VIWqWQ1ZyJBjbhiMD885S//L7PrNT5ElbXqOK4vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7222

On 05.09.24 09:56, Krzysztof Kozlowski wrote:
> On 05/09/2024 09:50, Krzysztof Kozlowski wrote:
>> On 05/09/2024 09:15, Jan Kiszka wrote:
>>> On 05.09.24 08:53, Krzysztof Kozlowski wrote:
>>>> On 05/09/2024 08:40, Jan Kiszka wrote:
>>>>> On 05.09.24 08:32, Krzysztof Kozlowski wrote:
>>>>>> On Wed, Sep 04, 2024 at 12:00:11PM +0200, Jan Kiszka wrote:
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>
>>>>>>> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
>>>>>>> to specific regions of host memory. Add the optional property
>>>>>>> "memory-regions" to point to such regions of memory when PVU is used.
>>>>>>>
>>>>>>> Since the PVU deals with system physical addresses, utilizing the PVU
>>>>>>> with PCIe devices also requires setting up the VMAP registers to map the
>>>>>>> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
>>>>>>> mapped to the system physical address. Hence, describe the VMAP
>>>>>>> registers which are optionally unless the PVU shall used for PCIe.
>>>>>>>
>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>> ---
>>>>>>> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>>>>>> CC: "Krzysztof Wilczyński" <kw@linux.com>
>>>>>>> CC: Bjorn Helgaas <bhelgaas@google.com>
>>>>>>> CC: linux-pci@vger.kernel.org
>>>>>>> ---
>>>>>>>  .../bindings/pci/ti,am65-pci-host.yaml        | 52 ++++++++++++++-----
>>>>>>>  1 file changed, 40 insertions(+), 12 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>>>>>> index 0a9d10532cc8..d8182bad92de 100644
>>>>>>> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>>>>>> @@ -19,16 +19,6 @@ properties:
>>>>>>>        - ti,am654-pcie-rc
>>>>>>>        - ti,keystone-pcie
>>>>>>>  
>>>>>>> -  reg:
>>>>>>> -    maxItems: 4
>>>>>>> -
>>>>>>> -  reg-names:
>>>>>>> -    items:
>>>>>>> -      - const: app
>>>>>>> -      - const: dbics
>>>>>>> -      - const: config
>>>>>>> -      - const: atu
>>>>>>
>>>>>>
>>>>>> Nothing improved here.
>>>>>
>>>>> Yes, explained the background to you. Sorry, if you do not address my
>>>>> replies, I'm lost with your feedback.
>>>>
>>>> My magic ball could not figure out the problem, so did not provide the
>>>> answer.
>>>>
>>>> I gave you the exact code which illustrates how to do it. If you do it
>>>> that way: it works. If you do it other way: it might not work. However
>>>
>>> The link you provided was unfortunately not self-explanatory because if 
>>> I - apparently - do it like that example, I'm getting the errors below.
>>>
>>>> without seeing anything, magic ball was silent, so I am not
>>>> participating in game: would you be so kind to give more information so
>>>> I won't waste my day in asking what is wrong.
>>>
>>> With my patch:
>>>
>>> # make ... dtbs_check
>>>   DTC [C] arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb
>>>   DTC [C] arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dtb
>>>   DTC [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dtb
>>>   DTC [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dtb
>>>   OVL [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtb
>>>   OVL [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtb
>>>   DTC [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dtb
>>>   DTC [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dtb
>>>   DTC [C] arch/arm64/boot/dts/ti/k3-am654-base-board.dtb
>>>
>>> With this revert on top:
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>> index d8182bad92de..dd753dae24c6 100644
>>> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>> @@ -19,6 +19,16 @@ properties:
>>>        - ti,am654-pcie-rc
>>>        - ti,keystone-pcie
>>>  
>>> +  reg:
>>> +    maxItems: 4
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: app
>>> +      - const: dbics
>>> +      - const: config
>>> +      - const: atu
>>
>> There is nothing like that in that example.
>> https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L44
>>
>>> +
>>>    interrupts:
>>>      maxItems: 1
>>>  
>>> @@ -104,18 +114,6 @@ then:
>>>      - msi-map
>>>      - num-viewport
>>>  
>>> -else:
>>> -  properties:
>>> -    reg:
>>> -      maxItems: 4
>>> -
>>> -    reg-names:
>>> -      items:
>>> -        - const: app
>>> -        - const: dbics
>>> -        - const: config
>>> -        - const: atu
>>
>> Neither this.
>>
>> Each case MUST be covered, look:
>> https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L191
> 
> Actually your case fits better another example from UFS, so take that one:
> 
> https://elixir.bootlin.com/linux/v6.11-rc6/source/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml#L39
> 

Via lots of trial-and-error, I think I now understood the magic behind
this: You may reduce maxItems in a condition, but you cannot increase
it. That's why all my intuition-based attempts failed before. Not sure
if this is a specified property of the meta schema or just an oddity of
the validator.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


