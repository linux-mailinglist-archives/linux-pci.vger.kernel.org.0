Return-Path: <linux-pci+bounces-19569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A85A0672B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 22:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F89163DEC
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 21:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B1C203710;
	Wed,  8 Jan 2025 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HyXXTB94"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD5E43AB7;
	Wed,  8 Jan 2025 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736371582; cv=fail; b=Er3OszSrXFVhip4EmJlR/3ax8ip0s/sLWkTKpMVYcKtJwGUw5CCZP4FipJ9JyTp70aV+peokfeBk998ir7OSnHHQsbsUjYMPEd0n8Ui3H25lj4x85+vI+NZh3gNUTkxRPI1V32e8l/hAI06r/oO9XqQf6u1xffxjZVZ7t/I1Fxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736371582; c=relaxed/simple;
	bh=fVKcMGpjT4UGKSmdeV5/k9/87KBch9Pj0Z68aIpyKn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XuTh8MNIQr4typdFLubPrJ9YNCTSW6YW8M2MuI8jljMHx4ozWTVexA3kinvIeuwcdiqC3uC9bTs4qJjkmEQGlxmYvPgNPw7xxCUj07C9RrIuKP1y6HWSk/W6L3hGikWLRHOsD9KKLW3zRz5iqgemwrzA356PszVSq317TamrOuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HyXXTB94; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVd9hIcumGnXkVRBznDYchDYEMNMB+Xw/Bd59ceskY7EuuhE6aEFD7f+7A322xFg2aatHFaWAE+NeSAH5Qy1x+Qx8ogyUGj4HYLpO6egH9y3oXYPLG4tL3MbUuRb4+o4iOqnyRQRUbpMebT19IMoJJgUQEsPbeyiuHErPdCpmX9DAQ1YtHGP8+6QAr1/Dq5NXnnkFWEZMmz6QnX0GVvSNOvEYXPwWJpDQ9J+3dlZDQNTMdYwoTgSFZOxfM2um1eE5DADxYga7a0Fqc9PaGtNC2gVJ+yxJS4iZHhv9qzt0Zq7S8E8mK/XXhhS19+dR47QRIc0vMAce2CnUn+2LciZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TWAkBhQC/nISS6zulXKxP0AJAzIwadAl8dgMPqCz+c=;
 b=wrYqfccE1uGgZl/SW1bv9Jsh+a6Pp78abArDAyEaE5Fx3LHK7JwcuqAqgv9nfGTQ/XQeHS3W9LWloK1n1sK/Vq3Ci2VBg0If/9tCBViP1m3v/Xjamg3yulCimKjtVEmgrGu6lI5YJng1xB8gXzcGveaLszgMc3/er53ZBKuSnrvR+uO9YGAa0MnnJmdQOtfghCOb7OAfwl3OWne9xywcOhF77wFudxAYyqq+reqnjNOtVirrH/eqKjANwbSY19HcxwTD+e2Zx9ShU3SDhUWWJExkQRKU4KOfTi6VHKkXLEhJ+vnaS4urVTvm4tXdDxHMYUpJqL5+h5P/AdKpiKByXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TWAkBhQC/nISS6zulXKxP0AJAzIwadAl8dgMPqCz+c=;
 b=HyXXTB9492cnQcMoT7JPPkBAMZtniSJuJeRbrgKuLSZuy8SvltA9+1kTS3u5E1xm3SZSBMpKA+TWhh5Hv+XMm7gaMXg8cFbwHM7eFRhmDv3N/iB2fBZOz/vQ1f16+SXi95oPbJEFL+c7UCcG4uQKJHt1sr1kO1vZp9/GchQ95/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Wed, 8 Jan
 2025 21:26:17 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Wed, 8 Jan 2025
 21:26:17 +0000
Message-ID: <959c10ce-9f84-4dd5-8506-9d094f0d6762@amd.com>
Date: Wed, 8 Jan 2025 15:26:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Avoid putting some root ports into D3 on TUXEDO
 Sirius Gen1
