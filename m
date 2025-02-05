Return-Path: <linux-pci+bounces-20722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B66A281B7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 03:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A49116416B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 02:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F425A65D;
	Wed,  5 Feb 2025 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEDdJA8t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2414421147B;
	Wed,  5 Feb 2025 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722034; cv=fail; b=mzFBRq2j++/YoHQMnKzm6WZri4uz5iCI+XGCDmshb80JJKuD3ioiYLsAf8hYSq0XpZJ+ShPts8dTaiLfq2zSf6Hz0o0c4ZTDtHrpI9n1c5+yof6WR8AdGjkTdoLQSChWx9js/DgT7TfRrzF3C1rW++9yyrmy5Cq020HsrQ3rUWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722034; c=relaxed/simple;
	bh=AMKSz8w8cXP9y0jGJZDiAImzTJdFQCGxkx984ZNd+Wo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tgv9dGr2mzxmjj6mt1lhJnlaWGja5yEFo3eFNppFW45zlIQ2E/NS4vgLwWlPQlH+OIxIwqpLxL6qHS+sl9g+/9MZyxwn1IO471VRZk1hAv5K9JQBvadweCdpV8170hFjlokrHNteHtRlykdZzaf1TPg+NNzlcZFjb6/oDlFtjhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEDdJA8t; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738722032; x=1770258032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AMKSz8w8cXP9y0jGJZDiAImzTJdFQCGxkx984ZNd+Wo=;
  b=DEDdJA8tpKlWIpBelsmvQY1ivJIdkwL47XjSeiohXmyZLk0kZfNsYrYG
   Dod6t4cB4yEEd2z855saDVQC+NldokSzUZUSdloMfEgYUItNxnjulBa9W
   sX2/qAvHgzs3qKtzfATwlN9Ak9J/j8I3KxaV3LlVRO3GASprp46NnlwRR
   EnVarRCJKn+78yPj5h7RufyvCG5Wc3jAB+G6sqTN7AdExgPFM6s5hGBuz
   nndu0sn998YAE3EKVn3bqNRVYdyoaatIKuJPfc1idxw496ONrEMRx8c+5
   nxp6gbUjk7HbcmzRS2O3GyK3sd4PnfLj7RlukY3ECF8s+MPkP3QQ0tg7W
   A==;
X-CSE-ConnectionGUID: Tnqgq2G7S8ivhnNJPX3xsQ==
X-CSE-MsgGUID: qaLVHeUqTHKKomhEil3KJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50264264"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="50264264"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 18:20:32 -0800
X-CSE-ConnectionGUID: 99rAXda8RWqYsvay0uEGUg==
X-CSE-MsgGUID: bIQ2TbVeTr2/jjjx7ptM2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="111346739"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 18:20:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 18:20:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 18:20:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 18:20:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfI0RxQ25U52ija3i3dA+StKKt67Rvp//npTzrzFbMCz4FWzogwcVj67oEOjHSA4gj5gPpuAdjWT4ncg5VG1y7ebIDRa/LFb0+MeF5AkcdZ54PWPc2cwrb5OdD9W1Oy8w7xGBklE/z7eamffSoO6LVFhsK0rZ6FZ1t+cv5pSeaV9O0juGNE9pVpvIZ6NPabdg1M0VEM7ELWJpwxSyii2bYccwSQQSdw/uaGcFMoK+FNPQxA4joKwy4NuhHX69TONIZugwETVoti3H0i9Hgul9IZOEuzTbaTm0QYoY7gKGTWVDOjkKbGSUy46xw2o0II3WGgvdH2W23O+vrhKQaEhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuHf2I+tNrKsXW5x5NDrngnpMw96gcVdXmucySeOFoU=;
 b=vMYxZttu1yfPp/PxSRswtSeNhhAg5T29Wb/96pjoyQ4/nHGhrZewEgQiw059JmyrcNGiK+Gyl7AKt59CpP5tlHKwVSqihA3b2sZfLNCfAEdBYaJw7jXDVE45bd4lgSRE1MmhUdEtn4LFbuYxGZ+wwzxgcJdRcml/VedjWahEoSwikYQV8OLnEV9XFDIeDnbsUbgd/cOmVCQkkcSgQSGhPsQz/kMKJJ3NLPDbUG3VWy/f623kszA5ogRzT33v2CNRJoQiJvbOlUx8mJTyfX6UuiC48dYgl9Vi/osxusnTmFUTMBgrVh8T0TiRR5+b+ggA/zWfDTeMx5rZ5+fmUWBlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by SA1PR11MB6711.namprd11.prod.outlook.com (2603:10b6:806:25b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 02:20:13 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::cbbd:ed55:576c:fd55]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::cbbd:ed55:576c:fd55%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 02:20:13 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Philipp Stanner <phasta@kernel.org>
