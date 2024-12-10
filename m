Return-Path: <linux-pci+bounces-18035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4810C9EB591
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 17:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5889A285717
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C651AA7A3;
	Tue, 10 Dec 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g6OCAUfR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275919D8BB;
	Tue, 10 Dec 2024 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846467; cv=fail; b=cDK3AZtujFpEt3QzAC+WA4PY/jXTlrsMzNg/yIxmosLYAWoLU2KAAc5J0u3HtuL6QP1CY6d/c95hHDs4XOSyjldBOZanelgmmsNeBuCmzPO2T4b58FWp6M4YKIqR4RopCZp5BZ0F8Vf6XwoObDBAJWyiek0Dn/YHN2rtaSJG3Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846467; c=relaxed/simple;
	bh=QfAKlQHLFelq79o9PLWvuYgrJTtRlTh3E7KVKZtNZTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pb5GKNUzCbp6TGcnROQk1STmFPw0KCAE3hJFMwSdGvCvd7az/TGZ7e0BCtDBkl7lUdXrWG+CNtAg/oj5HxTUk5cu0ucOcyFFlPc312nRdI6hYenQqpShiG6EQVhnbVoEBFSfoI4Aee+rZjH6C5fyxKGnNALwwhgLfXBfWnXZwYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g6OCAUfR; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq1P6oVZoANgUwZT7ZPMt0gKW2sH2LpYe98Jpwfn9hlO1wGoVqngSpFOLemg9AT6yQ7vIBYqF8G1UNkLJO6LBfbhKEbvVwkItBzlw3kInNL1hm51jI14fEAABozWEZU5xodnTwRKBkjzvi6fMZsf1w0BkU4mLZ1KEkxJfsk/nIyvF+iukXP7aBrWWMe/ukrPi1fEduynKZYhZPa+eAxM5uHqqGMpMV46r4LOszaZi1fKGRx1S8o1qxC+7X+MEq7QHunXxvA8mHmgZ/+3YieZvZBieNCIiXAq4izYFhS4dQbXjxe1PYUZZF2cHBAOGbAZt6akjKCkb25Z23CqX11gAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv5b1F17r0Sx8YJbMslpX6sDa0//Wkg2hfUrYBPAM7E=;
 b=hoWKEBE2LvRt+UYPtVnkL0N8HsYDP6p/IxJmkpWjtgO5Bvn2UxYk7uZLnXQoN1MeSLYyva/AwNsg0Rq8wzFD+hEtpwO6DPXMZr2+DMnOYajjROa19l0befZ7JEMCBYug49fbdixQlSCltZyzU1webj1RYI5Ge0tLZuSLRWTKC1ktxCGfg99zsVSP6S81+zTwnmJ2HPHeoPgXsKLDAgnnyr0mXLNCURo2DtXnDVpnw2Prv1FYg32JFpeYOnlU+CJlYI58cJNbASGkXqOwrBgNb8XxkFPKpJmGqPzoISSRseJ4SCMaHyodqQ6F5+QGQre7Js5P5C27Z3OLLAtdowG8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv5b1F17r0Sx8YJbMslpX6sDa0//Wkg2hfUrYBPAM7E=;
 b=g6OCAUfR9IsO0GdRS9lD3m4vkgF5on+yvWalvvKsjxWSdsKFeaN6Z8QjpFTx1uZhOBbqL8y7qy4VhxhHjvOR9AXbxcOp8yoZ+C5h1CzUoL8+ztiJgd9KIO/hvW9x+JPGWkZG9Rl+l+vnCYOYo63PbcIWoE6tsXZmR5ZVC9/f2gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 16:01:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 16:01:01 +0000
