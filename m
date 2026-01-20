Return-Path: <linux-pci+bounces-45274-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LghAHK/b2kOMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45274-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 18:46:26 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 480E148CD4
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 18:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 532B278AD0F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98959451079;
	Tue, 20 Jan 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGSdKcx8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4545107F;
	Tue, 20 Jan 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920174; cv=fail; b=Ngbjd+US3z/RE/W9JwDuefgO8GT/zS5+AITPZW+lnMh7YU0oe7ZwCVM0WEdzLVpheZRs5TY4GuevW+90bqxSTZ/Lfh7uX5nZ8OJWQ+xFUT8F7HbO4GmhBD1iYbJvkrUd0a/AE3+tnxGDYTOrGkNTbvm4VdCQ6M2b6XL8hF+rdfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920174; c=relaxed/simple;
	bh=tc4w25TxOl4TxMg13ujOH+Wcf5/FQsjjPpbzy4yetjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vFrjwYWsGUDx08RSAOzOOb+9pENLWApkZkMiDg8SGcTFeREGxNDz+vBD0nuwv4Loitkig8rdYHjeVo765PKRCNmXmjAvAbRyjaRfuIzwkggnNwimCa5yufbGpj1u7f1PSwcB7VidMNyK0GpswWOU5jXMJnIV6BcwkiJiXIqUz08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGSdKcx8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768920173; x=1800456173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tc4w25TxOl4TxMg13ujOH+Wcf5/FQsjjPpbzy4yetjY=;
  b=MGSdKcx8BetTHbz74EInJh0n9cKhhZUilptA8T5R9mMLh8A/EhV0HozK
   2zdocmG63l315ZbEfkqKCz8Z00sRQ3ehXv1K+V9OOt2NZj6/8vrO7pq6a
   uTKELTDk21ZYlwXtem4aE9iDZLZMoAPmBewWwZwnjtgaEnzluLDoSAuVO
   uxT0SsGHNXcE/CBNyj174wetfqgNN28N+6a3iXwWQu0hivfOFBmXARtul
   e92L34gSFyiWuHhNcvWs9T5jJppbsgEQ7wb8QOaTOZK+tUctlPnk3mdDH
   lI7SOrWhTitYH94juQ9yNsNMGPNLoGNu9R0GyRT13RQWUbNgFFSRBvWZH
   w==;
X-CSE-ConnectionGUID: hqPd1Ik3QZWaY1iAfk3VKg==
X-CSE-MsgGUID: 3XigzO1mSPGYxGu7kv+kVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="69862199"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="69862199"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:42:52 -0800
X-CSE-ConnectionGUID: IRnsjxWXTWeetVyG2E/UkQ==
X-CSE-MsgGUID: mhPcszC0SBGI+iek1Ax6Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="236816940"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:42:52 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 06:42:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 06:42:51 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 06:42:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugsv/lu2rIoLyCo6xAUHwpDOhDRlwcPqp4/gtghqqPjLTTVwglyvQUClP+Y6rurcGN8edRgf9c4sjmvy/tbfnM2KyuzByCftUPFEZ0pIFrkRnEsvpbVS+BNM0cQBLDVahsHqP7OCNdh+k6bt3TEhj0zRf6xoKdZ8RQSwnYAdt5DFWkp2DCwq3FErbrA0wWyr0Mdz2enIyrsEhh1CU0hVZcLuff9qKE0oufYJr6aMI5NU8Z63ERIyJQ7ExtOwmxqNittO9KCyJ/j0Pe8WOX67B683D51LCzdUOVIqe1wK49F97i9va3UwKYToPjsU92FBGUWKsnZYGmzRuoOtql9WwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2P7pBmA1+92c8qbwAcVUf5mKTrkcLZvDQ4HrlC/xDg=;
 b=XoQkOdzy/wdpGH4LMt75SqkUW7u/Qnia0JFiu+npdcRcOCd2e5YsM+r9TzQVSbijtjwHSeyHA7qAI3Ghgbgo5d0IkhgjAxZAYhC3knDYvW2hNuyaRJL2jPYwZHQ8bk0uuyYQcgfU8ozslvOQSWzKWlMZo9dL+4S2IY05PMCmrtics+SzVsIf2qWXzBEu3Y6EKymzF4q8yQK49/ET5mKmsHXpZLEcj6al8vmlYuOK2lq6fKzPTBXI97WcW0p2TlYiir8IfdYhaZBi3y2X1RfjIlEUotf/3mlDRBoGaWicMFT3o6XRia59AOrMXjLx1PWt05dUqO5dOvwqo9qNeOejkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) by
 CH3PR11MB7673.namprd11.prod.outlook.com (2603:10b6:610:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:42:43 +0000
Received: from DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::8648:3a6b:af5c:b6e6]) by DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::8648:3a6b:af5c:b6e6%3]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 14:42:42 +0000
From: "Shankar, Uma" <uma.shankar@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, "Nilawar, Badal"
	<badal.nilawar@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Gupta, Anshuman"
	<anshuman.gupta@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "Gupta, Varun" <varun.gupta@intel.com>,
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, "Poosa,
 Karthik" <karthik.poosa@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>,
	"Anirban, Sk" <sk.anirban@intel.com>, "Jadav, Raag" <raag.jadav@intel.com>
