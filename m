Return-Path: <linux-pci+bounces-39178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 232DBC02ADF
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33DB534F5A6
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450A3446D4;
	Thu, 23 Oct 2025 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jk9KPLfg"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66BF2609FD;
	Thu, 23 Oct 2025 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239583; cv=fail; b=um4N/nqNZ6p/7Har6tbv+muvH5j9P5RK+5f+50jZx96Z3JAvhQmu3cTf3uxV5thIBGeB0DAhMvbWq1CkEDLAOu9AJ9ElFek1zJVT7h15fzl7/BPkOQm6vflvVW9mmj22zOWBMIvj3h4IfwYDEw7DgYL/AP2ZDM5rmmhFW5M9WJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239583; c=relaxed/simple;
	bh=ItucSfjkigv6/FHfQkB0h7DBYuz7v4YIi6u5kmP+nuk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nUyuxnQv7EDD81Mx+ASyzYalys0ir5i68ye00P/bh/2inJG/NV3f7Jf0PNEcKr4WUhzBEJtdOyj8TMUJLuvB5BxbD9Ke+CcsGBtf8R0tRXepQb0Cy5PldOEXHHqTUIfvrNW+lrC2hHCiP13pr0S8M2YcvxVPPHU4g7TL97XAaBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jk9KPLfg; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJbo1rki2jl0+cko84F4hbMbXCjffnkk+sg0m44Mb6SQCbj+O7OBcAoR485LxwAZI51yS1lW7GLmUrwx8uL91sA5IAODTEDLe8cSfEQIjvtV3/d3cwtI4R0Pzclbi152kX+IP1saiodgoF0fX5X9WopbmnBpKEk6ngnZi6OPWbVUs3CIsGp9RfYjeh49LkJpODmwIEA680PFk9LN9FR+2+M+Gja5Zd/Tx4V/ZBCkBKeWt0tdZEB9CM/e9nhmpegK3p5acP6txB62nQOnIi3A+9kiDTRPrX8i+uWUOby4QDCPV5NLF+yMf3U7yYwNMz/7BnHbSf4OgN64csR3qsk6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeiQKywRitV/hzhc2DKCwca1Km7t7/YSlGxV2yUwmUc=;
 b=XMPpJuPdJaXiEjiFSmwTNTu+oQpDOi/E50OtbOZpd0MdfHeh4YKhDUvqct74XDAzrzD99BUMUq1Lg/7y8g8PDokJ+3NjD7UkaYoZ5upUWS3qpldWsEzD2osbEyk+BhNDJAjTVN/4l5Aezhg9uopoY8yHvIkaqkWgC3tvZ2Xv8gyPJkFAciBodU+Ygfc1F3Dn7E+HrwNAfxXySRB0CokF0RBJcgrSW8ctKZFnrECe8oMuam+qxWfu7TOgqVhXLKRm7exc5VKunAKMYtnBCBgnS1yk9RvHTkKxIoElcHnbppq3OXQGfGFLkQAl3Li6MRvexe/1RdYqoYuYLpFcyIpvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeiQKywRitV/hzhc2DKCwca1Km7t7/YSlGxV2yUwmUc=;
 b=Jk9KPLfgBvwGZvIKy79W6d/IQba6R1A+9nvsiwmwtBBLV8jdqDX0QoIz9YyChgYG4OPopbQ/A2IZnMRBKl8pxvOgjXekBfItJkF/LJxpD85OD0aOS1b5Rf3Hha28NbEbO02sh2DGjAkqdeuGgNXpbHpwiIKmTgLKL8FPhPthSuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 17:12:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 17:12:58 +0000
