Return-Path: <linux-pci+bounces-21749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723ADA3A15C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 16:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE5D3ADB66
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F81E26BD8F;
	Tue, 18 Feb 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fis6PTg3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2626D5CA;
	Tue, 18 Feb 2025 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892834; cv=fail; b=C9sQ0xzgfNK5XM9zNgfFTi/eeO6w0A88cHXS9O+0PCIeZcgYOv6ra0Zj9Jm2b6H3wtXCY9yiFTLesN44OOFZwLwsCFh4O6h/uZEbqexPQMcWdOiyCCachIT33Y8UQ3gTmrZzVnRb03oTkD5s+SkNuT6fTnh+osmT6XVPFGro66M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892834; c=relaxed/simple;
	bh=4AJu8eK7+C5XctBdi1fAg1LieSeRs4yLC2SMjFhVJNM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZXZnCxyppp/lFYkCOcRND2vF1b7IJyOThEUM4d4IVKNs1uCSDF1TjrFNqlgXKG/5REiOwM+lKHin4w6rhL+cnI+e6nv3uugWGfGvMNsxIZFmkjPpZ0JPBP7mCy6G+zxPliRYtTY9wYBpN85EE89B8MggF5oz2yE6/NWUfQpHgx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fis6PTg3; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2NoI0pxxDDu32S4adsaITh4rgYFJwihXMagI7UmHhiDAns0IWEJPdDX/2MlxiqCbEaGUqf7BdSdRTTZzWAgxtrtDw6JYxg6m20m6KpFR6ift7FB+qLY5STwWlsGFhEgVleKHT+7OSiErjNl6EO8MGqn+FlSEzfYBEKjM37H5SjbGFKWWVwGWa9Gqq5fVfzQoxBUcZwY9qj6AaLz7bnXZl0XjCnkBmZVDilbbNyyzJcnGma0hsAPwt9I9FvUfMZ7L5N6rdGGWKvr09/L+3gXIvSYMtSr7swMBc5bTj5g7I4aQa131vcm1jfHUZ64qUQTN4nlQny/Mgf3ipOrL8fw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53hbzHpbuD+cMGuZV5w3o/yAfTnFygOks5NuHngSPFk=;
 b=fvlfNgysWAgNVWFU3Q8dtpSb0XY9XpYsvwfzStIz5cYkVK0LzfGMS/o/EqzrFgxsX48ZwnDVJOLptG88C7VhjStWHbL40YM4gY9mOtbxaDBh4Z/MZ5rpkSXJ9v8FQfxYnDjiIDRug6M8z+OQTphXD7o3TSJAcPxkwtPhsVH3Ge1e/qeAAsuZx7Sk/8R/yIPyrFrftZasDBkzDN+HY/h5f7NE9ggvCNOhfEJonsaX3Nn+NMStn93CIz2vD0skONk8DTA2QWjAJLslvO/I/cgmlxhhsPAuu6QBAvRg+4BaiNye8pS/9V4bVGKb6+pCyTZV9nXgCnUWVN6PaIw/Tka7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53hbzHpbuD+cMGuZV5w3o/yAfTnFygOks5NuHngSPFk=;
 b=fis6PTg32MSUKQMPXp0Go12gWa81k70RlTbGzZj/2VWowYAQARnGb6oE/Hi5LHmd+ZnGOq51MGdkp6vCkY7LA/NMNXZGy2CcV+fHQl9N6zKcYefWCwDxfhpIeVDyZowYF0gho8cyDUe+5hnttxHXLoyKIDWwn4FY+HWrhvzCG+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 15:33:46 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Tue, 18 Feb 2025
 15:33:43 +0000
