Return-Path: <linux-pci+bounces-35884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE6CB52BAB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 10:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B76C27B6528
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7D62E2DDD;
	Thu, 11 Sep 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iuuWLvAB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEEF2E1749;
	Thu, 11 Sep 2025 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579502; cv=fail; b=Gy8XfGIG5FOFnXhkA/VIYTu2XVUez1lXCj9PLmVVpkrRSGRzsmF8fyfOt2wDYkd1SkH9j4hsKbvbyeojssFXhnhYm4nbSXe6G1d1zDpxLXiu5n04Dh3dG9qeYWeSFlwfDE/zZwWBnvFjaeNcprmhAH17wEAru83pkgM37fP60Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579502; c=relaxed/simple;
	bh=0z18peg5KF4YktABTp0zHPuIgwK8fyZqmlf3aAQKoSM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r5+TjQmlR5b1DKIpJ6utkahVEmj/vdFTh2mjUPRQ2mWiYOWwsDl+U8yP0VsKQeox+5wE0yG5sFaMQ3YxRekqXjwMElbccujWmkzeGjGBurTCt1RxSsHR9LGkzuZlE8w925FVmF0Yy9ZXhl+zcBj/QxqrN1YuAbbazucewM8jGzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iuuWLvAB; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATL2rJmifpn8Yl4lSNsh9X78fDguR+izyWd2OR4QE/jlx1EimGaSsBPbfdVYSKIUGiVbNNn6ldiQRdWC/Vv277r+Jb6qAtE83ZXMtsHt6iv0cjxJuZi377rkhxy3OziEfcL7MbNHK2aZjCPxvX+w+LZs2lPLKitfdWSRiJcrKpIEFxVcQPs5YswSe41uli4wNVdqHqQ17nRI1Pj044VpTwjHN7vi0tom8ntm+cPi+pUw+5/wTJtu712cIkXL3id2Ea9u118KxV2/SslpSPpkhDFR4XGMSr1udhl/U8t2Aq0Kdhz2hOY0Uyq3MOSsP+NgGtqTTzS/33YaRfGnxlPiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uxu3y5qiLoyHQlEoAme334VvKeAUNRrwXWEvT9Lhfl8=;
 b=d0ZlM44TUOtQu3t0SVk7s1JQ7L7TYJWDTU4O148ukPLGFoqEdhlO1kwH0+H2X4l/jeZw3vBrgLh3ufpC3dXKpEBGqKMXgG/lDgSf8auGzSxHgFBvTrbLPcr1SVqGB/jz64hqU/DXxAvhoL6RO3M+kyahctxjAdQQdfmA1ovlyKzL5N5CgYLZJ8Gjyc80FIroCnNsXysXLFyeqhG2T50DPiLa/igYjOEzjhXWnPpPakiuT+Wy2omIZNkt3WUqUvPxXJV4ZGttzYM1VlvB5oLu9JVXy3+NOpSnAffY2ujrhGv/6NrB634M7HIjT5Vx9vWLNQ56LOWqWZYSBrqbfOY63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxu3y5qiLoyHQlEoAme334VvKeAUNRrwXWEvT9Lhfl8=;
 b=iuuWLvABn8gPdrlPU2MOVsXVi85Tu4TZnG8fRilCiVPU9y4IKfd1ZEKRhtotPbR4GsXFTeGynxfiMsdPAElC/l8Vmvt+3EunJkgob84WVPcs9EkXfmekz4hP506h7T5+ou55H9bT0luQsNUZ6iM/4yEcaZ9tirsHLehUorOiQyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 08:31:36 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 08:31:36 +0000
