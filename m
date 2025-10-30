Return-Path: <linux-pci+bounces-39847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D6C22182
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 20:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A7F188DE77
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 19:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F97333429;
	Thu, 30 Oct 2025 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/Z5SkOZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21D332EDA
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854220; cv=fail; b=JG8T0Ta0woCw+sYauA7uKELgMGlGKpgsyvbAYCcKfpmDdVWgB9smlUDOD0aBH1ZAJI39dx1QPO/JcmRa2WUYahuPGSqwfGFjewzfHpg/qLgJZcMG1v+Y3CerGWezxlBq/vArPKuXaLK3gDlm4k/EI5FUbHISX+cF27zovugW9ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854220; c=relaxed/simple;
	bh=SK+cMb+U30TDiVZqOhnRsmnxO99ArDN2PaioZykd0mw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=IyM65lQeoywPa7HjFVlK893rZzzJYjvbGCIAvomTTVywAUhZN07kl/wZoIslrOHqDOvGszWjOGMSc/EF4uMuZCsupX8yqbSAo7voxYcsLS2GLQUrGi3gIUfTBZgQIvHOOM6dPWQwo+5fDDx3Z71CKchLxRtJCSjNlc/zC4plBQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/Z5SkOZ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761854218; x=1793390218;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=SK+cMb+U30TDiVZqOhnRsmnxO99ArDN2PaioZykd0mw=;
  b=a/Z5SkOZNKQF9WfEYcHZnoVdtBi155pWvAb/p3cmjwg298iw33bifJhg
   dzn4zGMfzIMBqenoONqrcJ02eHJhbFIJlSbKJrE7bRR0MxdJC+Dtn/cBP
   TtKKehBb41elYGpCZAVeyQmie/9sngmnUWYcLN4DW25XCUfD86HFiTjNr
   94NAxx1R2N0bAUEsmgGZpQ+vPuQbHNsOLyswuCmDOp7NrqHzUI6fdklwv
   ev9xqVXD7UYPxU8w9HHfKRx6IRvcwVS+yrz4xvRdadTklKZGQrBierxJi
   MfJBJeGjKdmhxVz3t3XPVSpTUqa1YA8onaIw01SfhyXpghce4Cm+DuLS0
   g==;
X-CSE-ConnectionGUID: exbwGXa3S5OuZiEyNUrs/w==
X-CSE-MsgGUID: acfVdTcbQtKeHGNbpdbtVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63895159"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="63895159"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:56:58 -0700
X-CSE-ConnectionGUID: tegggPE3RPy207yfl0dnSA==
X-CSE-MsgGUID: 7Mk07VHyRU6ZrI7rMJ7CaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="185734072"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:56:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 12:56:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 12:56:57 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 12:56:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kdh/jsNCx6RYFo6xWhJ9ijH+T+zn4OjC73saYHh03bX27yZyDibB40K+S9dW+dbcGsX5OaRuwndS2l+D1q3YbCoe2YrfzwKlVd5/mpqGiWd9rtqJZq6QCr4jDWdBcfYsl1gbpX6uSDxYZi04F1cmDB1qNIKOmVeHiYZNlazynnxHMDe9RFhYjkyRbi05rk3u+Nt3at3qS9e+WisDhVaN0mVWa9elcITbXi4I52/Qin10Ds+MBe7izpkvybgKn0bEgue6Kiq1EfkHfhVgDCI/0SgIssMAqqzg8kbOZF5B1jJIlkgSpgBZt06wVOoCMKqdEE8t4cgJ8d5GhXPp8Hbl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QwEXdaZb5rb+v4os0mYigz5Ef/+bBA6GXCW8PY+7e0=;
 b=rz581Nxd805bNs2upoctb6PCxDptoxmugZJkQuYOPYn4sfznEvk1V6kVd6tc3/BmPeoa6qUTPeWfCDtcUhXwfQ/NqEwNqFMhOYWuDA0NifZI9eCExr142bOeQapqmLAI1galq0bKdCJ4cf7N2i0O5BmIInVJDyq1Jexgm9z9CStk27xy7wC65CuszPBhUCQ6Z8AbVwf+ZA/Nf0s4bphbGFLS4MbvsLTivn+FTztrbaQ17xE75qBAY4SY4YtVKJsi9dStSnn/25uj532aPygCN16ioowyrKpyeSWIr9YKA87BUeoJCu8RBjiiv7zbZ1yN71fviuhenNgt6l6AtsC0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 19:56:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 19:56:51 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 30 Oct 2025 12:56:50 -0700
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>
Message-ID: <6903c302cc162_10e910050@dwillia2-mobl4.notmuch>
In-Reply-To: <20251029155303.00001e88@huawei.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-5-dan.j.williams@intel.com>
 <20251029155303.00001e88@huawei.com>
