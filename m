Return-Path: <linux-pci+bounces-32892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C20D4B1102C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 19:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889D07A3087
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5562EA723;
	Thu, 24 Jul 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CLdXQHKs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185A71E5B6F;
	Thu, 24 Jul 2025 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376826; cv=fail; b=VuHMuLfxGKoKGkF5mDgZlp1JgQ587NKDUM9WzWfsmhbiLwDpIs0woizx4NyV/NWa07zaf50A1TfYpfFzFvCvqFX7knGv2jWCJNUcfFglZXN9h1tBUrZa47Go3+cvqXs6bz6mLqRok0NSCKKpb6sauFfv1B5D15ib/iNaSyS+C4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376826; c=relaxed/simple;
	bh=aGScNSfNpfketTXZOlite0TbOLUVVV+E4usHL9TnPmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V5I+v31SiRZR9Y79RptKbhUNVcoKmBD11S+VBqLL4p1GsEQaM2Mfm5heB0/sjDcyjyRPo3ncRiR4Bqk/ut+OI+MQhUuqxX5uD9qwz2134+sawg3qfFZGbMKT1megaULZylJxflETSdVq+ItrvxDkI/G40YXOVCmzF5zbOa6Ookk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CLdXQHKs; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJ4thGbh3XHXIOqSms+C0XzOm8NJoGJEAEDLIWfb/xfwHEPEjvRlqjdPkR11TuzdBE0tsA7aTWBXNgqR9340BrYV0QzwPSt+knMZLheq26z88Etx7yHRupLNZm+cPIR3d3GG6kzt4rw5DyzLPwiHyF7xYfvx3CzeVwVTzmfUzJykq+qMvve5CyoLuyKU3xXdkErVcN2UB+onIrwkP4mbe19d4zHFmA5ZxfsMTX9GjV1q42CuoU1WneVkpInEe1LywTh5vJxoiPZJrma6eJdJ6lkMlSOt5L9NFXqK1GYmJtA7jRO+lXsvcfU2CpK7jX58uPrIxJQZdO9vW0RgU5wZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDmG6g94QXRWw52EeOglEKo6TFg3PnT/ind2guZcKUA=;
 b=cHjcb4D7bLVo9iHRr7ppVD+HiTg3oZZgiBEfWebjJdT0rI6G78AB1SCfkyHeA2Az3CWR/g0Ptv3R+nqvi+LZDW+e5vYH3xQD/mYvV9WOz2SEFR3y8cpwN7twgQlqxr9Hoiic2OdY3IV/MNyu80dEN5H77A0GsGaANLZVlIsFFGa6NcSIzvtYjvqHrghRlKkY+woVvtNnNvJgzdh4Xuwi3C/LgA629hKz/P0t2FvPfTMlNHihSEhnGMJxIzBEjih0r74Z4y+L0z/q9eyxiXix6Zw1f8BWkj0JLyDPHJME3Ge8M++nUZBo0eQ4DydsfmjY1KN4TVhgmr7V2d3FEGt+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDmG6g94QXRWw52EeOglEKo6TFg3PnT/ind2guZcKUA=;
 b=CLdXQHKsmUh9bpsYPQwo91o0+R16g/hFvF5DGiRc0YA9oBm38AX6EfH4yY6i64RkisEdMCWqhI1UNyC+Ls+VPYZJeTINtMSP1IvWomg1FzIsMCxoP1/TFT9aitTHnVew1yP5OmR7kvUAdjqqM6g8IVIidPchIfxzLXgZwPPGuHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Thu, 24 Jul 2025 17:07:01 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 17:07:00 +0000