Message-ID: <b588a211-c3d7-40b2-88d4-76af9042feed@amd.com>
Date: Thu, 11 Sep 2025 18:31:28 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Arto Merilainen <amerilainen@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 kvmarm@lists.linux.dev, linux-coco@lists.linux.dev
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-35-aneesh.kumar@kernel.org>
 <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
 <c3291a06-1154-4c89-a77b-73e2a3ef61ee@nvidia.com>
 <yq5ay0ql364h.fsf@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <yq5ay0ql364h.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY2PR01CA0031.ausprd01.prod.outlook.com
 (2603:10c6:1:15::19) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb663e6-9eb5-4982-a140-08ddf10d9eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGloWldzR242MU1BTVI1NGNSSGxlaiszVFBWSWtFVHNla0QzRzVwS3REM0lV?=
 =?utf-8?B?OTRyRGFlL1d1bnk0bmlxdkluSlh5NHNQbWV6a2k4WnQyYUNDNERqcGp6MDlL?=
 =?utf-8?B?S25Lb2w3OVlJYm9qRFpET1pTUHRjS1RNMmpqVkdUNmpMZ2hXS2ZOZkRBQ3Jn?=
 =?utf-8?B?OGN4dWMrTnhuUHhzTkJWelQvSTNseHJYVmZMcVU0LzFaUGozQmVFZ3RtbGpw?=
 =?utf-8?B?ai82bThDSlRKOGVEcXhKcFAvZVNwWW1lVmM3dG4xUkZucktZa2o1L1hIZ0gw?=
 =?utf-8?B?TVkzYWMxL1FNdUV3UFltNFRpV3JDMzlOWm5vYmVxeVVHNkxpQWNxZnlLL3RM?=
 =?utf-8?B?eHRhekhid3VIZUM1a1QzMDdPS3lpeEZOTHcrTHcwNXZSMFVEUncwQ2dxczZY?=
 =?utf-8?B?bHdFY0VncDQ2QkZHMTRuZVN5Yzl6THhpRWN2em5Yc0lBdTJIYzZLVVVvdHlE?=
 =?utf-8?B?NkVNYmFLRGphM1c1b1E4bnlJcXZRbHBOY0J0WmEwVk4vc2F6NWkrVG5mQXdo?=
 =?utf-8?B?UlhyNVV6TFRjMjJjK0ZTdEU1V3JhMUdEYUU1ckN2V3Z5eGk2RHBleGdjdkZG?=
 =?utf-8?B?TTFYK2FESmN3T040cEFQNjYzbUhPK0h5blB1elRLM0NKS216alFaRkZZUUxB?=
 =?utf-8?B?T3pQQ3pFY2dnV3h1SXVHajEvU00xczkwK3g2ZGlOQk1QVlBiQVpjV0tUTWMz?=
 =?utf-8?B?R2ZrcVNHYXh6UWlLcXRxRXNCYXlVMzBGK2FNOW1qUEI3RkptcFFOM1VwaVdp?=
 =?utf-8?B?Ry9Jb3NSZm9xQ1hZNzAxdWs0alZpV0VnMTV6RWNnbnhnbVBCWTFzNU9HajZj?=
 =?utf-8?B?WHRZZ0huSFpaUnBQSDFWdUQrRi9TalNVMmJ5eGIwb0dXVWtSdy8xWmNHU1hF?=
 =?utf-8?B?TVYrRzdCaEdXWnVDR1U4ems1aGVPbmNnWnU0dXhxZkUyVUo1OVlNVmRaZWdm?=
 =?utf-8?B?M2FCOWZYNWNmMW9uMDNNNzMxYkY1TXNkNVIrZ0JaZGcxY0tFaHhjaUk0TlJI?=
 =?utf-8?B?TEJhYWtqdDNKRW05dEF2LzcrVUJobU5BbkxlMzZoTTVvTGNQWHFXNFUzdGJX?=
 =?utf-8?B?MXhYa2JqQndjc2h1UFBJTkRCV1o1Zk5tZWtmblRyRVJXY1hheDJpakU3WnBC?=
 =?utf-8?B?eHNzZnJPMGtoTlRMbjdqcGI4Nm9qSVROVGRqNjYxMGlIU3EvTVEyLzlYaVkw?=
 =?utf-8?B?TTd2VGlEVS9mMVZHZTJQV1RVK2NPTklHa2hieXA0YXI3V0p0cXpwWThaam1O?=
 =?utf-8?B?SDh3cGl4cmtiYjRZSUkxNFZIVkdzMFVEVFg3Sy9YTGNSbVNZRlFockorOGtv?=
 =?utf-8?B?R2RiM0M4Uk5VM2RpTDZzQ3l3V0lwclltbDhVb3BrelRpN2ZxaXgwcERobHZT?=
 =?utf-8?B?L3JkSkp1OUk4cmc0S29LRlB0UFZ2M2RxOExBdUo2dE1GR0tUeFR4YnNqOS95?=
 =?utf-8?B?UnE5VVNONmNVS28zUU0zMGR0TC9vdWxFYU5kMlFnZ0d3MDB2bE9namU3SEJR?=
 =?utf-8?B?SzFWdW5uYTZqemhFYmpZYnMvcEU2VEZ0ZWN2NmI4ZXY0YVZlS2xZWnNQVXR1?=
 =?utf-8?B?OWI5R1Bja0xpemZuT1NjZCttNDJWbHl0dFhjSWhBZUxVWWNSRWtKM1lpZkNV?=
 =?utf-8?B?MHMvcjc3bUZxUUcrVXVyaDBMZ3VyYlBwWVNqSEUxQ2x2a1FoZGJpck92NE8w?=
 =?utf-8?B?K1BhSjZ3SlowSmxuN2JJZ0RkSElobEQ1QmdKaDlVU05hTUhyc2VnUHozRXp5?=
 =?utf-8?B?T3VUM0pqeUt3YXNtK3dIcWtkK0E4TVpuNlU1Y0w3OEFZM2ZHQXRjVlNUdFpQ?=
 =?utf-8?B?WWx1SndVMnB3SEN1QmJYNktvcUZ3TjZ4NTBvWjY5UDhmSjlveFF1dTdUcmxx?=
 =?utf-8?B?cUNtaG4xNGgveXFrbCsvNk5sQnlSQnJaM3ZlTXNnd3RYSi9xdWZuMnY5TmFr?=
 =?utf-8?Q?X2shtuzNeW8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkhPdFhlTG4xa1JOWmt4dWpUbFlHS2FXSm5RVnBSVno0Mi9JZzllalN0Ulpu?=
 =?utf-8?B?bEdvVHRjRWs0NkYybnFUc005L3NHNVZTQ09HNFpkSjhLaHMwcWpydWZzdmJX?=
 =?utf-8?B?L0NLMEZzRG9qUnNCMkRpWlB6RzVWcklQcnE3RzFZMWFJQURCbGZHcUVvT2x5?=
 =?utf-8?B?ZXhXa0RmT2k1b25MVmY1SHBadFNDTHdqSTZ3Vkh0VDkwYWxVRlplV0tyODkx?=
 =?utf-8?B?MkJKajBHbUpwditkYndyOERwMysxTWdWU20vNGlnMUF6WlJ4VFgwK1diak9s?=
 =?utf-8?B?SHhNRVRxNzdaVVY0YmpVZStyUGh0KzhZbU1jRjRYYlNITkdJSXlpWldpcE5F?=
 =?utf-8?B?cU0xTW1PclZrMTMwTGI0bE1YelRKUzhsOWpnSndpUG9uWWVIQkNoYkJBcEYx?=
 =?utf-8?B?SDRQMlZSd2o5YVRVdjR0ZjdsbzBxWUlMaW1yYjNnU2Z0Y2wwZzFGQ1ozTFZq?=
 =?utf-8?B?MlBVeWU4cE1tWHRuRnErb0EzNzJ6VXgvTFRVZFpCUkJRaGpPNXdFbU5yZFNF?=
 =?utf-8?B?MHRWdnBOZmFIQk0wcExTS3JXbSs4dG01a2M5U2R2MmxUeGRFbVQzZmtUKzF3?=
 =?utf-8?B?UHdDQTUwQW9TWlBRcHcwcUNVOTRlWE41TVhuMDdQdWt4UTdtU2JoR1VNTnZG?=
 =?utf-8?B?aDJkVTVTdkxMTWt6aHRlaVJONTJsVWt5WHJScDAxN0pZOVVOZFR1cTRHR0tv?=
 =?utf-8?B?UTlKNkJJRVdRS3p2R2xPSEhBTTA2Sk44R2RGTTVEdkZZNjZ5U2FxMHZRNndJ?=
 =?utf-8?B?VFRSYmIyeFREdXUzNkgrbkRFclIyZ0lxUGg3T21Iei9taC95Q2QyTTQ2b3Yz?=
 =?utf-8?B?anMwMTU2L3B4TUJTVXFPRFBJTkNRaUFNa1ZFbEQ3SW5wNVBmcFBzYVYydkpR?=
 =?utf-8?B?YWw4MndOSzY5cFdkY1FBR09COWFYcWFtb20rTm1Yd3dtSnJtNE1PN3hjMzNj?=
 =?utf-8?B?Z0UxQXRwa2I5am1kWUFvRXVTSWxSSnpEV2pYbVAzdFhTWkNxUk4ycjBXVzJP?=
 =?utf-8?B?bDRFY1ljOXo1UUxlc3E1ellWU2FBSUxlZzFnZnh0dTE2dFhHZlNrQnh2dko3?=
 =?utf-8?B?UXR3Mk93R3RvV2YzSWhsUS9BMHBFSjk3aUJVV2kvdDI5ZzlKSVR3QkgwNTNN?=
 =?utf-8?B?NDBhelNrZGpBS0EyQzlXUTVVV25wajYzRWRQUFVXNlJQMUVYRzExY2tpT2xm?=
 =?utf-8?B?KzBQSkpMMERRTmtJWEhKcDVuN1prT3hKQ3VweUtMNDN5SkxEZlhRTi8ybFBk?=
 =?utf-8?B?SnMreUFsYmdKZC9Yc05mb0ZBVkdpSFZ1WlF6eVM2UHpmck94UDc2UkZ2YWJW?=
 =?utf-8?B?TytrcUg3TWgvSC9ZSGU5b1FqTmxuSjR0NXhKNGs3V0M1S0hSRVFOUjlIdDBV?=
 =?utf-8?B?MVQ3VFhTb0VvK1J6bjNnMm5UNW8zaWg2Vk1CcDZiU05aWHEyVXJIaHBGcHox?=
 =?utf-8?B?T2NwS0dZa2dtd0RQUW1nQVZ5c2NFbWVSU21yQmFjL3Zkdi9sQVA1U2ZkbVhp?=
 =?utf-8?B?dElIbzVtQ3dJcGZvRW5SRTg4SWpTWXRZSmVXMG51Rmd0b09idXVSanRlZFZQ?=
 =?utf-8?B?V2ZteWpmR1hNQzErblh2UlpkRDZvQUpVaWlwQXpLbDJBWlF0NEVkWmlrRk5X?=
 =?utf-8?B?ak9vL2dZUnhNWGFFUjd5UmZPSC9MdGxPdHZUVk5pb3NpZnJhdHdZSExreEdx?=
 =?utf-8?B?eldrTVE5OWhISnpxSUxMMUlwMGt3bERyZlBzVzlIeVMrYmJQb21rZ2V2U0pI?=
 =?utf-8?B?anVQSHdIa1g4UzRTeVU4ZExIZEkvM0JLK3hxeG94SitnNEkvS0RmRm44cEtT?=
 =?utf-8?B?UUdvZEFUSDFqZlFpOW4wZ0hXclpEdWVneDNCRFdoSHM4TFI5Y0lIWXE0dnZF?=
 =?utf-8?B?aEFDL3B2TXBBbk9RSUFMVFIycld3amNrUy9waUd5ZjhWMHhVM2dmYmtQWDZn?=
 =?utf-8?B?OWNZSGVXcWRvQ0p1UmM2YlY5L296eFEvbmZrWEY5Qjh4dVF2M0NHRjNXK3VP?=
 =?utf-8?B?QzBtS3J1WVRYMGlIclFKcGZnbEZoUXN5eDBUYzM5MFVIZGM3S2ZBTkZwZnVu?=
 =?utf-8?B?TDBrbTFySmkxVXR1ZG0wQWFJMUVKalFPOHF0TFNzeU9sVVZPU0hqNUNxNjNr?=
 =?utf-8?Q?rmBB9jVZB/BUlh9zQ7vLYoBCD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb663e6-9eb5-4982-a140-08ddf10d9eb9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 08:31:35.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ly6ooJIK61320lpvOTIkWEUAY7beQ2IF9t9u/gjEFQsdES7kBOYJR9p5aacOuNnsciTD4GV4yAyurX1eHfab2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452



