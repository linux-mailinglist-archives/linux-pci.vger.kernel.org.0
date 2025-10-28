Return-Path: <linux-pci+bounces-39591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 443CAC1743D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 00:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F22574E1F36
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 23:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FA033CEA3;
	Tue, 28 Oct 2025 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+QuGma7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F22242D6C
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692458; cv=fail; b=hVMSlXiXBgwl4I9K8wPKK5IO0GKuD/IDm+XRwCv24zSx3XXM6qmDoNm1BjbMS+cY3H6NCez/UTAFsQkiYEqfOo6pWYxH1vgtD4tTtT095nRCaz1f8h35sPGLD3tJhd4HCMfpmAHrCX+mkNLqMygTL9HhEcr45+NdOYpSELRW8sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692458; c=relaxed/simple;
	bh=m8tyUbzk/4jXvZSNFw/GtjB0sKsVALWZsAp+XmmSxPg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=LbKnxHk/lo0364xBoxcAgKAQ7bUB/FrR03YBx+L0Vkc+EP6Dz9hc7L/xI1tyYgOSPHCBybuu1nuhfwwX7YD6Q8CRfKFsG0JYvuAPPFNtqYhyRaQwNCbKdjLGyhVkl3J4ch4YLKIcEMjyeIaJznbWweN0ihJTFvRjmxlMBDvj0mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+QuGma7; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761692457; x=1793228457;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=m8tyUbzk/4jXvZSNFw/GtjB0sKsVALWZsAp+XmmSxPg=;
  b=f+QuGma7Hj4sfOLFjtE++HeO4BY5R8TOF8evnKUyvS9pu1b8BlDlP760
   LW3GcMAds5Y1xh1qXsgKqNJDUTOwQ5U6PjiRztt5jUFteZK/nW5YOliiQ
   Zg0rY+NXC1Oy+6g8SyqURNXwgykyUKisbCKpOMzHv97TPhxhu4W8BWNqX
   syaM8P4JW3zaAsvV0AIzatIw8+R5d9+CEkDLwFrz00XN5du6wiIwXwVwn
   54TrCd5SvGmINPwa55se8L9aZRpIoPdU/yefQoOmUTk6x+mtNxXuL43EL
   o27zXzMXkV3cg5Wszck2UsM/7Vz/hOWmtvNqlGj2JpAy6KL0QdWd2h7Ct
   Q==;
