Return-Path: <linux-pci+bounces-3467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99038554E2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 22:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373571F24258
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 21:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8113EFF3;
	Wed, 14 Feb 2024 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4e3P7Wv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E01B7E2;
	Wed, 14 Feb 2024 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946517; cv=fail; b=fzdxjjli0AnwBehg6ELIGIxez8uuQ9/3x+RqYr7FLuRCUyqyCszI8F8sMREn1BLXYAvIY5gamDHAZGHp+ZrLt2zYl3dQZCikHgbi9YU7NkIlfGConXeTU72X1awlrTylV6PcqzQu5nWMVIAXbKa5N+9pZWCCFqjpVRT0NnH45i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946517; c=relaxed/simple;
	bh=VZh3jxsfsA6xhs8g8iJpFv+UY7ILN4AF4zBQCThcp/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5ojrMlEPamwHduuTSQQWgaMER1b2/aH2Kc4ntkyxBH0eN7GlQ9bT3s08JJiAPDE9gI01oUfmUfSmW+87JGnqHcIWk2/zP/syGBiu0J4qTv5tyyBTARGJL0Y6RyAwfPSo4cQL/Nskda5uYqTcZ6zwvYGxuFijrWl/1wvKqA16Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4e3P7Wv; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707946515; x=1739482515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VZh3jxsfsA6xhs8g8iJpFv+UY7ILN4AF4zBQCThcp/0=;
  b=Y4e3P7Wva5rnq//rr0OjuzXSJ07Gt5Mk4X+pYH7Rggm59qLm0R6aTAvP
   lQblVOALxH8RUaQSBR9CJ0yF2/Gr06OQ+Q39U2pT9N1gHUKiHx2PX8edQ
   u+mOSRFcy0m8qs9Q6bhxakAJ6W1LuhzC2v+kOdvXXlYwPbASPj5WaWb0U
   3OITfPkV38F5nF7OmqXwRDFKBkOEONyHVT4ZH7DK4sWbaC/T96VhLVLf7
   iCdJdOooLX3B9lwVtnDvGSrWnLtKBWjiLqnU/1iOUkDMfUwgO6VWLjvxC
   VJ6FBH03xbCDII+itwoXyMsnDUCL0kXby+q/bzCI3sow3DELnCiFuHc4A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19432171"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19432171"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:35:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7934562"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 13:35:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 13:35:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 13:35:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 13:35:13 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 13:35:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvCl3NlGPnj+396KHyfBYkqG1ibp88he7RO2wupKlLtkeYpO+ZF9Wq2DJ4d1C+Xq4gOQeeUGCcxPxBE+iD6d/OeiYn1c5bnblvuwP4maW3ngAuGXgPBPglLeYkGK2HAULr8r5ECgTJaTwGQfu18O9+PKTI1AOrA21K5pMZi4w70QJTMmzoPAasFlZUNdN02aL9zWBfPPuJSE8h39SoXpk0ycFkjDhF4siiH+E1KXw0e3XLXWeac4kDYD5Xz4lxFB7APLo9hT08eZ5dHdtkmrdhHqnxOYKa529wqfjbpdZpNK2BhB4qtqIjXqsdTD1V/bIJHN85Jhp4MtE+bcZ1zskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZh3jxsfsA6xhs8g8iJpFv+UY7ILN4AF4zBQCThcp/0=;
 b=Bbsp7WSG51q6gMkhQLBzZBtlpmhzPR5OVskJv/IIX+qD/iolLjFrinlvN3GYHYSL9p9EQtmPeFgsrazPJde3u/7478xmgGIb9bHCAV51Najsv+JQxVmOpOltuAQHxtBQN+lD0MiT0O01eaIPaclWW0oDgj+YT+oeOBm05AetprNI0TX7QLT3LBp2hR/4oJsxB5cLP/BO2E7nleuIxxVjdlHAg+jHkC4Fjq0kOpzcWKIhboDBWmPqSe0TsGJ785QIw1PsavS7InvkkWSH63IKr5x5Eipy4waXq0uunKS4ZsLGXYvMaY093L8+9CpXnC4UVSJ86xQX3FXRuEf6NusH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 14 Feb
 2024 21:35:08 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::50f4:1fc8:bfc1:706c]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::50f4:1fc8:bfc1:706c%2]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 21:35:08 +0000
From: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Wang, Qingshun"
	<qingshun.wang@linux.intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: ixgbe probe failure on Proxmox 8
