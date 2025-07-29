Return-Path: <linux-pci+bounces-33128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA3B150FB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 18:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD983A4DF6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90565270EA3;
	Tue, 29 Jul 2025 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lkLDjC2f"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF820ED;
	Tue, 29 Jul 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805508; cv=fail; b=GqgLoSIM68EIHjeCe5hYvXGg1uiiK6/KXyzVqK2GV+6NQzYcV+/2XidyGFcC3ANpmCk2W7oZ4HfMF1qP7fHyy4ousmyolDr7gMzQZQhQZvVzxOURAGhYcTTneCB6xBUQDTlNfsVb5xXjeN0tWnOxGk9cukD4wt5JxcUsueFYzzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805508; c=relaxed/simple;
	bh=eJBoNHhKU3JnSy03eL6p1U9eDOopwg1RZ+bizBUIUCU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GABpTvhIJ0BiSzh4nr4jY58qSJlqObOS7wVFMv772PcNvfbdFJHS/Pmub4pzaNOYqnlOemsL0QgzdliDSHYq2zjARGbkJ9agCk3dlJRBevVOmc9YutZCMqDlpZFyiQLIYdHX6PwkMcb8Jbiiv4Yiv0jFBIG9cfupjGaxs/1bfho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lkLDjC2f; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuQJH4rOjThM3eIrk775rODmQKOtTQ+Gz/HOpb91ccVloboOlaXIv8PrdGhls2JXlEeY1QNGTp8SZMFmuoERaJVXcUzxIVSMt2LJHhlkAyAsJlGECrh0gW/4ZO3y7IIK1/gFAWJdBas6Ad2+q48E1Jv89EKHnXJ8gRt/0Y0kP62kvr5pP7yO4lVdh0apFU0OIOn6GGSJML5Vek2HS1GzXlNt591hPNry6wEcaXZdvKk+9DhG7710220N939bsL0FVMGmjAOWKumXK1TcjtpGBRtLEGusirvPqduK1M0ha0GZtJwpFnBO55E9WY79lKPAnM62pLV0l3xD4hZb2G29GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTF9+2swEYe5K4PoavE2hSVFrXosFuh9blcbwHJ6fTY=;
 b=Qb1vxvuP7XfqcHmFw26vqwSe7oIZl5JrMhLNILSIJIiA4LZxZXY3hcGbPyMfivy2HJp7ey75pca5QVgDnDjFdPiqI3IdnNuHhJEpcJuMDhXGRBGxLeI17G/4TNvZtdqDX9uettiqAC6JL7lyLeeyDQJX8u4J+uqiytBSKZZd59TQVZywL2drS5Mfsz3StydXGgbrM0Z7HTkvWEzBaubq63+SacyS1GOMhwrLmic1k02FLwkPrjsVwh5e8a+noKNZisCWk603pKwj3QrxDxyRlYaJTyOV4rnVYX584uVGplYFgsmjB98IJRgbWLZtjasy91d6ObE1RN1bF3nN6WwZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTF9+2swEYe5K4PoavE2hSVFrXosFuh9blcbwHJ6fTY=;
 b=lkLDjC2fptXnufOS1OblfpmEYkN8XwCZxjNJVl4ynJtE8HY5UwvG3MxUogdcUhheOI0c8Xxx7u+tpVqlgs/aGzxRrW3QOw5S3tjlxgT4/NvGqnoWDNbP+Z3ZyR5813c6bNcByLYuCQrcNcRXcmjrX1ZVFbROCml6T9fH0bM7gCw0tStZgYRAeX7koCgdPLCJN9ZQrKYPf93GCK5lv8qlweiCjpYJH/nSTlHob7a4r5IuFgiSdo65xut4vFQuzsHPDcx+f8rrAxsXz5aVH17NqhamkkHfl+1MN9E2tJiZ3DZQTA0zExbgoRtRZZJY8sncSFIX0PuJofqZSoLVvMMaFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7371.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:605::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 16:11:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 16:11:43 +0000
