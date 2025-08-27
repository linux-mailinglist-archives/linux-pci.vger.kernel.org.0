Return-Path: <linux-pci+bounces-34847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8C9B378D6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5952A7C1CBA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2729B304BDB;
	Wed, 27 Aug 2025 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhvcSpgj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D3730CDA0
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266696; cv=fail; b=uFTAKi7hrBuLAwyScRr3PgV++9pEun1/BGT/aigoi/o89O3XayX/R3F29u1qxc0ZMV+Kh3zyhdmlBdTEHfcOjxleLslKTMqFBZairUF2f9SvX6PhPNT/6Qj5TGR2TruYjDJkXGgsE0xya9trNvUGP9Nwlk9dvP2yE7p2qoBidT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266696; c=relaxed/simple;
	bh=rR6Iq+uMhISmyOab0sHg41Od0TfcMNVL8AdJX1/7+Uc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RLCs8iyOr3cNbpxcQB80v/JTm80z293p8P/KfqHB3yVS6W50+kGZmgyLWE1cobJUqNkRIhj01CsDSUcgr5IFr9OdvyJQKg2ml6XXQp+D1PoCd2GrGiTNqBVotT4qQjoGdJYuVZnkwPAuAX20nmGGIEEx+TyFvnepb+vLcawglQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhvcSpgj; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266693; x=1787802693;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=rR6Iq+uMhISmyOab0sHg41Od0TfcMNVL8AdJX1/7+Uc=;
  b=YhvcSpgjZMd2Z1Cj0+AFPume0P0MyNVRWK6+GKa0F4FNQsXrlbF7UUlq
   EXMZsjpYm/s8ASUjB119/nrffStuoIr4nKZ/fO6bbQT11rX2ACYHgGg0f
   FVOmQZSQNwGYVRBYCyT0irHXlm5d5rmvX8aMQGf5QQ2DrEQmDmCcvUv32
   beDnkpAS+EerAxMBI+DtC/DHvYhDvh84b1r+KSoqSubRzpeqEE4L+7zg4
   HupxQ2b/sMdd/Xz00GekOP7dDpEiyl7i6/P2AbfxHZfdjgoz1R1ovL9c6
   Npk2isAmp49OHw2bfJZVCcHRanX5F2qxHMx4XdwTNlma9R/d0uukgitmB
   A==;
X-CSE-ConnectionGUID: 1jGCga2oS7+oJ3jvKnprvg==
X-CSE-MsgGUID: X/1Jggv7TjuKUVpA9pAFhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62159087"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62159087"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:32 -0700
X-CSE-ConnectionGUID: cidWxmmcTfyx8NXhH9Iouw==
X-CSE-MsgGUID: HscKeh94Q+CYJM/9s0j0pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169685082"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:51:31 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.87)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9XbpjCRwfPLWuYBgQwaUAhkQkIazEWu15r/P855h0gGk5l7u2kE82gi84kYfDt8s+euJP2wRLlgVLvvf49BmevwSRi/vDqJ3Iw3wICUJqSmwxyMQcaLwXX+L4RnmDjiZg/cUmDCtbQP7qIGTFqnU2dYDP2xDOBi3J0b5oD8s+jPEEU4ieXbRw7iWAO57BZE5HAXc5yzbT6C5jnepNtbtELGZdc6eJKCSN7BC2KggPAj4PCmheLRXHnMOfL6GFCZP72VXaCKGY98xDWc3vgiGgPzXZkFpBaj276eMVW/a8JVlzz8L18vW5dSZHFezLNezqjonYkcjjBZM3nZWhXP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNY+Ta+CHBuI2o9tF7wAkeKg+oTbY+yPlJQ+6JmzptU=;
 b=wCmqX+TXSzoT9+TIcc9kG0VgWUcunoukLaer+PmTf7uSS/NsM/rZLyrPvU8wXUK/7Y3+agNvZhTRALbNp0xa0WnW7gFCFrFYkJnVdxJBBksI2aWiBOPx3zvnaYdZcDicEAcs9gffLo8v5V/ss8MbtRH5noIuSWiJ1aBmgm/YFTrn6+13GJQF6paUo6YMt+qSrxHiKhtx703omDo/WBjxbXN0sLGYFhicWp3s1b551vgYVkXSi8K2+ZaXW031Zgl35Voyp2JmjRhvsCPesf4/lDxryKm5xG67BnWdmSTXwMpsih3pwkarrFEhY6k0NWJVcFdAFq/U8UNsXQxd9XGYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:51:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:51:29 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>, "Christoph
 Hellwig" <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, John Allen <john.allen@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Lukas Wunner <lukas@wunner.de>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, Peter Zijlstra
	<peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Roman Kisel <romank@linux.microsoft.com>, Samuel
 Ortiz <sameo@rivosinc.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v5 00/10] PCI/TSM: Core infrastructure for PCI device security (TDISP)
