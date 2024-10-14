Return-Path: <linux-pci+bounces-14498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55CA99D595
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D931FB21FA8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C06C29A0;
	Mon, 14 Oct 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TKPxhbPc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98301BFE10;
	Mon, 14 Oct 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926830; cv=fail; b=bFlYlSCEkycBA4A7EQDsvsLO0gTYTE546rIVjxV5I4vyus4m/1CBACMIC8Kakria7IMis8oHN7TaZwtQk9j3ZroJhB5h6dQnOfQl5LwcpNZhy2Z9LsheOBToToZXQ1tExpNuxKOu3xBjy/11N3uoojr3QblLJuu2LZfbP2uVULc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926830; c=relaxed/simple;
	bh=i/htXPDsGnMlQm3Vbsg6CZPQ5Vw6A8dAaZNE2tQOwXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hoGLu32MZueKxVHTa1H9SxCTrHsY5AFdfwi/YmbXyNlEx+Gmxh14fs0NCg8AkhDOD5ca7wuo3u8QwDC9SuzJhanvWjZNKa/6EGoacMMN5+cEe2QebDbvJlnKBtVGx4HIbW3zJJdKGAyvT3SgM2aIm9N4JnwwvRLei6zPEB05IE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TKPxhbPc; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHVvbO0TZP8tQK330XZy7kEMsrCLV5XpXOnR3y4Ohx5wA09WRA3eebY5Cbx8yyLrI3QuhyK7GwVOI6VmEoFGmtbcQCIycJ0nxSMH8766ueRm2yDRf7Pow4SXy3rtHrbNCnnNpFfLbBZaX6/Kdayk9xMb5fQiVXz1y7jI6VKIcD9KsvB1IzOa6jHKRX7KoQ8J0BRjt2OnQ8Ft0FX62h1ensKu4B1oSVQ5RC6V4Pf85ZOMvSQkgCEmENMYCBuQlVof5knic7b6VoLGYFoqgqgFdu5tVzAJKHfE0xTvn+98M2OlEbJM2bRC4n9SD8u84T8Xw3VSofzPy7BylzZzpBcyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDJctiwIV8qaOsFIFqKUgRuyU3XG0WIzYBx7jAqoB1k=;
 b=dAeUo04xqGm32IUzZxty0wkdseKf1iBuEdIRLWI95Lh2FdtdAWQLC7nCzyx6iJ6odz/wTo1RDXvotyWiXNHeIH8MuVQmjoHXNv4E+mWhgSOKC2RVHMmGSxEVc+ZjMusQgTdT2JWQ/J3i1z8+73F9VyMMSCoxthcl0FXYVz7p53z0fiCg4hi7c+u7AMMbSQ7gho2Uo4VG80565jmu+ZOWT1pybU+Tp407JcAglU2psseZUOZKfq1E6v7W9uOcst+JxiK+FTIFY7vTsl09PW/R5V/DZED3fydqc/15rKImJ7rYFAYoeTtd8+GFeWP61QMnTpnVd58w4joD4yO9UM9JTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDJctiwIV8qaOsFIFqKUgRuyU3XG0WIzYBx7jAqoB1k=;
 b=TKPxhbPcikL04yxfrywHnA1zsOcAMfAhAgkH0/D3kRD5s5J6IlwoNfAr3tnUJcI17vs/s6CJ1LR9E4CttKgD224z5oNRWJBiI2zmNIJeQm3NE6d/diAqc8HNMKBgKaHuBUGRB2J7pUrbEl1O1vXvdkcdv6DsUPckK+ys6SW3jEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Mon, 14 Oct
 2024 17:27:06 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 17:27:05 +0000