Message-ID: <945b3be6-3392-4104-aac1-35d460e40cbb@amd.com>
Date: Thu, 23 Oct 2025 12:12:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Shyam-sundar.S-k@amd.com,
 bhelgaas@google.com, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 jdelvare@suse.com, linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux@roeck-us.net,
 naveenkrishna.chatradhi@amd.com, platform-driver-x86@vger.kernel.org,
 suma.hegde@amd.com, tony.luck@intel.com, x86@kernel.org
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
 <20251022011610.60d0ba6e.michal.pecio@gmail.com>
 <20251022133901.GB7243@yaz-khff2.amd.com>
 <20251022173831.671843f4.michal.pecio@gmail.com>
 <20251022160904.GA174761@yaz-khff2.amd.com>
 <20251022181856.0e3cfc92.michal.pecio@gmail.com>
 <20251023135935.GA619807@yaz-khff2.amd.com>
 <20251023170107.0cc70bad.michal.pecio@gmail.com>
 <20251023160906.GA730672@yaz-khff2.amd.com>
 <5764e711-4c3f-4476-9ecb-1f7643e3b60d@amd.com>
 <20251023190644.114bf9f8.michal.pecio@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251023190644.114bf9f8.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cd7500-1bb0-4833-622e-08de125769c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGQyVGREQ2k5Smh0YnZwMW9YdHNXUzM3VE5WaU1wZ2hkWUZCVGdHUytiakFW?=
 =?utf-8?B?L1MyTDVJZGZ5WlRlckNZSW44TnVaSGwxWGFoaFRsM294VDdna1hKZVhmR1FD?=
 =?utf-8?B?NkVXTW5UM3pzb3dqZ2VDelE3QTY2RHlNU2VGRjNObUdONXJjSkgxdmpTamtp?=
 =?utf-8?B?aEhZUUo1d1JReE5NK1lrc1hmazJ3K2pSV3dhb1YvYitVTkFhUHd2TEpteGlG?=
 =?utf-8?B?OE40cm1CQTRUcDZnTVRsK0dab2t5c1lvYlZCZnFrUytMQmJiVENZU1pkVTVW?=
 =?utf-8?B?SFJhV3d3bndqSFBoNFVZaElraVJkVTdHN2RML1VIUFpPZmdhcWhSbFR6cVha?=
 =?utf-8?B?bnByaFAzTzBDYTh6SlBhdGRxekVxRVVvWTNsSDNoc1FrUFRKTXNMOWNMVlhY?=
 =?utf-8?B?dHNQenBHVXprVjUzb0Z5YXRQdG1oUkxvMHBHVEhVa3V2VlZKcW9uckgyRzkr?=
 =?utf-8?B?aENYOXpORXI0NnJNSTgvUXBqSkFVSkEzMk9WdXVaM01SZGhFZzNRQlpKMjAr?=
 =?utf-8?B?alk0dmNvMDRHKzBueWZycHNVZ2wyWnprdFkzbjJtZFhsVDNuRWlHVlcxUTNC?=
 =?utf-8?B?ZlprQk9ubksvUEM4OWxLR0F6SGJjNndsRzNFTUpPY1o1MTh4QTMxRjdBTDh3?=
 =?utf-8?B?bWJDL2M2U2pwQkhMajIxcHNsOXVvVkZvcjhTL0lZNzJJeVBiTWY3VmFOWTZB?=
 =?utf-8?B?dEJHM2RZbFp2eGtocll1YThvc1BWTGJnMWJhbjhabitkWjlhN2ZIUXRTVEpN?=
 =?utf-8?B?UHVySUp2NTZMWjBtL2ZhbUppMGtFSjZSVk9lSXZrT3JlUWNzSXkrMXZNbTVu?=
 =?utf-8?B?dUNoV09yVEw3VzQ4RlRIOGViRzJROXA0MUUrazByRks1T1VQSm85azhxSVFn?=
 =?utf-8?B?SEt5ZzZlTkswNUswWGh6NVhuMlMxWDIxNXpTRU96cFUrWEFjL3AyeDVRQThl?=
 =?utf-8?B?bURlSU9iN3lPbFE1elFXL2pxZVM1QThaNkNGbDVqbGljdUJiMHpCazVIanVS?=
 =?utf-8?B?cVVGYVpwVnJxZlRjL3FPckp6NFpZeGhHeFdDR09HVXIxTkVHUkplYXRUSFF1?=
 =?utf-8?B?d205azVEcFl4S2NlZVhNQllWOC82bXFPM3ZBR1BlS1k2VWdIZm4rMmtkRGxJ?=
 =?utf-8?B?VmFiSGZWakMybHhKck5TTm40L1o2OHNDMXZxNWxaTEx4YUF3NW42a0VTaWZm?=
 =?utf-8?B?TThGYzY4b0x6UFR4UnRDVG10Z3ZNSHZlY09vT1FjbHlyTmltN3FxK2VZZ00x?=
 =?utf-8?B?N2hQcXpMampoNFd6eExWR09FbllkQXJrMEJKanZvZEpFYTd3aSt5L0hoRVB1?=
 =?utf-8?B?RHFPK3U3czZ3b3RHYTdXaURwbzFQODRpZDlpL09PSXFuRG1UVFBYaGlHMVBr?=
 =?utf-8?B?N2t5L3Y2UjY0R25kWWYrKzB0OHNwZnNXQytkLzBIMWd1N3MrS3ZKMmFwTG8r?=
 =?utf-8?B?MVljWVpHMWhQbml2ODlkb2hnRHdoNXFMVTRYaytUNWNla3BKK3dYQXUza3gy?=
 =?utf-8?B?RFBud0NvMmRzRTl2N0NmclA1dXFmVjNhOTJRcm43WHNFVDVRenlkMkkwbmIv?=
 =?utf-8?B?SnJ1RVBnYXk0OGxmaGZxT0Z2MmhhK1NDNzNTZFZ1Si9VdmhpVUVuSlNDR1JE?=
 =?utf-8?B?cGY5ZlUvdkxVQXc1Y0xDWS9mcDgzQTdqYjBDSkFQYlpSbERaVHhtMmJmeUs2?=
 =?utf-8?B?NzRNeW5qbGtpQU93cDZJYlkxd1NQalcrcnJRLzJiWFpJTHVDK1Z0VUxvUHRK?=
 =?utf-8?B?OHZZMU83ZC93ZktHT3p6bytPdC9jeUJ4ME1yOU1EbkN5anZtU2V3RkYwTUVH?=
 =?utf-8?B?NkMrR0FSL2dEUGdXYzdLcjVrVWFhWGxCZE5FZ0VjZEk3VVYzdnllOHJRMFhD?=
 =?utf-8?B?TVIvam9oUzNRdnlidC9RMXhVbk96VnhDMXRMek1nZ2lDWkFoY2dyTEo1M1NN?=
 =?utf-8?Q?++riGI5Qll9xFWtDP8GfL7xO0YPdygJ/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHpWY3FiS2tLRDRnMmlHdDZ6NkRMZGF1aUt6T3pZemZpeDg1NEQxelFRcnpD?=
 =?utf-8?B?UysrVUQyYkVxUHNLUDhRbzJ0Zk5najd3RWg1bUdQRHF1cVJOVWo5VG5OMElE?=
 =?utf-8?B?N0piUVZRSCs0MG1ZVktNZTNXWGc4ZWxhakgzZjMySmIyYXFJOHVvWXBNemxL?=
 =?utf-8?B?d2NwSmtJSmxFWFRIQ3diQmlyVVc5dWNYeGtrZzlkZkxuQ2JIeTRZRTdqQzM3?=
 =?utf-8?B?c3RERURDakpmemhkSTd2cUFXemRTYlFDcHQ4TFA1T1lsYTB4WmtNa1krd1hJ?=
 =?utf-8?B?SitqN21nSmhBcERRZ3l1dEdPRXlEYmphVy9ESmVDK1IzZVZGeit3bEhLVVVT?=
 =?utf-8?B?aVpndnQvN3Y1a0h3VExEMXVua1gzSEE3QUNQa1dnY2loN2JLUnpzSGhyTWdF?=
 =?utf-8?B?ZzQxcmxqS0JGWVRNWWdOWEhadFgzNGF3V21TeS9DTjIxWmZkLzVHOGRBL1lB?=
 =?utf-8?B?dUwxcXh1dEx4WXJJTjk3dERvVS85S29Yb3pyYnBIK3ZBejBaanQ5OEVOVVVy?=
 =?utf-8?B?U3BwSHd0clFUeTRnMmpod1NJQ1YvL1JwS0wyZ2J2cVIzeG1YT1FvNDVpa3RO?=
 =?utf-8?B?QXlVOXpEVGN6RzJPUnZJcnRRazcraER1Y29qTWJ4L1kyVlpIbXBJVWE3UG84?=
 =?utf-8?B?VDJ1THFTMHUxWWlsd0VTZHlpRDBZTytNN3ZGV2FVdWpXTDh2QjZJcStOZGxH?=
 =?utf-8?B?TDBBbjU3Q3oxdVgrS2dGUkp4L1BUdFY5Yjh0NjNlN2MySWtidUwwc3RadXhY?=
 =?utf-8?B?ZDFzTTBoUUpVcWtMOXg0SlRsVG9PSmJHQmxzYXZuSlF4c1ZKVkNNNm8vOHBm?=
 =?utf-8?B?NGhtVU1rTllDYXZoUHNzV0UrRjMyMkdkbXp2WVlFbXhEWjBuc0pxL0RwNWJP?=
 =?utf-8?B?bzJ4UVpuN0FqRjhFWUdndUp2SVFUdEpLS0RGNEZSMU40ckZ4dzJkcEJ1WkRy?=
 =?utf-8?B?NXhxNXFNTGtMcm5aT2lyMWhZa2ZSOWhlUE5EZ2g4MTRhRzl2RGlVZG94NlNq?=
 =?utf-8?B?VTNFaG8yOGFISlExMWY3NERpZHBXR3RlakZ0ME1nOVk0NVNBc3Z0QzRDdks0?=
 =?utf-8?B?R3hYY0FRaTQ5Y3FqOWVIU1daMnpFWmgrYXlNQ1d3enB0SjZVOWg3WE9FeEd3?=
 =?utf-8?B?TkVXVmhoaXY5MXpjQ0lSM0F2SDh0bEp3YjdHMzNDUGQvQk1XcUJQN3d6S0Q4?=
 =?utf-8?B?WHY0K25lbEw5T1hNbFZtOGJYRytOdEZGT1A1K1FOT0cwRlBYcGdicHUyVjlQ?=
 =?utf-8?B?Qnh0c0pCQkJ6L2VsaDN0d013K1JSbXFzOFoxaEVYQ1NGb3EybVlwbzBGQnlm?=
 =?utf-8?B?d2xVcE9OaWdxeVc3THZTL1YxY3gvajZQaVdTaGpDaHNVNGYxV2lVeHNCZVlt?=
 =?utf-8?B?cldzSGVxdnVqcE1IRWNkMGUzT0NFbzlMbFVZT042YThCaUN1TUlnRUpxS1F5?=
 =?utf-8?B?RVdpZ2ZocnI1SUtDR1dZUkswMXNVUmMwWHdIQ2VsTEVheWYvQzB0M2xlelJi?=
 =?utf-8?B?MWh6bXNCL0VvTmhBem9uY0RBZnBMeENuYVhCSzdkWGJQRTI5eFBaaXZMcitP?=
 =?utf-8?B?Z2Exc044b05uQ3AxTXBOTVJrcEFsK3hjMHk0UFdsUmZVYWdJeCswYktyU0FT?=
 =?utf-8?B?azN1dzhMMUd6RUtLMGRjcHFqV3dHcStad0ZDQTV4SEhLMXkxNC92QTNSYko3?=
 =?utf-8?B?T2ZEQnBsZXRzR0ViQTZaQkUyNW1PRFBHaVd6U1V5WEhPTnkrTlhSaHZhUUpv?=
 =?utf-8?B?QXljM3liS01JNjdxZUpyMkRCaGRPM0xzSkRFVW5pTHVRemNDVFFXWFd4amZo?=
 =?utf-8?B?bkVjR0pFRURka1B2RGh6cHpiT0V4R3JnTFF2VUVFNlYyQU9wY09VWXV3aHc4?=
 =?utf-8?B?ZEZHQk8xMUFEM2oxVFBRblgzM2hxVFlxMTF1UG1ld2FvaGZaUTRrTDNkbmFR?=
 =?utf-8?B?SEh6MlhOZ0ZkR3dXSGZLWlN1VmhrbkZoTjVTcDczYW42Z0JLdThhclV1NjBz?=
 =?utf-8?B?c0ZqOUdWekovNXhLVExQN1AxMGsrbTE3OXRjK3ljWVRJOTQzVEJGbzJsR3U1?=
 =?utf-8?B?UXNUUC9rWkdGMFJnWldnTkZCd1JLSWNkMnZIWU43TjJoMVVkdy81V0YzSlA5?=
 =?utf-8?Q?4fzmx+4Ihqd6zJNNf4Nlfu08J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cd7500-1bb0-4833-622e-08de125769c8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 17:12:58.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISWRhTbJBndVphF52tz45rpni3g9pLokR1uC5B7/2MgA/Q0e5c4czM/S3DS+Yki8oyLMa58iAIn+Mpsh2vehqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600

On 10/23/25 12:06 PM, Michal Pecio wrote:
> On Thu, 23 Oct 2025 11:22:29 -0500, Mario Limonciello wrote:
>> As this is an ancient BIOS this reminds me of some related commits:
>>
>> aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
>> a74fabfbd1b70 ("x86/ACPI/boot: Use FADT version to check support for
>> online capable")
>>
>> Does reverting that second one help?
> 
> Not sure if it's worth trying? My BIOS predates the ACPI 6.3 spec by
> several years and (if I understand correctly) MADT revision is 1.
> 
> It seems Yazen guessed right: they list 6 APICs and mark absent ones
> as not enabled. But I don't think we can assume any ACPI 6.3 flags to
> be valid here.
> 
> I wonder if some quick check could recognize those consumer CPUs and
> simply ignore hotplug there? AFAIK it was never a thing on AM3.
> 
> Michal

Oh if the MADT revision is that old, then yeah reverting won't do 
anything here.