Date: Tue, 26 Aug 2025 20:51:16 -0700
Message-ID: <20250827035126.1356683-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9dd571-cd81-4830-6183-08dde51d00db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDZ1OVVmVW9FaktTcURXaDZYQi85VHZJcmJmN0owU1RZaUI2UVBLenVCWVF1?=
 =?utf-8?B?VVlid0d1clBhaHU1eXBIZ1VBU0g5bEozdmhOemg2b1Fad2liUXJHZVZSMC8y?=
 =?utf-8?B?VG92MzZGUUgzZUQ5aGpicWo2SkxVVmdFK2lNQm9GdnQydjhnMTlWZll6emRL?=
 =?utf-8?B?Vk5CbUNKUUYxei9VOGVRTFluaU1YaDA3aCt2K2dxbzhUcjdWQWZ5emFhTEZR?=
 =?utf-8?B?cTJhakdFOC9vMmlReS9ldnlkT0REamRIN0thVXVSd0dTczJyeGtYNHFXT1JD?=
 =?utf-8?B?VlJNaG1TbDFqSFhLN2x4YzA3aFhWT1hiQVRZR01hNk5UTXorOHVKYkM1cThq?=
 =?utf-8?B?RDdxSWY2Z1VzWml6cGZXQ2x2NjVZTG0yaUFvL2M2aHM5LzVCSzRPdDdBT3hu?=
 =?utf-8?B?V2dtc2JCVXJhTkEyUDliVUNlQjdlZ29JTmFzc0I3aDFUT05hWXJvUHNXc3Ns?=
 =?utf-8?B?d0lrelF2L2habkR4NHpKbC9sSTlvVjVVZ2dtbmY5V1ZJbWhGNXNjeHJ4RUlM?=
 =?utf-8?B?a0ljYysySldoSEI5WFp1M1E4dFhnWDZlVE5rMFcwWlg2dGtDTyt3RUFOcUtK?=
 =?utf-8?B?ZVgzVTVSRnlLNUdwYjM5T01RMkRYNjEyU0RmQmYvRGRTYmdteC9oNDI1S01R?=
 =?utf-8?B?dTRYS2JlZWhkbS9CMDI5VEU2YmxBamxpK3lKTWRvRDdFUWFlazc1eFJINXUx?=
 =?utf-8?B?RGdpaHRJYnNicHpleUxGT3lFTURBTEsya1lCc0c5Q2d5QzdndzVOaXN2cXBs?=
 =?utf-8?B?dDI5Z2JsTVZLL2lEQmxGSDJTSWYyTkorUWJqZzdCMDJQSU9RNVhTbG5sUTla?=
 =?utf-8?B?VlF1MGdiMWIrVlRXYXpaUU5yZHo2WjBVTWExVWcyNStjZkNMRlNWN3NjYk40?=
 =?utf-8?B?aHVvL21BRXVwWEZVc1Fub20rcWdOYTlHYzliOW9HWWNzT21tRGp3N0ZTZCtJ?=
 =?utf-8?B?MEdZeTlYNngzNkM3eFBlQyt1dE96Y2ZJajBJRkp0YjcxMGdSY3RWZ0hWUUc2?=
 =?utf-8?B?Y3VMZ1ptaFRSZ2J6QjJXSFErb1l5K0dzUXpMMDNVcWRiaXZpQ2dQSHM4YzFJ?=
 =?utf-8?B?OXZZYmVScmJzcllvU2lPejRVSFVQOFZpSU5JcGdOS2piYkhWalZGNFlOK3FO?=
 =?utf-8?B?WWcxK1hDYVozRTZoVmVuZVlvR0xQZ1hxMFZMNkJaNUIvTVNudWgxNVFDSzEr?=
 =?utf-8?B?Q1ZuTDhXV0trMmgySTJ6b3RWamJhUTF3WlIyV3VPaWU3ZEE1T2NpL1pLVDZO?=
 =?utf-8?B?ZGQwVUxhZkhmSnBCQXllZ24rVXg0d1VBRk1BQmY4WVRDY0tvOHVjKy9KMUpO?=
 =?utf-8?B?Y2U1NmMyZHJ6MERQMWlUdDN5SkZ3L2hvK3p0UmRGaDJBOHNLUzRtMjVjYVVm?=
 =?utf-8?B?Y2RQSHhlUTlJNzR2NmtmaXo2MWRBejhaN3h0dE5mc2wxVGNOcXlFeTVBTUZw?=
 =?utf-8?B?MmVsb0pZSFozVVptcm1meitYbDhocUVRd0gxSUp2QStYNWM2U1laR09ObU5G?=
 =?utf-8?B?SHA4YndhSjVvWGZ2dm9JQjZ6Z0pkRFg5elFlQVVyTVVJNDkyY2UreHlLVWx3?=
 =?utf-8?B?czV6UDF2WGF5Slk2bXdSaCtqUGlnRXEybWhnNlY5b0puUUZzODZjZGZTN1Ri?=
 =?utf-8?B?YzZmNXRjcDduL2pFakpXVnF2MWtEWGhmV1E4TUlTVTVYTHpkMzdLQTZEUjJx?=
 =?utf-8?B?elBtSytNdFU0ZDZDUW95ci9zQXI2aDlURERkdXlOUVBLZFczd1JmaXhONlRr?=
 =?utf-8?B?L1pNM2szTWZadGJ6NDNaTWd1NVNIOVNwWExLbFV5S2RnZ2dXU0x2bkZBcXJq?=
 =?utf-8?B?VVpPVWJIQ2NqaGJ3YStPdTk4OVhRMzBkUmE2bUpTYk9vV1pUOW1POUgrZnUx?=
 =?utf-8?B?UVVzcHVtcUJWdjE4Umg4bGcya1NubUdvanlGY1hSREhMTHhWOW9GSFFWcUpx?=
 =?utf-8?Q?azWpXUDea3U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BtTnFsK3d1RVVJWFVEV3hkeWZacUozeGdOY0lEWjA0YVdyVWFuaTQ4Smwx?=
 =?utf-8?B?Qm0zbkhYNlJHbXRaVlRqMmtqQUtrWVdqLzVEeTNmbHlndExsYmNGdTFEdkxR?=
 =?utf-8?B?L3l4dkZTam51Ykw1aXFoL3VFNEo4YVp4N2M2RkxLaUNFSHNrVTVYeENYaXJY?=
 =?utf-8?B?QkJ6OEtsQVlkdVBOOWl3dVlKUmRLd0FPRGhYdzFJMTVseVA2RmRCOFd2NEJE?=
 =?utf-8?B?WmFNNEs2S2ZkUVJYdHpYcWFBclFmK1hMMHo4aTZYc3RwRUF4UW5uY0pDbjFU?=
 =?utf-8?B?UHpxN0dpeHVVWmt0dU1wWmc3anFtMkdFMTZkRHVHZGIxM1JYd1ArZ2lNVmIy?=
 =?utf-8?B?RmJKNmhHUDc5WlNZdDJ6SUljbXRaWW9BTWExM1NJNm1NL1ZpQWRrcFNqV2g0?=
 =?utf-8?B?TC81STRFWkpneXVQYmlNSytsNmRaT2wvR3lFWnhScWNRRzRoQ1dza0dqUFkv?=
 =?utf-8?B?OFZQckZuTkkzUXpsYWl6UnFlMmNKYnZmZXpacExGVHBMSzUyemtZd2dBaDZi?=
 =?utf-8?B?T3pJTlNzZWx0aVZ0Nmh0RVpReUpnOGM0KytqNFpnQkZYWjJKVlBhRFQ5TGox?=
 =?utf-8?B?OHVBa1kzTHg4UHVXWGZHckRlQUZqd3Yvd0hxN1pvQWFJU3g4VlZyTWgzYmxP?=
 =?utf-8?B?VHhWcG5IbFBBSXJiZCtoRlNVZXZZUUxPMUdmRkp6OWxJeUtJL0hpRG8zTEt5?=
 =?utf-8?B?NVR1bmY4WXhZaFdLNVc5R2VaU1pZaUw2Ym9EVmNsSGlrUTl1bDl5SmZTRTd4?=
 =?utf-8?B?MnhCa3RINVd5VkxKTEhneUMwUy80ZldMaXcxdVhIWFpySGJKc2ZSVDFSZXFq?=
 =?utf-8?B?aDllVERnb0k4ekllQnFWV1RSVHE0aEx5MFRiZTkwRXR3NE0xQndobmxXdzIr?=
 =?utf-8?B?end2YTBOeWZaTU10RzRQREQ5OVVSL0t5S25GYUlvck9zTzFxQndvUXdEZ1p2?=
 =?utf-8?B?NHhOU0pNbjkveVhyaEk5ekIzUW1Uc2U1Z05PS1pLMHpOLzdLSUNMQncwQTZp?=
 =?utf-8?B?dmlPSGNQVnc2aXRQV0hDeHV4RVNpT3piR0s5NFVCdUVjNnZTakJQWVF6WXM5?=
 =?utf-8?B?ZUF0ZGY0YXoxZXVNWE1aRWhzbVNhN21EMklzVThPeEpGa01pbDRiN1gzckU2?=
 =?utf-8?B?bFNlVloraXZ3Y0YxSStveFY3bEdONC96bXBmb0VISyt4QlVnOGtEM1JuSTlw?=
 =?utf-8?B?MVdCdG9UK2gzVFhPOWVWdHZ2NG11MkYrWjJEVFdOa0FZd1V4SGN5NWpsdHcx?=
 =?utf-8?B?L2Fmd0ZySGpocUlUSEhZL083eStSY2ZxOHFxQUNIM0o3bGVteHRvOTVBc3A4?=
 =?utf-8?B?WmFrQmU0ODMrSUk2bXJUM2huNWkzMTdiQ1lTcjVGd0Zwb1Y4QjlJR2dBeEVC?=
 =?utf-8?B?NFp5VEx1UWNXY1pSaXdDKzYwbW9aNnZ3UDBGaFRLSWlQbGNFN2JMdGh1Uk5w?=
 =?utf-8?B?OEFGVEtLYU5jaGFqd1gxM0ZTZ2FxazlXRktKejEzNmdvejlIOGJsK05JMThG?=
 =?utf-8?B?N2JnT0Exdk80UitOaEVFQUxQejkwbHJXU05LYzMwMm5hRWJqN0VtYlYxYm1Q?=
 =?utf-8?B?R0F5eXFlSXplaXRWOFZYUHpMcGd3WkdJOGp1MTJKTzVuc2x0V3pWbUpvbW5M?=
 =?utf-8?B?S01PRE1TcHJZSWlUd3dJYWhuVnFCV2hReTVQR0J3MjhqcFo0ZGtvZmN3d3Yv?=
 =?utf-8?B?NmFTV3NOV2MvV3d3MkY2czAxNnlUTWlUQUh3R3lTU1RDR1R6Tk9IT0Y5eHhv?=
 =?utf-8?B?R3E1Y0NXajhlM2liMkRwbVkzaUdGTjRNRVpOcjNhMHBqVUVTeXdVbVNScHRD?=
 =?utf-8?B?SHRYeDJ0dmlHRmw0VkVNVitDZXFtelNEMHlNY0VVUXpOZEY4SWFIZEpCbkRF?=
 =?utf-8?B?WWZpT0NseTk0WG5TeXJxOWpmZkE5ZWZINXhjc21TSXp3N2hVenM2Ri93UUdE?=
 =?utf-8?B?dnBzbDA4WFJhRjM3ZTFtcDZ6VmtxYUxyckU4Z0ZNN3F4SXJaSjUxNEpPRGc0?=
 =?utf-8?B?SzcxcFNGNnBlRUJKdTlSaURuL2hRamNDUE15VmpVWDAwR3lGRzdCRDAvZkVM?=
 =?utf-8?B?NU5JZjFaUlJJdkpyUUtmN1ZmM0VJcGVYOTJGNW8yRldidVZiVVEzaUhNRG9J?=
 =?utf-8?B?N1orSzlFRTZsbzZ2aGs4M1lFUWQ0SnV3NTlBWFY3aStUY1crb0kwN2IrajBU?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9dd571-cd81-4830-6183-08dde51d00db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:51:28.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwXOLVd9Gk1+mgAotWfCaQ+PNM6/LDKqI5aUTsEmq1vks8vJeoge9nwxmjZ6s9M1uhfw2mt9wwCNV6/ErP1p4UlyvXXqQl+UL/48PRRe2ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

