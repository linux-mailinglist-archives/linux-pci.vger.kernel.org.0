Return-Path: <linux-pci+bounces-35488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA5BB44B41
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 03:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B7B1774E8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 01:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C38B72625;
	Fri,  5 Sep 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRJcAwtH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02F1EB5D6
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035695; cv=fail; b=d6VSfs8oLX8/u6oTebD3fv9hXU2DOEAU8sSK0wYdGYxZ3moInK8aeNponmUHqy6khRdfwvZSUOo7+0ohlrx4RHyMkqolPKOq71EuqGefzAamb1Z7ljs4XgQQrjOlfmgEVsIstFjgeA9CGxzFmmoVeK5dK5ZDnzxxjmwtopYg0oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035695; c=relaxed/simple;
	bh=awgqV/QGVEmmSHcYaRHjmz0vMOzUK+mO5FJa33jqSKM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=JqNR8+wRiqdOfZv/02fM6F5cSoRAEvkWPX970QKAarXP0eGT/YfatnCG1zjW10ekY9xOG9BdWn0B/CDlGRBAj6lWB1vWKPiKflUcNSGyMupqZ96b0HpNi6T1kejz3HfIluF9pKPGZAr3Tg9oOq9vT8ke0cMZoYVkDc6jvGaGa+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRJcAwtH; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757035693; x=1788571693;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=awgqV/QGVEmmSHcYaRHjmz0vMOzUK+mO5FJa33jqSKM=;
  b=CRJcAwtHYEyEOOBlNSTvfvV46r6EbgsieN0Rr0B8D53mCo1/0JgcszwH
   yTQg/6dUgjgaxieQGXu1qBfK45RBl1Wd3Sb/XFkW1r4+Z2nRaqkHfFRJT
   ApNPxUtu0rawOQ0VXuyAoh/w8HGAXtUDp8CM1lytxU51IYkq+gtIeRzD0
   EcsQWbNhG82GwwcBOpjxF57nsPVHE1F76T7Y/wVDyBRdfTa2e00GfLKKn
   qJkcehRI34p27fhu+K6m7hA2g1Oxj2q8PtTtLkzsBTGlJGJ6nexnvOjl/
   KI9mHEKdm6pwrWnW1QWlPq+miTkgE8FaSpXsFIhsr4Y2Ce1XY5VIwOE6p
   A==;
X-CSE-ConnectionGUID: 4SfcPDncSlG3N4EuGauAiA==
X-CSE-MsgGUID: KWGk1y7kR2iYgIbQ5CaAeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59244912"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="59244912"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 18:28:12 -0700
X-CSE-ConnectionGUID: n4CaNWEmTga6oa5X7AHXeQ==
X-CSE-MsgGUID: a20VoEk5SbKy/O7clMnz1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="202871591"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 18:28:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 18:28:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 18:28:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 18:28:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdAZEndNNmyynXpW7f0TZHupMXDL9Ote3NHL9C7dm5Mpr6Y+VKSq0RS9v2LnWjdI5h+02V0NpwM8nOuFzGIr2zygKjbzufjnL82LJr3+QmI0SFn4VplUFZhMh87v9oQT0IHb3mAaQcd3uq4NnZhG9/YN8jj5D3pWhhTJuG3SrnVQ2fB+E5inSeu+esQTLEKAsmixmCt2MoiGo5DWYep2INMDxysV22lFb+eRdkQDZ55ezm653rsajhOrmg/RGPMwb6FHGIsoeoiFOJLU6DIEtuRPRHxqyQ3lTfFTBXPkcwAldzPGWEgRT6Y9EMga+TooLeCRR02yRc4F8OZtXrkSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOpk34WmTjg/+hsfKPqbOlvpBMa34asFqTNKPgggYrI=;
 b=ljbHy6u4yMIKLei10Z/Q0YsgoRHVPEHMrdbiD9Md2h0nP4zhp3JFb8jg04fs3cKzRuwcoF4/TURxe+BwqPLecR9zdKZSqxbvcOdxaHDKJQb6nWaorhRZOeQvfzk39zBqN2wAX5fj1rGP4AS4TF6EfI1nyNe6qaiqjN6NOuGWv5h0VzIkMpjgeLD7yFdHXFkupNFDpew8yPw9FeXMhqTL1Oyxl4ia7vE9nAr3V8Uy9YUKIi2o0BIYkUjbsNbvIgTJbSrxJPNaSkoJo5YQIe219Ld2+NmXc/VqeXaqw7r5YHwYcjpvhM2EWQlRZLJdSO9kHxUy7bRxgQ8bYyxVtnQdKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 01:28:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 01:28:01 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 4 Sep 2025 18:27:59 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Message-ID: <68ba3c9f508ed_75e3100ef@dwillia2-mobl4.notmuch>
