Return-Path: <linux-pci+bounces-21701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCE6A39816
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 11:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF2C3B806C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEBB23237A;
	Tue, 18 Feb 2025 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fXW8iZBP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E518E743
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872707; cv=fail; b=cZGfjUekaqz9nwSPdn6Up2F/8aWtyRg3yrOgB6cczB1hxtIvQSNTeeBRlV4bYmzpiLzzgzU3fMrIUy6xY6JLVTgrnF8fNQaea32I3QdZF8tyVj7vfYRlut29zjkiK0xNxKR2H1IPimwcvPMj/VuRAmDj70YUnDZ8NbkR24hOwXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872707; c=relaxed/simple;
	bh=8W5OJcWO+Lg4T4iTbdjGULHJue3I9SAL9gcbp0hrIP0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h7IyLbI8K1c0SH6ODPxUy8ljbk1iCtecNgIRUbZhm6pBPdTCfPyKuYC8rkGZ6cFN08iX+oQXzhjdfJuXS3VAE2TjQ8QyxTB0GrTzXnQm/lgPEypIX8+thCsR1wstuZPy1pxvOvx2xWw/ti2BU4wsBKd6FS9VecBD6UpAw5pVt1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fXW8iZBP; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0xIOaLJfERqYThSbn9/stj1SomQzduuLHbRMrL7mnUSkCykcDoKlX3hf+i0mJppDLpA8CJmSlCZHDbdcDGJ2PNtc79N/0Qu/dV87mliV8Y37YeQEyNbtNSdf8uAQJBOhrtzGTYK/2/ezfLKMrOsYsoa2N+4i6tkwi9bNC+OpLq0x0/WysJL8O3t28Dsac32A6GItpnoyTZYK2IQxtqs/1uaDUKIOYO/ZiWegQp6BEJw2Mhak6N/yEbM0/Q9JIZGEGH3Iv2PWiy290eNLaSP+MVQdh6jS4W8IthAKZBQkzgWaAmfjzhlHsmjIIVTzW6zTZnXguvSbzfVKSvS8tXvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLMY3R1ADOjqwQrIZZcdCRxxBxxvk2a7r8XOdQQKOvs=;
 b=ai2RRGJYMYegc3YP+4VM/+diomW3VNd9NQtm+SNBsIOUM0e4aJBZFQmvVvp4Zi4TrR3Rkgl490olqERGT12UbIM9inAZKjMsqD3P2/qWh+nqq/On2m+tYibTcEM0RWp1GhWSZTnQTaOdBzXao1jNgCZjU0BFyffJvWOYprU3Vx6bWVbO4JoH0Ak7krHsbQFKqbd+MOH0Qj4UOo8qER1L8u2C9jgq3n2lwHigCvDFz6s3Xy9PPJak4d3o/u52dgLvJbY5XXil35Zo7g32cZpxaK+btxgFWy78WJLIpx8GdPAF+nPZkQ4JkLwmat8xPmi2HjHY7iN7P4tUChHfBdzehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLMY3R1ADOjqwQrIZZcdCRxxBxxvk2a7r8XOdQQKOvs=;
 b=fXW8iZBPFJ1Osd8wcYJSMI/g6VJwOrDMBJnSbvvTQQDPgGdFEqKlyoDDow9zmcEghXbhlnYUvRSpFQYUpOgkPLGbf9dmF3NrYR0y4DZLQw1p/2TzO0kOj88ZMi3d/ocs9POnUlN7AeuwePOxe5PhoHcFoTqx9ufzqXgdoVDCWuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Tue, 18 Feb 2025 09:58:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 09:58:23 +0000