To: Werner Sembach <wse@tuxedocomputers.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241220113618.779699-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241220113618.779699-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:805:106::35) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: ebaa2f47-8acd-4509-7c53-08dd302b1607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTNJNStqTmpnSHFMMlRYRjBJWmdxd0tiZjdpMHBTdUxNcTV2dFdTeFpXMVd3?=
 =?utf-8?B?cURzYzFlUFpEcEpnSTNhWTNwSTJubEVJaXRXbi9zdkx0dUlia3RyM2NvU0ND?=
 =?utf-8?B?Ujkyb3pCUHJlUEZUckNzL0pxR09RQlFCMVMyd2wxSEVZQ0tOWmRzUDhGUE9W?=
 =?utf-8?B?VGp2M0dac1VkMTBacTR2NHdWTkVPeWpDSGh5ZHZsdTd2aDFyQ0RPNXJTMGFG?=
 =?utf-8?B?T1kwaEVrQlpmL21uR0NHZkQwRUZkdUpJRFpsdExiS29zaWFRaEZ1SXQ0STUr?=
 =?utf-8?B?aFNWWVJIK2tKcnRRUnN6S01TWDVaeUlvOC9WMSttRy9hOGhja0d0SCtFN0FU?=
 =?utf-8?B?aXBQOG9TRng0eG8yRWp6NzVQenNJU1JIb2hzQTZqSncxVkgrajZHdmJlVkg2?=
 =?utf-8?B?cmJoS2hwQWxkSzNrZGhTZUd1ZDA5SURrM0NRcmVyTFNGYXdlM29ld1M5VEh3?=
 =?utf-8?B?TXoyYzZGdTc0TE1EclVxck5USG1RendPcm9wbVo0QXdIYW5NSlAwUzNYWmJj?=
 =?utf-8?B?Y25udEpWOFc1TExQalBKd29TWjg2WWdkOHRuY25KK29zTEo4dENjeXcyN3RM?=
 =?utf-8?B?ZVVRNkhTUzdVb0NoTS9SalMzZUdQNDdUcktmaG9kVVFTRTZxZ0dqY3FGKzFQ?=
 =?utf-8?B?VXJyVzJra3VaR3pQZUVhRzFWTUNpdktTVlBFNllyRUtUT2pGN2MxdERpa0pC?=
 =?utf-8?B?NGlNWU54eWMvYWMvUDdISmtiWHFIRm14KzRGUUJ2dm4wT1RkSUUzVXFJT3hi?=
 =?utf-8?B?TXpFd3RPWSt2eHRTUWJ5bEd0QU9tWEJQQnJKTkQzOTdXMms1U0htS1ZQR096?=
 =?utf-8?B?UHBZdHdIcnp1ajBWemY0b1pMVExCNldQTDlVYm4xVnRaN3ptcmRuY21kaUkw?=
 =?utf-8?B?RU9QRDRXSmdhWU9iL1VzTFc1bnppRFZLUFNnbXlWVCtSL1hCSU9qeTlxNVlN?=
 =?utf-8?B?a3IzenhOZzF4dDhETHNLQVY0ZERJMVNlN3JPUmhjRnhvaURPblhuL2YyYjdR?=
 =?utf-8?B?VjIrN2tlVGhsYjZ5ZWM3SXVvVDBrdzI4WGN0WUVyekY5QXJPMk42UDdlQVZ2?=
 =?utf-8?B?SUsrSG5MbmVOSWpGTTNtK3pZQmJQTWN1V2xUdExUT2JZdVA4cHFmcDZZdWVx?=
 =?utf-8?B?bWJ6ak9rcHlSanhTNXdlRnR0Vm0rbVFPblFhSFBaenViWCttTVF4eWJKT1pk?=
 =?utf-8?B?Vjg4czZsMjMzUkZFR0xSdWRIRERDMlI2MGdMTWthalphWFpvaVFIYmExS1NS?=
 =?utf-8?B?ZTZMa3JyeXU3SnZXenN2UTFseWxQY2RGRkp5by8wTGxQb3Nqc2pQcW1RTVpj?=
 =?utf-8?B?YkFhZkpWQ0JIcEZTYTdHM3E4WW84TytXY2Y3ZGFvYmYrTnhwbXdiZkkrQnU4?=
 =?utf-8?B?Z0FpbjFvNUV1NS9FRjJ4ZnBBbSttQk43VUp5RnlwZXYzNXlLaGZmbWJPOEph?=
 =?utf-8?B?bWkyZTJuZ0pjb3dGYkVscHVoeW5TbExEdmltcklBK1k5NENYME10L290WW5E?=
 =?utf-8?B?aTJ6L1pjWWR1Q2dSRUdURzJIeStLaUZCeEp1Tk4zNlJBa3lPeTVKOWg5UGtu?=
 =?utf-8?B?REZaQmlIL3lic0dRTmRPNGpZVEpVTXBWbVRKTDluMFVHMUlhZWVLMjN2V2NM?=
 =?utf-8?B?dnZvcW55UWpzb1hyVFFrckZ4a1hmUDUzT0VFSVVqc3ZidXVTcUM3TzI3S3hG?=
 =?utf-8?B?elFDZDk5R0pCSUJDOEhTbTJ1Q0ZHVW5NcTF0MmVVclpKMVd3ZTFuTjJmSkJq?=
 =?utf-8?B?UmF4V1FvSGF3eGE4M3BHVWhXclV4QkYyV2VsaCszVmluUkJXczNhTVRKWEhQ?=
 =?utf-8?B?Um5FTWxoeUtwY25GNWVPSDhSVFFLcjN0SWFqOVRQRzNlY1hrZWdpdjdRSlcx?=
 =?utf-8?B?V3ZjZ0V0ZmhNeG94VWxrbWlINWYvSVBUMGl4M0VuUGlEaVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekFSTXpjWTF1c0lINEhNVXovdVVBV2x2ZWFOWCt0OHBTU3B4Uk9GQitnclRz?=
 =?utf-8?B?WUx5UEl3QTJVTmorbDhxZFZPbXEwZUhNWFRJeExxdHA1a1E3SWVwU1E2bjZ2?=
 =?utf-8?B?Q2h0NG5nVmszbERMbmJzUnNJODh4T1NGNGZobEw2WEZQSS94UC9DUnovZmJI?=
 =?utf-8?B?VjFVam9FQWVtaHpPbzA0UVA4UUt1Ukp0eW5VQXFlRmFyQ2RUWDJYRjk2WlpT?=
 =?utf-8?B?NWw3YU1DZUJ5YUFhWmk5S1FxcWhFT0J2OHRrbWg2Um9nbXAyWVErK205TGYx?=
 =?utf-8?B?djFoYTlzemVoQmR5Qjd2azFhbmswWE9iZkZORnkwekRUZUlkTVVGNEF0WDNM?=
 =?utf-8?B?QmFDUG4wbFJMVk1OTWtQR3dHY2djbEE5QVlpVWlsbTB2Z3Y2cFhsT1I5S2ZN?=
 =?utf-8?B?dnFBcUY3Rzg3NXUzK3hidUtkOFVOQ3BYYVhJZDliTHRJRHB5bnJIREt6VkVh?=
 =?utf-8?B?OEFuMnVUc1NFTTJ1UDZmeFlyL2Yxb0lLenh3V3VmNWtDbXlIdkE2a0orYnJX?=
 =?utf-8?B?WDU0dk11SnBPL3FycGppUzJHVno5SHhvWVJOOGhBOG9ZejgxcEE5SU5na0lF?=
 =?utf-8?B?V3AzbUd5MGdpUVEySCtHdmVRSlB6cUxraGJncy9MVkYzMjUyN3JVSlcySWl1?=
 =?utf-8?B?aU4vVVJqVnNHejlnMlkxZEp4TXVlMXFDTmhmWCtxRlBDaUxyVGZCUE44azd6?=
 =?utf-8?B?MHhvMitxdUptV3h6WXNzZ1NaVTBqMml2VjliRk1SN0s2NElXZmpYMVkrdDF4?=
 =?utf-8?B?emg0V2M3bzhRaGpGeEpENzY2WjBCQzdKOWxFYVhPd0NaczJpcDR4L2tSd2xu?=
 =?utf-8?B?ZGIyZUROODZpOHNLUmpDbGh2TmhUbTZJYmpJN2haWnFKSjJpVEVrRWtsZnFD?=
 =?utf-8?B?SGVCNG9mYVRmWis2R2pLVExUdEdpc3duVXZyd2dGazQxQkFLalJGSU4zUDVY?=
 =?utf-8?B?Y3l1MmlOMnBSUWVOMC92VjdwQjlIZ0dCVW5EZnloamloNUFGMmJnUktvV1lX?=
 =?utf-8?B?YjhqWjg2R2Rob2cxeHUvelJ4aGM4U2xodGNINmx2aU5WQW9EZ2RPbzFSY2h6?=
 =?utf-8?B?d2g2enJ2OWZaZW9HeGZnbEppMWZ5SzlBM0NLbDdnbGYxcUkrMFpoRDF4dWZW?=
 =?utf-8?B?cGNhRkNIbjdVRGtHSlVOQnZmZFRucHZpUHdUVURlQWhvaHZpWC90Wlgwd2Vm?=
 =?utf-8?B?R1NRQXNzSnhTUmhQNlhESE0rT1BoaXRKNGxRODQ3Q2xaMnIwRU5UWWoxR09T?=
 =?utf-8?B?UUgyZ1VqUXYvcmF5SVk3eDluQUJUcDZtbHNsMytDN0xZdlFZd1pQQmlLUERG?=
 =?utf-8?B?dlZjVlE3N09WMXZmUUJ1NnRjRFVLRkFKL1ljSnhwWEFkOG1LWXlVTm45UTBo?=
 =?utf-8?B?S0ZJNlpyRXJiYStMY1FqZ2JNVW01V3dsdXQxZHpDdzl5dEJmY3kxVGRjK2Z4?=
 =?utf-8?B?SjdDS2wydHV3a28vRk5NSlJXb3JDSTgwQ3hSZHNDVFNsS3dOb1J6a3NpZU5o?=
 =?utf-8?B?VmlHYlErdDhFMFpiNXBPQzNyM2Nha2Z5RUl5RWNJT2hVbllxZk04Vk1Nb1Vn?=
 =?utf-8?B?dkR1S1c2T1cveElyK3hnTVNyRmQ2WWxZeEZvQ0NkQmF4ajVjZ3lnQU8zb2xP?=
 =?utf-8?B?MXFWdk92WmF0TVVvc3hjejN5UmhzdTRkSEtBVkQ3b1haamNGZXd6L0JZS0pq?=
 =?utf-8?B?bVQ3RTBIcG1rYU9pQ1o1V2w2UjBSd0ZBbElJb2x5ZkVKV0VIYnRzTkU2SW84?=
 =?utf-8?B?L2t3YnAzT3NGbkluckVvNkNjU0l5SHRHcGlOK3hDWXdISDBWZEpwTkdUZks5?=
 =?utf-8?B?eGlpTVlJaVV3L3I1L2czSmtPbitkWTExaEhnR2xCTTBhckxUU0pqeXVjYXM0?=
 =?utf-8?B?Wm9aV2ppQmtFbWpkbXhQbjAwNUJ2ZHoxdzZvNHh3MlgzT2NhblRDOHM1M1FF?=
 =?utf-8?B?VWU1M1doTWR0U1FLT1FKcE10bG1wMDNiZ21MTjlLQlQ4QUpjOHk1d0NqOVN3?=
 =?utf-8?B?VkRyN2IzOFBWSzhXMlJMWWR3d2RLQVhyMFpoMGFodzFtclhzWEZ6RU02TXF1?=
 =?utf-8?B?MUxoYzlTQ0JlemMzSUdOVWFPcXlVUFhWYkFOeXgvc2VpN1J1N0xraXhiM2pz?=
 =?utf-8?Q?PChrX6Ps/Mfc37dwnwzEvQTqk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebaa2f47-8acd-4509-7c53-08dd302b1607
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 21:26:16.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXtyi9TvqfDeSE/xZn5b7qm+GUlcaot4vHlbIf6OUykPByH3uElTALtWWcL0fOvtlKABPl7HRt5k4/VywxIKOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243

