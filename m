Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F52E635211
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 09:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiKWIQd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 03:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbiKWIQa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 03:16:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DC2F1DAA;
        Wed, 23 Nov 2022 00:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669191389; x=1700727389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7zNmNl2epwGjdci0+C5+2zUMs2YD7wmrP1BpfPbJoKo=;
  b=HSFPfrZ21i32p1Ih8hUU7lHVDHVnNHJn93uZSATnChl7E5Jc8ybUIFPU
   U6q+0aom5jY1qBW9xBv3tJVwTAmAo7myZxfWSMkLJqYS6KCz81W+IMfil
   lbzkEX6ywieswfwf0TolxVEV5x6Qu4bzIsM9CNXUUyjr7ufMv7z4t7JWn
   lm6Wxz78IF+GmTGZYxnAuqKZKB3wM8rh4nNuUOaAR0Hxn7IH1v3I5rVET
   lPqGxg172uR6V9sI/CjZeFXEeYHghPwkSgLz8MCtmrnbTq2lHd+f0TlVS
   gfESSfm81ttUOOtZQ3wTiYjltnEoH30RXYtX4vy4PyXpAcsH8CuY9Vs9I
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="378268154"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="378268154"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 00:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="784146185"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="784146185"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2022 00:16:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 00:16:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 00:16:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 00:16:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 00:16:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhOfKd7jzqhdQZ3TPnUzQjJdURmXTXkLnBEDDeRzgI3l3gi/oJSG25Dn8Ayb+B413qBmDOD5Y5hcrBWKlJkDrVqwu/xvx4/PVOlFkoBvZ3DHz11cXv8IWtpYOgcrYLavbJSDDkBUP8SHuMqoGJeNIjgRivaCnmaf8N3rw2GDrENmMrVkIr6JI6ihw1OEe5oclxFjM5d3YB48hBwL/sR6KMPde4AMYAOpmzlIV8RwOc6+scQQpjsoP/yRifoYscors23Cwm4xscvOYn/CoWJ4ImbpXVGr0Vz6N6VYHmMR5vZCLOQ2Ecy3DcylUj8kIAHP+jnQU+0M9bW/o+qn4IvEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zNmNl2epwGjdci0+C5+2zUMs2YD7wmrP1BpfPbJoKo=;
 b=n/FFWyfPg/UmaRWxGHBw140Pfnj5TU2QpIUsXMsjEqWNrdc5obA3e41maYPee7QVlFW84UPHTy5W67luqcNtuF4b/W00NJzCvGzJ58tlX4QhmPVWxe5/LUo/hbxH30M6k7J5qLI8PoVfWZjj1/sXei9+3KBQ/VRvL+GzjwGs+D1d4KTvvNKgJRHqwhlOEBY4IfI4I7ZBo4c3e0CWmIowBSx64dFyg4MgCVjrIji7WI7V012VZNZPVEMTq3JJn7xSYZG45yGMQ2Xn/1gfbfiXXut7ps7hs+IzSe2gWkf//cYTLw2DBDW6Dt1WAOcnlNoRIzc+REMONvrQFuzLkJhXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 08:16:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 08:16:25 +0000
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
Subject: RE: [patch V2 13/33] x86/apic/vector: Provide MSI parent domain
Thread-Topic: [patch V2 13/33] x86/apic/vector: Provide MSI parent domain
Thread-Index: AQHY/bbt5YvI6UGKMkmsvSCG3w5Tb65MHIMg
Date:   Wed, 23 Nov 2022 08:16:24 +0000
Message-ID: <BN9PR11MB5276223A2114DD96420C7B1D8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.217466288@linutronix.de>
In-Reply-To: <20221121091327.217466288@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4976:EE_
x-ms-office365-filtering-correlation-id: e1843df8-004f-4aaf-432b-08dacd2b0352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YnnaY9jK19jvnhrWY3TvcJ0XWwsfzLbSyXpGdVFv8IElIjypopNwI79bcue1gtXK9CJAZiSkZAyYyoX266ApmHU2gJJYF2MV1tDZ64eF10M0QTzcwxQ+AhrbtidFWQBK2BRnsGIpbYMS7Daadpc7KRHE2BweX5OD6OI9XzQpX1HWQ01AFjfScKGi4ojZa9k2x5+CYum2K61NYHQQmoeBY/ijED5GdJcFapwT7EXrevoigLp+hxyM/VjMGVmuu5Gm8qE92zy8vC/6QtCt1FLzonGzg1WXe+MWFL99GVKRhKyz78dYlYANleSbNclJda46EojKwVcwo3uithKH4aIFXsEftr6u8sWjr8QesCC3ZNzeKT9ac1rrxAG1i6BvZOhbMMCkDmty75o0nvv7pFvGxHv/ISy2BsCMbQibEFp4tQC+lUIaSATjbmW6xLuOnAjtQQ9/wb8/wX6NHGpngyiXyyr684kwQO1a+pV3TgKTvLyurmrB3zsZWQNT6+Xt5fjC33XdOCRJ4uWhaclN0pX5lirVlPV6G8/avIyJYFb/yMqdSg2BfSNk04Y0MqDMjmrDEtBcTGLWY+w78aGYxAvtxR2OHdJr0j4P8q0tCJ8ED28BB2GeMR8+H/e/8QxoJq4DBmMkWk+NEntrI7BNUwKiTMIHXbPxdpIpbR2QXoPJg/pJoqRHWw/+DHzeI0tdjMMbwXweg1Oe//u/lu4zNImXRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(33656002)(86362001)(26005)(38100700002)(7696005)(64756008)(76116006)(55016003)(7416002)(5660300002)(186003)(9686003)(2906002)(122000001)(38070700005)(82960400001)(66476007)(66556008)(71200400001)(6506007)(52536014)(4326008)(66446008)(41300700001)(54906003)(478600001)(110136005)(8936002)(66946007)(8676002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG9FMTg3WHVzcWtuMEZVbkoyRlJBanlrVjNnVlFSNVBpay91ZXNrN2FTdTJW?=
 =?utf-8?B?U09iOUZKc1ZNK0JMTitzR1NkclhzNkhkVld1dnY4eGFTdlVnY0N6TEs5YnZB?=
 =?utf-8?B?NlpHTzA1YmtKTFhmMmY1bjA4Nk4ya2xYblRJRXprcHpMK05pUzZFODFqU2NN?=
 =?utf-8?B?RFV5bTZBckg3dDZvSWpRY21kejNpOGhrb1FMR0M3R0FSdmpaNlNtYmsxNkda?=
 =?utf-8?B?VUVFUjZHMHcwaWhPdXhXRDREamkxN3ZRSkpOSGdKZ0V2cFdvK3RyOFNzcXMw?=
 =?utf-8?B?U3FuQXZmME10Z0lYV1ZteThOWkZUTVdtZGpocUtUakRDQWVMZkhyNDhVWTFZ?=
 =?utf-8?B?clBWZVV0YXQzZ3EvZTk2eDZ1TmVxZW0rVSttMlp2R0xRRExCcVhoSFlQRDJB?=
 =?utf-8?B?b01XODR4TUt4ZURVQ1FUOHpRZExMa1J4enVsZWdHbG5vc1k2R1hxbm9kbFlK?=
 =?utf-8?B?aFFZY1J3cU1KQkx3MlVCY0JnTms5WldLc241S3VTZlluaXhYMVllZkFkNkpF?=
 =?utf-8?B?ck5FNk0wcXhBcCtWT3R1ZlRyQW9zZWtNZXRrSTVXZGtKNkJlRU1OYnA3RUNY?=
 =?utf-8?B?a003L1J4MHp5dlBIYXB0VW9UUFhrbGJtb1VtVTQ1MnNZZDFmekhjTFdETWw3?=
 =?utf-8?B?N0oxeEdpR0tOSFpUY2hoYkVzZ2Jyd2s1VmhJSVZCZkt6cWVHaDgwa0lKanhH?=
 =?utf-8?B?RzJydWNISDh2ZVluMkRkeXhDUUhTbkRKd2M2aGFwc0JkQnRuZjRoTVZSU29Z?=
 =?utf-8?B?eWlMWmJJTDNvTnR1enNXRlgrYXVkelFISkI0eHA1WDY2RCsrR2Naam1MQlFo?=
 =?utf-8?B?QzFTS1AwakJIaGFQZENMU05DTmQxK1REVHBBTUJybzBtRERNT3Ewc01FY2JY?=
 =?utf-8?B?OVJDSnJQaFB6OHMvbHQ3Sm0wcktPaWhXbnJrSmYwa1FTS21XUnBrbit4TmpE?=
 =?utf-8?B?enhWbk51QWl3bjF5ek42QlBBNnBhQUx3M0h5ZkNSRjZ5ZkZLOTlYRy9xS3FS?=
 =?utf-8?B?UlRvUjZqckpsNnBGbmZWc3hOcGpVWEhZazZqSVF3SThmTWp6QnZMVThlQUVR?=
 =?utf-8?B?N0hVWm5ZQnBvUnVBR0NBTGkxeEI2ajJtb3NRT1hld3BwaTJYZTAyUWU1NTUx?=
 =?utf-8?B?MndOU1NuTUtRVUkzVWt5QUJLZG9QYVF0R2o4RE5CeVM2UE5xR2RZSWxlZHg4?=
 =?utf-8?B?K3ZKaDBPMTZyV3ZOSWhCUkQrUHFvdGJ2NUNSRGhqclJZMVJza2JjbENEWnA3?=
 =?utf-8?B?QjBBT0JGTkdBT3FRM2V3ano4eFBJeUl2emZoT3NSYWdCc0w2TXhtNWkvYkY3?=
 =?utf-8?B?bloyOXZBN0FMRU1oM0o4VURVb1Q4L0RsK3VIRmRpQVZiekR2Sml6OGUrTm02?=
 =?utf-8?B?b1JkMDQwbThuUnBEazAvUk02L2NZWFVQMVk5YTF0U2VtTEp2MW5QUU1ha2JZ?=
 =?utf-8?B?aS9BR0psTlZaR1l5a1dQdklHK3luUEtRUnBQRXpVY21wditqTWFTbWVhN09J?=
 =?utf-8?B?ekdRc1pSVW94VGhMWTlMeUhneTVVOTFzWERiazJVMXBlbVlIblpyT2k4Wmsv?=
 =?utf-8?B?WHdIRHkveUZFWmlZRXY2SjdweXdndnJFM3prZlhUZmd0OUpwRXVTUHZZNWJD?=
 =?utf-8?B?WGRtQXNRaEZWTlhMVk5KRmxBdGNxMlRkeG14MXRtMXVCUlhUQjQ5MEU1QllG?=
 =?utf-8?B?ZFhVZWJwZlg2WWh5Y0MyWFZFVmhtc2lILzg4ZnFFKzdaKzhmMVlFcDErTm5P?=
 =?utf-8?B?MWJ1TGIwUFZtZ3Q0QzBHNXliR1RHTmdMemd0cWJzMVVKQUFmdTNnY1VxZ3ow?=
 =?utf-8?B?Ui9TYzhIbzlXSGhzY3RhanFNcG9HcTZpRHFYVlhKVzRzMUxIdjViOGtTMnND?=
 =?utf-8?B?Mjg3eU1hRmNkVUhQQm9YamJPRnBaZFE2WkVLMDBNY0drVXdYd1FFc3g0cGQx?=
 =?utf-8?B?UnQ0MmpobHB6czVpT0V5biswM3ZTVTVGekl2a29WNHREYTdxbGFRbWZrN2FF?=
 =?utf-8?B?QWR6QUx0THJRRTNRM0JvRmZMQnpCb1AyRStzYWlIZmFUckV5REtqczcrejVM?=
 =?utf-8?B?STl1VHhkbWd2R0YwUmhxWVc5Mi9uWnNSeHZnVFRZTmxmeVlTSW53M1A2Yy9Z?=
 =?utf-8?Q?xSJOxVC8PZrBwdkZq27Q3HzjK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1843df8-004f-4aaf-432b-08dacd2b0352
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 08:16:24.8731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBzSHb6GHKez3I1MlDoi9RDZkb5k0J6kocUCi/JnotNjNoXs28xfFYl3JcNnlASb9IFAkPSjkj1xrGamiHEgxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
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
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gK2Jvb2wgcGNpX2Rldl9oYXNf
ZGVmYXVsdF9tc2lfcGFyZW50X2RvbWFpbihzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiArew0KPiAr
CXN0cnVjdCBpcnFfZG9tYWluICpkb21haW4gPSBkZXZfZ2V0X21zaV9kb21haW4oJmRldi0+ZGV2
KTsNCj4gDQo+IC1pbnQgcGNpX21zaV9wcmVwYXJlKHN0cnVjdCBpcnFfZG9tYWluICpkb21haW4s
IHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IG52ZWMsDQo+IC0JCSAgICBtc2lfYWxsb2NfaW5mb190
ICphcmcpDQo+ICsJaWYgKCFkb21haW4pDQo+ICsJCWRvbWFpbiA9IGRldl9nZXRfbXNpX2RvbWFp
bigmZGV2LT5idXMtPmRldik7DQo+ICsJaWYgKCFkb21haW4pDQo+ICsJCXJldHVybiBmYWxzZTsN
Cj4gKw0KPiArCXJldHVybiBkb21haW4gPT0geDg2X3ZlY3Rvcl9kb21haW47DQoNCnRoZSBmdW5j
dGlvbiBuYW1lIGlzIGFib3V0IHBhcmVudCBkb21haW4gYnV0IHRoZXJlIGlzIG5vIGNoZWNrIG9u
DQp0aGUgcGFyZW50IGZsYWcuIFByb2JhYmx5IGp1c3QgcmVtb3ZlICdwYXJlbnQnPw0KDQo+ICsv
KioNCj4gKyAqIHg4Nl9pbml0X2Rldl9tc2lfaW5mbyAtIERvbWFpbiBpbmZvIHNldHVwIGZvciBN
U0kgZG9tYWlucw0KPiArICogQGRldjoJCVRoZSBkZXZpY2UgZm9yIHdoaWNoIHRoZSBkb21haW4g
c2hvdWxkIGJlIGNyZWF0ZWQNCj4gKyAqIEBkb21haW46CQlUaGUgKHJvb3QpIGRvbWFpbiBwcm92
aWRpbmcgdGhpcyBjYWxsYmFjaw0KDQp3aGF0IGlzIHRoZSBwdXJwb3NlIG9mICcocm9vdCknPyBp
dCdzIGFsc28gdXNlZCBieSBpbnRlcm1lZGlhdGUgZG9tYWluIGkuZS4gSVIuDQoNCj4gKw0KPiAr
CS8qDQo+ICsJICogTWFzayBvdXQgdGhlIGRvbWFpbiBzcGVjaWZpYyBNU0kgZmVhdHVyZSBmbGFn
cyB3aGljaCBhcmUgbm90DQo+ICsJICogc3VwcG9ydGVkIGJ5IHRoZSByZWFsIHBhcmVudC4NCj4g
KwkgKi8NCj4gKwlpbmZvLT5mbGFncwkJCSY9IHBvcHMtPnN1cHBvcnRlZF9mbGFnczsNCj4gKwkv
KiBFbmZvcmNlIHRoZSByZXF1aXJlZCBmbGFncyAqLw0KPiArCWluZm8tPmZsYWdzCQkJfD0NCj4g
WDg2X1ZFQ1RPUl9NU0lfRkxBR1NfUkVRVUlSRUQ7DQo+ICsNCj4gKwkvKiBUaGlzIGlzIGFsd2F5
cyBpbnZva2VkIGZyb20gdGhlIHRvcCBsZXZlbCBNU0kgZG9tYWluISAqLw0KPiArCWluZm8tPm9w
cy0+bXNpX3ByZXBhcmUJCT0geDg2X21zaV9wcmVwYXJlOw0KPiArDQo+ICsJaW5mby0+Y2hpcC0+
aXJxX2FjawkJPSBpcnFfY2hpcF9hY2tfcGFyZW50Ow0KPiArCWluZm8tPmNoaXAtPmlycV9yZXRy
aWdnZXIJPSBpcnFfY2hpcF9yZXRyaWdnZXJfaGllcmFyY2h5Ow0KPiArCWluZm8tPmNoaXAtPmZs
YWdzCQl8PSBJUlFDSElQX1NLSVBfU0VUX1dBS0UgfA0KPiArCQkJCQkgICBJUlFDSElQX0FGRklO
SVRZX1BSRV9TVEFSVFVQOw0KDQpBYm92ZSBhcmUgZXhlY3V0ZWQgdHdpY2UgZm9yIGJvdGggSVIg
YW5kIHZlY3RvciBhZnRlciBuZXh0IHBhdGNoIGNvbWVzLg0KQ291bGQgc2tpcCBpdCBmb3IgSVIu
DQoNCg==
