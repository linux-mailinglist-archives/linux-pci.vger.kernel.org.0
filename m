Return-Path: <linux-pci+bounces-35387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A337B4235B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D1B7BB78A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8822FF673;
	Wed,  3 Sep 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G03NEzGn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6231A0BF1;
	Wed,  3 Sep 2025 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908977; cv=fail; b=Veh95F095QX4jlWW2MDjr+GaOGsS1Th28WI/2it6Y07IM4FUHN7/iboaHJg4nZTZ2BdORebGgbZRZmpzYlu278fdnvvruM0x7qNvCMSZ7n7HafJp1itcnL/qOD/VD7zYpYVOunjxSj0M+6PSJw2JLZrXS49JpoYnbogPGW/Fmbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908977; c=relaxed/simple;
	bh=iKQ6G23s4pcTkRjVdBh35s7VDZFPUyUPkNPOMokSfcs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QS/aA2lSF3DOCNk3kgSfNv5BfY3Yq7E/WLgUk6H+yxag/V114kQ7FUB7/cN2mEJmx9S5qiczYKknqfWcaBKKYjC6ygzgIGaBmka7xtYAx7/9tBseRFT6j0pNk9GXVYjO1TaJgTfMqoJPN61H7wctcpSbqcOD9WHjUUCL6xok474=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G03NEzGn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756908975; x=1788444975;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iKQ6G23s4pcTkRjVdBh35s7VDZFPUyUPkNPOMokSfcs=;
  b=G03NEzGn/CQFO1JPVfdWccuZpC0jU1eVEbRUyREk8aJ30SyxeisFKodt
   HbjxPcwr9rNbLKmQ8ueTRWtqcgd0rZEh7Hp7X2r6D06wL2v1u6bAylqNA
   VQoVPrOljXeDaqyz/3n21Sgbcb114UK+TOMhzRrMVtt9OfEa+PcZffLNL
   6XZw6br+hK8pmO5sJ4DDs+ilhqcoHsapxa+fM8tdUmJaZEtG4aM9j09OG
   yBwDMLe8g+MsCpal1fBFqu4ba2L86WDuULlTXgvkbH2oDqirnZsJUUgA8
   75PJsNpew7ty228Ekuhl/wJcK533i8QyxeMKPEH1+N3WRdGwA+1tH/nVt
   g==;
X-CSE-ConnectionGUID: lLU3qoYiRuK2dqRSXFWWRw==
X-CSE-MsgGUID: NtsFVOMjTyiV2GN3v4dWXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59292754"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59292754"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 07:16:14 -0700
X-CSE-ConnectionGUID: lpAv7EG4QpGE3E5uTc+QBA==
X-CSE-MsgGUID: aPs6+7+yR1uITAa1jDdT2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="176846374"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 07:16:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 07:16:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 07:16:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.85) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 07:16:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoAWtLJ5wF5Pj0tMkqwrIo5w9NciCLQ9END3KVuGpeAPvKZs68MuTcpkr73Dx+N0vWsIND47GXIt9enXrTb76ZwAJYAKFmN9cs2+EUZNcTOYUT1zzdSYZveoFKHY8AeVaeQmtv6d5Ut2en4m2qcWEmoH90SvPPW4LUABNcjzxZvepPt2uTfK6tk2PM+JaeahQ7mMqzcOLfd/qGCTyKOA6J0+qheWYhNW7ZDGv6bj/buRXPyY3RG7NiUbnnWY52F9qki5TeDx2SR+z1GESY9XHaIpAmcrrUzTpKYhbxoVhTZXhAKyVq9ZyJP4r0OkKPsCg0Jn70SqLtupqs+D8EgRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tOKYwA7nutaTk9fQ9XaD/pACdNGy6pV/xs/vIV398k=;
 b=BTLMUPpIf1kLhEPpD+CCpPFjDGqEK4+3/eUG6Txb+zZECt+D55GSPEaP87qh2foVyPfyXCDV8sIQgxA5N47uGC2t4vwY/7SfqORMb1JSyRtqUIEHUwgtg7v9Qrr0Q4hLZhb4aLdUr3v+X1hBOTzsYX+sTgvocV2nQCgkUiAQH59N6iNsWUh7WyN1ljR/Q9sGsLxwOT9AkTbJDwNBxbpWC1vj3D26JlY8M9QQoG/huBS6t+qlAnIcJbHEidsHPAaGhKxibRkRz7OLnO19HHiaa1aH7P7F4Z2+nhDQhg8xoS30PLgGVzz2Wp8DOB7mrW33AqXHfQqzXPZJVPOFI4AQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 14:16:11 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 14:16:10 +0000