Message-ID: <4c42244a-cc6f-48cb-8013-012e5dc49b81@amd.com>
Date: Tue, 18 Feb 2025 09:33:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/17] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-13-terry.bowman@amd.com>
 <67aea8002a005_2d1e29466@dwillia2-xfh.jf.intel.com.notmuch>
 <408f6acb-108b-4225-81ac-4f17a6486020@amd.com>
 <67afddbec62a8_2d2c294a4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67afddbec62a8_2d2c294a4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::10) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b76aec9-7338-457e-64f9-08dd5031a069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3pheUx5aGkwUkp3d215VE1DS0dLVkZCc0ZNMlNaRysxU29ocEpqMzBjT2F3?=
 =?utf-8?B?ajdNN0gzMnRmcXRSd2dMYzhDU2dQUXkweXpBUzlkS1U1SEovUXk0R0hHRDdr?=
 =?utf-8?B?MVZiaW5obGFBak96RnpiS0puNEF5QmFsMUVDK0hHanBsQi9ab0xGOFhCV2x2?=
 =?utf-8?B?U25HaXJxaERWVW16dXd0dDhGNVc5QnlEdTZuQ0lNR1VyM2ZhdEYwQW1Gak5E?=
 =?utf-8?B?aS9JKzdBNE5sUmgxVWY4R3dKV2l0WWRiQWV3MjZ4WjdOSGVRdXRwTytVV3RG?=
 =?utf-8?B?cFBqY1RSNlZUZW9sWWFHUE1ISnhqVmhwbXoyWktrV2xuTC94Q1RmRUpIRnVj?=
 =?utf-8?B?SEtqa05yRXB2eWN2akU4b3VHVHFWbWYvd2JHbUY2UWVWVVNjME9UaVNLeVIv?=
 =?utf-8?B?QVFsQ0NVdFZ4NnZqaHE5SktTOFZFWGxBc2tZbExwL1lCbXhUZUluMFlZZEJq?=
 =?utf-8?B?OUduSzlzMkE0ZkdIdmRCcWFVYXR6RHpzZlM5OW41cllmRjVzNi9sSkNlaDMr?=
 =?utf-8?B?NFlwbGZaZDJJNjZRUTBIbG5IOGw4UTFWemNMMTFpY3RRTlprQ0RsalFyWi80?=
 =?utf-8?B?alJDN0pVSEptc1FqbzE3NVh6Tm5HUkRENXY0U3RHdmpRc01nUk1YdGVCQ2E4?=
 =?utf-8?B?UjFBbzkzYW1SQWFNTG1laSt0YmpEam9pS1BoVHl0NVBsYlYvV1AycE5lUlBP?=
 =?utf-8?B?cmpSTVR2SFEySFRWODB5WEZDQXBEaVhzRVE2TkkzUkRSYUc3Zk16aytmbTVh?=
 =?utf-8?B?eVczcUtIeDZoSllPQ0lqUG9UQUZoMmRzdTE1S2ZTUjJQUWFza2UwZ21rb2Jq?=
 =?utf-8?B?azViU2hUUmlQL2N1dXdtcW44RW5NU29oaENjR1ZOSGs3U2QvOFM5STNwdkJk?=
 =?utf-8?B?VlB4d25sbVJ2S2NJZXZJUlN3Zi9JNy9jNEpnSTNLUHJqUDF1ZkdDakIvL1Vw?=
 =?utf-8?B?UWQ5eERTRXNhRDdkdUZOTCsybjdBODFlQjFjSjFPb3dHaXcvL0hycE5UcDI5?=
 =?utf-8?B?cG5ud3VNR1dKbjdSQXNVWUNNejFOZm5uZVV2R0hveDFSejRjcjdiUm1FMmY3?=
 =?utf-8?B?MmhQeHJEV2x5Z0tnTEl4WENJUzMvcDViV1ViSGdGSDNtSityYkNXMUtuNkVs?=
 =?utf-8?B?SUZMRWlBc3BBUlNhRThDd0FLWndJbk5tNjBGTUJUL0o1SzJMaGFKWFJ2UElt?=
 =?utf-8?B?RVE2dlgySmdsaDg4QXBpUlNUSVJaeDlweUwzL0JtNUVFbkN2OTdhSGVwb2Zo?=
 =?utf-8?B?TU1uOEFyZGVsOUEwOThDcjVKd3hjdjZCZVRxMXEzZlJGY0lQMUZGbHZPUVRS?=
 =?utf-8?B?RW9BNnlGTHg1QnplVHhXbjlxcjF3VTl3clpEcEx4cEdjdDhTdG1JZUZ0dEFT?=
 =?utf-8?B?QkJkRE41L0xuMytyZ0x2QkF2ZU4xL3hDckI0OCs3QTdBeGg2aTMxQXJlTzZ6?=
 =?utf-8?B?Qm54c2srSGQxVGs4YzdtTTEzTHZNSW10a3pDcFg1TVFVcCt4QVN0N0I0OXVh?=
 =?utf-8?B?ekg5c3ZWS1dqSHJETS95U0thdk10dSs3ai9BbWE3QkNQMFUvVHZ1T0FWRHRL?=
 =?utf-8?B?dnpuNm5VZTA4emhSVEJIcWN1MXN0MzViTWR1bi9VTzFLSmIzQnRPUTZxQytY?=
 =?utf-8?B?M1FKVDBlajJuazdMT0pvYWZSSFNVaEJoNWhXN3lMYWlLMU9Tb1czY1UvTm9Z?=
 =?utf-8?B?WkpJSkM2REl6UUt2TE1ZN2U3aHBTTFM2OEN3SGFTYWt6cE5yRzdhMUhvdXlN?=
 =?utf-8?B?bGtzMFUyZ0RrUkd3OXZRL0RPQVVGVkZEYlpSMlBoQ1N1bE56S0xlcHk3TUw0?=
 =?utf-8?B?blF2OUs2dzhMdStwcG55L1ZnZGZnWGhsbDN1Q0tETE1vbjgvY1ljN0U5bVM1?=
 =?utf-8?B?aGpOVnBpSTdwZDFkRWR0Sld4b1pOR0UrckVlQThGblNmS2l0VHlzQVVkQ3Zx?=
 =?utf-8?Q?g6KH01eVC1A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGxNV09ZT1N5SExhRU5telBZazFpaFdweU1jYkVZT3RSdmJOanJHZlFDWnRZ?=
 =?utf-8?B?ZytML1k1dGZISXNwR2dJT3BBK0wra1JWQ1FmN3RzcHBFcC9wNjJnUjg2L0tx?=
 =?utf-8?B?ODhvWHl6V09waFdTUDYwRGphVUNLZnlUKzkxdVVMS3VhcHFCNVFFOXZRdDNO?=
 =?utf-8?B?K0xBTTVSU0swdmptZjFKRDA1KzhRbUhzbmdTWi9iOEVXZDZWZC9MOHhmOXk4?=
 =?utf-8?B?WWtYTVFuNzVyR3ZBdWtRdm5TRG5NbHNMN2N4QWhNVzFBL0FrU2JTNVFSbndO?=
 =?utf-8?B?NjJBdVBqMGpXbUs1LzRjbHV2cWptMmorYWN5SU16Vko5cHY5dDVrQVhqd3Nx?=
 =?utf-8?B?RUk3UDRLSUlRZFVOOHlUOXgwbFNkOU5QTTJMcy94MSs4N29wNzhiRS85U2dw?=
 =?utf-8?B?MFQwUWFPL1FZc3dPTTh5LzUvcyt3dXRyVkMrOXJHUGZiRStGRWxmbUxzTW9O?=
 =?utf-8?B?dEx6ZHhxRGF1ODJialRZcjNWODdxZFc3dHZGSFJtME9sS1BwOG1MTEk0OTRS?=
 =?utf-8?B?K2QyVnFjWCtwRkNvVUtLS1Z6TUgyY09uVUl6eFJadkpPTXBBQ09odkNTRVY0?=
 =?utf-8?B?S0kyNVBXZ2xiWGtLNDFnVkNxYzdMSTE5NUpyM2pEdHVYUmprSU90TS8wU1kr?=
 =?utf-8?B?MDdQRHVxK21aVXREUDRJVkpoNTVBbUl5RFNEbE5pKzJXTEpJaGdlcWRlaDQ4?=
 =?utf-8?B?Y0tCQ3RXYllZelI4ZU5LQWJGM2hmVHZabzU1N0R4RnVlU3EyMmoyZ29GRm1a?=
 =?utf-8?B?WStQUy9LV3JKa1NLREp6VWJrVEpDelZwbmMzNWN3d2xURGNXZXA1ZUc2b3R2?=
 =?utf-8?B?MjVuYXY2M21GQXVySzRrL05BUThma3ZLUHpSVmdOZVpkYVFTcHBNbUhlTUpJ?=
 =?utf-8?B?dm5sV2p0cmJZTGoxVWh6UHVhcVJaajl2WlJkWXZEb2ozMzVDQ28xV2FMQkRE?=
 =?utf-8?B?NTFxcldkaUc5RHBDRUxPbjRFcksxS1JmT3FZZ05LZmpOeXMzNHRNUXVyeTdl?=
 =?utf-8?B?QkJ6M3YwOFBVR0dwY3RMcjlHd1VnZUliVU91OHkrNmIyQWFLdkZEZzNvejQ3?=
 =?utf-8?B?eVlWbVpRMDl0MnNFRTJsMFpMQjRoamt5cEZqZnBmWXEwM0toU1NTWVNtTGtu?=
 =?utf-8?B?ekEwM0lqd0lSblNCL25vQ1Evb0pFRkhldU9qQThxbFJlM3RnTkZFTXZCcFNW?=
 =?utf-8?B?R045NlhSajV1VW53QU1ad0g1SUpQZmNQS29KREsyZ3FKaHZyTGJVNW9TSnpT?=
 =?utf-8?B?eWQzeXBqRnlHRjZKejlPTWw4ZTFHOWd0TUpINUpNc0pkV3M0OFJrcnBkeWk1?=
 =?utf-8?B?Rm5WcGFzMkdESnQveDVJclVnZEFzT3RFRXA5VjFuai9wWkU2MDJ0b2llR0Nh?=
 =?utf-8?B?dmFCT3dHRWdRdFNWeHpkaU52eXA1RlNTU3hmVStnYkwyUUtmd3ZJaE5pWDJO?=
 =?utf-8?B?akVQOS9sS0xrTGE3MzJYL1NWdzE4S3ZSM0R0TEduN3Q3WlEvcDJwNTVhSXU0?=
 =?utf-8?B?T0xsR2RBWDR1REsrWEJtcHlmZjI3QUhlZnBpRTJnallSK2RESE1JNTFIRFY3?=
 =?utf-8?B?UjZCcjBXbTgzb2hzaldkMDVpcHliQTVDWHJaZ1lLSjhUbkpZd2ZpRHpFdGpO?=
 =?utf-8?B?RmtnZVhaS3loVVZnd0RrNUR3TnhOSU0zYlNUMGZNMHUvRHVOUGh2TkZDeU8w?=
 =?utf-8?B?eXJobDRZb09SSmplV3BhdytHdXlVc0dWWUdBZk12bTN6eGlxNmhYMDZaNjRM?=
 =?utf-8?B?WWpxZWp3Q1VYbjlqSXhGTlpDbjlKM1BpNE1OVVNDd256bnllaTBkdHNKRU14?=
 =?utf-8?B?MGExNXlleVgrZ2JFSFp4WkxqTFUxUHh0NXFheGtsaDRvb1U4aktVaUlEek9t?=
 =?utf-8?B?SnVYdTFIbjlyT0dYNlFBMzI4bzdyajlxUDdMNWZJQ0lNQU1iK1ZiZHpFaWg2?=
 =?utf-8?B?NjgxSGpYZnZMMHgrQ2k4a0psT1NsSEZkTlNoRHoyYk5EUld0ekVBZDZNSVZ6?=
 =?utf-8?B?d0pzbXhSd3YxZE9wUXJMZ3NXZTlKcndlSzBzdENBK3ZPVTRsSHJjVXdRWXBG?=
 =?utf-8?B?blhiRUZHb0VTaVJmUmhuWC9QSXJHenhsM1YvNlNudncrcVZoZkZ3aEoxeDBX?=
 =?utf-8?Q?JFrH7AImCOC/uJl9NJEAQmJRR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b76aec9-7338-457e-64f9-08dd5031a069
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:33:43.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9Xyp2GA2uoUZwGX8i4K/kjG/GJhHWvERAz0089pYTGeTQBmyN/11DzFpilNmSEthHRusVsaDKF35Vin3zdgEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330



