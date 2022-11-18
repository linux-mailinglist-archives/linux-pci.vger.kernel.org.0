Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC7A62EFD3
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 09:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbiKRInq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 03:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241579AbiKRIna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 03:43:30 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5968EB71;
        Fri, 18 Nov 2022 00:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668761000; x=1700297000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IYy8yg3Z6c7UlScjwdf9/1RtckREIA6AE6YdTWhaMjY=;
  b=T9Jr9GpZC/FdwNkFUfE8WX1nVnNAtNGZbJcl7NZ9b0EPAluUfI/NJ3HG
   Bc1/nt8ygz85lYnEjXSY0U2DkKiLEdh0LrB6vm4nSsVpJtfTTpCXSr7LD
   FO2uJAZJP17XMY9r0IVyttrl/U11gui8OF/yU9/x8BFP6IFA/++BtuxII
   MTCfuwCfRpMGsrWF/mKBBGtDAyoYqt+zekJP7MLZzZCqEI2L/GqRXYDVT
   81JKPEgweVuNN/KLWwX3xUAvJAlbzoBzwQj725ghQmVv68k4r2UvU+UFt
   ELiJcJXMFoRSXK4UXbZBcDlyecPfW8rGZcBWnq17O1kdYXN1ejunYHULR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="292791681"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="292791681"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 00:43:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="671250189"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="671250189"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 18 Nov 2022 00:43:19 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 00:43:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 00:43:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 00:43:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 00:43:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4oBQCvVG2bMCUO+dxqhBNu0CPGbyjxohBVs6yBpGHaQ7WxWi8WatQnOF5x8Z4NOvHTXBzWjGOxAt2kcFJC7v6+oRgYVu9BU5QRy4huxSloA2dDtQufVT04Gwr8yl7A8/ODk83eVhquIxHZZtN1C8QMbvbh4Kk+0tl/IvvKGIzsVNUFXajW/2D6BfW05+BrpVSkZzBTsJsmg6YB7PhUkfKXpTmcHjb5OmXC2V9FY48PCTc4kILqv6pN/M54QevXDZnwId2HP8XdZAVjqoS2Kby/mp5rRAu+Mn5a2VX3070+RaqVlrO89i4xMWPh6bLxHVttyDP/oBsYyT1erGJRX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYy8yg3Z6c7UlScjwdf9/1RtckREIA6AE6YdTWhaMjY=;
 b=KXXLAnMElM3uX0lGAFr2HvaUzgHE46K1EmkNjwbTZ4RPVMonFq99j7i7yf/y/UKeUQzNaY9BDAWitDB5C1VktI62KkR/cnQrztJgm1DweByEXR+kpI7QD/RqF5QyNedsFcrzt/tf3TPxgYovzWMf0WE84M4/cmjoyfGPo00pRTQ+qMEYLhoZcnuajDnxDFqztteJWP5BDEPUSditmCZi/nHDEUz1YSlK/oRWGKrhtCArwEr++kc/LhQNGFaY+8Qabydy9/sWDcOgE6CP5kxWA73k820/M2N5L8b3rufiBRtnxDHssYjNRLlAXwZ4hHxKgsFBB5JksFqiax6B2Grwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6818.namprd11.prod.outlook.com (2603:10b6:930:62::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 08:43:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 08:43:16 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: RE: [patch 15/20] genirq/msi: Provide new domain id allocation
 functions
Thread-Topic: [patch 15/20] genirq/msi: Provide new domain id allocation
 functions
Thread-Index: AQHY9dWAtezPKicU9k+8s39P1gVnWK5EOeAA
Date:   Fri, 18 Nov 2022 08:43:16 +0000
Message-ID: <BN9PR11MB527679752FAA7294E33619C98C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.892426212@linutronix.de>
In-Reply-To: <20221111132706.892426212@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6818:EE_
x-ms-office365-filtering-correlation-id: 625f582c-8b1a-45e4-3c4a-08dac940efd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +SOzYE9ev8o2/g2Zgmopq7/ysFPLzRXYn09OM/2bGFI6AkYCuaUGYU2LL6bkchidiRtdAhw1/FEGPOwuLjuf7SMAlH6i2AQDSX/KSfP48o5Bh7OJgj7tB67ksJrqTfaLA7YMkpxwSaYGmeif8ReQ+kE9vFAk9esn9VtS0HlBUknLMX3KSjWmmXByLjTx5vzkkBdZfIwOJtM/7mASDlNJ15DmG54iGJLlRLM9+Eu1D/AZM8W2eq/lEGn9skZTn7ydBU4ApYtdl5av9Y+wpbW3THRPpqV81m/XrO1vLLIMp5UF4/ksXyZ074ecLGL4lLPniNt5CXO+e4DBX4HZzKS8FZRUdJMmK7NQRgxuHZg42QPDt+kBNe/h9cSPaDE0MXnStGyessxeJpiOgskJpgQB4IQfoeSmXxq7qb4mbZn81cSs/fkrNDNXb1rM5GP+5wdAjuk6Noy6xwNOaK5w/NqY0TXjk/W34Oh/p/fff9Q254iF9ZdTN8sQllwD8Y1e8D6NySe0nA3YVbS1dcfVl5wanvjhxRF5bNY86nHmc0E7k7Eh9c5LkQH7PZX5SOVY7F9P4+sx1N96mmK5aTZnVNCJItdn7eIwNm+1kgVD5m7hjhvM7ew5P3920wRhGg38LWaiNVAfmUud/sB9FEE9kq2UC4+a66njQ2zPw7LVA+2KO0VEN+bw5Yjjlr76WJmiN8/QdzvErtz3cisE2PqBbkTNDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199015)(33656002)(38100700002)(82960400001)(66946007)(2906002)(7416002)(4744005)(4326008)(38070700005)(8936002)(86362001)(122000001)(83380400001)(110136005)(8676002)(316002)(54906003)(186003)(478600001)(52536014)(66556008)(66446008)(66476007)(26005)(64756008)(5660300002)(41300700001)(107886003)(6506007)(71200400001)(9686003)(55016003)(76116006)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGpMSVZjUlhlbXE4b0cvOGlpZXFYZHZHK0M2cm9KSU90SmJRQ2dXZXJPSkV3?=
 =?utf-8?B?U0l5eEppeWJ1OGJ4d1F5dE1oYUhETnFPbWxUeUdkWk9OcUpia0xUaXNFVGxO?=
 =?utf-8?B?VG0wcVZqcEJxN0h5YU83MG1ndVNrN0NOcWNDejRIRDRPc0NOb0I4STJSU0lT?=
 =?utf-8?B?V0xVckdvT2dkUitKSWFUTEJWd2dKbk5ySUFQeUhTbTNjbitDN3EzTGx5N2w5?=
 =?utf-8?B?YmZNZzJENmIraWlEekNRODk3V3o5czhRbGpuRkxrMzA1S2cybTFjSjhMd29j?=
 =?utf-8?B?THBvc1lQcGQ1bGZ3WTVIMzBrZUFISGdYc29IajNoS1lYcCtlVGVzM0hNRitE?=
 =?utf-8?B?bUQ2aUFiVmtCM29NRkNHMksrY3hLemdPWWFteXJJTmZURE1nUDZxNW1aOXRV?=
 =?utf-8?B?WG5HdDhhM1plTWhrNUVEak5pQzBWQlNTTlFvekNFM05SYlNmVVR1KzRreTBx?=
 =?utf-8?B?RGd1ZDFoYWY2UStOL0FjRzI0VjViQTlNRkM5VkNCLy9YTHdJaGxKT1ZzbXk3?=
 =?utf-8?B?MVlsdWVWMnNDMlZDaE1PL1ZsMlFBZ28wR1dYR3RQbW02cS9XVUl5WGp3TktE?=
 =?utf-8?B?UXpxdkMyWksyOUtpTEdPMGUwYXBZdkZaMmllcURVT2QwTm83SXRuRjcvMjR5?=
 =?utf-8?B?RWxPWWJWSngyK0FBQkZNU0prYTF4RWxxUGFLUlVlRWJ2SGZDd0NnM09FRzZ0?=
 =?utf-8?B?Vkx3bi9aZlhjRXdqWFh3THRYUmdFRU53akNLbFBXWE92eHlzeVdaRi95VlhM?=
 =?utf-8?B?M3p0Z3M4QklLQ0Vicy9xMld5Zk41UlBVZElzVHJFRklTd1RScitwYnRwOFd5?=
 =?utf-8?B?MFN0d2Q1a1E2R2tPRTlseURvRDJxVE9sMHQ3eGZUT20zejNnWjRQNVdwVWlI?=
 =?utf-8?B?VS8xeXVjS2taR1Zyb0J4bG9NUjVENjlQLzFzT2NuTkczZytwdDYwcmE1c20z?=
 =?utf-8?B?RkZmUUxTREhLQ204WkJETEFRQkxsK2E1emU1UUlucFlQQ0Z1bDI2Umc4V0Y2?=
 =?utf-8?B?RkYwL1pwUXE5RUFUL3FyT21EK3dSb2t2aGFybW1wSDFBZi95Y0Roa2FHdU1v?=
 =?utf-8?B?aEJxRU5EWkNmMithZlBKQXpiVVV4UVBKWElnSFQzVStXVEpIVmhyak1CeFhT?=
 =?utf-8?B?aTV6UGRoRWhZYTJSYU82RGVVTnZhVW1CNlRyUm1QYmE1SHRmUFg3bFVFK3N6?=
 =?utf-8?B?SGVNN2dXU0pScWozS2FCeit5RzVJMVhWR0RsMHBpaDAyRVpsaTByeHR3Nitj?=
 =?utf-8?B?SDhGMDYyNXIrME1KMHlaaEN3aHQvcU9JWGFvMnVRNjh1aHpuR1EwZFN2SThz?=
 =?utf-8?B?L2pvcnYzQ2JkZ2E0UW5vRDZPd3FMeUtrSW90alFFaDBBRGl6WkQxclk2Smh0?=
 =?utf-8?B?VTRHbnFJcHBqWno4NXJDRlFsYWhteDhZNG9DTnQ5TWFiVUJQekZIOWZDVDcy?=
 =?utf-8?B?c3hGTmRldHhJZXhMOXNwUlBNLzQxRzJFK1I3ZW1MQUFPZDNLcHR0VHdUYTFW?=
 =?utf-8?B?cnVkell5TzFYQmRtMWZFNVJ2V2YrR3NFMkFOc2hmS0t0MlA1SUlJWGFLZzhQ?=
 =?utf-8?B?RGFwRnRSVG5ZRERtbW8xZGxDcVVFSHoxNjBkeDRFTmw0d1dWSXczbkVwamdp?=
 =?utf-8?B?a0VERHFsRXNQcHNBQXN1RHA2ZHdrNXhDazFWaS95NW1zc1diNWR0UEhjaUkw?=
 =?utf-8?B?bmxMd1BiTzJHS3ZWbFdHVC8wcE1KT2dpQXBxdVh3L2xON21OY01tcVRRZHpo?=
 =?utf-8?B?Q29oSm9oaHM0RCtFeUpSbCtRRCswYXBXRXBJYnlKWEdHblpBTDJwWjJleDVt?=
 =?utf-8?B?a2l2QTNwbEhlN2JOb2VoL2djcnU5NWJna1E1RDQwOUNMdnZyU0tIRExsNXdR?=
 =?utf-8?B?YU5kM1RaMDdTMUc0THRFZmFhaWxBYU0vSzhyS0R6MzVqZUNHYzZHNlZ1T2lo?=
 =?utf-8?B?UDlla3FIQlBwU3RnWm4zUDE1alFXdERqSlZvSUs3TDMyUTdJMjl0VG5WbE1p?=
 =?utf-8?B?NGhBY0FBZGZvS05mTVNJNVRDOXEydlh2N2RDMzdwOGIyUEJnTlQrTmRqeHBI?=
 =?utf-8?B?S2t6bTRoREhOdFFiRjJuU1ZZZlpFUHZUcHRQMkNiU2wrU01Oa3hjZU1yNHpJ?=
 =?utf-8?Q?Wct8o06Kj8lHczkLxNEeHgtzh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625f582c-8b1a-45e4-3c4a-08dac940efd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 08:43:16.4591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +NVD3vaXKeaekVPWO1jFQVzgT4gseRrQ9B3r6/BrDYj3JTa81ndVBEfU4jRdY/hk5McXx8eNUTB1iY92xlefBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6818
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxMSwgMjAyMiA5OjU3IFBNDQo+IA0KPiBAQCAtNTk3LDcgKzU5OCw3IEBA
IHN0YXRpYyBzdHJ1Y3QgaXJxX2RvbWFpbiAqbXNpX2dldF9kZXZpY2UNCj4gIAlpZiAoIWRvbWFp
bikNCj4gIAkJcmV0dXJuIE5VTEw7DQo+IA0KPiAtCWlmIChXQVJOX09OX09OQ0UoaXJxX2RvbWFp
bl9pc19tc2lfcGFyZW50KGRvbWFpbikpKQ0KPiArCWlmIChpcnFfZG9tYWluX2lzX21zaV9wYXJl
bnQoZG9tYWluKSkNCj4gIAkJcmV0dXJuIE5VTEw7DQoNCklzIGl0IGludGVuZGVkIHRvIHJlbW92
ZSB0aGUgd2FybmluZyBoZXJlPyBJZiB5ZXMsIHdoYXQgc3BlY2lmaWMgY2hhbmdlDQppbiB0aGlz
IHBhdGNoIGxlYWRzIHRvIHRoYXQgcmVtb3ZhbD8NCg0KPiArCXhhX2Zvcl9lYWNoX3JhbmdlKHhh
LCBpZHgsIGRlc2MsIGN0cmwtPmZpcnN0ICsgYmFzZSwgY3RybC0+bGFzdCArIGJhc2UpIHsNCj4g
KwkJaWYgKCFtc2lfZGVzY19tYXRjaChkZXNjLCBNU0lfREVTQ19OT1RBU1NPQ0lBVEVEKSkNCj4g
KwkJCWNvbnRpbnVlOw0KPiArDQo+ICsJCS8qIFRoaXMgc2hvdWxkIHJldHVybiAtRUNPTkZVU0VE
Li4uICovDQo+ICsJCWlmIChXQVJOX09OX09OQ0UoYWxsb2NhdGVkID49IGN0cmwtPm5pcnFzKSkN
Cj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArDQoNCndoeSBpcyAiPT0iIGFuIGVycm9yPw0K
