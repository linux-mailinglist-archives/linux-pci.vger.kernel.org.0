Return-Path: <linux-pci+bounces-39129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540A4C00562
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 11:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB75F3B0F2C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C7F30AD1B;
	Thu, 23 Oct 2025 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="du3gAE4h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912030AD04;
	Thu, 23 Oct 2025 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212543; cv=fail; b=H41n5qYlaLAMMap+6l4ZVvGc2BOs3wAl+mkoHJxbsGv4CycZde4iA47r217pDRDSjsjB4KW55h6FzdiZTEqnMtaTJ46Xszse2h24k3+xG2gC9U2JoC+iuXoE/9VzDLS1ARAw3ixNgJJKJAnQkcuglYl0I2UKeEu4Q2FU1RUMUqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212543; c=relaxed/simple;
	bh=u0LMjIDFOwC4x+cHkXi+HjjKncffO8rTRRQ+JYzGVQA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PJiH6MfSVlOexefYNDlbNrbEA02d8eMww8QNsTgj0NyQkAk4my5maNsFvMfFSfU7XZ6DWwvrMuxuFM10fq3eX4KWYbrz4P/W+Np63nAahKPQGSKj3+pd2oPuDmSE55KZENrAWc7Hs5BwRUPfI52fGxUyPqgYbRDH7lUR2HpNscQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=du3gAE4h; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761212542; x=1792748542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u0LMjIDFOwC4x+cHkXi+HjjKncffO8rTRRQ+JYzGVQA=;
  b=du3gAE4hcLyauXYJsv8yqbSh8LHzRlM/VKuc2C0pUjKqW4OZtSRSu3Cd
   uxb7+axav1CPlQLxq5GZEdmGNn3rvrMisQ9A6PTT22vNStSje/xsxcXRE
   p9fyGxZVkuVGdg6hcJ94j0F7bck2iaf3Ikm3dJwA40TyJcrme3tTeAWnw
   hUXQaNNzelN/qjqRpw0kCtL121+IfsQBGqQ5a8pQDNRB4DMrQHfnF16Z6
   2MSUWQQdJFuEUvDy4zoahw9ulD7BAHP1dxReWi0AhRJg/50t1RACwJKyi
   c8VYKvKyTwTlVnUeub2rXwZyJHnoCsDzErQn+ZPvXhaAoPMPIlb4XMPWI
   Q==;
