Return-Path: <linux-pci+bounces-39468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5468BC115BA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 21:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB8561B1B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 20:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACFE2E541F;
	Mon, 27 Oct 2025 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CF5XHkuE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456882E22A3;
	Mon, 27 Oct 2025 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596117; cv=fail; b=OlBghutbHnZ6aai2Pr44mnLa+KC7A+EmCQs8VkDiYLARgfDcUXq7npzv9hGwjfkUh9d1MWa7fS8SVqw8dERnoC+mGe7RYI3rh9ugQ0eXPT77BQ+LAXwB2XvVdUrmxMmO+u3m1E8cy1WrbdtYRVPfHQvquy2slrunYDhOJLmRHTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596117; c=relaxed/simple;
	bh=fizxdl1y+de8CqGpJ5sBUaTpok3lrtrnhVDl7dTlWzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LLO3ZaMphbSbdQ/J9gY2s09c/mNAF4pHC7bB7bYfzD7YS13YSWf+kW7AH3R44MgiimsTic0W/3DraeeSfWM+8CVSgwPn1L8XodDOJUCfAdCNbwFFWZ7M02UaTv2hhxO8U6tRsc84I2NzCqpYhcQkfxEjgEPxcfvwfzQ9/fqt/7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CF5XHkuE; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761596116; x=1793132116;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fizxdl1y+de8CqGpJ5sBUaTpok3lrtrnhVDl7dTlWzA=;
  b=CF5XHkuECLW2G0DhoKllD38ScyLtabdPAjuvp6Q8v0fMC1MOh19TP8NA
   6p77zaUuat4NkqmNVtPplGN7XjbALY2nzLe2IvFk+KLrXvvvLG+GY65tU
   NZodP1hcO+TaDJCqaPOVZWxypDStmvNha3JeTEPZSwJaUdrsj1ijCL8YK
   8d3KSFH5cdgL/zDgiyF/d68yYtTMqPw76O2y24QD5rFvPuidqXIr4/+wT
   EWUYe5XscHVqRFsArgsB5XV1G1/JYn/mZ8aA/y+66MZsVtRj16i4z1egy
   M7TDkxCt/a4szTDS3h1hky+xmNceH3nwTzEUSDwua/zMu0Bce1FpHzjlD
   g==;
X-CSE-ConnectionGUID: fT3tSEF0RnK5SHc8dVCETg==
X-CSE-MsgGUID: LtCHD2VJRLesdSPTqx2x3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63781938"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="63781938"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:15:14 -0700
X-CSE-ConnectionGUID: svWLOL4JQ1GtVP8dbYb/Nw==
X-CSE-MsgGUID: fzdkB3p3SoGjpeetb85EJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="189449345"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:15:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 13:15:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 13:15:13 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 13:15:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAzKvvY6QVyVMjel3fHDQni9KX5aFPUC2sEKUkaIrpUNlynfP0XLM2NnL20s4kaXMfCUIUyrvnvnX8zuf5P2zonE3TfzJFTgK5tN6fYAmaLIjJIq7ljJbv6sazVzZpUpO0Bxsohk5ZJ8665mM2pevBnrr2XjJlRyyz3nFXrCgx3ABAw3k4s1tLpjLm3jv1jWMd8X8EEY7FhbBjwDIM9FbwHpQH/fUkfS9XApAP3H1wiauEOpqz+m2V1y7qYTjWltNmgqXZhU0RP0N/CKTKZRNM3kWPNXMd7Ay2pYNfw/97oGQq4PQQv1G5oSJSaxfvQz+ACXkSkCJW5axBpmjDDSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fizxdl1y+de8CqGpJ5sBUaTpok3lrtrnhVDl7dTlWzA=;
 b=FNeSFzoHm6iQ+z0aZVWlnZxXXDmZ3Bx16R6XpI8rxJFeheoN1GTKPR3ADm7VUPq3ebEWTWQx4F3mxv9VSEHGBgLJofFCjwwJEOL/hil5FXbNFGyw4d5SXBS4SMJ27R0q8d8F4WwY4OCjFMuGb6qoxYtoMhzeLxeAg0OQaupGypH6D7u8s828LGLjLc53d5Wa5tHF/ukHEbZNo524d8SHbRUTza7czUlxitZhLZTYy4Pwf9stNiXZgr4YLvciutALq8GpflFbM+9EnUId0DEVYm53kC7ktxaoAf3uX3ImiQdk8emLYpQKFBt7ci//zHV8nXJR14ZKUBbyTffWnTDWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB6660.namprd11.prod.outlook.com (2603:10b6:510:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 20:15:09 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 20:15:09 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Len Brown
	<lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, Hanjun Guo
	<guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"Schofield, Alison" <alison.schofield@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Sunil V L <sunilvl@ventanamicro.com>, Xiaofei Tan
	<tanxiaofei@huawei.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Huacai Chen <chenhuacai@kernel.org>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>, Arnd Bergmann <arnd@arndb.de>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Guo Weikang
	<guoweikang.kernel@gmail.com>, Xin Li <xin@zytor.com>, Will Deacon
	<will@kernel.org>, Huang Yiwei <quic_hyiwei@quicinc.com>, Gavin Shan
	<gshan@redhat.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>, Li Ming
	<ming.li@zohomail.com>, =?utf-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Karolina Stolarek
	<karolina.stolarek@oracle.com>, Jon Pan-Doh <pandoh@google.com>, Lukas Wunner
	<lukas@wunner.de>, Shiju Jose <shiju.jose@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 0/6 v6] Make ELOG and GHES log and trace consistently
