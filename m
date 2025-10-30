Return-Path: <linux-pci+bounces-39854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F95C2262E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106CB1A6048B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 21:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856A8335571;
	Thu, 30 Oct 2025 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvOfPASZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4D335577
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858826; cv=fail; b=Kqk3QWRdYbTfQgJRLJm/pBxFB4pYgd4g19ttJjpK+LLEb1mNKMfGqM13ZJIbODxdQuoipUph7ZQJA7VbluXRxBvasOmLof2gfc2U3Qy9CTX2hNqDPLGPvmYpts94HBKwEdn/R9HI29CvTFLRp1+dfTMps834yluPs44hVGWdOn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858826; c=relaxed/simple;
	bh=7ug8BtSy78+ON1dGiFpvsj+a7QRHWcmlw+4t6YK2S/0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fFLGNqVlJTMS/V5TIjL32llFrF1dwvHxoK6TpgpP7ec1VYb5TEpUQUwIWbI5dnOq/Q3esj2GBkNFmZ7le8sfH/V4GQOIMUF5xZUS3QyrS+IqWg/0pe4T2EH0wNxI78oMY6V2Zx9fb5s/Vy3klwwvo4R8wwEKt04/gp6yirmAlt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvOfPASZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761858824; x=1793394824;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7ug8BtSy78+ON1dGiFpvsj+a7QRHWcmlw+4t6YK2S/0=;
  b=gvOfPASZACTrhCUc9f99uDkZMaA863VH13rcd6yzacdgPJraCoE7BzlC
   md4CAseO9lxgUlHF2XPya3BzSlck/RNelUPmKjidnVwOm8R8nWl86zLdP
   DnDKbjV0TnjMteKKQhaI3Y9D3wDuDWpqqQfj0tj1Nk9kqGWYADliwr8eW
   fKY8p6hfG3dXrbbANdC+EmBNJTR53HQMt7Ba6q9NsD5OqqgJfBCvA1S36
   QAqQXzT3Z9D22JvOKatCEb8SjuITMXoz2EJnUOY+l3d+YcKNp+r7QmcpC
   IIhoTyCZ+jloDNCDQQTIwxlrNUWIz3GaZ0WHXSMLrbfPACMYY43J7hCEe
   w==;
