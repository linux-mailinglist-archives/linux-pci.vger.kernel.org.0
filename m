Return-Path: <linux-pci+bounces-35065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A9DB3ACD1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 23:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF3C7A3454
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 21:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93728C84C;
	Thu, 28 Aug 2025 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVJJ2AeV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C41285C96
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417112; cv=fail; b=UUnM7eIIpm8qXjSLvJk6lo4va5UMMp2RQtFCUi49WdtD82VW92ETS9DFI2LH91kIIB7J80xUpy/RXm75DKrO31uJHirlsge+I78eV3UDXpVng+PIMbCKOwWMpI/2cEQv4zWAX7qRBj0CVOFtub98KuXLSnG3/0U5DCA5rj7/VMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417112; c=relaxed/simple;
	bh=gdlgLUEflSKwsJitYt5GMgH4bUxW1nimMjFOHokqL6M=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=gipqYHtr2xhFkIyK26sr6d+5s5fxw4sUKCyg5CNCLxYO1GgOtO5K3vVnMyNkpyJUy6SCAS50lZzAU5wH+1IG524KHkih0VIaBqfdiL8lmHSlVkNtoj/4tJ9Zr9UiwkIlGZ7a1ET+sN4m+KxWGNaxZyDPg5Rdqhh2/Cxpekla0Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVJJ2AeV; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756417110; x=1787953110;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=gdlgLUEflSKwsJitYt5GMgH4bUxW1nimMjFOHokqL6M=;
  b=lVJJ2AeVH5GJPqMZcDGa3ITI/XO87P8H0WMiqpFZHrzpL3me410mFg7u
   +CmNQv04A+V336k8jbRevvB17QsvasT3JEyCbU8yE4QbWgvz0tIa1fdSl
   NceuQpyagL7RgzEOJQOCfC577qCAfmlVsiJUF/q4jW0PQUb9Nu6xbs3RN
   /c3P6/pjt2ISUBHN69+0CjOqdqZUhI9g38GSRIZUg5hds+sJheusVqAmK
   KHLsK2d7cXqzA5Jg5baSgNkRE8oTttbsVOvtcp9SF/NifDsLfl1BMl/YO
   C4YbayOubMgvR0ydedzgYjKcDK57hS7Cs6C7Ib9Y8DnjndpMCqfqR+m0N
   Q==;
X-CSE-ConnectionGUID: zggBmFLuSWq4yslIEKU1XQ==
X-CSE-MsgGUID: 7PnJ2l58SGqnE3nCfRzKNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="70141098"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="70141098"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:38:29 -0700
X-CSE-ConnectionGUID: xsIxvetmRrSyRctuVzXp/A==
X-CSE-MsgGUID: vK7MoaK5QveX/wJ5IcgSAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170388902"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:38:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:38:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 14:38:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.75)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYWuylxyZiYPUldsbTKl0zYmWXwQSQwMO162pq5PWhDBBjpBHTNvMM3fBOL3pvqjRxiD3thZB3TrsaLWR+Miu4NKb7wR1XPQz7DazPqou/YY0fOOVc3hmAExu+eiGHPUQe7SibCEXGR9S1oSxqaM3vNH7T1o/MfpWPgIWLpOl5S0+KabkbK896oTlTb6zb6SvC3072/5o8H3X3MqqIjIpOg6QARlbtcNYgGM2rN2/gnAbOfsd0YtyUM5pkeYNl4ibTJ2TyhmG44Vf8+fmDluuqUEBBDBaAxz/qxGznf8kLzIpV6Y2Tcv8AZxEAutZ1M7Y9HNz9lmb/1URx7r03KRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRwzYEW6gyeFHHhGeF4NLkBh7rrvbiNDrCYQ26yZi3s=;
 b=Cqlazzrmu3gbAcMclK1P+nqKfArIaKYtBQxdxjoNbZFqrmc3MrzkhfQC9wSTTxfJRjTs5fLMP5qgPECBWOvdfWtU1WLAeFIpzLHVjUKq1P/k6l/Br4DqG1BOkgCugJ4xxFua+Xkr7FSu+0L0Q+LQJsDXrDZoK796zqo3IskqJqD4F9BfmKR/W3AvXXFZK+PsMxK3Vdg2K3O0Q2aR/4xe3ZENj83xihVJ4CSdd4vk4c/2pV85bMy6Iq41lEWRdRmnmGiX53ev/JSbDEmFR02TZxuoc8nFyGAkCcht8JLMHgUmNuRmmPC6jHMvrZx00HZk7aF+o/EPezxGfm1P/6F9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 21:38:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 21:38:15 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 28 Aug 2025 14:38:14 -0700
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>
Message-ID: <68b0cc4632fc5_75db10074@dwillia2-mobl4.notmuch>
In-Reply-To: <20250827123924.GA2186489@nvidia.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-7-dan.j.williams@intel.com>
 <20250827123924.GA2186489@nvidia.com>
