Return-Path: <linux-pci+bounces-33621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CAB1E666
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 12:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4757A8A62
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FAC2737E4;
	Fri,  8 Aug 2025 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fnn2WHLr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC020E6F3;
	Fri,  8 Aug 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648474; cv=fail; b=jWxa3R62EgNWpfUP9AA0XeHG51JjdHtLNAPtK1sYF4iv7DRBKrnPyFDcIKp3izJbhOi88XW8HXSqkRJEta6UGMvq7g1Qo+WtWh1JHYzz1lDpGGeB5mru2BLctuTgHmwqhSrsoZQ/HXX43Z0jkVYClLD1Be7YqSKIQvs34rQmVK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648474; c=relaxed/simple;
	bh=Zd6rQ85pghtvRnnKnbw05eNPPOe/CfBqsCEMXLZIxrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uA4lAjoiDDJmv473F7kk9ocGEgbrP2wY/inJgAjz/gCcf3zIPo+D/39/55E92cQ/gscOM9F7KwfAjEOp/+GXB5TO6B/T66X8mcFEpyO40Vxn+urMWWkYrYbVbxaxDPUzQ3Ohv13S8lIDPfGAPiUlOkyWzBjcCG8J3m8dUIT7yWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fnn2WHLr; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dh2TLdTaIs3t/DaitsA1xuHeN1iwO6/Hc86ipFP3wZegmQ4rlBtWjIpyS5kC9lMX/ynccv9meU6+Rin9kpaq0JArFTS/rk4FBu844+k8vql91ZBnJLRELjQQ0k9v8tKAEcB3vrIAnZ7xhinG1M3cLpI5l5XdkYTjB8tNpdpqFT4dknW8t0nIJedgWy+c/dKmc19jGxGbTgKnwdLIXakJx+FwBb3jl+uMmRVkoG06Ox6Fp4sK1Nh1vIOeMdlEL08BfjsYAhhqhO1fuZB1j/i5iueBDOzutzZaTuCDTfuVDmDGzh5CHwVLmhhqBeO0m62mzDoN+M3a1ENuKkcL2TLgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHFfC8ZXc9v2vaQo7JBLDWt7/vE/B5nv0SakNohkyVg=;
 b=wzVAbI7x52+ctUZwbSwLq8tfV17ONQYZd1c6EaCjVFClUB2qxkxBZWAk50ZVJqTkppC0gr9lYaH1hSo5Wr2uHKMJ9Noin8HapF5UFizpmUfHtbCi1BXoXSCJ66rCZDBL2cisncsh5n4Wn2GXU5wTgQFJqEfB4ixArLjphF6UB7KYL/6WJHDx5zM/1dDm1q/fMpSwgoakJP9Pw78MkB1gQCYDplSn72+5lBHnqwjmGtcX0jX5VjYHlMt7k2QU8V6jmbwDgfqCPxVeEf2FnGX3juPTHfKJFb7hLWyDwVLq29NBzzx1G3BPN6DIDk1v81poxJ+s7Q5y2KM3awDtcakjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHFfC8ZXc9v2vaQo7JBLDWt7/vE/B5nv0SakNohkyVg=;
 b=Fnn2WHLrEY41lh3KgMhRaTTRsCRmZvumkAtsAXWveqf/rH2JrhxHA960oGoOfB2RIrGJARUPC5CPvMlnFrMWMZletkQpbYWEBbBJYsFfWQ1itWnUZ/Vq1l1iVI358nBKojmWeWKA3fTys/6h/a8xXVe4eIVZxCujsJE7rTRzilMZ6ddXNST3HyJayV2m3tQAHm3OFl6NJGQwVA7fjy8UQZ3KYRAzi6Est+I82u5GAUZ6oO0q/Xd9ci7LJGICqdLVKHk7gYJQF8kq1F7x1S5N1BfumJ9nsndn5hnerzqU54R2ejtKYudv+iSsnZFZZqDx2o82S9zeiJHCqn/yO14mkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14)
 by SA5PPFAB8DFE4E8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Fri, 8 Aug
 2025 10:21:09 +0000
Received: from DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003]) by DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 10:21:09 +0000
Message-ID: <9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com>
Date: Fri, 8 Aug 2025 13:21:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
 lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
 Yilun Xu <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev, "Aneesh Kumar K.V (Arm)"
 <aneesh.kumar@kernel.org>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-8-dan.j.williams@intel.com>
