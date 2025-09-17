Return-Path: <linux-pci+bounces-36371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DABEB812AD
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 19:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54A61C2718D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813982FCBF0;
	Wed, 17 Sep 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vOghiWLQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03FC1EBFE0;
	Wed, 17 Sep 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130029; cv=fail; b=RCrzaBWz6B3cPEevj8hnjUH2bx7nB1aWedzkECKFzX46O1lDbi+Cw1RZahgndOb/wjOqf3fdwizzpzkkTAkJHWyZ5RO/uDifBP7/sKFbWcnhJ5JPPGETHCOLiRQC2U1L5oJ/6lQiwBfexL8AGuqPa3dRbz9Y+jlypMj+VygPBkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130029; c=relaxed/simple;
	bh=XG5AVAb017CdXm57fVJRMlMy5jm46cqHpcG4E8m9udg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c3CFoIXDVMhBah0Gr9ic/mcwZIr4xWEkBVPcgP7ppj6hJ3a0WMpqRICzCK6tv3j8vFjBCA09+mvrAR1csR+DRFODInEPMu0UW/+jSvPebvHevwLqAZBIMWYRyU03ECcCawwmx96o5mMvzl6sE2iflPac6bR5IItjNxzU/goAHR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vOghiWLQ; arc=fail smtp.client-ip=40.93.194.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viFQUBUJ9HBgzGpw19mxxGnw0vdxZFvBqF/cR9JA5D7DIw++nDLogh5DqISeIoztEpeYKO0iC8m2/km2YOT5yqeMMglsVwXop4UNPwfxfhem8r4S9UIFtVHMvHMz2n+9jlfLqPwTdltJHRvIVdnTDp6u0gfud2CBVMUxK2nBX5uXQlsgtl/Ge7f1HdPTGk9dbdPM+BRfgq4NI+80zcCoElNij//sGeyaHJAya0JU1Sm0XWJiKft1GD0zTaPKEtfBEO+z6IXdYqUW65b1+9hTu0gIz5ou7LT0/9EvGmw7g8WWxf5U4QyhdzoRvtXrmobTOFxhnw49kYMEaBelNV50Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwhFYfXdl1/8TosZ0WNj6RdK8ZGk/xz8tKCyYzxNzFQ=;
 b=K9A88aYygZapHDi7Qb+d2icQajPBR8/WXlMlfL0CwlyxEMJ7CM+cT+3c0kor4qFlEQvgdO9LuF57R8TLtbIuuiYnvR30z2CawRCySgM8ucXLSu3x+UFnOFDHmH3Jz8s9eqhXVm3VRB+m/go0fbGkpgb9x+ztyH6tuqPpg9ybV5M/KMU6cKKCBzS+D6GSxXun/VjJ7dlsiHi2PPDJ8g5CvIojseah2lj0rioqotFYPW9CQAsuSGvzzJc8qfo4TBb2OmiSNjkIPh8Ico5Ook5a9/o3S4Rqoh/gw/7VWQzDavaKW3b57NA7O9BLiKrunXo9QVYDw/iBmAydE4zI5qSMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwhFYfXdl1/8TosZ0WNj6RdK8ZGk/xz8tKCyYzxNzFQ=;
 b=vOghiWLQdNqjvmWrdgwxNPtJdi56JtywzLBGwzUkeFrYLz8SWckzIHqPrciFJJynXKlPan+uzCWbmSBUvYJk8EpgXaIFIhe3ShA+H5m/81t8vzsIJneezzdy04sj9V7icSeiS8IPpaBnWm/Ru0mX0HAHP5khRBzm1jhwRPoggJs=
