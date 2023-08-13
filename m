Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ABB77A77D
	for <lists+linux-pci@lfdr.de>; Sun, 13 Aug 2023 17:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjHMPdX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Aug 2023 11:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHMPdX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Aug 2023 11:33:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545D5E0;
        Sun, 13 Aug 2023 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691940805; x=1723476805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Di3V7ufRtMsbgW8edjeQ0vMqnNma5ccA/tCzKcV3wp8=;
  b=cTHYtdx2BqjPXF0eDRqflnPobklalkaSJ2irLWqMwT/IgTZ6NrAjHhYU
   yzKO9y+JqcTVtZCTbUMcxCP8z2Ge19+4WMBdAcOtWOdvcL30Phtvnx7Qw
   UpE5J9bMkZTJTWwTHVe0q/iRYPlTLqFbje2GiEMwtw8rtmGAKOLeNexj7
   Uik3cnrGFW2eT4pvi5/edMJGwLOJxQaxQprH6jO5BgXrfMqIntWOryx9/
   ECoQfM+uFLwQZNaF0+CxnK5K7EyQaUFxcun3thGUZIGAfKHHUm71DlolO
   Gl12yvNsnRrH4107f0cl3/m8A+RksWUTzVjUHhujbza8pBIqe/TilYvYM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="375611064"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="375611064"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 08:33:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="979726120"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="979726120"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2023 08:33:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 08:33:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 08:33:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 13 Aug 2023 08:33:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 13 Aug 2023 08:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQP1DbyX0M0ZOZx/rbzqtMs1Pp1KqkzgeeyZHMOkBvVRYVcfHucbkQjOUDBggT87lecHMoPMg5YR3nuYJk5YKg8hG9wy7BOki78kfj4vpBcCHPCRnAtsh6Sk4f8CZMOmrTTwRrx4puwrqbv4rln+71JGMNmaoeENZxZ7DQNSDUofheZIl1m162W0Cs1ynTv5lUSJkg2FjyDGw6HI3rHPXwmRumyv4PIovi+DowWHVcd3+7CCvueLUWfzHQNT2mjpRGgBRfVVFPcsZXU0iB6wmsF8Ewi8GLlxmadu8uQKpHmV9wtq+72+cbUKQJEUrNAZZDr3FUHUS8zl+PoQnBXYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di3V7ufRtMsbgW8edjeQ0vMqnNma5ccA/tCzKcV3wp8=;
 b=kXyV/fpeTlyfDTfKFVY/U8MdDbzWcMVnWZAjJLOGJSf/qPxNKNacbBf7ChW6CChjEFw+VgNQj0zDOD9/q9V8mb6EEM8u7cK3VHM6cnuP7k8tp8Q3z8bdpnd/d+PqqgvCp0KHqBb5G+aSytHL/H64QKPlVuXbuZYHdVO5G3Tn/GfHf8plAp2mxXXtB0hSOsE0gc556bFvGr0B2IWHVb1V3lN54p9JCG3Kxb74v0njbrZye9IAuGKT7R5k9xY0fIICa5A506F2JohZSCo140dZOPtIgCVofHiQ72U429olxGIGQugaP/yC2OSwGsSqtmS6dAIG8g940cyHyqPxZWOe7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CH0PR11MB5380.namprd11.prod.outlook.com (2603:10b6:610:bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 15:33:22 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4%7]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 15:33:21 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "usa@junocomputers.com" <usa@junocomputers.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: firmware-iwlwifi: Wireless AC 7265 lacks D3cold support
Thread-Topic: firmware-iwlwifi: Wireless AC 7265 lacks D3cold support
Thread-Index: AQHZxgJCz45U7lBBI0ulMh7powJA8q/liY+AgALhZgA=
Date:   Sun, 13 Aug 2023 15:33:21 +0000
Message-ID: <29c5e32631abc368e7272fd193b0289ff8da0f95.camel@intel.com>
References: <658472FA-75CB-48AC-96C1-68BAA4AE597A@getmailspring.com>
         <FE32C1A0-5F23-4A21-BD55-4F152DE4D6D6@getmailspring.com>
