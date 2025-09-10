Return-Path: <linux-pci+bounces-35796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A85CB50D47
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 07:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D958D3B92B3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 05:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C540A31D39A;
	Wed, 10 Sep 2025 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzVUkIoQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44941C84AE
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482273; cv=fail; b=sAMlo2rp997M9M1t8Cdt9ZewnAMO7w0lAl9A6lLLmGI9vVIzrUL9Mj6+yfsrsrRWGjGjxaDy2CkA2XIhnRdFjcz6jfBSKcp65iN3Xnybzu4PIY5z7bnj6UUD7eOlHVjaBUiLWZu7yZB3241RGtn6vdns6ePTgP2NbzkNdBEw0+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482273; c=relaxed/simple;
	bh=Z25cFQIB8lFtosUzHCXJAuXp6Ut5KsSYO7fPkZFLGzI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=DwRm81wR6ixhqpx8yLnOXWmZEyuQlSF7FkIIDkFVmMXNf/nOu+KxjSXjvtsptv2v0PQl3ABf2/pxz5mV6ehQD9DR8mzCBitAkwOrSzmNDtD/i0It5XQfXQc8St3GmxnP0SxSZ1rPp6DwK/+O5nJDBtn6i5gDlLxk9kJ9EgLxqTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzVUkIoQ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757482272; x=1789018272;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Z25cFQIB8lFtosUzHCXJAuXp6Ut5KsSYO7fPkZFLGzI=;
  b=YzVUkIoQirVYMi9GA32rYVWuYU3rMGiWC5/WkbryTPupICwAUlj/jW1C
   xkTetVBODr0dwWuxEyMQlLwyOixRTb5ys62GOyWJ6lv7WJpRU5X0WImhc
   lBQcEJcEzBKHK9QqtYxMX0oQlQeL6zjMHB+4OI2yXLboVA44qnb5TVXdu
   5Jp95NZBqOAvHd1KtUOEmWVkJjcJmHYfoxqAWK8OmtynyGM84TnRmS5a9
   IbRkUlkMltsLWQXBRaeKfBRWG1j/31QyFaPZ9hhFBFZgSkllwpHxSJ8HU
   ZVKTl0CkUVDAX7hY3i63OGqKZpENu4vIQ6qs8Svf0uNB/piChcztMGGT8
   w==;
