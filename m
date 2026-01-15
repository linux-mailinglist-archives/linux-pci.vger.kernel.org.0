Return-Path: <linux-pci+bounces-44984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B505FD28338
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 20:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADEF13052225
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317631A046;
	Thu, 15 Jan 2026 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="asoVyo48"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C03195E3;
	Thu, 15 Jan 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506099; cv=fail; b=bFyEW/luiR59szTjJeRJA3zc0r1y4ZVX5T57tsjK3I2L8sXyF8iXIIl3w9luWOZeFy9utG2s5Mc0mWkRv8F1aazAVqh9vylALpvrla7+jdvOXbkiLj/bizYuY97TBxYBi/0ijCZDQy6mks1oI83Y4cHCBlb9/rUfvdKpUQ6wRs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506099; c=relaxed/simple;
	bh=xZ1zYoZ0ddLLHzj380teu1hs/ZZNC4W6Hl+FhoXS5QY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ObIILBbM0XOa6gaINRT0Ay+Ywinq7Jj5G+pEOJf4fVrtau8BWdEfJQgCcMTk8LwQtIUd64OlFS5QrFqyMiJVsf/I8m420d9ih3XAkb+pK6xEG4qmqTSSBV/qbASZhkq57et4iay/48hFQqL7Ju/7IXm3cMEv8hfa1+dYZKqRdVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=asoVyo48; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQpxx9T0lQdWL+hQgkXvkeLpkbuvT0btFjYhAxCgL1I1Q1D9gko9V3iynwXB79ViHLAu0L8bMkCPmrY9f3PTBPPnfrlJK2GrC32/lvVj7ZmfLYkQxwC3RUIQJF93NM+ygWISh5/BWkEq6t05Wo1txqs3dESjXvCPwZamVICJU2nAHbvQq7RijkJDCKljTVmuuYpf+8fl/+8m94ShWb85xfM2xtzQZxhMauiNuc3TMCMWFIfarEcxxYgqexc4GEObOD35Js35LFKVEiUG83Du5ZrSRF6Qp5Y5yY3oVBep2/j5XZ0XrZdEQJJtBvh0HjndDIBxqM3QDDWQlowPqFNflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0a//cW+VHOyxpdJ3aT6dFLPM0QNRP4E73nlQ401ed0=;
 b=WiBlNla7vMTYCkin3dVLjGemkp8UEsuLnj1zFzbA2xIO3cmtr7DWjH+xYCmzYy0RKTGez29fePTMCZcVLs/k/aAQvavWkOFBPXwwD/oB1k84wzX2veRx1qRmGmtwYIa+YcCi+6HJ8nC2E8lho7DkQj6xIYaJ4dBLhUhvb2aK9ISeL0Skz1uQHuNV7+nPYcnsBx3a21Ocgo4L4+oRYJMaoW++5i4/C2H/VeK6lilwaQfbUSZWtlCnDEP868OTGTve3QqZMLaQeYrJeT87DC2pHMZHgWOybY2D6ixVVCcPTmBKf/3C+B3hBLyYfW6m8Qfo3l+c1j1/XJeG+Fy7xXRcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0a//cW+VHOyxpdJ3aT6dFLPM0QNRP4E73nlQ401ed0=;
 b=asoVyo48jyrBulvgQ6q0dgEer/ZlV2YnW27Vni3ktdVQ55onBbwohUtM1VLvDfaqvC//WWW1qygugDFy2igudfsCwQlB3hjB2mUJEJw0wkM8hYuoI98YRP02crbQIUcppp/lw7ay5ivPBDMrHzA/QUZILzlWhKnBxYkEqAlAfl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 19:41:35 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 19:41:35 +0000
