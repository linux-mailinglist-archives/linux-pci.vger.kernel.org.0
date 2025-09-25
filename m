Return-Path: <linux-pci+bounces-37060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA3CBA1E71
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 01:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78D23AE4F5
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 23:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73401EFFB2;
	Thu, 25 Sep 2025 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmDtjqkt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015738DDB
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841255; cv=fail; b=DjSxeNuEgDwniPNASrrYAeJhIT+UIFsdjD5YSQqmy8tjVNAn40k3Ku2275eS46xKImnFfep88daf9kxktv+kfPUkYXkbcFweuGm3JxBxY4Uey+hcRbwpolJS1cY+Eot3fnIB47l3fXeSV7xLl0l+RfqF9Pv+13o/yfN4ArFxE00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841255; c=relaxed/simple;
	bh=9rXLXsMmiCesFmUMA75YbWHHctBXCD6Zzk8Tjs6mhlE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=K4T1aaY1tpK7uV+YG8jcssk8wI+XSOdM5WAepJ2R/z4H4dLyiUIwDmjwO2knCk273NdGn/jd/vIOwQleZ6crXYNNkHzStO19OF8WghS5djbplZADp6PnLDf1U54KH5S2PAbDIkl4dygcSGSkrKFXFHgCQT7ygFzYSLsla7ZEDKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmDtjqkt; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758841254; x=1790377254;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=9rXLXsMmiCesFmUMA75YbWHHctBXCD6Zzk8Tjs6mhlE=;
  b=UmDtjqktojEzcGnxEBhPi8V2wac/g8OdrHb7GLMCrO7SA+ZAYmBmLUq6
   IWZEPBbWc+qNCNGjJOjhV8yPHzVt4oPlN4V0ZDIhOHH/lBju7TNswLPGB
   AXwsUDLpDLGqvZra86aogGn0L3H1IfsY1CDwq6gwoN045Jc6YpO4riKtF
   9gGEIgsr15fJX9BOi+sngV7l6jNTTCh6GTLIxSGm07XQyUZsQXudpoiep
   gigW1AC+Mmvzx9D7dl5eQtbpouHTlYTkMXzfAVA0tb6ZRhjia3mWn51n8
   IBPJCsW100Nd3WQq0HaGEb2r8IFBdpgc7FQCUaV3JVTcSElSdZjVywb+t
   g==;
X-CSE-ConnectionGUID: QiNLOhveT3m7i7wYrsXxSw==
X-CSE-MsgGUID: qt5jNJfGSwOC6F7dsZvWIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61226021"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61226021"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 16:00:54 -0700
X-CSE-ConnectionGUID: 6uNMOdvXRh69q/MdpbSHJA==
X-CSE-MsgGUID: sMTjJaPdRYOIEAiddSwU9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="182622215"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 16:00:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 16:00:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 16:00:52 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.44)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 16:00:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOTkUjNl7zap3CqY0E4zXrFK29riIYQb1ASSJmAiyDIux/6+WZAM45XUpHatCRzd6pX7g1H1aca8dv2Qa/nbXQQBRdak+6Wi9Rdz2VJFecWWHewdRbhnfYs9btrJP3+Ti7eu4+0gJSfNUrURlXBBWOx0T8/tzyirAwfoaQgk0NW8C0RaRjkZRHVflRreMxv+qKpi1EGuhheoqz1/ZhDHcic14m2qXQIj8i1Uap0x4b3dOPQQ3tPQVP+clcgtN6YPnFnGOa2dvKTx42Eapa3pNxZBTAfjisn0kMSZm6FhQi6JfYKtKq+TCAlQJ6nugfTExTkz5XCMP7muPLn4Smdc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKdgxqNKHFK7TvmV8ZZitwMCoJF1lgkiKDUntYDOQig=;
 b=vKFtEMFi16XRKxX3HbpmIgRbD70dx0JHr1tde2Nvb3KrnW1WRiWiMwg0xY/2czYUymzrpjeHatSV1o1zynldEAsHWeIRuDgeFiyQ8DpwtdMjJA+5wWmcdEcz7BYJp47Qq+WGicoKe1ub3Io5493Gt6QlP9yfSv13kQTJcsgt+MhQDDARu+LTxF5H6f54Z+25hS5nVyqHVk1O5czb9nZAuhTqc6ZsvTw9pgEGe/h8Eg6rdtf9PQfKHHW0JlxSBxdx+/X3F1IoAD5TGzuDqwqoLliu3/Nyn+kZq1yjSg8E/hjnbbnJ5vByUDmKL6gZohYMTv3DVp3e6fXKJW8Z4mH7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 23:00:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 23:00:49 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 25 Sep 2025 16:00:47 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <68d5c99fbb056_1c7910082@dwillia2-mobl4.notmuch>
