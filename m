Return-Path: <linux-pci+bounces-27319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1458AAD46E
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 06:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51E51BC126B
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 04:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66A71D5142;
	Wed,  7 May 2025 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sat6pluf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2AC2AD20
	for <linux-pci@vger.kernel.org>; Wed,  7 May 2025 04:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592181; cv=fail; b=WTjGXJGsKjFg8ec/glorIIJ/xrha2xQM1e83JoihiG0Ciy/8vii/9wbsMKRUfKnHCgmB5508jZBUJQ5b9J05HG2TPZDQ2k3Ljc7igipF+AKkGJBVWC4lapi849HqXOMu+l4Cxm/TqK34jnC7UUx05zTNEOiwvjj8RzFJEg/2TS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592181; c=relaxed/simple;
	bh=GgvDN46E1x8eADU6zUY4i0ug/VB4KYMlii5If1e0ro4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+sJORQABL1IJe35/LF0M2AbM163u0qTOK7t4YUPXjIEexImo4h9PXQphfS6UImNy5LIhwYNoruzZOt96vVqvuRwGZZBhBUrASS490UptFAqhRRBp25h5T7FYpiP+/CXVNrLqnhwgbTjltXBYW/HZms/XRGrKcfOkyLhdnTJ5jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sat6pluf; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4J6/khWEBqOnbK+U8LDJxEtSVqtB64YCGQeJeBUZERmDRCNapj+Nv8xTPoibsXi2x5/rX4AZFsTwp+rFPFRT7rfZHl7uPYyJKXBrYO0HCYmTqVydvAcXlwv7fj9Y1Kqxj8y6/Xw5K2VK7deU+eJhKoQyPA3B8UND2SwM+UbWQ72RZVCRgo+s17lNK8fStTYRne+WNh+yZZGoeDWnhaBClljTSupLLdhxISOOhOSUh0X5zZKHxhZZSyb8hsTqnoSTh0sQBdVxpsleJv3ldf9HUOWdCQ6ogyHPQC5p6JCpHQm0MTsGtxiHZ75OhYc4zyQKXhQ7ttQQaQlpiHwvqzBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrTOU8I2i/eDC0oJZsqv+XDOJ++kc1miXamHy0OoahQ=;
 b=K7WVHbhB0//eRLJW4z3500wew19XfJO+srbXsZefbYpQdVyRqIu+JqbJCAFb32ylxYVvAr7LOOKh4nXbA9hOT2Mj3K0ei5nIJmMLb1p0iMmD0D0Out16jAmg8CbQbL7+6KUrTGSykAhkfX0Xs1mBSji5aP3QSrQ54zxiH8GXmOY6CMgx9Wsthr1Rt2eozaGZXSvBdTak9vmHhscevkJQ+yXwbO0i861ZFI8xKBrYsrB/MHgK89lLuogcFD1AMhd2mXmYdStXFp9CqdgRlJHmVSpDVit13MR8D1xTEnOC16+eLCVcd3KZzep0+Hq4hHaW213YQNhld+qufikC+b8znw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrTOU8I2i/eDC0oJZsqv+XDOJ++kc1miXamHy0OoahQ=;
 b=sat6pluf9lz1ywlikHF9hZMXSlXDXuKtzZFQE5DcToYbNRodlzvRPhIM7fqHN2NX3KocOEn+c8jlT20vgyEkPXyBSnm0ufq+VR7V/xJQ+2rExaulQY0EwC7DPJOC/x/gtJ0DFLkvbpaJqwyiQvQjLv63eMJDrUlgeHO+eKvDubekV6OEnL8/NICx27vjon2mxyOIqGrC6wZepeE4+zlOc+1Wl3B/S3MqQJ3a/D8ijTD8cV4HW9/TZvh0uCLY9Ju4xntTnF51Alho9bACYHN3MEp70HfaFhL/xDTMfyG1ISRWbK4LKF2LVlNU/99D/hSmdyf140U+MzPxPChg7Q8EQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 04:29:29 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 04:29:28 +0000
