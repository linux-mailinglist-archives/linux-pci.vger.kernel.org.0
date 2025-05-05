Return-Path: <linux-pci+bounces-27144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A3AA8FA1
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DB77A8F6D
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427961F8F04;
	Mon,  5 May 2025 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BpW1k3ES";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fWpAvnqF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D98C22087
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437491; cv=fail; b=H8Ym6S/YHnPEWIz8b1ZyVTxgzHMee/taA44UV+osCi4x746pNGjnKMN+4aRB/R7V+axcGO2POFyEfcUzNc1Sp6ep409Thg8HgzmAl8NSkXx2eDWzoxPxsXmlLpbyY4I7hQia8IrcUfPjqxubiEPFbw7UkJdDvrd7WirceqyB8YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437491; c=relaxed/simple;
	bh=Zb4B7CXTof+Vg0avUgPP73doPqHQrLzTZnwUMVo3fOY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZeIdGTEk5Li6QdQi150gJO8TROWpt6aHeiS2TEqzOZHShJmTQJ3GWQuUlPbYZFpeROHB7ixS8j/gZF2oWMtY/BWfCVbkdI08GTqU97t1TWnskKi3YoAGo9EnQ6FxCB+W0htnG3TIbKSBXYGwNQgFI2gON7rzw+XuLCRftvNygug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BpW1k3ES; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fWpAvnqF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5458i0oo021228;
	Mon, 5 May 2025 09:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ON+jeyr7DCZ30xs/gZIrUWxCGscGavEvogohKVq7iPg=; b=
	BpW1k3ESlLUo4bm7gruJ79v7n06yy8SI6L7di/Tu1p3URLqkGJr9DgnvuZ7auQ1n
	nShbZzNnbwm/u09ZqERvp+yfLEvNrdyVL2XgSfkFO1ajDPHEteXHeMSEw+N5u2D2
	6KT2r8X0GtOpZQLWprDTGub4FB3m1AfyhvgXMQOm27FAnU0yw0IibyA8FRv0OJqX
	TR5T7F7lnzYLeUPzEhEOlh5Zf4l/rjbzq+gaO5q8Raqfax2xrqiee5q9s1c1u+iy
	jO/rITykT7TIEzGWNSP/QwZSsr6ZOEFmswMld54gR1cA4uWiHbkGshur4j/uEDkx
	GCI7AKMM4hcchPBe8WzIgw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46esrmg3n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 09:31:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54590CeF035454;
	Mon, 5 May 2025 09:31:07 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7fst2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 09:31:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAMAsE3S1kJTb12R1IguehOe/3N/SEKMyl6dGoXw5nGuKz7PD0uibdU9bBVUyA21zDqrcmSVU5EdwcpW1wNFE3AwGisMJq3UdsDplAWKMofFAARk2e7A6EPAupPmMFURl70AJ/q35GAPxF5om7lxbNrI3l/WMLyzJcnZuXXNY3+SAmNrC34BCkp3MHjc3mtNkFDJ3FesTjwLMtPyg7K035LMTZ0brp2gv4kvgg2wL77PYhh4s8TzGJUwGfCBcM9DIKJx/jaRZla4VkRcJw5cOTCK2TeWVCK9Jp3YuyVqBBT50bj7gRRHGGMM87YmvGW57K+qRMpXUnK2dkWXqPxjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON+jeyr7DCZ30xs/gZIrUWxCGscGavEvogohKVq7iPg=;
 b=Nc7ytzl6JCNyvB8IvC4yPfJ/WYhuYCFmKLXU54p/rOD2/CypMBCzeO8So1wMaPb1SY6YprFC6/tp42/bfUQlYlsggfa/lPA8jyEN1j1ABfHuqIvXc5EDFAr8cFhWnfsZymjtvV6U9N1v1CCdkehXVEEqHm2CS6DWhkRFb/NBXLuy4n7fw1Ud/ym4OAHxG3WNrP4KkTMo/ZNEIZ1kLcz+/YjDSkWq8rkmncNX1ijVDI0bYEX3ZUjwrZuoJ0uysJ5seIVz8KJ9zaK83b8rnUl913c1TTUmqm6WkqxGNJgOtM6JnH+gvyY7LPwrvHgYaoIQfDJKyDP6uSdIZsyTvlsPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON+jeyr7DCZ30xs/gZIrUWxCGscGavEvogohKVq7iPg=;
 b=fWpAvnqFACluoBOTEsAaNVrAaSIwH1VWhd8OiQoLAXfHOEzBB6oHOaA8mawDHRomQpmPMvR7Sn0UXUd0GoCWNHzdcxYKQ/vuz9PuNES5EnraD3dLbpQ9YFXW0nJe6tNu1I+WvAvGpgBzf8AHOd/a84DsZA6RkhnfEmxf3r3XUVg=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by SA6PR10MB8039.namprd10.prod.outlook.com (2603:10b6:806:446::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 09:31:03 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 09:31:03 +0000
Message-ID: <af0c7147-325a-43b8-907e-f21b4fb78bee@oracle.com>
Date: Mon, 5 May 2025 11:30:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] PCI/AER: Check log level once and propagate down
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jon Pan-Doh <pandoh@google.com>,
        Martin Petersen
 <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sargun Dhillon <sargun@meta.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20250501214331.GA782778@bhelgaas>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250501214331.GA782778@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0292.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::18) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|SA6PR10MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0fc48d-1de8-41d9-cb41-08dd8bb78e18
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SExZd0IzUDlrbVVHdjAzWFBVNWpRSXBRMU02UWgrTEF2ekxtUTNJNzlkRnZw?=
 =?utf-8?B?V2FhcVkvSi9mV3czSFlXczYyMGVZL1RpSmc3NWg0OG1VekJNWGQ2aW9wWmdz?=
 =?utf-8?B?SnNZR2FnYUkranJiMEVyd1VQMmJKTHdxNWNzSEJDZWd5YmdFd2lIT0JScE52?=
 =?utf-8?B?NzE5S0d2NGFCTi84SDQ3UG1kZGFmaWlLZzIwQzFrREp1ZWRhS3pKaEhwcTRw?=
 =?utf-8?B?cGs1TW85UUlBNzVkZTFBVm5mT3ZXK3dPVkc3RUFseDBFdExZTFpqMVJ3ZE04?=
 =?utf-8?B?YUZsVW5PL0JCZExweXNyTm0veG50MG5nZmZWUFV2VmxQOExuUmJKeFhmekNM?=
 =?utf-8?B?OXdZa3UyZ1lTVlppWGF5TlhiM0VvN2JvYlFxWGFSMFd2N21XL3JrbTAyMVY4?=
 =?utf-8?B?cFZCcXVWUFAyMURmU2h2R2dPWDcwZnZJNjI3ZThLY3VmRU5nWDRYTFpEOFJy?=
 =?utf-8?B?Y0pFUFI1VDZqWUZTUDI0ajRsK1RZOVhlUzdKVTNZZ3pVcGF0b3BiU1dTdUlv?=
 =?utf-8?B?bUdaYngyQTMyUGFkMFhWUDE1SC9Fc1NsU0F2OE04ME0zV1RHd0xFQ2p2WjJh?=
 =?utf-8?B?a2xodFZhZFNtMjVpVi9EcE1DaGxENTRpZEw3UUpKQ2xnbDlLRmRhY3JzZDE4?=
 =?utf-8?B?YUswWm5oN1V6RlBZeDQwbmp3WnVLSXUwWVZXS2ErSG56SGEvbUN1Mzk4eGFT?=
 =?utf-8?B?KzM5K3JDTTM2SG43c2lWUG9jSTJsVUd6SHJacys4WFl5Nks2bzFqcGxDTnhM?=
 =?utf-8?B?U2d2Yjljc0NUa1BZWGtTeVBoeXUzdDNyeVdEVHBEM0QxeWFjNlpnQ2tuVDJu?=
 =?utf-8?B?WDdUMmVFcVZVR214dGlhQjBvM0prVE1qQlJib0JENFhPYzV5aDlwOWI1ZmhG?=
 =?utf-8?B?QlJtbjlURnFFaDM5VXdQUUZIRU0zcUpXcGZrSStYZnFOdDFMcDhrMjNvdzdQ?=
 =?utf-8?B?ZmNJVTJKbEdudmdseW9qYUdtd1M2LzRnbC91TjZOQTMvaHFveU5tZHF2SlJ1?=
 =?utf-8?B?SW42dzFWbU9QNmZwWWlabE80cVd2SzV6U1ZZeEREL0tPZnM1cVVkWGhPNzQ5?=
 =?utf-8?B?MkV5QzUwbzF3ajFJRXZOSkxEYkljT3ROTTNJN1p1SmVXYncyVC9TUkNDRUdN?=
 =?utf-8?B?RW1DNHZOekJYUHJqa2ZycG5Cc3Yyc1piemxydGk2RDJXek95SkZ5Y05DZXZ4?=
 =?utf-8?B?Q2hYcUc0cTQ0cVhuMzZJcStJMVZJa2Vsa3RPdkVBbGFUVUtUK1cvN0JzYkE4?=
 =?utf-8?B?ZEl3aFNRRVZxTTB1S0UxU09yYUY2RDZXKzJTTHpEd2hrOW5ldlhzM0JyZUwr?=
 =?utf-8?B?TlJ1MlQ2M0VmWkVWZlIxSWMrblRLdFh6QlUrTVlMcUJMNXBYRXc4cDZpRnY4?=
 =?utf-8?B?QXV6Zm9ZMW93V0xtUW5VU1duaDFNdmdZSzBHWVFsTnBzZHBITjd6dGxBSjV0?=
 =?utf-8?B?NEFZSDkzQlNjeUZhQUh6VHJKVGwyRi9ZQkhxOStlMjZzQ0IyZ1UzNlNwSnpx?=
 =?utf-8?B?SWtZNnlDV1QxeU5PTTMvdTgxNTV2THZhMGFKcTFpSmwwL3BpT3VVbXZERGZu?=
 =?utf-8?B?cDZUckE5WnlEdlNYazlieFozVFNBaWFJdGVXeTFDUm84YXQyelFBR25vZlAw?=
 =?utf-8?B?NlVuYTFOSzNIY2hDcUNSSVdEWXErNS9POUREdE96VFgwcGFLaVVGNXIvWHJ4?=
 =?utf-8?B?cDlrZll5Vkhya3FXcWNrK2FFWEJtS3lrZVZ1REkrNWN4ZWI0L1J0TUNsUndq?=
 =?utf-8?B?RWNVMEhwM0gwdWdTRjI2SzU5L1QvcEJ3eFYxVnhoY0xoMzhtSUZHcVQzVjQw?=
 =?utf-8?B?R2wybm1vdUJ3V055UWVQSmJKaUZ5ZXhOVHdwMmQ2M0FyUVpmOXFVeHpmZTJ1?=
 =?utf-8?Q?/ZCdSFnYPcMUT?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?V0dLODJXeG5YYVVTWjdCZnZZNWs0UkhGK1dWNjg2VkhMcDV5d0o2ZlE2dUs3?=
 =?utf-8?B?VkRXWGRJZDBvdWluY0R4TGlEVUwzM2Q3ZytkdFZCdmk1cmVXeGpLcTBTaWNa?=
 =?utf-8?B?UG9hNGRZWVdTRXJYOXFKK2hQQmdWd3RJWkRmK2lJMHd4UmZ4Ty9qRzI1TTc5?=
 =?utf-8?B?TXBTNHZIbkVveFhNZUtHelR5Y1VlUmU2bmR6SkZzd1p1Qm5Ma2FQYlJpQTVX?=
 =?utf-8?B?WVNTK1pLVk9FUWxJRkRDbVFENmR6VHN6Nkdka2ZoK1p5SlhtVFNTaERlKzYx?=
 =?utf-8?B?ZmViRXc3NVVvS3YrMVpwbENKbVl2QVR1SHhuRjRGcnZQWGNIdTc5UVZlS1Rv?=
 =?utf-8?B?WEp2ZjArbjRUOHlXOEtidVBPR1pvTjdJdEZON1NZVU9XMmpETFNjWTRKOFMr?=
 =?utf-8?B?cm1SRU54OUkrVVVLY0k2b2RSTCttcndFMHY1MkNrM2RkMEFsR3dKRGRncjVY?=
 =?utf-8?B?a2NXRC9iUTBubzBNaklaK0xQbzB1Yk9RUHlEMXJwdllYS1c2VmlYYzB0L0FC?=
 =?utf-8?B?Z2tzY1VyZEJpT1lEdXVJbzA4em1OQ08zdFlkZjlsZ2crUENJWE1vdkhBdFM1?=
 =?utf-8?B?R3ArZ2E0M3FmVlQxZUQwUmVDOWtIenN4RDVHVjNUQVZQVjJMZ2E3dS80SjZO?=
 =?utf-8?B?OGFsMmFwVlFsOGZsaVBtQzVHbGNtVHd4UDgvSTNmaFBhWUxFMDUwZlNBM1Vr?=
 =?utf-8?B?T2YxNGlzcXNHeWlLYVgvRHVIZVA5aW96VVpDRUFTQjNVRW5mNGNqV1hXREVN?=
 =?utf-8?B?Q09yeTFNeXJsNjRib1JoUlI4LzB0VjNWamVXUGlYVUZXcjRIbVl6NUZTRnR6?=
 =?utf-8?B?d29IaTRoSzBqUzhEb01xaGpUck9kQjlEejNOV2JyZGRtZzhZNnFmTk5VRVFx?=
 =?utf-8?B?V0oyWGgxa2pqRFVGVEtXZnNFT1gxK2d1cllNNkVYRG8yOTgxM2FTQ1BaWllx?=
 =?utf-8?B?RmFqU1J1Vy8yRThrOFRWdG1xT2FDSEE1T2d6TmliRU9ZUC85a2ZRckpCY3Rt?=
 =?utf-8?B?MW1Ubk1wdG1aNGg5SzdnTzdBeE5SOWd5RU1Od1ZvcnN5NWJvUjBlTmFQTVNT?=
 =?utf-8?B?RzA3SENad3BJdXRFZnZVOTNKcmNoL2RQODlHVE9oTWdyWGFJQXBHTmVqU3FI?=
 =?utf-8?B?WnpqZWt1OTlWcVhETlBHaHgrMmhncEFZZDRRZmJXWTVKY2c5WERDSGt2Titr?=
 =?utf-8?B?T3g5cndjRWpmWDBYdmNWenh2MWFBeVRvOWl1WEtkakFTaGNucXBXY2RCa2Nh?=
 =?utf-8?B?eFZsVzVRUUMrUDFKSk1UcjBqMmtmdFhmNGdLYmNXY2hzRnN3NWsvSmM4ZXJH?=
 =?utf-8?B?TkF1RW5ISTZUR2lCdldKS3RwMUV1YnI5emxUV3E0L1NnSnJaUndrUlliT1JV?=
 =?utf-8?B?b1hGSFF1Ujc3aDlMNEx4N2pqcTZtRldISm9iZE5WNUNnMmhPaDZDSTFXcnBV?=
 =?utf-8?B?NEIzWmM5b2RKU3NYYnN0THVDSEhrV21WNGpFNStuOTB1Sjh5NlRxWHVZY0hR?=
 =?utf-8?B?OFo0K1JxSU0yQkUyTFcrWjhCOFVrSzYyR21nckVKc2lKbjlwaktubGJrMEtq?=
 =?utf-8?B?YjR6THBkcU9oekg0RDd4azdFQkM4L1ZGb3NsZElUbi9UdmtHenFkeGhkR0hR?=
 =?utf-8?B?RGwrVmJnRHZML294aGF0RCtMNmZGME9XYlY2enFLYnZvbHVITktsTTZjdjVS?=
 =?utf-8?B?TnhBcXcwLzg3L2p3bTc4U1Y5WTVMYk1vTGxTWnhwb0hhWVFpRTYvd3B2Z2xh?=
 =?utf-8?B?bktqdzZiRkhhcUtGY1I3ZTZoSkp0YzU2NUY5UjM4VlkxL0RtU240UFA2Sklz?=
 =?utf-8?B?N25SaW5FUVVOcFZBRGlNRUhNMEdQZFZuaUY3eDVPRzJBcnBuUERpaXhIa21X?=
 =?utf-8?B?dE5kMDBJcDBpOXdaRGo5MnMvYUZWQ3AwV0R6Tng0YndkUUlLR0d1ZDlQYU5y?=
 =?utf-8?B?QWxDQ2h2MDhGUXhKNXF4SmNHK1BHVVpNbE1ZUDVZNTBPckpVWmR2N1loUnQ2?=
 =?utf-8?B?VFliV25vYWlTT0IrNjViZ0IrdkJWaGZ6NTZ0TXBEYUVCb0REM2FTR2Y3MG1s?=
 =?utf-8?B?SXVQeUtHSDdXT3E5TW1vOThZMlpHSXpZQzcrc29pd0IyL2JQTms0UG9yNnJL?=
 =?utf-8?B?TVpveGF3N0hZVWpFODNKSUZrcU40WjY2NmFZMkg1QkpXU0tIRE1GSVI3amgv?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZHKb//orsJcGTrCc6rmK7BmHezzcEoHyhm23JNa+QCFR1bOi5B4nqGLcQ/DDN6J9WZ437dGbxjhc5mMu5Phi/EQWjHtNKgPSixxJeP18PJSS5WkYO5bVEXpFASvo79xv/+nr5sEq820XLhY8qm0GAARfusBqMDYTCoGEFQq9q2tYkgpWhzMUqvnuP3RBMjhOw2o7IUo4sfC4A23ZxocXUL9AJJSEoegmQiEu2bKjQRw6xbISIhdsrpdM8rlrIuwChkPkTGBAUZp0tFUVx15FJJ/G8/B20Lssr/+iOESPYWb3XFg1CL47LrHFjdM2xOuSWbp2yadUVsmKUKdjpWPuO1bSliLHwv3ePdfjbFA+rNH/NhWougZr0023ivy38W/AnqRaGdkjXUYVyVSyQMUOz9FFAf8nch/IJi/j4bFhT+0cjZiDfxznY95JRKcooUF4FdDbwfKrkxVxg63S0nNK/Ic7vQqv/60UGdh36/k+PI8fOrSvCeVDMSBXnGkZ/TY6RDWurX8wS6NtKixfkMEIG3nZ+Fa144bDINZGp8r+lMC5251zzdW/EJI2rrER2vVZDIA4/JVAm82iIanAgcI7wyTxh9lY1jQXMMKRUgaQjZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0fc48d-1de8-41d9-cb41-08dd8bb78e18
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 09:31:03.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSPd7xgi0vry+TGclU0+eeAkNA2g5TPt4To14xcr5Apad9DUGcztzuAsUSH7qjsrdTf1YXguhTCq2HhXY6vKTZSeVlNCmrhMXGcxz3zd0Gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505050089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA4OSBTYWx0ZWRfX9pxBYYU0N+wH 09cSG2PEE5b42U7EZejHqSYiUu8mMQlPcgMl6ss3XZeuSUm+3JhiImdXC5iSsw0j7dOIQOkVv7L Izmqd09qfZ/jjByYxucmdXH8TFWGcmF8l2y9et4tbeAhwc710CxarBZJwGk/lpy5lJ7zYjv9sNg
 iQBEME8CH94AvVnHumETX06ds9fH2bcTUALq6N3CRJT6hWWhQ9g6Rb3OMa4wwwkA4sjK11RDS9W Nlzt1t2pHW+eKXUk1+iyP3+z5mN7KnVqgwVtUxOCbShIKhQWkpFvkRftkKssMlRTVY4k7es4/uc q5j2Edn5adTmKYKYk5gtHMEDUGkULdgIG7fT14nlhWalrZCv+oHMv0FUdos2kx7idhRsb2Tffjv
 l8XstOEzTjcrlUYDEHebtL8v/GRKhZCz4HbXoQ2R6LDAiE23lraqiTIMOcFPM9RpaEB3xmuc
