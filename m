Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B02668988
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 03:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjAMCYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 21:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjAMCYq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 21:24:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC6E482B7;
        Thu, 12 Jan 2023 18:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673576684; x=1705112684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PtmRt98s0AGp5/QMyB5ynCuA1lmNyyL4GYwAqTLQgzQ=;
  b=LxMnRU9MgjChhQc+f4c16ply6Fz3NDApzUczk6XXl0aerkF+UrDGqTAy
   5fGlF0qIghmYQd5SovEyLB2KqJaVDFWTFbTowtToWMwbTnhDiLdW34jxT
   dghSA2thMkJdtHdtmO3phxYSU2m2cDZotpeFptmJeztPJ7VITXRmYG/kW
   JMs3ZpK28l0Ig4iDXVBj8oS+Dr9jmPKzpv2z5wOdRy0Kz1eF4TRpDG4+r
   IazhCzAan1msMy0V73eS37GmyL3O2W6oOKOqOOVcnDdJEjxA7w3dDIn5W
   bzE5rcg/vj0G7LpgN9ue8T+S54dN8YMgIhmnVM1vb2pJynOiEkwQ4Ihur
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="351128220"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="351128220"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 18:24:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="782012755"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="782012755"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 12 Jan 2023 18:24:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 18:24:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 18:24:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 18:24:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 18:24:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXOqwxdkHsKy205+mz04jd2v2GgnxDR5sBF/Hs3qLCPWRCdyXM3BWT7Rdt6LmfMDoAFVwpUpUKyd42dNOOtQ+Dna98+MXlIeCPmggbgNB0wEO1FZ2x+h4F8/DbFbdDO4MhBTyFvev9dDM9A5fB49+MvKirqA2BoYOQi8jfFtQY0C94QSVK/9zXSbg2FRKpPbvkEK8xGnN2tg0PrStjX7v4Y8XokO9vlzkgiYrRcCONOc8cYCcroepBzIL7p01YHFm2Zf7il9SPy3mZqEHBPMKvnGUTGc/hkPerZR9Jh2l9Lz2KpT8nEtpzzper8G9/evDoV3aeXdRHrHQh6MGNbjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtmRt98s0AGp5/QMyB5ynCuA1lmNyyL4GYwAqTLQgzQ=;
 b=NtY7Q/R7NCj8EPKnZaGpV2gKlgebT6rVeWcOVYSvD5vAcKEIRpJTlnnD1/dU+RxMTU4fho8R3xfXHr2xnR5CUdBluTgWqCpaptCJs/wIRBANeyh1CjgvnZudJ8cwYl3mrmznutuL0gyxWcpDB1LIErS0DQYUH75gFBW4TbiSK0qOoCwaxc5AJj2LDc+JM0J9NbIZei+AWzzUo8ABgO0MSwXGXK4ktrLxJdUrYrXI2OFRGw+MlgXC0oXZ0SdwQyG58J9IFO0Fm4HN6raBXw1+5qiglghyxzeIxP2IzpFeDje2WuoGF8S6o+wvzAaedecjzlFvPEL6x5uGv7wwNoJy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 02:24:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 02:24:33 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rodel, Jorg" <jroedel@suse.de>
