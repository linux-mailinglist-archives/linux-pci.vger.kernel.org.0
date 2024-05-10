Return-Path: <linux-pci+bounces-7357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9588C25CD
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 15:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899B81F25C51
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E03112C48B;
	Fri, 10 May 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AODbG/QZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DD12BF34
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347910; cv=fail; b=Fxz9kC5jzUfo+aHvZ8QPqQnSdRznMFZUO2qoq7UguE2rjVtFo6GwTm8Spj/VrW1KEB+kfdLhd/nBaaMVG0Fd5h+P7W+4cGou6poRcjY0p6pvVp4xvfiylCAdYkOLWUAQDlDj+jH7oVqFZzB/uunSv2OVv5ZNyPNCfKkID6KiTcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347910; c=relaxed/simple;
	bh=VGacLX65tZbz64QlzqYTP5Bo45Uoo1GyKXuwYKMXWbw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VG9EVz7qEVs0tfePrYNp+0ZQ3BshyValvBArfYgPffeVZ4LP1HnkXR9D8TC4iLYGYVPi4/NENVq8sTdtLkOqgJkeqf8qTqSh6xoP0pJPwqCP1pubQvxAiYpy6p5d8+hMQhjs+KOADZ01ecFGMcDBW2mMnUitPoEBUhL+VoWDYmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AODbG/QZ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715347907; x=1746883907;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VGacLX65tZbz64QlzqYTP5Bo45Uoo1GyKXuwYKMXWbw=;
  b=AODbG/QZ8m60UTSd9np2GMDOWD1S5hTNRu/o2mv2kyK00ing6R/BIeGW
   AGkBUeKsMQa8kYBUcs4RQfP4QfLH3aezFk2eKd/cJsogp/9Z3AQTVl1/+
   ZrCs+u17udyUKp9BG9NVjvSAHWKFjPoO3h6gyfmjcNI6riTe9vZCWm8f5
   M6JRast6kZHkjn1E7DLY2aNbhLe6uhyGzHRmO+mQ8NiQDKyaXyLMh3lhZ
   N0YWXK5jBYVqmr+RhDAVvFG5MyTTZ5LZOpMPwi3iSv7qdCLOrfFYoDip8
   fNyDaWSia5E3BzzEiw+ZeeK/DBf20SI5gaXvv20hMNBeJwix3qrU5hum0
   A==;
X-CSE-ConnectionGUID: PxbAejeMTZebFncGo4cHpw==
X-CSE-MsgGUID: fHZHAk/7TeqNHqUc9e142Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11490755"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11490755"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:31:32 -0700
X-CSE-ConnectionGUID: CtCQm5zjRPa+AC4sewWkgg==
X-CSE-MsgGUID: b1VSKWVESGi5VZFAUJXjPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30169865"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 06:31:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 06:31:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 06:31:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 06:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2iPmmeQvWBVVryfmjXqCL7JF/aVKbL4iYfox8yirx+U3n+79W2YKZNCV7V9dmxcdskAjDAJ1WRHqw68SSAGFnMduVkQmtlosRULqNkC+G8abcX2f9KLs5kF3Gtl02/Yaegl4oofqCg+EYU0hWUhoQ84mEKzCVtQt2HgfT/T/+e2GNKa1xdq5wqrpSJltmC4S8h24SmwzE60Mxn3fNVwLBDy2NPq7z8Xf0t0Pl0Dut9BpdK42bvqgMD9o8Xqce3SuYBmy3ejQ4a9O68Y3XP97KPf0BJ5tKgwTl8R+lm2P8aBesRp0LcSAQzI2gysj1SE1MdGNHCl7cScPMi9PTKBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NM5mR5OVXa5ntX+UrI/AHyiqADVuEYZz8bHyP7iBJk=;
 b=EsflZA5uQnTDMBrEjU9WzHAPB9yU2IAd7PHSfjz93wOpuIaR3vlQMIsBGpe92Bcu91U2zfoklcOfLVJlaad4iVcpCCLPMpsaNtJuOg/MggBIbZvAPGKKCfqL2N4ZcNnawA8fJA8Cnz4xotVpmL4vmogCM/GwQp304UNva6m3oVLh7rsiqL7XZyK2sV9ppgVBhdDkuHRw/obC6qoDl0HwS7vT+uYs3W6XhVzvKZi86zHO6h/SP0ka1MnZRpXPq/AsIaR/hJ3dk9ZP85ZgiR5qQy+CkNBCjMdcVKjtL18LQcdb8b8zmHBIHvjNONNdDWsJsbA7XZa7KQIDeSv36S2B8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by DM4PR11MB5310.namprd11.prod.outlook.com (2603:10b6:5:391::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:31:30 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 13:31:29 +0000
Date: Fri, 10 May 2024 09:31:24 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/8] drm/i915/pciids: add INTEL_ILK_IDS(), use acronym
Message-ID: <Zj4hrFPSsckxEA5D@intel.com>
References: <cover.1715340032.git.jani.nikula@intel.com>
 <27ada56363cfa6a5b093cb31908a4b89aa912621.1715340032.git.jani.nikula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <27ada56363cfa6a5b093cb31908a4b89aa912621.1715340032.git.jani.nikula@intel.com>