X-Proofpoint-GUID: zd7sZkMhlUkOlsqI1vxqy5-YtAi_zMTh
X-Proofpoint-ORIG-GUID: zd7sZkMhlUkOlsqI1vxqy5-YtAi_zMTh
X-Authority-Analysis: v=2.4 cv=ftbcZE4f c=1 sm=1 tr=0 ts=6818855c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=XCEu6ZRhe_bOsSr_YFoA:9 a=QEXdDO2ut3YA:10

On 01/05/2025 23:43, Bjorn Helgaas wrote:
> 
> I'm (finally) getting back to this series because it really needs to
> make v6.16.
> 
> It would definitely be nice to determine the log level once instead of
> several times, but I'm not sure I like passing "level" through the
> whole chain because it seems like a lot of change to get that benefit:
> 
>    - it changes the prototype for __aer_print_error(),
>      aer_print_error(), and aer_process_err_devices()
> 
>    - it removes the info->severity test from aer_print_error(), but
>      leaves it in __aer_print_error() and pci_print_aer(), which need
>      it for other reasons
> 
> All these functions take a pointer to a struct aer_err_info, and if we
> want to compute the log level once, maybe we could stash the result in
> struct aer_err_info, similar to what we did with ratelimited[] here:
> https://lore.kernel.org/all/20250321015806.954866-7-pandoh@google.com/

I think that would be a good compromise between these two approaches.

> I'm rebasing this series to v6.15-rc1 and will post a v6 proposal
> soon.

Do you plan to include changes suggested in the thread or just rebase 
the series?

Also, it's still unclear to me how to approach the sysfs patch, both in 
the context of the ratelimit refactor (which, some of it, is in the next 
tree)[1] and the value that should be exposed in the attribute. We have 
control only over the burst but not the interval. When we deal with high 
rates of errors, we may want to increase the time window to see if the 
flood is out of ordinary or is it constant.

All the best,
Karolina
-------------------------------------------------
[1] - 
https://lore.kernel.org/all/b0883f20-c337-40bb-b564-c535a162bf54@paulmck-laptop/