CC:     =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Fagnani <matt.fagnani@bell.net>
Subject: RE: [PATCH v2 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Thread-Topic: [PATCH v2 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Thread-Index: AQHZJvGqu+RyQuVsw0uutCLZNXEz166bnMJA
Date:   Fri, 13 Jan 2023 02:24:33 +0000
Message-ID: <BN9PR11MB52765287D7C66D9CF52F143E8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230113014409.752405-1-baolu.lu@linux.intel.com>
In-Reply-To: <20230113014409.752405-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6754:EE_
x-ms-office365-filtering-correlation-id: c08ff951-3486-4203-019f-08daf50d4ec8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rAqVsSP/22dsyQhEEHulRMuHe7LwZeD4Gv8SGRFJYnd8xRsV6206jXYBq9Jd6h8LBcET09+bNLNO+qa4bdu7n23Lrcky4JL/nN5Bia6liWwX9VuhPVZQiZz1Zc1dgpNfkuLVimRingWpU/SdiZolNs2+h3lyL/n6HLKX8mvpbmFEiy+OViNX0up9jwfgB/VoNREgtFKNor8SfylzAJiULklVmhgjf/+gvSZD3QWRiI6lEebW87gwQ/RTsNHYEzbybiwK0Two2sFzQ4EqaL/Jo3vVMJCZNaAJZMVeZAQALGCE0vAaY6wTw3fTNiK6m8XelmQCCNJegUCn6eq4a4veArgXrceEy1R+V71Qio+vHTcH1hFH6/omfZvN4WBruz/73qVaGEw3YUyTXc8dMFzX6+xBLh4G26akGJ6mxw/KwHT7010oahsXAj5pHsc8KL+vix3h32mjE5HoDEodw1EkoQ3r/SeAx0zeGscFo0sa9FIiGE7mwazKarmOLCz0POOH68zmNS7QltT3ciGBW3rnO7P0Wlm1r5d/U9QmOWzezS9ulLswOjBYiffYv/G2JRixBvMOnlWeIu1d0rLU0y0j4fbai5JVw7PJk5jmzF9rygJWC1EjPSmfYaqJ+F8a5sWZ/M1qxP8HtEvqYHNxSg1OR50yZy+gj5tc6n3cYfd/NYIp42i9+UKic18OQEBWYxZwHUEoSWiJlI3An0gGWCzToA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(6506007)(122000001)(38100700002)(82960400001)(2906002)(86362001)(478600001)(7416002)(33656002)(186003)(8676002)(9686003)(7696005)(316002)(5660300002)(71200400001)(26005)(8936002)(83380400001)(55016003)(38070700005)(41300700001)(52536014)(66446008)(66556008)(54906003)(76116006)(4326008)(110136005)(66946007)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWpXNENXTHNaRFJnY3JrM3M3L1VyK25scmN4eDV2ZWtXWENHQ1d6a1pxem5x?=
 =?utf-8?B?Tk04Vm1WVVNGeEdYbGZJcUZ4ZFpVUjhPdk91MzFLWEtQMkFvL3FIYitxMWZF?=
 =?utf-8?B?aHpQN3lEVXhhMTdjK2dsZWFjM1cwOGJXdk5GaDFVYWgrbkpKT3M0MWs0T1N4?=
 =?utf-8?B?QmQ2TCtqUXNvQVg0Ym1Vc2ZQZTVkNjJoYzBjSkd4dFNxU2JQZmordWtja0JJ?=
 =?utf-8?B?ZHJoTjlCeGJkamI0K2hpcmMyQ3pYMFJON1hRMkg2Q1pmTm4zc216bm43UmZ3?=
 =?utf-8?B?aWFTSThPczlkUDZmMDdwUUpkZnFyemNwVFFaeVdFRWdhL1M4MXhHbjYzQW9k?=
 =?utf-8?B?N1l3UCs5LzQ2U2lNK0VsSjg1QXZvME9tL2w4aDdsMTZ6MzNBMTB1QkxYUjRj?=
 =?utf-8?B?ZU9jeG9nZDc0TW1qaFo1M2JoK3JLdjlBckhjWW1KWUNTVWtDUzQvbUVmTWlv?=
 =?utf-8?B?SVVDVG5RYmxiOEpCdWhTK0ZtMUMxNWczZGRHSDdWNUVvVW9GSndrUDRDUXFq?=
 =?utf-8?B?N2xSRldLV2tON05qT1V3UUFQT0lQZWJqRk1iVHNPNjVFY2k1aEFqODdicUV4?=
 =?utf-8?B?L216Z2x4S1YvZ0VvNlJtRllUOG8xSTUxNHRZRU1pZmdOTTZQcnFpbTlxL0FU?=
 =?utf-8?B?ZHZuQnAxeXBES0gzTkxsMmJxd1BjNXZ4VEFPVGV2QzBJUG1KWG1zR1ZwVnYv?=
 =?utf-8?B?UE5tSGhTTTR4YzJDRldya1lsOHk2Umh5aWlsdURyM0IwZmtHalhOdWduWjZ4?=
 =?utf-8?B?Qm1ZSGI5U2ZUMk96YzRTdUwzQzFFMkZqY2lIbUJ0ZEFQSTNuTjhFSVpJU0RG?=
 =?utf-8?B?WmVIcExQaXU0TlZ4aFZhZ1AwVHREQ290L1J3T3BzY1c1VFZTMlVzRHBWbnNW?=
 =?utf-8?B?a08yQ2QzUnBidi9kaXN3Q21HS3orU1VrSVZ3RHk1cThrVUZlR3VQcUlyMndK?=
 =?utf-8?B?N09HL2hESndPanM1VEJla2hFV04vbUVEYndkSmpXWFlGc1A2NjJieUtLNUQw?=
 =?utf-8?B?V1c4Und3TmpVOE80a3AzazJLamF3QkpHYkpWSGNPVXBSSGU3TGg1YmZhTkRv?=
 =?utf-8?B?U203d2xybTB1NFNrODY0ak8zVVE3Mzlad1pCdVZIc2hpemg2UzRvYnFVQXl4?=
 =?utf-8?B?MU0zd05yZjRqZVl5aTFiVXhmczNtQ2s3bGt1RFVLY01GK3JJcUc4b3J3QnNX?=
 =?utf-8?B?bVdQZVUyTGxzckVZSUtJd2hvVnRsL2dOdVFsbS9sRG5ndU9oSlpZa0drUEFZ?=
 =?utf-8?B?RVl0QitLZjJ1OGpCZTg1dkJDWGIvS3VJYi80RjlPS0VqTk5jVVdZZTVZaW9l?=
 =?utf-8?B?LzVMOUxEZWJXNnZLQm1XZEVISnk3OUdQL3hjMHUyN1IwZVJZcmRhQ0Y0ejBE?=
 =?utf-8?B?Q3hVSUQ1KzVrcXJtN3VtQTA1ZmhZUTYxS1NtV29zdndFRXgxR1pJc091RzNG?=
 =?utf-8?B?VkxQdEd2NGwxc0hsYkZIZ3NUcDhzaWNaSllPK2VicWJ0S2VOT3RTVnNUT1d0?=
 =?utf-8?B?WkdIM0w3L3BMa3IrUXF6OWlQK0Era1Z5Y2pycGxlU0VqVFlyVm9wWmpRUXZV?=
 =?utf-8?B?K29Sd0lsOVhKUHU0Q2pWakN3aEFab3VRbjh3SDYyNTE1dzJSaFAxUHI4VGJG?=
 =?utf-8?B?S214TzNrR2I5VWVxMG15dEYwU1BBUkJaemtWS1d5b1ZjRHlpSW9qdEU4dmVI?=
 =?utf-8?B?T0Uxd3Z3azNvbE1SdnZVSW40ZlBQbmsrdnpHRTFyMTJIdEROZThJS080clk4?=
 =?utf-8?B?N3JnTHAyVDMzRUpwVWJXcjVtRG9POUVBbElLOHZQbVpmQmxPWWpqOHRpcHVL?=
 =?utf-8?B?Sk5hNmFxd1pGUkhsdzNoRm12aVJNZFZoVmtRa2twYVNSSmQvZkZsSDVISnVz?=
 =?utf-8?B?MldaMzJoYUZQZzQrWWNBcVp2WHR3SW04RWNjTEdyc0V4V0dkZWg3MW9DWTFS?=
 =?utf-8?B?SUFXdEhWSUN6TlVJZTBLWkpSSkNFeWFCUEtPd2JUNXQ5RzlHZmJ3MXZiTndV?=
 =?utf-8?B?Q2VwNlhSbDd3QXFoR2xLTDBhRVJZWWJKWVl6TUF5UUVtSFowODlPWjFhQnJx?=
 =?utf-8?B?MXZ1blM3TXo2QmxLcmJXVGdhUU9PdVJ6a1d1Wm1neWhyQXpKemR6WUJlVVE2?=
 =?utf-8?Q?YNjXNMaBVO7aKnJbeTCFjYSKR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08ff951-3486-4203-019f-08daf50d4ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 02:24:33.0832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0+8gwe6I8SMXLQavuB7N5ENmr36Zu8TBXRW6nYaUQ6FYKiAvrX7sfwaLMTMlkQHTAU4LCTsChrMcTwdOr0WCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEphbnVhcnkgMTMsIDIwMjMgOTo0NCBBTQ0KPiANCj4gT25lIGFsdGVybmF0aXZlIGlzIEFU
UyB3aGljaCBsZXRzIHRoZSBkZXZpY2UgcmVzb2x2ZSB0aGUgUEFTSUQrYWRkciBwYWlyDQo+IGJl
Zm9yZSBhIG1lbW9yeSByZXF1ZXN0IGlzIG1hZGUgaW50byBhIHJvdXRlYWJsZSBUTEIgYWRkcmVz
cyB0aHJvdWdoIHRoZQ0KPiBUQS4gVGhvc2UgcmVzb2x2ZWQgYWRkcmVzc2VzIGFyZSB0aGVuIGNh
Y2hlZCBvbiB0aGUgZGV2aWNlIGluc3RlYWQgb2YNCj4gaW4gdGhlIElPTU1VIFRMQiBhbmQgdGhl
IGRldmljZSBhbHdheXMgc2V0cyB0aGUgdHJhbnNsYXRlZCBiaXQgZm9yIFBBU0lELg0KPiBPbmUg
ZXhhbXBsZSBvZiB0aG9zZSBkZXZpY2VzIGFyZSBBTUQgZ3JhcGhpYyBkZXZpY2VzIHRoYXQgYWx3
YXlzIGhhdmUgQUNTDQo+IG9yIEFUUyBlbmFibGVkIHRvZ2V0aGVyIHdpdGggUEFTSUQuDQoNCnRo
aXMgc2hvdWxkIGJlIG1hZGUgY2xlYXIgdGhhdCBBVFMgYWxvbmUgZG9lc24ndCBpbXBseSB0aGF0
IHRyYW5zbGF0ZWQNCmJpdCBpcyBhbHdheXMgc2V0LiBJdCdzIGp1c3QgYW4gb3B0aW1pemF0aW9u
IHNvIHRoZSBkZXZpY2UgbWF5IGNhY2hlDQp0cmFuc2xhdGlvbiBmb3Igc2VsZWN0aXZlIHJlcXVl
c3RzLiBPbmx5IGNvbWJpbmluZyB3aXRoIFBSSSB0bw0Kc3VwcG9ydCBTVkEgaGFzIHN1Y2ggaW1w
bGljYXRpb24uDQoNCj4gKyAqIEBmbGFnczogZGV2aWNlLXNwZWNpZmljIGZsYWdzDQo+ICsgKiAg
IC0gUENJX1BBU0lEX1hMQVRFRF9SRVFfT05MWTogVGhlIFBDSSBkZXZpY2Ugb25seSBpc3N1ZXMg
UEFTSUQNCj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtZW1vcnkgcmVxdWVz
dHMgb2YgdHJhbnNsYXRlZCB0eXBlLg0KDQp0aGlzIHJlYWRzIGxpa2UgdGhlIGRldmljZSBldmVu
IGRvZXNuJ3QgaXNzdWUgbm9uLVBBU0lEIHJlcXVlc3RzLg0KDQpJdCBpcyBjbGVhcmVyIHRvIGJl
ICJUaGUgUENJIGRldmljZSBhbHdheXMgdXNlIHRyYW5zbGF0ZWQgdHlwZSBmb3IgYWxsDQpQQVNJ
RCBtZW1vcnkgcmVxdWVzdHMiLg0KDQpPdGhlcndpc2UgbG9va3MgZ29vZCB0byBtZToNCg0KUmV2
aWV3ZWQtYnk6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0K
