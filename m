Return-Path: <linux-pci+bounces-18787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8162D9F802A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2021169D46
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D7226888;
	Thu, 19 Dec 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J6Pc2dI1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8C226182;
	Thu, 19 Dec 2024 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626660; cv=fail; b=F0Y1yCiDNFzNm0IiWTrE26MnEW+npNuUwTA07h/M3hEytI6LBUJRUFomTgzQ2HtKwMX9b8zUZY9oO0SyiG5i3r9rnjC8QrGwYSBKaub1Q53WFTYpe+AK8RRFFcGsY8YHH0+iilXHoUGbMtVTj7YbwZfL+fp6lG43mzlR2/hjzsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626660; c=relaxed/simple;
	bh=an08fc3T0USp7FXETKw2niZkI4e7QwsQNy1mhSkR1KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ISQfKL3ShNTbSupILdsnUzmxRNwoaJdlzWVoHVAmiFJRX63GqXumcZauX5DzL/lyuDmSEH4KaqDQWOtKr/rmKcN3luHfldWLfKuQeM2GAIwYOCvS9AKjGiHhy4qgB0er/TZo+PRD2QkS2NadfFVntEf13XzYqsDBtiGjI4wHNxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J6Pc2dI1; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aM4s5gO0ApFsmLWWqF2OHT+5p4WuFN0d7h3oITM44aJVrxzKw0acesSm3PmqP2Eo/j5XbTEqBbyfuU4fqrJBWeyY/s8cFx/1/k1jyqAM5ZRg78jmmpooK8bMUNaO5YIMRBHabiBZomwze0X19xvFOpIpZjnXn9+Jk2uDb7X72z0eVUL9/HeKUMZ6uUKDaAuIZyA6fXoBjxsXjQEB2wEZeGGGPWY1eQxv5VsI3LcVbebdoXyiwyIsvUy1LqBLRGgz96x5Wcaqyq7j4W3apCgqHgtWgxqLo0JPsmtDAr+Befi3z7Gof3eCcxsBjdex1iN5QqrCWaR+8HZSPSZoRLYnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POL+PR8fH18pzMtE9bDmBBqXhKEYVDdXJfUwuspfzNI=;
 b=edOAzCjy0WAg/KxqTQT9Y/TzUSW0cXOkiJmcSH0rah5QhrvoE/8pPxQAY6WjYUIpZ0qOApEAA6znhwXob6+4ddJB1vzP4Fy8u5rLu2c8WILHAD/qWpGMy799XRvypeqJkCMaKxaZniUPh4c7Oc00uUOflbng/sLKNhTZDj2j+cQlHkYjhbJ9xbB2wnXfOglGPyfyh3CuSVUp+EZol7vwDi0P7wX5NX+mAb3J9PEmPKs6YHmd2cC3HadTHwfXkmfN2wbM34fzDfGzI4sVWr5f9FJFTrRd2SXMgdDtBMVoLm0weV/CWUqY7bSxdoykgYrFeiBrAumIRQqBWsu2FmJGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POL+PR8fH18pzMtE9bDmBBqXhKEYVDdXJfUwuspfzNI=;
 b=J6Pc2dI1Jb27pnf8SNEvYC7iKM0ae3xTw7EE/wVsabIRZ4EZksQ/l1ntTSBjWGi+gGcQB2w/ymMhBKK2TUp+E7v9eMhstfo+jk5H+BIVDmE/6enrC3m019BTcCPDoqqE/rpOgKOUnpwLecrH+PsoumIQMuBrZ4ttNQ/whVJjrZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 16:44:16 +0000
