Return-Path: <linux-pci+bounces-14675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DAD9A1075
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EDF281EB1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADCB18891F;
	Wed, 16 Oct 2024 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a7c2u9XJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8D187350;
	Wed, 16 Oct 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099094; cv=fail; b=pUOqB3d9ih5cN+aZDIcnYv0uBEKB/vtdSHw3PdzHJJ+z1H5Uwty8rtBRaT1jbl/nrYa3oxPVCMdd/JQ27BMHBV9pZ/dHU2UTCzM5i8LAW/md6GlB6XbGCNZgQxfX4zKwony/W2jTKHLm+Icpg4tLiiurQDr+tgt0WwhU+Xak29E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099094; c=relaxed/simple;
	bh=Mf2NQxwEUzG0hNGDOICUGIwO0we3+sciI2oA06ytgeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lvn8Mo7s8HsezRp6CQpel1Lth1A0ZDfB36DvaQ8484vK940W0P5quPXzZ5jvbBxlYVWrfOxWlZQwkhKYw/a2BI0vQbswQvgq4qNXVJhmx0fBZ5PzpeLfhQ98eSl9JN1VTDcJwlohEeGUz246LWgcddFRybTbzWSg0XoeFSOPNbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a7c2u9XJ; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhUgy0o1ULuK4VdFZ5gkN1b0qi0xVwIx1oh4e8nSfxfsNJCwfeeqWctWGra8p/xX4Ht7JNM9xbYd9YINNW0lvUFQz7WsBx80XZ4w9OZ04dzdH0mwI/xgKfArB+DJUbIAoCsXg5pabncO0LCZMhpc8US1v4dCQeFQA/NKBSOtQgkc9M5JfDPMi3tPhh+AVWFsAAvO1uot8lusJFgQsaWPMA0kCLs7S95tgOJYAsEUdAt6bQE+kO48BR4NcrrZ1Bi4XO21AqRlLcSgp/XpEiqeCjPRj+wj6MyeWMSat843mbvbqxt9hpTwGBOdi6xyv4GZNdxHdAxyo15mEhvK+TrMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9vwyarPFx21K7HnD2vTsc3gLCvBS+sI6fYFVlnIzO8=;
 b=RUEn+fO5YbjtJg3JcIuVTYalJA5GV98I0ediAQvuRgnxp4SO9tBphBWmyC4ruTS+dEIk4Az+W2cO5DR3e+R58xfP+zXQBbvaUmCyYOBUHsydUX8WAx69xe8QpZedBJJihgyTKS6HlIdXfW5ak8UrAiXCylmlQ/4OiwiAP+bZQy9Vn5HJSLdM09IcqmU11RLe1hFZAKpwAzn2mka6eLvJIt9iLnFUFVf4q1GGYTl5tTVTRwFrU8TnKE6+0j9a4nhZpWDRYfxxHj/g+nQq/sCPClFv4DGNKLsIsbpGfSxv73qpurqVJ+Si57qLBgp/nhUcmHtn6jsUSpSHB1shvC0bJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9vwyarPFx21K7HnD2vTsc3gLCvBS+sI6fYFVlnIzO8=;
 b=a7c2u9XJ8xHdIZ79s42jLohxRavvkC5Sx3jH+Jx+LZOESDbX9yVc0YrHI1Bmm/SSO0Ueqx7ME54tPNUEBJsOV4Byxy0v+iozGEgvevFGZPNZb+5bWNr6rmabIz03er/3jISai0Pq5ke0H2Yfs8CJEyfA+vsVCKILLA61kb+tjUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 17:18:08 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 17:18:08 +0000