Message-ID: <7a55845f-92ef-402e-bead-5e579ea9cad3@nvidia.com>
Date: Wed, 7 May 2025 12:29:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI/PM: Put devices to low power state on shutdown
To: Mario Limonciello <superm1@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: bhelgaas@google.com, AceLan Kao <acelan.kao@canonical.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Denis Benato <benato.denis96@gmail.com>, =?UTF-8?Q?Merthan_Karaka=C5=9F?=
 <m3rthn.k@gmail.com>, linux-pci@vger.kernel.org
References: <20250506041934.1409302-1-superm1@kernel.org>
 <CAJZ5v0jXYgLsMHyD7EQwAf47=HnU7MCpC7+Th7nnonqV-q2qJQ@mail.gmail.com>
 <68fdf9e1-8f27-46a6-a8a2-11ffb84726c9@kernel.org>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <68fdf9e1-8f27-46a6-a8a2-11ffb84726c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0105.apcprd02.prod.outlook.com
 (2603:1096:4:92::21) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3168ce-ae42-4590-3e3a-08dd8d1fc165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHFBTXJtT3piK3luQnZYRDhrMFNhdTVGNU5hUXdHOXZPT0kvYlUxN1dSU2dm?=
 =?utf-8?B?SjROcW1POHVkdmpnRFVhMjNNcGJHMTRGRUFZVmdPejErYTlpNWpac2dYTTJo?=
 =?utf-8?B?RVRYUWsyUEdLbzRtYjQ0eUpYSTVDR3R2MDFjcUxNZU56WDNFVEJOY0F5d0pF?=
 =?utf-8?B?MU95U0lZQXBNVmxURVpsWkltRVVDa251ZEtKOGV5NkFjaTBwZld6OU80UHcx?=
 =?utf-8?B?V0kzSmQzMjRCanpnWE9RVmhOWlZiOHhFMjFJRmo5cFU4cFFpRUlvQzlwazli?=
 =?utf-8?B?WlU1eXBYbHhIazNoU0Q4VzJlUDVKK25ZcVpzK0dvOHRRbGMwbTgwRDhNcldv?=
 =?utf-8?B?Rkc0dVN4Y005cXBGUlFmN2lDUFJ4K2Z4S2dPTVd3Yml5TUwxbHI1UEZuN2th?=
 =?utf-8?B?MjhENFJIZlF5WVNLc0hhcy81NWhJTXcwTXhOT3pacm14OUVPZW5uK293clVX?=
 =?utf-8?B?T0FYZ1lsQmZraDBWMUJ1aGtkNEZsb1lnSG9qMTJSQ3FoNFBZaEI4L1l1bzVi?=
 =?utf-8?B?SU8xTStjV21MUTQydFlITHNCQmJMcndLZVd6UUQxSytPTTN5M1JWUHRxeFhX?=
 =?utf-8?B?Rk5lNzRwV0ZLdnovNWI0dUh1QlRSRnkwc3BIZTRyai9yQmtBMWM2MkhqR2cy?=
 =?utf-8?B?NGVocW9kTjEzSlZXRXlyb1BkYk5aNXJ0TU9nVTh3aGF4aFJPZHBZV2laK0wy?=
 =?utf-8?B?MElFRU8zQVZmTDlHc2VBQXAwbzlFV0J2UXdTd2VFRGoxYmdjdk5yeGo4eVJs?=
 =?utf-8?B?QUlERUlMMy9DdUNORkw4M0Q1dWxES01MaTNXSndmVnFRWTBSS2RDWk04TCt2?=
 =?utf-8?B?YStzYzJOZlhYU2FzNVIzZG42Ti9Ma1BNayt4NE5sRmR2dks5QytyODY0OENs?=
 =?utf-8?B?TjRLN3FaMGxuV1NkVTdwVy9Sa1pLQXQ0NVpiSTZYVHFuNi96TUhDT1I5Y2w0?=
 =?utf-8?B?d0ZjbldQL3lWdTVsWmRZL1B0YjlNQjZGWjI2NkZPc3ErTWlLcG1LVCtsYjZ5?=
 =?utf-8?B?WjFza3Z0eElIeEw0YldoWTNwdHY5Q0w1ZnVVNnJyekx2ZnZXUWF4cVF5RFhu?=
 =?utf-8?B?d3pjUm91K2lDWTNYbm84WVNlTU5ra2wvUjZWWm5mV25Lei9sMjFUb1F1L2VT?=
 =?utf-8?B?RGFiZHlQbEpvQUcwVUtoWEJqemI4QWROcXV2dktsOElNcjNLT2Q1MmlpN052?=
 =?utf-8?B?SHcxbXlnZUhzTmV1SE94U2JHNnpXem1SQmFMYUhQbTBjTnA1RE5yYUNYcmxi?=
 =?utf-8?B?MS9ESnI1ZDBmQjNqVmo5eW1QbFRPckVDN0l4SkhvbjhBdnpZWjNLSWo4SlYr?=
 =?utf-8?B?Yml6K0psUU9BWlcyVTJ0TXlaQ3NtYUZ5eEQwRkZjdFBUa0UwNmJvZTBDQ2k2?=
 =?utf-8?B?NVd0Mnl6SEpWb2ZNY2l3TXJYU3NucHRpVFZBQ1luVlVoUXdFVVpRMkpJUmZB?=
 =?utf-8?B?NjRMZHJrVFVqejBMajU1VUl5L1lJQndzVnJFZVhJZUNWbTBDU1lGU1BCaG9W?=
 =?utf-8?B?UnA5MGpVbDlBYVcwb2VXNTdqVndTQTV0eUM3WHVyMzhlK2pKaXBxV1FzeUlq?=
 =?utf-8?B?bjczMnE2SjljalFqNUFvMWdSeEQwb1V3U3V6UFZITGh2aThKZDNTLzBSbngy?=
 =?utf-8?B?bmRDZTB4bEovb1dubjluTlhRTnN5VU5IMXVSVDB0TE0weFVZdklSZS9yRGZo?=
 =?utf-8?B?VjMweVkyTXQrdmdHakZBWGNCWXZUanVFcjVZdkZVYXNjbkkzWGxIQXlrTTdz?=
 =?utf-8?B?N1d1ZG5EQ2pkdDlGOHB4RkQ4N01JdVlndzJmbWJqVEhuOCtncjJRWk90S1d6?=
 =?utf-8?B?ckFwWEdoM3RUSTQzeUFWVEt6eEVGQktweE1GYlJQQndFUE93TEFPMlZTMzdy?=
 =?utf-8?B?cmw2VkpoV1prTU5GMlhXRWRSdTl3bVFvUnp4MDU5djgvR25SWG1HbkZkaVNs?=
 =?utf-8?Q?Lst4bLMEDBA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTlUTjdwMzNleUhmVVF1UzJybEZDSUV6SzZCeWladlFNN3ltWEt0OHBlaklT?=
 =?utf-8?B?bW5KcnZuWFhuQStNU2tXNnozamd4OWxCalIrRlNja0tkR2R2dXlWVlBLcG9y?=
 =?utf-8?B?ZGVKdmhPQVEvYkpZaUhwWGllY3hoTUo0NDhkVzluWDJUemRmNnR5Q21FeWZZ?=
 =?utf-8?B?bEdSYjRDdEFVak1CRHJLazZqS0RFZjJrQVVpK3FGNWdnS0FUbEFJT0ZBWEtY?=
 =?utf-8?B?MmJtZjJSdWpSUHVzWXlWeXE3Ym5KUzdweHBveVBpNkdONkpNQmFoWS9vaUVo?=
 =?utf-8?B?NmZJYjFiSXIvTzAvck1PYjN6VzlxUlNJUy9GSjF3MHk4MnMvK1NJTjlBalRo?=
 =?utf-8?B?dUVSQTNUUnhXOWpvc01rSjUyQ25iMHRGalNFUEVsazM0UVpESk5KQUt6THdw?=
 =?utf-8?B?UDdkUkVxRStITjlPSGxNQjZGekxINFlVTUFjeEFKV2I0MGJ6V0kyeVRXNmtC?=
 =?utf-8?B?cG0weks5UFF3Q0MzcmFaUGpxUDZMeUp0WHdtaHlKUjMwcE15R0IwNmlkUG9P?=
 =?utf-8?B?L0hhZGgrYVNkdFlxd2VwUEJzSno4K1ZuVHc3eVg0UFFKRXZQdUZWQjlaVnJi?=
 =?utf-8?B?Z1NoWVBBN1RlVlFoUHdqMDBhallCVlNldlZ4dmJjYlVGcUVwMUZGM0ZYc1hK?=
 =?utf-8?B?eG1STk1TbmtraGF3THI3Qmk4cWlWaDNKblJ1aU1MM1ZSN0Y5VGxzUzBzYjNG?=
 =?utf-8?B?cmZXYkNhSWpRcGw3OU01UG9CQWtMUEREdTJUTW5BbjhxOEJhVmxHYlJXc3pq?=
 =?utf-8?B?UXZzVUpjWnlQaEgzRVFjS3JKMDNDenVrYUlLMkxMaklEaXhDdVZZUWF3UEg1?=
 =?utf-8?B?VC9mZzBhUWpHYUlyT05uN2N0OXJDVllUUGNMZ29sVlBxZFZ6eGRmL0pCQnVk?=
 =?utf-8?B?R0JTcDZqVHhHc2NpT0syZWlMVGQ3MjhOZXRVMkV3blVwMWFxV1ZCS0h4UXJm?=
 =?utf-8?B?aFd4cDl4UlJXQ3o3aE5DaUs2WVVOTWtuV0k5U05GSGpSMy8xU1NsbnFxRi9P?=
 =?utf-8?B?cThYYWdLeDZxR3lMRm5Yb0Z3MmczeklnYzFxN2RXOE1Lb25PSXZTdEdkUDlE?=
 =?utf-8?B?L2xMeWtZdXVxTmpRaXdpelA0UHp5T3pXcGtpV21od2lWWUdyWWhEUGgzdklF?=
 =?utf-8?B?WjB1em1NaFN5RGFDblNBc2JYT2NsbEh1a042RndPZTlNR1dYS2dOTXloMW1i?=
 =?utf-8?B?Vm40TllWWkJQem9CTkM4S2h2eUtoME1tYWoyMUUrcDB5TzB0OFppeGgrTHN1?=
 =?utf-8?B?RE4vemcvRzJWQmY1VytDNEEweTFqVDVGb3ptbllycEJ6VkdMTjZ3RGwzamV3?=
 =?utf-8?B?UlRCVVN4L0VndzhCdU54MmRHU2JHRFhUWmE4UzdiWnNzZjVyTlEvSGxJdTFD?=
 =?utf-8?B?b0xMWU1KK2hwVW04bDNxK3hMNjZZYllLNzNBb1QwMmdnelVYc1ZHOGlwYjR1?=
 =?utf-8?B?b1dsMzhnM3VycmdTdENRdUVMTlF5ZzVYcGx2TW1ETWNMcXVhMVRCU2U0M01h?=
 =?utf-8?B?Uk5va1ZFOTQ3OVpuYkx2MHBCRFdCRnY2MDlJeUVMZCtiQllnUENQRnQ4a3hq?=
 =?utf-8?B?WHhNMit1WnJ0TEdydnZaQ0s1Ym5aSVprN1ZNcTJJRXhKUDBHa0JoMlByT29z?=
 =?utf-8?B?SDQ4eklCeDBwalpJOUxDZTZPNy96SVhldE1Cb25YZXQ4Qk5VeENmNzRCT0Zi?=
 =?utf-8?B?dTdrOURjVThIbVJXK0FqSjU5dXpNMldGVEM3REhZNzc0M0V3c2FOWlVlcVds?=
 =?utf-8?B?TXVWdzZKNEU1cVY0RkpKcWVpQ2NGSGpvRzYyUysvSmZzVjF0SEFSRFVlMmhX?=
 =?utf-8?B?M1BwbDgwcDNMalRaZ1pzL1o2amxyeUdOR21Ub1M1VzhUQ3l4VW41dTZQQ3FI?=
 =?utf-8?B?djYxNWg2SzRMV2kvcENkQXFhaXJwV3FpamlIRnNEY2N3TGcvd3V2dVR6UW8v?=
 =?utf-8?B?N2hoaWZUWHMwOVZ5TU5HSkpDT1VLQkZTbVZ2djZUbEtmVzdpL3M3Z1ZmRC9D?=
 =?utf-8?B?SGFKSnhiYXVhSy9CQUJFaUMyM1VJZDRFc0FPbytZYzY1UUZuejJhRWlmajdT?=
 =?utf-8?B?TFVtNU50YlJERDA1dXdhb1JVSUIzQ2kvV24xc1VaV25USWVoWWJnMWRSRVNn?=
 =?utf-8?Q?CQdlkLCpgfV56nrBeZIwduUAy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3168ce-ae42-4590-3e3a-08dd8d1fc165
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:29:28.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2LfpGqAWJE/71Urd0XrDPuovfrhBSkQizFtslvZ82l0IsU85bt9NXF7we7RkmzhZYfBd5utPwk5stRAWek7jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960



