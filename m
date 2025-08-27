Return-Path: <linux-pci+bounces-34856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D0B378DF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32F17C1C51
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1D330E0CC;
	Wed, 27 Aug 2025 03:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGVrsicK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C463630DEAB
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266704; cv=fail; b=tFQ1yli7kA+so93R8RyxeZmZ5qoAvrH7EPlDwSFAacsLo2V5oOmKHqCVWKt3iAAYWBTRnf7kX/1n5lJZE3kexp3HEmGVYqaoSAk+gehlw1Ruoa8yB1n6dZQvTseyBTWaKyAdygvYrsa9E3xm5nXPP4McxwHRPcDABN5T5XCDFpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266704; c=relaxed/simple;
	bh=hEsCT50oyhQ1euTNvL4ie3qMdgpPt3qeNjVUvlgIWgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c5hqM7Thn2etvAvLJteDRxU1DpO3YVHqcXJ+pNCjb4aRGb95WX98WgYKb/2yzQf7r/DwoomcPeFRqTiKqtQZvwH8Yhc3bfiHI+vcUIt/aqiZsQWr4GI5oGMSW3QV64VabL/04JENi1pytcExuxoT9APTRgXaUzXbZ3CpYsP7bKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGVrsicK; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266703; x=1787802703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hEsCT50oyhQ1euTNvL4ie3qMdgpPt3qeNjVUvlgIWgc=;
  b=oGVrsicK6mNzgBf07qawLGSAeaP91eoL+qc7/FOi4ONw4reTyAab85AZ
   Y/dT3cm9++s7BAbaR3V7ci52tr3Fmo3RIv2pUs65FRRTMlCliTQVp65s7
   BJUJwg3pX9ybEK91Ra1aE2jgxDYEw0NUMPQ9dg8PscT+OZVvHW9HNCVvW
   zgJ3iXlww44KhwYPMlGOFzucdRjsPR43AzY/9yze7Yy0oWSm7YuOw610E
   hnF8u3mfTWi15HMPI2M705JN5ZbizTpTPNIQG0N5Jm3WBxggSHZuDTQFo
   iFXNrwDrqJupReH2IyoIRfaph40ZHro9z9ICXEPp+TgMOgSB/zirvqSQT
   Q==;
X-CSE-ConnectionGUID: QH8KqUrlTtOcrdi6tAeJUg==
X-CSE-MsgGUID: naYLJpcFTESKv7dyn9EBsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62159184"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62159184"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:42 -0700
X-CSE-ConnectionGUID: lOnPS6HdRB+M2v0UoQMTBw==
X-CSE-MsgGUID: OyMpVUdWSiqcz6BvGkigAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169685143"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:51:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.46)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz+908VuUdIlxY0g5WLML/WplkbTG4Ei4MiJxcfn5c71A5QC7/D0SgBPKbbFRo6fdiCJKjKJ7HDYbo4VR9936TM4PCss0pzNiMGNk0chpcqBfNmPxSe7KaT5rdeKNQdymnZqwK+pSz/RKbVa5TJIXvqrH+FehAPfYmRKgq5DeRzSIVNam0FiLcGBzXZUYkjLkUuIlD0iAZawq2+uZOnc3S4J/E3GRazDipt1ba3q/Vspf7bz5cIf0g2MXCe4aQN/ncaBZZHnm3+ii8TV+hKT4ZQWB3W2m2cv5Rut12eorXdRNL6vAE9Jw+7GAc/m2HLhYx4EkEdlYjR7do5OFun3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CB2RO8EKGmzXMrkKB+iSWZP6aZPjmdP9+1jBSoG8GMo=;
 b=vufeg7ikMTMnorH15saLa7NsCVmjmz/DQfKemCp2QzXW93v6JdSMxzqpIVjNkzbWGfyr6YZxMCyuG+mfFd0ntxxtfAsiM/V24rYbbOWQWQ/93vNe7sGz0Pi7N8sDYJIpTiU1h4juTQGC5BAZexOhwDu+dWDO+nGXGjSMoi3P/RgcSxSvFRwAIrTb1eRsV4UFO7z2RPi114Zs9NksNfKyY7PY6tnaHtx3cgjyA8gVyyMXI1dgs/R8f1ZopYqdUlDgJqdgQEsdVCdzp35oOoJREMvCrY5uyEpsDlN7B1S7C2CXA9u8ZTb++orKsWm6wa7SwRVE9TheYMbWdq8PLad60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:51:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:51:37 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 10/10] samples/devsec: Add sample IDE establishment
