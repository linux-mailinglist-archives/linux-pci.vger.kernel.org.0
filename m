Return-Path: <linux-pci+bounces-14798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDEE9A2590
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607A71C231CE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9251DE88F;
	Thu, 17 Oct 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="srcilRw3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308861DE885;
	Thu, 17 Oct 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176660; cv=fail; b=QGmPlfh27xe59dzLIjkPjiDI+UVVDUHxGyEmURtNLcrU5yl8Cap/2Kc6732U3RLVV20tk7s9hEPV3UGzQ93xs4lO+mdm43f5P++TpXW9XGa1IxyFkNycmkRV7qW37+jw8jhhCuDxKeqGXDkL1eGqEbPmRSbnZMjWcwXCQeub7PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176660; c=relaxed/simple;
	bh=TIprjj4xU/A8U0VMphuwWTWfn1NoxXSlM19kkEthZh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TZ6v0oc8+fILuwqLSUU7ooIlNr6QURM4LMlJimsQyeJA8rT2kIh6TwIilwczkQtLJe0NN9PpVEp0aBo8+90k9XdGRa9x5BHW+IOIRbr4gJjToCBiQW00rVTVvWC4iQ0CVxdZrFGZCB+qE0ZuuLTPCe0RF/Tok7XCNjXzA5yMjGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=srcilRw3; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okDN5nd/nyB7qMxicHckBMCsVYsq7f49479WwsAL1Ce82dGxw6we0yqrdx1ZWw3MWkUQYFcBALAKt+QkzXzOkz6Jk45HmsoosB2Ql3aHyonpgVx2y5oSnnJdZfJP6AvkIaWZKtm8T91/g4UdhXh5NOD78ussQ66j9axdv+hmReyDBJyiqfU1dpBMgsp1XfFOWFtO8dXJn4n8mF15PUxht9RNdBlRge57aFKY+EIWgTy9MSjI8cnmmNsULOPOmScMk+RkgmMZzeC0fvqSWSd5r5+uX0dL3pg2GSL2MhV/TcJ3rJvgeP2u9zQtL/KfQP5Stf45Eur8SNgJccoRLw7S7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGznFHhLhj5AmQbJ33mBwc3tMDJ2ZAWOlMbmQ08Cy6k=;
 b=zOWdUCUAN4du01sh9JQMbtQ+PBt1UCqLg5p6i/+o4LuMGZSDCtjV95bCl0om/4xsa12/GF5GsmDgSEFswoeUOeMCus1HbIrK+ee1YPuuahURa/CFpMTVulBrm/kPRVNsAVluRCoj7sWHEIUHcp7WDeMyMVGLp27BB/BdPK3fYqClD7kJh8Egw/Ys3u55Z8Q1IBXE4fU7BCmMsHImtbqmfvIOLKLN3ZBB7jN2xVjwitduRQY2ACz5ftPCD6DTKQemwZJHMXtXY/K5tU7JEOAAvA2b8zwz+ZAVMPofhebqEwhvQREfBHDlvET6QUnD5p5KW6a+rsPGbkTC7jfCVdAmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGznFHhLhj5AmQbJ33mBwc3tMDJ2ZAWOlMbmQ08Cy6k=;
 b=srcilRw3FrkpaelGa6uSiQnPqyOq/Mbdmqe4mGmbhvmBL9XnexCxrBBSa83T0DUxR86Gcq9Ky04XJ9Sg7a1xSrddEHBYLYL8UhNCvofkPhBWrFWGfflGQFrN3Sq6o7WwfU4Qn4Y3Y+VBldXQyZpq+BJ5aIX4lr0pAe+Qn7W4IzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 14:50:52 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 14:50:52 +0000
Message-ID: <d4fea4e2-412e-49b5-aec4-7bbe8c7709c5@amd.com>
Date: Thu, 17 Oct 2024 09:50:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] cxl/aer/pci: Introduce PCI_ERS_RESULT_PANIC to
 pci_ers_result type
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Terry Bowman <Terry.Bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-7-terry.bowman@amd.com>
 <20241016173011.000021e4@Huawei.com>
 <6555a001-4f5e-40c0-bf27-38dd7a15c3d9@amd.com>
 <20241017143108.000075ff@Huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <kibowman@amd.com>
