Return-Path: <linux-pci+bounces-2752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC9E841A89
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 04:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29416B20C8F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 03:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D3374C9;
	Tue, 30 Jan 2024 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnRkgXEw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B7374CC;
	Tue, 30 Jan 2024 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585318; cv=fail; b=N+fpylEoDEpIr1AqHcyme/JqHAmL85+9zFie9OPvgxMr4aD+ETeeF53ZXlBcyhyHwRRj8zlWncpeza/1EVXP+CJPlRYekRniNZ/hxj3lh8c85B6p1n3F1Ku2pqKyGp1vR+7HoA743fDVTymg1YyBhtOapjua226oXH0EBTLjg7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585318; c=relaxed/simple;
	bh=nNMikOuKwgpC7wdOPKk/mKNPkb9aSk/ebvNeegK98nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c90Saar2O8SQMv9mDCxK2w2tQi2zUTKZi7MUXTOz47ybD7HEwMz1TAkaO4hD2tQFCQg7RCNoblwQns9Re75iC6rWafQKV2kXT7H4rjsdf/8OUPCSQ0NtAc14oddnQXA5yTMRzaVDPE7PhqbSr69++ywjJLhWTZp8EPhKs4hMoJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnRkgXEw; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706585316; x=1738121316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nNMikOuKwgpC7wdOPKk/mKNPkb9aSk/ebvNeegK98nU=;
  b=CnRkgXEwSkheeybfQczVhYcNFcuQpX6KZ3FccD4cWxDiQ3ypzTV2H6Tq
   ShvoJccKFjAS283hAcBczvAV7AHwdZpHoZRb+Y9pYkFkLWgklS4sskPF8
   j7pHVdvllgMldIS+vPbw3WXan/Pl6klOwXBRfSEyCOyabonhhIDZ1lM9t
   3Ftik02LeG02ii8XGlcQpPRBsSz4yaVB+tQ+hxWTccQR5qWMoA3gx2lfR
   p8Iyll/pSEgsOZAX6GsREAOaFfVspW42054MZurrPJJqTAMLW87uWyzuN
   +QHlOkafHDXtIuDrdHKIPBjTcy97kD5joZcg2gWb3OtLFcSG9qY/h3mqD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10542015"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10542015"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 19:28:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3522541"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 19:28:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 19:28:31 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 19:28:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 19:28:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW08PGy8UwSZc28PyQp+SMYQbATuZ3Xh7g/2vdiD45+LXTYB4NC4zMLNveFGzYDaM9vgz9OYm+z75WH6z/VnTsoQUd/b8elEIuyzvDkSWIrDEixxqNLbPt/T3LVyz8SUqj85r41zVHIRNtb6dEetD3qoe20HEiPjGzLL7+RAhpa1GayE40r9TIwSRHdHNIX9Yq8TQHeWz5o4/uTWHgViWrxVE5S2zdoagAFg0V3JBKV3GRC6hhNUi6WfpcRKMMUFNrjKpzA4F6fZAmGIuFIN+DzT3jz/wHH2iQVG9NETUOux1SlPvbQCh0bthrNzpxDF53fM5fzCj+J6J3O9DJhBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNMikOuKwgpC7wdOPKk/mKNPkb9aSk/ebvNeegK98nU=;
 b=SEXB1440Y9NrdBu/nOuZK7vffaHqkXCu64Pl2F4EzzdQVUn3m9CaabAkvwfC79t0uYmHwo1xtrsKqA4yJ11fsgMy7/U1SdspJ3bjRwCfMwP1KtWibe418PuXgW/TXdepcNfgjNZ8PzzVbB6XZl9Ddyzgg+G1IOuwn53cCRzW7bdHc4UO+vvrg/gCX8yIhNxkEQ3fyM4SFZQp6CeabF9CZ1GLFxkrPVvZz4LdTQM3GGQB7qHpu/XhB5fP8gfIO1U3Vh1sFJ3aq9zb8O7T9kIvZJ1CVSXDbJsRc0hhACgzhuNf7N8G6N2ZdD2X1B3wpmF6EO1ALc0vMU+fu3xXZ21g9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 03:28:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 03:28:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Ethan Zhao
	<haifeng.zhao@linux.intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Thread-Topic: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Thread-Index: AQHaUmY538BcsBx6UEOae7WqjB1D5LDweayAgABmGQCAAM7uAA==