Subject: Re: [PATCH v7 4/9] PCI/TSM: Establish Secure Sessions and Link
 Encryption
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a11921-6542-4d00-75f1-08de17ee77e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDF1VTdTcGFNRnNYOWhFaVQrTGJGaW5pNTR5bDZFbVVsUGd3dnlqRGtNaWww?=
 =?utf-8?B?cUR0N3ExUy9SMWVKNndQaDFENGVFa0FtYm0xZFREUm1PUEJmTmVrUlFkWUM0?=
 =?utf-8?B?d3poTGhxNzFzRy9UbG42RW1PVW9PK011bkg2U2ZLTE1iV3pKZFBjVC9yYUdn?=
 =?utf-8?B?VXZSZUNqUGo3Z3g2eDQ1SG00UWNaZjNBWXlJV3NRVGYveFRkQlNRK2JwT2Rp?=
 =?utf-8?B?QzAyRXRNRGVFQ1IwaDcyMi92elpXN2F1NFZCME52TjlwQThpU2RsYUhUcWFz?=
 =?utf-8?B?dDJ3ME5oL3V3cXdwQWljQ3VSTjI1clowZTV6bmF3WFVVM3NVcUJ2N093bnRv?=
 =?utf-8?B?Y3VCTjF0M0lCSnN6VjRyb0oxekpTR3Q5VDMvaUc3M3M5NlVNKyszSFpjbUR5?=
 =?utf-8?B?dXkrWWxETnBjN0NHRjdjVlY4VkFSOFZ5UTQvYkE1L3YwWTFDNjNOUmpXUG1p?=
 =?utf-8?B?SUpFUFUyN2drVkpNdUZEUHdHZWdmMlFLV3pQa0FwRXF5TDBySnJzd1V1UllK?=
 =?utf-8?B?WmVwVTh0eDYxd09KR21DUXlWbnh2RjN1TmJxaUJJM1YvYkNnYXplVGRuKzVs?=
 =?utf-8?B?OVhYdDdVWnVFSlhIN29MUCtDYzJkMnQzeU9TTW5jTjJTU0JVTkNiNmpQWXNp?=
 =?utf-8?B?cDVsL0pGMlgxTlc5RWxoRmFxMnFwMmpzVUdzcmE3Y29TR0pyZys0QXZiWTY1?=
 =?utf-8?B?VTlIazl1bnR1TTlWNEQwS2g3Q01KMlc4a2NiK1E0QkRGYjdzVE4rZEtpNjRD?=
 =?utf-8?B?ckE1dGlRTG1IOWhIdG0vbFluYm1xUDJlNTBzLzdtdjdNZlNYZDFtRjBQTlVN?=
 =?utf-8?B?bUZWdlRBaGRWL0xQMXI0aW5XTXNtNTZDZlh6RGhxM25IT2hZcHFjY0w3RnND?=
 =?utf-8?B?RC94dWJheW5wbG1UbGIzOHBFeWVXNG95empadERwM3hTaUo0NnlONjBhNWxX?=
 =?utf-8?B?REtmQ0xhRE5ydWFTdjVJdGZWTWVnT2ZlM2xZM2lPUXF3L09oZzVuR3lsK3or?=
 =?utf-8?B?aXZpV1NsVDZjOG1NUXdFdUVPRUtaVSsrcnZMd0VaajRZSUpzR3FvbXFlT1RH?=
 =?utf-8?B?L01BZW5zbU1Ha0RRMUtJL1owZHpRbGlRRlcxNE1la29PK2lscmRpZGdVMm8y?=
 =?utf-8?B?MXM1TzViTklBTnBjS2NhUG9EWlF5THF1Vy9TNDlvR3dES0Y1OFNNZXhmcVZv?=
 =?utf-8?B?VGRXcFB2TGd0c1NHRFIzSm1mVHZTVW1IQmRLUmVmWGpieFhOK0NpRTBzaHJD?=
 =?utf-8?B?Nk5HVVBLZm81clBrUy9LeFFDMGlkZVN2MEYweSs4MXJMMHFuZ1dsOWd2OGNQ?=
 =?utf-8?B?bFlodWFBWmdLazRzZjJqcmNGVzhjSHkxWDFaaXVWWVhxMzd6YnBVa2h1a2Zs?=
 =?utf-8?B?SEVhbXZGMkVNd25FajZmeU1EOVBKS29ISG9JdVdqc0tpQnlmaTFueHdYUElL?=
 =?utf-8?B?UkY2YTBBSTl3NVdTU05GTTB1emdxWGhFRTFNdUlMMWxGZHo1MXV6Z0tydnVs?=
 =?utf-8?B?L1BMbnk0REhRcy90aU0vNnpzOHliaDZPZGhqc01vc1pYalpvNkpHamt3TUpK?=
 =?utf-8?B?ODgxbTN6MWhCM25uaEtqdEpBcjRnU1BBM2ZiOHRTRzVIRlNNT0crcnJIU0dV?=
 =?utf-8?B?UmEyQ2o1MVJvRHMxOWt1aGRuVjdjL2MxM1dydzU4eVF1MUthdEpTQ2ExdGlL?=
 =?utf-8?B?cEphUDg4aFB1TzZTdC93VCszajJldE1IdXRsQ2hnelBiRXFCZmFLallUYjF5?=
 =?utf-8?B?eXhKdW5SbDBLblVHZ1pudTFFU1Z6cXBvZGI1LzVKOSsyblErUnVrOCszVXdB?=
 =?utf-8?B?dW9rL2psdk1YaTZKRDNuQVQxN3luMmdnSDdJVGdvaFNjSnd4UnNWd2JJN1Fw?=
 =?utf-8?B?d1dvdmlPbFFuU3gzWHdaWEEreHh2bmhFM01uZmZrVnBPM2lNTWRoZC92SzlQ?=
 =?utf-8?Q?L7+2JQKVRcNQOSUV9I5n6eJZd1TXz95t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGRsTFpQQzNEZzUrYUdCMmw2N2N6azBsRWFyVk9iUlhXcENoWGxGZlJUWGpE?=
 =?utf-8?B?c3diMUFwOE9sWWE0MWp0bHpwaXN2eGRKVTY2NEg5aVkra3VCRnpDNFlYSlF1?=
 =?utf-8?B?L0NPWWZvWVJNTTJxTDdKSVZYWnhyZDJSWnZMaEZpT1MwbmJoQjdpWTRKbFlB?=
 =?utf-8?B?V09vSVhFUzYyOWlHNjBubkhucjR1N2dzUjFBZkpHQjZaMDZlV09XN3RGYjZi?=
 =?utf-8?B?b2xkZzhxTm1uV2ZCUkY1WVFBN0wwbGpKVXJJVkRmU0g3aDZDbFhNRmtMdEtv?=
 =?utf-8?B?YVZvd2tnbFRHOWZOb2ZXdjBZM2xzTHhmUzFIYmJ3V3pyODRQazE3R1E4U3ZS?=
 =?utf-8?B?ZVMrdTg4Wk9uaEdQa1ZWaTVOYkt2clpMelpwME0zN3RHR3Rrb3ZTaEV5anFM?=
 =?utf-8?B?NXNlOUJWK0FUZldSL3FHWWY0U282cWVxUnByWmlGMldDQy83QmxLQTl2ZUgx?=
 =?utf-8?B?SlA1SUQrYnU5MmhKQWlaYVo4NXVYb2RONHJJRFlOYU11eGxkOUJmTURYQzRn?=
 =?utf-8?B?Z3JBSitoMG1TWlZPMWlaMGEvWExFU1BUNmtWZU5DNHQySGZjYlVYQ0pvcXZz?=
 =?utf-8?B?NDFDc2w2bDFwVG91OFg0aHJYUU10RHJWenplY1E1UW5WMDQ5dU9nZFdLNVpr?=
 =?utf-8?B?VGc4c2NiZDhzck9mTGdTSlZRcnJkRDBDalB0MDg5dHNzZEd0alUrd2hIMmE1?=
 =?utf-8?B?RytWb2RvNytKeU14M3hDM2p0NVE2eGFYekxLbGsxdTEva2ZuMHdPUVMzZWtH?=
 =?utf-8?B?TWxXL01LZ3l4Qjd4T25pT2ZldzNXeEk0eDZkYm50YUF2SVJLYWQ0RnJLbGFl?=
 =?utf-8?B?WXhReEtxeitRamJ2VFFlQy9qT1NOWERHeER3VVJoblJ3MGtRZnBZL0w5d0Rt?=
 =?utf-8?B?MldxRG5DRytXT3ZBN2ZVSU9lWDVESUcwTlloamlYbElZTXhVbGFUKzVCRHla?=
 =?utf-8?B?WitFd3ZDM3l4S3ZhRWtwcjFnVzd4TWNKMS9QejhpVlVzK2ZWdGd0M0l0Q1l5?=
 =?utf-8?B?b1pXUmk3MXZCVys3TDkrY2NTZmg5YjdJM3BNVFppOXBKWUdKcWp1YW40VDFx?=
 =?utf-8?B?TXhTcHNuMTBPRTVyeDlEUUROUzVHdWJ5cjNRTDRSTDVLZzlCQnZQTGdJUkJZ?=
 =?utf-8?B?MVZXaElQMUFtZm44a0lGNDN3aWpzc2dId29uSTgvYVlqUUNrRHIzU1U4eVJK?=
 =?utf-8?B?cHN1UnVvc21iKzYxUVhLc3UwUUw3bXdlWEUxcEJ4UEI2TWlPUTBCMkNFZEd3?=
 =?utf-8?B?N0FCSStuOXE4SGxvZGtiY2t1YzZtTnVxcXpGM2FKaWtqSjRGck1xSnEyMnpJ?=
 =?utf-8?B?SEhvSXRxRytUNWQ3cXllb3N4VlA2czNkaXVDcHdmQ3dLSHM5ZVRrZDQ4QlBa?=
 =?utf-8?B?ay9JUjZZdGROWUNTTDhONHhQR3FpSXlZTGR6c2RCSUVIUXNMa1NIeGJaK3U5?=
 =?utf-8?B?MkNzZFB3RTh4WkI1ODltbkFkL0svRGNlNmlFcWxqMHhGcHBuckRvMWR2QlYx?=
 =?utf-8?B?d0xmMEVEYlZ3RmNCS2pxaWUwWXBYUlZ3bEpSaTlpNVk2Rm1rK2xweWkxSUh4?=
 =?utf-8?B?U2FseDE0RG5zRUlnUStNeUtueDFrTjA2QU5oMFRDcEVoM0tDTExkbTV3UzBE?=
 =?utf-8?B?WmZCU0E5bEM2bWsyV0ZoT0xlVXM3RlJ3UmNQY3BiL2o1T3MrOEt1MkhOdXh3?=
 =?utf-8?B?TE45VEM3eFV2cVRkUmQ0c0pNK3k1Sko4cUJaWTU0NkE3a2ZVdnVMR2JRSis3?=
 =?utf-8?B?VU8wcG01VXJ2YmNUNzI0OHNWUXBhcU53VEtmS1dnYU1TTlp6eDNVeHRsL3Qv?=
 =?utf-8?B?L3FKenBXVDI4eEduTUdoZVo2cm01TjhWUEtLbENlKzhSWFFNbWxKQ2VoQnNs?=
 =?utf-8?B?YUhQUGk5ZW8rVFlMRzJ4cmIyMWRqWCs3VE8yeElpenpEd2RvWCtkRkcwRFk2?=
 =?utf-8?B?TlJPTkZIYW5XQmkzdjRhUjh0aXV5K0ZuaEZEaStzaWNtd0JFNVp1bC9Ybitt?=
 =?utf-8?B?Sy9ic0g2a0lhbVYwanJnRytYYUIvVjZKK0N6M24xSFBVUG9wT09FcVlrVzZu?=
 =?utf-8?B?RGJtbDJxZnRySkdFVXMveVFpUk5YU2NKTFdjNTduT2pTTFdWTk1EVlExYUIy?=
 =?utf-8?B?MnBXWWFVSHVnV2dQOVBDbjRNTUVYN2o1U0ZMcTFKQzRYa214Mm9EUWd1dXo2?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a11921-6542-4d00-75f1-08de17ee77e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 19:56:51.6755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqJMFgdMKnPNqIupSHkcR2D2/AxQA6ydMU7ImSlTYomjL91Z8FelCXr/tex4UCL7EFPq7ar5cn43XnK2mGRZjjkMbcflwRsQShRneFb5C/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > Only "link", Secure Session and physical Link Encryption, operations are
