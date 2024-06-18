Return-Path: <linux-pci+bounces-8934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2315E90DE5B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 23:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14CFB22160
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F2F178392;
	Tue, 18 Jun 2024 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TYYA4Nke"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A863178365;
	Tue, 18 Jun 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745808; cv=fail; b=NleTGSfgNPrGECyaNlCASHfCSsjxrZIdQdFgJL3Ohx35bm02vWVr1KMw55/Zkp4C9m8JeWIzmQ3295a6ni0WzA7N6i8lWQhK9cQ+5l0J6VpNW9WE3HPsIpir1A/7mbKbjLDdyTqezosvbfFlROwRkdcJC4MS7Hr3iAPppsb1hW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745808; c=relaxed/simple;
	bh=+woq5D/4g6fdZ7mfKNj1IHXOMBeBUDimw7MxeUhRVEg=;
	h=Subject:From:To:Cc:References:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=OM0Rl4/wPSBo9bLtulYphQXAeJ1TI34MC7Ks8Vy7By84nutEcAt7tnGdLKseiJijzBey8tOmXxmmKruDuuGYFjMJV/Zdf8nme/jEJndofTr/xDWQ79JIRva/Dd9lqINeZu/YPxncvOrBfZWZXZ9b3K1diVZKqFCAcwa8q87mOvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TYYA4Nke; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khwlZbrhYCZ4CFqBqS8NxHIgWk4SKiAYst1/C1CqgFBvpnFiGT8MKB19MS1llRgEuKVh2B/qm7YSgP/zss1mhb4RKzCcj2I/zsoMczhdCojT8+e+L0qrlXRyi02RPrds+h02eppycngnvcd448wiZrrksU3QRysvvXqal6usZeEAYoHJbvZgY/4IuXcmZjIa4uYNntvpej0l3crV8KPi4Th1+06u4ELoFFAWqNh6CS9R84Rje1SuW6ztS8EETGVo9htmw0nZWgFRFD2COtbKU/BdbKoONkTNEsTElLi7C44zk1WpwRtWrjtSHAH0aPvYOxVA5iGaNIhEyTl6i3NatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2hHC1TVJui4u7nekhT8z9emQ5zVcGOmPYJUn1nBz6g=;
 b=VwQkqas6qaHI8iAw37sHxMWP+mtah3RR6+kPPYtbJHMaUEbUUWHcad3Lgp1IP+Wy3itsY2RVGlyc8533W/ut55nc4qmfPKN3MWSU9jMwK15l5iF/kzIKWufxNc1OAksxNoSo+uBLeSZz1MsrhGOwHJzx2Eisj4u05KoxiikY9MHM4uBiodIy9ULCtcw4PWJFuddbfQ8SBDtK17PBzeXrsfq4bbbqIzP8RGL/J98MCkrW5Aktp0JHKQt5Ph+3Aho/w8BSsnTuzk5+I95GPQq57mhASgjkjxBk0QwILSZtGHd8cXPZcYsluSJiOQTYBsJC0wfYm5pRMdM+vR5hTUJdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2hHC1TVJui4u7nekhT8z9emQ5zVcGOmPYJUn1nBz6g=;
 b=TYYA4Nke+JeT5U6sb5QEaEu2ojPiJ603MTyvBxSm8R+5g9khA88Yvr1hF8mS3NP+H93s1viWx5cQuJ6dativcH4AFaSWkhDPOGJwOi3Isu25ezx0HHL3EU4saojVdJUCyT9cKDbM7W6w6UEkSG9NNmJPAaZ8E2XvvbdYUlu88lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 21:23:23 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 21:23:22 +0000
Subject: Re: [PATCH v2] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Bowman Terry <terry.bowman@amd.com>, Hagan Billy <billy.hagan@amd.com>,
 Simon Guinot <simon.guinot@seagate.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240617231841.GA1232294@bhelgaas>
 <27be113e-3e33-b969-c1e3-c5e82d1b8b7f@amd.com>
