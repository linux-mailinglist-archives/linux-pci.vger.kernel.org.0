Return-Path: <linux-pci+bounces-19801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53747A11606
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 01:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6361889790
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8D22111;
	Wed, 15 Jan 2025 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hBuskbFc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658B111AD
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736900434; cv=fail; b=dpcKBOuNRIACtoGDurHm7rjhKcXUqRoSfY0XL6Hny7WKzcqDDRCrB+WtBtNtQeYpB+T5PmibIpI7k9s+IalqkNg568cqY2oVZPDsTFa06eUNpU7aUughtKENDZofljKY6uq+q7vUY1yDP55Nr7Va/PUh36K99fOap4X3BeQV9Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736900434; c=relaxed/simple;
	bh=A/OdpTtDAC9M4W7wx/mRiKHFMzLPPYgp4O8M76ni5AA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QmtR9oFCHFFsR1ULVireMvmjZ+61TMJVkMlPlZiYiKTsEm2FvYmfv3NknADN9RHX8edREJJBioxdbqcDmGEW+2FSb3zpyjEbAZlnpyyXEiFNWo670zxGve0rRTX/K8XLYGgk5rBkjcGGNo3aunocPFrHUGqNoLs95hSF281qAa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hBuskbFc; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlvM6ryPbXkmTiwzdh7tqnRBmVP7gfGEwvNP9/ZSBlBHxqZ97ghFWlQ0gx2+s+xt5MAbYLl3nJugdNwgDp+19Ao59Q0VExD9Gkj5qBV99y3UZtUSfJlbHF3O9SROiT6jliY9Fu7dr/zqiwmeCYOwi5faOQD8gKZIyAsmfMrBp2YJ/gUv5bj7SdFLGp1FwEmFW8ATDPR+d14zW2Wu7+F2KwYZi1Q7skf0iOyK1JCOAwqCqJWUGzSJOF7X2CLctiFEo8LnMETywm8AZhkCJiqx/0CpuXa3rlRdNha1FB/CtySWqEET+Q3X/IXVoKEmTwQzj6bXd/bmfoo87uFgWYIMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIuqzY6n1yUn0iNTx4O+6lhS1QuxjXdyL88Io9cFw0s=;
 b=mjiSMuMKV+2/O9SetteI5gnZUvu5Xv8ZFQl16D2rM6oMkJXxIAEr3NcRqbTW7kyoMmPYvUbb0OcqFrm4etrpgrw0vJAa1DKbWFADSpgetRdi7MVPWmb9xe574chbAIGxZj8RzkL1O9Flrr7s3X364U2/+yBBH1EqQTgFczIQahAlN60YDAY+grHbNt0kMbLCiaAB3RnCRKtED473mIQBm0c+1pjPQ+4X339MciUcawRY8NzT7ncvSItXLX1yNTJDKzhwrXHvUXxszHVVoSN1znueOO0QRevRzE0sMNjKK6ypmRscPN7V+LJRzplDsrAni1WpVuwVCpmnhCf9hK6qNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIuqzY6n1yUn0iNTx4O+6lhS1QuxjXdyL88Io9cFw0s=;
 b=hBuskbFcz1HV79qMmdN7Zp4p3cgMmvPP3upiDkbrHznkYOzHBb05Gnof1kFuFfOFqa6ieW9po5nnmf1O2OX3dgFMk2ZW6abSE1PZ65fvPRWzyW3Vx3gjWJoUCG/uluOBC0KlIN9YKt2Yipyw/w7wNz8qwQ+aH7OcOJzE+05fGRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 00:20:29 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 00:20:29 +0000