Subject: RE: [PATCH v6 06/12] drm/xe/vrsr: Enable VRSR on default VGA boot
 device
Thread-Topic: [PATCH v6 06/12] drm/xe/vrsr: Enable VRSR on default VGA boot
 device
Thread-Index: AQHchKo8m4IgQ/RhPESXCXhThPz9bbVTTCgAgAAQ24CAB7rngIAABGWAgAAPO3A=
Date: Tue, 20 Jan 2026 14:42:42 +0000
Message-ID: <DM4PR11MB63604AB8E122613BF072DEFDF489A@DM4PR11MB6360.namprd11.prod.outlook.com>
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
 <20260113164200.1151788-20-badal.nilawar@intel.com>
 <64894565d5eace99fd65f290ee807dabaa2de04f@intel.com>
 <aWkG5cEapt_attfS@intel.com> <431ce6be-b083-4002-8dc1-4be8e557d07c@intel.com>
 <e522e352351d52da15c8a9d7f9332e48092f06d4@intel.com>
In-Reply-To: <e522e352351d52da15c8a9d7f9332e48092f06d4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6360:EE_|CH3PR11MB7673:EE_
x-ms-office365-filtering-correlation-id: c89ecbf8-c55d-440b-037d-08de58322af6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?PRub9KDTYvCVVocebPyTKqwQeRLQb2ow6NFiPRHSaiNsXmp1jEKutx6mzhc1?=
 =?us-ascii?Q?QM3zT+/QKtZAUkzHu1gz8Fhq8Rwq44gGmac4kg1mHhNDubkb538S0nxx1S1z?=
 =?us-ascii?Q?FuJy1ZbCNnGSohfrDcMQgS/1A8P4SGAaipFDhm3HOC/2DehkzNkMgtaClbMV?=
 =?us-ascii?Q?0PMugTYnlBhx1AE5AJJTaWvCuYs0XAHSJ+B1vPtizZoM+wuvtYoDQeTOSidD?=
 =?us-ascii?Q?S6G/O+5xyWAUUhXy4SasdL0FZeL3hqQIJVdBMkcbHQ1evdQ/Y4sivw3m9qKC?=
 =?us-ascii?Q?M0+M2RjWWOp1Xiw1ejZRaw0fyb0WfXWqFZezgtiqYY+INVkf8xSXojeZ2+ad?=
 =?us-ascii?Q?/AN3AVMeJpwubi6L7KzMkJ1nYRMBCCZnXLFbH0Bxw04eAL9zRvQ+IoP88rtC?=
 =?us-ascii?Q?gAQH5YlL/sPQRpz3e3yqTPzjnBI68odw6mlqTucLg30PWFES5sA09PtTD2UX?=
 =?us-ascii?Q?sKtl+D2hogsN0yBwWWt5CjOWa218loTH+pdZhVMqVKBkrdxXuLfuaBliQQIB?=
 =?us-ascii?Q?Xm9h+dkHd9ecjJRMt2jTlNpgk7gvz4p0t6hkzhOrpNvNH0YVqpmoKSYyWlIN?=
 =?us-ascii?Q?hDnChlsLD6FEenF0kj0p5UbDkcfh84pMqQlDGJXzCeidQiGMANZY//b9a6le?=
 =?us-ascii?Q?DxkuuMHcKpQ68eb++QGJEg+p0as0RVs1xkocNrlta95mDltGD3BirNn32JfU?=
 =?us-ascii?Q?RwpWp1dNbPYu5AsIcCZ5U2xM8ptq94IWPrKBAkJEk3F+ktR+OmSbuvrKaNDb?=
 =?us-ascii?Q?BEuj31t2BWvFBfQvqM9Y7R7776Sluhnx+ZKo14hOCkCGSya35Gi9AuIbcZTM?=
 =?us-ascii?Q?DkABg3sK5iqZAkH7hHxeLLKPyY3KmrmpmzfI+uw/HdvIwtK/qOUHveSMxy0r?=
 =?us-ascii?Q?MaBJEMYcb5M2cU9QF7jBJweQVSu7uLApmk0YJ3vZc4VW/mLfN7IcjOsio9bH?=
 =?us-ascii?Q?NIp2u5Yza7uYRsL94BribbZQN2gLY3jbmzMXLm/GoeRqIRsu0Zg8i+Z9UDMH?=
 =?us-ascii?Q?1vHNnIU0wgNllseriU9RX6YmPxzkGVq51H8r6l7ZFIvPK+vQ3WvjqpgyTUoD?=
 =?us-ascii?Q?ToTzVWjwfpj/ItMQanhCXlnOh2wQrf2PzdUz56L3s5lIf1EkoqgiFnrOf7WZ?=
 =?us-ascii?Q?RQfmKpyfH1wPCor/Vu6/DqRrIhsrAbQFfQa/6FWnhdIeP0FXwwFTTi4C7GGj?=
 =?us-ascii?Q?2zhXwdL3CD1F1MBx8T5Mh0X6ZuIcv/UFxyOaTAXNPasmJ/l5ntjk3QUWxuxG?=
 =?us-ascii?Q?q6vlyA2pcW6R2El8CSnrnOxujH6T2fQ3OfytnR3NES+H/dXAoC5G0L6Te5FP?=
 =?us-ascii?Q?5qCPppRqNx+2ObL5RTgxOoZZpA/oD+FYzDceSwsXQDZhvtcn+ALq3cJnddHu?=
 =?us-ascii?Q?P19i8eDfL5FN0tMDlrh+vBrTDD8884XvsS6Q0oGDQ45+uAQ9ZFX6M70pQ7QW?=
 =?us-ascii?Q?HOEDvopzmWIVTc0JyJ5RHMYMWfvnZqGr2RYa1CQcC28+ODHDaNC1odPu0UCl?=
 =?us-ascii?Q?ZXml6Hs/OH73Zs1F1ZrHz+Wx1coa7eF391aLS9ypwBnaAG/nbQAeZj5SkEPR?=
 =?us-ascii?Q?jKIzOnGfpbveigVzqFi3/pMoX0EDrb69g8JhgLcy/YWQw3p1kqXuNkcJ+Qzh?=
 =?us-ascii?Q?T0n++of1M2NNXbux/Q3s7Oc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6360.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YirjrqLLXjBXkMJfeok3NBoROgL2KXO/a+P3Tpsimh+N6v85JsgdeJXKy1Jl?=
 =?us-ascii?Q?mztSC+3C6grZnr1CXjST5Ox31o6AMTliBrHwAu6LC9676p688DkruZACkdYl?=
 =?us-ascii?Q?E8rsklHyWessFH0TxHMu1n7WxN2V03UqncKgtz5oezsarBeWtAGmurxhLHRP?=
 =?us-ascii?Q?q2WqdeVa5FLt8I/6FXo0QmCFlrpYy4geTXZB+tlqIqvp6U523xftOUqE8zgY?=
 =?us-ascii?Q?NNiYbpXGdTbBxnrpHEd39yF9/fajSXtLK1HvALvwDoFDekLOrbnr/KYn2KHp?=
 =?us-ascii?Q?O/7XQFAOPvyuVa5gKQSR/+CX9vmwAPmIwy7n/zIY+wwxnhkSoNLmUKrw4Spr?=
 =?us-ascii?Q?QBdZQtT7ZTgZWXXMrOO2+KfTC2T1ABiKS5aqi2UIIHpYSN/xCsHesOfXhd3/?=
 =?us-ascii?Q?jPTz4zqT9hJAHRZNVl8I8dZ5o74duP+85ByuI/pKLT+axzgkRfF8VnQSM6cm?=
 =?us-ascii?Q?KMnSCPcSFZNAweHl0JZeM9OYFW+YMaerQ9qA+zMy6l/XhjQAZFKnIWEE6z1g?=
 =?us-ascii?Q?lq2bN26NtUOs1SHSvguOrczkMnZdP6SwNrsTANm5MCqcEbpIk0yuVLzI5SxD?=
 =?us-ascii?Q?tvsq3nKoF/XhVOUmrJj/vuyUpTcevXH90admoUXwOpAgctXxVvxuTyZTwwOy?=
 =?us-ascii?Q?/bcJggUAtuohxIMcj5fZcq/N4iS1y8+kbgsNK7nQicpJ3Io2bWOPoqwNeKSU?=
 =?us-ascii?Q?iaewphnZf+YBBQgQZqGXvR/h061g6weOVoYb5c75hcPohpXwvpUiVM31FWfB?=
 =?us-ascii?Q?0tFL0JoCmaTjXTnWe5zidmOXkrFI2xIaB9QJBWTPXSnPTc6y9edV6pUQzkvt?=
 =?us-ascii?Q?VX1QBIowRVuwkBHd6hbZYC0HwH6BNdnCTGyd1k+DjKOpeIrxc5XRQXBsfqQF?=
 =?us-ascii?Q?rLnAOqXNJayLQLBfprHWmW05D2wMeNtpudda2qJZBhFydCMkkRB8m9Oh8YqT?=
 =?us-ascii?Q?5o5VnY5fu2n9Ak038xtFq4br0xp56BIOu/OfJj/PzMZmeplc/fF3xoumEXgR?=
 =?us-ascii?Q?l8/tZqEUb8uvSSNMcDVMNWPKVTGD6IOOzHneXTBQbxyNwTSlvy+xu7uvms/8?=
 =?us-ascii?Q?rRmVwtgVjNcTAZkH0ChyMdwDHduvgOMWcKHM9ZfnzfyBS1ztHVe5807ubvuR?=
 =?us-ascii?Q?HA8wx7JcPM1Puax9bsE7ORRrR8vyRcQphISuVhtn30Ow9qXbdFXU3H9lwNdb?=
 =?us-ascii?Q?fztGuwk2e37fFBMRBGZWdDy4nUQKJBJT031vDxJHDLtN7AECCHCRC5B/2ssG?=
 =?us-ascii?Q?dTjyiYDuCbhN5gu9NTH7Ord+J+pghsbi+gKXQy5EPz+3HSVK+GLwk2rpautJ?=
 =?us-ascii?Q?C7QW2YMwoji5ivmpmfTc4XXMj8P3eZGAbmcUIYTDJlMsFqFwK5KN/EyduGu7?=
 =?us-ascii?Q?7sCpSAuVQNcjMOYzRHY2t6f7U2FTBQzTAYdH/8ma3zamXQujb2eIwAtwZaei?=
 =?us-ascii?Q?jj1Cv7Ovp4uUTjVqH+N/MApUEjFR/H+ZB/pSiswqNYuOPw5sBvEqGjCLpDSm?=
 =?us-ascii?Q?upku6hP4ImdM3XIAtE0KScAkYuN+WQf06JFnt2sZ3pvV3L3X5Q0bpdkwNaxk?=
 =?us-ascii?Q?VvsBshjOWhKKfWyt/d08b7CblSLK5k23NK82JiluN1ngp2IOCTEn6lH/lwBD?=
 =?us-ascii?Q?5Ex68aWc1GVIVwge7I9+NJX2FY8kj2zCQehZFrQVt0iEDtyGrHvFw0un7zE+?=
 =?us-ascii?Q?8Vq4WQOsGwWEgBZzJIMboHTBjc97IvVXxFpLUbfLQnD1BFi1oJ+onEYQTNKR?=
 =?us-ascii?Q?Z0vu2HY+Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89ecbf8-c55d-440b-037d-08de58322af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 14:42:42.5487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVySVcbTSWlAD98NI9mVMC1CHwe6hzORdN8obZ80JlgFsF1r3gRzaCdpyDWqGnZ+77bC/dyE1Fxdt9XbXw5rUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7673
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-45274-lists,linux-pci=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[uma.shankar@intel.com,linux-pci@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-pci];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 480E148CD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jani Nikula <jani.nikula@linux.intel.com>
> Sent: Tuesday, January 20, 2026 7:14 PM
> To: Nilawar, Badal <badal.nilawar@intel.com>; Vivi, Rodrigo
> <rodrigo.vivi@intel.com>
> Cc: intel-xe@lists.freedesktop.org; linux-acpi@vger.kernel.org; linux-
> pci@vger.kernel.org; Gupta, Anshuman <anshuman.gupta@intel.com>;
> rafael@kernel.org; lenb@kernel.org; bhelgaas@google.com;
> ilpo.jarvinen@linux.intel.com; Gupta, Varun <varun.gupta@intel.com>;
> ville.syrjala@linux.intel.com; Shankar, Uma <uma.shankar@intel.com>; Poos=
a,
> Karthik <karthik.poosa@intel.com>; Auld, Matthew <matthew.auld@intel.com>=
;
> Anirban, Sk <sk.anirban@intel.com>; Jadav, Raag <raag.jadav@intel.com>
> Subject: Re: [PATCH v6 06/12] drm/xe/vrsr: Enable VRSR on default VGA boo=
t
> device
>=20
> On Tue, 20 Jan 2026, "Nilawar, Badal" <badal.nilawar@intel.com> wrote:
> > On 15-01-2026 20:55, Rodrigo Vivi wrote:
> >> On Thu, Jan 15, 2026 at 04:25:06PM +0200, Jani Nikula wrote:
> >>> On Tue, 13 Jan 2026, Badal Nilawar <badal.nilawar@intel.com> wrote:
> >>>> The VRSR feature is to enhance the display screen refresh
> >>>> experience when the device exits from the D3cold state. Therefore,
> >>>> apply the VRSR feature to the default VGA boot device and when a dis=
play
> is connected.
> >>> I don't understand how you get from the 1st sentence "therefore" the
> >>> 2nd sentence. Please elaborate what you're trying to do here, and why=
.
> >> On a scenario with multiple GPU, only one can use the aux power and
> >> the feature itself was mainly designed for the display case - to
> >> bring up display faster after the d3cold.
> > This is to enhance screen refresh experience of primary display.
>=20
> The way it's being added, it's just really oddly specific.
>=20
> >>
> >> But yes, the right explanation for the why needs to be here.
> > I will rephrase the explanation.
> >>
> >> Also, although unlikely, we never know what users can do out there,
> >> and perhaps we will have someone with multiple cards and display
> >> plugged in more than one?! We probably also need a global
> >> counter/flag to avoid a second one to quick in.
> >>
> >> But we definitely need to prioritize the first one with display connec=
ted.
> > At present there is no way to know which one is primary display that's
> > why check is against default_vga_device.
> >>
> >>> So we have xe_pci_probe() -> xe_pm_init() -> xe_pm_vrsr_init() ->
> >>> xe_display_connected() -> intel_display_connected(), and that's the
> >>> only path and point in time to check whether displays are connected.
> >>> If not, the decision is "not VRSR capable", which is just a weird
> >>> concusion to make. The *capability* does not depend on displays, does=
 it?