Message-ID: <cf5f3b03-4c70-7a35-056e-5d94fc26f697@amd.com>
Date: Tue, 18 Jun 2024 14:23:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <27be113e-3e33-b969-c1e3-c5e82d1b8b7f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 7953d90f-e2f9-4934-af90-08dc8fdce1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUVnTnJTQTkzVzE2NGo1eWJFMHN5Rm02Rko5TnB1RGx1M09hRXRzY2JiT1Zm?=
 =?utf-8?B?djhIRmNRVU1FUUdvdjVrMTNFWUdhK3hjOFFtRTNGeTB1WE10cGpFSWFuMDNP?=
 =?utf-8?B?QjVPNjM2SWllWU5tWmJMUkdEcVpXWXBaQ1FzSTFPVjUrb0xwMFJ2QXJpNHg2?=
 =?utf-8?B?S0E2a3BwZDYrZ0lpcWYrMlhPVUxERFlIcTV3WDFWb2tvV2lNQWJNME02TGNl?=
 =?utf-8?B?VHU3VmRpZDRHMmtzRjl3QjJadkZmbm9JNlBXU2czZldCWmtaSzl6Q3JGSDBl?=
 =?utf-8?B?eUFKRi9lbHQ3UWUxcUl1bGVoeEdFd2JxazBBQXZ4cnh1Kzd5M00xdFMreU15?=
 =?utf-8?B?cGpZM3BPTmZINkY3TG5sK0dBNS9EdldVN1dpSW13NlhySmxxeEJlZTg5Qitq?=
 =?utf-8?B?djZxZGxnUDg4VlF0N2F6VC81dG8vSU00c25ZQ3dvYWwrR203b2JYelBDUm1k?=
 =?utf-8?B?eEI3VEdEbUJxb0JqcTE4cHNsYlFreDVUR0lsNUREODlYZE41eUs4c1ZaQzZv?=
 =?utf-8?B?dHpFMzA5ZENjZm9qRklacHZxaVY2OTMyMzRYZm1VMnpGdmxnb2ZQYW9LVEZq?=
 =?utf-8?B?VjhQdFNTWm5CRmF4YmJiKzRKekNBbDVRKytRaTJoTmZzVjh0WUtHaWZsbnQv?=
 =?utf-8?B?K0N1dEtkdzVZQ25ZZEVIbmZ0MU5uME9TNDBTZ054aTQwcmlrek1sbytTYkx6?=
 =?utf-8?B?UFdvS042dks2SEc5V0VSMXJscDNXWkZ3U0F2Q1krb2ZoemRCRG1QVlVaMm9u?=
 =?utf-8?B?NWlFZFNvZXkvMThxQUVaT0s0U2FMSWNpbVEybUllcGQvbTNHdDZIRnV5Sm5O?=
 =?utf-8?B?SGpHdys0YUdlbjNHWDB4cXBGNGoybjYvQU5wejgwRHFWVU1GeU1mekNVT3B0?=
 =?utf-8?B?Q1Zsd2drYkR6aTBMZENsMFZ0Ti81OUl6c1JtdjdpRWoyanFod3R4VTl5dEpL?=
 =?utf-8?B?RW41bXBYQVpTQ0ZhclQyU0JBK0NEMWZYQWh6Skw4SXRFUXMwUzFyL0VGOXph?=
 =?utf-8?B?SDBPeFNJY1ZYSHk0N0RtdEYrd1pzN2JjL3hVNHNNMXdTQXFNZ2xXWitzREJo?=
 =?utf-8?B?ODE3Yk1EYy96N1FuaUN2VUVsNGVSK3plR3I1cFFQd0hBaGliaUR0Zy92QXht?=
 =?utf-8?B?V1pRampTTXIzYThoOGRiT25JSGFxSkFrblFEcGpJbHhzWkdURHlXaEF4dGVi?=
 =?utf-8?B?U0N2WXYxM3lLV1RIeHNFSHVHK0ZLLytGb0Z5aEE3M0lkMUQvMGdETEcrS3pQ?=
 =?utf-8?B?MVMzNGpyR0R5MEd3Y1h1K0RQb1BKVURmRk0yMnBZZmRUQXE4SUhQTlBFTW5i?=
 =?utf-8?B?UzUwWVNxbUpNQkx1WVpncWFObzFyM05HTUpaallUM3h5UDZYQXdacW9yMGJT?=
 =?utf-8?B?Q0c5RHAvc1dJcVRWNFlEMG10QWl5eWorZS9EY05TTXlucnZXOXJEZGRzcXh1?=
 =?utf-8?B?bEhhSG1WYnc1aGJNYzd5dlBJUlRyVUNJY21IQ25kd1luMXJHdC95ZEFjS2g3?=
 =?utf-8?B?d3hxVXUwS0g3QUZabEgxZ2NieWFKSGNQdDJyaXZMdE5XNmNoc1ZOZjFTbXlj?=
 =?utf-8?B?a3B1Nyt2NnJXNzZGbFcvcVdqbVllV0FLa3I1Y0g2K3ZmVzVSRGMzY3dnT2Nx?=
 =?utf-8?B?eDg4U2ZkUFhKV0twU2Z5ZHN6Nkg0dzdXZDNxVURDWkhkRThWc0kreW80a0cw?=
 =?utf-8?B?YW1IZU1EdUQ1VjJ5SjMyYkNtRWdTWDNQUEx6OXpuMVlCcFBwYXk5NzUvRkhi?=
 =?utf-8?Q?uUvf97mVXufe0LmyxUWRztE3b550CmPZtZWAhTc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlVYMkRGNGdjc05RcnFOWllMRytWUVRzKzRHeVZXT0dxM1dqYnk5eEt2VTZl?=
 =?utf-8?B?TmlVd21ZTHROa2FDWU5wYnVwUStwZEpSNnMyY0JJOWgzYVJ2UzM2U1YrMTZC?=
 =?utf-8?B?Rm5qQmdHMGF4RVkwOHFaQURDd2czVjgwcmx2VVBncWJPUkJNcTBUdk4vQjhj?=
 =?utf-8?B?aEtWNVhVa3pvRmlVRTIwNW02MmxtcGV1ZjNCcjBUbW03dGtNOVl5cFlTKzUy?=
 =?utf-8?B?MCt4dzJzZFRCaS9BOUx6eG11MU5nazgzUXhNN2RlVUxJTVk3aUxZaGtKTENs?=
 =?utf-8?B?Yk9TM2xRSFkzSXpPclhHUXNLQ0dEOWdtV2tpRDVRcWVaMm5PZnRNQmZBRGNY?=
 =?utf-8?B?S3NOUkp0Z1dVbHpoWmY4Mk9Ea2s0bE8waEdmNXY3cy9DckJTQTRxR2ppWmFm?=
 =?utf-8?B?cFFPOThJUGJmNms5c1JMVUcxTWppUzhFdlB3dUV5eUpYWE9tbDVUTTVtR1Bj?=
 =?utf-8?B?N2QwWWk2WkhLSzRvWTAwRjl6c0UxWjRNSldQZmpDYTBIUytxUWphdXRDZ0R6?=
 =?utf-8?B?amV4cDN2K25NS0VwejRUTXBLZk15WGFUckZvTXdBL3M2ejA1N2Y5VzFWUkdU?=
 =?utf-8?B?TXZMY1owU3BCdkhoNTQ0U0NFdkQ0Uzh4aVJvT3VURCtMdy85cFl0OENhV2RM?=
 =?utf-8?B?WFRrNXM0MGlTM2tzaTk5akZ1SE9MR0JodmROOEZoWGpRRndwOWJ0RkY0RXZ2?=
 =?utf-8?B?dHNtR3RGOUFSOU0xTERKRG5menoyVzZaUkdWL0dheGZWbi9sWEcxRlYzSVF5?=
 =?utf-8?B?VXFPVzdaU013cGl3NUsrN3JsT3praVE3eWNtck4rTkt0RDJ6WEk5Y292ZGVL?=
 =?utf-8?B?dHpIUFdQRy8wRnFtbTNER2dheTVnNWdQR05vU0JwYi9tL0M3NHBXejVqRmNz?=
 =?utf-8?B?d2dyS3lkV2tHSERSTWJJUnBDOW9NdDRXR2JxM1I1bWlKOTdVcFV6TUoxUDdo?=
 =?utf-8?B?Q3VjQXFsMkpPQzAwYXBNYUhMeURKeWhjRnJGVWZNN2dKQnE4cXZmUlhTUU90?=
 =?utf-8?B?MWtONENDVDhYZzJQL2tGL21EN1BtYjgxdTFYL2xHU3dMQm0rVm5xeHRJZ295?=
 =?utf-8?B?MUNITzk0cjg3dHN0K0h5d2RZOWV0YkJlc3ZhWGp5OEhhcFFvQzllL1A4c2E1?=
 =?utf-8?B?WGp5cENsemZVbFlxeVBITk9HcURRYWJ1YXZndjl2RmxjaFZtU3ZRbE0zUk1R?=
 =?utf-8?B?WHpEa2E4dE9pUE16Zm1uSFBYanZwemdYTStUaGhxcXFNaEordVo0VDZrYU53?=
 =?utf-8?B?Z0xLczlub2pDM0ZOL055dHp4OHJCS3VtMjdpZDIxNWMwdzRHbGU4TzVFS3pQ?=
 =?utf-8?B?eHJYN1UwNFZkSWhSM0JLVEFBektBbGlvY2ZpRXJYU0xvL0lrbXlZRk0wL3Qr?=
 =?utf-8?B?U0dmaWxSOVoySlk0VXVtKzY5eis5KzFGZ1hGOFFDd3lDc1I1ZnVObUFOWjVj?=
 =?utf-8?B?amZ4YjVMSzlEQXBubmF2Mm5hK2c4aldQQ0xHb01aUDBBdzhJa3g5L0NyVHQ2?=
 =?utf-8?B?bHJXMTVJMHdzS1RaQVlNZ2dtVThFYmRWR1phaGRmcUNpU2FKczBPU09KQzZq?=
 =?utf-8?B?aDl1Zm9PRThIajV0aWUyaDVOaUZhS1dsNFJQbzJmckhWQVR1Z3orQVlIZXFw?=
 =?utf-8?B?eFFLMWhCR05aeVdDL3dsUkFMZWllWnVXV3lRNHhqNXVhSkV3OVMxandkL1Vj?=
 =?utf-8?B?LzVuQ1dISUhXTmJWVEY1WURHNHBmS3BTeFl4ajFGNXBCYnVoOHZvVXdsRGxv?=
 =?utf-8?B?NTduVW5IZTlKQURiRGxPNEhLcDV2SnJ2TVgraDdSVWFMcTAwWnhBeTdaYkFj?=
 =?utf-8?B?U1g2SEpPcUZVRy9Kc0Q3WFhEL2xvUGdwbXdVNysxbVVyTEd2YUNzVUZFaEVh?=
 =?utf-8?B?Rm5hc1JYY3orTGlDbFJqMXFvRlR3VWgxOXA2amNLbkpIZUFwQTI4RUR4QWth?=
 =?utf-8?B?V0NCMllyRVVLdDFGQ2RPK09HaTIzZW15K21DcS9VV1RJTUxHUkJVZlNMTkMw?=
 =?utf-8?B?eFBxWk5aL0hCMXQzUlRzL0J1cGgzeGJaUHl2RjE3VWl3ZWdPa2doUzdWZ3FZ?=
 =?utf-8?B?UkNlZ2dVMURqUThlSVZycmJwU0VHL3FGdldicG5PSlF0MzI0UkdleDM3M2U3?=
 =?utf-8?Q?25CG9I5VQ70+sAkj7XJZZQ0op?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7953d90f-e2f9-4934-af90-08dc8fdce1c8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:23:22.5027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3Y/T5RsZ4Ubhnhb/xertQUk9MyNZ/7SGnfXYLgANaL1cG228KwTPVs5gJ+cJZ7eQ0uxvcI98nGkTopg4EQp8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