Subject: Re: [PATCH 6/7] samples/devsec: Introduce a "Device Security TSM"
 sample driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd75dad-9409-4d95-7402-08dde67b321c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkVPQUZSa2ZFdHREMVprYVdaamI2ckVBZmxwd1hLYktPQnNvcVVTR0RBckZU?=
 =?utf-8?B?TllDWkd5QkN4WEdoMWRJUWduS2xLaHlVM1UyMy9GSW05ZWpWbHhaamRHeUo3?=
 =?utf-8?B?dmJ6cTNFYjBsZEZ1T3JrSG01eitIcUswM2JmT3NIMmZ3dTQyV2pETnlHa3Zn?=
 =?utf-8?B?TGhBMytab2o4M1U5YVZhajVRUUcwUllreE5OM1ZlWVlTR0JkcnZabG82U29V?=
 =?utf-8?B?TURZUGowK3IyT3NrMHJmRUx3V3doUUxyWUxFU3Y1QUN1bi85SmlWVkdoQldT?=
 =?utf-8?B?S2huVUMwMXA2YmM1UVRLUmV5ZG9yRnJkaXlLVjFsZE5QQXR6bWZ3blFSMHZk?=
 =?utf-8?B?T3dDbUw4QzZSb3JNajhUZ21uKy9UNnBpdSt4Vkx5d0M1YmttaXFSVmFTbmlh?=
 =?utf-8?B?L1VlZm5qYmhXVVdrUTZDOEhkdHBEVXZQdXRkdUtBdmtZOXAyOTh5UllZeGZT?=
 =?utf-8?B?RUtOakFkclpBbGdyT1daTTdmbDZrdTE4UzB2S1ZMdVlGdi9aUUVDM2FraVFq?=
 =?utf-8?B?eVBVNGdMZ0ZPNTRHV0xTVHI1b2w3dXVxZ0R3NmdBQi9VVWszWEtwVCtBWjhM?=
 =?utf-8?B?NVlpNDJHQ1Y1OXdybUZMcmRPZDlJdFl5TG8wYUtiR2N0bkwyMGR2UU1WRDgw?=
 =?utf-8?B?c3o0R3BHTWJ6ZlNqcUY0bXpOUlBkWnFFL0d4NVFCdm0vUEVmS0JFQmJBUTBx?=
 =?utf-8?B?SjJzYkpZYWV0QVBZM2ZqMVNlaUYyVFpldERpRVJnQWJZdUJRaGYvY0tLajhN?=
 =?utf-8?B?Zk9mN3dGYWdMZ3loNFgxOE1NeXdoR2Y1YTRkdU9Kc1lEV2dwUXhPdmFsVjBG?=
 =?utf-8?B?WFVxbXIrSnFBdHcvalA0TGtHM0tvTEtJS012ZnBCbjNJbytQcjRYTUxhWkVC?=
 =?utf-8?B?RXUvZzdkTzQvR2ZPWTZ6cUx3VWVIVjdGRmppK3J1bGQ3NkYxSWpHZ040cEhq?=
 =?utf-8?B?UXk0bG1lajFkZEdxVU05NEZXbGVvdkc3eUs4S1lyR00wc01YNlpTdzlPaVR2?=
 =?utf-8?B?cHlMNTNTZVJ2Q0pIdTlBazI3bCtrenFvcmQ4YitrN1Y5ZEh2MkdLN1hIcXZD?=
 =?utf-8?B?VHFtNkYvKytYdHNxWEttdjBFbnB3aHJaMDVuTEoweXhkdjJzMVpnWWRNQnVo?=
 =?utf-8?B?N0oyNWxtUEo5cE1ic3RLUmxVNUVpdDRrekQxeVhvMm16a0pNU2FhQzVnaGc3?=
 =?utf-8?B?TWU2ZGFGa3pnZTJ2QmFrQ3hqcmRscFZuaFBYQzdRWWJ4MEw3MFlWUTVXR1RV?=
 =?utf-8?B?Q0tzK05lMGRuN1h4R1BpSzRSbm1LVlRndWFUaGR1TGVUMnpEQjlDcjRxQ3V3?=
 =?utf-8?B?WVFaNnhRNzRxcmpiNkQ2N1ZXTzd1Z1VESW5kUE5FSm02QkxGTmVKYjZ6WWNM?=
 =?utf-8?B?ZXREdm9RYXlZckNCWDIwM0Ruczlla3MrOXNiU1l1OS96ZDVRcGhVOTVUQWxt?=
 =?utf-8?B?OXgwMjdJUXpWSmNBR2RkMWFDVTRjQ3FzaXpLbzcvRTJsWExicUVrK1l5aGlt?=
 =?utf-8?B?UTV4Ym8rMVRHSFArL0NMK0I2dDFVZlA0QktzRVBIUTAxTEZBNDNvdEdEZlV2?=
 =?utf-8?B?QmpkV0JUcSttUXRjc3c3WXA4QVl3cHc2SXZVZ1I3RjlQREtYNHhFWGpkK2p2?=
 =?utf-8?B?Z2t3aGUxcmNCUFo2UGMrTGsvWFNKUldmdVhSZnhVU1hWdW5BZUp1TDk3KzNv?=
 =?utf-8?B?K0VXS1pxcEZZSDllYmVTNS93L1FnRDB5YkczTDJySmcydXgvVVNXM2liN2Q0?=
 =?utf-8?B?TjdVVFMydnhpOE1WUFV1SHdpWGRlOXZweHlwcFp3TVArOGNhRWpabWNiNWhm?=
 =?utf-8?B?UW5UQldqVVIraDNsTnhLdm41ZUc0ejY1cEhBR0dCbFhPdm9QK0VtWFUyQkFS?=
 =?utf-8?B?b3Y2ZGorOHNuaGQxTUEyNUcxalBYMTM5Qlk5d1J0LzV6a1VjcUtZV2F4SGtz?=
 =?utf-8?Q?bwoNl8M3Gno=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUlBK2hhMGloV0JTUVlBdWpXTGVaclo3MGtXRmdCSnBOdXVrODJac28yaXo1?=
 =?utf-8?B?YUZEa0kyUGRIY2tsMmJLSjFWVmhubm8vWHhvSmJmOU5oTUNsMURFL3VjMmVa?=
 =?utf-8?B?cGdEZUJaR0dRSGVDNTVOdzN2bTFnSnYvcEZqMFUxZ293ZGVweUk0aytyd1pW?=
 =?utf-8?B?VDRjUkhRUXgyY1VrSmduR1k2ZTVOMXpDd1ZtUWJBeWVLb0gwdUYwWWZrWG81?=
 =?utf-8?B?dXNPOWFJRTkrbFoxb0FlaXZQWjdwM2FTZ29mdkVydzUvbHBibWZZMUlXbkZn?=
 =?utf-8?B?bkRVSDdOTnJzQ0tEZk5JeERIbkgrQWNwNzB0dmJTcjBDaUI5NjVnSjVNMVkv?=
 =?utf-8?B?SmtSby9jUmt1dEFjczZFdUhFVWhwWTdGL0RWc3NUcU9hN3JYeTUzdlVMeHVx?=
 =?utf-8?B?bVB3M2dZZytveHNnWkpXdlNjbVA2cHpYa1d3T2hpcVVORTdSMmQ2WlFTdkVT?=
 =?utf-8?B?NXJ0ODFQUU4zZ0pRL291ejQ2a3NiYXlPNlBxbUhHRldqVWMzUWxUU2VGUWJ4?=
 =?utf-8?B?eEo5UFByVWNsMHBxMXRwdFc1VzA2QU5EalZsazhYZklHTE9nRVR3cjBIZmMx?=
 =?utf-8?B?VE9Zcy94UUlqbzZvQzZVbmFuNWVjbXpmN0N2Mi9UVUd1cXVINCtYaVhpNXkw?=
 =?utf-8?B?djJTL1dlZVFDRlUxUjZ0QlZaazUzb3R1VWxtMWkybTJDOXc0ZUUremRuUFor?=
 =?utf-8?B?MHR4Um1JcUVhaUwxcEl5dFZoTTJiVWhxc3ZrT2Z6d1RlNzNjelV4Q3BxRXFX?=
 =?utf-8?B?bWtkdE92VkVOSHBWQ1hVMzlSRjEwT01oQXk5cERETWlGVDdUa21jZmhhOHRL?=
 =?utf-8?B?TVg2OWRtNWtXSzlrTGc2NkxhcjdYeXFRWVlpSFBLelZGb3QySFE5RDRBcWEx?=
 =?utf-8?B?TFdjL2ZtdU9pdWdDbyt0NjBxM2NKUlpxMThzSGo5cUVwZ0NVejRUNDBJMklt?=
 =?utf-8?B?elNMQ1dSN2F4WXpZT1E5MkIyOEtKVkdDZHdETnVYMVRlR1V2ZW80SmQ0SS94?=
 =?utf-8?B?bzRUSmpFVTFIUm1VRUd1ckNsV3I2ZWpaM3lxRDlpMkE2STEvMWo4Y2c5SFZR?=
 =?utf-8?B?L2QwcjREdm5Pc3JvM0Rac2o5NTk4eWRwcFBtUUJFNFVCTnR3ZGFVMmNSOG9K?=
 =?utf-8?B?bko5ZWxCQm9wT2I0TE5mRnE3TUZnWW5pckdZcDF1L1RrVDJsNzllQ2hwTytU?=
 =?utf-8?B?WGlFQVJGYkp1ZkJpVVJUOFpOQWZOMUNFNlJyRVk1ZkVlUncycTdkM1JPOWNH?=
 =?utf-8?B?Q0VjdFpZRTI1WjhsZXdMSkR0cU5lR1VyOHJ0TkdjcHBIWGJ6SDhKSnBEekRQ?=
 =?utf-8?B?ZkwwK3RCUUhybXp6UGhTRkRxdUZvSVoxdTdaMDdQbFZ3dmpiT2c0Yjg1dzZZ?=
 =?utf-8?B?SEN6aHl4MUU4QWhnV0N5STRtTlA1WGhOR2Y1YjdMN1ZFQ3NyaW9sN3Q4QTQv?=
 =?utf-8?B?Wit5NXpzeHl3T05uQVFLVGhQQm8wZE9SZlJEKzdrZ0JIQTJZdlVXbFNURjhy?=
 =?utf-8?B?dVQ3S1czVlI3dWFUZUVJRHF3ci9MbzZKWHd6andpcEJTbXR2S1ZtSnMzWEFR?=
 =?utf-8?B?NUIxbDZMQm9SVk9weStGRDdiamE3ZW9HWnhTYjlsblVSMjR2L3NIV2dTK2Rn?=
 =?utf-8?B?RERPTjlISGNYTUNudldNdXpUbi9zditOY2JnOEp4dzhXLy9DMVlndlE2MUJC?=
 =?utf-8?B?OXd0T1U1aXZVendXMTg3RWtHRUxraENLck43eEswWGMvTUpkK2kvMXhnMG9o?=
 =?utf-8?B?U2EwYkVuM0FJdllXb3dDdmN5N1lGazEvM3ZVVzZQWmNpZ3dmOFR2bUNMZUFl?=
 =?utf-8?B?SkVCMlovQkxuUklTQjJsejNiVlRMbG1YcHA5NTN2UTZTdUQyZitzS0ZvZHRL?=
 =?utf-8?B?L01WVUM5NzlMS2dEZnAzN2liZi92QmQ3aHorMXpuSVBHM2F2RHJwNFh5aXFW?=
 =?utf-8?B?dmMyYW5XRE1wcHVJb1pPZDRwVkpUTFRmVVZOa0h1dVFTcUJCQWdvWWgwenQ4?=
 =?utf-8?B?Qm1UaWtkUTlCR0ZVYnpiWVY0NHo3alorWUQ4bDAzZEx1cys5WVVDUVNvcHVI?=
 =?utf-8?B?SWkzU1NIaDcwRkZJTWNSZWJOaHpscTZqWWpVcmVEM0hyN1kvbzdEM3hFNU1v?=
 =?utf-8?B?ZklTYjBSV2c1NWNSeUFCNlNuSkh5MDMxa1llOWNocW9yZWFvSTZ2QWFINGlE?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd75dad-9409-4d95-7402-08dde67b321c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 21:38:15.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fU0r3FSsyQWJvu8jGXe+bj1X0+3P8vvgePg5JH6icUfLwEZFD+/k/G88xNjkrTIp97odvnrVb9SfdDPRDQQAiT1fNuNcxbzcCrV+Tlda7vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Tue, Aug 26, 2025 at 08:52:58PM -0700, Dan Williams wrote:
> > +static int devsec_pci_probe(struct pci_dev *pdev,
> > +			    const struct pci_device_id *id)
> > +{
> > +	void __iomem *base;
> > +	int rc;
> > +
> > +	rc = pcim_enable_device(pdev);
> > +	if (rc)
> > +		return dev_err_probe(&pdev->dev, rc, "enable failed\n");
> > +
> > +	base = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
> > +	if (IS_ERR(base))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
> > +				     "iomap failed\n");
> > +
> > +	rc = device_cc_probe(&pdev->dev);
> > +	if (rc)
> > +		return rc;
> 
> I really don't understand what the proposal is here?

tl;dr I will include an end-to-end flow document in Documentation in the
next posting.

> 
> device_cc_probe() doesn't save anything, doesn't this just get into an
> endless loop of EPROBE_DEFER? Usually the kernel will retry these
> things during booting?

Hmm, no, deferred probing retriggers after a one-time boot timeout
(extended by driver registration events) and after any device
successfully completes probe.

1/ TVM policy decides it is committed to operate $device in confidential
   mode.

2/ Enlightened driver learns about that policy "somehow" (I am open to
   this policy being conveyed via driver-core standard mechanism, but for
   now assume the driver learns the policy by driver specific means).

3/ Enlightened driver uses device_cc_probe() to exit its probe routine
   at a known point where the device's configuration is ready to be
   locked, or otherwise falls back to shared operation if confidential
   operation is not requested. This is different than standard device
   teardown path which may "unconfigure" the device and scuttle
   acceptance.