Message-ID: <dee7db73-5a6b-47f7-bf4d-2ef45d8018c1@intel.com>
Date: Wed, 3 Sep 2025 19:46:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4,10/11] drm/xe/vrsr: Enable VRSR
To: "Poosa, Karthik" <karthik.poosa@intel.com>,
	<intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-11-badal.nilawar@intel.com>
 <bd981a4a-e678-429d-8526-abd9290906d1@intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <bd981a4a-e678-429d-8526-abd9290906d1@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::16) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|SA0PR11MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8c8838-f797-4542-8e6c-08ddeaf46e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFN2RDFCMkJsMFNWTW1SaEU3Zk9OOEV4ajZhVklORWhtRWo5S01Bc28wbW8v?=
 =?utf-8?B?Y1N5ZVgzYndwampVdTkzSEx3aUs1TzRsVmp0NzVnUlJXeWp2REVtWW5sbVRl?=
 =?utf-8?B?ZWZObkZOcVF0T1JpL0lNVFdpdnhZY2RvVktObzUrbjQ4dmF5SHZZT2JXWTB6?=
 =?utf-8?B?N1ZiRWgzRUQ4NWswODFvMjRoQjYvZ0NXZXB0QnpIWE52a1lyRFZaL3RQY1BX?=
 =?utf-8?B?dDl3YjdFVG4xQ2FQOWhPZEFZUTlrcStUTHBsZFhhV01CckVVSWFHR2JLL2NH?=
 =?utf-8?B?RytxajJlRmtxWGRZS3BzbllPdk15VUJ6bDIyMzBnUlhpYndRQjFJelVBUXRT?=
 =?utf-8?B?VnRlcDRveTYrTVpSd3Fic21pUUlqbWt5VlVMVGV4TXBneExEWkx3dGl0UXcv?=
 =?utf-8?B?cS80WXRiNDhlL1hsWW52alk0Y1FRVnhaT0pZTm8rZ3VkYzgvTWdaSTB5aFlp?=
 =?utf-8?B?SDkyeGZPem1QYmpXSE1rZ0FKbkc5TFBsdktaa3QyVWlTUExCQjBqTzVSRS80?=
 =?utf-8?B?MmJGd09mWXVmY3lQdmpyTDVhYk9ZL21XSW5CVWgvd1BsdmpHenQ0NEp3RFdr?=
 =?utf-8?B?UGhqK1lpRzVLOXJyd0gxMFZ2Zzk4c2dwQ1ZMZ0lWeWFsV0kySzZJeDIvYmFI?=
 =?utf-8?B?R0lBWUV2T3BDMmpSZXdSTjl2WndYVjBjT2QrVVhld3lUbGsya3FKTnF2YzNx?=
 =?utf-8?B?TVUvWFRXb3hpWENLYVN6ejVZRVU4aHI5RFJPZndjN1ZLK3dNOUVtRE1VMFpC?=
 =?utf-8?B?TW90dFI3czZ5R2pqQk9LK0JtQWZOaHlqNmo4VFpGazQ2OWlRRUkrWjMyQmRr?=
 =?utf-8?B?VS9NaG1zc3VZREV1L0xWdnlkOTU1N2xEUUlDcjBFaU1DcUxROThWVFZxVFNV?=
 =?utf-8?B?bXVMS21TbG5mc2xaTWM2TUZYZ29TSUMzd1RLRG5yL0pEQXhJdmd2NFlZeVd3?=
 =?utf-8?B?blBjS0U1QjFEb3U5VlQxZHZDRUVyTUhINW9rbkpKdUZmaXFXVXBJNUE3dVh0?=
 =?utf-8?B?ZmdJZWtObGRuNGxMY0p0S1kyYkhyNEU5eWNnQWVud3BDWHRuZjlwOGtLK3Zp?=
 =?utf-8?B?UENoWVY1bVRIZXoxcTRTcVJ1RnJsUjdvVGdGUVk4cUV1UjRpUUtubWtUNEN1?=
 =?utf-8?B?L3o0cjdYTjlWdmNROHcvNDh5Q1F6UVdZRWdmRit3M0l0bkU3NDV2dlIxZ2Rx?=
 =?utf-8?B?Vy9JK2IvOFNTNldTR29IcnNzWUZQUFRTM3BscWlvRFBvQjh0bVQ5WS91RGpU?=
 =?utf-8?B?Z0RPSE9oMzFpSWdyRU9lTHFkS25MZUN0bE0yZ05KV3VFQnRLSnZtZ3hTQ3pJ?=
 =?utf-8?B?MkpBQU9XM1IxUjE0eXhESCtocFhOM01tWkdiTXN2cEJaNzluVzlrTGlpQzRN?=
 =?utf-8?B?ZGY4TnJURFU0Z3NwQW5NVzdLQVU5SkF1SVlSUkt3UWVKcjEvcFBJNDRGZ04z?=
 =?utf-8?B?UEJ2M3VMNTRFRlI5RzdnUUoxNG94U1JkeEc1WkR6VGU1YlhWWGF4dWlPTlZj?=
 =?utf-8?B?amF6WUdrNFFYVnJoTU1tOGwvTDh0VjYzNGprdFpWY1hKU2NwQTMvTjk5bVFY?=
 =?utf-8?B?U1J0NkxiM0ZKZnRIcFFRWjNudUI2RFduUXRaVkg4bzFwbFJJU0JRRjFINGZa?=
 =?utf-8?B?VmlpTzdDR3BMTUZ0c2FyVFhCYUdNcE51T1gwNGIwMTh3YjZaVnc5b2pJS096?=
 =?utf-8?B?aDVyYkhrRml3bDl4STFlbVpUMnNlbnJRVTdmbUhnSXNPMlZtUUNuWUs5cE9J?=
 =?utf-8?B?UnJRRmJhUXlzUzE3TGxXVlV1TFBpWkVMMXRlUGg1Zzdrd2ZDQ1FCQ1lmTCtQ?=
 =?utf-8?B?MmhJWVRFbCs2ZWp3UjhWSFlMeGg2K294aEhyblRuc21lT3lodzNoRXNrK3FY?=
 =?utf-8?B?Z1B1NVRMbk5zeHIzTXdjYnJpeStQcW0wdERzd1o1WHVUSFc1UXIveWp0VkVX?=
 =?utf-8?Q?mYQ+98NZhgs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWRxMVA1aGx5c2lHek5KVFlka1FWWGtQblg4by9sejhjbWptRGU4aC9MS3cz?=
 =?utf-8?B?a2phdzRCTkVwZjIwM29ULzV2bHVMWHhuM2ZjQnRFVlZrQVZrcmg2aDNMdllR?=
 =?utf-8?B?TzcvRXZnQ05Gclk0Z0NFT0xWZ2ZWRDJiRUlWUFd6K1djLzU1MzFkdDlBaURO?=
 =?utf-8?B?dTVRN256RitnNmZRN3lacXFadzh4SXlWaU1jUG5OVHEvdTEvek00RHNlRHAz?=
 =?utf-8?B?VlFiVWpZTVcva1dqSHUxS0NBOEtuYTZtNUxWZ2Y2QmpCaEhFRWt0emJUMFJa?=
 =?utf-8?B?eHBRT21PdzhNZFZlZWRHdktkWW1TVEZrc1dXUGd0UVBsK09TRGhjMWowT08w?=
 =?utf-8?B?YlY3MzUrdmlhbHBtT2xtWnlGenpuc1dXREV6Szl1T3Q0Z2RGSWE2K1ZKUjY1?=
 =?utf-8?B?dU5ybVd2LzZkcURMNFk5TEJIY2dNc0pjQndyZExVS1hrVkNGYitVRkpuMFZv?=
 =?utf-8?B?Ukd0QUM3SkwwU09OWWhiL2dxUndzNHNIM3ZGdm9RWk10a3c1c2FIdExxS0Ir?=
 =?utf-8?B?aDBTWUpvaEp1SHlpK25jTlgxL29MMFluMkJoREExNGFyWXZoTjJiOWQ5c1ZF?=
 =?utf-8?B?Y1lOZk1sM3c3TkZ6NUxtWGxQSU5ud2FqY0o2VXd2THUyNmZ1SFlUV2JZUHBk?=
 =?utf-8?B?Q0dEay9LMklpcEtUUDJJNDhqWE5HQUN5TG9SZlFIZVY1VUNyNTRmWUYxNS95?=
 =?utf-8?B?R0p3K2huSm5ENElMcDQwNFF2c0xWNVduVDNpYktDbFgwcHRIMTNhWUxOb00z?=
 =?utf-8?B?VmF1WHVoNXU5Tm50Tmttc2VYaWswRXRhYWpMNTJEaThhS0s3VkZ4UDdoa2NO?=
 =?utf-8?B?RWwxR1QvcHRKblFhS3NUTFB5dCtLTEhMRGRtenRoTFc1Nm9KZlM1TndPcko0?=
 =?utf-8?B?aWdNd0h3VmUzSi8yVW1ZUW9ETTFrU2VUbE5BRFh6K1o4MDF2QzVHVVlmUXdL?=
 =?utf-8?B?TTd0QVRhYURpM2QyL0xwdEh4MzQ3TmVldllUNzcxbEFYSjB6UVhlMjI3Tjda?=
 =?utf-8?B?bUkxRUdMV0c2N1Z5Mzdzb2RCM2lOR2x5aFVFWGx0OHV0QWRxVXZ6TWN6Uk9V?=
 =?utf-8?B?bzZxODNhQ2EyTGtsbm9xYmc1VnNNS0NReTRMelJ1Z0JxMzcwWExKVWQ5QjBJ?=
 =?utf-8?B?QUpFeVRaZWpkcW5OVldaanpXUkNhQS9ncm4yQUs3T0RFMWNhSHRJVk9Dakhq?=
 =?utf-8?B?UnloVEFKemlEbVljU0tGT1pPc3ZTZnZQc1gvbmt4OThTU2RpUm82Z1NIZlM2?=
 =?utf-8?B?R3FaUkhmWUlkbVFTbVFEVHB5RjlnSWhwVGw3c3NkZ1NVYTEyNmdldndzWUNJ?=
 =?utf-8?B?aWVHZTNoQ1pZejdaWVdyL0piaTlUei95UnVUNVlDYTQ4ZnFqWUJlZGFwcHlJ?=
 =?utf-8?B?TzhSNkZscmlmR0J1VTdFcldrL0ExVkpreElTSEF0SjAyZUlqQ2JYMkthNDJu?=
 =?utf-8?B?dy9xd1NpU0ltcS9rOHJ0VXFITlBnQS9xcWFuSmVJU2hRZU9kSE9TeldHekRO?=
 =?utf-8?B?NWl1V2hlcExwQm51MUhLZ3ovQTZDaExQRERhSXNDUmVDdUd0R1JBd05RYkFT?=
 =?utf-8?B?UnhVTjhHRTFjMUY0RjYvWDBZNGp3QTBuUXVqdkZxTkp0bm1SdDhLWXJsS2Zw?=
 =?utf-8?B?ZkI2VFQ3ZXlhRGR2SjRoNGtMNkU3NXEvNWxlUDU0KzdIbWNpTWQrSzJtK25N?=
 =?utf-8?B?b3I3WE15VC9nSCtIdU9PR2UrazJuTWZBS2xWMHRNYXBKdlJJY2RMVnBnU252?=
 =?utf-8?B?M25tR3JIV0c0eTh2dEZOeHVjY3M1cGV0MWNEQ0tpVldneFQycDdDUE96cW1v?=
 =?utf-8?B?VWFlWTBGOGc4aHQvanBHTzFUNmsxcDBHd0UwUEgyWWZjeXo4Y2htZ2FHSjh5?=
 =?utf-8?B?V2kxZlVIMVh3b1U4dk1lWnZaM2hpMDl5c1A2ejJPeGJ4NVZpNU56c28zTGRN?=
 =?utf-8?B?dnBsOHBmcDdWVk0rUllvd3ZrQ1RzbDRiS080cmVPNURrZnFIMjRONW9DREJ0?=
 =?utf-8?B?Z0RWZDAzVjdMTmFwNnRqSVlhRE15b0d3clFFeVRqRkhOYlpYK2E1V05Caklu?=
 =?utf-8?B?dDU5SFFWTHZhWmNRdTIwVXZ1dFB1MW1NM1FUV2hQVW82Z0pWc0s0NnNlcCs5?=
 =?utf-8?B?eU16SHdhNmMyMlFtV2l4M2F4bkpsYjczemkwam9maVpERmpoTnk3b0RmcFBE?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8c8838-f797-4542-8e6c-08ddeaf46e7e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:16:10.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtoPYf/5xiR1FaNq7i0yvjWxRmjPOwpg0Sewg4IKJg5l/c+8bBFYaJt792SToPfBp1d74txSqzux2PLzcb+Rog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