Message-ID: <a11c82c3-b5fb-48d9-8c95-047ac4503dc6@amd.com>
Date: Wed, 15 Jan 2025 11:20:22 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
 <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>
 <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEWP282CA0170.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1cd::17) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0861ab-8963-426a-1c94-08dd34fa6aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXJlYWV3Rjd1ZzF2TjJhRE5ITmJ4R0pacm9MSlp1Y2JQdXVtT1REVS9Nd2E4?=
 =?utf-8?B?VXlUTHBsNHdhb3p2dTVZaFdLdG9RaWtJVWdwU25XMFNSenNPWjZOTmwxRzVo?=
 =?utf-8?B?eC9RNkVwdWxkNGxLTXVKMG5rYkFORWVvWE9WYjF3aVJWalA3M00xMk9QV1Nn?=
 =?utf-8?B?TnZjYWpPdXRxU2YwRzd4WERPZDl3TDJsTE45ZGR2cnNpK2h6d0xzTHRCOHBW?=
 =?utf-8?B?azZJSnIydTlXYXcva1NVeHdJSDgxK281M0hoNWdJU3p4Wi9uYi84T2JaK0tk?=
 =?utf-8?B?UzJEL3crK2lDanprM25LNTkycTljUVlySGJaZmU4c0pqY210UXRoSTRhcUV6?=
 =?utf-8?B?Uzc0YWpPdTBwbTUvcGRYTmlGQytyYXpxVHlVSjI1VkVrVFVVTDNXeExwZlA1?=
 =?utf-8?B?TkZSdnpaYnBaY0dka3YrVC8wZkFzei94NXQ3cGF4TjZVbWNCRW5kYUZxSUpB?=
 =?utf-8?B?aStkcWhiUGcrYjV2S1gwbjhIakxqT20wYTVJcHBLSXNZR2RCN0VQOTNmWm5Y?=
 =?utf-8?B?bXhnZUVHSldZdUJ2Vy9VZ0x0Nm9IenhxV2NRWlEzaFBwTnZqUEtlSVlxTGhO?=
 =?utf-8?B?SGZCc0tRMXN1YXZyK21rRzFxRGpCZTFXbWFFOHNXcDdGeUFMTGhVM1lVN1lL?=
 =?utf-8?B?Vjk3empMdHBETERQdGFVZFR2dnZ5OW1ZVHNTb3RLZ3Jab0lJLzdGVklDZkNr?=
 =?utf-8?B?WFhHTVNaem51cjdQUDVGT25kUTJWRldpZ0lQZlVCOWJpWDBkeWxmcXpEM05y?=
 =?utf-8?B?VmhIT2cwcXJTV1VJcG51Vm92Qk1EZ3V1V0xNM1lrcnpwYWhVWVdCUFVyazZI?=
 =?utf-8?B?OEM3NlJPV2lkNXlXNDBCcXNSV0MrQWJ2TyswY1RLTmpheVlxYzByMWVnNXJh?=
 =?utf-8?B?VmthRVd1YnllcmtSTk9YRGJZQklOcjBUM3duUTJtd3FLUlg1Yk9PZXRVUVhN?=
 =?utf-8?B?QU5TWkxlV0JzWnVKMjZWczhwTndoSDR2N05rMzFWZmpmSGx4N1JqazR1UFdp?=
 =?utf-8?B?eDIyc3BER2J6dDdLTjJTZjFoMkQ4dHhMOUY4OExIWDJPdjRNeEs3Q2dpZStM?=
 =?utf-8?B?VGMzMGlkZ0xsR0RRYThlc0xBdTVtTzV6T0RMaFZBa0N2WTU4TG1kd01YT2dk?=
 =?utf-8?B?akR5cGxVbFg3UUdjZWtZTlk0b2dMUzI1NW1UcDRFWnBVSENDVzRuM2h4NlFF?=
 =?utf-8?B?dzcxODNoTmVTUWFoc2JpZG9IbHN2ZjJnazM3STRoRk1VZFZnTk5jZGlLbFoy?=
 =?utf-8?B?RkFQRTR3eXVEKzA0a3YveGJENkJ1L1V1UkJ6K0dZeHZUR0JHM1hiM2tDeGh0?=
 =?utf-8?B?WUorRjVhVmJIQWMrLzZrRFJkWXg2WDBzby9pSXN0S1l5SkU0cmVFTFFNY3Zp?=
 =?utf-8?B?ZjljTG9PelFHditaMHVESnRHcVJHbkNJcFpkZTRqVGphMncvYWp2NDlOcXkv?=
 =?utf-8?B?TS9EOVRYdjVKaHhhUURIeUhMc0hHa1BQNE9qOExVMW44Kzh6QlpZR2Iza0hh?=
 =?utf-8?B?L1RFeXE4TVl0UGZOQklKZE52NTBFOHNINEZBYVpTdVZTejkzbS9UYVJZbjRk?=
 =?utf-8?B?SUk2YjRSUzlYa01yM3YvMlFUWHljSnJTeURURWo1YmNtN1NvbU5MQ2RnQnQ3?=
 =?utf-8?B?bS9qTjBtOUx2Sk9hYnJONEJXTnpRK0wya0twQnZJVk90R0d5TnVOWXNQOVF0?=
 =?utf-8?B?aW9oTW02NWdHcGk4bml0VDNPUXFIeGFkNnVWbytIU2NPZ0gxdjF0dnB6c1lX?=
 =?utf-8?B?dFpGbkNnbjQvZFJaUXZNYUthbXFFL2VzWmpqU3FaeExBaTRnckJ4WjJlejUz?=
 =?utf-8?B?QmNEelVYZXVzT3BodjN1UzB0eHA2WmhlbHdKQjBjNWlOMTRTM2htR2dFTE9z?=
 =?utf-8?Q?Vd7niJ4OgWyI1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFZ4d00wNXJYeGNzYkVXMVRxMzRWUEJxMlA0NFJwZDFqRHNLWk9CTDArZ0la?=
 =?utf-8?B?NFZ3bnRzMVJ6ZkhSdVZ0UVhIVThlU1ZEdk5QUGRyU1ltR0F2T0Y2eUJqKzNj?=
 =?utf-8?B?cWhpWEZhcEFsME9CNFd3ejNVL3VQWFc5cVlxUS9pb0EzMTladG5BYzVVKzNq?=
 =?utf-8?B?UWRDUENwbjNpa2ZrcTJ3SHU5b0d4M3BISk1NREoxdEJHeEV2TVNGVVpIcU9M?=
 =?utf-8?B?aDZrdlpZUVU1aXVKaDhTdWxvMERyZ3AveUVxZ0E2KzhqSmRNcXkrY2ZGTUNw?=
 =?utf-8?B?T1dEQldldWpwcjN1QkpVbDJqempjemRMVWF0R1BwRXp0Tjk2bThZTmJtb293?=
 =?utf-8?B?UDNvbTlwSnlEdkhPSnNPOGZRaW1DMm5xUy9hMFUxZEErZzlDLzFWQ0Q0bWlm?=
 =?utf-8?B?eDdkT2dWazBxMURTMTZ6MTVYeDZ3RkJBaFlWOTBYNlNPc2F6YlpIQlE2NnBI?=
 =?utf-8?B?dk5VRlBBU3RCaFlYdDFWVEtGL0JraVdteTYwM0NSMGkrd05lWW5HcG9CTkJJ?=
 =?utf-8?B?cjNyR2hTV3J4YVU1TFdoeEx5c05lNVFyaEl4N1NqbEdTRlM1TTNOYVpQSkN0?=
 =?utf-8?B?V1VIRU5lY1JQVjl4MmRlaE1hdmlJUUlSdTYxMFZIeFpmdkQzLytUTTQ4SG8r?=
 =?utf-8?B?WFl6elVuQ0tkbHB6L3ROWGdjazJjSzZNa09wdjc1dmwraWVBajVnejNPL0Rl?=
 =?utf-8?B?YzNEb1gya1VTdmRSSTRIUWd6OUhOMGU1NjJyZ2h2R1FDalV1bkt1bWRoak52?=
 =?utf-8?B?NlE3WnFjQWNVZ3ZmY2pNT1BIcitpQ1hYcEJpMFc5UlFrTWFpSTZkZjBjTTQ2?=
 =?utf-8?B?RmJyUW9GMkJMUVh1SHNvWWNQNVQ1NVpHdEU0dDFkakJWYVVxTzgyeUVXd1Zt?=
 =?utf-8?B?Wmhmdll4VWhmV3BaMDZydnhYM3lWMzIxOEJHMjlDU2l0WmdGaXJscFBTaHpH?=
 =?utf-8?B?OTdYL2dGNW9JRGtMM0VEL3c2ODV0WnVPZkhMTnMrTUdjRHBWb29HQVZUbXA5?=
 =?utf-8?B?ZER0R05VeDZwdnlnMG9YSmhDOWltUEhBemJnKzZCRDA5ci9GbElmVE5oc3I5?=
 =?utf-8?B?c0lFaGFSZlpTS1B1dUxVWUtycEdpM2ZHejBZVTBpRmVyU2F4ZkV4QTRjTjNn?=
 =?utf-8?B?WXcxdDhoK2hnVTBtdWx1S0l4ZzE2azRPcTJaR2p5QjlEY3hXdHF5NHlXUnVW?=
 =?utf-8?B?OURudjFuRG50b0kvVkFaWG9OWnFSYThKSFFFdnNtc1RjN0FKTWVZWkZLZk1p?=
 =?utf-8?B?cHlUViswby9qbHI2OUMwWWQycUt6QUMvSW95dkF0dlNkL3dyQ1JTYlBlYzV4?=
 =?utf-8?B?ZGRhdk1vdUdlRFdzUVhGYkFFcjFuMHBaVytrQnRpdGs1NHl6YTV0VkhNSFY4?=
 =?utf-8?B?emhSSWZVR082VXdMOTRSQzZyRGV1VFlpZ1lnRHZlQjE4YWpzTnc2RWI1MjBq?=
 =?utf-8?B?SkRKalRQTHB4SW5raG5uNUJBMi9iK2ZNY0tjalNoUFg0MzdOK0ZMejh6blFm?=
 =?utf-8?B?VTVkL09OdjBzSjVXS1g1YzFOVWpzVzZlL2JMeXdHSDdQVUU2dk4wYkZ1RlQw?=
 =?utf-8?B?RVc3U1RJdXZRbUVWdndWcnBJN2VmK1RuVHZaRXJTTS9BNGZuNHNkUnN6QWpy?=
 =?utf-8?B?SEpQY3htcWE3bGlaSWwrdWtzb1ExRlowOTB1YjRWMXpVMVBxSzdJTlY2d2ta?=
 =?utf-8?B?dEcvQndMN1dBWkJnTmRtanhZUmxaQWxCUVBYVjlJTkw4K0xUakZveVdwYkdz?=
 =?utf-8?B?NDZIbm9LVjI3WW93eXppeVJ3dU5BekQvb0NBVnNjMjB4M3BEYkZnTjdXcTRB?=
 =?utf-8?B?cE8wVTA0d01OZmhLdCtNNzBlTWxxZStla2l1dXBKUUEzMUNoWlVTajM1MGt1?=
 =?utf-8?B?OW8vcWE2R0dzbVVNZUJBQ1pMTmlNVXdTKzlBckRRMGZHVjkzV3JmcWFKQXoz?=
 =?utf-8?B?ckhQTGcwVS9aZkdhRFhETGorblFOVVdVRUNuMStRRlZkRkloTC9ELzFSUHEr?=
 =?utf-8?B?VDg4aG1KZjVIcmo3R0VaTytCSkZkYlQwSjBIMC9NcmxDYzZ1QzdRZnU3T0h5?=
 =?utf-8?B?N3AwQzBVRjJvaTltUDhEOEZXakROOVNlb1VtYWltTnNZR01zdTR6dUFwbjNm?=
 =?utf-8?Q?KkQlFExd8qbvjJYtQEhJThqPi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0861ab-8963-426a-1c94-08dd34fa6aa7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 00:20:29.3686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UR5nL2Hs6keFx+cpYmJy9twkED+55zXUa0IWF9mfnJmNNt2kHDMdMr9b/Y1BpN37miQPMI8nZnvC/FKWXsy8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659

