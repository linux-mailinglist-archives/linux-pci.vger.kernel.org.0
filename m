Return-Path: <linux-pci+bounces-34741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9555FB35A07
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 12:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBF13B5640
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 10:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B8279DAC;
	Tue, 26 Aug 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N3dFuwbc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D52BD5BC
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203783; cv=fail; b=Xr90mjeo8KaKqxW4HWLnU83IOWWaXv0h30MdPgLxAnJtpoqMRtxcQUvVxC86PkZdpDm3jcVHRBFQadEUrVRolMxXyA0vGLBLulR/j1L/EeyBskhTZrn1uO8K6CRlij2n4ip1lEqs1Nl0AIlmrWuOyDCq9c1Ld4lU8HaEEkg5l2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203783; c=relaxed/simple;
	bh=eg7X/YjessPrxi2ujg+jIlr334oHXgQ5z+QE9j3cf7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tUB+Uf3P4+yuxXs+OkIADMWsRnaKr/n8O1V4VOrpUVx5xuP4ghFo+3Qjrs5iEDhpdDI+hrOuTJHHTw1NiXl+O9FCtKTggnp+rRVuGWwMllXGzzwUGlrrM/wyQJL66RkKygzrD2Ob4XogJqTw52Yio7GvI5oBqqRMvjH5IOnTiZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N3dFuwbc; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSPbHBQQagEli46xgLVu4iqDb8zDiM3z2l3jAz+4AvXUN/KvrsuwfkMl0omwaQwHqaww52B5+gLgmoU85DHILxupgoUAX8JsdASHcXHCuaBYW09Oyld8/ERTRtIcimfVxxkVTS6AZzeVuEMD21fsFzWK/cvOT5ibkynfOeb5MGvT/ZfeqWAjnObxbs8iJ2cceBZsgj9CXkhjNVWJ4nT3gZT7/zvWTk1Zrwy4L4xxz0opEfpCtKokQs+nTp6EjK1/koTGEnVbft8NY7SArfGrO04Tb//o7gCeBQ1nPfA0BRDJWpZcY0iL692ijoQxzmohNJcQimf33nBGDlwi7SmjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWPC6ihw6kHMpBPCWdcAhdWXYfXfghQf0+splD2J+6g=;
 b=ywmKdxvCGdOxs+QpSHL3wiO/iG7jJRdoHjZG8S+IwTRjFiyaIWVnbuPm/Ci2KBjHO4FNzaKipjSOvIvUUuOmIxEvJ97QsiNfsm43p1V4ljlNlaUXWWa++mSrJocWINWdwVJy8owbGfJ2YPKOml4lj070yJvSdQReVmSMpqLm/AZrrNNcM+TOOdDJGz/1BNuW49ZxdW468bTY4NzxImGWoYHDg+pLvmbY82Wpr35B42XNUlmXS9n2aVGV2ag6dtGJzoQVMFqYFUMjl5Wo21oyl2jWFZDL/ksAcxXHeSbBZFMrKvJxP9Ul0GUPCRuV6H++KAgdgqHbq7ILRzIb9yM2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWPC6ihw6kHMpBPCWdcAhdWXYfXfghQf0+splD2J+6g=;
 b=N3dFuwbcDUYZjTqc/4NI7NRZfIEsC92TFx78W8T9BNEUOiFTDwJVVOBCCuXFJpW8E4OJXcUWh6+Ivbi/J48luyJNZHqrxLcuOdOh/0vPi2VK+3F0/njdADHa4i04efPMBTUybyLZzbfviyp1nEGlTGh7cPP8IYwDPH7/80EYKhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 10:22:56 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 10:22:51 +0000