X-ClientProxiedBy: MW4PR04CA0301.namprd04.prod.outlook.com
 (2603:10b6:303:82::6) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|DM4PR11MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: 20544c61-62b6-484f-243e-08dc70f57ff3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v+4UL+N/Kly2Z3Ahbu7rDLOxDFkrBNSPRdwIpfctPSVLb2NI8zNDZNv2yhoa?=
 =?us-ascii?Q?kbnFLJTL9MGNuErngG0T6L4qqkFwBikr3s7I7qGQAnw5DVVXexyLCAnehUY4?=
 =?us-ascii?Q?YE9WpoPFGe6YqwGHM+Tl1ieKKaeS/czga1eFbnupfYa+xNwZFvU9t4fBM20I?=
 =?us-ascii?Q?jGskZ/1x58YFuIMmD7Iowxt0a3jB+FLcvAQPjpC/Okq/yoApnvCFl46LZWLL?=
 =?us-ascii?Q?ITpTDpFEa4dlFN9NhpfKCjhh0r1TjN8AFhdIMA7rXXuvm1AwC0dkFWxTcakK?=
 =?us-ascii?Q?z1bp2eatzYdEgDNu2mzMyXYiX4rzYGm1CfHQGkk6B6t1vY4weFO3x4//ZVda?=
 =?us-ascii?Q?EBdQ3CwfJJzVv8jr5sdnEbc5In008DljaMOiReN5Yhz5zkZEEjBpM9UrhwNa?=
 =?us-ascii?Q?tHheeQIL0Fm/yCZ6rgAz6eSKTqnxfWHCIlX6d/d/7BwYW0lzP6mkiaekcvmQ?=
 =?us-ascii?Q?wW7sGjLm9+2gBGCxHUmDRDoYZnvZwWXM/m5G0ghsvDeOTQV1GWSrhTnQDv8s?=
 =?us-ascii?Q?EA3mM98FEYcfcWKdeAJYhJ45EXl4tnk15FBijU8kOTbBir1aDcnrFHBy96pV?=
 =?us-ascii?Q?kZ/4HXfEYxmLbeZ3OoE0mmSjlzUvjxVsKGtpRbzYhrDgjvSvAIJbV7sf2Cff?=
 =?us-ascii?Q?Ln29QHz7iUp2XcWNDBS3Z57KpmhZY2ueADmgPdl4ykEin64toys5jo2aQ5DP?=
 =?us-ascii?Q?gw0ffeVJ8RMimVgo8NfiRGfUFVzhQUTaraTM9c5OPLuNkcV29Ic5nRbqKt+Y?=
 =?us-ascii?Q?IhvjdYq7b/8Js1jYIE5iprH3L3VbUqq5KyKBFE+Upy6YsPZUwpH9v+4+FmFu?=
 =?us-ascii?Q?BFlnJov6EFGwVwG+w8QO+7lhr7KQbpCjR2Omuz1fpx8GZ+mcHkzETaQW+g90?=
 =?us-ascii?Q?21on30mAnbtNUL8LJsuQo5t366KhpV+pUeNsBBu5glkrurehnqMgmn4Jhfa3?=
 =?us-ascii?Q?ywKzEEewaIBsRadv1ztuaeSPNhZluiFD2+g2KbEZeXFU4Gb5LDl8T1Jr4VEU?=
 =?us-ascii?Q?eADBh5QwxT/VuCdTo7/7EUcRoelxskna5q/LU8luKkiTLB0U36+17DhK+n7U?=
 =?us-ascii?Q?GhdR3Hu9EdEKpnzCTtAiayrZX1hlqA8OMGQhd37NcQNeGWaWIlIYsjqXnNNW?=
 =?us-ascii?Q?IQraGPnYsTOYVDI9tKVG9WW84s55Bif3/uEeuG5AVUSkUz0hJSsXHDVVZdua?=
 =?us-ascii?Q?tzxT6cwO/OjERFuyTG7KJuEPnVdrMCt7Rk1/ZHZodE90o26MpiB6CeJAk5V3?=
 =?us-ascii?Q?xY+5NfzCQW+I5ytOFYDIFUMc3HOFBvmOxzLBrGI0Wg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rZKRNtl44WxUMV/kYfd1+enVF/RXtxaoaQvpaD6yDlajGSkD8WS46vDNLBpp?=
 =?us-ascii?Q?zgX5Ki3CSRA+Hn7INUl7h1+QLTVLeQL6bKQtrpU2y7hw7X0VfQLnQ/giolgO?=
 =?us-ascii?Q?ReMMpdV0b0rdiexFuW0BE9osd3RWiPU8ReU6r/727L5KYgnKNnk9JSq3cjpn?=
 =?us-ascii?Q?wiuoPvSQ/m3I8366tWCtS5pSjFmhyyd9PjHRvFtbxzfUkDO4ECAddE9BD4V5?=
 =?us-ascii?Q?j3IVGAsF0Q+WvC9UFXXI1g3lL/4camVo8bR/dLsTGemXgA6nz3kCbNGgJAOA?=
 =?us-ascii?Q?QokS3EsRIWLYrbtw7WxBk2PuPG2zaHgiY6ewEaHN7UtHdwNrWIZIm4bbtA73?=
 =?us-ascii?Q?fMm5UewtwOOHcOSnCyt7VxY+6j0BA+ZAw8U9k5yMjcYS6V+vudNvKYiPyIfN?=
 =?us-ascii?Q?7Hn1gZ8/+fHcaQd6rb9W4VHT2dQJ3Qt6T32md2Ozn1xmdy9BycCGK5Smt3t6?=
 =?us-ascii?Q?62v3ApwKHhPj4rmHrZ7dTaI8Y29mfdToP8Op6asKHM0jv5lKHfkfBAM6v9gi?=
 =?us-ascii?Q?E4oT7QiX8cYNHrmYjjyzNhGnm6Ysl52yqejc71UWFmasaNkxQb0QqgoB7a3J?=
 =?us-ascii?Q?mpdZYKNNxYxgJ8NhlAoTze17erlMfO3tskHSghnnilBPTlPgl1nfGWyrkjRt?=
 =?us-ascii?Q?wWPokasoGsnzDy7Q7ZTw13AftrvRxJjon2EJ2WFNvNYeoBLEdmMJGtPoXYXC?=
 =?us-ascii?Q?QhaMMu+HYmvTX3oJsBYHo+4fegWVZAJObbhCFLqYqfVNdMh1SBctGO9xpueQ?=
 =?us-ascii?Q?3+ZCeSqlsBxZNhDqUkpalJDcYgPFbo+7UZu3SdZ7269MWE2YySqoqhHdleMY?=
 =?us-ascii?Q?/Yx756SszfafOGs2ZK6CoUXo4k4eQSNeoZgBISER4miD0BQ7YZDdbGZxDsZQ?=
 =?us-ascii?Q?GpTEWLbIdRn3vSKhRBOO1/MdziAzIYG6Lf8C3N1hZqu7O7IEPbV5nAX65qLT?=
 =?us-ascii?Q?iGPdUaE6LiAZgRVAL6ztEfnqKhwQ5gvcTUIpJBF/cKrZ7zzKQwr3LK/TDLmj?=
 =?us-ascii?Q?7L0/N/wOrqNYfRrSXlO9rKshs/H5coAl2kiHTaYxW5NRovDZ11QIULb8iMxJ?=
 =?us-ascii?Q?SmTo1vv/JXtasRJ47FJffsbAU/bgt09y9ELVng3pnenh56jFzDOOPfi7WEPd?=
 =?us-ascii?Q?3Zm6VUoHEwj6qtw5+DVZMwgsEbV5zo4BXd5aSu/chdHowUCwfqBd/6doWRUe?=
 =?us-ascii?Q?AhBOB2LCHWoPY9SkAqtDmzudyomx5FBjSTeTnX+6zPfmSGGM+cWgPLyt3ZD8?=
 =?us-ascii?Q?bqcklMDO8DV59AAs5Hoj3gGO8Z4U1YUVpQWilest5MKBe+HoWbOEtjfEbIGc?=
 =?us-ascii?Q?2b9qeKdlmgRYpdT7oWhVpWP4NO6x261UP5iBZZNQm6x4il+uR5Uo8k6ehE7i?=
 =?us-ascii?Q?1I+1TjwYj5gSsCF6vP2FK7AhjhLGyFel30b7hLDhJuzuUbDAbG9Bs9zaWK5j?=
 =?us-ascii?Q?ABTb9nAIEQ0m26zPaclt8KN91Ug9zfUsNaG/0mY9CjLk5GNADRDAW0fA8G2Z?=
 =?us-ascii?Q?1k1L+ezN49VlPTCxvTKdOeovyNiaPJjVMzJjRxIs3B2W86uZDe6dXPFSqdSV?=
 =?us-ascii?Q?ccj/ylXoa3NmyqiTfZtD+EOCbHh4LLG085fOaviyaJobeZsbsQxhAgIITx0M?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20544c61-62b6-484f-243e-08dc70f57ff3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:31:29.8433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR1/fpLO7xdQOctEK99q5/im528dylJOkbswTBEWy0QGuE79llRn7V7YBlG9aRUyazv6tLBqXsGuOCPIUXJh4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5310
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 02:22:15PM +0300, Jani Nikula wrote:
> Most other PCI ID macros use platform acronyms. Follow suit for ILK. Add
> INTEL_ILK_IDS() to identify all ILKs.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  arch/x86/kernel/early-quirks.c                      | 3 +--
>  drivers/gpu/drm/i915/display/intel_display_device.c | 4 ++--
>  drivers/gpu/drm/i915/i915_pci.c                     | 4 ++--
>  include/drm/i915_pciids.h                           | 8 ++++++--
>  4 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index f50394a00fca..d8419d310091 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -533,8 +533,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
>  	INTEL_I965GM_IDS(&gen3_early_ops),
>  	INTEL_GM45_IDS(&gen3_early_ops),
>  	INTEL_G45_IDS(&gen3_early_ops),
> -	INTEL_IRONLAKE_D_IDS(&gen3_early_ops),
> -	INTEL_IRONLAKE_M_IDS(&gen3_early_ops),
> +	INTEL_ILK_IDS(&gen3_early_ops),
>  	INTEL_SNB_D_IDS(&gen6_early_ops),
>  	INTEL_SNB_M_IDS(&gen6_early_ops),
>  	INTEL_IVB_M_IDS(&gen6_early_ops),
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index 0e0f5a36507d..052fd1c290c3 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -816,8 +816,8 @@ static const struct {
>  	INTEL_GM45_IDS(&gm45_display),
>  	INTEL_G45_IDS(&g45_display),
>  	INTEL_PNV_IDS(&pnv_display),
> -	INTEL_IRONLAKE_D_IDS(&ilk_d_display),
> -	INTEL_IRONLAKE_M_IDS(&ilk_m_display),
> +	INTEL_ILK_D_IDS(&ilk_d_display),
> +	INTEL_ILK_M_IDS(&ilk_m_display),
>  	INTEL_SNB_D_IDS(&snb_display),
>  	INTEL_SNB_M_IDS(&snb_display),
>  	INTEL_IVB_M_IDS(&ivb_display),
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index aa8593d73198..d85f023afebe 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -812,8 +812,8 @@ static const struct pci_device_id pciidlist[] = {
>  	INTEL_G45_IDS(&g45_info),
>  	INTEL_PNV_G_IDS(&pnv_g_info),
>  	INTEL_PNV_M_IDS(&pnv_m_info),
> -	INTEL_IRONLAKE_D_IDS(&ilk_d_info),
> -	INTEL_IRONLAKE_M_IDS(&ilk_m_info),
> +	INTEL_ILK_D_IDS(&ilk_d_info),
> +	INTEL_ILK_M_IDS(&ilk_m_info),
>  	INTEL_SNB_D_GT1_IDS(&snb_d_gt1_info),
>  	INTEL_SNB_D_GT2_IDS(&snb_d_gt2_info),
>  	INTEL_SNB_M_GT1_IDS(&snb_m_gt1_info),
> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> index 21942a3c823b..05f466ca8ce2 100644
> --- a/include/drm/i915_pciids.h
> +++ b/include/drm/i915_pciids.h
> @@ -118,12 +118,16 @@
>  	INTEL_PNV_G_IDS(info), \
>  	INTEL_PNV_M_IDS(info)
>  
> -#define INTEL_IRONLAKE_D_IDS(info) \
> +#define INTEL_ILK_D_IDS(info) \
>  	INTEL_VGA_DEVICE(0x0042, info)
>  
> -#define INTEL_IRONLAKE_M_IDS(info) \
> +#define INTEL_ILK_M_IDS(info) \
>  	INTEL_VGA_DEVICE(0x0046, info)
>  
> +#define INTEL_ILK_IDS(info) \
> +	INTEL_ILK_D_IDS(info), \
> +	INTEL_ILK_M_IDS(info)
> +
>  #define INTEL_SNB_D_GT1_IDS(info) \
>  	INTEL_VGA_DEVICE(0x0102, info), \
>  	INTEL_VGA_DEVICE(0x010A, info)
> -- 
> 2.39.2
> 

