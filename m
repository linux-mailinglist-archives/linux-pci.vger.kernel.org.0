Return-Path: <linux-pci+bounces-26889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998A8A9E5E9
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 03:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB3A3A9B69
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 01:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB2278F3A;
	Mon, 28 Apr 2025 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xv3WRdrU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E7178F51;
	Mon, 28 Apr 2025 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745804839; cv=fail; b=hUoYz9zxpMcD0XS6jHYNGP17GibNyMnPfS2+RI6PHcVVRKsiVu2/fpsaazrlbY0iwl7bMbOvE77VhodZiNHCH2ti01+Mo9qr+O6pLA57373My0xPpeRBJeMoRHi2aemP3hQUqnhBaHZcSb77GyHK/iuvwKO0ZuYsXyyAK2h8+Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745804839; c=relaxed/simple;
	bh=QZEhsdUEBVFvpXgio2L703x5K3JTXtWSsxFXo6QhZwQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AXROtQHotpDV18eKdgrInwSZv0wJ9bpXSOshkESBizhSWJcjK6uVCwTRpvIb/Wf/kvhd0AqXEOLjcJjdz5lmUheG66PjeBuckBY1tSonMOAYoUxuJlr2Wab+sHKDAXk2kT7cIAmcI2QaCFB/8mpJlVvV9oN+4I8x9zZJSB5FM6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xv3WRdrU; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONEfrdNlzWbx16XDJyE0Dnrwvg8A4Kf5YjNfIma3JZUMfnBH9EYrMS0woBBB38Tb5Hz9fIa1d3FFvSSiTQ74zF/eGN3XTtki4zhuORcI0A3GUW2hmT8+VwmIoYcIUaGI8qDFVU3HaS1Vp9R9weMAWxzsazUCkViT4q+I1BZYIIej28TGtz0DkKwkoPdkjtzqRSI1MzflGkPOEYqY3Oo4ubMuQT5Bk//ywedAXS/mFvfkEXmfIQRecpVBfe2tlterZgIDIY4rVeARSueIoUNCVfJNWIS/8cCSZd4md3xdvvUFXlfmTdRI9PONJXfqfV77eSTDQ5IumUSMlWm3eDjnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCnE1p4lO54s19ZnhHjOYRbKY3NutnTGNhQ6EtEHs34=;
 b=wdTGgTJumhdgyzUGMAL7WC6mfyg8DPV1Knc5CzBP+04t8lK20Lp8pF7vJver6VVwZHJ5XDMCNI1ccvJMw37mTdtjm8iaiBcKHBjdtU0cMimHopnhIikdZEgk9XgS3TUKxLRYQ4EMoioDZghfLK+/trIBEAgzvOewiAEA9Eh1McBx9jpdbGkQuvvmnc/Z5iaSv0HLYvltqNvFufn0D3H6gc5yeCTqrjzIPRL+zF6xWuElcrhlPfUnb3uxfhx+DMV+1uNvdKVCw0MQgUtWCq44aPWNs/SORmpougBm86LhDRo/LOTTUUIao8LTDHgjnzlCnvB79e518nYzvw2cJs4A6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCnE1p4lO54s19ZnhHjOYRbKY3NutnTGNhQ6EtEHs34=;
 b=Xv3WRdrUnbEISzUXBDqKvgHBGPM9nEDJbSJbogiFPNFtJjUO2SkqYrOQkwAsL7J/NJhfvEMQSkD8YYr+0ZKTwMrcVX8SU+eW0osdHAOYX2wftlPkNmC62Tt6nYiM4hvXJTyFjyLrIl04MM9fUtiagm2Y3SqAOcAVQ2ddMZ78dCl7Z4yMjRMS5o1j0oVZWZyIIrJj9o4OfD3mBY8KArVuels8os7NjRVfIz187nOB3cr3N6rsYRAQy33rtOxMOstQaYRWmIxd11Yvhv/ju/pKpGse5GpVuDp4vQb9jyUD/UHE5SgG5TUw65CzdDL1iBm1COjjZgKlcEA57UWanLajCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Mon, 28 Apr
 2025 01:47:12 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%3]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 01:47:12 +0000
