Return-Path: <linux-pci+bounces-4067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A95868535
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 01:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E75B1F22046
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 00:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BBD17F8;
	Tue, 27 Feb 2024 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnIduHn8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157361847;
	Tue, 27 Feb 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995118; cv=fail; b=szMWORSEBDtm4A8UaftUmoC5koA3HBOQaoYQQe4kHvm4upWZaHobv8WWnZo+zQtfpMBaB6/hkX+4D2TpIZIsmdNLyPzEz9Ar9hdSSvmHtW9q1YjcqWhhgnrVASvJAli12gHEknJ1F/vVew+GUifbG5EjN5GpCMYtpQmAAphChxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995118; c=relaxed/simple;
	bh=4LKKZaz3wW5nAbVZH69R3fgso7QNAj0tZObnB95rYZY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qDSgDt05NPdaY09fokw/mUEMsfKK0QH43Dvh0V7W1ihKQ9jYrUjh8Cfj6/ppWNBXbQx1JUiixAk/9F5NYgSC1lTn+5346EqTL4ez4ZOWXuyYy6MqNeOM95kwxbsPr7wkLVMVnyclBpp0DTpRvO7HGAoSqCgtfWy2rEFEMc0FeL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnIduHn8; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708995116; x=1740531116;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4LKKZaz3wW5nAbVZH69R3fgso7QNAj0tZObnB95rYZY=;
  b=fnIduHn8zCalW+VBv0ywFKdAU/n+pn/pcJ2Tom4KZFtSUzfl1Mba8UOU
   AvG3813+SToui+MmRHketszmbvACPztpuFg1KcZw4WyqMxxLy7N0KN94K
   XscILwJ86m6FbR76oPrMlZx2Lrcz1tfcOF9MT0GqT3D8sY09mFHZADAxA
   GC8Zb+Ub0NoRz9mDtVrr8pySzighNXBVlpsFLIkEg/Km9aOkIUOlL7+WR
   daN2FQBLKI2X+2HAg7ZxNfPZUBPmdg7B+CS0vmLsamDpQAxOvMsYz0aZP
   YBquTE1vtID1ZV/3UH5kb+UMOKIlRMoNwlbQQ9Riowqvi90kxijIlobSd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3177746"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3177746"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 16:51:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="44347211"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 16:51:56 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 16:51:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 16:51:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 16:51:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l00pJt+5eOdoQ2K5JYhYPcH9ARMKq4BIQWl1uAKmOG9OTJOoaSUYKkBFwotqJs8jnCBUQ0pDwD8l+ODPjEOApp9s7UBX6l8pTCfhtOlb019SdsAbSeN4u6NNF3CpJjeg60Z/b8o5N1md3ze1AmL85W5/Uu9mH5BY8V2J7BMpZkbRgnKVv95VXuwRpy34CDKGug6NLelDyOlJSp5R/vpd5azj0IwuJOTE4mbsDuEAxApuIVwusZINxORJGsBoFc0r7yh6wR8cAZ+ApJaFLfQTm7IlceqSXsBDx38TQHcMGGlsBqD1FM3u5YB8xC90812QR12Ba9NTcYyElG+/244B6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK7tIbGO1k2zHxYbGBZ0oEKfh///1d53Hm854SE9Fd0=;
 b=lLVaHhf8LAF3OLqorepN10OMv58Xaw/A5IxVHlpbbaJ7VDJb5XPNzXQlNBSlzMfL5HoAxxV91fLrVcwXcfanpmrxvavZWCdbfOQEQ3qbWOtXgjxcgylqoNse21o0N0elkcgExcnI+xukvpozdTAGlVCLRy1qjtHRzWZ6puc5tfUATEb4KVt0W4FNRATjDEMPU4wnrKwdSZ6kj0rpTUgIYr118jptnjBkyWYIRyM6kv3ThQwow2kS1SRS0LWvVElcZ2n7yqri2X3wfvlJZRDJ0u14FwhEs2UpzmfEyU0crVou7rldB5dt+NVND+P1jB5wANlBwTjqYORz+SnUFl95dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7495.namprd11.prod.outlook.com (2603:10b6:510:289::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Tue, 27 Feb
 2024 00:51:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Tue, 27 Feb 2024
 00:51:50 +0000
Date: Mon, 26 Feb 2024 16:51:47 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, <lukas@wunner.de>,
	<Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
Subject: RE: [PATCH kernel v2] pci/doe: Support discovery version
Message-ID: <65dd3223cc108_1138c7294dd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240226033114.3100118-1-aik@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226033114.3100118-1-aik@amd.com>
X-ClientProxiedBy: MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d105bb-18cf-4ee9-d416-08dc372e4834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0O+l2v95ATjmA6I0ot6wwF3mtMVqr8EY9WmyxDeZUvFbpfAf1/QJzA7ZIau00y6k0XxCDJGD/PIAQxxbUh5r3HaMjHohivLy+C9WddhoBG6sAyzyiITXAXcp5CD0WN6iBoQIaJfwXDn5JLqrnCbZBUge/mhD269vj+CN+P1Der1uri6w2rMqutApImL3QhwX6tnFBEALHOtlyq387syfkJdtamySDtesoBQ3xv/TyRhSuhmwWKnmF+AxXLBop/6LcotGUKoeYzJsxc07kFCPBU+ZLZ2ThD6xM1t5cksAV5jgdOkfBzW+dkN8S+dIpaF2OMXz7FqtIxXyKQcHm5aKNo+1LxAkf3l4wC6tuVQS4iQhC/wi1ulNPZRFiML4VBlTrM9y7xvAQZ+HKwpuPWE4JB3+7y39PFPzuJXjzObhT+0QP8mEQeaz4ohFJlUKxl1udhYzMMx7cUkIZupPxi5Q7qeuZ28MF+XpG/mJPGmCirCrDgWXFRajVoPFRTElzL4F6XIEPtW23XxWg0H1cWlNlLzl2lDiYDRnxpdKkMhaNTmRGxqV2rL7BItRdhcTRcycZYZYCKnADfGahIWNOmEeJ4cAHTodKfUNLy76oFgVcmZwXBHJq9aFb6uJ1cQZ18yJAWRnhog7zWEQUTGntOWt5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVlyYThJaFd4a0pqQzJMaTE0TXZySDFzamNmTkRSQ3RTZlFiTVBEdGFqWThI?=
 =?utf-8?B?eWxDSGluaVlSbHN0R2M2dHc0RlVxSTdLV0ZvQ0p5aGhmdE5ZbEFqM0RhalQ3?=
 =?utf-8?B?MXJkcUxwVlVPUVdvV2pkWWNhZTVXUERETTNWczR6djBadmxDdG9sOXN6NWV3?=
 =?utf-8?B?TXd0TzhtM3BSVW1xSFdoZlVFK0hZbjlCT3h1alF4ZUxWQ3gvYXFmRGhkOFA2?=
 =?utf-8?B?aG16eWVzUmhMOWdQc3E1d09vZlNmK3dEYkppV1VpbXU1NTRUQUdoeGNIN3Ux?=
 =?utf-8?B?RVBCQUk0WmJHUDdnOU5ucnpIYlJKM2RJL0hJSFo5V2lGMFNQekoybklCNkZG?=
 =?utf-8?B?b2NxL2pmbW9iOEt5Q1VCUjdYcUFMblZPZnpxbngwNWJrMHFoVlZyd003QXNH?=
 =?utf-8?B?Q0NmNE9EQWdTM0Z0TXJ0VmJQQ084QnNOQjJkNmRLWS93NWhpZXFRZXNNUjk4?=
 =?utf-8?B?aFVDRFl2OEFBUnNFVjVSSnpqZzlUMDFqMkNrZmw4cjJCT0p2UzQrNzhtVytG?=
 =?utf-8?B?VmhPSWl6bmdxb2U5SFdvWWd5dmN6SmFjOWNxb0hQOWZrejRVVU5lUDFRZ2VM?=
 =?utf-8?B?WkY0QldQUmNDdzczMUNSbmZ4ODVqRUtEQnhtTytHK3g0K1JhcmIrZVZYMWNj?=
 =?utf-8?B?QTlTL0xOVzBXdlpsT1loNUFzTVhDcXYvd3dTNDMvbG5ZZ2VKNjRsWVZucldt?=
 =?utf-8?B?OHdWd2NJeFJwRGIxaWUvNTJlaHV6cWlyK2p1ZnZ2Wko5OFBpVmFzNUZSdEtW?=
 =?utf-8?B?MXQ3MVM0SGQrM0dheDBxc2lQUGh5TmZQbGZBbTRYcy93NzhCcFM0ZXk5d21U?=
 =?utf-8?B?ajBTRDJ6KzNlcXVWQjh2dXppb0J0bTBzTmw2OHFpY0ZzMWVlYlV2SHdwVzdH?=
 =?utf-8?B?dVdTYThFbWpyelB5M1doRE1IVURaeHBtTGwrZ2NjQ0Q3eHZWNjJNU0UzRktT?=
 =?utf-8?B?TGRvSlRhMDBveGE3YXFwRHlZdkZQaXJmd2hESG51bks5MFc3S1MrMVBGTG1t?=
 =?utf-8?B?RnI0QVZpZS9HUC8vbHFlQXB4ZUFycE1NUUxpUmFEelZBMEgzK1lDbnRqNVBX?=
 =?utf-8?B?MXhDQWdQLzZoZTAwakhmMWZTSHV3ZytuVnRTSEM3RVJOL0xKNktMdURSTlRU?=
 =?utf-8?B?VDNtdStCNmJhMzhGa2ZRT3FKWU5KLzJtejJuUGlaLzkzL3BQejczWVFoZm45?=
 =?utf-8?B?dVgrWlJWNWFvU1RnQzlDL3UveWJIeUdITXB3M2k1eDdZM3liaTZlcTF6dHFn?=
 =?utf-8?B?REJZZ3dsaWZNODdqemRrNVpyYVhRRFNEY3FoZmZCVm5mL3J2LzQreWJINDMv?=
 =?utf-8?B?K3AzekE5bWJDUU5uUk5zUEt4bW0yd0ZyS2ZTQzBFR0JRUHZBWGNTaGczVmhU?=
 =?utf-8?B?N1Zrd0Exd3MraFRDQXZ1UndibllyaC8xWUZ5TThMT1VEMXBPczhxOFlZUktV?=
 =?utf-8?B?clQveHdVQXk0Z1ptOExob3M2cnVzemR5QTlYUUtOYk02bG9McmdZTDY1Z3I0?=
 =?utf-8?B?KzBSdW1WajE4ZmQxQkxyVWhLUS94dUZrM3kyaG9jZW1Ob1JQUWppR0p3SEFH?=
 =?utf-8?B?RHQrdGdGcmU4K29pTHFQWWlnY1pxY2psKzB2b3JvQjBHSkJNWHI3UUdSbU1O?=
 =?utf-8?B?RG5Id0VVdUNVYWdyK0VQODZ3bjkzckZicVhYVjhFZ2NKd1RTNk1INlZpY1RO?=
 =?utf-8?B?WHdmZDVRbWFURFNkVDgveDhiRUN5UE1zUEdEeE9iQ1U5MSs2WHdVTUNhdmlG?=
 =?utf-8?B?UUhuNkFMajM2MkxOTElXYkhBT2lZSmhqYjBjZ0p5SE8wNU9GcjRYMWE2SDcv?=
 =?utf-8?B?Vm1MNlhqVFRVaXVmUmVpT2tZL0JFdzZrVll4a1VmOXZwblBaSEhnSXpoRHF4?=
 =?utf-8?B?cVFJYVBYaGV5QkMwWERhZEF4RU1hNXNONTBaVGVTcFZVOEticEp0dUt5eGNJ?=
 =?utf-8?B?ejJoT3N0STBRVkd5ZlNXS2Z4clZSZW9lNFBiZ1RDZ3h0dlkxKzZBdHZuWHRy?=
 =?utf-8?B?KzRhTFhHeEhNcFYwamlPK0RXc1gzVkh6RlRrejVMWlNRQlpNelZzMmZTY2hV?=
 =?utf-8?B?L1NRSzExZCtKb3RndnVlcmUxVHorN2ZjbTRuSEpaMHBKMHpDZHRkaFVKOFBG?=
 =?utf-8?B?dHJ4eHJ3RFE4OWVGL01KM1hYVXBrRE9mbnA5ZHhPTEZ0SkZwMTVDWFZCSUVC?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d105bb-18cf-4ee9-d416-08dc372e4834
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 00:51:50.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXef9AcXo9PbLyfXJ/dsBXhtkMKMl9Q+SxQJFalxl2DOOuOuIBgrzrdG1buIOtPailcow8s9aVTufQjAGEJ0WK2uAeyMBMpyXErUS+Mhnas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7495
X-OriginatorOrg: intel.com

[ add get_maintainer --git-blame folks to Cc ]

Alexey Kardashevskiy wrote:
> PCIe r6.1, sec 6.30.1.1 defines a "DOE Discovery Version" field in
> the DOE Discovery Request Data Object Contents (3rd DW) as:
> 
> 15:8 DOE Discovery Version – must be 02h if the Capability Version in
> the Data Object Exchange Extended Capability is 02h or greater.
> 
> Add support for the version on devices with the DOE v2 capability.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>

Hey Alexey,

I notice that get_maintainer.pl by default only mentions Bjorn and
linux-pci to Cc on touches to drivers/pci/doe.c, but can you include all
the other folks that have worked on PCI DOE going forward? Same requiest
for SPDM and or anything else TSM related.

$ ./scripts/get_maintainer.pl --git-blame drivers/pci/doe.c 
Bjorn Helgaas <bhelgaas@google.com> (supporter:PCI SUBSYSTEM,modified commits:11/12=92%)
Dan Williams <dan.j.williams@intel.com> (modified commits:15/12=100%)
Lukas Wunner <lukas@wunner.de> (modified commits:11/12=92%)
Jonathan Cameron <Jonathan.Cameron@huawei.com> (modified commits:11/12=92%)
Ira Weiny <ira.weiny@intel.com> (modified commits:8/12=67%)
linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Yes, in general "./scripts/get_maintainer.pl --git-blame", is too
chatty, but not for new code areas like this.

