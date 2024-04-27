Return-Path: <linux-pci+bounces-6710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515D8B437D
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 03:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386C51C20325
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 01:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1002E403;
	Sat, 27 Apr 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="At7Ac59Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8662C6B0
	for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714181280; cv=fail; b=rHDq3GkxX8zBhQihmYT+IYEkgVAGdJ4doNyzAFgw6H0acWncgDE+23wNqUOBUhbsd+IefsBIMDV67OG7U5isZC/XLfQ0/YcMtGrauv2beCzBgPQQJlJZff6mWrVeZ6bC/2yGy04zLzbrqL+s/UW5qoqU3e6Nhd7mNBEP68qYh+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714181280; c=relaxed/simple;
	bh=awie/jxEgU//zKp2xe/kZhNY+tfaV9Be4/pUMaq08hk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K9vpTgiv/FrhwpPr5dPn3g9nriouInKzTk5Ict6zoNzJSU44FpBuqbXDdXRXmcLUYAmRmcNeR9LB7EtI72jkVAXpqz9mkPG5NGe7sZhYEdy4yyIKhXecPbgxiE2UqTojmtwzpn/hT1XMBd2MSFcBRa4E5ETdnhaymvfhP4EGM54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=At7Ac59Z; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714181278; x=1745717278;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=awie/jxEgU//zKp2xe/kZhNY+tfaV9Be4/pUMaq08hk=;
  b=At7Ac59ZzYfKcJOa3zmCeP//+Uru2NuktQTAqEewoVhNXPz24A3hhlJ3
   k02Hz7fy5QWBzSlEidLhlrUOF6FXgn7XkzqQ5PnWT+FFY9MdQi+u6u340
   H8vJvNywY6V/KK2YaUSu2ACWgQLAnMP8qDQQq9LqfrohsXXuG3DaWgkGY
   x6O0IyrajGwuVtFTs6vQ5ypuSQOE6CS/Jytd81wnJJfz7lBp1tFVwsFg1
   Vn4gujvsEEw4bFLH4Nj1KuBxhCGX+OOka62PsvxPCu7+oZiEyw70dDV8C
   jzrXoI9Ut5XLrGeWfKCITSwj4pRYfCeB+o+PhJvobnQd/95UTB1dKl/BX
   Q==;