Received: from DM6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:5:14c::29)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 17:27:03 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::fe) by DM6PR11CA0052.outlook.office365.com
 (2603:10b6:5:14c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 17:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 17:27:02 +0000
Received: from [10.236.181.100] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 10:27:01 -0700
Message-ID: <325f6586-5634-4c49-99c9-c5507480b8f8@amd.com>
Date: Wed, 17 Sep 2025 12:27:01 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] cxl/core: Set up isolation interrupts
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
 <20250730214718.10679-8-Benjamin.Cheatham@amd.com>
 <20250912162512.00005794@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250912162512.00005794@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c14e341-334b-4621-1b35-08ddf60f6a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFFBRVlURzYxOFF1S05wRkwvTHNtcVIrNWw3eUVNZi93eXBwY2d0dnUrTUlO?=
 =?utf-8?B?KzFheGVSbWNoVzBtZDdTQ1Joc2dkZlE2RDI2Mi83Sk4xamJmUElQeFNBbThu?=
 =?utf-8?B?clJSMG5FMjBOL3RLc1lJcGlDMEEwbWpTbWcwaFhoSG56a09CZFBuK0thMC9l?=
 =?utf-8?B?Q2p5V2wvTlZzVjlMaVlXZDg3V0xHWklZUEJ3eU44cTYrOTJBd3QxOU4vZEQr?=
 =?utf-8?B?Q3B5YVdvNU5oQzBEOWNlcUY1bUJYRkRhbC9Xbk5TTHgwNVdhRUdJSlBTT2dw?=
 =?utf-8?B?WEt0TkYwSWZzN1IyVGJleXd5TTJKN0VuZFJjWWlJV1JGYS9wYnQvZWpjSmpF?=
 =?utf-8?B?K28zZFBVNHU3QzRsc2VualRrSnZCb2Z1RUdvYjFDVElRSk85ekhsUEw1Vzky?=
 =?utf-8?B?Mm9wLzRTbkkwUkNjL09IUkErOWN4TGtxczY0Wk1SaG9vaVNNa01maE5SM3lW?=
 =?utf-8?B?ai9hUzVZR0Fucm9ma0Z0OEJIQUNHTjQ0ZHF1RG4rQmNvYW1jTjVYc29zSHVM?=
 =?utf-8?B?NnJtTDlYY1l1d2JXTlpUSXJUWmZXZVdmNWNjb3NkRXROSXh0MytwdnRHQ3Zp?=
 =?utf-8?B?Tmc2SVJZY2xLZGl4WHltZ3U1dmxRS0E0WDhNd01yWFZndUdZVmNyc1VPV1ds?=
 =?utf-8?B?SkRaSTcvOGVxVVc1ejRlcnFla253UUhhNzd1cWl1aWZPbUpQRkhHcVN4OUFT?=
 =?utf-8?B?dzBOQ1hJSXcraXBhUndTRzUxclpwQno5M2hCU3FITE9OTEorRWdQbnBPeFJk?=
 =?utf-8?B?cE5GOHJRdzNTZWZJQStlS0hld3lUUTkvZ2krUVZ1eTRyN2w0WWMzaGVVUzNs?=
 =?utf-8?B?SDlyQWZqWURTdHo4a0Z6WVhMT0EvTDFYbk1FNjV2TjIxUUVSa25rNVNlc0pi?=
 =?utf-8?B?OHl0L1VmSzRsQkxROERXR2c3M1pTVnh1aGJqNU5uQXQ2R1BrNmRqbzhnY0R6?=
 =?utf-8?B?bSt6dzNWNENYV0MxM3lVOExwWk9yb2dVRENqY1lyYWpNTGZXcWkvTDFEVDlU?=
 =?utf-8?B?eG5vZXVxckVTcTU1Q2NoRlF5OUxoUUo3aU1QaEZEcndzOVY3eXRjdXYwKzNG?=
 =?utf-8?B?UVZ3YTQvQko2UXZmejFJTktMeVNhb1ZJWXZjWEJQVVQ2WE1DOEZrc3RHaDlP?=
 =?utf-8?B?RVJic3ZYd1c1TWNvWjlOaExYSnovRmtGcmUzWWdqMzFKeCtZc2QxNFpURVdY?=
 =?utf-8?B?cXpMekhrU2dUdWVIakthK25tT21ZYzhPRC9tTUQ1a0NQVGRtazdvVEtaVUJy?=
 =?utf-8?B?VkViYU9waUZMcENyZGROdmpneFdEMWFmSXlXVXBhN0dpM1VlTnplUWtyM0pV?=
 =?utf-8?B?TmphaXJhdmt6UkZLVDZ5NTVSTnplY0pJVUw3eThNL3AzSkxzOGswUUpFNURl?=
 =?utf-8?B?dmQ1Zm0wRlZIUUFXWG9YYml1U0Q4dWN3aWtOTjc4MHJrT3pKaWNtZGRwZXg4?=
 =?utf-8?B?UFNodHh0dU83RzlVUDZyZWNhakFSYThpWnhBcU1GRy9pdUlQaE5Qald3blJF?=
 =?utf-8?B?ZDJHYjNaR3lvTjcwNm1ISjZiUm9hK3lrUnFjK01EdnNaVmlDOXVPMUNrd3RT?=
 =?utf-8?B?bTA2RGlYSUlBYjNqbW5WY0drcHVDMytmRGZJZkxhV1lnU3k2QUVQNGp0WkZV?=
 =?utf-8?B?Kzhpd2JCbmlPUnpWY3REbVdLQ1NVTng3RG5Bd2RWVTdjb0kybDFuVHVuYlF2?=
 =?utf-8?B?N3RZUExYblovd2N0RWh0SWFxV250NHZLRytxMENvdG5qNDNnczlUSC8vdlFS?=
 =?utf-8?B?RFZtT0JYRnI0dUJsN2dDNnh0emRjSzB6SU5pcHRlZEtiVS9vcTNBbFU3RThH?=
 =?utf-8?B?NTNLbm0zMVkyVGJBQmtWdGxBVGxURGJCSHpjMWVuNENlY093K1pOSVp4RGgx?=
 =?utf-8?B?L0dnUDZJTHZtVGhFQU5NVXpvbG9CNlB2Z2JKMEUwWkJIWWFoUjJuTnltOXQr?=
 =?utf-8?B?dWlDUnB0WlBFZ3FHc2RaSEVCUnZ0RDhkaEtmUmhiOW9yU3lRVUdnNW02YUFt?=
 =?utf-8?B?TGYzejc0dkk0R2JhS1FiVEFTYjhtdUhpNWYvNEJyT3I3TlEwUWdxRUUveWp2?=
 =?utf-8?Q?wK62kF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 17:27:02.3068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c14e341-334b-4621-1b35-08ddf60f6a3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410