In-Reply-To: <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b4d209-01ad-4cf6-b44f-08ddec1b73f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkpsUnF0bkQwSFQrNVZWOUxTS09xNEh0QzRIT1I3U3hka3F2R21zSDZBdGor?=
 =?utf-8?B?SFlVdmJTSmwwL3VGamtHQW43MEdIeEFVeWFRandBK2hiUjBORTBHWVRyUG96?=
 =?utf-8?B?K0dnN1ZPd1I0Zzc5U01meSs5ODVCK00rTjB2d3QxTWt4OTcrbDZsQnZWaXZ0?=
 =?utf-8?B?aHpodElzalhQTmpPbms2c25yWmh3Q1hXdjhreG95TkFhcE9FcHhnUk9jNmpa?=
 =?utf-8?B?M0FocTMxYVBheGs2TklwdkhhZXRjK0x0S1RYN25Cb0x6YkJ0NFB3aFJHdnhC?=
 =?utf-8?B?MHBvT2hsckwzTzQrdWlCczdGdkMrZHFGY0dlT243aks2V25ldjM4emR4aWtq?=
 =?utf-8?B?SXB0akdqUEJZUmlDOFFXclE5VUpCaVU4VmRjVnY1eXVTSUlEN1NmVnFqQ1F0?=
 =?utf-8?B?UTV4WWx2dmV0NjdJVjRtV2JJcU5EYnFqcGt2T1FZRVRIeGpLK1M4QTh3djVO?=
 =?utf-8?B?YlhXRHhCQVJEQUVGdjAweFNUYXd5aVBLQ2tuTTVQbm5GRXlzbzJ6Z0RDZEF4?=
 =?utf-8?B?MXVxYm9JUXlGcXNsM2UyM1ZaTk9UdnBiTXN1VndxY0h6T0ZmTCtnSlY3NmxU?=
 =?utf-8?B?Qmt4aWJ6cyt5REkydFRPRC8zY3dLd24vc1pjUkVSeDI0SGZzcGVvRTNrQVBj?=
 =?utf-8?B?amo0RjFERGpGTnBOaUh5SFpBVnNIYjYrdDlLU3p3eVRNc2xPaXFvYjEvaWk0?=
 =?utf-8?B?OWpUdW5rRThHdEkrNEljZkpabk1kdHc4OUFrN3JTdjhpMVlHaGN4S2JnL2lT?=
 =?utf-8?B?dTVLWHFLc0FjZ1Z1QnhHc1VrUkE1THBqczJFUnhRQ3c5cStCcXl4b3FKT0FS?=
 =?utf-8?B?MzFwVzJCaUkyODhtaFBNZlJYajI2V0dOR1BKRUtiK203ckFXQVBhODBWZXR4?=
 =?utf-8?B?NHlqSlhSWU4zQnQ4YWtmNjhCVVRsYVFxMEtUdHhRM29tSDVMNDNwcENidnpn?=
 =?utf-8?B?ZXNSNjQvMHZrVlc5MnByb2oyUWVvZ2FLTHU0Y2VwUWZ1bGRoa1dBbkpUeWpY?=
 =?utf-8?B?ekZpQ0tJNDRnTURQU3I0V1JoWEdkT2VuM0NEODNEYmxiTkdhZTloQlRZM013?=
 =?utf-8?B?OGZ2eEJENXJKcFZyb25mNmlJWjBRUnJNQkpmSGlKNUlwOTdmT0ZiV00xVHFC?=
 =?utf-8?B?OXd3WHpTbEdlZXlKaTBiRWg0NCtxRUFGKzNSRk8raEhPeHVqTlN3djAzVFkx?=
 =?utf-8?B?ZVh2RHpxWGFnWFRVSmJzOGdib2tRVXhZVlRGSkQrT25aYkh0Y1d4ZkYreVNI?=
 =?utf-8?B?c05zcXBpeUJIb2JQalRIVld0RWFsOVc1N1ptVnFZUDlLcnNKemFmdXoxaklL?=
 =?utf-8?B?N1BOSHNoc0VieEg5aUI1SjNXMWlzWWdsTVNyT3l3TTNmOFEzY2VQQ3ZkYXpB?=
 =?utf-8?B?V2xIZHRtVmZLdDc0K1VwNDdWQjVnVmFxbE1Qc055dHFTREZGSnNNTGJ4b1JD?=
 =?utf-8?B?RnRETENMOVcra05SM0piV0grOFhla3FCdDRhcUliZG5RYVM1VXBJU3FwVm9R?=
 =?utf-8?B?RnJQaS84clRiMWFOclg2cE5oVk5RVzZmQWZMQkhBWElQKzVzc0FLbGJkbmJN?=
 =?utf-8?B?cnk3Nnp0eUtTTnh6U0ZoRjh6Vk8rY2FuM1ZpM0xUZ1FJK0REZnd2WlpoOGtQ?=
 =?utf-8?B?SlJWSEtTekx1QVVobWxhYU1CZ1lhSGFraDhMZm5OMll6bGVDM20zandDQkZz?=
 =?utf-8?B?cTZYOEV3ejNWeWQzd1E3SmlCTzdYWWhyRW1yVzFTRDM2NHlneHByTnN1VG8y?=
 =?utf-8?B?WTkrOUY2eUlSY213ajRHVGxUYW4vUDU0cFY4M21NMkVyMU0yOEt4SGJZYjJV?=
 =?utf-8?Q?LgjEYrZwwfXXnug/qS8glqowmbtmvy2RJeNCk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1pTeFdtTDZJU0tjd044OHNwekg4MWwzUncyQXZuN05RYnBVREIwZkFWKzV4?=
 =?utf-8?B?aHFoeHZXNGtIeWJTMnNlNmxJSHRoWlU1L3UvVkM2SjdRaW9rWE5KeDRHUGla?=
 =?utf-8?B?Rk95bnpzR3RYZlowbWF0L1NqaUc5WXN4MFZXZnV5ZkRoTkZ4eGNINlphQUdU?=
 =?utf-8?B?SHpKWjJVVEhuQnFuQzRxcDJwMlVYTFUxdUlqaEpVTDR1dUlHWmQ3Z0RvK0k4?=
 =?utf-8?B?bkFKS2tPYzNickowM3JYaGF0eHlZamRKWEtSb25INUszS3hma3R0REJBNVpH?=
 =?utf-8?B?OUxFc29obGN1dXJFMlJiTWU4ZlNiRXVCZHc5ZVA0YjFLV1J3MUgvZmRTUGdo?=
 =?utf-8?B?M1NuZDUySlBxZDlDenA0c2JHYUQzRTFYZElwYVRnZGJPbGNENm5rMzlFL29h?=
 =?utf-8?B?b3Jxc29lRUI5ZTJPQjBFejNGZEZMUkE3alpzQnlQOFRudWFTY3owa2N6U24z?=
 =?utf-8?B?SWNudG4zT1VNSk5VcURPb2pGUHI5TENGSzlSWEZIamp1WjVpcHJWRDFpR0M4?=
 =?utf-8?B?SjgzYlJTOGZISVlOdklMYyt4MnljbW51SzdUNlQ2NVBkb3RJT3hBdThuNVZm?=
 =?utf-8?B?NkZ3Wjc0dUc1TWs4Q0g1U21ma3dIVnU4QUxFN2l2VktYdkRxNzBNVlM0d1Iz?=
 =?utf-8?B?dHRqNjhyQjdURksxWnYwS3NvUExvblRHT0k1ZEJkT3NuMjdkeHlVN1BQeTVj?=
 =?utf-8?B?L3RUaHpQcUVXbDRJUEFsODg2SUhhWXUrK01VdHhLcTFaMllha3FGdlN1MHZU?=
 =?utf-8?B?cUJrWjNRaVU0RktHQi9mNVZkektYQmd6K2IyYkFFS1dTUFVWR0N5SWg3MEdU?=
 =?utf-8?B?cHVKajAwSlFYWE10b3NMeWFlMzhwQ3Y0bWp1UEJkZVJHTm1lMkZ1SzN6L0tX?=
 =?utf-8?B?SmZyekp6S2ZNSjZJcmFDK0RaeG1OazZEQ0pLcHRmZHErb0dGUWhHVW5sWDRU?=
 =?utf-8?B?aDdwTnBYNkhEM1E2R2tqdUR4T2JieTN5UDRZNnY5azhTY2U3bEV4K0oySEJu?=
 =?utf-8?B?YmpuRGJDUzVHamw5OGdPTzVNWWsyZ3h0ZVBGRVd2akpmaDBDR3NVd1hFNTc1?=
 =?utf-8?B?ZnhYak5sVnpIcEIrSU9vYnRoWnRQQUxoaFdCVml0aEhtdHl3Wmo1N0RwUnAy?=
 =?utf-8?B?RHNWZGJlV2Y2VU9QM1l1VkFhbHVPWi85aUw4QUhOSUZmR2ZPc2EzOXB3N2xj?=
 =?utf-8?B?eWI3cHczaCtpM3lTa3hkVnJXTVZXUEpacm83ZnVCdisyb2F4Yi9UQlVSdWdC?=
 =?utf-8?B?VHhJeWs2a2JXWldzSmRpVkFSV0pIcmVOZDFPL3RleHJQRllZWm1UR20wV25X?=
 =?utf-8?B?eXZFSjYvRXRGUWs0LzVaMVkrTEpOTTkzOXVZNnFXWENkSDhHU1dFYXp6SHNH?=
 =?utf-8?B?Y0pnTEFERGptdUtYbU9ZUkJGSEpBVXI4TGZWUmhmQUkxZ3B1djMxYmJybmVV?=
 =?utf-8?B?VmU5QWM5QUJLcjdBbDFvT0FUMG9jcTlVeDF4YmMyVXI2UHR2aFp6NzVMcmlv?=
 =?utf-8?B?QWY4WG8zK3ZsSXh0QlEyWk9laUswY2wrQnU5NGVxY0hFNW0zcUtrQkIyZnNu?=
 =?utf-8?B?cEpBTi95c1JIc0JoTW1rc2JLZmM3eW40d0pGVGxQNTQwTDJtSkQzRndwZ0pZ?=
 =?utf-8?B?VXJVWVdlalNLVURQQWg2ZGhLU0oxRURoWW1pK1E3enVCbnZOb0JMZWF0d1Ax?=
 =?utf-8?B?V3pYemJKaUx5akhHS1BCM0NUUGlvZWhoT0FQZGFEZGdGZTdpa003LzdHZXk1?=
 =?utf-8?B?bjVScVozQkhWVTFCVkE1RUhieWFZWmk2U1h1cXpxdVVRZnhlYURMMGgxV3pC?=
 =?utf-8?B?VFhMVG8zNjQ5YVRCei9GTEZ0NXZOd0Q2bDNlNkpHWlp1ZWpqeXk3Yk5mS3hr?=
 =?utf-8?B?ZVBuUHpjSTIySUptQUpjN1VvSE9yaC9EcmNuOUhsVHZ0bkd4OEpHTGNGM1hs?=
 =?utf-8?B?RHdQejNNZU96WkVIVDdYTXBHZEcwemlxaDM4Vis1dHFiM2pOcHI1MVBmNHVO?=
 =?utf-8?B?WTR2b201SW5GeEtIR3F5c2xhcHQ3M1F0SmxUS0lvblZMZkhqUnRIZ2VCQjQ1?=
 =?utf-8?B?NG8yZ2ZpazBKZUc3bTFQQUZNZTNWOVRuU0M1SU5jRXBSa0RwdmdIb0RQNlJF?=
 =?utf-8?B?Sy9YOTRPR3MyQ0N0d3JIWG5RamFBTFhrTlExcmZMMHFwaHBVMnpWYnFxKzZF?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b4d209-01ad-4cf6-b44f-08ddec1b73f3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 01:28:01.2102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IOqjH/YWO0Uj1L5u1RrtTB8HiOfdjieQYzAQ2iD739gVaTM4qDNyWY5ZjVxSsUQrKg2I+5PDcZJkLlmqW1SHACtlEg5yq/6WpRkOjoM8HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