CC: "Sun, Xinpeng" <xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH] HID: intel-thc-hid: Remove deprecated PCI API calls
Thread-Topic: [PATCH] HID: intel-thc-hid: Remove deprecated PCI API calls
Thread-Index: AQHbcW1Qev02qCR6X0eV5Ad5QyfDyLMsWASAgAut8YA=
Date: Wed, 5 Feb 2025 02:20:12 +0000
Message-ID: <IA1PR11MB609896DE56DDC47092751C2DF4F72@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20250128101156.77868-2-phasta@kernel.org>
 <20250128155813.GA318665@bhelgaas>
In-Reply-To: <20250128155813.GA318665@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|SA1PR11MB6711:EE_
x-ms-office365-filtering-correlation-id: 9ef2e6ee-8b47-4ce0-22ec-08dd458b9f30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+cLJqd+3PW81qZ0LLVM9mo1Svuha8I1sLBah8NCeAZv8DS+NtjOzCMsLsT7l?=
 =?us-ascii?Q?Lia0fWrmdY5IKgL3d9B9KtWHyRkwq5wPiyFh4iG60viJAan9piJbfaQJZQji?=
 =?us-ascii?Q?Ciclhjaix36b/4ywc/eST67rqq5oYhjNNHfuHdrxkGfD2nq2IvP9eiur25TZ?=
 =?us-ascii?Q?xdgxlmrTny2V3zX2J/dW7z4y8M86LWLkcuTCmc+oPkeY6xX5b9HiGM8Buwoi?=
 =?us-ascii?Q?Kbh7GyDeGjgNOuY5fN78O9D7FEbtcqARhKP+KDlQKh+aYu8zZoLvBFKTeh9r?=
 =?us-ascii?Q?NnlQXmNkWN74r6KiHcVp5wrBJMhKsTUckOggKOHVoZEwm99eDaTvl9aJ8sS5?=
 =?us-ascii?Q?59eF1C87PArjMj2V7zb8rjENtv72GWFv629NHIGBK2zj4rq75oE4RcEI8wun?=
 =?us-ascii?Q?OGJ3NYA3WXtsLMS0evI+4dN3mV8gtgzuMtnWMvjvDUsM+6skMnnj1wjWmH+U?=
 =?us-ascii?Q?Eb31zzt1tLLp0X25EY2STV9JmKXzgkwDdMR6WfkqBxGZA/cvA7XCg/XEg0PE?=
 =?us-ascii?Q?0sGP1t/XIvP5v458Ejc327NPAxaw7aH9SzlqeCDTaSxTX/VydJoNH9Mnlr33?=
 =?us-ascii?Q?tOk2Vgv4H3kcUbg5OqdGuKB7zVaQETWLL2+uLHMEUkAiqyx1ZRgivZrzufQt?=
 =?us-ascii?Q?ta5X//uBNgdWPAeYxglszxOg9nBDINhhDFZMVgzgZitAnwzmhxMQQXMhvhmy?=
 =?us-ascii?Q?TWpVVyUkQQLBJALlo423N9S8g+dnAH3Hb+sepaW9HrIPo+dZLIg2YXLPF3fN?=
 =?us-ascii?Q?usOKn0po2xXA1FFlruUm12Yc1t8ckFHGcqXLklctgXr7i+2OHlgdp9L/gC5y?=
 =?us-ascii?Q?8jDyuK9ibjBVrTmKWjszh7c9eEt2qb7VJ+fOG8HxTX5UpeH7hzLjgkQ/XZOO?=
 =?us-ascii?Q?Bw1wxYvRu6KEdvWbhDC7hnH6NDnZxOVINXJVMuHBR7h0qe9FErt3cy1AquVL?=
 =?us-ascii?Q?mbtF0yWF9qcmVkT4mCDjeXHc9Qlp4LJ38j97B/8DL4L8vV+15XP3HbaSRTlj?=
 =?us-ascii?Q?HhcEV6sdHqhy/CazLinieXDZ0ymR4WQEa2w9ztc/zI76oVBTHHlUhY62Hsux?=
 =?us-ascii?Q?4FZSjGmWpLv318yU9RGmQ8XZTDXShMRCMNqe+pigG3i0fiozxzq0lnYUK954?=
 =?us-ascii?Q?rWgjR4c2o9MuCHNBol96vw487K1SjUU5lqSsBaX+C/f6LEonGoaqdBqLXUC9?=
 =?us-ascii?Q?WhpVOvvbcJX0AIqhkvs+CtPRvAGenhPBeMspPYnjRx61IWtnhc8LOiILkpoh?=
 =?us-ascii?Q?M8v9tmT/w58aGy/GcIQwUQWjcAGe5Oo2YFDyyAxMwW2ZQCU6DvW+FpEj4C1i?=
 =?us-ascii?Q?+OHANRtm+Np9Y25/lvnKNhTBrr2rN8vZrEQ3Zw6V3QwXycsMp4B1e8XEEc+G?=
 =?us-ascii?Q?8Ah2cvG03LdoV9omr0gRBs9Bixf+n7IWXw3rVrrOuX2tb/TWzw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kgzL9KfbYOrS1fsUwrlAxq5fC674ZNnrbJMm41fta9kRofmtA6e4e8rahaPz?=
 =?us-ascii?Q?0d3UniFvBoa7XACGM/7N95swup3ASdZmLbKARggtNNlidCyzIlEyyciJr0Mq?=
 =?us-ascii?Q?V8Sn0YH5yits20ZZ1spWu4z+FK50vqhJirJliattzQhvB6Ix0ZtyHA6fcuQz?=
 =?us-ascii?Q?zfbjRq2QwWlwey56N9Rfg7SE+D15mR1UF1Hm/Vc8T01qkjGKYFrzIZisNfa+?=
 =?us-ascii?Q?/DDelfjY9/Un/HAmGOo0DUkbKvrIRvI0k/YNcG8ipeBB90DJODSgldNQZHiM?=
 =?us-ascii?Q?THt0EnR2YEwXGYKKMiZfPtomurqAtW8a/cVR85jCesIZU/NyTes3S6/9amyp?=
 =?us-ascii?Q?FJCdnIlz30aWMbe9+HsSv+wAlsXrC1cH711FoycdSGOMg+3v4VEh72IphZS0?=
 =?us-ascii?Q?EI8XSSOCOTt1PzkLIY4qLv/Lkxg39nzZ+UeJCE7kaOccF5stw/NbD7/WTuFw?=
 =?us-ascii?Q?9in3wGnJnBYh/EgbaqfzCCuM3qrIFHlfFXcMW++9AKOB/MvdpoCQort1tOw5?=
 =?us-ascii?Q?o40/1EyCOlNJvADBkQQ4XrXOp6RrYyLN4HiKIxBqaMT9nQZ0gWRnsk4zV2jK?=
 =?us-ascii?Q?UrbY4JmCWBNcVt3dbQYWnDsFtBKwnRlwJu5siFtEbMAmwRGfiTSCfiM1X9QF?=
 =?us-ascii?Q?m+zjy3JZ4pdmUwAN+gGDKylxpERszJFImKV8mY8TYLSUfQVLNef0pmlzC/Re?=
 =?us-ascii?Q?G75kMuPHqM9AmbLw7PPbx0+k1xthT+BvzjuU/WhcI+Vref98659UQlKJ/HuZ?=
 =?us-ascii?Q?4TtRwbn4VD7joHRij+JfWEUQaCO+VaobUhUmYbJFWmFD/Gz8YnYFCRICghAx?=
 =?us-ascii?Q?2GgnQqd3tVi5tJvhWIrf3zERqQ9nrOIenDwI00t9vuNTQAe0Yq9xhf7TcuAR?=
 =?us-ascii?Q?qozHwm9vOv5IDdKtRregnXyLDhu5VZBdVXVZU+3EN78E1CND01zEVmoptDk6?=
 =?us-ascii?Q?BqSvBPk3zVd1jUqrws7qNoQvb2SfTM/jLvgQ1B2b/CtU9mv1wESAoH1sNP2z?=
 =?us-ascii?Q?Oo1Myjc+uPPBn6H9kNDfo8jh4ljWz8q8jvFAJnKNhZgVQSomk43UVLdJs17x?=
 =?us-ascii?Q?CdZw4DHo9vrBD8WxqrOLeOstrQLkqZV/LrWJ9Z1L2+rEX/b4c+zCoKygXWXK?=
 =?us-ascii?Q?v0lmBP/J9qXrZxH3zAmZrxs0kBRboz3g3F96VicYp9PWGDckVyMgIyruzAY0?=
 =?us-ascii?Q?JCuEK3VI7h8RG6UrQJMM6Sn2FkKW30KRnFdvqS2FEm5IZltD4eMLiebHhwet?=
 =?us-ascii?Q?pY0NOgPyUhhSrVVIMVcsKHGZ9f2cypcsZySjUvTvlItasS/KvZ2eUw2TE35w?=
 =?us-ascii?Q?yHOzh2EInQ2qVg2PHEXZna+nqhyYGmIO4DaGk70ofWEZwjZjnZ4dJ0TKZH1C?=
 =?us-ascii?Q?rJhGS6oF+Ywm2oQu7bVCJRwv2hnFxcj+8Dzs/2F19O/A8fVkxbjhAtxJPapX?=
 =?us-ascii?Q?oDNc5pCR37ePf0EKrWOAGhHtsMLutOjBlSCD0AfCjc9BvtlMaEx+N9vCoFOx?=
 =?us-ascii?Q?nN1OotnPPBdTQv2j98/gTJiQhbe7tXm6R7XAPNjCYJxZyW5YtSRJ9zHPC+b/?=
 =?us-ascii?Q?6KpynwAPHv2qaw81knY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef2e6ee-8b47-4ce0-22ec-08dd458b9f30
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 02:20:12.9613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WoE3szmquVa4gtLB4AF4umrpTVpSXvX6iLGSB5HxTDxdFBMyVIcy2WRRZvfI33Wzb3XtBCUwMe6POi9LPSETmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6711
X-OriginatorOrg: intel.com

Thanks Bjorn!

Best Regards,
Even Xu

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, January 28, 2025 11:58 PM
> To: Philipp Stanner <phasta@kernel.org>
> Cc: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>; Srini=
vas
> Pandruvada <srinivas.pandruvada@linux.intel.com>; Mark Pearson <mpearson-
> lenovo@squebb.ca>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.=
org;
> linux-pci@vger.kernel.org
> Subject: Re: [PATCH] HID: intel-thc-hid: Remove deprecated PCI API calls
>=20
> On Tue, Jan 28, 2025 at 11:11:57AM +0100, Philipp Stanner wrote:
> > intel-thc-hid reintroduced the already deprecated PCI API functions
> >
> > 	pcim_iomap_table(),
> > 	pcim_iomap_regions(),
> > 	pcim_iounmap_regions(),
> >
> > none of which should be used anymore.
> > ...
>=20
> > I'm trying to remove this API since a year. Please pay attention to
> > the docstrings in PCI which mark certain functions as deprecated.
>=20
> If you don't use it already, lei is a great tool that can help watch for =
things like this:
> https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
>=20
> Or lore queries along this line:
> https://lore.kernel.org/all/?q=3Drt%3A1.month.ago..+dfb%3Apcim_iomap_tabl=
e

