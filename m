Return-Path: <linux-pci+bounces-35576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CC5B4649F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 22:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0135C66EC
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA421F4262;
	Fri,  5 Sep 2025 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1JBcGOt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C927814C
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104534; cv=fail; b=uT0V/iqdyMU5UpehQFZcVZhSvmbWOgMqaUbfLN+R6995KbxjuKzY3l3PMLZsdZEMfeuOZ0Y2tUWSYnZpc6tGtSCK9PYWdVwnjYpLlsCAjQaL1HqU6jlDc6uYkOVfy6zJ1Va3iq2aG+HG0AjC7v4ZPn5akcka5QPiW627MRZ895M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104534; c=relaxed/simple;
	bh=HghvnlvrvZbbCPqQydE6tzVrmkOL48bwafjhcn2PaKU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=hUWT8HZllXUySwc7MqFht4MFAdbX/r9qfV1AcXbm+STk+SMf6lERBCI2ZpyQwVaHhK584L/fyYDp+b6kANRo5YuuvV9Vaq4l8lySWIDjda0Tusgvl6ioZ9ib7GwRSZ8TI+ow92jNeXAAoGO6uMSlGWYKItd5wXGS8SKUF+O8k20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1JBcGOt; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757104533; x=1788640533;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=HghvnlvrvZbbCPqQydE6tzVrmkOL48bwafjhcn2PaKU=;
  b=Q1JBcGOtatNaabkOcWtV9Qp9kyMy49v7eVd3ubOfJ1tBxEitszMoWfrz
   4xrn9XRGxVJbLw6zFQi21VODc4mbXgCMLU4fz4Q6Kp+PxWe9xYo2hrFNy
   w6s7696xftqavjCgy2qkEdWBgh8M/edUR507bm3Th/ceS5rW10DoPP/7X
   dhdhy2QHTS1pVl+1RgGDMVfNJtW6enBPRbxyVat3pBZtOeUW3+0u+cJj3
   SF0HxuVRazCSnSLEbDM89TeqmUMp+Hm3w+Gfec5QDULxwr6aEAgGYlrdm
   me44OodN/dYnaIAD5u993+/TtpkV9Noh/GSqAWPjQXhwA4bjmuMEeWF/x
   Q==;