X-CSE-ConnectionGUID: FNqsf/u3Rnmgl0d/wYJdkA==
X-CSE-MsgGUID: 2/sOi+UqTrWEXLofuDMahA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="12867693"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="12867693"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 18:27:57 -0700
X-CSE-ConnectionGUID: vuPcW6ZzQbqp5wtrsbA1kg==
X-CSE-MsgGUID: mdvfrpBERU6GTlr/S2E6tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="26217765"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 18:27:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 18:27:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 18:27:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 18:27:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jahc3GAGJ105Kl4b5KxPjU7uDwfSCLy6xZ00xlLL1zbm9Z1OwAcKzXO5TQ6hd1K06rTL8zB3XLn2Wu99EVpXlATRW2Gtm81V2LHnJGr18iJ9+gpyfunoZSGCkA2dfS3AoFpZ323BdgCiBNrpdpXBu5VnbQLB5/Mhg7HaBNkEkmnrVg7XA4H6zR+NO4LGpxTPjdKBvutfK/moNUXKt1oLFKe5uDdn+6Id0aZLAPXYG3F/nhsB7CwPRrnlErYdZ6/0+h/Tip/KOMihStF4tcIJJh2RKcH0HpIDn3MV6EnwHYw1fzBVJjIPdeMIS4bD6aTmD9Vtljc2RayAb6n37nslDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOZwmhjL+3GuKIV7hAY2Tb2CH6R5giGudKn+6gnmRrI=;
 b=hBivuYg+4KByGuCcS/OmcBgbRUS12qsJ+twkSafDDIKjdkFJovZAmwqmYPNdbmZZ15UeXEzlSxjHIi+L079czGPNN4ArCiYvzhnBAqWjgM5xazBKrsnOSTi1crVfu9jJRhB+HpS3jaTPDY7XiablqFvgg/kG1aXJgiEAdyf6EgUJ6qZAnKHT+YY3m6jetIebCEfeskocG2AnFBBcDuoxu4x3YCbqZmC70N6sEnyPFCyXyiIFAqlhVB+zumlg5OH3npj0bTBgEMfJwdWY2eEwB2Dr3pZTE+VY1VN1FOrKLp3H2qBuaMmePH86zob+MJTa+KoQWu0p4SLgW06itMhfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7343.namprd11.prod.outlook.com (2603:10b6:208:424::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Sat, 27 Apr
 2024 01:27:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Sat, 27 Apr 2024
 01:27:53 +0000
Date: Fri, 26 Apr 2024 18:27:50 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Wu Hao <hao.wu@intel.com>, Yilun Xu
	<yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<kevin.tian@intel.com>, <gregkh@linuxfoundation.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH v2 5/6] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <662c5496d5b9f_b6e0294ab@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>
 <20240419220729.GA307280@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419220729.GA307280@bhelgaas>
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a56c766-5fb8-44a9-5faa-08dc665942a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rH2CXmvA9Bvzu0NnFGYD2ffif4XRfVkhFp7Q7IHdjOO5djoXja/WUTddeksN?=
 =?us-ascii?Q?XXH1sZ7kWbFAELIKWzexr6/XI2EDhRfE6/KZC2b+rjd2BnJCyYyqlfJx/CBR?=
 =?us-ascii?Q?PW+xkqgcOUKAeFcWoazhDy7kRFBlEUNPCtFYXetSFYbJ6F30mmQ+TL3yca/7?=
 =?us-ascii?Q?dnhIqp5oqbUjYFq7Ra4CSf9+ZYBqR7uDBJ4VQHvlG1sVIKyT56IzGBEcpiD4?=
 =?us-ascii?Q?PpHtqCAa7xBmlQicecxQgcTyDfYrCJrVYMp1NfU4oclohQBoGUMzJnId8eBO?=
 =?us-ascii?Q?ohTt3IUgskDclpWAz9kd7deDryEHlztxNQ6Xv2lihyTk+WW+dWf5rmZFY+bs?=
 =?us-ascii?Q?pGfBq6hIWPJe/SJIJTAtpo5LfhzRS418wemj4Za/AGZOYZmbt5FanDrJfWzd?=
 =?us-ascii?Q?0mlbDXC2Zft5TNxG9oNO6MrDkWT0fyhMo40kUiy775zQUzDKBabDLacDlTtd?=
 =?us-ascii?Q?2nF853IxEtr5usJapnFB0WSRXuwl6qSv1zhxg4Qxverute/XWHpILXnkPA1Q?=
 =?us-ascii?Q?7pGjqg0jWiizS/W+YeEz0gay3BpkSZsWL761JqI/19/sdfh/Ju4E0grJsvQs?=
 =?us-ascii?Q?TbxkhVsWguZArcHWc27g4sgYa9t1cdOWIe9aw8M88eQUzRw8+9KiraZh83wR?=
 =?us-ascii?Q?9iODaN6H6wWmp4Txzpo4AQkgAj3wyk3mHqeCDSxkbSto37+6WJ/M6EeDElR6?=
 =?us-ascii?Q?zksGdfvF+4+abWTvLliMdtEMriJk1OOgseIAXFe+RQcIvFIa7VthB8FizADP?=
 =?us-ascii?Q?qoIyzOqMILTFjJ/5C0yfzaUHUpX9C9O3tKk0K/OUSYi6xYKAV0Gnh9cZ+hX0?=
 =?us-ascii?Q?pkHJR0PaVfQiurawTWVsFdc21igG4CCwhNtSoXHZ+/bAWVCfH8+ZQg1PAUdW?=
 =?us-ascii?Q?KoQBr2YUogJ/zgwD4bLCrSsu0BnDxJ9vD8T/fg6RSFgGyjQLeUu1qcb/OuLW?=
 =?us-ascii?Q?B3FlskLw/G53qhVnIKg9PTegky2R7Ca35SQBcPIMLpLymRQ1N3Xmwbz9Udq9?=
 =?us-ascii?Q?wMifoGnelol7OXje59111Jv1apboQRLf+iRXa8kESfwcb2tm1u535cV3KI3T?=
 =?us-ascii?Q?JUUTdzTV/U34XUEwYDi6FH4SzLYwiO/bOje4dft0u5oeaFjG5jvACC/YgZ6Z?=
 =?us-ascii?Q?SpxdBAMcFvQODeqfVrSLzgBiVNN2XEr8+GQRRLjjQVhLHOVHSvR8KfKkfnYd?=
 =?us-ascii?Q?fy3w8Vq0hNlfECKBfyGpYc9k0gr/GScF/h9Juufmq+6pyzD6dXS8ha9heCcR?=
 =?us-ascii?Q?JpURRaSNZKIo73hFj3HbhhpxxjjZDo76sQH/TDo9vQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ApD9OMFFPDXlb/Ci911Mg4zoM43mSp1lXzfe0k8Sv4d4DmpfthqSc+XrIu0?=
 =?us-ascii?Q?/SrB12Zql3rkNEyg/CS7lpf7CewIOwKLYWRJra9cysgsAs5xDClW8CubzTAX?=
 =?us-ascii?Q?v0t1aH6aPSp8Wp8CDLOjvjvk02farUvn4qlgowajh9QlEZ65H5VAHFnnI8xU?=
 =?us-ascii?Q?Zrv28/1dtkYJO3FfIqNZFSTFa8a3YIIwTMM95Dy38Hls4648scAKBer5POep?=
 =?us-ascii?Q?s0nOv5nypkyQ0Ycqqo0pJNVWOy+tKkLyAurYSEFaT7jebtBWsVameSjTNQhH?=
 =?us-ascii?Q?7FriZGwfgtnpv/iax2O7FHP904sSuQC5VPm00s9bWU9aaY2pOJPJ3Xbbt1oY?=
 =?us-ascii?Q?x9LahuN4b8tRfO8uHZfgw434cbC0whuI2XRA0++IBqGHUISlwjzc5T52jFCO?=
 =?us-ascii?Q?RvIwoz8n/M4HtT+MK5VdH+V6t/Fbdjovg1AM8cyaZhhNcnin0NrLTHTmTz5e?=
 =?us-ascii?Q?xt6qsFPG3JtkcgWUI7d7c0Jxu6ILbzEGqF3Mn6j8zpgGA4nSxVqIErP6lrU2?=
 =?us-ascii?Q?s7nAJM2lZZ8vxboy5ILF/bV7DfUEV8lnyJqJgGqau5skl2iP0NwJuJiTLwRZ?=
 =?us-ascii?Q?bYz+JCw5J/S0MxEO5DAXZjBrbL6YJr8qxtxaP2fr/y7TzQP4U+2LOVkcgpbN?=
 =?us-ascii?Q?f/t5wktxZS0aDR8FhQWycv+Vr/MzOsrSYTrqo7mVdonSGL0Wloc9aG4JPhxo?=
 =?us-ascii?Q?0BWyNM7kBEAOTHbwuCwZ2I7akB6qGTRHzFfifjXh3Q0VymJ8PxYhxcKK9Ku2?=
 =?us-ascii?Q?jwOoVwzLx7Rp063JXqUb6vXOvFG+zVjAHKo1xQFFubTaOULdmtmf7inUZYTH?=
 =?us-ascii?Q?CUQBqPi/fcx60GokUQ3GO87dt6kg3HP+CgacR0roCfFWKqRSIHdmNSapZ+wj?=
 =?us-ascii?Q?awQaB92ZML04sA03JbUB5PT/KkMW9uembUZZ31ppCESijtu8hk8pTX/6tAEj?=
 =?us-ascii?Q?nwO+6oeePYgx+os5TCdAFOyohcNr+nVgU2eYRrnGHLyCYKox2/B7pCO4OVTr?=
 =?us-ascii?Q?nuHvIDz1PuDxAIFckYIUrQj2rmmwNWl5EQyBZ7ocO1udmYPxJ8z70tAZEcGu?=
 =?us-ascii?Q?ZFPtbDC3wsUrWuyqYNYaunk5KOMjHvd9wLxLisBQbYnfgehMbHrVXWdP7C55?=
 =?us-ascii?Q?LKgonXr44w/ND9W+pJ4uPscddyJdi9pMc9nzGTZoIStXCZbIp0M/ottLmvZM?=
 =?us-ascii?Q?G87gk4r0O+w1FLTSXUeT/Nkmp9flsWzZxh+RsfdKhH+vHrHWCgKVpgaqOrXW?=
 =?us-ascii?Q?oaxlEKRMnOZk79X9PD/sSklME0nFrCaGE9Ic722gw0w5ykzPzQzMD/e47Z+s?=
 =?us-ascii?Q?8DykPXO4FQOBpOyG1r+hOkVVRv639vR7dIE7FNDYoMWVhQn/8/NYBU0OhVnr?=
 =?us-ascii?Q?Uwfyj0zJtWm0stk1O1WA0go2YvcH2yMYOubJDgv1P12qtJ14vGB/WiPXHuud?=
 =?us-ascii?Q?vewe4oTPrt++PZHSIDFQ0HZOjv2rdjEA87ePynmvTKhPsqmoKM9i66EhByv/?=
 =?us-ascii?Q?d+YcNA6z71aeMB0XRCGE5TB/EuJPXERxO+Ryctsv3/doh4cNrZtotxFZHkhU?=
 =?us-ascii?Q?lquU+JDgW9wCvYNaqBbN8oZptDd7zOFKSjItrX3cmhNYG8oxq8P0OAsVcCiC?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a56c766-5fb8-44a9-5faa-08dc665942a4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 01:27:53.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0WU0Z7U1vXdCTP3TfzhQ0Rv4T7OFw1QT6hvk79mqBvcWWTTA3zt+1M11XFI3ldv2GjHEQh1cO81oWGyw2gIT9Dczw3jsX4ROlBSLWZdUps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7343
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Fri, Apr 12, 2024 at 01:52:13AM -0700, Dan Williams wrote:
> > The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> > Environment (TEE) Device Interface Security Protocol (TDISP).  This
> > interface definition builds upon Component Measurement and
> > Authentication (CMA), and link Integrity and Data Encryption (IDE). It
> > adds support for assigning devices (PCI physical or virtual function) to
> > a confidential VM such that the assigned device is enabled to access
> > guest private memory protected by technologies like Intel TDX, AMD
> > SEV-SNP, RISCV COVE, or ARM CCA.
> > 
> > The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> > of an agent that mediates between a "DSM" (Device Security Manager) and
> > system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> > to setup link security and assign devices. A confidential VM uses TSM
> > ABIs to transition an assigned device into the TDISP "RUN" state and
> > validate its configuration. From a Linux perspective the TSM abstracts
> > many of the details of TDISP, IDE, and CMA. Some of those details leak
> > through at times, but for the most part TDISP is an internal
> > implementation detail of the TSM.
> > 
> > Similar to the PCI core extensions to support CONFIG_PCI_CMA,
> > CONFIG_PCI_TSM builds upon that to reuse the "authenticated" sysfs
> > attribute, and add more properties + controls in a tsm/ subdirectory of
> > the PCI device sysfs interface. Unlike CMA that can depend on a local to
> > the PCI core implementation, PCI_TSM needs to be prepared for late
> > loading of the platform TSM driver. Consider that the TSM driver may
> > itself be a PCI driver. Userspace can depend on the common TSM device
> > uevent to know when the PCI core has TSM services enabled. The PCI
> > device tsm/ subdirectory is supplemented by the TSM device pci/
> > directory for platform global TSM properties + controls.
> > 
> > The common verbs that the low-level TSM drivers implement are defined by
> > 'enum pci_tsm_cmd'. For now only connect and disconnect are defined for
> > establishing a trust relationship between the host and the device,
> > securing the interconnect (optionally establishing IDE), and tearing
> > that down.
> > 
> > The locking allows for multiple devices to be executing commands
> > simultaneously, one outstanding command per-device and an rwsem flushes
> > all inflight commands when a TSM low-level driver/device is removed.
> > 
> > In addition to commands submitted through an 'exec' operation the
> > low-level TSM driver is notified of device arrival and departure events
> > via 'add' and 'del' operations. With those it can setup per-device
> > context, or filter devices that the TSM is not prepared to support.
> > 
> > Cc: Wu Hao <hao.wu@intel.com>
> > Cc: Yilun Xu <yilun.xu@intel.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# PCI parts

