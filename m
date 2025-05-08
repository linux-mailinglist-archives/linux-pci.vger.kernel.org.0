Return-Path: <linux-pci+bounces-27447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3CCAAFEC5
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 17:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A5E164A1B
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695021F462F;
	Thu,  8 May 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zj1UL5sp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A7XvLrhW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E691D7E41
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716923; cv=fail; b=W1TEeeG2zp6t03aUg8f4aIDF76XtSYHR4xL/cbBgqG54bQK1XW5H6FwRArwZmu93e9XHaZu0ANRTxJjr0AwCIuDh2xmh5GEZKB+kuZdeU3vwLqYhm3AzSgRiPT8TU5cQ+zENPg0BldaJ86y5iHn0+fvqvlROSB90XEkUUczy0Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716923; c=relaxed/simple;
	bh=vmpO2wYQW9m0UD+24gq/u8wAMHWvv6D8qNHLAYR8w40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tFWCRe/f9vXK83fYzUjp/z4IQ2jFmYt0FU3r9UdDOrg5e1Vt1Dx/LFl9a+jr2hYkHnFp8ODqwFsPF1zNy61jaYn5Qq5SOgB7sCvLWw3Pi/99BbF9WGXhd34tj3ddvJ2ARCgPQzwjNtFeQPlbyaWtK1nsk3+3mXhElcruOGDP4gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zj1UL5sp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A7XvLrhW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548EurtO025661;
	Thu, 8 May 2025 15:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xbSEPXklWsPmiotoitp3u5VijQFQHqtOBbfO8lvv/Q0=; b=
	Zj1UL5spPTi3/PZRFnmFuGbR58eL6gcX+ccc/X00Zm82GpPRs5Rbhmu1E2HBR/hC
	91tdtEItBky8ESMj0uAQKkaouFvBm8ef4p6LVY8fHhFaShpoR49gur/II3aJ1jL1
	o56r+Fd+m0Fq8qTob6eqILOAH8BUrmN8OZdG3SGran077cpVZGzW0MONxWrOI2Vm
	MBv9s8EKX1Ec8dnnn3pjk6gAvrwnbBJej1nFbjVuNEvaf9d/H40iAsbGKHFYU/c4
	8hAOwy3R4C6W2M+XKu0y5P8jdLCnU1cuM2M23aAq6mdCx5wgaGYheFSo4Ax4e6rE
	WRKNSpQnOjJT+S0dmDjFyw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gx3hr5g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 15:08:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548EZ6i6001970;
	Thu, 8 May 2025 15:08:22 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46gmcbv3x3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 15:08:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr4CFPz5OmcOrLVklkffRTxScNFSVgcunwVPPiGbo4aH2HF0lKv0AJmPpGQZowOX12hyIcNsz2XiVk3DvonAhUByTPQk9Ji9le6bYMuODJ5FMsJm4hbixOe5X4d1MaXaZlmNqjTdFzAsSsR4CAIvzvdazeI1UMqxTWPWDwMnJvyLGBUmS7oHc1Ji5DvOOg4FDD0NNMGZZBF2OzxERPTDAmMnMaI5pyddgMVB0U9Uw4S+6mR9zyY7zD+Ajqlwq4YTq1MygPV+Gm6t2xUlNd1qGvaUDgiS6F0vu5p9NyPh3pQfOWrXu1UxXYPgTyui2gmpEqn3hzPxw70251dDC1BB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbSEPXklWsPmiotoitp3u5VijQFQHqtOBbfO8lvv/Q0=;
 b=O5o0nbPJYJ3XLS/xyGsxzocFW01v0kc2FDVYKXboQH79ZQ9uI2mLYDjm2BVnBM2nj6Pedq4Mie1siYg6dy/LosFRTbW/SmQrG4FQHokxv8CwTBIGmDpcMR8B+Upw+Nhek2wvCQJcoYdyu0eerngIAVe3PFod6ZWANPMW+jwiCXhQDHUV+QwtX5NvcFjYpyRa2cqe0bn/4xVuJ74BITE60fNMb2EguWmvw1zPQuAcpnRSIpFO/oQclgF/UsZ+0aEJxvQenaj1ERzzb7fSMGWV/38XxwQhAe6Vk29lCYmHCwdZ57N8M0PjJ89VJfDp3Px0fqmScr5Y16EbNwJacuh49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbSEPXklWsPmiotoitp3u5VijQFQHqtOBbfO8lvv/Q0=;
 b=A7XvLrhWXzocVdAN8f58A3+mFqFm20D45N57Uj/B3Jxzw/8L9JKOh6tcCDLc2cy1L7u/viGyEFIIo/9hMKUow207rXrJnGZEmr/M0GTuN6kNoAvi15aEtQwFTHW1KDXcGAOiJAyJEyCKVL9jBd17RK6/GAY/hds7x/BTc0vVfqU=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 8 May
 2025 15:07:50 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 15:07:49 +0000
