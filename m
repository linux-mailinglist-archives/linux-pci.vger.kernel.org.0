Return-Path: <linux-pci+bounces-17985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D839EA889
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 07:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4DA1883708
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 06:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF0022617B;
	Tue, 10 Dec 2024 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z7aU4CdU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939A5226185
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810904; cv=fail; b=NBVvouRyoycWj0yy1/+vJhJUNKBK0Q2GnACeUWjSdjIqZ1Cq6+8OpSSwT1CJZ+OLgpdOq5re+wHBFhzsyqc34Cu5WMNPpb43XAUM+WtPYO2Si1GsZpvzEc/NQKFT5p5icYipJvZpd6x85Do9jQaIMCxGNwQ1gof7aThRPfGE6wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810904; c=relaxed/simple;
	bh=zuzEbb/9JWu3vMckuBzQVZnb1GdnyfxWS2oZ3SwwoF4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XwtfFROV4HBca+DLBBcGwNJRQzwuSra9vvMJtwi12Tw7iozpMQnbeyN+yg5zoec8qpfUmLqaL2/TZad/A3T3gwF0mMlEkHGMI3h42Y3pypsIZXYbct5x3c1zfN7URmk9lvUu4gsxf5ceDO39n/ZXYB71SHpmyRHKJAL3at/ATnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z7aU4CdU; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO3TnelBWA3vLN+SkAf2BArTxWTl81iquOfV4Ge52j0yaWQewoJ0uHYfLqWBIG7Q7gk5ShD3y82iuv2JE9efgMbqb4n0A2Lof8uLh0ytUvWlUS3BITqlqSAUznARXmXF7hhc7aN3anJOGAQqACmGxtry4WEGMkeCYeQN6kF6WyjFz9xhVFDhCi3J0pX3JwWvKF+Cb2oaZ7xpYKn60pxbXm4iSSskuMT8AfKtKlRVS63JQIoStlrnEok47j/rxobETc4dg1u0+x9buWTGtrzdd2mVI4sTNZpWV5Pqs5091FlbVspmX8iAH2mmDGX1e4LjuSUd48keuOJTn9NQoU2AYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN2xxllLsP9CZ7lDYzm1yYD6gPfNS8e3SUNLsuZ6uSM=;
 b=EUhAcX7FJpmqIZ4wvA9XGT2WOPpbb8hNP/bNQuVNdv9d/oBX1GakVR85deh+AQtY4GYGSAzDr/w/JL8HrzJbf14ItOfjw7gAf5qV410m7ISVA28SDKc/t5pypcOSBFqLnx3KRUoi9lBK+Xx8g0Kyt/5puNrqth+lc4g0ftku9wd0txPUNYUH2n+o6s03YOE+gMwiiCg6Vs5tJbTInHJPuryX1+XNKs1hiWFib3KVbf5xdijUsZOf0EHirMOHGXUmpsOBSVNtKqGeg6Yd916RioxnCELyfg+4iJeiUAH2RNpre9G7ZjfZ5gk5YzXAvRF6/hnAGaMMzKv0fBqd3+W2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN2xxllLsP9CZ7lDYzm1yYD6gPfNS8e3SUNLsuZ6uSM=;
 b=Z7aU4CdU1QDj1UIkgLPRdm2yLgem6x67qLZMNj7hxcQrXG0xrI36KBb7eN5enKFORGp93/9FGHybGIAFmjMW/yRGM//rO4fFOOf0HEBdDy8OupWmyDHOSiH8V3dW4QrtggHOWCxLLUD+kBLaDQvi9ip1tt8/19AAYTbHr/rnmWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Tue, 10 Dec
 2024 06:08:17 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 06:08:16 +0000