> > defined at this stage with placeholders for the device security, Trusted
> > Computing Base entry / exit, operations.
> 
> That list probably needs an 'and'

No, but went ahead and added parentheses to make it clearer.

> > The locking allows for multiple devices to be executing commands
> > simultaneously, one outstanding command per-device and an rwsem
> > synchronizes the implementation relative to TSM registration/unregistration
> > events.
> > 
> > Thanks to Wu Hao for his work on an early draft of this support.
> > 
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Some comments on comments/documentation inline.  With those addressed
> (which should be straight forward)
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> > new file mode 100644
> > index 000000000000..e3107ede2a0f
> > --- /dev/null
> > +++ b/include/linux/pci-tsm.h
> > @@ -0,0 +1,159 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __PCI_TSM_H
> > +#define __PCI_TSM_H
> > +#include <linux/mutex.h>
> > +#include <linux/pci.h>
> > +
> > +struct pci_tsm;
> See below for note on a duplicate of this.
> 
> > +struct tsm_dev;
> > +
> > +/*
> > + * struct pci_tsm_ops - manage confidential links and security state
> > + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> > + *	      Provide a secure session transport for TDISP state management
> > + *	      (typically bare metal physical function operations).
> > + * @sec_ops: Lock, unlock, and interrogate the security state of the
> 
> devsec_ops?

Yes.

> 
> > + *	     function via the platform TSM (typically virtual function
> > + *	     operations).
> > + * @owner: Back reference to the TSM device that owns this instance.
> Not seeing this below.

It is gone now. The reason kernel-doc is not complaining is because this
not actually a kernel-doc formatted comment. In any event, now cleaned
up.

> > + *
> > + * This operations are mutually exclusive either a tsm_dev instance
> > + * manages physical link properties or it manages function security
> > + * states like TDISP lock/unlock.
> > + */
> > +struct pci_tsm_ops {
> > +	/*
> > +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> > +	 * @probe: establish context with the TSM (allocate / wrap 'struct
> > +	 *	   pci_tsm') for follow-on link operations
> > +	 * @remove: destroy link operations context
> > +	 * @connect: establish / validate a secure connection (e.g. IDE)
> > +	 *	     with the device
> > +	 * @disconnect: teardown the secure link
> > +	 *
> > +	 * Context: @probe, @remove, @connect, and @disconnect run under
> > +	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
> > +	 * mutual exclusion of @connect and @disconnect. @connect and
> > +	 * @disconnect additionally run under the DSM lock (struct
> > +	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> > +	 */
> > +	struct_group_tagged(pci_tsm_link_ops, link_ops,
> > +		struct pci_tsm *(*probe)(struct tsm_dev *tsm_dev,
> > +					 struct pci_dev *pdev);
> > +		void (*remove)(struct pci_tsm *tsm);
> > +		int (*connect)(struct pci_dev *pdev);
> > +		void (*disconnect)(struct pci_dev *pdev);
> > +	);
> > +
> > +	/*
> > +	 * struct pci_tsm_devsec_ops - Manage the security state of the function
> > +	 * @lock: establish context with the TSM (allocate / wrap 'struct
> > +	 *	  pci_tsm') for follow-on security state transitions from the
> > +	 *	  LOCKED state
> > +	 * @unlock: destroy TSM context and return device to UNLOCKED state
> > +	 *
> > +	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
> > +	 * sync with TSM unregistration and each other
> > +	 */
> > +	struct_group_tagged(pci_tsm_devsec_ops, devsec_ops,
> > +		struct pci_tsm *(*lock)(struct tsm_dev *tsm_dev,
> > +					struct pci_dev *pdev);
> > +		void (*unlock)(struct pci_tsm *tsm);
> > +	);
> > +};
> 
> 
> > +#ifdef CONFIG_PCI_TSM
> > +struct tsm_dev;
> 
> Seems to be declared already (not under an ifdef) above.