In-Reply-To: <b99b2951-9f09-4f9d-a132-f05ab1f8928f@amd.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
 <20250911235647.3248419-5-dan.j.williams@intel.com>
 <22cbe028-c1ad-456f-a046-12b4559394b4@amd.com>
 <68cdb9f271b46_2dc01001e@dwillia2-mobl4.notmuch>
 <b99b2951-9f09-4f9d-a132-f05ab1f8928f@amd.com>
Subject: Re: [PATCH resend v6 04/10] PCI/TSM: Authenticate devices via
 platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 395cd3ab-d65f-4625-5e65-08ddfc875e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjJXL1NDWERTakNmWEM4aTZFdkFZMlRvR2FyVERBbWJVb3FnNDBLUUNWc0hy?=
 =?utf-8?B?dCtsdllHZWxsREIvMUMvaVhwYUdXczZiMzhDQklrSnNUTm1uTHVkT29sblAw?=
 =?utf-8?B?Zm5Da2hVYVlWRWZxVEViYWppYWFmMmszNmg3eHJEcUQ1ekRQWnBHMWhpNlZ6?=
 =?utf-8?B?QlJ6V3Vtekw4UnNBQ2lpMllSTm1NN1F3QjQwRURhLzF3M1VKRTZOZGVUaFcr?=
 =?utf-8?B?TUdtMTVnQ3ZITUJnWTdVdHdXM25JTDVXYVprQnc1MzExZWVFdnJLQkNZczN0?=
 =?utf-8?B?Qmd2dkhxbk5rY2diVDNrZXQ4aVJSbDRHM1NPMjZtbk9rREdLTk9oaGZxeVJV?=
 =?utf-8?B?WXFwVkRSTjJrUDhrTlkvNzVPWStGeGlZVUpyMm16WWF1MENYLzdxOWl2RW1R?=
 =?utf-8?B?b2xPalArTXM1SlBSbG1LcFVyL1QrTHdvSW9YSmd4cXFwdWJPZ2ZiWjEwVFdV?=
 =?utf-8?B?VzlHSEJIdHFUR0YyUkVDMEFzNk0yNm5SOExXNDQrcjIrQm9MMWNrMFVhZnha?=
 =?utf-8?B?cktqNHBJd21hNFBIVzZ1RGJCQXFwRVpKZEVqZVNGM2dBVzJMTGwxZlQvaGl0?=
 =?utf-8?B?ZEJWTi9aSE5xdkxCb04yYm9PZ0dqcVN1NmJCdGx3T2R3Tzh2QVVpcXoreE5r?=
 =?utf-8?B?ZnVXK25FaWgwOGZWOGNBSGNxTmhCZmkwbFhIcUNwak5qYWQ1RTBRa1EvWTJO?=
 =?utf-8?B?UUZhZjY2cW15TEtPSCsybjQzcHdvajlJclgrMXlIMHBCWk9CdEVLVitFaUN6?=
 =?utf-8?B?dW9IbGM2cjRkUSt4K2lyMUdQdVIxelloZXVqRUV0RWg4YUxWN042ZDVxWjhR?=
 =?utf-8?B?OGpDVnJ5UXhZTGNaMXR5eEJIS1kya1dNb2Ztb3NDNUNlZWdLZW0yLzVIajFy?=
 =?utf-8?B?bDIrQ0ZpMGltejY2ZXc5SlFOY3g4bDBWTTYveVFkVUlSWHNWY0NtV0wremYw?=
 =?utf-8?B?cHB2NTFpNmNsNFVZcDQzMmxtS2luSERyWmZJWlNOb1U3eFlJTTY1UytkVVdX?=
 =?utf-8?B?aW1obCt6MU1IdWMwU2l6R1dzSmFCUkJMV0xpV1FSWnd0TGtOSFI0YVVRdWJE?=
 =?utf-8?B?c1BzWkVDUFF4S2RyMk1hWndCT1VkQWRNS2lzUEprZXpCNGlRRExyVUNsdWRT?=
 =?utf-8?B?S3RodkVkcEJJdVJOVENrT2MzTzVtcmZDdmlIZVNuYmMvemFFQ2VDcm1tempu?=
 =?utf-8?B?QW9EZmQ4Rkg4Qk43WWs4TWIzRFRSZ1FyN3JFTUMxMUhYMjNwUlBYWVhQU1RK?=
 =?utf-8?B?bmVMTkxRWC9QeE1kRm0rcnd1MXRTTFlhME9DL0Z0dGZNaWFlTC8vOEg1YWNQ?=
 =?utf-8?B?S3dYUHAxVUwzZGVDazJJRDZzb3laQW8ySGdWblY3S0djQVQ4aXltRFJ5Tm1u?=
 =?utf-8?B?b01tQ0QwRnRGWE9Id3pjQ2dyTHN0MHJ0SGx6YVVPaVpSM1g2cEtwS0J1azVl?=
 =?utf-8?B?eVJaNTFhSWJGLy9kZWx3RHhMTjN5dnBnWE5DcVp4Y2VZa1MwSUtjM1B2QWRW?=
 =?utf-8?B?dmV5R2U2VFJaSEw2TC9Pa0VoblplQ3JFSVppVllITmlWOTlDcktvN0VrRU1F?=
 =?utf-8?B?bjNVT2NvUlRGY3c2aU85QjdFWXB3UmdScGhLR2QxUHBPVjc0c0dSSS9vdWRl?=
 =?utf-8?B?ckd3aDBNcklycXlDb1lPNktWNUMrUVpQZ011Z0RXNnR4SmU3R25SRUxXU2Vu?=
 =?utf-8?B?cmk5bU5nb3YweU5FNXY4aFJQY1pHLzhHOUF6M1g2QjlPZ1JRVXg2MWdLQm1i?=
 =?utf-8?B?Y1h1QnRuTm96NXc3VDNCRFljd3lSbEpOMkg1TG1TL0Q0YWwrNm1mVEUvMFZH?=
 =?utf-8?B?SUE1NUtYbFJIc1V0UzhlWGRld05odlorWnVRWmgxQ3c0N2I4eGtJbHFKVU5h?=
 =?utf-8?B?L2x2bW4wNmMyQ24wdzhXM01xUk1mUUZpUWpRbml5QitwZjZsbTVWR3JtUThy?=
 =?utf-8?Q?OZmshyPvOIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjIwTzhUVm1QZnpYdmNnM1FMK0lhQjN6ZHFEMFNOQjFzdkFaN2IzYVpubktv?=
 =?utf-8?B?VGhVTEdSeWZDanR4Tk9oRGFHaitXbDg4UXdaQ3llVkhJdWMwMjMxS1Y3c3Bo?=
 =?utf-8?B?L1ZVemlqZG9Zbmw4T1IvbnFaZms0V1pYcU8zR2VOYnp3eVY3Y1hvRlNJVDNx?=
 =?utf-8?B?L01yc3JDZnFjSE1rcXk4aW5CUDRMY25GeXo1R0paZFNZVmhHck9VSWszVDV6?=
 =?utf-8?B?RmlTRDYwcFZObE5QOXhjUXdLdVQ3elVHVlh1ZnNOSmhoVisyV2F1WWsyU0My?=
 =?utf-8?B?QVkxb0hueE1xb0lLb2U0SmMzTlBvZStKWVRBSmFFYWVoMk5iTE5CUFhnbzhH?=
 =?utf-8?B?WjNmNGFVck5wa252b0crMlBkdklVeENYaVZ0Ym5seDR1TkVZRzlMdTBNVzJO?=
 =?utf-8?B?emhmTHByWVNHS1F1WWVhR2h5bWFTR3FzM25FQlJOTzhjeFp1NHMrUjVvZ0dz?=
 =?utf-8?B?K0l3djNhNW44Y3dpNzQ2V25iY3NoUm5iUm5TNTF4aEZZVXltcktpRzNFODha?=
 =?utf-8?B?Q3I0OHhvKzdVYld1K2RQUDF0T3Y1MkU4UFdMaVNOL21qeHdYZnB1cDczaXRk?=
 =?utf-8?B?NjZGQXFXeTgwR3hRVlBvUmdEN1EwbUlzSUxvNEpVZkM2K1k4UFNQWUI4K0tp?=
 =?utf-8?B?ZDZhLytTMkgyRGFxei8vS3VFdFdrZ2IrRVVIem1VNENqcHZPTkJ6Z1RWSUpF?=
 =?utf-8?B?TmtTTTBKWXNFRk9RTVVhSTRCRU9tckVvUXg4VGRQYStBaElWWFRVY3V0VkhD?=
 =?utf-8?B?YlRGWG5oSUJONnZYeUxSR0lZc3d0Y2hGRzBmVHdwaURqbGZMeU0yQnQxOHM2?=
 =?utf-8?B?ajlzK2lnZ0hVajV3a21Mcm9NL1hqc1Y5OW03anpHVEJOR3hMWnlTdVlPWW9Y?=
 =?utf-8?B?Z3hsRTdVMEVmb05qcVpHam1oQ29pWlp0R0RGNExYZ245QWVRWjRDSjJvOHZx?=
 =?utf-8?B?b1J2emU5MHUvVEJnTEp6dW1aSEljaDl1bDN3WkYyNlhoMHVtaklXbDdSUHd0?=
 =?utf-8?B?czJGamp2STM3S3VCQWpyaEloUlhIajlwSnBLWUJuL0hLZE5aVEY4cHRHemFl?=
 =?utf-8?B?dVFhVjdYcXAzMUM1R0poamxaNlVkR3o0QmpRZnYrMEdsdEdCU3FEaWpiNnNP?=
 =?utf-8?B?VkRzM3VCQzdwMmEyMVc3ZU5zcXNwQjArSUVCdHpVT2hSRHF6OTV3VUNJWVEw?=
 =?utf-8?B?SDRPZ2FUWW1CcUVTT3l2czRVdHBKUTl2VWpkWTVNdmNUaVlUbU8xOHVUV3Vv?=
 =?utf-8?B?YWdVNVlacERsNTVEaVZ6SVQvQ3B0YXFQeG55MFpKYWlVeVgyUGN0RlB1dFht?=
 =?utf-8?B?eEFBRk14dk5VcG4wVFR1ajFLTk1nVG43dzhQUTZ1dHMvOVhDTGtUNmhaejA5?=
 =?utf-8?B?WWx0Uy9LMmNibm9HNGNjZDFVaVNjdVRqMlBUM2pRYWRFNTYzc1dJeEt0Q2JN?=
 =?utf-8?B?VHBWZTdyQzErY0gybWpzUjM1bDEwbXJvUGREbU9zRVRHeVlxUVJIWDdQTW9h?=
 =?utf-8?B?YlZ0SGN2U2J2b0R2OXVCczdOcHl0Tk8rWndOSm8xWTVHYkFzanNRUkc0OHA4?=
 =?utf-8?B?Nm1zTllGU2RlMFlGUWtHZ1JUblJsNjhJbE9MelczQVJ0aTloVGpzWXhPU3pV?=
 =?utf-8?B?MXRDdHl3ZjFuMFhzRUhxSk9lUEpKRGV5cHZBVEpDRVVnTlhrOE9hcTFWNk44?=
 =?utf-8?B?eUt5cU1ieXFFQUgrZ25RYjhxWnNFTkFQQi9jN1NmdWxEdjJrZnp2QUhqWmRF?=
 =?utf-8?B?bzZHWTVWMWJEdjQ3bVZBR2RxQUJJeEt6cTY4VkFqRHdzU0tSQm80T1pqWit2?=
 =?utf-8?B?UzdveVhXOE52MEtmZUVwUmtOeXRjMnZyZXRGdmVMQUFhWEhycGZMUkxVYjZ4?=
 =?utf-8?B?RU1qY3BER2dkK3V1ZE43WWdpR1pEREg0VUlyeUhPeVpaOGFCL2tCaEVaR3VO?=
 =?utf-8?B?OU9RQ3EvRm5KTVBkN2JtSmk4K0YxMFhiMWgxYmZRMndSQmxvT3ZVdlhpM1Bo?=
 =?utf-8?B?SlJONE5GaEJBOVdQa3dmT0dMdEhCNWJsTkRHdW9WcGExMmxhQ1M5ZGxiMEVK?=
 =?utf-8?B?TzNPMXZSU1RuM0IxcjdoV1hQR2lxWGgxZHcwejk5SjhhS1dINy9YWENaT0FG?=
 =?utf-8?B?NHhkU2pBMjE0QitDZGNTbmQxVWFmVWxoVkVzTFRsdGFVdmhMZUNBS25GMGx4?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 395cd3ab-d65f-4625-5e65-08ddfc875e3a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 23:00:49.0228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbOJR1Dja/n6MeT6RXTPIKhMSvnkS2DC0Ze2aI9UWqdIv2kxnUihM5Xl3UunXfy5EvmTuVYYDGTFLGvYgO2LIf+Ckln/S62ql3rSHdJRKF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9254
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >> It is still a rather global thing. May I suggest this?
> > 
> > I am not too keen on this.
> > 
> > Yes, it is global, but less often used compared to @ops, and I do not
> > want both @ops and @tsm_dev in @pci_tsm.
> 
> Why exactly?