Thread-Topic: ixgbe probe failure on Proxmox 8
Thread-Index: AQHaXtfArMYyEqGoN0aZnzQoyM7aBLEKPpqA
Date: Wed, 14 Feb 2024 21:35:08 +0000
Message-ID: <F7D2F429-F330-4BAB-8876-196CA639DA76@intel.com>
References: <20240213235231.GA1235066@bhelgaas>
In-Reply-To: <20240213235231.GA1235066@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4914:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: 99f19e25-0af7-43f5-ef4a-08dc2da4d0fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7pYn2X+DyxXCOuJggsrfr8r+hetMPggNQiGXUfCs8eKinY+uc/IDEvhyK3wG2IAAlo0WLqN0gmd2c48JZiUxlzJcwx3WC7qVPEJ/IOKW73fivnK1hZPNPHFHz1aOIHjJZWfwFZLGjlBi+klIVW4W34F/U9Tak4sYLS0beb9fzG1O7ULfZGzg/RMgoUifW5yyZgkeF80jXcI7l+CKqa4QMExlo9dQZZy3Arsn51AuUCwilhTm9qPPJ596pfQGAIgdl6DVFsiJW45hXv8hsNO55IovUZmN5ydwtno5DhhK7fZJqEk0Vp5sw2EJI2bQ18wCewlRjwA6WXP7p6XLT//v1KvtbMK3/HsZN0ufyfHeEkaQeiEjkX0eWBl2QiFdD7BNR6gFmytFAyCZiZXj/xpvnN6VAYRRbrCCL9m7hNRVhsLRUgXPPBR0OiatrRIaBRncg3lmWFNdu4cpQwLgXov4DmCWYLGFb9l4POSl59rd0KKiVv1bZE0a7it1J5YZcQ5HNRO9heQip7mAMK9OB9wPDSf0y82vddrCYfEl5BfX8DOkjM2WjTHd0xucJsDWJPNVEp7gCk3b8tUZpoBzBoK4KVCuevZ/D9ol6RQvtSI6qAM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(8676002)(5660300002)(6512007)(38070700009)(53546011)(6506007)(71200400001)(6486002)(478600001)(966005)(2616005)(82960400001)(38100700002)(122000001)(83380400001)(86362001)(8936002)(36756003)(4326008)(33656002)(6916009)(316002)(66556008)(64756008)(66946007)(66476007)(76116006)(54906003)(66446008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlEzK0ZiMW1DbEZ6OTBUYjFsaVFJYmNBQ2pHc2dvNVEwSm1aRFVxWEF3Qllx?=
 =?utf-8?B?Y0drMlZBWXV1cndLQkw1QmpjVlEzektnYzBoZ0c5eDdZT3MxYnR6M0l4VjhT?=
 =?utf-8?B?L3IvR0hpNngrS09TNXdscGsyYXFDNHN2V2hTclNmUUFYS2lYVWZYVW9mRWd1?=
 =?utf-8?B?dUM4S1ljUGs5K2VBQ05ZcEZjQ1NyM3EwclNQM3JlN3BkYUZpRzlLQkN3VFIr?=
 =?utf-8?B?K05Bb2Vvc05qNXFWZDdGQVlyNm9VVFBBQUczaEhhd003d2ZuYjBiY21hSDk0?=
 =?utf-8?B?TEZJS1ZROGplTkpTTUgyS1hBR0pGZ1NWbE5Rb1dGdTBxVEtvVko2SDh1RVdI?=
 =?utf-8?B?YmhlaVpyQzFCWTdnN24xeHRGWnJUc3lUZ0ZEL1dSWjZxSnhqMkFxWCtBMXNq?=
 =?utf-8?B?SCsxR3ovaDNhOSt2cU5WOTJkQzBDeUJXSTQreUFZVFNHL3hjMHgrcG5tRTF0?=
 =?utf-8?B?RG9pNVcrTWJDNnpSVncxV2orZTluUEJ2YXkxcFd0K29zVWNhNVpiK2xrNXYy?=
 =?utf-8?B?eEgva1g3OHJjcmVlRDBBR3dsMk1HeXVPUWFjRVV6WkUvUE1EN3ZVWS9hQnlz?=
 =?utf-8?B?Wmc5YTFKTk1NbDhxWXdnZ2NNOEdaV0JBaWY5bXZIdlo1bll2TWt2NWhqSEl5?=
 =?utf-8?B?Q0J6TVI5cGkrZ0R4ZjdrS3ZYT3Y1aEI5UkRnalo4NGd0bytYaTNrV2pVZ3ha?=
 =?utf-8?B?SkMxOHd1aFpnbHlkYW40N0hZNTlKLzdnSXdvSWkvcnU4QW1lY2U5WUhZY1RJ?=
 =?utf-8?B?TGVRM0FycVJaSjJ2N3FvcjNhSjhkSTRLbThhY3JMUVFvQWZBY1p2RXlmNE5I?=
 =?utf-8?B?Z3pCcUt3aEd6NzJMSENhaXY1UW9yWHQ2YU4vditWVC9XVjczcFBUOG02ejRw?=
 =?utf-8?B?d0ZCY1pBZDVMNmtjTDBXV3l6R25JTjNEMTlmVDVJMkx1TWhQdXFsUE1WYVFk?=
 =?utf-8?B?VWZGRHBsdndyeXpIUkJjTmFvWDFrcVlOSnF1SlVRMGZWdzlzWS9ZRllhWXJN?=
 =?utf-8?B?U0JackJBM200OC9qQ3lRT0V0aWJuTHBOVWhoVHhVUDFYL2JjNDJNbGJsOHBO?=
 =?utf-8?B?TjJmQlBhSk9zRk5oRzc1NDN6b1hhb013NW8rdzdOdjUxd05CK0VOTHNqOVdx?=
 =?utf-8?B?ckxra3JtMG93bThoMHE5L3VSakJiR0V0MU9iNGJMOVc3WW1BQmk1aHlKVnlV?=
 =?utf-8?B?UkN5RVFxM3phLzI0TmhrZmtLZTFFMTl1YXZhRjJUVjZ2bzhLRjNMM0poUjBy?=
 =?utf-8?B?RFYwVTRiQlBkb0orc2xUSVNhanNEQ2VkSWJTNjIxVVcrSUNBNGIxejIzeEVv?=
 =?utf-8?B?d0FQZ0UvekpZcDJ6TXA0Mk5nZXZpam9pTXJiUXVCWGlndDNwU2hER0JnMzZG?=
 =?utf-8?B?dHpuT0RPaTZwSnhaZm56WnZxamZ6NURtb0hwZ0ZKWlJ1MWpldTRMZVNic3lK?=
 =?utf-8?B?MUIvSC9MYnJrSG5jTVdVMEZGTW1DM0dVUGR4UnQ1VEN4c1JXZkNqWlJFYkJX?=
 =?utf-8?B?cTlmQ0w0Z3RYNnJybWkzSkROandlNU9LWEFJckhDdFZHRGZiMUswS2VwM0NX?=
 =?utf-8?B?ODZsV1JDK1lHOW5YakpxQlVIYVc4MFZ0NEJXb0hzS0pPeGdQWXBWUzhKeUlN?=
 =?utf-8?B?YktKeHUyNmlyTnE0R1dPOGNqWDZ2dG1DQUxLYlBmZWNmUU4zR0g1MmJHemlI?=
 =?utf-8?B?akxXSGozZXJRcTBPaXEvcTdLdEFnRWtKampzTC9OU05wdzROZWI3elpXRjJm?=
 =?utf-8?B?d2tJbVE0Yk56a1hVWUdOTGlQc3FDQmphQmtQR0dvdkFKQ3J0VWpiTkdaTTZO?=
 =?utf-8?B?UTVKSzh3MHpFL09XWWpaSzdsWW5HR3FKbUwxUWgxU01nU3B4ODFoWHNMU2I0?=
 =?utf-8?B?L0tvNWpiKzZxVWFGa1p0V29pbUtJdHRzR2VJZGYvcUVvZWNHSDFna0VJUStN?=
 =?utf-8?B?cmN4VjRUZWJUa3ZrTXpLT2h0aEtIaVd3ZUtVQWgyNkV3cXFlWWRpa0V2RVVy?=
 =?utf-8?B?elB3V092WGZHTWF4b1hFUG1BVWFLaXpNYm1hS1NSbksxakJObldPRU9lcE9t?=
 =?utf-8?B?NUh3OU96MW9XR0wyV0xJVW5UZ0kyUUNzR1h4a0FPaHd4N1psL3VnL2VDNm1E?=
 =?utf-8?B?SHQrTU1PQ3lDczB6SVduYk5QeEFEWCtLUlFmUHo0TDliaWhRL2wwY08vMysy?=
 =?utf-8?Q?1xusJVHzISniX5VyA+RDlyA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B446681E21F9646AACF47764E690A99@intel.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f19e25-0af7-43f5-ef4a-08dc2da4d0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 21:35:08.3670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPbIZCKcqX8gfec8u7WA12vxHVX8rn9/VbiDeO1DURWr4gEDzovOlQKVrfkvjN17NhTesSPtEuGGVp9dWff8yHs04zjxNZiNuI4v903a+Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com