Thread-Topic: [PATCH 0/6 v6] Make ELOG and GHES log and trace consistently
Thread-Index: AQHcRBhJ+NKnKy5QEEuDW+xP4WY3ibTWawCAgAAIyjA=
Date: Mon, 27 Oct 2025 20:15:09 +0000
Message-ID: <SJ1PR11MB60836FB0D4D8EE564759F7E3FCFCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
 <CAJZ5v0h22pPnwPnkbd5HfP02aTbiK22nHCGtGKn1eR2KDM4Yhw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h22pPnwPnkbd5HfP02aTbiK22nHCGtGKn1eR2KDM4Yhw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB6660:EE_
x-ms-office365-filtering-correlation-id: b4ada8f3-9a86-4133-ad6d-08de15958732
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZlR5Ri9pNnk3RCt4WGtRNkNRM0pWWXhubXpVOVN4MkJEMUdTZEM2YUMwaDVz?=
 =?utf-8?B?ajVNM2lmSUM2cytzWjkyMHl6UkZYckROVVNadk5xL0pSTUxBVU03QlhHMzRQ?=
 =?utf-8?B?eDh5bmFNTFhTYnZjVUdWRTJUVXkzeDFHTlY2eExXZE9xbjRJYlFYU0pacTVl?=
 =?utf-8?B?blJ1OXJnbVFhYVhtc2YxNWxxbFkyVk1uUjVVTHJ1QzFqVkhVVEgvRU1EYUI5?=
 =?utf-8?B?ZGRLeEpaTEJqSS8vdUhmY21zL2llM1gyZ1daM1NQeHREK0FVVDRoVDRCRXpP?=
 =?utf-8?B?dXRwV1J0a3VRS2Z1ZGR3ZS9LSDNOQ2p3emh0ajJiL2pjaGs5SjYwcXdsWk1w?=
 =?utf-8?B?M1FYUlhFNTliYUtOZ005VjhhckdPM3V6MzE3OVZMWmN5UldNV2VWNnBJTkpO?=
 =?utf-8?B?MFB6YVp1cUNpV2hyUVVSb2JxR0F2dTZVOGtoZ2FocExjT2hmajA0YjNPUEJK?=
 =?utf-8?B?RC8vOFZuU1V6TDhSenA4UjRsVExlSWxock1WTEN4MkxWNFNtckxGWlZzckJK?=
 =?utf-8?B?WlArZno4Qm9VYnhTZmltOGY1UUVORGFpNDh4endiOTlpREVRanI1S0F0MlFD?=
 =?utf-8?B?TjB0Nmd2RCtldktLaUhINDlYaFdFZHVYZHRPRTg0Zm93K2Z0cEwyTUlTQTQ4?=
 =?utf-8?B?cDRaT1ROK211dDVxYUJidjlod2t5cWFxNkdIRGhSN3JVZmFCWVNaM1pocTZR?=
 =?utf-8?B?MDFJTzFGMUZjUkRFZVR0L0tWeWNUeWI4UUZrMGtLNUR0SkNqcjFmZnhhMlZK?=
 =?utf-8?B?QUtpRitHbThoS3IvekxiSWlUaldJMGFGODZnTmRSWWw5cmNzNmZZRUJOcTB1?=
 =?utf-8?B?Z2tvR01rQ3BXNkJMUnVDbXB0TEFicDRzY0EySFhRY0czbFJYMHlza21zV016?=
 =?utf-8?B?R2tDWHhDQy9ITDRnbGJLUUJVNHRlbkhKZEJLZVUxRjdQODlLb2NxYkh2Yzd2?=
 =?utf-8?B?aXJTd1pjbUR4alk2T0JVQTI3U3MxSktnY1hqcXpGWkJUL0NtZWZIdFpZWjV2?=
 =?utf-8?B?SGdaUm85bWo1cjZhYjNsQUQvVlBkN0p2WkJmaDJjeHMrb0JoakdxQ2NzdE5J?=
 =?utf-8?B?Rkt3ckpRSUtKc0lrUzIxYWZVVFJqMVRhSFc5RjBFZytXaFpsY2xqNXhFNDRF?=
 =?utf-8?B?ZC8xdm1wUSt1UlB0WTFZeEVSSWpSN3ppUHphYksvVFAvdVI5Q0crWC9TVngy?=
 =?utf-8?B?Zlh0VVUxOEwydXc2aW5GK2tpNXVjTEFacWFBY2l1VUVtYkgvbGJrVEVoT2pP?=
 =?utf-8?B?S1lmT0VOT2VyTzB5cjF5Z1MvSE9sVFBoZlppV1UxTTZudXhhZlNCMWszd25o?=
 =?utf-8?B?dWoreEdyajVLRTFvMWE2UWFQVFR5VDd1aTZyR0NJQTdVRHFUY3NpR3NpaDha?=
 =?utf-8?B?eUR1RVdFaExaRnZhNW5hOE5KdmExZWJyOWJKTnY5RkZMOElySUlJUXRJUWdR?=
 =?utf-8?B?Q0dxYTdqYWpFRGVjU1VKV3F6b2VoZkQ3ZHphMlFRZ3AzVWl0TzA2ZXEwVlRG?=
 =?utf-8?B?bnpUUFl3ZER2Z2d2NkZTNXQrdGNFTWUyTXhMWTNiMWZVVFc2NEtWeFhQTi9r?=
 =?utf-8?B?QVRNR0Rzb3orWXRKR3I3RVNEVmJqOUdtczBITGRUMlpFVE5tL1pVa28xMDI2?=
 =?utf-8?B?cjBQYkgyOUdBV1JVczFsV2g2UGpWc05BbEU4b3BjeFliL1dhWkxTUVZ4cHhi?=
 =?utf-8?B?T3hIL1FtRWhReEVyWWErZ0ZBeVZkTHhXUU9YQ1pvMGkzdW5PYzRtalBzKzFQ?=
 =?utf-8?B?aTdDRnVjbXhqZ0xwK1kvNjFFU0dXZFgyM2Vld05zQm9GSmsyWU8yK3gwVmtX?=
 =?utf-8?B?L3hTcVdZb2k1VEJHenlvNm5HbHNacTNiOVpqclVRZ0xYdGFrNlFtMloxZWtQ?=
 =?utf-8?B?U2VyZjFTSjV2SVgxZHltTzdCY0JqLzAvVVY4RGY1Q21nWWdRTmRoQlIzeGlq?=
 =?utf-8?B?UDE2QUFpUEl4U01MQU5reElqOTVsRFlWZ0xhMWRqMERYUnJMM3ZNOG5wMWdN?=
 =?utf-8?B?Wmh5aXA0eThLK21LTGNnMk9jQTdwaU9RZHNzMzFqZUN2K0QxcHk2Tm54NUow?=
 =?utf-8?Q?mZKyXs?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEY5ak5NY1lTMDYzYjdFdFFQNDYzVzJOei9FZkcyVURkSkpWTDJUU01DVzhr?=
 =?utf-8?B?WktiOW9iZ0xLcFRkK1EraEhUMThxSXdoRlNFWlpyWEFzbE1uK0VMUnFBU3NO?=
 =?utf-8?B?Q0MvZHFMUXEzcGE2Vlk4aWZQcGRuYi82LzZMMFQwWjhPNUdKUE5sam5oSkFt?=
 =?utf-8?B?OWQ3NDEwY3hOdms4Yms2d2VROVdFK0tVVnNMV0ZsUUtxU2NHNmhYVVc4THpw?=
 =?utf-8?B?TklXeG15S1gwbGpwa1hHS3gyY3g0V1Jpa1ovam5DYkxpUVFHTmV2R2I2djRR?=
 =?utf-8?B?c282YUJ3eWQzWTJXKzAyeklNRG9DR3k5OUdrbjBYRTBuaHNGQWNUV2NpVGRR?=
 =?utf-8?B?RktHYTh0S2FjcXdSVnQ5eEh0QnBKQzdCY09VVWZqTkkrT3NTWnkrSCtIeE9i?=
 =?utf-8?B?aU40NVI0Smgyc0hoMnU3aWpkVHdFbGw3RE5nWWI1dTcrL3JLb1RrZnNRT1NE?=
 =?utf-8?B?UWpBbThjTmhPakdTbGZ2Vmk0ZXB5ZTJZOUdCMEltUDZVM0tycmxZRlpWaGRZ?=
 =?utf-8?B?ZzNoNVM0TmR4V0gzTUY4VmlIWTBMcldYdkwxMlhjUEk2Qml2RDlHck1jdHMx?=
 =?utf-8?B?NlFNQ3Y0NUxuOGZRMmJMR0FaMzIvK3ZMRysrYlFzTW9wdlh4QmVjbE1LZHcw?=
 =?utf-8?B?Ym0yUVU1Uk1rSE55N0Vuek51MnpPUDFoS2gzaitJeG4xK0JXSnFXUU41VXdI?=
 =?utf-8?B?ZExrUVhCczE1UmtZazdMQi9aOFgydG9XT2dyRFBuY0Jpa0I1VE9nRkNOOXRR?=
 =?utf-8?B?ZmNHYlpEVDJuRkd1MGVBc25ocG1nc1V2czlMU3RaU1RJT2lTZFFORFVSZytP?=
 =?utf-8?B?TUoxNUxsT0Zuay9qMXhuVUIwKys5TWNERWRjZmJrT2Z6c3NTZW5ZMzhoNnRS?=
 =?utf-8?B?L2FoNUJmSGEyWGhBN2pRalJlblJZbCtNT1M1Z2dwVmw0Tm5SdlJrOEFBd1Ux?=
 =?utf-8?B?NmNpanIzVC9HVGE4NERhQytKa2hONjhQWjdIVnEwT3NHa3JWSjdHQkVsQy9v?=
 =?utf-8?B?dDliNHBUTWxkYk1YVjk2VFliZGFURkk3VzV3ZVRiUEtxUHJNd1ZuWm1Ud24x?=
 =?utf-8?B?Z2hZOHFRVDBVTkJvYUcyeFhlY2dsT25mUEczMkdsK1ZaWG04SEw1K0xRaUxR?=
 =?utf-8?B?cHBXbTRkTERrRmNFbC82RDNIV0NDSnN4UEw1cFRVa2ZzUjA5TTVJTVhSZTZZ?=
 =?utf-8?B?bVQxdXlMa1ptUWJUNkRIZFdYNloza2NWNzBCcWdJT2kxRjNwbDE1bGZCd0Ju?=
 =?utf-8?B?NUZwQ293eXZPRHNLaG9EOEFQRDlaT0VmL3hkUHNLaWNYL3ZZWk5rUHQ1L1VO?=
 =?utf-8?B?a0QvaEk2bVFOall3aG81ZTZvb3NTakFKOEZIQ1EwSkJGcDYvWU8xZTF4L0JU?=
 =?utf-8?B?SmFGM01Ea3pLMnZ1UlJYaHczQTNhRHZZZGZGSWJUMXNmTHF6cENiRzFHNSs2?=
 =?utf-8?B?cGlsVXkwUEk4ejAxUDFiV2FOdHZTRGtnVkZIRzdndkFXcE5jOGZ4d0JFZ2NM?=
 =?utf-8?B?T1pNWStTVWNpRk41TUQxcVExSFVGRlNuN1lYaFFMaUw2YWhVU2crMWNRTHRs?=
 =?utf-8?B?b2ZGSTZWelhoTUY5cy9XdE0yYXdsSVBMY0MwTkNYODZsR0dzeVpxbU91ZHZw?=
 =?utf-8?B?T3plUlpVZTBPOW1BVk1iczBQdndDYkdlTVlGK1k3cGgrajV4cUlpbmJ3VzZy?=
 =?utf-8?B?NG9STmZSYW12S0FTazdGbVJSOU50eUxsUkxVZzdPN0lwbW5yY1lWR1BjcFUy?=
 =?utf-8?B?OG9BU09vQ3NNVE1VYlVrbFNzclR4bWphRm9HRVRlZU95R0JaYUhIVWpuOGpQ?=
 =?utf-8?B?NWozMy9kL1Z4aGFnUnVTbHU4NUJkdk0vNFBaRENKVVp1YmpYeHhCdnFWWVNV?=
 =?utf-8?B?MjRWZ1RLQXk1VzZUNEg3Q0U3WEFrdzFyWEIyWTVHaUJ2OGZpU2ZvdlU2U2tz?=
 =?utf-8?B?UVVJSkoyY2hzdis5WHIrTXF4aUIyMDFzTkYzc2s5ZFl1ZEpxVDB0cEk0Q1Uw?=
 =?utf-8?B?WkNpQi92YUs4enhPU3FxMFJjVEhGeHlyTGt5c2g2Q2RJNWJQdmlTeTdYRE1x?=
 =?utf-8?B?QkpTcEhXNURiUURHbGNpbzRVN2dXamcyY1poTEFHQlJyaExxTjhGdFdNcmsv?=
 =?utf-8?Q?+Zc+bmk1D/PvZdQCEJsyH+DvK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ada8f3-9a86-4133-ad6d-08de15958732
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 20:15:09.5202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtQ1n/hX22AbdNp1bg5/8jOfGDByDZAOduYf/PxFHmqLrOGZvNzpaQiODEl9XTdyFRhFBTbhVxhjwVa85Hzqrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
X-OriginatorOrg: intel.com

PiBJIG5lZWQgQUNLcyBvciBlcXVpdmFsZW50IGZvciBwYXRjaGVzIFszLTUvNl0gZnJvbSB0aGUg
ZGVzaWduYXRlZCBBUEVJDQo+IHJldmlld2Vycy4gIFRvbnk/DQoNClRoZXJlJ3MgYW4gTEtQIGNv
bXBsYWludCBhZ2FpbnN0IHBhdGNoIDMgKHBlcmhhcHMgZm9yIGEgY3JhenkgcmFuZGNvbmZpZywg
YnV0IGFuIGluZGljYXRpb24gdGhhdCBLY29uZmlnIGRlcGVuZGVuY2llcyBhcmVuJ3QgcmlnaHQp
Lg0KDQpUaGUgQVBFSSBiaXRzIGxvb2sgb2sgdG8gbWUuIEJ1dCBJIHRoaW5rIDMtNiBuZWVkIHNv
bWUgQ1hMIGFja3MgdG9vLg0KDQotVG9ueQ0K