Message-ID: <80d568a9-f9a7-49b2-ac46-f3b4879c5066@amd.com>
Date: Tue, 26 Aug 2025 20:22:44 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com,
 Bjorn Helgaas <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250516054732.2055093-4-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0071.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::22) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 9238e584-edf9-4954-0a61-08dde48a82a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MldFWEMvb2FJdnZKOGI3M2Y2RFhuSEQrZDFwVW5MOGIwOFRFaDVVanExN3lG?=
 =?utf-8?B?YkZDU1dUNkc4QUx3RkxnSWNhclVEajlGN2JLcnlPNXR0dUJic1NyUDVsMG9R?=
 =?utf-8?B?VjNaMlFhOTA5MW5tNkp4U1BuRVJKbE1HZGU4SERobmtTck5FKzZzek9EWGV6?=
 =?utf-8?B?bC9UUDJnbXkrQ1FMSWFqc1J2Um5jRjZmL09jUGZocW8wckRWWDNuNUdsbjR6?=
 =?utf-8?B?SjFqL0w2Zm9lRnBDSGs2SXlMNFdNVjVUNDNPbWJEcUNwMTVQVE9hVVRQK2FK?=
 =?utf-8?B?L2ZZbWxSUXJQT2o1bWgwalRaZ05tWXo1alBOZUxOWW1lSjFGM0RWZWdsek8w?=
 =?utf-8?B?cWRESVMrclNGL1h0MWVRbTJ5N3BERWgxLzIzZ2dyRlRKcEtQMnlFVTluQkV6?=
 =?utf-8?B?dCtKcm5SaXpSNTN3ZE0vQUdNSjFNRmtUQlVBV0JWZ1BXNkJsYUpqM1B5bkJ3?=
 =?utf-8?B?aElOaWd5RlZkUTA3Y25jZEI4T25SbFJhTlFHbm9PWGZwZjlhaWduSFBCUXBi?=
 =?utf-8?B?VkQ3QWtHRFlwNW9WYlRLUFhlVE0yVU1mU0crUGI2OU5NN2JSUGhNRTFrcElw?=
 =?utf-8?B?UGFkZU5NTTYxQ0VZdnNRclZLWCtNdXJSdjBad3pqazhNOFo1Y2ZXL2pmcWtk?=
 =?utf-8?B?VG91Qk10aWR1VVNUWmZOVE5hNmZrMVhGSnJsU3Ard0w0QmxHMDhVSE1DLzFW?=
 =?utf-8?B?dHV6ZGl2dkQxZnRHMTNaWG1tQU1uSHAxUTNsM2FCWk9BS2NBc3ZlT0FCSUIz?=
 =?utf-8?B?TTVjb0xmTVBKbzl4QTFpUXdJVDVGVFV3SGRkbDBwT3RQTElmS1dtMWd0dWhi?=
 =?utf-8?B?YUw0NVlkWlFBN1Y4K0EzdzJjRElFclU3Q2hlV1RPMVpjdS9FNkUvejdLS0Vh?=
 =?utf-8?B?dGl0S0JDVlBpWE5TcnNjWjdxYzNDaWRVd2lkajF2clFSV0xWQlpaNzFudENF?=
 =?utf-8?B?OXVlU3BHYlBlN1lsV0FzeXpsaG0zWE9BeHdEVVFqNitRREhiZEhhbTFHbllH?=
 =?utf-8?B?QUZCaVFsVWNqU0VXKzJ6MHQyMEZVZXJZUDg0dVB3d0JSeHphS2FEU3hGYkhj?=
 =?utf-8?B?TE5ZMWN5WVprb0ZwMFdmWkU5bUkxeXFNUVhOWHdKeDZXWVcyWnJWU1BURkFi?=
 =?utf-8?B?UHlYc3VwK0h5akxiaHNjN000WG5HdHZuc0kway93UzFBYlNUMVVhcmhYaGdi?=
 =?utf-8?B?RU9GdGs2d3NNeS83UDZqZ2locE9WVklrZlliZ1h3aDJPOVlocDlqU1pXL3A0?=
 =?utf-8?B?eDhURkh3MHpVaVF1VGNXNmZTL09rRkpCRlVLUHhLYnhQeHh1bDU0M2tYT2hZ?=
 =?utf-8?B?TytUUDVIc0c2NEYyVk1QMkhWZ05LZ2JobEU1WWlvM2toYU85d2Vhc1FIQTl6?=
 =?utf-8?B?bUJpWGppSVdoMFJWTSs1SjRYU2VYNkVHWVFmTTFzTnliVTZqMFU2RDQ5b2NT?=
 =?utf-8?B?M0VNRGVlL3dZNk9PVWF0QmlqYnEzSWtkcEhCU2tvNXZCQTJqbmU1cytXcFpa?=
 =?utf-8?B?K1N3bHRnMVByTzhlK1pYU0J0WmU1ek1iYjRFd2Q2UFU1Z29vMWZaSVpMUWlK?=
 =?utf-8?B?U2cvQ1hjTzM3bGlHeXlwSGdOUzIwejFlZlZIdmZtdmRwalZGWmtXVTE0WnFq?=
 =?utf-8?B?ZXBueW5KbVd6RlZWVk4yY3p5d05lcjAvSFlLTTYzbkU4enVNNlE3bEVRK0Jj?=
 =?utf-8?B?UlpPQ1hXUkNaWjZqS1M1bjBObzNZYVg0K0VEZm5jekxDQXRjNUdlVVdKclVD?=
 =?utf-8?B?dGcrQWYvL2p0TmowRFBiV0kvVmJSdHFLVGNEZzY3ZWQ0MHlPTkMwT0lKeFJa?=
 =?utf-8?B?WUt0aENXMEUvdEF0NWw3bWhNalA4MlhKNTBFU0t6dy9FY1poOGpPV05VNTBj?=
 =?utf-8?B?ckg1TWNXWXQ5c0IwakRHd2ZkQmxqamNpUk9MZGNFcWtHTlF0a3hmVXk2UHdr?=
 =?utf-8?Q?4Vb1h/bBaKw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVJrT3dYZURkUk03ejJiVURxNDhnVFVLcjNESEw2MEg3VHpHTXpNdSs5UnFq?=
 =?utf-8?B?YlAreGlhQmQxL2VMTG9JLzF4bFlWaFNXSlJsMjJURDkrNUlOMGhlQlRqanBF?=
 =?utf-8?B?eVRlSDZBUGkrQnJjbTdXNGtiaWNaZlFPWC9UU2hzcDZJeklFOG9ucXdQRG9x?=
 =?utf-8?B?L0cxL1pQbElweUs5QzloM0hQTWF3ZWwvNFFSOFdIaXFVN1E5b0VQYXA3YU4x?=
 =?utf-8?B?REtjNXI2V2ZzUThhVmNBWXY4UGsvQTlzbTB0MkVxMWtCSmplN0VpZVVDRVU2?=
 =?utf-8?B?aEJyTHJhL1pXcm5FMHRjNSt2M1VjWDM5bDJQc3p5bCt2empROExIRkdTNHBR?=
 =?utf-8?B?MjZpQ0RyZDRWSzByZFBGcGdwMzJoZjFHVEp5bU5yQm5SRjdwbmhPTjMvYTcy?=
 =?utf-8?B?eGZmRXFFRnpYaEd2UGRveitZYUhVS081bmRlWjRqY3FMY2o5M0oyS3lsV1lN?=
 =?utf-8?B?eDVVSm1uamlQb2JuUXVqeVAxSTUza2NxR2JPVm5iRjZVeFppaytlWTQ4em1I?=
 =?utf-8?B?Y1NvUFZsNk1pZmxjTTVmUExzMVJGUjFGOVVSZVJJMjlZT3hPNkRYS2o4RHJa?=
 =?utf-8?B?ZklDemhDdnEzWTdVa3cyY1ZDRlFBWmZMSlZNSzZyVEpKTnIrQWYraXRlMEl3?=
 =?utf-8?B?b25iam9OZnJ4a1FRSXYyQlFTeUQ4YnJWcnZPR0pGdG1EbGdKNjVKYmVZTjFR?=
 =?utf-8?B?Q09qcVczdVIxd0dXM1RaR2RndnpNaHNBTUJOcnUyTjI3QVc3bnBOZDNrR0p1?=
 =?utf-8?B?K3p4Z0x2NTZLZEI4dkpvY0JuV1QxYnd2c0U4dUZDdkM0Yk5WdU9GOHVDZkw0?=
 =?utf-8?B?TnZWS0FRdUx4NlROUFJock9XU1hPcmt6RzNMME9JZ2x0ZDR5S3RVKzg3QmRi?=
 =?utf-8?B?MlEvY29YL2xINnBnQ2tnVXZINWtKdS9BcGdtVDVYMWpxQWtsWFgyMDNuZnFl?=
 =?utf-8?B?ZG5JaTZUdUlkK1FibzZiUWtEcUc3bXhkelJybks1R092NERFdmtOb0JKUlMz?=
 =?utf-8?B?NmN3QmRzTzlMRkhGNndySlczTmR1Q0JxWUM0dFh3VWlKdk9FcW8vOEp0dmZz?=
 =?utf-8?B?SGlCNHVVQ3E5aFdsM2poVUZQLzB2NDd2VW1GTms1dDhnN0dGcHd0SkVxdTBk?=
 =?utf-8?B?dVVDR2dtWGt1Z2lQVVNjbHVqR09Eak9yWVdURVZYL1FSRllyOWxFMVpJSHZj?=
 =?utf-8?B?M1RiNWtaT3ZCdWd1bWdFdSt4ZXByT09VYmFoZHJuRWh6V2wvMnFrY0xtRjE1?=
 =?utf-8?B?bGhyQWRON09QYmtxWXcyVXl4cTFLdkN0NkhsL1lNVmd5ZWxJcDV3Ykk0N3ht?=
 =?utf-8?B?STY5a2R6NlRsb1BHSExhazFTa2tvcEtqWE5TWDFHaXdEZmJuSEgxcDh6V2Jo?=
 =?utf-8?B?alUyVmRNdzlmeDMwTHlqcHpWNlJJT1NkNUJJeDNPT1NQTTZjaFBTR3VWbXR1?=
 =?utf-8?B?RVpUeGwvdGRWdkY5SzNCSlhMc2hmRU9DbFhFUXRrK3FwL2t5VmJYaXB3MXVz?=
 =?utf-8?B?QWMyNjJnOVdpM0R6QlZmT25OTzNSYmFGMGRVeVkwaXM1YXJqZVVSZVpHalhT?=
 =?utf-8?B?ZmZBSjJib3dzNzNqekY2aGJ5bXJ1TU0wVnRJd1A2Ym5wRmhXUGoxbmN3SU5i?=
 =?utf-8?B?ZGd6YXhkK2lkdzRHTnJ3ejJKQjNhUFUyTnl3YVZqNDVqNUREMjREYjBoRytM?=
 =?utf-8?B?Q3FnQ2VBZU1wKzVtSklNajQvdU4yT21xa3hkcHJlM0RvdHZnZmdDQnZxY1Bz?=
 =?utf-8?B?V1o2Q1lveUN0T3lId3EyV0YzcFBxQmxWcVR2OWJFeGtaN3RZSDNVS1p4MmtR?=
 =?utf-8?B?ZUovTnpqSWQrMUpHaXJiTVl5TjhPeUV5RXVlQ2hQTkYwNkx3d1lDcU9nbnZk?=
 =?utf-8?B?SFNKMHZsTlFSYUhiQkxmUnZudW9zckFvYUtzV3lHdm9ZVEJtK1JaWjZuR2Iw?=
 =?utf-8?B?NEx3TGdnMCs3S2J2ZHlnZDZLVEJzSUJVZzFreXBoWExCQWZsMkprSVU4bHM2?=
 =?utf-8?B?OEE1MVFIS0ZlQkFsOVJzNzZiMTVraTRpeHJiak90NHRTS1FsaUR5L3l0TjlH?=
 =?utf-8?B?Y3hBMUZxU1F1VXpTUThNdk1TWTBmUHI4VDRJVjBTY2l3REhOZThua3dnZERC?=
 =?utf-8?Q?GgFUj5fDtWLEt3V2REj3u4IQ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9238e584-edf9-4954-0a61-08dde48a82a9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 10:22:50.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqkjcE4tJAM2rbyt6gxdSvV8+SDPvUet1cpRBEVvCPqBFwUltmzhz9U4HRuh6hvIWMDFRanA9JKL/KUR4ahvnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421



