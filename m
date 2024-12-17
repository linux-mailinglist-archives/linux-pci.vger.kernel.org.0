Return-Path: <linux-pci+bounces-18637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7909F4D53
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 15:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BF61887204
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A331F63C6;
	Tue, 17 Dec 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lmPUGWkI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40341F4E3E;
	Tue, 17 Dec 2024 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444703; cv=fail; b=bkESOWiAfPAbveFmPHtRXntnBVpNVmVpLR1g/FxcDOjveavfyVIhVn90MppB1/wF+Su9jFm7EfWyWamt0HsLEycU8/YmA3Ir1g219tsAUTpKsxut3l8OxjPR+Zr7NbXu/nz3HFE7T3xG1aN9G/rfv8lP7kQgketN6p2Nk7UfPmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444703; c=relaxed/simple;
	bh=nE+aNEdBh4Fb5lUOf5rxGv1WmKdxlj6JjDLHtcddobo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aEkOqoCDlKe+/fF2TvKgFmUb3SyIXE+sbmmrVgBH43gS1JFuqamydEYcW4KliY5Dzv6h/t3rLvpRkcYqXVWBVzxX8cR68OyA1LIJvHOxlve6nuOjD6D0+ZLddM6LcP9bFlP/FgMqH28pWLxJqswqaQuK8l25/tT2shBO0zsnYOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lmPUGWkI; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JshLeJLGtsPjDwhcHOUGJa9vddkbKcM1RZvpDDAIadhRVFmVsIIW2YYt0kbuFeWkKbMbXcyXN672QLssaaM+dBHpPD/4gvi0WgTDUVHg26naUUnHrf6Q/EdiIBN4L563s5Wquvlysoj+DdqJegWjmv9bM0wf3+8djKEFiiIqJRNoZyTsPmRAY8LvtqabjU6SSR5MHY9n2zWSAb2S40VrDzUUrodfDMgavPtRg7KT4QTjUOADfcW5NrL1LWDgFAtJeXmjRPV+uqJ7F8l+c2Kz2QNb7BRIrQW8dGYnz7mL5K56p8i0uHVYqG0QfJbfoLmEJdY52p9cBfHKbkaTzJKroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ikKAPvTMGJVZJhGb3Oj+v9RqPAWABAzGIdgD0CtSw0=;
 b=iiiqeO6d7/Gg82LX3wfXGWcz0Fg+PiEGCp6SLfjlkcqgMZnJcMojrQTLSsw8d+k6gd60LWsJP4qePOnNMBdVMkfHRq4BJoJR5M7xQOZFyfj07pR3j+6v4cHQZ63hrv4qTRIA2E0FwkzyySGFiQHjSlVhvSN4qp7o1rjdAcDySy1Hv1YabmVTX/lDySeWOZPS4q7DmSsmuC25LyZI5rOJhtJ3nvXd/sCBdMP99SkuEn41pxUJYUslM1ozz7NRCZvon63sr4TonYv7q6vSnjZtcvSBEz3+FCE7qWX4UeBYGaqf7P0hwVjksyxa6r3OFCIcmReNB2J9iR6m6eWmnavPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ikKAPvTMGJVZJhGb3Oj+v9RqPAWABAzGIdgD0CtSw0=;
 b=lmPUGWkI3qy0uM1KEswOperN+xpBcZP0kRVX8YYVqPMxymZ/mfuDuiU/j4vUrp5lXTCRyPxH0IJsPn9xvI0Nb3681mgK7ZTgFNfyEY+jnx2lYVw3E2ihJDONu82Q/srbf2N3dHWDIBSxdIvjzNEnbpAbV6tt1D6arVJ5CQ/mT6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Tue, 17 Dec 2024 14:11:39 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 14:11:39 +0000