Message-ID: <066fd1e8-d86c-4016-8fd9-6b94092ea48e@amd.com>
Date: Thu, 24 Jul 2025 12:06:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/17] CXL/AER: Introduce CXL specific AER driver file
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-5-terry.bowman@amd.com>
 <688177d0553c8_134cc710028@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <688177d0553c8_134cc710028@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0107.namprd11.prod.outlook.com
 (2603:10b6:806:d1::22) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 04294150-5cef-4cc5-9b72-08ddcad48136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjRmTE9iUmFWdkppeXNObzFEQ0dxekVjd0xpcWxiMXowYkxjeUNCejhIZUlq?=
 =?utf-8?B?dk9OcDN4V0pnL1puNkpNdzcvcTBpdlBJVU5aVmxZY25IbkU4L3NjaitCNGtk?=
 =?utf-8?B?UGVMbkVyUWFZMkpPaUFwL2hiN2V6aTBtZXRtc25SeGxUUGZzWkN2cnYzTEk0?=
 =?utf-8?B?dmVGSEVHeDNPbStZVi9QOXBMYzA2U0h6RDRWU0tjUHdmQ1pGc0FsM1lqSms0?=
 =?utf-8?B?Q0JoM0RkZTBHeTJpK2txaHVDT2tmK0RGSXQ0UExUZ25hQWc3WnNHc1U5RDAy?=
 =?utf-8?B?YnhKRnNlOFV2L09HZHJHbjQ4SGVnNGRybWtSQnhiZzNvQm5ydHl4NFBRMWp6?=
 =?utf-8?B?RzRQbDhOS3BrMTVXbzFkSVRWQmEvclM3aWc5dGFYa0JnZSs2VmRwcUIvNTJX?=
 =?utf-8?B?WVhXWWI2V3BGSThHQTVsNmtxZHNMbE5LcXhsZFpFSmdreEpsUVgzZGttS1pj?=
 =?utf-8?B?OW9va1FmdGlZRHo0YlMxUGFIWG1yQnRMTTVpbWE5bVRZcXNHMnBzZE1wblNI?=
 =?utf-8?B?L293VzNjZ25MTlNRNTlRMm9oV21Jb0dIQThKaXZiYitWQmZUR1k1L3FpWEVV?=
 =?utf-8?B?eDlRcXF2UjBCRklHWlc0bWNna0gxYmJhV014bEdicS9EOHI0L2lBZFBvKzJL?=
 =?utf-8?B?T1lnbENrY0tqb1l6UERzeVE1V3pJZTVCRndzZGtjOHNXS0NrVjlZbnJSZlBT?=
 =?utf-8?B?YU50WHlsK0lxanllSW5iNmNwRzdKTHphTHVUQ2lkMnBEcmllclgvV3djeTNk?=
 =?utf-8?B?Q2ZCRVlWR3BvQnlzeGt6RFhpRkRlbzJPOXN2UnRROGR3TitteUdsUlRPSFhz?=
 =?utf-8?B?NGorVVNlUjJGaDRaWlo2Wlo3bm9mTnBRdk8zMUtyenZNOHdrYkZxUkRVUXND?=
 =?utf-8?B?Umw0RTQwbHVoTzlMbzBUdGJna0NNeXU1d3BUVU40dGhDQmVTdjRTaTVjcXdn?=
 =?utf-8?B?eUphOHoweVB0NWNiaVZCOVpKaS8vVDV4blQvZGRFQUFQNW4rTEZkdXhZZUFx?=
 =?utf-8?B?TEM3UkRIZDFkUGdXRmt2eVBUOWdaK0hsdHNSc1RIU3RoSHZZZkpOaGtFNmNt?=
 =?utf-8?B?Qy9YUlVaa3NLRko3OHNpYXJoMmNJUnhPb0FRUzhXOGJzRXVpbFVEVFltKzY3?=
 =?utf-8?B?NXBtK1VPUEdHYjR4Tys5c21tc29nNmF4Uk5PdUFxanJMdGVqMWZHOEtjS2dY?=
 =?utf-8?B?MWp5WkpTWXlwWG1kVnNPR1BrdWFYVE5LbTBDc1pJVW01ditYUUdVQVRSV1Nx?=
 =?utf-8?B?NWMvNjlzRzFuN1hXN0R3WmlVMFZxeWk4U2w3a0pkVDFKZXl1b2xvZHJyZVZS?=
 =?utf-8?B?RlRBTGRvem1QMFlIZFJUcUZzbnFHUkdEUnNhK2ZTRVZ5YTFCWFJtWXNhcXBx?=
 =?utf-8?B?cmRzaWt0T0RTN200cmR0WXZFUUhYN01nNGJxc1RnYkJsY3lKNUZ3a2dvRnZ1?=
 =?utf-8?B?NGdlb2V0alhOOVdzOWVuenRkZGdtaU5tVU1hNGZMMGJXeFRVQ3Q5bXI1WGhQ?=
 =?utf-8?B?YlRHTFJDSjZBd0llSDRpNEtyWjRheFpwME1MeU5rK0xWYkhJZzIxVFZFdXlN?=
 =?utf-8?B?WVM3K3NrVHN5ZThvRk1JU29QQXYvTWRoNFNWWGdZMXczVXVhWHM0Rk93RzRH?=
 =?utf-8?B?S2FKcjZSY2tiYWhwbE9hRnA0OEk2TGJGMFV2VE8yOTFyclVxajVTeW96NmIw?=
 =?utf-8?B?UXdsWnp1bTJEWmlJdXQ3S3dFUmJFa3NkSmhxNGhYMVNJWWhnbWNORExnN3hK?=
 =?utf-8?B?bEJuREcrTmEvUVVPdVNWVDNZdFJrbkkxTkRJaXV3SGpxWWNud0FxbUt0cGxC?=
 =?utf-8?B?QytLbGlSeHc3bE01Y1c2L21qTk8yc1I5SGhvMkJBZzNqYjkrWWwzSTJKbEd5?=
 =?utf-8?B?R1poaXJuS2dBaXpybjJtQWE0RmlvTjlMYXdKNGhEbUkxUkoyYWtxVkwzVytE?=
 =?utf-8?B?U1ZZUVhLdzVPQkptNkJ4ZE9VTlFZcXB1dDY5bk1pQnM1cDJCMjFMMVljdURr?=
 =?utf-8?B?RG84dXhQc1dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHpHY0lydk1RR2plSjNXZThvQ3g2MGVXWDdMWVo4Yit0K3k3R0ljUlp0cjZY?=
 =?utf-8?B?VzN5bEhQRy9KZkwrRXJDbVQ5MzFPREs1Smk5b0hNS2FkWktoQldNd3VmOXVH?=
 =?utf-8?B?REpDL2RXV2hOeitucFhiZUxLRmpCZFNBS1c3cm4vdjRsQkFBdzRJY1dLTWdn?=
 =?utf-8?B?bFRnU3pFWDg2UEVKRDlzQU5ZZThoWXdvWGJ2NjNwRUZ4bndEVjVGQnNFaFNT?=
 =?utf-8?B?cnc1MDNqNzB3QkRoTUxJVUNnNHhzNm8vU05MclVNaWYzaGtsQzlFVkpUbTF0?=
 =?utf-8?B?Vk56NkVsRGJRcmF4djV3WTZGOVFYMFVmMnNxTXkvUnlrK1JTTEpMeE1iUk1x?=
 =?utf-8?B?WjZtSW5lT293TzlMMHBHTzNZUmhqN2JLaXIzZ0o5bUpzL1pseGdZVGJyLzlm?=
 =?utf-8?B?cU1HRHdNVWMrdVNmNWZyYythQXpHeTFKdDJzZXJJcXgyeFZXWUpSOEF4MTZR?=
 =?utf-8?B?eFZuYmdzaDliNDl2bE9MdlZFY2RuekVyYlArc2ROL1Qzczc1TU9kdjNmS3pC?=
 =?utf-8?B?V2xiZEZ0ZUZjMWdLb3krUklDbkk5S0pqNWc4SEgvVVlsaTZRNDJaNjVPOFJ6?=
 =?utf-8?B?NHJFRlpmU2VIV04zQzY5ZWxleGhxVmtRRTd1MkROQXIvZGdWUDh4ZXpTNkJ3?=
 =?utf-8?B?dHUvUGFvWU1IeHdhSy9VU210Q3JvZzlRODdyQTNCUWNzeXVWR3RQSkc5YjZT?=
 =?utf-8?B?RS80eFJPbTNackVMMzFSSm51d2VKeEV2eG9sM1RTNFd4Q1YvaEZRbTZObDFB?=
 =?utf-8?B?SDVKZE5Td2IzZC9KUCtPeHZiRUZHVGtZeDJFWGY1RDZZa3FVbGJEK2k3ODdK?=
 =?utf-8?B?UUxyQVIyd25vaHZlcm5wZy9FM1c0RkdIc2hOY1lhR1lUNnNtUFdlNzJkN2g1?=
 =?utf-8?B?bk1ST0Q3TnpiR1cxRWpxb1htaTQ2c0pORjY5WUFxMnUwU0FWY1dVNGFHQkNj?=
 =?utf-8?B?eXQrbHBKdW11NnlQUnROaWxYazlmSlA4djloL3lkMDhWUnhiOGloNmU1YVB4?=
 =?utf-8?B?QjFMYlNhbmhjbm5OTVZCcU90QjNMNDVUZ1cvaGVobkQ1bjlURExzdE1qMWY5?=
 =?utf-8?B?VHNXZmkwTElwL2xFeGxPSnRTY1NPNENUSGxSSGV3WWdnbyt5MWkxYkZQenBV?=
 =?utf-8?B?cG5mb3M4cjkvQU1VTEZnWUozNWVmbWlzOHkzaENDM0lHRUxrMUJ5Z2hPMXQx?=
 =?utf-8?B?Syt2YVlFUzgwL2ZJd0J5NU54VzNyb2lPUlBwRkdpSzdqbVpHaGV4UUhvOTl6?=
 =?utf-8?B?djR1NG9ZY1dsQUo4cXVJaDNCTi9pWUxBanhIZHZXcmVzdFpZWTFyL2wyRlov?=
 =?utf-8?B?N0tOUVZTY21jbFFBQ29lWmZCcWpBOGx2Z2I5eXZFaHJKTzZHM3FWaWE3NTRE?=
 =?utf-8?B?d1pUblBKMWJLZ3NVQXhaRGFmaHlXZlp5ay8wZDE4c2Rzb21vS2d6YTVFWnBX?=
 =?utf-8?B?VG9PL2xaaEpsTFo0KzJvbjlvaVgwdk1xN3FoUUtFTUR6dm9QbnM3NTVCTnAr?=
 =?utf-8?B?VWVuMkJwVSs0T3VPRDFGT2JuUlFJQlJXcVJHQkcxbUJPdmpEQk5pdkppbXc2?=
 =?utf-8?B?bGdmSTg3N3M5eW1zMlNBQXYzNXB0bm9BYzJmTWU1SUI3L3JEUTlKTG5RSFl4?=
 =?utf-8?B?c1hiUEJvNlNDRjZTNXFBYWdWSktnRGYxMUJaNjRiTytCbGFrWGJmT1U1aUJM?=
 =?utf-8?B?dXN4OEdVNGF3d2FsRnhKTmxXbHRuQ1pYZUphNWZtbnhHbGx1U2NnZk16b2Vu?=
 =?utf-8?B?Nk43WnR5OEg4SzZFWTY5OWkrTmpuNlVZMnJTMVNobEZZbFNzVkhJeDlZaHdm?=
 =?utf-8?B?VjlqRjhFTDh6d0dseGdCK1ROM1JmWXQwdHA5ZFNkdldLNENrUG5Ea3pDT2Ey?=
 =?utf-8?B?akRQbklESGQ4SlNBTWR1U1h3TWNaeTFORTA0c1Zkd0Nxa2ZYMnpFZXRpZHll?=
 =?utf-8?B?ekdYWG5SWGtjeFZVa2FTTk1pU09Cc1RTRThaSmZFTjFHTVVNdlJmZDNzREo1?=
 =?utf-8?B?dkZoc21ZcG1KS0VpQUZUQlhKSVEyQUhGc3ZLY2ROUDBLTmZzcXY1WkZudTdy?=
 =?utf-8?B?dlZpZThnbnZCVUxweng3MXJtZ1A0QWtrcXFCL2wrb0x1NVI3SEpNeDByaGxk?=
 =?utf-8?Q?JtVdXawD0u0dIkxyQx7ezGAcq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04294150-5cef-4cc5-9b72-08ddcad48136
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 17:07:00.8743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaMifNNy7RdolKREvkZSjheK0MGpKsc1gUF9J2gas1/Nd2b+q5vcQV6F77Nhflp/YFwm/y5YLS3jVxLsPOXY+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573



On 7/23/2025 7:01 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> The CXL AER error handling logic currently resides in the AER driver file,
>> drivers/pci/pcie/aer.c. CXL specific changes are conditionally compiled
>> using #ifdefs.
>>
>> Improve the AER driver maintainability by separating the CXL specific logic
>> from the AER driver's core functionality and removing the #ifdefs.
>> Introduce drivers/pci/pcie/cxl_aer.c and move the CXL AER logic into the
>> new file.
>>
>> Update the makefile to conditionally compile the CXL file using the
>> existing CONFIG_PCIEAER_CXL Kconfig.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> [..]
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index e2d71b6fdd84..31b3935bf189 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -12,6 +12,8 @@
>>  
>>  /* Device classes and subclasses */
>>  
>> +#define PCI_CLASS_CODE_MASK             0xFFFF00
> Per other comments do not add this updated in the same patch as the
> move.
>
> When / if you submit it separately it likely also belongs next to
> PCI_CLASS_REVISION in include/uapi/linux/pci_regs.h defined with
> __GENMASK(23, 8).

include/uapi/linux/pci_regs.h appears to use all values without using GENMASK().
Just adding as a note. I'm making the change.

> Otherwise, with this change dropped you can add:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Your next email pauses this. I'll respond there.

-Terry