On 2025/5/7 1:32 AM, Mario Limonciello wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 5/6/2025 10:50 AM, Rafael J. Wysocki wrote:
>> On Tue, May 6, 2025 at 6:19 AM Mario Limonciello <superm1@kernel.org> wrote:
>>>
>>> From: Kai-Heng Feng <kaihengf@nvidia.com>
>>>
>>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
>>> connected.
>>>
>>> The following error message can be found during shutdown:
>>> pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
>>> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link 
>>> Layer, (Receiver ID)
>>> pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
>>> pcieport 0000:09:04.0:    [ 7] BadDLLP
>>>
>>> Calling aer_remove() during shutdown can quiesce the error message,
>>> however the spurious wakeup still happens.
>>>
>>> The issue won't happen if the device is in D3 before system shutdown, so
>>> putting device to low power state before shutdown to solve the issue.
>>>
>>> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
>>> compatible with the current Power Resource states. In other words, all
>>> devices are in the D3 state when the system state is S4."
>>>
>>> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
>>> state is similar to the S4 state except that OSPM does not save any
>>> context." so it's safe to assume devices should be at D3 for S5.
>>
>> That's fine as long as you assume that ->shutdown() is only used for
>> implementing ACPI S5, but it is not.
> 
> I suppose you're meaning things like:
> 
> kernel_restart_prepare()
> ->device_shutdown()
> ->->each device's shutdown() CB
> ->->each driver's shutdown() CB
> 
> Is there somewhere "better" to do this so it's truly only tied to S5?