X-CSE-ConnectionGUID: 9l8Vl+QFS4iv09ybpipkLg==
X-CSE-MsgGUID: rMlsqmBWTuiTUketed3wSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="63101238"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="63101238"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:35:32 -0700
X-CSE-ConnectionGUID: wy/19yaHQNKMowTYt1/94w==
X-CSE-MsgGUID: HSRUTghWR5KW2Qd/mp4wxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="177480116"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:35:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 13:35:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 13:35:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 13:35:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSP7MI9UuQeV0SSxDQYjRxDHk424ZZe0VmjVYUF/PhSBgZd8v+Tb3kF0nB1UQK1m3ChR0HqVoIm7rpoYo11l0Jw/kFdCsTMc5/DPw4Sn5HO5vX4EE/XnSKyb3vmOk8a/+KsCws6TxSHzrXuZhTcEsttfGXx5oGXS72ck021bzvbsfMtn6swfPbUinaKGAr0U/d0WwderZM3yfmtngkDIB/odqjeygrHUt9ToOvN+cDkYgLoEPSK6aNW3I/TJqST68F+17YFkBLPJO+SMovmseGcic3FZPSr6wRYNhSZCwgiirHh1OYxfG27f+lHDGZ31fgwu17jWfp14tDjFd7Je2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv6Ysgk1vpb0LUTxvrwnDwbTnKiV17JJoEBTB5+fx1c=;
 b=T61iM0criMCFUqYAbooMUXffSQB/RColRj9iO576pWXUt13i79OoivbTmC5FnoviZ1lqUbUf4TTfcjZkEAPUvIUrveH9yNdVqOSpkaK2a8DphojAbYUEnqYUuNQ/v5askLr8NsE3J07H0r9inX5c4x9LcVMpzQ/RbAXdBW3wSH47alNNzb6Ecog3V1VNBu5xOK28iz63UMyy1mbGQDxlzPxJz75rS0uyruLxG3bAXmeQYHXjOb37nc8uK9Eknz+wGQwLNrCsRJQ4Vxminzx9trLQ9hP0Sdfaw2oQQqxENnsBA0t7uOCPpL07BFiUaZCVmBPrI1i2KA+O33IcpuK2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by BL1PR11MB5223.namprd11.prod.outlook.com (2603:10b6:208:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 20:35:23 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 20:35:23 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Sep 2025 13:35:21 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <68bb498912718_75db10076@dwillia2-mobl4.notmuch>
In-Reply-To: <ae564552-e0e8-4d97-9578-d19871697ca5@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <ae564552-e0e8-4d97-9578-d19871697ca5@amd.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|BL1PR11MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf8fc00-7387-4515-b911-08ddecbbbd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVo5bUFPWXlhaTNHa0Q0K0c1Rmpsa1FNVmRQeXFCQlBZZ0MxQ3Q2WnBNdGNw?=
 =?utf-8?B?a1dzNkNWakN1d201eGc0SmUxbjZTYUNjOExOa0lwOGhycEtGYW5McjJYSUxi?=
 =?utf-8?B?dmNZYXRXTzhxQXJzeUMvVWwyMHI2YVpRM29wY2dXbENNK0oxNWpYVEZweFRp?=
 =?utf-8?B?dVpUZzNBTVFuRTlOWXk5ZXIzOFIzbTUwZlJzUmp6L2w1RXQ0WngraVV3MHA5?=
 =?utf-8?B?U1hCK2JWWGQzU3BaRUFBczdoRE9Ja0tZVElHcUdpUlFGU1F3TFA5Q3pNeVlO?=
 =?utf-8?B?K0l4SjJ2eTRYN2REck1KS1RUV0trSXZIenV0RU5vcVdvZERmQnEyYnRtZ3Zr?=
 =?utf-8?B?MVdyY1g1Yzc5R1pMYjZCTGhBTGxqSUtJeFdESXlMeFRvVkUzVVFUTmZranpG?=
 =?utf-8?B?TTFvaGtpcjBaOXd4azNDamhLcDNHT3dtb0c1bVM0WjRBbVlMdlVPZEFkS2xo?=
 =?utf-8?B?c2pCMWx4blBncXZ0eUtaMWxIQ1pJU3hQRHVnbWVhQ3cyWGc3NHJOOEU2ZHVt?=
 =?utf-8?B?V0NoMXlRTmxiSjZHVEdtRGhMYko2Z2dUckRrVGF4MlJ5aWN0bEtlYmVaTWE5?=
 =?utf-8?B?YXd2YUtkV2w2eS9SNUpJTjFrQnpRVVEyd1NMSDRoRTlzc0JISTJlRFZYKytk?=
 =?utf-8?B?N0o2Q3ZFUU1HR1M3YUhFRlBFMHIvYzJKb2lXWllDakdmN0FjV2owMmpZSHJj?=
 =?utf-8?B?WmEzTmRHV0dkSzVLYytibCtsV2t5MnNYR0gzRUwzQU9nVlhQbzBvOTNIeU9N?=
 =?utf-8?B?N3JLT3VLampMVWZDTnR2RndFcEo3R2xPZm0zekRUR29FcnJLYzdGZUtVaGd3?=
 =?utf-8?B?MU80SHJMODllcHVxeUJaQlI1cCtIT1M5Q3IrcVJxNStlTkQyTTU4VlpYQnkw?=
 =?utf-8?B?MGE0a1N5UW9KTVJweUV3OFNqelZiaHMxT01kVDQwMzJYRitIWkZydFNueVVt?=
 =?utf-8?B?TC9pYTVqM2VKY3Z6YlpsR1NXaVB2V29tQUpNeDFpTjNRa0t3cFBSS05vZGNt?=
 =?utf-8?B?dmE4SGY4Y2xqVC94Y05KVEJHYURocWIyUW9uL2JaNWU2a0V1STNmWEJwaXUz?=
 =?utf-8?B?cU50b1lDVzZhQVR0ZVIvaGJBYzdVM0RUc05abWR0UnV1dFpUa3pCc3Nodzh0?=
 =?utf-8?B?Nkh3cDA5a3NFWXhydUtaVVgzU25ZU2lpMEFEbENhcVRQWEtlT3F3Y1BIKzRP?=
 =?utf-8?B?cU9RZm1TQ1VPN25rVVVRdm0zVUNraEVIZGVZMm9UNDhwTU1JUGFjOVB5WXh0?=
 =?utf-8?B?M1BvVi9OY3JoamJjNG5URmpZK203ZThoN1lIZmgyNDJmeEY5MTlkSjNkSm9y?=
 =?utf-8?B?Z1pzZnV1TDNOTHAvaEVJaG5DRE8yaU5wZmFBalAybG9VZlpscENwNVlscndU?=
 =?utf-8?B?VEEvT1dQTjZXV1BsenhQY3grenAyMWhsUmdiU3RxUFFLOXBmUEhYaUpVSjEz?=
 =?utf-8?B?RTVHMnJZYVgwS1VFVnU3MkRBb3NiNTd5QU54aVVYNVBBcXVXZlFBUjA3VkQ1?=
 =?utf-8?B?a3VmR01tNC84QW5aaXlmbTdPUktFbjNuZldTWW5ZdGZrSkVJWVI1M212aWtH?=
 =?utf-8?B?YWE0L2NweitSOWNBV3NldDNHOVdSYmh5LzlUY0dLODVweFVNcjhuM3V2UnUy?=
 =?utf-8?B?dnp1cEdOamdRZk9IajBQR3FPVlllaWdSalVtWlN5VmVmaG8weEpsRWNSeWpN?=
 =?utf-8?B?K3RIdWN6RWtybUF0UWZWdHgvbzkvT3ZNV1JtcTdhbUVxdEp5TndtT25pNlJy?=
 =?utf-8?B?dml3K1RxVGoxa0tpeDVUSVlKbU5vMi9OcE16K1ZBRkEwU0lHU0V6S3lLNU80?=
 =?utf-8?B?Mk00MEJjdXhVaWQ2Y3I5ZmNaWUVUOXdEVWZQZWVOemxPZ2FmaHN1eFAyN3lv?=
 =?utf-8?B?N0p5a2FYUDVkMmZQNEp1ckZmdFo3ZmExaUtEc2xlMEd2WlNjcHFnYjBGN0N0?=
 =?utf-8?Q?Ly5xOE4utck=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzhjM2FTNDBkeHJ1ZGowWEdXeXJUYzdJZEZDWnRxVGV3cDBURDJrSUV3MmJy?=
 =?utf-8?B?L1c0Zi9Fdi9JYXRxaVZKN05jVTJKZnByR3czYk1ZNlpSZ2ZzcGhOcjkvSWZH?=
 =?utf-8?B?WVQ4QjhWbjVBK2tBUVJwZ2lUVDVEMlBWWVZCVDBQMEd4L0pPb0NObXZ4N0Jq?=
 =?utf-8?B?NE5iczViNkwrSEg5bEJTaSt2OVdLbFRWMHF2TVhTVjJ1bnBtbFFhaEJmaDVF?=
 =?utf-8?B?WjhWRE8yZFRGT1pKR0pYSlZPZFZxVDFMNTdsZ24rMU1randyT0M1SnJJMzRr?=
 =?utf-8?B?YWZiYUQremUvME91ZDUrQTJzcE1hdnZOR1haYXVmem93U2d5K3JNb0J2OTFl?=
 =?utf-8?B?Wk9sOUdVM0ZHaWY3WXZ6YS9XQWJZaGUvTW1CYWhHT3lSb0lyL3NsUWdmZVZQ?=
 =?utf-8?B?T21raFZXOHF1L3pSTVhrSjVCSHZtaFJBRWIrd21jMmhNcUZFWnQ2bU1qNmpL?=
 =?utf-8?B?NFRtOEdST1h4VUFqSkRXWUNRdyt2STdUYXR3NXJKQzVlVncyOFV0VDRJViti?=
 =?utf-8?B?bUt0alA1cE13alF5Yk5yZHd6Y1Q2OXkrWVk3bmhkUVpyYndmQzh5R01xYU5C?=
 =?utf-8?B?bXNmcW1uVCs2bFVJbGpzdHZ2U05mUE1HdHNTNFowWlVQK09keUFzWjhwaFlO?=
 =?utf-8?B?WkR4bWhXK05BMjgyMHJ2TVJ2d3BDU2k4Q255d1VMVXQ2aTJMZDFETWdjNCtW?=
 =?utf-8?B?TEVvZ0M3elVhOUtCRHg3MlNtSXRJVzJoMUhoWHQ0SjdRaWk5WnJvNkRZVHEr?=
 =?utf-8?B?Mk91VDRjemNkaWtsSGg5Vnp5RWw2ZUw4RkxVUFBDMTN3c1FRamhhNG1iWHFQ?=
 =?utf-8?B?KzNCaE0zQ3dOcVc2Tmh1eE1QSFdsMStkREw2WFFabGV3eDBWbVZwbitmelhZ?=
 =?utf-8?B?R0NOdm5qTWNxQU1QRWNmY1ZoU0JBay9JcUR0aW90eG8xYnJNWDNReDUzOVhk?=
 =?utf-8?B?WTR6eXBqaW85M1ZkK1BWLzNLT2o2eGtiNEFmbDRnWkl3c0xqY1lQQkkxYVdy?=
 =?utf-8?B?NGxHRnFqV0gveTNOVkpPN3ZTUGRNbXRqeDc4Sk9BTEVyVGNUb2EvZW9XVWpG?=
 =?utf-8?B?UlA0SXJvb1NGMVlqNjVmYXNaci9sR2ZHQnRUNDByRkRwcm1GSS9hOEQrbFM0?=
 =?utf-8?B?dERMbTRRS2R0bGx3cUFCZ0VLN3V3Z2RGUldzckw1Qm5UVXppcm5vUDNYYWty?=
 =?utf-8?B?VzZMSGhZZjFXUXVwNS9RRU51NDEvU21uZ0VIdGd0S25QVXFLc3pOWThhQlFO?=
 =?utf-8?B?a3FXeVVzTzkzRDVvbEM1MTNQejdjK2hDeDhscjJGbUt0QThqV3BzUVJWcE1N?=
 =?utf-8?B?OWxPNkxyUGluTHZ6eGdiMFUxV3AwV0dNeG1tU1MrZGM3WloxNStyd1pZQTJ4?=
 =?utf-8?B?UkhRR2c0T3dJYkJLdVZEZ2dCaUxocWtGN3VmWjlNMmtWTURnMFIxbU5sbHVJ?=
 =?utf-8?B?YTRRK1BQcE1XOFFGRlNYUUNGUVVUSURUOC9tZHZ2KzgzaFZKVUMwVGxQMDRx?=
 =?utf-8?B?WmxYL1JITzRVd202ZlN4VDQrSHlGUkc3WVdJekY5bTVSRG41MXEybnBYdERP?=
 =?utf-8?B?d3hLR0hSVU1WVzhDMDI4NTlaMGMzUlZjUW9GMWYwdENHeHRqZ0ZETWdCdXAx?=
 =?utf-8?B?NmQ3anpkUXExdnFJRm5lR21tdE5hL2EvUkdSTVFobFFWS1FGK25NZnk5elNm?=
 =?utf-8?B?N2J1VDBJNERmSG5PWThDVmdXdm1DNTMrVU5QcURrbWlHVUFkalJydDExWHNr?=
 =?utf-8?B?Tlpnek9SVFNLNTdkRmNOSmRYMTlGL0tzbTVNUnZXd0ZNeGliZmJVVnlOZks0?=
 =?utf-8?B?d3dPQUFhK051TEtWcUtjbkJ2ZEl0dXZtcFJuT01hV3k4U3FWWU5VTllVT2dQ?=
 =?utf-8?B?amJWWkhOdTZkR1ZCWmNKU3dzY1AvK0lEZUNJc0RJQzdKdmRYNkhEbXJOOVhB?=
 =?utf-8?B?N0JoUHNEY3ZtM2V6clZRMHIrNVI4VzZYZTIwT1JXcHhIMXE1SlhYeW9YbGtG?=
 =?utf-8?B?UDdMcHY1T2hYc1JoaXN5dGhmU01KTjl6Rko0YUhPQitxd3VBaWdCd253eGN5?=
 =?utf-8?B?UHFCYVJJQmpiNzNacTgxSDRhRm9YY05QSHUxcjVXb3J5dGhZWGRFUGlVRE82?=
 =?utf-8?B?SDBybDdFUGdub1hRNmZJdWF4TUR1OWRZZ2VOZ3Z4VVU3RWRZSWt4MHlUQndq?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf8fc00-7387-4515-b911-08ddecbbbd14
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 20:35:23.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /o6zgguFfkEt5DZLmTJFWiwfEjSqT1RnKgMssNpShwlrnO9RgeLPPkW2/9zhmd2Qe4GqlWY0dRp9vb7Ckd7zS5Kryj9n663jEzyoHj9LHHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5223
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> On 27/8/25 13:51, Dan Williams wrote:
> 
> [...]
> 
> > +static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> > +{
> > +	int rc;
> > +	struct pci_tsm_pf0 *tsm_pf0;
> > +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> > +	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(pdev);
> > +
> > +	/* connect()  mutually exclusive with subfunction pci_tsm_init() */
> > +	lockdep_assert_held_write(&pci_tsm_rwsem);
> > +
> > +	if (!pci_tsm)
> > +		return -ENXIO;
> > +
> > +	pdev->tsm = pci_tsm;
> > +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> > +
> > +	/* mutex_intr assumes connect() is always sysfs/user driven */
> > +	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
> > +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> > +		return rc;
> > +
> > +	rc = ops->connect(pdev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	pdev->tsm = no_free_ptr(pci_tsm);
> > +
> > +	/*
> > +	 * Now that the DSM is established, probe() all the potential
> > +	 * dependent functions. Failure to probe a function is not fatal
> > +	 * to connect(), it just disables subsequent security operations
> > +	 * for that function.
> > +	 */
> > +	pci_tsm_walk_fns(pdev, probe_fn, pdev);
> > +	return 0;
> > +}
> > +
> > +static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
> > +			    char *buf)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int rc;
> > +
> > +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> > +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> > +		return rc;
> > +
> > +	if (!pdev->tsm)
> > +		return sysfs_emit(buf, "\n");
> > +
> > +	return sysfs_emit(buf, "%s\n", tsm_name(pdev->tsm->ops->owner));
> > +}
> > +
> > +/* Is @tsm_dev managing physical link / session properties... */
> > +static bool is_link_tsm(struct tsm_dev *tsm_dev)
> > +{
> > +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> > +
> > +	return ops && ops->link_ops.probe;
> > +}
> > +
> > +/* ...or is @tsm_dev managing device security state ? */
> > +static bool is_devsec_tsm(struct tsm_dev *tsm_dev)
> > +{
> > +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> > +
> > +	return ops && ops->devsec_ops.lock;
> > +}
> > +
> > +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> > +			     const char *buf, size_t len)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct tsm_dev *tsm_dev;
> > +	int rc, id;
> > +
> > +	rc = sscanf(buf, "tsm%d\n", &id);
> > +	if (rc != 1)
> > +		return -EINVAL;
> > +
> > +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> > +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> > +		return rc;
> > +
> > +	if (pdev->tsm)
> > +		return -EBUSY;
> 
> 
> In one of my previous RFC, I had an IDE key refresh call and it's been
> suggested [1] to ditch that and use connect() instead and the clause
> above prevents it. I am hacking something around this anyway (need to
> validate the PSP support for it) and may be this may be generalized
> now rather than later. Thanks,

When I recommended reuse "connect" I was thinking about kernel internal
helper calls ->connect() again and have the low-level TSM driver be
responsible for determining the difference. IDE Key Refresh deserves its
own follow-on patch set to layout assumptions and tradeoffs between:

* core helper that calls ->connect() again
* core helper that calls a new ->refresh()
* no core helper, TSM drivers handle locally. Local because the refresh
  policy might by dynamically negotiated per TSM-arch/DSM-device pairing
  and the core is not in a good position to drive that policy.

