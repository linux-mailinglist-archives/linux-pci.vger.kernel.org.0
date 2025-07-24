Return-Path: <linux-pci+bounces-32881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F8FB10860
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 13:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52AEAC39BD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5C2269B01;
	Thu, 24 Jul 2025 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0TyCq3N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D51E9B2A;
	Thu, 24 Jul 2025 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354848; cv=fail; b=KvIWR+r2PmuHRnRLGkHs6vAm21mYups/HCjjgH0FE1LveQqEcTqN2Q6u7mOOo2owqrnaQFOWeujBxdXYI6EN1sl4eEUQ31SiXqt43Ule1IcJlZCS8AS5Q+c0t5AXdhhK1w0LWy+261CxiBAxiEqs0zg3hGcdF90oi/TQnJaedAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354848; c=relaxed/simple;
	bh=0GtLa0gn4Djvt5yRAqAb3VtoSIr40fi0kijBawa2y7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RbBUFaBR5v9GTCysYaqhU7u/LrtQLdQHHzx0NZ2/bgVjpi1LzL5YpxqZGPbXb2hE2T/Fb96suKpK687JWvTdF1rGAX9CgzTsV5wPgG1Hc5a5zQBVLlA63nsSS7rCnDZxxt8bKndd1Shp2+tiOVsOW3zeCiUHW4T/XiCVM4OTG40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0TyCq3N; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753354847; x=1784890847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0GtLa0gn4Djvt5yRAqAb3VtoSIr40fi0kijBawa2y7E=;
  b=Q0TyCq3NTHIqIEBtqG8N12G//3fQQhFOeP2YZo8laAXSnsyV77A1i/H0
   BJ5aI3XhrzPaNmZGHpI/5BQRh0wllM9eAo9n1I+OmQrH+R9/Zx4C4tMQp
   f+xc5H2RJU44tyjvYrgOabiZhwSM3c1fQguAOMuxbeGnqsxc2bIWBbP/7
   p9k/IVCpL5IQSBLdVzhlyVLFR9FD+6z0U9tbpvrN9msjPyUE2vX+JZLLZ
   eJiYly2VS2/3/2lBdwYwtw/MUO75phQ3bO3SMjqnbe337DCBmC8L8RmDn
   8QdoPe6bJgiHxxZjHAbXfcDPZnCUPqc3SMbJ9VSRlbtZNAeFD+LlBGAY9
   g==;
X-CSE-ConnectionGUID: Ij1fNIKPSpqdJo69m2/wAA==
X-CSE-MsgGUID: /RX38R37Rqu3mu7Eb+LLCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66227539"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="66227539"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:00:46 -0700
X-CSE-ConnectionGUID: /YcvuglCRKKZKqOMus5jww==
X-CSE-MsgGUID: bUBAJXpuTNScX9epLNw9Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="165701181"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:00:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 04:00:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 04:00:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.60)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 04:00:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMyNeJwm+BKAjrJMX269XxSwm73cqAnj6X4RggZPrSDHIA8Yy6dBQEqL5oammUIggDZkOyXTfzy15DSwaBYxJFdBThoSK4o/fRaZTexuX2gJcxYfI3on9yhlmyoYWdEzHHyiDPud0UI4YwRj3ZPm8XqNBARy4z0JmdphxN2CELs7Q4NK4FWsLtnsTKBGUUmyuX34gKzyY7lECBjK4KDn/2kMWp1EfQJ5aTSEz+8Z23FHaXmz0dp0JO/0DkbRDRorpGT1aXHtqXJOH6r6tY2eoI2Aw09SFiPkq74dDHrPAxZxtoHWj9Ns0u+KyzPdAkAcyWmEgWYP2HHoYp7SiEeb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GtLa0gn4Djvt5yRAqAb3VtoSIr40fi0kijBawa2y7E=;
 b=W3cenghLO37zT/nyMzbUWqD2m9S5FjYwLrQDGsL2Yqyf7NnUY7q8AK/fTezSVT0BNzwOakTpTO4zBuEjqUha+9tsqnP1BixfGNDd0xmVQfTgmH19NvfT36sEXLLU9KCpOMHtI2qqSZ0/miig05borpQK5EXF1nWbO9sWFtqPL2PpjQA6qe0tz5Yutgt/67JVKyzr4WuOKKxtIKUu3GvOc2hqHepkILLe7l61K2uSsDn98ny6OSTOPiEUTwPvsA4iKnPUeY+qAJDI+oLgIYUy+17em/yBt4aGphnAXbqSHoYX1fZBt7YHWWCuB9feHcwpCX/PbWf6Ob69rkeaGItp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SA2PR11MB4825.namprd11.prod.outlook.com (2603:10b6:806:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 11:00:42 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 11:00:42 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v5] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