Message-ID: <1cea169a-778f-432b-9e9e-1d753bedd041@amd.com>
Date: Mon, 14 Oct 2024 12:27:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] cxl/aer/pci: Refactor AER driver's existing
 interfaces to support CXL PCIe ports
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241010191135.GA571342@bhelgaas>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20241010191135.GA571342@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0018.prod.exchangelabs.com (2603:10b6:805:b6::31)
 To DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 36858dbe-7681-46c7-2d57-08dcec756c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFN2aXhYSFhUbTlYZy9qaWcvNWNUVnAvK3o4MFkvWVdrREU2S0lpUFpYS3F2?=
 =?utf-8?B?WW4ycVRHSmNsOTNndFJqaTBjTXc5cHNJTnphdk5MWFhTR293V2Jlc1haLzBO?=
 =?utf-8?B?Z3lMeDZiWkdDZ25QeW83NXBOQjBtdEtrd2wyQThaTzdkSzdnemkrdytTYWRu?=
 =?utf-8?B?SWtET1BveFhXRWdFNC8xZkRFNm9Lc0NSNnpRTHNJWTRRanU5WWRvVzFwZzVL?=
 =?utf-8?B?ZHg5cW9hMkZjSy9qUmg0UStTOThIQVUrakNXOVl3cEU1YkxsSDZhbituY0lE?=
 =?utf-8?B?cWhPMGx5SGc1WDQ3ZDVCTTByM1lXZVRETDNWRzd3MzM5N2MxTTNCc1EvcUFN?=
 =?utf-8?B?NGVrUGk1VWFMa2svajA1TnVXZi96S25HVGlQS01tMGVLSUhqM1YzWWFXVFZo?=
 =?utf-8?B?aTlBQmYvVi8xdTRsK285NXQ1VDgrVWJESERNVGlHTVUzblE4SzFYQWtVZWZt?=
 =?utf-8?B?LzZ3R3h3NmxuUTJjYUNCeWhVSWh3alV3MnBIRkxFSXg0ZGl4QUgwbWdFak5E?=
 =?utf-8?B?YmF5NjVCY3VlU0pKQktsS0x0RFhwN1Vsb01rTkpkaEZsZzg5dEU4aDJQZTk5?=
 =?utf-8?B?UmJBQmpiaE43eWt2bW9zemF0K2FXV2I5RkVjeWN1NW4vanV0WU1UWE5wTEIr?=
 =?utf-8?B?dEdyNkN5NFlKOGlnNHJhY3VOaHZmTVovU0NHemxRejJKeEEwU0g3YXBGc0M2?=
 =?utf-8?B?VDhveDQrMUhTeTJOZEdUeGdFbFhIZi9makMxb1hYZzFZTlRqeUN0WE50OHBq?=
 =?utf-8?B?a2F2MmI2dzFISE5FanhscDM1Vm1QeUl2NFlJenJidlFveUYvMlVQcU5GUko0?=
 =?utf-8?B?V2NzU3hQYW80SE8rM3U0MTJHM0swQ0xKSHZHeXcwdk5ONzVTejVpbjBLTHpi?=
 =?utf-8?B?YXI2ZURzZ1B0cU9pRXZQK1YwRTVMTFA5K1BwaG5zaHZCbXF5N2Zxd29yTWRH?=
 =?utf-8?B?NUhPa2w4VE41akdNd2x0dllURnB4S0x4TFdpMVBJMEVwNXZ0ZG5OVFFtUEhv?=
 =?utf-8?B?TDNJOHZ5bkNwZjQ0SDg5eDZjaUlmODFLaDJiK1Z5aDJ4ZUFzMURjaGF1TzlH?=
 =?utf-8?B?V0JUakx1UExBNnhWR1JwNE85RzZFYmVqWXNGS2RjSUo5NXM4Vi9aOGxrNEpm?=
 =?utf-8?B?QUkzamp5SzJWWTUyTW9xZmJPZ0FCUWhxQXJJRzF3SEVqTXgweHpsUUhVMGpy?=
 =?utf-8?B?RHVrK3NJL3djL0ovKzNtN2x5S2g3U1I4Um1NZG5hb0ttZ2UvWm9uVnVFbWM4?=
 =?utf-8?B?Y1NlV2RqT2MvdXMvVGdwWnhjZURmZ0Z3MUdyQWh3VStST21vendUYis3aUlt?=
 =?utf-8?B?Zk5URVk4cHV6Mm1hYkFRbi9SQ09aclp2RXdpUCt3UjNYL2JYejJUekN3T2ZG?=
 =?utf-8?B?Z1hpWmhKcmljVktmWkRCd2FnM29RWXBDdnVqUk52N2gxZWNGc1hJRGM4WDNx?=
 =?utf-8?B?czYxQmozRDQycHlUREVpQU1kNmZKektHSTBSUUdrVllWdGdaWVF6VzlTenB0?=
 =?utf-8?B?dGxCL2ExZWpsZzJpYUhVWXBhTHJPTnBPNjV4cndmd3JrZmNMRnVxOU9BL3Br?=
 =?utf-8?B?RU9mMDlPRE9sNlNRUDFtaFl3cXhqcDllWXhsbUlzZ1l2MUF2ckNaUEo5U0Jp?=
 =?utf-8?B?RXU1cUJZMTZHOWNMWURoYmNpWmd4c3lzVkpIWGdXTUZKZkQxb1ZXc29obXRn?=
 =?utf-8?B?MWRIVXp3UHVuUmFveldpU3I0SEI0UXZBSlpBeHp2QnI4NjYvZ2k4cENRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUlOMzFNeUlwSmI4V3FWOEtyWlpTWkJzbXhBUmJxTFppVFliRWo5bVRiVTRw?=
 =?utf-8?B?Tks0aklvVlAvdGxydVphbk1sSU1KRnJ5WVFLRUhmUDdvZFgycFZWU0ZoSnNy?=
 =?utf-8?B?UnRNdnFnaklPbFZpOXZQWnJmWjgrcWp3Y1p4eURUd256RmE2Q1ZNWStaSS9F?=
 =?utf-8?B?TER4ejlQc3dYdE95VXBONXFoTGM4bmhVMVVRVGxCejFhY3lzTU1TcUhnVTdB?=
 =?utf-8?B?UGNVeDhiVm8rVUlnZXp3YTNEWGNRTjVETUJRaFdmRFByWFlWSWk2TDZtc3Z1?=
 =?utf-8?B?WEZGQTlYTzZMQ3VCcHgzR2pTSWxuN3J3R040TFplQlhiM1BXQmF1ZWpSY242?=
 =?utf-8?B?cng5SDFPYWdCT05iRng3TklOWi9VZzFqdllzVXNwcml2c3NYc3RDT216TUox?=
 =?utf-8?B?c0x2WXQ5MXMxTE50MkZmUDBhWkoyNCtXR2dwQ1QxV1FjTENXb1FPZEVaSUxt?=
 =?utf-8?B?QWZFQy9kbEZjTlZ6THhkS0JIMXNZUW52WUIyZmp4SWhMTFNKbnRRak1LR1E5?=
 =?utf-8?B?bTN5RFZPTjM1dmtmSWplKzgrVDJpdWRBNGpMUHMySk1SYmFkV1EyYlpDbm1t?=
 =?utf-8?B?cTNJWkFnb0tJL1o0cVp6N0NZMk9nTmd4eHRjclhESm80aC9oeWlmVXZWcTVw?=
 =?utf-8?B?UU5mN2VURkl2OTBBZkkvVWdRY0hqUkhsNkE3cjZoV29zRE9tUVNBbWhtMXRm?=
 =?utf-8?B?NUN0L1N1aXZZbXl3SGU3VWpEQTJlNXM4eU1UVldLcHRTdWNwVXE2YTF6eC9Y?=
 =?utf-8?B?cFBNclRRWkFiVTBRQWorbWZTK1JQSUtzQWprZCs5TWFBRE13bUtFQTNvYVFJ?=
 =?utf-8?B?bFZ0ekF5VmRLMUg2ckhEMmI0OVl3T1ZYL3Y1R3hmdVAzejBpWXBRTVdESnBQ?=
 =?utf-8?B?MG1Xd0tUQUFZQXlrZ2VmU21tNUZQVGQzd1BoSTc2TFlqU24wNlAvdTNCbGZx?=
 =?utf-8?B?UGMvNzNaWTI3T1VIOEVUM0pRUWNqaUNmeFpjRmkxZkxpVmFQcldsdFNvNlZ2?=
 =?utf-8?B?M0ZDcFhYWk1MN0t6VzU4ZUhYSExHVWRkVGN3ZUNkUHBKbFhxUWdSOGRVTm83?=
 =?utf-8?B?bTJWdUltZDhVTDloT0lWK2dneHB1emtMT0NkWHFoQ0Nma25seTBXQjF1TmZI?=
 =?utf-8?B?RkdBTFNxbUZwRHdoR01JaWlyNVhJZHdSM2F5dlMzUzk3MldBQXoyNWI1SUVu?=
 =?utf-8?B?MXlxdERWQUorWlJ6QWNNTm9yU1hrZGVrUkZmd3JRc3JlUk0vLzJTTGxSeVUz?=
 =?utf-8?B?QXQ1NC8zRStVdS9hTzJqbnJWSk1UNUtzK24xazdEL0JleFR5bE9paFRIZUxr?=
 =?utf-8?B?K3hiTFRRdW1FNWZmS1FIZ1V4WGRNRWhjd1B0NmVscFN5ZWtHdVRDanoxRVQr?=
 =?utf-8?B?Y0xucGx5U1JRc1dyQmpFWGtuK3ppby9WbWpxRDQ2NnlibktIM2pkaHdTbTAw?=
 =?utf-8?B?MGVoOXFJMHpQbXpFNVB6L2txbG9lSStjc2MwY25LdzU1RjJSY3gwUkdGY3Fo?=
 =?utf-8?B?cGwrVVB4Zmd3Vlc4TEhRZzN0WStJVkVWemhvZUpiT0lYQ0IwZm94cXB4QjJJ?=
 =?utf-8?B?cEdlRHNTS2l0N0luM0dvQ3B2Y2xseFNzYlVLczMwRXBjNld0ZVl0VmVhRG8w?=
 =?utf-8?B?STRxc1B2M1VZRnNOVDlZSExPaldod1ZQc0szZS9xa1lSaUdacGtPYWo5OE9H?=
 =?utf-8?B?R0hUdzlYQ1d6b0QxMSsyclZZaXJsQ2pKS2xHVUtySTNiZHhTOGU0enpJdmc4?=
 =?utf-8?B?ejZpVFVjcDJmVisrRkpTdlJ5T1VDVVQrV2E0VTR1SXJnaElGdHYyR0ZBQVUv?=
 =?utf-8?B?ZC95b2JBSUFScUcybmZRdTZrbXlQNXlYZWFKZnFQbkdxZDRoSzBxVDMzdnNQ?=
 =?utf-8?B?cEVMaXRtUU5ZeGtMTzgwYWNaaVFvMUNqeEJmM2traUx4SkpnVnZuZzA5K1Vn?=
 =?utf-8?B?TWo0SnoydCtxUDZSUjR3eHZSSTB2K3dIMklzc1owRXFkaGdveE9FLzJKY1Qy?=
 =?utf-8?B?QWQ0Wng4SE5HelVCUWtaN3NWbDh1NGVRc3RRellOcFk0N01RbWVGZGJvazB6?=
 =?utf-8?B?ZUlvbFFFS1FvNEpwSEk1WjAwbVpMWVRzaEN5MlkvZERaclJMdUxWd2RPRWVC?=
 =?utf-8?Q?qpEQh0wQwHKMxx61teJtCSykh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36858dbe-7681-46c7-2d57-08dcec756c9b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 17:27:05.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yfZszYxltrFKDU06WWdMlCLe7frN59nkz+5O4WwYP6FJuXbaf0/SwGNz9qc+QfgqteLUDFviezGaZfNU9l8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859

