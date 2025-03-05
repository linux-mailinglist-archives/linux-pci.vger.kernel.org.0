Return-Path: <linux-pci+bounces-23013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE4A50BF9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 20:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E63189506F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 19:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAF25485C;
	Wed,  5 Mar 2025 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/ihEw7F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A4E25335D;
	Wed,  5 Mar 2025 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204530; cv=fail; b=R4ua7n+G29WxWU6V4hyyt1u/wnh37CkP3huoWXxj+SOnzDE5ws23mFhTof2y9Q4Ve4n2xeLQstfPb9/OYG3qUSyC/FMDYW400LZildt0xDfcPJYSxUeQlS4yghj/130G2aNf455raTWTRptwHCDthfx8hyijn9mUA0qH7d6OQT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204530; c=relaxed/simple;
	bh=vmLwjjD7GHbXkf6IqiM9ZDLKqPSAoFbRoKnNWQdAgoQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tx1Z9JGhSwrNSsemyMQv86sVh5otkqYGumPUqKf0BwNdkizt+KYxmUmtmnyjlRjJ6HYqOJoJ8LL90CH20BBWQ7H9vT0lVDMYNCVmp2nmHk/4/pXXe4cbCN3orBl72+Hy2J0oaMMl+njUwhCq4LOS+wz92fYdaY3YKEAak0GvjTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/ihEw7F; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741204529; x=1772740529;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vmLwjjD7GHbXkf6IqiM9ZDLKqPSAoFbRoKnNWQdAgoQ=;
  b=l/ihEw7FCtkuif6N3+DVXigKp5+Ua2GOf5MgZwZs3r3ZejgObvGtqG40
   4wmewczaSv51EUofgioUbCtZHE8ypxmS5B6ToSZ/WjDGiq5y5BhAZMxkM
   cywXOzuueU26IJuMM4uOc+ky7FSEOMNqpo8kQNkZPJz0vxjzTE+sg6D23
   Vk42nJYs59Xnx57CT7VFWF+bRyQGLr7XncypvJ9mkh0EX1WqpgU5cjTPv
   qiq8Uq0BltcE4KnwsjGRCv8Og5zF2lxz+cRBjDOUrdmppuoA8o1qNGB85
   iqZbesc7q7M1wJg1MnD4xnk5Ga7huX6G3pRI2j2qJKJ1rr6mRBffpgBFX
   w==;