Yes, the Alexey request to drop owner and only have @tsm_dev in 'struct
pci_tsm' moved the need for this declaration earlier.

> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > new file mode 100644
> > index 000000000000..094650454aa7
> > --- /dev/null
> > +++ b/drivers/pci/tsm.c
> 
> > +static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> > +{
> > +	int rc;
> > +	struct pci_tsm_pf0 *tsm_pf0;
> > +	const struct pci_tsm_ops *ops = tsm_dev->pci_ops;
> > +	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(tsm_dev, pdev);
> > +
> > +	/* connect()  mutually exclusive with subfunction pci_tsm_init() */
> 
> Extra space after ()

Got it.

[..]
> > +/*
> > + * Find the PCI Device instance that serves as the Device Security Manager (DSM)
> > + * for @pdev. Note that no additional reference is held for the resulting device
> > + * because @pdev always has a longer registered lifetime than its DSM by virtue
> > + * of being a child of, or identical to, its DSM.
> 
> This comment has me confused.  I would normally expect parent to have the guaranteed
> longer life span than the child. This seems to say the opposite.
> Code itself is fine.

Right, comment flipped the polarity of the lifetime. It was meant to say
that registered children always extend the life of their DSM ancestor.

 4:  722f1b0155cf !  4:  77789285d040 PCI/TSM: Establish Secure Sessions and Link Encryption
    @@ Commit message
         "Security" operations coordinate the security state of the assigned
         virtual device (TDI). These are the guest side operations in TDISP.
     
    -    Only "link", Secure Session and physical Link Encryption, operations are
    -    defined at this stage with placeholders for the device security, Trusted
    -    Computing Base entry / exit, operations.
    +    Only "link" (Secure Session and physical Link Encryption) operations are
    +    defined at this stage. There are placeholders for the device security
    +    (Trusted Computing Base entry / exit) operations.
     
         The locking allows for multiple devices to be executing commands
         simultaneously, one outstanding command per-device and an rwsem
    @@ Commit message
         Cc: Samuel Ortiz <sameo@rivosinc.com>
         Cc: Alexey Kardashevskiy <aik@amd.com>
         Acked-by: Bjorn Helgaas <bhelgaas@google.com>
    +    Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
         Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
         Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
         Signed-off-by: Dan Williams <dan.j.williams@intel.com>
    @@ include/linux/pci-tsm.h (new)
     + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
     + *	      Provide a secure session transport for TDISP state management
     + *	      (typically bare metal physical function operations).
    -+ * @sec_ops: Lock, unlock, and interrogate the security state of the
    -+ *	     function via the platform TSM (typically virtual function
    -+ *	     operations).
    -+ * @owner: Back reference to the TSM device that owns this instance.
    ++ * @devsec_ops: Lock, unlock, and interrogate the security state of the
    ++ *		function via the platform TSM (typically virtual function
    ++ *		operations).
     + *
     + * This operations are mutually exclusive either a tsm_dev instance
     + * manages physical link properties or it manages function security
    @@ include/linux/pci-tsm.h (new)
     +}
     +
     +#ifdef CONFIG_PCI_TSM
    -+struct tsm_dev;
     +int pci_tsm_register(struct tsm_dev *tsm_dev);
     +void pci_tsm_unregister(struct tsm_dev *tsm_dev);
     +int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
    @@ drivers/pci/tsm.c (new)
     +	const struct pci_tsm_ops *ops = tsm_dev->pci_ops;
     +	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(tsm_dev, pdev);
     +
    -+	/* connect()  mutually exclusive with subfunction pci_tsm_init() */
    ++	/* connect() mutually exclusive with subfunction pci_tsm_init() */
     +	lockdep_assert_held_write(&pci_tsm_rwsem);
     +
     +	if (!pci_tsm)
    @@ drivers/pci/tsm.c (new)
     +/*
     + * Find the PCI Device instance that serves as the Device Security Manager (DSM)
     + * for @pdev. Note that no additional reference is held for the resulting device
    -+ * because @pdev always has a longer registered lifetime than its DSM by virtue
    -+ * of being a child of, or identical to, its DSM.
    ++ * because that resulting object always has a registered lifetime
    ++ * greater-than-or-equal to that of the @pdev argument. This is by virtue of
    ++ * @pdev being a descendant of, or identical to, the returned DSM device.
     + */
     +static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
     +{
    @@ drivers/virt/coco/tsm-core.c: static struct tsm_dev *alloc_tsm_dev(struct device
     +	return tsm_dev;
     +}
     +
    - static void put_tsm_dev(struct tsm_dev *tsm_dev)
    - {
    - 	if (!IS_ERR_OR_NULL(tsm_dev))
    -@@ drivers/virt/coco/tsm-core.c: static void put_tsm_dev(struct tsm_dev *tsm_dev)
      DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
    - 	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
    + 	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
      
     -struct tsm_dev *tsm_register(struct device *parent)
     +struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)