Date: Tue, 26 Aug 2025 20:51:26 -0700
Message-ID: <20250827035126.1356683-11-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035126.1356683-1-dan.j.williams@intel.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: b40815bc-bc3f-468a-ec4e-08dde51d0634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wUJtlN59MbG31cmWz0nc5S6EoxhnENxFx1K32PGChYelV+bgJeNGJ1hANOCA?=
 =?us-ascii?Q?12DHOt5NZV8PRMQZf6E4cfhGpM2Hys8YKVuuODNZ6ugMhoRceFPVoieZ/k3U?=
 =?us-ascii?Q?JQbQoqNRVtBrsvOVyjz7MFbYEwV9yfr1kvQmygrTXOe7ecJ5T4e9EVQDjf2m?=
 =?us-ascii?Q?7srpggdb7xRQR1ffVTMLmsRQe7/ohocLWP2flenwccsLovj4bxlYZiiyBfSU?=
 =?us-ascii?Q?K04fBqtdumF1TP39uNn69nJ+SYFYnzMoG95VdVhspAOXY3PJfxX7PwfTpyMN?=
 =?us-ascii?Q?0xeqLn+E/8s/zuj+sXfX/QMITK33Ayi3t+AcnkiNHH/yFhr4GdRaEJ+uxyui?=
 =?us-ascii?Q?ZboAJ28VAK0e1qjmtl3FC+5cQqPXUPS45yu13FiyHrQeSIon3pePEmij2OOs?=
 =?us-ascii?Q?AZwE2tB5ylrYpZgNpfLn73wABRCwFRi0VCedrohL6vkT4uumNqw6YuPae8+H?=
 =?us-ascii?Q?NXzw+D24Ip50pYMjyBgX4NjZXJ1JPbIolvteNcnUH1vjO2eYqfphMMmWLrfG?=
 =?us-ascii?Q?B8EJFcMA2nVlbWbKHG56KjJ/AEYjw6+iOM9tqjh4mEvD3lf3vYX1egizK/T/?=
 =?us-ascii?Q?zxu5AEYu1By6E8zmamIPzvhHzzVhCCSBZujy4uxK+XGtGmTca41eqsjW1ata?=
 =?us-ascii?Q?Xw7t3GGN6fHpuPns0HvdkJP9M13ZUcfXTOMFz9iL4Ga1PSykVjq2G5rRFafR?=
 =?us-ascii?Q?JBdRBRpfxLFwK9W1iuYwqvCt4HeO5JASovhkGy3tXPBineF/suHlsLJJTsCg?=
 =?us-ascii?Q?sOGrUqrgaegcTL2kOujev7+cbqhoW/onprs/TwtyYkyUoGNdbGwUpA8XaIlo?=
 =?us-ascii?Q?VVUstiENJMmaoLVNAOBUueQqecRRbawlE8lUeQ8opbZN8uSikp7EznUmtafm?=
 =?us-ascii?Q?HH5JvNNSLDHkqG6FT7k+H1OvTcbziejpZoO0tWjK9HSBLW/StAvD5jdMXWIS?=
 =?us-ascii?Q?0qh8YnedGVJ7aqkBND+nMo5Sj5mRkg7sh22MoffCr7Hg4Qp5AQYNdOEAAvmr?=
 =?us-ascii?Q?+SS4aHD1A1i1IAOuhgMza6W7wxOOEsXUXNsJfO7EfMRDT1aazZqTotkcVYq0?=
 =?us-ascii?Q?8pMQQOxImYqM4lDXk2qYpixVWcaQ9Zyhhh903SkbvCysgZPa43z1hd8MFnQn?=
 =?us-ascii?Q?oa/BchO7LrrmyENUWL9my1ayC8OBKLeGvyY1XGn68GKfUnvysx1uFROCuxwT?=
 =?us-ascii?Q?enLolz2vWbXAPlj8TLRCMh5C89Syx8s6iSvv+zyWAIkAvl/KKnpCJBlFqSLf?=
 =?us-ascii?Q?q+5ctCfBMjSOPmyLpBimgfWieDdkzAvkz3HCrxqZmO8gjTo3CfNp7x7G9wxp?=
 =?us-ascii?Q?/7uP73EDYXbPfG1A7RxEWHfPKonpWMWLEoUxDKd7+GYdYo4HL/pFDniMqXId?=
 =?us-ascii?Q?/Zj+81h0xRBJKGDk70RMNn6hwEBj687BvXpdhgCYxIURVkSPC1gmJ/BonWCI?=
 =?us-ascii?Q?VDbdd1q8Mqc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qVFccYVHsQYOa6ayoyyPT0KEAZ81UtVD1/Cn1WiqQ4b4NKXboTJhnV7kGAOE?=
 =?us-ascii?Q?BpbIVO40TMymBOnzCRdfqREgrWAeagVf5iKEctTcou6NfeIDnQTiEeBlBcxs?=
 =?us-ascii?Q?0y/czafAEFqrrVioiwRDE8MHcpp2xAklgOn/+YzN+NybLpvHIfAe/VmQH2Fl?=
 =?us-ascii?Q?OuZu42ftSN3Z1pI7yl1VXtyGmd2oPY6e9+s7u1uwoL5p8tWDaSTMEa0sREbL?=
 =?us-ascii?Q?2tqb4znBpeAkXIH4JIRy5MA3A8/Tdk5i44qKhnqy8JO9ai0Q1C6bwI8tCJMv?=
 =?us-ascii?Q?lKyzLDg2ygpMxHzaEzXvAoKSg2ixFYRMa9RWBg8uf6W8M39uQpjkzTmIHJ4e?=
 =?us-ascii?Q?fevi6nrpJ/Ty1ijIjsWVybkd6xhgQASyy0oOcdPnTSzDqFQj89OCXg/KQCop?=
 =?us-ascii?Q?KxfpYZkwLoAKzPpt7/EUVDuQf0U6r4mhk6AopNrqNNn33esxo+LN+DDQWYlk?=
 =?us-ascii?Q?k0ZNBDVxRQCPnjCskwvs6avJ83tYu5hGmWBTUOO4UxASNeBKyn9aWNZo4AQe?=
 =?us-ascii?Q?CZl5JxFFUPikrMcWrZJ3C630Qd9mpMQShxuHqv+QYVoCtlhHF3BAhmVYWXC1?=
 =?us-ascii?Q?8L2oEjl7HqwaU8jO8/b/kaHzZ+pompCWmvmNbOahcKn9riMdJW9TQVNP7tht?=
 =?us-ascii?Q?TElcx1wJDU2AdyhUwkxooYE7BWSiFuIdvepEI+JEqZ/yArzglpZUzRHQfw41?=
 =?us-ascii?Q?IruTuD9HqYFPv3eFLh9JRsCyaiCHsrO/HatCO98DL1h53tDjRBTvDSvC7PX6?=
 =?us-ascii?Q?zEi4S8mWRn3aPpnRpC83TrNfWxAkzTPzYIvBCzNYH7b+V4TyuaSMYSIM6a/e?=
 =?us-ascii?Q?siO3rjOB07WdACZq4FF0AhI/xpG+GWaLhG5roQb+A0tHKWyUj4bxkZ6TBM4P?=
 =?us-ascii?Q?MZ6CODaIHMlmjSaST5k5KhN7LTVl4KkY0+iArkEDaVYatKOfOhKGa+EMdflA?=
 =?us-ascii?Q?yBOGC+Xko1I7fbLsBn7+rAtoBAomcuT2790HA54ia5wwNjW/n66K0juilxEL?=
 =?us-ascii?Q?V48b1A761hF1r/UrT5qGg3ii9+KsqPCnrusU+c5k5gmujLZ107yavBjzE90Q?=
 =?us-ascii?Q?0xIQWe5JbP5YNOpr80XdRPTJYl8TZ+faKdwy2OQ5D1EbH+RNms0Vn5fUzc4n?=
 =?us-ascii?Q?HLM+YCawpTR3MVa8zHVNcSzjINkPlUiZAIdnHjGNMwro8Rx4+ge1yc3gxpTP?=
 =?us-ascii?Q?ZSM0Cq1uhcPiVbd/kcn6b84UqxssHJGgcTnakWt5m7a7haJfyFSndUtND0C0?=
 =?us-ascii?Q?l3jpEaBgPn4ACxlwMRece5A5isrTgK/AaSV+983qTmyYREyPHMlVCZPFP5wV?=
 =?us-ascii?Q?iNJgVLFOnJgsVnXkKTGew7cU8X2j3MrToPtDsb5D/ApjtoYdBtSOMCtLjP70?=
 =?us-ascii?Q?agU8jIr2Vj6tWNUaWyHA7wFkRUdDPhVKtUmV2RMcgYy2k3quQaha4UY5GX21?=
 =?us-ascii?Q?ZHTl9rmg2xbwbEnsHdfKRJnxO1fJPXRfFLfnwGtM8fTumIYYvAUavWVWlezJ?=
 =?us-ascii?Q?ewYl+psr+bCvgRpboHSiXbwWnC+8Z/pXz2ifYN/dp8oNQqFuoHb8tga1ne1q?=
 =?us-ascii?Q?yT+WNZVjHwZcaEpICM6hjpfAXyAys6w/dfjv7fXiMMgcoZ5X35pqdVjJIoK/?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b40815bc-bc3f-468a-ec4e-08dde51d0634
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:51:37.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsJxQC1JECjJI1pon6UNm2MSnLKBfwjKToHh2kk1ijFLcc4LRYvpsbCGkJW2ujlw/lzggFKLiRZoMQIDIfAobpQzVw9SHhod04de5bWt8T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

