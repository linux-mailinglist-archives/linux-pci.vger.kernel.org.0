Return-Path: <linux-pci+bounces-45150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CC8D39C92
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 03:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 077EF3006613
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 02:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570B91991CB;
	Mon, 19 Jan 2026 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCenex10"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DC18B0A;
	Mon, 19 Jan 2026 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790939; cv=fail; b=Fa4Gva1VrfW0hdMhnSib+/NXmZC+z4rlC0oMOm/UYCsJ8DhcK34QJb4LDcr3D7wTGjoYlPHLDC+fx3SewbP3lQFbTe78r/LxWzmV82wKYMeCq/hhp7Abmt8R8OZhhevRtIC8bFel3I4ybtEor/LVKyJQNVJI0YpHlo7wU2NK664=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790939; c=relaxed/simple;
	bh=4jUb9WFn42XV4qlJrEoxaH443LaYeB2vhI083qpUCUU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fyBhf6dCjr6zben6vJGfoh9dUqRJAJplTDXtWmfnNAltesuBAkmMHi+9D1Ar8LefIkrE8wXB7/W2uGLvq0ArpGBPolakoOaSqsYhk28AVaP+03BNX55Y5JfE83XJdpjYdKnReLhs3mlYGSrqHGQtybP5MymrSZLO6DQywnxYdH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCenex10; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768790938; x=1800326938;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=4jUb9WFn42XV4qlJrEoxaH443LaYeB2vhI083qpUCUU=;
  b=bCenex10ZvmC8Edfo7Z32Nkpzt9yOtjOLpsdpsCL0ZgWc33rTsUUDvM9
   SIFbZHO6Mnwe0MTE0SOq2Y/yi3EWLYylp7E+m7GQyZWejEX3/ZhKWCpyA
   +sR7RpB+F3G3WdDpP+3XJ1c/R/E0SHM/lJjE4fFN97Z19VAHsIe4U8xT6
   Gp58G/8WiOk021dpt9iYKOVCcovWnCtm1UecBdOje3ONegrV73m9x609g
   HCIgoUA0jR67Jp6vzEjMNyaCI6E0ro+CPMH+CRqjwBZU2bS+/MNyr7Vfc
   rM4NMvAec76ombBfai7k020EMRXx6AHQjLpxG3yNXb95z0zTW3BQsMHH4
   A==;
X-CSE-ConnectionGUID: uHS1R9zCRrObtPrSw6w6/g==
X-CSE-MsgGUID: RBk4KVxKRmmAygU0bWHbsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="70051068"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="70051068"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 18:48:57 -0800
X-CSE-ConnectionGUID: 6Hthdn7zTU2ol5zExoYxQQ==
X-CSE-MsgGUID: 1rt/WCA7Qk6SVZwW2H8sQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205807417"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 18:48:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 18 Jan 2026 18:48:55 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 18 Jan 2026 18:48:55 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.21)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 18 Jan 2026 18:48:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhCQJjgnZV90R9BNgXtpgF6ZoD2Z0xlZFBVNr+jrk0YvZJkdPpWbhjeIrZ9ep/fpQq9aadEu6frf5c6YvA404NyIPREOAZVn4CmOeY8fOTqWdK9DgasDJdGMWRUEBDadYKtG4FALa+szTkee1S5jQSQKqXvH4sz8+fqMRq9NF/Nx76BFErLIimPq0vH7/zWOWm0zJJij0Kw1koDqODpU3h9O8wWyp1VUIIx0H+/4IRC4TSpf8aDJxFadaQ7pBzwvE7fz9Bh387/nY9ir6ARpv7/+J5kyYAPltXajl9fukgxMLuvAfTxfnlTSA9OuBPhLeFwwY6BWyS0HTDtYEtaQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jUb9WFn42XV4qlJrEoxaH443LaYeB2vhI083qpUCUU=;
 b=cEBPTlresW6dkj+jLNSRJVRt9DdC6hL0qb1s27E32lFx+zlaNXU3yuuCF83yRVxsvpriKVnq0AGvGXzwvbYCFPdqNjlc8Oe6ZRaknlxAfJMgmgRhks54DSg2wpiVYhjciiFDOJoPQmqxKwEWjckRJMuAoYHND6Pra4yC6Iv7MPSr6qaRzW+oGph1NQrVylcfmNtoVeabc/zTCFOZoaMeM5FdVuT3BR4swgOm5We91idBkaA6AtbjAGRKEhkqFCkNSAJo6WuVrCS5VetSQbcUEbM3FIPvWP6dD9rYmruBCd8ruKuDGMA+Dpqtka4strYxkYGHUozBomZ+Ef3TTexkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6749.namprd11.prod.outlook.com (2603:10b6:806:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 02:48:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 02:48:53 +0000
From: <dan.j.williams@intel.com>
Date: Sun, 18 Jan 2026 18:48:51 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, <dan.j.williams@intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <696d9b932dc68_875d100cf@dwillia2-mobl4.notmuch>
In-Reply-To: <20260116150119.00003bbd@huawei.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-20-terry.bowman@amd.com>
 <20260115144605.00000666@huawei.com>
 <6969c260b7998_34d2a100f6@dwillia2-mobl4.notmuch>
 <20260116150119.00003bbd@huawei.com>
Subject: Re: [PATCH v14 19/34] cxl/port: Fix devm resource leaks around with
 dport management
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d5fa49-4e38-456f-01e0-08de57054805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3cxbDJULytYQ2RWR3dmMW8ycmxSa3M5NkVYVWFQaXNCcWplZjlJZWVCVTRt?=
 =?utf-8?B?MkY4K0VoK0ZnRG12d0RCTmlSKzYzWTlkVi9IQm0wNkVHdEl1MkVMaytDc0xz?=
 =?utf-8?B?V1hBWnpJOVZudVFIQWRTYjdzK3hma1hYcVlNOHlpTzYrbnBWVWlVM3FwKzMz?=
 =?utf-8?B?MVZCNE90b3BwL1FkSU04MnRicW5kQkF5MGhpeTNxQVphdjZRL2IyaElQbEZx?=
 =?utf-8?B?MmQ3Q293YUlFR1BiTFA1Tk5sS0xFcktXQ1BkSm1IbjFMUXRvTUsyM1NqdDVX?=
 =?utf-8?B?c240YkVNMmNaQ09ONEE1YktJNDVkckJZeW5CVkhWenpiRlhOS1hERFEvOU9I?=
 =?utf-8?B?dElzanlzWXF6RC9iMmNGR0xXMG5EY3dqY0M4RlJRSTJnVVd0TDZWSmVBL0x1?=
 =?utf-8?B?Z01nekg2RU40WEt0KzVrTkR3YTdXVzZ1UklzcElQSlUwSUtObGdIRHBQaFhX?=
 =?utf-8?B?ZTNUTUlzU0ViUjFsT24rVlkwQnRTNWhHK1k0c3FxYVpwL01la0ZFS2tyZHdL?=
 =?utf-8?B?TlRNUTNFQ1VCYkdxd2lzUS9ydytYK09RRWJYR3c2dU56T0lBaWYwbmxHSmFR?=
 =?utf-8?B?QlZlYzJLR0VacXZpN3hqOGdUYktNY1FvMkRXZ3lmMmNOeVVheDgzdkR5Ny83?=
 =?utf-8?B?ZFVESmllOGpHYVo3ekFJNGdvTXdlSXAvNjB4akQ0YVZBRElxaG9sbzVOTlFG?=
 =?utf-8?B?ZnpiWjlHRzFlbWRKNEphYStKNGFEb1NiUUlvU2xIRTc3bFY0N0ZuWmlmM05m?=
 =?utf-8?B?SUFzL3RnbmoxOWhUK2Z5ejNXYmVmREtRUU90a05kak05UFVwd20wVmZWSEJr?=
 =?utf-8?B?ZWN6STErMHlSK0VxMDVUVmRNWDNHWC83aWN4bEt4SzBEc0ZEUDcxSWlIbTBG?=
 =?utf-8?B?MjJheEVDVGIzSlNMRTh1Vms2Y3lxUXU4OUExSHArOTFOc3B3bVFwcEd5OWR5?=
 =?utf-8?B?VzVuQWdBVDRxK2FoRUxjalV0dEZuaVUyQVNwV2JxaEl3YWxNS1B1TFhTcEE1?=
 =?utf-8?B?Z2p5UDNpTTBhNnlPWkNHZmZEY1ZjcGdzNXVkSlVzSDVuakFkOGU0cWFyMFNu?=
 =?utf-8?B?UnBhZmpCUW5WL3JBMFo5SVI3RUJ6M0srZ2doTWFyMDVnRjZRaGIxdUdjb2Fu?=
 =?utf-8?B?cFZFTmVxQnVVZFY4ZWdJOUJHOGt0Q1dnQzV3RmJCMXA4c2wzNk9XL2ROTm5G?=
 =?utf-8?B?M1RXY2lvdGx5eEZ3YlJOQ2o3TitJSFVRRmR2L1FpYTFobEtNWmpkRmpUTzlE?=
 =?utf-8?B?dmZGaVNLaHhMeWk1Qk00VG1CTjhXOUViRVRONDh5dTZwdENFOUlBWUxIQ0xV?=
 =?utf-8?B?SnBmVEdURmF0VHkwby8wVllham1MeGhNTGErV2dvSURhQnIzdmJhU3hMclNS?=
 =?utf-8?B?NnZJaW5HSWthdzNQcUNuVUZkRVA4NFM4eitRQktTeXVUM1FBcEZGR1oyaGRQ?=
 =?utf-8?B?eHpNR2l5eVc1M1dqNnBTM1BpQ3E3RTM1K3pzT0E5T1dhSGowMW5zcUNIejR5?=
 =?utf-8?B?Y2FsaS9mdXlXaVREamNDOUQ2eDcxaEtTUHkrSkw0OS9VUWV6NGc2ajNXRkJF?=
 =?utf-8?B?RUxUZVZNTjl4N2c5RlRwbi9RTWtjRjc1MkRLaXdWZUZyc21OajlyZHJwNFNC?=
 =?utf-8?B?OU5ldTdLL0d3MThnZjBwczI2VHdkazFBZThTM1dYMVRlVDNUSFdwdVMrMUdv?=
 =?utf-8?B?WWdWVDFiaXIxZW56RCtyMFFyRGNVdnY5aUhtaU54eGRTcmZyZklJcDZWanJp?=
 =?utf-8?B?dnE4Zk4vMVZ3NUlPT2VEeXk5RjBpakFuNmFndEFWV2U0VWJJb2d5cFFrYzJN?=
 =?utf-8?B?bjdKMUhESXc3SVIwU1VZbHkvQk5qeHFQbWFKU3lIVjY2eHFFaFlTTHRmbWhs?=
 =?utf-8?B?dXBCSnI0SDNFVXBDb3BNazZIYk8xL0VzTWpFZDErbVorSElNaHFQdTZYaEh6?=
 =?utf-8?B?UGs4Umw5MjZqOUZsL2tTaGY5RXRYVndWNnB4VWJuUG9UL09nNnRJY1hDMzV0?=
 =?utf-8?B?MGw4SGV0WXB2L29SNGt2SThDc1gzOGhMakl0b2ZBZHVmOHUwOVlMRkNaUGF1?=
 =?utf-8?B?VUU3VlcxZ1lkajBJQW1WQkVPWC9BS2pxcG8rVnBMWUtVVlRWMkFHbVVRdFo1?=
 =?utf-8?Q?wweQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjJHSFJnUTNkS1NLbnRpUzc0L3F6b1RmTTlLc085aTl4TGRUbDZSbGF0aURW?=
 =?utf-8?B?T1pWNzNDeGZYa1U1aUVHUEFJN0NIaEpoYWdkQmJDNTZXangrMVZkc0NndlU3?=
 =?utf-8?B?VGxSeThnTXZvdkN4TWFKS2hPNGxzQm05d1NKamNRbXlTZk03SU8vMzJGbVlX?=
 =?utf-8?B?cEc4V1BsSW82cXkwaVp3bmZzZ3BJQTROWHBKRTVscUt3SHB2QU8xYTBreDFm?=
 =?utf-8?B?aGY2VE5xNGh2YWNVNXhkY2Z3MkNZN1hJWEZIUHVLR20zVk9RNStaU1djMG9y?=
 =?utf-8?B?WUxxMWdaVTBZc1drYkFmbXJabjNnbFBTV3ViU3haK0p3YTh4Z01WV0pmYlpk?=
 =?utf-8?B?VUtxYTBXQVVjVWtOWFFxVStZOE00ZzV1OStyRzFQb2s4RXJkY2x6LzJ3endT?=
 =?utf-8?B?UmdUUzdpcmxVUGw2MjNpTTNTb2Rmb0FURmU4ZnBvS0cyNk9vK2hUZGpsNzFk?=
 =?utf-8?B?M0NNd01jTmdhR1N0ZUR0S0NNdHJ3WFpHQUxKak10akRaY2NzTnc3WTdjcm9Y?=
 =?utf-8?B?K0NOTUxUSi8xdGtzUFdjemVpd3Z0Mm5WVXR0TDlCZEtzR0NlUkFMbS9RS0x0?=
 =?utf-8?B?VUdJWHhKVENnbmZjZFlCZjY3Q2R4c1RMYnB3UkRIQjVmdHEyblJKaEZpRkEx?=
 =?utf-8?B?ekxCb3orMDdQOCs4MHdJbkpnYXhmT3RxajJnUjU0WEpFd3EwTGwwNVk3YzBk?=
 =?utf-8?B?VEV2cmVjYjNlU1Raa2o3ZWpnR0txdnFodTBDT1BrMzZldFhrL0JRZ05iNkZx?=
 =?utf-8?B?a3BPdmwrU1VwdXBtdThZd0N6K3J3NEZod1oyZGU1d0lObSs4UDBIMnRwWXds?=
 =?utf-8?B?OXRSNWg3WnQvVlIrZituaENyekZmV1RSN1dFUFR6bnZDZHhTK3RLeHJmc1dj?=
 =?utf-8?B?WTJlZmRKU0IrTjdoV0wzNDZ2U05PaHJ6QXlkRnkxT2Fpa3MyRnlTSXNFN0lj?=
 =?utf-8?B?NHJnNjRYVGQxb0V0ZkRiSXB5VU9nb201YTM0UE1oMHpZYnRJeXZQb05RMXc2?=
 =?utf-8?B?L0tvSS9oaG1UM09nbGpjRldXZ2JrTXkyZVB2dERYa2hDZ1o4VG5UWCtQa3RN?=
 =?utf-8?B?NFIzZ1VjTHNrMmZEV2pwQXZaVjVuSnF6YTNVZGU0WjZTcVFCZkRQSExBYjNw?=
 =?utf-8?B?cnBrQ01LRWFkQWwyRlVqK0Irb0F5Q2E0b3k0Z1hNNnVQa2UvM1dvU050cnpk?=
 =?utf-8?B?eUlQNWZuRWRxY0lqa1VVVWtQWnNad1Z5TXppUGovZW5FNXc3MUJIUkZDNHdL?=
 =?utf-8?B?cW9BVFVCVXRXOUY1ZG1FcHVZdnQvMUlsZ240SGc4QVdOSStYeHlncFozR0x4?=
 =?utf-8?B?VUtEeXpkOEUrMzRFeWRGS2FLZDUxSDNpVllnTUZ1aUFtMENmV2hNUU1VbTlY?=
 =?utf-8?B?eStiZkhhdnBSVVViUC95U1hYYnVBRkJ1ck1DRWN6d2NaWk83QkplZFJ1T0px?=
 =?utf-8?B?NHg0WStHQlhZNEdnc0FZYkdzdWxrRnNiSkJzMk84ZUZRMWpuR29DbVNWL1RX?=
 =?utf-8?B?RXNOUEhva3ZNWDQ4c0ZUVDlYRjhmK1M0dEpTZ1VzRmVMOWdBcTd2anpkQTZs?=
 =?utf-8?B?eUV2RC9HaEdHSXpOY1EyWXBMZ3owWjhFbHNyb2d6TVp4aUNVNE5MYUswMjlC?=
 =?utf-8?B?cjBUMWk5eUZvYUZONEpEU1dFdDNXaUo1Y0FtNG90NGlhZUlySkdlakxvbUpq?=
 =?utf-8?B?bjVvSUREdndyUGZaa09sQWtsRjV4QXBpNCtiNUZLK1U1YWJ3YkI3U2tacGdD?=
 =?utf-8?B?MFhBWEI3UHhOejZseS9yRm9vVStCVUZUSFNXUXRIY1pIdnJnZHJQci9FN0k3?=
 =?utf-8?B?NTVQcjhJZWo4RHdCb0FsOElIMmg4UHM3YXoyZjkydUxDVlFScy8rMERHc0xY?=
 =?utf-8?B?ZUplNFZzblE0NFlaUFFJTkJKTndjbndZOHBPZWRBRDNVcVBRcW5lTzh0anhy?=
 =?utf-8?B?OTFGeUlQMWlmWW92SmptYUxJSVU3ckdibEdXdkxONnA2T2YwQ29xYi9MZ25J?=
 =?utf-8?B?d0x3bGp1aVNkdFVoUi9nalU5Y0JNOGE4UVljVWVoeDVtVzdURWl0WDk4SDVq?=
 =?utf-8?B?MkpDMWNmRFFhTXY2YVlUc092cDNzVVFvWDZSYlRERGJxazIzbEJzdnptVDZU?=
 =?utf-8?B?S0Iyd2dUL2dtR2dLQ25wMlNiVm9XL2tIbUJSM1U2eFlnVW93WnUrQVZrdjZp?=
 =?utf-8?B?aVcyMDZFNkxLTmRtSTNhOW13MU1ETTNoYUFWZmpzYndrOXFtNlVyV1VIZkYy?=
 =?utf-8?B?T0w3WVhTc0ZmaEZuVTNPU091T09FRThMcVA0SU9VeThtTC9sanp1YnNYVVV3?=
 =?utf-8?B?ajA1MlUzUlQ4T1IrZ0J5bWQ3bkE5YW1xb2lYTHdBWEc4NXI0R3h3T2ZTWUpw?=
 =?utf-8?Q?rnCoYE5D63j/h8IY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d5fa49-4e38-456f-01e0-08de57054805
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 02:48:52.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACWroO5Bw+tbgncS/EN0496wT5lkRKYEaOVnVNReANlTqMsh6+8kRt2stzE/4BeYb3GFGjYIoIOqbupuM4fJoDeBee/Pcl+LeKotmf5rPyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6749
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> This might the hardest to review patch I've looked at in a while...

Well, that *is* fatal feedback. I think this simply needs to be broken
up into smaller to digest pieces. Will send that shortly.