Message-ID: <bdb5a5e2-3a7e-4050-bf25-c95dfa05138a@siemens.com>
Date: Tue, 29 Jul 2025 18:11:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/7] soc: ti: Add IOMMU-like PVU driver
To: Nishanth Menon <nm@ti.com>, huaqian.li@siemens.com
Cc: lkp@intel.com, baocheng.su@siemens.com, bhelgaas@google.com,
 christophe.jaillet@wanadoo.fr, conor+dt@kernel.org,
 devicetree@vger.kernel.org, diogo.ivo@siemens.com, helgaas@kernel.org,
 kristo@kernel.org, krzk+dt@kernel.org, kw@linux.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lpieralisi@kernel.org,
 oe-kbuild-all@lists.linux.dev, robh@kernel.org, s-vadapalli@ti.com,
 ssantosh@kernel.org, vigneshr@ti.com
References: <20250728023701.116963-1-huaqian.li@siemens.com>
 <20250728023701.116963-4-huaqian.li@siemens.com>
 <20250729122246.o7upnxvqnp7nltdo@harmonize>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250729122246.o7upnxvqnp7nltdo@harmonize>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cf9c2a-1efe-42cb-5715-08ddceba9bd0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHlzVW1WYVo5TktiYkFlaU9Yb1NlSnNrOGpHOFU2eEM3ZzV6Z1pYWXVld3hF?=
 =?utf-8?B?Nit3V3VuaGJiWkIxSlJZQnVKa2J1eWFmRE82MmhIdDJlNlk0LzB4aUZSck9J?=
 =?utf-8?B?MkdYbGg3VWhxaGE1aXlkQXRjeGQrOVJUc0o1OEZWYnc0U3lhZnE5a0IwOE1p?=
 =?utf-8?B?aWFLWkd5RHMwM21DVVpQRWcvaFlYN3puTUh5UDg4S25SdW40VS94bVU3REx5?=
 =?utf-8?B?bE9pY01qTldrMlNVU3plN2RGcG4wZmw1YVNrVU50RWxaRVVGaWR1WThZaERL?=
 =?utf-8?B?anVKSThxSktkN0k4Z3g4dlZHVU40c2lnT21DVVlBWU5RTUV5Q1hLSHVOdjNr?=
 =?utf-8?B?Wld5UnYrOENpTUNib1BoVm0rUEdzaWloUGlDdHhVMzR0cDNtT0lJYmMyTjRW?=
 =?utf-8?B?THYzTUpNcmhFVVBVQWtrVVVuZFRvdytOMmtUNkd6aktIMHcyZnBRZTFzeWpt?=
 =?utf-8?B?UTBBb1M5NHd2bVFTcjc1WSt6QTFQSDJoZnlwYzkrYkdnTGJGVjVoYUV6N1h2?=
 =?utf-8?B?T21IWVJzN0RZT2I4ejFQM1czaElrbWdSK0pyc0c4TWVBOFdSdUlCcWNUSW9N?=
 =?utf-8?B?SEJMMzZVZjNpM0FRbGhBY1hFakd5UlYwOEU1Q2t5cFQwM0JvQllId2VYTHlD?=
 =?utf-8?B?N1hPNDlEb25xbU53S0w1cERSQmZLN0ZhQmtwOVJuOTMxbVE2WXNHRlVWMGtJ?=
 =?utf-8?B?a0JQRUppZEhrT0ZUMmE4UmMyYldSaEVMVStHR3ZuZUJJUkYyREJaMHdKWGd4?=
 =?utf-8?B?SU1rQXdVTUxDZ2U2UWNsdW9PN2UvU0lYUTBpQjdNYzRRcU4wZHVsR3NjQm0x?=
 =?utf-8?B?bjR1ckYySHhIbW56TFBaTkt3TnFqTmQxYkNFVmVOZEg1WjZNZ3VrdDJaNFM1?=
 =?utf-8?B?clhjdTV1bzVYNFIzb2ZPWEVrNzhFd1FEc0tKeEFyYmh5MFNmZ29CcEUvSWsr?=
 =?utf-8?B?VHZtdFQrUG9aKzRRSEF2VDNpQTB5UnNmMkZWcWdkQmhZRVdxNmZNTUphOXNS?=
 =?utf-8?B?UlU5UmxvclNtODZ3WC9EaHpKVGRkcmxsbU9jcjdJSi8rVC9VUFJBZlJqYVJC?=
 =?utf-8?B?R2t3SEx0aDJOUWdlVUUvbjZNeGRDM2l3WEg0ZzdLNW1QLzlTaFB3S1VPV2Zs?=
 =?utf-8?B?N3hhamx6d2xkRTBOT0ZLRG5maXJFZkxRZTNLbCtqVE5YaVlZNVFJdVlZTWtM?=
 =?utf-8?B?VW90bVFZSnA2dHJmUDgrbXowRGlWMW1Wc2tkS1QvdXBEaTA3SFB4UGdrR3li?=
 =?utf-8?B?SVFmUmduREFjNnRINnRTa0lWTFo3UnhiTHRoaVIwZWlWOVVXajlTOHV1bC9i?=
 =?utf-8?B?eC95M29GMTJvSmE2cHhxYzB6Mnk5aHM5aDJXWGtnZWk3U09DYTlLTmt2MktL?=
 =?utf-8?B?TmY1MW11UkUrNytGcGRvYjFkOUVOY2xVbXZUd0lpY0lzdzd4NjNJS3BMWkNX?=
 =?utf-8?B?YXhidmVTN0FBYWZBNyt0SW9EWUw5R3hyTGFzbmlCQTlZSGxrbnEzOXR0d0p2?=
 =?utf-8?B?aGJRV2JWc1hwaEtqdGw4bk43WFZKLzZiM1I1c3VweTR1TU1kN293bmJCYlJN?=
 =?utf-8?B?Sm5EMTZCb2Z4bXJvNFE3ak9nWTF6aWdpMkFQRHF0NVVLR0lSVjdlaGtVbjM0?=
 =?utf-8?B?SDd3eHlGUU8xb05wLytiUG03RFo0a1gwUG90RXhiQkN5R2VKU3l5dzVvMUVw?=
 =?utf-8?B?QTMydktXb3RzTXpBbnhmcVJtdHFVckxWMWFmWTNiY0dzYzM1U1NxY0djNVJB?=
 =?utf-8?B?MCtNM3NYcGp0MnBleXBkLzY2RjJCakh3OWFsSGgybG5sMExhMkdaYzc4aXc3?=
 =?utf-8?B?QjNXK0gzdUtTbUFOMnlWaVB5MElveWMyMnNQc05uOVduSkp4cjBWcWxQblcv?=
 =?utf-8?B?WUtZYmZzSHZJUThhRE8zUnFJU2NBdkI3VmhMcG5TQXNFMEp6SjR4SVV0ODBR?=
 =?utf-8?Q?BJB6L2oVYqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2VtdERyUm43NGdGK2Z5NWlBeUZCSGc5SFlYaVUzVnBQdjhRZmMvWnBZUk9P?=
 =?utf-8?B?VnhrTlNGWmd5Z0hHdEtsRkdiODR4ZFlsSVU3dFBlZnU5aDQxWklPKzRTNjNw?=
 =?utf-8?B?eWhKR2JwWE43TWN6akpqZTdGajA1eTdUVWxpOG90OE53d1Zld29aUnNJNzUr?=
 =?utf-8?B?cTNQWmZ6RjZQV1BtUE9ZSEdadnZGQmFpTUpJaW14YW5zeURzRmZPOXAvaGJs?=
 =?utf-8?B?M3hjZjhZR2NCdFhlN3pXTEdVR1AzWE5BR3htQlN1RHF2ekdvWmRPUkJiQ0Nl?=
 =?utf-8?B?QUJRWWVSMmpTWG4vcmJPWHkxQ3NBQ2swWGVJMkE2R0kxN1hnUmQ5OVljejdY?=
 =?utf-8?B?M09LS29VaTNyRWlxOUNnOVJHQVFRRGhma1graU0wMWVoSzRPSVk4OHF4T1kx?=
 =?utf-8?B?M3ZwR3I5QmxEdGo3UFYzaHJJc3Q3VkFnbEllOWdqWjV6QmxvY1RGZ3hpamNu?=
 =?utf-8?B?RitUUThrTmNHZ1ZRVXVzQlhBRFFENG5XMkJEaC8wVUhJMzlHVzExTS9LcVRz?=
 =?utf-8?B?TldKSWtyRWxtcHpaT3ZGaFVLTVpIQnJUSlFnR0NZSlI0Nm50L0ZpS0ptckND?=
 =?utf-8?B?R3JDT3I4TWxoT0JEbGhWbVVrQXFxYWpkempuSVJHamU2aTc4aURZS1FCNWIv?=
 =?utf-8?B?dUprbVZGbFdYcE9Hc1hJV0xHa1h0T0lqWWNiYnQxNWZQdmVGMWNMd3g5R3Zr?=
 =?utf-8?B?TXhRMHUyQmsvZUR2SVIxVFJkYUlnbXhYbS9TUmF1dVNVZEZ5dGR6M2xmdGxH?=
 =?utf-8?B?VDM5R2hpZE40UCs3SnQ5VnN0dTlZaWtTYm5xNWV1cm5UQlRIQXJoV1Q0U2V1?=
 =?utf-8?B?ZGFEaVp6S2VCdlBTVXhrdmNNTjhsMWgzb2FsdjFvaDc5S1JlSW02ZHpGTVk5?=
 =?utf-8?B?K1E1UVBSeUtNMHY2N0h1UzArTi9HQkFGZklyYmRnZ3NRNmlDdVpPUGVkQ2l6?=
 =?utf-8?B?OFI1QkVlbEVvNS9jcThubmh4VnAxMWdMTUU0TzQrOFRxVjdZRXZjeDZrcm5p?=
 =?utf-8?B?ZmNabVNnNjBxSDJPcE1HaGxwZnF4b2xpdTlvZnAvMzJQOGZ0RHlvUkdUZFQv?=
 =?utf-8?B?K25ieWp5MCsxQzB3ZVFvcDFnSW0ybE1tUVpqM1BsYnJVUjU1Wlk2a01qc0Nl?=
 =?utf-8?B?ZE52dTlPY0piaTBVVm93eXM1M01ENzlHTlYzK0ltdUJCb1VRd1ZkK2t0SkxK?=
 =?utf-8?B?Z2k2WWZudllwSmZUOHBoWldpcUJ2azFqYkpUOHVBdmJIRHo3cFBtNWRmZFhX?=
 =?utf-8?B?THg4UHpDM1hpa0tVU2JWOTN1NDhOTFpJMnoyYTF3OWlIUWM5ZWV4RmlaM3Ir?=
 =?utf-8?B?SzBnUEF3N0hjTnQ1SHQrdVhqMjBXdFVmLytrUXpnamUweU15Y1VxQjR3RDgx?=
 =?utf-8?B?T3NjelRSNnVUY3FIK3YreFVvNmpscmZ6VWtISURzSEhmTkhoVlV2Y0VPZlJX?=
 =?utf-8?B?V2p1ZXRJSDBLdGNwcTFuY3kycTZ1bmtHcGV0Mno1bUNzT2lKSUF4UytGM0lY?=
 =?utf-8?B?NDBNUEpOMUQrNGlmWG5vT0NIV2twQUQ3elpoV3JIYzR1MGVVb0sxNGhpSGRP?=
 =?utf-8?B?OTZkR1Z2ZVJMbXJZQVNtdFBrZktvb2F5ZHFHcERrQjRqc1U5bEYxRFZ4M2o1?=
 =?utf-8?B?VmUxeEhCRWJOSDIyRlJUejlYZEtNSmV5VzU2dExYL1NiaGR5Q0lQWkxEWUU4?=
 =?utf-8?B?bWFWOElKMHBNZmJwdFJXdmJ6Q1lpY2tpeG5KRWduUnpWaDdLU0tJOE9rTEpV?=
 =?utf-8?B?S3dKQjVNMVl6THE3SG53S2JtR1NmTTRQNGFmbS9uNjZ3a3BKRmxZNXFOWjVu?=
 =?utf-8?B?NG4rTjBEQmV1MkkxQjJpU055RFB3YURMTGZXL3BOdjV0Q0JwZnJsakkvVklS?=
 =?utf-8?B?UmpFS1BZbnVpS25UcjZnUW5ERXcxSTZNdkpJdDZWbnpSbkl3SXlURFFuYXI1?=
 =?utf-8?B?eFo3d2Uyb25PUkpMb2wxQk9sUFVOYWEvdm1kVmtZU0ZhM3BxeTVLZERZME1j?=
 =?utf-8?B?eVVydHAvWkpwZjVtSndmcUtuN1pBR1dNQWhwekZFZEYrcWdWSk1QL3NvaGJE?=
 =?utf-8?B?b3hxRE84alljcytQd2NHK1VVNVJZZjI1NmF6RkV3NG8yYnMvSHZWbkhvYmZ1?=
 =?utf-8?Q?mO4xB6dN0TLN/klhKeKUYJwiU?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cf9c2a-1efe-42cb-5715-08ddceba9bd0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 16:11:43.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlZ5X+7PvAOW1fKGakhR6BS9hAwDpUJ1g8bmrefv0jK4J+ESPaBnHsyCjyILPB9+1UoFka9yl8Wf4rhGYTV0NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7371