...because it complicates the data structure merely for code convenience
which is often the wrong tradeoff.

Here are the current options:

1/ Current:
struct pci_tsm {
        struct pci_dev *pdev;
        struct pci_dev *dsm_dev;
        const struct pci_tsm_ops *ops;
};

2/ Alternative:
struct pci_tsm {
        struct pci_dev *pdev;
        struct pci_dev *dsm_dev;
        struct tsm_dev *tsm_dev;
};

2/ Proposed:
struct pci_tsm {
        struct pci_dev *pdev;
        struct pci_dev *dsm_dev;
        struct tsm_dev *tsm_dev;
        const struct pci_tsm_ops *ops;
};

I rank 3 last because it implies that @tsm_dev and @ops may have
different lifetimes or otherwise may not be related to the same object
until you read the code.

I rank 2 after 1 because most of 'struct pci_tsm_ops' do not need the
tsm_dev parameter.

Now, I would maybe go with 2 if 'struct tsm_dev' could be defined as:

diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 376139585797..3619ffa8f8c1 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -112,7 +112,7 @@ struct pci_tsm_ops;
 struct tsm_dev {
        struct device dev;
        int id;
-       const struct pci_tsm_ops *pci_ops;
+       const struct pci_tsm_ops pci_ops;
 };
 
...i.e. a container_of() relationship, but that makes pci_ops mandatory.
It is already the case that TDX has as a few host-services in mind that
may end up sharing common infrastructure at a TSM device level, so 1
remains the preference.

> > So the options are lookup @ops
> > from @tsm_dev or lookup @tsm_dev from @ops. Given @ops is used more
> > often that is how I came up with the current arrangement.
> 
> I am looking at:
> https://github.com/AMDESE/linux-kvm/commit/9e3caf921ad6ddd6bd860ec307b986649322a618
> and not really sure "more often" applies here.
> 
> And do we have to check now if tsm_dev passed in probe() is the same
> as the owner?

@ops are not passed passed back in probe so ->probe() can not verify.
Also ->probe() sets the operations to use via pci_tsm_link_constructor()
so at that point it does not matter how ->probe() got invoked the result
is still the TSM driver returning the ops associated with @tsm_dev.

> I struggle to find any other _ops doing the same owner
> caching easily.

struct file_operations::owner looks like one example.

> Or merge struct pci_tsm_ops into struct tsm_dev to stop pretending
> that pci_tsm_ops is an interface, and then we won't even need that
> @owner. Dunno. Aneesh? :)

Not sure what you mean by "pretending that pci_tsm_ops is an interface"?