X-CSE-ConnectionGUID: wG1icqJIQX66H9+EjwFd7A==
X-CSE-MsgGUID: SulVfv6ITaWobRrxzOofZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="71197515"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="71197515"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 22:31:02 -0700
X-CSE-ConnectionGUID: NxXW8NRSQ/6lXoxMrwIJcw==
X-CSE-MsgGUID: /UvYkuoUQN25MtPXB3+ZHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="174073316"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 22:31:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 22:31:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 22:31:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.78) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 22:31:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSxjupa80AxE76Cv8p8/ntwQQXWD5k5WxheK3cnOGjFcw2v27Xrz/V4dRSjB+HOcWVI8f7S9WW9TiXeaKYKeZTs0Ybddrsm42voIsNcVoH90nF+n9iSRkWT1b869Ka2Ie59qURl+SgA9ALtIf+Amvn2F6mqFLZ1fMMUzA+hPp/ccj4Nfx4gv24c3UdlQMiWZ44wT3trJ3e0snH1Hbqqp2Lu1slBPKD7ZJGZS/qYOZ+/YF3bptCxvgh1CirQLDij/boWk9LHJKoeOqcZw1oBfdkpyTqa27HZSRDSNQm2KgYmVLSaBpwrG+6CeSea1XnUXvets16JzvzXILvmcGg54Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEo9lSZhRcBEB/BiYFKRmK++tz4pTxryQ611pFkuqew=;
 b=R5osZ7lZj5h44/VIHOCI67M51swGDgC+Af4g84nN744O0VESeTJsZffa1ajoRBISHCG7LgmXTMMkJ7cKfuUelMUkVMfyNZVwN+1Piv6FhtdCjroPhiWmlauNHDQ7b8CDU3VGZQpftqi3KdrJh7prEoFxEa0VBFCSx+wpq6YzMlAFE0BUmeRaTNWNR4pf8v6cN9GnI4DbRsR3zizyIrm/WBOekQlxHjQ3GIHNkxXZQv1BR/b7VlCul42CdX1/9bL7VokCAJUXRPFu0RA0s7vmk1tO9qtazD1KwV8s/4gn/xHDk/H93GliTeKmBd0QuV63o61kHXYQF5T5NmDrklPBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7946.namprd11.prod.outlook.com (2603:10b6:930:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:30:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 05:30:59 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 9 Sep 2025 22:31:05 -0700
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>
Message-ID: <68c10d197df27_5addd100ec@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5aplc61crg.fsf@kernel.org>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-6-dan.j.williams@intel.com>
 <yq5aplc61crg.fsf@kernel.org>
Subject: Re: [PATCH 5/7] PCI/TSM: Add Device Security (TVM Guest) operations
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: d42a9bc7-88f2-4a5b-d8eb-08ddf02b3940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L25YOHBmeDBlRTVOSzhSTFVkdW8rVUp0bWNJSXp4QnVJVENZZ1c4bHdYVEV4?=
 =?utf-8?B?RWFOMVFtL0NjWEMwTTI1akJEYjVvQW0xTGhNUi9Kb0lsbHJDN0szMmhtTVNG?=
 =?utf-8?B?SWdYMk9wSlE3eHlmbFZVdkJGRGpWN3JnODBkb0FqTEpIdHNrNGErVzZRR3Rt?=
 =?utf-8?B?eTZvVStxU29LVWx3Q2tQMmJSRzhmNHNLRlRXWmtieDFjRllHeUQvRHRHWDdN?=
 =?utf-8?B?SmliaENVaGNBOGt4OFZ1OXVRNDlNQlVqUXhEblJjYkxnTld2ZU91MHJQTGY2?=
 =?utf-8?B?VWF5QW9oVTFBeEp1ODlnYUZNSUt2VFI5YmJZU1hjWmd1OCtyRm4yMGs0azAr?=
 =?utf-8?B?SFN0QTNUZjQrb0ttb0ZDSTQ5R0pmTkNOYXlZQWg2MS9GWVFyRUJnM1NhTEdy?=
 =?utf-8?B?QUVIaE5GNGlHeHllaW96TE55c0pVN0d5YUs5c1JOTkJQRlR1bU5YdEJVeTJC?=
 =?utf-8?B?d3dMWnlsRWdHUmtDakNXNDN1aHJMKzZTK01ubm5kTndzT3JISXhNV3lLeHhR?=
 =?utf-8?B?T21WUXNyeEpvS2QwcTBJZ3VaRjB5QnBUWEhsQ0xrdDM0VVA2ZXlzeUJTRkR2?=
 =?utf-8?B?UkQyS2VjUUNudkI5T2E1WU1wTDFwMElwb0d1RWJpWDExaXdwa1RLWVh0VzJD?=
 =?utf-8?B?ZVRheGREcWNHNUVVTGhlQmJOWmd1d3BBelMvTjRldkliVFowMy93amx0TTJx?=
 =?utf-8?B?VFRJdWJ2UzlTNHVxclF3aHgxYlF1b1ZGV2JFQlFCUXZzVHJDcHpQWkVYY3Fp?=
 =?utf-8?B?MzkvZy9EbDM4VVZ2VW9vYnJXQjJ0RWRmRGNWQTJXTi9BWVpCMmREeFRHbnAv?=
 =?utf-8?B?aHRwN0RydE5aZzdheHBhTVk0L01aYnJpTVJ4a2dKNDlkZmxCN09tcUkxcjlr?=
 =?utf-8?B?ZGJYL0NjemI0anUwZzRqNFN4UlEvRGY3WmtFVUpIc1h5dDQxU2ZUUTBDS3hw?=
 =?utf-8?B?OVFZcldibUtVM0Zwdm9hNjArVFhVUDczM29KVmxhK1plVDhYbjEwSDBaN0Nv?=
 =?utf-8?B?RDk3TGIwM1BBcTNJRlRRblRGaDNBOHFkdHNMd0VhWVpkaytZRDZvMGxtY0sz?=
 =?utf-8?B?TFIyV2loQzhTb0RDMnN0SmFmQ1ZwVWRzUmpYNVJaeUd3RkxXTUM4SnNsd0pC?=
 =?utf-8?B?c3hObXpLeC9Ic0FhdFFCQkEvbUlqc0gxdWpqeGczR2pEdnhBM2VRZWZzZkt6?=
 =?utf-8?B?N2haNDE5Q2VuRmNSNlozUTE4YTQzcGE3anlUK3pxV0tkZ2Vxb0lBODZDSlcy?=
 =?utf-8?B?M0w1MmRnVEZUdWYyVG1YRFJYN1ZFQzZSU1J2amE0aWFaMFJ0ZG9PSm9CbjQ2?=
 =?utf-8?B?UGdsOC9uQ2RaRkN5VlY4VTYwUngxNGdOR1duOFVXMGs2UlFkWlM5amx1ekdB?=
 =?utf-8?B?OC80RGRKMDh1K0hFNUQ4REpuakJWb0hSeDdnaHJUalBJa0pKZW1Ta1NvS3ds?=
 =?utf-8?B?NnVEV3BkZ1NOVXlKQ1ljU1ZFVVVOMzAvSUQxNTZBZnZwZ1ZrNHp1MnZyanlI?=
 =?utf-8?B?NWlRY2tjVERvRUQreTdmZ0d2alJaNmtlOUtSRHdJdWFuYnJGWm4zdGsxK0Jy?=
 =?utf-8?B?YjgrdEtBdW1EdjJrNmQvTmduNmM5b2I1NGNUeEVQNnF4RDFuaXhoeXBydFpI?=
 =?utf-8?B?cE1VVkVFb1Y1Wm5sT01JWGgrTERsTGFKNUpWYVJpMWJ1Wk1zMkNmMy9DdStr?=
 =?utf-8?B?RlRGd0gyeHl3Q1RTVCtOS0hybzhTTXdzMkxJcDVkNFliaGU2RkZnSWNrV3FV?=
 =?utf-8?B?N293Q2lkTkVYZjg4V0lmbkJYOWJhSENEWSs1enJ6bS9LRXpPdFVmR3dWWDdh?=
 =?utf-8?B?eDBWMFBNVHNzdkR3SHFySlRkMFBJQ3ZVdDFFUXJ6S1RCc29lKzJEMUZyNTBL?=
 =?utf-8?B?MUxHNkdkRjEwYnZOczUzRlhxanVaMjR3MUF6OS9sYUE1V21wQjZ6TWs2eXZy?=
 =?utf-8?Q?kW0OVK7v40w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3lkY0VnZ2pPU2VUZUxVRm5aSHNFL2p1WUlOSURKSVQvdnk0WWExYU5NNVlB?=
 =?utf-8?B?cUF5N1d1ejR2eW8zeVlCQTRrZ1RtM1VUcjdGdlFKN0V2TEZMM3hTSCtsaC9U?=
 =?utf-8?B?cjdYWTgxS01Gb2VjV3dMcGd3akdac3pIZGprZjdJM1R6dWYzUmM4eFo4Z2VJ?=
 =?utf-8?B?SzBQUmNnRFNCZTl2Vy9WZ293M3VsUk5NK2VRcHBRWVBDUFA1aWp1dDFuZ08y?=
 =?utf-8?B?YWwydXhEaGpnM3lrVitDbWFBSFo4d0xqMXkyVVlJT1FzaHZkc1Q0Z2pRZTdN?=
 =?utf-8?B?VjZyWlBTc1VOZkdLTjd5eGNGZTFBM3ZOL214NFFtSGljQ3doREJsbkNvWDJi?=
 =?utf-8?B?Nko1MlBKb3dvZTIrN2g2c3JJeWJ2UjZwanU2SlZTc29qWDU4a3A5dVcvOXBF?=
 =?utf-8?B?MWR0NFpxRjJVNzFSSnpHQzU1czN4L0dVclFZSzNjNnh4Q3Vta1U4VVF6WWhU?=
 =?utf-8?B?eFU4SFRzQVdjQVdldnNTemhZcUMxYnFMN1pkVTNYS216UTlKS2N4cnIyNGF1?=
 =?utf-8?B?MU4vbkZpVlNUSU1IaVJDb2hOUmlYL0U5NnRTaDczWUEwQXB2eEVoSE5hc0pL?=
 =?utf-8?B?bXB0eDVQTTUzWm5SUG5vTC9vS1B0Y1Z1b1pjeDFrTm85dFRrZ01XOG5hYUs5?=
 =?utf-8?B?ano0OTY1d01kaXNnOGtKUTZaNU41Vk4zYittaldNdTRKTmVFWEVlVi9YQWs1?=
 =?utf-8?B?bjYvRi9peXVRSnBuU1pUZzcyRFQ3dTlpYlNaMFA1NEZ4dGllS0Q3QmZLQjhk?=
 =?utf-8?B?ekhrTmtMZzhuRlJlZU5ERkZuUzFLZ1JHc05DN2poVERpSzVjYW50SXYyUU83?=
 =?utf-8?B?b3dWeU5mMlRSVk5hS3RXYldqUDZIN3NSOFJTZDFhQmJiQm5YdFhtcDQ3RmZ4?=
 =?utf-8?B?ck5lN3BsNVVxV0lxellNTUFlakRWNG1nV05GSWlTeFlockFDWWxWUXpqWkdE?=
 =?utf-8?B?UThoYWVXa09ZVVJ3Q25IcXIwclB6VHNQUGxwcFZDV3VqdDg1YnRzKzNLVzJY?=
 =?utf-8?B?TVVlTXFhRWVBS01TMC9wcE9SbXkyVkFxZEtaYTdLZUNsd1U2eVI0Z01GcnVu?=
 =?utf-8?B?c2p5elR1MmMzSmJGM1VxcEpHYnlkQWxnN1dUUHg2ejRmUXh2eTNoWHlPeE5E?=
 =?utf-8?B?TXovUEZvRlZsTEtkNXMyZ1d0RGNLa1Z3cFkrS3dZUXo4QURvMllGTUp1RnVp?=
 =?utf-8?B?UElGVE1HVWRNbUJRWXY1R2JXUm9pOTh5Zm9NSmR3Tk91K1VtNDY3ZnZCb29m?=
 =?utf-8?B?emFhc0s5LzhBU0g0SmtGd09IdUZ4RS94MHBsQnk5TWx6VDdtT0xuT0xRWFNH?=
 =?utf-8?B?THNGNjN2dW5RdVFTcmtENGkvd0pHbVJreU1pOS9UZS9odDNQWmxLY25wYjZW?=
 =?utf-8?B?aG9XOFpJdEtBczh5S01IaDgrVUJseVk3MXBLbE9VdjRhYm1WNnd4b0JJbWlP?=
 =?utf-8?B?QXRzeUVndHNJUGdjOEllais0aFV5dFhrSVN2YzFNdi9TeFlYUWlHa1RBaThn?=
 =?utf-8?B?Y1VuN1REdGllYkQ0NFU5eFJoaDJlREV3UzNBUWZzT0lFYVZrMjh4WW50SWEy?=
 =?utf-8?B?NlUzOE9QVkVQcDVXN3ZzZ0pLblZpYnNGbllrdE5qS2txKzVIYlQ3alV6UEVI?=
 =?utf-8?B?YTQ0YmRDK3lOWmhnQzlILzBURS8vczBkWlpEUUovbDBVS1d1VGtodk5HRXJk?=
 =?utf-8?B?NmowZ2orcW9QM1VRU2NWdkpyN0FvVWZSYlVQTmh2cmNGeWtwdU9aajZvcDBV?=
 =?utf-8?B?N3RncUN2aTRNVGVldmRBTnhjOTlFc3VWa3JOMzR5THRkVVpTUkFKV20ybzFS?=
 =?utf-8?B?QkFpYXdzNGY0SWZmamFnY2xKN05talJkT0ViV3N3QWZ4TmVqQXVabWtiZEhS?=
 =?utf-8?B?YjNWQlJWdjk1cXBMRHRCeU9Ub3czWWxjdlZFZjhwVTFVTGlxUzBUeFZPYzhv?=
 =?utf-8?B?VTVHM1psZTcyZlZKS0w2YjhQZWJJdWpzbkhtSEZIVlJEZ2tZSFlBT1lvZFFB?=
 =?utf-8?B?U2xpVVpEeDM3QXplVldLanR5L3VseE5pUjgyYi9iRE5keGV5MVdMOFVmam9X?=
 =?utf-8?B?aWpLamEwL3I2ejd6T3VaUlRJT0JxSHdadisxalB6ZjNreDdNSzk2aHV3UFZj?=
 =?utf-8?B?RnE4SFM5YktmL3dkZEk0cmZjTmJCTGlOY29wVmFxU0VxWUVXaW5xajdJWnR2?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d42a9bc7-88f2-4a5b-d8eb-08ddf02b3940
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:30:59.2415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVCgdLNDddEt1F4FN4NZ3cqQhO0E4bhK/MzVFowdZr1GEsr8hJXs0Fw8iivJcgO5aRsT3ROJ6KO7Ho7HOmVATkGjja61f3Tr/Yn/DaS931w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7946
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > PCIe Trusted Execution Environment Device Interface Security Protocol
> > (TDISP) has two distinct sets of operations. The first, currently enabled
> > in driver/pci/tsm.c, enables the VMM to authenticate the physical function
> > (PCIe Component Measurement and Authentication (CMA)), establish a secure
> > message passing session (DMTF SPDM), and establish physical link security
> > (PCIe Integrity and Data Encryption (IDE)). The second set lets the TVM
> > manage the security state of assigned devices (TEE Device Interfaces
> > (TDIs)). Enable the latter with three new 'struct pci_tsm_ops' operations:
> >
> >  - lock(): Transition the device to the TDISP state. In this mode
> >    the device is responsible for validating that it is in a secure
> >    configuration and will transition to the TDISP ERROR state if those
> >    settings are modified. Device Security Manager (DSM) and the TEE
> >    Security Manager (TSM) enforce that the device is not permitted to issue
> >    T=1 traffic in this mode.
> >
[..]
> > @@ -453,6 +477,265 @@ static ssize_t disconnect_store(struct device *dev,
> >  }
> >  static DEVICE_ATTR_WO(disconnect);
> >  
> > +static struct resource **alloc_encrypted_resources(struct pci_dev *pdev,
> > +						   struct resource **__res)
> > +{
> > +	int i;
> > +
> > +	memset(__res, 0, sizeof(struct resource *) * PCI_NUM_RESOURCES);
> > +
> > +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> > +		unsigned long flags = pci_resource_flags(pdev, i);
> > +		resource_size_t len = pci_resource_len(pdev, i);
> > +
> > +		if (!len || !(flags & IORESOURCE_MEM))
> > +			continue;
> > +
> > +
> > +		__res[i] = kzalloc(sizeof(struct resource), GFP_KERNEL);
> > +		if (!__res[i])
> > +			break;
> > +
> > +		*__res[i] = DEFINE_RES_NAMED_DESC(pci_resource_start(pdev, i),
> > +						  len, "PCI MMIO Encrypted",
> > +						  flags, IORES_DESC_ENCRYPTED);
> > +
> >
> 
> Not all resources are secure/encrypted. For example, if secure
> interrupts are not supported, then the MSI-X table and PBA BARs remain
> shared resources between the guest and the hypervisor.

I failed to mention this in the changelog, but part of thinking here is
that the mixed security state of a device based on interface report I
was expecting to be follow-on work. I.e. that minimum viable base case
is all MMIO is private of a private PCI device.

However, we can still keep the PCI/TSM core implementation equally
simple by moving these iomem manipulation routines to library helpers
that a TSM driver can optionally call as part of ->accept().

> In ARM CCA, the interface report is used to determine the nature of each
> region. When ioremap() is called, it relies on the Realm IPA state of
> the guest physical address to decide whether the mapping should be
> treated as shared or private [1], [2].
> 
> With this change we report the msix table and pba range as encrypted in
> /proc/iomem
> 
>  50012000-50012fff : PCI MMIO Encrypted
>     50012000-50012fff : 0000:00:01.0
>       50012000-50012fff : ahci
>   50013000-50013fff : PCI MMIO Encrypted
>     50013000-50013fff : 0000:00:01.0
>       50013000-50013fff : ahci

Unless these interface reports from different archs are all coming back
in a common format that can be parsed I do think it is a good idea to
reflect private MMIO in /proc/iomem regardless of how the arch
communicates to ioremap() to apply the private mapping pgprot setting.

In the meantime I will move these to optional library calls.

