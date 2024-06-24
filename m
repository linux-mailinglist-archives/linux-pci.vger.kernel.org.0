Return-Path: <linux-pci+bounces-9191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E487915132
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B2D1C23CEB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E119B3DD;
	Mon, 24 Jun 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4uAj0npH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911219B3C4;
	Mon, 24 Jun 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241091; cv=fail; b=P7z5mdlF3+UCzqhi82Ja55iCrjNuOu/V6ygHEh7QMiQuAKTqAv1ql3nCTzNyPyA9gIusnFfKTAXq+x6LR96hI/e2PbwiLYTWk9UQdu1d8ZsubvEaNotNisCFe2Y3G3LSXzTmjssu1eMiR+hEJyJZlRQ5UkCxG+ZOx9WRZb7nbaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241091; c=relaxed/simple;
	bh=sFNDdVgEKACp8cl0Eue2qEWyjU6rhc68y6C4BB3nqPQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oxDtZ8zLson1tLBb8ypYE4HEzsPjPB+YzoSjTGt6e6MQg4j9VAnvNbX+wiEqg3BzQly9oydK7KAPPF/Pa/3TjB1yOBcjxrWWYPApDQAMiYedlianF6W9jXIgy3jBTWlU6hR240P1m7R4WrWrxNVFmFvPpBhCxq3xm+SafsAzMw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4uAj0npH; arc=fail smtp.client-ip=40.107.101.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tsb74Do05/vBuIzFhhpY9Vwfm3mI0BsjZBFWYb0ppCGVlgBDU+I+oOdNPT9losXLT8O6IVRE7UT0yLRKtswLOMPvojkLmmobmMGLu4pCQE7abf1XXPV01iV+pyk8WmssrzROtT/9W++TFnMpXFMskardCMRDR3/RK2qzSnyUfdjQsb3O9smjsJRWHLAG8KBqko/0L5hEKVBUEhr82xlSh9PmEnFiwX0z360l+nEjqaZTCVFZqWnSk6Eon8/zDQgafh4+ett9lFnJxVZxH5UVMaswxJCClTvlnFIQwJmbsDE6+5hJEWCsjNHojGQX7ySgXFt3pll1teBbj6H5p3Xipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d77xWLKFXAEoEuzbH3oRL/viJUml0HhZbOJIYy3sfXo=;
 b=Mi0LCl4cg5zYg/aqoMwrpHQJ3ILDGiXN/L1gIMSPxjCxWIXGixkRuuHXEfslUT4NPM1DM61h0DUJ7ozsFazWy3H5sUubCadh+UnKIyHCE/KCrC94dBZuull7oRdmYcf37HdT7TBQwd3EFVgG2kYM3vhTvGpnEQClwbr7ZJcsqgS6EYhn0sn282U/WLExwiChy9pna9SeVvClocFnSFVBRf5t+0Kn8MRXDpHdg2+Pd/Gvx7HPdpMirgAkcV/nZ3ONONkAXznFPtDtXbADhaP9FpfUS38YRZ1E/KFbxh7XGodBZZKqUQVn6gFZQYFQ3sUzPo8VcY7LfSyfBTuFgGoKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d77xWLKFXAEoEuzbH3oRL/viJUml0HhZbOJIYy3sfXo=;
 b=4uAj0npH9yDrvBmtztbSWfY7J5PEmJPcJOQPiHKeimYXTe75fv+pbmgF3G0jJQ3B4AxMzc8mHjUG1CLceWUZZUCk0b/EFadW+Ozu+gq5FBL7sMde6oNALFztC0aMwblIoLU0uKZbrxQGe8KTEltxAZ6KpaFc3x+y/ki/L4/r+6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 14:58:05 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:58:05 +0000