Changes since v4 [1]:
- Rebased on v6.17-rc2 plus a new pci_bus_find_emul_domain_nr()
  implementation after feedback from Michael
- Update all spec references to PCIe r7.0 (Bjorn)
- Alphabetize includes (Bjorn)
- Drop "_MASK" from register field definitions (Bjorn)
- Add explicit includes for used functionality (Bjorn)
- Fix some misspellings, punctuation, and capitalization (Bjorn)
- Drop whitespace out of the TDISP setup success debug print (Bjorn)
- Make the "Device 3 Extended Capability" changelog more concise (Bjorn)
- Clarify abbreviations in documentation for the IDE stream sysfs
  symlink (Bjorn)
- Drop pci_ide_domain() export (Bjorn)
- Do or do not, there is no try for pci_ide_stream_enable() (Bjorn)

- Prefix register offset definitions with 0 (Jonathan)
- Rename PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK to
  PCI_IDE_SEL_STS_IDE_FAIL per latest spec (Jonathan)
- Replace call_cb_put() with scope-based-cleanup (Jonathan)
- Move the sample emulation devices to a known unused device-id, 0xffff
  which is the value conveyed in an error case (Jonathan)
- Reflow line breaks in tsm_ide_stream_register() (Jonathan)

- Drop @groups passed to tsm_register() and tsm_pci_group() (Alexey)
- Simplify __sel_ide_offset() (Alexey)
- Have PCI_TSM select TSM (Alexey)
- Move DOE definitions to pci-doe.h (Alexey)
- Remove pci_tsm_doe_transfer() (Alexey)
- Reorder pci_tsm_link_constructor() to skip init actions when the
  function is going to fail (Alexey)
