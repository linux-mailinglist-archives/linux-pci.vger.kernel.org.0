Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0536370A9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 03:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKXCzE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 21:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKXCzD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 21:55:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE78C8C94;
        Wed, 23 Nov 2022 18:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669258502; x=1700794502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z5qfoA6hc7564ebRfteznH8K7Rj7s/1lWlFraANPhn8=;
  b=jFtWP8TJZc5YHp8w30b6N5DZX97kAM4xbl2vWDAO/3A/Quw3zBj7+Dfo
   zOihynO8noxXYmGZECK30P9pd0hxH0QHS7hqArjDDZQCvVA10Wvh53Ejf
   AE0bxIBJutG0NzSbr20kchi26cCmFuvrV/IJy2vPAVKO+XE5iFDwk/KPC
   d3h3jYsI/0T8rr1JDlzFHgqKZL8yjnHSnV9IGbZr+jD/5NSeuGKsys/iC
   Um4SygmcqHqGYHXzjgfbjfRNIn+cW46hq6B8eff3hYHWVJgqGn5da+YLo
   bVO5hYcz0zS7HbNc6LQozqiIcHCCPo/xxBbqN8J7CBcrR2xOu9YijvK1l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="378462042"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="378462042"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 18:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="766933448"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="766933448"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2022 18:55:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 23 Nov 2022 18:55:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 18:54:59 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 18:54:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 18:54:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckL/hy+UrdBcztG4bzKl+kDvYEpuXql2jofzDPN69x1BaUn1cNupmYfqOgsDf4fKU5QlEPK9AOQrgUnM+e4IT1O1ZtVwqk+xyTMmQU0uLbU7Y4TQIfE1peVj77h19B4CCu+NfaQ6ZKtOC2T/+Uc3LxoKWa0LOAp4RJiDNopoFHP3mcjEmgjbrDdD8T8k0NRxmPrBBZVEBUgEGZnu1+qdnrAVFst8ZxYf3nxt3dc96mxTG8mBtPtwFV9E8100kN6Vrlu1gQqQ5Xu+b/Gota4quWLkLhrtkETHP4qYSUq48WpRfLGhcw7NvcwTTTTWLdd0LPeWBGRFFzTASrknXG5vow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5qfoA6hc7564ebRfteznH8K7Rj7s/1lWlFraANPhn8=;
 b=MLaiyoWU9oQh95uEp0RhBFUfgNwX2j9/8E3QFps2IBXmCp0YmAxUwaIaJVTzDuG8XWJF/J0J7jUXCpX7iSJ6VUr8Ax93NiM+QZAi+rqLmKQtgt6bIAlOxyhJVo4MwKOZdBCtyxUNX+fDSiyVhwWSofR62oFkQmumsv9iNjoO3njwkA8844iBOEZo2gDW9zYA5oNmeHzttupnyB2GBN/exKqLxskYJ/RItGsxYqPEAx0s7DkSGONkNN4E0E8iJbIZ+bNlZodOSN/+DuDAYIOCucMl0LkqMQXQ5ICVykvHbhjRkmlymHksX08+f4jSuQOKNrAoVPujQ0jCvwjcvR2Fmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7051.namprd11.prod.outlook.com (2603:10b6:510:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 02:54:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 02:54:57 +0000
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
        Allen Hubbe <allenbh@gmail.com>
Subject: RE: [patch V2 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
Thread-Topic: [patch V2 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
Thread-Index: AQHY/bbnx9tNlaP12EatQzHOylQ+GK5ML7LA
Date:   Thu, 24 Nov 2022 02:54:57 +0000
Message-ID: <BN9PR11MB52760110F539C1616C2ED8CD8C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.660407141@linutronix.de>
In-Reply-To: <20221121091327.660407141@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7051:EE_
x-ms-office365-filtering-correlation-id: 253ae943-c980-4e36-d640-08dacdc745a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5R+UR2ZreI3hZsak5vg8aG02EDGj1ov21I9Y4vmBmttrfDq0m3aan59eJdEx0pm9ot0j5//Rb0PrVC5277d1bML/e1eEmwrfVz/zcLiVZjIUkirqA8RTuVY6JbOi8F4ySlmeDq3vmTLzuApqX9N4ZEtQn84bGukNJAv/3zduRHnsWG+TKLyrcPsCvzhRsFED91SXalEewpSdgxZEKD1DBnlhtl8oH39AxZvA6jNtwZ9n5ZkOplFHX75yTbN+uB1rlNlSNEYhe6QZ6rll71J936JqWHHxXgUwLlsWzPFeTXSPEf80TKHHN1WsSGWwFR64UAt6GkYqv9hvlBKUJGOQextMkfQA0zqcQZ92RdLcL5KPuJvcw8LZdozyr4z13bvTjAV75Y79B8zU41WrJpdwSQzWctc6Dx3oeXLdgKmXICS7GNLPwUeShRT2FUg4MDIO9MChhZm/EY3oZJn1pAVhNE4HvFvnKFNref7GbznjxW++XToVOD/8fBuSjkiH32Ua3kdI6D0WMEbZYi6L4/xeDBTU3TzlySISOKQz8cfQuRA9YC4LtNot5IP1HwMtkGITIZWnKJN8eSn4uH+zpamNneG/NW3zFCBOr+4+a1T9BzYy+gH1MFqrv5J2RGlCzIgpQtREwi5vUaMp8fshyy0i7De77hmozHm2B56CiRaE8oFqb0OqVG4cWVgY1VKCnQWR7C0bzZpmEn8Ozn2q5FYI0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199015)(5660300002)(64756008)(8676002)(66556008)(4326008)(55016003)(76116006)(4744005)(8936002)(7416002)(66476007)(41300700001)(52536014)(86362001)(82960400001)(2906002)(66446008)(33656002)(66946007)(122000001)(478600001)(186003)(7696005)(38100700002)(316002)(54906003)(9686003)(110136005)(71200400001)(38070700005)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTl0Z3NSK0xodC93NTNpUGlFUEdUY2N6SElLdGRxd0dPQUlzU3pRenFSNk44?=
 =?utf-8?B?WkEreW5VQi9qM3h1UE9uSVlLSlU5Y3NlSTNjZjg2MUgrZFJqdEFmeTQvUHpP?=
 =?utf-8?B?NEYwMlZaczdLOXpOcTRJTklRUUV5eGoxWU1MVEJIMCt6T3dFMUFRVU42bkpt?=
 =?utf-8?B?NXNlZmtEZERXY0dMQ1VlQ2xqa2VPUjZNU0sxKzY0Zi9nYXJqYXN2MXVpdkxW?=
 =?utf-8?B?K0kzRUh3SGtCQ2VWcW8xUDdRTVJPdHE0eFZWcnlxWUxObGlqUGN3Q2lqK3R1?=
 =?utf-8?B?dTZXbkNPQnQxMnpWNjVrTTErQjNrVXN3WURLQkY4WnNRQ0d1YU1yd3h4UlFr?=
 =?utf-8?B?NXhIUEhIeis0aXZXazQwR0YyWmNwR3Y2YjN6RE1qZURKS0twb1ozUjhUNzRG?=
 =?utf-8?B?ZWthTzY5Zk9jZ1hpZEJHT2Jid2VuQVVFMmZ2MXZsQTcyb3dHNytDL1pIQU1O?=
 =?utf-8?B?Z2FiMUlOWU11eFpzRUNzOVF5OGoyOUduUmI0YzNoN3dEeHV3bHh2OU9tNGNW?=
 =?utf-8?B?SlFpWVlFN1EwZGpDeUdvVzFGRUdrbnZJQjhjZ1RIbHMyNzJiNEVlUmhmb0Nt?=
 =?utf-8?B?WGlHbTZER3pKaDh5UFl5RElncS9oTXkzdDcyRGlqN0NtNHAyQktveTIwdWh4?=
 =?utf-8?B?ei9OaWF5QkovRjhHSC9OUmE5emhtTk5PYVZzM2lBQzJwa0VSblg5Q3ltNVM2?=
 =?utf-8?B?ZFhNK0NicFlnZGRQZmJPWFlwYWsvVDFDdklmNVlkMm5JMHM5SGJNN3NybnFq?=
 =?utf-8?B?Vm5vMUpLNUJTVmF2YnY1azVuQ0swWnNvQ1hMOGxOSHhDMmdydHhad2ZZSEJQ?=
 =?utf-8?B?QXZyMk83NitLMFdKRjkrWFZtYS84WCtmZld3dFhueU5xRHUxalZkNHZicWd6?=
 =?utf-8?B?Zzg1SXA4cGwwRFluWlZKNE5YZVlYcGdTYS8waVVnZFIySlROU2hHdk43VVQ5?=
 =?utf-8?B?b3pEWFZhRUlSTEV5dU1CSGVBcnlPcVh5bUR2MVV1NnhpQ2VGVU9Kd3NzR0dF?=
 =?utf-8?B?OWo4dThNSE51a3d6azBWSDIyR3cxRlhFbE9PNjZ2WnpIRzEzRGg5NG9mL0lN?=
 =?utf-8?B?S2paekZ4ckVkT2wxOUYwalNhaEd4cVo3OUMrbzdibVdLTmY4Lzk3bmFneEdG?=
 =?utf-8?B?K2haUGtwZU4rRzlmRTF1a3FycW5XbU5KOWFPUkZSNy8yWmpwMDVqQ3V5R0V0?=
 =?utf-8?B?dHlzejFmYnVreml3eDhmcEZodStqTkFOdDdTM3VaQTdWVjhxblpSckNwK09E?=
 =?utf-8?B?MXgvQmRLNXF0R1U2YllyemcxRFV1WUhyK3oyOXNYM2wxcCtDMGkxT2dxbWxs?=
 =?utf-8?B?cnEwSUg1YUUwQ1pIaHBHR203SE1FNnA0emYrV1Jqb3E2Tk5XbDRicUZWNkl5?=
 =?utf-8?B?U0lnQ3FHSHBLb1Q3SU5meFZlQWpYdjNqNWVpSEJodDB2YXBjaEdpNHpxK2VY?=
 =?utf-8?B?dWgxR1JIZXUvR28xWEFxenpqTksrQ0VaczZZT0JBNmRoRktoenRseFZpUDcv?=
 =?utf-8?B?cVBrUzhpRE9vZXNhZUhuZzhkcGxSL3BwWTJCRWJFN0Z4Mm5VRVJpM3EzNTRx?=
 =?utf-8?B?R09INFEvbmU0UDJBSkNwcE1GZ1pnd2prcDlFeDRqWmplRnU5U0tzNk5McFdq?=
 =?utf-8?B?N0orQVduWXZRc1JhaUkvMkRDRmRUb1hqd21ucVQvUXlUNm9mKzhmRkZvK1pq?=
 =?utf-8?B?LzRNZkR0bVVzeHpKa3lZbXlvU1JjOUVXMkVFRXg4eU5aanplZVREazRlbS9K?=
 =?utf-8?B?RjQ3NktPMDBEd1EyQWgvZjFjN0ZDYXp5Q2xGRHRBei91N0UxTkQwQUs0Tmt1?=
 =?utf-8?B?czQvem9FazkyNGlwaHhzUVpkZnZuZW04Rlo4WjZqVnU4NCtVQlZDUmtTSEZn?=
 =?utf-8?B?bm1RZDd2RzVubkdRNDVzY2RGdXRzU1llSGlhRmhXbDlnZWtlb0pIVDNxMjVZ?=
 =?utf-8?B?dnkvZjEyWm1qbnliT0Y2NGxEb20zSjFHWEV0VmphWUxPNUpnemtIKzJFY0JY?=
 =?utf-8?B?by9BSXp2bFZCYm84ODBQaTJxckRueGlpK01OSFQ3STd0c2RaMDZoSXhQS0hZ?=
 =?utf-8?B?NHhiWUVIa1E0Q0g0WU9YaTY1SWRsVWVMSGV2U1dHa3I0VkhCWXdzUXN6WUZS?=
 =?utf-8?Q?CDOUoc7ASKeSKep6y7iFjtd/W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253ae943-c980-4e36-d640-08dacdc745a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 02:54:57.6847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3353Bci5zRvjEJRlSMi5nmg3CyTVKoJXZoXGe1TruPcd06LpdGSqDUtLgbKbdnoeTQGU3XF3Hltfh/GXyiemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7051
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogTW9u
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gRm9yIHN1cHBvcnRpbmcgcG9z
dCBNU0ktWCBlbmFibGUgYWxsb2NhdGlvbnMgYW5kIGZvciB0aGUgdXBjb21pbmcgUENJL0lNUw0K
PiBzdXBwb3J0IGEgc2VwZXJhdGUgaW50ZXJmYWNlIGlzIHJlcXVpcmVkIHdoaWNoIGFsbG93cyBu
b3Qgb25seSB0aGUNCg0Kcy9zZXBlcmF0ZS9zZXBhcmF0ZS8NCg0KPiANCj4gVGhlIGZ1bmN0aW9u
IGFsc28gdGFrZXMgYW4gb3B0aW9uYWwgQGNvb2tpZSBhcmd1bWVudCB3aGljaCBpcyBvZiB0eXBl
IHVuaW9uDQo+IG1zaV9kZXZfY29va2llLiBUaGlzIGNvb2tpZSBpcyBub3QgdXNlZCBieSB0aGUg
Y29yZSBjb2RlIGFuZCBpcyBzdG9yZWQgaW4NCg0Kbm8gbXNpX2Rldl9jb29raWUuDQoNCj4gDQo+
ICsvKg0KPiArICogQ29uc3RhbnQgdG8gYmUgdXNlZCBmb3IgZHluYW1pYyBhbGxvY2F0aW9ucyB3
aGVuIHRoZSBhbGxvY2F0aW9uDQo+ICsgKiBpcyBhbnkgZnJlZSBNU0kgaW5kZXggKGVudHJ5IGlu
IHRoZSBNU0ktWCB0YWJsZSBvciBhIHNvZnR3YXJlDQo+ICsgKiBtYW5hZ2VkIGluZGV4Lg0KDQpt
aXNzIGEgcGFyZW50aGVzaXMgaW4gdGhlIGVuZC4NCg0KPiArICoNCj4gKyAqIFRoaXMgcmVxdWly
ZXMgYSBNU0kgaW50ZXJydXB0IGRvbWFpbiB3aGljaCBsZXRzIHRoZSBjb3JlIGNvZGUgbWFuYWdl
DQo+IHRoZQ0KPiArICogTVNJIGRlc2NyaXB0b3JzLg0KPiArICoNCj4gKyAqIFJldHVybjogc3Ry
dWN0IG1zaV9tYXANCj4gKyAqDQo+ICsgKglPbiBzdWNjZXNzIG1zaV9tYXA6OmluZGV4IGNvbnRh
aW5zIHRoZSBhbGxvY2F0ZWQgaW5kZXggbnVtYmVyIGFuZA0KPiArICoJbXNpX21hcDo6dmlycSB0
aGUgY29ycmVzcG9uZGluZyBMaW51eCBpbnRlcnJ1cHQgbnVtYmVyDQoNCm1zaV9tYXA6OnZpcnEg
J2NvbnRhaW5zJyB0aGUuLi4NCg0K
