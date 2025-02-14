Return-Path: <linux-pci+bounces-21525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47063A36778
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 22:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EBB3B275B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA561C861B;
	Fri, 14 Feb 2025 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGC1INWb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369911C861E;
	Fri, 14 Feb 2025 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568313; cv=fail; b=Fs2LtDE9HOS48eIgLm5JCDfWqGmZI21zE0wwsWf8AkV4TALWvMVDl9Z09qnSvnBI85qybvlSOPzatO1cgoVkuhi1B4sKk6E+oeQCKvG52PxLCQUtNPlFKjFKAulki7i2/I5UAUQHlCIKEp9b8B2dXhOp1Mb9LyInJYEz6nM+igc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568313; c=relaxed/simple;
	bh=7iAbgS8aTbSeex1yy6kVJkIPlDv6Cjh3t5J5JBgDUBU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rLO7YO9zQLSQJvygphkfwkz0kQrhPQoOLqOPkQJPRW3B3DX5IE6iiQh9RLcr4aTpThUUNevwTVQcD9qkbL0JNXaXhAowO/5XiIah9JMvUGrGeOY/ZCs7UrajjH83pOG9BDu2kgZAr+v7BAJs2cJQyfFE/PFpX7t+U0rppKD/OuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGC1INWb; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739568311; x=1771104311;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7iAbgS8aTbSeex1yy6kVJkIPlDv6Cjh3t5J5JBgDUBU=;
  b=SGC1INWbEA1utL8YmKUUT1HGB7J2upbu/HUxUVwTE+6cwG8vcazP4nXx
   dSU+sF5yIcx7MgDVczHoF80VbW1SHmfayeQjsZSC38OQzcCAu4e9/45Ko
   1LnjyP+QKYVGbJd5mntoAAS8dqcbnie6zfR4lNdkJRX5EIczMPkWJPmAW
   tiIPXPUf1thC069/a0WHuQHRoPVsrpJrRVsmbgl4zfcCP6FCYJ9vebQGM
   evTr/ieUJr5xQG2na/glvXKvSO1dQioxIF4fUz5qUF6DaGdLS32dytMwa
   wug0JxlrogS56ietkhDc+cci4E9NIcQxBSocu26cRKKP2WLh1TmlNDAU2
   A==;
X-CSE-ConnectionGUID: neo1nwgdRRGubuOCS1lw3A==
X-CSE-MsgGUID: kyDuq8MiQniro92C/kMWIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40455077"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40455077"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 13:24:49 -0800
X-CSE-ConnectionGUID: SEOL3RF/R7KIWyEDK9YWbA==
X-CSE-MsgGUID: pupl057NSOi8trtZKnV0Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="113418290"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 13:24:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 13:24:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 13:24:43 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 13:24:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gg1Kg6xe+Bd8nD5SYh1wCev9PTdjjk1t/clPysNttzlYc33WPkDaAP+4VadWHrfeEQ4W0ZhVDeDEONtxpBq11jazpEVqnizh2VzG504Silj2QFsmRVgo4ma4mdKBO1KfQjQQrDm8Dss/E6aP+ytYxJ6uuK6Mi3BBIGhvhAUP2bCfyW4f38HgmT0Pnpbju0w+97m3JWXUXybTlFQ54+sdJlyMk4xazcPBvvTj5I5cblHu8krUTcQwdLNUENyNm74+0qzRmmVusQQ9AeQVY2Zj3Y4ctl4s5MdGt7Ol7un7zaQOU1rW2aww/hVoc+Dlo72Mr2AIQlcpRQ77csw0RAVXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIRu++3jSuaU98/ldhvXY9BkE/OXO7SyaXmIdVnKXAg=;
 b=g9hlv8+SHbtRi3Tt2cCzpGjkAOq9lgEBiZ6+bJCKlOG9T1hLaP7PPs51MFQb+5isi262AH7H3X4QriUwHCsck08vPAko1OcK83L55ly5SvkXznxq4Kei2+lGIH/Cf1ghPfDJMaf9F2ggMvbs+L55rQdv/bxL+o0nwh0Q7M6+zw4C4E/VhHplTERP5yOEOJVVINMaRt0HFrOX/+CInlz1lhQOTrnE316AHMC3FPX4k/81B6AXCwi04TpWF3POrNYDBtlEInID4C+kVMHp33hoH4ELTGuvMjDBNXVD708YvDtIxAk1ki51YUYpQOrcqKscxsj49JaZDen/RJxXo4ICFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8772.namprd11.prod.outlook.com (2603:10b6:408:200::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 21:24:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 21:24:40 +0000
Date: Fri, 14 Feb 2025 13:24:37 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 07/17] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
Message-ID: <67afb4955252f_2d2c294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-8-terry.bowman@amd.com>
 <67abf81f4617b_2d1e2946a@dwillia2-xfh.jf.intel.com.notmuch>
 <609a02bb-3271-4021-9499-8b281a959f62@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <609a02bb-3271-4021-9499-8b281a959f62@amd.com>
