Return-Path: <linux-pci+bounces-38388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E406BE5247
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 20:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E244D585F96
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE81B23D2B4;
	Thu, 16 Oct 2025 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1V+zRea"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB023D7C9
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641140; cv=fail; b=Wc26Ts523lYrSGgJjusB24qrYOk3y7depEOvQbPiONzV8FkyDguGe9Abhl1vy3tB4udUtw3Oq0TndR4Rfe2HlMbSjJd/bh75Ry2a92zmiP9+nKZtgFte/PQOCVesfZ3l0bAe9EAyOODSLHGqHotDdgF8P11DW6wh/8Dx7b1at/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641140; c=relaxed/simple;
	bh=apn+EqGHOlwHPd8iOXN+dH3KgGocdubyEbgIMM00JTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PwL6NxHTgx4kciwPsLxXzX1nCRSVVDLNK6IvP/1zDhWIRbCy4CIbq/M4iDol2jWJ3SY+fQ/GHVNBB6qPUHEq5XKlYujVfCoL5a8KuKLO/s0Ul7aAIPbhBBkqXBnjiZzACWg8RyGj9p44GdT2Y//YskbcTFKbybsMQzdVf6gReQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1V+zRea; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760641138; x=1792177138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=apn+EqGHOlwHPd8iOXN+dH3KgGocdubyEbgIMM00JTg=;
  b=I1V+zReaxUq5LfFZrDZm6TbJyA9DIyvw74dMdXUvNUnUtIjTg7xZZ4jV
   9T0qeLu5VMDg4xqSBPcUy7urnKr96CQR3TGVB1zF+3pbEouhXKP/SzsIW
   RwTwCs9zCp5Y+pA5/e9ssIS8FyUrj+O2HhhFyR6NDdyyJG3FEIuadeJh8
   uFGEffPFershWUPrpavooex0YDxNMuG6d1QHUHK++Xi3oE6t+EzCG72Mr
   4k8vbvnH6gMnJwF0BZRJxFSaLoRSelBnehJ6lNKEJgkoOkLEwFgGeTdpD
   qBZfWfoyAMuvsYfgaUOdK4ven613zg2/eyxcZ6wofXTHXkULA2Uv2AHXs
   w==;
X-CSE-ConnectionGUID: g3Oawo32Rbu39auVgHNLJQ==
X-CSE-MsgGUID: IsHCV0ypSvi6xNR28s+Q+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="50415374"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="50415374"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 11:58:58 -0700
X-CSE-ConnectionGUID: jpge3HlaRvyfptUP23tE3A==
X-CSE-MsgGUID: f1w7KMabRTG32LlP8hkPCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="187809423"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 11:58:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 11:58:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 11:58:57 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 11:58:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p27xxhZDO52bjfgq5tATZ7Maw2vonV9w+VTiSmJ+8Xp6KeGpyNxLoP3BfdGKMghD8eehB8mpmPdrr5Q99EdITKMkLQBnWSgBhJRQ4VnVr7mW2iDfPGX6OFdCp5FD2Wh947uGE+w8T6Ewr3mH+yWqFyJGgB6cYGn9ZSUU8lhIx2sDXg10gj6svymLNLqatIQCMeGwk1X8G/tby+WuJV2iQEKsjOtTSjFDbWjnrh80vGCE0JV+wADk3NMAAvBg3ZiZr+FgzLn5ID/E9kMDgYLqfX8jV7MP6aCyz5mMRunYA8jufEvoeJs18t2wqaHmDfnLiCPq06+gSoAGfA8TMKtTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apn+EqGHOlwHPd8iOXN+dH3KgGocdubyEbgIMM00JTg=;
 b=WJGDzWm+DhuA5p+4qSsdmz3Le1wfGmLinyVKChk38Tzm2H/g+ycTCb0qw3VE9Fw+cbig+xHmvcQp2OORQRllAknq2RzpbvjkPEwTG/36+kS5nZfqQ8gVmQpOeve50KQ5bfR1iI65WtRgRlBb1W3EZbOq++qNUwJhZSgqVxJTPYF7rrTqCVW1C3HzzO1kcrf4rjljF9g3qWUtkBDwvfac3w6btXf7a0OeaIcyb6k2VK5DA+M/M2pJuxrmZa2znYYVQms8gpN87hHGhco/sl3ZEWzIbb3QhE5Ryu5ggLpK5+xS3ALZJP3XQDZ5oapyIwams73XW5b7GSfR9dJiDcs7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 18:58:55 +0000