Message-ID: <496638e5-dc24-4d59-9982-e3a77b0f82dd@amd.com>
Date: Thu, 15 Jan 2026 13:41:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 34/34] cxl: Enable CXL protocol errors during CXL Port
 probe
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-35-terry.bowman@amd.com>
 <20260115161821.0000157d@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260115161821.0000157d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:806:130::20) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1a0824-96d4-4ac1-ea74-08de546e175f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?USs1bUtFc0VlbHNreGNrQlJpa0dza1NlT3VpT1hoaVJVQXV4L01lMm1VK25T?=
 =?utf-8?B?OHNHN0ZyN2tlV25Kb29ZTzFHbTBhWndweStqOXFvcGZuY0R2QmxGL2tIOXM1?=
 =?utf-8?B?OFp4bVlJbW9kK2x3YXB5Y09wQW5tRUdLZ2tFRjQzbE9rUVJtVVliMDBjOGxU?=
 =?utf-8?B?V05CZnkrdFhOUXA2YVNvTU40b3JvSTQxMkovUXRTQUJJVTQvMTRBT0ZHbDM1?=
 =?utf-8?B?TGJqZG0rRmZzL1hTaTJqVmFVenBDQk96eGpQVEtuZnZqQmFwcisraWxBb2w5?=
 =?utf-8?B?MUJ6ZTFpVUJXa1BZU2JVOXFUcGRvdklXV2lseldLYTI5cnFjNXR6SmhTTkdo?=
 =?utf-8?B?NjFKQ1BRSDRGWmJSVVQ1K2xKemhlN3VZbkFEUSsveVhTeDhueVNCaHEvbllU?=
 =?utf-8?B?MzFrWmMyYms5dWlYWTU0NVVFVlZrS2RaSWVyME9oeFc0R2RWSi80Rk5yZXJQ?=
 =?utf-8?B?ZnYya3YvbVF5ZHdmMlJJVmhtMHVNQVArK2VSNEFidHFIaSt4OUxUQThlTlVB?=
 =?utf-8?B?dUFTdmR5NHl0YlVlUWoyOXpheE9Nd0MrclUvUkRIbkk5bCsySHRoUS9ZYkVR?=
 =?utf-8?B?djB1TEJEa2dnTFhOSXBoZjF5MnNyNmZNNStMM0l6bVlLVHQ1L096bDAyQXlB?=
 =?utf-8?B?T0txU05EbmJaZ2VPNms3cGRndmwzZFk2WFdsR1R6cUdVQTM4NTBna05JQzlY?=
 =?utf-8?B?eHlNa0lJQlFsUjhrMWo5U0k0OStFUXdkSEdDa2NrZS9VK3JnRVVQY3pYZFpG?=
 =?utf-8?B?NWNGdUNMdVd2SDU0VDFSZWZRV091VURqS1FULzZzaVRZaDYwNlBROURFRnZo?=
 =?utf-8?B?Q2R6elpmdkErdElCY3ZPeXVPUzhlL1R1ZHhHRnNVelR5Q1NaOXc0MmhrcVgw?=
 =?utf-8?B?dndudC9kRlIvUlltNHFmTFhJeDN0ZFFiTnZjYkhUM2tTUWJpSFRkSGR6WTB4?=
 =?utf-8?B?bEo1TnFzQjQwTy9OaVhIWkRnSGMzNUxWcnMyUEVHeFVkK0FIUjV4aThpaHI0?=
 =?utf-8?B?Y2gxdUpmSXJpQ2FSR0ZIS1FJZldSUkd1cjdFM2hhUmhYUDRhZ09zSHp1bHdk?=
 =?utf-8?B?cHN1bVpacy9GdkpxTEs0bWYyTHVMbThEKzgwY1FSRXlHYTFhT0JwcVkzcWQv?=
 =?utf-8?B?QXBVK2N5YUNTWWRDTlh3UXpWTEs4YVBmNURXVzZHdy9MRVVKNFpzUnlGU0d5?=
 =?utf-8?B?bmwzTG50V3Y0Ry9vV1lHbEppREtNWXFJNlpabm44R1Bza2dVdTVJOVhWbTNi?=
 =?utf-8?B?TFlSSmVDVVFmMklMd2NucU9rN3ArMDJST3RwZXp2ZjZNeG05QURMM0x3UDYz?=
 =?utf-8?B?VGppU3lJRlYvQ09KbzFBMlpmMUZ3K0xFV29HcjVVb0lUbW9GVE5WNytsN3Vw?=
 =?utf-8?B?Z2d3dFhHd01sRWVaNXZxcmRwWXRwYVQ3eW5FSVl2YktkQXRIM0JBOEhKeDh3?=
 =?utf-8?B?aVhhWGFISjhuWDFEVnNLaUNVRGtJL3pGQ012Y2pZMzEyK1MyVmRKbUtKQ0Nv?=
 =?utf-8?B?WXk3WVUyd3JpaVJoV1p0ZG5UY1haRGFiUjh1VzVYclMyN3pzcFAwaDhCVVdj?=
 =?utf-8?B?MDU3ZzlsR2ZRS0xGei9SVXhXWXp5TEZCdTV3a2lYMmI0aUdDbGd4cmd1NHI0?=
 =?utf-8?B?SnNvb1dTekIram9KWHRLVU5Vc2Y1VUhoVGMzS0x1RktOUGg4SXozUW1ybGQr?=
 =?utf-8?B?N2x1MGRYVmJKRDJBZHdEYVZPZVpyOEpWMDZqd0JkejQ4a0M3WGd0VVQ2K1M5?=
 =?utf-8?B?TllWUzhSMHNUb1RrWXlNYWdIRnhHTllOOHNjSFl1Rk0yM3M4b2oyWDUwRjV1?=
 =?utf-8?B?TVNFcUZwS1JNeUppS0dKVFVFMGFFazBLQjFjWmJLR1grR0tUNld3ZFVvRE1K?=
 =?utf-8?B?MXM4cUk3MUNQamVwNW5mM2FQUzZtR3FselN3ZGN4c2VkZ1MyeUJ2TUV6ZHdJ?=
 =?utf-8?B?aFVSSHJEY2c3N3BHNXkxSXUwaEk3NEk5N2paZ0xMVllWaW9LOGdVMlFCRkQ0?=
 =?utf-8?B?VFlER21pWitLcWZyQWZScExwKzN2SnFWYWZlbyt2QUZyL0ZJYTZ3ZDRla29r?=
 =?utf-8?B?cnFGZU9CNEdYTGlrMWtKbStrbHN0QTFwRkt4K2ZwMEJlZHFXVjNuSXd3b3dZ?=
 =?utf-8?Q?UJPs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGtzSTc3U1RjWTUyWkdxUWRCTzI3YkNka2tVanVHNWtDV3pkMXM1VXlJTmFP?=
 =?utf-8?B?aFpLN25mZVIvd2w2SzQya3FKMUZrUWE0c2M0NnVTTHdUdmVYTkVrZndyRnd3?=
 =?utf-8?B?MjNmcHFwcjdVQXpucVN0YTJZVUNJQVhLSE1BZ0VFWGdteEg2MDB3TUI3a1Nr?=
 =?utf-8?B?aTJRRFR3b3JONnZPaU1IWnZuRENBT0JuWXBlajdwU2NPbWJicGE1c2RDQ0Ru?=
 =?utf-8?B?MXg5cm5rTnJESDVsbk9LMzE0RW9uc0QwcmErZjRtT1ZpQk1KaERFNXZkTjM3?=
 =?utf-8?B?VmJXd3V5dXBEY01pMnhmQkhQWlNzNGhrcm1tSVhnOTV1eFkxb1hmNEYyZ3k4?=
 =?utf-8?B?S3psSTUzTjc1TlRuZlh5UU9WK3IyNkllTTJvT3Q4SXN2dERsZ21vWWlJSEYz?=
 =?utf-8?B?Rms5alUrOVhiYkNMMTZBc1kvQlpXc2RkUng3cklDdGxVVG5iNTV0S1pXZ3R4?=
 =?utf-8?B?UEhQd1dlUkpmK0JRanFrL0lmT2IzcFd2c3NqYTdQWVEyQ3VrcXZwTU14aWNR?=
 =?utf-8?B?b0l4UHFKc2Z2N3VLcGwzMXVHTVZLSEY4YWcwWGtkS2s0Q2ZDOHZoc0szNW93?=
 =?utf-8?B?NEZGam9YbENZVHNUYWNMRDFianJ0aGticzBGa21uMldVSll0STlQMHB2VlA4?=
 =?utf-8?B?eUVEVjNDL0xOM2JJOW1kNjVtOTZ4M092SGc3SDVNcHJwMzJrSURTQnc1a3NQ?=
 =?utf-8?B?QlVGWlNkNnAzVm43alFsWU9obnpzMjRNRWxqUXJML25uSEQrM0docEtnWDF4?=
 =?utf-8?B?N1FKUnhPTzYwWEVsc3Q2Z2J1TFJrRDM4WUxIbmJQdHMwRXhrdkppZVp2U1JE?=
 =?utf-8?B?REM0Vy94bnpKdDZTY1F0MGQ4RmFCZk50MEpuV3BraVJIbUp5U0RYbnRrdkFF?=
 =?utf-8?B?dkhRZGY3U2Vmd2FmTG5pNFpFaUNrNCtrNUVzUzJpdzJwR3Q0RU9aeUw0aElP?=
 =?utf-8?B?SnptTGpUZjdDQXBNSExvTkpVSlh3ZVFhWmh2QUpibDRPOHdDWEw5L1RuZi9z?=
 =?utf-8?B?NkxnWEtiejZYNjVVaWlTdzl2RGM0ekpqak92b3c1d2MwVSs1Szc4b1NRb1lw?=
 =?utf-8?B?NzMyVW94MG1DQXJyVk93TXJINEFoWm1pS3E1WVBwMGUvV2JOQTBUQWJ3VGln?=
 =?utf-8?B?WkVrcExTU3dlRm55c2VIc1ljOEJ3dENralplQzJKanloeEo5YjVzMzN6aFZn?=
 =?utf-8?B?K1gzeHpMVGNrZWpjcUx5WFpoTDhKSnR6N3h5Qm1RR2ZNZFE5SGdIL0pSK05j?=
 =?utf-8?B?cnJIWWZRN1plNGJReFB5Tm5OdVJQdGNOdlh1WGxpRWdWWWVMZTlRTHg5cnJh?=
 =?utf-8?B?Mit6Mnd5dUJIL2V1QTJhZG1hYnVBWHNxaGV2SXpxRnZXQmZ6cS9ZbWNOR0lu?=
 =?utf-8?B?K1FqdWZ1Sm1KczRUYzF4aDFqNzlEdGZFdnVMWXArWlQ1Rmd3TGFQT0hOMXF2?=
 =?utf-8?B?RWt5WmdET3gvcFBsWnBtSzhtVXE0RXVmV2d5UkM5Q3NZd1FtTDBjWjk0ZjIz?=
 =?utf-8?B?eFE1MENTa2FyKzBiVjBZNjh1cE1raWptZ3pmOUVOenpha3p2WHlHcVhQRXRG?=
 =?utf-8?B?TDAwVnpmMU1yaWcvK2xwYzhQT2NWK1B5M1NLbFYrQlZpTVdUY3hsKzlVbmxL?=
 =?utf-8?B?OHN4V3BHczQ1VVlMUUtyVUlLd0taT09sK2djM0lNQk5SVkJ2VXlHd3d6OHF3?=
 =?utf-8?B?WkNNSGkvQUpWRlZqNnd0dnVYUmxYV24vd2QyeUwyUGJXeDVlWDg3Uk55cWJR?=
 =?utf-8?B?ZWdEK1QvZmh6NFpGT1hyRlJHaklPN1drcFJOQUZIa05kVm51NVMxQWFjeTRx?=
 =?utf-8?B?YzgzeHZnS3BlWnJSMUxsQmRDRnRZdmY3QmVYelFhRFdrcWRDTzZmbjdjczRB?=
 =?utf-8?B?UFMrQVJrSUgyUHJBNm9ZVkthNVkvQW1mS0pyR1Myd3JxZGxETlIyekRJeFdO?=
 =?utf-8?B?MDlxSENMbmtRQTZ5LzI4eDFtbldIV2FGUWc3TWFES1ZCSlRPcklkdUp5ZUJC?=
 =?utf-8?B?cEVSZlhaMjMrZVVxSGVmeUVYUlhvY1gzaU84U0hKY1RIbFBxUG1UeXh5cUZs?=
 =?utf-8?B?Q3dZVlJ5TElFNzZJWS9tbWZ1cGtYa1hjNGxTSDZpZVZGSnZlMEtsaTlkdHR6?=
 =?utf-8?B?NjQ4d2dHcmJHOUczTGU4L1VsOHdtVEh2SGtlb1FpYkFSMmpqZVNocG1DeWhh?=
 =?utf-8?B?bU5tSDkvTDFDT08vOWhpVk55UzQvMmdXenhlREFOTmZ2amo2SEEzSmg1dnA0?=
 =?utf-8?B?WDNUMEl4N1A0RDMraWtuRTZPSTRha3Z2TGZQODNYMi84NXdzM2ZsUzdndEh0?=
 =?utf-8?B?MEpDY3Z1b29MajNqbVJIajRTQklITGhndmZ3Z2xaZGdCb2hiTVdPQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1a0824-96d4-4ac1-ea74-08de546e175f
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 19:41:34.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZez7awB5mS+31N4CDx15zJqwCiA2UfNjJVLWgZIqwPXQm9wjexvcHYDPltKpTH6jEqNaE/k0NpEK5C2KYZI8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357