- Rename the core 'struct pci_tsm' context as "base" (Alexey)

- Pick up Bjorn's acks
- Fix Documentation to reflect passing the name of the TSM device to
  @connect and @disconnect
- Rename pci_tsm_pf0_attr_group to pci_tsm_attr_group since it will be
  shared with the guest side
- Fix SRIOV function tsm sysfs init, add pci_tsm_init()
- Clarify why pci_tsm_destroy() occurs before device_del()
- Cleanup link_tsm vs devsec_tsm confusion, prepare for more devsec_tsm
  enabling
- Hold pci_tsm_rwsem for write over connect and disconnect flows
- Rework "tsm" group attributes to prep for devsec_tsm attributes
- Fix find_dsm_dev() to be more careful to not walk past root ports
- Drop @sec_probe and @sec_remove add @lock and @unlock in preparation
  for devsec_tsm enabling
- Require samples/devsec to be built as a module
- Fix bridge and device MMIO setup in samples/devsec/bus.c
- Move samples/devsec/bus.c to faux_device
- constify pci_ide_attr_group()

[1]: http://lore.kernel.org/20250717183358.1332417-1-dan.j.williams@intel.com

This set is available at tsm.git#staging (rebasing branch) or
tsm.git#devsec-20250826 (immutable tag). It passes a basic smoke test
that exercises load/unload of the samples/devsec/ modules and
connect/disconnect of the emulated device.