X-OriginatorOrg: intel.com


On 24-06-2025 17:15, Poosa, Karthik wrote:
>
> On 29-05-2025 16:46, Badal Nilawar wrote:
>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>
>> Enabling VRSR in runtime suspend and also in System wide suspend.
>
> This can be rephrased to -
>
> Integrate VRSR into both system-wide and runtime suspend-resume flows.

I will drop gerund.  So it will be "Enable VRSR  in runtime suspend and 
in System wide suspend".

Thanks,
Badal

>
>> Also fix couple of typo in xe_pm.c.
>>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_pci.c |  4 ++--
>>   drivers/gpu/drm/xe/xe_pm.c  | 46 +++++++++++++++++++++++++++----------
>>   2 files changed, 36 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
>> index 5ae1df345416..fdf878594fb0 100644
>> --- a/drivers/gpu/drm/xe/xe_pci.c
>> +++ b/drivers/gpu/drm/xe/xe_pci.c
>> @@ -926,7 +926,7 @@ static int xe_pci_suspend(struct device *dev)
>>         /*
>>        * Enabling D3Cold is needed for S2Idle/S0ix.
>> -     * It is save to allow here since xe_pm_suspend has evicted
>> +     * It is safe to allow here since xe_pm_suspend has evicted
>>        * the local memory and the direct complete optimization is 
>> disabled.
>>        */
>>       d3cold_toggle(pdev, D3COLD_ENABLE);
>> @@ -943,7 +943,7 @@ static int xe_pci_resume(struct device *dev)
>>       struct pci_dev *pdev = to_pci_dev(dev);
>>       int err;
>>   -    /* Give back the D3Cold decision to the runtime P M*/
>> +    /* Give back the D3Cold decision to the runtime PM */
>>       d3cold_toggle(pdev, D3COLD_DISABLE);
>>         err = pci_set_power_state(pdev, PCI_D0);
>> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
>> index 1e061bfc3e52..19596d467298 100644
>> --- a/drivers/gpu/drm/xe/xe_pm.c
>> +++ b/drivers/gpu/drm/xe/xe_pm.c
>> @@ -147,10 +147,12 @@ int xe_pm_suspend(struct xe_device *xe)
>>         xe_display_pm_suspend(xe);
>>   -    /* FIXME: Super racey... */
>> -    err = xe_bo_evict_all(xe);
>> -    if (err)
>> -        goto err_pxp;
>> +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>> +        /* FIXME: Super racey... */
>> +        err = xe_bo_evict_all(xe);
>> +        if (err)
>> +            goto err_pxp;
>> +    }
>>         for_each_gt(gt, xe, id) {
>>           err = xe_gt_suspend(gt);
>> @@ -162,6 +164,12 @@ int xe_pm_suspend(struct xe_device *xe)
>>         xe_display_pm_suspend_late(xe);
>>   +    if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
>> +        err = xe_pm_vrsr_enable(xe, true);
>> +            if (err)
>> +                goto err_display;
>> +    }
>> +
>>       drm_dbg(&xe->drm, "Device suspended\n");
>>       return 0;
>>   @@ -203,9 +211,11 @@ int xe_pm_resume(struct xe_device *xe)
>>        * This only restores pinned memory which is the memory 
>> required for the
>>        * GT(s) to resume.
>>        */
>> -    err = xe_bo_restore_early(xe);
>> -    if (err)
>> -        goto err;
>> +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>> +        err = xe_bo_restore_early(xe);
>> +        if (err)
>> +            goto err;
>> +    }
>>         xe_irq_resume(xe);
>>   @@ -214,9 +224,11 @@ int xe_pm_resume(struct xe_device *xe)
>>         xe_display_pm_resume(xe);
>>   -    err = xe_bo_restore_late(xe);
>> -    if (err)
>> -        goto err;
>> +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>> +        err = xe_bo_restore_late(xe);
>> +        if (err)
>> +            goto err;
>> +    }
>>         xe_pxp_pm_resume(xe->pxp);
>>   @@ -616,7 +628,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
>>         xe_display_pm_runtime_suspend(xe);
>>   -    if (xe->d3cold.target_state) {
>> +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>>           err = xe_bo_evict_all(xe);
>>           if (err)
>>               goto out_resume;
>> @@ -632,6 +644,14 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
>>         xe_display_pm_runtime_suspend_late(xe);
>>   +    if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
>> +        err = xe_pm_vrsr_enable(xe, true);
>> +            if (err) {
>> +                drm_err(&xe->drm, "Failed to enable VRSR: %d\n", err);
>> +                goto out_resume;
>> +            }
>> +    }
>> +
>>       xe_rpm_lockmap_release(xe);
>>       xe_pm_write_callback_task(xe, NULL);
>>       return 0;
>> @@ -669,7 +689,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>>               goto out;
>>             xe_display_pm_resume_early(xe);
>> +    }
>>   +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>>           /*
>>            * This only restores pinned memory which is the memory
>>            * required for the GT(s) to resume.
>> @@ -686,7 +708,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>>         xe_display_pm_runtime_resume(xe);
>>   -    if (xe->d3cold.target_state) {
>> +    if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>>           err = xe_bo_restore_late(xe);
>>           if (err)
>>               goto out;
>
> Please rephrase commit message. Other than that, code code flow looks 
> fine.
>
> Acked-by: Karthik Poosa <karthik.poosa@intel.com>
>

