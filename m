Return-Path: <linux-pci+bounces-35951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1593FB53D01
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 22:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C445658776C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 20:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A89D21D5AA;
	Thu, 11 Sep 2025 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Way94P3q"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73211B672;
	Thu, 11 Sep 2025 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621972; cv=fail; b=JF+1PkCHPwoq2L0aSRPR79D8MNVz7Ba/tMsLsdOsExhJOr8xBiY4me0MwYZe5GlIjlyNMzAy1Afd50Dau8mHDmjXiGyHHUCiyV7IPc+GY0vp2G1wYePevs4KhDSOuxuy19Qk61PkTg3Q9eqqZhuTjVfKbG4rrwGu40juD6crenc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621972; c=relaxed/simple;
	bh=oGxFcZXYfXXvaYdK+LLoc3wDvQzWSX5gLBWI12fv/ww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pXy65xvjntBS+vaBqYA7dcQhJPcuWjCnX3pHEh6CbWo4Su+zLH+WP6TffNNa3K/Yu7SMHVpU+yhmBc2/UpwFhg/pJbBhAYBzs56UzqomZ2yF20BtL2FRPZalZz/2iMTMPp6cIYv7e0lhKG/oV/Trqq6akrLyfT6YXMXNeJeggdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Way94P3q; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EciTz1+d2+6eAuUtpCsgVWaDFewE6n9CgZI2NCeGS1cDp23kBphJjdPETs3ns7Pku4M/HiGOZswqgeu01aqBzq7unwRNRZNaOgr+5W3CELlobY9u+fglyS87mZTNpHIjKgB5Jy4h9kyDuAssvPYMCea2HrWAOr3B4WUOlw4nt243TZKtCx6VEw1St/NmM3wL3eb1Fl38m/X/UKP4W/WNVqLsSR4AHZHrMy5hFKV1UCvV8aAGOLpdXj6sqkWFEt8X1mvOPtZObn/4QqqNur6kTCHjkqls7Rm5BwysMke6EIdcLv+pUkVC16X6SZj0P2Yjl+UYb5LiexkvynNnKyx/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHDwYfKtR71fJHyglGQ8z6RX1lVEDR3XtTeJYIyGtpM=;
 b=qaFTnmy0M8952VEr+tqp0sz7Og4j9p16XY1TavlFV6bmh4z2AoN6W0VdFAucJka/KNDs3OobH+fcyEPSdUN1s9QdaZvbrYFH+dUhdwzkslXyQkHmeSDUiQ2n16ITLy7U+N85UOvrrSEtQ8Du4wFYwVLT24M08dSZ6KTtZKLG6bigOo2HetaH7KPnnNsd1duWs41NvD3AC7F6Q8YEChZBhDYJ+pS7WpNVw8biO5wGfdKeaT1767/CEnuPtPBP+rtDXt2P/f9H7+GRZrbkYh+PUW4S/PZpOOZr5DEYOOAQJ7RRWRajZQuckDnXuAEwKFjuyThLDRCSoejUj3r9N8v6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHDwYfKtR71fJHyglGQ8z6RX1lVEDR3XtTeJYIyGtpM=;
 b=Way94P3qxX/zTbX2ZRYmNPZBGAsozBc+QGUuj0rLHrdFeIxj22uHlVHMn8B0Hc1Efjfuk0UggieTIPmiYbnHGFks/SsJzT9PzfquYixhUrbb4f1POE/rqTF/GALkKuMBupkYGF6ZUln1KZYHhEJ1d0QPRhocwsvLs4ZFFJiMWQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 20:19:27 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 20:19:27 +0000
Message-ID: <c05ac8ce-044c-4cbe-8c97-846e473324df@amd.com>
Date: Thu, 11 Sep 2025 15:19:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 23/23] CXL/PCI: Disable CXL protocol error interrupts
 during CXL Port cleanup