Status (further "link" vs "devsec" TSM clarity):
------------------------------------------------

The bulk of the change this round is driven by further preparation for
the "guest side" / device security state manipulation infrastructure.
I.e. the support for the PCI core within the TEE to ask the TSM to
transition a device from UNLOCKED to LOCKED, and LOCKED to RUN.

A set implementing that to be posted immediately following this with the
subject:

    "PCI/TSM: TEE I/O infrastructure"

Otherwise the feedback has appeared to complete the transition from
fundamental concerns to matters of polish.

Next steps:
-----------
With "[RFC PATCH v1 00/38] ARM CCA Device Assignment support" [2] this
effort got one step closer to the criteria of "samples/devsec/ + 1
vendor implementation, or 2 vendor implementations can demonstrate the
end-to-end flow (minus attestation)" for starting the push into
mainline.

See, and review, the "PCI/TSM: TEE I/O infrastructure" posting for the
next batch of consensus building.

[2]: http://lore.kernel.org/20250728135216.48084-1-aneesh.kumar@kernel.org

Original Cover letter:
----------------------

Trusted execution environment (TEE) Device Interface Security Protocol
(TDISP) is a chapter name in the PCI specification. It describes an
alphabet soup of mechanisms, SPDM, CMA, IDE, TSM/DSM, that system
software uses to establish trust in a device and assign it to a
confidential virtual machine (CVM). It is protocol for dynamically
extending the trusted computing boundary (TCB) of a CVM with a PCI
device interface that can issue DMA to CVM private memory.

