Return-Path: <linux-pci+bounces-15926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3C29BAF73
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 10:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD771C2189F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FB14B06C;
	Mon,  4 Nov 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nviNdUga"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36BF6FC5;
	Mon,  4 Nov 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711915; cv=fail; b=C4KyH8s4hjjYhT7SSqVqrdJZPt+mwJBzfDOZPrjIoZnzLXEs/a3FdFo1xKoEXWA136ReRKCCsilw6d7v+4zsp3ilYJjzfS54WlKqEp5dlPbKO7fQSEK4v2HHR3z8/TLL26qfquoT8+f0sAify54pWFyVBnQCeIbGjYlWopOx9wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711915; c=relaxed/simple;
	bh=ClTgiC7TDbb18N83uQxBiG+E6YSz+gLCVTN7/fRuJ3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jrmnmYtOrH+fMrEdUKHOb0R02Qj4VqqClfJpmsAlJ3Z9hxVYiB8fulB+85QfsHMKWmVP+PdXdQTegv6gvRpl+cwL1+nyyr706lsFxJ0tVZtLSM2rPbSQ8DRJCF70eKHkpfrdgsJIuNuSMwKlhEZ+TF9ayDaVZdMK7thdzIzWJns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nviNdUga; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730711914; x=1762247914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ClTgiC7TDbb18N83uQxBiG+E6YSz+gLCVTN7/fRuJ3k=;
  b=nviNdUgawr3VG/cD5NwPtk97uuDV2EJ4zBpu6HTw03KCuynidSw0AMJy
   ep6PnfPwGuHeAvzZrS1PIE5H9NM9aaZKfYz2WvSpNvMq3ww0oTMSzfOJ3
   jf4+Gm8qdw9oSchCCwzlmRRcaVyB0wy/VYdQG2Iq+CAnQiehuP2wrV1JA
   eyxgqypW3U5dhcXNOJoxow33YKDUL1UhaV9Wle7hwfUB9BbG7AqqsC/7f
   ygWyF2ANtiG39XCbIIbTRTczMoPfMwS5ozMtiLe7sJG0mrPkTYeZPAWSo
   p7trVbIDgespPylcd5+XCoX/neqqVz/ybNUCodoDQ++TZ+3GqBusH6UEY
   w==;