Message-ID: <af5241f7-da8a-4ec9-9952-7df8c8a3668f@amd.com>
Date: Tue, 10 Dec 2024 17:08:09 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 01/11] configfs-tsm: Namespace TSM report symbols
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Yilun Xu <yilun.xu@intel.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Sami Mujawar <sami.mujawar@arm.com>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343740180.1074769.15809313632664416174.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <173343740180.1074769.15809313632664416174.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYAPR01CA0021.ausprd01.prod.outlook.com (2603:10c6:1::33)
 To CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 737f33f5-95f1-414c-c511-08dd18e1099f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm51bFRYREtXZE5yUDVlTTBJb1pFMWtwUWlUeTcxb3JCUUcweHRNdlBlL2Vl?=
 =?utf-8?B?V3NvTVh0VTk3Y1RVbzBYbzJVSXg4djNSUThHMVNiN0xobXBFWlRXdVBtMWVR?=
 =?utf-8?B?eDViSmtSOWtialBsRUROclZDL1BueTJwa3ZxT2dLT0RPZHRSMU9LU2lKZHJq?=
 =?utf-8?B?cm92cUcrYk45TkRZaDBxMzhRN2JNUHFuZlM4a0hnekpxNmhnSUJ0OUtmS21V?=
 =?utf-8?B?RkY2MFd5VDliNEszMWNBd3RRNHZPak5BSG1TeXVVZzZuR2JUUmRlQ0N5VnV0?=
 =?utf-8?B?VlQ5RHExRGtQY2dsNE1ac3VkWGM5WWExemVRd2JjWmpQR3RMenpZMW9NejNO?=
 =?utf-8?B?cFRhTStNeW5uSThoWHNPMkVFYk42dmptSkdCK05zZzRBV1EweXBiYUxWRDND?=
 =?utf-8?B?aDAxbjR1UmtSeFlTU2NNMlIydTVWUmhhMnJGblBRZklzZ0xSVjJ0eVJ5cElS?=
 =?utf-8?B?ZG50aFFncitFL3ZZdU1sMjZoU2t0U0lUOUQzYkRRV0syTkxVWWRMMHRwY1Fn?=
 =?utf-8?B?TGRhWmxhQ0hObVgwcU1sRU9kM3I1WExqbitVcFA4QWR1UGFFOGRHaytDWU9r?=
 =?utf-8?B?djU5Q0g3a2RTUjZpWUdaemJyWHpZNVUzL1dKZVJXZW1sSHl6RlhCU3ZLdGNz?=
 =?utf-8?B?UGJMVUpUdUxnc3NxRDZGdDBqRm1seW1aS3FoSmg3NnlLSWYwMTMvUlliVUVL?=
 =?utf-8?B?TFNGZ1BpY2hJc3NPYkplbzhQVENuejlBWFNFVmRLQkc1UDRFS3dnd1Fmall0?=
 =?utf-8?B?WjRVcDVzUzR6ckI1ZHZaMnhWMHpTQVF6VEJoUUtqT1RQZ3h6aHQ1R0h6V01u?=
 =?utf-8?B?VHFhQSs5eUJEdGZjbjZYS2JIUjNKSlR0c002a3NpN3ZpTHMyd0lPMzUxUURp?=
 =?utf-8?B?YlBjQnNxblVNVXk4U2lZN2NTSHF6VHBqaHBJWVZzS1NUZ09lQUVRQnNQeDBr?=
 =?utf-8?B?dXFlVG5PNFRISDF0NTJ1bHZjNmowWXMxNzV2UEJnK3hCZlRBQ2YySUFOZGVB?=
 =?utf-8?B?S29CQ1RTcVNMcTQ0QzZzWlUvVFBhcEJFZ1FyeENwdHRhc0Fub0RnVVNBNnVG?=
 =?utf-8?B?VGJaTWU2OUYyRmVOS1dTT0VLRThqakF6TGUyUzkvL3J1cWhERUdHMGFOSWVF?=
 =?utf-8?B?aEpUR1cxTWlLdEJuUTcxY0RWd3QzbzlGVFNWdjFycFZ4YXRDMTJSVndCRit0?=
 =?utf-8?B?VHp6NmNkVS9UbEc0NGFlSzY5dTF6YzU2UzNmQ2FRNFdsZkhZWEpQZ0NjWVY1?=
 =?utf-8?B?UWhqb3BOVmhJY2RHL0h5Z0Z1UTVaYUUvMmJYRUlVQytMUmdzQ1VvZlR4OUtX?=
 =?utf-8?B?bEpLYjUyMG1QMjY4NDVmVW5aN01lK1JXbTF2VzdBeXkxN0c1UGJ6US9rS1p3?=
 =?utf-8?B?bVdJcjAvcld4YXFKRnVzWi9UbWFCY2M5cHYzTDBGVVhPQitzSEJBa3BVTlVI?=
 =?utf-8?B?VlR4VmF6QmJNZFVMMnZpdGhWaFk4dkExcXVtRnJoalkxWlBaTDVOaUhESS83?=
 =?utf-8?B?VzJYdnhkWnJPVHBpM2RHWHZGc09Na3NueDVkcGg4UkduTnloYXozNEtuZXVv?=
 =?utf-8?B?aERMY3FkL2VCdWUxOWQzUUwxdGVKTHVmWnRlS2d2OHU5ZlRmbWJZa3lBZVNI?=
 =?utf-8?B?d1dVTXNWTHpmTkRqbnB3M2VJN1AyT0lBVm9JT1lENzRjNldUNWl0di9HR0lu?=
 =?utf-8?B?Z3BXeW9zMi9JbXNqMnk1SE9sUlI0eTNXYXF3c1dTaHhFTFNoM3RDajM2bGpz?=
 =?utf-8?B?eFdHM1NCeUlYVVJ3SFY1SHZlejRsTXJiT2tJRWZwZXYvalFyeWpCek5jWlYy?=
 =?utf-8?B?cko5SllzQWRUZWg3MEJHUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0dnL1pUZjhwdHBkT2lXeTg3Y2thUXRvbXphSGJjMFhoU1lOb0twdy8wTE5D?=
 =?utf-8?B?U1VnbUdmcVhtVUJHRmt0VFdOUzlmL1ZWeklXelB2d2JtT1BzL1BOMWkrRkx6?=
 =?utf-8?B?cGlOeHFFaGQxUVJ0dkt5ems4TTRBWTJXV1lLTnNTVEVmalgyeDduQVRnSHlN?=
 =?utf-8?B?NWFOT0ZFbEhnNnZrY0c4S1V0SFRIQUJNWjQyM1d3bzJmTGVOWWhPa2Foc3lk?=
 =?utf-8?B?VzY4RWtXWWQzTGpseGpmRlN2N04yeEY2QVJuTkZTUXRsUHpsaGs0a0dFTldD?=
 =?utf-8?B?amRsUTdhTCt4WUl0TXlXSWdPbmtiTzBuOTJIUGZGczd3S2dPQWloZlFOVlRw?=
 =?utf-8?B?Z1FJM0lKRnhlNVo0M1dRWG90SlY4UE5raGc2UFY2Q3NRZk1Ic1pYa3B6K0pT?=
 =?utf-8?B?Vk5WaGNYRCtmTVZsNE5FRzI2OExTaThOdGszR2d1VnBkbUUzSy9GeUxlTzRJ?=
 =?utf-8?B?eXgrR1VmYWliN29oQ2VsUFRmRkhCZFNnZXQ4VU1ZMUR2ai8zRnEzcU1CRWEr?=
 =?utf-8?B?VXFzM3cxOFM2czRreFMwY2o5d2ViRGZHNTQ5SC82blhjVEtsbzNGYTE5VjYx?=
 =?utf-8?B?TnFJMERxcnNxcy9mQWJEM0U0ZEhHV0VKUFF6eDR4NmI5OTNDb2hXUlZZNDNZ?=
 =?utf-8?B?TEVYdE5LbW1qaFBxZWFrcndGdG5mSy9zWXNlWVJ6M2hxQis1My8zc1QwV1po?=
 =?utf-8?B?VEpXdk9ML2ZwNyt4c2Z6T0ZEQzF4a1o5REkxeEF0L2hKbnRXMHp1VUFJU1lG?=
 =?utf-8?B?eXo2Q1NkOElLQ1g1TWlvaUcxeFVGc3EvWVZ1U2tiWVg4WW1CaWZlWUxhTWRX?=
 =?utf-8?B?aHhoUEI3VEdSckYwcElITXFTREZBM0tjNzNVMDROTUFuTHhoQjliOVEwVzA2?=
 =?utf-8?B?ZDg0b0NUQTJjS1lBSXQ0amVmWUdNWkFhaU9xSmVzNVRudHRkY0VwdHRCOHNZ?=
 =?utf-8?B?MEtLQWVqNUFQd2lYcU9aZXpXak55U0luZDhyK3FhVHp5c2g4OExTdGQvOTBE?=
 =?utf-8?B?dkZYSXJ2d3E0TXp1TmxzSVFCYVJFcTRtaTIvcXM1eEFOYW0zZlR6VEU1Wkw3?=
 =?utf-8?B?OFpyYWFJNCswOFZIbW1iVVpWUWZkZC9QNnM1K3lzTFBIaHJUZ1c1bXNIL1lH?=
 =?utf-8?B?VTUxRVR4TUUwTTIxRm1QaGIrK0ptcTN3dm41QUVYQXpsODRyVXAwVzByWWcz?=
 =?utf-8?B?OXVGRmE2YUc5RkdBVzVZQXpJcllISVVHcFZJMDg5RzQ0WFN4aERVeGRJa0dt?=
 =?utf-8?B?c0tSR3N4aFgyYlNMbDRSNHMvV2xFeGlwdkFFSnNjMFc5b1JhdDdyem4xSkda?=
 =?utf-8?B?d3pMRHFMZDJDQmpKcGFKdnh1SUFRVXVyc1F0QkVLWmQ4SFM5ZUtmOHo1cndY?=
 =?utf-8?B?WXZNZjV3RjE2cER3ZTA3ZFZlZm5seE5hYy9rRFc0RW1PbDhMTlZ3VzFzamtI?=
 =?utf-8?B?RWlQUjB6d05jWWpYT2cwREFBN2ZEQlVDOTJyb2Z0c2RaN3prU01DQVhaUHRK?=
 =?utf-8?B?V0k1TWRzSnF2SmNqcmd1Rk5EK2tuZWxLbGk4SXM5dnJrMElIZUx5d1NJd2dR?=
 =?utf-8?B?dUxiSVVyY2lhQjgrV2J5K2I2SWZ5RzZlcXF4c3Z5SW0zdy9CTndhWE1lWWl4?=
 =?utf-8?B?ek9hYmpKNUw1NjhFSmdacFdqVUZybXBZV2IvbGpzVzI2c1pSRWFVdXpYVjlt?=
 =?utf-8?B?aDhOcWhkRG1sVjlranhVUHNvSUhTUmV4emhzcGsyVUlZaXh5M2N1THJUcyth?=
 =?utf-8?B?dFg4Q0trZUt6NmhCelJ3dzVIUmVnbHp0N2hIWkJzRXVSQzZ0SFdHUXhxMGQr?=
 =?utf-8?B?elU5ZU5GaWQ2S3dmVXNPUTgxdHNiYUVNTFlxc0ExNUdTRXljTW1tcnFMWUlm?=
 =?utf-8?B?Z0hvVnA0NXNkR3NNMFlxbnB3OTkvQVJWUCtTN0d6b0lVQW5EUjJsQ2xSUldj?=
 =?utf-8?B?NzFFbVBMekVnR0NOSGJGdm55aHJwb09Jc0RSVXBpcWxTMDYxYUxrbXdJRXJV?=
 =?utf-8?B?RGdCTzFCMkFUTEVjcVNocm8zL3BCZ29wdldsRk8va0phRGdqVVVFZlMzbU4x?=
 =?utf-8?B?QjhaV25nd2FVN0xDQjdmVGlWRGdhKzEzOGcwTGYyVE9EeG1Rb1U5RUIvR2xV?=
 =?utf-8?Q?uD8S16pVkfsOz8oJYpfSmCYas?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737f33f5-95f1-414c-c511-08dd18e1099f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 06:08:16.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02Dq78sLYIlVDSiG721PNBhOQReyWZcclb1ZGHUXhyi87lKG9DMe/W3QOFuAXFrXmtaNOPe+YDhzPnZivhVkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612