The acronym soup problem is enhanced by every major platform vendor
having distinct TEE Security Manager (TSM) API implementations /
capabilities, and to a lesser extent, every potential endpoint Device
Security Manager (DSM) having its own idiosyncratic behaviors around
TDISP state transitions.

Despite all that opportunity for differentiation, there is a significant
portion of the implementation that is cross-vendor common. However, it
is difficult to develop, debate, test and settle all those pieces absent
a low level TSM driver implementation to pull it all together.

The proposal, of which this set is the first phase, is incrementally
develop the shared infrastructure on top of a sample TSM driver
implementation to enable clean vendor agnostic discussions about the
commons. "samples/devsec/" is meant to be: just enough emulation to
exercise all the core infrastructure, a reference implementation, and a
simple unit test. The sample also enables coordination with the native
PCI device security effort [3].

[3]: http://lore.kernel.org/cover.1719771133.git.lukas@wunner.de

Dan Williams (10):
  coco/tsm: Introduce a core device for TEE Security Managers
  PCI/IDE: Enumerate Selective Stream IDE capabilities
  PCI: Introduce pci_walk_bus_reverse(), for_each_pci_dev_reverse()
  PCI/TSM: Authenticate devices via platform TSM
  samples/devsec: Introduce a PCI device-security bus + endpoint sample
  PCI: Add PCIe Device 3 Extended Capability enumeration
  PCI/IDE: Add IDE establishment helpers
  PCI/IDE: Report available IDE streams
  PCI/TSM: Report active IDE streams
  samples/devsec: Add sample IDE establishment

 Documentation/ABI/testing/sysfs-bus-pci       |  51 ++
 Documentation/ABI/testing/sysfs-class-tsm     |  19 +
 .../ABI/testing/sysfs-devices-pci-host-bridge |  26 +
 Documentation/driver-api/pci/index.rst        |   1 +
 Documentation/driver-api/pci/tsm.rst          |  12 +
 MAINTAINERS                                   |   7 +-
 drivers/base/bus.c                            |  38 +
 drivers/pci/Kconfig                           |  29 +
 drivers/pci/Makefile                          |   2 +
 drivers/pci/bus.c                             |  38 +
 drivers/pci/doe.c                             |   2 -
 drivers/pci/ide.c                             | 582 ++++++++++++++
 drivers/pci/pci-sysfs.c                       |   4 +
 drivers/pci/pci.h                             |  19 +
 drivers/pci/probe.c                           |  28 +-
 drivers/pci/remove.c                          |   6 +
 drivers/pci/search.c                          |  62 +-
 drivers/pci/tsm.c                             | 601 ++++++++++++++
 drivers/virt/coco/Kconfig                     |   3 +
 drivers/virt/coco/Makefile                    |   1 +
 drivers/virt/coco/tsm-core.c                  | 183 +++++
 include/linux/device/bus.h                    |   3 +
 include/linux/pci-doe.h                       |   4 +
 include/linux/pci-ide.h                       |  72 ++
 include/linux/pci-tsm.h                       | 143 ++++
 include/linux/pci.h                           |  36 +
 include/linux/tsm.h                           |  11 +
 include/uapi/linux/pci_regs.h                 |  89 +++
 samples/Kconfig                               |  19 +
 samples/Makefile                              |   1 +
 samples/devsec/Makefile                       |  10 +
 samples/devsec/bus.c                          | 737 ++++++++++++++++++
 samples/devsec/common.c                       |  26 +
 samples/devsec/devsec.h                       |  40 +
 samples/devsec/link_tsm.c                     | 242 ++++++
 35 files changed, 3134 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 Documentation/driver-api/pci/tsm.rst
 create mode 100644 drivers/pci/ide.c
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 drivers/virt/coco/tsm-core.c
 create mode 100644 include/linux/pci-ide.h
 create mode 100644 include/linux/pci-tsm.h
 create mode 100644 samples/devsec/Makefile
 create mode 100644 samples/devsec/bus.c
 create mode 100644 samples/devsec/common.c
 create mode 100644 samples/devsec/devsec.h
 create mode 100644 samples/devsec/link_tsm.c


base-commit: 650d64cdd69122cc60d309f2f5fd72bbc080dbd7
-- 
2.50.1


