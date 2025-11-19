Return-Path: <linux-pci+bounces-41688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08086C71374
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3A96A2A35B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05452C031B;
	Wed, 19 Nov 2025 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fLK/xgNU"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022652522B6;
	Wed, 19 Nov 2025 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763589774; cv=fail; b=mpUO5H+OVzcjM5XtGcOF85TwNozE1zYQrirQJnBWty0kdL9f4kFDDMHWI3qb2ofh58aHUlVJC9xWNZLxEscf4SD0rskBwewtNCoEGPByJ9LvmIk8FUaR1Q2SnToc8+3cEFSJZsJYtuhOiOhwGCfY4zPxSeoX2Ko5mObS4w4IhJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763589774; c=relaxed/simple;
	bh=CcllRrdp7X8mxILGul2+BgowpvEnF8D4MwtskxtoSEY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rp3X9JGPFZquFJ63oYri2eznfRxdihUNEjJDB2RE+M5C/OErnyx99gVE/Bc6aUuKr20U3iLFqA8EQTI7BWx+VZmGToTs74gNaBdKNZ6PDyxUqZY+xBPurjRnDAjJ9UVMs5yF8hCQ9caHdjuDzKM/+aHQpIuGAggTjc6FfFBj6D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fLK/xgNU; arc=fail smtp.client-ip=52.101.43.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SItG2ofxYpBH6oV7bh1M8lN8MTvbRjH6JOG7jm+E/2tz55E75n7EpbUDIL3JnsHr1LAKc4uqqa7wx1bY5KH++4TpeWUd44NEg7SNjI8xl5uFjLXm8Aiawgp7Q4Z5wVzdqfzlA4nrwFHCmsBbEglqZ58LlcFtZQjsemUGKmZLsuTCtqv2iru2VBACSOdvSoO5LhqFhwlsW8Jb9JsZA4a40DR8EWVALCW5eq0HAtTfcOXD9yyBoALHKpMjHc2/6FPClrmAlV+QtGTzMdNpmXBSNsQ8qDfemMdUATHrF5AWT4H07kIq90nGJMBGcKxs/DhWuDraapWWbwjb4v5JSuDTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcllRrdp7X8mxILGul2+BgowpvEnF8D4MwtskxtoSEY=;
 b=wRhaPKpliRjj3oF86UqFLqgVPqK3l82qQLp1bSUonQ6FkWOb7NxVySUjXe0daQpv35rnvTl39qqMz8MZ+84DEgZ/xK4hUxoCvp6V3kYcWY9SbFBGtVLDHKT2rKxp+ZDkp1N6/WKIVTpAp+ChIyZ63fTGcVVogZKB0vTt1bvVeRCYUyh2Bry9XTnCHxyqOn5Ne5vd7BlFdPT6XfbiY8a6WSCXVJqb99v5azHB0NoixdPPJpqooVGVKowA/9732oE76HdgKk3DGe6ip2Z0T1mNe5afzDguveU0+ry2O1FuFVyA2w0LJUwrb4N5+PrswnNRJONQY00poOA2A8ZC1Fsjhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcllRrdp7X8mxILGul2+BgowpvEnF8D4MwtskxtoSEY=;
 b=fLK/xgNUqdEXzyNg1BG1UntwtJe79mjHRTwG+sShAy62AFmlsjfXgrtoSPLbhV0dyNGpy2tZxf/BvKEXcyMA1GTaac58i1qSvXddBm9KuTIMY0nAaQPy5B6sHWDQbKVoO+9a+uBONnNPuRlEBUcrQJUqg6nVzVz4daq3LPAxJiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 22:02:43 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 22:02:43 +0000