Message-ID: <49673ec5-b1dc-4544-935f-650cb9f3d112@amd.com>
Date: Mon, 24 Jun 2024 09:58:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/9] PCI/AER: Update AER driver to call root port and
 downstream port UCE handlers
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, ming4.li@intel.com,
 vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-2-terry.bowman@amd.com>
 <20240620122144.00000faa@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240620122144.00000faa@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:806:f3::32) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5d03e1-1665-493c-2711-08dc945e0d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDh0eUhDc011MjU3S1FHaUxGNGhVRVZaTWFkRVM0Nng0VTVQVUV6RDlpRmdT?=
 =?utf-8?B?TzNjcWZQYjgrNTMzMHFwcVA5U0xZZThaTHNGTmVhWDRLRHphUG1YdnlXRjJk?=
 =?utf-8?B?a2pYNzUrOVhxWHM5bGpjdWlDWGZ5aTZmYUZQNGhmbGlMVXdDak1uanJhUmxH?=
 =?utf-8?B?SkErUlhOWUZGSXYwdWdHbTZZZ1NuRjdrbURGM0UzOElHVFNoUktlOWE5b0p0?=
 =?utf-8?B?QVAvNWI1OHlRMGVMT2NXaXhkT0xoKzZSMUJlTk85RFNRakUvNnUrUW5hYkp2?=
 =?utf-8?B?YkdVWmVITjhGME5lYnErNlgyN01XcGEvQlJVT0lxRFJyUENZclhvNzJDeTlh?=
 =?utf-8?B?aWY2N25CRkVDOEh6c3VlUXI0QzlPd3E2MHd2VVdtdGJtNkxwREFtT3RubkVY?=
 =?utf-8?B?UnFROUFlWWo0V3U1bFRGSEhuS01pRVgwL3oxVWg1aE1Fb3pRSUg0TnIvbGxj?=
 =?utf-8?B?NktPcUZtbGxNemVsRFhyS1FTRmJSdDAyV3pNS3NYSlMzRGlOVGJKM2tQd0o0?=
 =?utf-8?B?SmRscmRzaHZYUHR2cUcyaFJ2MEI2QktGK3VzazdjTW5IVnRqOGJkNS9PVmNi?=
 =?utf-8?B?RXJxWm1rMk13TEFlbFMxdGFVOXB3S3p5YndoUmpxZnRpZSsyTFRIeU9wcTdz?=
 =?utf-8?B?UlR3UFVNc0VIYkpGRnZwVE80RkRPczV3SVkxN0szUHJLRCtxM3I4YXlhNytV?=
 =?utf-8?B?WXZGWUhLTnJWVHZGTmRSZWRlcmZSSVo4bVFhK0RieFJvNkhlSlBLUTloTWlV?=
 =?utf-8?B?M3BUazYxc1dMTklxUlVTbnFDc3RFK0ppU1hzNkdCZldCbXNUZWc5OVZSNTJD?=
 =?utf-8?B?bUlhQytvTTQvdzJuR2h1OXcxT0hJRDE3cE9EWnZnM2NhS2hMeW5RdFI2Z1FO?=
 =?utf-8?B?RW1waHNPOHdtb25kUzhZdTVqTlkzYVdRcUxJVHRESHBpZ2hWUTN3d3gzRUJR?=
 =?utf-8?B?VzlxbjA4Z3loTDZqWEl2VkpON1RhSTlWSEJrdVlyREs1ZW1oWUJEWXp6T0wr?=
 =?utf-8?B?bXpsTDZsY1JBN3FnbDc4T3Rmanh6VDYrek9QVW9Sb3RhaTlsamM3amlRTTFG?=
 =?utf-8?B?Y1NSSE5xZ2tXbTMyVklVYWtaaHJndkpVMHhXbndCNW93anY2aHZWRkVpRUNa?=
 =?utf-8?B?NmVRdmg1NW1IWUlzZkViL2JoWFczOEhueFpOb0g1VDdYak84QWVvK09CZ09i?=
 =?utf-8?B?WlowcnhiajNNNDZ4Zk90ZEszbUhBbnBXaGZ6NzY3UHhxeEF1MnpneUw0ZHZr?=
 =?utf-8?B?aVVqV25saVBkVFlOMkc1emNDdSt2QlFJU0VFbE1SRExZWUlpazdhVk1relZp?=
 =?utf-8?B?MFdWOVdTVnN5YUdxOTluSkVIbDZqZVhYNnQ4MW85blRkWUU4RE9sa3VXbFhW?=
 =?utf-8?B?TThTSGhiNXV5cERsaUpsdHROb2w4eW51b3NyOVNQUUhIUSsxcTFnOGxnVDh6?=
 =?utf-8?B?V0dpc0lXL1FWSktoU3hFM0h2cDRwRlhCVjhLNTFBcmR4ci9BT0xzZzRjRUVQ?=
 =?utf-8?B?aFNoMGQ2RmFjY09jQzY0SmFoY2dObjdnZWpVUWo3ZG1vWXArZVFDWk1GR0VI?=
 =?utf-8?B?aVZJUFhUbkl5MjJXOCs5Ukg4bDZLVnJmTllMeGF3R09xNGc3VkErbFRxdi9O?=
 =?utf-8?B?TUl0OE1ZMytLZjA1akp6N21kdlc2bGV5TU9VQWI4bmo3eXRwYzFCanUvQ1Np?=
 =?utf-8?B?YWo3Z05IOWVUZkNvajJXWmVlSVFvb0ZUcVhZLzhlczNRZzkvMkgvaU9BaUFI?=
 =?utf-8?Q?k+rrUf4XMA5+HgCFIw8eRbdRBCLrLmWEzLq+HRv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXArR2ZXTEhFck9QWlJ1L1VrV2hUbDJGazJDNkVlU1RUMUpmMGl6YmZRQjlT?=
 =?utf-8?B?YjAyNFVvUEhrMXR1ejlKWko1TkpnbWVhN1lxeDJuN1g3WTExaGU3cVNSTjcr?=
 =?utf-8?B?dkErN3NhYVN0aHhwZksyVTcycW1VVUVML0R1UzR6NlliNjFRd04rUENVVDlI?=
 =?utf-8?B?d1dtWGJ2QlZydnhvYzhxZEQzK3pZZEVKd2FYdytobzRCQXlmckcvNUEwc0tx?=
 =?utf-8?B?M3RPMzF4ZXlzMlJVTFR3MEhyYzBta3MxeHQ0S3RUWS9pak1iSmpsUjZHLzJ1?=
 =?utf-8?B?VUZjcmRQWUpxYnhZUG4vMFRDTHo3S0FRaTZmRDJSWXNLNm5NQUxhV25xZURh?=
 =?utf-8?B?L3gxRlVQMEtlU1RoS3NrcGEvR3hWbm1lV1RwWW9UVWplZXZCV2JDT2NsSFAv?=
 =?utf-8?B?ay92RVRvVTB0SXVTUEdhVUpITW1lSXVQUWNMNlpaZ0NSRjM4V2RtZDE5OTF3?=
 =?utf-8?B?R2NwdVBrZGFwdlJKUTZtS0w0RG9ZeXJTbWNQQXdrZDZ1QURaMDE2OWc3cm9r?=
 =?utf-8?B?MHRDbnA4N0FFQjRyRCtpVzhnTWFaVDkzdlp3R3dPNm1XZnZrcThzbTBlU2Nw?=
 =?utf-8?B?TUhlZVdTUFR6Ti9tc3RlQUl2VUhzdllmUHNobTYvOHRlY2ZoNm4vakhmNDVM?=
 =?utf-8?B?T1FueER6WDNWbnVEUHAxN3VZV3RENHVZc2syeTlqeStuSUx3VDNLU1ZXNytJ?=
 =?utf-8?B?YXJJSHdibkhMazUzR2NSQnBpdnBhTWdCYitTcTJhK29VVEdxc3N6WVdydDI4?=
 =?utf-8?B?VXJDL2NPVVVzcW5VdDRCbUF2RlFXdWRPWGMrRDl5ellLNnE4ZUY0THI3dFJo?=
 =?utf-8?B?NzZTalpkSzZjRG0rYytHbzZkOUsva2RGdXB0eEo2YklNY2lEZjNwUTZyUTRS?=
 =?utf-8?B?TFRjTVNjb1h5Y3B2UWRCV0xnNndUaWZ2bjFIUkt1OHdYVFY4di9uRHZXaWJN?=
 =?utf-8?B?NXdJR3N5cmZKMnRsSndCMXdTNW1lSkNCN3FFWWxCVnV3MTJsNmcxWEFKeWt2?=
 =?utf-8?B?dHNmOGFWZ011SzhoUnBSdmZnWGJwVkNWSUg5U2t1d1VmMUF3Y3NkVDI0Rzlu?=
 =?utf-8?B?NElsVHcrT1d6V1FsNDJiUjJVL3hPdHdWakdBZzgxMDdBWFJKQVhDTm1JekVy?=
 =?utf-8?B?eHJidllOUDVSQ0c2SmdnTUxMeWtBVVlGUkdNTGZZdTFnTm9qdWVGbEhUMXhi?=
 =?utf-8?B?cy9LMUdOc3N5ZzJKTjdSR1dGR1NWUHRTelJsZXpJRklFa1ZNaUFvVXgyM2ZO?=
 =?utf-8?B?QWY0VFptaVUyNm43bVpIamMySWlIQ0Yydy9mZG55NEtQemZXRURINllvZ1JY?=
 =?utf-8?B?eTdxS20weFI0Q1BxeDVTQjFQZ0k1L2NGRlphY05NSlhSci9pYndLOC9Ldk5G?=
 =?utf-8?B?LzRmTnJmbnJGSGd5dFR0TTlzOTJHY1BPYVlqVTVjTGdpVitjWWlKVHlqRnhq?=
 =?utf-8?B?ay9qN0NRVms3QWJUQWxWYmg1aVNDUk80ZXRsNEhRQm80VWZMTXVQbEhnQ3Jo?=
 =?utf-8?B?MTZ3bHI3aHZFQ2VYekViZS8yNkl6bXJLRXNubmRld1J4NmZCVjNIc2ZVdWxR?=
 =?utf-8?B?M0V2QVloQVNvWkZkZ0pHZ3ZYeXlHa2ZHMTZ1THpRQ2tUdnhmV3dXeFlBWlBy?=
 =?utf-8?B?dGQ4eGIvOEx1WnVXQ1BpeWkrOGY4S0VQNUFoc2xsN0RtVGYvdUdhTDE2NzBD?=
 =?utf-8?B?MEtLNjk5dDNwdzRUTDBlcEY5aTFGZnhNN1BhWmRzcHJ3U1RBUkcvRXpFcWZk?=
 =?utf-8?B?a1pRSHpVMTc5R2pYMHFPSUF3WWZSUDZlVllzMDhzK09md091eHpmTHBsOUFB?=
 =?utf-8?B?SldRdXdsbjMyd3RvRmNDS2xIU1k2d2ZxM0w1QStWMG5EVllCV3hjK28rZUtj?=
 =?utf-8?B?QTBKRHNxUmxhd1FXZXhJcFVPTnQyVkhpZ2tJZ29qZlU5TURxN2Z5dk56UXlN?=
 =?utf-8?B?ckRyVGcyWUpGdm9vcytQaTdQSmh2MmhhZ245R25OdEVMaG9jZW45ZDFtZUVa?=
 =?utf-8?B?SVljbzF3bDErWndiNzZndU5QNk12TnpEYldvMjBMajIvTWtOc1pVVzFOWThI?=
 =?utf-8?B?L0x6MjV0STJFbXRBdVFFU3RLMlpKSDdJby95L2Vnbmcyc0ZybnhFU1lHQlBh?=
 =?utf-8?Q?ZxDXB8iykGTCABPS9K1D0jIhJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5d03e1-1665-493c-2711-08dc945e0d57
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:58:05.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgJ0naY+XGojXEWX5PGZ53t3u0scM8RKejkpKCAEKreD+Rcs8jL7sh4vCg/KnXVfFQV0a0PuHclWl99ICdNQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