In-Reply-To: <FE32C1A0-5F23-4A21-BD55-4F152DE4D6D6@getmailspring.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CH0PR11MB5380:EE_
x-ms-office365-filtering-correlation-id: 912101f3-0295-41c0-cb2b-08db9c12a02e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qOcU7nqCwlbtLTYT5Y+rtNsecI2JVet1VxyLUzx6FwAIhXBN7EZoTkvQWyN3VR24xmnO8T7RJw5b2cN+pWenSEqgsTotMlJ50DlR9XRhcbaM7F3YS2qCVWIL0pu1bg6zywlCXwrNbCUvpBArS/6s5qXpwF3ofjhEychopyqY+gpNOuK4aM2ZsrECYh150/gPAsxtxToC5gaoDw/U+hzCLYEQ7/oBJ6C8A8rjof6vtOXyGkaGYLy4TyUL8ivqWuc1ZSLVxHlyQ+fHvZLOdSACthOae9WgKlqrW8bHditiTuR+sYbQd/AB1bzcBQnZdk21ECwMp9to+1nDBmXWW7YR+WGNaNxxtAlGUyKZOZIbqN80xnoAeiBo3o8VCdgGVSjvclczSd0tKh7mM+GEOp+AWA9jwVH/84gkzEurFgD6a0iIIXjqLoZ8KlnYbW9F0c5RIUEqfBnmSiPjO528F68ZFxYwIN1W0p9qsFKDM6NmJ/OB0T3l2yX+SVBjWpqUcmQes+nWfmYJ+eVrV1BA6kamaZ5kzn22eJ/gQ7//uFEUe4gXrXjAwbm5Icj4oWrV3l8v7D1bPaEEmnXN2veEtomTOcKUmg1Z0IK28f4m12Rfdob5FId9wHvjWTeND/jvnFe3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(186006)(1800799006)(966005)(6512007)(6486002)(71200400001)(110136005)(54906003)(478600001)(2616005)(6506007)(26005)(2906002)(4326008)(316002)(91956017)(76116006)(5660300002)(8676002)(66556008)(66476007)(8936002)(64756008)(66946007)(66446008)(41300700001)(38070700005)(38100700002)(86362001)(40140700001)(36756003)(83380400001)(122000001)(82960400001)(66899021)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dllHUHdpeG1heTYxWEVBckRSckh2Ti9pMUl4a2c4ajF3OTFqVUsxUGsyKzFl?=
 =?utf-8?B?UUZHTFVsLzVlUittNWVoYm9Db0N3TWNRZ0JEOU50S1RHQXp3cmlLeVd0anB2?=
 =?utf-8?B?enhlYXhlMk9vaDFocElkaEFzOGZuZXF5MXY5OWJ2Rnp5b3g0UkxIUTZ6RmpD?=
 =?utf-8?B?UmRGZzhqVHBycmpjR0xhN3pYdURkemhSMGxSSjlINWdEd05janhJZnpVSkUz?=
 =?utf-8?B?UlhpYWYyeE5HOXNSV250d1h6OCs4b2IxbzRJcGdIc2xMZzByQkZmK092K0VK?=
 =?utf-8?B?ekU1Y1BGdmpORFFZdHJiYllPa0RYZGhEcWJaN094YlFNU3VyR2xmV2FlUjNE?=
 =?utf-8?B?RXJGTkhGMlpnUkQxam1mMWhVSHovbHdJLzVJOFpEc2t1VEJWRTV0UGZ6T2NN?=
 =?utf-8?B?NFNBYmZqUTJEa2dCV3liOXFJL3AyeXJSTWxXVDhJMjNBcGRlTE1UM211WUZr?=
 =?utf-8?B?alF4SWF5TWRva3kvU3drb2xXd1FWZU9sUjM2QUY2QXN0bkNZbWUxaW92Y055?=
 =?utf-8?B?SmFSNjFUMDdtbDBmSmNjQ3U1TE9teUpwb0hsWFZlSEx4bGhNNFZvY1JHaEUz?=
 =?utf-8?B?Ni81OUNqQ0hJQ1lvamVxT2FrMm9XcEl5MEZTNG55eVhJUmNTV2d4TThIZmx4?=
 =?utf-8?B?Uyt5dURTZm1OWFJzUEJMSXE3dkIxSm9RVlV2SmYzR3lrQ1MrRDdCYkd0STdB?=
 =?utf-8?B?eXdNL1JvT3RvSEhBNW9IWTU2VzR2V1FBZUpBemFUdWw5TXhXN3grOEhlWWZu?=
 =?utf-8?B?MmZZMjRub1FlczdDem5TQ3lCYkFEWTJOMkRGR2dqcVJPTWE4dU1QQUlWTWQy?=
 =?utf-8?B?bHdsMVplbnlXNXlvRzlNNVhadTdYVTlEQUZxakdFeU9zZHdxK3BLaVpNTHZ4?=
 =?utf-8?B?RFBRMzJsZ291cCtDWXhKSlB2b2pObXJzRllyN3ZJWW9iL08xLytVUVV6clBH?=
 =?utf-8?B?N3pBOUt1cTFoNGtYSXhKNlV5b255NWFxMjVpZ1ZVb24vamdOREZnUDFjQVRP?=
 =?utf-8?B?dFJDbndQendNZmdIcHlER3krTDVLTUwwMnhIdDJZWmdlL3U5OE5KWkpwN1R2?=
 =?utf-8?B?cjhCb1RrOE95ZjJ0TnYxSjdzcWg0Y21xWnBITC9ycTUxR2hhYVUzL3lnSHU5?=
 =?utf-8?B?T05rU2NaU1RvOHJvTjd1Q2JpbUpwQUtKYTlZVnRtT2VXakVGeVhqdTRLbzVU?=
 =?utf-8?B?eEFRRDdVVXFacDNIWkJkNWtzNHp2NkRCTDVTWEpDK3lwUzUzUjdmMVJFWERU?=
 =?utf-8?B?U1hCTlJSd3pNN2VMRnZ3Ulh4OTJGQVhwaURSWFJUR1BYampxNXZaaXd2aDNi?=
 =?utf-8?B?Y3JNdFpwWTJzakVxeU9BYlNKYmhVQXBrYXJMYW9pcWlDVGJ3cURhb3hDSERw?=
 =?utf-8?B?RGZxQ0FBRmhiWGRRanh1SHpramNIMVpFNGVBSWg1dWZRZlIrUnM4WHl1NXA2?=
 =?utf-8?B?cDIwVC9paGFtbytDN3loaE9nc0VOdklxVC9VMmpaSjRQTWZxT2N5RXRwUTdT?=
 =?utf-8?B?Z3A3OG5uenNmMHdkYlM1RFg4THp0cllDMWVvOTAvbkVmUzAyOUVVVzhVd3Rp?=
 =?utf-8?B?eDYvUytxRzhLWFNsOUszSTV6UW53d0ZvbTQ1bEVGWGFmT2FLYTNndXRYK1Z3?=
 =?utf-8?B?RDhWRDRmWEM1aVJudWU2TDgwbW95emRFVHhkRG02d1g2RkdBMW92WDhZRDhr?=
 =?utf-8?B?Wno1RE5OR0NhTm5LRjEzQUlMTmtxakRHelNnUGlUL0luTWlBQi9PeUorTjgz?=
 =?utf-8?B?RjAyOTVRTGVNOVQ4WUc1eGRoUnFrNjJpN2EzUUxVRTVjUUpUQ240R3NrcjQ4?=
 =?utf-8?B?VVpDVU9LdHBmYzdQd3MxSnIvSkdibUdtMHhZSnZtYmthbkJvZWtrNCtyQXU2?=
 =?utf-8?B?Y3V5M245SzVBSEJNS29nSmFTSVFZaEV5WDlUQlhCOW1xaUY1WGtFWE1iVWpP?=
 =?utf-8?B?RXE2cXpmUVY3UUVrVU1VQVpCNkNWVmJkVUlld0J1eWRwMDF3dDMzTGNWdHI5?=
 =?utf-8?B?WFp2LzFZSDQ5Q0VFZEpQaXNpS05QSWhTeGN6N0djNzNRa3ZBNnkzejBkT0xq?=
 =?utf-8?B?YlJBVVVxVlgwcEJEM1ZydzFYSXliTHlwV1UzdVBGVyticlJIemRVQVIxSUVp?=
 =?utf-8?B?UUtRK01tRGJqeFl6OVUzOFR4ODk4SktrZHpMQmNPakhvcFJPRVdsT21CSTBp?=
 =?utf-8?Q?bLBaWM1jX/HjQe/eRm6bC+U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <600B3246A8B6084EAF0CD3F4D5F8BEAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912101f3-0295-41c0-cb2b-08db9c12a02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2023 15:33:21.3792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6emNSl4todpzJ0RGF18B7Uia8qPp7EOKIhPTS0GbW5IwXg5yWfIykssIQYk7ket574MtE9scs1Hw114VGlFUYQKDV44VNSV1q3MvDZT/Xk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5380
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNCk9uIEZyaSwgMjAyMy0wOC0xMSBhdCAxNTozNCAtMDQwMCwgSnVubyBDb21wdXRlcnMg
VVNBIHdyb3RlOg0KPiBIaSwNCj4gDQo+IEFueSB1cGRhdGVzIG9uIHRoaXM/DQo+IA0KPiBHaW92
YW5uaSBDYWxpZ2FyaXMNCj4gSnVubyBDb21wdXRlcnMgVVNBDQo+IFA6ICgyMTUpIDUwOS01NDcy
DQo+IFc6IGh0dHBzOi8vanVub2NvbXB1dGVycy5jb20vdXMNCj4gDQo+IE9uIEF1ZyAzIDIwMjMs
IGF0IDg6MDEgYW0sIEp1bm8gQ29tcHV0ZXJzIFVTQSA8dXNhQGp1bm9jb21wdXRlcnMuY29tPiB3
cm90ZToNCj4gPiBEZWFyIE1haW50YWluZXIsDQo+ID4gDQo+ID4gSWYgRDNDb2xkwqBpcyBlbmFi
bGVkIGZyb20gQklPUyB0aGUgdGFibGV0IGJvb3RzIHdpdGhvdXQgV2lmaS4gVGhlIG9ubHkgdHdv
IHdheXMNCj4gPiB0byBlbmFibGUgd2lmaSBzdXBwb3J0IGlzIGVpdGhlciBieSBkaXNhYmxpbmcg
RDNDb2xkIGZyb20gQklPUyAobm90IGlkZWFsKSBvcg0KPiA+IGFkZGluZyBwY2llX3BvcnRfcG09
b2ZmIHRvIGdydWINCj4gPiANCj4gPiBbwqDCoCAxMi42ODEzMDNdIGl3bHdpZmkgMDAwMDowMTow
MC4wOiBEZXRlY3RlZCBJbnRlbChSKSBEdWFsIEJhbmQgV2lyZWxlc3MgQUMNCj4gPiA3MjY1LCBS
RVY9MHgyMTANCj4gPiANCj4gPiBUaGlzIGlzIG5lZWRlZCBmb3Igb3VyIG5ldyBKdW5vIFRhYiAy
DQo+ID4gDQo+ID4gaHR0cHM6Ly9qdW5vY29tcHV0ZXJzLmNvbS91cy9wcm9kdWN0L2p1bm8tdGFi
LTIvDQo+ID4gDQo+ID4gSSBhbHNvIGZpbGVkIHRoaXMgdW5kZXIgRGViaWFuIGJ1Zy10cmFja2Vy
Lg0KPiA+IA0KPiA+IGh0dHBzOi8vYnVncy5kZWJpYW4ub3JnL2NnaS1iaW4vYnVncmVwb3J0LmNn
aT9idWc9MTAzNjYzMw0KPiA+IFRoYW5rcywNCj4gPiANCj4gPiBHaW92YW5uaSBDYWxpZ2FyaXMN
Cj4gPiBKdW5vIENvbXB1dGVycyBVU0ENCj4gPiBQOiAoMjE1KSA1MDktNTQ3Mg0KPiA+IFc6IGh0
dHBzOi8vanVub2NvbXB1dGVycy5jb20vdXMNCj4gPiANCg0KVGhpcyBkZXZpY2UgaXMgdmVyeSBv
bGQgYW5kIGFjdHVhbGx5IGFscmVhZHkgRU9MLCBzbyBJJ2xsIG5vdCBiZSBhYmxlIHRvIGdldCBh
bnkgc3VwcG9ydA0KZm9yIHRoaXMgaW50ZXJuYWxseS4gRDMgd29ya3MgZmluZSB3aXRoIHRoaXMg
TklDIG9uIHN0YW5kYXJkLCBvZmYgdGhlIHNoZWxmIGxhcHRvcHMsDQpzbyBJJ2QgZ3Vlc3MgdGhh
dCB0aGUgcHJvYmVtIGNvdWxkIGJlIHJvb3RlZCBpbiB0aGUgdGFibGV0cycgUENJZSBoYXJkd2Fy
ZSBvciBtYXliZSB0aGUNCkJJT1MgaXRzZWxmLg0K
