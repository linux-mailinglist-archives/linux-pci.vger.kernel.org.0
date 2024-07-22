Return-Path: <linux-pci+bounces-10593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77E938D66
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 12:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E10D1C21634
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 10:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C6314B95E;
	Mon, 22 Jul 2024 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2S74D6kx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2223DE;
	Mon, 22 Jul 2024 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643582; cv=fail; b=RR618w+NiDiSLHPROAYZVr9VRFijOl40B2ILgBWvSg8WtKwOuFHI7C8UVNfLDtB7+t68XZ4BHu02zISft0n8t6qJHoQksODKYNNnRWpRum37WrvElSY0vkNLMUysWiP4Vi6AHY/U269UCM3XJkiGFYJzU1P401xLPYTEZ6u5/aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643582; c=relaxed/simple;
	bh=hnYcXklOuZGM+Qe3XmH8lXSWMYlF7tnlR6zNgTNaaH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fnvjqCKPdww9oHozVQ4H3NPN86MTLruISAaoLJbHmOque9MqjJA0fyuoEUtds/YSk+H61pBcBVihTxcfvXAgG1lRpm0NYNygKqbIaeAjynwEn/h3n/r0mxjAFYy9cOhNgVJt5AjVYnIJYurEqcB+WHcQuvuaWWbrjTt9FUo+hS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2S74D6kx; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgV42fZJdYrodKgi9DUFP7ipgQ7Yhz1T7A4QXuQuJRa0hq3u6DeYWwC1Tpnmb0PGE1BRDVEO2yYDkez3W6Up/OySgxC0GXgMnAGA6yniCXIX8XCHX2gl1iaLP7dmvoF+dra/hoYDTMf4GNSZEMgS7JUSdsXOh11fQPSgdnuTmmyd2gV5Vcq0G3keJLou1wzDmLi6j5SFFTbd/C5fCKJvC+xcsdlfSeFH5ZgG1rfNOH/GqlYw426ikuT8CmYr4nS1clbpOOaegt9VeImqTJOPTLq6+AWNj+JzTvmzc+xAYJk1Z21T1nzzrpE2zM5NgC76ufpzp7RqmSVs1uTx85VXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEY/fktG2zU2k5fzQHmOSgvSebazxwVY/j0frRA9MNg=;
 b=X/BXS+YJ+iAHBxsGCUIsAOnCGtbrEYCNU6SZuY4eTcqYO1cgzzfW4OufhYoWggnrYNk1A9+tZQLl8CT/FcMKg3/nxs03tpvoGwT38Ad0slyX2FXs8xIRUOaFKY0+JPpq//sDPEGtXLGl7WrAysioKUvoidXTbbkifYEyx/ePsbOfTkxfyaU2p8XcCiwpBJpYnarp7M/w7wp1CVkMNh0B0xP3TOaBCIg4Hz+6hrjcbiXgUg7BQpoalsb/9tVr1PK0i0EoKm2ZkjUmpL5OvBVLP0zSNXK7xwMX4DoCddUc37iSBV5OnkRXiisuijIB5p2HSeeiHUZa2dppKzX/2kdJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEY/fktG2zU2k5fzQHmOSgvSebazxwVY/j0frRA9MNg=;
 b=2S74D6kxwtPTLoae4um/pQv3ZlLk/9aIiuJVFBF8GGDKtO+v9qhLIWp3b0e5powUPBPSmOOGeZt9H9koKuNTBtg0JVPeWSUGwE2q+PbBJ+pLK8sXgTEDfHad7TaAv9B0AdcRV08k7+o99a6J6mR2KnieHvB01P1z7XLpvRjTEBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 10:19:37 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.7762.032; Mon, 22 Jul 2024
 10:19:36 +0000