Message-ID: <e098c309-e89b-4135-b5f1-dc8629445bc7@amd.com>
Date: Tue, 18 Feb 2025 15:28:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
References: <20250217151053.420882-1-alexander.deucher@amd.com>
 <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com>
 <CADnq5_NUEuMFsd__w1eGBWALxcQwtX7sa2Sn53vDjaxrqNuhPQ@mail.gmail.com>
 <CADnq5_NEhv-E9ZxHvxhBtFb_cBkPqMfu-nsQfEknO30tNBjA2Q@mail.gmail.com>
 <a2645312-0903-4fa9-9735-7f2a77986cb8@amd.com>
 <97e803f4-f00e-4fb0-8ed8-714ea9960e5a@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <97e803f4-f00e-4fb0-8ed8-714ea9960e5a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f8a40b-cb59-4cb6-962f-08dd5002c7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUgweStZNjhqT0k0dHhiZkVHQisrNUhPNHFsSEFXNnpEaWJXR3RCNkhkUlY2?=
 =?utf-8?B?OC93MklZcVZ3SW9iNlpZZ1BVQ0Yxd3lORE1Hbm10Q1d6dFNGU1hXZ0RhZ3l2?=
 =?utf-8?B?bTVyZEx4L1FSNzd5T3A4TUs2MXhFZWdaMUJ1K05iQWloQWZUZGJiMzkvNnd5?=
 =?utf-8?B?S1F5MzYzUjRUMTI1RGRic3NCeFdKSGUvV0VGcTJkM1lMM1oxUnkrYk9vTi9H?=
 =?utf-8?B?djRIbnFMbTdNV0k2ZlNWMFVhaVFVQjg0UE9vTk14VndMTGgzYjhnN2IwL2Vl?=
 =?utf-8?B?dkxZS0o4WUl6RXhHRWpmOUNGTjhOZU1RU3JsdTVDN1pvTDRIZ1hmVW1TQjNO?=
 =?utf-8?B?NzJZS2Jjbk56V0V4eEorTlNweWJyWG0xQldCQ0tPTGJFQVFtMVl2UGJMT3hY?=
 =?utf-8?B?bFdnTzkvNHhCeE1xV2IyaWxCaGd4M1lhb0pHRlNmV2d1MG11M1Z2VEsrc2tZ?=
 =?utf-8?B?c1k2WUVaODJQdFhDMjBFQlBPZHk5WERNZCt1RWJjMEVVUXJvQVNDOTZlT3pa?=
 =?utf-8?B?MmVMUk8vSWVURUZqcWx1ODVMcGF2S2pjZ1ExeWtsaHZVMFBvaHVzMDNFVys2?=
 =?utf-8?B?ZnhOcEpxeTJFRlpEZmV5cUFJMXlET0gzNzBpNE9DMVdHNnZnUUxYWjhqV2NL?=
 =?utf-8?B?SkF0UHkxTkp6Ym9ONUFwOTFwTFF5WHhSZmlLSDdUYVhmS25WR2N4VW45WXlZ?=
 =?utf-8?B?STB4YlBCbEhXWFJxcnVGdy85TG1KUXc0bU1PbGMvZ0JYV2htYnQyd1pjZ1kz?=
 =?utf-8?B?NkdXY29EV2hMQnd4NWtiZUpibGxmcEd3c2hjTFl4elhOc3NiUmN0blFQOUNP?=
 =?utf-8?B?N1Y3TFR4YllZY2NwZmRWem42T296QXdzVitlSVozbWY5RHJXMEFDVVo1MEtq?=
 =?utf-8?B?QnovZ3pudGlCc0VMNFZOM2V5N0lqbW94U25lbk9FS0NraVJuV01sczhseVVQ?=
 =?utf-8?B?SHZoS3ZSbVNCTVI1dGcyMFRHUnBLZlNZd2RjSGpJV2ZZQUU3dEk4YmgzVW9U?=
 =?utf-8?B?UFJWVDhueklLRWFQM2ovZnpuaHR1SDJHak5yelI5dGsrSE81ekxZY0RtY2Vx?=
 =?utf-8?B?VTRZNzhNVmxNampsU2FyeEx2VlFtdS9JSGU3NHlwZUI0emdiS2JJV2NKazFa?=
 =?utf-8?B?dSsrZ2xMcnNJOGR2RFJKSERIUUNPSGZndVlwMnp6SXlKVGJKVFFZOStpMXE2?=
 =?utf-8?B?eStGWDFsRi84MTZ6K0xmR0Y3NkpLVWtNR2pEa1lweDRZVnExYlU0M3NZd2hG?=
 =?utf-8?B?UVl6NzdZN3FWQUYzMk9vU0hmL09VcWZBMkhoWmZ5SjRLM3JoVTVjMU1vdnBF?=
 =?utf-8?B?OWFsbFA1SnJiQWloUmhSK1N2dTRqd0o5ZXdpL0VkZGpNRVU4eVYyNmNoSFVE?=
 =?utf-8?B?VzE5VmZLdCtqdzNpejExeHpyODl2amlOMjdVRWlyTGdRS1lzak5hOXBIeG5r?=
 =?utf-8?B?NnQ0TENyTUJCYjExZS80T2R6VzZ5cUVxZlVROVpNd05sUFRGTVJlSmtabE1t?=
 =?utf-8?B?T0g1a1I2blR2am5URk9xSjRKZ2ZKNSswUkhtRStneFc0Q2lzR01XWm1BMTl5?=
 =?utf-8?B?MjJHWlBMcUg2SmpKMEQxcEdiRFBZbW9yd3FZcHN0c0RDdlg0RDNLTWVsN0d3?=
 =?utf-8?B?UE9IQlFrUHhUTzFwcGFvQW9lM2FWQVE5OUt3Z2NKazBZbjhOTGZhREJNTGsw?=
 =?utf-8?B?ajFPZzJnOVE0WHNONTVuL3hRUUtMai9qZlJZNWtScld5djlqTnFZTko4K0pN?=
 =?utf-8?B?MzQyZjhJb21HOUgvMXR0VzJDbE8vTzVETk1mckRvcmJKTmJQM0hKUVFFL0ly?=
 =?utf-8?B?d0VGVml5TEVTVkJPNks3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7804.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHFQd2tTZnVNaEJLQml0LzRNK3lGd0dEQm1kS0wxbkd1UGt5ODZhNmRSSkYz?=
 =?utf-8?B?VExsTWg2MHRJckVKTmk4b1FiSkdiZkVTSkNGdFZRTTNEVWVzU2tBajdtbUpy?=
 =?utf-8?B?bFVwYjBLYm1CUTl1djAwR3htUWR2Y0kvSTJQQ1VvYnZVY1NIMXI1a0VNZHRO?=
 =?utf-8?B?ZnppVkI5cWozLzBWSlJuNis3aThmNHJWbnluWU1LcXplQ2xjcFpTUnU1MThk?=
 =?utf-8?B?NTQya3RTK2Z6TlNMMjJPV3NhS3ZuN3NKOGVEdHZBTk5VM01RWks2T0dnZjRE?=
 =?utf-8?B?dmxHY3p0eDk1ZDlxWlM5Y2twOGE3bkdhV1VOaW9ld1BDMWE1R0ZXTjIwLzhw?=
 =?utf-8?B?NmlrSm45N1FDN093b2c4a3BJRHN1VkhzeG5YTWdwSTlVSmxxMjMrend4Mkt5?=
 =?utf-8?B?Z29CZjdEWmNHN2xCRnZKNDV2bGdtb2FmNW05OVZ1Ny94RnVTd2k1aUVPQmRP?=
 =?utf-8?B?aTRIaUQ0SEtFVVZoS3RmUTBNSzlpak4vTEtFUTREN24xZGRTWlhnRWlUVlZl?=
 =?utf-8?B?eXNSdnA2aHBTODBnQkJqb0Eyd2hOZGd0ZjR1YnMvOC9jRHhpM1o4aWo5Z2V0?=
 =?utf-8?B?OHllTjY0eXZNSWNNN2lhMkg2NEhFK1dKcjJQNmtzZzRNWUdVcENocDJrZUdn?=
 =?utf-8?B?ejNkdHZlMHFpMFZLUHlQY3Z1WmhmVXkrbUZ6eCtpN0s0cUZHNDV1Y21wMExm?=
 =?utf-8?B?Z1hOQjdkQkVvNVhJRldYczNRT0lwYzREVmR5WWxSeGN3QVpkZS9jSUllVVIy?=
 =?utf-8?B?Zjdab0Yyb2tNZGhZdEdCSnpjL3NFY2RwZ0kwMzdJM1MrN0E4QUNvVG8vWXVw?=
 =?utf-8?B?aGUvZVNuQ3g2cSttNm4rQ0IyNlBoblEzc29tR01XRCtNQ3I5bUtXOUNaYnJZ?=
 =?utf-8?B?aC9nVDFVNmRDdkR2ekdERFFmM3F3RTBTU25SWjI3TTROdlR4TXg0MXlRNlV0?=
 =?utf-8?B?WjhYNEdUZXE1L05EdXVtdlR3ODlBQ0JGNXg3UWZ2TFFaQ1ZVUE1yYzI5ZUNH?=
 =?utf-8?B?ZDhyS2V3ckd3SDROdEJjZkVmd29SazY5ei9XWERzSUY2UjczVU5waXluQ3hs?=
 =?utf-8?B?dTFJUnkrRFFyV3dTTVlJVmFDMEExR25FVmFnSUNGeEtBWkFFdHdUTHg0dmNS?=
 =?utf-8?B?YitLNWZyYXlnazhZUU1wdlJ2bUN0NVpmVUZkc0NBT1FQWjc1NzNXWGV5M2RW?=
 =?utf-8?B?UElPS2ZLTG9UMW1YZFdUVHMvWVduREphNFk0clRhTGREYzl0VDFsdGpmMEpR?=
 =?utf-8?B?SWh1L2thdkprTlovZEszZE5paXRiN0ZUQTlpTk1kYzZ4bTNQK1ZIMFFsK01v?=
 =?utf-8?B?QVhTQk8yQ1JaV0p1UDhYZnFyQURDY25xTXBtVkNIdXRsUlFNNzFjTXdsM25F?=
 =?utf-8?B?Q1AyTHl4WmRMS1RCNVY4c2h3M2diMkdzalRpbGE5NnB0cWF1TmdOUkpRR0Fl?=
 =?utf-8?B?NVhOSEVTUXNqWTBaa0I5eE5Ec01UbnNId2t6QXZpNW5vTzFtZHY2R3FmNmta?=
 =?utf-8?B?MUM1ejNzYnEweVhvenArZFhDUjc3VnZBL3VpUWg2UEwySXpBWmlmclhHQjhF?=
 =?utf-8?B?b1ZKU0o0SUNlVGJRNlBYZGt4aFRKYXc4dWEyeEhCTGdSSWpKY0hmdkhwbjI5?=
 =?utf-8?B?NXlzWjlnbWRPYTRxcTNZWkNFeStRTzYwNEdmT1U3UE5iQjlPNzlrd01GMzhl?=
 =?utf-8?B?QXRhbW1iS1dzTC9QcUx3U0o2OFJyaHZWc1VIbGhoWmZMOXc3dkRabjhJQlZB?=
 =?utf-8?B?OHM0Ly9kZklWNkdJaklPUTRnMnFWYnEwalhRUUJqQkcrOUR0VkFCU09ScHRz?=
 =?utf-8?B?VW05bkhteVhpTHBTUWlCNDZjVXpRSVczcDlmcnQrS3ZMWTVmQk1kODJiM0xu?=
 =?utf-8?B?OFlnWDRCVlRXR3YrclA5WXBpMnJPelRhMlprL1E4VEhyUE8xWG94UjZaZEsy?=
 =?utf-8?B?aEs0aUJtNW5kK1JjZmY0NE5UbGlINVl3NE05azQzOS9GZ1B0UUw1NDZuWGx6?=
 =?utf-8?B?aG5sbGE2ZmpVelZsY1pQV1J6T3ptY0tyajllSHJvNVZteDhWMXNWT2tCRlFG?=
 =?utf-8?B?V0tpRWtLRDR2cWltc0R1NnZoTGpSOHdoOXJBV3FrMk80SFBKUDdtR0d2Um41?=
 =?utf-8?Q?wCALzIRirU2NNpbmNY8MFImBs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f8a40b-cb59-4cb6-962f-08dd5002c7da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 09:58:23.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LskDqxnfLWpkB8sMMFXnMr90PgQTyV0X5YZ2Q1pJXw6z+YE50jwFBaAQ5pWk3wSg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208



