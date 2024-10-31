Return-Path: <linux-pci+bounces-15705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816DB9B79FF
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 12:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419C02862DF
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6919AD94;
	Thu, 31 Oct 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCZCz6P2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5319AA6B;
	Thu, 31 Oct 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375418; cv=fail; b=Y3BMqteMvv2tQXbbgtuL/hSDagaADADGby/CU3QIPWV6ZJ8SX9uFeMlfSL9Xo4Z2FQOr19jVAjMT5jkx8GVYP0+l6G44849gXk/QlSTIqGDLTO85FqHJPoNxu2tW2PSqbIK6SdwBq8jKZltpVIxa+GViNVY5ZWAMDyNoCaa8e2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375418; c=relaxed/simple;
	bh=ajPn2GLiyihq/DzAinNalfzYRwPwoElofJtUgHOsDIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=djG3oKQ6R/RBeuUmt71/aa2CvYpGULFltFTfTsDZXovlXZ29Bu8iBGpwENejjY9HTvovGq1ig+ZjK53PREnUjg0k2g5UdxaKxQaQ0EXgqXSEwJku8ola3RLGyCE7lFgKk4xCT0vMy5CtWDKgdFXNvLdEi6WSw8cbBWHFeKu1xRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCZCz6P2; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730375417; x=1761911417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ajPn2GLiyihq/DzAinNalfzYRwPwoElofJtUgHOsDIw=;
  b=SCZCz6P2UYThYM/FKaGLaUq4LTXQVDSYavLXVPsTTqcBwA9t6Jk0AToC
   xXQiy/KB/jqrhjwAaFlMI9yB4hdBombAtSMrvvWVjT0WxJxGbMedN3Kud
   ZR/+rLsZeblewVEnYjmT7GC7tvyxxNybEWrdbJYpP1zKzRvZoL9kuzohQ
   iL/5x7uwrq6JQ8HzPq6wxBhC4uQEKxQ5wNfPpnPnneX3fmQBipurKicA7
   ppX0WyAc1+yMpP0/t5WxjtZeC/VaFEQ9bMUQkFCSQVfAFx1m+/VBpIC4k
   AvszTAPYyjHBrfP4lfLcSk+6Z+/jU1gYy9GqlnmpDHvgHn9XhApUd1ISb
   w==;