Message-ID: <b297cfe0-c54f-4205-b102-ba53ec40344b@amd.com>
Date: Mon, 22 Jul 2024 20:19:23 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Kees Cook <kees@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxarm@huawei.com,
 David Box <david.e.box@intel.com>, "Li, Ming" <ming4.li@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Dhaval Giani <dhaval.giani@amd.com>,
 Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
 Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>,
 Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Jann Horn <jannh@google.com>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de> <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <6695a7b4a1c14_1bc83294c1@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715232149.GY1482543@nvidia.com>
 <6695b29d204e4_8f74d294f8@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715235510.GA1482543@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20240715235510.GA1482543@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0013.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::12) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: c82da6c9-a348-464c-8c73-08dcaa37c98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmVwNHpuaGpzTEFJWVJsYzJPZk5BRlVnU2NkTkh3MkxKZEwvV0xjNmVrcEJO?=
 =?utf-8?B?TGNMQ0dSdWVPT3l1Nk5IQ1VLaElyZlJka3IwaGM4UUNvWlltTTlnMTVDRkg0?=
 =?utf-8?B?b2U2cDJLekhhWDJ1aldVdnlNNkhnNmJ1Snd6Kzl1cTRTNDZmVjFteU1oZDRS?=
 =?utf-8?B?cGQ5KzZjSnNDNWpwaDNaQTNFSzlLamk4cG5MeXNmV0RGaDlvZll6TFVJeHRN?=
 =?utf-8?B?SDNOdWFJWDJjVHRrbE5QdG43U2JsNWM4dzlGTXlYWW85NFhlR1N3TWlUUm5K?=
 =?utf-8?B?NGF4TGJwTFNTcmRXeGNZT0JjNUJBcG9EZFJVM2hZbXZOcUJLL0RKZVNmUldw?=
 =?utf-8?B?VmhLTDZNUTlPeDRoZ2VXcGF1VGlhTHVDdlBtWlBDOWtxeXNRcHhweWRqeW1W?=
 =?utf-8?B?Sy9hM0ZSUUhacUZOOTlCdHhqNjVKcHdIK0tNc3BKVVpBWVU2azFaNzY0Mjgw?=
 =?utf-8?B?VWdiTW9rTWlGRkhTTjdkOWlCenZRQm5GeGR2dk5yQUtlTk9BQllOZ0txWExn?=
 =?utf-8?B?dzcyOGhBNXF0Y3plaTRsb056S3RHOXdOMzFYcGdrckNNN1p2c09oNmFyM2Fa?=
 =?utf-8?B?RzlDUXdrNFp2Qk9SeWVzdk42RjRxb0tKM2FFNzFYby9GK3hCZk95ZjhCY3VP?=
 =?utf-8?B?bFp1QUxraGVwY2t2aDdsM0tuZkFjR1JsSDR4WWdwajA1MG94STlZWFRtYmtq?=
 =?utf-8?B?TGdLemlLeVNsKzIrT2hpalU4SWcrVEFkRDJ3eUV5ZHZsT0lXRVZpU2xiQXRK?=
 =?utf-8?B?WUdjcVlvbFFOdWVvM2pYRnVzcFB2ZitINTF0QW1UTzVGRTBBNnE1LzQ4UEtz?=
 =?utf-8?B?d1FIa2hKUHErUWlzSVYwR0RscWJqTkx5bk4zVEJhK1ZCYmRlNTBwalZLcGdZ?=
 =?utf-8?B?VkRVOVNRalBmN3J5RUtpSVpsR2VpNWpUVnlIcWRQY2trRlRCTXBwU1p3Um1j?=
 =?utf-8?B?eHhKQlhlUkZHU3poWHpSam53eC9FMThwRDlIcVNxSERNS2poanFGanFneUFm?=
 =?utf-8?B?RExwNldBZ0wrek1HODhpOUdMK0JudzljbzAvcGRHWEQ5R2swbTdOOVdBV2NI?=
 =?utf-8?B?TlVMQnZwQXJPeEgvSC9mK1JxZUZNazlpTWJrZnpBNCs3QlZ4UVd1R2VwODB1?=
 =?utf-8?B?L0pncUdRNkJ1UTFkYlpZNXNvM2JpMkdYWTRiOVFzTU0waEluZVI2ZkR5M2dz?=
 =?utf-8?B?aElVNjBTYklWNzFmeVd0dEZQWlo5b0ZVSWoxbVVYV0xDMjBFMWNTWE1HR3FN?=
 =?utf-8?B?VEovWGJycVlpTEIxeFZmSDRyNW13N1R1ajNxY1pDZm8weDI4TFZPTTJQZmo3?=
 =?utf-8?B?cXUrTmRJY0VVMGNQUXhIRWtsY2g5Zmh3NFVmcUdBZ0srMXZGZEJQTVJ5NDFy?=
 =?utf-8?B?VTJCQUpWelEyVXFXcnJvSjdzalIxUzdoblFoS1YrazhGamYxUExMc1VEVzBU?=
 =?utf-8?B?Mk9xR1Q0MzhuU3ZZdXhIcnBoSjlTY0pybjhMS2FsSGhTRmpVZzhiK3A5T2lx?=
 =?utf-8?B?eXZDSXJTVDlxTldmZHN4a3ZPLzZXWENqcWFSejkvREZ3QU5DRUhNWHNwRU5Y?=
 =?utf-8?B?L3k3Z0ZKcTdaSnBkU3NiNGNtYndqNGxhQ1NSZHVzeDBpaU4wSmVDN1RBbXly?=
 =?utf-8?B?K1daRWtrRklzUHV3QUdoMnUyQ3hrYWtDUWUyNXBlN3k2THBNR05nbGR1U2dO?=
 =?utf-8?B?R0RNRkJFWWZIeEpJYkY0U1RETmZkS2hZNFBoVFZudkNueFptUzh4RVBXZXNn?=
 =?utf-8?B?Z0g5RjZ1eStBd21CTyttR2NKc0l4SmFzUEVENFVydnNKQXJWZUtFYmhyZGJL?=
 =?utf-8?B?WkUvcnoyWnJwZXRsQTZZUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkdMNnM3cWhEOGVTcEwrODRaakRUT2Q2SzhvSW1naXdmbzhSeW1rNDFhVGFB?=
 =?utf-8?B?TlhNSVkrcUNTbGM5NHFkbkxsdmNqcGNCVURVTHZsdXZrMEJvbEI2WjFoQ3pO?=
 =?utf-8?B?ci9mU0FsK3RWVFdEZy9zR2kwWmEzOENsUTJFcThuSHB1Qk02MGZhc3owbTBS?=
 =?utf-8?B?VjRKeTJxV3h3aUxwU1NwQWM5Vmo3SG5XWkFsU2N3V0F1dXhteTFFdjlKd250?=
 =?utf-8?B?N1hRZkIyWFF1SWdDQ0hzWlZjeEs3YStScjlKbzRXWGtlekRHWk9YY3E2dFBa?=
 =?utf-8?B?eWI1VWxka05Ka2hBUXhXWWZNQ0JyeXhwNVF4YTRJTVBwUE9YdDhFRGxrL2l2?=
 =?utf-8?B?cndtMEZydk9aK0NXYnpuNE1Wb1ludDg2cldOdk9PRnJldDFEeHFoNnZkdWp4?=
 =?utf-8?B?N3VWZXBXZ2c3end1eUxsbXZiZ0hrZms1WVZOcElHbkxoV0NDdTlNN25Oci9r?=
 =?utf-8?B?dm9TZEQxTnhzN1R6ZW96TXZHZG13Ym1BUksxazZSMjFZK2wyTm9yQjM3YW8w?=
 =?utf-8?B?NXlmU0haK1EyR0tVM2VSTEl1bGlsdE52MmlzRmVHT05GSlhNT1NnSWdOeFlI?=
 =?utf-8?B?YkZ0ZW82N1FSRjBSK0hxYzJvUm9JWnpvVHU5d0V0R3h2dm1HL0U1bjVhNGcw?=
 =?utf-8?B?aHpCbXk0aUtoVFBieXl1V0dSYXliemNWbEFRSmtvaEtMVEs0YlJzSjBucmxK?=
 =?utf-8?B?SlpaU0IyZUx6RDZ3ekRYNzhabEVHTVFubUhaQ2wwelNoZDRFWXhxOVYxVk5K?=
 =?utf-8?B?bG4wK2sxdFlaSU9YZllGUEEwZnQ5U1JPOHNNamJzSHRwMktsNllOZThzRitY?=
 =?utf-8?B?elNpV3ZjU2hWeWJyOWlKQTVuazZzdmVJdjZHbkQyTU1FMlB1L1hRZ3ErZm9B?=
 =?utf-8?B?Z3Q1YUduRmZqeW91WUpLSVpaTWxrbDhySys1d0EyVkF2WkppU2t4MnVaYUY4?=
 =?utf-8?B?bklsTmE0ZVpZRzN3WGV5Y29DWUJtcC9EQ2EwK3ZtSHlNdFN3bFNaRVowNith?=
 =?utf-8?B?R29SUytUcnVHc0czMzB5RGxYcVNSczZGRSszaXhXSlFsYXZqU2FlVjJRTUww?=
 =?utf-8?B?YkYrVTZ1Yzc2LzNvUHB0b2wrNjZvWVV3OVpNU25RdDVvSmUzQ041cnhEdHNr?=
 =?utf-8?B?R0daSUJuWXZ2cGljWVFBY0F3UFdDRmRiNE9EQUJ2NzBON3djdVp6b1g2a01S?=
 =?utf-8?B?R2JNbXdsZ1lobGFCRXd0NjBQK2FsQkU5QTBBakh5NzE1UzJnT3RISmVBazkr?=
 =?utf-8?B?YVFxeTlEekxSL1RESFY0czZWU09OK001NUZ4aGgzN1BoOFJHOXBCbWRLWEN5?=
 =?utf-8?B?SG1XU3ZRTWdjVmNUbXZmaWxzTnB1ejhaTzEyTUY1NCtLNnZUU3hpUDBoUkZT?=
 =?utf-8?B?QWxraFBzY2puVlF2eXVZN1daVzBoYzdjZFB6L3l3Nk9Vb2I0WUx6TVNHRlpn?=
 =?utf-8?B?aTFPZzdrMUVTMzNZbExuQnFWc1JTTUdzbk0wQU5uOG5vWURaTFZiQlVUak54?=
 =?utf-8?B?ZHJaUFEydDJiZDJuYjFzNnRnSWxWcFlOWnp4TkRXdSs3RGhxSWV6T2RwRVhH?=
 =?utf-8?B?M1hSM05USERBYzJNdDJOQWxYcG9GVXRnSjBQZ2VzeU9sK0hzNDFPamZEbmMz?=
 =?utf-8?B?cEVHb0d6bk9ENGd0Q1VjWU9ydklLQ2M3VlIrUVVvWjRRL2xxNGc4MXViNzR0?=
 =?utf-8?B?ZWdTZDZYYzQ2UXYxU2kxeSt5RGFVTUpIc0JIWTNySjdpVWdBaFhIQWFKR3Q3?=
 =?utf-8?B?U1J3VG9JQklnVEIyay9nRm9CWXZEa2J2eFJ2SERTaVBtdy9KZEdqcnFhKytP?=
 =?utf-8?B?R1BsSUdtWGdJc2RRc2NLcGlFWU91MEZ3M3JmL1hyZ29nQlF5bk50RXIrVGhC?=
 =?utf-8?B?ZWwzd0RadHBvQlhhM29GdFBlbjhWSW9xWktSYjgxSDFxMTVCVGVVUzhKOEpC?=
 =?utf-8?B?dnZKMDdib21KSEgxMklVMnJEa1dQU3h2b2pxWjZzWURoejloZ1QrMGk4c1Ry?=
 =?utf-8?B?cG1TbDNZRmFmTW8yQXRjYUtYU2svQmVVclZ5ekxzWnZZWkxEZHUwYkRVWExn?=
 =?utf-8?B?Z2d2bmdvcHJtdVBHNTF6ZEl3OHh0dGlDa3YrVWtoRE1iWXpkY0tBbUZOOXA1?=
 =?utf-8?Q?OeMh0NBMLmZ9xR7SErzrAXxYJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82da6c9-a348-464c-8c73-08dcaa37c98f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 10:19:36.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3S6lxEkTvQbLjTYo4qrZRHmdzA/YG5BrsXn1nWlB554irp/9zZeceIM+0vsqZpFis1sNlirfZGznKQl1j+HVog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176