On 2/18/2025 1:33 PM, Christian König wrote:
> Am 17.02.25 um 17:04 schrieb Mario Limonciello:
>> On 2/17/2025 10:00, Alex Deucher wrote:
>>> On Mon, Feb 17, 2025 at 10:45 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>
>>>> On Mon, Feb 17, 2025 at 10:38 AM Christian König
>>>> <christian.koenig@amd.com> wrote:
>>>>>
>>>>> Am 17.02.25 um 16:10 schrieb Alex Deucher:
>>>>>> There was a quirk added to add a workaround for a Sapphire
>>>>>> RX 5600 XT Pulse.  However, the quirk only checks the vendor
>>>>>> ids and not the subsystem ids.  The quirk really should
>>>>>> have checked the subsystem vendor and device ids as now
>>>>>> this quirk gets applied to all RX 5600 and it seems to
>>>>>> cause problems on some Dell laptops.  Add a subsystem vendor
>>>>>> id check to limit the quirk to Sapphire boards.
>>>>>
>>>>> That's not correct. The issue is present on all RX 5600 boards, not just the Sapphire ones.
>>>>
>>>> I suppose the alternative would be to disable resizing on the
>>>> problematic DELL systems only.
>>>
>>> How about this attached patch instead?
>>
>> JFYI Typo in the commit message:
>>
>> s,casused,caused,
> 
> With that fixed feel free to add my rb. It's just that the Dell systems are unstable even without the resizing.
> 
> The resizing just makes it more likely to hit the issue because ti massively improves performance on the RX 5600 boards.
> 

As a workaround, from the thread, the most reliable one seems to be to
disable runpm on the device.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>>>
>>> Alex
>>>
>>>>
>>>>>
>>>>> The problems with the Dell laptops are most likely the general instability of the RX 5600 again which this quirk just make more obvious because of the performance improvement.
>>>>>
>>>>> Do you have a specific bug report for the Dell laptops?
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
>>>>
>>>> ^^^ this bug report
>>>>
>>>> Alex
>>>>
>>>>
>>>>>> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>>>> Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
>>>>>> ---
>>>>>>   drivers/pci/pci.c | 1 +
>>>>>>   1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>> index 225a6cd2e9ca3..dec917636974e 100644
>>>>>> --- a/drivers/pci/pci.c
>>>>>> +++ b/drivers/pci/pci.c
>>>>>> @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>>>>>>
>>>>>>        /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>>>>>>        if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
>>>>>> +         pdev->subsystem_vendor == 0x1da2 &&
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>            bar == 0 && cap == 0x700)
>>>>>>                return 0x3f00;
>>>>>>
>>>>>
>>
> 