Hi Jonathan,
I added a response below.

On 6/20/24 06:21, Jonathan Cameron wrote:
> On Mon, 17 Jun 2024 15:04:03 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The AER service driver does not currently call a handler for AER
>> uncorrectable errors (UCE) detected in root ports or downstream
>> ports. This is not needed in most cases because common PCIe port
>> functionality is handled by portdrv service drivers.
>>
>> CXL root ports include CXL specific RAS registers that need logging
>> before starting do_recovery() in the UCE case.
>>
>> Update the AER service driver to call the UCE handler for root ports
>> and downstream ports. These PCIe port devices are bound to the portdrv
>> driver that includes a CE and UCE handler to be called.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> ---
>>  drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 705893b5f7b0..a4db474b2be5 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -203,6 +203,26 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>>  
>> +	/*
>> +	 * PCIe ports may include functionality beyond the standard
>> +	 * extended port capabilities. This may present a need to log and
>> +	 * handle errors not addressed in this driver. Examples are CXL
>> +	 * root ports and CXL downstream switch ports using AER UIE to
>> +	 * indicate CXL UCE RAS protocol errors.
>> +	 */
>> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>> +	    type == PCI_EXP_TYPE_DOWNSTREAM) {
>> +		struct pci_driver *pdrv = dev->driver;
>> +
>> +		if (pdrv && pdrv->err_handler &&
>> +		    pdrv->err_handler->error_detected) {
>> +			const struct pci_error_handlers *err_handler;
>> +
>> +			err_handler = pdrv->err_handler;
>> +			status = err_handler->error_detected(dev, state);
> 
> This status is going to get overridden by one of the pci_walk_bridge()
> calls.  Should it be kept around and acted on, or dropped silently?
> (I'd guess no for silent!).
> 

It should be used later.

According to PCI spec "The only method of recovering from an Uncorrectable
Internal Error is reset or hardware replacement."

I need to make certain that carries through below.

Regards,
Terry

>> +		}
>> +	}
>> +
>>  	/*
>>  	 * If the error was detected by a Root Port, Downstream Port, RCEC,
>>  	 * or RCiEP, recovery runs on the device itself.  For Ports, that
> 