On 16/5/25 15:47, Dan Williams wrote:
> The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> protocol definition builds upon Component Measurement and Authentication
> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> assigning devices (PCI physical or virtual function) to a confidential
> VM such that the assigned device is enabled to access guest private
> memory protected by technologies like Intel TDX, AMD SEV-SNP, RISCV
> COVE, or ARM CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a "DSM" (Device Security Manager) and
> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> to setup link security and assign devices. A confidential VM uses TSM
> ABIs to transition an assigned device into the TDISP "RUN" state and
> validate its configuration. From a Linux perspective the TSM abstracts
> many of the details of TDISP, IDE, and CMA. Some of those details leak
> through at times, but for the most part TDISP is an internal
> implementation detail of the TSM.
> 
> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> Userspace can watch for the arrival of the "TSM" core device,
> /sys/class/tsm/tsm0/uevent, to know when the PCI core has initialized
> TSM services.
> 
> The common verbs that the low-level TSM drivers implement are defined by
> 'struct pci_tsm_ops'. For now only 'connect' and 'disconnect' are
> defined for secure session and IDE establishment. The 'probe' and
> 'remove' operations setup per-device context objects starting with
> 'struct pci_tsm_pf0', the device Physical Function 0 that mediates
> communication to the device's Security Manager (DSM).
> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem
> synchronizes the implementation relative to TSM
> registration/unregistration events.
> 
> Thanks to Wu Hao for his work on an early draft of this support.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci |  45 +++
>   MAINTAINERS                             |   2 +
>   drivers/pci/Kconfig                     |  14 +
>   drivers/pci/Makefile                    |   1 +
>   drivers/pci/pci-sysfs.c                 |   4 +
>   drivers/pci/pci.h                       |  10 +
>   drivers/pci/probe.c                     |   1 +
>   drivers/pci/remove.c                    |   3 +
>   drivers/pci/tsm.c                       | 437 ++++++++++++++++++++++++
>   drivers/virt/coco/host/tsm-core.c       |  19 +-
>   include/linux/pci-tsm.h                 | 138 ++++++++
>   include/linux/pci.h                     |   3 +
>   include/linux/tsm.h                     |   4 +-
>   include/uapi/linux/pci_regs.h           |   1 +
>   14 files changed, 679 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/pci/tsm.c
>   create mode 100644 include/linux/pci-tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..1d38e0d3a6be 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -612,3 +612,48 @@ Description:
>   
>   		  # ls doe_features
>   		  0001:01        0001:02        doe_discovery
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Date:		July 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a physical device function
> +		supports authentication (PCIe CMA-SPDM), interface security
> +		(PCIe TDISP), and is accepted for secure operation by the
> +		platform TSM driver. This attribute directory appears
> +		dynamically after the platform TSM driver loads. So, only after
> +		the /sys/class/tsm/tsm0 device arrives can tools assume that
> +		devices without a tsm/ attribute directory will never have one,
> +		before that, the security capabilities of the device relative to
> +		the platform TSM are unknown. See
> +		Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect
> +Date:		July 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Writing "1" to this file triggers the platform TSM (TEE
> +		Security Manager) to establish a connection with the device.
> +		This typically includes an SPDM (DMTF Security Protocols and
> +		Data Models) session over PCIe DOE (Data Object Exchange) and
> +		may also include PCIe IDE (Integrity and Data Encryption)
> +		establishment.
> +
> +What:		/sys/bus/pci/devices/.../authenticated
> +Date:		July 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		When the device's tsm/ directory is present device
> +		authentication (PCIe CMA-SPDM) and link encryption (PCIe IDE)
> +		are handled by the platform TSM (TEE Security Manager). When the
> +		tsm/ directory is not present this attribute reflects only the
> +		native CMA-SPDM authentication state with the kernel's
> +		certificate store.
> +
> +		If the attribute is not present, it indicates that
> +		authentication is unsupported by the device, or the TSM has no
> +		available authentication methods for the device.
> +
> +		When present and the tsm/ attribute directory is present, the
> +		authenticated attribute is an alias for the device 'connect'
> +		state. See the 'tsm/connect' attribute for more details.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09bf7b45708b..2f92623b4de5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24560,8 +24560,10 @@ M:	Dan Williams <dan.j.williams@intel.com>
>   L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm-report
> +F:	drivers/pci/tsm.c
>   F:	drivers/virt/coco/guest/
>   F:	drivers/virt/coco/host/
> +F:	include/linux/pci-tsm.h
>   F:	include/linux/tsm.h
>   
>   TRUSTED SERVICES TEE DRIVER
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0c662f9813eb..5c3f896ac9f4 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -135,6 +135,20 @@ config PCI_IDE_STREAM_MAX
>   	  track the maximum possibility of 256 streams per host bridge
>   	  in the typical case.
>   
> +config PCI_TSM
> +	bool "PCI TSM: Device security protocol support"
> +	select PCI_IDE
> +	select PCI_DOE

select TSM

as otherwise:

|| ld: drivers/pci/ide.o: in function `pci_ide_stream_release':
drivers/pci/ide.c|276| (.text+0x620): undefined reference to `tsm_ide_stream_unregister'
|| ld: drivers/pci/tsm.o: in function `pci_tsm_pf0_destructor':
drivers/pci/tsm.c|434| (.text+0xa1): undefined reference to `tsm_pci_group'
ld: /home/aik/p/tsm/drivers/pci/tsm.c|435| (.text+0xae): undefined reference to `tsm_pci_group'
|| ld: drivers/pci/tsm.o: in function `connect_show':
drivers/pci/tsm.c|201| (.text+0x1a4): undefined reference to `tsm_name'
|| ld: drivers/pci/tsm.o: in function `pci_tsm_register':
drivers/pci/tsm.c|462| (.text+0x28e): undefined reference to `tsm_pci_ops'

etc.

but this is kinda wrong as it is quite bizarre to call drivers/virt/coco/tsm-core.c's tsm_ide_stream_unregister() from drivers/pci/ide.c's pci_ide_stream_release(), i.e. "virt" from "pci core". imho the caller of pci_ide_stream_release() should just call tsm_ide_stream_unregister() too, and so on. Thanks,



-- 
Alexey