DQotLQ0KSmVzc2UgQnJhbmRlYnVyZw0KDQoNCj4gT24gRmViIDEzLCAyMDI0LCBhdCAzOjUy4oCv
UE0sIEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79K
dXN0IGEgaGVhZHMtdXAgYWJvdXQgYW4gaXhnYmUgcHJvYmUgZmFpbHVyZSBzZWVuIHdpdGggUHJv
eG1veCA4LiAgSQ0KPiBzdXNwZWN0IHRoaXMgaXMgYSBQQ0kgY29yZSBwcm9ibGVtLCBwcm9iYWJs
eSBub3QgYW4gaXhnYmUgcHJvYmxlbS4NCj4gDQo+IFRoZSBpeGdiZSBkZXZpY2UgbG9ncyBhbiBB
ZHZpc29yeSBOb24tRmF0YWwgRXJyb3IgYW5kIGl0IHNlZW1zIGxpa2UNCj4gc3Vic2VxdWVudCBy
ZWFkcyBmcm9tIHRoZSBkZXZpY2UgcmV0dXJuIH4wOg0KPiANCj4gIHBjaWVwb3J0IDAwMDA6MDA6
MDMuMTogQUVSOiBDb3JyZWN0ZWQgZXJyb3IgcmVjZWl2ZWQ6IDAwMDA6MDU6MDAuMA0KDQpXaHkg
ZG9lcyB0aGUgdXNlciBvciBiaW9zIGNvbmZpZ3VyZSBjb3JyZWN0ZWQgZXJyb3JzIGFzIGZhdGFs
IG9yIHJlcXVpcmluZyBhIHJlc2V0PyANCg0KU2VlbXMgbGlrZSBhIHNlbGYgaW5mbGljdGVkIHdv
dW5kLiANCg0KPiAgcGNpIDAwMDA6MDU6MDAuMDogUENJZSBCdXMgRXJyb3I6IHNldmVyaXR5PUNv
cnJlY3RlZCwgdHlwZT1UcmFuc2FjdGlvbiBMYXllciwgKFJlY2VpdmVyIElEKQ0KPiAgcGNpIDAw
MDA6MDU6MDAuMDogICBkZXZpY2UgWzgwODY6MTU2M10gZXJyb3Igc3RhdHVzL21hc2s9MDAwMDIw
MDAvMDAwMDAwMDANCj4gIHBjaSAwMDAwOjA1OjAwLjA6ICAgIFsxM10gTm9uRmF0YWxFcnINCj4g
DQo+ICBpeGdiZSAwMDAwOjA1OjAwLjA6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAwMDAyKQ0K
PiAgaXhnYmUgMDAwMDowNTowMC4wOiBBZGFwdGVyIHJlbW92ZWQNCj4gDQo+IFRoZSB1c2VyIHJl
cG9ydCBpcyBhdA0KPiBodHRwczovL2ZvcnVtLnByb3htb3guY29tL3RocmVhZHMvcHJveG1veC04
LWtlcm5lbC02LTItMTYtNC1wdmUtaXhnYmUtZHJpdmVyLWZhaWxzLXRvLWxvYWQtZHVlLXRvLXBj
aS1kZXZpY2UtcHJvYmluZy1mYWlsdXJlLjEzMTIwMy9wb3N0LTYzMzg1MS4NCj4gDQo+IEkgb3Bl
bmVkIGEgYnVnemlsbGEgd2l0aCBjb21wbGV0ZSBkbWVzZyBsb2cgYXQNCj4gaHR0cHM6Ly9idWd6
aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTg0OTEgd2l0aCBzb21lDQo+IHNwZWN1
bGF0aW9uIGFib3V0IHdoYXQgbWlnaHQgaGF2ZSBjYXVzZWQgdGhpcywgZS5nLiwgYW4gQUNTDQo+
IGNvbmZpZ3VyYXRpb24gZXJyb3Igb3Igc29tZXRoaW5nLiAgSXQncyBsYW1lLCBJIGtub3csIHNv
IHRoaXMgaXMganVzdA0KPiBhIHNob3QgaW4gdGhlIGRhcmsuDQoNCknigJlsbCBsb29rIGEgbGl0
dGxlIG1vcmUgYXQgdGhpcyB0b21vcnJvdy4gSSByZW1lbWJlciBsb3RzIG9mIGluY29uc2lzdGVu
dCBiZWhhdmlvcnMgYXJvdW5kIHRoaXMgc3R1ZmYgd2l0aCBlYXJseSBpeGdiZSBhbmQgd2hlbiB0
aGlzIFBDSSBjYXBhYmlsaXRpZXMgd2FzIGZpcnN0IGVuYWJsZWQuIE1vc3Qgb2YgdGhlc2UgaXNz
dWVzIGhhdmUgYmVlbiByZXNvbHZlZCBzaW5jZSBhbmQgSSBoYXZlbuKAmXQgaGVhcmQgb2Ygb25l
IGZvciBhIGxvbmcgdGltZS4gDQoNCg0KPiANCj4gQmpvcm4NCj4gDQo=