In-Reply-To: <20241017143108.000075ff@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:805:f2::45) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6e8781-a3ae-4e56-4870-08dceebb18a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjZPWHl0WG9FNW1XckQ0ZDdacjd1VXkvUmZlajJJb2JHeW5xUGJPQy9oajVO?=
 =?utf-8?B?Qm1uMDc5MURZOVFubFhmY2N6OUh2SkFSZjdmSXlmOEpnOGtSVWYxQVozV2lG?=
 =?utf-8?B?aWZwdTFXSzJveWt6STRMY1c2M3F0cytmbk8xRWpLM0FEKzVsQkkxZGJkQThY?=
 =?utf-8?B?bDRZWUt6THVsSGx6SnBSNWsyMitiWitDeXNyYTR1TUtHc0N0Q0p3UXk5VGps?=
 =?utf-8?B?M3ZWWUhOVG5BTzJTMFJyM1c2aEFtSENYR3YzbkVKQWRiZVE4OExWekdvSDBT?=
 =?utf-8?B?NU44allKaVMvSzFLa0tVVU5QK3QrbWV2UitDM1h1dFI2cmNiV1owYWdwaFF3?=
 =?utf-8?B?VUpRYWVNaEFKVFJUQlBvblBWemJrTWNFcFQxdm9lbFFzd01PL1RTQ2NxUUYz?=
 =?utf-8?B?My9HT2dhekNBc1BMaTRPODd2TitaaHR2bjFJb25OUmFrODdkYm9ydDg3UlZ6?=
 =?utf-8?B?MUo4Uk1QaFcwOTFuZU01ZTVHNXVCZHM3N0RlVjJWSXNLZTRiN3YrOXFVRzNm?=
 =?utf-8?B?aGcrc2IzOHY1NEpzclptOUVDd3NEaExqY2w4TnRkS3lRcnNPSVNCdWt3Wk5V?=
 =?utf-8?B?S0xhbXBOb2RsMkVhQ1p5UlU2VUNmdUdvWmVkRDhIaXJQcklrekFyRFU2Sko1?=
 =?utf-8?B?WmwwMG1tYmFnTUVXYk5yRjdrN1RBR2tVTTJpRnlNZzE0ZjlyQ3hQWjFPbmhm?=
 =?utf-8?B?SFJMRzNITkFSK3JYRkxwN3ZWcmdrb2E5TERFZnI4U0dkcGtqVHpmZWtuMEdw?=
 =?utf-8?B?U0JXUStlTHl0c0NXbnFITjlvU2k1T0hVWHFKb1ZSR05kZERpV0xCR3IyKzBy?=
 =?utf-8?B?eTdmL2I1YTg4dVBvTVNMZTNSbzdZRDY2MzQySDBVcmN6MlhPdm1WRDhGUWZS?=
 =?utf-8?B?UDJzdlpGNzc1S3krSnk5R2Y2OVBRZUt2OTdiZkhkWTRhWDljWnA4NTd2VDE4?=
 =?utf-8?B?SUxVbXM5ekswaGJLTmhKUk14bklEU0NwWSs5Nkw0eFpPNzNLeklWcDRmbFZS?=
 =?utf-8?B?Z0xVek5DUU53ZGIvTmZ6OXlQdmgzMzhQTGEyMnJQempBSnNUNEFCaUpJc0pH?=
 =?utf-8?B?bWZmTVFyN1JWaEJkQ2EwY1YwemU1bzdqVDB2RjBoVzhrTjJIRi9JZi9BK2sz?=
 =?utf-8?B?dU1GMTIwdy84TDBPOXZwWUZQOGR0dk9oQjFEVndQYTRuWFd2TmFzMGNFUHdU?=
 =?utf-8?B?Z2ptUE9BT0o2QjVpQTI3QzAwQm1TNkZieVYyWHBNR2NmVVZ2TmUrM203ZVhY?=
 =?utf-8?B?dm5DeFplcmg0emMxZG1yVGF1ZUlQZng0aElzYy9WcitnSHVEWGwrQU90b0NF?=
 =?utf-8?B?TTB3aXYvM01nVGlwQ1owanRTUDFDRURYMWk1MlgzRWROMHk2bzlUdXJwR1Rt?=
 =?utf-8?B?dmxCdVB5MHNDam8zcUQ3cmVJczNFZUZuOVpBN0t4anA1Tnp6SlVmMTFRNWdY?=
 =?utf-8?B?Q25heWdTdFlFSHl3bjYxSG1XMlprRnovR0pQR05hY0JVbldFbWJTS3ZyWkpK?=
 =?utf-8?B?bitRYlhMZUJzNVVEbGdGbzdGVGVCaFBvMUN4MXZYbXFTWWdWMUdQUWh3eGtn?=
 =?utf-8?B?bUtiQ2hWYS85R202azV1cFdiVWRNWGgvQlhVYUN3YXR5TXoxVkZycVEvenJS?=
 =?utf-8?B?YndMcnB4TUN1T2FsYllEbkFDaENFbmR4cG9PWVo5RWNNOU9HMkdqWDgyN1ox?=
 =?utf-8?B?a3J1WE1nakNKR0dIbVpPbDMrYmJkU3hReDJHV0dSUzN4SnpOSzJVYzd2QjhL?=
 =?utf-8?Q?g+SfL/2p33KXb5YNciKrCvHEjhFzpU4lw9y1yd3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU1KT2NCbzVnZDV6c0NaSnEyUGZZdDNPYWZjUjR4THRyMWJ1aG80d3BCSnpL?=
 =?utf-8?B?MDQwRU8zb1U4SWM0bWxFYVlpQ2ZiS3p3N01xNTNqcCtVY3p2UkxPQVZ2SDZt?=
 =?utf-8?B?dnpOMzEwb1ZJbHR3UGh4bjNmS1VmcGRzNnBZUFJpOGY0Wmp2VU5GZ1dlU2do?=
 =?utf-8?B?bm1YdmFOVkhNa3M0czVjK25XZ0draTFvVWhjbTg5VHdQTWNuTTAvbVI3NG05?=
 =?utf-8?B?ZkZ3Y0NEbmpMSm0xa0VRNk1SWnVKUktHRWZoMGY1NnFETHJodWxlUDhnRml1?=
 =?utf-8?B?em1CcCs0NWdUN1lwYkgza0g4ek01SWl0b3BVdU5qVEwzRWtsWGtwWVZSbk13?=
 =?utf-8?B?QnZCZ2hSd2VOV1Z2WmcrZ2NVUE03eDRtblU5TUs0U1dXQmJjOUYzUXNIY3Rr?=
 =?utf-8?B?WHdTYnJUaEE0NDBibk8yUDcwRnJsMENLTjAybkp0TVpNeldVWjhuUlZDRDM5?=
 =?utf-8?B?UkpFN25yZkZhVURVQm5jTzBhbzhOcHBhUlByNXRaaFg2MGZIQzNjTlV6Szg2?=
 =?utf-8?B?dEJtc0RjS3NHWTZtWkVOeEpEa2J4L3BkZjNZd1VxajZOZ2hpeFE3Y0VodUhT?=
 =?utf-8?B?d1FvSG1Ta2JvdEN0a3hyaWlRZDRlaHdWeHpGMHh3NCszNHV6NVkvaWxMM3Yy?=
 =?utf-8?B?MG1zVHFRSTBNMUUzdTlqZXI3QVU1NmUya3laRjliUDVwZHhXcVlYejhYdnh6?=
 =?utf-8?B?U2Rtek94OTRqY3lTR2NpYjE1Y1hWSy9oTWRSd05MMXR5ZlV3L215RmJXNDJq?=
 =?utf-8?B?TTF6N0VwY2hLUituT2JPYUtIbTd4aHA2ODhKZ0o5bDNzOUJJRkdqOUhJTTQr?=
 =?utf-8?B?RWdOWld5eWpkK3FLUVZ5cmdEWStrSFNQclA4RHd6OEJaR1lCeUxNdTJ2ZnRx?=
 =?utf-8?B?YUw2OWJJVVZqWFZqKzhncXVweEgzeTIyL2NpNUFWZHh1SnIrTlhpMllhV0lT?=
 =?utf-8?B?eW5jVStIR1lSMkREUFVDSFFQL3VOWWphTFU3eWpyUkRWZWRiZWRmakxtRkNr?=
 =?utf-8?B?dHZmQ3Vna01VK29FaWJ3U0gycDJHM1lCUXE4Nnp4R09xRWk2ZzdKdHgxWXZu?=
 =?utf-8?B?N1R4YzgyTXRzMHovaGlCMFVVbVZQUjh6Wi92azdKYkJxWmUwbCs4TFkvTCta?=
 =?utf-8?B?RnZYdGxCRXZNTjVpdDMvb2NPY2pMdDczN0ZiUWZDWi83blZ6RVFEUXdKTDBV?=
 =?utf-8?B?eDNHeStrUmdURVhIbUlGc2VuSjhQOUxlbjk0ZEI5NDNXcjFCbCtEZUhzUGNj?=
 =?utf-8?B?K3lyNDhCRGdPaVAzaWU1bFpWUTk0Myt0S0tsbTFvalZVYnh2Zjh0ei9WK2tv?=
 =?utf-8?B?TzN3c3JwUVNvejcwaWRSVGt4c0N6akJYaDBkY0xNckd3aTYwUXJuTnJraXho?=
 =?utf-8?B?cnRmclA1MmVnZDRnK2dkTjdlSzB1eDVDMzB1SXNmb0huekVLalRZQlFmelRD?=
 =?utf-8?B?blZTUE41WUhyQ1NtOG9Vd213ZjJSaDB5YVp1L2hnck5nUUpQWUJPQ09XVXlU?=
 =?utf-8?B?YzNwYnRGRmdKcmNUSXpSZ1RlZVQyUXdVbU9LUmNLSnZMRzI3TGFWUjdrcU9W?=
 =?utf-8?B?aHdKWXpJam5OMmpXeW5jMXlOKzJsT3dQeXlHTWlvSEJiMU1xRTVqcFE4OXVN?=
 =?utf-8?B?SmZRVnQwNVJNNE42a2ptWFZ1M0VvSlJRTVpXMFY0R3l5NjJkaGxrbDJvelFm?=
 =?utf-8?B?Z1ZXTzc1WS9iUWFNNlIyYWFmNjhjSzB6aURTWGM3WHBNWkkvTGJNQ2syU1Jl?=
 =?utf-8?B?b0Q2OFpKOGJMbmc3VHhPc1R0VEFTUEluUllHMDlWWTRqeDRmY2hBY1IzSWZu?=
 =?utf-8?B?NmdFVmc5QmpVeUhkcUVUWGcyWDZySmhoSXQ5Ri8xRkw4RGpjb0JGdVlXeVhZ?=
 =?utf-8?B?MlN3bHhTN3MvK05OSFM3VFova0xwczZwZk5xaXVCby82NWNEVittVGh2amxP?=
 =?utf-8?B?bi9qNi9iZFNUdWxPMWhSaWJvY1FENTVvK2U2aG1DYmo1SGc4Qy9QMkZHOGhm?=
 =?utf-8?B?clhVUzA2UkhkeGZtdURaMnMxSTlIY1pUNVpsMkdaYklzYXFMODZwamVzRFFO?=
 =?utf-8?B?RzRJSW9LRDQvMDRqRzMzcGNTZWkvS3U1TlNIZXYrVlFhUzVYcTlOYWJSZVdk?=
 =?utf-8?Q?CdZetGogQ97aRY5ZEpHzvQpSB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6e8781-a3ae-4e56-4870-08dceebb18a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:50:52.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+zxM+1bgkM4MbdquwhI+Tj1djiBjyTok1CbmP8mC/nA2wONia4NVb3jY9BWlBZOuIdUciqP739C+NZ3rbUfJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