X-CSE-ConnectionGUID: HVbLVp8QTQCLASjH/ajxLg==
X-CSE-MsgGUID: 8ps1aa/lTrGOb7ONnWD/Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63844223"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="63844223"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 16:00:56 -0700
X-CSE-ConnectionGUID: xhXK3l3UQraE8ChvCAp3sQ==
X-CSE-MsgGUID: Iy2KFb64TjKV5kUSuaXfpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="190669016"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 16:00:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 16:00:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 16:00:55 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 16:00:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7MvoLTzUJ/Vm+rrMsZyWUE70yEeRIixuAp2e6URyDnuFwIBtAOw3/HK6tuqC0RuV+k0VS1FtPjwQP4aouVeeCNgiGDgD9Jiu9Q9um1zxMCvIXuceh3MpvOEGk9BX/t12H26LpH4yhnb4hEegRmwIeDpKdHdmCa0/6ocdKRYwwjtttm1vbu7QjwEeY5zr9BD00+0N2FOuM4k7Ut6Pk3Md2KRKY87ORYoQKvSCPKebjuvGBQV9AsEtgPDw1SEKuyAdkbTMpolRqP7Czkjo5yQC1DjCy5WSiCMw6A2eBCD/8xZkVUcpgqFFLjHJfUhdfATOsGQ/Kt86UcLTrUcaID4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGsy4nJB9j1OlqEiSE2jhuu6ORtCpS8AR/Ny+cmLl5s=;
 b=ENWjS6y5A5KbEEg7KvIulfQiQ64pTN/XxYjf0WDNFNcuQJsjDMkWatiwUfVX0IGKbyTFVry0XgkqoJcot+McnDtx2BNxw1TJZOJUDE6asyqSWpyu3UjL4apX2GfeS5RLiHlLLvfYe1Pf1lAMb9IPansaNOKhJq0L2lB5WDu9PUCkpO7pj+HLFN6dXapYYO81BaMKKAaYQF2K7qHSpOHcmLH+6LskbQnu0ebcDIVpqhhIyRD9+qX9Noqq2zeB4XWucaHzhZKGcdAuAbKIYe1MhYeeTpsH5lBbagWa1MNOzPpO2yuAfAIkkpycU7in3rNKDbQOCcigo0ndjpAB4Mspvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6176.namprd11.prod.outlook.com (2603:10b6:8:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 23:00:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 23:00:47 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 28 Oct 2025 16:00:45 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Message-ID: <69014b1d8567c_10e910013@dwillia2-mobl4.notmuch>
In-Reply-To: <43070157-cfc3-4ef2-8b2a-e677515e8bce@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <68ba3c9f508ed_75e3100ef@dwillia2-mobl4.notmuch>
 <43070157-cfc3-4ef2-8b2a-e677515e8bce@amd.com>
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ebd7cd-d0f6-4b26-af92-08de1675d4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2d2TGFJeHZSNFFJRVBpdk53Uk45TTM1RkxtcmE4eGwzY1dYTnpTbGFqODBW?=
 =?utf-8?B?REdEd2NWNEJVT3lIQ3lMRE50Ym1kZHMrYlFnR2VCUzd6SysvbzI1MGtNZmd0?=
 =?utf-8?B?azhtUkdQVWwwbVU5bHF0RUwxQkNjZGtBd0UrY1RlcWk1TDdMZS9KcVpQL2V5?=
 =?utf-8?B?cS83SnlMQlhFTHFrOWhGTjV0aTE5bCs4U1pGMkJ1QUt5YmQxQ1UwbW9UUHBJ?=
 =?utf-8?B?T01tMzZrR0dNRlEwR3lyWmNoVmhuUk9EQnVhanh3bHVlbWd6c0krK1ZWYmZO?=
 =?utf-8?B?VGZhT05uOHUxVU9QMEVTVnJ1R1QvVE41dCtSQk5JQU1kbHdmMW1FMXhDQlpC?=
 =?utf-8?B?amw1dmlwQjdmelZvS0ZBQkgrOFlBenNBZUwzaTltbXJRazVacUJrNFQ2S0xV?=
 =?utf-8?B?TWlLRFpHWEgwQTN3RnF3UVVlTnU5NDVmTllqTWY5VlZQM0xvb1hlaHN3SHpw?=
 =?utf-8?B?UU01NUFGQjF2UXY4U05kVzd1WGR2SlFaTVVrWGM5SG5SbDhGWjJyU1k2RTZz?=
 =?utf-8?B?ZytWZTdOZXE4MHdYSHJpTkRoUDFnd2pjRU55WGFvSnhUZ21hU3BMS1FNQkdS?=
 =?utf-8?B?WkUyWDFUTTQ1SXcwdDZrek15bUI1aVNvS0ladEQ3MEhFSllRaWR5VzNiM1Y1?=
 =?utf-8?B?d29kcjFhckU5ZWkzY1Y1TVpPTzBTN1FxZVBBeWRsVEZKNFdDaXAwaVFiWWoz?=
 =?utf-8?B?SU4rVG5XQ0syLzE0SmhsMEdMRWtuR2NBWml1L1FqcGI4WVBEdm1JemliUjJo?=
 =?utf-8?B?MHpiQkREdGduVjdsVkNMcVRLdUJKODE1R3hPOURlR2I5UVBGc2l6ajBWcFFI?=
 =?utf-8?B?ZW45Wk85eVF0bVJrRlltMDAzSWFOTzFSNUxPVk9uU25lSEpVSnViOUZQWUdY?=
 =?utf-8?B?YXBrK2FtWnZFK3kwZVRJUFBPVk5za3YyK1E2NzVSU0JzNnhOSUJSZ2FpUVRy?=
 =?utf-8?B?UklBaFlRQlBFdmtONHpJQ3c3citNaTVYcTlqc3grN0REK3ZOWmU0ejU1OE9K?=
 =?utf-8?B?bklUaGlOaXV4V3VGS2NucENFZCtmbjVzdGlCRHZVM0dWWTF3SG1Ed3k0Uk42?=
 =?utf-8?B?bmVKbDA2UGptalJXZGFBc3M3VGtvQWlNbEI5SlZWbEw3QSs4WDRkWUlUYmkw?=
 =?utf-8?B?djNJZm85bElWSHEyY25WbVdWTXhDN2tHMEo4ZDl4NTQzcTFUYlh6ODVvYUFC?=
 =?utf-8?B?M1hhTTJWbk1HNTVyRUN0V2xpTHVvblNCTENCRExrZWtzRWEzR2NtRjJmTkl0?=
 =?utf-8?B?djFUQkttWC84d0pRdDBsbnU0TW5qRzJGTHl3dHdxUFVCWVYvQ0dvempkc09Q?=
 =?utf-8?B?Nkc4WlVnMFFOeXVCY1JwenFaWm5JWlFVQnhXeG45M3dQZEJ4L3NKMnVxRE93?=
 =?utf-8?B?emdSUXgrcUpQNVlQaE1CQThrNUtzdW5pbmU5OUZmVTB4T01LWXUrbFhrQmdt?=
 =?utf-8?B?eisvM2VJYUUwZWt3VnVlcGQzc0dNdmtiaWdkSE45bkIwWUFUeFZFNFB2d083?=
 =?utf-8?B?VmRCcFljaUwvNG5XMEo5TmFDWWVJL3habHdlbEE2RXp1NStiOHV2QVpxeFdY?=
 =?utf-8?B?eGZhNHdPNU50NE9IK3YyM0UxL3ZyNXphdWJUaTQydXZscE1RSml1SW1sNjB1?=
 =?utf-8?B?YmVVRmlHMVo5WFZFS3VSb1EzUkxKSmI5L1I3WG8vTjlmTkhGWlBPZGVrMjhU?=
 =?utf-8?B?Vk0yKzlTL2xIcWNyUmQxRWVmTHl5a1JiVmxyWEVwWTBUSHo1dlorYm9Dek14?=
 =?utf-8?B?V1lwM1BzNEwzdmlhcGZzS0R2eW1tYW9KbWhRN1BkNjhyL2t0ekw3U3huVllC?=
 =?utf-8?B?eE9uQ09GUTdGKzg3MzI3VmRpRHZod1RoM1V1SEFsZTF4TG1xa2hzVlVGWEJZ?=
 =?utf-8?B?WU9DU0VrVVQyL0NXcjNzcURzMHlDemw2K3lUY0hBRGxyYU5HWGpCU1dhSnlK?=
 =?utf-8?Q?lOgghiA1l68JhZ7rw37aQZ+f6mT30ssy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTU4OFJqOFNRcUJod0xHampOWklZVEpPZjFHOXNobS81NUcxYlhRYlA4UkNi?=
 =?utf-8?B?RWovT3RXL056QzFLTVY5NklLNHh5TmtRT0owMVZ5QmxLRERkdWozeGpEeE9z?=
 =?utf-8?B?MlVJVGRoMVptdTZ0TW50SVVWS0UwSWJqSHR5bjNQVE10OHFSSEhBVmpGUDhY?=
 =?utf-8?B?b0JvQ0d6M3FBUjd2Ylp0MkhUTzNhSmU1UVg1dk5ZZGxRSzc1bjJ0Q2JnbnJ3?=
 =?utf-8?B?QTl6cWxOaHdUL1BYZ3JMT01oUCtQclRSOGphWmZucElKTDlpeEgyU0Q0c2c4?=
 =?utf-8?B?emZCdGFGMU56aGdMNlg2eGJ2Ymh5aUZkZHAvVWdjWU8rK1hxSWR6YWdCNWxv?=
 =?utf-8?B?UGt1aVpLY2l1eXFRbWxtaXM4KzRIVzNSNDRGUTIxczM4STd6bDI1ZTc4d3BF?=
 =?utf-8?B?K2Y5dXlKeW5KL3pORWs4UTdhS1grU0xRN29ZRjNoWXJVbmg0T0dIbDZLK2Fp?=
 =?utf-8?B?Q2V1S3lsaFoyeG9zRnFNcVRCeXpiNlVjclJEVkxteEg2bndnNDBNWldPQkpI?=
 =?utf-8?B?c1hUTHFrT1VIQUhQdEVkckdpWmJva0VPdGFFVlpPVzRUWFp4S3B0YWNDS3ZQ?=
 =?utf-8?B?SCt0NUNBR0labVpzMmZYbjF5M2U3OHZTakIzK212QVpzMEZDc0xha2Z0VjUy?=
 =?utf-8?B?R213ZXZQc0l2N1RSa0lkMkxycTl2dGx3bWVJZmRpUE5hSnE0aitRQUk0V1U3?=
 =?utf-8?B?dEV2WXdmNVpDMkQrcyt5ZnN4SlJGUWxzcHNtSnoyZFE5RTd3L0tSZlpla2Vs?=
 =?utf-8?B?L0ZXcnc3bm1ISDNkMG9VTXJqUEV5U1VVekNheXk5cjE4Rm5LejZPYSt5NHhz?=
 =?utf-8?B?QzI3YWZrbnltQTNUV001cXNBSytZQTVtbUJVOWl3ZGlzdThRYXRKdHlrdzRB?=
 =?utf-8?B?azB6UGkwRVJhYmM1WWNTa2VKSzFKbjY0SWY4YXhDVUdRM2RwamJjdWpYUHdv?=
 =?utf-8?B?WThaTFhhSTlMekZZSDBtWjZpSGljY1VUK0NoRXRzNzhMeDBnemUzdHovSTRY?=
 =?utf-8?B?ajVVTjQvMkJUdW9vQmdvS1ViSHhWVkVTNG5CTU5tL2orNmt0LzdwZ0FTRnVQ?=
 =?utf-8?B?emQrSXhkM2E4SkdQT2NxSFFpbjZkdTFGL1MxenlWSURhUTJwWjN1OHZYOGhM?=
 =?utf-8?B?Z2d5aktmbGE0d29abUcxV0d4d2F1clUzcUl2cGhuMDhCclV2cUd5bktrUzc1?=
 =?utf-8?B?QVNiSTY1N1hiMjNMK1V4U3RrZU5Ja2lHalgzTTB4SXZyaW56R3ArOTBYdEw3?=
 =?utf-8?B?M3NFWGNIUVF6VU9jU3cwNHNPb2hqYldyT3JTNElkUHRuMXBBcG5MREJtem10?=
 =?utf-8?B?UE5pd2dGMDBpTmhUVFh0V3I0MzNkZzZBRHhWWUVDai9ZYWZMcUZ3d21mZE5W?=
 =?utf-8?B?blJxY1hwMFl3SWFDdE5ybnpWMVFjMEJtUHN0WUY5TXR0R3Q4S1l2ZWpoanZG?=
 =?utf-8?B?T3Viay91MnRWQm83OWh0YUQrRjR2bG5keVdmLzBMUVovZDFKRVRhb20zQjZ5?=
 =?utf-8?B?amZ0MXQ0SWwxTVFzc0NKWHhYYitCcFBIblBtRHFKb1dFSy9pL1I3aEpBQnhG?=
 =?utf-8?B?cGhBVW1ESDVveFFjNzhVc09yWHZLb2gvbGFNdnVUMTA2VjBjcVlYbng4eXdB?=
 =?utf-8?B?UlV1QjJ5Q3pVZGNKRGR3eCtndDJLWTRSemdCZkdGbm5tcHErM0hpSjVtNHhC?=
 =?utf-8?B?WW15aFNoK0JzOU1JTHArQ2YzZFozUEhHVGYwc1N3RXlrUTR4dDFZb0p0dHQ0?=
 =?utf-8?B?MWtlcUhTczdWY1V3VFhIdzdOVEE3YVltZGJqNVZIamIxa0x6U0NTN3dZZm54?=
 =?utf-8?B?NTZXTVU4MWZhbGFOaEowYk5CcTd1UjVwOXFVbzVmMTJKSVFPMW1kQm4zU1lD?=
 =?utf-8?B?VFpQNlVOdTd0OTRsMEdmdklwNVE3dTZGWFFycEVWdEpLbHZhVjArYkJGMW95?=
 =?utf-8?B?UWswVmpJSWk3aHYxOHcvVlpyKzFnbi9iZkhxV3F2RUptL0xsdTZKM2hqTnBS?=
 =?utf-8?B?RkloRWVqbDZDbG1tUUNUSFlzMDhFRWx0VEhxSVBJdFJXc1MzM0ZEYWlyanho?=
 =?utf-8?B?dEllYkNVUGNDZTVxNE9hUDZ6S0ppeTBPdUhlQlNQYXJwNXVtcmJRS01IWDla?=
 =?utf-8?B?UytYQU1QemgyajQrVmU4bGN3WnFBYW50K09ydHFZbEI3dVN0Zm1OUGhjS1dh?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ebd7cd-d0f6-4b26-af92-08de1675d4c1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 23:00:47.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzccuY9GK8GqelsMCBJ2nXj9qJrzRKrc5kgm0TzCfbWoF02sLrQEXkAbtr4ziqUqI3+3SMNqnBMgdYQ3xpJv5rawZvztftNx5qzo0aMz/sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6176
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > index cf1f7a10e8e0..a2d3fb4a289b 100644
> > --- a/include/linux/pci-ide.h
> > +++ b/include/linux/pci-ide.h
> > @@ -24,6 +24,8 @@ enum pci_ide_partner_select {
> >    * @rid_start: Partner Port Requester ID range start
> >    * @rid_start: Partner Port Requester ID range end
> >    * @stream_index: Selective IDE Stream Register Block selection
> > + * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
> > + * 		    address and RID association registers
> >    * @setup: flag to track whether to run pci_ide_stream_teardown() for this
> >    *	   partner slot
> >    * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
> > @@ -32,6 +34,7 @@ struct pci_ide_partner {
> >   	u16 rid_start;
> >   	u16 rid_end;
> >   	u8 stream_index;
> > +	unsigned int default_stream:1;
> 
> 
> This sets "Default" on both ends and the rootport does not need it in
> my setup (it does not seem to affect anything though) - the  rootport
> always knows the stream ID from the RMP entry of a MMIO being
> accessed. May be move it to pci_ide_partner? Thanks,

I was about to change this, but it is already the case that "default
stream" is only an Endpoint port concept in pairing of endpoint and root
port. Also, this is already in 'struct pci_ide_partner'. So if your TSM
driver sets this for the PCI_IDE_RP case, then that is your TSM driver
concern, I do not think the core should worry about filtering mistaken
settings from TSM drivers.

