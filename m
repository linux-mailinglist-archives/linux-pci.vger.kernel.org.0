Return-Path: <linux-pci+bounces-24240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A88CCA6A989
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 16:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00235188F6AA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3BE1E32CF;
	Thu, 20 Mar 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RtJeEnxz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y5HfQjQt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805111C3BE0
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483691; cv=fail; b=nuS7TRykWITVWWOniH+ZOrrMCpHHmo24ETHnsWYdfFVN2MLgdHqkVUiecwJ6gLHoftI8QwZ9n9sLIBL41HaO2PS/SmO7qUhQXda1i7va4gG0abf6Fclr2APXGZ3MSeq88VTxRSnUz4AORox/kac6WMLtBNKrDYBUwoUsuo4wOKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483691; c=relaxed/simple;
	bh=8BVreoo7Uo1Cfy0xXDE4oyU93ufl+wT63v6Lsgs+Pm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cRAIz862Ri/bJs3nU1xLHcCvKZOBuCKL7n3koCHDPCBpsgicGPzwz4mWlxwqedPZ7bLSdZE6iT9SM5s4HTOG3bGCJcih/fJr0iehP/ZVwcTUfYWf/EbUo/17vaxcdErphiuLQceIcbWzCZN3SoFbSEt9LR5BodLljn59l7lCJuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RtJeEnxz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y5HfQjQt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDMlZh016028;
	Thu, 20 Mar 2025 15:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8bJpkHcYMVtUE0gkQPedrz9HWoegi3l3c4I5YzlROpA=; b=
	RtJeEnxzC6rjGSgBFutsfre8K/ufmgQEsSx3Mi1JpBGUgjp7VCRIsFn1WNo+b+mu
	tsG1k2ez/l3rN7o6N5wUjlxbMF9CXkje3AVn9VRLbkAjM6T6rYVkxotI5RTJnADB
	FtRF0kBowyFcFnPjHxO2hzMSVQIhA7I73u66cYx3vW+mLbQO26VZQfPdpLYW0xbY
	Ga61o2O7mmQKkoYLUkA1IUBYGSAjovkp90+OM0etPb56RVMdmqJNe4AK1CEHEfj1
	2ShEewuJCtVF0m3QBIpYTUEAB3bZ3f8NB77xausBH816Jai+aVlrL1RaeMgrLkJi
	6RwWjde4rXX7vp5/xNQ0Rw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3x7xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 15:14:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KEQJCf009621;
	Thu, 20 Mar 2025 15:14:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm2trdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 15:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ3btZtZ4OaKBggiaGbrjLU/8v1HL3NeuguHg3ncxCn+ID9JOTQcbz0TULdygUfCg2scDRY8SkG3Kmi2Bz1q49NM4oEhKKuKARml7dh8IxeBxhW27D+5jmT8jPyq4Ka44HtJikgj+nDfrw2tB36Qe2MQTHm9d8QQjgKCThq7srhPIuNpQnTg8bHwXL0BeW3uK1IW4k5Hq/tHrjBvLBvZclOrYEfZLpyMqejWEnZdOxiY+MCc2tQ+v2g3rTvgV2WYBOUQowj31kEa5kPSgf18why8NBl9x+vWH0mTE/mlDh0g/37jMqcvJCaKO+TeBpIf88QaIH1RWv0FFTcXBxTrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bJpkHcYMVtUE0gkQPedrz9HWoegi3l3c4I5YzlROpA=;
 b=nh5AaITGCNK8rzFYxjvDgvo0EjcdJN6a00Ch5ObEkK+7/FHi7gp/CniD6xVEN+8YuRyAL9E8mGmqiZM7btu4LZkNlbVmTUJg5AOtLpwdM+3ZNXqg7+3seq6exP58m8UTBBMZHEb4ZzFhBPAdIg+AZ3ZLSIJTql8wOfS/9F7HaNVjfeJMddtf5aNUfDrI9fkeyu3UVj3+BCGeSNcU8I+I0+LAoG2eZ1OLdbtQk1C4wm1J02aM76Qm6v8FvGbAmecUJj00n3P9oMvIcSJ1l5sUXMZKo7kqi31uBpaF9gDDpX96/rpWxCke5ti+FBUFeJnmG4g+EghPokBOPhn8RxOfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bJpkHcYMVtUE0gkQPedrz9HWoegi3l3c4I5YzlROpA=;
 b=y5HfQjQtCUhjM6xWc7boXzYCbNJ87w90xQBCqUueYDCpCPT53RP9eGUgMmlDUV2Mz7mUuIF8shLAu1J+dIWVtoGYedzrqH24t6zALxphTb9f0McDUabzMX/Cht29PvWtbJ0Pi5KFRcJ2tokdpiv6VKX+v1inCUfLRIhg3fYogPM=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by DS7PR10MB5056.namprd10.prod.outlook.com (2603:10b6:5:3aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 15:14:11 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Thu, 20 Mar 2025
 15:14:10 +0000
Message-ID: <b919c39e-bb0f-40f6-84c9-f712404c0ac0@oracle.com>
Date: Thu, 20 Mar 2025 16:14:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Consolidate CXL and native AER reporting paths
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jon Pan-Doh <pandoh@google.com>, Terry Bowman <terry.bowman@amd.com>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Ben Cheatham <Benjamin.Cheatham@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Liu Xinpeng
 <liuxp11@chinatelecom.cn>,
        Darren Hart <darren@os.amperecomputing.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20250319222120.GA1064967@bhelgaas>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250319222120.GA1064967@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::15) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|DS7PR10MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1c5f98-82d0-4a1a-6853-08dd67c1ddbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cThVOUp0cFpzdVFMbHJMY3BpenNPNXcxcmRDc0xNUVU4eEZ0d3pIcWcyMTF0?=
 =?utf-8?B?YVlNd2ZSMUF6azA5bUhjRWRGdG0wTHorMjI3clEzbWpiMmpuMGFRMEFoUlN3?=
 =?utf-8?B?V05VamFHNzNQdGZLTTRMa1V4UTlVdUtpb2h0V2xNWUU0YUpaK3pycEtjKzN4?=
 =?utf-8?B?eElIOUZheTVMYnQzWHlHcnUzUEFiZyttSlFjUnJ1OC9rVVRlLytKVm4vckdR?=
 =?utf-8?B?U3ViYkR6MytwL05DZnVQd2ppMkRVd3R2T1duekdRb2ZxUWtybFFhM2YvTVZ1?=
 =?utf-8?B?Y1hielhqSEtxaXVHM2h1Z3d4ZFJ6SHBhYVhiOE9DY2dUcm9JSU54YjRZNHlT?=
 =?utf-8?B?Qlc3UnBHanFTQ1luSlJmaDNicTFrTmJwVDRGSjQ2RWc1OXdGbCtsRGxXcnpE?=
 =?utf-8?B?WXZhVHFUU2tjSDZialFEWDNXblIxc01WQUVUWjRzWk1taWo0K3NYdkdSaXF3?=
 =?utf-8?B?U3BPaTFEVENaSUpFbVJONDlyZEI5UmlTUWl2VGtrai8rM0dUTW1xU1g1Q0VP?=
 =?utf-8?B?WXNxQlVVendmWmliT25pYjZPV0VpRnRSS05KSjJKNThTZkVHbzlCbzA3aUVQ?=
 =?utf-8?B?dWxnTXVTTEZzY2FVZ1lFaHVsQm9mbEk1RnEvYm96Z2hNYTd6Z3hzWWFtbUhF?=
 =?utf-8?B?RTROOURKbW1qVy96bDZJYVpLOTJYQ0lXQ2ZSYjl4TGIwemlvUVlINkNmaXcv?=
 =?utf-8?B?OHk3VW5oa2hPN0k0dEFKUmxNVUNIcGdTd0dpdFppOG1hWjFpeVJ0Y3JjY2w2?=
 =?utf-8?B?NFkyRFFiQ1V5MTZoek1jTjZoeE9MNGhkVFQ2UmlRekNNWGhUeHI5RFUwTDFo?=
 =?utf-8?B?WHVkMXF1U0V4NGtXVEFXN09wY2MyWU5MbUZZQkZDek55K2ZQd0hscytUcC9i?=
 =?utf-8?B?aTdDZ0N0a1BXbk9mMmc4aEl3ZXF1VElNU21LOG15Zk9naWNhaHRmSFJTZGFX?=
 =?utf-8?B?VnhzM3UvSWtLZ0h0b3hhcUxLUm5sMWpjS2pLNk13Yyt5aXYvTkw1L1phb1RG?=
 =?utf-8?B?RjNyblF3UWlqa1V3SGpZR2xUZS9aNE1lMXkxZGQybGtlbDF1RW5GMFA3c29h?=
 =?utf-8?B?N0NKbENnMG80ZW1qQ3hMTm9weFgzUG1OcVdkZ0ErekpnR2dRVW4yeXkwRE8w?=
 =?utf-8?B?SEljdFZiaFk3bGVnaWh5NHVKcjYvSnp0ZVRveVB1TDVwQko0WHZvdGNBMmhm?=
 =?utf-8?B?OEdyQWxzSmhLWDZwRjkwQ0NlT0E1RDhqWkJVWmRxa0ZCdjJKeWVVWlh0WVoy?=
 =?utf-8?B?aWpEL1p0NTlYZWtaalBJSkIwcGp6elQxZ0JxTkJITVMwbko2a1dzVHN3ekRa?=
 =?utf-8?B?WTJqSTZnRXBvQzFBajNXYitzNHIvNmRlRFBUNkgxZTFGZlQxeW44S280eElq?=
 =?utf-8?B?WDJ0Q3FldENKeWdhTUQzbjVCc3daN2J6SFVveURRWG43N1FhVmNTOGdCSTUr?=
 =?utf-8?B?Z0dYQzlkbzFLbnkvUk55ZVV3eUJFQ0Y3YTNpNE1HM3ZSbDJrQllhbTJubkx3?=
 =?utf-8?B?ajVwdHRsN1k5MUpLMm1xT2t3TkUwbk4rWURCTlFlaVlXejBDa0JMOU1mamNT?=
 =?utf-8?B?ajN4ckFRa2FqZVFZM0gxOUdmcmJQdzNLSWFSZGN0amFMOGNZejZFUlhYcENV?=
 =?utf-8?B?YUNVTzJZbzQrRWtOVVdWZGhTbkJmU0FhY0hXYUVVZWpKVWp2bkp0R1dLL01E?=
 =?utf-8?B?OUl4OEh0NnpKcUdhUUpna1lFOWpWOFAzQ1FETHZhQ2NiQ3BWZzBqTXFWOUl2?=
 =?utf-8?B?UTJrWERDTUgwcVBzOEVFcHhJSjVpam1UM05KZ1BzbzN1eUlma3JHS2NwY0hC?=
 =?utf-8?B?VTRXdGtaeEplVkk2SDVQUkJQZTRiYlhuWlVXMS96Zkt1azdDSEJXSm1QVmsx?=
 =?utf-8?Q?DdfkylpSsnsCq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0t6R3BWQmpHZkplWjUyY2ZYeTFvTWZXTHA4RHRNWGpDeDBlRktoejFMYTht?=
 =?utf-8?B?Z2o5Q0M4WVBPaWsxNmdUU0Z1UklTRHZyWktpRityeENLbWI5Zk94OTJXSWpI?=
 =?utf-8?B?UytqTWdCdHE4a2NuU1M2YmZpRE02UXZ4MnNOK0U4VjZNNHdhU0xuU2dqcXBU?=
 =?utf-8?B?ditERkJMSTVSOWtId0MreCtsQ0hMWkt6cjUwMStCUnI4WldzNDlqZFhVVkNo?=
 =?utf-8?B?M1JTN0laWk15TC8vOXQ5RXlYSmNqL3lBRDZxMnpvSkpnSmZMUWI4ZTZBd05x?=
 =?utf-8?B?RjROM0NKNjRFQWVTMGR2clpzeTI1TE8yM2hEOVBJOEZDTE0xeEMwS2tTOUov?=
 =?utf-8?B?TDVZZlhuVnp6OTB1OFJRM0pLWVdYaWRZOGtGNER6WXByZEVRZEZlWUZSV2Ni?=
 =?utf-8?B?TitmVTE5K1ZxV0FSQitwT2IxZ3E5SzZ4aWN5V3pFTWFEZllsRy93WFVQQU1i?=
 =?utf-8?B?TCtpMzQ0OVJibWJjelN1amJYWTR3ZldIeTBZQklhRTNXeDh3a1pvd3FpVDI2?=
 =?utf-8?B?NWJlS2x3ZTVhVmt3OHQ2UVdadkVWYUp3bkNtckZwc1lWdE0zZDlIUWxxTndk?=
 =?utf-8?B?SGl1Y0JLZjVmb0txNmg1bCttQ2FuYnZGRU85OHFRaEJWRkNnUTJZZVZLWjZw?=
 =?utf-8?B?QmVQQ21TL24wWWc3VGhEekNpempKKzA4R3pxWnV5RmYxWVhiR082WVJPc09J?=
 =?utf-8?B?QUZOek9RV2lZVE9oY213aXFyYTlXUjRRbHhVZGlLcnZIZ25mUU1tbWdITisw?=
 =?utf-8?B?dVJBbUhWb2M2c3l4L2hlTDBwUVpUZDNRL2VaS2F6WC9maVQzWEJJYkF1VTZo?=
 =?utf-8?B?VklIcThpaUJIRnNvbDlQT2R2eEJ2NEg0QWM5UUFSZlJvUm1tNldhbmhMbmsz?=
 =?utf-8?B?aUkvUHMyQXo0WHVWOG9HVHZObW1aa040UWVDV2JEWTJpemxaQVBURFU2S25n?=
 =?utf-8?B?bjJzb3FpWUhNTnV5OWtWd1ZrMyt5VWY2cHN0ei84YXRJL3VtMTQrd2c2by9B?=
 =?utf-8?B?VFdlalRtNVFlWVRyVDRSK2R6MWlXZ2NRSTJkVjBzaHlMNURUWlhVSlQxRThE?=
 =?utf-8?B?WkhhUVJTUXVRbEpRV21qME8ySk5TTmFVREFYNDg1eGlxUUxCWFVrdEZMTTBI?=
 =?utf-8?B?dWFKamVDcjBWMitxdm1xM3Bza2IzSHNGMEEzNHl0NHovNjFESU40bVQ2N0xE?=
 =?utf-8?B?WTBMYUZFTmxsUCtyZzduWGpDS2U3eUplQUI3OE9BVHNpbWdtRWI0UFRoVTV5?=
 =?utf-8?B?SVVpSGdpRUpJN2EzOWU3RkN3bDVsYlZMV1pJam5IazBVcXlvTVRxbTQ2R2g2?=
 =?utf-8?B?K0NrY3RTc0w4b1RPbXFIZDQvR2w5cjUyLzQ0dzRVeTZldU9zQjRJWk01Lzd1?=
 =?utf-8?B?YWlCZklNUmRRVTJreU13M0JkWEltcGhWWlcrb3VpWUVkUUVOQlUwOFN3TGNa?=
 =?utf-8?B?MVIwOG9PT2xwZk45aHQyL0pxQ0UrQVJ1NnZDYlJrUmVJeUdPZ2NzUWQrU0pF?=
 =?utf-8?B?azhIRGR5V3B5RWIxZUxqWjV5YUw5Zm82c3oxYTJDSUEyZnVzYzltaHNaTWM1?=
 =?utf-8?B?YzNHMEFTYzU5eFVXeitYbVRTc2NkTFhXUFR2SGMyQk1NMTFSakJiUzFTamp0?=
 =?utf-8?B?TWZKZlJqVUxRRS9NdStiWFgwRTFNcHVyWTFUa2k2WWFXRFo4akZIZTFKOHlQ?=
 =?utf-8?B?R09udTFQdE8renBvOWZwNUNZUmdydEpMcmlSSHh5cVFwdFhkeisvUStGS0dn?=
 =?utf-8?B?bC9rVnptNThJSWZkWDlWa1NrSUt4bXZyVWloQ1NXQkpmTnVlQWp1RmNPdFE3?=
 =?utf-8?B?RE5qRlNmN2ZVOXMyUDFiekNiYjVyOXptTTZldkVMWWI3V3N6Rm9TdUdJYzZJ?=
 =?utf-8?B?cTFMclBrKy92OW1kQnNzS3VVK2hNUDNKdEFBTHJBRUlsTVdwZHc2MHhIS1lB?=
 =?utf-8?B?dStrZ25ScEVXa0lDRExjSXdZU2NNdDZUY2ZwclhCU1BTT1ZWYVdmaTZzcVEw?=
 =?utf-8?B?eDExWk1pYXo1aUxrNmV6UE1iLzhvQjI2cWZ3RVZIcHpMbXJ2Nk9BZzk3ellR?=
 =?utf-8?B?NXk1V1kyUjRjbEoyQ0ZMRGRjdlJ1NGxLMEJLaFprb09WMUIwcC8rR2RObmVu?=
 =?utf-8?B?U0FmdFVhdFhUYUdiZGk1RzdacGowV1FIcFRVSlBsVVZBSFUzWUhBRS8yNDkz?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yNFNf8Tr9R080Q1eRPNuR9vxnXWGZYSWy2iRqrwcceaBOn2TNqEMQjM2JyAqLA9Y2MMzPtzshfqjDnIt9bZPWNukR3u4aiij9a9CH9M4iTqI4uUJG1icqy6JARkMYSJGWupUamywYyjl2gXxy1TGlIwgMdKk+s+BfUAVeyFn+27FQ6a73VBwKZ0qtcFvAU4OtA3iZZEbxjHqzvc66+puS1YdSKRsC/0DM5mpNPboqMBjdHI1KrfmGEOtjHHYuCq8kZSIxXZclLSoCov1KxJixRMHQB10ai4x8sbvRrN31KGrNe4zvE2aH6Q/Z7rdb7oaEuW+4gZP7TJ5dncGBNJpeL5Qoc8VeLCMKTTp6h/3LImQAdtSoaIsw5yKN3yNJPRjBNAJswGskftTGF5eO4+KatCm6XPIZ/JC8MH7byW8fQDrcB6C6rEHcVUMLkJFswmTLIEERUrdQt2/fcujy+ng5QlBUaSrJIfb8OvFKn213RQ0JG97fgqfTGbhUv+2GR1dTzfw3HLme6v3hiyhUznckEvok/8hobaWj4ZIE0PZCRYfqM2l4AG0tL4rmyPQEmPBRhhCIQOahqtJ+jTFEe/wQ8Ftw24OKl2rimn5JAu+EQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1c5f98-82d0-4a1a-6853-08dd67c1ddbc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 15:14:10.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+v62HjD1fLxS8EwmUZ2TqoLI8+VVZVuJbFgtmVje9SJpzcKxKkTjYVZe4IkANZnnKCBFZB3tofcoOwDrpYK1lBWccpCnWF57jy9RYOaKGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200094
