Return-Path: <linux-pci+bounces-34692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C333B35101
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 03:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAD8200AB5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 01:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FD1F463E;
	Tue, 26 Aug 2025 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fERZ7iq1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293442AA5
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756171901; cv=fail; b=SZU/dpL9F7N0TUjMaeZ6W2QyUw88yobK96LRzeTSg30lfrsPEdcF1emfmjLLF0x61FzAtPNQWyO10IJIDG8Z514wEYdDAUHRP8+tKjp+unIzL7dH71yon9mbAwmNnng3KOd+kNsH2eIc6Z/pZv4wmviSObBAoUv6Vfo/uRwYKMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756171901; c=relaxed/simple;
	bh=vQcPZLy08ot15Q7tlwr1uKpMrEL5fleaxB/XDEk2YxU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KYlgOktq4q/w7/iIfwAFA8PY9y16gaYg8V9msZ8kK5o0jwW9JF84snBB1OwJeqL6jyGrG8ov9UsJXxCpm66hBUyiOZ/M3xB274q2dLnefXqjU7eMME2g2liHreM6iNf3hC3n/BPmZjOQWLi+ELSe2h7sbNpczlfBzVSBXqpImek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fERZ7iq1; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXdvtxfrBvi+btVEDfRpOjCU66RPM/RoD1QSLMowFGRHWXWyU06ACbhRsbPDt/nbgrg0lvwQGeq5sjs5Ws2auYin8HS5e0md+02+jlICbYQgAgSflRf4dalgiOCV08xLf9DJ+gKODmDSbOgFQouHQUCAouTQXnVgLYXryQVbtqlfyHHmSy8SFmWiZdZn/Kf93xtoJWqq2XHQnjLti0gzUzkQgfv6wU04TV4jSstpsRoq4DFW/M9jgPObAISe0jGdMdasnZ1r/qqjMmGi7tGmLvtshmKL6/QUSd+rzfpIOLU08PJRnRRydcKcXEi4ejmZy98Zkmk/hha7ip2d8ra7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bDisyDU4Xe+cyXpkuYNKrsN+zz21o2ORh3IsqiWDBU=;
 b=c5jtxBZKAmmNxeYXuL9o4gNeTwH/V1KKxmQiJEPFmm6arRNjJxXBxuCeeLWlz8AbiFfG5py6Cx1hL6wlP3jVphUuZJex8iYlfqx1yVIfxc5oKLf14BsZnAoBbzUS64P3iswMxwvZ6HxAnWuo+rsrehEyRxE8W2drf6hm9ziLQxe2VwMLP0CB87RoXtUWDdx4SXtnP9pOrZBPobRehGPbIrzejOyDXOSqY8hJIkByDD56jC3Wz+YRkkXMWEkW4SfHNy21f0PS+L35cK33uOUvjFnqfOrEtDGGg0/0yB7EOcrhmpeMyVWu7G5o9DX7uj0sbzkRhbLwqNi4GJ7iLdQMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bDisyDU4Xe+cyXpkuYNKrsN+zz21o2ORh3IsqiWDBU=;
 b=fERZ7iq1nykQcL3YXrLuWIR/pPImNU7ipLm3MzIUxcIFyQvfG38aze7qZDZ6lYz9MUmSeIg371PVb4h17gfPoRdrAtGP434XAlqT/s9IhCpq9fAXrAb6p0+m4ycJ1Cw4AsKPae6pk6eoLgC0Eny+bQ95TMR4wZs1lj4pqR3/4no=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Tue, 26 Aug
 2025 01:31:34 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 01:31:34 +0000
