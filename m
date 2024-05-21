Return-Path: <linux-pci+bounces-7731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBF38CB562
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 23:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10231C21693
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 21:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89C556771;
	Tue, 21 May 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIWdenD/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1153816;
	Tue, 21 May 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716326658; cv=fail; b=ig2LX3ubxo/iiips1PzZlezacz5vkw6IU4Bs2tgVjLt/Y3DwC1oqqp+DB8pfiszf2DwVHionGgw+Owa+RflKt9uGwgTmqepGX/xOQM7TKAReyrEHSo1sui7u/+dSgzrH3j7DhNfTkeraqg9WwMOShNVpCAPbRS/+h12IQ2SQ6Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716326658; c=relaxed/simple;
	bh=krA19H8HWJAZjZmJp1l801fQ0nKN7W4JjEvw1y4Al4Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ni6b2zSC3n2KaC8KyZoJn86LT8Cs9NR9WfAmozbtSuMrOh3D3Rx2B1Rdq+FRj3fksUUqOlsddigIPfyFY9oQG40EknSY7BPCE7ELYB8EhoWAb70BGOgJxu7wYLhtLcyOB6J5bymE7wzmoFmWXQyp5avcfuB1uw/5o5hkjqAUo4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIWdenD/; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716326656; x=1747862656;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=krA19H8HWJAZjZmJp1l801fQ0nKN7W4JjEvw1y4Al4Q=;
  b=bIWdenD/l1/e0x0JwD6NPddb2Wn94ZSOYi1ThygGBjsJzZyBp/L9jV+S
   WpwjhIts4iweRJti15nXX0cTFH6yPQyjBcnV3i52uWYLbYMw/ruAeD1df
   LBosPgZLm7C2QWtj8tjczjsovnHG9SsaagFOFzCyDKT1ifsa2K5OKO4PM
   9+WPK906qbMiSHQFT1B2keaw8h+V23YeJn2MQPniGQT6xSuTj4dJnudF9
   524HMFJnOr8ASTy9BkzM2rM4MKFIl1CquRiEvEo/mukw4N5ndl1y4joQa
   plJYXVSZKAsJQxA9RxCtfP5pYt/7/Q6MDtP8NrOmM52NkfOZRHBeW9DnR
   g==;