On 9/12/2025 10:25 AM, Jonathan Cameron wrote:
> On Wed, 30 Jul 2025 16:47:09 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Register a CXL isolation interrupt handler as part of cxl_dport set up.
>> Only CXL-capable PCIe Root Ports have CXL.mem isolation interrupt support.
>> The interrupts are left masked and will be unmasked in a later commit.
>>
>> A CXL-capable PCIe Root Port that has CXL.mem isolation support and no
>> interrupt support will have any isolation support enabled. If
>> isolation were enabled without interrupts CXL.mem transactions could
>> return poisoned data. This could cause data/system corruption if left
>> unhandled, so the capability is left disabled in this case.
>>
>> CXL endpoint drivers can add an isolation handler for a device through
>> the isolation_handler member of struct cxl_dev_state. If this handler
>> is not present, the system will panic. If the handler opts to not panic
>> (i.e. returns "CXL_ERR_NONE"), the endpoint driver is charged with
>> maintaining system reliability (cleaning up CXL memory, disabling device
>> state, etc.).
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> 
>>  /**
>>   * cxl_dport_enable_isolation - Enable CXL Isolation for a CXL dport. This is
>>   * an optional capability only supported by PCIe Root Ports.
>> - *
> Make the edit on original patch if you want to get rid of this line.
> 

Yep, will do.

>> + * @host: Host device for @dport
>>   * @dport: CXL-capable PCIe Root Port
>>   *
>>   * Returns 0 if capability unsupported, or when enabled.
>>   */
> 
> 