X-Proofpoint-ORIG-GUID: l8zl4Eg5Ofvn_CEO6zSqpWDhoLyZoxZX
X-Proofpoint-GUID: l8zl4Eg5Ofvn_CEO6zSqpWDhoLyZoxZX

On 19/03/2025 23:21, Bjorn Helgaas wrote:
> [+cc ACPI APEI reviewers and more CXL folks]

Thanks, it's good to get more eyeballs on this patch :)

> On Mon, Mar 17, 2025 at 10:14:46AM +0000, Karolina Stolarek wrote:
>> Make CXL devices use aer_print_error() when reporting AER errors.
>> Add a helper function to populate aer_err_info struct before logging
>> an error. Move struct aer_err_info definition to the aer.h header
>> to make it visible to CXL.
> 
> Previously, pci_print_aer() was used by both CXL (via
> cxl_handle_rdport_errors()) and by ACPI GHES via aer_recover_queue()
> and aer_recover_work_func(), right?
> 
> And after this patch, they would use aer_print_error() like native
> AER, native DPC, and the ACPI EDR DPC path?

That is correct.

> If it changes the GHES path, I think we should mention that in the
> subject and commit log as well.

OK, I'll make it clearer in v2.

> I think this consolidation is a good thing, because I don't think we
> should log errors differently just because we learned about them via a
> different path.
> 
> But I think this also changes the text we put in dmesg, which is
> potentially disruptive to users and scripts that consume it, so I
> think we should include a comparison of the previous and new text in
> the commit log.