To: Gregory Price <gourry@gourry.net>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-24-terry.bowman@amd.com>
 <aMGUMACDTT5a2-XA@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aMGUMACDTT5a2-XA@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:806:122::33) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c949f4-58ca-4f82-e450-08ddf170816d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejlWL1RDTDl1T2NiWU9MTW94dVpNSktMSG1tZk9sUmlJcll3cytEQUtJc05D?=
 =?utf-8?B?WXdqT1FIamlGMDRlRjJ5VDZPU1hmbC9FZi9TdzBrdXNoRjNNR0xqc1ArVUd0?=
 =?utf-8?B?YzM2V0hwRnNRcHZPWEM4UlRSbWp5ODRvWFFidVlKdjZMbmlLUTB3OXJOUFJJ?=
 =?utf-8?B?THo3K3lHaTZZY0thZWdMNWl6bjlzQ1Nwd1FCZ3ZKMXpNUG9rZkNSRW5UTGg5?=
 =?utf-8?B?M0RJMXpnSFpaSkZuYmpxZjVqZGhFVGdJN1ByUGNSS1NHZ1A1NEVVR3ZXUDk2?=
 =?utf-8?B?TEZYdlFuUkxzMHZnN2c5NlRKK0JVN1dwV00zR2tFVUtUakQxa25URm9GNkVi?=
 =?utf-8?B?ekJxQ1VzNGpXaWo1TjJPWGg1Y0RxZWhSYU11YlQ5SHVPeGF3Z1JUWlVaNTBq?=
 =?utf-8?B?N1RqZXd2N0xnVzN5SUFJci9ka3VyTzNmcWNqRG5rU1MwY3U5bmRuVThId3di?=
 =?utf-8?B?K1RNR1lLOU5DbmQxY1Z0cVhXNWpMS01Ebmk3OGRKeGM4RmJlQ2JYVmN5K0lY?=
 =?utf-8?B?ZDFUSXlmM1AxUzNCaTlMd2lVSC8zRWlraHU5L3Y0MnZvYVlUQ1NDS0ZzbkFv?=
 =?utf-8?B?a0JYTkUzWlczeVlLNTNIdDFkb01vM3VBZ0pvdGNzZnRuNUhXWVEwNUNBNWRp?=
 =?utf-8?B?bklMcUlyMVMrOEtMSE5VS2p3b2ZicnVVZElyc3FNTy81L05FTHRwZzd2a21u?=
 =?utf-8?B?b2dVNGZWanR4WVFMS0NncDFMZUVFOVJTcUQwMjFWOG1BbnRqVEd5a0VoVmtQ?=
 =?utf-8?B?SjBoTXpnVTFCS2VqU2I0bE9tTmVSckRHekxHU0Z5NU5qdDBXZUVjQTJQSlhT?=
 =?utf-8?B?bVdvbHZ1ay9kU3FVVUhBWDZtSFdQSWJMTXZYT1NzaTR0VGtTb0Jnc1lyZ3k0?=
 =?utf-8?B?Rkd0bll2U21oVnRCSkR5ZjlqVXVHc21GYWI4M3MwQVlldkJmYk9oQlN0SHlU?=
 =?utf-8?B?Y3VvWjQ2SUZIM0RpcEQ2WHRsdEsvSFNXVVU2eDAwZzlLenJyYkcyNHFzeXZ1?=
 =?utf-8?B?eWpETnc0aGpWRG1YNWVNQ0c3cy8xRU1KOVgrZnNOR3o3VG9lMUtRQUx3MWpz?=
 =?utf-8?B?WHFRNHlhZ08xUVRFc1d6TUVRZnJ2QUxBVWhNVFlJcnZpMGplWFpkb2g1M3Zj?=
 =?utf-8?B?ZkRyVGZsaXJ2aWlKMys2WEs2dGs1TEdTZkpyazF3enI2dW5vMGh5NVlEb0xU?=
 =?utf-8?B?MnUvd21TOVNnQTVKQnpHbVFQMEJSV0pxWDN2UGhjOVpFbHhmQkxabWN1K1c3?=
 =?utf-8?B?a2ltZkZYMkZESjdKeC9EZ1dlZ3ErRnJPdnd5VnFFWU1mKzRmQUtFZzF1eVdu?=
 =?utf-8?B?UHhhMTBiVUVrdVV1b3VIT2ptYm5XZ1Fwa0puNlQ0Zmw1RnAydHBoNDl2RnNv?=
 =?utf-8?B?RGY3YXRGU0Z3RVBoV0RzNWNCaGVPY1JuWG52eklvR0xmRGRQMytjRHphYThs?=
 =?utf-8?B?dmR0cmdKZWZJVDY0VHpsV24xeTJrVjJScTk3b3JIdTd5NE5NUmxiS2diNlM2?=
 =?utf-8?B?MnJVTHAvbVhxUUFiN1FqcWpra1ZDR0NJK2svZVF2NnZNalNEMXZuZEFyazR3?=
 =?utf-8?B?UkhFOVhDU3FrMytZbVVLSmMwblZKZkpNVEhyaHNISkdmUGppUUozbnE1MUp5?=
 =?utf-8?B?djl5NjZJNG5wSHFKY1F5SGthWUFPSnJRdlg1TWJERkR3VHBNMncyL2hsQW9B?=
 =?utf-8?B?SWpTbWdUZUFsS2ZNYWltV1FUSTNkYjR0eXBPV056NjNWbUJpek5jenhFc2Q5?=
 =?utf-8?B?a0VWSkQxVmtxOXczcmI0a205bUZYMUIvbDdrOTVyNlhBelliaU5nV200YlBR?=
 =?utf-8?B?SzIxb1Qxc1phRW5Db0E3SFJreHF0bW9QbXVhQ2ZncmtIcGNPSFJOZUVuRzNI?=
 =?utf-8?B?WDZOcytXUXQ1NWVJQ2FEWU51TzUwUW9TQW5Cd2JqZVQ5a0VQYitGYyt5NElj?=
 =?utf-8?Q?9Tz0P68ICY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3p5Y2VsSWRvcWl4UHRyQ3c2Sm9JTHc1UEhoL0xsdzgzMjdKRStwRTMvV1Vj?=
 =?utf-8?B?Sndlc0RpRDNVRXAwNVVjeGR2SVMxZWZOUlAyWFlhSFFEeWUzY1h5TWd1eDV0?=
 =?utf-8?B?RVRSU0pYekJDT09JSlRsNjlQemxNSlNmREQ1a3dlWndNekhVWDJDSVRQdERN?=
 =?utf-8?B?ODRuczNDL1V6eVU2ZGZJd1JQbTJiNGI1VGhLUHcxUHlKL1RHWTJrYWUzOUhu?=
 =?utf-8?B?Y2hTcDZYQml4cmlLZ1NoNGJRTEF6YnlPYXAvYTRGblpQOHFwTFFLTnpDQXZn?=
 =?utf-8?B?aWxoSm41eGlnOEhoOEJxS2xXVDRmazVXeUN1VHBzU3Y3RHJqRUN2LzFrbzJH?=
 =?utf-8?B?ZnZ0UVU1QTBNMGNXbUgrdVBRV2Jlc01ReG5YK21tWEFZYXEvK3ZUQUIwNTRX?=
 =?utf-8?B?Y2FkUVl3VmRQSWRXa0NTSDFuaWpmbGhITnFqNWRwdE1uaW5Cb1RNcnMvRVhi?=
 =?utf-8?B?SVFlTWI5N3p0dkNNT1UyVmFoN0RrRmpGSTJFMDRyQ3NianE1ajVxN0dKaU04?=
 =?utf-8?B?Rnl4UE5OQU04T09BejhSQ3Niay9DU21lMHpSNk5LK3RzWjU2cjJJNVVyMSt3?=
 =?utf-8?B?bkFnTGdWcktSb2Y3NHZKK1AxZ0x0eWUwWVpVNVlRczhWdnVxbGt6OG1jbWpC?=
 =?utf-8?B?WXNuRVVyUkI1elFscUJqRktGaldiS0U0c1dFcERxU3NlYWpTNUFPQTNBQW5t?=
 =?utf-8?B?ekUzbEs3OFJRMldsMGdlSnVSbURRdDBMVXRWYWhPVDhuYkhuRTd3QXB6WS9a?=
 =?utf-8?B?Tm5oYm1hN1pPeDl4ZXc2NDNOQlVpNE41eDZoVHkrcGJ4bjZYVEJIcjF2TFVK?=
 =?utf-8?B?dzI0YURHaHNmZ05aakg5RHhubzJTaDdkbVlKNkRBeE9sVVQ1RE5KZUpMNnBL?=
 =?utf-8?B?ZldzSmt4VURpOXBUaVEzOU1nK3pXWVJEcWk1QzZzak1CMlZEUFpMTlJ4Qklp?=
 =?utf-8?B?cEEyQjZHbnNJSTNxSTRNblBvRlhjbTIvdE5zN0Rqd0pSK2IvWUQ1TGZIZmVG?=
 =?utf-8?B?Uy9yRUdBUDR6NEdvMncvR0lMaVhJMzA1ZlBpY1JDMERnT0YxdlROditvWjJY?=
 =?utf-8?B?b1k4aVpOTlZCQ1NsckpTamwzMTZSdmUyRmVvaWFCK2l4R3hGa3pVOWtkdEh2?=
 =?utf-8?B?cUp4cXUxNU9CLzhGbXh3UHU1enlXWEgzWXowL01QUDI5cHdwVHd0WkNTNTdC?=
 =?utf-8?B?eWtXOEhNWGVwVUFJbXgwNWJydkI5RzBtQmVEN1N2VmNWdHhNZDdrNnA5MEIz?=
 =?utf-8?B?VkpkWnd1YVJxVlVNbGN6V0tLL3pkTWNTdDRpTDNGQjFTajRvbm1KNGxhamtE?=
 =?utf-8?B?b1p6c0hQWFFSSWF4clpFQ3IvRW9HVjFDOVVuVWgycEZvdlVLbGhEQisybHVh?=
 =?utf-8?B?RkdEdzNLZDYyODdCdHVQNDIxSnJuTWo2STdYYzdmbG9hUXJWN05TckIyUnE5?=
 =?utf-8?B?M1VTbmhKT3c1TDQzY0psOWtxK042LzJtVzZWSFR3S0ZoQytyKzB0bmQ3ZFM1?=
 =?utf-8?B?dlNyazlGS1l2ZklGZHI3WVVzQWc0ZVZLM2tzVzJhV3JVVzRHK2ZndUVDVFVa?=
 =?utf-8?B?dlpWeTIxaHBJeTd4bk9nUzNkeFRMNjJwaXhOUGJoTU1QSVVEY3RpMnV4YzY1?=
 =?utf-8?B?L2JCZzFyOWZseGswNkhWdUtCMnVtUVhaRWNCVWdGVEMwZS9sYkJzdko0aHRu?=
 =?utf-8?B?YU54Z2R1SjZCbmVXQU9OaDNLaW84Mzl4OGMxdzkrdmhiVmhyL1c2WXhObXdC?=
 =?utf-8?B?ZHY4WUtWRDdVcm9ETElXcHcwcnBVMHdFaFB5VWhxYndUS0ExTW90TnJWc25R?=
 =?utf-8?B?elJaQ25KSGpQMWMwblZVNGpBVFAwWjBpd1N1Y1psMUhndTg3ODEwL2dpZWpF?=
 =?utf-8?B?OThLeUxpdXJBV1VsdHZrb0p3TFFJYjRtM1loUzNHMU5CUzFENHJFWDZQNzg4?=
 =?utf-8?B?UW8wYUxBZWx1R2NnbG9RZnJNSEM2bStkZnVkcjdMU3k2cnNiK1VRYmlxRHI5?=
 =?utf-8?B?QUZtOStEUksrVDB2YXg0cytKK3Y2YU5ManBiMVNab1p2LzR6SkdQYlFhZlBV?=
 =?utf-8?B?QnFFdURxWEdEVmhVM3hVWXI3QmJzRXc0OFZ2NnZrWjZUVVBLVGt5N05IbDJq?=
 =?utf-8?Q?ur/SmjrtPJgCrHyZBqty9g1WP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c949f4-58ca-4f82-e450-08ddf170816d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 20:19:26.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfW4pMsWcUFF9o2ua1PWcBkGDBu5GT9MTo5sgUyy3Gnv7CBpZE+8bfUTCuTl4z7XFtJrKKvimAgO3HPVf/oiZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644