Hi Jonathan,

On 10/17/2024 8:31 AM, Jonathan Cameron wrote:
> On Wed, 16 Oct 2024 12:31:35 -0500
> Terry Bowman <Terry.Bowman@amd.com> wrote:
> 
>> On 10/16/24 11:30, Jonathan Cameron wrote:
>>> On Tue, 8 Oct 2024 17:16:48 -0500
>>> Terry Bowman <terry.bowman@amd.com> wrote:
>>>    
>>>> The CXL AER service will be updated to support CXL PCIe port error
>>>> handling in the future. These devices will use a system panic during
>>>> recovery handling.
>>>
>>> Recovery handling by panic? :) That's an interesting form of recovery..
>>>    
>>
>> Yes, Dan requested all UCE (fatal and non-fatal) are handled by panic in order
>> to limit the  blast radius of corruption in the  case of UCE.
> That's fair enough.  Maybe it should be called attempted recovery handling ;)
> 
> This is fine.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Jonathan
> 

I'll add "attempted" recovery to the commit message.

Regards,
Terry

>>
>> The recovery logic in cxl_do_recovery() (not using the panic) is also tested as well.
>>
>> Regards,
>> Terry
>>
>>>>
>>>> Add PCI_ERS_RESULT_PANIC enumeration to pci_ers_result type.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> ---
>>>>   include/linux/pci.h | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index 4cf89a4b4cbc..6f7e7371161d 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -857,6 +857,9 @@ enum pci_ers_result {
>>>>   
>>>>   	/* No AER capabilities registered for the driver */
>>>>   	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
>>>> +
>>>> +	/* Device state requires system panic */
>>>> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>>>>   };
>>>>   
>>>>   /* PCI bus error event callbacks */
>>>    
> 