X-CSE-ConnectionGUID: IamIDlxfQ3CQG/uCLl3Gug==
X-CSE-MsgGUID: 8zWclbPhSkKAKYdewoLI0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65993087"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="65993087"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 02:42:21 -0700
X-CSE-ConnectionGUID: yltDKtmlTY+LvHlbvEPqFg==
X-CSE-MsgGUID: WTGwdyMPTReGKzCqXXchZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="189244211"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 02:42:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 02:42:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 02:42:20 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 02:42:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrP7C3OZ1Llf+Hq7WqTsPhHh+osfW9Znr8pr8IP5K5xvCvy/tt4Jcz3QudQwpE3qjZoWYot/KG6Bc5/cPOGy6efRiMI93NgJAgFA8J/JCYa4YJEFeC+CZaXYBn/7yHXx3359IaO590Z4DgDkjjtwSFRLbwZedvk5ytNimnNb/CUYu978iVstpM21H28hh1A1isg1cjl7vNQ7YT6mV3nDgAPxpP14nsNDJWuAAFVPbMMEovjaoTqo3N2TV+/yr4TEXwtWswqtJKQu7xXVlmH4Smgw4yT1tBJmQm8wPiqo9LYK7MAg6rXuIeUqhv3XJHxOg2Cv4htnzJipH2hSZMiqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0LMjIDFOwC4x+cHkXi+HjjKncffO8rTRRQ+JYzGVQA=;
 b=PzxnIocjBXqOaZhZNcAPJxm9/RE3Mvh4h+17/tJc1EwotF0HNawxZgAlnqy0fKW8TbFyc0vtc6uINuqAcxX8fLCPVMpxLY31knIW+dAQSnLduQuq8c2TyOTJx3yl6yzeTtPR+0P2hSdL9Sg10PrfjdPphXe49bfKiRn08HkC/pBpY/ElDsliGmtbYRa4qk3I/CqDN0DE5ZdIZ+6LbPodiuVwEYm9luR7A/sM/IZ46X7GM/zraSaX4+iWEnyttF+j+9rwZeQ0+DIcraRJe+HLOByY7+jI5d+B7MD+gOZiwK8U7lXFy2mAgT625wvNr+dXFEOIlsnQYGl3XVHdwmBVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9016.namprd11.prod.outlook.com (2603:10b6:208:582::17)
 by PH0PR11MB5878.namprd11.prod.outlook.com (2603:10b6:510:14c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:42:16 +0000
Received: from IA3PR11MB9016.namprd11.prod.outlook.com
 ([fe80::636d:715c:da02:9944]) by IA3PR11MB9016.namprd11.prod.outlook.com
 ([fe80::636d:715c:da02:9944%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 09:42:16 +0000
From: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>, "K, Kiran" <kiran.k@intel.com>, "Ben Ami,
 Golan" <golan.ben.ami@intel.com>, "Berg, Johannes" <johannes.berg@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
Thread-Index: AQHblKzedN5ESVMts0qaxi1x6po7nrNzCIqAgAX5lQCAAA6ggIFXvXuQ
Date: Thu, 23 Oct 2025 09:42:16 +0000
Message-ID: <IA3PR11MB9016B8132E2E11806B58A0F7FCF0A@IA3PR11MB9016.namprd11.prod.outlook.com>
References: <CABBYNZJQn4ZYMxLqCkJwA71a_VWhu4QXTkU7vt7wiQXf3bdYdQ@mail.gmail.com>
 <20250318154727.GA1001403@bhelgaas>
In-Reply-To: <20250318154727.GA1001403@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9016:EE_|PH0PR11MB5878:EE_
x-ms-office365-filtering-correlation-id: 5e28d4fe-44cf-49a1-64bd-08de121873ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aVNmL2NiKzFOcmdGVkxxMFRaVWxkMnVYbEZxMk1CMTBRaEdZU0N3ZFVjT1Yx?=
 =?utf-8?B?TFFGdG13TTUzQXU5d3pBK1g2cVAyMVh4dWFZUFU2K1E5OHBJSkhKRElmQ0JK?=
 =?utf-8?B?V0RRSVpnRU1hZnpQVmJuazdibjNHNzV0ZStuTlY3cFBld1FCc3dNTU5XOE1j?=
 =?utf-8?B?ZDNlZi9TSXdRZWZTRmMxM0UveU1zaGNyTm1rdEtqWHNLSUdqZFRpbGdLbnQz?=
 =?utf-8?B?MkRKazF4azJWT2tPbmFOUFlNQVJVZ2QzL1J3aTlsU1JSVm5SL2MzQVZqcDIv?=
 =?utf-8?B?VXI3RXJtMFFTbE1rOGt2QUZaeWhNdGVFWFhEek9XeThWekdSS0laUTJRYmZN?=
 =?utf-8?B?YWdnK0l3dEpnRGhFT1llc1Vad2ZkM1pUeWxQbmF6bjZ6WElDWUNCNEt4V3g4?=
 =?utf-8?B?M3pZc2NacGl2NG5qd1lRM1lRQk1QMDRpNERiSWsyTnRKb2VXb1duRTRQUG94?=
 =?utf-8?B?dW0rZXJEbWM3dkZVZWRrZlpidnBocGp6QUlFU011UkRXZ20rUzc2ejFRR2RZ?=
 =?utf-8?B?RW4vRGZsTENRMTVmYm8wK3d0aHh4b3NrSUljZ3VrNmV2aXlaK0duVCtRVlFa?=
 =?utf-8?B?Y1I1SVpGbTFkNy9Fb3l3V0dlWEk1M3BONkloMi9UYVQ4YmpqNG9FcVRKaE5X?=
 =?utf-8?B?M1pkT3dPRzNqWnpJYjhVV3V4S2xxVnFYN3p6dmgrNjMzNFpqeVZtOEc0MkRk?=
 =?utf-8?B?c3FiUTg0ZXZCQWN6K2JJQm40OXNyVU8yek5Sc1I5MGp0bFR6RncraDdxL1pI?=
 =?utf-8?B?V3diOHFGczZYeml0cTIyU1J6QmV2UlJCdi9oMVNtMk5nempSZXFTV1k4aU9I?=
 =?utf-8?B?UXE0K25yYkp6cGtPMTZ3bHF5c2Z2NXVOZWtNMkJDbmM5SmN2UU5hNTFKVk1U?=
 =?utf-8?B?Q0tNbXprVGVFTkYrSStvaTYzVFYweEE0ZGdMTkplWFJicS9LSDNSSmwxZElm?=
 =?utf-8?B?bWFUczlROC9uT1dsTUNMRytsZStwcWl3dDRaa1UwQXZmbGlvTVc1NC8zdlp6?=
 =?utf-8?B?R3lObkFWWTF0a3BYMU9KQ3ZLcUJ3THpEWDNZNldCUDFSTzREV0VyckNZVFll?=
 =?utf-8?B?UjBCQ2RpamZkOENCUXlSU21leGpzYmJGZ3E2WVIzWDdtL0dsZlNING1MZUph?=
 =?utf-8?B?VkZqcVN0QVRCWk83eVZEci9ocmZWQm5FUkhjVUZ6SXl1TlBkR2t6THVVbStD?=
 =?utf-8?B?dyt1d1JoNzBWdkNkWEZJak1TZndIdkI4UFM3dHprM3VmL0tpRzBqOW12V3gy?=
 =?utf-8?B?YkJkK212YkNMTjNPUTlnWnBXZlBodmlYQm0ydlJPZCt1Nm5laWc4REFxb3Zp?=
 =?utf-8?B?T2RHdlRIaTFzOXZjZGFTc2hCQ3VrZVdKQ2prSFlTUVVWNnpjOW80ekpsTnU5?=
 =?utf-8?B?aFY5cTJPcHFIblBFK2JNc1JoeVJnY3hFQ09sZkNYRWZrSXBkOWR3TmdJZFNM?=
 =?utf-8?B?czRmZ0NKWjFnUFY2aGZRWEtMUDI4TktwbEoxNUZsQkJRTVdRa3J0WmtxOTJu?=
 =?utf-8?B?UDFYSzZHTVljQk5YZUtobW0zS3ZVWEluWkoyNElUSGFhTkZtRmwyWTRFbG1l?=
 =?utf-8?B?YnR5SXJxa3lzdWhGLzdhTVBlZ2ZabUVDMmRtTkw0andVaDB6V00rdVBXc1hD?=
 =?utf-8?B?b1IwN0s0VGFMOXJ1RlE1M2crWW9aU1J4Wk1qemZRRFBjcVgyVURmY3ZXS0xz?=
 =?utf-8?B?UllVaWxoajNGK2ZLME9iaklTSkdFck9wUnloMjBUTDRvckNFY0x0eS85Qkxx?=
 =?utf-8?B?Wk1tZzVwemxmcmQ4TWdVQk1ld2NkUGdPaVA5bGhzdTd4TWYvUFUrRTVjUFBz?=
 =?utf-8?B?OUNTT1JWd3RLeFNuZ1ZLYlhtcms2TWNWMGNqRUJJZnlNT1JRM1ZQejZvYllS?=
 =?utf-8?B?eVZHMkdBdXBtTU1JZjRPQk5hNGlZUGZFQVNnV0lXNWR5Z0E4TG40ZGR1MlF6?=
 =?utf-8?B?UVZBam1POG9VVTRUTjUvTDNlOXhyZzBGdkFYdTFNbC85MVNybTJBaTFEL0xL?=
 =?utf-8?B?cldlSzlvN0JnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9016.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGdyUFhWT1F6V04zKzI3Rm9na2ppVkdGKzI5Sk1XWnh6dnU4WFFUcnIzeG9P?=
 =?utf-8?B?WHRscFhOQXk2d0RvSGwwV3EzQ3VVWmN4U0xFUFViUUJRaFcvSEY0NlEzeGUv?=
 =?utf-8?B?dEJ0c3ZSZ0lMQlNXdFRvc1BVeTd3RUNUV2w0YXFIbHBzR1lUSnZTS1ZnT1Rz?=
 =?utf-8?B?dnVGTVdaSVRmV2xKYnkwTEgrRGxnQU9sblRlb3JXcXZCWnAvTGxybWErSEdU?=
 =?utf-8?B?L2tRN2tDb3UyZDBKTk5lMHZhWHdYaDMrWE1aRG0vYjVVRTc5ZHlxTG45WVpq?=
 =?utf-8?B?WXpoZnhiUWgyRXQ1TE9NMzJNdWMzTWFqaWErQWtkbW9zQWdMK0ZZM0t1V2s0?=
 =?utf-8?B?WERPNUVHVUNOMzJBd0kxNGdQbGoyNG5LYThVTTRyY1RSQkxWdS9PRU8wM0lm?=
 =?utf-8?B?bE1PMFRMczluMm9xc3dUQWVmZzlwUENTbFV6bUh3cnVvQ1h0REpDUWlURk55?=
 =?utf-8?B?TlN6RkVzeEsrRkN5YUx1cjJteEVta1ZpYnVVY0JZdTh4aGdQaExjV1FkeThC?=
 =?utf-8?B?OW5teFRrVGNoOUJBOHBwY1JtNUQySDVVRitjYVZwaGdiRUxGK25TN1ZzaXhZ?=
 =?utf-8?B?eEJmRzcxUlhRSnloTzM3dkE0d1diQ2VkODZEQWVVWHEvR1NYMVR3K3ROOFpu?=
 =?utf-8?B?aXJKY3lQdTdBWnRmejZtVUh1MzVhTTJPaG9kcXQ2QjJicVJkZVlRam9mUzBl?=
 =?utf-8?B?MEw4dzYrTDVYTUVZbjdlKzN3WjAvYTJPN3Ftd3dvNWlTd0hIQ3h3RmhRUnRw?=
 =?utf-8?B?UmJKeTdKbUs0WmExbWhmMVBIR2Y5OExkUmhGdkc0S2h4NzhpMTRiZ3VTdEVB?=
 =?utf-8?B?YnF0MUdxZVdWNHVCT1gzK0NZK3NYb1pUd2hHZ1hKbU1aSEdoQVN1b3hYcmY2?=
 =?utf-8?B?ZFQ3bWtpbmRPbGpMZjd3NHJOUGtkcVlVWkl5VjY3dDhaeXkzWWw4M1ZsWVd3?=
 =?utf-8?B?aU8zMlJhTXlrbG1zSFBSSjdJYWN1dTN0ZjVzSFF0a01wbVlMQ2ZKbGxwTGE0?=
 =?utf-8?B?b2FPUndXdG9QbUdxVHcrK3EwMDRCdjlYWE0zdjJYS0dlQVR3bkpmTkdtdTAz?=
 =?utf-8?B?LzZIemt0TWNOYk5IeksrN3BXTU83QXQ2V2pOWUtMNkFVNEtvZHFLdlhUa2J0?=
 =?utf-8?B?OEl0bnloUlNvK2doMitsTkN0MmlHOG8xZDU0WEtXVzBNbDdtKzRjVFlOcE5l?=
 =?utf-8?B?eldRVS90NTMxM2p0WHF1N3Z5dUU5Y3Y1anJSckt1MllEb3lwVVNRWW1XVTFE?=
 =?utf-8?B?WU96anR4SWZEa1lySDJIVExGOWorclIwTlBvcER6YWJ5cmNua0k1eHdJQlVa?=
 =?utf-8?B?aXd2emtMTnR3NExlaFBlZG5MUEU1M01OSDAwNmxtOU4waUJjM3dxMWNQKzhX?=
 =?utf-8?B?dEEvU1M5aWw5S09sYW81Q3grN3lBSTNQcVFBR2hOdFI1Ym14Q0YwRlNsUmFR?=
 =?utf-8?B?OExuVWw5bm85NEFjdE1OV1A5bmh2b3F2eHQ0Z1BzdlpSS3ZyWUkrVlM2YWor?=
 =?utf-8?B?dmhUVXVselYrc0hQTm90OHNBMHpxa01rQ2pLSW9GUjNEdzlRR0hwcW9LWVBl?=
 =?utf-8?B?ZmJCN2lEUE9DbFd1Z3BXNTZmZkJuOE5BQW4vSythMmtKMEttTnRieWVCdUl6?=
 =?utf-8?B?R1FzMStzdjNsbU5PQmNod0JWTGQzZVhCNDRzVWMwcVcwN3F3WWpyeGRrUE9D?=
 =?utf-8?B?NjFndlV5a21JQ0pxT1VqR0U0MU5tbDR5TGRoTDVvaHFkMnNVMGhib0E3eFJG?=
 =?utf-8?B?K2JaWURpeUduT29RcG1XK3JpWnVyR3hMMWVMTzNycjRxL002UkZqUWI4QUpQ?=
 =?utf-8?B?RlBJdEIwTVhoa0RQYmhJK0pZRzBOS2hoRXdYa0JBT0NYa2R4UXJYRFR2V3Rj?=
 =?utf-8?B?eDJlNnZJYTNxdnRiajBZZFdjekpnam5taUoyOWp2TCtJNlZEYzREZ24zaHVB?=
 =?utf-8?B?SnZVM2RhM3NacjZMNVhJSWsxUWZiYm8xdFRKclRPSjE2QXh0clhZYW4zRkZl?=
 =?utf-8?B?MzNRaEQxUzZQTngrNzNUL2JIMGd1YThJTGV5RVErSlJMT2NoNnhUK2dGSThB?=
 =?utf-8?B?NENjUWlSZnlOcU9Va1hCOCtBM0FBdnFnSjNXTVJCWk0xQ3FtTHArVjlHNWJG?=
 =?utf-8?B?SXErUVZET2dNT29uNnY5MkZMZ2h2RzVITThiVm5SV1JuUGZDdmhCc1ZvdTFQ?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9016.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e28d4fe-44cf-49a1-64bd-08de121873ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 09:42:16.2431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/OkuABFdQEKggzX+n9ORL4mdH8KHWcsH7e9mOXC3F1tbFnXOTYs70G/0rmIj2Znf05SJnk+oNksK1L1ez7x3O/6dc5+pEjYHXnmAv/YsdSWACk7QDjltkiYli1iR01A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5878
X-OriginatorOrg: intel.com

KyBHb2xhbiAsIEpvaGFubmVzIGZyb20gSW50ZWwgV2lGaSBQQ0llIGRyaXZlciB0ZWFtLg0KDQpI
aSBCam9ybiwNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEJsdWV0b290aDogYnRpbnRl
bF9wY2llOiBTdXBwb3J0IGZ1bmN0aW9uIGxldmVsIHJlc2V0DQo+IA0KPiBPbiBUdWUsIE1hciAx
OCwgMjAyNSBhdCAxMDo1NTowNkFNIC0wNDAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IHdyb3Rl
Og0KPiA+IE9uIEZyaSwgTWFyIDE0LCAyMDI1IGF0IDM6NDDigK9QTSBCam9ybiBIZWxnYWFzIDxo
ZWxnYWFzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4gT24gRnJpLCBNYXIgMTQsIDIwMjUgYXQg
MTI6MTY6MTNQTSArMDIwMCwgQ2hhbmRyYXNoZWthciBEZXZlZ293ZGENCj4gd3JvdGU6DQo+ID4g
PiA+IFN1cHBvcnQgZnVuY3Rpb24gbGV2ZWwgcmVzZXQgKGZscikgb24gaGFyZHdhcmUgZXhjZXB0
aW9uIHRvDQo+ID4gPiA+IHJlY292ZXIgY29udHJvbGxlci4gRHJpdmVyIGFsc28gaW1wbGVtZW50
cyB0aGUgYmFjay1vZmYgdGltZSBvZiA1DQo+ID4gPiA+IHNlY29uZHMgYW5kIHRoZSBtYXhpbXVt
IG51bWJlciBvZiByZXRyaWVzIGFyZSBsaW1pdGVkIHRvIDUgYmVmb3JlDQo+IGdpdmluZyB1cC4N
Cj4gPiA+DQo+ID4gPiBTb3J0IG9mIHdlaXJkIHRoYXQgdGhlIGNvbW1pdCBsb2cgbWVudGlvbnMg
RkxSLCBidXQgaXQncyBub3QNCj4gPiA+IG1lbnRpb25lZCBpbiB0aGUgcGF0Y2ggaXRzZWxmIGV4
Y2VwdCBmb3INCj4gQlRJTlRFTF9QQ0lFX0ZMUl9SRVNFVF9NQVhfUkVUUlkuDQo+ID4gPiBBcHBh
cmVudGx5IHRoZSBhc3N1bXB0aW9uIGlzIHRoYXQgRFNNX1NFVF9SRVNFVF9NRVRIT0RfUENJRQ0K
PiBwZXJmb3Jtcw0KPiA+ID4gYW4gRkxSLg0KPiA+ID4NCj4gPiA+IFNpbmNlIHRoaXMgaXMgYW4g
QUNQSSBfRFNNLCBwcmVzdW1hYmx5IHRoaXMgbWVjaGFuaXNtIG9ubHkgd29ya3MgZm9yDQo+ID4g
PiBkZXZpY2VzIGJ1aWx0IGludG8gdGhlIHBsYXRmb3JtLCBub3QgZm9yIGFueSBwb3RlbnRpYWwg
cGx1Zy1pbg0KPiA+ID4gZGV2aWNlcyB0aGF0IHdvdWxkIG5vdCBiZSBkZXNjcmliZWQgdmlhIEFD
UEkuICBJIGd1ZXNzIHRoaXMgZHJpdmVyDQo+ID4gPiBwcm9iYWJseSBhbHJlYWR5IG9ubHkgd29y
a3MgZm9yIGJ1aWx0LWluIGRldmljZXMgYmVjYXVzZSBpdCBhbHNvDQo+ID4gPiB1c2VzIERTTV9T
RVRfV0RJU0FCTEUyX0RFTEFZIGFuZCBEU01fU0VUX1JFU0VUX01FVEhPRC4NCj4gPiA+DQo+ID4g
PiBUaGVyZSBpcyBhIGdlbmVyaWMgUENJIGNvcmUgd2F5IHRvIGRvIEZMUiAocGNpZV9yZXNldF9m
bHIoKSksIHNvIEkNCj4gPiA+IGFzc3VtZSB0aGUgX0RTTSBleGlzdHMgYmVjYXVzZSB0aGUgZGV2
aWNlIG5lZWRzIHNvbWUgYWRkaXRpb25hbA0KPiA+ID4gZGV2aWNlLXNwZWNpZmljIHdvcmsgYXJv
dW5kIHRoZSBGTFIuDQo+ID4gPg0KPiA+ID4gPiArc3RhdGljIHZvaWQgYnRpbnRlbF9wY2llX3Jl
bW92YWxfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndrKSB7DQo+ID4gPiA+ICsgICAgIHN0cnVj
dCBidGludGVsX3BjaWVfcmVtb3ZhbCAqcmVtb3ZhbCA9DQo+ID4gPiA+ICsgICAgICAgICAgICAg
Y29udGFpbmVyX29mKHdrLCBzdHJ1Y3QgYnRpbnRlbF9wY2llX3JlbW92YWwsIHdvcmspOw0KPiA+
ID4gPiArICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHJlbW92YWwtPnBkZXY7DQo+ID4gPiA+
ICsgICAgIHN0cnVjdCBwY2lfYnVzICpidXM7DQo+ID4gPiA+ICsgICAgIHN0cnVjdCBidGludGVs
X3BjaWVfZGF0YSAqZGF0YTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICBkYXRhID0gcGNpX2dl
dF9kcnZkYXRhKHBkZXYpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgIHBjaV9sb2NrX3Jlc2Nh
bl9yZW1vdmUoKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICBidXMgPSBwZGV2LT5idXM7DQo+
ID4gPiA+ICsgICAgIGlmICghYnVzKQ0KPiA+ID4gPiArICAgICAgICAgICAgIGdvdG8gb3V0Ow0K
PiA+ID4gPiArDQo+ID4gPiA+ICsgICAgIGJ0aW50ZWxfYWNwaV9yZXNldF9tZXRob2QoZGF0YS0+
aGRldik7DQo+ID4gPiA+ICsgICAgIHBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZShwZGV2
KTsNCj4gPiA+ID4gKyAgICAgcGNpX2Rldl9wdXQocGRldik7DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KyAgICAgaWYgKGJ1cy0+cGFyZW50KQ0KPiA+ID4gPiArICAgICAgICAgICAgIGJ1cyA9IGJ1cy0+
cGFyZW50Ow0KPiA+ID4gPiArICAgICBwY2lfcmVzY2FuX2J1cyhidXMpOw0KPiA+ID4NCj4gPiA+
IFRoaXMgcmVtb3ZlIGFuZCByZXNjYW4gYnkgYSBkcml2ZXIgdGhhdCdzIGJvdW5kIHRvIHRoZSBk
ZXZpY2UNCj4gPiA+IHN1YnZlcnRzIHRoZSBkcml2ZXIgbW9kZWwuICBwY2lfc3RvcF9hbmRfcmVt
b3ZlX2J1c19kZXZpY2UoKQ0KPiA+ID4gZGV0YWNoZXMgdGhlIGRyaXZlciBmcm9tIHRoZSBkZXZp
Y2UuICBBZnRlciB0aGUgZHJpdmVyIGlzIGRldGFjaGVkLA0KPiA+ID4gd2Ugc2hvdWxkIG5vdCBi
ZSBydW5uaW5nIGFueSBkcml2ZXIgY29kZS4NCj4gPg0KPiA+IFllYWgsIHRoaXMgc2VsZiByZW1v
dmFsIHdhcyBzb3J0IG9mIGJ1Z2dpbmcgbWUgYXMgd2VsbCwgYWx0aG91Z2ggSSdtDQo+ID4gbm90
IGZhbWlsaWFyIGVub3VnaCB3aXRoIHRoZSBwY2kgc3Vic3lzdGVtLCBoYXZpbmcgdGhlIGRyaXZl
ciByZW1vdmUNCj4gPiBhbmQgY29udGludWUgcnVubmluZyBjb2RlIGxpa2UgcGNpX3Jlc2Nhbl9i
dXMgc2VlbXMgd3JvbmcgYXMgd2UgbWF5DQo+ID4gZW5kIHVwIHdpdGggbXVsdGlwbGUgaW5zdGFu
Y2VzIG9mIHRoZSBzYW1lIGRyaXZlci4NCj4gPg0KPiA+ID4gVGhlcmUgYXJlIGEgY291cGxlIG90
aGVyIGRyaXZlcnMgdGhhdCByZW1vdmUgdGhlaXIgb3duIGRldmljZQ0KPiA+ID4gKGF0aDlrLCBp
d2x3aWZpLCBhc3VzX3dtaSwgZWVlcGMtbGFwdG9wKSwgYnV0IEkgdGhpbmsgdGhvc2UgYXJlDQo+
ID4gPiBicm9rZW4gYW5kIGl0J3MgYSBtaXN0YWtlIHRvIGFkZCB0aGlzIHBhdHRlcm4gdG8gbW9y
ZSBkcml2ZXJzLg0KPiA+ID4NCj4gPiA+IFdoYXQncyB0aGUgcmVhc29uIGZvciBkb2luZyB0aGUg
cmVtb3ZlIGFuZCByZXNjYW4/ICBUaGUgUENJIGNvcmUNCj4gPiA+IGRvZXNuJ3QgcmVzZXQgdGhl
IGRldmljZSB3aGVuIHlvdSBkbyB0aGlzLCBzbyBpdCdzIG5vdCBhICJiaWdnZXINCj4gPiA+IGhh
bW1lciByZXNldCIuDQo+ID4NCj4gPiBJIGd1ZXNzIGl0IHdhcyBtb3JlIG9mIHRoZSBleHBlY3Rh
dGlvbiBvZiBDaGFuZHJ1IHRvIGhhdmUgYSBzb3J0IG9mDQo+ID4gaGFyZCByZXNldCwgZHJpdmVy
IHJlbW92ZStwcm9iZSwgaW5zdGVhZCBvZiBhIHNvZnQgcmVzZXQgd2hlcmUgdGhlDQo+ID4gZHJp
dmVyIHdpbGwganVzdCBuZWVkIHRvIHJlaW5pdCBpdHNlbGYgYWZ0ZXIgcGVyZm9ybWluZw0KPiA+
IHBjaWVfcmVzZXRfZmxyLg0KPiANCj4gSWYgdGhlIG9iamVjdCBpcyBqdXN0IHRvIHJlaW5pdGlh
bGl6ZSB0aGUgZHJpdmVyLCBJIHRoaW5rIHRoaXMgaGFjayBvZiByZW1vdmluZyBhbmQNCj4gcmVz
Y2FubmluZyBpcyBhIGJhZCB3YXkgdG8gZG8gaXQuICBJZiB5b3UgcmVzZXQgdGhlIGRldmljZSwg
eW91IG5vdyBrbm93IHRoZQ0KPiBzdGF0ZSBvZiB0aGUgZGV2aWNlIGFuZCB5b3UgY2FuIG1ha2Ug
dGhlIGRyaXZlciBzdGF0ZSBtYXRjaCBpdC4gIElmIG5lY2Vzc2FyeQ0KPiB5b3UgY2FuIGFsd2F5
cyByZXVzZSBwYXJ0IG9yIGFsbCBvZiB0aGUgLnJlbW92ZSgpIGFuZCAucHJvYmUoKSBtZXRob2Rz
DQo+IHlvdXJzZWxmLCB3aXRob3V0IHRoaXMgZGFuY2Ugb2YgY2FsbGluZyBwY2lfc3RvcF9hbmRf
cmVtb3ZlX2J1c19kZXZpY2UoKSBhbmQNCj4gcGNpX3Jlc2Nhbl9idXMoKS4NCg0KSeKAmW0gc2hh
cmluZyBpbnNpZ2h0cyBmcm9tIG91ciByZWNlbnQgd29yayBvbiB0aGUgUExEUiBmb3IgdGhlIEJU
IGRyaXZlciAsIFRoZQ0KYWJvdmUgbWV0aG9kIHN1cHBvcnRzIEZMUiBlZmZlY3RpdmVseSwgYnV0
IGZvciBQTERSIGl0IGlzIHJlcXVpcmVkIHRvIHVubG9hZA0KV2lmaSBkcml2ZXIgYmVmb3JlIGRv
aW5nIFBMRFIgdmlhIEFDUEkgbWV0aG9kLg0KDQpDdXJyZW50bHksIGNhbGxpbmcgcGNpX3Jlc2Nh
bl9idXMoKSBzdWNjZXNzZnVsbHkgcmViaW5kcyBib3RoIHRoZSBXaUZpIGFuZCBCVA0KZHJpdmVy
cy4gVGhpcyBhcHByb2FjaCBmb2xsb3dzIHRoZSBtZXRob2QgdXNlZCBmb3IgdGhlIFdpRmkgZHJp
dmVyLCBhcyBzZWVuDQpoZXJlOg0KDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92
Ni4xOC1yYzEvc291cmNlL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9n
ZW4xXzIvdHJhbnMuYyNMMjE4Mg0KDQpDb3VsZCB5b3UgcGxlYXNlIHN1Z2dlc3QgYW55IGFsdGVy
bmF0aXZlIG1ldGhvZHMgdG8gYXZvaWQgdXNpbmcgcGNpX3Jlc2Nhbl9idXMoKQ0KZm9yIHRoaXMg
cHVycG9zZT8NCg0KPiANCj4gQmpvcm4NCg0KUmVnYXJkcywNCkNoYW5kcnUNCg0K

