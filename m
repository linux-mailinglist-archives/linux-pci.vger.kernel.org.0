Return-Path: <linux-pci+bounces-28074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDC1ABD26B
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 847627A345A
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 08:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B48626658A;
	Tue, 20 May 2025 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="La8RD5Bo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3A265CAF;
	Tue, 20 May 2025 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731225; cv=fail; b=i02KukC3AkRKD5IpkAc+YWmN4YQj9CWVaNyzoUu0FCqitVnx/ZnVZB1fYLnSJaLFPuqs0r5stgLj9q6nMd0wRtclSpK1MiOSKKtE/QZPmfBa0AsC5uI7CxoY67Fd8RFWPcozz7hHuhYWas18CXYLJMrUH6A5kO15MCG4Z4gOxzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731225; c=relaxed/simple;
	bh=RtRTHTvEew2KUgPvM+NEamm2LkGjK5YwvcZiG3/zyec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FfcxC0gzZIiqYN7AYFFlqyNpSxglrZwVE2dEVWGYJ3Jt9HBCLkwv7q9VNpfkKLJvWYZB9kTyHCyQK5I9MAtgCU2hXWPA2EQkSe0dPWnUNYgcBLczxzluCh3fgXEpRssduHEXqtvX/hMoxZnAwNhJ/2CJNHxeZj5aXTPExR2tEio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=La8RD5Bo; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwGHzGyFa0KLmUjU2d2lwO/btXNKo2iwuk+9rP3IASAHnXt2yqbqBTF2715bXXIXjkVisEuI6NZXryCYeI9sb+uxbY2+W5C/N+t8vfhQH+Y6spLDmbBcWSwbKSfcB9mnyq6MJOhpF3lQDsRaXINdSsdHrCzfFHnYuPtqm2mzOfh1XNGUHRJ66vIAuwA2gbCQu21OOVu/OaGPTj7l4G3l8yi9poeSNjRkO35aVp6MzR8Da7DtWJgAlv8xnXC+y4gPDcC4ZbPmJJ2vreDuSiUrnBYZ/FBXWsGoJ/1wRaoMzQOcYGepX5brITrj5rYj+0Cu7Mw4R80QeL++lxt8uaGrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwGRw3kvOcpMy0PL7yoY1NuveNRK4RYGaMZL1qwxLiQ=;
 b=fMXLen+Vs0Pd7/frGxB3PKvDQTNxPwE4ILo2rfGA13LB7cq1h9tgEEzsqKiaGAPZ4aJOq8IC5XawIu9+c+qvc4lJ+VqDGiCCWLlzd9Vf2j4PfZQVqhPQkZbPoIU7I0bUF1PELjD63y/8OT8ZkTO0e9afW/WOBNu4fjisuXShkAX90NFFAC6PTf2rpVp6oxHFOXpLgH8CfoYcTXh1+UXcP/J6BNHZof5uakCJJS+pq1dKLREtCrgzuWwjJ1ALTd6OmTSx/sZqdJwyuI3VSsUBl1Qobh0a98wtkQvx/j1kfPx7h/Gk2SUvKTxh6VMdp3YZ02CKBeREVdKbiQs+8A78UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwGRw3kvOcpMy0PL7yoY1NuveNRK4RYGaMZL1qwxLiQ=;
 b=La8RD5BonvoTyXpFo3GQ777OdsG65AyykZZAe+VpLlgeRzv94jOTv3mAcvfEjiRFMjAuqIivdGk2VjG+ts8p3yz3m4V+ooNMKfubmW/g+K/b7HO7NIlbB01Ofwnrgh4aTafUbalsRo/E1eXje32c7iyLnBoNgGfc/e9/yI9WsC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.31; Tue, 20 May 2025 08:53:39 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 08:53:39 +0000
Message-ID: <ae0c9a42-5898-4bc6-b104-aab90ddbc751@amd.com>
Date: Tue, 20 May 2025 14:23:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 rc] iommu: Skip PASID validation for devices without
 PASID capability