X-ClientProxiedBy: MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: df73bdcd-07d5-4d18-c04d-08dd4d3dfdea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anNGUzdnUGFpTkNabm1aY2lIak9SZ0Noc0FpNDNHaGFtUWIyYUhjb2FjRkNE?=
 =?utf-8?B?R2hBSkFtNUxxZjd6ZG9GYjEyRk94dFVkbytmME9oaFViTzlrdzNVb3o4Uytp?=
 =?utf-8?B?UGxjZTRKV0VGRUdrbmNGWUNSdDBmNHV2cHBvMzN1Y1hPSDlabysvSTdOUEF4?=
 =?utf-8?B?clFHdUpQOXRrQjRJc0xUd1Bac08vRVp3UENPMHhyeG1nTmszUktGdTZHNVpU?=
 =?utf-8?B?MUZsM3hSb1BuNUM4TWQrWm9COEJVd3U0RC8xM2ZOWXltT0lsU0kzYnFRVnFa?=
 =?utf-8?B?UVpGUzJzMWlraXpzWTRoQyt4TnhaVnk4Y0pjc3lRQXN0TEtQZFdFRVhxS3hC?=
 =?utf-8?B?NVBjVzdvcmt5VTJKblllN1JOTjhPUG90STV2cXE0UFZkZ1hmL2hUTGh0SlFX?=
 =?utf-8?B?YTJva0hOaWU0VE1XTldKV2dyZHNCc2pGYWlic29HODNUZm0rd2drRGpFa3lK?=
 =?utf-8?B?Q09NYUpVRjV5UUI3aVFGUFRiRHYrdjgwQVN1R3VKcDRuNWFYK1ZtS0JzL2JD?=
 =?utf-8?B?ZE9xU1JhU3MyTnllT1RDN0F3NW14Uy9PYVZuVjZkZFRHZ3hCUnh4dWlkU2VL?=
 =?utf-8?B?ZkVHZ0t3MTZVQ1dGRENJcElqMTk2a3FYWnorSDhjUVNVSmVZQnRtNWRlQk02?=
 =?utf-8?B?dmVJZlFZNWpMUDB4YVdhODk1d0lBQVdhWFlJd05YS3ppTDFITmdpa0g1ZTNF?=
 =?utf-8?B?K25KVlg0OEcxWWhQbXRtT2t4WVhhc0V6ZWF4ZjN6eWJ1em94blc2RGlDRGlY?=
 =?utf-8?B?empwZVM4TEhDQjh6ajV4bHFWSENVZ0tYOHRXRllLWEtsbExrSzdXT3Q2Vmh6?=
 =?utf-8?B?UUE1dkptb0M3QVpGY0txOFEyTCt0RXlKSWkyVG4zdXpzcHZmRzNYVkZqWXhQ?=
 =?utf-8?B?dnVFcFhCbHFlYUVTeDN3VWVFeXB2T044YzV4cjVEUTRWcUgrOHcwZTNNZVdQ?=
 =?utf-8?B?OWl3M3dyL0JpNnM0aFppcGtBQ29UVTdGVDlHTnBuMllHY1g2bE0xOWE5QlI5?=
 =?utf-8?B?Ty9DTXVVaVJxQURpc0lWenZucFBlL2pXdEF4S0RaSmtRejYvUSsvbkRPSk1N?=
 =?utf-8?B?dkdJMDdkemt3NHVzWGNrYWFmVGlhS1FHaGJ0NklxWnFWbWtGOUQxeUViTjVY?=
 =?utf-8?B?Vi9lSW1LQ0JSRVlQNzNsOXlIaGI2OTJ0TGd4REVuTDRLa0NTRjlXLzlZam4v?=
 =?utf-8?B?SlZ0S2xydkFZUGUxY1BNZWtVMWdYSHp5bnUwemRFYktHdVFuNmZKZTRYOUF3?=
 =?utf-8?B?ZjFKRWs2OFdZWWRIYmtXSmIwRTdmZzcvVHp0bFFqNVNsalRxR2thWHRBM3FR?=
 =?utf-8?B?bFNuNE45bVdUU0xqaGVpRFVBdWxQSHVkeGEveFJHNFRmUW1ZeDgwcURNaDNF?=
 =?utf-8?B?c1JHYXdSMElOWEdPMThnQnk2SFgxUnNyYXNuTjVZdkpyMU5DeEtoRU1xRVFB?=
 =?utf-8?B?cS9HWUFSaTFld2xkR3lGQ3BlKzFnQ1VPN3lxVzVyOTNaN0svVHBGNk94VXl3?=
 =?utf-8?B?RHFQWGhpNWRhcFBMUWpTWmFRcE5tRHloR2ZhanZFU044eUJ5bTJYNEFYOFY5?=
 =?utf-8?B?elIvaWJuSm9ERjdHamQxV3AraDJ1MzM3d1ptVmQ0V3hSa1dIUjRPM0FiVGMz?=
 =?utf-8?B?eVdmL0J6S3hmbkl3TFNiSkJNQjJDOUJ2bzNBd2dZcmZPZlVkTHduQ0lrci9M?=
 =?utf-8?B?WTZrN29VRE16WjhwTWU4MGk0a3IxVHk4MDJwb0dJM1gzYWdwNDJYRTgyZExZ?=
 =?utf-8?B?UytMcC9kSEpBMk1uZWlUdkV4S2hLQU16bGRONXE2TEZYNUp1U1E0aTkwbTZQ?=
 =?utf-8?B?dlFycmdxcVVEeGh6Tm9oaGZEQlpWQkpLMWJkUEd2cm0zbHVmN01jVCtjSEpH?=
 =?utf-8?B?WjRRZXN0V2JaQ21rSkZ6K2xwVFlRODNqc2p6QU1PeW1qMWZhY2g5VjdHc2ky?=
 =?utf-8?Q?6KZiik+1zH8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkNMRWptSkNxQ0hLYk5NcGx3bXpidW9JdlZxK1IrMXZnUFd6WUlaUWtFdlZt?=
 =?utf-8?B?WWYyd1hVNktxWUNiR2Z1RGtyY0QxcjUzcEFlVE5abVlCUzVTRk9zQnpsMzBV?=
 =?utf-8?B?bmcreERuNUdRYjZpT3NHalMzM0cyam0vT0RiMTMvendxRUlQdUtkTHZXL29X?=
 =?utf-8?B?b2x5V1RwbEorUERRaHBEOTlkRVdHUjV6clBtUENINUNWNWpmQTJmbm04bkpJ?=
 =?utf-8?B?Z3hnZ2Q2SUVFK2JYQ2xDOWRITEV6U01BcExCOHJOcXA4dzhwTU93b2JtOU53?=
 =?utf-8?B?dktiQTBDQ2JFUXJjenpBcDZQeEs1dmhBaGlIRklDYWdjemh1ai9kTXBTdnN2?=
 =?utf-8?B?TU93SEVwZU5COVQzemZjZ2RMMDcrb1A3WjlObUJPWFlVYklQcjZtMkhUQjYr?=
 =?utf-8?B?ZUhWd1dkSUhGUXpwL0dOVXNSVWc3Ni9tLy9BTEhWRXFNeDkwUkVZUGgzTEhV?=
 =?utf-8?B?c1JHVGkyYUVFY1VkNy8yZ1hIZmtNNFVVRWh6Vkp2V0ozVDVWaE4zRUh4VEpn?=
 =?utf-8?B?emYrcmFTMXBKb3RDMFhiTlNnTEhUOXRzd1BQRDg1SFBNN3dHejBqbkd6ZzFC?=
 =?utf-8?B?U0MvNG1zaStvS3lkQW9vanN1cHFudE9VVmJxT3N0K0hEc3B0bHFoNWc2WnZn?=
 =?utf-8?B?VjNIdTQ3N2x0MWZNWkxBSUtxb1VrUVFNdnFMTXdxRDh0UTh6VlRIUFBPZTRL?=
 =?utf-8?B?d0diNzJhdk5WQ1RZandiVUFPbjdhcTZNRUd6OERWTy9GRUtKWlhSUW9nb2ZC?=
 =?utf-8?B?WlZxOXo4KzdaK2RqU3MwUUxuNXFyVitrRUczdUNad1hRMTV3N3dQNm5MTmJ6?=
 =?utf-8?B?NmJwd1VxMTM3T3YzZGRYSUhTeHZPKzlib3pOVS9heG93OFEwTFdQMVhzbjE2?=
 =?utf-8?B?RW9FTXRSempWOCtZRHVYRitVaGxZNEk4Ni9maWc2R0RvUlh0bWlwRUg2a25o?=
 =?utf-8?B?dGUyY21EMERtb2o5bVNNU1l2QXoxNlVWSEFwbHVKc2NKWWpwc3dFQkROaFB1?=
 =?utf-8?B?YnY3TnMwYXBpMVFhcjBtYnpoai9qT256V1NnbURuQzFlbzZJUHFoL1dvd0tk?=
 =?utf-8?B?TVMwTmRiQXlhOG8vVXhLeVVUeHg0R0lGYWp1R3BTZnh3WU5WQ3BYQU1IdHJY?=
 =?utf-8?B?dDArVnY2TFRvL21GZEpHSFpZeEhxV284MnU1cFpXdjRWcjNUWmRQYmhIQUs3?=
 =?utf-8?B?cTVaY3VnTDZnUm9UWEo4ZEdhdEJUMnhRc25aUFIrTzFjbzZiVTRmRitOS2xM?=
 =?utf-8?B?SHlNTjVKdlFNUmxMd0lEbmNwN0piNGtIbGJrYXFCVTFCRGhvVUhqZEw5M0xl?=
 =?utf-8?B?bmlrbys2ZHZXdW50eEd3bTB4QTN0aCt3ZnBNK3FOYm8vZmljZHdqclMvUmRR?=
 =?utf-8?B?dDJma3pTaVNHclZWbnNHU1JMVmhDdXIvMlE2TVdTNjRrYTZFT3BIRDd2OFVm?=
 =?utf-8?B?ang4OExwbUg0QzBpdVRSY2VZZjVheU1pUlV2bGsyZTZzVnBlLzJsbW5wLzk3?=
 =?utf-8?B?VTBSbnlsZE9SV3hQZEhOWGE0SnpRVWQ2SGdDQkpkSDQrWmxXY1hFeGxXTmhh?=
 =?utf-8?B?ZzF1bG1KbVcySWcxMnY4UzBXZTlQa3U5cU4yaUtoV0g4YmdFQW9pbURzbitt?=
 =?utf-8?B?c21iMkpUSm80SFRVN3d1K3VKRmh0Z2hYaEl2SnpNU0Jwb0JXaCtLNVEvalRW?=
 =?utf-8?B?ODlNUDFnY3hsRmpaUUp4b2JpMmhpYk45cEI2a0Y4M0NsK1V3MFQvb2xCTjZK?=
 =?utf-8?B?ZEVIUXlZeVZoWkRjeHUrTjN6eDIwT3JmQ2drTm1FTGgvYmpIdWZBZStNY2Ex?=
 =?utf-8?B?OGZ4SzhnY1g1N2lLUnNvcCs4c00xTzBPbG85c2tEQXNGa3VpUWU1TEl2U2RX?=
 =?utf-8?B?U3VjUVdYK1ZWcldTd0VhOThNY0dsLzRwY1lscVpoYlhBejUyOGZ1UkJIYkxq?=
 =?utf-8?B?YzZONmd5cmJqQnkvbDYwSjVhZjlvblVtZUJ4dGpPRFBQYlZxdjZDNUlabEZj?=
 =?utf-8?B?RUw4eXBwV1oxKzFuOHNxekRzMGNVNTJGZllJMDU0cWpmYmgxaU1WNUx1Undw?=
 =?utf-8?B?K2IyUUo5T1hlODBtRlhBTkJMNzEycnlkakRCUE1oOXBGRkkwN2pxOW5vaERt?=
 =?utf-8?B?cis3RUZSUWczR2xHaVhrK2ZRbXdrRGZxUktkTzVrV0dQTlJ6djFuWW5qMnJa?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df73bdcd-07d5-4d18-c04d-08dd4d3dfdea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 21:24:40.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UMqz+vvJ/CexVLp/nYvKOE9yDK/HP6P8vQNQpssRPSWI+yZOhe5OA79ahNzSeCIs3B+543sTzo7prMj/Mkmc1WHxBo/IO4JS2/wSMyLi5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8772
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> On 2/11/2025 7:23 PM, Dan Williams wrote:
> > Terry Bowman wrote:
> >> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
> >> registers for the endpoint's Root Port. The same needs to be done for
> >> each of the CXL Downstream Switch Ports and CXL Root Ports found between
> >> the endpoint and CXL Host Bridge.
> >>
> >> Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
> >> sub-topology between the endpoint and the CXL Host Bridge. This function
> >> will determine if there are CXL Downstream Switch Ports or CXL Root Ports
> >> associated with this Port. The same check will be added in the future for
> >> upstream switch ports.
> >>
> >> Move the RAS register map logic from cxl_dport_map_ras() into
> >> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
> >> function, cxl_dport_map_ras().
> > Not sure about the motivation here...
> >
> >> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
> >> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.
> > Ok, makes sense...
> >
> >> cxl_dport_init_ras_reporting() must check for previously mapped registers
> >> before mapping. This is required because multiple Endpoints under a CXL
> >> switch may share an upstream CXL Root Port, CXL Downstream Switch Port,
> >> or CXL Downstream Switch Port. Ensure the RAS registers are only mapped
> >> once.
> > Sounds broken. Every device upstream-port only has one downstream port.
> >
> > A CXL switch config looks like this:
> >
> >            │             
> > ┌──────────┼────────────┐
> > │SWITCH   ┌┴─┐          │
> > │         │UP│          │
> > │         └─┬┘          │
> > │    ┌──────┼─────┐     │
> > │    │      │     │     │
> > │   ┌┴─┐  ┌─┴┐  ┌─┴┐    │
> > │   │DP│  │DP│  │DP│    │
> > │   └┬─┘  └─┬┘  └─┬┘    │
> > └────┼──────┼─────┼─────┘
> >     ┌┴─┐  ┌─┴┐  ┌─┴┐     
> >     │EP│  │EP│  │EP│     
> >     └──┘  └──┘  └──┘     
> >
> > ...so how can an endpoint ever find that its immediate parent downstream
> > port has already been mapped?
> 
> 
>             ┌─┴─┐
>             │RP1│
>             └─┬─┘
>   ┌───────────┼───────────┐
>   │SWITCH   ┌─┴─┐         │
>   │         │UP1│         │   RP1 - 0c:00.0
>   │         └─┬─┘         │   UP1 - 0d:00.0
>   │    ┌──────┼─────┐     │   DP1 - 0e:00.0
>   │    │      │     │     │
>   │  ┌─┴─┐  ┌─┴─┐ ┌─┴─┐   │
>   │  │DP1│  │DP2│ │DP3│   │
>   │  └─┬─┘  └─┬─┘ └─┬─┘   │
>   └────┼──────┼─────┼─────┘
>      ┌─┴─┐  ┌─┴─┐ ┌─┴─┐
>      │EP1│  │EP2│ │EP3│
>      └───┘  └───┘ └───┘
> 
> 
> It cant but the root RP and USP have duplicate calls for each EP in the example diagram.
> The function's purpose is to map RAS registers and cache the address. This reuses the
> same function for RP and DSP. The DSP will never be previously mapped as you indicated.