On 6/18/2024 11:51 AM, Smita Koralahalli wrote:

[snip]

>>>> But IIUC LBMS is set by hardware but never cleared by hardware, so if
>>>> we remove a device and power off the slot, it doesn't seem like LBMS
>>>> could be telling us anything useful (what could we do in response to
>>>> LBMS when the slot is empty?), so it makes sense to me to clear it.
>>>>
>>>> It seems like pciehp_unconfigure_device() does sort of PCI core and
>>>> driver-related things and possibly could be something shared by all
>>>> hotplug drivers, while remove_board() does things more specific to the
>>>> hotplug model (pciehp, shpchp, etc).
>>>>
>>>>   From that perspective, clearing LBMS might fit better in
>>>> remove_board().  In that case, I wonder whether it should be done
>>>> after turning off slot power?  This patch clears is *before* turning
>>>> off the power, so I wonder if hardware could possibly set it again
>>>> before the poweroff?

While clearing LBMS in remove_board() here:

if (POWER_CTRL(ctrl)) {
	pciehp_power_off_slot(ctrl);
+	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
				   PCI_EXP_LNKSTA_LBMS);

	/*
	 * After turning power off, we must wait for at least 1 second
	 * before taking any action that relies on power having been
	 * removed from the slot/adapter.
	 */
	msleep(1000);

	/* Ignore link or presence changes caused by power off */
	atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
		   &ctrl->pending_events);
}

This can happen too right? I.e Just after the slot poweroff and before 
LBMS clearing the PDC/PDSC could be fired. Then 
pciehp_handle_presence_or_link_change() would hit case "OFF_STATE" and 
proceed with pciehp_enable_slot() ....pcie_failed_link_retrain() and 
ultimately link speed drops..

So, I added clearing just before turning off the slot.. Let me know if 
I'm thinking it right.

Thanks
Smita
>>>
>>> Yeah by talking to HW people I realized that HW could interfere possibly
>>> anytime to set LBMS when the slot power is on. Will change it to 
>>> include in
>>> remove_board().
>>>

[snip]

