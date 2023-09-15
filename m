Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597B47A1572
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 07:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjIOFbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 01:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjIOFbl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 01:31:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F5D2735;
        Thu, 14 Sep 2023 22:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694755890; x=1726291890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hWybNn996JYGGDqKakgZQ4iTOleTab3rqVyJUetSH6s=;
  b=Muqbwdf4OBHT9qS6YE5PT8gOmD121kZnGwOH7n22RiwciKw4u09xkNZb
   BhQ3LB40tNTJE/f7POJQe+5CRaJltsTaSlKJ9GJETaiM1jjcu+Fr7stk6
   czftXqI7r+6E7crCn2gU9xzDnjOMdQIaiTMPmJRiGufOn/2v4fP2ZD7cu
   k7DkhS7O/NOlTgllRqeM5t8xZEv0QAQJL5bmWzaIZe2Fkoxa9Uyonz2H6
   7jqRk4YhM+eiC16yD5hmtp8WMu5/5krE4eLVrkMqEcEKUg+RSwlgNl5LB
   cqkGBhuiuXCDgUJ6U6foTRJ3NfSpgLxMSmLYueIGnQrfyfXbMdXSmNewW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359418843"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="359418843"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 22:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="888090463"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="888090463"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 22:30:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 22:31:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 22:31:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 22:31:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 22:31:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9gy1n9UtkDAC56HuKfSOC3XnWBG4bQu7GFEp9OQ6MEu43tyuu3FPdkvKlZbOEdbI3w7Fv1xWVK7YTYDgEuYdDabgvquZ9Iq7LgW7d392mnQc23BzPP0zY8C4Yn2Z3MiqErvWICPSCd+KeCDhJze2rY3RVY1bYmk7LZlpdAGuf6r25ru1XRYYyF3xzOZzbtVqzWTKICoXPaZZvNmji3GrfZmzzIHI3tNvEeBRMsqNMfOyA5scDdzS4M/jmyKvpErN8/rDH5kV5G8vR2oorB4+5g93N7GNDHZzXCU5ohum2NLn4TVKvDm6Yp+no/Ctz3Ou4KR8UTSo3VIUJc5R6ssng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWybNn996JYGGDqKakgZQ4iTOleTab3rqVyJUetSH6s=;
 b=bTbk3S2pRB7TeNiYS65TjlmJcfL8P5uJh24Fsq4PTBlXMbXakc5rQXW7TSaYmya6X7kP6NxqYhtu2llPbFVeYqEwH6Ibyaj4jYnCc9nDr4xDC+vEXZZ5S3/XpN2yOa+5oTxRCTWTDxeVVcOGBlSRzfG44wgiXdVUt8qAVmiM0rATAhC5YCb5SZAWVipStvAl2mB3EWqqNaEQAqfShtLDq8xKivmdJyb/MuEO8qq2ikc3fnJxbG/1SHSjT1LA6zwlsFKK5MOOv5VNtC4EM9IludnEgFxu/6+UZCGOl6S778rNg7o8czd8J90AhFjrb86+02y5imNDBkz2JIX4A8ieCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB2624.namprd11.prod.outlook.com (2603:10b6:805:64::14)
 by SN7PR11MB6560.namprd11.prod.outlook.com (2603:10b6:806:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.41; Fri, 15 Sep
 2023 05:31:26 +0000
Received: from SN6PR11MB2624.namprd11.prod.outlook.com
 ([fe80::ab1a:364e:5c0:430b]) by SN6PR11MB2624.namprd11.prod.outlook.com
 ([fe80::ab1a:364e:5c0:430b%7]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 05:31:26 +0000
From:   "Xu, Even" <even.xu@intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lee, Jian Hui" <jianhui.lee@canonical.com>,
        "Zhang, Lixu" <lixu.zhang@intel.com>,
        "Ba, Najumon" <najumon.ba@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
Thread-Topic: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
Thread-Index: AQHZ5sKmjsJQWHkOtEGLHUKsvcaerrAafreAgAC8T9A=
Date:   Fri, 15 Sep 2023 05:31:25 +0000
Message-ID: <SN6PR11MB26245C44E84C37C1B551260EF4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
References: <20230914041806.816741-1-kai.heng.feng@canonical.com>
 <7b45ac2ed091497b4e21a6a5c19956161175ba16.camel@linux.intel.com>
In-Reply-To: <7b45ac2ed091497b4e21a6a5c19956161175ba16.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2624:EE_|SN7PR11MB6560:EE_
x-ms-office365-filtering-correlation-id: be3d923a-db8f-4f41-b1a9-08dbb5ad014e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eNXE3NwCBm6PEuAOiA28I1LXLpyDmkYawNU6yriyULqf5hshyn2XW5xI+ruwSeEunBhdjJ6xyrEg016yzONca3BpaQoY7Bg10NkF4yewqStqdylkJvhz8ajCzZ87poHXu23wAj/nHUGF8tfISKJdvTINks1af96tpO9nf9b+a8w4UTA+wOJ0GeVhbqiCQeKAXbo8RKSJb9sRdYV1WErEm6tfr+dWu3BlWGrZXKnASURHtREtTSUMlzdkTL8qBWZxPS6ViXJhJ6Y4cP4MipkGTaBq04pICdFDcLl4SY/oOcTXX4BL2LH25shfIjWN4BAQzf7j3tpKbK9ZERPiP9/PMNUAEJsEWBxXbGXa3jFZGlyOfKhGdfp0pbip/4MTIm8rDJqPYGOf3GPjSFl9B1/sl4J3htAhSK7I/JguTgfYGylYgLXpOYgyDUPwc2tretHsyn0JQqlyuV685gb1pUqNVAleSQAPdAaNEdfO3rX4CvbITleGct4Xouz8wGtWpLQ+iWMJsWrNRLb0hk0MKQ5l9Kosk8W1rcmT90z3bRALAOuVcy7dwKG1FUGpiOlDGFUuAS1Xh7xbMrVUJMNofbVMSBeYv9n/0aZg+xXHEdAASL9mMcUk1V3JWWDJSa8Vkq8F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(186009)(451199024)(1800799009)(26005)(6506007)(71200400001)(53546011)(7696005)(9686003)(2906002)(478600001)(4326008)(52536014)(8936002)(8676002)(76116006)(66476007)(66946007)(66446008)(66556008)(64756008)(5660300002)(110136005)(54906003)(316002)(41300700001)(83380400001)(55016003)(86362001)(82960400001)(33656002)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajM0RzhOWTBJaktFQnpwWEdnMTdzS3hqMmVsS3JxVmVmbmtqTjVkYXI0VENC?=
 =?utf-8?B?U3Jaak80MWp0QkhwamY3ODI1OWx5RDFreERUUE03eVJ5N2NGYkU5OTZpakEr?=
 =?utf-8?B?RnpUTDFpTTFqRkpDalN4aTVDWDZDbXN0TC9uQi9POWthSDVmbWVYUVRDT2c0?=
 =?utf-8?B?NXpzaVRhVGlvbkdBNFFleldIVTJBVTZjK3plOWdhZmJWRXlIeWFmNE43dHlS?=
 =?utf-8?B?cHRWR0hnYjJ4MWgyanNoNTN4a01vMExVTm1DYVhsZjBJcCs0dG9xbzdjaUVq?=
 =?utf-8?B?NjJhN0pvKzlmMnZsdlRCVk5WTDV6Ykt6VkQ0Wm9Bb0JuZXpMamtBb2lsWUpa?=
 =?utf-8?B?cmkvM3NJQ1dSRGJDLzV2SjlZSDVMcGRoRjg4aG50azJRN0hWc1RaL2dXbEtG?=
 =?utf-8?B?cDJPY2tidFl3N2U5a0R3bklzM25SejBjYWRCcVdHaVJJUG01Q05DUjgwMGdq?=
 =?utf-8?B?QldtWFhjb1cxYXVwalVEcW00Uk0zUGtvQUp2OGIrMVhlWU45M1NDTE9TOUdP?=
 =?utf-8?B?OGtKdE1taytSWXBLRnY4LzZiR1E5L2pxdGlPUzVqK2FxWDFpQnhHbFg5cjlX?=
 =?utf-8?B?aEpkOGc4QXE3eUc0MWlTUGJ5bFVrMnBDeXdUVW16elI3NEM5TDJpendzS1FT?=
 =?utf-8?B?QTJpYlA5RHlIWDRYeURhQlJkelRMN3VFQkd0NTQyNU0vaXpRK21JWSs0QjMv?=
 =?utf-8?B?NjBJTmhMSlFVV1Q5Q215eThmZFltcG4vMGFuaUV2UVNQY2dxUlVhLzFadk1a?=
 =?utf-8?B?bXYzeFF2aGhDMGg0K29WR1JhOTBSaTZENGJKMGl3UHZNbWZBU2VpVC9WZmtm?=
 =?utf-8?B?UUVZeVNhREQvUnJLdlF3c0pLbXBzM2lKOGlHRVRTWVpIZktPUXpBSTlWbkIy?=
 =?utf-8?B?VjN3MGNWMi93SEVBQUkveEZaTEw2UC9UVk1HUDkzbWFubWRrVXZiWStmR1FI?=
 =?utf-8?B?eC9WVHRsRS9yaTg4cEJoRmhxVU5WVStUWWk2cDhZQUNhUTREMDlqa0FYYnYx?=
 =?utf-8?B?amFQT1F1ZnpWSXZUU0J3eWtpd3NpNHp2S1A0N0lLNldoR082YWN0VWRpcW56?=
 =?utf-8?B?citjMVhjU2F4cjhtY3RnRHZJRlZPRE02R2IycWQ0VG4rZXpPdTcwZUVaMnZF?=
 =?utf-8?B?R0NMdjRDU3A2QTVjYktobTRoeDlRRFI4QWI1S3hsSzR2OWZmMlExajBSWGFG?=
 =?utf-8?B?TzV4cEpDSTMraTJQWWdDK3dCTzFuUkg0blB3RjI1V2pTUXpVU0pFS1JrbWtX?=
 =?utf-8?B?djJ1L1dXYzVBYUNmc2tFaHhBSjJsT1lqVm1aN3h0Y1YxNEkrZWFFYjRONzVl?=
 =?utf-8?B?ZjNCNk1WcDVGL204akdNTm1VVWlPTGMrd2V0Tms1dkhPRG51VERIM1Evb3M5?=
 =?utf-8?B?RlpNcXVUanJsaVFPYzUxNXpJUGZxTzhkbnJrby9pV2d6M1YxdWVlV2hxZ3Z5?=
 =?utf-8?B?T1Ewa0NVTFBmUWkwNEZTQWErZ0tYQTRUNUZTUXI0ckdIUzFtQlJZMHRBYUJS?=
 =?utf-8?B?MEdnaXpFa2ZEYUVUajh1TEJEVHFJdDludENndjJ0YnZHOHFZTzlKRWIxYTNj?=
 =?utf-8?B?MUowd3ZKQVl1dWo4MWVZQy9Yc1JHbFBVS0pVSVV5ZTFUUnF4YkJkd240MUhn?=
 =?utf-8?B?b3JIRUlRQXYxeDdUZHppQXNacnl4WW5CMmhuUDhCQVJYV1hIUjZCamRtUXVn?=
 =?utf-8?B?WG1WMHJwTWtBUmhLQkhNZ0puN1ZjbXFGUTVXa1lDZHk0Nk5Ua3c1V3ZIb0s3?=
 =?utf-8?B?MGxCTEd5Ni8rY1EzUXhKZzFCSDliMWZxcWFNZW5sakZuL2VlNnRRb1pRK0dE?=
 =?utf-8?B?ZlZFdkZqK09VOEc2N3YxdkpGblRRd29UaEZkN1dPTFg1TTNIY05UZm9vaWdD?=
 =?utf-8?B?ay95SGt0R0ZNd1JodlhLdGYwaVJXMTA3c2VIOUlZbFFPR0tkSldpVE1IVVcx?=
 =?utf-8?B?SzBNVmY3ckY0KzloTGw2Vm92SlZ1Y0NFbWJPQjVxVHN2QUlTLytQY2pyeUtZ?=
 =?utf-8?B?aFpubmxOcC9oM3QwY2VFbWRta2tDWDdqcXhkaXQ4SkNaeXd1Y0NjaUlZZ2hN?=
 =?utf-8?B?OU00SGJHOUI0RFdQUHh0SWJLN0FRaW4rTGlpbU5lRGorYklwcTdlaGxNS2o2?=
 =?utf-8?Q?YpEs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3d923a-db8f-4f41-b1a9-08dbb5ad014e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 05:31:25.8412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZaJun4lf7QNuPc7t6atEJ03fA6u5UVolKIwN3CVNopOb7q6fmkfSvB/fGKX516O46wIucmGoC7jeZsFJVyUfQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6560
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksIFNyaW5pdmFzLA0KDQpTdXJlLCBJIHdpbGwgdGVzdCBpdC4NCkFzIGxvbmcgdGVybSBub3Qg
d29ya2luZyBvbiBFSEwsIEkgZG9lc24ndCBoYXZlIEVITCBib2FyZCBvbiBoYW5kIHJpZ2h0IG5v
dywgSSBjYW4gdGVzdCB0aGlzIHBhdGNoIG9uIG90aGVyIElTSCByZWxhdGVkIHBsYXRmb3Jtcy4N
CkZyb20gdGhlIHBhdGNoLCBpdCdzIGZvY3VzIG9uIEVITCBwbGF0Zm9ybSwgSSBhc3N1bWUgS2Fp
LUhlbmcgYWxyZWFkeSB2ZXJpZmllZCB0aGUgZnVuY3Rpb24gb24gRUhMIGJvYXJkLg0KSSBkb24n
dCB0aGluayBpdCB3aWxsIHRha2UgZWZmZWN0IG9uIG90aGVyIHBsYXRmb3JtcywgYW55d2F5LCBJ
IHdpbGwgdGVzdCBpdCBvbiB0aGUgcGxhdGZvcm1zIEkgaGF2ZSB0byBwcm92aWRlIGNyb3NzIHBs
YXRmb3JtIHZlcmlmaWNhdGlvbi4NCg0KVGhhbmtzIQ0KDQpCZXN0IFJlZ2FyZHMsDQpFdmVuIFh1
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBzcmluaXZhcyBwYW5kcnV2YWRh
IDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4gDQpTZW50OiBGcmlkYXksIFNl
cHRlbWJlciAxNSwgMjAyMyAxMjoxMSBBTQ0KVG86IEthaS1IZW5nIEZlbmcgPGthaS5oZW5nLmZl
bmdAY2Fub25pY2FsLmNvbT47IGppa29zQGtlcm5lbC5vcmc7IGJlbmphbWluLnRpc3NvaXJlc0By
ZWRoYXQuY29tDQpDYzogbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBMZWUsIEppYW4gSHVpIDxqaWFuaHVpLmxlZUBjYW5vbmljYWwuY29tPjsgWHUs
IEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPjsgWmhhbmcsIExpeHUgPGxpeHUuemhhbmdAaW50ZWwu
Y29tPjsgQmEsIE5hanVtb24gPG5hanVtb24uYmFAaW50ZWwuY29tPjsgbGludXgtaW5wdXRAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTog
W1BBVENIXSBISUQ6IGludGVsLWlzaC1oaWQ6IGlwYzogUmV3b3JrIEVITCBPT0Igd2FrZXVwDQoN
CkhpIEV2ZW4sDQoNCk9uIFRodSwgMjAyMy0wOS0xNCBhdCAxMjoxOCArMDgwMCwgS2FpLUhlbmcg
RmVuZyB3cm90ZToNCj4gU3lzdGVtIGNhbm5vdCBzdXNwZW5kIG1vcmUgdGhhbiAyNTUgdGltZXMg
YmVjYXVzZSB0aGUgZHJpdmVyIGRvZXNuJ3QgDQo+IGhhdmUgY29ycmVzcG9uZGluZyBhY3BpX2Rp
c2FibGVfZ3BlKCkgZm9yIGFjcGlfZW5hYmxlX2dwZSgpLCBzbyB0aGUgDQo+IEdQRSByZWZjb3Vu
dCBvdmVyZmxvd3MuDQo+IA0KPiBTaW5jZSBQQ0kgY29yZSBhbmQgQUNQSSBjb3JlIGFscmVhZHkg
aGFuZGxlcyBQQ0kgUE1FIHdha2UgYW5kIEdQRSB3YWtlIA0KPiB3aGVuIHRoZSBkZXZpY2UgaGFz
IHdha2V1cCBjYXBhYmlsaXR5LCB1c2UgZGV2aWNlX2luaXRfd2FrZXVwKCkgdG8gbGV0IA0KPiB0
aGVtIGRvIHRoZSB3YWtldXAgc2V0dGluZyB3b3JrLg0KPiANCj4gQWxzbyBhZGQgYSBzaHV0ZG93
biBjYWxsYmFjayB3aGljaCB1c2VzIHBjaV9wcmVwYXJlX3RvX3NsZWVwKCkgdG8gbGV0IA0KPiBQ
Q0kgYW5kIEFDUEkgc2V0IE9PQiB3YWtldXAgZm9yIFM1Lg0KPiANClBsZWFzZSB0ZXN0IHRoaXMg
Y2hhbmdlLg0KDQpUaGFua3MsDQpTcmluaXZhcw0KDQo+IEZpeGVzOiAyZTIzYTcwZWRhYmUgKCJI
SUQ6IGludGVsLWlzaC1oaWQ6IGlwYzogZmluaXNoIHBvd2VyIGZsb3cgZm9yIA0KPiBFSEwgT09C
IikNCj4gQ2M6IEppYW4gSHVpIExlZSA8amlhbmh1aS5sZWVAY2Fub25pY2FsLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogS2FpLUhlbmcgRmVuZyA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPg0K
PiAtLS0NCj4gwqBkcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlkL2lwYy9wY2ktaXNoLmMgfCA1OSAr
KysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspLCA0NCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2hp
ZC9pbnRlbC1pc2gtaGlkL2lwYy9wY2ktaXNoLmMNCj4gYi9kcml2ZXJzL2hpZC9pbnRlbC1pc2gt
aGlkL2lwYy9wY2ktaXNoLmMNCj4gaW5kZXggNTVjYjI1MDM4ZTYzLi42NWU3ZWViMmZhNjQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL3BjaS1pc2guYw0KPiAr
KysgYi9kcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlkL2lwYy9wY2ktaXNoLmMNCj4gQEAgLTExOSw0
MiArMTE5LDYgQEAgc3RhdGljIGlubGluZSBib29sIGlzaF9zaG91bGRfbGVhdmVfZDBpMyhzdHJ1
Y3QgDQo+IHBjaV9kZXYgKnBkZXYpDQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gIXBtX3Jlc3Vt
ZV92aWFfZmlybXdhcmUoKSB8fCBwZGV2LT5kZXZpY2UgPT0gDQo+IENIVl9ERVZJQ0VfSUQ7DQo+
IMKgfQ0KPiDCoA0KPiAtc3RhdGljIGludCBlbmFibGVfZ3BlKHN0cnVjdCBkZXZpY2UgKmRldikg
LXsgLSNpZmRlZiBDT05GSUdfQUNQSQ0KPiAtwqDCoMKgwqDCoMKgwqBhY3BpX3N0YXR1cyBhY3Bp
X3N0czsNCj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IGFjcGlfZGV2aWNlICphZGV2Ow0KPiAtwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgYWNwaV9kZXZpY2Vfd2FrZXVwICp3YWtldXA7DQo+IC0NCj4gLcKg
wqDCoMKgwqDCoMKgYWRldiA9IEFDUElfQ09NUEFOSU9OKGRldik7DQo+IC3CoMKgwqDCoMKgwqDC
oGlmICghYWRldikgew0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2Vycihk
ZXYsICJnZXQgYWNwaSBoYW5kbGUgZmFpbGVkXG4iKTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAtRU5PREVWOw0KPiAtwqDCoMKgwqDCoMKgwqB9DQo+IC3CoMKgwqDC
oMKgwqDCoHdha2V1cCA9ICZhZGV2LT53YWtldXA7DQo+IC0NCj4gLcKgwqDCoMKgwqDCoMKgYWNw
aV9zdHMgPSBhY3BpX2VuYWJsZV9ncGUod2FrZXVwLT5ncGVfZGV2aWNlLCB3YWtldXAtDQo+ID5n
cGVfbnVtYmVyKTsNCj4gLcKgwqDCoMKgwqDCoMKgaWYgKEFDUElfRkFJTFVSRShhY3BpX3N0cykp
IHsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGV2LCAiZW5hYmxl
IG9zZV9ncGUgZmFpbGVkXG4iKTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiAtRUlPOw0KPiAtwqDCoMKgwqDCoMKgwqB9DQo+IC0NCj4gLcKgwqDCoMKgwqDCoMKgcmV0
dXJuIDA7DQo+IC0jZWxzZQ0KPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT0RFVjsNCj4gLSNl
bmRpZg0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgdm9pZCBlbmFibGVfcG1lX3dha2Uoc3RydWN0IHBj
aV9kZXYgKnBkZXYpIC17DQo+IC3CoMKgwqDCoMKgwqDCoGlmICgocGNpX3BtZV9jYXBhYmxlKHBk
ZXYsIFBDSV9EMCkgfHwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX3BtZV9jYXBhYmxl
KHBkZXYsIFBDSV9EM2hvdCkgfHwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX3BtZV9j
YXBhYmxlKHBkZXYsIFBDSV9EM2NvbGQpKSAmJiAhZW5hYmxlX2dwZSgmcGRldi0NCj4gPmRldikp
IHsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBjaV9wbWVfYWN0aXZlKHBkZXYs
IHRydWUpOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2RiZygmcGRldi0+
ZGV2LCAiaXNoIGlwYyBkcml2ZXIgcG1lIHdha2UgDQo+IGVuYWJsZWRcbiIpOw0KPiAtwqDCoMKg
wqDCoMKgwqB9DQo+IC19DQo+IC0NCj4gwqAvKioNCj4gwqAgKiBpc2hfcHJvYmUoKSAtIFBDSSBk
cml2ZXIgcHJvYmUgY2FsbGJhY2sNCj4gwqAgKiBAcGRldjrCoMKgwqDCoMKgwqBwY2kgZGV2aWNl
DQo+IEBAIC0yMjUsNyArMTg5LDcgQEAgc3RhdGljIGludCBpc2hfcHJvYmUoc3RydWN0IHBjaV9k
ZXYgKnBkZXYsIGNvbnN0IA0KPiBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqZW50KQ0KPiDCoA0KPiDC
oMKgwqDCoMKgwqDCoMKgLyogRW5hYmxlIFBNRSBmb3IgRUhMICovDQo+IMKgwqDCoMKgwqDCoMKg
wqBpZiAocGRldi0+ZGV2aWNlID09IEVITF9BeF9ERVZJQ0VfSUQpDQo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBlbmFibGVfcG1lX3dha2UocGRldik7DQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBkZXZpY2VfaW5pdF93YWtldXAoZGV2LCB0cnVlKTsNCj4gwqANCj4g
wqDCoMKgwqDCoMKgwqDCoHJldCA9IGlzaF9pbml0KGlzaHRwKTsNCj4gwqDCoMKgwqDCoMKgwqDC
oGlmIChyZXQpDQo+IEBAIC0yNDgsNiArMjEyLDE5IEBAIHN0YXRpYyB2b2lkIGlzaF9yZW1vdmUo
c3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+IMKgwqDCoMKgwqDCoMKgwqBpc2hfZGV2aWNlX2Rpc2Fi
bGUoaXNodHBfZGV2KTsNCj4gwqB9DQo+IMKgDQo+ICsNCj4gKy8qKg0KPiArICogaXNoX3NodXRk
b3duKCkgLSBQQ0kgZHJpdmVyIHNodXRkb3duIGNhbGxiYWNrDQo+ICsgKiBAcGRldjrCoMKgwqDC
oMKgwqBwY2kgZGV2aWNlDQo+ICsgKg0KPiArICogVGhpcyBmdW5jdGlvbiBzZXRzIHVwIHdha2V1
cCBmb3IgUzUgICovIHN0YXRpYyB2b2lkIA0KPiAraXNoX3NodXRkb3duKHN0cnVjdCBwY2lfZGV2
ICpwZGV2KSB7DQo+ICvCoMKgwqDCoMKgwqDCoGlmIChwZGV2LT5kZXZpY2UgPT0gRUhMX0F4X0RF
VklDRV9JRCkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBjaV9wcmVwYXJlX3Rv
X3NsZWVwKHBkZXYpOyB9DQo+ICsNCj4gwqBzdGF0aWMgc3RydWN0IGRldmljZSBfX21heWJlX3Vu
dXNlZCAqaXNoX3Jlc3VtZV9kZXZpY2U7DQo+IMKgDQo+IMKgLyogNTBtcyB0byBnZXQgcmVzdW1l
IHJlc3BvbnNlICovDQo+IEBAIC0zNzAsMTMgKzM0Nyw2IEBAIHN0YXRpYyBpbnQgX19tYXliZV91
bnVzZWQgaXNoX3Jlc3VtZShzdHJ1Y3QgDQo+IGRldmljZSAqZGV2aWNlKQ0KPiDCoMKgwqDCoMKg
wqDCoMKgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGRldmljZSk7DQo+IMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgaXNodHBfZGV2aWNlICpkZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRl
dik7DQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoC8qIGFkZCB0aGlzIHRvIGZpbmlzaCBwb3dlciBm
bG93IGZvciBFSEwgKi8NCj4gLcKgwqDCoMKgwqDCoMKgaWYgKGRldi0+cGRldi0+ZGV2aWNlID09
IEVITF9BeF9ERVZJQ0VfSUQpIHsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBj
aV9zZXRfcG93ZXJfc3RhdGUocGRldiwgUENJX0QwKTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGVuYWJsZV9wbWVfd2FrZShwZGV2KTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGRldl9kYmcoZGV2LT5kZXZjLCAic2V0IHBvd2VyIHN0YXRlIHRvIEQwIGZvciBl
aGxcbiIpOw0KPiAtwqDCoMKgwqDCoMKgwqB9DQo+IC0NCj4gwqDCoMKgwqDCoMKgwqDCoGlzaF9y
ZXN1bWVfZGV2aWNlID0gZGV2aWNlOw0KPiDCoMKgwqDCoMKgwqDCoMKgZGV2LT5yZXN1bWVfZmxh
ZyA9IDE7DQo+IMKgDQo+IEBAIC0zOTIsNiArMzYyLDcgQEAgc3RhdGljIHN0cnVjdCBwY2lfZHJp
dmVyIGlzaF9kcml2ZXIgPSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAuaWRfdGFibGUgPSBpc2hfcGNp
X3RibCwNCj4gwqDCoMKgwqDCoMKgwqDCoC5wcm9iZSA9IGlzaF9wcm9iZSwNCj4gwqDCoMKgwqDC
oMKgwqDCoC5yZW1vdmUgPSBpc2hfcmVtb3ZlLA0KPiArwqDCoMKgwqDCoMKgwqAuc2h1dGRvd24g
PSBpc2hfc2h1dGRvd24sDQo+IMKgwqDCoMKgwqDCoMKgwqAuZHJpdmVyLnBtID0gJmlzaF9wbV9v
cHMsDQo+IMKgfTsNCj4gwqANCg0K
