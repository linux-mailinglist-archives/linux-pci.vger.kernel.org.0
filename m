Return-Path: <linux-pci+bounces-28817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D993DACB9D3
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 18:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A729F3BE5A6
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B087221280;
	Mon,  2 Jun 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I+fb06EC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593042A8F
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748882944; cv=fail; b=mIALQyI5I9xCgOCNIEHvfAMTWsPICFTT+i5zTzIUv+pvVtj8rBSWhLLp0JlU9CAK/52d+d83xLlPH2kzptmO//C1iSnITByPuFu23A6lCH0miQseN3vyhhVROSM9ahegMhLEyVrXhkaCsPiApzNOepjdgGnh49akJH9/A/mgBc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748882944; c=relaxed/simple;
	bh=jzy8xZgMXtwjFrAP/UVGVbc7xfo9UvNFkLrHxYFPVuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VtfI7w70ueKtfnrDmQDqwhZGDveN2zIo5Hdm6yyRNer0I0hErdRY/qldWRYxLZ9qCKQ3xxTW3lLyh5WL2DI0vh451KfKjfs+d0+MF+TerCAjjJz7MqTrYawwn1AwCki1WfGt7FTD8gwIppzbkBVvWCc247Kv2isSjtWWwWr8MU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I+fb06EC; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCZOxhjFSNg8FwLDdR9eG8wDoThW1G+fA19P+Pzn48b3J9DFkV6jgRoYnbSGjjQwWEltVcVV06VxDvW/tN82tUYNoBh563XFzzYKpZMb++2coy37ELW92nVUYE9891fYzsEHc/Nn8TWKGTDosZmbfhSmVeCxlTy4MgvsAmYpDZa4pD2ujy6Q6vuRCP7CvjDcAOpXLmO5JzGsGofxMltUoE2Xfu+cAy5Nxyj2znluSG4HdBzDCynSY9RoIkMwYE3a3FkkeEcnR1Ppw6c9VYJVgPXagt2TCJF5H4DK3X2PSETXgZfGpVMd1IGWEsOI9a1Pt6k7Y8N7+5qBRqGwRCiRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/c6OawJ8mtlAldvZhIMHmiCJCJahFzFDq/13v0flbc=;
 b=ECW2KqTurPbCmnEC6qV4V2FSgJoKNAPWJ6l/5zSEZxmgNtB/9d/LsMoR4pM96+Ntm48dwVzaK7bWwrhiwjxQKZ1s37jWxDifJNDjweyUVZfRml8PjmUKoR78EwVk2Mw8jgAMxb1Q9GF9eu48yQ3atX8dfdrp8bPnRp1E2ZS5aRNW1X9OWreDM4/IRuqIa/hJLgzAyZh4bF6sDEKwD4PrbwiQxfimRMFF3/rQNhebOClGvurNZUudxcJf1E3vQQ/oJFv31sYtOHqCW2/N3gOwh1WzlH4ARzvbnTcmzGiRVpMS/mFlxlVVAEcEEZYjciLLoOuVEu6Sv7G1VV1Id5zLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/c6OawJ8mtlAldvZhIMHmiCJCJahFzFDq/13v0flbc=;
 b=I+fb06ECoX4ASdB9FEniLOMn22IZK5zGP+kLFxBR3e64VfxqCGRO3toDmuyl7GtX7ED1I/r4qsov/MlJw/cJqQbGfpcO0dBKZztjEnO9b86p0KZE9uy9NDqBJztibrV76ycSh1Rk5mAZ037VIMbfa1JcOba3oGsmbd5BCFVhh2KMxlLwYTqY2TU480m5vQg/0PMfBRzuuBn32Zv3Gl6oFYZzW2cAFWCkzcEJUbtuni9M5VITUM71EI5a7NKSOhGoxf4oKN6HBPB+WSnG4H7Wy9jhcnJRR0dvVViJVN8Bd82Wo2L+ttXSqleMXzosk7GiFhxijSAJfeG9AF8hpitdtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 16:48:59 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%7]) with mapi id 15.20.8769.033; Mon, 2 Jun 2025
 16:48:59 +0000