On 10/1/25 08:28, Xu Yilun wrote:
> On Thu, Jan 09, 2025 at 01:35:58PM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 8/1/25 07:00, Xu Yilun wrote:
>>>>>> +static void __pci_ide_stream_setup(struct pci_dev *pdev, struct
>>>>>> pci_ide *ide)
>>>>>> +{
>>>>>> +    int pos;
>>>>>> +    u32 val;
>>>>>> +
>>>>>> +    pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
>>>>>> +                 pdev->nr_ide_mem);
>>>>>> +
>>>>>> +    val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
>>>>>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
>>>>>> +
>>>>>> +    val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
>>>>>> +          FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
>>>>>> +          FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
>>>>>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
>>>>>> +
>>>>>> +    for (int i = 0; i < ide->nr_mem; i++) {
>>>>>
>>>>>
>>>>> This needs to test that (pdev->nr_ide_mem >= ide->nr_mem), easy to miss
>>>>> especially when PCI_IDE_SETUP_ROOT_PORT. Thanks,
>>>
>>> Yes, but nr_ide_mem is limited HW resource and may easily smaller than
>>> device memory region number.
>>
>> My rootport does not have any range (instead, it relies on C-bit in MMIO
> 
> It seems strange, then how the RP decide which stream id to use.

The RMP table (an AMD thing for secure memory) has streamid.


>> access to set T-bit). The device got just one (which is no use here as I
>> understand).
> 
> I also have no idea from SPEC how to use the IDE register blocks on EP,
> except stream ENABLE bit.

Well, there is another problem.

My other test device has 1 link stream and 1 selective stream, both have 
streamid=0 and enable=0 after reset. I only configure 1 selective stream 
(write streamid + enable) and do not touch the link stream.

But the device assumes 2 streams have the same streamid=0 and when it 
receives KEY_PROG, it semi-randomly assigns the key to the link stream 
in my case so things do not work. The argument for it is: every stream 
needs to have an unique id, regardless its enabled state as "enable" can 
come before or after key programming (and I wonder if somebody else 
interprets it the same way).

This patch assumes that the selective streamid is the same as its index 
in the IDE cap's list of selective streams. And it just leaves link 
streams unconfigured. So I have to work around my device by writing 
unique numbers to all streams (link + selective) I am not using. Meh.

And then what are we doing to do when we start adding link streams? I 
suggest decoupling pci_ide::stream_id from stream_id in sel_ide_offset() 
(which is more like selective_stream_index) from the start.


> And no matter how I program the RID/ADDR association registers, it
> always work...
> 
> Call for help.
> 
>>
>>
>>> In this case, maybe we have to merge the
>>> memory regions into one big range.
>>
>>>>>
>>>>>
>>>>>
>>>>>> +        val = FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |
>>>>>> +              FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,
>>>>>> +                 lower_32_bits(ide->mem[i].start) >>
>>>>>> +                     PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT) |
>>>>>> +              FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,
>>>>>> +                 lower_32_bits(ide->mem[i].end) >>
>>>>>> +                     PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT);
>>>>>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), val);
>>>>>> +
>>>>>> +        val = upper_32_bits(ide->mem[i].end);
>>>>>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), val);
>>>>>> +
>>>>>> +        val = upper_32_bits(ide->mem[i].start);
>>>>>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), val);
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Establish IDE stream parameters in @pdev and, optionally, its
>>>>>> root port
>>>>>> + */
>>>>>> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
>>>>>> +             enum pci_ide_flags flags)
>>>>>> +{
>>>>>> +    struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>>>>>> +    struct pci_dev *rp = pcie_find_root_port(pdev);
>>>>>> +    int mem = 0, rc;
>>>>>> +
>>>>>> +    if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
>>>>>> +        pci_err(pdev, "Setup fail: Invalid stream id: %d\n",
>>>>>> ide->stream_id);
>>>>>> +        return -ENXIO;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
>>>>>> +        pci_err(pdev, "Setup fail: Busy stream id: %d\n",
>>>>>> +            ide->stream_id);
>>>>>> +        return -EBUSY;
>>>>>> +    }
>>>>>> +
>>>>>> +    ide->name = kasprintf(GFP_KERNEL, "stream%d:%s", ide->stream_id,
>>>>>> +                  dev_name(&pdev->dev));
>>>>>> +    if (!ide->name) {
>>>>>> +        rc = -ENOMEM;
>>>>>> +        goto err_name;
>>>>>> +    }
>>>>>> +
>>>>>> +    rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, ide->name);
>>>>>> +    if (rc)
>>>>>> +        goto err_link;
>>>>>> +
>>>>>> +    for (mem = 0; mem < ide->nr_mem; mem++)
>>>>>> +        if (!__request_region(&hb->ide_stream_res, ide->mem[mem].start,
>>>>>> +                      range_len(&ide->mem[mem]), ide->name,
>>>>>> +                      0)) {
>>>>>> +            pci_err(pdev,
>>>>>> +                "Setup fail: stream%d: address association conflict
>>>>>> [%#llx-%#llx]\n",
>>>>>> +                ide->stream_id, ide->mem[mem].start,
>>>>>> +                ide->mem[mem].end);
>>>>>> +
>>>>>> +            rc = -EBUSY;
>>>>>> +            goto err;
>>>>>> +        }
>>>>>> +
>>>>>> +    __pci_ide_stream_setup(pdev, ide);
>>>>>> +    if (flags & PCI_IDE_SETUP_ROOT_PORT)
>>>>>> +        __pci_ide_stream_setup(rp, ide);
>>>>
>>>> Oh, when we do this, the root port gets the same devid_start/end as the
>>>> device which is not correct, what should be there, the rootport bdfn? Need
>>>
>>> "Indicates the lowest/highest value RID in the range
>>> associated with this Stream ID at the IDE *Partner* Port"
>>>
>>> My understanding is that device should fill the RP bdfn, and the RP
>>> should fill the device bdfn for RID association registers. Same for Addr
>>> association registers.
>>
>> Oh. Yeah, this sounds right. So most of the setup needs to be done on the
>> root port and not on the device (which only needs to enable the stream),
>> which is not what the patch does. Or I got it wrong? Thanks,
> 
> I don't get you. This patch does IDE setup for 2 partners:
> 
> __pci_ide_stream_setup(pdev, ide);  This is the setup on RP
> __pci_ide_stream_setup(rp, ide);    This is the setup on device

Nope, the opposite, rp=pcie_find_root_port(pdev) so the first one writes 
to the @pdev's IDE cap and the second one (optionally) writes to the 
@rp's IDE cap.


> unless AMD setup IDE by firmware, and didn't set the PCI_IDE_SETUP_ROOT_PORT flag.

The AMD firmware only programs keys to the rootport and uses the host OS 
for everything else - IDE_KM over DOE to program keys into the device 
and the IDE capability programming on both ends. Thanks,


> 
> Thanks,
> Yilun
> 
>>
>>>
>>> Thanks,
>>> Yilun
>>>
>>>> to dig that but PCI_IDE_SETUP_ROOT_PORT should detect that it is a root
>>>> port. Thanks,
>>>>
>>
>> -- 
>> Alexey
>>

-- 
Alexey