Like I said in a comment to the patch, I tested CXL error reporting in 
QEMU with and without my patch, and the output is the same:

[  152.090666] pcieport 0000:0c:00.0: aer_inject: Injecting errors 
00004000/00000000 into device 0000:0c:00.0
[  152.095743] pcieport 0000:0c:00.0: AER: Correctable error message 
received from 0000:0c:00.0
[  152.098676] pcieport 0000:0c:00.0: CXL Bus Error: 
severity=Correctable, type=Transaction Layer, (Receiver ID)
[  152.101576] pcieport 0000:0c:00.0:   device [8086:7075] error 
status/mask=00004000/0000a000
[  152.104012] pcieport 0000:0c:00.0:    [14] CorrIntErr

Please mind that this is coming from a kernel with Terry's patches 
applied, as I wasn't sure if and how I can inject CXL errors without them.

> Eventually would like an ack from the CXL and GHES folks before
> merging, but I have a couple more questions below.

Absolutely, many thanks for taking a look at the patch.

>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 013b869b66cb..217f13c30bde 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -885,7 +886,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>   	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>>   		return;
>>   
>> -	pci_print_aer(pdev, severity, &aer_regs);
>> +	memset(&info, 0, sizeof(info));
>> +	populate_aer_err_info(&info, severity, &aer_regs);
> 
> Maybe the memset() should go inside populate_aer_err_info() to avoid
> potential error in the callers?  I'm guessing we don't envision a case
> where "info" already contains data that needs to be preserved?