Message-ID: <fc0696d0-7d8e-4094-98e6-6596b9b44866@oracle.com>
Date: Thu, 8 May 2025 17:07:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] PCI/AER: Check log level once and propagate down
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jon Pan-Doh <pandoh@google.com>,
        Martin Petersen
 <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sargun Dhillon <sargun@meta.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20250505174347.GA985743@bhelgaas>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250505174347.GA985743@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0093.eurprd03.prod.outlook.com
 (2603:10a6:208:69::34) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|SA1PR10MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ccc28d-84ba-4a03-2fde-08dd8e4218f2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NHh3UFhrVzdoek8wRUJqbWVuSHVQZ3IwY3ZQK09senBnSndmS3J0dExYZ2NC?=
 =?utf-8?B?eGErQ1c1eFo3aVVCYitGQVdORE9IOWZMOXFHZE1WVG0yUURGbXMzS3VoOTBj?=
 =?utf-8?B?SDRUYmxoME1hV21TQnZrQXBLL2RXRlpWMHNMMDJ3NlBtUjg0SEE4SkpnNUFS?=
 =?utf-8?B?VmRvNm9GVFJZWjJhWGZsR2g2QkJ3TE5xdGxqeVB1Z09BSnFScktKekt1dHJE?=
 =?utf-8?B?MElOdnpDRTdOcHZnejV0cFdYTEdKN2xjT1hHL29HRTBwdENidVZ0MFA2Zkhy?=
 =?utf-8?B?M2plUkxOcERuT1Y4eVBqYnFRT1hDYncyWUhWSUwzSjE2cXdKajVudmNYeW8y?=
 =?utf-8?B?TExKTHFDd2l1NVM0cEJwTXBKVGdVbWQvYnVoOTdPQ0RmRGJKRFpNT1NwWnE3?=
 =?utf-8?B?R21GbkhReUtkSy9FM3Z3UVZ4WDg0TWJwVGtESTVQbEMyQTN5UWp2MEZRUjhM?=
 =?utf-8?B?QUx4M2MrMmlhWTZ1OUdWY1Ztd29CWkdjWklJSHpQWUNFVitzRE9lQXdGYXBD?=
 =?utf-8?B?YnZSeFV5TW9CZ29YbFFXK0N5eERDenI3NmViLzJreUxWRkdYNUV3b0ltbytJ?=
 =?utf-8?B?M0FoQzBEbWp3d0FRZ25TOWRFZUo3VkxEWUNFVmQ2dEVuT2pJZFdoZnBWTUU4?=
 =?utf-8?B?M09sS0ZZb3N1T1ovRGxDK0thbXd2UEJyWThCY0RJdXBsL3I4VU5wakQ2R2Mz?=
 =?utf-8?B?R2dpYVFsR1NENUozQVRJc3RwY0hGMTNrK2Y5NklXUUx0VDBmeGF5UTRTeU0y?=
 =?utf-8?B?VEs5Y01FS0dsSTNIc1BleU56aHhqejBPalJmaURiK0JMM0FKTldOcFk3VzYy?=
 =?utf-8?B?SlNyRGl4R1o1QThNUTRlSkpIODE5QkRmK0U1QnlKcE5yU0xFYmFZL0ppQks1?=
 =?utf-8?B?a0xLbFVISjNiK0liOGJMMzJ4QlBaY1JJTTNkSGtTODFBVndqT21PY3ZZR280?=
 =?utf-8?B?RXNKRjlZSzFIc2JqVEVhRUZjL3dBKzJyaVpQSXg2ZVcwSnNFTUFZbGhLWUhC?=
 =?utf-8?B?bUIyY0QyemNhNW9jOXhlMlYyRmdXZ2QxVjFCUWlzdGNXYU1LVGlHMzZDcU1S?=
 =?utf-8?B?SWlOaGRZanFYVXNNTHNSajA3Ri9VM3NDbDA4aUNmWkZId2NObk1ZZ2FLTFl6?=
 =?utf-8?B?YzZYRHlhNklYSXVsN1Q1czNUWDFDU1UwdVROQjF5a0JEWnJVV0p5QWFPKzQ1?=
 =?utf-8?B?WmNyR25KVmVpQzRUOC81azE2RHBVUVllZUpCNVhtREFNMFJ6eXBBQVdUM05M?=
 =?utf-8?B?bGl1UVErcWwvdTd5ZGJkditDVWdBWCtiV1NtTVRqbmFhVStyTWlkSzd4TFdt?=
 =?utf-8?B?TlB6WVBCSXdEOEVCOVpTTlVHbVZjWks0aHl3Mk5qSVJkbS9IMitTKzM5R0dx?=
 =?utf-8?B?eVNxRHdtbnY5UStoUkxUVzUzRTFOYXM3bVRlUmNJOGIvMUNnUmlQMjlkWmxr?=
 =?utf-8?B?dFVsdWpVcFovTXZYYzR4TytPd0dsVUZGR0dzWWpteXFqUXh0SDF1L3JKUk5p?=
 =?utf-8?B?NUxtQnhtS2IzRVBiWVRUZzJuT3RlTmZsOEhMd01PMTI4ZE0vaUl6M3QvcVZt?=
 =?utf-8?B?Q0FQc1hyOStrekZFbklYd2VNWjdyV0YrYkxGc1lRbmJsTVZzWXg3SHEweFVV?=
 =?utf-8?B?enJJL253RHlobFdvM1o3OFJyVThsdGpoNjJETFNhZmI2SzNPS0JkR1FmQWhI?=
 =?utf-8?B?ZXRXMG84dW5Zdk5JQkdUMi9IUTFGaWh4UUdNOUxzbHdmL0d3Z1BIMzVLdnNm?=
 =?utf-8?B?MXh5MlYyd1JMQ0U1YnZIUDdPQ2FkTEFNeU9XUXJ4bjZKdTM0Ri8xMkJ6d2ZU?=
 =?utf-8?B?NTBZZDVyVWxKczJiTDVpRHlIblVLZEFNa3VsQ3Zsblg4RmdxOFhKOGtoWi91?=
 =?utf-8?Q?pISGaDSoOijXd?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NGRlMkZjMEdZK0FDMlJ5c1Uzam9kRDdiMG5IcjdOaUNhb0tvWE5Dc2d0VVFq?=
 =?utf-8?B?eEJuelVlV2VvcWdGODlJK3lMUmhqZGtzeHlmSWM2Ny8vbHNadjdvWDhYdEpH?=
 =?utf-8?B?NlRrZnF4Mk9pb0xZbHl6dmllS2hvN0FsKy9TQ3RpOGtnNXpjSXNTcFFrdHVC?=
 =?utf-8?B?MGFBc3g5NGdSWHNXSTlrOXRQUUhxcEVQKzhrbStrazBmeFlGUXZ3dzZtaUlp?=
 =?utf-8?B?VFNkY0ZwQ0ZhVFExME9jdHc0SURUR01PVGRVbER3Ryt2cmprbTVta2htdmZT?=
 =?utf-8?B?d0NtZVVGL2RzN3QrM3NzR0szZHF3Rlh3N0RZL3h3ajBQd20wSTFIaE9QTjEz?=
 =?utf-8?B?VkNiaDRWYnMxSmhuOFphaHVhS0lXckw5NzZNYnFXZC9xUm16ZGN4eVJYNHF3?=
 =?utf-8?B?TFBGSFRZZGpCWkZTQVdYYU00a0dhOEsyVW0rUHRTK1hYbEpBQjJFeHFwMDJE?=
 =?utf-8?B?azlCd1kvWTE2TjdwWlkwbnNMVWhlbTRON1ZUTlkxQUs2amJHYVNrTjFCdTB2?=
 =?utf-8?B?YXhXUTJyK3ovcitkYURWcm54amtncVNzWHFYRGZ5cVNGcU8zVnIvZGVnRHJ6?=
 =?utf-8?B?TGV0Vjdvb211TkpOZWxyQUdiTDNEaE5kTkY1WHBWWnk0MzMzUlRtRnU3SjZO?=
 =?utf-8?B?eEcralpLYjNXanNqN0pVamRpQnFLV0VJck9RSDNNWkRWZEtORXY0L3JwSjZr?=
 =?utf-8?B?cVZHOGZpRW9vKzVzV3MwRDYrTVJSZDI3b1BPOVc1TXNxMVpkcE02MURRem5R?=
 =?utf-8?B?SUtFVjgwSlRhY0ZCTUlEWW1VTW96MklJZFJwVTNhQURLaUNMZW1KTmlIZll3?=
 =?utf-8?B?bnF6NmJGU0p1RTR2Q0xZUVQ4S1h1M0RpS3JSNjdNMEY1Q1N6S2QyR29rZTBh?=
 =?utf-8?B?T2lXWnJYNnpnSks1MFdqMllmQ1FhWUpkdE9Lb2V3RmR6aVFXb1FubWRJdTNF?=
 =?utf-8?B?MU1RSStCZVU2emtmeEhQVXhPZXcvcTdDUWtaYm5NTEhLZ0trOURHRGhHOUxs?=
 =?utf-8?B?MGR3UXAvWUhGcnRpWEQxcGNjWTBMWldubWRyVTlGRkk3ckJ0UDdIV3VndlZ6?=
 =?utf-8?B?elVBblBVWER3aFNKTlBkQy9QNG1uRGE4djdQc2cyWEtCT1dFQ2NHdjJsSnhT?=
 =?utf-8?B?a2IxMGRZTzJseDNmQ0R3cC9hc2M1R0hORDJGMTFDUkdwUG0vUU9tbFVkNWNN?=
 =?utf-8?B?amFKeDNKMDE2aGYxVTNocU9LMUEwZ2x5azJ2MmZQam81MVZaMnRzeE9XcDRJ?=
 =?utf-8?B?bkg4MEdVWFQxRk5LQkcyZk9TSzljY211d0JKNEdSMzY4Nit3czNuTDUyVmZP?=
 =?utf-8?B?OUdGckUxaDhJVXhKWEJYQTBPeXNqYzVkUEVlWjl3QVNodWZwMVhwSGRsbUdi?=
 =?utf-8?B?VTRrWWFac290UEgyNWhPN1BUbzdxL2hBNUZtcXRqNzZIMFNCaEs4TlBlMWcv?=
 =?utf-8?B?aHNNb2g1SnFhaUtqU29JcnJtaG1mQklVL2dyYVlFeHpuTnFsZE0wR1N4VTZj?=
 =?utf-8?B?M1lGSlk0NkxMaFBXQTk1MEY2ZlRrcnZNVjVwQ1Jtc0c5N29xRjVZRUVqQWw5?=
 =?utf-8?B?THJmWEl2MjZRZEZ6S21ZN291ZGZiNkc2ZmJDakJQZFlaUnowWkN6UlZpOG9Y?=
 =?utf-8?B?NHJTRWY2QlM3V1VndkxJeFdIdHpvN1ZJbm81S0JQUjlzSXJyMFg5TEh1bEFo?=
 =?utf-8?B?WlJDT3AxMWE3UUhHV1dqbTlGekxxWnFlTDNKWCtBb3BRSFdMYktib3dmNU9h?=
 =?utf-8?B?dWFweThXOFNxOVhzdTNqQk9XMlNVUjhVMGJtNW93ZGx0eHBMTDl5Tmt6S0xm?=
 =?utf-8?B?SWFWRWFWSCtMM1VvYlNoanhXcVZaL1JvUEZ0SGcrNUI5N3dXT0lsdVU3bHZi?=
 =?utf-8?B?K0R3ajIvL21KY1VjQS93U1pJVkNBaW9tWFZZWFpUSjEzc1VVNzMxVERyR2Mv?=
 =?utf-8?B?cUpVclVUeGppWk9QV1p3cXZ1ODFLT2lKNnY3cUs4MWg4TXFHaTZtVDREOXVB?=
 =?utf-8?B?RGh4aVJuQ0s0Z1JLZ3FZY1dFWVpVendkMnlQVDJrcjBaanJnSjBENUlrVVRz?=
 =?utf-8?B?RTVvMmlWZUlvZ1ZwSWdzY1U1d0NTY0JHR0pYc05lSWFvTVRkUHlZeVVoRmZU?=
 =?utf-8?B?aDE4UTRoVURNRS9mWngyaG1rdm5sbEJaa1FjNmVjSjU5aTJOVkxiMElEbnVZ?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nts2byyR2q/JyQa2v8IJ3/dIpdGU7PcFXlFM0DKnJtIBpwd8WxawbC7CvN7zpbUd/B3ng0TuyxrK8nBhdX0v+B61Yw4AibOUHHoozAtoaoAzTACf9QtEiRMecW84Um1uk9e+Y80F8MIUc9MEkOpdIQMRP6TsVI927RiKDnSMPDrX1vedi4geV6sH6BnB6yCplpwDDvw3xTsEX3svoWqXLBF5ryiu7CjeexMGoYkQRoWscoPBNNbnvuOFtSKArIp3rq8WCzEQgEUUfYQ5Za7EiyzgH8syGh9fToSoxe8xpt1Y9NhmyLpVaD2MSvXraz97Eje53B/NBDUrMomReCN0+8YPFNBDUAiWXNVxV4f5HeUU42lGupDNCwN4W2aVEUtgxo767rTw904TOth69CvOf18FmwM3m6EX0OPJ6Un0IFHPYei3m0zfruN0EBYxPRh/Sa3Nlx2ijKHTfuroSI7MbzUg8wD/LCRV1Rb+6hTr0CO7ZErwr7kCPTKdh6g1jftUgawaGl5geuGRNR8Yayrnlyzm3sMXVMtyRBUoD/tVQbBOVEF0DG6KCZKWRViqb+4LpUFlmG0dpc4Q1C/1TUxNj6AuLgWVBxjBQU8o9VMiCxY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ccc28d-84ba-4a03-2fde-08dd8e4218f2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:07:49.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQij0O0K2pM3XezE1K9t9kWAV02cYbyw2ktnf5pJsvlsdDpx5y0SsHeJmC+F7UvzrG2gmERAo+hfCBEZJFv3pxNvBVtRgleCNVKjgRnOmrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505080131