X-CSE-ConnectionGUID: FN3mmqjbQjyx2IIUPhb1SA==
X-CSE-MsgGUID: 1LI9WUuORUOGPdBZNnSXVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29771354"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="29771354"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 11:55:28 -0800
X-CSE-ConnectionGUID: SqW975azS62yShOI31xQaw==
X-CSE-MsgGUID: Xo8MTKBTTKOtByI7X4j/mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="119294224"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 11:55:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 11:55:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 11:55:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 11:55:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5x+bCaibGNjD1aTQFeVXsRUFVxgaLjOs6Pel1mDTCC4neEvVJf1NSeOWiO+1Yp5cy/kMSRuRrh0KB7/K3N8YMBslhjnVQbQ7C5dGinQmh7MOFRk3iVuyZ/hNFrJfXdpu8yveSnh+sggwaslSICTkCoilj6QttvdSv9++aaodAC16o+Fdm4yTs7k0pXhx4CVAK0f2T9K1qkZ3xYRIDg5xIuYi3nOmpir4Dkrqc+a7wKqxPnhUZHZousgBdSUzLnXmaJThxK+FDOtQlF4uhVs1NSea4iVqAUgAy/UfCHGQil2B8LOYTOLKy9n8/QsVwDE7yUs+/4G02sK9PgGsty4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4vEnVQ4mP9WT0r0vhZFNTGEEKzHUxi9LaIYwYueyxY=;
 b=MkNswG1Crcm45/jGDXWiCE0ShB6LiXzfaOn+MmNX0UG3HFW0BmxIdjJS3ygc+GGkx6mEv838Zy0hn24Y2vbo3LxHAjqJ1wKLlh1suvUTPWb8NzyQxgmrs4xyexhMCrre42btxB7sy8a76TAXZVmJndNH5Liga3Wb9l7W0d0kbrFJv8nV2Fv2qlNJuVNI+KvV8KUCZr6Hf4/MtqwmZ2UcUqvPwc9PfDJSoyle9N3QSdmRfhxkl6W6DT1wB2lCOQxvX2OIFLN/kzt/B/dvk+phTW4vX9PUTGBdMJJCh/oIbvJY0CC9f4LIX5yqqIFCEjxT9q7E6FmNMXPlATyydOM3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7741.namprd11.prod.outlook.com (2603:10b6:208:400::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 19:54:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 19:54:42 +0000
Date: Wed, 5 Mar 2025 11:54:39 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Francis <alistair23@gmail.com>, Greg KH
	<gregkh@linuxfoundation.org>
CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl
	<aliceryhl@google.com>, Alistair Francis <alistair@alistair23.me>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lukas@wunner.de>, <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<Jonathan.Cameron@huawei.com>, <rust-for-linux@vger.kernel.org>,
	<akpm@linux-foundation.org>, <boqun.feng@gmail.com>,
	<bjorn3_gh@protonmail.com>, <wilfred.mallawa@wdc.com>, <ojeda@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <gary@garyguo.net>,
	<alex.gaynor@gmail.com>, <benno.lossin@proton.me>, Alistair Francis
	<alistair.francis@wdc.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <67c8abffd2deb_1a7f294d5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
 <2025022717-dictate-cortex-5c05@gregkh>
 <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
 <2025022752-pureblood-renovator-84a8@gregkh>
 <CANiq72kS8=1R-0yoGP5wwNT2XKSwofjfvXMk2qLZkO9z_QQzXg@mail.gmail.com>
 <2025022749-gummy-survivor-c03a@gregkh>
 <CAKmqyKNei==TWCFASFvBC48g_DsFwncmO=KYH_i9JrpFmeRu+w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNei==TWCFASFvBC48g_DsFwncmO=KYH_i9JrpFmeRu+w@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: adf10a2c-f9af-46fc-2bf5-08dd5c1f9274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djdPQ1pTYjA1azZjTlRQSm5rcndCcVo4SDJBU2dtV1g1cmdtcEdSQ3BnRkd2?=
 =?utf-8?B?NzFTSlZZTnBxdUtOb0ZDOGFoc1I1V0UvcVNHZmF0L0RjM2FqYnNXSEovekd6?=
 =?utf-8?B?bzBUL0FCbFdmTXlQWXAyU1V3NUtWZTR1WEQzYVdxV1dBWUdRc3NQYUtRMVJG?=
 =?utf-8?B?TjAvRFZmbU9qeUc0RzdFdWRZdjg0L3JxWjYrQ25hcXBUTlk4TS9IOHhYZHY1?=
 =?utf-8?B?MXVzWWtSaUVkamNJZDV3SytCWnZDcGM3MlpvNTRuRnZReE9SaUpyRExSMmxt?=
 =?utf-8?B?ZUVjc1gxTCsrRVVUMVhyVnlhN002eTFKb2Fjazd4RW1ic1N2U1FJa3VUdkJy?=
 =?utf-8?B?MjE4N1hMNHpvUHR5RXNBZlZPUnF1dVQ4NXl6dHlvQkFpaGxIdVNtTmdzeDFp?=
 =?utf-8?B?Wkk4T2ZIQ3FEK0t6dTA1c1g3VHBuNGRtTTF0YkdkdHNjeDlyWE1nYzE1dzAv?=
 =?utf-8?B?TGdqRXpzazVYWGEycXVPUUFId2I2QkJ5RFRValpSelZUWHRPNWk0RENBUGFo?=
 =?utf-8?B?ZFVGeGIrU1ZPc2EzOFVEc2J5ckZocVBRMStKNXVRNEVoY25WOFRwSExweXpG?=
 =?utf-8?B?US9SWTlVVG80YWMvQkw2N3VsSjY2K3lCZzN6QTlHbTJCd0xIWVhYL202Vit4?=
 =?utf-8?B?cG5LcXlPYktpR0RMdG9xS1piR0dzWnlHWWZyd1hUNjA1M0tYSU4zWUFBZXJQ?=
 =?utf-8?B?NUhjQTAvWkxZMlVyTk5aTDFQbWUvMitzWlBRTkpjSk1jQUF0aXBqR2YvSGww?=
 =?utf-8?B?MVpPYWVuZmRjb3o4eUU2VnpDU3ZvY1U0QkRZUlNaQXNJTXJsU2dsR0RUVzNl?=
 =?utf-8?B?NEpoemdOTEFuOHptbE9WOGZEbW5wTEVLZUZoelVCbksrTEJVWXJtZDdFVnhD?=
 =?utf-8?B?ZmFuMWx5UERhQ2IyMGZvL0xheksxUmlRZk9VOWVpL25jMXFYeHpHVkpQeWxD?=
 =?utf-8?B?RGI4Mm5FWjJqT0pja1dyQWJUbFZNZE91K0k4KzJJV1BNbjBCNTVPTXdjSmxG?=
 =?utf-8?B?UFVZZmtEVHlzaVVjSlV4RjZGUGRBbjJYbWZhMVZKd3pwVGR5OFUra3lKUGpr?=
 =?utf-8?B?bUU0bzgyUW42OHV1ZHJOM08vTFRXYVU5OWRPSUtEcU1CRzhHUko4anlEQ3FZ?=
 =?utf-8?B?a2IwMjN3Skg5QnY2dUNpNVFLbS82VzBqMld4R0dGcjlzN0J6d1dkUWRJSTFE?=
 =?utf-8?B?YUtVRzArQ3ZQRTNsN2NmU1RDcnZQU2pHSEdXcUhGUVg5VEVBRGxoWHd5dVgr?=
 =?utf-8?B?QVJWWnpBclNSWjBGcGg4dHAwczJzVlVZc1FkSnlZS2FRR0tpV1hKcVZNYjVI?=
 =?utf-8?B?Y3NXTDE3NmFQQUFOeWI1VGpKY0RwUml2YnplcDh5NGNxMjVlTlBpZ2w1QjZp?=
 =?utf-8?B?bzh3c2NiODRxR3hZM0ZxSDRXWUptZ2Q4RkVpanEwMEFxYUlVV0RHUlZrOFBm?=
 =?utf-8?B?UndybjdkdTZaZytWNFZhakNxQlJnenh2dUN5UjZiTjlCVFpSY0pWcDJ2Tmll?=
 =?utf-8?B?VklzdmRBZ25XdVRnV2xHdmpQNHdSYTV2K1E1SWFyUVhlVmh2Q1NIVDBEL1Nk?=
 =?utf-8?B?M3kyWC9mcDVzRFA3dmQ0amY3VmhBbmROc0t0ZmNWRWd3UW1BL3FUWXg2TEFQ?=
 =?utf-8?B?SWFzZGg5TVBodTVZMmV3Vm15RWZiZGpLL0VYdHRBeGVQTWVERmVheERLR3pR?=
 =?utf-8?B?Zzl6NVM4TUFZdUZNOVZ5RmVKOUtYcU0zWEhGeFJ3bEpuMlI2blV5STNzQnAz?=
 =?utf-8?B?dGkxa0U4ZU1KMlBDMmRPaThLS0ZQa1FXRXB6ZS9qS0ZpLzNueFZySzJkeCta?=
 =?utf-8?B?c01WYll2K2k2THYycFRiSjRObHl4TXZxWWkvY2diUHV3dCttRnAwR0NxeVFo?=
 =?utf-8?Q?ygdk7kK0kH3Fy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alV6b0w4dVJ0RVJ6cWEzZGFxUDhHei82Q2hxTXNNUUlEOW9yTTBiWk9rRGVo?=
 =?utf-8?B?d215TEFBWkFrc0hodmM0blZlei9MNWx0ZkZkZmJuZW1XVlRNdXJnWCtMV1RN?=
 =?utf-8?B?M3BWalQ3M0ttemhKVytBV0NXdGpGb2VaM0xrUm5FY1NNVkVTLzBDTjgrNlB2?=
 =?utf-8?B?THB2ZU5rRGNFUmlHSnk2SmFGdVN6WEVyQUZQMENUUWpvR00zY0l0dXZieE8v?=
 =?utf-8?B?Sm5QY2ExaUtROEZqYkNwc3BkNGpiYy8zeFVidUdHc1QvenFSWUhGZEJEMHdr?=
 =?utf-8?B?TDdoYVAxUGZXZmM1bjNIZmZGTnd2MVZCdCtGS2hQUmNpV0kvMmFTN1FvWUFQ?=
 =?utf-8?B?VzZlZTNtblpEbVEyUVM0SGdSRmNwdFl5VURNZ0xqVXFDSkZyZFdnYWJhemNW?=
 =?utf-8?B?MVVGdVJDRWZnVnFvYjhUczlkeC91eUdweEwxdS9hbEVtT3hIUmVObkpDbHRS?=
 =?utf-8?B?ejh4Si9vWmZoNWFTeWtlS2JBbTl1aXpvOWp3TGxrenAwYnZvajhCaFVtcHlO?=
 =?utf-8?B?cUlmN1I5c0Z4OWd3bVpObDJHbDEzeWhsN1ZUYW91cmVIV3VDTU16cVhhdC8x?=
 =?utf-8?B?ZDlzemtqSURjYiszZWlCOGRRZXUrWW9DamRVY0ZWYWFBVldMeFVMWElYQVJz?=
 =?utf-8?B?ZEZNenJxNnM1MTNuaUlaMHd6N3NEbW92WUVpMlFtSnBkZUttNlY2cnJTYk84?=
 =?utf-8?B?UE5Za2VCK2tqTlE3RlNVeG45bmw0dlp3SGVlZXlLc2U1bTlMTFpnY2JKdGN2?=
 =?utf-8?B?M3ZScEN1bGNHK2IzQ2xSR2tnK1JrdnI5Q00rQUs3YVhyS2JWSGxNbVZWQ1ZO?=
 =?utf-8?B?ejJya2NiVFNQSElDNCtCT28vMXhkeFp5dUtvYmxZZzA4Wk5WVFZ0THBSU2Yr?=
 =?utf-8?B?R2dsb2tucTE2TzQ5MGhSRDNIUGhoelVsOUlLUDlWRUxyR3l0blBTc0xRQ1hM?=
 =?utf-8?B?eXM2dG9HODlqUlNCaFJDdlYxNXZKQm1VRGEwT3Z2UkJrVGh0Q2sxbzlHbHFO?=
 =?utf-8?B?alpmL3hJckRKVHY3ajJFZVFxcUdoRy8vWE9QdVRhakVodldwYmhoQ0QrdjdN?=
 =?utf-8?B?T3FDV0ZPNmV5dldYNGY1V2RNdEtBM1IyN2Q2OHJDV3l4a01LZngvS2dLSjNi?=
 =?utf-8?B?WG1wOElWZW5JYmhhVG1Kb3E5ZVRFWFVaL2NObFI2OE0zb2ZsUmJ6VUFsZ01U?=
 =?utf-8?B?MmFVM2owOG5Lby9PK2txVk9JWVVBRHRTcnhlREo1cVo4cjBqNzlPanpMd2NS?=
 =?utf-8?B?RGFXRGZMdytWVHlpMkUxVEdCSjhjand3cklad3c5V05zYnYzNWcrOHZYdHZN?=
 =?utf-8?B?cy9oc2pZK1FtV1oyRy8vTjhZYVFvclJnOGN5N1RyOEc0WDRmdTN5c29BbWo0?=
 =?utf-8?B?aFY5T1lKVy9RSTBNaE5UdGZMblBmS0RXbHdGcGt3bkdKTitzOEtvdEc3VDV1?=
 =?utf-8?B?NVY5Vkw2eDhKSkFkSEQ1SmRPOTlaWjhVOHdEazM3NEFybXN0UUZpemhhSFZ4?=
 =?utf-8?B?T3pnSHYxNy83d2phSmpUc2c0bDV2V0l2UmRrMzJIbzR3ZjEvMzQxeGFobFRn?=
 =?utf-8?B?RDJsd2M3Q3RzbTZiSk5Ddm54V2ZGSUdyazZhQm1zT1crenNVNjJlelNWaXF5?=
 =?utf-8?B?dnVycTVCV29hTXNKL3NvKzVRanJ4eFU4MW9vNjFmazdDOFEzWkZQQ3BuUmxP?=
 =?utf-8?B?Sll3K09uZmIwS2tRZFpoQUg4VDgwcjEyOFd1bGwzcStQMkIyRXNXK25qMmxO?=
 =?utf-8?B?Q3FOQ0IxLzdSWDU0OTBFcXRSaG1tWkZScENVOG8vcWJkeVVoeS9ZQytzT05L?=
 =?utf-8?B?aklLOGtIbkZvQmJ4U3AzSzU4aXYxakF5NzB4RjNVWjg4QWZJUDhiTDlCbnpT?=
 =?utf-8?B?ODN0dExNN21xOHNWZ2lSSk9tL1Z0MjBjSVkzS01oN2l4SmhyQWlXTVVBOGsz?=
 =?utf-8?B?UnpITHlmb2dudWZreStkTXdqMXFrbWZROUNBTHRyU1QxM1NwV1RSQXNXdldu?=
 =?utf-8?B?RTVtZUJ4d1phWHIra0ZMVkVIcHBaMnB5L1dYejc4WjQwTC9MM3IwaHdhczJa?=
 =?utf-8?B?TjVidXZ5RVpkL3MxL2tDNmtZNFJ2dUJ5YjZ3QTcrU3JUbWFDUlhSTEU0YWRz?=
 =?utf-8?B?VVhKK0Z4R1ZVN2lxc3VKbEdFUFN1YzFNeDhOcXZwVG9XcWxuUG1JNU93Y3dt?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adf10a2c-f9af-46fc-2bf5-08dd5c1f9274
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:54:42.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzws1fIODC9Qxg+fYiPM0Y1GEUbA7V714SoY7bG88oX3dZli47pgNY1gVrkzpGBSv4WebbCw64+Cdravh7MGvc1NRILeAljzunMK8sF6GX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7741
X-OriginatorOrg: intel.com

Alistair Francis wrote:
> On Fri, Feb 28, 2025 at 5:33 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 27, 2025 at 05:45:02PM +0100, Miguel Ojeda wrote:
> > > On Thu, Feb 27, 2025 at 1:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > Sorry, you are right, it does, and of course it happens (otherwise how
> > > > would bindings work), but for small functions like this, how is the C
> > > > code kept in sync with the rust side?  Where is the .h file that C
> > > > should include?
> 
> This I can address with something like Alice mentioned earlier to
> ensure the C and Rust functions stay in sync.
> 
> > >
> > > What you were probably remembering is that it still needs to be
> > > justified, i.e. we don't want to generally/freely start replacing
> > > "individual functions" and doing FFI both ways everywhere, i.e. the
> > > goal is to build safe abstractions wherever possible.
> >
> > Ah, ok, that's what I was remembering.
> >
> > Anyway, the "pass a void blob from C into rust" that this patch is doing
> > feels really odd to me, and hard to verify it is "safe" at a simple
> > glance.
> 
> I agree, it's a bit odd. Ideally I would like to use a sysfs binding,
> but there isn't one today.
> 
> I had a quick look and a Rust sysfs binding implementation seems like
> a lot of work, which I wasn't convinced I wanted to invest in for this
> series. This is only a single sysfs attribute and I didn't want to
> slow down this series on a whole sysfs Rust implementation.
> 
> If this approach isn't ok for now, I will just drop the sysfs changes
> from the series so the SPDM implementation doesn't stall on sysfs
> changes. Then come back to the sysfs attributes in the future.

This highlights a concern I have about what this means for ongoing
collaboration between this native PCI device-authentication (CMA)
enabling and the platform TEE Security Manager (TSM) based
device-security enabling.

First, I think Rust for a security protocol like SPDM makes a lot of
sense. However, I have also been anticipating overlap between the ABIs
for conveying security collateral like measurements, transcripts, nonces
etc between PCI CMA and PCI TSM. I.e. potential opportunities to
refactor SPDM core helpers for reuse. A language barrier and an ABI
barrier (missing Rust integrations for sysfs and netlink ABIs that were
discussed at Plumbers) limits that potential collaboration.

Now if you told me the C SPDM work will continue and the Rust SPDM
implementation will follow in behind until this space settles down in a
year or so, great. I am not sure it works the other way, drop the C
side, when the Rust side is not ready / able to invest in some ABI
integrations that C consumers need.

Otherwise this thread seems to be suggesting that people like me need to
accelerate nascent cross C / Rust refactoring skills, or lean on Rust
folks to care about that refactoring work.