That's a good call, I can move it there. We always want to start with a 
blank slate when reporting errors.

> Both GHES and CXL start with struct aer_capability_regs from
> include/linux/aer.h, so instead of also exposing struct aer_err_info
> to the world, maybe we should have a logging interface like
> aer_recover_queue() that takes a struct aer_capability_regs pointer
> that CXL could use?  Or maybe it could use aer_recover_queue()
> directly?

Hmm, sounds good, I can try implementing it this way.

All the best,
Karolina

> 
>> +	aer_print_error(pdev, &info);
>>   
>>   	if (severity == AER_CORRECTABLE)
>>   		cxl_handle_rdport_cor_ras(cxlds, dport);
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 9e0378fa30ac..b799c2ff7b85 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -561,30 +561,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>>   #ifdef CONFIG_PCIEAER
>>   #include <linux/aer.h>
>>   
>> -#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
>> -
>> -struct aer_err_info {
>> -	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>> -	int error_dev_num;
>> -
>> -	unsigned int id:16;
>> -
>> -	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
>> -	unsigned int __pad1:5;
>> -	unsigned int multi_error_valid:1;
>> -
>> -	unsigned int first_error:5;
>> -	unsigned int __pad2:2;
>> -	unsigned int tlp_header_valid:1;
>> -
>> -	unsigned int status;		/* COR/UNCOR Error Status */
>> -	unsigned int mask;		/* COR/UNCOR Error Mask */
>> -	struct pcie_tlp_log tlp;	/* TLP Header */
>> -};
>> -
>>   int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>> -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>> -
>>   int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>>   		      unsigned int tlp_len, bool flit,
>>   		      struct pcie_tlp_log *log);
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a1cf8c7ef628..411450ff981e 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -760,47 +760,33 @@ int cper_severity_to_aer(int cper_severity)
>>   EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>>   #endif
>>   
>> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
>> -		   struct aer_capability_regs *aer)
>> +void populate_aer_err_info(struct aer_err_info *info, int aer_severity,
>> +			   struct aer_capability_regs *regs)
>>   {
>> -	int layer, agent, tlp_header_valid = 0;
>> -	u32 status, mask;
>> -	struct aer_err_info info;
>> +	int tlp_header_valid;
>> +
>> +	info->severity = aer_severity;
>> +	info->first_error = PCI_ERR_CAP_FEP(regs->cap_control);
>>   
>>   	if (aer_severity == AER_CORRECTABLE) {
>> -		status = aer->cor_status;
>> -		mask = aer->cor_mask;
>> +		info->id = regs->cor_err_source;
>> +		info->status = regs->cor_status;
>> +		info->mask = regs->cor_mask;
>>   	} else {
>> -		status = aer->uncor_status;
>> -		mask = aer->uncor_mask;
>> -		tlp_header_valid = status & AER_LOG_TLP_MASKS;
>> +		info->id = regs->uncor_err_source;
>> +		info->status = regs->uncor_status;
>> +		info->mask = regs->uncor_mask;
>> +		tlp_header_valid = info->status & AER_LOG_TLP_MASKS;
>> +
>> +		if (tlp_header_valid) {
>> +			info->tlp_header_valid = tlp_header_valid;
>> +			info->tlp = regs->header_log;
>> +		}
>>   	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(populate_aer_err_info, "CXL");
>>   
>> -	layer = AER_GET_LAYER_ERROR(aer_severity, status);
>> -	agent = AER_GET_AGENT(aer_severity, status);
>> -
>> -	memset(&info, 0, sizeof(info));
>> -	info.severity = aer_severity;
>> -	info.status = status;
>> -	info.mask = mask;
>> -	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>> -
>> -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>> -	__aer_print_error(dev, &info);
>> -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
>> -		aer_error_layer[layer], aer_agent_string[agent]);
>> -
>> -	if (aer_severity != AER_CORRECTABLE)
>> -		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
>> -			aer->uncor_severity);
>> -
>> -	if (tlp_header_valid)
>> -		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>>   
>> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>> -			aer_severity, tlp_header_valid, &aer->header_log);
>> -}
>> -EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>>   
>>   /**
>>    * add_error_device - list device to be handled
>> @@ -1136,6 +1122,7 @@ static void aer_recover_work_func(struct work_struct *work)
>>   {
>>   	struct aer_recover_entry entry;
>>   	struct pci_dev *pdev;
>> +	struct aer_err_info info;
>>   
>>   	while (kfifo_get(&aer_recover_ring, &entry)) {
>>   		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
>> @@ -1146,7 +1133,10 @@ static void aer_recover_work_func(struct work_struct *work)
>>   			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
>>   			continue;
>>   		}
>> -		pci_print_aer(pdev, entry.severity, entry.regs);
>> +
>> +		memset(&info, 0, sizeof(info));
>> +		populate_aer_err_info(&info, entry.severity, entry.regs);
>> +		aer_print_error(pdev, &info);
>>   
>>   		/*
>>   		 * Memory for aer_capability_regs(entry.regs) is being
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 02940be66324..ab408ec18e85 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -53,6 +53,26 @@ struct aer_capability_regs {
>>   	u16 uncor_err_source;
>>   };
>>   
>> +#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
>> +struct aer_err_info {
>> +	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>> +	int error_dev_num;
>> +
>> +	unsigned int id:16;
>> +
>> +	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
>> +	unsigned int __pad1:5;
>> +	unsigned int multi_error_valid:1;
>> +
>> +	unsigned int first_error:5;
>> +	unsigned int __pad2:2;
>> +	unsigned int tlp_header_valid:1;
>> +
>> +	unsigned int status;		/* COR/UNCOR Error Status */
>> +	unsigned int mask;		/* COR/UNCOR Error Mask */
>> +	struct pcie_tlp_log tlp;	/* TLP Header */
>> +};
>> +
>>   #if defined(CONFIG_PCIEAER)
>>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>   int pcie_aer_is_native(struct pci_dev *dev);
>> @@ -64,8 +84,9 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>   static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>   #endif
>>   
>> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
>> -		    struct aer_capability_regs *aer);
>> +void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>> +void populate_aer_err_info(struct aer_err_info *info, int aer_severity,
>> +			   struct aer_capability_regs *regs);
>>   int cper_severity_to_aer(int cper_severity);
>>   void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>>   		       int severity, struct aer_capability_regs *aer_regs);
>> -- 
>> 2.43.5
>>
> 


