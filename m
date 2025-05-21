Return-Path: <linux-pci+bounces-28246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90877AC00B2
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 01:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A138D1BA1005
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 23:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA041A9B4C;
	Wed, 21 May 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NrX21wHF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5A6148827;
	Wed, 21 May 2025 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747870225; cv=fail; b=i2IMTqSFPz+7DlnklbFPm/EKfZgO3k8ZTODJQY8RlBuyh8t7Rx0CterPD67LPPk1f8Tn0sa8tdvKJi9Id25pBwHnqLCV+sA0VYmXsMmq95KnjMwN8+ZCwo16xHfY3iD+8t2Xx7LQAphLrxiZAbOEIs3YmdkC4jQqxWQOpKTJnek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747870225; c=relaxed/simple;
	bh=ynrPdkIktm/Qz6zVrAl0F3z2ACwktIlI0MyDRkJA3tc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tpeazpw5uChL0GSLEbIyOFEaZtrpldO35wG2yavYj5VcUepBOZI9RKCbO1UGZOqcZXZLnfIIu/dTZ+n1J7G/A9sY7U8bosFFWrO+4MTEPjrlhEXRhlP7na6QWp8h4hV0skbWKHCobDPCgd++PReCzzkwOPQBbBr/IXeKFv2yvd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NrX21wHF; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXAa1eWkQRB9fN/aRvl/MyIpo2bGyBYTNDN0mqi6Wb/0nQreukfFzMzMVWYJQVUf1ddd86o90PRRw3CEpTW/Z/jl/4sEMGPaiLNq5dDvHLst+kuL5P3d7K33rYJXr7fkPCreLPdD2OIiHgG7vGeYqZoJwTQWuEXrL4ud1qAaii1T0IlTdzRM6UueC1aUKSR+pecP32+c+C+kKGEwJzP4Zx2ar6uuKL4QOjDOfViPEY7d6AoxyghfJm4f3X4Ox5pD5gHYTxM2FPSObkPxvgFhLFUXKg0ZjfJ8gFvjxLoEdOj9OpWH3DDFFkjHYBUba7caFTBOvu2pcuC0yl4CYZsM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs+6vatvsUMOSkzffkAbfBGUriIHmMZt9LjOb2N/MU0=;
 b=AGI4L9re24FInm+cDafRAhtOoLMmJKvRLJRpbWHnnpBMjeDAX2uMOvw19baqdFYQ7Bou+mmGi5Ph1QYsZJV3nNHdzRJtlJp+dbXGHbO8w+8r4zaxi4pl21mzAmGmx10fG4HOI+YaLdgLceYMbQ/E9nTqfN5wkVtNGN+y7jydS13y9BsoYTBP5ea+mY2TX/49AszOZteCXsMx6ElhK2Pjsj69ecMNDBVGyh61AAOGvjVkDZNohQ8tQ4PwwZXmYfO8+9a7D81WgZp5Y+v/KHNBQvB23/8G5Kvyd0pUN1KDLQIhpWQRYLoMP2kLOJi+8miYq4OGzFNKGkn45G4AFMxZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs+6vatvsUMOSkzffkAbfBGUriIHmMZt9LjOb2N/MU0=;
 b=NrX21wHFV27PWMpAnN797+2DrUEuOwIAjvqHsqKZlTn1YdBuGE33a1+fobUSaKDqvV6nBnX2YekjoKjRzFxlAntv7GeSb/pt1W9HLxk1dTVpNLA6v/gyZOFnkUr3sYrX8ptwoCjbNs1xwCny0GvpNqIpJuYBEgHRg8FSu+XeN68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.31; Wed, 21 May 2025 23:30:14 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%7]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 23:30:14 +0000