X-CSE-ConnectionGUID: Pgmzm8GyQ2KWX67cHhSh9g==
X-CSE-MsgGUID: zc8pZx1WTrCrYFPKUM0jwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67876236"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="67876236"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 14:13:44 -0700
X-CSE-ConnectionGUID: sHDMGeRMQsC9cct+prS7IA==
X-CSE-MsgGUID: EkfsT7JsThCJw0ZuTN/p9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="186161734"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 14:13:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 14:13:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 14:13:43 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 14:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2ymD4XwjoWmTM6XTsEdQXTtnLI0XTkOF8g37yRTFs8oiN80ocx8ldGBIhQ+zFTIZL33JcdgBqNsY+wCHoTc9SHNXzn/Yy3IWB1pFNadsbsR6eHEhxpuRA92MVZAeuu3L811V7Nc7OLl2JT9j2yJQSa3MlnTMJUbkg462A3n0+ocDBSuu/6wAxsIwgaiFGuj0hNu1y5gR1H9dqgHwyagZw77hD6p4o5Hof6d3fEutfZtkoxx0KgydNJzWwQG1YIx+Novzy2wWV1PGpAtumNwGWZRNtngHjIJY2QDNZsJEE5t+NxRhzgbJbaGDk1VkCYR+NbzZpL2NBm5JnT4CN+msA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ly2jnwaFAiCatU+TDrLUQ3YwwRaFKpB2nTCRxJZutI=;
 b=TfzaJ4VUDWKZBvFamXCqkU9sbuozfFgozs3L5jaA07n6g0oJLO1JtaNdUmcYyCHZ1zf9GqlaQxX70A0npcCUN0FnReHXlYTlBZdQQ0AM05XDQ9FWbaPGW2ay63sgA/1LeriRqHbcA4PaIHOoesw3pnsZsCOCBJO8EmZ3cKwjy1qtBH3tmWC68+Clscc5X4b1O/yjozcgnnpXMFU+tkIn2MvkC3NdgFoCQ4bBEk7mpxG8BjDt5nX+LkXF88OHvm6Y9b6QM3ANrt9+NwN1S9rC54V63ttkY6U0Q7vp8EtvsE8YbrAS4fmb7VgjdNpaks4Ko1sCz99E/Csd7PZ7OYSD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7075.namprd11.prod.outlook.com (2603:10b6:510:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 30 Oct
 2025 21:13:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 21:13:41 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 30 Oct 2025 14:13:40 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<bhelgaas@google.com>, <gregkh@linuxfoundation.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Message-ID: <6903d504e69f8_10e9100f1@dwillia2-mobl4.notmuch>
In-Reply-To: <74738e82-5861-4ac8-8e96-c98a22173afa@amd.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-3-dan.j.williams@intel.com>
 <74738e82-5861-4ac8-8e96-c98a22173afa@amd.com>
Subject: Re: [PATCH v7 2/9] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0124.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1fcfe6-d846-4917-0a98-08de17f9337a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WExGZUNKaW1pUXFiMDNtU1dYYkQ3dGRQMGtiK0RJWDFIaS9MTWM0bDRPNnJs?=
 =?utf-8?B?MXhTdzlvTWhXakFJbE9iWDF1Ni94bkRrc1pkcVAwWHZrWGYrTHpPR2g4cFhN?=
 =?utf-8?B?VUJONGxrWEFTNWJ0QmFkYnRueVpnd09GM1lIQTFTMDBvd2lvRVNXVzViNjhR?=
 =?utf-8?B?SEwwamdCeHQrL2w5cFg3aHZUSUFvSEFGWDVPdHN2dEhjNTRRNzZsOW9XeWlj?=
 =?utf-8?B?WUYwTk1WZ0ltMUxhQ3p6SVRMMWR3VEJJaVNXaTJLaU5hMFYvOUZPOEZvOVdm?=
 =?utf-8?B?SEpMU25icUYwbG93RVVka2lqcWxUWFNBK2JrcmJoVWE1di9yVlN3c2o2b0FO?=
 =?utf-8?B?b0lmRjNaQXdsWEtXZWljYTNhTzZuZE5nMlFHY2lSM05ORGlINXREdlhrTWtN?=
 =?utf-8?B?Mk1RTWhGS2VhNkpUTUtVeDNVdUd0bTVrNVB2aXhqMzVNVXNCZHg1T0s2bE83?=
 =?utf-8?B?K0dGYkh4L3VBSVpuSkVYTzRZaThzWEFOVVQ3N1Zhd2JUUlk2Z21aSzJFNXNW?=
 =?utf-8?B?V3RwUkRsckdMTGd3WVZ4MjF1T0NuSklCWkV2VTByUmtlbGRBcThNc2dkWHdH?=
 =?utf-8?B?ekZnTEo4YWl5K1dpUXFudGRJV2M5SmREbVRrbEJBVGFGVDE5L0ErOXhGUmVE?=
 =?utf-8?B?d2F2MlVIdnBDRnVZK2Q4dUZ1TFVVOTd1ZGVtYk5DWTc3V2ZOWXFmQWpQR3p3?=
 =?utf-8?B?eFEyYlhJRG1xNWppenBxWWtlMWhWRHZHSlU1cm9ob01tZGVleEZuY0tKTkZM?=
 =?utf-8?B?NisvRzdCQjh0Y3NpM0JVay9VREdxR2x1V1J6V2RmWjN6Q2Z4b1Y3UUZBSE1W?=
 =?utf-8?B?SFg0ZG85VkEzYWtnME1VUlo5ZFg2dWRXY01rS2VXRkFDc0QvdHJuOXJ2Q2xU?=
 =?utf-8?B?d242RHRubWF3V1RqMWhzeDlqRUZjRnRUN3NjNndocWR5eS9EaW1qU2xpd1ZB?=
 =?utf-8?B?M2xlMHZNSnhJbG54eTNrQ2lRdjVqaXpsYlR2ZFBvRVRlVGNDb2pFNlBmN3hs?=
 =?utf-8?B?Y3RIVlBNWWxUNFNxcENoOGhKOEd0UnorRUt4R1pLQmh3Tlc2U1BheFdnVFJk?=
 =?utf-8?B?YjFlcjE2Q2pEeWQ2UEx0bFRPcCtnVEcxMWZ2OHRxK2l3MEV6UDZHU1hubGFC?=
 =?utf-8?B?ZS9qb2loRjlBc1VITkJFK0xWdWhtdTZiZ3dsYXpzM1J3WDF2c2FYWnlFYVdr?=
 =?utf-8?B?YWlmVE4zZklRb21FNE92NmFTcStSL3JURWlHRERwOEdLNEhvT05rQU54Q1py?=
 =?utf-8?B?N0NGK2hmMWoybUlSL3NmbU50aTBMV2VPQVhpc1pMV0ZXb3FKbXpkUk5FWGIz?=
 =?utf-8?B?eWdtM1B3T0RhSUlXT1diU1hjVlRkSVE4bnh1dnNqM0gzbGp3U2h3N0Nodmph?=
 =?utf-8?B?QitWblhKdTdRMG1vcTJHL3gwenI5cWZRWjBCbE9xTVlsQTU1ZCtDdE12c3lk?=
 =?utf-8?B?RGNkQzNxWkVwZVVETlNOdC82bGtodktlODRTVWVQVU1LQ1YyZGMzZmNnVFFF?=
 =?utf-8?B?TkxVU0dzMlpLVXlLR0U5VXlOeFpUL29XSHo0TDFWRE5pMXdOOW9DVnhoZ3ps?=
 =?utf-8?B?SVRoUTB0M3VldWh6dm92aC9lYitQSU11ZTIrT295Qkt2dlpxZVlta2F1M0pV?=
 =?utf-8?B?Mm1TNWh2SnFvaXFYSGd1bkduL3kreVBaQXNBaVRCRzBDUkVRcStMQkpTWFZJ?=
 =?utf-8?B?QmQxeWpaS2svMmQwYUpwU0wzYnluekNiQTNmeUdtODd6SHlCTkVpTitwSFJn?=
 =?utf-8?B?N09tcUJ2RTJKdHZHTUMyZi9XNGo0ckNPYVFuWU5mVHFjOWdrelFQWlNwZ09m?=
 =?utf-8?B?Q0xIR1lHYUN0Rkkzdy9zcGtaZCt2R1VYTDlvbDNPa3hLQUpQb1F2aTczUGZn?=
 =?utf-8?B?UTkrd2xrcmhZRW9kb0daMUozV0VUYnp1ZmtNQ3dSa243aVVSdUVBbmNRY0Ny?=
 =?utf-8?B?WkRXV2liQkppc2FhRFpnOWVUYWlYQTF2QTgyRDNCVkN0WnphbDBJaTFZUUZF?=
 =?utf-8?B?Qmw2S29YcGlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhwYmozVTVOOXBxZ0swUlJ4eFYyMU5UTEJtRDV6Z3pUZVFkUEpRU0h2ckUr?=
 =?utf-8?B?bC9ab0lJQ1B6QXkyeEtoM1d3OWVaUmpmMDlBTk9JVjlXbitkWnBHWTdMTmI5?=
 =?utf-8?B?UXdOVGl2elV2Nk5sT1dvOVUyaFA4Yjd4WFFhYWVCNWdwM2xyZ0RvSVQyUW10?=
 =?utf-8?B?bElwRHhDaWxTUnNpRXV1ckVSZUFrQll2cGtJVnZZQ1dHQkRKenJtUXRhQ0p4?=
 =?utf-8?B?UkorY1pEOFowRzVaQkJvS1R2TjlyaGFhSGEzc3hBSFU5bEhZZ1lFdUZjOWlj?=
 =?utf-8?B?aFFuSmRiRjBvTnlaa3F0Um9OWnJFSkZNYTBXUGwxdWN0YXhEWnBGdnczN0hJ?=
 =?utf-8?B?NVo2R0tlQlNsV2FMYVR0bmJEMUFvRDIrbWpHdWE0S0s2UGhzK2crWWtNKzdv?=
 =?utf-8?B?VjBSL0srSFNRL0F6M3N4WkowN24wR1N4WncxSGxoNVcxVHA0S3d2RkVyalNa?=
 =?utf-8?B?UmMzcjQxZVpvK0pNWTZKN2RYR2kwdEE3UENzb0g0T292ZTB2K1BhaGxoKzFp?=
 =?utf-8?B?VmVvMXBITWVHak82VllEaVlSRmk5MUc2enc0eUkrZmxuSzE0Ui8wcThSNkw0?=
 =?utf-8?B?YVJaM09WWmtLUTBhL2VQbmtYQmNiYjI0Qy9JbXBjclZUSGhtb010cytWK0F0?=
 =?utf-8?B?Vm96d3R1dnNqVmFZSi81a0YyZE9WMFVJVng2dlFacFFrV0JhV1I5dnhUMVI4?=
 =?utf-8?B?VlpSRHAvV2pmYytTZ1BlZ3BsNjN4dENpUUV0NFIwcTd6MWlHeVBLck9WdG1S?=
 =?utf-8?B?MEk5NnZmM0lZaFdPSS95RWZmaW1pVVM4TktuWUFGdzdLeGZEQmdZRDJ0Yk9j?=
 =?utf-8?B?c3N4dW9oMnhRZitWTTZFZ2dZUnJtQTdEa1dGWGErQ3Fub2VheDgweUtONC8w?=
 =?utf-8?B?N3J1UVNmTWNLS2d2VzQ1aTluSXQzUUVJVWtIZ0tnQmYwd2ZtY1dYaklMa3dv?=
 =?utf-8?B?bzhrNmxyRDhZdWUyZUhGMVp1L2xDUm5EbVdUNlZWclNXREdYQXU5dFRUWEMv?=
 =?utf-8?B?ZWtXb0xWdGhVTHJwU1l1bmpFQk5FK1M4cWlWQm83b3hDVXl5Q00wTVpCa0hy?=
 =?utf-8?B?VTF4cXNRenpPVUdnU3lHZFNQSVFVdUpYUTc2WVUrelZjbGdSdnhYRDlyckFP?=
 =?utf-8?B?VDRUUkdhQmtQbTRCVnRZVktlRXZQYWtUckY1WVRzVi8xZGZ4eVdDeFhhUVVE?=
 =?utf-8?B?MzFBVVV1TEZ0QlZ6SHkzaElSamJhNkY0SW9HQjVMOStFM1NyZ0NBVnErUjNq?=
 =?utf-8?B?bkJUcllzcWZhMEtKVjdaWUJOcTdVaXJjdVh0WVU0aHlqMEpaMlNDYVpIWEVr?=
 =?utf-8?B?Q01qa2M1L3k5Wnh4ejl3c1BkRUZuUUx5R29XOGtIeC9nN2xUU29sUGc3NWFT?=
 =?utf-8?B?VURiQzJwd1RXRXRLSnJYWkd5VFlVeVJWTSt2bU5rbklkZCt3MGx6czg5alRQ?=
 =?utf-8?B?akxUUEdMeEtiaVg4SDFvRUtkZkRtMC9WczdxNnptWm9Vam01TWc5Q3VtQVVa?=
 =?utf-8?B?VTRGRGFDZVk0Sk5Lb1dLTG5EZlQ4eGdIYUhnQlA3YjZ6YXpSRzRPMVU5WjNS?=
 =?utf-8?B?emFKR2hNU0RHQUNZU3RBQmVHSU1vajJ0VHVtVVdSVENxSVpXOVJPdEo4cy9i?=
 =?utf-8?B?MHVQbmZGRktMVDdIQ0hTem9JL0t4Z3JPdEJ3YXR2OFRmZVJRK0kzbVpWVkh4?=
 =?utf-8?B?bmZwakVCc2pJY0szMmdZU3l5T3BWZkNSN3J1WWR6L3M1L3licmtQdTdKcWRl?=
 =?utf-8?B?NHl3ZmxUcGRSSWtOcXB6SzlBTkY5eEE4K3BkalIxek9uREh3eHVNR0dZY2th?=
 =?utf-8?B?WFZ2V0lQZ1hBNG9YN0M0eC83UUNFNTVscGpYRXo3SFZ5UDkrb1Vic3JITWhm?=
 =?utf-8?B?UDhGQWxucHZwcWtrcjlqR0MrbjQrQWtoWEpDak02bVhFVkczUy9zeGwzbVhT?=
 =?utf-8?B?QUZsWGJqVkVUU01jQ1FkU3ZrSENXSnZtTEw5cWJDT2t6Qm9wdzJrREpmbmFw?=
 =?utf-8?B?T2xBc3c5WktOdFJZL3RJcUYzZXRwb0ZKbzI2STUycEwrRkRBdzJFZGF3OFMw?=
 =?utf-8?B?OTlxODJCbi9SSURnRGlCdndRK085dzA3eDBiam9SV1RXbjhZSzA2TDNGSXo1?=
 =?utf-8?B?MVRLRk1PcUpvOG1xRDRxRjg1VS96UlRqUUc0Y0J0L0w4cExBcGR1bU1GbVpt?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1fcfe6-d846-4917-0a98-08de17f9337a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 21:13:41.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpTzFUbjNcDkwD9rkyq9IEcB6Ni0Grfg3Nv3qWby4HbpGrJFrz6Fo8Dh/Epd1YuYh3x0yP2Bhc65rojE45p2YwJ0VPaFzdvbkRfwY4QHvts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7075
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > +/* Integrity and Data Encryption Extended Capability */
> > +#define PCI_IDE_CAP			0x04
> > +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> > +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> > +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> > +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> > +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> > +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> > +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> > +#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Request Support */
> > +#define  PCI_IDE_CAP_ALG		__GENMASK(12, 8) /* Supported Algorithms */
> > +#define   PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> > +#define  PCI_IDE_CAP_LINK_TC_NUM	__GENMASK(15, 13) /* Link IDE TCs */
> > +#define  PCI_IDE_CAP_SEL_NUM		__GENMASK(23, 16) /* Supported Selective IDE Streams */
> > +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> 
> 
> Since you are referring to PCIe r7.0 (instead of my proposal to use
> r6.1 ;) ), it has XT now here and in the stream control registers.

Recall that Bjorn asked for the s/r6.1/r7.0/ conversion throughout.

> I posted a patch for lspci with this:
> https://lore.kernel.org/r/20251023071101.578312-1-aik@amd.com

I think we should handle XT support the same way for the kernel, i.e.
with a follow-on patch.

> Otherwise
> 
> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>

Thanks!

