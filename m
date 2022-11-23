Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE316351AF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 08:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbiKWH6K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 02:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbiKWH55 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 02:57:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA039D;
        Tue, 22 Nov 2022 23:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669190272; x=1700726272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EZOmedniSaaJ2q4bRRGlVU+5sQKpJvclHrzqVlCtEX4=;
  b=VuyMYtwmSW+LUDDixKa4IqmkYbxEjAGS4SBb55/WIS0cb5zucadeJ3DX
   8XS4YYp4rWgpH5wKcOJmxLg2tiKW1+wueQDr/3dWxQvfneGW2Mx6bA7Xa
   OLk+L6qNkW6xludskhU57k5+GkNEiPFUNKDGt3LIofjTWrht/SW0E6McF
   C0u2PtMcrIN+DFqmoNk4gL3s+6C+I8JHfnKMc40nU9S0VMgoURy+tx/Kp
   tp4uoh02zfItITp9TX3wv3sr6ctBAiaRD6F44ZvuZ7MmsS1OO9udwDDSI
   bpznbFDr/iuRwSBq7geLxayURIbsEJW8bkx5ULW9wuNvNmjAN6QnWsf+h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="378264255"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="378264255"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 23:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="674631683"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="674631683"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2022 23:57:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 23:57:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 23:57:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 23:57:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 23:57:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xzlu1ZapdocStrz4yOYjHbxprWiDEwcF/6FXGLsB1rK5bUftmngDPB39IePpD3fLtBwhC4ybYAcI14JPpx2yRAWi/Rw3S/WKPk4jdRVFMCBRaLo0Gh503NpoS4Z3usBePBA99YyP176Np3x8TRs2ia2syIAfDJXJTpeYGE1V4k/ukTktCqFI/v6T5dSxbi9lzgKMO5xF41B47+kM1sO1AYalpLOAGcggEl4jSwTNddLZYjmllXCOJwz1XBsnGiEOeqxTexUErfYI4yEbXj+byMsgpjFV9SNmPXBfoxa2wSQUP9tdA1RsZhpiJH2eS/ZQuBExtjrwxnsAO3XXdeEPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZOmedniSaaJ2q4bRRGlVU+5sQKpJvclHrzqVlCtEX4=;
 b=NaZ3AnDzhNYVfYJ184m6LsZqZJmJucdw6+iniLv0ShzlkjOSWAxQt4HENE0BmNOiKnO0M0OgdvcfSyvsbW0PDlVTBtJ6f1/g4DKYCgGaGNI+kgcafbDBBgLDvsyM0o7twVr1INpAomY84Egdn/sozEPaav/rLoUVsLn4beGIwMwytYIJHN7YON+ub/1y6vnmmzY90qoOejFffgeWhhM4JNnCv7bQ1eEzuCzGNdnLH/1GVMP/2atEdxsP68kPt+tPdAxvjSrDCPh+kkBDTAVHqKdK3w9ecYaffiUcZaF5Ij/EUN73OwLvwLdBVhfMi/Nef6ChgMDc0efebXqNrMPhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4963.namprd11.prod.outlook.com (2603:10b6:303:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 07:57:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 07:57:49 +0000
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
Subject: RE: [patch V2 03/33] genirq/msi: Provide data structs for per device
 domains
Thread-Topic: [patch V2 03/33] genirq/msi: Provide data structs for per device
 domains
Thread-Index: AQHY/bbbYt/MW3FFXkmu2kAe6qH0XK5MC4uQ
Date:   Wed, 23 Nov 2022 07:57:49 +0000
Message-ID: <BN9PR11MB527698373FD71F975F3C5D7F8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091326.659141858@linutronix.de>
In-Reply-To: <20221121091326.659141858@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4963:EE_
x-ms-office365-filtering-correlation-id: 64347384-ac35-400b-5e8e-08dacd286a93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iXi3Pu27KKqHfql1xwS9b4ZrK0OeRWnVpNl8retYl2gpUi9UwXFdq3yrBvrQL42vWKS6h/GTu/XqDqxTUDfbGYaP88GIoZBUqjngYJujBlCB2XEjWdmWZXZLVhpypeeHbogodWmQJb3GCe7Md4dkODxDNZQrxPOA5Hi8IlIKVTb/VnPBIgfi9Ug55rKcAd1e+U9u8eZwmXPaI5siigFID0JM5ouyJyFCx6oq1cZQgcvE6uP1vkI7BamGyHp/TSCRErGg5wHfnH7wvQz5Jm0hYLmMdd/f5EMvfgQ1ql3vtDOnoFUhQCziYKOOB5Y8bnK+pUgHnJGD0e8S6AgnmpvjEwbyZoK7h/FaMhgIWlw/jp9IjM4cUdhcGwai911K2k8KzBAR0DH0bYgfF18n3uUTaFrX86Ne7DK6b5e3UGWrd464drZT5dmTLluJfHSjmjd1eme136weioOc03tl7L4xPGITM6CFRWuONpZju+a69TjxtE/ABAbBDX+vbyLMiwUj3BdkCjhdk6n4v9IdIkmtlV3YPuLdcGDNJLgD/YyJkehvAPhDVPWMyHetboSawgapRxEDzXdx60M0CWXYVFBrMceswEm8hCNlnwK4WsoYm04gz1t5ONv6hivZJDq/UeEmSQIhYE7ttCqqfuGcOOmStM9rjVPYBS9VRzoLLJyyrAC05alaAJW1yJYbtUbgSgfBedhKF4J74EjyIhUy1Xhn9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(52536014)(54906003)(110136005)(7416002)(38070700005)(316002)(5660300002)(8936002)(186003)(76116006)(64756008)(86362001)(66446008)(66476007)(66556008)(8676002)(66946007)(478600001)(4326008)(71200400001)(9686003)(26005)(7696005)(6506007)(82960400001)(41300700001)(38100700002)(55016003)(122000001)(2906002)(4744005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTF2Tm5lYlJWQWxvNFVTdmdOZzZaaytZbzFCN3MzNzBIWUZxY0xUbmFURXdr?=
 =?utf-8?B?K3poMlJvQVBsdlcvdFBrNlp1ZUhBSldQek5rN2R2T1JaOEN1V0hBcjdlaFpE?=
 =?utf-8?B?YXpaVzFmSWJEcitkaVF0cEh2c2Z6K2UxOE1hbUwyV2hQQThkTytjbTlsZkNZ?=
 =?utf-8?B?Z3owV1ZjSmZ5QVJ2c05HWGV1dFlRWHBNTjhVTWw5YnpvQXo1RW82UC96Nnpk?=
 =?utf-8?B?TmV4ekR4cDVLbFdiRmlnbFlGQ2tmUm16QjdCT3NCaW5Sc1ZpdVBPRG1OWWZ2?=
 =?utf-8?B?T1c1aDExQjRRRnp4R1hhR2loNUJWMDNscmVWbjFDRW00djhPdnpaRm9PRW5N?=
 =?utf-8?B?SnJpdEdVeUpuRWVwMU84ZEFTN2d3c215c0p3eVVYbUM5TWg5N2djaEtGb0dF?=
 =?utf-8?B?NU10b0srWFcwWXd1dDdLN3E3NE8xemFIaW0wUXRCWTVQYmNGRDJHMkxTZXM1?=
 =?utf-8?B?YTQ5a0FGaGpLd1NLV1pIOFF3aVFKQUpGU000MnMwRlNUSlloa2ZCaG9vcU5D?=
 =?utf-8?B?blV6bytjL2cyZzVFTTRQeExxZ1hZUHZiLzlaRVhvTkw3UUtsYzRNQ0tMdk9J?=
 =?utf-8?B?dlpNeUZOaGg4TUpwOGRzN3NOOTZKYWswTkZHRzBIN3dya1g4aUp0eUVOWStW?=
 =?utf-8?B?UFQ5SEdCSi9HUDUzeW9zLzkxaWNUYWpvVlFNMkhZYWI0RjJTRmFGMStRZkxW?=
 =?utf-8?B?WlVUTWRnRy9zWjBrQ1doc0tXd005T1dMYjNhZHU5NkkwblMzbG5teHJZR2J4?=
 =?utf-8?B?SytjREVZZGw2Zy9lUzJkalRqMHpFd3lrS1kwNndJUXRBa3dHdmhpd3RRaWRh?=
 =?utf-8?B?T2s1SHRBOWkxdG5UWmRxUWNmcUNmZHFWV1RZeXJha0toVEhoUGlUa3FJL2Rt?=
 =?utf-8?B?STYrVG12aGQ5eVR4L1BoVmhqZXBPQ085aUN0dkNXYjhuV3BySzYwVlg3b2o5?=
 =?utf-8?B?TytvQVVVamhuK3ppSGZ3L3pIcjQ0ODc4KzNCMjFoZWgySXJGNDJBWURoQzMx?=
 =?utf-8?B?YmViNjkyWUtYQUwyWHhuamV3M2c3VUp6bU1Mc05XeE5RN1F2eDhQWkZEak5o?=
 =?utf-8?B?Rll1eGpnREZoYkpKcTE4ak9FVlNDNXJRVFJjTndodU5yTEFTdkRJaGdHQ3Fm?=
 =?utf-8?B?OUowYldia2U3RmZ4UzVTVGQrcitxb28vcy9JcXZTQnN5N2c4aks5ay92MmFm?=
 =?utf-8?B?RkRxL2hJN3RpRUFWL01jRC83TEtnWXNOY3pwSEwrN2F0ZlpyNDJuRUxOblJV?=
 =?utf-8?B?MUFQeXE1dHpIRjU3QnNQSjNObnM0TjBoSFNiMGpwbmtZMG9PMWFRaDdQc2d2?=
 =?utf-8?B?aFdCbHlLaHhUM2YxKzNNM0xVQWlneEdCMXBFdlpHbnA1MnNObkMvRWRxSUQz?=
 =?utf-8?B?WjE1dHo2U2FkV1VzZ216cVVYMzJBWTVzSGwreWRFT0dhZ0hnZFVVdE4zdGUy?=
 =?utf-8?B?d3ZKYW1mNDcxb0xBSTNhdElQamtjLzdKY2gwSnBINEpxMWwyNG55anB1NXA0?=
 =?utf-8?B?ZTZDSFlDbUhvdC9Jd2RidG12bDBKbllhaG80eC9pNXBlQThIMWp0TzJZVXcr?=
 =?utf-8?B?dXBMYm45dURpYkc3dW1lWHdGczdIUmJVSUFlSEphbVRabkhmUmtMZnh2U1pi?=
 =?utf-8?B?dVU3WUViZ0xSSjRPMmRhenBSQVQ5RUpkSFltSmR2YjFFZmNWRnpVVDc1RGdC?=
 =?utf-8?B?WkhoaEhJVE5NN1dnTzVUb1VZQkM2bTZnVGRRWDJhS1FEVno5WjNXYVN4VnV2?=
 =?utf-8?B?K3VwTFcvZGNTSHk2a3ZYTXUxcEV4TTR3ZE5rK2JpRWFuQ1FZUmFIS3pUeVFQ?=
 =?utf-8?B?NHVkOVFUSjhjSXdNNFFEMG1VbFVVV0EydnJ6Y3hjV0tzS1ZTd01uNEZMQzh3?=
 =?utf-8?B?ZTAxVmFQMXZnQ1dJM3pEV1pxSFFOR2duUzVRcGN0WURJTXY4cXVxek5qUVdX?=
 =?utf-8?B?QUlTMmJGVVQvWURsWnNJYWdwVDVkMkFGcnY2a05zNkN5R1BFV2ZSL2FFV3Vx?=
 =?utf-8?B?d1ZBbFBaYmJUUUN0ZE81NFU4VEJBeHdPRFZPWC9tVUxiTXBpTVk3SUVGZHY5?=
 =?utf-8?B?aml3VHlWd1hsWjR2S2FxWDR5MktCek14TEY0aWFCSlkvdkxCSjc1d0RORmxv?=
 =?utf-8?Q?JI6Wdqf7b3ER3m6LKGosA+U0s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64347384-ac35-400b-5e8e-08dacd286a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 07:57:49.6150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCiWG04dBwotbrv3gN0XbWHrBslwUN6CyABlUcnEpCj9k3/WvuyaQfYGGvP61aNylSOTmTcAdNrQLiPH19ernA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
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
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gUHJvdmlkZSBzdHJ1Y3QgbXNp
X2RvbWFpbl90ZW1wbGF0ZSB3aGljaCBjb250YWlucyBhIGJ1bmRsZSBvZiBzdHJ1Y3QNCj4gaXJx
X2NoaXAsIHN0cnVjdCBtc2lfZG9tYWluX29wcyBhbmQgc3RydWN0IG1zaV9kb21haW5faW5mbyBh
bmQgYSBuYW1lDQo+IGZpZWxkLg0KPiANCj4gVGhpcyB0ZW1wbGF0ZSBpcyB1c2VkIGJ5IE1TSSBk
ZXZpY2UgZG9tYWluIGltcGxlbWVudGF0aW9ucyB0byBwcm92aWRlIHRoZQ0KPiBkb21haW4gc3Bl
Y2lmaWMgZnVuY3Rpb25hbGl0eSwgZmVhdHVyZSBiaXRzIGV0Yy4NCj4gDQo+IFdoZW4gYSBNU0kg
ZG9tYWluIGlzIGNyZWF0ZWQgdGhlIHRlbXBsYXRlIGlzIGR1cGxpY2F0ZWQgaW4gdGhlIGNvcmUg
Y29kZQ0KPiBzbyB0aGF0IGl0IGNhbiBiZSBtb2RpZmllZCBwZXIgaW5zdGFuY2UuIFRoYXQgbWVh
bnMgdGVtcGxhdGVzIGNhbiBiZQ0KPiBtYXJrZWQgY29uc3QgYXQgdGhlIE1TSSBkZXZpY2UgZG9t
YWluIGNvZGUuDQo+IA0KPiBUaGUgdGVtcGxhdGUgaXMgYSBidW5kbGUgdG8gYXZvaWQgc2V2ZXJh
bCBhbGxvY2F0aW9ucyBhbmQgZHVwbGljYXRpb25zDQo+IG9mIHRoZSBpbnZvbHZlZCBzdHJ1Y3R1
cmVzLg0KPiANCj4gVGhlIG5hbWUgZmllbGQgaXMgdXNlZCB0byBjb25zdHJ1Y3QgdGhlIGZpbmFs
IGRvbWFpbiBhbmQgY2hpcCBuYW1lIHZpYToNCj4gDQo+ICAgICAkUFJFRklYLSROQU1FLSRERVZO
QU1FDQoNCiRQUkVGSVgkTkFNRS0kREVWTkFNRQ0KDQo=
