Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0311262EE9A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 08:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiKRHpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 02:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiKRHpD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 02:45:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8288B103;
        Thu, 17 Nov 2022 23:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668757502; x=1700293502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S87G3L3N3ncBEpQAKssoTbcIcwXnLivjhf8re/E5OW8=;
  b=RAXPUENQ9LlyLpzpS+AllpslEaoqCOnriMergkniWxrXheHvgdqv9xo8
   mnBbz4C/1kkH3K+Ri9dnelHuKNx1TgXuJjOhYmT5tKJr5OOnb2MoCxkI/
   KiNNPZJHxa0EeTTm9HlC0drd6FGOiaKy4DfY9Tv/aZdaATHTBDnLx41ha
   uxW2Mq3a9B6VE3xNg8U7GOrkqK7CMCwqVvtHntDcbSnxcV+MEdCcTDCoK
   sLGDdyti1W8IeJD+MlKuwOR58Mf8zfI5zu90fujzv2cgmip3L3Kg7836C
   xiAJXq27xhfAxpc9cX73VLhkJoMmDkpsr9BU9xqZTA5GayehLVlmDvrJl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314897521"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="314897521"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 23:45:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642417582"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="642417582"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 17 Nov 2022 23:45:00 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 23:44:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 23:44:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 23:44:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWQLOYQADV/GFrbCDFtWhBN03Npq4AchI7iN/E43o4CkHBpcJGISDjZ7XKtSeybATP29iS6YHzf7g50TkhRbpoDxvj5nq9gp/WQIKOZ0oOYGdX40Cie3MHuII8AbHGQ50TyS4PFeOk38pLBRhH+1LINJ9KUyfI3tGKGfpgGE9YVepW+C8dobsXNntCDQhdBg60Rw2drZKp+JEEGc4VDutTUGCW/R6ku3ZLoG+Dkzcbr/Iw0BIo3BPDs/xMc+FjeaZIFVFhh8USKpFrnMlp9XVMdahRvzdEYsKeK7ac4Er27MdZZecF5DbfCQwh6ZjL+TG1SrSjWl5FF2GizCTtcr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S87G3L3N3ncBEpQAKssoTbcIcwXnLivjhf8re/E5OW8=;
 b=RNuCy1jmanrPCIXT4bUTi1DKgx5g2UFIYgQl7LfPGtDf73ijGVQX3kGeRAMBf6aGueZT+uHPI+JZGaDkLJ3v7JLUQhPfJEVYCdzKKiks7L5T6+yI8Nn3ygnuDbffS9lhdRFQqn3moumveokb6XoEEfupapCngG+UamGtjbSoH11aEY9+RBHcpcwiivn+Rq1qFhzPIqVXEZtuRPAbLZXdW2vph/qz9YH6z+HLOt5FWIdG0avhLOQTZdB7RT3vbHvUeTmslkEjeoXmhD/Rw8dKQO8YMbfYsUZRRcjsMij08hrFnGUt0/XRjCDT1COYzx0PMw967veb4F/AL8FI9cjKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6539.namprd11.prod.outlook.com (2603:10b6:208:3a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Fri, 18 Nov
 2022 07:44:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 07:44:52 +0000
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
Subject: RE: [patch 04/20] genirq/irqdomain: Provide
 IRQ_DOMAIN_FLAG_MSI_PARENT
Thread-Topic: [patch 04/20] genirq/irqdomain: Provide
 IRQ_DOMAIN_FLAG_MSI_PARENT
Thread-Index: AQHY9dVz5XBxhwP8ukWx0DPcw8DF9a5EV4JA
Date:   Fri, 18 Nov 2022 07:44:52 +0000
Message-ID: <BN9PR11MB52764804AA65AE79A0A689998C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.276545278@linutronix.de>
In-Reply-To: <20221111132706.276545278@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6539:EE_
x-ms-office365-filtering-correlation-id: b1b7c330-c6d0-418c-1022-08dac938c762
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RJQrC2jfI7XbhYpFNa/DYrMXvOKsgf6DWqSt9Xpj4EaY6HgjZGkquuhbdY3yeuKBt4NjvYN/E5jMYey+f/C9+ExegbMrD3H3Bgqv3p2+v7tCvOFat7gIpjjwyNlbtSBV7i8G2wqNiIvV29BZc8l2ivLp87+SKh58xqk+DSlj7bn6W3USpiInpT1bhhOoCNUMfFV8KWD3hpFYh/EZztqQJ3CH93uVFQQdrMl0kfZbiHrdQG9GRICu/CERe2eWrUSUqLegG/sW7Ncq9ZCpq6tYkm7BBguv6ImbYu2m+nCVvkOj1gS3Ej7Q3YSB02xqv97gBwaj58t0Rkhh2Acf100opeQKOnI5519EN+Vlr+3LmZwWOHfLVIFMWRbIt38xq2i24iqWDtgScwNkHz4rAnWVHc+tdXijS7Wc3OR8bKqaGszXE1HuE6LC1DZnG84Jc4UTaRj1U/iJwxhKxQsgTlq5CyKK1avqYLW9ZVQqMXV9QxXe4QVhX/bejy6EoID7dDRaLOfdfSvxqffMnwChiBOUgAUVQ6dDVKFYIHVfZpc8MyUWrBHueGrg+TbWWemqjPAiqIMD1d7iRx2Bq2FJqz0FUSP1HmZaxWvfQBN+qHd4/KhdyS/cUrauw0r1W9WAbplc53jTgOw9o0nQ8vlUxu5hDluinaQil7p70QiFotwDa3YH8vGWxAd9ekJKtdjAE+/ixN4ErHsJjT9+YySF2NIKIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(26005)(33656002)(107886003)(110136005)(478600001)(55016003)(6506007)(9686003)(7696005)(86362001)(54906003)(186003)(316002)(2906002)(82960400001)(52536014)(38070700005)(76116006)(4744005)(7416002)(8936002)(66476007)(66446008)(64756008)(66946007)(66556008)(122000001)(38100700002)(71200400001)(83380400001)(5660300002)(41300700001)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elYrUjVRVDlLcUdLbVU5UDlhZDg1VzAxZTRMQkNhZW16MWFsVDNsNFN5SkVz?=
 =?utf-8?B?amNLVXJiK2svc1JZUDU4NHVZdjJhQ0I1UzRKdm1lK3Y0NU03ajJ4RjNPZ0ZH?=
 =?utf-8?B?WWlzanora2RQak01NjhlS0VRK0F0NC9OQnFlTys5a2tmdi8waXFiL0JhUUc2?=
 =?utf-8?B?TGFqZGRYdzVnQk1VR3hrQW5OS0N5MFNiMXVzZGRmb2czaWZpbG1CMDRXZDF1?=
 =?utf-8?B?bmRWUnNPNWpsaUZXVFExVDFzbFJvRVZSYWxaMGE4dDFodVNBK2JoTldhRFdk?=
 =?utf-8?B?MzdIcTByRjZRZkozUkJ1Ly9KYm1vc0Y4ZDhQaHVyU3h5eER0VE4wZFRaVHZk?=
 =?utf-8?B?YVNSUDJKNWFJWDNGTy9ObVFrelM5ZExHcTI2Qk0wQVVta2FuUkhTN2MzWlJh?=
 =?utf-8?B?d2gzUWduRG9JOG5QMzlqUUIrNTJ4K0ppZThrN2ROMTZaZGgwWG45TUwwMEVp?=
 =?utf-8?B?OG5TQmtKbllWTkNGZVV5SFA3a0tvWk1yQ1d3SnFQelhUSjd1UFdHMjAyRjVk?=
 =?utf-8?B?UHdWQjRQSHdPVHZ4WnBFK2tGMUpaUDhnQWYwVmNvQVBwOGxRVGJ5RWhmemtk?=
 =?utf-8?B?ZXBqaklSeVdvd01lU2E4WVpYYTh3S1cveDZucTBJNjZvSklsRVFNUkF3MTRQ?=
 =?utf-8?B?aEpuVTdzVU5ENERkM3RMTDNETlZBRzVKeHpQdC9PaURJTmxONmpWa0dUMytE?=
 =?utf-8?B?bitGOC8wMlFyeDFYMThPejVvSXNqUk5LT25BazFaWWovMStHaDRTTUd1ZnJG?=
 =?utf-8?B?bU00ZWhIY01ZQlgwNW1vNmYvMFRwbHh2Q3I2MjJyUVpDUHdyekRxT3YvZnZZ?=
 =?utf-8?B?SGZhemNmbWlBNkNsN0c3bno2VmhyWVc2UjFXNkxGckVBOUVmYjZJTzdiVnVL?=
 =?utf-8?B?MFJQeDVjbHhLSnYvV0xISitHT1NPaURQRGMxcWpsSGEvVVZjYWwrbXdQTDBR?=
 =?utf-8?B?STZ2dmJ6U2Rtd0JkR2Vjb3dVMC9vdXIrUEN5TWwwMGQ4Um9UVjl1Q0VGc0ox?=
 =?utf-8?B?cEZWMVlKRUwydStJQ0ZxQlR2ajgxb0ROYnp6TzBOa0J3RXZxdGZQQWFXaHNH?=
 =?utf-8?B?N3lZeFJPVnZyNGJmLzFPUDMzNy9wd3RHWEczZ1dicjJDRng5aTMrSEEvVG5m?=
 =?utf-8?B?Q0xINzJGSW9KaGVBK3RmM0tKRWN1UzhvenA1VTZYLytERlhHcWlkZzRCWHkw?=
 =?utf-8?B?cDJQelZZTG1HSms1aXdmdU5HVjZLckNsR09CVWh5MDRrRTlVL3FtZllGOTNo?=
 =?utf-8?B?UmNXZVd3OC9VZjZoK0xNSVdpL1RFQTV2SEtLamZ2VklkSUFWUHV0dmhtS2pB?=
 =?utf-8?B?MURPZnZTWXN2Z0ZmZE9FUElwSm1BSFllZjZRdjZDbVVZbkRuaC9XbkRXeXYx?=
 =?utf-8?B?aEZvVnJHYkRiYis1UXA2RXl0WDZSKzg4YU1YNmtkakJ6L2tqQ3Z3S0RvaGpB?=
 =?utf-8?B?RDE0R1ZDdkR5WFlWUktCSXNVL0s0ZTRxUkhDcGNuRWhTeXg4VVI2YXg3cnRU?=
 =?utf-8?B?eVdGc2FWb0Y3V0VhTWhuQUk5KzBqVCt3a1hkRlBQeDlSbDJCdXV2TFN1K1dB?=
 =?utf-8?B?UE9ZcElla25VWWtUZCt6cGR3cFRRTlltT3ZZaUdoZjVXSXUrdm9HOTJQOFBJ?=
 =?utf-8?B?ZXljRU56TzdIYW0rWVUvbHNkbjV5Q1lMdnprVFNEejFJREorYVo5bzd2NlJR?=
 =?utf-8?B?bWk1VjJtdkNFTStlUjUzc255TzVsdDRpbVBVZlcxTXpaUi8va2xoakdxRVpr?=
 =?utf-8?B?QXNxWmFzQmxJU1Q2SDU4TEVRcWcveE5DU0syclNkdEpvTVJNYlpOOE5OR0pH?=
 =?utf-8?B?clVjYUZRa3F4aDhnSUVrSjAvVzlMNUpGK2JrWUJjeFh3YjRweFJlRVVid0FI?=
 =?utf-8?B?MGNpMHBmMUdETmlKdXB3QzV6U0VKd0Y0YUJnU0FoVHFlUW5TcDBLUWlDN0pq?=
 =?utf-8?B?L1RKaElSdjVKSWVjSThWdHp4TFA4MmJNNkppb2lyVDhNU0crMVJPc2hmcmRi?=
 =?utf-8?B?WTZ0Z2lVT1BoZ2dBVnF1dlVnVFNOb1UrSVJ6Q01OcHlNbkRYUzdjeUlyMVBN?=
 =?utf-8?B?N2c2WnR5c3NTWWdvM2xMWVgyTGNkRitZUGFpTG80OHp3YTVVWEN0Ui83ZktM?=
 =?utf-8?Q?ymQDKZAW/GmOcgNyR84+X+xA1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b7c330-c6d0-418c-1022-08dac938c762
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 07:44:52.6790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSPDz/3ISoONOFlSWS5AmqFTP3WtC9SWrYT8ETxOp5zYo+IDtMcOTRnuIXS0gUEmjs/Nn09eIqUgU3S1W5zV0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6539
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxMSwgMjAyMiA5OjU3IFBNDQo+IA0KPiBUaGUgbmV3IFBDSS9JTVMgKElu
dGVycnVwdCBNZXNzYWdlIFN0b3JlKSBmdW5jdGlvbmFsaXR5IGlzIGFsbG93aW5nDQo+IGhhcmR3
YXJlIHZlbmRvcnMgdG8gcHJvdmlkZSBpbXBsZW1lbnRhdGlvbiBzcGVjaWZpYyBzdG9yYWdlIGZv
ciB0aGUgTVNJDQo+IG1lc3NhZ2VzLiBUaGlzIGNhbiBiZSBkZXZpY2UgbWVtb3J5IGFuZCBhbHNv
IGhvc3QvZ3Vlc3QgbWVtb3J5LCBlLmcuIGluDQo+IHF1ZXVlIG1lbW9yeSB3aGljaCBpcyBzaGFy
ZWQgd2l0aCB0aGUgaGFyZHdhcmUuDQo+IA0KPiBUaGlzIHJlcXVpcmVzIGRldmljZSBzcGVjaWZp
YyBNU0kgaW50ZXJydXB0IGRvbWFpbnMsIHdoaWNoIGNhbm5vdCBiZQ0KPiBhY2hpdmVkIGJ5IGV4
cGFuZGluZyB0aGUgZXhpc3RpbmcgUENJL01TSSBpbnRlcnJ1cHQgZG9tYWluIGNvbmNlcHQgd2hp
Y2ggaXMNCg0Kcy9hY2hpdmVkL2FjaGlldmVkLw0K