On 12/20/2024 05:35, Werner Sembach wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") sets the
> policy that all PCIe ports are allowed to use D3.  When the system is
> suspended if the port is not power manageable by the platform and won't be
> used for wakeup via a PME this sets up the policy for these ports to go
> into D3hot.
> 
> This policy generally makes sense from an OSPM perspective but it leads to
> problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with a
> specific old BIOS. This manifests as a system hang.
> 
> On the affected Device + BIOS combination, add a quirk for the root port of
> the problematic controller to ensure that these root ports are not put into
> D3hot at suspend.
> 
> This patch is based on
> https://lore.kernel.org/linux-pci/20230708214457.1229-2-mario.limonciello@amd.com/
> but with the added condition both in the documentation and in the code to
> apply only to the TUXEDO Sirius 16 Gen 1 with a specific old BIOS and only
> the affected root ports.
> 
> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org # 6.1+
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

So I don't think this should have my S-o-b.  At most it should 
Suggested-by: or Co-developed-by: since it was based on my original patch.

> ---
>   drivers/pci/quirks.c | 30 ++++++++++++++++++++++++++++++

I think a better location for this is arch/x86/pci/fixup.c, similar to 
how we have https://git.kernel.org/torvalds/c/7d08f21f8c630

thoughts?

>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 76f4df75b08a1..d2f45c3e24c0a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c

> @@ -3908,6 +3908,36 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>   			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>   			       quirk_apple_poweroff_thunderbolt);
> +
> +/*
> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
> + * may cause problems when the system attempts wake up from s2idle.
> + *
> + * On the TUXEDO Sirius 16 Gen 1 with a specific old BIOS this manifests as
> + * a system hang.
> + */
> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "APX958"),
> +			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "V1.00A00_20240108"),
> +		},
> +	},
> +	{}
> +};
> +
> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
> +{
> +	struct pci_dev *root_pdev;
> +
> +	if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table)) {
> +		root_pdev = pcie_find_root_port(pdev);
> +		if (root_pdev && !acpi_pci_power_manageable(root_pdev))
> +			root_pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_ryzen_rp_d3);
>   #endif
>   
>   /*