On 9/10/2025 10:07 AM, Gregory Price wrote:
> Hi Terry,
>
> On Tue, Aug 26, 2025 at 08:35:38PM -0500, Terry Bowman wrote:
>> Introduce cxl_mask_proto_interrupts() to call pci_aer_mask_internal_errors().
>> Add calls to cxl_mask_proto_interrupts() within CXL Port teardown for CXL
>> Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
>> Endpoints. Follow the same "bottom-up" approach used during CXL Port
>> teardown.
>>
> ...
>> @@ -1471,6 +1475,8 @@ static void cxl_detach_ep(void *data)
>>  {
>>  	struct cxl_memdev *cxlmd = data;
>>  
>> +	cxl_mask_proto_interrupts(cxlmd->cxlds->dev);
>> +
>>  	for (int i = cxlmd->depth - 1; i >= 1; i--) {
>>  		struct cxl_port *port, *parent_port;
>>  		struct detach_ctx ctx = {
> While testing v10 of this patch set, we found ourselves with a deadlock
> on boot with the following stack in the hung task:
>
> [  252.784440]  <TASK>
> [  252.789090]  schedule+0x5d6/0x1670
> [  252.796629]  ? schedule_preempt_disabled+0xa/0x10
> [  252.807061]  schedule_preempt_disabled+0xa/0x10
> [  252.817108]  __mutex_lock+0x245/0x7b0
> [  252.825229]  cxl_mask_proto_interrupts+0x23/0x50
> [  252.835470]  cxl_detach_ep+0x25/0x2e0
>
> This occurs on a system which fails to probe ports fully due to the
> duplicate id error resolved by the Delayed HB patch set.  
>
> But it's concerning that there's a deadlock condition without that
> patch set. Can you help try to eyeball this?  I'm trying to get more
> debug info, but testing system availability is limited.
>
> ~Gregory
>
Hi Greg,

Thanks for pointing out. We saw this too and is reason the device lock was removed from 
v11's cxl_mask_proto_interrupts(). Looks like I need to force the EP detach. Do you have 
steps for recreating the duplicate port id ? 

Terry