Message-ID: <1ee2446e-0b8a-4255-a648-30d2019b591f@amd.com>
Date: Wed, 21 May 2025 18:30:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/16] cxl/aer: AER service driver forwards CXL error
 to CXL driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-5-terry.bowman@amd.com>
 <20250423160443.00006ee0@huawei.com>
 <e473fbc9-8b46-4e76-8653-98b84f6b93a6@amd.com>
 <20250425141849.00003c92@huawei.com>
 <8042c08a-42f0-49d5-b619-26bfc8e6f853@amd.com>
 <20250520120446.000022b2@huawei.com>
 <46c962de-a691-4e67-9af6-5765225633ae@amd.com>
 <20250521193412.000067b3@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250521193412.000067b3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:806:20::30) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: f03de56e-b3fb-4e4a-0658-08dd98bf701e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekdRTGZsc0tGeWJ1L3VoV09hbGFCZTFnWUFmcncyOS9hUUIwNjgyTTNwZi9t?=
 =?utf-8?B?TU9kTmIzaC9VaE9nTHgzZzNNd0xMTUlETVdaZ2hEQVN5anpNaDBmK2ZQa2l0?=
 =?utf-8?B?Y3pzZWZGemFRVjVCT0d6UHZEMzlmbE9ZVm5kamlFREpxTG11Z3BvbnBoN3FS?=
 =?utf-8?B?dDVxNVczdmJEaS9IdWdzSG1Wc3pFU2FCamg1bjZoYlp5SlpyYW8xQ0lhNmFS?=
 =?utf-8?B?di9LTWNYUDlnUlFhRXBibnFZd1gyU3llaTQrRGY2Y3EvMEV3Z0t4RDhqcDYy?=
 =?utf-8?B?UGcvOWIrUW1RcjF0RVZ3VHRJbEx0VEpHWjVqclNac3JkWldSM0xvcG1ybGhF?=
 =?utf-8?B?VllFd1pkdHJCb2JXc2xCNy9qZElJOVloWWZURHB4SzB6MEI2Y0xMS0xMaU9u?=
 =?utf-8?B?a0U2TUZjcFJpbGNLMmoxY09JZGJXVGFWUGRtQXRXZTJGcHk4TFNUMEtwc25X?=
 =?utf-8?B?LzFIa2FoTk1Lanl6dHRzb1gyVDlTMGszZDRLWFltWkJqN2piWkkvZmUyWnNv?=
 =?utf-8?B?aDh0dXNjYlVINEVDbjZIZ3V2SGhUVXBRWHYzRXk5S3VyZHNjeWt4ME5BRnBx?=
 =?utf-8?B?endDWHhaNEpCNkgveGtqU0ZDdlA1R3hFS0pCU3pmWDJDMEtlNzFFWW42MnNj?=
 =?utf-8?B?SkhEQXFZY212UC8yZUhBUjVDZzlBYlZCZno1eEdEajhVY0o4azUyMUo4ZXpw?=
 =?utf-8?B?R2FYbjRNZ01EZmZ4OStNbjdWaEZ0MTlBUWx2NWZmU2N6R2JDWWZpSDN2WlVr?=
 =?utf-8?B?MGRtM1N5TGNOeXBPNmI5OVE5SUJYVmVtRTlyZTJBazFSRGl1ZDcrbFZvRldk?=
 =?utf-8?B?ei9URkRka21IK3ozQzkwaEN1NVBoVVZ6eFd1ZzVjYWZjb3lYVG55UEpIbE53?=
 =?utf-8?B?UitjbWdMR0s1d3pKT3RNTTQ1aVRxSkV0WjIwUmx6TDY0eWZ6R2l1U3c0cXE0?=
 =?utf-8?B?czJWMzNhMXhPQjVMVDVqZDV3NFdpakQ4V3lIa1V3Z1pCUXMwdjRORGhEcjVr?=
 =?utf-8?B?cVNUYTB2MjBlUWpXOHkzL0NsQ3JQMUZrZ3FFVXM3dyt0SVhwcEJtWFRTRWhl?=
 =?utf-8?B?L3FyK1hSa09GK1c2VFZ4S3p2RUpTWGxIUVhEd014bTNJUnEySFdYR2JOb0cv?=
 =?utf-8?B?WkFCMjN2QWVwWEN1c2RXQjd5TGQyQzlhUzhJWDRuZjZ2cC9nb3djajJwbXU1?=
 =?utf-8?B?RVBXYnVGaGFRdmowWEY3K3pQWnNUOGZQRVNFbVc5UDlxTkhTRVJUL1ArVVhn?=
 =?utf-8?B?MGVHWXdOalR4ZmRXcUl2cGcycGhPR2JtVTB6Qno0WWY1SkorVEU4V0F1d0cy?=
 =?utf-8?B?VGsrYjhyeGovMTQ2THpGc2ZObEpjaXN3MERmL0ZsaS94c2NFQmZBNzNIM0p0?=
 =?utf-8?B?Nnl0R1U5dWlNN3A3UXNudEdnZ0JaRlR4c0lEMkYra1VOWWNybGZ6Y0h2NEtJ?=
 =?utf-8?B?TTQ5UksrTFI1b0ZCelpQM3VBMDE5WHFiVjA4Y1hkV29yWGNTakR5ajBndVJP?=
 =?utf-8?B?WWd6eEp6U3ZMRlZzdlgxaFBETzdkZWVTdFhYa1lUUGlhT3loYTRpZnNac214?=
 =?utf-8?B?OFcrYklpRmh0VkRHY0g2YjV1WnVJc1J4bnMrdmRkeG50MHFMckJpWlFqL3c3?=
 =?utf-8?B?K3daVmxHNXVxaEYvbkRqdnk1NmFsRFBXcFgxYy8xVUZSTytKb2syYWsveWU3?=
 =?utf-8?B?bkdhWXhMcUUvYjNUanZid0IzeFFoVXVmWkdPVmJaemEzV3dsdEtMOHRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTZpbnFkekd1aXdSbXpmT1g4LzRUcnM3MU44TVFnVCtEbEM0R2IwSVc5UHFa?=
 =?utf-8?B?MFA1MVZVNXJCOWErU0JRaDBzT2kzbGl2K1VKNXZTREJrMzFjcjZRRzZ3T1NW?=
 =?utf-8?B?RktFUk5IRHdsY0Vuclo4b3ZrWUtXZjlBcVBaOXNCTkl6bkhCNVVEbmk5N05H?=
 =?utf-8?B?SWRGblhPV3F1VTR4RCs4aHViY2Y0QkRGM1BTODkzZkdFNDR2VVY3Tzd1cEth?=
 =?utf-8?B?NzlJRzlJMUlQa2gzbm1qS2RZY25yZWIwNnh6WDlMbEQ5MUlEYVdUb0FWbUwx?=
 =?utf-8?B?SGUvY3FMREhSM1RtVkVzTXhtb05kK2tsczgzSlEreWkzR2pjMGl3Ym94Z3ZB?=
 =?utf-8?B?b0xoWHFPRUkzcTc0b3pnSjJWSXlmQmVJdzFsMVllYkVIZWZvcUR1NHBKQ3FN?=
 =?utf-8?B?b1VzQnl0cXZ1Nm1TWlVFZVQ3Rk5uWGUxTmdsK2VNZzJQeDRFR3padDZqalh5?=
 =?utf-8?B?YU1WTDUrUmk2dHNySUZIeUs3djZ5MUxzZDYvZWJ6enJDeXMyWHEyRklGdWNy?=
 =?utf-8?B?T2YwMGNyOCtNcnZCYTJtWGxNTlIyRzJrMjA2MGY5MkRFTHlwLzkyeFd3bHVl?=
 =?utf-8?B?TEJjdVl6ZkxKeUduQ3hSNExPUW5FM0pkUm1STXl0amxTRG1FNWZNRG4zOUta?=
 =?utf-8?B?N0JOdldhK0Z1dytsMUpQNGhHVkhHbjRZTEtFNml0cVdCRUNIaGdZYTZpVFM3?=
 =?utf-8?B?VTU1dmw1eU1EaVZ4Q2w5WTdReHF3YW1TWjNuN3huUTdPSGtxSk1mOTdFYUla?=
 =?utf-8?B?SWRHWmZVTyttNmlkOEtld01YbzV6K09pMXlLbHR1ZVgrZ2tLUFZZMTRVTlhI?=
 =?utf-8?B?WU5FcUg4b1pjQXB2UlBSa2xCbDlXaURSYmEvVVNEOEZaOGttNXhiTTA0WTVh?=
 =?utf-8?B?MXJwek4zbG1LOFZHcVVCdVVPVTM2UWhIai9uOUFQRHUxMTJmOEZSWHV5MTFO?=
 =?utf-8?B?R0VyRG1MODhwMU1XaWNmL2MrTGNxQkN6b3Z4bXlLOTlMeUVTYWUzbFhhbFEy?=
 =?utf-8?B?Q0h0T1dZdTJ0NG01N3BEbTVGeFpsUGpMYmxnVWNjRGlBc2h3N2pHVk5iaGJ4?=
 =?utf-8?B?NG5HZitwbFRrWkZNVHVaaGNYSU1qbEJmQjltK2svbEJpS1k2Y2JvSW8xTFhi?=
 =?utf-8?B?TnRzQXcrU2VnZGRQNDdnNEtxWi9PVW1NSkp3K1NoZnRldWt0dHZhakJjd0Iz?=
 =?utf-8?B?cWtNQVBrbU9sbmJSTlFSSStGMW4wUXJYajFzTUZoNU1EWkR2REsyM3hlWWhr?=
 =?utf-8?B?K2FqWGFYYjA2aTQwZ0dvNkNnVlZCcDA3YnFYMWExeElnQmdpdGUraTFBVUM0?=
 =?utf-8?B?N0NBNlRJd0d6NDcvemNKT2hlK2w0OHhZRTF2akVVcXdSZWIzM1gvMlJsbFd0?=
 =?utf-8?B?YmhZdGVvM0tQaTUxUk9BWVlvemJSSVl2L20zaFQwYkt3U0VWaThkWE03Q1RP?=
 =?utf-8?B?aHF0b1dKL3YrUGp2NWhjUlQ0V0Q5SjBqZ0I0eHJPeVQ2WlpxUFBSQ0NFV3pF?=
 =?utf-8?B?cEd2ekR6TExJMlM0aldhOHVCZjE2RTJhaXFxMGNFU2lBVDRvSGc5cERHZVZa?=
 =?utf-8?B?a3pIcmNsMmd5d1BNdTJ3bkJscXMzcmd2ZkJMV3pVNTNXU3pETW9JR0Qvc3Q3?=
 =?utf-8?B?ZlJnS292Q2kzdm4yc2dGckdrV0o3TmpCWHZ3S2R1Z2ZIRkxiOU1VbkFXck9G?=
 =?utf-8?B?R1lRK0FQV2tSYzFrajJ2bDdsN0ZUS1g1WEhUdkluV2liVFg0cHFrTWRtTW4v?=
 =?utf-8?B?OEJ1T3ZBa1RvL3M0TmRWa3NuSVdVaTM2NjdZcWdtM1p3RmtXR2ZnSnMvYzhC?=
 =?utf-8?B?anpUSHdTbjc4N3pDdG9leWhDYlNiYS9DZzVZLzhpSlhzZFIxOFJtZlQwZmgz?=
 =?utf-8?B?TFRxTFJ2T2NBTDdiaVpvdXJDK1d6L25YZ1dMSWE2N2RpdDM5NmdvZVlOajdT?=
 =?utf-8?B?dytFVXI4YjlldVNrT1ZUbnhIdVRwRmdnTk1xN3ZpQU42dVM2UUhCU0ROTjIy?=
 =?utf-8?B?Sys5bTV5UU1hZlR3aWRacWJ3Vi9EbjFaSU1wMFk2UVdpTUUyb3RhRnVQbDFi?=
 =?utf-8?B?bnU2TXNCT25pM0tEVGRGb0xPOFZsWlFEOCtVVG9BN0YrMEtUTURMaUJMcXZa?=
 =?utf-8?Q?Bj6BVfsSfp80voQ5Hw4HZXz79?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03de56e-b3fb-4e4a-0658-08dd98bf701e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 23:30:14.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8G7o1hqdgONiGJO9PBc0ye7ZBv0n14Wi8uoWl5kHcSRtFC11FLLmCf5ceSVOzgq7NL37ZEc5jEkYnlC1FowG2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001