On 11/9/25 15:33, Aneesh Kumar K.V wrote:
> Arto Merilainen <amerilainen@nvidia.com> writes:
> 
>> On 31.7.2025 14.39, Arto Merilainen wrote:
>>> On 28.7.2025 16.52, Aneesh Kumar K.V (Arm) wrote:
>>>
>>>> +    for (int i = 0; i < interface_report->mmio_range_count; i++,
>>>> mmio_range++) {
>>>> +
>>>> +        /*FIXME!! units in 4K size*/
>>>> +        range_id = FIELD_GET(TSM_INTF_REPORT_MMIO_RANGE_ID,
>>>> mmio_range->range_attributes);
>>>> +
>>>> +        /* no secure interrupts */
>>>> +        if (msix_tbl_bar != -1 && range_id == msix_tbl_bar) {
>>>> +            pr_info("Skipping misx table\n");
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        if (msix_pba_bar != -1 && range_id == msix_pba_bar) {
>>>> +            pr_info("Skipping misx pba\n");
>>>> +            continue;
>>>> +        }
>>>> +
>>>
>>>
>>> MSI-X and PBA can be placed to a BAR that has other registers as well.
>>> While the PCIe specification recommends BAR-level isolation for MSI-X
>>> structures, it is not mandated. It is enough to have sufficient
>>> isolation within the BAR. Therefore, skipping the MSI-X and PBA BARs
>>> altogether may leave registers unintentionally mapped via unprotected
>>> IPA when they should have been mapped via protected IPA.
>>>
>>> Instead of skipping the whole BAR, would it make sense to determine
>>> where the MSI-X related regions reside, and skip validation only from
>>> these regions?
>>
>> I re-reviewed my suggestion, and what I proposed here seems wrong.
>> However, I think there is a different more generic problem related to
>> the MSI-X table, PBA and non-TEE ranges.
>>
>> If a BAR is sparse (e.g., it has TEE pages and the MSI-X table, PBA or
>> non-TEE areas), the TDISP interface report may contain multiple ranges
>> with the same range_id (/BAR id). In case a BAR contains some registers
>> in low addresses, the MSI-X table and other registers after the MSI-X
>> table, the interface report is expected to have two ranges for the same
>> BAR with different "first 4k page" and "size" fields.
>>
>> This creates a tricky problem given that RSI_VDEV_VALIDATE_MAPPING
>> requires both the ipa_base and pa_base which should correspond to the
>> same location. In above scenario, the PA of the first range would
>> correspond to the BAR base whereas the second range would correspond to
>> a location residing after the MSI-X table.
>>
>> Assuming that the report contains obfuscated (but linear) physical
>> addresses, it would be possible to create heuristics for this case.
>> However, the fundamental problem is that none of the "first 4k page"
>> fields in the ranges is guaranteed to correspond to the base of any BAR:
>> Consider a case where the MSI-X table is in the beginning of a BAR and
>> it is followed by a single TEE range. If the MSI-X is not locked, the
>> "first 4k page" field will not correspond to the beginning of the BAR.
>> If the realm naiviely reads the ipa_base using pci_resouce_n() and
>> corresponding pa_base from the interface report, the addresses won't
>> match and the validation will fail.
>>
>> It seems that interpreting the interface report cannot be done without
>> knowledge of the device's register layout. Therefore, I don't think the
>> ranges can be validated/remapped automatically without involving the
>> device driver, but there should be APIs for reading the interface
>> report, and for requesting making specific ranges protected.
>>
> 
> But we need to validate the interface report before accepting the device,
> and the device driver is only loaded after the device has been accepted.
> 
> Can we assume that only the MSI-X table and PBA ranges may be missing
> from the interface report, while all other non-secure regions are
> reported as NON-TEE ranges?

In case of the "some registers"+MSIX+"some more registers" BAR#X, I'd rather expect 3 ranges in the report and not just 2, for each subrange, sorted, with/without NonTEE bit set, as the PCIe spec suggests (sort of, I struggle parsing it):

===
When reporting the MMIO range for a TDI, the MMIO ranges must be reported in the logical order in which the TDI MMIO
range is configured such that the first range reported corresponds to first range of pages in the TDI and so on
===

And if the number of pages in the report differs from the BAR size, then we should fail validation. Otherwise it is impossible to tell from the report's MMIO addresses what part of a BAR needs to be validated (==TEE) and if the guest device driver has to know it - then reports are just useless (which is hardly true).


> If so, we could retrieve the MSI-X guest real address details from
> config space and map the beginning of the BAR correctly.
> 
> Dan / Yilun — how is this handled in Intel TDX?
> 
>  From what I can see, the AMD patches appear to encounter the same issue.

I am skipping MSIX BAR because T=1 is tied to C=1 so after such validation, the BAR belongs to the guest and the hw will reject VFIO-PCI (==HV) attempts to write to MSIX BAR. Probably too straight forward though and I can try assigning it to the host (and add Cbit in those PTEs), and see how the PSP handles it (not). Thanks,


> 
> -aneesh

-- 
Alexey