Hi Bjorn,


On 10/10/24 14:11, Bjorn Helgaas wrote:
> I would describe this more as "renaming" than "refactoring".
> 

Good point. Renaming is more correct. Thanks. 

> On Tue, Oct 08, 2024 at 05:16:45PM -0500, Terry Bowman wrote:
>> The AER service driver already includes support for CXL restricted host
>> (RCH) downstream port error handling. The current implementation is based
>> CXl1.1 using a root complex event collector.
>>
>> Update the function interfaces and parameters where necessary to add
>> virtual hierarchy (VH) mode CXL PCIe port error handling alongside the RCH
>> handling. The CXL PCIe port error handling will be added in a future patch.
> 
> "Virtual Hierarchy mode" sounds like something defined by the spec.
> If so, add a citation and capitalize it the same way it's used in the
> spec.
> 
> Same for "restricted host", at least in terms of styling.  That
> support was added previously, so a citation probably isn't necessary
> here, but since this is part of *adding* VH support, hints about VH
> will be more helpful.
> 

Ok.

Regards,
Terry

>> Limit changes to refactoring variable and function names. No
>> functional changes are added.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/pci/pcie/aer.c | 28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 1e72829a249f..dc8b17999001 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1030,7 +1030,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  	return 0;
>>  }
>>  
>> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>> +static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>>  	/*
>>  	 * Internal errors of an RCEC indicate an AER error in an
>> @@ -1053,30 +1053,30 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>  	return *handles_cxl;
>>  }
>>  
>> -static bool handles_cxl_errors(struct pci_dev *rcec)
>> +static bool handles_cxl_errors(struct pci_dev *dev)
>>  {
>>  	bool handles_cxl = false;
>>  
>> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
>> -	    pcie_aer_is_native(rcec))
>> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>> +	    pcie_aer_is_native(dev))
>> +		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>>  
>>  	return handles_cxl;
>>  }
>>  
>> -static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>> +static void cxl_enable_internal_errors(struct pci_dev *dev)
>>  {
>> -	if (!handles_cxl_errors(rcec))
>> +	if (!handles_cxl_errors(dev))
>>  		return;
>>  
>> -	pci_aer_unmask_internal_errors(rcec);
>> -	pci_info(rcec, "CXL: Internal errors unmasked");
>> +	pci_aer_unmask_internal_errors(dev);
>> +	pci_info(dev, "CXL: Internal errors unmasked");
>>  }
>>  
>>  #else
>> -static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>> -static inline void cxl_rch_handle_error(struct pci_dev *dev,
>> -					struct aer_err_info *info) { }
>> +static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
>> +static inline void cxl_handle_error(struct pci_dev *dev,
>> +				    struct aer_err_info *info) { }
>>  #endif
>>  
>>  void register_cxl_port_hndlrs(struct cxl_port_err_hndlrs *_cxl_port_hndlrs)
>> @@ -1134,7 +1134,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  
>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> -	cxl_rch_handle_error(dev, info);
>> +	cxl_handle_error(dev, info);
>>  	pci_aer_handle_error(dev, info);
>>  	pci_dev_put(dev);
>>  }
>> @@ -1512,7 +1512,7 @@ static int aer_probe(struct pcie_device *dev)
>>  		return status;
>>  	}
>>  
>> -	cxl_rch_enable_rcec(port);
>> +	cxl_enable_internal_errors(port);
>>  	aer_enable_rootport(rpc);
>>  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>>  	return 0;
>> -- 
>> 2.34.1
>>