Date: Tue, 30 Jan 2024 03:28:29 +0000
Message-ID: <BN9PR11MB52762D214863D3054083856E8C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <46e0c704-cc77-4d23-9503-0d6d5d07bb26@linux.intel.com>
In-Reply-To: <46e0c704-cc77-4d23-9503-0d6d5d07bb26@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5862:EE_
x-ms-office365-filtering-correlation-id: ac138f2c-209b-42aa-d0ce-08dc21438704
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hu0iKaVI9naP+T4X1zKInRJxakF51xuXrKTGKtLUokKGG2cXmWEqgDMn4hPrUSrD2+Hh7y3MUt29+iDESsevn9iUhuLr6/Ts/nnf0bw2JNRtlPIbfWbYKHnNiUH7pWz8RXNgO3TDkiKi4LlS/TRXnOc8IfyVnf2jkkM5TYOXY+VHws61b7IUkDkpww1WvuAgZuf5q2BgTc3gHJUqyyON0yCg27KH8lmF94zWpMWw1YjsYVIOcN2g5ai1wzMdNiKAjwchsqg0EmQ89aDvw4mIce/rusE3VOsdx3lj6ykOXBB65wBqKPQ13gpLRf/UBMKqtlU41rCbBrDwQ4yaifX75ExSwBJKPsvl7UJDVB4lI2hCH4QuqkmsRK1sj28UngMuB25obu9/ITcvDfNzAfsgN4c9OPjm7AvOMAnLkCDEKPASQBpCSD4isggKG7U44XVPocubwGshUptfmAL8C3Sd2uwCoMroyq3m9SeMAA4eYlGDaWYXgP6BzRMrbcJJqc4pbRLJLiNyqleNR1lAgd6DzMivVA7nY7GwyR5GZ6o6OIuS51h02r8pn1hcvT9MfJ+pNqB5r1svs8LBnTcaYIT5vPDxDq6au8p9mGxEh0EdNCw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38070700009)(55016003)(26005)(5660300002)(316002)(71200400001)(7416002)(6506007)(66446008)(7696005)(9686003)(66556008)(53546011)(66476007)(66946007)(76116006)(110136005)(52536014)(64756008)(4326008)(54906003)(2906002)(8676002)(38100700002)(33656002)(122000001)(41300700001)(86362001)(83380400001)(478600001)(8936002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUd0RVNSeG5FamQ2aU9lbHFiRkdVUDRLKy9mR1VmdzNMQ2ZBQ3lTZTY3dEJ0?=
 =?utf-8?B?K0RLc0lidVQrMFZoSmJBUmNXbnRYVmt6SjB0NzNTaTdMN1ArcFJNb0JSR3ht?=
 =?utf-8?B?K00yaUZDTG5vVVF2ZGk0NWE0TGlFUXVmaGRLbE5oTWorU0oyZmhiSU1OeEdl?=
 =?utf-8?B?SlpVbWc1aEV2dFFBd0FtaDRZcVZVay9zSWJHbDZHUktjMUJOUWpwaVlKaVY0?=
 =?utf-8?B?dVNqMGhPMW5SYXFuYU13cXVDZ0JzdTlKNjVlT3FqcVhEYkVIdHhDMmJMQ284?=
 =?utf-8?B?eWo3VmdBUC9vdCttTzViNW5ZUnBndW9PTlB5UkEwd09KdnRnQXFqdkFlU29J?=
 =?utf-8?B?M0xYcmhucVV1NlpSQWJ5UkxXeFZVdndPQ2RBQUQrZ2JFTjcxLzgwaHExcWxa?=
 =?utf-8?B?WUtyZlY5THBhQVV1RktTOFJuNTNlMzlnUDlCbmNTQTZpRVlsM0c3R0d6ZGtU?=
 =?utf-8?B?VzRGTC9qR3RyMU9tS3NXM0xvSkJzZ1MvWGlWUmJqaWJDRWtNcUV3YlNtUy9u?=
 =?utf-8?B?QkQyZWxQT1pEK3E1MFowL3R6bjBITVhFUUEvUGRGS2dENTlPMmJaSkg2YkRz?=
 =?utf-8?B?TzJZcXZOZ2lzVXN4a2hMcmxXUHk2UzZJdjA2U1NIR3hKRFNVc0R1c3pOUjV4?=
 =?utf-8?B?ck9EdEpsVHM2eDNWOVg4cGlKSVhOeWhEWHlrWkR6eE5mYmkvWFBhWmh2MGZj?=
 =?utf-8?B?N20rOFpHcktmZkdtNFk5YUEwVVZEL0NvTE9SakVZUy9GUTlub3RkTmp3NWdG?=
 =?utf-8?B?akNGRlpOY3VzVFZyWlJpOVVqRktTZkFSWE0wVm1JUStCSkd5K3VVQ21iOWw4?=
 =?utf-8?B?K2RRSUs5a2pOL3dEbVhJUi9rRTJBSUtGbzFQQzQvOE9OaVk2aTRLeUlKYkJl?=
 =?utf-8?B?c3pjS1d3M3RsNlh6K2dFQmRsKzBscVgrcXBXZDBiVm5LOGV2Z1JmUVBORTBp?=
 =?utf-8?B?Z0d2eTQ2dzJ3M3V6K3NjSmlUR0d1OERpSmNNMExCckFNOTd0dHJXendSUWRx?=
 =?utf-8?B?TkRaVEJnZGl3OW14OVZjckJQd3h1QTFGTVorMTFkWm9ZZnVSa1p3cTFhRWpS?=
 =?utf-8?B?cVhrNyt2VTdoU3RXVEQ4VkRreGdncTBkMTFMb0FyUUNnaXl0Qm9OVndLeEJJ?=
 =?utf-8?B?M0x2OTNGOUZhNXZ4MUUya0d1WndLMER6VjlkbVB0QzY2ZERBSmhPS2lZVk9y?=
 =?utf-8?B?eVhZeHI3cHAxSk9zc0ZlbUtremZ5RkxhQ0doYXdQOHFVMVRDRTE1dHB1VU1z?=
 =?utf-8?B?VzhRRFlrLzBHQlFuZVk3VW8zeFlCeks4S2VYT0FIK0NhODZVcXFZeGp0RmE4?=
 =?utf-8?B?cFRLUEFpTFBGSUhvaXgrOVhzTUlGTnpWNno0SUoxRmNSVm9VbkdvL2krTGJo?=
 =?utf-8?B?TTB6YjEyNFZERXJ0UmFpS3JmOHBUeUhnVkoxd1pRbzFubW9lWFRjdDRGcENy?=
 =?utf-8?B?M3VhUzR5RkUzVGxTU2VzS05VWjNzZC9HZmVYV3hNeWFRczJkM1B3ZXY0a3c3?=
 =?utf-8?B?REREcDdvY25iNGxzanBSQUVyL3dBUHByVllnVFZMY2gzTk9GVXFuc0EzR2hC?=
 =?utf-8?B?N2NHL0FuLzZJbG9XRnhVTEdJMDAySTFvS2FqNnhYZDNleHBRaUdVbENPaEo0?=
 =?utf-8?B?T3ZvZ1JaTGJYMEVPaUs1QTd4cU9yeFEvRGlDTXoxdTVHWXU2aE80SVVKQ0Zu?=
 =?utf-8?B?V2lXOEZtc2M3Z2hpWmp4a29uTy9BNmVSVGc5V2szNTVwUVRacVhidHlWVXJi?=
 =?utf-8?B?NUo5QzhZZVdKVy91Uy9QNFJkQUhxY29tRGdkSEk0R0J2WnA4amp5YTRvbDZT?=
 =?utf-8?B?cmJnVDJJbnFRSXdCanJXM25vSG5pajZZOXowTEM0MERIaEJrNUxQdCtpdzJU?=
 =?utf-8?B?YjZqVVQ0eTRFd1B6QjFKdjNiMGp0Mk9iajdEbEpNK20zRG1xdFVmemJSUHBR?=
 =?utf-8?B?SzRqWE9OMnBZYVY5akhrdHZlRlMybUh2MjJldC9NemcydDgzMW5jWkR6ZkpT?=
 =?utf-8?B?MEdReDVkQUZVbUlRZDlDU01QYnBDdzEwdmNPaXhwNFhMc3M2b3FvYzhTT3dS?=
 =?utf-8?B?Z05NUXMyakV4SmRsWGZiZno0M0dPNUpEbGVrSVNUWm54eXZycVdDOFBXU0xN?=
 =?utf-8?Q?hcZWz7u8Zoytl9VEcz0T2Dj9O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac138f2c-209b-42aa-d0ce-08dc21438704
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 03:28:29.1146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzBFyZksXH2Mx2hDVzRJ4y+PWVY5Ylx2PSO6MJaYqaGqdrq0zLLpoxl7dxINPJCJt+DB+443Hn6u8GuzsAkW+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5862
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIEphbnVhcnkgMjksIDIwMjQgMTA6NDkgUE0NCj4gDQo+IE9uIDIwMjQvMS8yOSAxNzowNiwg
VGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEV0aGFuIFpoYW88aGFpZmVuZy56aGFvQGxp
bnV4LmludGVsLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDI5LCAyMDI0IDExOjQ5
IEFNDQo+ID4+DQo+ID4+IEJlY2F1c2Ugc3VycHJpc2UgcmVtb3ZhbCBjb3VsZCBoYXBwZW4gYW55
dGltZSwgZS5nLiB1c2VyIGNvdWxkIHJlcXVlc3QNCj4gc2FmZQ0KPiA+PiByZW1vdmFsIHRvIEVQ
KGVuZHBvaW50IGRldmljZSkgdmlhIHN5c2ZzIGFuZCBicmluZ3MgaXRzIGxpbmsgZG93biB0byBk
bw0KPiA+PiBzdXJwcmlzZSByZW1vdmFsIGNvY3VycmVudGx5LiBzdWNoIGFnZ3Jlc3NpdmUgY2Fz
ZXMgd291bGQgY2F1c2UgQVRTDQo+ID4+IGludmFsaWRhdGlvbiByZXF1ZXN0IGlzc3VlZCB0byBu
b24tZXhpc3RlbmNlIHRhcmdldCBkZXZpY2UsIHRoZW4gZGVhZGx5DQo+ID4+IGxvb3AgdG8gcmV0
cnkgdGhhdCByZXF1ZXN0IGFmdGVyIElURSBmYXVsdCB0cmlnZ2VyZWQgaW4gaW50ZXJydXB0IGNv
bnRleHQuDQo+ID4+IHRoaXMgcGF0Y2ggYWltcyB0byBvcHRpbWl6ZSB0aGUgSVRFIGhhbmRsaW5n
IGJ5IGNoZWNraW5nIHRoZSB0YXJnZXQgZGV2aWNlDQo+ID4+IHByZXNlbmNlIHN0YXRlIHRvIGF2
b2lkIHJldHJ5aW5nIHRoZSB0aW1lb3V0IHJlcXVlc3QgYmxpbmRseSwgdGh1cyBhdm9pZA0KPiA+
PiBoYXJkIGxvY2t1cCBvciBzeXN0ZW0gaGFuZy4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTog
RXRoYW4gWmhhbzxoYWlmZW5nLnpoYW9AbGludXguaW50ZWwuY29tPg0KPiA+PiAtLS0NCj4gPj4g
ICBkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYyB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvZG1h
ci5jDQo+ID4+IGluZGV4IDgxNDEzNGU5YWE1YS4uMmUyMTRiNDM3MjVjIDEwMDY0NA0KPiA+PiAt
LS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYw0KPiA+PiArKysgYi9kcml2ZXJzL2lvbW11
L2ludGVsL2RtYXIuYw0KPiA+PiBAQCAtMTI3Miw2ICsxMjcyLDcgQEAgc3RhdGljIGludCBxaV9j
aGVja19mYXVsdChzdHJ1Y3QgaW50ZWxfaW9tbXUNCj4gPj4gKmlvbW11LCBpbnQgaW5kZXgsIGlu
dCB3YWl0X2luZGV4LA0KPiA+PiAgIHsNCj4gPj4gICAJdTMyIGZhdWx0Ow0KPiA+PiAgIAlpbnQg
aGVhZCwgdGFpbDsNCj4gPj4gKwl1NjQgaXFlX2VyciwgaXRlX3NpZDsNCj4gPj4gICAJc3RydWN0
IHFfaW52YWwgKnFpID0gaW9tbXUtPnFpOw0KPiA+PiAgIAlpbnQgc2hpZnQgPSBxaV9zaGlmdChp
b21tdSk7DQo+ID4+DQo+ID4+IEBAIC0xMzE2LDYgKzEzMTcsMTMgQEAgc3RhdGljIGludCBxaV9j
aGVja19mYXVsdChzdHJ1Y3QgaW50ZWxfaW9tbXUNCj4gPj4gKmlvbW11LCBpbnQgaW5kZXgsIGlu
dCB3YWl0X2luZGV4LA0KPiA+PiAgIAkJdGFpbCA9IHJlYWRsKGlvbW11LT5yZWcgKyBETUFSX0lR
VF9SRUcpOw0KPiA+PiAgIAkJdGFpbCA9ICgodGFpbCA+PiBzaGlmdCkgLSAxICsgUUlfTEVOR1RI
KSAlIFFJX0xFTkdUSDsNCj4gPj4NCj4gPj4gKwkJLyoNCj4gPj4gKwkJICogU0lEIGZpZWxkIGlz
IHZhbGlkIG9ubHkgd2hlbiB0aGUgSVRFIGZpZWxkIGlzIFNldCBpbiBGU1RTX1JFRw0KPiA+PiAr
CQkgKiBzZWUgSW50ZWwgVlQtZCBzcGVjIHI0LjEsIHNlY3Rpb24gMTEuNC45LjkNCj4gPj4gKwkJ
ICovDQo+ID4+ICsJCWlxZV9lcnIgPSBkbWFyX3JlYWRxKGlvbW11LT5yZWcgKyBETUFSX0lRRVJf
UkVHKTsNCj4gPj4gKwkJaXRlX3NpZCA9IERNQVJfSVFFUl9SRUdfSVRFU0lEKGlxZV9lcnIpOw0K
PiA+PiArDQo+ID4+ICAgCQl3cml0ZWwoRE1BX0ZTVFNfSVRFLCBpb21tdS0+cmVnICsgRE1BUl9G
U1RTX1JFRyk7DQo+ID4+ICAgCQlwcl9pbmZvKCJJbnZhbGlkYXRpb24gVGltZS1vdXQgRXJyb3Ig
KElURSkgY2xlYXJlZFxuIik7DQo+ID4+DQo+ID4+IEBAIC0xMzI1LDYgKzEzMzMsMTYgQEAgc3Rh
dGljIGludCBxaV9jaGVja19mYXVsdChzdHJ1Y3QgaW50ZWxfaW9tbXUNCj4gPj4gKmlvbW11LCBp
bnQgaW5kZXgsIGludCB3YWl0X2luZGV4LA0KPiA+PiAgIAkJCWhlYWQgPSAoaGVhZCAtIDIgKyBR
SV9MRU5HVEgpICUgUUlfTEVOR1RIOw0KPiA+PiAgIAkJfSB3aGlsZSAoaGVhZCAhPSB0YWlsKTsN
Cj4gPj4NCj4gPj4gKwkJLyoNCj4gPj4gKwkJICogSWYgZ290IElURSwgd2UgbmVlZCB0byBjaGVj
ayBpZiB0aGUgc2lkIG9mIElURSBpcyB0aGUgc2FtZSBhcw0KPiA+PiArCQkgKiBjdXJyZW50IEFU
UyBpbnZhbGlkYXRpb24gdGFyZ2V0IGRldmljZSwgaWYgeWVzLCBkb24ndCB0cnkgdGhpcw0KPiA+
PiArCQkgKiByZXF1ZXN0IGFueW1vcmUgaWYgdGhlIHRhcmdldCBkZXZpY2UgaXNuJ3QgcHJlc2Vu
dC4NCj4gPj4gKwkJICogMCB2YWx1ZSBvZiBpdGVfc2lkIG1lYW5zIG9sZCBWVC1kIGRldmljZSwg
bm8gaXRlX3NpZCB2YWx1ZS4NCj4gPj4gKwkJICovDQo+ID4+ICsJCWlmIChwZGV2ICYmIGl0ZV9z
aWQgJiYgIXBjaV9kZXZpY2VfaXNfcHJlc2VudChwZGV2KSAmJg0KPiA+PiArCQkJaXRlX3NpZCA9
PSBwY2lfZGV2X2lkKHBjaV9waHlzZm4ocGRldikpKQ0KPiA+PiArCQkJcmV0dXJuIC1FVElNRURP
VVQ7DQo+ID4+ICsNCj4gPiBzaW5jZSB0aGUgaGFyZHdhcmUgYWxyZWFkeSByZXBvcnRzIHNvdXJj
ZSBpZCBsZWFkaW5nIHRvIHRpbWVvdXQsIGNhbid0IHdlDQo+ID4ganVzdCBmaW5kIHRoZSBwY2lf
ZGV2IGFjY29yZGluZyB0byByZXBvcnRlZCBpdGVfc2lkPyB0aGlzIGlzIGEgc2xvdyBwYXRoDQo+
IChlaXRoZXINCj4gPiBkdWUgdG8gZGV2aWNlIGluIGJhZCBzdGF0ZSBvciByZW1vdmVkKSBoZW5j
ZSBpdCdzIG5vdCBuZWNlc3NhcnkgdG8gYWRkDQo+IG1vcmUNCj4gPiBpbnRlbGxpZ2VuY2UgdG8g
cGFzcyB0aGUgcGNpX2RldiBpbiwgbGVhZGluZyB0byBvbmx5IGEgcGFydGlhbCBmaXggY2FuIGJl
DQo+IGJhY2twb3J0ZWQuDQo+ID4NCj4gPiBJdCdzIGFsc28gbW9yZSBmdXR1cmUtcHJvb2YsIHNh
eSBpZiBvbmUgZGF5IHRoZSBkcml2ZXIgYWxsb3dzIGJhdGNoaW5nDQo+IGludmFsaWRhdGlvbg0K
PiA+IHJlcXVlc3RzIGZvciBtdWx0aXBsZSBkZXZpY2VzIHRoZW4gbm8gbmVlZCB0byBwYXNzIGlu
IGEgbGlzdCBvZiBkZXZpY2VzLg0KPiANCj4gSSBoYXZlIGV2ZXIgdGhvdWdodCBhYm91dCB0aGlz
IHNvbHV0aW9uIGFuZCBnYXZlIHVwIGluIHRoZSBlbmQgZHVlIHRvDQo+IHRoZSBsb2NraW5nIGlz
c3VlLg0KPiANCj4gQSBiYXRjaCBvZiBxaSByZXF1ZXN0cyBtdXN0IGJlIGhhbmRsZWQgaW4gdGhl
IHNwaW4gbG9jayBjcml0aWNhbCByZWdpb24NCj4gdG8gZW5mb3JjZSB0aGF0IG9ubHkgb25lIGJh
dGNoIG9mIHJlcXVlc3RzIGlzIHN1Ym1pdHRlZCBhdCBhIHRpbWUuDQo+IFNlYXJjaGluZyBwY2lf
ZGV2IGluIHRoaXMgbG9ja2luZyByZWdpb24gbWlnaHQgcmVzdWx0IGluIG5lc3RlZCBsb2NraW5n
DQo+IGlzc3VlcywgYW5kIEkgaGF2ZW4ndCBmb3VuZCBhIGdvb2Qgc29sdXRpb24gZm9yIHRoaXMg
eWV0Lg0KPiANCg0KaW4gc3Bpbi1sb2NrIHlvdSBqdXN0IGdldCB0aGUgc2lkLg0KDQpzZWFyY2hp
bmcgcGNpX2RldiBjYW4gYmUgZG9uZSBvdXRzaWRlIG9mIHRoZSBjcml0aWNhbCByZWdpb24uIGFu
eXdheQ0KdGhlIGhhbmRsaW5nIG9mIC1FQUdBSU4gaXMgYWxyZWFkeSBhZnRlciBzcGluX3VubG9j
ay4NCg==