On 1/15/2026 10:18 AM, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 12:20:55 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> CXL protocol errors are not enabled for all CXL devices after boot. These
>> must be enabled inorder to process CXL protocol errors.
>>
>> Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
>> pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
>> But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
>> Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
>> correctable internal errors and uncorrectable internal errors for all CXL
>> devices.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>
> 
> A question inline.
> 
>> ---
>>
>> Changes in v13->v14:
>> - Update commit title's prefix (Bjorn)
>>
>> Changes in v12->v13:
>> - Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
>> - Add Dave Jiang's and Ben's review-by
>>
>> Changes in v11->v12:
>> - None
>>
>> Changes in v10->v11:
>> - Added check for valid PCI devices in is_cxl_error() (Terry)
>> - Removed check for RCiEP in cxl_handle_proto_err() and
>>   cxl_report_error_detected() (Terry)
>> ---
>>  drivers/cxl/core/port.c |  2 ++
>>  drivers/cxl/core/ras.c  | 22 ++++++++++++++++++++++
>>  drivers/cxl/cxlpci.h    |  4 ++++
>>  3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 0bec10be5d56..588801c5d406 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1828,6 +1828,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  
>>  			rc = cxl_add_ep(dport, &cxlmd->dev);
>>  
>> +			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
>> +
>>  			/*
>>  			 * If the endpoint already exists in the port's list,
>>  			 * that's ok, it was added on a previous pass.
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 427009a8a78a..e299eb50fbe4 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -117,6 +117,24 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>> +void cxl_unmask_proto_interrupts(struct device *dev)
>> +{
>> +	if (!dev || !dev_is_pci(dev))
>> +		return;
>> +
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
>> +
>> +	if (!pdev->aer_cap) {
> 
> Add a comment to say why this might not be set.  How did we get here
> with out calling pci_aer_init()?
> 

I borrowed this from the AER driver. cxl/core/ras.c and pci_dev::aer_cap are 
both gated by CONFIG_PCIEAER making the only explanation for !pdev->aer_cap
to be caused by a missing AER capability. The CXL device is broken if this
happens.

-Terry 

>> +		pdev->aer_cap = pci_find_ext_capability(pdev,
>> +							PCI_EXT_CAP_ID_ERR);
>> +		if (!pdev->aer_cap)
>> +			return;
>> +	}
>> +
>> +	pci_aer_unmask_internal_errors(pdev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_unmask_proto_interrupts, "CXL");
>> +
>>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>>  {
>>  	struct cxl_register_map *map = &dport->reg_map;
>> @@ -127,6 +145,8 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>>  	else if (cxl_map_component_regs(map, &dport->regs.component,
>>  					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>  		dev_dbg(dev, "Failed to map RAS capability.\n");
>> +
>> +	cxl_unmask_proto_interrupts(dev);
>>  }
>>  
>>  /**
>> @@ -159,6 +179,8 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>>  	if (cxl_map_component_regs(map, &port->regs,
>>  				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>  		dev_dbg(&port->dev, "Failed to map RAS capability\n");
>> +
>> +	cxl_unmask_proto_interrupts(port->uport_dev);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>>  
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 3d70f9b4a193..0c915c0bdfac 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -89,6 +89,7 @@ void __cxl_uport_init_ras_reporting(struct cxl_port *port,
>>  int __cxl_await_media_ready(struct cxl_dev_state *cxlds);
>>  resource_size_t __cxl_rcd_component_reg_phys(struct device *dev,
>>  					     struct cxl_dport *dport);
>> +void cxl_unmask_proto_interrupts(struct device *dev);
>>  #else
>>  static inline void cxl_pci_cor_error_detected(struct pci_dev *pdev)
>>  {
>> @@ -104,6 +105,9 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
>>  static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
>>  {
>>  }
>> +static inline void cxl_unmask_proto_interrupts(struct device *dev)
>> +{
>> +}
>>  #endif
>>  
>>  int cxl_port_setup_regs(struct cxl_port *port,
> 