On 29.07.25 14:22, Nishanth Menon wrote:
> On 10:36-20250728, huaqian.li@siemens.com wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The TI Peripheral Virtualization Unit (PVU) permits to define a limited
>> set of mappings for DMA requests on the system memory. Unlike with an
>> IOMMU, there is no fallback to a memory-backed page table, only a fixed
>> set of register-backed TLBs. Emulating an IOMMU behavior appears to be
>> the more fragile the more fragmentation of pending requests occur.
>>
>> Therefore, this driver does not expose the PVU as an IOMMU. It rather
>> introduces a simple, static interface to devices that are under
>> restricted-dma-pool constraints. They can register their pools with the
>> PVUs, enabling only those pools to work for DMA. As also MSI is issued
>> as DMA, the PVU already register the related translator region of the
>> AM654 as valid DMA target.
>>
>> This driver is the essential building block for limiting DMA from
>> untrusted devices to clearly defined memory regions in the absence of a
>> real IOMMU (SMMU).
>>
>> Co-developed-by: Diogo Ivo <diogo.ivo@siemens.com>
>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
>> ---
>>  drivers/soc/ti/Kconfig  |   4 +
>>  drivers/soc/ti/Makefile |   1 +
>>  drivers/soc/ti/ti-pvu.c | 500 ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/ti-pvu.h  |  32 +++
>>  4 files changed, 537 insertions(+)
>>  create mode 100644 drivers/soc/ti/ti-pvu.c
>>  create mode 100644 include/linux/ti-pvu.h
>>
>> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
>> index 1a93001c9e36..af7173ad84de 100644
>> --- a/drivers/soc/ti/Kconfig
>> +++ b/drivers/soc/ti/Kconfig
>> @@ -82,6 +82,10 @@ config TI_PRUSS
>>  	  processors on various TI SoCs. It's safe to say N here if you're
>>  	  not interested in the PRU or if you are unsure.
>>  
>> +config TI_PVU
>> +	bool "TI Peripheral Virtualization Unit driver"
> 
> tristate please? Prefer to make this as a module.
> 
> 

PCI_KEYSTONE is bool and needs this (if enabled). So this won't be a
module in practice.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