On 5/21/2025 1:34 PM, Jonathan Cameron wrote:
> On Tue, 20 May 2025 08:21:18 -0500
> "Bowman, Terry" <terry.bowman@amd.com> wrote:
> 
>> On 5/20/2025 6:04 AM, Jonathan Cameron wrote:
>>> On Thu, 15 May 2025 16:52:15 -0500
>>> "Bowman, Terry" <terry.bowman@amd.com> wrote:
>>>  
>>>> On 4/25/2025 8:18 AM, Jonathan Cameron wrote:  
>>>>> On Thu, 24 Apr 2025 09:17:45 -0500
>>>>> "Bowman, Terry" <terry.bowman@amd.com> wrote:
>>>>>    
>>>>>> On 4/23/2025 10:04 AM, Jonathan Cameron wrote:    
>>>>>>> On Wed, 26 Mar 2025 20:47:05 -0500
>>>>>>> Terry Bowman <terry.bowman@amd.com> wrote:
>>>>>>>      
>>>>>>>> The AER service driver includes a CXL-specific kfifo, intended to forward
>>>>>>>> CXL errors to the CXL driver. However, the forwarding functionality is
>>>>>>>> currently unimplemented. Update the AER driver to enable error forwarding
>>>>>>>> to the CXL driver.
>>>>>>>>
>>>>>>>> Modify the AER service driver's handle_error_source(), which is called from
>>>>>>>> process_aer_err_devices(), to distinguish between PCIe and CXL errors.
>>>>>>>>
>>>>>>>> Rename and update is_internal_error() to is_cxl_error(). Ensuring it
>>>>>>>> checks both the 'struct aer_info::is_cxl' flag and the AER internal error
>>>>>>>> masks.
>>>>>>>>
>>>>>>>> If the error is a standard PCIe error then continue calling pcie_aer_handle_error()
>>>>>>>> as done in the current AER driver.
>>>>>>>>
>>>>>>>> If the error is a CXL-related error then forward it to the CXL driver for
>>>>>>>> handling using the kfifo mechanism.
>>>>>>>>
>>>>>>>> Introduce a new function forward_cxl_error(), which constructs a CXL
>>>>>>>> protocol error context using cxl_create_prot_err_info(). This context is
>>>>>>>> then passed to the CXL driver via kfifo using a 'struct work_struct'.
>>>>>>>>
>>>>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>      
>>>>>>> Hi Terry,
>>>>>>>
>>>>>>> Finally got back to this.  I'm not following how some of the reference
>>>>>>> counting in here is working.  It might be fine but there is a lot
>>>>>>> taking then dropping device references - some of which are taken again later.
>>>>>>>      
>>>>>>>> @@ -1082,10 +1094,44 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>>>>>>>  	pci_info(rcec, "CXL: Internal errors unmasked");
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +static void forward_cxl_error(struct pci_dev *_pdev, struct aer_err_info *info)
>>>>>>>> +{
>>>>>>>> +	int severity = info->severity;      
>>>>>>> So far this variable isn't really justified.  Maybe it makes sense later in the
>>>>>>> series?      
>>>>>> This is used below in call to cxl_create_prot_err_info().    
>>>>> Sure, but why not just do
>>>>>
>>>>> if (cxl_create_prot_error_info(pdev, info->severity, &wd.err_info)) {
>>>>>
>>>>> There isn't anything modifying info->severity in between so that local
>>>>> variable is just padding out the code to no real benefit.
>>>>>
>>>>>    
>>>>>>>> +		pci_err(pdev, "Failed to create CXL protocol error information");
>>>>>>>> +		return;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	struct device *cxl_dev __free(put_device) = get_device(err_info->dev);      
>>>>>>> Also this one.  A reference was acquired and dropped in cxl_create_prot_err_info()
>>>>>>> followed by retaking it here.  How do we know it is still about by this call
>>>>>>> and once we pull it off the kfifo later?      
>>>>>> Yes, this is a problem I realized after sending the series.
>>>>>>
>>>>>> The device reference incr could be changed for all the devices to the non-cleanup
>>>>>> variety. Then would add the reference incr in the caller after calling cxl_create_prot_err_info().
>>>>>> I need to look at the other calls to to cxl_create_prot_err_info() as well.
>>>>>>
>>>>>> In addition, I think we should consider adding the CXL RAS status into the struct cxl_prot_err_info.
>>>>>> This would eliminate the need for further accesses to the CXL device after being dequeued from the
>>>>>> fifo. Thoughts?    
>>>>> That sounds like a reasonable solution to me.
>>>>>
>>>>> Jonathan    
>>>> Hi Jonathan,  
>>> Hi Terry,
>>>
>>> Sorry for delay - travel etc...
>>>  
>>>> Is it sufficient to rely on correctly implemented reference counting implementation instead
>>>> of caching the RAS status I mentioned earlier?
>>>>
>>>> I have the next revision coded to 'get' the CXL erring device's reference count in the AER
>>>> driver before enqueuing in the kfifo and then added a reference count 'put' in the CXL driver
>>>> after dequeuing and handling/logging. This is an alternative to what I mentioned earlier reading
>>>> the RAS status and caching it. One more question: is it OK to implement the get and put (of
>>>> the same object) in different drivers?  
>>> It's definitely unusual.  If there is anything similar to point at I'd be happier than
>>> this 'innovation' showing up here first. 
>>>  
>>>> If we need to read and cache the RAS status before the kfifo enqueue there will be some other
>>>> details to work through.  
>>> This still smells like the cleaner solution to me, but depends on those details..
>>>
>>> Jonathan  
>>
>> In this case I believe we will need to move the CE handling (RAS status reading and clearing) before
>> the kfifo enqueue. I think this is necessary because CXL errors may continue to be received and we
>> don't want their status's combined when reading or clearing. I can refactor cxl_handle_ras()/
>> cxl_handle_cor_ras() to return the RAS status value and remove the trace logging (to instead be
>> called after kfifo dequeue).
>>
>> This leaves the UCE case. It's worth mentioning the UCE flow is different than the the CE case
>> because it uses the top-bottom traversal starting at the erring device. Correct me if I'm wrong
>> this would be handled before the kfifo as well. The handling and logging in the UCE case are
>> baked together. The UCE flow would therefore need to include the trace logging during handling.
>>
>> Another flow is the PCI EP errors. The PCIe EP CE and UCE handlers remain and can call the
>> the refactored cxl_handle_ras()/cxl_handle_cor_ras() and then trace log afterwards. This is no
>> issue.
>>
>> This leaves only CE trace logging to be called after the kfifo dequeue. This is what doesn't
>> feel right and wanted to draw attention to.
>>
>> All this to say: very little work will be done after the kfifo dequeue. Most of the work in
>> the kfifo implementation would be before the kfifo enqueuing in the CXL create_prot_error_info()
>> callback. I am concerned the balance of work done before and after the kfifo enqueue/dequeue
>> will be very asymmetric with little value provided from the kfifo.
>>
> As per the discord chat - if you look up the device again from BDF or similar and get this
> info once you have right locks post kfifo all should be fine as any race will be easy
> to resolve by doing nothing if the driver has gone away.
> 
> Jonathan
> 
>> -Terry
>>
> 

Ok. I understand. Thanks.

-Terry