Great, thanks Bjorn! This lets us move forward on the TSM details
knowing that it looks like this meets your expectations on the PCI
integration aspects. Will continue to include you on revisions as this
evolves, but this is good news for the cross vendor collaboration effort
in process here.

> > +What:		/sys/bus/pci/devices/.../tsm/
> > +Date:		March 2024
> > +Contact:	linux-coco@lists.linux.dev
> > +Description:
> > +		This directory only appears if a device supports CMA and IDE,
> > +		and only after a TSM driver has loaded and evaluated this
> > +		PCI device. All present devices shall be dispositioned
> > +		after the 'add' event for /sys/class/tsm/tsm0 triggers.
> 
> What does "dispositioned" mean?

When /sys/class/tsm/tsm0/uevent signals KOBJ_ADD, arrival of the TSM
device, a udev script can assume that the kernel has walked all PCI
devices and toggled the visibility of the all
/sys/bus/pci/devices/$pdev/tsm/ attribute directories.

> What devices does "all present devices" cover?

A snapshot of the state of /sys/bus/pci/devices at TSM arrival. So a
udev script that, for example, wants to perform the TSM "connect"
operation as soon as possible should watch PCI KOBJ_ADD uevents and try
to connect if the TSM is present at that time, but if not, try again
after TSM KOBJ_ADD.

Similar for the PCI-hot-add case. TSM may arrive first, so that policy
script should recheck when PCI KOBJ_ADD, for the device it wants to
connect, fires.

> 
> Is "tsm0" a special global thing?  Is there doc for
> /sys/class/tsm/...?

Yes, it is a special common object that any platform with a TSM will
export. I had yet to create a document since there are no common
attributes defined in this version of the patch set, but I can go ahead
and create it and mention what userspace can expect about the state of
/sys/bus/pci/devices when the device shows up.

> 
> > +++ b/drivers/pci/Makefile
> > @@ -35,6 +35,8 @@ obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
> >  obj-$(CONFIG_PCI_DOE)		+= doe.o
> >  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
> >  
> > +obj-$(CONFIG_PCI_TSM)		+= tsm.o
> 
> Maybe put it next to CONFIG_PCI_DOE or at least not off in a special
> separate list?

Sure, will do.