Message-ID: <b7e89c01-72c9-4e26-bd88-6cfcfdc78033@amd.com>
Date: Wed, 16 Oct 2024 12:18:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] cxl/aer/pci: Add CXL PCIe port correctable error
 support in AER service driver
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-5-terry.bowman@amd.com>
 <20241016172235.00001e65@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20241016172235.00001e65@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0121.namprd05.prod.outlook.com
 (2603:10b6:803:42::38) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 450c4e9e-be17-4e5f-9a10-08dcee068107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFFxN2Zkb1gxNC8wa3JqdHFPRno1K3BZMVJFcFo0eUNIWXgzSWlQU01xdklL?=
 =?utf-8?B?UzV4OCtKNE1Fd0g4VU9IL2p1RjFYaVMwVVpqbDdVZkthREUrOU5tVTRHVk9B?=
 =?utf-8?B?blFleEZQTGlqWE1sc3pvZlJnbjJSdEdJbm1zODAvN003Ymg1YWFJQlo0QTZT?=
 =?utf-8?B?TTVXRjFkU2ZYNjh6VU5JcnMrbzV4dmhiSHFYK3IxSGhYY1M3OFpFWWprY2sr?=
 =?utf-8?B?UHZSYjB0djYzVk02N2VKQThUMHM4K0pqUXVYdC8zbk92R3NNL0NMand5WFQv?=
 =?utf-8?B?M1BvMW9EOHljcFVoYkc3TU9QMWtLbWcwd2J5TzV1MmpOSS82QzEyS0FMd045?=
 =?utf-8?B?dVlEbS9COGIyclJzejFOcU56UWNsZ2hSY0hBZFJGM1JUem93amRWT3BoQWJV?=
 =?utf-8?B?TVc2WFhtTGFDc1lQT2ZLalJoTHp5ZklVblE0QjlBNnlFQWpzR1Y0dUJwcEpW?=
 =?utf-8?B?YUUyZmxDT1J6ZVo3VXJDL3JQOTVkRGhvN1BGbnBNZFZ5QUV2NVM3UnhjcGFZ?=
 =?utf-8?B?KzRubjZpbjloZXJ0b3RFZVJVOTVFQnNHYXoyQy9jemNPb1Q4ei9WRjFmN0ZL?=
 =?utf-8?B?bFcyb0s3MzNteGtHcTBKU2hsd1k2LzNJVEpYYU15a3lFTU5ObWYyTWdSb2lB?=
 =?utf-8?B?N3NRRUJyMEVVaFVJZXlrT3FUZDBrUDI0Uk1JalNXTmI4bGRmUWVWK3Q3MUN4?=
 =?utf-8?B?L3FadHVDZURvb29XU3lJSGFhZWVrZVBQVm5iOWJLOTIvY0dKb05WUkJ4RkhC?=
 =?utf-8?B?d1BveVlzYVBZa1A5cnpmU2F4VTdMbGtlemxvcWZkYXo1aUNxd1BkQm1Bdm5m?=
 =?utf-8?B?aTV2ZmtuWG1QdThHUHlKc0pyRG1iYU1PQzVDS2xWeDlEeUVISzFCMTNGRlYy?=
 =?utf-8?B?QjkyV0JBYUJqYStSRlM2ZjFJbFRKNkRFWUR1NTZUMEdtNm5QNU85QjhyRWto?=
 =?utf-8?B?dGdIQ1pSc0JXVml6U1FxMDJkRGdiVFk5L1ZSZU1uTGF3cDcrckVOalQzY1NX?=
 =?utf-8?B?QTFXd0YvNXNGQ1hWK3NLNmg2NkZMN2E2YmpWbHdMdkgxODlJTFZwOHRFN3hL?=
 =?utf-8?B?RjkwQmYra3pkWHRFaXdYSkZ0QVd5a1VMZ0tsQkZJMVZTZFg0Q2ZsY3c1aFBG?=
 =?utf-8?B?WVhBc3ArSDI5MGZOQVJJb2xLckFNNGJzdk9SVGJ2SEliMGpwNmtSL0RyS0dP?=
 =?utf-8?B?bEhBRjY1SVlSTkFKUnRKRGRHZXpDWlNPMUdTSUc1eEdYTUVxS3VHNS9TTXJG?=
 =?utf-8?B?dlplMERhZWVpZU5OWXRUdmE2ZkRYdmN3aklMZ3l4QUQ0OXc2SmJ3dXBHUFUr?=
 =?utf-8?B?VTgxNXJnc0dhRUdGd3dBNnpFa29YZlo5emFRY1J4WFRtUjBLVUtqSHJQSFhS?=
 =?utf-8?B?SS9wOE1VQ2dhTHhBbVlzeklETE9hYURLNGRPR0FvZkpRSEhKSlJLSFVnMDli?=
 =?utf-8?B?UEFCeU5YejdCeCtiUmJ5WGdMSUJEQ1hRQkQrelhKWFB5L2ZZNDR1NXY3ZjFK?=
 =?utf-8?B?WWtxVDJJYUFPbnQ0ZjZGZmlZQmlCalYxVHF4aGtqRHRwM2JjMzF4NVo1THk5?=
 =?utf-8?B?QUNVT0c0R050ZkNuWWdLNTExUWlidkF2TDVVM0FhNDdrenRGQUtaZUs0Qi9E?=
 =?utf-8?B?UWVOMU5WVVo2Rmo0KzFrSEs1bUZrWlowWnhTdmFNTjYrRzM0WGJsR3lGcW9a?=
 =?utf-8?B?elJxY0ZsZ2FiMlF6a2hDdFcvSHJxdkZ0WFB0MVBNeDNXNS9ZQUdYdWN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlJ2aFZkSDJPZUlmMHoyb29KbjMxL1RKNTBCQXJON1QzbC82dHZZWUVlcWZP?=
 =?utf-8?B?Z0U2WCt5UUdKaDhHcDdXTWg2MjZNdHc2REc4TiszbkNpVUJCT2oxY2gvcDBJ?=
 =?utf-8?B?SWdIeGhrM05adGJldE9lb2E5bUtlb3F1dnBPd1VyanFVUEMvSXREclIzV1pj?=
 =?utf-8?B?L2ZRMVFBeHJ1Z3BHQThqSnRKdnBFU29wWHpRZEJXeEg5WCt0RWQzSVcveUtk?=
 =?utf-8?B?dkZDNWxpMVBHVkp4SmJWUUZFd2k1K2hWbmxoRTEyM0dnWHhmVUphYUd6LzRW?=
 =?utf-8?B?RTdDN3ZkenVKU0JhakRVcUVFbnRUM1hGYitrME1OWGlFY2swZ3BteW8zVWhs?=
 =?utf-8?B?V0h2NGNVbWptNjNHWHFpVnZ1MklYcW9zWFYwNnBWcXdEZDhRb3czWU1za3d1?=
 =?utf-8?B?SDNZQ1FHMVZUa0p4WnV6N3BnemtWRkJwdm5qcTRicVhwR0ZOdFlWR2dzUDdk?=
 =?utf-8?B?L3NIRnQ1c2VGNEl1R3BhcEhmYlU3K2hMZDJJWXVwSHQ1T29tSkxlZ0daZTcr?=
 =?utf-8?B?NldjOFVjNlBYS3dJQVNFbGlEZUxTQi90enVvSURTbWlZaDNXSjNkT0crVE04?=
 =?utf-8?B?eGwzOXpHN1VBdzA2c3YrMCt5OEczLzFOeHdpVkFpMmxzUXA2TEhaM3RhVklt?=
 =?utf-8?B?MXZOR1V4OU9ZZjgzYUlvUTYvY25QcjNzeWYxV1hUR3Y1eFhtT0p1eUczUDFD?=
 =?utf-8?B?WDVwYVZWc1NYK29UOXlOK3hNWUhJaGx0TEo0Qmx3VnVnaGYwYzlKVXRZQVdv?=
 =?utf-8?B?aG9KZXBnSm5wWmhXeEtSU2FBL2ZWNEZCZXpzSDhYK2NBSllVTFhwNFNTdHpa?=
 =?utf-8?B?WmQ0YVNJaFhCeEM0amFiOG8rVkdyRVNhWk1ONTRkbVlYbGY4RUx0SnFDcDRV?=
 =?utf-8?B?dU9rK0VrbUdtdGRnUmtKSmpTa0hPM1Y4RkUrZDhXMkUwQ1BnYVdDL09IVmQ0?=
 =?utf-8?B?ZkhPaHFCYzNnMVZKZnBNSFF0bHkvUStjNWo2NU1Xc1lZbFdFR3J5TXA1TVBQ?=
 =?utf-8?B?MXBaZEV4a0xzNVIrUndWOVNKMlhhYzMvV3RjWTBGaXJ2SGwvQmJXckFpb3pC?=
 =?utf-8?B?RVFBTDN2OFMyY3htRVZnc1JpN1FqTjc1MnI5M1NndTlOdDNmY1NOOGVacDQy?=
 =?utf-8?B?NUU5a0tyUElmdG9KVTR1bFAwM0xERWlhS0FlY0VZL2VhdEk0Y04vTjJyVFAw?=
 =?utf-8?B?Y3J4RnNjZm9Pc2NyODkrYVdoVldTSDlHMkxrV2ZqWVVSQk5wSmcwQnMrUXFS?=
 =?utf-8?B?V3NkajZ5TUp1b09DaHB1ZTlRWGZHSjJsdFViTzRMR204YU5iU0hmZm1OaWt6?=
 =?utf-8?B?TFhiajloK0VJV1JmWkgveTF1dU5jcURaU0R5R09ON0RqM0NiWjVpS1VtWjlh?=
 =?utf-8?B?Sk1zdnRxNFJiZnVxMUd1SVJrVHVob09GZ2JibXQ2OG1ScmhHdnJrRHkwSmRT?=
 =?utf-8?B?Z0R3MnhRYzdkZ1NvOSt2dWZZS3gzUGl2aDR5cFVWMkxxTDk3YytpZkRQbFJM?=
 =?utf-8?B?Z1NnT2NiemZobW1FdDB5S2hkU3ZVdXVkRDdBZmxTNVRGSVhPTXJzaG8yR0ph?=
 =?utf-8?B?eWM5ejBVYjJmNzIvQkFSbGpLajByNlNudkFFdHNMcmM1U3hRSDVvdVJ4ZWdJ?=
 =?utf-8?B?QUlCV1pFM085eklhYVQ4NFhjM20wbDBtRkU3NSt6bHZGVHhyTWlNUFBXTXVx?=
 =?utf-8?B?N2JZdFh6VVpPSjhaMncyblQyZUxrZEN5TzU3eG96dmRSUXUrY3RpR204dm1q?=
 =?utf-8?B?OXl3emg1Y3pMdDBHbUllWXNJMUxBQnI5bnI0S2RZYmhqeHB1T2EraE5MNXBU?=
 =?utf-8?B?Ny91UjN4MGtYdklDdXIxdWZWUkVzRlNSSExVcHRwSDNOV0ZYUFJtNlczZk1M?=
 =?utf-8?B?UzVId3pUbWgydUgxbUk0S2M3N1E0dG82TTlxQmk4TTRUZTVOYVR3SlB0UUc3?=
 =?utf-8?B?OVdmc3ZkZXlWRnpFT0NiVVVVaExjdFJoSERGT2w2d2tOQVE4TnlaRFlBUkg3?=
 =?utf-8?B?ak04M1JnMFZZd1NRSFZ4M0lIMlVPRk54VzhqQ3NqTjNXWWZpWm81djZjWVlF?=
 =?utf-8?B?QU5pNDJVQlN1UUNpRWZVVnhlWG9pd2RnazZYeDVWdXRjREExc2tFWW0vRitG?=
 =?utf-8?Q?VMgli6oZUAwmKwBCz7h9l7MwJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450c4e9e-be17-4e5f-9a10-08dcee068107
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:18:08.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6yK8HRWDe4m5ATeoo2WVjC2n5UMsQ+Uu1Tvhx7BWMfMZUIdeqXB5pqI3Xg1sHvYAkhuJ56Oui90CxhJ4chxdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234