Message-ID: <6c2193a3-02f7-4374-bc64-e9dde471da44@nvidia.com>
Date: Sun, 27 Apr 2025 18:47:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc] iommu: Skip PASID validation for devices without PASID
 capability
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 stable@vger.kernel.org
References: <20250424020626.945829-1-tdave@nvidia.com>
 <a65d90f2-b6c6-4230-af52-8f676b3605c5@linux.intel.com>
 <8ef5da0e-f857-43a0-8cdf-b69f52b4b93a@amd.com>
 <20250424123156.GO1648741@nvidia.com>
 <77be6671-e4e8-4b17-bf72-74bde325671a@nvidia.com>
 <20250425120035.GA1804142@nvidia.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20250425120035.GA1804142@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cdf2e1-549c-4818-0da6-08dd85f6982c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TERNUnIvSnFzWUxUaWFBbDQ3U2s2RjdMTzhwYm5ZL0VMZVF5bExyYUZJVmp2?=
 =?utf-8?B?RWFxdE9NTFE0encyUmNDSk1PekVmemg5VnhWR2EwWXd0Y01BSE90eDJXVFps?=
 =?utf-8?B?SEVnbWoySHNPNVEzd0NtNlpvSm5wQWNVa3R3MERiMFJhWHBPSzFVSVoxbU0w?=
 =?utf-8?B?TkpseEVlVGNFZmMrQi9CS2NlenRaOHAvdlRmZ1RodWd6Vy9FaGtuREl6dXZY?=
 =?utf-8?B?MTFZZ0ZMRFdLRlhnSDFjc3k5b2h3bVhHSnMyVkNtc0NTUTU2dmZtNXBKWnpk?=
 =?utf-8?B?dmFYT2lzdTBQSGUrYUdrTWZSQ0ROMFZsRnZ0Ny9KaXJyWG9YYlZaTGx5Z3gw?=
 =?utf-8?B?SjVoN1RBNlBub0c0SHlON3d6NFJ4djcvelhOdUV3eHRIQUdGNld1VGZURkMy?=
 =?utf-8?B?UHRQczhBWGwwTkN2R01xbUFNSFdjeXVrdkhPRXltMzh2RENNSmtsRVhlajVU?=
 =?utf-8?B?SVM2Q2FsS0laN0s1aVk1WTRmdEtsa282ZVB3TEIwbzNLaUV1S3lLYVc2dGRY?=
 =?utf-8?B?M2JSOExuTlBOQWhyZXhwY2hpMU5zUXhGc1pvRi90OGo4MXB6eWJwaEhDR0pJ?=
 =?utf-8?B?dE1LSDg5c1IyYjV6VjdIQ0tSRlE1R2FVejF1a2pCRjltbGtkVzI3enQwdXBE?=
 =?utf-8?B?bmFZVXVtWUdlaktrYStVQlVrUTNOeHpCenRickpsTGVSN3pkdmdtNEVNSGZr?=
 =?utf-8?B?RG5ZVFA2REZVek55Ymh3QmorcVg3bzFaTStXSmdkaVp6WGhyc085VDdQci9y?=
 =?utf-8?B?SFF0b3Nib2xiekxRc0tlTzFYMXNLVVo3WHM3QXM4V0hiNDljeWpsOG9rcEVD?=
 =?utf-8?B?SUh6QXBXcWhYRmlpYjhqRVVXV0h2QjRMUXd2TWJIZGdvcDV1Mko2T0IrbDcy?=
 =?utf-8?B?aTVZK3RueHc2Q3JGWHhGWjBicW13R1hlTitkV1Bhdmw1TythWW1rUk54ejU5?=
 =?utf-8?B?SmRPMG53eUNuazNvMXpzeE5jU0FPY1lUTFZVNFhzdTNjMm41UGJoKzI2eDhZ?=
 =?utf-8?B?VVA3YU1GRDYvVWhNbkhtN1F2Z3pYVXFyclRQQjE0a1V0OTVNdk9DSmQrdkZz?=
 =?utf-8?B?Zm1kWGo0Y2taRGNINmo4RmFQOU15ZzRoRWc0SUZST1Y2aEoweStCdEFBblZw?=
 =?utf-8?B?NVRUNGtSMXBPbmNNS2krV1JIMFNSQmdKbnNMd2taOG9yTlVOL01VMzNyOHln?=
 =?utf-8?B?alI4cDNELzd5T2h1ZXdXL2d2cUVUSTNtS3ZySGVIRTJvaW1aWjcwc0N2QzBH?=
 =?utf-8?B?TWduVDBqOE91Vm5ieFBBQ3N3ZllmTlFmSlVOY2dqMXF0RkJmcms3d1p0VVBG?=
 =?utf-8?B?amh4RTU1MU1WRHNLRDR3WUZyQjNEb0Q2SGpEdmRMWVdHcFFjSXhjYnAwVVBK?=
 =?utf-8?B?UGlpMldsZjI0TS92YXUxNnhWdUY4cVZZdmtVTVhIRVBEcWFXcnErS0VDdy8v?=
 =?utf-8?B?bHlIN3BrSUxlL2hELzc1REowK3J5SGZlY2hXKzNsNnhLaVNMc0tORm8wWjIx?=
 =?utf-8?B?TUVnM3VxQTVYaFZOdGRnc2RFVFFNVHlOWmVveExiYUczMnRiZm1xa1dydTBx?=
 =?utf-8?B?d2NaSm83a2pZMUdGUXFNMHRvMUZhNzZUZTk5Ty9KcVRWUXRtWC8vTjdNWTNZ?=
 =?utf-8?B?a3dhQ202VzF4ZUdCYkZqb0VvK0kyZ05UQW9YZ1FLd2dsWS82SFpjMnVTUlZv?=
 =?utf-8?B?d0RnVHNqSkNaZ3JYazFKbzFJNkV4cnRwbk9yem5yVHU4T3k1dTg1L0V0QTVN?=
 =?utf-8?B?eEVoRWljQ3I3SHlBM0xZMEFSaXN4b0MwUnZkYzFQVTNUNDBCZHNKOVpVdVNa?=
 =?utf-8?B?UDgzY2xDRk9nTCtXQzJ3YitUekZVeXBrWWk4aFYxckQyOW1IUk5tSTBTMW1x?=
 =?utf-8?B?eUR4akNzZ3lkcjMzcnZ0bHArSTFOU1ordWxlSjF5WEtjU3Ryb29Yc3FVb092?=
 =?utf-8?Q?Bj8KVxVv2u4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnJCWnB5TFY1dS8wL2IzZlpRTUdBZ1NVVjRGenFKZkJDbmZHY242RDRjQmVv?=
 =?utf-8?B?VzlVN0hLejNXZ29IcHpjeVIzMmo2ZGptRzM2ZmhhUS90Tlp5OG1WV2tKZncz?=
 =?utf-8?B?bWdEamRNUUtTQlNzeUtlQkN2akU2MnBOazlLMHVrM3hkd0dpSEt4U3BLdzJq?=
 =?utf-8?B?dXVDcmx3LzlSMmNCVk9DeGN5RDFncUlCUEwrVDN4ZEJwbGgvTURSNDdBQUdr?=
 =?utf-8?B?dWx1c2hYWWp1UUF6RDFWS2Q1ZTNTSThVV0o4UVV2dTZTZjVWTlpoZThMb0Nh?=
 =?utf-8?B?K3hCUGhhODNPUkZhWTNUa3dPYkpHVUNHV2VxYis0Z1RralF1T3dKbmQwUDRX?=
 =?utf-8?B?aHhjVUMrZEFzTlJHYjVrRWMxcjNZdEczQ09zb3NyOTN5a0p6ck93bEpwMXVJ?=
 =?utf-8?B?OXE2c3MyNG92UUxWSU1Ia3hKTjRFVzVEd01KY215aS9id2lkZUFoOWs3UXNj?=
 =?utf-8?B?NXZzamt5aUtKamNCeGdNOWlZdzBaZnIzZWJHNStKTVF5Z3JnODVvSGNPbUt3?=
 =?utf-8?B?YWVtK04vMHNvc1VOUFlQQXJ0US9tbUt6Um4vVU1yOWNScGMrT0ZDOTFtYnhN?=
 =?utf-8?B?V0xTc1dqengzTkJ6Z00yR2psQVpYT3FsK1pxTi9CdHNFdmpEZXVTZi85U2dS?=
 =?utf-8?B?ZTBIOGk2bXJrNzBtd3ZRODFWby9qdnRLVmVheU1RS3pMNyttS0k2TGxJT0Fm?=
 =?utf-8?B?d3ZFdkR6Q2VtWG9nbFd6Q2s2UXFpclcwd25TZTdvUy92QmZieDRqUFYvUkpX?=
 =?utf-8?B?Ni9HazJIY0ZFOTFGeGUvdzR0UDRhY0crYWpiN3kzVmVaamczRjIwZTY1RWIv?=
 =?utf-8?B?YU9DYjhra0dUWEpoaGtLK0hoYUxLS0VNYjV5aXlWaHFoSm05NWEybmg2QmRu?=
 =?utf-8?B?TkJ4YXovN2hmVjVnR0tjOGhHaHYwMS91MnMvWHVSNlRzN3Vwb05NbVY2SHpV?=
 =?utf-8?B?SlE2Wm5WMjM0QTVFcTdhbWpiQzkzY2RNeTlRdWdPWWQrY3ZYOFJFbmtyQUto?=
 =?utf-8?B?NElIcDZ1dWdreFBVSHdKVnVsQWdQY0tFZjJ1WVYwQU4yYlAzUUM5R21QMXo5?=
 =?utf-8?B?cktmNVJCZWVYdHgvdjZ0K0w1TTZZRXU1czVya3J5aWFWdzAyYnF2RmxBMUpa?=
 =?utf-8?B?cE1qdzcvWEx1anBXMmRFL25zb05GNXVsVzVMSnU5WXFFOW1hVG1MRENseHl0?=
 =?utf-8?B?RE9TYjJndVB6ZWhoWUtnQ2ZES01Vc0dCY3dISm9SNTBiR0YraEhVRW1YWlhY?=
 =?utf-8?B?VE9ObnNwNkQwZWg2ZHphK2JQNFZNK0JhYXhsWUdQamRQOFBlNGhkMnlmb3do?=
 =?utf-8?B?NWhwbVM0dC8vL1JHZm91VExrdk9xUGFMTkpMRlBOQ3pWUWl4cU5LTVdDK3BK?=
 =?utf-8?B?STRQdGNBTlNySS85dVJZanNUMlNXclliYkY1U3FPWTltUFh2Z1NydE13TU1k?=
 =?utf-8?B?aVpDVTJNUGY5aVoxY1lZMjRGWjVHSFpYM25LVUVtMXY5aXI1dlpHeXphaFY1?=
 =?utf-8?B?ekdBRXNFVEZuUkc5ZzN5Mkd5VEtXdlZBdWlkQ3h5MmQ5eUNmTXJYYVJiSXVi?=
 =?utf-8?B?MUJwK09iUStTdGFXZjdWdVgvZ1ZKWlJibExKdFBMNFVHdmJiUHpybm9IRUFr?=
 =?utf-8?B?cmdoRGdwTk5aQTVCSWlsbHVtd005N0ZHeDdvS3I1eitqV0dIOXV3eSs3Ukdy?=
 =?utf-8?B?R2U3N2JqWTJNdy9zNzNOWTh6bHN0K0NSb1hQelZ4MVhQRG4yTWs4bkVGM25s?=
 =?utf-8?B?dEJvKzg3NmV2cGkxeEw3dlRFVUxpcnhueFcrUjdDeFZHWExRWHF1OUpXR0lk?=
 =?utf-8?B?MnlyNkZKbUVtY1ljcVB5YVpaMFpIMU10L1RDZ0VqdklPV053SnA1Z3pISEE4?=
 =?utf-8?B?Uld5OUhYTUFwNE1ieGcrVGJXYVFLUGtrOXNXc29zZlVEOFRTWTcwbnNpenY4?=
 =?utf-8?B?d1VSbzZDa2VCbVhmYmFOZjJHZlIxY0dQMVBvSUIrQm80WHBuTHZOOFROa1l0?=
 =?utf-8?B?STZaMmJvSWUvdUQwMEo0cjhwUTNPaVM4bmlhbm1GaFVQS1JhQ0VacTZxcVpU?=
 =?utf-8?B?bGJoa1ZEM2E2NnFxMkxxUXRUNkNpQ0Rua0llbzNsMUNkWFZYT0doOXlSVnZR?=
 =?utf-8?Q?gfzTz8BlrKnCxuBXAcfklUh9R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cdf2e1-549c-4818-0da6-08dd85f6982c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 01:47:11.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYupOXGfCFAbft0N6P6VR8G2qkPiP5cmA45wlNFIFlXHMweoBWj6Z3cDowyTJSuzByNHzG3D93XmOfsGuhMRdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251