Alternatively, is it possible to put the change under '#ifdef CONFIG_ACPI' or 
'IS_ENABLED(CONFIG_ACPI)', so it won't affect anything other than ACPI based system?

Kai-Heng

> 
>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
>>> Cc: AceLan Kao <acelan.kao@canonical.com>
>>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>>> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Tested-by: Denis Benato <benato.denis96@gmail.com>
>>> Tested-by: Merthan Karakaş <m3rthn.k@gmail.com>
>>> Link: https://lore.kernel.org/r/20241208074147.22945-1-kaihengf@nvidia.com
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v3:
>>>   * Pick up tags
>>>   * V2 was waiting for Rafael to review, rebase on pci/next and resend.
>>
>> Is this change going to break kexec?
> 
> There is an explicit check in the below code for kexec_in_progress, so
> my expectation was that kexec kept working.  I didn't explicitly test
> this myself when I tested KH's change before sending it again.
> 
> KH, Did you double check that on your side?

Kexec remains to work on my setup.

Kai-Heng

> 
>>
>>> ---
>>>   drivers/pci/pci-driver.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>> index 0c5bdb8c2c07b..5bbe8af996390 100644
>>> --- a/drivers/pci/pci-driver.c
>>> +++ b/drivers/pci/pci-driver.c
>>> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>>>          if (drv && drv->shutdown)
>>>                  drv->shutdown(pci_dev);
>>>
>>> +       /*
>>> +        * If driver already changed device's power state, it can mean the
>>> +        * wakeup setting is in place, or a workaround is used. Hence keep it
>>> +        * as is.
>>> +        */
>>> +       if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
>>> +               pci_prepare_to_sleep(pci_dev);
>>> +
>>>          /*
>>>           * If this is a kexec reboot, turn off Bus Master bit on the
>>>           * device to tell it to not continue to do DMA. Don't touch
>>> -- 
> 