> >>>
> >>> If you boot a device without a display, and then plug in a display,
> >>> no VRSR for you?
> >> yeap, it looks like the check is in the wrong place. It needs to be
> >> checked when going to d3cold...
> >
> > Yes, VRSR will not be enabled if display is not connected at boot.
>=20
> Why? And this needs to be properly explained in the commit message. The
> current one isn't enough.
>=20
> > *capability* does not depend on display but VRSR use case is.
>=20
> Please at least don't conflate the two. Don't determine capability based =
on whether
> the conditions on the use case exist.
>=20
> Contrast with, I don't know, FBC. The platform will still have FBC capabi=
lity even if
> the conditions for enabling it aren't met.

Yes right, I think display can be plugged later after boot as well. In this=
 case also VRSR should be
enabled.  This can be handled through the display hotplug path and VRSR can=
 be enabled accordingly.

Also elaborate the reasoning so the assumptions, limitations and design cho=
ices are clear and
why certain trade offs are made are clarified.

Regards,
Uma Shankar

> BR,
> Jani.
>=20
>=20
> >
> >>> More comments inline.
> >>>
> >>>> v2: Move generic display logic to i915/display (Jani)
> >>>>
> >>>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> >>>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> >>>> ---
> >>>>   drivers/gpu/drm/i915/display/intel_display.c | 22 ++++++++++++++++=
++++
> >>>>   drivers/gpu/drm/i915/display/intel_display.h |  1 +
> >>>>   drivers/gpu/drm/xe/display/xe_display.c      |  5 +++++
> >>>>   drivers/gpu/drm/xe/display/xe_display.h      |  2 ++
> >>>>   drivers/gpu/drm/xe/xe_pm.c                   |  5 +++++
> >>>>   5 files changed, 35 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/i915/display/intel_display.c
> >>>> b/drivers/gpu/drm/i915/display/intel_display.c
> >>>> index 81b3a6692ca2..97c74272fb19 100644
> >>>> --- a/drivers/gpu/drm/i915/display/intel_display.c
> >>>> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> >>>> @@ -8426,3 +8426,25 @@ bool intel_scanout_needs_vtd_wa(struct
> intel_display *display)
> >>>>   {
> >>>>   	return IS_DISPLAY_VER(display, 6, 11) &&
> intel_display_vtd_active(display);
> >>>>   }
> >>>> +
> >>>> +bool intel_display_connected(struct intel_display *display) {
> >>>> +	struct drm_connector *list_connector;
> >>>> +	struct drm_connector_list_iter iter;
> >>>> +	bool ret =3D false;
> >>>> +
> >>>> +	mutex_lock(&display->drm->mode_config.mutex);
> >>>> +	drm_connector_list_iter_begin(display->drm, &iter);
> >>>> +
> >>>> +	drm_for_each_connector_iter(list_connector, &iter) {
> >>>> +		if (list_connector->status =3D=3D connector_status_connected) {
> >>>> +			ret =3D true;
> >>>> +			break;
> >>>> +		}
> >>>> +	}
> >>>> +
> >>>> +	drm_connector_list_iter_end(&iter);
> >>>> +	mutex_unlock(&display->drm->mode_config.mutex);
> >>>> +
> >>>> +	return ret;
> >>>> +}
> >>>> diff --git a/drivers/gpu/drm/i915/display/intel_display.h
> >>>> b/drivers/gpu/drm/i915/display/intel_display.h
> >>>> index f8e6e4e82722..20690aa59324 100644
> >>>> --- a/drivers/gpu/drm/i915/display/intel_display.h
> >>>> +++ b/drivers/gpu/drm/i915/display/intel_display.h
> >>>> @@ -560,5 +560,6 @@ bool assert_port_valid(struct intel_display
> >>>> *display, enum port port);
> >>>>
> >>>>   bool intel_scanout_needs_vtd_wa(struct intel_display *display);
> >>>>   int intel_crtc_num_joined_pipes(const struct intel_crtc_state
> >>>> *crtc_state);
> >>>> +bool intel_display_connected(struct intel_display *display);
> >>>>
> >>>>   #endif
> >>>> diff --git a/drivers/gpu/drm/xe/display/xe_display.c
> >>>> b/drivers/gpu/drm/xe/display/xe_display.c
> >>>> index f8a831b5dc7d..54ed39b257ad 100644
> >>>> --- a/drivers/gpu/drm/xe/display/xe_display.c
> >>>> +++ b/drivers/gpu/drm/xe/display/xe_display.c
> >>>> @@ -64,6 +64,11 @@ bool xe_display_driver_probe_defer(struct pci_dev
> *pdev)
> >>>>   	return intel_display_driver_probe_defer(pdev);
> >>>>   }
> >>>>
> >>>> +bool xe_display_connected(struct xe_device *xe) {
> >>>> +	return intel_display_connected(xe->display);
> >>>> +}
> >>>> +
> >>>>   /**
> >>>>    * xe_display_driver_set_hooks - Add driver flags and hooks for di=
splay
> >>>>    * @driver: DRM device driver
> >>>> diff --git a/drivers/gpu/drm/xe/display/xe_display.h
> >>>> b/drivers/gpu/drm/xe/display/xe_display.h
> >>>> index 76db95c25f7e..11d4b09808e5 100644
> >>>> --- a/drivers/gpu/drm/xe/display/xe_display.h
> >>>> +++ b/drivers/gpu/drm/xe/display/xe_display.h
> >>>> @@ -37,6 +37,7 @@ void xe_display_pm_resume(struct xe_device *xe);
> >>>>   void xe_display_pm_runtime_suspend(struct xe_device *xe);
> >>>>   void xe_display_pm_runtime_suspend_late(struct xe_device *xe);
> >>>>   void xe_display_pm_runtime_resume(struct xe_device *xe);
> >>>> +bool xe_display_connected(struct xe_device *xe);
> >>>>
> >>>>   #else
> >>>>
> >>>> @@ -67,5 +68,6 @@ static inline void
> xe_display_pm_runtime_suspend(struct xe_device *xe) {}
> >>>>   static inline void xe_display_pm_runtime_suspend_late(struct xe_de=
vice
> *xe) {}
> >>>>   static inline void xe_display_pm_runtime_resume(struct xe_device
> >>>> *xe) {}
> >>>>
> >>>> +static inline bool xe_display_connected(struct xe_device *xe) {
> >>>> +return false; }
> >>> There was a blank line before #endif. Please keep it. Ditto
> >>> throughout the series.
> >>>
> >>>>   #endif /* CONFIG_DRM_XE_DISPLAY */
> >>>>   #endif /* _XE_DISPLAY_H_ */
> >>>> diff --git a/drivers/gpu/drm/xe/xe_pm.c
> >>>> b/drivers/gpu/drm/xe/xe_pm.c index 3fe673f0f87d..e7aa876ce9e0
> >>>> 100644
> >>>> --- a/drivers/gpu/drm/xe/xe_pm.c
> >>>> +++ b/drivers/gpu/drm/xe/xe_pm.c
> >>>> @@ -9,6 +9,7 @@
> >>>>   #include <linux/fault-inject.h>
> >>>>   #include <linux/pm_runtime.h>
> >>>>   #include <linux/suspend.h>
> >>>> +#include <linux/vgaarb.h>
> >>>>
> >>>>   #include <drm/drm_managed.h>
> >>>>   #include <drm/ttm/ttm_placement.h> @@ -387,6 +388,7 @@ static int
> >>>> pci_acpi_aux_power_setup(struct xe_device *xe)
> >>>>
> >>>>   static void xe_pm_vrsr_init(struct xe_device *xe)
> >>>>   {
> >>>> +	struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
> >>>>   	int ret;
> >>>>
> >>>>   	if (!xe->info.has_vrsr)
> >>>> @@ -395,6 +397,9 @@ static void xe_pm_vrsr_init(struct xe_device *xe=
)
> >>>>   	if (!xe_pm_vrsr_capable(xe))
> >>>>   		return;
> >>>>
> >>>> +	if (pdev !=3D vga_default_device() || !xe_display_connected(xe))
> >>> Simply considering the places in the kernel that call
> >>> vga_default_device(), this just doesn't feel right.
> >> I also don't understand why to check this vga default device...
> >
> > As previously mentioned, a check for the default VGA device was added
> > to determine if this is the primary display.
> >
> > Thanks,
> > Badal
> >
> >>
> >>>
> >>> BR,
> >>> Jani.
> >>>
> >>>
> >>>> +		return;
> >>>> +
> >>>>   	/*
> >>>>   	 * If the VRSR initialization fails, the device will proceed with=
 the regular
> >>>>   	 * D3cold flow
> >>> --
> >>> Jani Nikula, Intel
>=20
> --
> Jani Nikula, Intel