Message-ID: <b104b695-a966-43e1-b4fa-1c8cce6d65e7@amd.com>
Date: Wed, 19 Nov 2025 16:02:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 12/25] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-13-terry.bowman@amd.com>
 <691e3542c1b2a_1a37510046@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <691e3542c1b2a_1a37510046@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:806:22::27) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: a8826d05-2f72-44d4-d2f1-08de27b75d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1lsTmRoMTNROFAxOEtvOE13YTlEc2xQMHQwZnNvNytPWjNBeVlVd04xWEc4?=
 =?utf-8?B?MnF1dDdHSWlXWGNsMi9GbnlpQURtaHk3VC9FUmNqVHJqbG95REZUT0taNS94?=
 =?utf-8?B?N2tHUzJpRXFJTzIvQStjaWlrZ2ZKYlB2MlVRSGhsRHNuNU5TUEU2VFVIajhV?=
 =?utf-8?B?RkxYbTE2ZEoraThqdDE1ZzFmZC9CSStxOWN2aEJZbE1Ta2JFMUtyRzRsK3lU?=
 =?utf-8?B?OFBQL01LUERBNzhSdnNPTGgrMTg2RGdZQ2NhQmpvc3BoWlF1VGhoYlJ0UnJl?=
 =?utf-8?B?bC9yTkJlVEJIU2lFMkpGL3V5Z3dBbzB2MXV1N3c1ekxjdng0MkdWZ1cxQnFM?=
 =?utf-8?B?eFBaYUpKNm50cVJyL0p1WlpiZ3o1TWlLUjBpK2ttL2hBQkhsY3R5Z3hGRjE4?=
 =?utf-8?B?K2g1THFqQnRDUFZXekRPcUZEb3ZwZlJiRnNGeFM2dGFuNUtZS0t2RVYvb3hH?=
 =?utf-8?B?Z0FGR09TSnUweEN2eVFYdlRCTlcrQUVSb3JPdWZiU2dyZDRBWWVmSndOK29U?=
 =?utf-8?B?WlZGaGdFcUFhT2FxSGN0MzBIQm1uWVpEWEthNFNwYmZTODE4Vjhua3VXSUZH?=
 =?utf-8?B?cWJkd0JERXhlWENkZmpVZ1JmSXhaY29mWldnZnoxUGdmbGtRa09CVGVwOUg3?=
 =?utf-8?B?ZTA2dXlJcFdOaDRPbWF4akNCRnRMM0hSRWNSRUNpdEozWnR5dUdraHorVVVm?=
 =?utf-8?B?WEFZdHBkbkxuczQ3MW1BaDhwSWRjRVlHaUw4ekwyUldnb3d0aFo3NEh6V2lW?=
 =?utf-8?B?ckF4aDd5SVlJUWZsUjNvSElLMkVRWjBFaWdMakRpa0l6d212VjkzbVlBRmRK?=
 =?utf-8?B?T3VCRjR6N25oODczb0FVSWE3STdkL2FJclRiOG9lMjRGeTJQQ1RFOE5DL0tS?=
 =?utf-8?B?RFdxeUJGNWREQVlCcmFzdEUxaDgyamdTMk5QWFBhNElVTmUrRGx6eDNrRENK?=
 =?utf-8?B?MXlTR0loYWtjdkhDYmdSOHc2TmJUMDVqazNSaG1TS1A4RFBKM0FBYmxRTyth?=
 =?utf-8?B?Q25IUnhGZzNzZVN0azJWbmg1MXZzdHdrQ1pyK1Fodm5YUjI5TWFBOGRQbTVo?=
 =?utf-8?B?VklIblc5eU9ia01HS1RWVEc4QVlFU1laMUMyQkhXaTk0dkttSG5HSWhOQXB1?=
 =?utf-8?B?cTMyLzVSbUMyRVdSV2hnVFd6Z2dISko1ZC91TkJPZ053WDRQLzJTWnQvN3Qv?=
 =?utf-8?B?cm5nZm5sNVdFZ2RRL0tSbGN0TEhUbkpSZXpac1ZiWjhpQTc2WGFabFpudUZw?=
 =?utf-8?B?RjNTdHZ2U2VNanFBRmNKZ1NRRkFJbzVib1lCYkRCaW5ra25mVjd0UG9jUkFI?=
 =?utf-8?B?Y21oSlRZSXFwdEpQc2ZQNHV6UW5jUzZWOXdVem1QbUdzNktjZFk3b0d1Ym05?=
 =?utf-8?B?dzB4RDBIS0lZL3pSdHhsNWhCVE4yUnRIU2oyVzRkUzMxYWhkZDF2TEc4bTF4?=
 =?utf-8?B?Q3ZjN0I4MWtHQ2tvYzlHV1FCUGlXbzIyTWh3Rk4vcG50Zks1Rk1CNXhMUlRv?=
 =?utf-8?B?cGZrbktId0N0RC9lZ1FBRVFiS3hKQm1GK2Q1ZUROQjMzVWxLZGUwZDlWdTZp?=
 =?utf-8?B?UDhTZFlPUkt1SitrZndKZWMwTG05K0JWUFZra2gxZC9YeERFdkt4Uy85NTBM?=
 =?utf-8?B?NHI4ck5OSnZIYi81RUJqUE1wdDNtQi9Ja0JIZWowNTQzNlU4NGFsc1B0ZlIw?=
 =?utf-8?B?L1MwaEdSMWxFYWs4QjBCUU9BY25yVndiTnZBSFR3YnBBQ0lKNXdxZ21aZzM2?=
 =?utf-8?B?WkJicTgwNlN3Y2hNYTJqOGR5cXNhSTJnTnFqdStPRXpqcWhYRFU5NjdzVjA4?=
 =?utf-8?B?SGI5N0ozbEJjUDJrZmszd3BNNVdpVTRHRk1oTVJZQ29uSU1SaHlOTVlMYVRT?=
 =?utf-8?B?NFh6R3Z2bXBRRFMvRFQyaG4vbEFtQmR4ZUNYZnBXM2x6ZnZCMGM1aUdVelBK?=
 =?utf-8?Q?6794zw74d6dn66Zb3qzN2s/LBYIaz4dg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?citMRXEvRUc2MWVyaHB6TDVWUnYrV0hCSTFsbjBhVHlBdTBqak5mTXo0dm9x?=
 =?utf-8?B?MTlYRlNaK3QwR0dzVVg0b041V0hYRmVQRVRrSTgzVFV0dHBnNjZPWDdLUGc4?=
 =?utf-8?B?SUVDcVhFN3I5eGtFeUtFMkZLdXEzOTZWMHBxQ3gwSTY1bk1qaEhRVFdIZE5M?=
 =?utf-8?B?RlIrcDBaaVp5N3Y3QzFrTUdkQ2FIYjdyc2l0SkJXUi9LeEt1N01TT0owMXJU?=
 =?utf-8?B?UUhscUVVY0VmOU10TFRYRCsraUtsMGR2K3BSL0lTb3FvZXljSGtOQmxLdHN0?=
 =?utf-8?B?a3Z4d0FqdXNLV095THJSM3Rqck5UK0JzM0xEUFRGc3paSkpDMmM2Q05kd1lL?=
 =?utf-8?B?TldoN1hiSENkbkZBNWJFYit2VWM2SXdJZHZraEpFUW9pT0d6Z3JjejB4d2JF?=
 =?utf-8?B?ejR6RkJLT1lXZ0hxTmsxMXd4cDQxajRUTkd5M3hubFM1Q01mMkRjZ0ZHZ040?=
 =?utf-8?B?SVMwM3ROLzBoSmhwS21lam1pSnF3OUFMblVmMy9jWUh5WnB2K2hPUTB3b2VO?=
 =?utf-8?B?a2JDOHpzV3BQN3pNazVrWHBieThaYUxHMC9FME95V21kNkd5QVluSWNoSGpK?=
 =?utf-8?B?YlpzZzlhOE5EMUFBOVNTMWk3QjNMU3p3ck5nV1JsdXY5enZIbGZYd0d5RzNK?=
 =?utf-8?B?WnhpejJyRmh1OUtlREVmdS8xb08yVC9Gb0gzZGZYWU94aGl6c01EdFZHS09V?=
 =?utf-8?B?ZmJ4VlN4Rno2MHluMkc3eGxRTDlpYWh2em9ZeHNIQ2J5VlhtNWhLU2NOOFpW?=
 =?utf-8?B?SmpydGMzWllEbUlRY2Q2VWhYRm9CcjVhV2Zmd2lTRkFDZ1VrT0tKbCtqLzBM?=
 =?utf-8?B?ejd4eittZzAreVBjdkozWTNjL0ZqcWtkb09SSFJsd1Y0NzFQVFRJRThoRERs?=
 =?utf-8?B?UGoraVlmWHp4TGN1TkdGQkkwcGFabm4yWGUrRGg1dCtZL0o4T1g0QnpPK1E5?=
 =?utf-8?B?T0d2aC8vSXdqZytWdmJXN1V4Z2xmc0NKZUlnbkFGRVh2akMycVBKeG03aVR1?=
 =?utf-8?B?K2FIRDkveXljZVF2enUrNms4R05reGxGbzQ2ekhrVFhZTTd0Ykp2NEFURGdj?=
 =?utf-8?B?MDhvMGRRWWlJRzR0TjRlMG1qNURib0NGakpGU0dmRUJQZ0Vzcy9GQU9GbWdh?=
 =?utf-8?B?VWROOW9qdE1SQTdBSktxWXRvVG9BNVR6MHZBRjVwVEZydmZyVk5GL2R5aWIy?=
 =?utf-8?B?QmR0SDVUTTBSaGtOdVpiZ2ZwVlV1aHNuL3FNV3lWTEpSVWN0NHcvVUgrMWJF?=
 =?utf-8?B?ZDBzQXZFeUhOU1J1SWkxd0YrRXAyNDFiTVN3bWZHTG9nSi9LbDE5d3QwUXl4?=
 =?utf-8?B?cVBuSzV1dm1kUWhCYWxyZ0NiMXExdzVzWDAzQTA2VDdTZVVneENyMDFOL2ph?=
 =?utf-8?B?R01Vbno1d0JLTys4RXNaK3lSNW1NZTlFSUYwZEhkNHdjcGRGQ2dkUWZVSFNL?=
 =?utf-8?B?Sy9RcVp3UHBPNTFKYTMrUWR6QUJ3T3VjR3FjNmRpM0kxc1VnTWd0VVRhMkp4?=
 =?utf-8?B?dnNlbzBNdzU1aDhobnhkTE5tVGNPdkdINndORjR4eHd5SmZ6N3JCZkcwMGR0?=
 =?utf-8?B?NEJxOU1IandtejVjMzJmdHBPYmdnTDBMKytyTEt1WTJ2dTZrS0lGRmlwb3lv?=
 =?utf-8?B?YTRyRW9QUUp3V05CNzNSQ05iRzZGdDRnQmc1MHpBY3U4dzZ6MnZKemthTjNC?=
 =?utf-8?B?SkZhQXZrdmwwM0R4dEVnZzk3bUg5b0hyYlZxcjY5NU5nNkk4alpFdzB1NW01?=
 =?utf-8?B?SGhKRjF2bXFpNW40N0tOdkVtTVRiU1h4ODY0T0d1TkJwYmY5N1dLZVpKUjVT?=
 =?utf-8?B?NjIwT2R1SDNqZGFNeGw2YVVoaW4wcWttMTQvUDlpNHFVV0FlZ09pY3RQYm42?=
 =?utf-8?B?dk8xNXl6QzUrWlYwQVk0bHZYVEMrSzNaUUtyTWFmbG1LU3l2VVF5YWkxLytJ?=
 =?utf-8?B?dTlqMlozM0pJTkFRaXRLc1BsdzNhaHRPekRLNXMraEZqTTdpbHM0cHRVdkhW?=
 =?utf-8?B?RURjeks2S3BoK2FtK3FHNVRrTzdvUXhaMDg3VTdjdEtjZVlORUJvZmszdURL?=
 =?utf-8?B?OFJqakZKSDRTU0cwQkFaK2w5S2REM2FkdFRxalN2eDVrZW03V1hTejB5Tnk4?=
 =?utf-8?Q?mVOZzmD9zQThvLSOeERagkKrF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8826d05-2f72-44d4-d2f1-08de27b75d78
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 22:02:43.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4DUeVXBFny1TOyJK29eFgtv3i88m+zrxQ2ROBJSMxaYe0iKoisSlSAONezTxMcV90l05v5cDC/Q8gLV21Kiwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041