X-Authority-Analysis: v=2.4 cv=SoGQ6OO0 c=1 sm=1 tr=0 ts=681cc8e7 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=RuLfewo-LvrYZDdFx_kA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-GUID: PExUCksmDvMxrlXFHFF-dViKyIpaxRsm
X-Proofpoint-ORIG-GUID: PExUCksmDvMxrlXFHFF-dViKyIpaxRsm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEzMSBTYWx0ZWRfX4fla/TXgebwX wMjStp5yaJQxMRJQskk1stIPB5AheE4SIIHa5ZFobh1Vo7NjsmQWJWLk9wcW8dReyGaUk+2KZxe KF89g5GCJALWG0prO3H06l0NTe5YX7fmPPzML6FPHlNZDDtdUTxfU37EpKILYfzBk3PBjDllMQq
 cHbX09kX/7r9is1sKnras2sLCgbe9jzjcavPdNAGQGi3mKAbof/4Gf1r+EsxlKqIB7FinNcu2iF WARPmIA3exlmWXxRMXfxIy6conDXJILGoqF5W6euXjGoccCEI1KfoAXh0bT9PqcUs5gAk+UnZ5L oQI7Nbutg7lAjFWMeDQBppthC8GFolU5o5g/GNwqK8LivzU1SQH0NJ1biT4mHxv18Cx6Ccud6TR
 76wnwNuK2NDw/flhiuFAAKMZvFJMi0Kt+o72pgROCW5n/f7R5vjhRsaGUZCavhO9/vv4kVdL