X-CSE-ConnectionGUID: 5yaQ/I/lQ4S1U2YIZh6bng==
X-CSE-MsgGUID: lfdpE82HSKiaq9EwUM7Tgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30276447"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30276447"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 01:18:33 -0800
X-CSE-ConnectionGUID: 2G5TDQtiTfu6xpS6bYT/Bg==
X-CSE-MsgGUID: 5ZIBpuk2RPCEnlL9yR1UYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83478069"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 01:18:33 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 01:18:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 01:18:32 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 01:18:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwmnRg2qYX4hVY5v7amZCkmKXkoqDgQR8VJsQa9H02x6HDJ4EVKssZgD4Mdvi67bBADZpDgsjmTirbpGBx0bHtgLPJ27Mizgo35tQiu/oOM54vMHgJ1Gnt9yNUPrJzElnUaurmHbJgi6hqfx/d6S1OPEkD089jQwdBjc3Sv0Efahincmfrm5TS4IhQ2xaommEemtVgfRv8WaYRjOJQ+toPL5uA/UECSS8oyIzvfMujgpLP7tHBS7cC6VjLKvo1a/NrJWIGMhq6apOTnnAMAhLHaeV3AKUXMyNqgJ30EPJa2ytC6hQ3M0jPySNoir1SyOKPoqbN3LIsbRXdYcMtqPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClTgiC7TDbb18N83uQxBiG+E6YSz+gLCVTN7/fRuJ3k=;
 b=J9GKwM/xLGeJXUkQ3frTb5AOqD9K9DymB+GyjAaa+VFij+kZUS4NQRmSB3E80tq4ORA9/dwr3DY745ioN6DWX0Z/tF3vGhFUikG7eqG7n21NG4fbUvQ4ZzWWyTMb8w/HczIPW7dy7OwKSoOM4nGsIlfHLUkCxDRavCT986D1CHQw0ZGOSqMK/e3Xapc4Oh8eXw/Rj2U1OlW98nw4QmIA1V+8lGL5PrFhTajZee8UmLam+luT2s+WYZJupT+3CCY0Ew6jAV+AzFPI9lctlVOPn9yJehNtI+fE90rjKJIEWKMMVFiIlhC7jW4TxUaZ6MECtd/FP1AzNAdF0jUX+CyiAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7)
 by DM3PR11MB8682.namprd11.prod.outlook.com (2603:10b6:8:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 09:18:30 +0000
Received: from PH0PR11MB5952.namprd11.prod.outlook.com
 ([fe80::b961:2a71:c5e8:460]) by PH0PR11MB5952.namprd11.prod.outlook.com
 ([fe80::b961:2a71:c5e8:460%3]) with mapi id 15.20.8114.023; Mon, 4 Nov 2024
 09:18:30 +0000
From: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "K, Kiran" <kiran.k@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Device suspend-resume support
 added
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Device suspend-resume
 support added
Thread-Index: AQHbJRENZ2yMshNiiky51ZyXMna5ZrKT7XYAgAM4FEA=
Date: Mon, 4 Nov 2024 09:18:29 +0000
Message-ID: <PH0PR11MB595244C38429E3AF6CAD73F6FC512@PH0PR11MB5952.namprd11.prod.outlook.com>
References: <20241023114647.1011886-1-chandrashekar.devegowda@intel.com>
 <e6bd065d-0b9b-4c37-958c-fc2a09ea0475@molgen.mpg.de>
In-Reply-To: <e6bd065d-0b9b-4c37-958c-fc2a09ea0475@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5952:EE_|DM3PR11MB8682:EE_
x-ms-office365-filtering-correlation-id: 845c2bf2-468f-4f39-8bff-08dcfcb1a5c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aUgvcVpCdHRyVDBvZ2ZRNU5PdFVIY2lIKy91YW1Vek1sbkdGV1JIUldFQ3ZU?=
 =?utf-8?B?N21CaGZPbWQvOW54S01XL2l6b3Fhc0wzTEU5bWpVNmVFRytxTkMrbEk4c3By?=
 =?utf-8?B?SDcwaVQxZVV6QmdweUZuVmEvWjlZR0JJVWtuWGM3cnl4SWpxOVNtWmNONVBK?=
 =?utf-8?B?NXRyZk9SUUs4V3VmREtBc1k5T1oxZW1JSW1Id2lZUUVlOTBBbzZwcVV4MkF5?=
 =?utf-8?B?RW1XTDVYdjhqZ0hwQ1hJaWUySHJ4OUJiSS9sUVhGREpaczVCTnlGb2crblg5?=
 =?utf-8?B?cTBRWWowa1ZDYnJlcy81aVhEbFdDV0pHN1REUmhza1RIMHZJd21ReEtaY3dn?=
 =?utf-8?B?WmFrQXQreVZQWGdOYTJrWHBxMVY5TE1hdVlMc2t3bnd4SzJWcWFSYW5TREtO?=
 =?utf-8?B?S1pyUHA0ZzNjS1ZjeVJYSUIrQ1pnTlM3OHhWNXhIbjdqSWxjRGdYcjlkWTN0?=
 =?utf-8?B?TG8xdkptY3A3cGwzT0tYVGlDcXhwZlo3d0JJZEp3b3dVd3JMOUQwRHAxanRx?=
 =?utf-8?B?Z3IydXFqdnNVbEtCQjFybG90Uk1FdWIrNmlvTmFCWDZLTnJFWUtYU0xwN25R?=
 =?utf-8?B?OTloejVQNkl0UkxEQW9MQ1EwZmRyL2R3MWpvSnFQeFF0cmYvb1FRUCtETEF6?=
 =?utf-8?B?YUdZWmlmaXNrSlUwbU5XaFAxMDhBb0EvYUszdWdwSWdmeU13YlkraWFHWHpw?=
 =?utf-8?B?SXN6dXg3K1BFVUtVaHN4ZlpFK0pSUWpjMytKMFgyQTVlN2E0OFRJWWlXTDVl?=
 =?utf-8?B?eXNVeHQvM1lpNnRnWGgrQlY4UUdlQ1NpT0FsMXFZbkVCYXVtNkhUbEpQQVR4?=
 =?utf-8?B?ano0VlZKalZKZUEwclR6Nlp3dk9NMldESVF1VWMxeFpUTWVnbVo1aGowQ2JR?=
 =?utf-8?B?ZkZaaEpGbU96bTd2elA2QzNLS0UvaitWa09tcVM1SFV5enBER2ZRWXF5dCs4?=
 =?utf-8?B?aU9scFgvMW03UUNPNkp1dlVPaWZzN1Zja09VTWJTL2RESGhKeGh6RnJXREhR?=
 =?utf-8?B?U21VVU9CVEdjQWNtS2NLc2VVS1NGWHRlaE9iWGlHTzdBZlhNVFVxcnVHNGxV?=
 =?utf-8?B?OU1lT2R5SVZUbGRnd1FvMUV1MTl6aS9icjVlM29ydVNVb2lUcWJjOWtiLzZm?=
 =?utf-8?B?ZUNDSldBMXBoU2pnSHpQOXJGWTMrVzBxcHZ5anRwbkN6blVvN3h1bE5VRXZ3?=
 =?utf-8?B?OVJndVFlOTdKdkZycmtiMnRYVzlsVnBHallnNjcyaFA1cHBFd1MxZzRvaWFV?=
 =?utf-8?B?Q1RRVFgxK2tLakdOeWswUjRLVzRWT0MxaVFLc3EzN3JnanB3eFVsMVcxYklj?=
 =?utf-8?B?SWNEWkFyVFVSNC8zWGlkck5OaUl0bExOR3RMQk1VNGJ1THNiV3BKOStRZWdV?=
 =?utf-8?B?cnlCUmdMM2FFYnMxK2syQVRhYThyR2xJTEtvSUxIVXhhdElzeEtMMStFcjBN?=
 =?utf-8?B?WHhaM05hTk53MDgyZjhkUHBkZ29taUJLcGE0ckZlMjNrTUtUK2dEc2I0cFV2?=
 =?utf-8?B?QTY1c2JSOVpFK3dINDJ0RFZBNXZMOEJEWTBBRDJzRDM0Sk5UeDMxN3ozZWtR?=
 =?utf-8?B?enZXQkVQZGoxWmNtaVlDM3RnRmtlaCtWQmsvd3FNUFJQdG4vNEtnZGsyVktm?=
 =?utf-8?B?NDE0bjF0OE9IbGlNdWpUYUt0M2ZnMUpFT3RhZ0l5U2VvRUxWZElyWmQwZktw?=
 =?utf-8?B?dDRzdWE0N0dmOEVsd3dzNHNic1I0SXIrZE8vQWVYYmk2MWIzTXVCVmVhWnZs?=
 =?utf-8?B?NTRRbU9MbHo4Qjc5RjREeGVGUGdJaFZSUDZwQWlJQ1R3VFd3a0NsZVJ5bExP?=
 =?utf-8?Q?i15bGKdSrqqrxlxdxMiHQz/TJPXzMMr36lQ7Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnAxaFZaZ2l3R3YwRU1XbVJKRFc3RCsrdjVmZEdEWkJjdll4QUlmSHlyUEdq?=
 =?utf-8?B?UTZmTFp6TXpoV1RicGVFdy9jMmYvbjhMLzJndExlbXJaMVUrbUhIeGx3enJ6?=
 =?utf-8?B?RDI3STF2OGNQamFSNzFZU0V6Qjc5Y1N6RTVpVDdValJmclpLMmZ5MzRRbXJV?=
 =?utf-8?B?S0pVQzlsNWdUNUt5TEcyRE5IeFEzOEE5TENGdFZOdTBDZVF6Rmx1bHpZeW54?=
 =?utf-8?B?WWRlOXZBUDJtWk43WEFhcEhWcDFVK2MvMFZremhvVC9GTUxoWWRNelUvS0Ra?=
 =?utf-8?B?QUhoVVpCM0tiV2FGVS9JMWtHbC9wK1RNM29WVC9nVkUwemNRc255TU5uaW83?=
 =?utf-8?B?K1Rya1MyNU56U1kvd2VqL2lwV3RNTWdrdkFjYy91czJUcmx5cm5OOVhMc01s?=
 =?utf-8?B?d3d2Wkh4VTRDYTFaMER0cjdETGZRU1JNRllmN24wdXdzbzJ3cmEzVGVlMFdm?=
 =?utf-8?B?VkRvNnlUVVhlVFNTMnc4SGl5ZjlTVXpSVHlWV3NLU0QwOGt3bGQ4QzRuZVJs?=
 =?utf-8?B?RjBpeFd2SlZ4SzFibENtb3JlMzcxdCtYcHZLUS85c2ttYUsyTTJUTEg4SllF?=
 =?utf-8?B?K1NrRUk2SFdDU3ZIcWFCVEViV3pyTzFJUXh1MDhSQXJrV2lydkdWOHB0SGVR?=
 =?utf-8?B?VWVpUlg5UU5RT3FWRTRkc3hlNFhLdVRRTEJER2RaUFBjZjVCMVRkVlNxVm83?=
 =?utf-8?B?RTFWY1NqYnZiUk1Tc0VBYS95bmNWeGQycWN3Qko4MXY3aEpkcG4zakNlQnU4?=
 =?utf-8?B?dmVqbVdRNHViTjlnWDU1MWE0Y2RJdjZ6TFdEOTdKR3VicXkxVTB6ZWpCalJm?=
 =?utf-8?B?R3Fkcllsd1VmSm80aDk0cEQzRkNTei81eU9wa0xCWHRLaUNEVGZhcldCRGFk?=
 =?utf-8?B?OEhVODN0QXVNYkFENmFIWGh6RDFrR3JESG45S3BEc2NMT2hlK3hOSWJoaFdu?=
 =?utf-8?B?c1c1a3UrcWZlNW1GSVpBVUlUYmQwS1dzZjE5ZnY1VkEvMXZ0Vi81alRCeGtC?=
 =?utf-8?B?L0VIYThCVXF5RzQ1Z3NBbXB3anRvQmF0clR5Q2tveFYrUndOQ1VVd1JCQ3BS?=
 =?utf-8?B?TG9XSUorV3g0OTRmdy9ieWk4TjZ0MWlxR1F0NlNKcklTTXBRNU5pYlExVXBI?=
 =?utf-8?B?aS9mNEZGRmIyTkpxQjY4SWhWT1AyTUFHRklBSU52TndPRTRwMFdRRWxGUC9w?=
 =?utf-8?B?K2hmclBYWms4RnI5T0JVOEZhcHZCTFVUb3VhODZCeFhLNVFYd0srbUZFTmll?=
 =?utf-8?B?OFRQVkJyL04zWmpTcHlSK0hyY01ZRjNkM0krdGRucVBiY0p3NlUwaEllbXV5?=
 =?utf-8?B?R1M4N2hYTmplZG90dTdOWTRyRFpsaUZuUnJhdnZMVWQrQTNBN0hva3FkdnNV?=
 =?utf-8?B?WUlIak9FT2dtWTFEMngwTVM4TkFBM2kxVUdDeWJONm04TFpKN25PQXRNdzQ4?=
 =?utf-8?B?WG1DSTBjcUNHTEduNmZjZUdMSzZicU15bm1VcFFmWEhyS0ZIS2VEV1hndjZG?=
 =?utf-8?B?bGJtNnpQWEpHUGIzM1dJa3ZHV2JDRVFQbzV1ZTEvOGxKODRjazBWTlVrRDV3?=
 =?utf-8?B?YWZhVWgwcE1lRENaVU9uWUFDY3RST1YzNHhpa3pCZkE0N0JuMDZVVTdDSlF4?=
 =?utf-8?B?aVBYKzFHNER0ZmxZY1hlZHZJbXpkR1ZCTmNBQTdBQ0E0TEFhZmxlVVA4SXEz?=
 =?utf-8?B?Q1dOSHNJTWVubTk2L1kyUENOak9HeEtkTEs4MnN2MXVES05HbnN0R2FoenlO?=
 =?utf-8?B?QXU3OVlZNEt1TnlFakl2TnJTNU5Rb0pCMGwyV2s3U2R1MkdJbXpCaGUzU21h?=
 =?utf-8?B?aW1wdCtSM1R0Tml6b0ExUGRYMGQ1ZXEyQ2VVL0ptUmw0Tks5eGRPK3ZHNlBW?=
 =?utf-8?B?aWsxMGJIMG9lRVhxeSszWWRvMExzS1M4R21SUWZGd2pOc0FXRkxBdTNNUmxo?=
 =?utf-8?B?WHFCRUo1dk1TeFpzWWxPbk9TZTYrYXVEdVV3VE0xQWtZdk5OeTBETVZZTE9y?=
 =?utf-8?B?WTVWOVZ3dkdyK2FWU3lGcnNzaDdIU05EclZyaks5b0tnSzN5Ym5wczBMdU9H?=
 =?utf-8?B?KzJTN1gzMXNOSjgxdGFjNE5sVkpKNUdaWWJTdVo2SGh4V0c2ODFHR3diN1Uy?=
 =?utf-8?B?SzZ1RVIyOXozbitNc0pGT1BjajNIdjJEVkprRk0vRThqWGlrNmNxQUxiUlF3?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845c2bf2-468f-4f39-8bff-08dcfcb1a5c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 09:18:30.0131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoJiNVGRQszev/3f08qOWEfWCaZ1An/+B7MNZlE89wgar3/jtk15t7Dv4tKN7Fb/vohquoyw8mcxggklUVMTiKleJrtgnV6vkf5R2s5G5JPa3QljxrViCoth4i/PNF+A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8682
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCiAgICAgVGhhbmsgeW91IGZvciB0aGUgY29tbWVudHMNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBn
LmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjMsIDIwMjQgMTI6NDkgUE0NCj4gVG86
IERldmVnb3dkYSwgQ2hhbmRyYXNoZWthciA8Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwu
Y29tPjsgSywNCj4gS2lyYW4gPGtpcmFuLmtAaW50ZWwuY29tPg0KPiBDYzogbGludXgtYmx1ZXRv
b3RoQHZnZXIua2VybmVsLm9yZzsgU3JpdmF0c2EsIFJhdmlzaGFua2FyDQo+IDxyYXZpc2hhbmth
ci5zcml2YXRzYUBpbnRlbC5jb20+OyBUdW1rdXIgTmFyYXlhbiwgQ2hldGhhbg0KPiA8Y2hldGhh
bi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+OyBCam9ybiBIZWxnYWFzDQo+IDxiaGVsZ2Fhc0Bn
b29nbGUuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogRGV2aWNlIHN1c3BlbmQtcmVzdW1lDQo+
IHN1cHBvcnQgYWRkZWQNCj4gDQo+IFtDYzogK0Jqb3JuLCArbGludXgtcGNpXQ0KPiANCj4gRGVh
ciBDaGFuZHJhLA0KPiANCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KPiANCj4gRmly
c3Qgc29tZXRoaW5nIG1pbm9yOiBTaG91bGQgdGhlcmUgYmUgYSBzcGFjZSBpbiB5b3VyIG5hbWU/
DQo+IA0KPiBDaGFuZHJhU2hla2FyIOKGkiBDaGFuZHJhIFNoZWthcg0KDQpBY2sgd2lsbCBhZGQg
dGhlIGFkZGl0aW9uYWwgc3BhY2UgaW4gdGhlIHYyIHZlcnNpb24gb2YgdGhlIHBhdGNoIA0KDQo+
IA0KPiBgZ2l0IGNvbmZpZyAtLWdsb2JhbCB1c2VyLm5hbWUgIuKApiJgIGNhbiBjb25maWd1cmUg
dGhpcyBmb3IgeW91ciBnaXQgc2V0dXAuDQo+IA0KPiBBbHNvIGZvciB0aGUgc3VtbWFyeS90aXRs
ZSwgaXTigJlkIGJlIGdyZWF0IGlmIHlvdSB1c2VkIGEgc3RhdGVtZW50IGJ5IHVzaW5nIGENCj4g
dmVyYiAoaW4gaW1wZXJhdGl2ZSBtb29kKToNCj4gDQo+IEFkZCBkZXZpY2Ugc3VzcGVuZC1yZXN1
bWUgc3VwcG9ydA0KPiANCj4gb3Igc2hvcnRlcg0KPiANCj4gU3VwcG9ydCBzdXNwZW5kLXJlc3Vt
ZQ0KPiANCg0KQWNrIHdpbGwgdXBkYXRlIHRoZSBzdW1tYXJ5IGluIHRoZSB2MiB2ZXJzaW9uIG9m
IHRoZSBwYXRjaA0KDQo+IEFtIDIzLjEwLjI0IHVtIDEzOjQ2IHNjaHJpZWIgQ2hhbmRyYVNoZWth
cjoNCj4gPiBUaGlzIHBhdGNoIGNvbnRhaW5zIHRoZSBjaGFuZ2VzIGluIGRyaXZlciB0byBzdXBw
b3J0IHRoZSBzdXNwZW5kIGFuZA0KPiA+IHJlc3VtZSBpLmUgbW92ZSB0aGUgY29udHJvbGxlciB0
byBEMyBzdGF0ZSB3aGVuIHRoZSBwbGF0Zm9ybSBpcw0KPiA+IGVudGVyaW5nIGludG8gc3VzcGVu
ZCBhbmQgbW92ZSB0aGUgY29udHJvbGxlciB0byBEMCBvbiByZXN1bWUuDQo+IA0KPiBJdOKAmWQg
YmUgZ3JlYXQgaWYgeW91IGVsYWJvcmF0ZWQuIFBsZWFzZSBzdGFydCBieSB0aGUgaGlzdG9yeSwg
c2luY2Ugd2hlbiBJbnRlbA0KPiBCbHVldG9vdGggUENJZSBoYXZlIGJlZW4gdGhlcmUsIGFuZCB3
aHkgdW50aWwgbm93IHRoaXMgc3VwcG9ydCB3YXMgbWlzc2luZy4NCj4gDQoNClRoZSBpbml0aWFs
IEludGVsIGJsdWV0b290aCBmaXJtd2FyZSBzdXBwb3J0ZWQgb25seSB0aGUgRlcgZG93bmxvYWQg
YW5kIEJsdWV0b290aCBUeCBhbmQgUnggZGF0YSBmbG93cyAsZnVydGhlciBub3cgdGhlIGZpcm13
YXJlIGhhcyBhZGRlZCBzdXBwb3J0IGZvciB2ZW5kb3Igc3BlY2lmaWMgaGFuZHNoYWtlIGR1cmlu
ZyBlbnRlciBvZiBEMyBhbmQgRDAgZXhpdC4gU28gY29ycmVzcG9uZGluZyB0byBGVyBjaGFuZ2Vz
IHRoaXMgaXMgdGhlIGluY3JlbWVudGFsIGNoYW5nZXMgZnJvbSBkcml2ZXIuDQoNCj4gVGhlbiBw
bGVhc2UgZGVzY3JpYmUsIHdoYXQgaXMgbmVlZGVkLCBhbmQgd2hhdCBkb2N1bWVudGF0aW9uIHlv
dSB1c2VkIHRvDQo+IGltcGxlbWVudCB0aGUgc3VwcG9ydC4NCj4gDQo+IEFsc28sIHBsZWFzZSBk
b2N1bWVudCwgaG93IHlvdSB0ZXN0ZWQgdGhpcywgaW5jbHVkaW5nIHRoZSBsb2cgbWVzc2FnZXMs
IGFuZA0KPiBhbHNvIHRoZSB0aW1lIGl0IHRha2VzIHRvIHJlc3VtZS4NCj4gDQoNCkFjayB3aWxs
IHVwZGF0ZSB0aGUgdGVzdHN0ZXBzIGluIHRoZSBjb21taXQgbWVzc2FnZSBvZiB0aGUgdjIgdmVy
c2lvbiBvZiB0aGUgcGF0Y2ggLFRoZSByZXN1bWUgZHVyYXRpb24gaXMgYXJvdW5kIH4xbXMuDQoN
Cj4gSXMgaXQgYWxzbyBwb3NzaWJsZSB0byB1c2UgQmx1ZXRvb3RoIGFzIGEgd2FrZXVwIHNvdXJj
ZSBmcm9tIHN1c3BlbmQ/DQo+IA0KDQpZZXMgQlQgZGV2aWNlIGluaXRpYXRlZCB3YWtlIHVwIG9m
IHRoZSBwbGF0Zm9ybSBmcm9tIHN1c3BlbmQgaXMgcG9zc2libGUsIHdoaWNoIHdpbGwgYmUgZW5h
YmxlZCBpbiB0aGUgbmV4dCBwYXRjaA0KDQo+ID4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2ly
YW4ua0BpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hhbmRyYVNoZWthciA8Y2hhbmRy
YXNoZWthci5kZXZlZ293ZGFAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ibHVl
dG9vdGgvYnRpbnRlbF9wY2llLmMgfCA1Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ICAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmggfCAgNCArKysNCj4g
PiAgIDIgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+ID4gYi9kcml2ZXJzL2JsdWV0
b290aC9idGludGVsX3BjaWUuYw0KPiA+IGluZGV4IGZkNGE4YmQwNTZmYS4uZjJjNDRiOWQ3MzI4
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+ID4g
KysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4gPiBAQCAtMjczLDYgKzI3
MywxMiBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9yZXNldF9idChzdHJ1Y3QNCj4gYnRpbnRl
bF9wY2llX2RhdGEgKmRhdGEpDQo+ID4gICAJcmV0dXJuIHJlZyA9PSAwID8gMCA6IC1FTk9ERVY7
DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgYnRpbnRlbF9wY2llX3NldF9wZXJzaXN0
ZW5jZV9tb2RlKHN0cnVjdA0KPiA+ICtidGludGVsX3BjaWVfZGF0YSAqZGF0YSkgew0KPiA+ICsJ
YnRpbnRlbF9wY2llX3NldF9yZWdfYml0cyhkYXRhLA0KPiBCVElOVEVMX1BDSUVfQ1NSX0hXX0JP
T1RfQ09ORklHLA0KPiA+ICsNCj4gQlRJTlRFTF9QQ0lFX0NTUl9IV19CT09UX0NPTkZJR19LRUVQ
X09OKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIC8qIFRoaXMgZnVuY3Rpb24gZW5hYmxlcyBCVCBm
dW5jdGlvbiBieSBzZXR0aW5nDQo+IEJUSU5URUxfUENJRV9DU1JfRlVOQ19DVFJMX01BQ19JTklU
IGJpdCBpbg0KPiA+ICAgICogQlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxfUkVHIHJlZ2lzdGVy
IGFuZCB3YWl0IGZvciBNU0ktWCB3aXRoDQo+ID4gICAgKiBCVElOVEVMX1BDSUVfTVNJWF9IV19J
TlRfQ0FVU0VTX0dQMC4NCj4gPiBAQCAtMjk3LDYgKzMwMyw4IEBAIHN0YXRpYyBpbnQgYnRpbnRl
bF9wY2llX2VuYWJsZV9idChzdHJ1Y3QNCj4gYnRpbnRlbF9wY2llX2RhdGEgKmRhdGEpDQo+ID4g
ICAJICovDQo+ID4gICAJZGF0YS0+Ym9vdF9zdGFnZV9jYWNoZSA9IDB4MDsNCj4gPg0KPiA+ICsJ
YnRpbnRlbF9wY2llX3NldF9wZXJzaXN0ZW5jZV9tb2RlKGRhdGEpOw0KPiA+ICsNCj4gPiAgIAkv
KiBTZXQgTUFDX0lOSVQgYml0IHRvIHN0YXJ0IHByaW1hcnkgYm9vdGxvYWRlciAqLw0KPiA+ICAg
CXJlZyA9IGJ0aW50ZWxfcGNpZV9yZF9yZWczMihkYXRhLA0KPiBCVElOVEVMX1BDSUVfQ1NSX0ZV
TkNfQ1RSTF9SRUcpOw0KPiA+ICAgCXJlZyAmPSB+KEJUSU5URUxfUENJRV9DU1JfRlVOQ19DVFJM
X0ZVTkNfSU5JVCB8IEBAIC0xNjUzLDExDQo+ID4gKzE2NjEsNTUgQEAgc3RhdGljIHZvaWQgYnRp
bnRlbF9wY2llX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gPiAgIAlwY2lfc2V0X2Ry
dmRhdGEocGRldiwgTlVMTCk7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBidGludGVs
X3BjaWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gPiArCXN0cnVjdCBidGludGVs
X3BjaWVfZGF0YSAqZGF0YTsNCj4gPiArCWludCBlcnI7DQo+ID4gKwlzdHJ1Y3QgIHBjaV9kZXYg
KnBkZXYgPSB0b19wY2lfZGV2KGRldik7DQo+ID4gKw0KPiA+ICsJZGF0YSA9IHBjaV9nZXRfZHJ2
ZGF0YShwZGV2KTsNCj4gPiArCWJ0aW50ZWxfcGNpZV93cl9zbGVlcF9jbnRybChkYXRhLCBCVElO
VEVMX1BDSUVfU1RBVEVfRDNfSE9UKTsNCj4gPiArCWRhdGEtPmdwMF9yZWNlaXZlZCA9IGZhbHNl
Ow0KPiA+ICsJZXJyID0gd2FpdF9ldmVudF90aW1lb3V0KGRhdGEtPmdwMF93YWl0X3EsIGRhdGEt
PmdwMF9yZWNlaXZlZCwNCj4gPiArDQo+IG1zZWNzX3RvX2ppZmZpZXMoQlRJTlRFTF9ERUZBVUxU
X0lOVFJfVElNRU9VVF9NUykpOw0KPiA+ICsJaWYgKCFlcnIpIHsNCj4gPiArCQlidF9kZXZfZXJy
KGRhdGEtPmhkZXYsICJmYWlsZWQgdG8gcmVjZWl2ZSBncDAgaW50ZXJydXB0IGZvcg0KPiA+ICtz
dXNwZW5kIik7DQo+IA0KPiBQbGVhc2UgaW5jbHVkZSB0aGUgdGltZW91dCBpbiB0aGUgbWVzc2Fn
ZS4NCj4gDQoNCkFjayB3aWxsIGNoYW5nZSBpbiB0aGUgbmV4dCB2MiB2ZXJzaW9uIG9mIHRoZSBw
YXRjaA0KDQo+ID4gKwkJZ290byBmYWlsOw0KPiA+ICsJfQ0KPiA+ICsJcmV0dXJuIDA7DQo+ID4g
K2ZhaWw6DQo+ID4gKwlyZXR1cm4gLUVCVVNZOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW50IGJ0aW50ZWxfcGNpZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+ID4gKwlzdHJ1
Y3QgYnRpbnRlbF9wY2llX2RhdGEgKmRhdGE7DQo+ID4gKwlzdHJ1Y3QgIHBjaV9kZXYgKnBkZXYg
PSB0b19wY2lfZGV2KGRldik7DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCWRhdGEgPSBw
Y2lfZ2V0X2RydmRhdGEocGRldik7DQo+ID4gKwlidGludGVsX3BjaWVfd3Jfc2xlZXBfY250cmwo
ZGF0YSwgQlRJTlRFTF9QQ0lFX1NUQVRFX0QwKTsNCj4gPiArCWRhdGEtPmdwMF9yZWNlaXZlZCA9
IGZhbHNlOw0KPiA+ICsJZXJyID0gd2FpdF9ldmVudF90aW1lb3V0KGRhdGEtPmdwMF93YWl0X3Es
IGRhdGEtPmdwMF9yZWNlaXZlZCwNCj4gPiArDQo+IG1zZWNzX3RvX2ppZmZpZXMoQlRJTlRFTF9E
RUZBVUxUX0lOVFJfVElNRU9VVF9NUykpOw0KPiA+ICsJaWYgKCFlcnIpIHsNCj4gPiArCQlidF9k
ZXZfZXJyKGRhdGEtPmhkZXYsICJmYWlsZWQgdG8gcmVjZWl2ZSBncDAgaW50ZXJydXB0IGZvcg0K
PiA+ICtyZXN1bWUiKTsNCj4gDQo+IERpdHRvLg0KPiANCg0KQWNrIHdpbGwgY2hhbmdlIGluIHRo
ZSBuZXh0IHYyIHZlcnNpb24gb2YgdGhlIHBhdGNoDQoNCj4gPiArCQlnb3RvIGZhaWw7DQo+ID4g
Kwl9DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArZmFpbDoNCj4gPiArCXJldHVybiAtRUJVU1k7DQo+
ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhidGludGVsX3BjaWVf
cG1fb3BzLCBidGludGVsX3BjaWVfc3VzcGVuZCwNCj4gPiArCQlidGludGVsX3BjaWVfcmVzdW1l
KTsNCj4gPiArDQo+ID4gICBzdGF0aWMgc3RydWN0IHBjaV9kcml2ZXIgYnRpbnRlbF9wY2llX2Ry
aXZlciA9IHsNCj4gPiAgIAkubmFtZSA9IEtCVUlMRF9NT0ROQU1FLA0KPiA+ICAgCS5pZF90YWJs
ZSA9IGJ0aW50ZWxfcGNpZV90YWJsZSwNCj4gPiAgIAkucHJvYmUgPSBidGludGVsX3BjaWVfcHJv
YmUsDQo+ID4gICAJLnJlbW92ZSA9IGJ0aW50ZWxfcGNpZV9yZW1vdmUsDQo+ID4gKwkuZHJpdmVy
LnBtID0gJmJ0aW50ZWxfcGNpZV9wbV9vcHMsDQo+ID4gICB9Ow0KPiA+ICAgbW9kdWxlX3BjaV9k
cml2ZXIoYnRpbnRlbF9wY2llX2RyaXZlcik7DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmgNCj4gPiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWxfcGNpZS5oDQo+ID4gaW5kZXggZjlhYWRhMDU0M2M0Li4zOGQwYzhlYTJiNmYgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmgNCj4gPiArKysgYi9kcml2
ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuaA0KPiA+IEBAIC04LDYgKzgsNyBAQA0KPiA+DQo+
ID4gICAvKiBDb250cm9sIGFuZCBTdGF0dXMgUmVnaXN0ZXIoQlRJTlRFTF9QQ0lFX0NTUikgKi8N
Cj4gPiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9CQVNFCQkJKDB4MDAwKQ0KPiA+ICsjZGVm
aW5lIEJUSU5URUxfUENJRV9DU1JfSFdfQk9PVF9DT05GSUcNCj4gCShCVElOVEVMX1BDSUVfQ1NS
X0JBU0UgKyAweDAwMCkNCj4gPiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxf
UkVHDQo+IAkoQlRJTlRFTF9QQ0lFX0NTUl9CQVNFICsgMHgwMjQpDQo+ID4gICAjZGVmaW5lIEJU
SU5URUxfUENJRV9DU1JfSFdfUkVWX1JFRw0KPiAJKEJUSU5URUxfUENJRV9DU1JfQkFTRSArIDB4
MDI4KQ0KPiA+ICAgI2RlZmluZSBCVElOVEVMX1BDSUVfQ1NSX1JGX0lEX1JFRw0KPiAJKEJUSU5U
RUxfUENJRV9DU1JfQkFTRSArIDB4MDlDKQ0KPiA+IEBAIC00OCw2ICs0OSw5IEBADQo+ID4gICAj
ZGVmaW5lIEJUSU5URUxfUENJRV9DU1JfTVNJWF9JVkFSX0JBU0UNCj4gCShCVElOVEVMX1BDSUVf
Q1NSX01TSVhfQkFTRSArIDB4MDg4MCkNCj4gPiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9N
U0lYX0lWQVIoY2F1c2UpDQo+IAkoQlRJTlRFTF9QQ0lFX0NTUl9NU0lYX0lWQVJfQkFTRSArIChj
YXVzZSkpDQo+ID4NCj4gPiArLyogQ1NSIEhXIEJPT1QgQ09ORklHIFJlZ2lzdGVyICovDQo+ID4g
KyNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9IV19CT09UX0NPTkZJR19LRUVQX09ODQo+IAkoQklU
KDMxKSkNCj4gPiArDQo+ID4gICAvKiBDYXVzZXMgZm9yIHRoZSBGSCByZWdpc3RlciBpbnRlcnJ1
cHRzICovDQo+ID4gICBlbnVtIG1zaXhfZmhfaW50X2NhdXNlcyB7DQo+ID4gICAJQlRJTlRFTF9Q
Q0lFX01TSVhfRkhfSU5UX0NBVVNFU18wCT0gQklUKDApLAkvKg0KPiBjYXVzZSAwICovDQo+IA0K
PiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0KDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpD
aGFuZHJ1DQo=