Received: from IA1PR11MB6267.namprd11.prod.outlook.com
 ([fe80::748e:f6e9:c380:ed94]) by IA1PR11MB6267.namprd11.prod.outlook.com
 ([fe80::748e:f6e9:c380:ed94%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 18:58:55 +0000
From: "Brandt, Todd E" <todd.e.brandt@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "bjorn@helgaas.com" <bjorn@helgaas.com>, Inochi Amaoto
	<inochiama@gmail.com>
Subject: RE: [Bug 220658] New: [BISECTED] PCI MSI patch causes boot crash on
 HP Spectre x360 Convertible 14-ea0xxx
Thread-Topic: [Bug 220658] New: [BISECTED] PCI MSI patch causes boot crash on
 HP Spectre x360 Convertible 14-ea0xxx
Thread-Index: AQHcPrxya/66fDSbzECZe3w4gqeQU7TFGW7Q
Date: Thu, 16 Oct 2025 18:58:55 +0000
Message-ID: <IA1PR11MB6267810FFB290004E2DC2958BEE9A@IA1PR11MB6267.namprd11.prod.outlook.com>
References: <bug-220658-41252@https.bugzilla.kernel.org/>
 <20251016164626.GA988785@bhelgaas>
In-Reply-To: <20251016164626.GA988785@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6267:EE_|SN7PR11MB6994:EE_
x-ms-office365-filtering-correlation-id: f7d10f12-b905-4c2f-99a6-08de0ce60e53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RnFVbG9ndEpzZmgxUHZHWm52c1dQdmZqaVJlbisva2pMRER3bWZibjMyc0hz?=
 =?utf-8?B?bzJzdktlQVc0UUU3SGNQY3A1eGJ4bDJBaTc2QlRPOUF0eUJjNFBMbDhtMU9R?=
 =?utf-8?B?ZGpoQkxjdElnR05TMFpmcE1neWxGb3lLUUU3WGtrRmtiSWE0MnAzOHk4UmlL?=
 =?utf-8?B?M3BIbzZ5dmtoVk1XRUdKcEFDelNhVUdqVW9IMlZqL2lVajVSSXd5ZCtuVldz?=
 =?utf-8?B?WktabHEzblUxZkc3c21lSlNWUmh0U1c5ckRhMXRqYlRhcklnRFo4RzYxbW8x?=
 =?utf-8?B?aUh3QzJGaGcwZTNrQ204Y0VzZkxVTDVkY1V2QS85cU9IWWRjRHJ1K3JnaXFr?=
 =?utf-8?B?NXVtWTZnNDNUUmowM1hNYm9ydjFHM2F0ZUl1S3NKdEgxRHg2RjloZitpejJU?=
 =?utf-8?B?S0xjcnp0VWswYXpBQVprVW9GNHFWQkUrNUlqZHBnUGljWVk3cWZBM3dMRkJO?=
 =?utf-8?B?TVMwNUxXa2RzMURxeGFCT2swSlVsZ1ZYbVM1OWxGd1JyY2czOVN6NjFMOGx2?=
 =?utf-8?B?NE81VE5WaUlkZTBoUXF5eVpTQzAvWXZlb0NHVHFaV015NXNvRkRxMnI5UEw0?=
 =?utf-8?B?RzRDendTeittRUpKYWRxYlZmWlpLVk1lZFE2S1o3bGVBWlRORkhNdWVuM24y?=
 =?utf-8?B?TlAvRXlHNlJGdGhoV1E1ckUrMHA1SGd1SXNFeUhjN0V3dE56QWIza2VKUi9M?=
 =?utf-8?B?NGNaMUxKMFVweThheGMydVVYTERFTENacFJDZWh1UjdIOXZmaE4wUEpDMU9a?=
 =?utf-8?B?SUM1ZEdIYU9uNUVaY1F0Zm9yK3JwQ2VYMm5vUHluWVQ1YzJ3cmc2TEZUNjJl?=
 =?utf-8?B?Y3FCbUovU2FwUFAwYlR2czdITEtFdGdqc0lkRnNKZW1aUEtKbjdRUmhreGJ6?=
 =?utf-8?B?emoxOEJ4UWQyeGY3RFRMbVRGN3ZDcHM5RC90ZmxKY2VnOHNuT1BpWENURk5n?=
 =?utf-8?B?SUViSjBWUWNrcFFab2p5d3Y0S0doazV2bEprelFlSzVyNVo1R2ZXMzY1ZVpM?=
 =?utf-8?B?UTdDNFRIS0NqVUVzc2x3U1IzY1FtdHM5MndNdGtIaklCMmorYlpzVGZldE5a?=
 =?utf-8?B?U2NkbTFqTTR6UGJqVlRQU0NXYmpENWdnL3V5MG5JNHkxbFFCdFFEOVhGZkZU?=
 =?utf-8?B?QWE3QXozSGVvSklidnNDTVo0Tm9LdVNFWklQYUdabFRFTFM4MllLMDR0S21a?=
 =?utf-8?B?Y1dwQjVEVEZVaExkZ1R5N2grS3pXTEZkWXBUcFFqek1UUllCMVBPVUpEajlV?=
 =?utf-8?B?elBVMmFSTVBDWllTWkR4YlUxclZUMnorWFpxQXhMOEhmV0VqVzBKS0IzUjVS?=
 =?utf-8?B?aTNTMnFZSUltbDBQWTJxNko3dFFZaVVxbUM2NzQrQW1MMWlwZmZJWW1ONkw3?=
 =?utf-8?B?SDJobnRBVVEzUWRWejFPSHFVVDBjVUNHMlc1azdzenc5MkMrd05URlRMSHZE?=
 =?utf-8?B?Q2dlRGRkZTZic3o3L1B6eEtMMC9NMi9oLzYzd091aXR1ejIxamlDb1FxQTB2?=
 =?utf-8?B?eGhJTnQreTZhRUhjaTBKdHl5am1vODRMRHQ2V1FhWm9HVHJoWVJlQmJwYlVJ?=
 =?utf-8?B?VU1PaEViWEJDa1pGalh0c2NXUDJIMllteXo3T1dZRWNhQlcxemU4YytTMldH?=
 =?utf-8?B?cGFoS3lWcTFHT3hiVlMyZGFWbUJRVW9xUEVndThzdzhSSmxvNGlGckxaYmZC?=
 =?utf-8?B?OTIzTXdESjI4NjdYZWlvYnlPdk51L0FCYmdoZ0NNQUlmdFVFM2NkWllJb0Z3?=
 =?utf-8?B?dWJyUUdOVko2Q1NHRWVvS3VNZWFQMXpPUjhiWlNtTlpyQWlHbVYvK2ZzWXdJ?=
 =?utf-8?B?T3M2R2xUTDgzUnh0eWFCd2ROeERFZk8zZk9GZFRBdk1MdmlWemd3Q1Voa3kv?=
 =?utf-8?B?MndReWtYOE11NHFTWWtObU1uTjA5aXdtcEtJTWRJUE94Wmx5alRoblozL0NE?=
 =?utf-8?B?cURrdHI1SUUzUzJnNEZWTzJpaCtMcm5UcVBxNWwyN2tRR0dWOE5KMzIvTmd6?=
 =?utf-8?B?VVBaaGNUR0hBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6267.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkNNSjdNdUZmdkI2MTMwTGFjOXgvVlM5bThrNjhrWjM4dnErRkcrZDhKcklo?=
 =?utf-8?B?NlZ3UkNzRTFkVkEzbE1jSXpXWTZvdVBqUlB6eDRVem53eHdYdmtWcEVWK3ps?=
 =?utf-8?B?ZjBDUWZzeG95bkZVMXE5QWFjbEVkcHM4ODQvNEllU1hJa1VZNnVkU29sU01t?=
 =?utf-8?B?SDNOeW04ODkzeVV1OEFpN0k2bzNTOVlFb3NYQ3ZOZ2FHeGExQWpqZ0hXVXBX?=
 =?utf-8?B?OTlzaXN2YWcvNHdNdk9lSXlJVHpBZmk1UmRPbXNiRGY4YWpDSWMwVTJwcGRU?=
 =?utf-8?B?UVZncWJGVEZrZFZFTnBqL25RcFcxK01uUm5kSWp2N2pTeU1IY3N1ZlFxamdZ?=
 =?utf-8?B?bnZGN2xBWjBCRzI0SDFjbXV1Z3RNczBHbFAwNUVUY2JZWk5HTFlCMjI4M21J?=
 =?utf-8?B?TG9BbGRndkJEanJsRnVkN0RSTVprbVltK2hya0QzYnFhWlpYMzk0TjVQSUR5?=
 =?utf-8?B?MzBIVkltV1orTmFzSHpVWlJ6bkNwdnhCNlBWWlh0R3Uzd1NhaDQvNlhiU1JE?=
 =?utf-8?B?a2kyWmFNSHdWbU4yRmt0MmtJWk81OXdzSXVyUDRYVWg3NDNNZGNaQXgxdDZw?=
 =?utf-8?B?WVlmZzZtNm92REFTOUVzT2hhbHRiaTdQcnd4TEdBSXZUT210M3NTSVg1TEhn?=
 =?utf-8?B?cUhkZXd2akp5dFJqbWJoaEhudkQrSmNOV0hlaDBtd0k3Sm9mWFB1a1BjQitT?=
 =?utf-8?B?MUxKMUlwWDl6dUR4RkVSRG5IN3g2eTJZRVQvTUJUcmFEek9IbHo2ejA0cGxp?=
 =?utf-8?B?NnpUUzlXZDVtT3pVV1JSMzA5ZVl6Z1l3Mm9BRnJ0bnh4QTBCMUZXUGxPQ0tW?=
 =?utf-8?B?YktLdVhGZEV5ZTlTejJyNlJKWXl0WTlqNTRJbnY3NVo0TElEeVBmY1dMb0J4?=
 =?utf-8?B?b3lvQUJOMGJTUW45cjB0MWpSNVhBakprWSt5UUFLbHkyK2pjeUNnMjNMSURW?=
 =?utf-8?B?VXplSmtONUdmSWVKeXgrN2Z6bGdmOWpsZ0IyYmxRQ3VKZ2JaRE9BL1JRNjkx?=
 =?utf-8?B?bm8xZTJLTVVJZnFrTFJsTVE0YXlKQUdHQTRGNCtDQnc2bWJ2NFRXRUdTUmVq?=
 =?utf-8?B?VDk5SFRMY0tlSFhsRmk0dThES2pVcWVTd2REQVZaMkRwNlJ6OGpEeFdJYVpu?=
 =?utf-8?B?UEsrUitHNXZxTG1zQlBpM0J5eEZmaDhhWDVLZzR0RnlMak9lbm9UOUt2SGFH?=
 =?utf-8?B?eXo3K3VibkYwN2pKZzlXVnUyN0RPTHdnSk1vT3o0U3A3UFhEZlpVQ1JKMWll?=
 =?utf-8?B?ZXpBeTlibjdQZDYwT3pUS1lqZG1Mc3llR2xwb1FKOUVUMWsrcFk3UlJKM1Nq?=
 =?utf-8?B?RTMzT3YrdGx2VXNMRnQraGJOcmVxZ1dSeW0zbkNoTmxzcDE3Nm1CNm9IVzdK?=
 =?utf-8?B?R0k4OVVnUi9zK3cvdkNKUnE5UUVrQndHdDRkK0dWVkJKSGtvY0FGekY3bSs1?=
 =?utf-8?B?ZGh3MGlVMzhDdXZpRnBNZnpxMUR4MTBqclBWRjArcnE0bHRwR3FpcVhkMlpu?=
 =?utf-8?B?NGZCTjByOHFMUGpGWmRGaElLNkpJTTVzeWYweGRaejZzbDRLRytBdFBZOStK?=
 =?utf-8?B?MTBDY29pVDBtSWRhajhUSzlUdEVNaEZhQ0xMcEhUOFFDd002alh5Tk9vY09h?=
 =?utf-8?B?eW9QNzBOSnFEOXcvaUc3WEY3aXBxTW5mY0Q4WEgycmNIY2J6ZU9SV2F1aThX?=
 =?utf-8?B?cStmYlh6Y0dqRWxaQ3M3R0ZDenhmdHI2MUlMTjNDaDJEd3hJdFZUelJPSjRZ?=
 =?utf-8?B?Nms3MlJTUWMwNUdxRnhhR3pkd3NRZmFFWTJGSkcvVkZGcE0xUzJFUVZYZnpC?=
 =?utf-8?B?ckdnWWMzSVhWVTQ1SE40bkgvaVZDd2FSTFFTTnNwQ21iVk92eFpmYmVaMStV?=
 =?utf-8?B?bnJKV3dOYW43ZENvc2NRcU43bmJtcVRvc1phMGh5TW4wUkNPMk95NzRTTFNM?=
 =?utf-8?B?eWU5VVNRNzVPUmlDUmRWT1BEUzdVQjEzUHdCVjBXeFNIRTJJRU9DUDhOZ2d3?=
 =?utf-8?B?dWJmeStxeFdjNXhPcTF4R1pNSElkK3Z1TXhWMWNOK1RTaGV3VW1GN2s2UXlo?=
 =?utf-8?B?U3E5V3BxZytsMisxMkhnWTdYa3VXOWtCU0NkNWhNTnZYYjIrRmNwWWlucTk3?=
 =?utf-8?Q?hIEYQCicvD86C+tfTfAq7tPbj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6267.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d10f12-b905-4c2f-99a6-08de0ce60e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 18:58:55.5153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htYeN/OAHsQBM/TuOCYFqNj6ka0MybD+sxHJUFPdNnN/poyHb7QgTrBZfJF0EAUnuENoH3UdDYhCiZxX6BUQTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com

SSB0ZXN0ZWQgdGhlIGxpbmtlZCBwYXRjaCBhbmQgaXQgYXBwZWFycyB0byBib290LCB0aGUgc3lz
dGVtIGlzIGZpbmUuIFRoYW5rcyEgSSdsbCB1cGRhdGUgdGhlIEJ1Z3ppbGxhIHdpdGggdGhlIGZp
eCBwYXRjaC4NCg0KUmVwb3J0ZWQtYnk6IFRvZGQgQnJhbmR0IDx0b2RkLmUuYnJhbmR0QGxpbnV4
LmludGVsLmNvbT4NCiAgICBUZXN0ZWQtYnk6IFRvZGQgQnJhbmR0IDx0b2RkLmUuYnJhbmR0QGxp
bnV4LmludGVsLmNvbT4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEJqb3Ju
IEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4gDQpTZW50OiBUaHVyc2RheSwgT2N0b2JlciAx
NiwgMjAyNSA5OjQ2IEFNDQpUbzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KQ2M6IGJqb3Ju
QGhlbGdhYXMuY29tOyBCcmFuZHQsIFRvZGQgRSA8dG9kZC5lLmJyYW5kdEBpbnRlbC5jb20+OyBJ
bm9jaGkgQW1hb3RvIDxpbm9jaGlhbWFAZ21haWwuY29tPg0KU3ViamVjdDogUmU6IFtCdWcgMjIw
NjU4XSBOZXc6IFtCSVNFQ1RFRF0gUENJIE1TSSBwYXRjaCBjYXVzZXMgYm9vdCBjcmFzaCBvbiBI
UCBTcGVjdHJlIHgzNjAgQ29udmVydGlibGUgMTQtZWEweHh4DQoNClsrdG8gbGludXgtcGNpLCBq
dXN0IGJyZWFkY3J1bWJzIHRvIGNvbm5lY3QgbW9yZSBkb3RzLA0KK2NjIElub2NoaSwNCitiY2Mg
SGVydsOpIEQuLCBmZWVsIGZyZWUgdG8gcmVzcG9uZCBpZiB5b3UnZCBsaWtlIHlvdXIgZW1haWwg
aW4NClJlcG9ydGVkLWJ5IGFuZCBUZXN0ZWQtYnkgZm9yIHRoZSBmaXggYXQgaHR0cHM6Ly9wYXRj
aC5tc2dpZC5saW5rLzIwMjUxMDE0MDE0NjA3LjYxMjU4Ni0xLWlub2NoaWFtYUBnbWFpbC5jb21d
DQoNCk9uIE1vbiwgT2N0IDEzLCAyMDI1IGF0IDA4OjE4OjE4UE0gKzAwMDAsIGJ1Z3ppbGxhLWRh
ZW1vbkBrZXJuZWwub3JnIHdyb3RlOg0KPiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hv
d19idWcuY2dpP2lkPTIyMDY1OA0KPiANCj4gICAgICAgICAgICBTdW1tYXJ5OiBbQklTRUNURURd
IFBDSSBNU0kgcGF0Y2ggY2F1c2VzIGJvb3QgY3Jhc2ggb24gSFANCj4gICAgICAgICAgICAgICAg
ICAgICBTcGVjdHJlIHgzNjAgQ29udmVydGlibGUgMTQtZWEweHh4DQo+ICAgICBLZXJuZWwgVmVy
c2lvbjogNi4xOC4wLXJjMQ0KPiAgICAgICAgICAgUmVwb3J0ZXI6IHRvZGQuZS5icmFuZHRAaW50
ZWwuY29tDQo+ICAgICAgICAgICAgIEJsb2NrczogMTc4MjMxDQo+ICAgICAgICAgUmVncmVzc2lv
bjogWWVzDQo+ICAgICAgICAgICAgQmlzZWN0ZWQgNTRmNDVhMzBjMGQwMTUzZDJiZTA5MWJhMmQ2
ODNhYjZkYjZkMWQ1Yg0KPiANCj4gQ3JlYXRlZCBhdHRhY2htZW50IDMwODc5Nw0KPiAgIC0tPiBo
dHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvYXR0YWNobWVudC5jZ2k/aWQ9MzA4Nzk3JmFjdGlv
bj1lZGl0DQo+IGhwX3NwZWN0cmVfYm9vdF9jcmFzaF9kbWVzZy5qcGcNCj4gDQo+IEFzIG9mIDYu
MTguMC1yYzEgdGhlIEhQIFNwZWN0cmUgY3Jhc2hlcyBvbiBib290IGFuZCB0aHJvd3MgYW4gDQo+
IGV4Y2VwdGlvbiBhZnRlciBhYm91dCAzMCBzZWNvbmRzLiBJJ3ZlIGF0dGFjaGVkIGEganBnIG9m
IHRoZSBjcmFzaCBvbiANCj4gdGhlIHNjcmVlbi4gSSBiaXNlY3RlZCB0aGUgaXNzdWUgZmlyc3Qg
dG8gdGhpcyBtZXJnZSBjb21taXQ6DQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gY29tbWl0IDAzYTUzZTA5Y2Q3MjMyOTVhYzFk
ZGQxNmQ5OTA4ZDE2ODBlN2ExYmYNCj4gTWVyZ2U6IDNiMjA3NGM3N2QyNSBjMzNjNDNmNzFiZGEN
Cj4gQXV0aG9yOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+
DQo+IERhdGU6ICAgVHVlIFNlcCAzMCAxNjowMDoyOSAyMDI1IC0wNzAwDQo+IA0KPiAgICAgTWVy
Z2UgdGFnICdpcnEtZHJpdmVycy0yMDI1LTA5LTI5JyBvZiANCj4gZ2l0Oi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXANCj4gDQo+ICAgICBQdWxsIGlycSBj
aGlwIGRyaXZlciB1cGRhdGVzIGZyb20gVGhvbWFzIEdsZWl4bmVyOg0KPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IFRoZSBmaXJz
dCBiYWQgY29tbWl0IGlzIHdpdGhpbiB0aGlzIG1lcmdlIGFwcGxpZWQgdG8gNi4xNy4wLXJjMS4g
SSANCj4gY2FuJ3QgcmVtb3ZlIGl0IGNsZWFuIGJ1dCBpZiBJIGJ1aWxkIG9uIHRoZSBjb21taXQg
anVzdCBwcmlvciB0aGUgDQo+IGZhaWx1cmUgZ29lcyBhd2F5LiBTbyB0aGF0IG9mZmVuZGluZyBj
b21taXQgaXM6DQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gY29tbWl0IDU0ZjQ1YTMwYzBkMDE1M2QyYmUwOTFiYTJkNjgzYWI2
ZGI2ZDFkNWINCj4gQXV0aG9yOiBJbm9jaGkgQW1hb3RvIDxpbm9jaGlhbWFAZ21haWwuY29tPg0K
PiBEYXRlOiAgIFRodSBBdWcgMTQgMDc6Mjg6MzIgMjAyNSArMDgwMA0KPiANCj4gICAgIFBDSS9N
U0k6IEFkZCBzdGFydHVwL3NodXRkb3duIGZvciBwZXIgZGV2aWNlIGRvbWFpbnMNCj4gDQo+ICAg
ICBBcyB0aGUgUklTQy1WIFBMSUMgY2Fubm90IGFwcGx5IGFmZmluaXR5IHNldHRpbmdzIHdpdGhv
dXQgaW52b2tpbmcNCj4gICAgIGlycV9lbmFibGUoKSwgaXQgd2lsbCBtYWtlIHRoZSBpbnRlcnJ1
cHQgdW5hdmFpbGJsZSB3aGVuIHVzZWQgYXMgYW4NCj4gICAgIHVuZGVybHlpbmcgaW50ZXJydXB0
IGNoaXAgZm9yIHRoZSBNU0kgY29udHJvbGxlci4NCj4gDQo+ICAgICBJbXBsZW1lbnQgdGhlIGly
cV9zdGFydHVwKCkgYW5kIGlycV9zaHV0ZG93bigpIGNhbGxiYWNrcyBmb3IgdGhlIFBDSSBNU0kN
Cj4gICAgIGFuZCBNU0ktWCB0ZW1wbGF0ZXMuDQo+IA0KPiAgICAgRm9yIGNoaXBzIHRoYXQgc3Bl
Y2lmeSBNU0lfRkxBR19QQ0lfTVNJX1NUQVJUVVBfUEFSRU5ULCB0aGUgcGFyZW50IHN0YXJ0dXAN
Cj4gICAgIGFuZCBzaHV0ZG93biBmdW5jdGlvbnMgYXJlIGludm9rZWQuIFRoYXQgYWxsb3dzIHRo
ZSBpbnRlcnJ1cHQgb24gdGhlIHBhcmVudA0KPiAgICAgY2hpcCB0byBiZSBlbmFibGVkIGlmIHRo
ZSBpbnRlcnJ1cHQgaGFzIG5vdCBiZWVuIGVuYWJsZWQgZHVyaW5nDQo+ICAgICBhbGxvY2F0aW9u
LiBUaGlzIGlzIG5lY2Vzc2FyeSBmb3IgTVNJIGNvbnRyb2xsZXJzIHdoaWNoIHVzZSBQTElDIGFz
DQo+ICAgICB1bmRlcmx5aW5nIHBhcmVudCBpbnRlcnJ1cHQgY2hpcC4NCj4gDQo+ICAgICBTdWdn
ZXN0ZWQtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiAgICAgU2ln
bmVkLW9mZi1ieTogSW5vY2hpIEFtYW90byA8aW5vY2hpYW1hQGdtYWlsLmNvbT4NCj4gICAgIFNp
Z25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiAgICAg
VGVzdGVkLWJ5OiBDaGVuIFdhbmcgPHVuaWNvcm5fd2FuZ0BvdXRsb29rLmNvbT4gIyBQaW9uZWVy
Ym94DQo+ICAgICBSZXZpZXdlZC1ieTogQ2hlbiBXYW5nIDx1bmljb3JuX3dhbmdAb3V0bG9vay5j
b20+DQo+ICAgICBBY2tlZC1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4N
Cj4gICAgIExpbms6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDgxMzIzMjgz
NS40MzQ1OC0zLWlub2NoaWFtYUBnbWFpbC5jb20NCj4gDQo+IA0KPiBSZWZlcmVuY2VkIEJ1Z3M6
DQo+IA0KPiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTE3ODIz
MQ0KPiBbQnVnIDE3ODIzMV0gTWV0YS1idWc6IExpbnV4IHN1c3BlbmQtdG8tbWVtIGFuZCBmcmVl
emUgcGVyZm9ybWFuY2UgDQo+IG9wdGltaXphdGlvbg0KPiAtLQ0KPiBZb3UgbWF5IHJlcGx5IHRv
IHRoaXMgZW1haWwgdG8gYWRkIGEgY29tbWVudC4NCj4gDQo+IFlvdSBhcmUgcmVjZWl2aW5nIHRo
aXMgbWFpbCBiZWNhdXNlOg0KPiBZb3UgYXJlIHdhdGNoaW5nIHRoZSBhc3NpZ25lZSBvZiB0aGUg
YnVnLg0K