Content-Language: en-US
From: Arto Merilainen <amerilainen@nvidia.com>
In-Reply-To: <20250717183358.1332417-8-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0100.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::15) To DM4PR12MB5391.namprd12.prod.outlook.com
 (2603:10b6:5:39a::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:EE_|SA5PPFAB8DFE4E8:EE_
X-MS-Office365-Filtering-Correlation-Id: ea61dd4b-ffc1-4312-8754-08ddd6654a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG94M3RmaHpnQ0xuYUNQbnk5b1BBVTRFeXF2Qzl0Ly9tSjJ1WVRDWU5md0xr?=
 =?utf-8?B?UmNFcklsbC9CQkUxeExnUjdkazMxL2JKOTlFNGpWN2lmWStESDcyRWdDNndQ?=
 =?utf-8?B?eS9aUE00cUwvODJ0cHJBRUlTNzBjRkpHT3Y0N3RrUG4xV1d0Ym1FVE04UUVW?=
 =?utf-8?B?QWZlVm5WQnpTNEovVEJoNHQvdHhkR3ZxemxqclY3ZXlROG5waG1RZ2VxTGlE?=
 =?utf-8?B?ZDlkZ2ZDQmpTUEpDVmhRRzI1NGVQQkxJSG5IdTU1U2w4c0g3dXB1S0NpdUow?=
 =?utf-8?B?UjFXZWFReHJBT3l0MmVuSjZCSFBicVA2UzZPMVdQOWN6VnJ5UWRIT3B1V1pS?=
 =?utf-8?B?TmdDMjh4blh6aFQzSnAvVGplMXFOUnpRcUcrcnEvaVE3Qnd5YWp0TVFoak43?=
 =?utf-8?B?VHpTUWdldFlUM3J3L0NOYUE4czB4NSt4dkRiWTlOd0huQ1VLN3BOREkwYmpz?=
 =?utf-8?B?ejBCd1JyNk9zc2NhYUtIbDVxd1ltYjU4TDAzYkNOTXV5VGJSTWU2NVpzbTBW?=
 =?utf-8?B?RmQzODNsMXMyaTNxL0c4UFY2d0pZZTVlbFlhNHh4ZTNxL21RR0VBdllNRWRH?=
 =?utf-8?B?UkdkUWp6MzU4eWs4ZEpvNk5ETjVaY2xzU0JpMVNtbUdKZFJsZTN3aWpUei9K?=
 =?utf-8?B?WTd0SW16NDBJVWhrU1hSdnViRXZjUUMva2IrM1NpMVZTNG96eEpNYUYwNDIr?=
 =?utf-8?B?bHVmdWwzSTFuMVBKS3g3cnl6b1U2RTh3MFZjZmlCZFNyWWVaZlRSWE1ZU3U1?=
 =?utf-8?B?S3ZXdTJ0REwrbEtEamNJUDhFenpaK21NRzJveEo4WjQ1a2RtU2dDM2FEV0d0?=
 =?utf-8?B?TmRzQmFzZW81QnZsUTZkYmN5Z0IxN0NtTGpCYjdsdTRxOUlPNHhEeDVOQWE4?=
 =?utf-8?B?bDROYjhMV0xwTGp3SWJmZktRYkZONCsvSUQ5YThnRzBTMXQ4bUVxdTZnaWVY?=
 =?utf-8?B?U09PZENhVWdid2UwOEZDNzRwRXk1MlFyK01GaEtaMTYwQVRaSTZzL0hUcVUx?=
 =?utf-8?B?Z1F1STdlYkl3UFJpbGlMclFEVm1rcDAraFZVenM1WGw4YW5aeFpGVDYzc0Jo?=
 =?utf-8?B?SkViTkpkRjFXQmh5RFYzMEFpN20xVWxISXRXSlRSaTRqRTVSTjdWRDk0T2x4?=
 =?utf-8?B?cXhDemxxN1NsdlJMNlFRUWJMY0QzL0w0MC9DUUNIaDBzajRZcXI4Z3JZSTB1?=
 =?utf-8?B?T0o5V09pY3hiUVZISS9yZndFSGlMS1pXSzFuYlRtMWlwd1Z2U3hpR2RnVzBD?=
 =?utf-8?B?VG0ybHNuanlZZDYwR05UanAvVlIxeHZ0ZUVOd2E1cU5VZWFGL3VweWZ1OHN1?=
 =?utf-8?B?UHM5LzRMSDl5R29oYlkwclZ3TkRSVnpRamdINGcySzJISnlVL1R3MGM2R29L?=
 =?utf-8?B?cXJ2UE9UclJHdUE5a0hTQ1R0Q2VpY2dmcldKZTRrUGR5L3RKcFkxeUYyaEs0?=
 =?utf-8?B?d2hRNTNOazRDVUNDTjk1ZFFUNnUwa21oTW5HM2lHeFo3eUhIWFNkRVM2Ukp4?=
 =?utf-8?B?SDlQRHFUcDBZNVpBdDRZRExIU0pNWnpDVEtVMU9TYkJhek5Bem9vY1dwV1Fn?=
 =?utf-8?B?SmJySURkVldkd1lQN0F5WHc0V2lNTlhoSzhmanNRTnA4VFRFMnd5UVNYZFVj?=
 =?utf-8?B?N0RuZURDZ1ZDZlcwRWw0UFZEaFJzWEVWZFAyL2FuYnhUQktJVDdoMGJ3MkJB?=
 =?utf-8?B?bTlUK053dGhRTXBCTDZ5NzNkUmF0YkVrdlluNkczZTUxVHJSRnJXT0tzcHpZ?=
 =?utf-8?B?MWpnOWdlWVAyNWp6WXVTdDBXMCs1Z254U0JIdkxQR0g0UDVSODl3UTR2OG5P?=
 =?utf-8?B?SGpJb3ovNU1kY3p3czlyT3dBa2IyUGh5TEJscUkrYWhweFYrbllFVytEU2lL?=
 =?utf-8?B?a2tPVHBrT05WdHcycUVqd243QlgrNUVaanM1VDZENEpMOS9uSmhaeTZ3eHFK?=
 =?utf-8?Q?+k43344BSXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5391.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1ZRQXdES3RlTVM4NjJjRUJRajBjellQS0Y2a2hlMjBEemRDQ2NUZEt2enhY?=
 =?utf-8?B?T0FjY3BWenBUYnIyN0owYlBYT1BydjNzajRSUVJjOGpiL2N2K21nckdOdVNB?=
 =?utf-8?B?NzB0VnFmbmxUdnRISmsrdlNMbml4Z0haYzF4SUZwMm1ESGMvVE1kS2ZMbmNs?=
 =?utf-8?B?ODRGa0hYYzBTNDFaOTBWTU1CM0FYOTVZUDFGN3AzUDBFZFdnSDhyQTBtWFNz?=
 =?utf-8?B?RDF3OXN6bWxZNEFjMEJGWXVaTzdQbE5tRWdkT3JzYXlOc0RiRlZ1WXliSzE0?=
 =?utf-8?B?NWt5TnRhcGliVU4wMXQvL3ByVHNQd0l2NFBiYXdvOGk4a3JMMSt4a2ZpczZS?=
 =?utf-8?B?TDNiVVU2dm0xMEt2TTBLQjhMdDMvQXIwZmVCc3BPN2FxOExDYWh2WGkvWElP?=
 =?utf-8?B?anRheHY2V2R3RGlrWE9kN2p4V1pvTm1TdFdVQkp1bm56c2ZmS2JxS05EdXNX?=
 =?utf-8?B?bUpSODZHSUptRDFNSmhHWjlSVTNDdkpTcEUwRlBnM1p6OEMzcERBa25ENWVJ?=
 =?utf-8?B?bmNCRUYzWGpza2F1MkZ6SGpoVXNsUndsbGRGUjFvUzE5dk1xckxEUlBIc3hy?=
 =?utf-8?B?di9RZkw1R2lDVVN5RDd4dXNCYjNOZ0xiejlEUTVlMHhObUNMUkFtdm1zVkZY?=
 =?utf-8?B?cGJQQllVVVNrSlgxbStYY2ROS1hpM1RORmUydytUcGI3bTlqb3BtWjAya0N6?=
 =?utf-8?B?YmNPbHRCSUhLdDM3QVByL241ZDBIcy9qNE4zVmN4WmhJZW1RMlFxMjNIQVZm?=
 =?utf-8?B?WGVyZWxXSlhxSGxreWQ3MUhPNEdPNHlQRUhaV01sUzdxZktBalhUeWY2RWUv?=
 =?utf-8?B?dWgzL3R3d3NBR3drc0tsdmx5SmFTaXJvREtiNlJVbUh0S3dDd005UkdNalBs?=
 =?utf-8?B?TXhzaG0vckdJZ0h5bDUvOVFDQmorV0wzb1FwTmQ0T0FvUTl2ZDZMejRnMzlL?=
 =?utf-8?B?ZmU2aFFRSG1zREdZMW03cmFaSFVEc09LeEV3alVWdmJ1eWpWRndCZjVGUUtL?=
 =?utf-8?B?WGhCZG1GbXpwZDdxTUxXemVHRkxjS2ZLN05FaEZ6OHJvYzFxNnNoT005Q0J4?=
 =?utf-8?B?NnVCeDdhRzZpTUgxckxldUdjRHN4aERrTVRNTXlqZ2JLMm1TM0dRdFdUVndK?=
 =?utf-8?B?RW56TE9LdmRhd3BuN3krZ3pNaHVtS2xsamRvRkUrdmxZK090MW5MdWJZUXFz?=
 =?utf-8?B?OXFxN2ZDRTMwejZ0YlI2OEJzblhZZTg5K2UyVlBSODJxS2cvZ2RMNkI5clBp?=
 =?utf-8?B?MkZHNC9ySjJZNFBmVlo5dzIrd1cxcUxVc3laL2gyK2Q5NkNrRXptbnJwZWpq?=
 =?utf-8?B?eE5JQXB2K3pkQy80QWhJdWQxQ1VWRW5CUmNDcTEzR3gzdGxxY3dlc1Iyd0hW?=
 =?utf-8?B?S2JWOElkSHFGSFNQbDdmOThHeUZ0QnZucEZXYWJJQmpFNExhM0lCQjA5Y2I5?=
 =?utf-8?B?VmNMRVlnRXN4UVdTUmQwMjVuQ0FOUk1Od0RCUGk3aGJIakt2Vy8vbEZwRVNG?=
 =?utf-8?B?dkVBdURueEM0VUNLbS91VkJhbi9Wcms0aS95Z1NDNngrQUFTckxFM2RsSUhq?=
 =?utf-8?B?MEdRN1dHZGpXV1pVdlF6YlUzRWMyeVR5UkJzWWFLMEE1UlBBL3pWQWlMQ0Ji?=
 =?utf-8?B?M2kxVHJYU1RMdWZ5amVOYWJtMExZUnlvQzZWenRodVZsbjVoSnpWZ2tnWkxU?=
 =?utf-8?B?NWpOS0Q2M0wzUWVuRExJdGJxTEJJeTIrUG15MkZGT1BzWmZjbVpnK0lIYjFw?=
 =?utf-8?B?Q2NVY0VLWkVRT2I3NkFPaDNKdFdYZ2lJTkg5ZUVlNWd0MjlMaWNYWTJlM2tx?=
 =?utf-8?B?SnVpTjg1Tkd1MG5QVTYxN0UvZlZwS1hNTThrcDNFN1F1RnZYejkvanhvQjVG?=
 =?utf-8?B?VTNHZ0F4dER5L2hTKzl0UDZKWWpSeWlCNnIwS2hZc0lUT0x5OWJtTkZwa2lh?=
 =?utf-8?B?blJOSEREQ1NTS25YWWxDTXJ1TjdBUzRpVTRCdHFOMDVXMkZseDdsWVFMNElZ?=
 =?utf-8?B?S3pWelhFdFB1R1o2aUpQRzA5bCtQc05Walk1Y0hORGxYMUtOYXg0cTZxQitn?=
 =?utf-8?B?aFJRek5SL1JiTytReWViR1JsTTB5UTF5SzR6cGdldVBSZ0pacmVNYnBDcEVO?=
 =?utf-8?Q?8fk9j7tLuq0lJEeAI4qLF4RV6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea61dd4b-ffc1-4312-8754-08ddd6654a9c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5391.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 10:21:09.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1J3TuSI+XrJRr1KnsYJJGE72N8WwoaV7ASG35bMrgVaiqGc8yZ/4Jgq1w03RaASa2/dHBscIKdkDir9jKavKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFAB8DFE4E8

On 17.7.2025 21.33, Dan Williams wrote:
> +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
> +			    bool enable)
> +{
> +	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |

If I recall correctly, setting the DEFAULT bit is allowed only for one 
SEL_SID instance at a time. If we consider the root port, wouldn't this 
prevent having multiple IDE capable devices under the same RP?

> +		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +}
> +
> +/**
> + * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + *
> + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
> + * settings are written to @pdev's Selective IDE Stream register block,
> + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
> + * are selected.
> + */
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, settings->rid_end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, settings->rid_start) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, pci_ide_domain(pdev));
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +
> +	/*
> +	 * Setup control register early for devices that expect
> +	 * stream_id is set during key programming.
> +	 */
> +	set_ide_sel_ctl(pdev, ide, pos, false);
> +	settings->setup = 1;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);

The first revision of this patch had address association register 
programming but it has since been removed. Could you comment if there is 
a reason for this change?

Some background: This might be problematic for ARM CCA. I recall seeing 
a comment stating that the address association register programming can 
be skipped on some architectures (e.g., apparently AMD uses a separate 
table that contains the StreamID) but on ARM CCA the StreamID 
association AFAIK happens through these registers.

- R2