To: Tushar Dave <tdave@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, jgg@nvidia.com,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250520011937.3230557-1-tdave@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250520011937.3230557-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3030eb-da67-4832-00f5-08dd977bd045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkRRQlpRVU5CRVY1WHJMc25aNW5SR1JKYnd5cUZlYURybk1IdkNzY3JwMmRV?=
 =?utf-8?B?VHhvdkRjVERVYXZqWG1ONWVOMmxTdGswbU9LQlROelNzUDlWeHRLZXR3S2ZB?=
 =?utf-8?B?TlRFcEtGQVY4VUtWKzgzZXRWOERmV29XRDA3eDdtbm4rSE80L1krK2NKVU5t?=
 =?utf-8?B?dVZlb0YxclRLK29OU3BsRHlTc2JOVlRhNE1tbElya3dOOFhJTzZzeUxCTHZR?=
 =?utf-8?B?K1I5M0tOOWRHdzlJa0xGMzhZQjJHejk3ajBrajlGc1ZuYzZzdzNTVWZCaEhC?=
 =?utf-8?B?N0VISUhtc3B1ZUpvdVdZMmFySDY5SzlnRU8xeVZEcGdXS1pYVUlKUHp5d0F1?=
 =?utf-8?B?Q2puVmRWTTlZY2ttK2pFR1M5aTNhZnUyQ1hQNFpEK25EQmgyaEFxcXpuUStE?=
 =?utf-8?B?VG1Vdjk4U2hoRjRJTGo0Mmp2cE9zUmZ6OEpIV1dBM29OcytwZ3E0RVFsaTlJ?=
 =?utf-8?B?TDF4UXlONjFweGVHVUhlb293c2dOL1ppWTRqdnM1R1JPOXhodk1hT2kzcEdI?=
 =?utf-8?B?QU0rdFl5a004TGh2Z0NsUURSS2tEV0lYUXJHYkYrVU1aWU1sYy9yZ2cxWEhk?=
 =?utf-8?B?Njd4UjNBbG9FZUFDbzVCTThDTk1hdlBDUWdhUjh0OG01alJWWTVmazYzTUdk?=
 =?utf-8?B?bDZLK2RPZDVnaTczeWpTMXJybmhSS25RVHZqbmlrcU9WTWk2T0Y2Tk9EWDRC?=
 =?utf-8?B?blNlWEpMMmw0NzRqYlNVQUpkcDFpc0RKaHVIdDFBTnlEQTF5K3hlTytwaWcr?=
 =?utf-8?B?WC9WZnhCbjJJZnRqdE4vR1psa1VHU1c2WkhidVRHUmNBUi9JSkJsUnViU1F4?=
 =?utf-8?B?dXNmMGQ1TmNSOGNlUWVzbGQ5ckZINEJmU0FRV3BUd01VQ0p3N1c2WUlBTXov?=
 =?utf-8?B?TCtNR2RiblpZL2tLckxMdFNtN0U0bW02WFR0OG5XOTNYbUx4MG9Hd2VnRVkv?=
 =?utf-8?B?VmEybWdQYzJ0cDlKRThxanIvbW9vRkpMMjdkZlIyNEpiQTNZZmRjMjdqTTVk?=
 =?utf-8?B?d1cxUFJndCsvRkphWXkxYTVkdXVRZFlqb1gzY21Ia2gyd2NmVFJoTEVkSnJz?=
 =?utf-8?B?azFidEJjbGE1Qm5vR05pdEw5MXNMbUhyMXNjc241N1YzcUUrNU1GVTA3aGdX?=
 =?utf-8?B?OVRvVWVmVENOUzQvRWt0OWxZeHE0R1FHMFRJS0NtOHZhLzZvTkx0UkozY0V2?=
 =?utf-8?B?RTYvSWVDUEZOamNtSE9LMXhLUmMweWFidGFUUXlsZU0xTFZtRXFZWm90aVBL?=
 =?utf-8?B?dWZEaXNibVUwc3phb2x1K3RqODVBdXc0bUMzaDEyRE16MHdHR1ZlTUg1b0RH?=
 =?utf-8?B?Q2d3eE5NYVlvQnRGcFFpV1VFYUNyUWYvdWNwTzhvY2JDb2V0N0xJa0ZaS3Bl?=
 =?utf-8?B?LzdrNVAvT3A2MTMrenRtK0Rqc2RudWlwekRobVp0ZG1tc0daakVseVhUbFIw?=
 =?utf-8?B?Q3lqVjNRY0ZVaGlBTE95RmFsenI1V2FoYjBzaG9WU01sSTdtQ0hPY3ZmaXl1?=
 =?utf-8?B?WTFmYTZGb3BXRUE4Z211NDE1ZnBGMjZyR1BsdHJSdmNWSW9nSnNPN094Y3gv?=
 =?utf-8?B?SlFJaFV2WU5jdzFyOUEybzIxek9yRUpHYXoxUHlRNVlTNVBlY1BnVjBEV3cy?=
 =?utf-8?B?aHJBT3JCZEtKcyt5L3g3cTh2YlV2Sng2VUZZMHo1RjdRNnBqdWZVL1JDcDlx?=
 =?utf-8?B?R2NYWWpCTDRZb0VSMEtDRkJRdlNLYUVZQVFZVUgybTB3YTdMMlVXRE0xTXhu?=
 =?utf-8?B?QVhWSXZxdStleGhKc0dXMDZ0SXpTV24wcWh4c0VUcDRLaHlOT1ViOG5WUVZq?=
 =?utf-8?B?ZkIrZlpqdW51SDVpR1JrSllpeCtiOGp3eUF2ZzArcTQyNVU4eU55UTFGdWhT?=
 =?utf-8?B?Z3Flakh2ZEdTQ3poUkRNcEN0YkFuamlVTGFlV0FBdmRKTTBvemhQNVdYM0Zt?=
 =?utf-8?Q?QYd0eSqiTHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bitENDlidW40ZnNiaEwwNFhYQUQ0cFBqeXBGallSNjJYV29PRGt6dlFKYWRp?=
 =?utf-8?B?VDRRTUptUEZuZ2dsTmRSTUp1eGFhOGJxdjNDMCtFeUwzRy8zcnpjT3Qyb3Vt?=
 =?utf-8?B?VFU5Yk9aVjJNQmFCKzNlL3ZvZHFJUTNXcFZ1L2VDbG5XbFJGbFh0bGE1eHo0?=
 =?utf-8?B?b09PTUo2VTJqcFB5b2NRd2VpVDNBeVI3VHhnVGJFWTJMekdJRldIcG9Mcmt0?=
 =?utf-8?B?a1Y2MnllRjBsdTFPdnE0VVFYZHF1cGRuMUVjTGVRd0tBOHF4ejkzY2dzNUpa?=
 =?utf-8?B?MWRWeTRxVGRwanljOWFQR3U0QVVjRXBlQTNKVHBoeFdZNXFDMHZGcWJwWFNZ?=
 =?utf-8?B?R1pocHdpOTBzMnRsVGs4UEdhYUluTjh3emFCT2JBZEVqNVN1eVNWVUQwcHVj?=
 =?utf-8?B?ZFY4Ui9ERGFSRCt2VlUxZHpRQVNPeW42cStQaWxUNXo2QzNXeml6ME02WWF2?=
 =?utf-8?B?TzZwUGhWYVBsSEMwQkVza3BYV2FTc0h0WmlOcWNZQ2RwbjVXZEkzblA0Umw0?=
 =?utf-8?B?Q2JGcnZQOUt6Y0NIRndCSE9CT2N6bVBhOTFPbW5nKytObDYyaUdDZWg5dzBv?=
 =?utf-8?B?ZzFDb1JSMmYrTWNwbjZZcTJzSWlnWUVwWktvZlMrS252OURiUUhZNTRzTzRM?=
 =?utf-8?B?Y1B3Q3FDckVrekhndjdBYjZTbEN0R0k4ZXp3QVFzOVl0UG1Qem5yNERnQVda?=
 =?utf-8?B?ZkY0endBdlljVjBMZmJCMytqdXR3clRwNXMyQmFPaWo4RmprS1lKYTFVbUZD?=
 =?utf-8?B?R04wRHZveEhhU0lidEoyUjdtQ0lVWkp3amFaMFBNL1hhYkxpc3VYN3lQYXRi?=
 =?utf-8?B?djMrU3Z0UENiYU8rRHBMSUcvK0Z5Q2UvcEh0M20xRVlPRmtzbVIyRGdsWnhT?=
 =?utf-8?B?N3dyRG5ZU0VEY0h1MVJKS2l3alBQK0dkWms1SXZxeWFJemw0TXNJQlE5R1F5?=
 =?utf-8?B?bkZEcis1NmJ1NVNMT25qQWc3c0RWeWVnVHFoYmdTeVlQQWpyNHJlQnlvUE83?=
 =?utf-8?B?elo3azZkVC90WXRwb2sxZTBlb0ZjQWg5WGdRc2VRU2FDZkJ6RjVIbWlpcFZH?=
 =?utf-8?B?a2Z3RHZ6dDBtSXJuWnRhb2U1YVNuaHJ3Y2F6cm80ZVFkMUhrZFYzNnVINjFj?=
 =?utf-8?B?djZzVVplTlVFVk1JZm5ueEF2Mm1GenFsZ1F3NlRnTit1OVJ5b2N2eVhjWng1?=
 =?utf-8?B?N3U5S0s3alRnRkhaY1cxclhpWG1ia3N2RHRrb3R2UkFzeDRaaUZoZ1R2YkNw?=
 =?utf-8?B?cnRoZEhySklSOWd1ZDhEZTYwZTV6QjVpZjFwSmxLOGNkUXVrRmVab0JRSWxF?=
 =?utf-8?B?Q2V1dGlVU2FadGNoeGZ4b0NvdFVmcFF5RndHck16dS9NMHJGRUF4Zkczakxa?=
 =?utf-8?B?cVFYODBvRzhSWXIwM2VyMDdWRVcvcHZJQ0NZRjRYWTlnSmczaXdwRldlZWl6?=
 =?utf-8?B?VU1wZncza3BFYWRqdFM0NmNEbVhrZmp1U1pxM2Q0WGlCTmdNMGl4bnMxdEMy?=
 =?utf-8?B?bVllVnR3WmVEb2s1Y2pRMUZWdk5MdUZzblpZYmR3ak9yaWNydVRpNk03VHBO?=
 =?utf-8?B?SFdqVXIwd0ZvaHZJbElVQnZNZzNIcUMvY1pvTkpLVmJRQXYzbkhZNHNWTW1w?=
 =?utf-8?B?SWtmMFZDeE91NzJZYzlnVmEvc0M1UEVhSjY1bG14OVg5bkpMVzhZbEg0SnU3?=
 =?utf-8?B?dlBrcXA2alFtdGV2YkxzMUtVTlcxeXRreUwwS21XYWlialRnZ3VkbURHY2tV?=
 =?utf-8?B?MERqMC95YllEdG9qTG5DRGxGUVVJWjgxdFJISDZuTHA2dmtkT0wzSkxDQnhI?=
 =?utf-8?B?UkpScVhhZVp3QXBpY2I3TGdDUmsyekY0aWQrcnkwTThyQllGeGJjNDJQOE04?=
 =?utf-8?B?M2I2cm9qbWkwcmxlWXdUVU1wbURIWmE1YzNCbnAwY2RwZjJYazVmMUo5am1Z?=
 =?utf-8?B?OXEvUXZTM0ZJdS9vTXhQR1haSDcveVJmZTlnOVBDKzVFVDVRMnMvQU5BQWJp?=
 =?utf-8?B?U1F4cDFGWEJGN1ZYajZ2YnUvYVdVVFJENndWeDB5WEZubjRDNzZvRElIbVpW?=
 =?utf-8?B?NWpxSWNxdlllWXd0ek4vdWdBenJCaDJ4akZTMmxUQjc1eFZ3cDlkMHFkOCs4?=
 =?utf-8?Q?onTZp5t3ohuv462NEHl7H/vzq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3030eb-da67-4832-00f5-08dd977bd045
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 08:53:39.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAWMYH9F7OWlirTs2dzAWzM5f0Wdgh+IIO3xteXCpHfqwqZd+y9aMz+yPPcAvfSIAYqrtqxV1znfhpL0vBFUDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100

On 5/20/2025 6:49 AM, Tushar Dave wrote:
> Generally PASID support requires ACS settings that usually create
> single device groups, but there are some niche cases where we can get
> multi-device groups and still have working PASID support. The primary
> issue is that PCI switches are not required to treat PASID tagged TLPs
> specially so appropriate ACS settings are required to route all TLPs to
> the host bridge if PASID is going to work properly.
> 
> pci_enable_pasid() does check that each device that will use PASID has
> the proper ACS settings to achieve this routing.
> 
> However, no-PASID devices can be combined with PASID capable devices
> within the same topology using non-uniform ACS settings. In this case
> the no-PASID devices may not have strict route to host ACS flags and
> end up being grouped with the PASID devices.
> 
> This configuration fails to allow use of the PASID within the iommu
> core code which wrongly checks if the no-PASID device supports PASID.
> 
> Fix this by ignoring no-PASID devices during the PASID validation. They
> will never issue a PASID TLP anyhow so they can be ignored.
> 
> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tushar Dave <tdave@nvidia.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant





