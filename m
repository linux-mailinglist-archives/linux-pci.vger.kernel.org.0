Return-Path: <linux-pci+bounces-42736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCCFCAB23D
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 07:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFD1F30080D0
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFCD2D593E;
	Sun,  7 Dec 2025 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIz5Tqh+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52CB21B9C5;
	Sun,  7 Dec 2025 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765090469; cv=fail; b=TrvTrAnSS5T/myh84mmV17dFp4vAGmfpvkgZrFJDC0YkI20MLt6ixRz7QDb8rFVz4MY4CjJZvmtCB7rX/59RmvjIxE1w6iD672i8oTSQo8ujFZNrJeNyieVOkTF8kwIs6XHDXsS2uRnlf6uVjdc5X2BUyL04cD2+YpujsQKLCEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765090469; c=relaxed/simple;
	bh=iyuTT+Dm8hnu6KyBV+1/DE2vXTJQ5t0YcXmvWR65mEs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ct/XyNvFoiY4RKUDuPvOqI77dRANqv1icGtjc7dWG6dpUM2Qul3gj1ZdGw69ALbFl3eZEgB3+6QX3N/X5zwIq2srEpSVu1pRtFVIluNc5poU2FVG4X9OKPgoleMszThd+kLbF3bzYAKJuO3HcQeCVYA7ExqJuWme91sFRMfVgX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIz5Tqh+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765090468; x=1796626468;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=iyuTT+Dm8hnu6KyBV+1/DE2vXTJQ5t0YcXmvWR65mEs=;
  b=IIz5Tqh+HUEGu4oJ9wqpoTwLFmz95qrxg2yzVG2fgw4NXlQe2JIw6299
   nu3tZUK6VqE42kEY8ZN9l9t8kovz7MifVlrMaTjba1LNf2ySDbf3KS15g
   l7OdLtam3ebAIlRNtQfkKaAjPZTGm9J9i3K2MJ5q9pWk43zzMzeYludwQ
   jVGtlML/2aOIvDrYTL5GQe3TNBbY4oZq9qXAMPtRmEMT4cMp0xsXWK7rl
   XRYRoQhjxPdg/A4vePMCGiQ0/UKbRnLsBl79gkROWa7zzyoQ8UfCU4M20
   ZRhG+7NLept8m8PWGsbFnB3UuXUtCBuWKoCOmoSwaMsxDeD5RiTAYKufT
   A==;