On 11/19/2025 3:23 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> CXL currently has separate trace routines for CXL Port errors and CXL
>> Endpoint errors. This is inconvenient for the user because they must enable
>> 2 sets of trace routines. Make updates to the trace logging such that a
>> single trace routine logs both CXL Endpoint and CXL Port protocol errors.
> No, this is not inconvient, this is required for compatible evolution of
> tracepoints. The change in this patch breaks compatibility as it
> violates the expectation the type and order of TP_ARGS does not change
> from one kernel to next.
>
>> Keep the trace log fields 'memdev' and 'host'. While these are not accurate
>> for non-Endpoints the fields will remain as-is to prevent breaking
>> userspace RAS trace consumers.
>>
>> Add serial number parameter to the trace logging. This is used for EPs
>> and 0 is provided for CXL port devices without a serial number.
>>
>> Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
>> unchanged with respect to member data types and order.
>>
>> Below is output of correctable and uncorrectable protocol error logging.
>> CXL Root Port and CXL Endpoint examples are included below.
>>
>> Root Port:
>> cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status='CRC Threshold Hit'
>> cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
> A root port is not a "memdev", another awkward side effect of trying to
> combine 2 trace points with different use cases.
>
> So a NAK from me for this change (unless there is an strong reason for
> Linux to inflict the compat breakage), please keep the separate
> tracepoints they are for distinctly different use cases. A memdev
> protocol error is contained to that memdev, a port protocol error
> implicates every CXL.cachemem descendant of that port.
I misunderstood this comment from previous code review:
https://lore.kernel.org/linux-cxl/67aea897cfe55_2d1e294ca@dwillia2-xfh.jf.intel.com.notmuch/#t

Are you OK with the following format for Port devices? Or let me know what format is needed.
cxl_port_aer_correctable_error: device=port1 parent=root0 status='Received Error From Physical Layer'
cxl_port_aer_uncorrectable_error: device=port1 parent=root0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Erro'

Terry