On 16/7/24 09:55, Jason Gunthorpe wrote:
> On Mon, Jul 15, 2024 at 04:37:01PM -0700, Dan Williams wrote:
>>> So from a Linux VM perspective we have a PCI device with an IOMMU,
>>> except that IOMMU flips into IDENTITY if T=0 is used.
>>>
>>>  From a driver model and DMA API this is totally nutzo :)
>>>
>>> Being able to flip from trusted/untrusted and keep IOMMU/DMA/etc
>>> unaffected requires that the vIOMMU can always walk the same IO page
>>> tables stored in trusted VM memory, regardless if the device sends a
>>> T=0/1 TLP.
>>
>> "Keep IOMMU/DMA/etc unaffected" is the hard part.
> 
> Yes, but that is not just "unaffected" but it is implying that there
> is state in the VM's iommu layer too. If T=0 goes to a different
> translation then the DMA API must change behavior while a driver is
> bound, which is not something we do today.
> 
>> Implementations that want something more complicated than that, like
>> interleave T=0 and T=1 traffic, need to demonstrate how that is possible
>> given the iommufd maintainer declares it, *checks notes*, "totally
>> nutzo".
> 
> Oh we can make the iommufd side work out, it is the VM's kernel that
> is going to be trouble :)
> 
> Even in the simpler case of no-interleave but the same driver will
> start with T=0 and change to T=1 is pretty complex:
> 
>   dma_addr1 = dma_map()   <== Must return a bypass address because T=0
>   goto_t_1()              <== Now dma_addr1 stops being usable
>   dma_addr2 = dma_map()   <== Must return a translated address through the vIOMMU
>   dma_unmap(dma_addr1)    <== Well now you've done it. Your kernel explodes.
> 
> Maybe the "violance" is we have to unbind the PCI driver and rebind it
> to get the goto_t_1() effect..