Thread-Topic: [PATCH v5] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
Thread-Index: AQHb+9dtOes1mInNPkalf/M6FIzy4bRAuc4AgABiWyA=
Date: Thu, 24 Jul 2025 11:00:41 +0000
Message-ID: <PH0PR11MB7585B5D59A152CAE89ED3B29F55EA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250723135715.1302241-1-kiran.k@intel.com>
 <jn33hvzv6mnhij2ihkuwrwpv2nfkypdjecvjy2flfzli3dju72@44kspi4tzalw>
In-Reply-To: <jn33hvzv6mnhij2ihkuwrwpv2nfkypdjecvjy2flfzli3dju72@44kspi4tzalw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SA2PR11MB4825:EE_
x-ms-office365-filtering-correlation-id: 70161d26-d7e6-4e05-9e8b-08ddcaa154fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bFgzV1Ryci9pNjNZeWE2MTFuNFR4QSswd3IyaG5kTVc3UVJpbDVDSVhiYTdR?=
 =?utf-8?B?ejNGQkVBbGV0WWxodGtleFFlbFNodnE1QTRoYnJlWGU1Q0RacHJnVGF4NTRr?=
 =?utf-8?B?L0hjREdIRWN6dzZ0SWVVWVc2TmxERWtETC9sRDhEdThxbHNPdnppSTBDVHNO?=
 =?utf-8?B?enpzV2lZbkVoVGhCWFZUK3RFL2RBZldnTG9KMXRPc1RraXQ5dTlVQ3gwbGZz?=
 =?utf-8?B?a1BzdVZ2QmZKaDg5MzlObmJleWxCMzA5WmdwK3FqSFQxbndEcWJEbmtDWmJy?=
 =?utf-8?B?OFE2d1J5RkRwSXRCWUNyQk95VnNKeTZYYzgvUU4xNmZ5OGlMMGVoUHpRWk90?=
 =?utf-8?B?MHUxNUpLWmZFUjZXc1F5M0tuOUtzUS94MDlid29zSnVOclp2Q2R5RXgxa0JF?=
 =?utf-8?B?YXJLYzNIRW9pMkJwSFJTTDlMQXVTUko5eGpSWWRUdFRnMS92VmNud1N0cXg5?=
 =?utf-8?B?ekE5dk1DbVcvTWEvQkZRTTdWbTBZSXRtZ1ZKTkQ2cUhUazNucW1HS3ZORU9Y?=
 =?utf-8?B?RmFUOGtMbGFlVHpPcW1mNEFmTU95NjBYWk52NUpmdE9yd1NJRWpHNDRzT3Vl?=
 =?utf-8?B?cmRWT0dEaGx5MmIwdlJ5d0xJRDlWK3ZyaENmcXpnVS9TM3JRZktzT3Q5SFFO?=
 =?utf-8?B?bzJRQlFVZUQxcVRYVk45dzBJcGNPWWdRN3RvYVdDTWlwVnZyY0ZYZWlscFl4?=
 =?utf-8?B?STRXY2pvRHpNQkN5U1JHN0pOOWYxNk1MWVFObkdvWDhvRldxRkN1cTJXT3g3?=
 =?utf-8?B?OGx1cVFPa2EzbDlpUXFnYWlsanhXbHFzbzQ5STgyd201MGFSVDJEenVKdkha?=
 =?utf-8?B?TWJ3NExYN1B5VHpFcGRLOVlZMjRkM1FqQkpSQkliZjBaT2lPU05STElSMUw0?=
 =?utf-8?B?T29EaFdGZFBQSVF5NkJBbmJKYXhZUlZMQWZENkg1eE93ZHBrYXIxbFBrbXYw?=
 =?utf-8?B?OTdOWjZtWW5BcGlhYkxvY3RoRzhnYmhVVkFxZ0lTUmE3MU1IN1hiVGJWUDVx?=
 =?utf-8?B?Y1ptbEw4RzRBZVJ3RS9CaDhTaXU0Y1gwekVneEt1ZmxhZE8vMGNyb0xVZ2FK?=
 =?utf-8?B?Wnl6M0EvbEt2RXVEeGFxbkVtaUc4U2FhRDgrMFFWZzNRbStZamZaMmJncTFY?=
 =?utf-8?B?QXY3UTJsT3ZSQ3d0OVRhVkR0L21raUFXTE1WVVUxaVduaU5LN0xuU09LQUVs?=
 =?utf-8?B?dTR3WW5DMFdqRnI5RDl6MVBLRnhaMWk3MDYyVlpxV1VaeVJPcHV3QVJkMTZP?=
 =?utf-8?B?dE9XajNTNUkzS210MG84QklCUVZjYTZoRFpKeko4R3FVSTNrSm02Rm1WTmRN?=
 =?utf-8?B?M0ZPdmxjV0NwQVNUSVdiZHFWQlFuNytWUDVxSXVxM1RibERHRlQxM2ZNTmFj?=
 =?utf-8?B?c21VOXQwbUgzSzBQMVRwVUphSDR3cjVKYnpjUG93dU9XcTBNSjdCa0VDWHNG?=
 =?utf-8?B?S0tYaElHMW9xZ2s4TW1CN0YxMVRYVi8wdk43cE5VQjcrV2h1VFhET2oraStX?=
 =?utf-8?B?MVBLQ1ZRNUhlOEp6dExEMXptTEE0TzUybFFwMVZzdUI5Yi92QjBqVzBzSjhi?=
 =?utf-8?B?M29mdVNJaEhyVXBjdm9FWUk4VjZVc00xSUh0c01iWldqMVpMMUNVUXYxL0xl?=
 =?utf-8?B?YUY4L0JkcEh2cEdZa1RycDlPM0x0QWhGZThqQ1h3S0RQNGFZN0pwRk95aCty?=
 =?utf-8?B?SkM3QzlMdWpxR3Q1WTljaDZpMkUxRExYYVc5R1NGWkJwQVVaZEJ4azFDMytr?=
 =?utf-8?B?OXQ5ZERRYzZvTGRjM0pDaHB4ajNxdkxWTGh6TGZCMVZiTWU4d0wzZTVJZVBo?=
 =?utf-8?B?TEFKdnplbmN5ZnJaNWJOQ1plMzV4TFF3SFdYdjU0MFB1MkNLOC9jWWsxcyti?=
 =?utf-8?B?bGwvdjFqYkk1TVJrR1c0U0hHckd4OGMyTkwrRWpvQTl5aHVUcmF0L3hQSjhs?=
 =?utf-8?B?K1JXNlJkUEVKdm9MNHZXalhXWHBDZWQ0Vkl2NTg2dWxLUkM0NGJ2d0hnUFpi?=
 =?utf-8?B?aGx3algxRGF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGNEUnVJMzY5eEFrZVFlUjBOUEdRTVFob0Irc1o0ckhMVFZETmZlM3diWlVk?=
 =?utf-8?B?OFVOY3ZoeEUzanl1T1pLRlBLSDAvWml1N0xTenpSb0NVZFlYVVhERnZaUzdp?=
 =?utf-8?B?MENnZGQwNTJUV3ZidTJ2ck9RR3hwWEEyNU45QzRtMmp5dXZSNjZ2ZlhGZTZr?=
 =?utf-8?B?QW0yWWZIRmpUVm9jTDUwOTc0UkE3MkdwY3lwNHUzdDM0QUt6Q3IyUXVxZDV6?=
 =?utf-8?B?eU9qZUN1Tm5zSU9Vd2JkajY1c3pIL2dVYUpBT2lMaEVwS1ZaRXp6SzRIT1Va?=
 =?utf-8?B?MWViMGdjWTN0VXNiNWhpL1V4Z3luZnJRc2JqMXJkMWFON1ZPZFhTbjAwbXZx?=
 =?utf-8?B?czB5bTFWRkEyREdESEJlcHp4MTFXTDlXWHFZNVBnWExqbCs0WnZRWWdRUnN6?=
 =?utf-8?B?c3ByNDUwSUdlWktvaStNUDAzck1XckUranV1MmhGczZ3aFQ0empEeGR0Ynk4?=
 =?utf-8?B?czN5NEV2bElzMmM2VWdOYnlERk9tQldzYkp2THhEYk1TVGFhWExoN1VrZDFt?=
 =?utf-8?B?Z2l6eXRtQVl2a3EyL3g5OUdPNU9ZVE1tR0ZETzRJdWRXY3lCdDVsMmRpbEhR?=
 =?utf-8?B?WmcwZFNRcEN6eDY5RU5HTmFtaHNwRTlrWmRuOTlxbzIvcGhuQ0ZCOGVYSTRy?=
 =?utf-8?B?UDJhekFRWjBmb3NoV3dMV0N5aDI1Zkd1ek0zcmN2WXNWWFd4eFR4QWFSSFY5?=
 =?utf-8?B?R0hQY2xZNHAvSUZjbjF4R3Q1ZXVmcXRlZlJCK3JxY1MxUVpCVUs1Z0FOZjM2?=
 =?utf-8?B?U0ZRZTBYQTJjZ0hwdkZ3NVdaUnl4Q0YvRC9jUlVnRmFseFpSR2lqZWRwRFVD?=
 =?utf-8?B?VDJGQnVyTVRnVGFsMUNPTDVscDdwa3V6Zk9VdzNSUGhTUzdjdVNnOTRibS9v?=
 =?utf-8?B?Rzh6cWhFWUJHbUZRM2laVUZyMmg2bGFEUFFXTlVPcjNaVVZIVk9UUUNZRC9N?=
 =?utf-8?B?RWJqbGwvZTliWmNwNkhOZzg3RXg0SUo5ZS9Eb2JjZzZyK3B0ZVVOVnp0WGs5?=
 =?utf-8?B?eEkxTnBIY0dLZE03TXVqWkdVNnVDUzV2Ni9VSXl1NUs4QXVKamxuaWxxUnZm?=
 =?utf-8?B?RGI5S3BlUTVJYUE3eGJyT0xHMDA2MXVSa29adEloQ2Zib2RaQVdFVG8rUDd0?=
 =?utf-8?B?UzVzT21nME56R0RwMXFxenhicDlXK2NHam9mZlRjTHVMUlJ0a2RNSWxZQ1Zu?=
 =?utf-8?B?a3ljU3NmcWU0UDRvT1RqUnMvT1hHSjFiTDB5UVRZUEpjaCtHQ2ZzSHVtdmk5?=
 =?utf-8?B?SHorKzlZV0lqN0loWjNMNkJaMUQ4RURMUHZmYXJYUjI0b1NxOU50WVl5QXNB?=
 =?utf-8?B?YnZ1UGVPVEpDNmxhZ3VmcFY3YWR6THVGcWloajBJaHpYUWhROFBLSURCQVdr?=
 =?utf-8?B?RSt6dnh6UE5tVUIxdFlRMXFrWXg4bThCdFBRbEkxaCtLTE1NTXJQSDY5dUFv?=
 =?utf-8?B?U1lFWk5pNVpBblZYV085eVRkN3ZzbTV6TSsxVFhaZDRjNDNPeFNCdnpjaDRh?=
 =?utf-8?B?YVpMZ3Y2eDB3SUlFd0lSb2NHUDRGTGtCNjUzaGRPMFhCTVFnS2ZwZE5nSmVH?=
 =?utf-8?B?SVhLNmJBRTJsdXpsbExJRTJMSWpyVEF3QXNIMlp1emU0ckM3L2JTWExXNEtR?=
 =?utf-8?B?Mm5aMElyQmx0dUx4Y0ZxUks0QUQwbE51ejN5anJXQ21hN1FZM3dyTFR5ZndS?=
 =?utf-8?B?T2hVeDZqQklmWFRNekh2WDNXNE9LSVBOa3B5VklPaWQzZFNrUkdQZ0RnVlZh?=
 =?utf-8?B?ajMxWS9QeVM2MDdnZkJsMVRLTUx6cVJHa0JOeGgxTFkrcUZER3ExUUloSFlr?=
 =?utf-8?B?RWRRc0QxaXpWLzBoZ1dKM2Y5d1dIMWxtaTdNMnllbjhuUmV4SU1EdXQrcjRj?=
 =?utf-8?B?MjNNTS9FWm5HaGd0dnFBVGpHUk9INGJteUcyUjhSWGd4ZlRpWnZrd1NxYTcv?=
 =?utf-8?B?WWp2V0VSRFE1VkorSTladjd0RjAvL3JGQ213eDFEUm9lNEx5aXZtQjRNMEJ1?=
 =?utf-8?B?a25qVnA1VDFaVC9ScllkeXEyTGdFMWpBUXFYYlFudDE3TitNTjA4OTJSeUtk?=
 =?utf-8?B?R1ppS3hSVVVkVk51dUJ0b3FuSXBRd0dpSU1TWmwyUVF3VjEvUmdQaXIzRU85?=
 =?utf-8?Q?ghnM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70161d26-d7e6-4e05-9e8b-08ddcaa154fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 11:00:42.0148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FDf7S+GsWvE0hx7S7GjA5bbjtxUqi8ffuCb04hph8SH3A4zlNidMUal+VCXcCQ2VzBvjkYvQ+vXpbXx9GAHMCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