X-CSE-ConnectionGUID: UfK+b3lEQo6huLMX0grftw==
X-CSE-MsgGUID: VXKVgV1MT6ewNqqQtGC3dg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12387812"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12387812"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 14:24:16 -0700
X-CSE-ConnectionGUID: LGGQyJYNTz67Pp46s9muQQ==
X-CSE-MsgGUID: eaeqPJ81StqugQgczoddhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33112025"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 14:24:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 14:24:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 14:24:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 14:24:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 14:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4NRR/FC5AytE7jIUueodfs9RIEhcaXYDZEpqzUF1rKgFdQ6VSsF6cjZkE6RLFu9xXPrxzmSU6czDbDPhpox2AhUpxzssssn+Er0efQKSmET8p7jnf6T28VznwnKkCrxE2d+v0XtwkgseX5Heu95yo/gdrcVXezfz4lAo/8tZhs+2D/rnWspPxZbmFVqerUVg7IwuEp9wMyVORhXI271dQBTcY1hbNYBGUMPhz6XXeBgKGsBHI8l13RYROFh9oJ0jPXGF7MaG7LpDIf+YQpNoInENU3/UlTBpGVuVgc2oX39GwA9yoeMxQ8Q6B8jBZix+qjZadE8fCPNUpqe2gQgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQBDq115WQpq0IF8UqS2gJQhNmGOau6g9VBzYaG1N6Q=;
 b=IMxsWJcy0c64BpF3Eog5XSBQ4665BhYC0FmQKtWu7EFYqQkDpNU9PeE3jymAsJA744YeyFwZl1toT7UIs4++os+EI9C/DmjVQ5MMoc3Sd7XYZUlfqRXkrqCvPZ7xzpA3xKn+qDQ+fNJmm3WF03UD7shN0vo1j6yUD/D9CnxEZJwwFzcPCiHf3ESadBYpfz/Et95TEbXZGhS1dZ3PjZ6AB4wBaLYZ3fuNMHuCNi21RtMB4uuivrwcvj5SjiXuXHI+VlSyHU1zr5bGB6Le+cLU7WjQ/cAO49RAgBR+k6tO5qhoX8FcQ9s1HRMFmUPduFafl2uvh3WgEPA4r3fiauZ6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7918.namprd11.prod.outlook.com (2603:10b6:208:3ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 21:23:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 21:23:58 +0000
Date: Tue, 21 May 2024 14:23:56 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Vikram Sethi <vsethi@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
	Vishal Aslot <os.vaslot@gmail.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>
CC: "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	Vikram Sethi <vikramsethi@gmail.com>
Subject: RE: [PATCH v2 2/3] PCI: Create new reset method to force SBR for CXL
Message-ID: <664d10ebeb537_e8be29494@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <E1AAAE3F-E059-4C57-BC23-6B436A39430A@gmail.com>
 <664ce3e1a25fe_e8be29431@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CY5PR12MB60607B123B05AF10568ED5EDBDEA2@CY5PR12MB6060.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY5PR12MB60607B123B05AF10568ED5EDBDEA2@CY5PR12MB6060.namprd12.prod.outlook.com>
X-ClientProxiedBy: MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a679fcd-b8e5-45f0-ed05-08dc79dc53d2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emdhSmgvU0ZOMHZkSnhpUXlTRGhmOHZWZndnOFB6dmpoN1hOY0tDNHRxbEFi?=
 =?utf-8?B?NXBiM1o5N0VGVUYxbkh4cTFWRWRoSGQ4a3NxdlVPTUsrNkRKLy9MTlhNcXhr?=
 =?utf-8?B?YmZoa0llVHFPLzRNZTIrdDh2Tzh3VDdDQkdDMGZER1c4QllNdHNrRXJ0TXox?=
 =?utf-8?B?eDJ4eXdIQWhNYjIxbXN3bkw3YWNtZmR5VDBYMjFPWWpKNkMvRmZsNXhzT0tQ?=
 =?utf-8?B?M3ExeDYyQTJuTCtaZU11T1c5cDAvT01GamRkZnA5cmJOZDJ4N2tRVGZjakNn?=
 =?utf-8?B?Z2xGdkwyR0lzSWNzazVhRzVHMFpWaTdqRk5OK2ovRFpWd3pHMGF5clhIZG4r?=
 =?utf-8?B?b3ArVURkd1dSaVNWa1NINVBIQzhxdlRFWkhBSUU3Tm1sRTdJU2sxV3JHK1dE?=
 =?utf-8?B?TjdBakU2TzRTMEc1eVpPY2oyaC8xOGJ2dXJZQnU5MjBuZ0NFSFNwYmkrU3Uv?=
 =?utf-8?B?TThwYUN3SXN5eWJreENzMEdDSDJCZnA2dFNrOEhxbXZkcVhWU0dPT0trelJO?=
 =?utf-8?B?WVc2MHluQnlReEJabFhER25HS3B4QzdyRDNzRThGVEhReDMwSFpObHRNYy9u?=
 =?utf-8?B?akxTMG16Wm5rTkQxdjRYVkNXMmdvVFFFU1RsMDFCK0lnM3NyN3hWTEdUaW4r?=
 =?utf-8?B?dnFPNG10UWZEZ0p2OWdSTjdEV2lEUDU0MmxIUURGSmIxTHRFN0xIK3djc0FU?=
 =?utf-8?B?WjZZM3FzeXhHWWhBL2x0dWZpS0tOL1cwM0Z5ZFBEdVROODE5NWRiYkwyNFdF?=
 =?utf-8?B?VjZSSmJCQldBeituRldXZDRKRkpwSGU2U1dYSjh0MVBoMHc4bTlrd3AvbXJ2?=
 =?utf-8?B?ODhRMGJQckpSanduS3k2VXBXZERHUEZjdUgvOXJLUzd0YzZCc21FbEpRekJF?=
 =?utf-8?B?ZXFZTHR3TlBQYmQ1ZHJKaFRTWElUdkJtYTQ1Y0xzd29vakxIb29SeGtBZTk4?=
 =?utf-8?B?MStJdHJTTDlmMkFzVEpyd1RGQ1ViVWpPcG1nVXlNblErcllLdFcxcXg2V3pT?=
 =?utf-8?B?azdxWERFcHF0ZWJ1eTFaeE5yeVBOZ1p3YWZWL1hYaUk1ZTJzeEcwb2tRV1Rz?=
 =?utf-8?B?cTloVVBUcUVkdXVJMWRacnNGUWVzYllGaU1Hamt2NytjL3dHampwcEcvN2NH?=
 =?utf-8?B?bmdvcm4reDRUY3A1UVlaV1YxeUF3Q2JpTWZsSE5yL09sejJWVTI2OCtKUE9X?=
 =?utf-8?B?ajVOazR5NCtlOWdFSGErZ01mY3l4Zm1jdkE5UlpERkEvdVNRVW55aVFZazdH?=
 =?utf-8?B?Y2UzRExPUFJxNW9Bb0hVVTZDTzhiTll5WnJsbVZrcXBCNHRPd2EyQnMrZEJa?=
 =?utf-8?B?dHlyajhwNXMwZ0VTcWZPNmJGNWMvVjNEM2pta0RqZ1loaXVBckg2Z09WQmJ1?=
 =?utf-8?B?anNGWjlDZlJ3OHI1YWVlZ1BDOUh0aDZJY3B2TEFOR0pkTXpzTmdML0tITDAw?=
 =?utf-8?B?cDVzZTBZSmkzWnJ1NjhBcmRNTG8wYXVyQ21CZHBZOVc3ak5Pci9zWmEzbkZp?=
 =?utf-8?B?NXh0Z2V1ckoyNDkvUndQSkhCKzVRdjJ4Tit4QjRoUnJOZDN4dmZaK0JXdlhS?=
 =?utf-8?B?di8zYkVUWmYxUnE1VnhPcDVkR1krNUp2dlN1VURrcXJmUXhzc3J1Slpyb3c0?=
 =?utf-8?B?UzM2Nkh6bUZZQlhtMVhhRFJ4TmZyUk9ZSm9za0F1aVRMTFphblM0a3JmYkJG?=
 =?utf-8?B?YXlwV1FwR1pOa0k3eUFXdXRBNWozWXZkNzFpM2ZSd3FHYzlpVFVOcnZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUZodjNVVWNEdCt2RlN4VVg5WWVGcHFTWmxkTWpsWW9mRkZZRCt6MXVJcDhD?=
 =?utf-8?B?TWY2S1kyUUt5bElkSG1FQTRtcWN1RzJid29vdDFqL0VseWFWMGNRVDZrM1JY?=
 =?utf-8?B?Nm9XMzlBak9tMk15Y1NaVEV3eWtRMmlvSUVTSHV5elh0bCtMNjZsWjdlRzlM?=
 =?utf-8?B?YnJvVVpmNEdWSnp2dzJkY3V6NGowUk5ZNHpIMm9KRW1RVlU3VzJqVjVJNFdF?=
 =?utf-8?B?amxLcVlYUVRLK25WbksrUW1oK1BhcVo4WnFBZ3ExWkgyWVpyZFBxdjhFYVlw?=
 =?utf-8?B?VjJCSmpCNmg4RTBSanREeGo1NytBdVB1QjU2V0FUdWpYZmo1Mk5RQThaN09I?=
 =?utf-8?B?MmZXbmhMdXN2dGZRYm1sbUpzMkl4MmZub0pLTnFoUWlROERrZlU5RXd6Y0hC?=
 =?utf-8?B?QkFhdktEMmJVbkQvZm54bmVkTTVFWGJiL2VsOGJtdXN5WkRad2Q5WUZmcjRY?=
 =?utf-8?B?RkpyUDRIWWtrcCtRYUV1aWtCUHhvR1I0WmlndkplejhGU0tNdFByR3pFM0l3?=
 =?utf-8?B?b24yZ3FldzFFZUNUQzdKL1VDU1hucmJOMEF4RXFoU2VwWWVhOXZNOTBtdkJ0?=
 =?utf-8?B?blYwTUhrTGxXUm5uc05CMTh4cVhYMTZ1TVBjdyttTWdqLzRjSCtGanpvZ0Mw?=
 =?utf-8?B?MVVIWnp4MndZYXk0d1FSTEtGTVdlYlRjNkFFQlpad2tIUVgrcEZpRGRMOUpF?=
 =?utf-8?B?akNCS1lzbFBVazdhL09WR1B1QmhteDJzdTZJZkhVc296elpyVjRGdjZPUkpI?=
 =?utf-8?B?VThXQUo5MXE2NE9FNUluMXcyQ1cvRUsrQXBObG1YcEh3T2Y1WnZ5dnNIVTRv?=
 =?utf-8?B?WXh5YzRjNHhwdFRNZnJnT0t3L1BBK3JEUElOenRMTXRmeEFMbUlyaUV5S21p?=
 =?utf-8?B?Y2IrRGRkZHJkaUdVR0RzeU42czdMeGd3SjlKU1BZMzNKYm9OMFBJN2pXY0V0?=
 =?utf-8?B?b096YkdQR0dLQ0tVTUNUby80L201cHhneDhkOVFPelBHMFpPRFlNU3kwYXNm?=
 =?utf-8?B?RUVwVGgwaHNsZklCTmFoV1E3VkdRUno0WDFKZmh3QTRQM0VQVUxoNU1oQXgw?=
 =?utf-8?B?WFdrVFRkaThGOXZJVVVtY29XYm1VeVF1SElKMTlIZHQwdmt6VUZtTkFoNVRF?=
 =?utf-8?B?K05zTlBncER1MG5QeEtCTG1OdFZmT3FDL1l5dmp4ZnFqUVRJZDBDV2FzTkpG?=
 =?utf-8?B?VU1NNXo2ODFZcU5RZTBGVGNIRUFHVExqQU4rZEhPOHhMTEh3SlRFc2pRUUM3?=
 =?utf-8?B?Z2EvQ1lJQW1NL2ZXaWd6ZmlweG5TSTM1bmEyMWdDT094NGo4OVRBR3RDTmow?=
 =?utf-8?B?MU1EbEZ0cHduZmo3WTFIUGJmWWw1VGFZU2xPVThWOXhQU29mRFc5M0EzQUF1?=
 =?utf-8?B?YzV0bWw2eVV2SCtBaGhjWGN3MlBuQk8wNEFmUjdxQVBScytiRStuWWNLbTJz?=
 =?utf-8?B?aDJFZEdMQjJ3NTJ2Z2dtRVRrVThZcFB0VElWb01sOFkrSDdJMDNFUVI5ZEZQ?=
 =?utf-8?B?bDhjclNUVEpFSHBBTlJqQzR2U0xmU1g3bms5NGZxeXhDQVZCNVFVU2k0Sk9M?=
 =?utf-8?B?bHB2VlJqTjE4YVdhaTl2bFdBOFUyVjlJNGZlTDZxWGtUUkVPMzYxa0RrM0o2?=
 =?utf-8?B?WGtRbHhqYkFhNXFGT0JISG55WDNtQnUralVHNXdmTVdORlBJZXZ4TGFLL0lm?=
 =?utf-8?B?ODNjRXlib0VzRXY5aHZKQXdGVTU5ell6am5QRUJodm9Ya2g2NHZkdWZIQjU4?=
 =?utf-8?B?anc1QjQzQWxFRHFOb0tOeTBhbkY1Vkxnalh0cit1RjRCeHV6N1NxYVNCOG5u?=
 =?utf-8?B?ekF3Q05hVFQ3a2lnTEgrQTFCKzRJdDdtQWk4eW9ZdlFLQTN4RlQ0RE9xNUxL?=
 =?utf-8?B?N3FycHhtK2UxNEVSd0ZiMjQyT2dBdFNLZ0ZUT1NXU0RIN1QwZHUxVTBCakh2?=
 =?utf-8?B?MFhHZVR5ckZUUXJLTkMvT0h1c1VTdnZjTnJMUlZMSzdKbnR2QVlZVmZvdncx?=
 =?utf-8?B?TU9UVTBGSUw4MFUvK2pRWkUveFBmZVZRN0Z5M1BVWUc0SUVlRGtnM0dyeFZj?=
 =?utf-8?B?T2hVS2o0UTUwS1RONHQrRzJ5dFVmcFpLWXJyakVyZVdmYjF1MDNQK0dHYVZV?=
 =?utf-8?B?czF2c1NtUklpWlE1NGVGWXRNOGJrSk9jL29aamQzRXd5UnBVdVVXajRscFlw?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a679fcd-b8e5-45f0-ed05-08dc79dc53d2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 21:23:58.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unllyMbAg3JKK+XsprFd4gV1nsVwblVxc74B0dULdxwYBv8nJ61YoOctlUsXUrY9U/OibSxLDZXk5BjS6rfa1ERUtEqw8auK4Ct2FOo7Dw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7918
X-OriginatorOrg: intel.com

Vikram Sethi wrote:
> Hi Dan,
> 
> > Vishal Aslot wrote:
> > > Hi,
> > >
> > > For T2 and T3 persistent memory devices, wouldn’t we also need a way
> > > to trigger device cache flush and then disable out of
> > > cxl_reest_bus_function()?
> > >
> > > CXL Spec 3.1 (Aug ’23), Section 9.3 which refers to system reset flow
> > > has RESETPREP VDMs to trigger device cache flush, put memory in safe
> > > state, etc. These devices would benefit from this in case of SBR as
> > > well, but it is root port specific so may be an ACPI method could be
> > > involved out of cxl_reset_bus_function()?
> > 
> > In short, no, OS initiated device-cache-flush is not indicated, nor possible (GPF
> > has no mechanism for system-software trigger) for this case.
> > 
> > Specifically that section states:
> > 
> > "...it is expected that the CXL devices are already in an Inactive State with their
> > contexts flushed to the system memory or CXL-attached memory before the
> > platform reset flow is triggered"
> > 
> > ...so if reset is triggered while the device is mapped and active then the
> > administrator gets to keep all the pieces. This SBR enabling is all about making
> > sure the kernel log reflects when the administrator messed up and triggered
> > reset while the device had active decoders.
> 
> For a .cache capable device, shouldn't the kernel be writing to the
> device CXL Control2 register " Initiate cache writeback and
> Invalidation", as part of the "OS orchestrated reset flow"?

For a CXL.cache capable initiator, since there is no generic driver
model for that I would expect that responsibility to fall to endpoint
drivers to implement in their reset_prepare callbacks. Otherwise I would
expect the device to be already "Inactive" prior to reset.

> CXL reset, the link is going down in SBR case, so the device has no
> chance of doing the writeback of dirty system memory lines it holds.

For suprise reset, sure, but drivers can always trap reset_prepare.

> Hence OS must do it prior to the SBR issuance.

"OS" is one of userspace device idling, accelerator driver, or PCI core.
I think if userspace fails to idle the device, then it is up to the
accelerator driver to handle reset while the device is not idle, the PCI
core should likely not be burdended with this per-device / optional
CXL-ism around reset.

> that the only 'supported'/workable SBR for such a device would include
> previously offlining its memory and unloading its driver, and part of
> that step would be driver code doing the device cache WB+invalidate?

That certainly is the expectation for CXL-memory-expanders, so when
accelerator drivers arrive they need to consider that this will not be
done automatically on their behalf.

> I think that additionally, kernel should also be doing a host cache
> flush here to WB+invalidate dirty Device owned/homed lines cached in
> the host CPU, to handle the previously discussed scenario of device
> snoop filter being reset as part of reset, but not expecting future
> WBs from host, and raising errors if that were to happen.

Again that is an accelerator specific responsibility in my mind, and
ideally the device handles this with its own back-invalidate given the
difficulties of wielding instructions like wbinvd (on x86 at least).