Exercise common setup and teardown flows for a sample platform TSM
driver that implements the TSM 'connect' and 'disconnect' flows.

This is both a template for platform specific implementations and a
simple integration test for the PCI core infrastructure + ABI.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 samples/devsec/bus.c      |  3 ++
 samples/devsec/link_tsm.c | 70 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
index 07cf4ce82ceb..37a62c1cbba4 100644
--- a/samples/devsec/bus.c
+++ b/samples/devsec/bus.c
@@ -13,6 +13,7 @@
 #include "devsec.h"
 
 #define NR_DEVSEC_BUSES 1
+#define NR_PLATFORM_STREAMS 4
 #define NR_PORT_STREAMS 1
 #define NR_ADDR_ASSOC 1
 
@@ -693,6 +694,7 @@ static int __init devsec_bus_probe(struct faux_device *fdev)
 	hb->dev.parent = dev;
 	hb->sysdata = sd;
 	hb->ops = &devsec_ops;
+	pci_ide_init_nr_streams(hb, NR_PLATFORM_STREAMS);
 
 	rc = pci_scan_root_bus_bridge(hb);
 	if (rc)
@@ -730,5 +732,6 @@ static void __exit devsec_bus_exit(void)
 }
 module_exit(devsec_bus_exit);
 
+MODULE_IMPORT_NS("PCI_IDE");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Device Security Sample Infrastructure: TDISP Device Emulation");
diff --git a/samples/devsec/link_tsm.c b/samples/devsec/link_tsm.c
index 46c9343815e3..1fef2822b38d 100644
--- a/samples/devsec/link_tsm.c
+++ b/samples/devsec/link_tsm.c
@@ -4,6 +4,7 @@
 #define dev_fmt(fmt) "devsec: " fmt
 #include <linux/device/faux.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/tsm.h>