Received: from IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514]) by IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 16:44:16 +0000
Date: Thu, 19 Dec 2024 11:44:08 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Rostyslav Khudolii <ros@qtec.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <20241219164408.GA1454146@yaz-khff2.amd.com>
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
X-ClientProxiedBy: MN2PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:c0::27) To IA1PR12MB6354.namprd12.prod.outlook.com
 (2603:10b6:208:3e2::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6354:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: b5062be5-dbae-4852-1d19-08dd204c6026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azJDOXNob0pwRHJ3ZkZHV0J2T25IQ3M1d0t6RHdFWktONXdIYi91b0syNGNh?=
 =?utf-8?B?b3loVW8xY2NHVDFQMFY2TS9Vd2VZT0diVVI0N2RrRDJYMUkyTHY0aU1Va2du?=
 =?utf-8?B?cDZrd0VtZUV1YStNbHNuMTJBTnNJL0Irc1VLYkZlaEVMek9Zam0wckxGbjJl?=
 =?utf-8?B?SzVuWkxXcjFJcHdoQ2NsMTdBbTl3TW9OOUM2TUZCZU0wa1Q2enRNM0g1UkRx?=
 =?utf-8?B?eWlzM25nZVo5ZnA3ODA5eHVPL1E3bmRMNDF1YWpiY0dEQ0V4K2YzUzBLTUUw?=
 =?utf-8?B?Q045THYwcllFL0RFaGtKdC9VY2FHRS9GOWFSei81V1pTeDAwK25ORnA5MENI?=
 =?utf-8?B?WHovcmFJK3FvbG1uN0UydkxOSEdrbjVoUUVCcWdIa3BZdStMQThhK0R2Wmhq?=
 =?utf-8?B?MUpycXpTT3NQM29JVGY4L1o0RnJqaXRiZFFTSGJMa2JyQ3laM0ZoSWcrQXhy?=
 =?utf-8?B?YVdqUEtnUEV6L1o4c0Z0Z2lSbDNwdUkzVjEzdVBIdjVDNzdJeXU1azc2WWhI?=
 =?utf-8?B?ZTljdERDcXVET01sWWppQkx2MlBPMGZRZmFVaXVpQTlYYWMwWlB3eGJiYzBr?=
 =?utf-8?B?N2s2cDQ3OVVsd2RVKy8xWGlCeFQ3aWhRQ3BRektZYUk3dE5hUlNwT2F4c1RO?=
 =?utf-8?B?MnZKcFYwS0hxNGo4ODZ2UTVmNUx6WlZWRXpwYjBOTjgvNEJhdFpMbGZUYmli?=
 =?utf-8?B?QmpzTWtkNUNxRHhvZjltUzdTTXJReTU1QTBmbks5UnloVmRpd2t5aXhKcDl1?=
 =?utf-8?B?d0kwL3g5VVU4NHZtRGRSRjBOcXc5SG9uSjd5SHNaY0NuWWdLamFySDFuV0Uv?=
 =?utf-8?B?Q1JMaEh3S1RaMFR3OUtXNG8xQ29ZNFh6alBLVGc2WXdkbElYSmVKWnoxRCt6?=
 =?utf-8?B?eVBKbEtLQXRBZ1p0UXBDbzNoSkZPQ003b2QwQURMRzRGVzBoWk5aNmZnSkJi?=
 =?utf-8?B?dVZ2MHFpaDhpaE5GR21ja2xMeVBJYmZiYUdDVTB0dkhXTUpkVjFabjZYRldW?=
 =?utf-8?B?anIxWGVQa2ZPWGRvUDQ4dmlVT2EvSklFaUFDaDE0dGpEQjQwSmJQelNyVTF5?=
 =?utf-8?B?dUoxVzZiVm8wOHQ3QWx6SjFFbXZTUlZkSWNSZjFNYjlFYlh4WUdkMnJWVTVy?=
 =?utf-8?B?ZUo4MkkrbXFEY0c1elp6QWFSTlEwLzhFUmp0S1FkeWFrdGZFdW1qeTBwdnNU?=
 =?utf-8?B?Q1dqYzZPL0hTSGVhMk5OMWRxb1FYWDJWejgxbmZrb0JBNjgzU3Fsa2lkK0pS?=
 =?utf-8?B?c1E0WDh0cklVYXpWcThCeHBKcndtcmYzTFliUzBzV2k4MWVXTE9aVzhGS2pP?=
 =?utf-8?B?K2tmelpFZmh5bFRFdjJtUkRnSHBpRzUzRTdRMU11WE9wWEprVm9rMmR1WmNk?=
 =?utf-8?B?bkNsOGlSekVyY0F0bllvQ0ZrYWgrMjVrb3RRcWpmZmFKRUZGZEdzY3N0bkl4?=
 =?utf-8?B?ek8xVlRjRzBUTjIvY0dyS09aUDR1UnFXOU5mMEtpb1pjOU9pdWl5dzIvNHZy?=
 =?utf-8?B?Ry96d2dpaHlYNUVIYXliTWR3Z2E5T0lPNmJUNjRPZjNvQy84QTJ2RGF5YnYr?=
 =?utf-8?B?RmpXQ1cxcE9adlZmQnVjL3d5RVlkVkQwSWNjSkV1a3VXSkpOMGpRcEdzRDcz?=
 =?utf-8?B?eW5VWGxabDdmbFhIbm5KcVYvTThHRWo3eUMzRXQyc2s5MXNYejNkS2p4TTBU?=
 =?utf-8?B?dHMxczgwRmRrV2RRQ2thVmorT1p4dnZHNVdRNUN4S05DTFhwU1BabmJYV0F6?=
 =?utf-8?B?dk13T3VDWWNoV1BRTkNYZjZpLzN5T0U2bWQxNVVOYS9MWWhUKy81YmI3a0dZ?=
 =?utf-8?B?KzROZ3NTTVZvUDZQbzZTUzJHaktYV05NVHlGUWhsRHRzSExkSGhqa2JHM05D?=
 =?utf-8?Q?fkFcrB4PeOXB8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6354.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm9aTkxxQWtRN3FoUUkxMjdLV2JucE1teU9mcjM5am1qb09POWhVVjhtY2Nw?=
 =?utf-8?B?TVk1MkErOFBtQUorZ05wS2Z6WnIydVVZKzJkWFN2QlRFNENrWmNQYlNGb3N3?=
 =?utf-8?B?QkRXaCtWODg1aDNMNEpxaDE3WWJ3QUlCVUVPTUIwYXpJTVNXZ0ZlUExJVlll?=
 =?utf-8?B?em9RMDZpYUt0dkYwQ0VJV1ZGMTk0VWIydFFsbzB3SzdrUStZU1dYcHA0MGJk?=
 =?utf-8?B?bE1pcnBuRnFBb2lhT3ZWaHhMRHAvVHVxZnFLUkJYVXFOa3ovZ3RzUGFlS1hT?=
 =?utf-8?B?MllSSkQ3Sks1WjhscFVYQXZtSnI0VUV1ZUpPT09uNnAwZ0VEZXBnb045RXRu?=
 =?utf-8?B?bHRHNUJkb0Rzbzg1QTVSN0kzdElReFF1ZkZHbGg1K3lhSnRreTRha2pvT0g5?=
 =?utf-8?B?RXdRUURvWnlYdUhoZStuZGV5MUlUWDhBWHF0L1lZaFNLT0E2MW9oSU9qWlYv?=
 =?utf-8?B?YlRrQ21PS0huSzIyTHhzYUN1L1Z0eDVTVzlDc0ZSdFNmZmNyeWhlRzFJYUZW?=
 =?utf-8?B?dStab0ZUdUlOVlNVSk5uMGNUUFRoRDdyRHF1eXJ2WGJiUEloT0poNGFBMnNr?=
 =?utf-8?B?K25yejZ4VURJMU9yKzNMMjI4UWpSY2lIbU1wUkNKUEtKM1dVZGJITDFqNWFu?=
 =?utf-8?B?Vk9sT2pIYS9YWFhyUHRBQ1poV0JFak8yZk5EVnFJUHRPYURGNEd0KzRzTHls?=
 =?utf-8?B?Z25KaGh5QjAvTXphQkZTUXFmalhEN25HM0FqWklkaFZFOHFzYy9QcjVwZGJh?=
 =?utf-8?B?M0QzUEFFSjJqaFdnL3BzOHJQcURyT0ZrbEVQTVlCTTQraGlCeldXelVnTGFs?=
 =?utf-8?B?bjMxNE1jME9kblVzNU8wOFdyYVo0dStyRDFHZmtvZjBYajNDNDRacUpncVNK?=
 =?utf-8?B?QlNIc3cxeE5XTjhlbmw4eCtEeVd5SldPS2RkeVVMMG1uZnVkU3dLNVNndHY5?=
 =?utf-8?B?aDR1akhaUGhVVWxKMlVUR2psbEJGUXJDMEFlUDRwakhiNXFDTFdQUXpOTGNi?=
 =?utf-8?B?V2hOa0RXUTZqcWpDRDBReGlVVG91ZFpyZEN1OFI2aklTdWNUQVpZVnR2U2Rv?=
 =?utf-8?B?dnlkREVGaFhtM3AzVkliSFpqU1h0M1RXRHd3TTV0ZXZLYVB6azNOSjliaFU2?=
 =?utf-8?B?WmVlSlVaa0d2RWtWem9xM2h3eVpLd2lyaGQyaEg5YUZlQWh3eEVEMDRJcnFE?=
 =?utf-8?B?VlYra3BGZ3pUd2xyMG94Y3BPVEg4N0g3VXZJRDNzZ2Q5M0h1NXFUZGNZMkdh?=
 =?utf-8?B?K1UyVHY3L0Nna3lsc01kdXJLYkI5Qk53b2l1M2lQVS83V1FKKzg2bS9ubTNt?=
 =?utf-8?B?SjdnNmk1QW50Nm42WlpDeEtITWV3a1lXYnVTdzNnOU5GOEpmUlQxdGcyRURN?=
 =?utf-8?B?Wlptd1NJVXE4ZEUvNUdPZ0RVNnZQSzFyakoxbHRLb0RQdUhzd1pkZEMrZGZZ?=
 =?utf-8?B?UHBLSGxZVFdwbEwyR1htdWxkQUFaRlpRbnEyWkNxWFpLUU5CRVhwUFBCS1Y3?=
 =?utf-8?B?bjJCY0ZoZXRlajJsNGJGcEF1RG54SlJyU1lvSDF1Q3FwbUVBYURRdlBMTXZM?=
 =?utf-8?B?S3I2ODgxVnptcnk3MS9tejhKZHg2NkdQTUVKbDBMbFZIc2FVNTBnSExkd2RM?=
 =?utf-8?B?WTc0SWxtZ1psWS9TYTdrRkIvVnZ0V1VvVVkwSm9aSi9WMVVTTU1Wc2R4Q0hM?=
 =?utf-8?B?R3pGVFFUV3Q4MnFEc2pZMm9XTFVXRFQzRVB0YVl3RjBKZUVVNUw0dUVCdThQ?=
 =?utf-8?B?TVJrS3Nkb2xpVXhwQ25tSzVCV1JoOTcvWWJaUVAvMDlHbGI5c1R0T1FVdUxC?=
 =?utf-8?B?QkU0aDhuakRTdUpoZkNYTUthWGdTcS8zcTdXdkEyM3Bpa1R1aGo0Y2JrN1E0?=
 =?utf-8?B?TWJXRVZ6OW8zQnRIVnhWemRLK2JkbUs4UWtWLzk5eFFwZC84Z0Q3akZRa3Jp?=
 =?utf-8?B?aXBQalg4eU93RTBFWjMvNEsyTk9LSWVocjV6T0xFQnhDeHhBak55ekdkU3Nm?=
 =?utf-8?B?bnpvQVM1NmMzMEMzUnl0TmlKWmdMTTA4WVFmakxrQnpST0JGdVVjNDBDUnc1?=
 =?utf-8?B?KzJzNTZadEwzejl1TEhJL3pvMHlNN0wxdUl3TW5sNlBzRG5DUkxMeTUra2dh?=
 =?utf-8?Q?4v7HWBkagaWaXNeKEaCqVTxU7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5062be5-dbae-4852-1d19-08dd204c6026
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6354.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 16:44:16.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rgRcVeaSxL7WhP6xkWWDI14vda7Oj/9DlCODKYLRhyAqP5LzgUSPrKptvqWk5t82WIiuGKr13zppc+WXaS+DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210

On Thu, Dec 19, 2024 at 12:23:37PM +0100, Borislav Petkov wrote:
> + Yazen.
> 
> On Mon, Dec 16, 2024 at 02:15:26PM +0100, Rostyslav Khudolii wrote:
> > Hi all,
> > 
> > I am currently working on a custom AMD Ryzen™ Embedded R2000 (AMD
> > Family 17h) device and have discovered that PCI IO Extended
> > Configuration Space (ECS) access is no longer possible.
> 
> Perhaps that particular type of system of yours needs some special handling.
> 
> Things to try:
> 
> * use the latest upstream kernel
> 
> * add some debug printks to the paths you mention to see where they fail
> 
> Looking at the relevant chapter in the PPR - 2.1.7 or 2.1.8 - that
> should still work.
> 
> Leaving in the rest for reference.
> 
> > Consider the following functions: amd_bus_cpu_online() and
> > pci_enable_pci_io_ecs(). These functions are part of the
> > amd_postcore_init() initcall and are responsible for enabling PCI IO
> > ECS. Both functions modify the CoreMasterAccessCtrl (EnableCf8ExtCfg)
> > value via the PCI device function or the MSR register directly (see
> > the "BIOS and Kernel Developer’s Guide (BKDG) for AMD Family 15h",
> > Section 2.7). However, neither the MSR register nor the PCI function
> > at the specified address (D18F3x8C) exists for AMD Family 17h. The
> > CoreMasterAccessCtrl register still exists but is now located at a
> > different address (see the "Processor Programming Reference (PPR) for
> > AMD Family 17h", Section 2.1.8).
> > 
> > I would be happy to submit a patch to fix this issue. However, since
> > the most recent change affecting this functionality appears to be 14
> > years old, I would like to confirm whether this is still relevant or
> > if the kernel should always be built with CONFIG_PCI_MMCONFIG when ECS
> > access is required.
> > 

Hi Ros,

I expect you would want CONFIG_ACPI_MCFG and the "MCFG" table should be
provided through ACPI.

Can you please confirm if this config option is enabled, and that the
system provides MCFG?

> > Linux Kernel info:
> > 
> > root@qt5222:~# uname -a
> > Linux qt5222 6.6.49-2447-qtec-standard--gef032148967a #1 SMP Fri Nov
> > 22 09:25:55 UTC 2024 x86_64 GNU/Linux
> > 

The ECS space is expected to be enabled by BIOS and advertised through
ACPI.

The oldest public doc I found mentions this. This is the BKDG for Family
10h dated from 2013, and the product was launched in 2007.
https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/programmer-references/31116.pdf

"The BIOS may use either configuration space access mechanism during
boot. Before booting the OS, BIOS must disable IO access to ECS, enable
MMIO configuration and build an ACPI defined MCFG table. BIOS ACPI code
must use MMIO to access configuration space. "

This paragraph remains unchanged through the docs for the latest
products.

The PCI Firmware space v3.0, dated from 2005, has this in an
implementation note:

"If this platform also needs to support legacy operating systems or x86
BIOS Option ROMs, the CF8/CFCh access mechanism (which is PCI Segment
Group unaware and only can support up to 256 bus numbers) must also be
supported."

My understanding, based on the above info, is that ACPI should be used.
The direct register enablement is still possible for backwards
compatibility, if needed.

I think your observation proves a good point. The registers were moved
starting in Zen. But this is not an issue on modern OSes since ACPI is
used by default.

For your specific issue, I think we should determine if there is a
configuration or a firmware problem.

There's also a difference between "early" and "late" mmcfg init. But I
think we need to have more details on the issue.

Thanks,
Yazen

P.S. Thanks for reporting this! It's a good question, and I find doing
"archaeological" research enjoyable. :)

P.P.S. For the maintainers: should we consider cleaning up legacy code
such as this?