Are you talking about in the current code, which should have already
reported problems due to multiple overlapping mappings, or with the
proposed changes? Can you clarify the sequenece of calls that triggers
the multiple mappings of RP1?

Also, if EP1 and EP2 race to establish the RP1 mapping, then wouldn't
EP1 and EP2 also race to tear it down? What prevents EP2 from unmapping
RP1 if EP1 still needs it mapped?

I would prefer that rather than EP1 being responsible for mapping RP1
RAS, and a lock to prevent EP2 and EP3 from also repeating that, it
should be UP1 in cxl_switch_port_probe() taking responsibility for
mapping RP1 RAS.

One of the known problems with cxl_switch_port_probe() is that it
enumerates all dports regardless of attachment. That would be where I
would expect problems of dports already going through initialization
prematurely in advance of an endpoint showing up. However, that's a
different fix.

[..]
> >> +
> >> +	/* dport may have more than 1 downstream EP. Check if already mapped. */
> >> +	mutex_lock(&ras_init_mutex);
> > I suspect this lock and check got added to workaround "Failed to request
> > region" messages coming out of devm_cxl_iomap_block() in testing? Per
> > above, that's not "more than 1 downstream EPi", that's "failure to clean
> > up the last mapping for the next cxl_mem_probe() event of the same
> > endpoint".
> Synchronization was added to handle the concurrent accesses. I never observed
> issues due to the race condition for RP and USP but I confirmed through further
> testing it is a real potential issue for the RP and USP.

It is still not clear to me how this singleton lock helps when multiple
EPs are sharing a resource that both races init and shutdown.

> You recommended, in the next patch, to map USP RAS registers from cxl_endpoint_port_probe().
> Would you like the RP and DSP mapping to be called from cxl_endpoint_port_probe() as well? Terry

I think it is broken for an EP to be reaching through a switch to
initialize a shared resource at the RP level. Each level of the
hierarchy should take care of its immediate parent. We need this
bottom-up incremental arrangement due to the way that CXL hides
register blocks until CXL link up.