4/ Whenever TVM is ready to measure and accept the device it triggers
   manual bind. Meanwhile deferred probing has probably gone into "wait
   for userspace to manually kick this device" mode by this point.

Unenlightened drivers skip all of this and just assume that the device
arrives in a "ready-to-lock" configuration.

> How does userspace accept through the sysfs retrigger probing?

Yes.

> As we discussed in the prior chain we need to have a policy decision
> before auto-binding drivers at all in a CC environment, I don't see
> that in the code though the cover letter talked about it??

The aim was for the "'struct device' has an acceptance flag" discussion
to settle before starting a "device-core policy for unaccepted devices"
discussion. I am ok to put more logs on the fire if there is an appetite
for that.

> How does the kernel/userspace tell the difference between drivers that
> want this early binding and those that don't?

I was hoping to put the onus of that on the vendors that think they need
this Enlightened driver path. The path of least resistance for device
vendors is design the hardware so that it can be locked without needing
a driver to take any configuration action ahead of time. Otherwise,
explain to users that they need to adjust/replace the eventual udev
sysfs script that does:

   lock
   accept
   bind

...instead needs to do:

   bind (defer)
   lock
   accept
   bind

Now, there is a debugfs method to learn the probe deferral reason, but
there is no requirement for debugfs to be mounted, and it turns out that
probe deferral reason is only updated if the device is autoprobed. If
the first time a driver sees a device is via explicit bind debugfs does
not convey the deferral reason.

> Can you write out the whole flow from a userspace perspective in one
> of the commit messages?

I will do that in v2.

> This also disables BME, we talked about that a lot, the commit
> messages didn't seem to describe what solution was settled on here?

Your proposal to put 100% of the onus of not clobbering the RUN state of
the device via configuration writes to standard registers on the VMM has
grown on me. Make VMM responsible for trapping and declining requests to
clear BME and MSE while the device is in LOCKED or RUN state.

Enlightened drivers could skip clearing BME + MSE when locked, but
unenlightened drivers should assume either the VMM traps the
configuration request or the TVM must re-lock re-accept when the VMM
fails to meet that requirement.