X-CSE-ConnectionGUID: L8ajKssQTfWOH96zfRfRWg==
X-CSE-MsgGUID: QdSfmjaKTCm3vEomlITFdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="67030500"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67030500"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 22:54:27 -0800
X-CSE-ConnectionGUID: Jy95JaExR2a0rHMg15E4yQ==
X-CSE-MsgGUID: shOXkZr8Tg2wvF2q4nQgCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="195723464"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 22:54:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 6 Dec 2025 22:54:27 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sat, 6 Dec 2025 22:54:27 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 6 Dec 2025 22:54:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn8ofney3jF94TIsfybEkcDmyCSsSVb4P06iiUBEHpouqhu7WZ/Hrza86m4aqhtYKTb8FYV8ddr1+9hcEQ/E9I91mxuxttaDLnxIKcdx60quMMLpaQeKycWbB/OFY0xsxaxVThvmUJtUM6WMmJuFC60kjYGtehsG2jAAv0/UXg37//ytITpHTDqChcgtLB+R/UivC9f7QZqofM/H2gBBLGz/0jl2pL2iNZdef0xMfk0hiRqdGlGQbELEJDEPKpbeaY6NBo3INiSUhMd1fHHAmaLJNH+UVyD/Pt6B3zwE5IsJELlQIOQJD9BOQzBUfhMbRMeiqbegh+aX5ocBmCFLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DKrXEM2bVTAxQX0w2bWploETqaQHT/WrP8nrSCAfuE=;
 b=Fzh/vcKVh1o4cczQPJJM4ZNNCKJMjUi93niDkW5HhMxF3OoPq7WEJKy5ha10U2YFjdvoiWpe37rDrCsB/xMo8BZILEpLAO7g4tdHMUZKMcTE/e4ClXer5/56sIBi4N0Kl1rwVmshB9H78kyED7fZBBiVZzyZpy+902C9YB5P8ttEWPWXY01Wqg+mbk0GYbzJMCdbHs5cXMEioOOuUmRbDJpV4KnrRe8/I7tOc18KlA5ZN96s7YdRaol4Ghj2zJNoo8t7Yl/Vp0KtO/4hwR6gI3biq7WbLB7MR1zyTYnSSWJ+B53LU7lI7OM1Pd2+qF9dIzOlSoDWop+3V+1gVwam6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6447.namprd11.prod.outlook.com (2603:10b6:8:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sun, 7 Dec
 2025 06:54:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9388.012; Sun, 7 Dec 2025
 06:54:23 +0000
From: <dan.j.williams@intel.com>
Date: Sat, 6 Dec 2025 22:54:19 -0800
To: Linus Torvalds <torvalds@linux-foundation.org>,
	<dan.j.williams@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Joerg Roedel
	<joerg.roedel@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>, "Aneesh
 Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Message-ID: <6935249b454e9_1003f1006d@dwillia2-mobl4.notmuch>
In-Reply-To: <CAHk-=wh9dTX5eg0+NruSDbOCT_tafsO=a8m3cbhxFBvt-21bxQ@mail.gmail.com>
References: <69339e215b09f_1e0210057@dwillia2-mobl4.notmuch>
 <CAHk-=wh9dTX5eg0+NruSDbOCT_tafsO=a8m3cbhxFBvt-21bxQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCIe Link Encryption and Device Authentication
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::45) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a99bb5-a105-48cb-9cbe-08de355d7430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVpmcHVHdG90anE0SXdZeXFPWjZUQkJveW14SmMrZXlqbnN3ZlZjbktudXJI?=
 =?utf-8?B?a2N4RlpEOTM2dStReVBUc002Ny9qeTBZNzNtNGZPT2xNalFtemZ2elh1WTk0?=
 =?utf-8?B?Nk9sc0xnV0c5M2ZkaDlDSThDU2ZLRGZ4dlhBOTdGMnVhMkV2d3N5Z3ZId3Mw?=
 =?utf-8?B?VnNHVUIwM2tKWUJWdm5WZWdHUTcrVnF4SDZKb04zaUwwYmpWdnMrY3VDUWRS?=
 =?utf-8?B?ZFY5Y00vVTNjZnlxT2hhR2hWUXRNODVTeHc1S3BxcUppWWltUm9ZRFNqejlr?=
 =?utf-8?B?bWFpRlVrVW9HVUh5RHJWVTliQjJLMnFxMWNmMExxQWkyTERKQStuM3ZzQTAr?=
 =?utf-8?B?TTU5Lzc5NXpzNXh3QTZiU2hGNVNwNEFzUTgrbW1KSmxsUE1MRUN3Vk0zaTE0?=
 =?utf-8?B?NzIzMWRTYk9zRHFZSUFSbWx3MDV5YmpmVkdpWXkySi9SM0ROdzJNMHVRNHls?=
 =?utf-8?B?cTNqazlyeVR2VVRSbFNxbS9GdjhtVnNxREpqZXFycytUY2pGdDdKdzFiVHdi?=
 =?utf-8?B?alFKaE4zOUxqWFV0bUl6M1lEdHBPeGRIemprNVhmVkNJKytaRjFzUzFJWnMx?=
 =?utf-8?B?bk9MenAyOVNWeGJiUkxNWmRjYVVhNE1vaTBXS2taTGh2OUJRNW1PR0tiZ2Fk?=
 =?utf-8?B?NHh3OXhDTzZkcDRiT04rR2VzbnhJZDVaK0tyLzhmc0c5dlZrVFV6dGNTUmRr?=
 =?utf-8?B?WlRkbjJyNUZXYWI4TEh1R3pBMmF5alpRd2FFbzNCTDFZc2dIQVRIVjVqZGZZ?=
 =?utf-8?B?RkR0Rjc0Q2U1VzlJT1pNVGxNS0F6Q1MrbGRId0g3U1JqRmgwOGFnOUFRQlRZ?=
 =?utf-8?B?ZlhxL3ZUK3QwOGhEc2YrUzVtMklCUlpaM2VEQzQyekVva0M1WVFmbnRqZkEv?=
 =?utf-8?B?dzVwNkdFR0tvcGZYWE9NTUY0bXZoSitMS1JBVm1RSHREL3FvWDFmMUJHd1BE?=
 =?utf-8?B?Mit6bTNXRExhZm9NSm95SExxb1E0SWhkejNoMkc0Q2lub0RiUjhUZ2xGVnlj?=
 =?utf-8?B?TStKZEJWWjA1WVdGS1V4Zk95QUFOTk1ZTW5HWlRORmNQQXlPcUlrd2pYbzZO?=
 =?utf-8?B?RHJXSDhHWHpicE5ZdWFiQ3VMWTVsR05qT0NHWklLS003QXJZbWxGZ3hQcDN0?=
 =?utf-8?B?NFlRdXBDT3Jyd2ZlRFlqOCtZT0Y4ZDVBb2tMcG8rakQrN1RVQkcyeWZlVjhF?=
 =?utf-8?B?SG52QjJEcG1sWjU3SFQrZ2MxcnRkc0xWQmhOSEgyUnRJVzMrb1RwRktjVmlx?=
 =?utf-8?B?UHlkek1zZGRxd0dIRERkaENpS0RKNERXalNqc1FuNDZzL0tabm5oYVRUQnNK?=
 =?utf-8?B?RTk1dG9UR1VuTnovaG5jU2pEdzBLSzNkWlpZdVd0dTFTejQxMk4vWjBYb0g0?=
 =?utf-8?B?MU4vWnMwdHhYai9aNm9meTc0SllFQy9abU9UTWtBRlNYcnpTcVpjYmhOYkYx?=
 =?utf-8?B?ME8xSUhjVVdCVHdNUHhDaHp1ak93YXBOZ25vRnNUWUo4TStDTDJyZTJtamlY?=
 =?utf-8?B?ZzFjYlh3THc0Zk1zeE1NWVNpeXVYVXJzb3lsamdQdld5RjlXUXhxSFlQZ3Zw?=
 =?utf-8?B?UkJ0cjNmR3lEN0h0cDg3emFFNmMwcnpad09iU3IxREFDUUd1QmVHdmlYdXdw?=
 =?utf-8?B?T21PTmhCdjUrR0gyWnNTZUF4YURUTUpmdDVDQmJIaWFoNkszY202NkMyWmJt?=
 =?utf-8?B?aDIrQ0FRNllZSEZoSFBlMzhYTm5RMkJkOXhWajJ4ZHd5cUc0cnJWb2xHM2Iz?=
 =?utf-8?B?WFBMSW95L2pzWm4yWXV1Q3FNYVNXZDRwa0RGV0NDcVRMSmhPaWpQRUNkRG4y?=
 =?utf-8?B?TG10NU5HbUY2VU4wR1llK3hJa1ZnVDVOMlVGQndjMWVEQnlaSzBnelpaQTF6?=
 =?utf-8?B?TzFPU0gwc2NUREhYZHZPQk91ZGFERjZaVkM4RXZZWFladFhQVmhhRHdRVmti?=
 =?utf-8?Q?PsQAXb0pQMESzQOj7x72ozRspyGr37Go?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmxIWGJiVXZoUkNlUXBZWWVlMSsyYnBHTFNCZzQwNGRVbDU3QlpKRHREd3Y0?=
 =?utf-8?B?UWZia1dKQ3dPU1lmcXQ5NlVrdzBybGZxcThOUll4aHptVjVOQm5Oa3dXU1l1?=
 =?utf-8?B?MmJEQ3hrVlVrYWJtenRaYlJoR0xiSFBkQnNpWjlVMUxkTUlaejN2ZzkrVExi?=
 =?utf-8?B?NXgyZkVJU1lObDRBUkhWRFU2VGg5VXF0N1RObzlmSithQXhSSWRMYnJhbDVa?=
 =?utf-8?B?Qm5CVkNzMHoxdFNMZHpHWUROOGhpZndHUWplTVBNc1dDNzJjdGVvQjBoaTFR?=
 =?utf-8?B?ZFVseE9rVzdsdU5EYVpqalYzVGRiZnlXWk82TXc5VFdYWlUvT0VBd0hmQ21C?=
 =?utf-8?B?REUvM0RVS0VXRUdBYVYvUE5TKzRCSkpmdnBYTWdEQ1dXUHQrZ2t5QmxTQVF1?=
 =?utf-8?B?b2xJbS9raFNMR2ZNWURHRE13MVBTNFlMdGk1L0Jjckp2a0lTVDdydm9RS1Zi?=
 =?utf-8?B?blFRc3lieGduSlpCNXpoOE00dUxTNGdkV29NM01XbXFJNTdQUEtPanRXK29O?=
 =?utf-8?B?K3hua3JKUkNFS1ErYW1MamV0eXRQQkFvVFVTK0RvcjFYcS9SM29NN1VNcXBZ?=
 =?utf-8?B?S2d6T2o3elV5YkhXdlV5VGNoNjdqcHpmWGRxMGJTOUtiU3FVdGtkTVBjVGNU?=
 =?utf-8?B?V2F3QXJxOW1CZ2VYaXV5OUZuMmM2TTFRYzhEQjlmUUcweWYwUjJGbEl4MmpQ?=
 =?utf-8?B?YlpNWEFJK0wvUkQxZ2lWVHdKdUNJZnJIU1VsUjJ5NjE0VG9oU2VEbjhBMXZT?=
 =?utf-8?B?aFpvcFlKeDBhZDhpck8zU1ZzVGdqMkxuK2F4cHBCYWZsNGVhY0lGb201M0gx?=
 =?utf-8?B?MVA3aGpCd2U2OCs3c1FySGo3YjVkTjFkNHJOcVd6WHpCb2gvSFJEVTlVSFp0?=
 =?utf-8?B?dGtsUWhRQmpnK0ZqMUxmMlc0WFoyd0orTWQzUWhiSGFUMmIwWjBwRmR5aUFn?=
 =?utf-8?B?dDFWelBLb0t0S2QrdmRLZlA3WTdlODRXQUZMQXJYcVRmVTZjRlgwbHhobUp4?=
 =?utf-8?B?Y2t0MGNmZ09UR2QvT0tUR2pNbko4UWNtZjAvSy9RWk9LSU9IcVIrMmtqdGFY?=
 =?utf-8?B?TzNTS1ZEVzgrQXU5eFQzM1FtdC82OXlTZWR6R3FkQkJmbzBYaGdERWRHM2dC?=
 =?utf-8?B?aExFL0hlZ1plNzhwNnBiejkwbnhzbU8zVjJKMFQvTWtOL2FkeExaejRQeE11?=
 =?utf-8?B?eE9jWjA4U3VUQnFLcmZQcnR0NWtPbCttWEp4VkM2QVRYNFo5N2F2ejQrbk1W?=
 =?utf-8?B?WUlYZ3VOQnRRUithWHprblFLeDFVcUQ2RGx6Y2d5N1hiajA4TEdCQnpnNm1h?=
 =?utf-8?B?a3FPSDZUSFQ0SVYzTi9USS9xeHVPdklJRlNDM0wwTkUwZ0M0MEJ0UmRxSEsz?=
 =?utf-8?B?SUNubXVtSmFOdmNNTmM1RFJWbDFjdmF2aUhpWnRZclBnMDdsTUpVUzh5eHJ1?=
 =?utf-8?B?TlVLelZVQnJsMDhjOTQ0Uzh1dGd4bXU3OTlENHNyM0NLU1MrT1EvdVFycnYv?=
 =?utf-8?B?a014UkgxL0J2OW1QU0hwZ2FHbkFoOGxQTUpiQTBod1pVTDY1VTRSQ0pLYlJO?=
 =?utf-8?B?Y0xQZG95cjloQVhYOVVCVHdMMUtJTzNrTkxFdlh6L05paGs1TEUyamhZdE9I?=
 =?utf-8?B?T0R3YTUxd0lNT0toRDBKc2NBby9vWGYwK1EyMU1NRm5mQ3BQVXJDMzNKc0cy?=
 =?utf-8?B?bkswNFJmU21yMXRoZ3A1SlpnSlgzWit2RXFNR3FZL0VuVGdGaWtlWEFtZHl0?=
 =?utf-8?B?N0x4SlQxU29IeVRkMSsxTXlPWUhSSGlKTVR4YTA3L3NIUlVSdmg3S3FmS3R1?=
 =?utf-8?B?KzJvL0krOTI0Zm1mYlFZUWs4eGxGSFpDbTBjR3BVeHdIczJGREUvcHlONmd1?=
 =?utf-8?B?OW1DaHVNc1Z5SUpIdWYrK3EvbVJRQnRoRW9pYWNZb1h0aGhDQW1ITU85cUl2?=
 =?utf-8?B?U0ljcS9INTZCY3lSdlBReDZCZWpCZnhHTkNnOTdsbVZvYm5IRVRMZEMwWEZL?=
 =?utf-8?B?QURlV21Kdm1lc3FJV0wxaDd0QnRidjFtTVNERGc5a0o2SUxHZlFRTFRTeDNV?=
 =?utf-8?B?OUNLQkpONHdHV1hUMUwxRlYyUVJkem5LRGU0UTU3cXhDc0d0YzRsaFlvU2lY?=
 =?utf-8?B?SVl0Ykc2dU1rclhoM1F1bUJhd2JZS1VrUDRVSDU2b2t4NXZPT3Q5VHNicE1X?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a99bb5-a105-48cb-9cbe-08de355d7430
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 06:54:23.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9SVshtLpIhQ5hd2XpIiz5kTQ940Ihr2VFd4OO/c2FGmWqaEE4VH8rdmeowXXBT+UXMB5ilyJCxcp1oFhUDLO+YGHLF6dfva2R3wGHh50Oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6447
X-OriginatorOrg: intel.com

Linus Torvalds wrote:
[..]
> So if you have AMD_IOMMU enabled without KVM_AMD_SEV you end up with a
> broken build:
> 
>    ERROR: modpost: "amd_iommu_sev_tio_supported"
> [drivers/crypto/ccp/ccp.ko] undefined!
>    make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> 
> I've pushed out a minimal fix that seems to work for me.
> 
> Please check - and be more careful. This is _not_ some kind of odd config.

Ack, and ugh, sorry about that. Your:

    5e5ea7f61610 iommu/amd: fix SEV-TIO support reporting

Looks good to me, and agree that SEV disabled should be a reasonable
default for folks that have not enabled it previously.