Hi Jonathan,

On 10/16/24 11:22, Jonathan Cameron wrote:
> On Tue, 8 Oct 2024 17:16:46 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The AER service driver currently does not manage CXL PCIe port
>> protocol errors reported by CXL root ports, CXL upstream switch ports,
>> and CXL downstream switch ports. Consequently, RAS protocol errors
>> from CXL PCIe port devices are not properly logged or handled.
>>
>> These errors are reported to the OS via the root port's AER correctable
>> and uncorrectable internal error fields. While the AER driver supports
>> handling downstream port protocol errors in restricted CXL host (RCH)
>> mode also known as CXL1.1, it lacks the same functionality for CXL
>> PCIe ports operating in virtual hierarchy (VH) mode, introduced in
>> CXL2.0.
>>
>> To address this gap, update the AER driver to handle CXL PCIe port
>> device protocol correctable errors (CE).
>>
>> The uncorrectable error handling (UCE) will be added in a future
>> patch.
>>
>> Make this update alongside the existing downstream port RCH error
>> handling logic, extending support to CXL PCIe ports in VH.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Minor comments inline.
> 
> J
>> ---
>>  drivers/pci/pcie/aer.c | 54 +++++++++++++++++++++++++++++++++---------
>>  1 file changed, 43 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index dc8b17999001..1c996287d4ce 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -40,6 +40,8 @@
>>  #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
>>  #define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
>>  
>> +#define CXL_DVSEC_PORT_EXTENSIONS	3
> 
> Duplicate of definition in drivers/cxl/cxlpci.h
> 
> Maybe wrap it up in an is_cxl_port() or similar? Or just 
> move that to a header both places can exercise.
> 
> 

Ok. I'll move the value '3' into the function call rather than use a #define.

>> +
>>  struct aer_err_source {
>>  	u32 status;			/* PCI_ERR_ROOT_STATUS */
>>  	u32 id;				/* PCI_ERR_ROOT_ERR_SRC */
>> @@ -941,6 +943,17 @@ static bool find_source_device(struct pci_dev *parent,
>>  	return true;
>>  }
>>  
>> +static bool is_pcie_cxl_port(struct pci_dev *dev)
>> +{
>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
>> +		return false;
>> +
>> +	return (!!pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>> +					    CXL_DVSEC_PORT_EXTENSIONS));
> 
> No need for the !! it will return the same without that clamping to 1/0
> because any non 0 value is true.
> 

Ok

Regards,
Terry
>> +}
>> +