Message-ID: <4dac3ff2-e3ab-42c0-b39f-379d5badca42@amd.com>
Date: Tue, 17 Dec 2024 08:11:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Werner Sembach <wse@tuxedocomputers.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ggo@tuxedocomputers.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209193614.535940-1-wse@tuxedocomputers.com>
 <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
 <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
 <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com>
 <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com>
 <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com>
 <90631333-fda0-42cf-9e32-8289c353549f@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <90631333-fda0-42cf-9e32-8289c353549f@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4dbbcb-be28-47e3-cdb7-08dd1ea4b980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmJEdGdxL3N6MkpIdnN4NkNTeEtraytHeGVDUG0vMkkzVCtrZFZZM0kzZEps?=
 =?utf-8?B?SzJhZFVON1o2RmFiVVFjQ1lYRHJqdU5Ra2g3eHpQUWxOd0hUL2RwSDl2eWVB?=
 =?utf-8?B?ZHNpK2R0clBqZmM3a0gwSzIzYStnbjRSV1d3dnk4RGNOS1B4cVRMU0djRHZZ?=
 =?utf-8?B?Zkc2YjRYNjNBUTJXYlNPVHpGVmE5YWtBbVVSdmc5K1pmb0R0SEtTelIxdnVC?=
 =?utf-8?B?aXhMZ3VKTU4rNW1xZHIrbS8xMVoxOGV1dmFBNUt3bFRkTk81QlMxU0txNytU?=
 =?utf-8?B?SHF4UEorSHk5OFp6VHhkMW1mclJvOWxOYXZ2NFFuTWxEY1ZCZ0JwQkJWbTgx?=
 =?utf-8?B?Q21Fak95eXVYUGo5NERUU2ZmRXlyMDFIY3Q2WFVDN2ZFczc0UjZFV3RHNU8z?=
 =?utf-8?B?RmFLY1UyQ2d1OHJxcHFEeVpHeWlpcytGQTV0dEJFNXFaenQ5YkI0cmhud0xN?=
 =?utf-8?B?blMvR0JFaVVEbzhsK09Xdm5DMEtkSXNab1NWK1lDcVcvWDdwbW02RnE5MmpT?=
 =?utf-8?B?a1ZNV2haUFJvdHkyd1dJN3RzckFqcU1sV2k2NUF5Q0VNZTh1M2o2N3cwUzdv?=
 =?utf-8?B?SFJNaFF3VUlBTFZwZ0lscEVGM29UOG9iYmpLREQ2L0VOZWtZQ0R4bDlqZWFN?=
 =?utf-8?B?b3ZNOEREZHJCTnlkNTdZRVpYUVhOck9naWNDNVpJaFR6eVhDVW8ySW90S25u?=
 =?utf-8?B?RHJhMHJ3c3hwQWx1Vng0QWFIa0l1TkwvNVNsOEE0b2Qya2VDcE5xZG4zT3ls?=
 =?utf-8?B?NUlIVm5ZUlFRc21NdGd4TnhEb3JQTFFmWFdGeDg4OEdTUDBnN3pPYjFMSUF0?=
 =?utf-8?B?U1pVdjUxc0xVb2lOT054YUpjVjErVDJsTTBDZHhna0FMVXAwa0VENVd3dm1x?=
 =?utf-8?B?MmwzSHZaVzBFbS9OUTF5QlJGakJwRkZEVHl1Q2w5NGRjdkx1SGpsRVZ2d1pQ?=
 =?utf-8?B?MjducjFGU3g0b0FLR0tvNWNucXhwNzVJWFhlTEswR0U3QzFhamZPRGtsbjhN?=
 =?utf-8?B?NUwzbDVJb0JNY3EwK0IxV2F5QzN0SlNqY1Y2Wm9xWTBiVFdRbFBxdEg3OFQx?=
 =?utf-8?B?MlNLbTZSU01MMVgrUzFVcmIyOHJhTjJGdWxGaHNYL1FrSXlkdDFLWmttNWhw?=
 =?utf-8?B?cXdQaDVlWGRFajJRekZyK3lTelBZMm1HL1Qybm5OYTZLNE83QTNGRlN0Tjlv?=
 =?utf-8?B?bCtoM0ZWYVAxcG1zanhsV0RxV3R1c3hRWnZWblJoK0MzVDRPTWxzaXUzOERY?=
 =?utf-8?B?NlpjQjBsV2d0K1V0MjNSOFdjbFVGQkpWMmhLOHZCUHA3YWM0clc0SEd5Rk96?=
 =?utf-8?B?YmEwd3FBNzlpQTYyczN4UFBJZDFlV2pzUlVQWjk4K2JVQTljc2lwQUV3elNp?=
 =?utf-8?B?TGUvTHcyb2hkSHBOTkVRYTBRWnNrVzUrOS9PUkQ0c2ZZTUxnK1BYMGdoSHI4?=
 =?utf-8?B?cjROelI0NGRuMmc3MmpzU2tYTzRTYUZDMUFtV1JUWWlmQzNSQlZqMWI4bTI4?=
 =?utf-8?B?Rk5vYzR6Mm8ycmk5Ky9jK0NoZmR6d3dPNEkrZzNKbStPeWtpR2JjTUttODVa?=
 =?utf-8?B?MW9HRkVrcmhxQWlmL0Y5QXBDMXEzYkNJU0pvQmJPYlp4azNzZ0ZPRmJhWWF1?=
 =?utf-8?B?Z2RtZDZBRFZDbmpjYi9QMmJqTE1RYVJZdmd4NEhvNGVoVlFtVmlzUUFLcWpo?=
 =?utf-8?B?N203U2xmK0w4ODdVVTlhYXp1UGdQbEtSV25zb0dxWXhRR08zT3I1c1R4VnRN?=
 =?utf-8?B?RkRSYXk5TS9tdHBJREE2bDVlQ0JCQXVFWnlONjllRlBwNHg4K2RpRE1WcE82?=
 =?utf-8?B?NlZ0a2lHdVQ3c1huZUlQR3V5c2o3Z2NvNTBGQXp3S0doRWh0U3ovWlErL2x4?=
 =?utf-8?Q?evE3P0gBDrgVo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2xTZnV2bERWSWNHRlJ0SEdTS3NVVUh0ZS9SQk8zZG9lL0cxdmk4bExhenQ4?=
 =?utf-8?B?cHZsbzVWaXEvdEZKUTd6U0pXQmJWcFRmZVp3WjRjdlAyRDVWQnFERmhSQlFh?=
 =?utf-8?B?eGhOcGZldmttRnBwSFlUejRKMHI1NjY3Z1RlYktGOVZPcVlCQUsyOFhvc1hk?=
 =?utf-8?B?UDk2RVpwR0t6OWluY3hSc2QvZXROdnRERkdPWVFJd3Nsd3RneVhiTlRSUWgv?=
 =?utf-8?B?VzdJU0IrYVB0ZWJEU0M4WjVpRjE4aWl6b1JNanQvcFFKUk9BdGNaUml3L0tt?=
 =?utf-8?B?Z3JpNnBSalJFS1NydVBXL0VlenJTeWZEcC8zVklhWUw4SkFnU2FhenlyRFN1?=
 =?utf-8?B?NFJBMWFpU1N4TWpOMFZRSlNMYUVkdnVUdlNxczh0clhlamVveThHQ0hPa0Vu?=
 =?utf-8?B?ci9BeTkyVE91a0FNVERWUjZjWXZ0bUdkYkhXWGVlcnBoRGs4RGg0T1NLY3NY?=
 =?utf-8?B?K1JOV242RTdTSkxwVlZIMHFUb3N5NGJXZGtqaks3ZVIzM1dqcnJYbkVRblgz?=
 =?utf-8?B?b05TZnBFZ2RDU0tzeFVvdHdVZllyNUFhMUlVeXczUnlQcWF3MmhVbWJzc1Nq?=
 =?utf-8?B?SE9WMTZsalY1aW1aSktuRjFKK1pTbXdNRDloN0ZqaU9ZY2NwSGJWbkxlcHoz?=
 =?utf-8?B?SDh4MytDa0JjcjlnaDBUY3FmamxvSGFjSVU5OWpmb0JuMm9ESCsvZkZYKy9q?=
 =?utf-8?B?TDZOQ0pUaWJCRDZiOXZnbWZoSkJFUnZWUkhYMVRqYnNveXlhRTVtTVExelhM?=
 =?utf-8?B?YVZlR2R4VW12NGJlU29QUTlTbDZUUnRQS3grUlZlSmNDQzk3Uk9hMmF6WFQ2?=
 =?utf-8?B?SStOREFZQjl5VFc3M0E3VEtHdUJBY25FWENLNTZTY1ZLak50VE9JbWwvVHpO?=
 =?utf-8?B?NHdCOUlCTzZ2TnlZTFN6Ry9VL2p5aEZGYmVRWTI4OXY4S0l6YmYvakFWQTZM?=
 =?utf-8?B?dUROVTVucVJkZWN0ZlBjWTBPakF6SVpsN3Y3VHhDbGtPY3RNajU3THVXSmkr?=
 =?utf-8?B?d2R3dEZCRUhPVkdOMGU1M2YyWlFKNkorUFBZSnJCcFF0TGtNa2ljZktNcURs?=
 =?utf-8?B?NTRHTzVFS1hvVXNFTWxlK0lXNEp5Nng3NGJjT0liMGNHcFJDS3BCNWI2K1Vv?=
 =?utf-8?B?RGRPQWl3TUpvb0ZwdW1uNVpOWmowbE5ITkErTTgvNEdyU3ZXRDFDSWJqeWE2?=
 =?utf-8?B?ais0OVJkYXpCenlPcEp0amJ4WFVPak10MG5yVGpBSHd4dklTTW1tejh5UjZU?=
 =?utf-8?B?blVXa2dqQTdzN1Bmb3ZhZVQ3NE5qSElraFhQNmVzY3I3NW5QMmtCL09SRnBx?=
 =?utf-8?B?UGJtU0hiWVd1ZVB5WW9UdmsvNEZtWlE4QzhOa2k1RXMvOFZKT2V4V0VYSE5W?=
 =?utf-8?B?elBkaU9NT2xsb29IM3NSSUorOGFmb0tmOXZMVURvTUVVOTRyK3U0anB5RW1T?=
 =?utf-8?B?WUgvWWtUMlhNM0dsczFhaWVyaU5ETTdvamhpakdjb3NLbHo4UWVDYktaaFVR?=
 =?utf-8?B?RUlyNjNqYTlmL1ViSExxR0RmUW81WklqWW9odmlNWXV0Vkk0Ky9HekQwSkh6?=
 =?utf-8?B?SFloUFlJSFUrRzl6ZVdDSjI3UVVVNUx3YXhEUzQ1SXQzbVNrdjdnTHNvNDFk?=
 =?utf-8?B?ak9hQmZVWlZSdkt6ZGVtOTZlMFRCMko2bjFzSSs2ZzdIaHZENGI0eGNFTFg5?=
 =?utf-8?B?cDZpZDJzcEVTaVV6OHdMdTNGNElVVHpjT1BHYWp1dDBlbTViV1hnUkRxREZy?=
 =?utf-8?B?MWc2ckVYVW16aklkYTRpLzloMDdOY1IxVlhON3p5Q3BIWFdzK01OaUVERVlJ?=
 =?utf-8?B?SG9iUStJZUdOWlNhRWp4SExjSUhvZDhUWWo0c0l0clFVeTcrVWtxcTlXR3c3?=
 =?utf-8?B?NFVTdkVjYTJnMVEzK3NrUXBCTzA5WjU4NnQybUkzLytaUjlIb1lhNXN3SG1t?=
 =?utf-8?B?QVE0Zy9GYW1qSDZwc0w5WWlZTnNZWjNRaXNsN0JzZEpuS0VBc0x3K0dDMXc1?=
 =?utf-8?B?NWU5M0gvRnhoRmZzMzNoelJXS0N0WFAwUWZmb3hCSG1iSnFtaU5Sd2FBdXZW?=
 =?utf-8?B?TFc5ZEVZYXd4dmJsSi9ZenQ5OTRJYkhDWDArYWhBc204bFBFMTExYkRqRUk5?=
 =?utf-8?Q?B7RUnZ5/wr3gbELYyp44rn7ql?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4dbbcb-be28-47e3-cdb7-08dd1ea4b980
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:11:39.3875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rd8D49uChYE68uzqu+qspMvQMISUdS0jnLto6uF1YC36ZslfYvIiTCTIurdRZtKaFszIY06gwJlYpwlKAnJF1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456