@@ -92,6 +93,23 @@ static void devsec_link_tsm_pci_remove(struct pci_tsm *tsm)
 	}
 }
 
+/* protected by tsm_ops lock */
+static DECLARE_BITMAP(devsec_stream_ids, NR_TSM_STREAMS);
+static struct pci_ide *devsec_streams[NR_TSM_STREAMS];
+
+static unsigned long *alloc_devsec_stream_id(unsigned long *stream_id)
+{
+	unsigned long id;
+
+	id = find_first_zero_bit(devsec_stream_ids, NR_TSM_STREAMS);
+	if (id == NR_TSM_STREAMS)
+		return NULL;
+	set_bit(id, devsec_stream_ids);
+	*stream_id = id;
+	return stream_id;
+}
+DEFINE_FREE(free_devsec_stream, unsigned long *, if (_T) clear_bit(*_T, devsec_stream_ids))
+
 /*
  * Reference consumer for a TSM driver "connect" operation callback. The
  * low-level TSM driver understands details about the platform the PCI
@@ -116,11 +134,61 @@ static void devsec_link_tsm_pci_remove(struct pci_tsm *tsm)
  */
 static int devsec_link_tsm_connect(struct pci_dev *pdev)
 {
-	return -ENXIO;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	unsigned long __stream_id;
+	int rc;
+
+	unsigned long *stream_id __free(free_devsec_stream) =
+		alloc_devsec_stream_id(&__stream_id);
+	if (!stream_id)
+		return -EBUSY;
+
+	struct pci_ide *ide __free(pci_ide_stream_release) =
+		pci_ide_stream_alloc(pdev);
+	if (!ide)
+		return -ENOMEM;
+
+	ide->stream_id = *stream_id;
+	rc = pci_ide_stream_register(ide);
+	if (rc)
+		return rc;
+
+	pci_ide_stream_setup(pdev, ide);
+	pci_ide_stream_setup(rp, ide);
+
+	rc = tsm_ide_stream_register(ide);
+	if (rc)
+		return rc;
+
+	/*
+	 * Model a TSM that handled enabling the stream at
+	 * tsm_ide_stream_register() time
+	 */
+	rc = pci_ide_stream_enable(pdev, ide);
+	if (rc)
+		return rc;
+
+	devsec_streams[*no_free_ptr(stream_id)] = no_free_ptr(ide);
+
+	return 0;
 }
 
 static void devsec_link_tsm_disconnect(struct pci_dev *pdev)
 {
+	struct pci_ide *ide;
+	unsigned long i;
+
+	for_each_set_bit(i, devsec_stream_ids, NR_TSM_STREAMS)
+		if (devsec_streams[i]->pdev == pdev)
+			break;
+
+	if (i >= NR_TSM_STREAMS)
+		return;
+
+	ide = devsec_streams[i];
+	devsec_streams[i] = NULL;
+	pci_ide_stream_release(ide);
+	clear_bit(i, devsec_stream_ids);
 }
 
 static struct pci_tsm_ops devsec_link_pci_ops = {
-- 
2.50.1