On 4/25/25 05:00, Jason Gunthorpe wrote:
> On Thu, Apr 24, 2025 at 05:49:20PM -0700, Tushar Dave wrote:
> 
>> In the above topology, we setup ACS flags on DSP 0008:02:03.0 and
>> 0008:02:00.0 to achieve desired p2p configuration for GPU and DMA-PF.
>> Apparently, this creates multi-device group with GPU being only device with
>> PASID support in that group. In this case, set_dev_pasid() ops invoked for
>> each device within the group with pasid=1 and doesn't fail.
> 
> Hurm, it doesn't fail, but it corrupts memory in the driver :\
> 
> int arm_smmu_set_pasid(struct arm_smmu_master *master,
> 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
> 		       struct arm_smmu_cd *cd, struct iommu_domain *old)
> {
> 	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
> 	struct arm_smmu_attach_state state = {
> 		.master = master,
> 		.ssid = pasid,
> 		.old_domain = old,
> 	};
> 	struct arm_smmu_cd *cdptr;
> 	int ret;
> 
> 	/* The core code validates pasid */
>                  ^^^^^^^^^^
> 
> Which is not true after this patch.
> 
> The core code may not call the driver's set_pasid() function with a PASID
> larger than that specific device's device->dev->iommu->max_pasids

Yup. And I should be adding similar check (i.e. max_pasid > 0 ) before invoking 
set_dev_pasid and remove_dev_pasid (as Kevin already asked earlier).
I can do that in v2.

-Tushar

> 
> Jason