On 12/17/2024 08:07, Werner Sembach wrote:

>> '''
>> Platform may hang resuming.  Upgrade your firmware or add 
>> pcie_port_pm=off to kernel command line if you have problems
>> '''
> Yes, full log attached (kernel 6.13-rc3 one time without sudo one time 
> with sudo)

Yes; I see it in your log.

>> "quirk: disabling D3cold for suspend"
> On the fixed BIOS I see that line. On the unfixed BIOS it aborts the 
> functions at "if (pm_suspend_target_state == PM_SUSPEND_ON)". Skipping 
> the check on the unfixed BIOS it still hangs on resume.
>>
>> I'm /suspecting/ you do see it, but you're having problems with 
>> another root port.
>>
>> I mentioned this in my previous iterations of patches that eventually 
>> landed on that quirk, but Windows and Linux handle root ports 
>> differently at suspend time and that could be why it's exposing your 
>> BIOS bug.
>>
>> If you can please narrow down which root ports actually need the quirk 
>> for your side (feel free to do a similar style to 7d08f21f8c630) I 
>> think we could land on something more narrow and upstreamable.
>>
>> At a minimum what you're doing today is covering both Rembrandt and 
>> Phoenix and it should only apply to Phoenix.
> 
> I also try to find out how many devices where actually shipped with this 
> very first BIOS version.

OK.