(uff, quite a thread, I am catching up)

Why flipping?

If there is vIOMMU, then the driver in the VM can decide whether it 
wants private or shared memory for DMA, pass that new flag to dma_map() 
and 1) have DMA memory allocated from the private pool (== no page state 
changes) and 2) have C-bit set in the vIOMMU page table (which is in the 
VM memory).

It is without vIOMMU when flipping is sort of a problem but the driver 
in the VM can decide on type of DMA, talk to the TSM and only then 
enable DMA (==bus master) but by then the things in the HV are settled 
so we are ok.

Talking to the TSM does not really require DMA but even if it did, we 
could enable untrusted DMA, do this attestation step, then disable DMA, 
tell the HV/TSM to switch DMA to secure and enable DMA, all in the 
driver's probe().

> Changing the underlying behavior of the DMA API "in flight" while a
> driver is bound seems really dangerous.

Hard to imagine why would a driver want this :)

> My point is if we start baking in the assumption that drivers can do
> things like the above without addressing how the VIOMMU integration
> works we are going to have a *huge mess* to try and introduce VIOMMU
> down the road.
> 
> I'd be happy if V1 forbade the above entirely.

My V1 says "all IOVA below X are private and above - shared" (which is a 
hw knob in absence of vIOMMU) and I set the X to all '1's just to mark 
it all private.

> 
> Jason

-- 
Alexey