On 6/12/24 09:23, Dan Williams wrote:
> In preparation for new + common TSM (TEE Security Manager)
> infrastructure, namespace the TSM report symbols in tsm.h with an
> _REPORT suffix to differentiate them from other incoming tsm work.
> 
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Sami Mujawar <sami.mujawar@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alexey Kardashevskiy <aik@amd.com>


> ---
>   Documentation/ABI/testing/configfs-tsm-report   |    0
>   MAINTAINERS                                     |    2 +
>   drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |    8 +++---
>   drivers/virt/coco/sev-guest/sev-guest.c         |   12 ++++-----
>   drivers/virt/coco/tdx-guest/tdx-guest.c         |    8 +++---
>   drivers/virt/coco/tsm.c                         |   32 ++++++++++++-----------
>   include/linux/tsm.h                             |   22 ++++++++--------
>   7 files changed, 42 insertions(+), 42 deletions(-)
>   rename Documentation/ABI/testing/{configfs-tsm => configfs-tsm-report} (100%)
> 
> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm-report
> similarity index 100%
> rename from Documentation/ABI/testing/configfs-tsm
> rename to Documentation/ABI/testing/configfs-tsm-report
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e930c7a58b1..53f04c499705 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23842,7 +23842,7 @@ TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
>   M:	Dan Williams <dan.j.williams@intel.com>
>   L:	linux-coco@lists.linux.dev
>   S:	Maintained
> -F:	Documentation/ABI/testing/configfs-tsm
> +F:	Documentation/ABI/testing/configfs-tsm-report
>   F:	drivers/virt/coco/tsm.c
>   F:	include/linux/tsm.h
>   
> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> index 488153879ec9..63b9fdb843fa 100644
> --- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> @@ -95,7 +95,7 @@ static int arm_cca_report_new(struct tsm_report *report, void *data)
>   	struct arm_cca_token_info info;
>   	void *buf;
>   	u8 *token __free(kvfree) = NULL;
> -	struct tsm_desc *desc = &report->desc;
> +	struct tsm_report_desc *desc = &report->desc;
>   
>   	if (desc->inblob_len < 32 || desc->inblob_len > 64)
>   		return -EINVAL;
> @@ -180,7 +180,7 @@ static int arm_cca_report_new(struct tsm_report *report, void *data)
>   	return ret;
>   }
>   
> -static const struct tsm_ops arm_cca_tsm_ops = {
> +static const struct tsm_report_ops arm_cca_tsm_ops = {
>   	.name = KBUILD_MODNAME,
>   	.report_new = arm_cca_report_new,
>   };
> @@ -201,7 +201,7 @@ static int __init arm_cca_guest_init(void)
>   	if (!is_realm_world())
>   		return -ENODEV;
>   
> -	ret = tsm_register(&arm_cca_tsm_ops, NULL);
> +	ret = tsm_report_register(&arm_cca_tsm_ops, NULL);
>   	if (ret < 0)
>   		pr_err("Error %d registering with TSM\n", ret);
>   
> @@ -215,7 +215,7 @@ module_init(arm_cca_guest_init);
>    */
>   static void __exit arm_cca_guest_exit(void)
>   {
> -	tsm_unregister(&arm_cca_tsm_ops);
> +	tsm_report_unregister(&arm_cca_tsm_ops);
>   }
>   module_exit(arm_cca_guest_exit);
>   
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index fca5c45ed5cd..7eedde61589c 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -701,7 +701,7 @@ struct snp_msg_cert_entry {
>   static int sev_svsm_report_new(struct tsm_report *report, void *data)
>   {
>   	unsigned int rep_len, man_len, certs_len;
> -	struct tsm_desc *desc = &report->desc;
> +	struct tsm_report_desc *desc = &report->desc;
>   	struct svsm_attest_call ac = {};
>   	unsigned int retry_count;
>   	void *rep, *man, *certs;
> @@ -836,7 +836,7 @@ static int sev_svsm_report_new(struct tsm_report *report, void *data)
>   static int sev_report_new(struct tsm_report *report, void *data)
>   {
>   	struct snp_msg_cert_entry *cert_table;
> -	struct tsm_desc *desc = &report->desc;
> +	struct tsm_report_desc *desc = &report->desc;
>   	struct snp_guest_dev *snp_dev = data;
>   	struct snp_msg_report_resp_hdr hdr;
>   	const u32 report_size = SZ_4K;
> @@ -965,7 +965,7 @@ static bool sev_report_bin_attr_visible(int n)
>   	return false;
>   }
>   
> -static struct tsm_ops sev_tsm_ops = {
> +static struct tsm_report_ops sev_tsm_report_ops = {
>   	.name = KBUILD_MODNAME,
>   	.report_new = sev_report_new,
>   	.report_attr_visible = sev_report_attr_visible,
> @@ -974,7 +974,7 @@ static struct tsm_ops sev_tsm_ops = {
>   
>   static void unregister_sev_tsm(void *data)
>   {
> -	tsm_unregister(&sev_tsm_ops);
> +	tsm_report_unregister(&sev_tsm_report_ops);
>   }
>   
>   static int __init sev_guest_probe(struct platform_device *pdev)
> @@ -1062,9 +1062,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   	mdesc->input.data_gpa = __pa(mdesc->certs_data);
>   
>   	/* Set the privlevel_floor attribute based on the vmpck_id */
> -	sev_tsm_ops.privlevel_floor = vmpck_id;
> +	sev_tsm_report_ops.privlevel_floor = vmpck_id;
>   
> -	ret = tsm_register(&sev_tsm_ops, snp_dev);
> +	ret = tsm_report_register(&sev_tsm_report_ops, snp_dev);
>   	if (ret)
>   		goto e_free_cert_data;
>   
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index d7db6c824e13..66ea09207a7c 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -163,7 +163,7 @@ static int tdx_report_new(struct tsm_report *report, void *data)
>   {
>   	u8 *buf, *reportdata = NULL, *tdreport = NULL;
>   	struct tdx_quote_buf *quote_buf = quote_data;
> -	struct tsm_desc *desc = &report->desc;
> +	struct tsm_report_desc *desc = &report->desc;
>   	int ret;
>   	u64 err;
>   
> @@ -299,7 +299,7 @@ static const struct x86_cpu_id tdx_guest_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>   
> -static const struct tsm_ops tdx_tsm_ops = {
> +static const struct tsm_report_ops tdx_tsm_ops = {
>   	.name = KBUILD_MODNAME,
>   	.report_new = tdx_report_new,
>   	.report_attr_visible = tdx_report_attr_visible,
> @@ -324,7 +324,7 @@ static int __init tdx_guest_init(void)
>   		goto free_misc;
>   	}
>   
> -	ret = tsm_register(&tdx_tsm_ops, NULL);
> +	ret = tsm_report_register(&tdx_tsm_ops, NULL);
>   	if (ret)
>   		goto free_quote;
>   
> @@ -341,7 +341,7 @@ module_init(tdx_guest_init);
>   
>   static void __exit tdx_guest_exit(void)
>   {
> -	tsm_unregister(&tdx_tsm_ops);
> +	tsm_report_unregister(&tdx_tsm_ops);
>   	free_quote_buf(quote_data);
>   	misc_deregister(&tdx_misc_dev);
>   }
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index 9432d4e303f1..bcb515b50c68 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -13,7 +13,7 @@
>   #include <linux/configfs.h>
>   
>   static struct tsm_provider {
> -	const struct tsm_ops *ops;
> +	const struct tsm_report_ops *ops;
>   	void *data;
>   } provider;
>   static DECLARE_RWSEM(tsm_rwsem);
> @@ -98,7 +98,7 @@ static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
>   	 * SEV-SNP GHCB) and a minimum of a TSM selected floor value no less
>   	 * than 0.
>   	 */
> -	if (provider.ops->privlevel_floor > val || val > TSM_PRIVLEVEL_MAX)
> +	if (provider.ops->privlevel_floor > val || val > TSM_REPORT_PRIVLEVEL_MAX)
>   		return -EINVAL;
>   
>   	guard(rwsem_write)(&tsm_rwsem);
> @@ -202,7 +202,7 @@ static ssize_t tsm_report_inblob_write(struct config_item *cfg,
>   	memcpy(report->desc.inblob, buf, count);
>   	return count;
>   }
> -CONFIGFS_BIN_ATTR_WO(tsm_report_, inblob, NULL, TSM_INBLOB_MAX);
> +CONFIGFS_BIN_ATTR_WO(tsm_report_, inblob, NULL, TSM_REPORT_INBLOB_MAX);
>   
>   static ssize_t tsm_report_generation_show(struct config_item *cfg, char *buf)
>   {
> @@ -272,7 +272,7 @@ static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
>   			       size_t count, enum tsm_data_select select)
>   {
>   	struct tsm_report_state *state = to_state(report);
> -	const struct tsm_ops *ops;
> +	const struct tsm_report_ops *ops;
>   	ssize_t rc;
>   
>   	/* try to read from the existing report if present and valid... */
> @@ -314,7 +314,7 @@ static ssize_t tsm_report_outblob_read(struct config_item *cfg, void *buf,
>   
>   	return tsm_report_read(report, buf, count, TSM_REPORT);
>   }
> -CONFIGFS_BIN_ATTR_RO(tsm_report_, outblob, NULL, TSM_OUTBLOB_MAX);
> +CONFIGFS_BIN_ATTR_RO(tsm_report_, outblob, NULL, TSM_REPORT_OUTBLOB_MAX);
>   
>   static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
>   				       size_t count)
> @@ -323,7 +323,7 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
>   
>   	return tsm_report_read(report, buf, count, TSM_CERTS);
>   }
> -CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
> +CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_REPORT_OUTBLOB_MAX);
>   
>   static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
>   					    size_t count)
> @@ -332,7 +332,7 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
>   
>   	return tsm_report_read(report, buf, count, TSM_MANIFEST);
>   }
> -CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
> +CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_REPORT_OUTBLOB_MAX);
>   
>   static struct configfs_attribute *tsm_report_attrs[] = {
>   	[TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
> @@ -448,9 +448,9 @@ static struct configfs_subsystem tsm_configfs = {
>   	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
>   };
>   
> -int tsm_register(const struct tsm_ops *ops, void *priv)
> +int tsm_report_register(const struct tsm_report_ops *ops, void *priv)
>   {
> -	const struct tsm_ops *conflict;
> +	const struct tsm_report_ops *conflict;
>   
>   	guard(rwsem_write)(&tsm_rwsem);
>   	conflict = provider.ops;
> @@ -463,9 +463,9 @@ int tsm_register(const struct tsm_ops *ops, void *priv)
>   	provider.data = priv;
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(tsm_register);
> +EXPORT_SYMBOL_GPL(tsm_report_register);
>   
> -int tsm_unregister(const struct tsm_ops *ops)
> +int tsm_report_unregister(const struct tsm_report_ops *ops)
>   {
>   	guard(rwsem_write)(&tsm_rwsem);
>   	if (ops != provider.ops)
> @@ -474,11 +474,11 @@ int tsm_unregister(const struct tsm_ops *ops)
>   	provider.data = NULL;
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(tsm_unregister);
> +EXPORT_SYMBOL_GPL(tsm_report_unregister);
>   
>   static struct config_group *tsm_report_group;
>   
> -static int __init tsm_init(void)
> +static int __init tsm_report_init(void)
>   {
>   	struct config_group *root = &tsm_configfs.su_group;
>   	struct config_group *tsm;
> @@ -499,14 +499,14 @@ static int __init tsm_init(void)
>   
>   	return 0;
>   }
> -module_init(tsm_init);
> +module_init(tsm_report_init);
>   
> -static void __exit tsm_exit(void)
> +static void __exit tsm_report_exit(void)
>   {
>   	configfs_unregister_default_group(tsm_report_group);
>   	configfs_unregister_subsystem(&tsm_configfs);
>   }
> -module_exit(tsm_exit);
> +module_exit(tsm_report_exit);
>   
>   MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION("Provide Trusted Security Module attestation reports via configfs");
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 11b0c525be30..431054810dca 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -6,17 +6,17 @@
>   #include <linux/types.h>
>   #include <linux/uuid.h>
>   
> -#define TSM_INBLOB_MAX 64
> -#define TSM_OUTBLOB_MAX SZ_32K
> +#define TSM_REPORT_INBLOB_MAX 64
> +#define TSM_REPORT_OUTBLOB_MAX SZ_32K
>   
>   /*
>    * Privilege level is a nested permission concept to allow confidential
>    * guests to partition address space, 4-levels are supported.
>    */
> -#define TSM_PRIVLEVEL_MAX 3
> +#define TSM_REPORT_PRIVLEVEL_MAX 3
>   
>   /**
> - * struct tsm_desc - option descriptor for generating tsm report blobs
> + * struct tsm_report_desc - option descriptor for generating tsm report blobs
>    * @privlevel: optional privilege level to associate with @outblob
>    * @inblob_len: sizeof @inblob
>    * @inblob: arbitrary input data
> @@ -24,10 +24,10 @@
>    * @service_guid: optional service-provider service guid to attest
>    * @service_manifest_version: optional service-provider service manifest version requested
>    */
> -struct tsm_desc {
> +struct tsm_report_desc {
>   	unsigned int privlevel;
>   	size_t inblob_len;
> -	u8 inblob[TSM_INBLOB_MAX];
> +	u8 inblob[TSM_REPORT_INBLOB_MAX];
>   	char *service_provider;
>   	guid_t service_guid;
>   	unsigned int service_manifest_version;
> @@ -44,7 +44,7 @@ struct tsm_desc {
>    * @manifestblob: (optional) manifest data associated with the report
>    */
>   struct tsm_report {
> -	struct tsm_desc desc;
> +	struct tsm_report_desc desc;
>   	size_t outblob_len;
>   	u8 *outblob;
>   	size_t auxblob_len;
> @@ -88,7 +88,7 @@ enum tsm_bin_attr_index {
>   };
>   
>   /**
> - * struct tsm_ops - attributes and operations for tsm instances
> + * struct tsm_report_ops - attributes and operations for tsm_report instances
>    * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
>    * @privlevel_floor: convey base privlevel for nested scenarios
>    * @report_new: Populate @report with the report blob and auxblob
> @@ -99,7 +99,7 @@ enum tsm_bin_attr_index {
>    * Implementation specific ops, only one is expected to be registered at
>    * a time i.e. only one of "sev-guest", "tdx-guest", etc.
>    */
> -struct tsm_ops {
> +struct tsm_report_ops {
>   	const char *name;
>   	unsigned int privlevel_floor;
>   	int (*report_new)(struct tsm_report *report, void *data);
> @@ -107,6 +107,6 @@ struct tsm_ops {
>   	bool (*report_bin_attr_visible)(int n);
>   };
>   
> -int tsm_register(const struct tsm_ops *ops, void *priv);
> -int tsm_unregister(const struct tsm_ops *ops);
> +int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
> +int tsm_report_unregister(const struct tsm_report_ops *ops);
>   #endif /* __TSM_H */
> 

-- 
Alexey