Message-ID: <849c12a9-f801-46f8-8fff-09fbc259843e@amd.com>
Date: Tue, 26 Aug 2025 11:31:27 +1000
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
X-ClientProxiedBy: SY5P282CA0150.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::17) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 3832537a-0d14-4ee7-1850-08dde4404a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWdZMkpxRy9vdlFPL0lvbG1rK1hTOVNZZUovYi9KM2lZNkl1cEpobWY0eEpn?=
 =?utf-8?B?dXBjUFIzMWxjM1JaeEJTd1ByRWFhTk9jczhhbkJpUm40MENVMW5XeWV6V0Nj?=
 =?utf-8?B?TU5wTkR6L1RrNlg4SnJ5RE1ZVVJJWjFxb1BnMy9ONG9ZanJsZGgzSnN5RVNt?=
 =?utf-8?B?cW5laENyWDM3c3FMdnJDeVJHaWR1dmh6eFk3R2p4Q0c0cXM4QTN6QmdiNmph?=
 =?utf-8?B?bnFtNVAvR2tnbHFmK2JYb2FpZVFtK0NCNTN5ck1lWitMbGRyN1V2U1RvRXh6?=
 =?utf-8?B?RGZ6dDhMRVhEeTJnYUhSbTQ3VUw3ZkhEMW5VcmVZblFDZ2dWZksyOUk1Tlk1?=
 =?utf-8?B?VmFZRjk4UldvZFFUWkp3VmNSV0FucStwbGtZc1BqWWNyQmxpcWFqc2VMQllh?=
 =?utf-8?B?SzlYVXZ0TUlxa3N6WWVkRCtabHVidXpIV3dtdEFGZ0JUcFF4Y0tzYzkxVC9h?=
 =?utf-8?B?Ym5PRVRFeXpzdVZ4M25pZ0U5SnEzUW0ySWNPVU14MjNKL1U0Z3A1ZXMyVTFI?=
 =?utf-8?B?V3hjRktCckVOOVQzUUxQTDBqUXR3Y0pwdlhHdzNOWmpNdHlKSng3WTBLTEd0?=
 =?utf-8?B?VU93UEt5QjM3VEJsaTVsTC9xUGFrbU1rS2NyMkpybkhnR2xWOFl4MSs3bXlO?=
 =?utf-8?B?MjNIdUs5U3FPblB3VlBjcHI4NGQ3NnVEanMxT3VBV0JrZ2hhc1Rtdm9vdUZo?=
 =?utf-8?B?eDFZTTB6b3BTaVpXcTBuN09CL2laRzlDaU9uMjZHT09Ibkc1M3I3ejJEZ2Nr?=
 =?utf-8?B?TVQ4SUtXbkNodmZaS2s2SndKcm9jQ0w1WUxib2NZZERlNXNNNDh5NTZmZ1py?=
 =?utf-8?B?VG1qekU2aktTcVYzQzVTdHprODBnM3dkM2ZET2N0ajFJbzhjOXRUYk1XSVlP?=
 =?utf-8?B?YlZiYUJ1eW0yeGYxOEhkOTJkc3crTlNTdlA4QUh2RFp0UlNkeldSVnFwVS9Z?=
 =?utf-8?B?OGJPYmNwRTNHVWt0YVF3RXljMkhlQnlGUzFOQUl1MVdQVXVmZWd2cFdPV0ww?=
 =?utf-8?B?cVk4K1A5QWwrSGwyeUFqMmJvNytiNm5KelBuWlhvVmQzOUNaZlAvenh6N0ND?=
 =?utf-8?B?UWluWHl4Smdmd3RpZmVFZXJZckc2UVIvR3RHc25ORnAzaWtvMnlDUUdNc1kr?=
 =?utf-8?B?cEl0WDQxTGpUY1pCVUZxcGNLUVRnVGtPbGwvSTVadC9mQXVkM2lJYWI2WWxR?=
 =?utf-8?B?YlNWUXM2SXp4RkZzUjc2VUNoTFFsY1BxTFI2eUk4VFhuQVduczllVnhqMjJI?=
 =?utf-8?B?T3NrRTlVMndXU0piQzNyV1FGNGkzQkZsd0xVbEw2QmZTMGFHa1lyWXY2Z1Ni?=
 =?utf-8?B?aXlYeGxsK2tKdkpCNTRCUXVtSi9oR0p5cVpGYUE1VCtXTTZRMGxhQzVhaFJX?=
 =?utf-8?B?SExOa05EWGxQUU9UQk8rZHFsZC90OWRwN0RkODEwdzNYUmZMNllmMmorenV5?=
 =?utf-8?B?OWNPZzVlU3J3ZXN6a3R2RnFxZUp6RGV4bnRoeHM5T0VhL2VNM3N2bktFdHNl?=
 =?utf-8?B?WFFzbVFST1JtaVdvci8wRCs0ckl4VktMdzR3MWZ4bklOdEVjY1dkZldUdVZU?=
 =?utf-8?B?ZWpCTk9MYVZZc3VOMndoYmQvdGxTV29EeS9MN2ttZGQ1NVZHWXFKcEZwMmMz?=
 =?utf-8?B?YmRHWkpMbDN5OHdMYzNxZnB1em5MbVpZV05zSGdTVE1CeE5NdTQ4RUt5VWdo?=
 =?utf-8?B?WjQ5OWpSTnRKZU5VaVQ5T1BCSm1BQjVVY2VvQUZtWW42ZUEyak1GQXErNmw2?=
 =?utf-8?B?L1ZMUTNWdW94TkM3d01MdnhwSTBvbUJUNmlsM3AvSE54TkxNKzdBdWE5bmxw?=
 =?utf-8?B?ZXlXYWU3TVlSZ2I2a3JOUHQzVnJqdFplUk9SLzlQZVk3akY3RzdtQk5QbjA0?=
 =?utf-8?B?akU5aUUyVGh6MjAxeE9lZW9IVjJXVmY5NVNaNENNNXlSZElNZ3FWc251aWRl?=
 =?utf-8?Q?8Xgj0uEoRr0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUVzZThpQmxaQ0F1M0xIQUdSUEc3aW40TkdEVG9mOGNsSk1senlCVGpRUGJj?=
 =?utf-8?B?cWs5QWhQdXdKaXNDL3dWRFEySVJkZ0NzbWVFcnVTM05YUUZXcHpoY0tlUFN5?=
 =?utf-8?B?MFBMb2laT1VmR3R6OTNySFg1eDJ6UHJHYkNHTDBXZ3ByRE5VZHR3UXp6cDRj?=
 =?utf-8?B?Q1lqWWhHU29DZFE3NE1JdHNWSXNSVnJzSW5uNFRoY3Q1eHYvL3Yyc3pBWEFU?=
 =?utf-8?B?YWE2NXozYWRpTVJNTVgxaXZ6ajJMSVo2ZDU3NTluZ0JObmxhY044T3BRM3F6?=
 =?utf-8?B?NFl6Uzk5Mno0SFJ1ZjdZeU4vcnJkMVNXTzdYZnpxMkVCVUJORXUvdWZOczZC?=
 =?utf-8?B?aWZxcVFDYVdXK2RHakM1d3BwemcxSk42Nng1b0F2TWdUdzc5MTNpRk0zVkd6?=
 =?utf-8?B?ZlFpRk1XbVlHZDcwS0VWYVhrR0pZeDdIUGlieHYydC9hV1lvVFhLMi9MUTRV?=
 =?utf-8?B?NlFINjFXVmU4WDdyQmowYXFqWDBtaHltMytNVXVCS2VRa0VFNEFYZ3I3YTBk?=
 =?utf-8?B?NlBxU2dpRnd4WG14SmJDbFhZK2t2YTZ4UWRXUDNiV3NkZWlicThDY1gwQzNV?=
 =?utf-8?B?WVFlODRFU3UvenB1UWJQcENYdHJsOEhUdXRwdWgvWW85cjV1c0hadHVURHVo?=
 =?utf-8?B?KzUxV01iMldzQ1pSTTYwRzg2ejNHMS8zdVczNCt6cFBZdnZuL2RFNUhsK1k4?=
 =?utf-8?B?eFpmYXVDZldLOUM5NGt2V3VNaW9uOXlqL3JrY05ndmM5YTB5QlU3cnkwbmly?=
 =?utf-8?B?RjFRMW0yNHo5Q2xuMjRpVGFnM0RuRzJLZTRUZlZYbUorOGM3d0pkMjkvMURT?=
 =?utf-8?B?YTQvMHN0TEJGMzQxWXBKT1p4VFhBNEdVM3d4SDMwUzVYNXRabXVoYkh0ZGNJ?=
 =?utf-8?B?YjdOSUVqMG13MGxXWmFiUFZGVzRnSnM1eU5DZHFaak5wREhsVytyTzUrajB5?=
 =?utf-8?B?S2JIUDQ2bGZMcENzVEJFMDNhY0ZhVzQ0YklqYTlhYU5ENHVsRmRUdVNhM3lZ?=
 =?utf-8?B?Q3dQdXRHV1hjaE5GZ051MnhlVHN4UzlRZndLcEhQWTNmc3kyWFVBSXh1YS8y?=
 =?utf-8?B?WEFVWGJQSWEyOEh4S1dwNERzNzJWVGgzNEt4T1FtTTFOOWZMaVNnNS9lMTdi?=
 =?utf-8?B?UFIzV1ozNUx0WUNRcmNlWldsaTl3K3pIbVk3dHA5NDJ1cFE1aGQyMU1wd0RL?=
 =?utf-8?B?Nzc2YWQ1SU1KTUVCOXE3SFY5U1pVUjY5NjBaK2Y1VW9sQ0lFRHZkSHpiRlpV?=
 =?utf-8?B?QXVleDJkNXJrOTQrREVGVGs1YW5RclhwNXkvdjljb0kzM1VCUnp1bGNXY3FP?=
 =?utf-8?B?ViszakptYzlKL2MzcTNIQmJPVXhVU1NwSnVSQkFtNlAyWFB2U2xWVWkrY004?=
 =?utf-8?B?cmU1MEZIQ3Z2Y2hEQ0pyNGwwUnRidGo2SWFjZ2Zkc1hNVVdLZEJhOXBFa1N4?=
 =?utf-8?B?UzdJaGNrRnlDelhVRkFpd0FhNzErSWhueEY3bGQ0Q0VwSlZ4RGp2WElJajQ2?=
 =?utf-8?B?YUxKdzJWdlVYMTJnZ0NFemtvWXM3eEF6UHlTWVFIbENVcGV3cFJQM0dSN0tI?=
 =?utf-8?B?N0t2TzNkaldTejMwd1lIbWpYVE1LWGpYRis5Ymo1TVpLcngyWVhOS0pzRlNP?=
 =?utf-8?B?OXpBVUdDQ21ZMmk5NjNseFBQTzNwM3FBb2p3V00yN0o1c0FCMEt5ZWprQ0Vy?=
 =?utf-8?B?OHo2WFhqcmpPRE1pUXJrdEpCZWRLektId1g4NjlLTWlVRGEwVVZ3QzNJc3JF?=
 =?utf-8?B?MjFjdnVvUjkvSmRjamtwaGNpclR0Y0RDaWlZMjF1aHFPU0lrdGxsMi9aT0ZO?=
 =?utf-8?B?ZVMrdzRCZGY1UmVUei9DZnJMZnJucWRiRFVZYUlZbGwrRGs0cXB0QU5pb3Zt?=
 =?utf-8?B?dFdsZEEwYzY0OXpLNGhOdkRqaDdua1BUWXZyVytNcHVicVJiTkVuT2VoTW1k?=
 =?utf-8?B?Yk9iOXhqQjVjUWwxRHZiYm9CNEJvajZiRjd6b1pOTnI4VUlma2FiSXJYb09w?=
 =?utf-8?B?RkZNVVFueDhnMCtUeFNySnJyZmx1c3lnby9qVU5QaG5ZRDhZWk1WWk9uYzZB?=
 =?utf-8?B?M2ZxQ1RlcEwvT0FhcEVSa3dKdkYxaDNCR0pud2Q3UjhTek1KcXNxZU9BakRh?=
 =?utf-8?Q?2/jAxeKEM9W0DEsviFKGu63NC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3832537a-0d14-4ee7-1850-08dde4404a9c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:31:33.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfFXU6Ge8jwjNMvkSriRMcWUZz0knrE8Vf+tbYGHSPaoZgMhbKW4hi0KAf8R+F1LXmLWyhSVo0qMHNShAY/6Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155



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
> +	help
> +	  The TEE (Trusted Execution Environment) Device Interface
> +	  Security Protocol (TDISP) defines a "TSM" as a platform agent
> +	  that manages device authentication, link encryption, link
> +	  integrity protection, and assignment of PCI device functions
> +	  (virtual or physical) to confidential computing VMs that can
> +	  access (DMA) guest private memory.
> +
> +	  Enable a platform TSM driver to use this capability.
> +
>   config PCI_DOE
>   	bool "Enable PCI Data Object Exchange (DOE) support"
>   	help
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 6612256fd37d..2c545f877062 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>   obj-$(CONFIG_PCI_IDE)		+= ide.o
> +obj-$(CONFIG_PCI_TSM)		+= tsm.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index c6cda56ca52c..6bd16a110916 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1811,6 +1811,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   #endif
>   #ifdef CONFIG_PCI_DOE
>   	&pci_doe_sysfs_group,
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	&pci_tsm_auth_attr_group,
> +	&pci_tsm_pf0_attr_group,
>   #endif
>   	NULL,
>   };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 10be2ce5e5d5..7f763441f658 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -517,6 +517,16 @@ void pci_ide_init(struct pci_dev *dev);
>   static inline void pci_ide_init(struct pci_dev *dev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_TSM
> +void pci_tsm_init(struct pci_dev *pdev);
> +void pci_tsm_destroy(struct pci_dev *pdev);
> +extern const struct attribute_group pci_tsm_pf0_attr_group;
> +extern const struct attribute_group pci_tsm_auth_attr_group;
> +#else
> +static inline void pci_tsm_init(struct pci_dev *pdev) { }
> +static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1b597b6e946c..c090289b70be 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2620,6 +2620,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	pci_tph_init(dev);		/* TLP Processing Hints */
>   	pci_rebar_init(dev);		/* Resizable BAR */
>   	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
> +	pci_tsm_init(dev);		/* TEE Security Manager connection */
>   
>   	pcie_report_downtraining(dev);
>   	pci_init_reset_methods(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 445afdfa6498..21851c13becd 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -55,6 +55,9 @@ static void pci_destroy_dev(struct pci_dev *dev)
>   	pci_doe_sysfs_teardown(dev);
>   	pci_npem_remove(dev);
>   
> +	/* before device_del() to keep config cycle access */
> +	pci_tsm_destroy(dev);
> +
>   	device_del(&dev->dev);
>   
>   	down_write(&pci_bus_sem);
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..d00a8e471340
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TEE Security Manager for the TEE Device Interface Security Protocol
> + * (TDISP, PCIe r6.1 sec 11)
> + *
> + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> + */
> +
> +#define dev_fmt(fmt) "TSM: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/xarray.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/pci-tsm.h>
> +#include "pci.h"
> +
> +/*
> + * Provide a read/write lock against the init / exit of pdev tsm
> + * capabilities and arrival/departure of a tsm instance
> + */
> +static DECLARE_RWSEM(pci_tsm_rwsem);
> +static const struct pci_tsm_ops *tsm_ops;
> +
> +/* supplemental attributes to surface when pci_tsm_attr_group is active */
> +static const struct attribute_group *pci_tsm_owner_attr_group;
> +
> +static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
> +{
> +	struct pci_dev *pdev = pci_tsm->pdev;
> +
> +	if (!is_pci_tsm_pf0(pdev) || pci_tsm->type != PCI_TSM_PF0) {
> +		dev_WARN_ONCE(&pdev->dev, 1, "invalid context object\n");
> +		return NULL;
> +	}
> +
> +	return container_of(pci_tsm, struct pci_tsm_pf0, tsm);
> +}
> +
> +/* TODO: switch to ACQUIRE() and ACQUIRE_ERR() */
> +static struct mutex *tsm_ops_lock(struct pci_tsm_pf0 *tsm)
> +{
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +
> +	if (mutex_lock_interruptible(&tsm->lock) != 0)
> +		return NULL;
> +	return &tsm->lock;
> +}
> +DEFINE_FREE(tsm_ops_unlock, struct mutex *, if (_T) mutex_unlock(_T))
> +
> +static int pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> +
> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (tsm->state < PCI_TSM_INIT)
> +		return -ENXIO;
> +	if (tsm->state < PCI_TSM_CONNECT)
> +		return 0;
> +
> +	tsm_ops->disconnect(pdev);
> +	tsm->state = PCI_TSM_INIT;
> +
> +	return 0;
> +}
> +
> +static int pci_tsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> +	int rc;
> +
> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (tsm->state < PCI_TSM_INIT)
> +		return -ENXIO;
> +	if (tsm->state >= PCI_TSM_CONNECT)
> +		return 0;
> +
> +	rc = tsm_ops->connect(pdev);
> +	if (rc)
> +		return rc;
> +	tsm->state = PCI_TSM_CONNECT;
> +	return 0;
> +}
> +
> +/* TODO: switch to ACQUIRE() and ACQUIRE_ERR() */
> +static struct rw_semaphore *tsm_read_lock(void)
> +{
> +	if (down_read_interruptible(&pci_tsm_rwsem))
> +		return NULL;
> +	return &pci_tsm_rwsem;
> +}
> +DEFINE_FREE(tsm_read_unlock, struct rw_semaphore *, if (_T) up_read(_T))
> +
> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	int rc;
> +	bool connect;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	rc = kstrtobool(buf, &connect);
> +	if (rc)
> +		return rc;
> +
> +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (connect)
> +		rc = pci_tsm_connect(pdev);
> +	else
> +		rc = pci_tsm_disconnect(pdev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +
> +static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_tsm_pf0 *tsm;
> +
> +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (!pdev->tsm)
> +		return -ENXIO;
> +
> +	tsm = to_pci_tsm_pf0(pdev->tsm);
> +	return sysfs_emit(buf, "%d\n", tsm->state >= PCI_TSM_CONNECT);
> +}
> +static DEVICE_ATTR_RW(connect);
> +
> +static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->tsm && is_pci_tsm_pf0(pdev))
> +		return true;
> +	return false;
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
> +
> +static struct attribute *pci_tsm_pf0_attrs[] = {
> +	&dev_attr_connect.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_pf0_attr_group = {
> +	.name = "tsm",
> +	.attrs = pci_tsm_pf0_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
> +};
> +
> +static ssize_t authenticated_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 * When device authentication is TSM owned, 'authenticated' is
> +	 * identical to the connect state.
> +	 */
> +	return connect_show(dev, attr, buf);
> +}
> +static DEVICE_ATTR_RO(authenticated);
> +
> +static struct attribute *pci_tsm_auth_attrs[] = {
> +	&dev_attr_authenticated.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_auth_attr_group = {
> +	.attrs = pci_tsm_auth_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
> +};
> +
> +/*
> + * Retrieve physical function0 device whether it has TEE capability or not
> + */
> +static struct pci_dev *pf0_dev_get(struct pci_dev *pdev)
> +{
> +	struct pci_dev *pf_dev = pci_physfn(pdev);
> +
> +	if (PCI_FUNC(pf_dev->devfn) == 0)
> +		return pci_dev_get(pf_dev);
> +
> +	return pci_get_slot(pf_dev->bus,
> +			    pf_dev->devfn - PCI_FUNC(pf_dev->devfn));
> +}
> +
> +static bool is_pci_tsm_downstream(struct pci_dev *pdev)
> +{
> +	struct pci_dev *uport;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	/* "grandparent" of an endpoint is an Upstream Port (or Root Port) */
> +	if (!pdev->dev.parent)
> +		return false;
> +	if (!pdev->dev.parent->parent)
> +		return false;
> +
> +	uport = to_pci_dev(pdev->dev.parent->parent);
> +	if (pci_pcie_type(uport) != PCI_EXP_TYPE_UPSTREAM)
> +		return false;
> +
> +	if (!uport->tsm)
> +		return false;
> +
> +	/* Upstream Port has a 'tsm' context, probe downstream devices. */
> +	return true;
> +}
> +
> +static enum pci_tsm_type pci_tsm_type(struct pci_dev *pdev)
> +{
> +	if (is_pci_tsm_pf0(pdev))
> +		return PCI_TSM_PF0;
> +
> +	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
> +	if (!pf0)
> +		return PCI_TSM_INVALID;
> +
> +	if (pf0->tsm && pf0->tsm->type == PCI_TSM_PF0) {
> +		if (pdev->is_virtfn)
> +			return PCI_TSM_VIRTFN;
> +		else
> +			return PCI_TSM_MFD;
> +	}
> +
> +	/*
> +	 * Allow for Device Security Managers (DSMs) at a Switch level
> +	 * to host TDISP services for downstream devices
> +	 */
> +	if (is_pci_tsm_downstream(pdev))
> +		return PCI_TSM_DOWNSTREAM;
> +	return PCI_TSM_INVALID;
> +}
> +
> +/**
> + * pci_tsm_initialize() - base 'struct pci_tsm' initialization
> + * @pdev: The PCI device
> + * @tsm: context to initialize
> + */
> +void pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm)
> +{
> +	tsm->type = pci_tsm_type(pdev);
> +	tsm->pdev = pdev;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_initialize);
> +
> +/**
> + * pci_tsm_pf0_initialize() - common 'struct pci_tsm_pf0' initialization
> + * @pdev: Physical Function 0 PCI device
> + * @tsm: context to initialize
> + */
> +int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm)

Here it is: struct pci_tsm_pf0 *tsm  (it is really a "dsm")
In pci_tsm: struct pci_dev *dsm (alright)

May be we need some distinction between PF0's pci_dev and pci_tsm_pf0 but still these are DSMs.

In pci_tsm_pf0 it is: struct pci_tsm tsm, imho "base" is less confusing (I keep catching myself thinking it is a pointer to tsm_dev).

"tsm" would be what you call "tsm_dev" which is ok but seeing short "tsm" used as "dsm" or "TSM data for this pci_dev" is confusing.

s/pci_tsm/pci_tsm_ctx/ and s/tsm/tsm_ctx/ ? Thanks,



-- 
Alexey