Date: Mon, 2 Jun 2025 13:48:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250602164857.GE233377@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BN0PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:408:ee::31) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: cba8c336-dfa8-4ac6-5203-08dda1f55edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHk2YnFxTGNSK3Q4Z3FjbEVEQWg1dnJMbXRpMmRCOXdvMVhPS0NzREdIdnhU?=
 =?utf-8?B?TlVQYnBTc0dUcnRISHhZQ2RZL1Z0cEpjSWp5UXRQVEJ3dGFGSnRPQ0xyaUNB?=
 =?utf-8?B?MmwvU293VSt1ZTZqTlM0cXo3b1JWTWRCT0J1ZWZpNkJBTXRsNU5ML2h5dHFz?=
 =?utf-8?B?bE0ycTN3MXVtL1NXY0pUSXQyZ0N5ZTBqZmZqdXBNZXZnUEIwdXg4dXR1bGVT?=
 =?utf-8?B?L05LWURrMWJaZ0lna2wwcEhjbmhPVlJjdElNNStvSHlXcVhYT1I2ckFhQVMr?=
 =?utf-8?B?SDNMUGJCeEdJb3Y0Y0o4WFNzbWNlaGdKYzhhVnMwcFBtdksrTy9FR3RJSi9U?=
 =?utf-8?B?WE9palJBRVhLWUZHRVA1dzBYbDdzQWN2M0ljTW1NaThOdFBBMHpLemluVFFX?=
 =?utf-8?B?YjNhQ3k4VEx0L3ArYkVHeTVuT1IyN1JWZ2tYN09xZngvUDJtVmZmT0FXVFpT?=
 =?utf-8?B?aEdNcVp0b0FXMVV3ZUdIZFZlbU5WTzJwalBBNUNNTU9hd2VEUzN6WFk3QzJO?=
 =?utf-8?B?MERLRCtrd3lObVhrU21HM0pkRWdTbUpEajdKYzZTbDNlOUFWdE9mUU1FbGJv?=
 =?utf-8?B?YlZwcko0dll4ZzhFNFlRdUo5LzlBUk5vSTdtMmovYjZqUExaNXM2RlpoOG5L?=
 =?utf-8?B?RjBqVDVrTExkdi8ydldQWmlIaFFPYVcvM1h0a21maHEyRmtmVnJzQU9ibExS?=
 =?utf-8?B?L1VYSFdYOWVDeFZUMDcydUR3QXE5VWQ0U0FsQnlUdnFveUNoQm11YzFBZTVh?=
 =?utf-8?B?VkVDdVVrYkNIdktDTTZISG9pb1VnTUJqRHpqbHlGZS9ETEkrTldBQk5zeVBs?=
 =?utf-8?B?bFlUSkt4M1lmcnowazZuRTg2S0twNjBaSlIwZ0crQ3pqOWM4VmZTNWRqcFE4?=
 =?utf-8?B?U01BR1pBOFUxcXVBdk14YkN5c1IyYm5YeXhpWVhzOSt2QVpuS2tldWhmSDJ2?=
 =?utf-8?B?WWkwMTllYi9jQkVkc2RFNkNkWXozKzhxS09mYTVoRG5xTHcxZUlSdHowcG9G?=
 =?utf-8?B?SU1STWJtZXhmdUs5cDcrSEtwRzI2QTRjaS9OdSt6aG9KOXZKK1lDYndsQXdi?=
 =?utf-8?B?TzRadlBGRzhtNlhTbDVWL0Q2T0xCMU5RR1lRVUFJTEdkVEJrVUFOQnQ1ek9y?=
 =?utf-8?B?R0xxODNHK1pjNFV4SUN3a09pdGRMVFJxMkEzN2xwOVpQK0gxK0VyVVFGV1Jz?=
 =?utf-8?B?MGh2UFRTLzRReXNOSUpxd1o5dXJKc21xREswV1dCZ2lSR3BkY2F6SnJzdmlw?=
 =?utf-8?B?RkhPV3ZFcGpoVkxibjQxdmpqUnIwQlA0ZDMwTFNsUFZWdkZHOE1qV2V2RFlw?=
 =?utf-8?B?M3pMUHhKWW5aUVNqZWtsNUhvWFFxV2VnWlVTdEgyRlQrc3NjWWdZQzZtek5B?=
 =?utf-8?B?dTdlUGVpUDV5NE51S2ZZdTNpMkszQ2JrdTV6eEZqTCtXdjNBd0JYYm1TRDk3?=
 =?utf-8?B?WGRML0JPbllEMWZsQzl6V3NGWjh3aHB3b0tMQUdpc1RBdWRHTXc0M3ZZY1Rp?=
 =?utf-8?B?QWc1Tm5GS2t5NGlDcWg0dyt4TElFdDQvdnFIWjZZYWNnWmdXS0IxWnZ3S3ox?=
 =?utf-8?B?UnBhcDRlWVlla2p6SVphenBDQU81MkUrL0RqM3dwcjl1aG5VcEgrNWpQYVBC?=
 =?utf-8?B?V2ZNN3hwUlBmWVExaDJkRFlNQzNuV21ONXlNTFhpbXdZMm1sYkJTcFU0dTZy?=
 =?utf-8?B?VjhFQVdJTFlLT1lzSmhvQ1R6MlRXUWFJS0pJZXFDVy9DdC9ZNVlnbDFockp6?=
 =?utf-8?B?Ulhub0JjQXYwN2I5bmZSSVVpNmE1UU01Zkw3alNkV0Uwc2RXa3dhQitJbmI0?=
 =?utf-8?B?djhxNlRjWXAySG5RZitzVFhoOGR2c1dybk5wdThQa0NiU1ExbVNXK1VhbkJj?=
 =?utf-8?B?a1pwRTZyUWI1SENYcGw2a1UrOEozR0twdzNvbW9JK0V5WlFnalpQM0hoVWlp?=
 =?utf-8?Q?eS98Zw2q66A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjRxNm5TdHp2TTY2c291d0xTaGtGaStPVDRWc1dKRkZteFllOGl3TlBkTVpL?=
 =?utf-8?B?eXQ5cXZIcDR5MkRRZWl5UUdNYldZVzl4Q3pZdUxZdy9JVkduV0FRSUZHUUNa?=
 =?utf-8?B?TnRPOWs4dmk1OG1RSCtIY1RrZ2hTNWp0cVBYbkFPbFFWLzFYMjRrT1VLOGFR?=
 =?utf-8?B?UHZ6bS9DNUpCeWpWQjNQN1RMVUp0MjhwcGZHMjc1RCtRNDZhQzBDbWF0SzhZ?=
 =?utf-8?B?QnYzOFdPTlNBNXdPREhDZEhiRW1ZT04vNDhkajJqbURSSGNKMVBNNzlaclZz?=
 =?utf-8?B?Zmg0M2VXSjNZVzNGb3B0aSsrU1Q2bUlYTVYxMkQ3a0lZUGZtb3Z3cUFXMmxy?=
 =?utf-8?B?clBIR1BDK2JRYVpWM1dhWm1xa3pIUTFRcU1DSDdlWDkwcHBhVWdkdVQ0a3NX?=
 =?utf-8?B?OGZJd3AwSmVXWnFCc1ZoYkREMDFDZFlJWDVSQzdLcjMxWG1IVStZeXc3Qndq?=
 =?utf-8?B?TDQwMkVoWGJjQ0p3NmZCdVBnR3Bwcy9KTmlZQTllcUpnUmYyckZWQmpzTW03?=
 =?utf-8?B?YmxDL0NDZi9naXM4d0FLN20rdlI2S0xuYkc1S2lHSTFSNFZTbWVGeEI4OUkv?=
 =?utf-8?B?VGE4RS9BL1dNZTUvRWlaSXZlZ2hIdk81UCtrcHIwL21YY2ZHdE14dThiaTQ0?=
 =?utf-8?B?TzlKYVE4TGhRcTQ0Z3FPRytCWkZJbHBnRXZkS2dsNnJsK3VlQ2I3aUJkVWk1?=
 =?utf-8?B?WHhDQ21NVjZkSy9IOWZhRzFIR1Y2V1l2cUpEN1VNRHV5dmVET2lOa1lGaStw?=
 =?utf-8?B?aGFKc2NMOHJUbTRKN3dvWkZDaEpBa3hIclBqaEtaMkZ4OW84Z3VvOHVjakZT?=
 =?utf-8?B?Y0NmbVFuYzhxZ2I2WWlDcVlpUmxKc0o2dTZ6SFhSaTNqbWNabTE3OSs1YnJU?=
 =?utf-8?B?UW5PNHNCOFlscmR6cVpGbVkxN2RXZmJoZmJzV0Ryc2VybmZSY2s1aUF2SnFP?=
 =?utf-8?B?MERIc0cvaktMS2FZcnFiYWlrNzFuNTFBVkJYNGEybjBIaHp3MjNRWTRhUGdk?=
 =?utf-8?B?TXZaZE8vUlFmVk1hRnFYOXJDSi9IdzV0WWhlN0RMaXhBTG93bWNqaFRKWDNm?=
 =?utf-8?B?U09jcGxQekpNQ1FVM0hET05mbTd3aDgzTmY2UXVJMnBseDgwN2hGVWk3eDVL?=
 =?utf-8?B?QUdIVGg5N3pUcGRxY0Q3SWtXenhGcWxYbXdoUjNFWldHTGFBVmNjbUt1SlNQ?=
 =?utf-8?B?aEFTTDN0N2haSEwzcXlhN1VRMU56V0dmdW9aY3JJRGxxbDNFUjNvMzNoWUhV?=
 =?utf-8?B?TmR3S25WSjRTb3QvQWF2YzBTanZnRCszR2IvUDdOV004RHRQU1R1dGhJamo0?=
 =?utf-8?B?Q2dYUzJlaEFHNFRhbWltWWdseXpiNkJiUi90NExsUGRkbmNmbVNxd2lrbitj?=
 =?utf-8?B?NFdUZm1SLzRUQjVwSks1VzFZTzlnTVlBd3lTeFVsOXo3TlpteS9oQXcrUlIy?=
 =?utf-8?B?dlBNa2UyK0hqSHdyampzeTE5TEJYQUU5bldNSXVOQzF2QXM2RjBaQzVIck5B?=
 =?utf-8?B?V01tRHI3MTNMbTRtd08wMEFrSWd4aDNmb2F4bytQV0tyMjJBR2ZXMTlFbEEx?=
 =?utf-8?B?M1dDcnAzMWY2QTRmRW8ycForSk8wVTlUQy9hUENqcXcvY2o4TVZ1NTh6Z1Jo?=
 =?utf-8?B?ejJCaUNwWHMzcW5jdFJDS1AyQkRHa2M1OVA2aDdWUWtFcGJxcG9UcjFUZzYz?=
 =?utf-8?B?WTVjLzlQbUxDREtEckZRRUdpbzBQbEl6MzY2blZYVTFWTkhKeTR5RVlHaW9J?=
 =?utf-8?B?aEdtdkZoQXE4cTJOTGNVR2JGRDRobUxoVTh4VlZHMW1pMzVFQ0YrSWxUUGF1?=
 =?utf-8?B?YWUvd1MvZllVSEVPb1VWQXNvSTBVTG5tWkVMeXhPSGFyNTE2RDZiVlg3amVX?=
 =?utf-8?B?c0x1L1lWNW0vYVFxVS95a2c5OER2OFBPRnpkdXJvaGpkRlFJRDdVWHQ1L3Zs?=
 =?utf-8?B?T2dTT0ErMlNpbkFUQ1lBSXY1Mm5ub29zbzVnaSszcVlIaTk5UU40K09WVFNT?=
 =?utf-8?B?YWtUSFJadWZaY2NlRGh3eGlCczZHM0taZXdUY1JTWHFtQlZHRUFHdHNHRzRz?=
 =?utf-8?B?bTVBTWk4NzdxeUt3WWJyME50UEVjcVNzSmVyVjRSSlB1dzNxK0M5RkNmRDZS?=
 =?utf-8?Q?eQSu7aSyVdjloWkvfZXJPP1up?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba8c336-dfa8-4ac6-5203-08dda1f55edd
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 16:48:58.8842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTKkYCJB5SVpUYjfBk71+N+BGT6YnhtRJatVnDTqjsrwIRUfJJ1umhcj5zhAPv+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754

On Tue, Jun 03, 2025 at 12:25:21AM +0800, Xu Yilun wrote:

> > Looking at your patch series, I understand the reason you need a vfio
> > ioctl is to call pci_request_regions_exclusive—is that correct?
> 
> The immediate reason is to unbind the TDI before unmapping the BAR.

Maybe you should just do this directly, require the TSM layer to issue
an unbind if it gets any requests to change the secure EPT?

Jason