Message-ID: <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com>
Date: Tue, 10 Dec 2024 10:00:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Werner Sembach <wse@tuxedocomputers.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ggo@tuxedocomputers.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209193614.535940-1-wse@tuxedocomputers.com>
 <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
 <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0030.namprd05.prod.outlook.com
 (2603:10b6:803:40::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3aec9e-c7a6-4012-640b-08dd1933d81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWFYeTA3N002UWN3eFZ5dDBwMGRSNUFVVVc4a1F0UDRabFV0VlhCM3lMelJ4?=
 =?utf-8?B?QW9pcnNncGVuUGF5VUlrK2QxWGlYektZNDBickxKUUxvVWltVkR2d1lQVjVv?=
 =?utf-8?B?VUxGUU9oL2dtZThjZkJtNjNROG9uUUVKYlp2bDZZYURmTmtkbzA4RmxjdHhv?=
 =?utf-8?B?Qis3WEZpM0ZINzExOWVOT3NLeENPeCtHOVlvUmtWYUY3VnV4VkI5YVlObmdh?=
 =?utf-8?B?cStJdlFSd0JpVUlFYVJPTjRWeVgwV003UVVhUFhSbDdsU3RDcTdiK2I4dXNu?=
 =?utf-8?B?cVFGaUx3Tkl0K0RmVnFOYVFMeUtHQVk2L0ZLWFB4ek9nWFJ2RmRScTVKSUFO?=
 =?utf-8?B?YWFuK1ZoYVgxMEVCVDJjejduMU1KL1VWYTlNSnZOT2pJR1hOUkluOGpUejRm?=
 =?utf-8?B?QzNRODR6Ym1hdzlRaXBhWnE5NVNOckF6b2p5OUdZR1dWRHlGbHJ0L0dnVDhP?=
 =?utf-8?B?K2JoZm9maW82QXdDbWY0aDRxWkRlZ1ZndDNweUJkTUFoM0hTQnIzVUJpSjEv?=
 =?utf-8?B?aEJ5UUdNSTFOTVdaRFRCYk8zbWovSm1EbnRLbjVnV0ZPdHZxd0VJS0tSTGNN?=
 =?utf-8?B?WENsOHd0WncvU2tRb2V6YWVFeEV6YlhVb0QzNUlUL2NaVGU0ellqL1lvSkU3?=
 =?utf-8?B?RkJQVXBsWFg1MEN2MEwvTjFmeUtuTUl5Vnk0ZHIwdllDVVNqOWhjbXdySDJK?=
 =?utf-8?B?a0ZHSXRtOGpacmFudFpQY1JaaXJMa1pwM0M3VGtWRjBsWWFNVWxkR3BDYnlt?=
 =?utf-8?B?WDVsdmE3WXVRQjlLZnFmc2R2elhBOHJVTEl3ZFhGQS9jbGZ0Z2l4M1VGSTdm?=
 =?utf-8?B?ZGgxdGJ5NjVvVzF5Z0lXYU5iQ2Mrd3p0am9XNEN1YjJrdmxLZWFqOVhhSDhs?=
 =?utf-8?B?VlNjQlBYMzZoNThUYm8xcHBMZmtWN0VGQ01tTXB1NE1nbXVWUTVmQ3F1NCtF?=
 =?utf-8?B?QWVsNDU3c0RodW4rOHptSjZQeCsxRDZqZUd3c1pFTVpRZEo4Z1VvS0pyM1NT?=
 =?utf-8?B?b3dCSjh6S293ckJEUjdXbEg1dDNBUk9CRHdqVFZDZXk0TVVkbGttVDBGV0JZ?=
 =?utf-8?B?enRkVUpsWEJLWFppazlybUNKRU4vd1dsVE9JYUtGOGxiK0pMdFJlQnpaQzJy?=
 =?utf-8?B?OTR3ck5qaVZQZldtbC9qQkxPemhGdy9WQzBhZS9RZGZLQlMwRlJZYUFXbUE3?=
 =?utf-8?B?T052UnVnYTBwMlJULzZJcEZuTFo4dUVwU1Z5bnRSeS9zWDRPSlFQQ1RkcDVx?=
 =?utf-8?B?SW5OWmhmRUhaUHpUaGY2aHhsQzlOV1YwL3gvM3hpYWRWeUNaK3Zreko5S2dt?=
 =?utf-8?B?MzVsZS8wRm5YbXJydU1aVmZKNW1HT3dwRENMd0pLYUlPQVFXWURLamc5OVh0?=
 =?utf-8?B?N1I2aldzbVVQSlpCQXFlQ3dkaUJCR0IyN1IvcFIxVG1jMkMzSjlEeVFINkZV?=
 =?utf-8?B?VGt5Y1RoWWVVclUxdXFkT0V6OXFMaGN5cGp3UHdtdkJSOEdqQThuZlJaUVJ0?=
 =?utf-8?B?bXBIaFJaczdRQThzSHlHYysxdkp2c2w3YzZVZUxHd2d2NngrMUdEcjlqdXk2?=
 =?utf-8?B?TFFmMFFGUUlTMkVycjBmVXI2aU9TL3pUbGJxRjZ0d3hkTEUySG82NS82c2ZO?=
 =?utf-8?B?ZHdWNmFWQk5oeFBvbllwTDFVSkQ5RktGSWVtSDlrdFI1TnNKVU01cDgvUXYz?=
 =?utf-8?B?QldLTkFjdWV3am51NW4vZDloNjlTZGtEczErRnF3cmNGSzJUaS9LbFhQMFNO?=
 =?utf-8?Q?Jo0Whw391sfhXNmDLH0LxhrbWRGic0grPNX0CuJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NERwUXZpcDFaOUVnTGFJZGFhWW5ZdjV4WXB4aEYyby9ncEREeFhoQ3JRWXFT?=
 =?utf-8?B?ckpRNm1DRFdMaTJZZFd6OCsvVE5raE1Jb0lidmRUdURXQzlKLzgzWFNkTEc5?=
 =?utf-8?B?bFFWQWc3K3lha2xRd3BDbVEvRnlOR2lXTlFTeE0zTC9BUGtaU0dvVXE4OEJL?=
 =?utf-8?B?OHB6NktkZUpqV2x1M3RYUGl2OGN5S3RYUXNpZktTSWd0RG50UFdpd1lVL1JB?=
 =?utf-8?B?THcwdGFJN0NTTkJnbXowYWlyUGN3UGxReUlGTmlNU1JEUTFtK0VtUTRDV3ZJ?=
 =?utf-8?B?NXVwd3VLK2JCSzhmVXJ0N3lyZUYzUXRnbFB6WWVlbWNHTitTak12UDVnbXdz?=
 =?utf-8?B?VmViUDI5V1BxeFhGUHd2aWZEcG9Xc1NDM0w2aG03RDFwYXBFU0F3T2hEdHJv?=
 =?utf-8?B?M1ZpY3B4QnU4OU5Kbk1LZVlzQW9ESGRXK0FnQXJybjcreVpCRm0rM2Y4RENo?=
 =?utf-8?B?djZUbEpOTHJ1dHMxVkFXSDdiaVZ0UG9USUtRQ041VEhtdi9tbXBJSEQzZVdj?=
 =?utf-8?B?cnI4LzI2Z1poeXV0UWh3RUtvNll2TEl2Sm5yaU1tTjV2OGd1OXgwM1hlNUk1?=
 =?utf-8?B?cGRvT25YNm9ycTRFTW9XUWNHNEJ1UE9TNWhlbFhUbGUvYmN6bysrTXc0U3RI?=
 =?utf-8?B?YWVHdHg0TFVBL2tjMVYrTW1lb2NwTnJENFhFMTc3Zkl2NHprQjMxVUtYWXZH?=
 =?utf-8?B?eGNrZFVEbEtPRjhjSDJzZiszbzE0TFJkOHBGMWNNbmtkQ3UvM3JacDdaejdU?=
 =?utf-8?B?TmJ6Z2JuRWc4QkdOVGFLVlV3SHJCbDdXVjJnb2c5aU5ldG5pSjJUeW9zTDVH?=
 =?utf-8?B?bVR3UjMyMU11Nk0vci9ac3dGSUppRklML0FVZ0ZuRTlLNmEwcDdBMTRuWTJv?=
 =?utf-8?B?MlJDa01KKzJObkpiWG5adXZMc29pTDVQR2FBNytCZ3dGVTB6R1VQN3h6VHRo?=
 =?utf-8?B?QUd6SFRTWFcrQld4SURUakc2WncwNU1CTm5UdC80RDNKSWxkb1F2TEF3ZUNX?=
 =?utf-8?B?N0lEY09hYURYeXNTMHkzRW5UOHRiTHlUTk9vbHhjOUxOZXRLZHoxVHhDc0J2?=
 =?utf-8?B?UlNaYXh2dzVHSm5QVTdXQXpFaGRjL2xEU3pXRDVJejlHbFd4K2xaV01UY1Fo?=
 =?utf-8?B?SDlkbWdMUVBQY0EwT2Uray9WZWpkVE95Q1VacVU4SnNrbWd0eWZqVm1tcWov?=
 =?utf-8?B?UUU3dEgyZE1IMUFJUUFKZ09HNWNXbzRSZE1rWW96WTYrMDlveGhoNWpXV1lv?=
 =?utf-8?B?Wmd2MnZGWDM1VWlnNm9qRlkyUWc3SVNjbzB1aEUvNVpkVklPbGtnSEZKTm5X?=
 =?utf-8?B?RzNmSVRockFHZStlT3FIQU5lWTgwWlVOUHI1VlpSVXN4b0h5RTNWVm9YckVZ?=
 =?utf-8?B?SUxNQk5GTkxreGR3a3VidFZTQlBGMXFkZ0FCV00rSzBtd0tiMHA5U29ybUlM?=
 =?utf-8?B?cllReE1DZlR6ZTNHdmtseHN0RHJpZEY4cU5CS2oyMDZlVks3Nk1pTFlRQU45?=
 =?utf-8?B?cG0zZkVTbGhSTFlVcUFydkhMYk5mTFJndEJCRUhob0VxNk9uZkViNzJ0Y2dB?=
 =?utf-8?B?aDAxbjZkaFBSa3poc1JZS1RKcUVmajIrNmFEdlltU1lCZEpZZ0RuMzVsZWpG?=
 =?utf-8?B?Vk1qWWhxMllpMS9oMW1EWkQyYmNOelhsdTF6WXIveFNHYTJKTVZhajduRnFS?=
 =?utf-8?B?NXNLSmJmYjhHbGttRFkwR3djK0tyV1dQellhVkVZTmZnTTNhdy82NDMzTldF?=
 =?utf-8?B?STdTd2p3Q25meWNzY2RvVWorY0ZFbnVBN0VReXlmZXJQdjlhdW9HUjFOWEZZ?=
 =?utf-8?B?TjViOFRTU010KzY3L3VJZGVFcFpxUHZkVHVIV3dUY1JPSGQ5KzUxNzhYTWZ5?=
 =?utf-8?B?c1AwRkZBTmNMMDhDOWp4ZXkwUmJFVWdoWHpRSTJ3NzNTdGYvOGZZY2QxcGpW?=
 =?utf-8?B?NDdib3M2dUt1ZlRVbnlveHBHTFV6dHMvOFFMYUgrYnMzeFRNYlBpR05pQUt4?=
 =?utf-8?B?Q0lFMk04L3Z6TGFVMElzZWxQU0ZGT3NrU1htWmhLU1hRMTA4bTVxd3lMc0R1?=
 =?utf-8?B?OC9WWlViUU1RdWVPMUV2RVJZemh5Y09kTmlPdmJzSE5IU1hUOEcvTXZxVUR1?=
 =?utf-8?Q?8IkFvKd9IPG/tNLvzaErY+fWi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3aec9e-c7a6-4012-640b-08dd1933d81d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:01:01.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxw1YGOmXGnZoXEEG+sWVWKXMfBZwAyFHaWEVtJisU2jpIMic91GiIQBBbfogUF3o3brH2o8dmgf6Tn0QJbJVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035

On 12/10/2024 09:24, Werner Sembach wrote:
> Hi,
> 
> Am 09.12.24 um 20:45 schrieb Mario Limonciello:
>> On 12/9/2024 13:36, Werner Sembach wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>> sets the policy that all PCIe ports are allowed to use D3.  When
>>> the system is suspended if the port is not power manageable by the
>>> platform and won't be used for wakeup via a PME this sets up the
>>> policy for these ports to go into D3hot.
>>>
>>> This policy generally makes sense from an OSPM perspective but it leads
>>> to problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with
>>> an unupdated BIOS.
>>>
>>> - On family 19h model 44h (PCI 0x14b9) this manifests as a missing 
>>> wakeup
>>>    interrupt.
>>> - On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
>>>
>>> On the affected Device + BIOS combination, add a quirk for the PCI 
>>> device
>>> ID used by the problematic root port on both chips to ensure that these
>>> root ports are not put into D3hot at suspend.
>>>
>>> This patch is based on
>>> https://lore.kernel.org/linux-pci/20230708214457.1229-2- 
>>> mario.limonciello@amd.com/
>>> but with the added condition both in the documentation and in the 
>>> code to
>>> apply only to the TUXEDO Sirius 16 Gen 1 with the original unpatched 
>>> BIOS.
>>>
>>> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>> Cc: stable@vger.kernel.org # 6.1+
>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from- 
>>> suspend-with-external-USB-keyboard/m-p/5217121
>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/pci/quirks.c | 31 +++++++++++++++++++++++++++++++
>>>   1 file changed, 31 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 76f4df75b08a1..2226dca56197d 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -3908,6 +3908,37 @@ static void 
>>> quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>>>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>>>                      PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>>                      quirk_apple_poweroff_thunderbolt);
>>> +
>>> +/*
>>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into 
>>> D3hot
>>> + * may cause problems when the system attempts wake up from s2idle.
>>> + *
>>> + * On family 19h model 44h (PCI 0x14b9) this manifests as a missing 
>>> wakeup
>>> + * interrupt.
>>> + * On family 19h model 74h (PCI 0x14eb) this manifests as a system 
>>> hang.
>>> + *
>>> + * This fix is still required on the TUXEDO Sirius 16 Gen1 with the 
>>> original
>>> + * unupdated BIOS.
>>> + */
>>> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
>>> +    {
>>> +        .matches = {
>>> +            DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>>> +            DMI_MATCH(DMI_BOARD_NAME, "APX958"),
>>> +            DMI_MATCH(DMI_BIOS_VERSION, "V1.00A00"),
>>> +        },
>>> +    },
>>> +    {}
>>> +};
>>> +
>>> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>>> +{
>>> +    if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table) &&
>>> +        !acpi_pci_power_manageable(pdev))
>>> +        pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>>> +}
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
>>>   #endif
>>>     /*
>>
>> Wait, what is wrong with:
>>
>> commit 7d08f21f8c630 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD 
>> Rembrandt and Phoenix USB4")
>>
>> Is that not activating on your system for some reason?
> 
> Doesn't seem so, tested with the old BIOS and 6.13-rc2 and had 
> blackscreen on wakeup.

OK, I think we need to dig a layer deeper to see which root port is 
causing problems to understand this.

> 
> With a newer BIOS for that device suspend and resume however works.
> 

Is there any reason that people would realistically be staying on the 
old BIOS and instead we need to carry this quirk in the kernel for eternity?

With the Linux ecosystem for BIOS updates through fwupd + LVFS it's not 
a very big barrier to entry to do an update like it was 20 years ago.

> Looking in the patch the device id's are different (0x162e, 0x162f, 
> 0x1668, and 0x1669).
> 

TUXEDO Sirius 16 Gen1 is Phoenix based, right?  So at a minimum you 
shouldn't be including PCI IDs from Rembrandt (0x14b9)

Here is the topology from a Phoenix system on my side:

https://gist.github.com/superm1/85bf0c053008435458bdb39418e109d8

That's why 7d08f21f8c630 intentionally matches the NHI and then changes 
the root port right above that instead of all the root ports - because 
that is where the problem was.

You can see the PCIe ID 0x14eb covers quite a few root ports for a lot 
of devices.
If you're disabling D3 for all of them, that's going to be too broad.