X-OriginatorOrg: intel.com

SGkgTWFuaXZhbm5hbiwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuDQoNCj4tLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaUBrZXJu
ZWwub3JnPg0KPlNlbnQ6IFRodXJzZGF5LCBKdWx5IDI0LCAyMDI1IDEwOjM3IEFNDQo+VG86IEss
IEtpcmFuIDxraXJhbi5rQGludGVsLmNvbT4NCj5DYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2Vy
bmVsLm9yZzsgU3JpdmF0c2EsIFJhdmlzaGFua2FyDQo+PHJhdmlzaGFua2FyLnNyaXZhdHNhQGlu
dGVsLmNvbT47IFR1bWt1ciBOYXJheWFuLCBDaGV0aGFuDQo+PGNoZXRoYW4udHVta3VyLm5hcmF5
YW5AaW50ZWwuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbGludXgtDQo+cGNpQHZnZXIua2Vy
bmVsLm9yZzsgRGV2ZWdvd2RhLCBDaGFuZHJhc2hla2FyDQo+PGNoYW5kcmFzaGVrYXIuZGV2ZWdv
d2RhQGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1XSBCbHVldG9vdGg6IGJ0aW50
ZWxfcGNpZTogQWRkIHN1cHBvcnQgZm9yIF9zdXNwZW5kKCkgLw0KPl9yZXN1bWUoKQ0KPg0KPk9u
IFdlZCwgSnVsIDIzLCAyMDI1IGF0IDA3OjI3OjE1UE0gR01ULCBLaXJhbiBLIHdyb3RlOg0KPj4g
RnJvbTogQ2hhbmRyYXNoZWthciBEZXZlZ293ZGEgPGNoYW5kcmFzaGVrYXIuZGV2ZWdvd2RhQGlu
dGVsLmNvbT4NCj4+DQo+PiBUaGlzIHBhdGNoIGltcGxlbWVudHMgX3N1c3BlbmQoKSBhbmQgX3Jl
c3VtZSgpIGZ1bmN0aW9ucyBmb3IgdGhlDQo+PiBCbHVldG9vdGggY29udHJvbGxlci4gV2hlbiB0
aGUgc3lzdGVtIGVudGVycyBhIHN1c3BlbmRlZCBzdGF0ZSwgdGhlDQo+PiBkcml2ZXIgbm90aWZp
ZXMgdGhlIGNvbnRyb2xsZXIgdG8gcGVyZm9ybSBuZWNlc3NhcnkgaG91c2VrZWVwaW5nIHRhc2tz
DQo+PiBieSB3cml0aW5nIHRvIHRoZSBzbGVlcCBjb250cm9sIHJlZ2lzdGVyIGFuZCB3YWl0cyBm
b3IgYW4gYWxpdmUNCj4+IGludGVycnVwdC4gVGhlIGZpcm13YXJlIHJhaXNlcyB0aGUgYWxpdmUg
aW50ZXJydXB0IHdoZW4gaXQgaGFzDQo+PiB0cmFuc2l0aW9uZWQgdG8gdGhlIEQzIHN0YXRlLiBU
aGUgc2FtZSBmbG93IG9jY3VycyB3aGVuIHRoZSBzeXN0ZW0NCj4+IHJlc3VtZXMuDQo+Pg0KPj4g
Q29tbWFuZCB0byB0ZXN0IGhvc3QgaW5pdGlhdGVkIHdha2V1cCBhZnRlciA2MCBzZWNvbmRzIHN1
ZG8gcnRjd2FrZSAtbQ0KPj4gbWVtIC1zIDYwDQo+Pg0KPj4gZG1lc2cgbG9nICh0ZXN0ZWQgb24g
V2hhbGUgUGVhazIgb24gUGFudGhlciBMYWtlIHBsYXRmb3JtKSBPbiBzeXN0ZW0NCj4+IHN1c3Bl
bmQ6DQo+PiBbICA1MTYuNDE4MzE2XSBCbHVldG9vdGg6IGhjaTA6IGRldmljZSBlbnRlcmVkIGlu
dG8gZDMgc3RhdGUgZnJvbSBkMA0KPj4gaW4gODEgdXMNCj4+DQo+PiBPbiBzeXN0ZW0gcmVzdW1l
Og0KPj4gWyAgNTQyLjE3NDEyOF0gQmx1ZXRvb3RoOiBoY2kwOiBkZXZpY2UgZW50ZXJlZCBpbnRv
IGQwIHN0YXRlIGZyb20gZDMNCj4+IGluIDM1NyB1cw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENo
YW5kcmFzaGVrYXIgRGV2ZWdvd2RhDQo+PiA8Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+PiAt
LS0NCj4+IGNoYW5nZXMgaW4gdjU6DQo+PiAgICAgIC0gQWRkcmVzcyByZXZpZXcgY29tbWVudHMN
Cj4+DQo+PiBjaGFuZ2VzIGluIHY0Og0KPj4gICAgICAtIE1vdmVkIGRvY3VtZW50IGFuZCBzZWN0
aW9uIGRldGFpbHMgZnJvbSB0aGUgY29tbWl0IG1lc3NhZ2UgYXMNCj5jb21tZW50IGluIGNvZGUu
DQo+Pg0KPj4gY2hhbmdlcyBpbiB2MzoNCj4+ICAgICAgLSBDb3JyZWN0ZWQgdGhlIHR5cG8ncw0K
Pj4gICAgICAtIFVwZGF0ZWQgdGhlIENDIGxpc3QgYXMgc3VnZ2VzdGVkLg0KPj4gICAgICAtIENv
cnJlY3RlZCB0aGUgZm9ybWF0IHNwZWNpZmllcnMgaW4gdGhlIGxvZ3MuDQo+Pg0KPj4gY2hhbmdl
cyBpbiB2MjoNCj4+ICAgICAgLSBVcGRhdGVkIHRoZSBjb21taXQgbWVzc2FnZSB3aXRoIHRlc3Qg
c3RlcHMgYW5kIGxvZ3MuDQo+PiAgICAgIC0gQWRkZWQgbG9ncyB0byBpbmNsdWRlIHRoZSB0aW1l
b3V0IG1lc3NhZ2UuDQo+PiAgICAgIC0gRml4ZWQgYSBwb3RlbnRpYWwgcmFjZSBjb25kaXRpb24g
ZHVyaW5nIHN1c3BlbmQgYW5kIHJlc3VtZS4NCj4+DQo+PiAgZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbF9wY2llLmMgfCAxMDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIGRy
aXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5oIHwgICA0ICsrDQo+PiAgMiBmaWxlcyBjaGFu
Z2VkLCAxMDYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0
b290aC9idGludGVsX3BjaWUuYw0KPj4gYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUu
Yw0KPj4gaW5kZXggNmU3YmJiZDM1Mjc5Li5hOTY5NzVhNTVjYmUgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gKysrIGIvZHJpdmVycy9ibHVldG9v
dGgvYnRpbnRlbF9wY2llLmMNCj4+IEBAIC01NDAsNiArNTQwLDEyIEBAIHN0YXRpYyBpbnQgYnRp
bnRlbF9wY2llX3Jlc2V0X2J0KHN0cnVjdA0KPmJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhKQ0KPj4g
IAlyZXR1cm4gcmVnID09IDAgPyAwIDogLUVOT0RFVjsNCj4+ICB9DQo+Pg0KPj4gK3N0YXRpYyB2
b2lkIGJ0aW50ZWxfcGNpZV9zZXRfcGVyc2lzdGVuY2VfbW9kZShzdHJ1Y3QNCj4+ICtidGludGVs
X3BjaWVfZGF0YSAqZGF0YSkgew0KPj4gKwlidGludGVsX3BjaWVfc2V0X3JlZ19iaXRzKGRhdGEs
DQo+QlRJTlRFTF9QQ0lFX0NTUl9IV19CT09UX0NPTkZJRywNCj4+ICsNCj5CVElOVEVMX1BDSUVf
Q1NSX0hXX0JPT1RfQ09ORklHX0tFRVBfT04pOw0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgdm9p
ZCBidGludGVsX3BjaWVfbWFjX2luaXQoc3RydWN0IGJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhKSAg
ew0KPj4gIAl1MzIgcmVnOw0KPj4gQEAgLTgyOSw2ICs4MzUsOCBAQCBzdGF0aWMgaW50IGJ0aW50
ZWxfcGNpZV9lbmFibGVfYnQoc3RydWN0DQo+YnRpbnRlbF9wY2llX2RhdGEgKmRhdGEpDQo+PiAg
CSAqLw0KPj4gIAlkYXRhLT5ib290X3N0YWdlX2NhY2hlID0gMHgwOw0KPj4NCj4+ICsJYnRpbnRl
bF9wY2llX3NldF9wZXJzaXN0ZW5jZV9tb2RlKGRhdGEpOw0KPj4gKw0KPj4gIAkvKiBTZXQgTUFD
X0lOSVQgYml0IHRvIHN0YXJ0IHByaW1hcnkgYm9vdGxvYWRlciAqLw0KPj4gIAlyZWcgPSBidGlu
dGVsX3BjaWVfcmRfcmVnMzIoZGF0YSwNCj5CVElOVEVMX1BDSUVfQ1NSX0ZVTkNfQ1RSTF9SRUcp
Ow0KPj4gIAlyZWcgJj0gfihCVElOVEVMX1BDSUVfQ1NSX0ZVTkNfQ1RSTF9GVU5DX0lOSVQgfCBA
QCAtMjU3MywxMQ0KPj4gKzI1ODEsMTA1IEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxfcGNpZV9jb3Jl
ZHVtcChzdHJ1Y3QgZGV2aWNlICpkZXYpICB9DQo+PiAjZW5kaWYNCj4+DQo+PiArI2lmZGVmIENP
TkZJR19QTQ0KPj4gK3N0YXRpYyBpbnQgYnRpbnRlbF9wY2llX3N1c3BlbmRfbGF0ZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHBtX21lc3NhZ2VfdA0KPj4gK21lc2cpIHsNCj4+ICsJc3RydWN0IHBjaV9k
ZXYgKnBkZXYgPSB0b19wY2lfZGV2KGRldik7DQo+PiArCXN0cnVjdCBidGludGVsX3BjaWVfZGF0
YSAqZGF0YTsNCj4+ICsJa3RpbWVfdCBzdGFydDsNCj4+ICsJdTMyIGR4c3RhdGU7DQo+PiArCXM2
NCBkZWx0YTsNCj4+ICsJaW50IGVycjsNCj4+ICsNCj4+ICsJZGF0YSA9IHBjaV9nZXRfZHJ2ZGF0
YShwZGV2KTsNCj4+ICsNCj4+ICsJaWYgKG1lc2cuZXZlbnQgPT0gUE1fRVZFTlRfU1VTUEVORCkN
Cj4+ICsJCWR4c3RhdGUgPSBCVElOVEVMX1BDSUVfU1RBVEVfRDNfSE9UOw0KPj4gKwllbHNlDQo+
PiArCQlkeHN0YXRlID0gQlRJTlRFTF9QQ0lFX1NUQVRFX0QzX0NPTEQ7DQo+PiArDQo+PiArCWRh
dGEtPmdwMF9yZWNlaXZlZCA9IGZhbHNlOw0KPj4gKw0KPj4gKwlzdGFydCA9IGt0aW1lX2dldCgp
Ow0KPj4gKw0KPj4gKwkvKiBSZWZlcjogNi40LjExLjcgLT4gUGxhdGZvcm0gcG93ZXIgbWFuYWdl
bWVudCAqLw0KPj4gKwlidGludGVsX3BjaWVfd3Jfc2xlZXBfY250cmwoZGF0YSwgZHhzdGF0ZSk7
DQo+PiArCWVyciA9IHdhaXRfZXZlbnRfdGltZW91dChkYXRhLT5ncDBfd2FpdF9xLCBkYXRhLT5n
cDBfcmVjZWl2ZWQsDQo+PiArDQo+bXNlY3NfdG9famlmZmllcyhCVElOVEVMX0RFRkFVTFRfSU5U
Ul9USU1FT1VUX01TKSk7DQo+PiArCWRlbHRhID0ga3RpbWVfdG9fbnMoa3RpbWVfZ2V0KCkgLSBz
dGFydCkgLyAxMDAwOw0KPj4gKw0KPj4gKwlpZiAoZXJyID09IDApIHsNCj4+ICsJCWJ0X2Rldl9l
cnIoZGF0YS0+aGRldiwgIlRpbWVvdXQgKCV1IG1zKSBvbiBhbGl2ZSBpbnRlcnJ1cHQNCj5mb3Ig
RDMgZW50cnkiLA0KPj4gKwkJCQlCVElOVEVMX0RFRkFVTFRfSU5UUl9USU1FT1VUX01TKTsNCj4+
ICsJCXJldHVybiAtRUJVU1k7DQo+PiArCX0NCj4+ICsJYnRfZGV2X2luZm8oZGF0YS0+aGRldiwg
ImRldmljZSBlbnRlcmVkIGludG8gZDMgc3RhdGUgZnJvbSBkMCBpbiAlbGxkDQo+dXMiLA0KPj4g
KwkJICAgIGRlbHRhKTsNCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBp
bnQgYnRpbnRlbF9wY2llX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+PiArCXJldHVy
biBidGludGVsX3BjaWVfc3VzcGVuZF9sYXRlKGRldiwgUE1TR19TVVNQRU5EKTsgfQ0KPj4gKw0K
Pj4gK3N0YXRpYyBpbnQgYnRpbnRlbF9wY2llX2hpYmVybmF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYp
IHsNCj4+ICsJcmV0dXJuIGJ0aW50ZWxfcGNpZV9zdXNwZW5kX2xhdGUoZGV2LCBQTVNHX0hJQkVS
TkFURSk7IH0NCj4+ICsNCj4+ICtzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9mcmVlemUoc3RydWN0
IGRldmljZSAqZGV2KSB7DQo+PiArCXJldHVybiBidGludGVsX3BjaWVfc3VzcGVuZF9sYXRlKGRl
diwgUE1TR19GUkVFWkUpOyB9DQo+PiArDQo+PiArc3RhdGljIGludCBidGludGVsX3BjaWVfcmVz
dW1lKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPj4gKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRv
X3BjaV9kZXYoZGV2KTsNCj4+ICsJc3RydWN0IGJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhOw0KPj4g
KwlrdGltZV90IHN0YXJ0Ow0KPj4gKwlpbnQgZXJyOw0KPj4gKwlzNjQgZGVsdGE7DQo+PiArDQo+
PiArCWRhdGEgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7DQo+PiArCWRhdGEtPmdwMF9yZWNlaXZl
ZCA9IGZhbHNlOw0KPj4gKw0KPj4gKwlzdGFydCA9IGt0aW1lX2dldCgpOw0KPj4gKw0KPj4gKwkv
KiBSZWZlcjogNi40LjExLjcgLT4gUGxhdGZvcm0gcG93ZXIgbWFuYWdlbWVudCAqLw0KPj4gKwli
dGludGVsX3BjaWVfd3Jfc2xlZXBfY250cmwoZGF0YSwgQlRJTlRFTF9QQ0lFX1NUQVRFX0QwKTsN
Cj4+ICsJZXJyID0gd2FpdF9ldmVudF90aW1lb3V0KGRhdGEtPmdwMF93YWl0X3EsIGRhdGEtPmdw
MF9yZWNlaXZlZCwNCj4+ICsNCj5tc2Vjc190b19qaWZmaWVzKEJUSU5URUxfREVGQVVMVF9JTlRS
X1RJTUVPVVRfTVMpKTsNCj4+ICsJZGVsdGEgPSBrdGltZV90b19ucyhrdGltZV9nZXQoKSAtIHN0
YXJ0KSAvIDEwMDA7DQo+PiArDQo+PiArCWlmIChlcnIgPT0gMCkgew0KPj4gKwkJYnRfZGV2X2Vy
cihkYXRhLT5oZGV2LCAiVGltZW91dCAoJXUgbXMpIG9uIGFsaXZlIGludGVycnVwdA0KPmZvciBE
MCBlbnRyeSIsDQo+PiArCQkJCUJUSU5URUxfREVGQVVMVF9JTlRSX1RJTUVPVVRfTVMpOw0KPj4g
KwkJcmV0dXJuIC1FQlVTWTsNCj4+ICsJfQ0KPj4gKwlidF9kZXZfaW5mbyhkYXRhLT5oZGV2LCAi
ZGV2aWNlIGVudGVyZWQgaW50byBkMCBzdGF0ZSBmcm9tIGQzIGluICVsbGQNCj51cyIsDQo+PiAr
CQkgICAgZGVsdGEpOw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArY29uc3Qgc3Ry
dWN0IGRldl9wbV9vcHMgYnRpbnRlbF9wY2llX3BtX29wcyA9IHsNCj4+ICsJLnN1c3BlbmQgPSBi
dGludGVsX3BjaWVfc3VzcGVuZCwNCj4+ICsJLnJlc3VtZSA9IGJ0aW50ZWxfcGNpZV9yZXN1bWUs
DQo+PiArCS5mcmVlemUgPSBidGludGVsX3BjaWVfZnJlZXplLA0KPj4gKwkudGhhdyA9IGJ0aW50
ZWxfcGNpZV9yZXN1bWUsDQo+PiArCS5wb3dlcm9mZiA9IGJ0aW50ZWxfcGNpZV9oaWJlcm5hdGUs
DQo+PiArCS5yZXN0b3JlID0gYnRpbnRlbF9wY2llX3Jlc3VtZSwNCj4NCj5Zb3Ugc2hvdWxkIHVz
ZSBwbV9zbGVlcF9wdHIoKSB0byBhdm9pZCB0aGUgaWZkZWYgY2x1dHRlci4gSXQgd2lsbCBlbnN1
cmUgdGhhdCB0aGUNCj5jb21waWxlciBkcm9wcyB0aGUgZnVuY3Rpb24gZGVmaW5pdGlvbnMgd2hl
biBDT05GSUdfUE1fU0xFRVAgaXMgbm90DQo+ZW5hYmxlZC4NCkFjay4NCg0KPg0KPj4gK307DQo+
PiArI2RlZmluZSBCVElOVEVMUENJRV9QTV9PUFMJKCZidGludGVsX3BjaWVfcG1fb3BzKQ0KPj4g
KyNlbHNlDQo+PiArI2RlZmluZSBCVElOVEVMUENJRV9QTV9PUFMJTlVMTA0KPj4gKyNlbmRpZg0K
Pj4gIHN0YXRpYyBzdHJ1Y3QgcGNpX2RyaXZlciBidGludGVsX3BjaWVfZHJpdmVyID0gew0KPj4g
IAkubmFtZSA9IEtCVUlMRF9NT0ROQU1FLA0KPj4gIAkuaWRfdGFibGUgPSBidGludGVsX3BjaWVf
dGFibGUsDQo+PiAgCS5wcm9iZSA9IGJ0aW50ZWxfcGNpZV9wcm9iZSwNCj4+ICAJLnJlbW92ZSA9
IGJ0aW50ZWxfcGNpZV9yZW1vdmUsDQo+PiArCS5kcml2ZXIucG0gPSBCVElOVEVMUENJRV9QTV9P
UFMsDQo+DQo+SGVyZSwgeW91IHNob3VsZCB1c2UgcG1fcHRyKCkgZm9yIHRoZSBzYW1lIHJlYXNv
bi4NCkFjay4gIEkgd2lsbCBpbmNvcnBvcmF0ZSB0aGUgY29tbWVudHMuDQo+DQo+LSBNYW5pDQo+
DQo+LS0NCj7grq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u
4K+NDQoNClRoYW5rcywNCktpcmFuDQoNCg0K