On 05/05/2025 19:43, Bjorn Helgaas wrote:
> On Mon, May 05, 2025 at 11:30:58AM +0200, Karolina Stolarek wrote:
>> On 01/05/2025 23:43, Bjorn Helgaas wrote:
>>>
>>> I'm (finally) getting back to this series because it really needs to
>>> make v6.16.
>>>
>>> It would definitely be nice to determine the log level once instead of
>>> several times, but I'm not sure I like passing "level" through the
>>> whole chain because it seems like a lot of change to get that benefit:
>>>
>>>     - it changes the prototype for __aer_print_error(),
>>>       aer_print_error(), and aer_process_err_devices()
>>>
>>>     - it removes the info->severity test from aer_print_error(), but
>>>       leaves it in __aer_print_error() and pci_print_aer(), which need
>>>       it for other reasons
>>>
>>> All these functions take a pointer to a struct aer_err_info, and if we
>>> want to compute the log level once, maybe we could stash the result in
>>> struct aer_err_info, similar to what we did with ratelimited[] here:
>>> https://lore.kernel.org/all/20250321015806.954866-7-pandoh@google.com/
>>
>> I think that would be a good compromise between these two approaches.
>>
>>> I'm rebasing this series to v6.15-rc1 and will post a v6 proposal
>>> soon.
>>
>> Do you plan to include changes suggested in the thread or just rebase the
>> series?
> 
> Yes.
> 
>> Also, it's still unclear to me how to approach the sysfs patch, both in the
>> context of the ratelimit refactor (which, some of it, is in the next
>> tree)[1] and the value that should be exposed in the attribute. We have
>> control only over the burst but not the interval. When we deal with high
>> rates of errors, we may want to increase the time window to see if the flood
>> is out of ordinary or is it constant.
> 
> Unclear to me, too.  Might have to revisit that.

I understand. Let me know if you need any help with the series.

All the best,
Karolina

> 
>> [1] - https://lore.kernel.org/all/b0883f20-c337-40bb-b564-c535a162bf54@paulmck-laptop/
>>