X-CSE-ConnectionGUID: 17Bxhay+QOKIclsTtFZSFA==
X-CSE-MsgGUID: YZsMTLHUSpK7iaGzm3+eYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="33903255"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="33903255"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 04:50:16 -0700
X-CSE-ConnectionGUID: psyCiVPeTEmQLo6BJ/Rx/w==
X-CSE-MsgGUID: Uff7xOjVSGOesHkBQla+DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="120062457"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 04:50:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 04:50:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 04:50:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 04:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNn//+Uk85ynXjHXD8HplhR09k4OePb0PM+G6B5u1FiKqe/gRzSOQvi6PzBm8dnc3Crzd+mpB8p9GNYb0Ky13TlGxnt6fz9nwp7TPJgknbXBuiEm94qwNhTwJK0wxHnzGfoKDF6OMxrW14frSL1ZrmnhT4Em/10Ko8DKJHcqwcn8dsQqZ3XtuYjeFVWL9MIvdcSrPReiIEbCyqJeKSe7A2ZIQ0RCbAS1lmRn9qzKjNxNxEIgLjCkX1ru3QIvR0a/12pKd+FQ7kCnzAf8dWJux+suvcgdBwesJRCdY5QuRzcRLTSsByaGdSiMWwdQSE0q/PU949lg3ZpF6cbNA/nyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajPn2GLiyihq/DzAinNalfzYRwPwoElofJtUgHOsDIw=;
 b=s4Fsd56dM0/HbBm8lBIwfbYh0ErzFz+W3GCqyj0CJwbR1Zf62n4MwpwYq5WCQUOuzzcBRxmPd7FGEzREFxtxMIN1u10XwkHctsERkVlu0R4geql0z4hJE7wOPl8HuiTCQhL5nEMg9xx9QTprfSsh0XRA88PyHBDZ5Iljh0snZ81XVoCd6J6hrW1Usw6yH0d5rYp+B1IfHLC1KuiNFsHEKusPai8LnEhR06bnmTy90GRZqLpZMFOEeQP8XCwjT4UP/ev3Q+M+i9uT4A5VZnAQ30NqEvy3MxyEza0R2QfD7PI7umQrB+eB3l65wunla0QsD0YW7qVsZCBIFeFTROSa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW3PR11MB4698.namprd11.prod.outlook.com (2603:10b6:303:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Thu, 31 Oct
 2024 11:50:10 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 11:50:10 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "avadhut.naik@amd.com"
	<avadhut.naik@amd.com>, "john.allen@amd.com" <john.allen@amd.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "Shyam-sundar.S-k@amd.com"
	<Shyam-sundar.S-k@amd.com>, "richard.gong@amd.com" <richard.gong@amd.com>,
	"jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "clemens@ladisch.de" <clemens@ladisch.de>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "naveenkrishna.chatradhi@amd.com"
	<naveenkrishna.chatradhi@amd.com>, "carlos.bilbao.osdev@gmail.com"
	<carlos.bilbao.osdev@gmail.com>
Subject: RE: [PATCH 02/16] x86/amd_nb: Restrict init function to AMD-based
 systems
Thread-Topic: [PATCH 02/16] x86/amd_nb: Restrict init function to AMD-based
 systems
Thread-Index: AQHbJXAimaYZSg6TnU2Ki9kvG1u6UbKgiiyQgAAsgACAABJKkA==
Date: Thu, 31 Oct 2024 11:50:10 +0000
Message-ID: <CY8PR11MB713456E1E8EF5257F0DEE9F089552@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-3-yazen.ghannam@amd.com>
 <CY8PR11MB71340D079448528FD548F73289552@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20241031103642.GCZyNdumQSdi76CA3w@fat_crate.local>
In-Reply-To: <20241031103642.GCZyNdumQSdi76CA3w@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW3PR11MB4698:EE_
x-ms-office365-filtering-correlation-id: 368d28a1-73fa-4913-dddb-08dcf9a22c4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MkQ5S0lqUy8rSEVLZGkrb0ZSaE54OHNlSzdPWTRTRzkzTlZoMXlmSVpaRVBi?=
 =?utf-8?B?TVNlUzU1VjFEZnluL0FyTUlwTkRCeWIyUWdZZkVROElTUytXWE9zWWxoSVJx?=
 =?utf-8?B?YVlTQ0JrL2ZEY2hUSWhMWDhmemMvS3JBNjl2bU9Rdm5zSEtzcFNEbjRrUmFP?=
 =?utf-8?B?bENCalVBQUg4TE1zdURYTE12Qms0RUZjbjYvNHhmRGovdTFWVnZBV2RidStn?=
 =?utf-8?B?ZG9VaWJON3N6TEJ5MGY1bXBxS0h0cUR4TDhaaTFYS2RNRW9RU2w2S25oZjRP?=
 =?utf-8?B?ZkNqSHp0YmEwTXQxRUc4Z2oxbjhHeHJUWU1HNHMvRzI0S0FTcUc3ejRPc3NP?=
 =?utf-8?B?T3QrZTFmRWs0VnJLZ0t3SVpRMXluUGVHZ3VRV1d2QW5tUG5PUmFRcGQ0U1U2?=
 =?utf-8?B?T1Y2L2grN0xTTGppTmxSVlFhQ3lGVmxQM1Z5NkVMa2xYaWdySzJFT0VXYjk5?=
 =?utf-8?B?eHROc2c2dGtCdGZMSWFvSnRSZG5KR0dKdFdtRjRDTFA2ZGJBd3ErSWNNaWxK?=
 =?utf-8?B?QWlvb1BFY0hEaGppOEMrZkZIelN4dnNmRThxbmU2VmZ4OXB6YzhTQjQraGJm?=
 =?utf-8?B?OGx1a2xHcHAxeXNIakdMSXFLZk5Qem5kQlBxbjRVRHJYempYS3Q2bFViQ0Vp?=
 =?utf-8?B?cWV6UWVUT1hNM1orM0FicklKZmRsdm5ldWxPNWJjNzdnZVpjSHArOXRpTkQz?=
 =?utf-8?B?VW5xTUg3TVpOTC9rbUkycWlKc21xbEQ0RW1PVStkUHMrc0pOcklMcytKVTdE?=
 =?utf-8?B?c2Nqb2FKRkpEbWxqTDRBTm1IQ0ZLM0FxOWZBRVRpamdQVWJzTmRlQmJEYnlV?=
 =?utf-8?B?bW9UUDNzVG9vbiszK3Q4a1JISzU5OUp3Unp0WHQrQXNXN2hjMk15SGJzYUVh?=
 =?utf-8?B?WjJ5aVpTZ2RJd2ZDSE5GbGdPVFhFYXJrMC9BV2FWNVRsRVFDREQ0TkZDaWM1?=
 =?utf-8?B?bXFYczd2Nk5oZDU4eGx1SUZSWVJybWNMcGptbzh6RnUwQVJXVW94dHJkbnhS?=
 =?utf-8?B?Y0cvU3psOFA2Z1FYTXFuSHRSUlNXd1l5Z0dFSUkzbi9xcUtlbGlYOHI1WkJr?=
 =?utf-8?B?NDQvMUZWa0RyK0FTTlJBWmtWeGFmM05HcXJFNFg3b2lYS0tPaE54cFlOa1RR?=
 =?utf-8?B?cXZmWTVoRUd0TlhzZnZxZ1dQUXN5OEM3UWlSakprUHQ5QU5TcEVyQ0YzanJz?=
 =?utf-8?B?eVpPWjlxRVlIVlJubHQyWGtNaFNETFo0bXdSTTlldlcyakxqVHBlaVMrbVlG?=
 =?utf-8?B?c2QvdTk2QWlJUnZzd2JDbjF2dGJNcTluMzBlQVc1YlZSYkFYc1pTMUdYeE5a?=
 =?utf-8?B?aWs5ZkQ0b3N1V0loUmUwcndkNUVjRlJPYmM1M1pWeGlxc0pCN3VXcFo4K0FE?=
 =?utf-8?B?Y215MmZUZ0F4Sjd3MTJyUFpsRnFGQ2FCMWNIVWpCdGhmNnlXOVBUaEJqOEQy?=
 =?utf-8?B?Z1VxRkVsbmlHbXlYRDltQU1Wb1hodVcxcGRHQWsyaXpvL2VUOEI2Q0xGQzNx?=
 =?utf-8?B?c0FRRldobllWYk9UMFZGbzBOWEtBN0ZzQmJrRkZMTThQc2xVbGthNnpxS1Rh?=
 =?utf-8?B?S0MyYjB3cXRoTVlNTWRqTTFIcE9xc2NIV0VEcHZVWEgzamdXdUdWQ3V0R0FT?=
 =?utf-8?B?dGNxQmxPK2xPYnhXNFczYm5iK2ljTnlldU5LSlYrb1RiWVRXeGo4MDFkR3pT?=
 =?utf-8?B?UHlVb28wcmpEc3FTanI3Y3dYSkhweHRCeWtnc3l4VVgwa2l6WjR1R3Y1K0tt?=
 =?utf-8?B?YmVPSkVMQ1UzZkszeExhTUdqVXVPMXRUeVJnS1pVenYwT0h0dVNiSk02OEFn?=
 =?utf-8?Q?5a6LvUH6bJOg/oF2PubdJVypyaqvS8lK7GzCk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmRMamJkZmxPTE1TQWJPQ25Vb3JUMktBQ25tTFpTaE9HNnA5S1hyd3pTRk9W?=
 =?utf-8?B?TVBSWjg1aXRZZVFweW9QQ3pFazVYYkNEdEFmT3RpeEdPamtlMlZMYUFrY3ov?=
 =?utf-8?B?SVNDc0QwNUFkVFVNb3hUSEVWTzJwQkhVSktqYW5FYWh1aG5EUzRESXRpcDA4?=
 =?utf-8?B?QmJUYVZIaWxsOHdHeXBVVkZVQStjOS92V05vUHpGMWJXTUNZeHM0c3NSZGVJ?=
 =?utf-8?B?OEMrSXd2Ymd3enBTT2M1ZzloenVVUUFORG9ZMXBvaytRQ0dIZHF0SDJRdnh4?=
 =?utf-8?B?OGprZlV5aHF4QlZJNE9SelBucDEzYXROaEgwRFBQWElPbkZ1Y3BxU2hmZ08r?=
 =?utf-8?B?enphVmxsVDltbWtCSXpqamVpejNMK2FVNDIwVXA5K2xLdGVMKzNCQUtVRHoz?=
 =?utf-8?B?Qm95SUUwYzdKRXA3RHRrbEdNb3NpUmhoS3VHQk9Rd1I4dEhDNmpwTTZ4NjJs?=
 =?utf-8?B?bzJqdTJIQzlFdHFEbnplSkRSOWkwMk1pd3Vaa1FMZXpEZElwN3dvVGQxemM5?=
 =?utf-8?B?SUxlS0dvY01kZERNQllOQWpIM054L2ZNK2dzMXc4QW42SmsvTjRvU1g3UExX?=
 =?utf-8?B?dUFtbUEwbFNUdjNnV2lWQWhVRy9KSVI2ZTNRTCt4ZXA4VFIwZGR6ZVNFQi9l?=
 =?utf-8?B?QjdBUjVNSlZhS3hoV255Y1pJYTdEeDRRWFdHWG1jbURyUytLa1U5WnBLUVNQ?=
 =?utf-8?B?Z282cFYxN1diK1VOTTFCQ2t5ZTBCQnF3Szg5cHJvTWVXTXl0Nk5QdUh5NVFI?=
 =?utf-8?B?RW9BNmRoa1VyMWZzZnJDS01TRDdiSEVlRkxMZ1E5dGZSbStaUUFvWUtKbTMv?=
 =?utf-8?B?bUdXd1o2Y0dLRk12UEFpRDZyc2YreTRobjdJVmh5dFdIb2V3U1VjdE9COVBo?=
 =?utf-8?B?Ry9EZ0xlTzNjbXZ0UlVYbU5kYXJCT0R2R2tVNVg5R3diMFhSSkt0YUNNMzdj?=
 =?utf-8?B?UnZZaG43dkNXd0Fwd0RDZ2NQYU9FNnY3MUd0ekJidHNUc3IyQXRnTnVadmFp?=
 =?utf-8?B?VnMyaDVCdWhZV3p2cjREeXVXS0xGRXcrMmRVUHpKYjk5ZHFDalBqZWo0a005?=
 =?utf-8?B?cE9PV0I3T3JOU0trMFh4U1UvZnhHaEM3Q0l2bzRKWDdGdTB4VzRjM0J6UFBy?=
 =?utf-8?B?Zko3emNtaGxJRFBmUUQxQktTT0tRbVRidDNPVUZjc1ViTFNKOUVWMFlHYllx?=
 =?utf-8?B?dk9KY3F3SURwSitQRk1yTmJLcXVCcjFCeng0bk9nVGhWQlhWQ0Q2NmxOS1dm?=
 =?utf-8?B?TVlKOUVRZ09nWWJZMFEwSFYwR0dieEJXQ2t1OXAwZkZEZUNSdUg2Q2xPWC9S?=
 =?utf-8?B?QStVZkdtLzREOHdYWHhKWUE0NHJkSEQzWWtpdVhlRUFuaWFEODZZMWZMWFpX?=
 =?utf-8?B?aWxBRHBDMHgreld0YXhoaVRLS0hTVEhBdWo0RjVnZFFFN1QxM0xLcjNsK3BP?=
 =?utf-8?B?YkJNNFFLN2ZkNVBDbEkyYzVZTGJvUFpGQVl6WVN3cERkbmVSRkwzMUdoOWZG?=
 =?utf-8?B?a3k2Z1JKSmw4bDI1dGNEQmZFVy9VeWUxbXVXM3hnYkp3ekR1Y3FSbzhHYnpU?=
 =?utf-8?B?VEp6YlJmdTYrVU11OXphUjFQeitiL2pHVzdHOUdwYWN6NDZGY3IwZUtLQkFo?=
 =?utf-8?B?b2FHT0w1cTNLQWdnRzByMzljQ290bktOZ01xdkpETVJ3YW9lVEpjSWpTRGZu?=
 =?utf-8?B?RmRCdlhsbTNLRGozbjRUMkxEdHJqbHY4MEE3dUV3cHM0RlB0c2w3SWlEblhu?=
 =?utf-8?B?MGZhNW9FZHhkcHZ4b1l0Ui9oM2NscTFxN3ltZEg5UUV0RkhSL2FGTFVKdGcy?=
 =?utf-8?B?UE15WWlQNW9wRm5mYTEvMWNWMGEvdjBYdG96VGJvS0FOTEthMFBCdHNQby9E?=
 =?utf-8?B?dG5lWGkxbmlNdUpjcVZXQy9DTXE4NDdDSC84MS9Wajc1VjZseWJWWFBtUm9R?=
 =?utf-8?B?bUplaTBXb1dVSlFNRXVhNmRpNCtGYVlaMXJ5UndjcmRVWEh5RTNaMk1HdDFx?=
 =?utf-8?B?d0dvQjJkbjR2WWZsMkw0RUxWemVEd2hLdTdRN2d5WE91a3N2K0d2a3A2QjVQ?=
 =?utf-8?B?ZStNYUpZY0ExdE5yQUlHQnU2Tko5S1hiQ0xVRmlrbmRkdWxYRUEwWW93M3FI?=
 =?utf-8?Q?ovahQdhZ52VmQTz+NsaUtNFJy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368d28a1-73fa-4913-dddb-08dcf9a22c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 11:50:10.2746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ux+5hu3+qli61vuKK7vKXV0/i6SfXIxY/Lh6llhamiAkg3zj1apsDPAkwdE3UVTWaFftv0NBzn3Vx9JIwgA44g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4698
X-OriginatorOrg: intel.com

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gWy4uLl0NCj4gDQo+IE9u
IFRodSwgT2N0IDMxLCAyMDI0IGF0IDA4OjA5OjE0QU0gKzAwMDAsIFpodW8sIFFpdXh1IHdyb3Rl
Og0KPiA+IFRoaXMgZnVuY3Rpb24gY291bGQgZmFpbCBhbmQgcmV0dXJuIGFuIGVycm9yLg0KPiA+
IElzIGFuIGVhcmx5IHJldHVybiB3aXRoIGFuIGVycm9yIGNvZGUgbmVlZGVkIGlmIHRoaXMgZnVu
Y3Rpb24gZmFpbHM/DQo+IA0KPiBObywgZ3JlcCBmb3IgYW1kX25vcnRoYnJpZGdlcy5udW0gY2hl
Y2tzIGluIHRoZSBjb2RlLg0KDQpJZiB0aGUgcmV0dXJuIHZhbHVlIG9mIGFtZF9jYWNoZV9ub3J0
aGJyaWRnZXMoKSBpc24ndCB1c2VkIGluIGFueSBwbGFjZSwgDQptYWtlIGl0IHJldHVybiB2b2lk
Pw0KDQotUWl1eHUNCg==