> > +			    bool enable)
> > +{
> > +	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID, ide->stream_id) |
> > +		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
> 
> There was:
> FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
> 
> and now it is gone, why? And it is not in any change log, took me a while to find out what broke.

Oh, sorry, it results from this feedback.

http://lore.kernel.org/9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com

...but since the address association registers are not programmed then
nothing routes TLPs to the IDE stream. My mistake.

We may eventually need the ability for the stream allocation path to also
allocate a traffic class in the root-port, but for now this assumes single
device TC==0.

For now I am adding this:

-- 8< --
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 4f5aa42e05ef..610603865d9e 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -379,10 +379,12 @@ struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide
 }
 EXPORT_SYMBOL_GPL(pci_ide_to_settings);
 
-static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
+static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
+			    struct pci_ide_partner *settings, int pos,
 			    bool enable)
 {
 	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID, ide->stream_id) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, settings->default_stream) |
 		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
 		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
 		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
@@ -424,7 +426,7 @@ void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
 	 * Setup control register early for devices that expect
 	 * stream_id is set during key programming.
 	 */
-	set_ide_sel_ctl(pdev, ide, pos, false);
+	set_ide_sel_ctl(pdev, ide, settings, pos, false);
 	settings->setup = 1;
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
@@ -481,12 +483,12 @@ int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
 
 	pos = sel_ide_offset(pdev, settings);
 
-	set_ide_sel_ctl(pdev, ide, pos, true);
+	set_ide_sel_ctl(pdev, ide, settings, pos, true);
 
 	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
 	if (FIELD_GET(PCI_IDE_SEL_STS_STATE, val) !=
 	    PCI_IDE_SEL_STS_STATE_SECURE) {
-		set_ide_sel_ctl(pdev, ide, pos, false);
+		set_ide_sel_ctl(pdev, ide, settings, pos, false);
 		return -ENXIO;
 	}
 
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index cf1f7a10e8e0..a2d3fb4a289b 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -24,6 +24,8 @@ enum pci_ide_partner_select {
  * @rid_start: Partner Port Requester ID range start
  * @rid_start: Partner Port Requester ID range end
  * @stream_index: Selective IDE Stream Register Block selection
+ * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
+ * 		    address and RID association registers
  * @setup: flag to track whether to run pci_ide_stream_teardown() for this
  *	   partner slot
  * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
@@ -32,6 +34,7 @@ struct pci_ide_partner {
 	u16 rid_start;
 	u16 rid_end;
 	u8 stream_index;
+	unsigned int default_stream:1;
 	unsigned int setup:1;
 	unsigned int enable:1;
 };