On 2/14/2025 6:20 PM, Dan Williams wrote:
> Bowman, Terry wrote:
> [..]
>>> Ok, so here is where the trouble I was alluding to earlier begins. At
>>> this point we leave this scope which means @port will have its reference
>>> dropped and may be freed by the time the caller tries to use it.
>>>
>>> Additionally, @ras_base is only valid while @port->dev.driver is set. In
>>> this set, cxl_do_recovery() is only holding the device lock of @pdev
>>> which means nothing synchronizes against @ras_base pointing to garbage
>>> because a cxl_port was unbound / unplugged / disabled while error
>>> recovery was running.
>>>
>>> Both of those problems go away if upon entry to ->error_detected() it
>>> can already be assumed that the context holds both a 'struct cxl_port'
>>> object reference, and the device_lock() for that object.
>> I think the question is will there be much gained by taking the lock
>> earlier? The difference between the current implementation and the
>> proposed would be when the reference (or lock) is taken: cxl_report_error()
>> or cxl_port_error_detected()/cxl_port_cor_error_detected(). It's only a
>> few function calls difference but the biggest difference is in the CXL
>> topology search without reference or lock protection (you point at here).
> My point is that this series is holding the *wrong* device_lock():
>
> I.e.:
>
>> +static int cxl_report_error_detected(struct pci_dev *dev, void *data)
>> +{
>> +       const struct cxl_error_handlers *cxl_err_handler;
>> +       pci_ers_result_t vote, *result = data;
>> +       struct pci_driver *pdrv;
>> +
>> +       device_lock(&dev->dev);
> This lock against the PCI device does nothing to protect against unbind events for the cxl_port
> object...

I'll update to use the CXL device instead of the PCI device.

>> +       pdrv = dev->driver; 
>> +       if (!pdrv || !pdrv->cxl_err_handler ||
>> +           !pdrv->cxl_err_handler->error_detected) 
>> +               goto out;
>> +
>> +       cxl_err_handler = pdrv->cxl_err_handler;
>> +       vote = cxl_err_handler->error_detected(dev);
> ...subsequently any usage of @ras_base in this ->error_detected() is
> racy.
>
>> +       *result = merge_result(*result, vote); 
>> +out:
>> +       device_unlock(&dev->dev); 
> [..]
>> Which directory do you see the CXL error handling and support landing
>> in: pci/pcie/ or cxl/core/ or elsewhere ?
> In cxl/core/, that's the only place that understands CXL port topology
> and the lifetime rules for dport RAS register mappings.
>
>> Should we consider submitting this patchset first and then adding the CXL
>> kfifo changes you mention? It sounds like we need this for FW-first and
>> could be reused to solve the OS-first issue (time without a lock).
> The problem is that the PCI core is always built-in and the CXL core is
> modular. Without a kfifo() and a registration scheme the CXL core could
> not remain modular.
>
>> Or, if you like I can start to add the CXL kfifo changes now.
> I feel like there's enough examples of kfifo in error handling to make
> this not too burdensome, but let me know if you disagree. Otherwise,
> would need to spend the time to figure out how to keep the test
> environment functioning (cxl-test depends on modular core builds).

Thanks for the feedback. Yes, there are several examples and Smita is using for
FW-first as well. Correct me if I'm wrong but the goal in this case is
for the FW-first and OS-first to use the same kfifo.

Terry

