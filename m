Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F487A3F01
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 02:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjIRAd3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Sep 2023 20:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjIRAdY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Sep 2023 20:33:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C52411F;
        Sun, 17 Sep 2023 17:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694997198; x=1726533198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2eAWlSnAsfwJIQNBVL7yf9w5m4Uh9Ue+aL6ASH0zXMA=;
  b=RvhOM/rd3qa8jOCqYulaYbZzR/5PIF+3FscIFO603VmoqNvFMDZvMRZD
   5jQ6gH8p4O5mSwMsuvniRSSFmy04lMZfqX+wcBIAIDZNiu6Xobp7Exeol
   Jh256gsnICU2L24Gc1JggG2iI+qNI6sxrgglDZ0iKPHoRtB+m3m53qUis
   rqnxXFAeYhwplRqA1dxskzi3CHt1QP4SbN+X5gAPuKg2StMrBdEt6mvEz
   N6tkvxouxAQs0Q5ym1QT8G5ycBOO+E7wPxmMK2Rbw1gMmVR3+Ejhb9M8c
   ALkEvlp1KXjUPrjbQLmPGG8kTeahntmqkD8WOTTyPdCv04XY6cTrsxe+j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="383361035"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="383361035"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 17:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="860859378"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="860859378"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2023 17:33:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 17 Sep 2023 17:33:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 17 Sep 2023 17:33:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 17 Sep 2023 17:33:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+Vw1mTURQwB9tuACRpokukMI+n+8MVKl27YdBzPpsl6unOL4jo4+xmUeH/2tIWPs9gwgRNLNiEIaJoDnQwwEOLj07gno/f1Ka6g2977Gyfooevaeae6WBaXGCukHofve42bUkgoeYEFq+R1cF7t/GDSm3Uz7m3xCOm8Cf+yz6pVQ9T9xnWUp1UoEquEMNWJ+ZI0z+y/TT0GaEfGH9IfUoS6wgBexgpkhQCLe+En93xG4MWraWOA8RLv/kI2is95ooXgdCRKqkUHZcmVCzBTeD398kPD/JAKYX8XNojVEQWlURgOu5/u9taSmXLSl1iLf+JfGVqf0baVZFj+Nw+nvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eAWlSnAsfwJIQNBVL7yf9w5m4Uh9Ue+aL6ASH0zXMA=;
 b=fGj9YdscLQnMyGMPHJKQfvIHWZvhqaDNzgwRHi9ApeTTd7UlFT8wZxrNXC4teVrHcUn1kwCDPFcl2w2PqTcGCZ66wbNiUoQZRRuWB2z+nEiCC+XcBV+rnPYrvH+9VK4FUhP++NF+8eGcLIqw4m0ZV1itujfff7SCpfQG796k7Es1e4R9o8kheG6zppdoqsnwl3ql+gadD+qWsqOMt60U1vTrSyl4tHeLr1h1v8UHUL8E2uaQ4M7KDdcITSz/4x/WntpNTIkET8nzr32Bl0EqECvtJWcrpG7wt50YqgkhQ0XE4Dk/JohV4+5GmCFe42MJE4f1JiBHQbgirXt+rhvrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2618.namprd11.prod.outlook.com (2603:10b6:5:c0::30) by
 BL1PR11MB5221.namprd11.prod.outlook.com (2603:10b6:208:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 00:33:14 +0000
Received: from DM6PR11MB2618.namprd11.prod.outlook.com
 ([fe80::195e:39ff:e0fa:c497]) by DM6PR11MB2618.namprd11.prod.outlook.com
 ([fe80::195e:39ff:e0fa:c497%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 00:33:14 +0000
From:   "Xu, Even" <even.xu@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lee, Jian Hui" <jianhui.lee@canonical.com>,
        "Zhang, Lixu" <lixu.zhang@intel.com>,
        "Ba, Najumon" <najumon.ba@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
Thread-Topic: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
Thread-Index: AQHZ5sKmjsJQWHkOtEGLHUKsvcaerrAafreAgAC8T9CAACtvgIAAFvPAgARDGWA=
Date:   Mon, 18 Sep 2023 00:33:13 +0000
Message-ID: <DM6PR11MB26184A8A3F955589F5FC6836F4FBA@DM6PR11MB2618.namprd11.prod.outlook.com>
References: <20230914041806.816741-1-kai.heng.feng@canonical.com>
 <7b45ac2ed091497b4e21a6a5c19956161175ba16.camel@linux.intel.com>
 <SN6PR11MB26245C44E84C37C1B551260EF4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
 <CAAd53p5ywMVKWzhn0nYzvBnW_Bc=sntgBttJdcVUuf_a4AnX5w@mail.gmail.com>
 <SN6PR11MB262473E2BF4057F4D285A613F4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB262473E2BF4057F4D285A613F4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2618:EE_|BL1PR11MB5221:EE_
x-ms-office365-filtering-correlation-id: eb97a535-0792-448c-e287-08dbb7ded81c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WmkoKQysoEzbonadIv5xa3j7MTT5MfMMfoF74vi9dXViCnzH97a6Fn9+hGfU4hVZ6EvRAcP7ybH0ixuqNJeAuSa3T37bOoue1yf77USCePoerSdcwE4xWj9gVX17+4EadbZ7Q6ZwMbpXssKmvQZjiVGgBMBVV9YLHYHhh9t1Nj7R4mOF2V4tHRM7mgHHO/cnHEl0LdUP++qdOH5lGwUyPnf4mU6Sjp+7EHQIAjJrk3ML51prSOS71r1rFtlHtRndpoCGHQ1O2QdC67eKT6As1rcP6lz1nnDFlb3Z72tPkX/vc9zDaUjpoEkiPyS+RynoHN9Q1wB7A4rST5RaMbIeqJYCeyCR8vRNsGtcinUNgWbl5vkC8KPA2kez9tHxcq0bztJT+/v78sdHA+wCyZ8d2nYxKW0EGQHJJg6Efm+MV78aBuE3wtBqTy/ExyvYEsKOY37AK5G2vcwWgv8hYPm9BJ/UiXOzJz44VcDM4uSVpqQ9YBwWEkZ8zYqxAq+0HsKHb79CaS5Vd9brkVT6pTPwUmhZZ3eM7DyTAnpabRfT3LJ0L09exCmt5N0LXRh0kspK6k6zmmgFX4liSG4V1yb4vhfOPS9MOhSyMBtDPEHOE4s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(1800799009)(186009)(451199024)(52536014)(5660300002)(26005)(8936002)(4326008)(8676002)(2906002)(86362001)(122000001)(82960400001)(38100700002)(38070700005)(33656002)(83380400001)(55016003)(66946007)(6506007)(7696005)(53546011)(76116006)(66476007)(66556008)(54906003)(64756008)(66446008)(71200400001)(478600001)(9686003)(41300700001)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWlWV090RUNlb3htdWh0ZTJjYkE3RTE2WS96aDF4TXcxREU5OWFQeGVjZnNG?=
 =?utf-8?B?ZGI2SHorQTlhRUZYK05WS21yOVd4SHBydlZyWExIc1VHUzJpd09TbDFCdzRI?=
 =?utf-8?B?Y0xYOFNWaDl3MUU3VFdDYUR5Skd0OUZDWWxVWW04MGFDMGQwaUxGNjhhYzlZ?=
 =?utf-8?B?QnROZHBEUXl1T1lWQzlXMUtyd3ZnaGNXd2ZBVWhtQjRTQ1N3MXlGalA5Wita?=
 =?utf-8?B?Z21UUFViZkxodTlaZy8yeWRXZnlwVjdLT1gwb3h3bzk4TWNnUm8ycytpcEUr?=
 =?utf-8?B?SnhUenY3ajV6RVVUdE9HczhCZW10SzNxek9yb3hqeEltdFN3ZVFIVEFRVW9J?=
 =?utf-8?B?d3FlSzZHYTF4Q0NQMUtqZHpMeGFMM25YRmZSSzhqTG9TTnE0TW1neWtwUVZC?=
 =?utf-8?B?YUh2bjlJdTYwS1dBVFVCVCtLc1JCNEQxZ2FhUDBLaHBGdEtiZjJwTHN4QUd5?=
 =?utf-8?B?YWMxYU0zN1lZdlpoR1VYNGQzQmZTbjcvV08xS292VUNXK3FyYkJLQm9LTWVO?=
 =?utf-8?B?elYzbkg4cXMzdmtJU01PZGVCSkRyalFRejBoaU9tOXBFSjdKSUg5L2dNcFoz?=
 =?utf-8?B?UUMxQnU4d0ZJNHBIYmZIbGFUbkp1SWw5Q1gyZ1NFVWVvTUtneDhVb1JpRjE4?=
 =?utf-8?B?N3lFMGJ2TmtYWHBHV3JrbXhJemh2anEwdytjUHJJQll3SE5Zbkh6bURrSXBk?=
 =?utf-8?B?cGFBemdiK3lncG9LQ0FtOVhPZUJsTmlCK1Uwa2hpZExCOFFlRXBuYXJ2SHNN?=
 =?utf-8?B?eTlKdzV2VWViR2pKR0ZMNHpPa05HbEIzY3ROY29OYmt0M1paRFlqa3Bpd3Zl?=
 =?utf-8?B?NE04N2FmTUw3QzZqTU5ORlVZTnV0MGIwcDJxRi9DKzdDZzZQR2d0SEU0VVlD?=
 =?utf-8?B?MWVhWCtMVzhiV3AyTllTdU9LZ2ZIUGVnNEJUMTlTUjg1MXBTV2NTVWpDUVAx?=
 =?utf-8?B?dXJ6ZnhzTkttZ1A4NlVuTEJaV2xMeldRY3crSjY5TFBmc2JVT2JBMFg5NzA0?=
 =?utf-8?B?RlJYQVFLdE9xUFFoRW84Ri9sazdrTHI4UWt6bGw5UlBwTUhDTWxESWtrUnZR?=
 =?utf-8?B?VmxzVzB4UmNENGR6aGZjUDVPa0wyVktiUnZ5dVBhRFI2ZDNoajJvWGhzNTgv?=
 =?utf-8?B?Rm94RUE3UGlmR1poNUhXVHd0LzJrQlIwTVBWbjJzdnR4MjdvMHlNdWxTY3NO?=
 =?utf-8?B?aSsvcU5DTGEwRG5OS3dUdi9WWWUxdkF5aVN4aEpSTFR5TUJHNEc0VEMvSTY0?=
 =?utf-8?B?RlBmU05MNEorRzUxZ3hpcUU5cG83UkluS1ppbGZlenVpMHFZblI0dEw5OTZL?=
 =?utf-8?B?L21WQ1ZlQklTaWR6dzlJaHF4aXpyTHVDTEcxV3FNVWpHaERPdE1vU0tJb3c4?=
 =?utf-8?B?bmIwTHMyV2dtZEY5Qkt1alAzcmMwZTN0MW0xTE9paDkzSmtNOEVPQXU3U0l5?=
 =?utf-8?B?RHNObTh0cjk0Z3hNYnRsdHp3Tm96WG90elpUK2luMTE0NnpENCtGc2Zrbnp0?=
 =?utf-8?B?SHJsZHI1ZjYrZWZjY1Q0bk1FY2xJQVpGQ1ZBVDVmc2hoRVAvaGsvdTR2VTFJ?=
 =?utf-8?B?UitGRUNyZmRCTUJnUklURUxXWWFNZG8ydSs5SDNwWmh2K3hjUEFnRXFMN01K?=
 =?utf-8?B?b2hGTnQrOGdudktNUjgzdU1zTEZnRHpWYVk4WUVHY1BUWjhnRE9QOGpUUEVv?=
 =?utf-8?B?NU1oOWxWd21qRUJyU0FRTEx2cmFVRlM3cU1iYXZ3RFNwdCtmUGRxUzVaOEhm?=
 =?utf-8?B?aFZPS1M0TzVLWHJDSnZPNUt5TkJSYVhGQWptd29WcTNNKyt3UWhBL2l5bnNV?=
 =?utf-8?B?WHRpaVVOc3lTeDZtN2hUQlpleTJudlFpNFJTclBURVBuZkN1Wm1Ga05iSjhx?=
 =?utf-8?B?NnY1N0d5UGNmbU9xMFJqQzZhSi9ZdmV5MUtydmFJRmxQVFc4UEtEVmlqSWha?=
 =?utf-8?B?bHc5ZTBhYm82K3dyUk0waE43V2Y2UUUyYitISTFHQzJidE9GLzFqL2I1NHJp?=
 =?utf-8?B?NnNzZTYrMlNhdXVvUWZUK2xwSU1pWFpPOURnRGQ2UXZMWFZXaGZIVWl3NTBk?=
 =?utf-8?B?c1ZKRmFkcDhOSUdPcGVjamgzUTl6T1Z6VWxRR2ZkMkRSQXBnSDBvYlBHdEdM?=
 =?utf-8?Q?dS6Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb97a535-0792-448c-e287-08dbb7ded81c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 00:33:13.9447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHZcn/EL+H5CBagY5EKl4JPATaS7lOkm3PWr+/FDrrBm03nuv2eylF/shLbtYFDrXjqYCPwTzsTkiSYr/pwt9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5221
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

SGksIEthaS1IZW5nLA0KDQpJIGp1c3QgZ290IGZlZWRiYWNrLCBmb3IgdGVzdGluZyBFSEwgUzUg
d2FrZXVwIGZlYXR1cmUsIHlvdSBuZWVkIHNldmVyYWwgc3RlcHMgdG8gc2V0dXAgYW5kIGFjY2Vz
cyAgImh0dHBzOi8vcG9ydGFsLmRldmljZXdpc2UuY29tL3RoaW5ncy9icm93c2UiIHRvIHRyaWdn
ZXIgd2FrZS4NCkJ1dCBjdXJyZW50bHksIG91ciB0ZXN0IGFjY291bnQgb2YgdGhpcyB3ZWJzaXRl
IGFyZSBhbGwgb3V0IG9mIGRhdGEuDQpTbyBtYXliZSB5b3UgbmVlZCBkb3VibGUgY2hlY2sgd2l0
aCB0aGUgdGVhbSB3aG8gcmVxdWlyZWQgeW91IHByZXBhcmluZyB0aGUgcGF0Y2ggZm9yIHRoZSB2
ZXJpZmljYXRpb24uDQpUaGFua3MhDQoNCkJlc3QgUmVnYXJkcywNCkV2ZW4gWHUNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFh1LCBFdmVuIA0KU2VudDogRnJpZGF5LCBTZXB0
ZW1iZXIgMTUsIDIwMjMgMzoyNyBQTQ0KVG86IEthaS1IZW5nIEZlbmcgPGthaS5oZW5nLmZlbmdA
Y2Fub25pY2FsLmNvbT4NCkNjOiBzcmluaXZhcyBwYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT47IGppa29zQGtlcm5lbC5vcmc7IGJlbmphbWluLnRpc3NvaXJl
c0ByZWRoYXQuY29tOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7IExlZSwgSmlhbiBIdWkgPGppYW5odWkubGVlQGNhbm9uaWNhbC5jb20+OyBaaGFu
ZywgTGl4dSA8TGl4dS5aaGFuZ0BpbnRlbC5jb20+OyBCYSwgTmFqdW1vbiA8bmFqdW1vbi5iYUBp
bnRlbC5jb20+OyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNClN1YmplY3Q6IFJFOiBbUEFUQ0hdIEhJRDogaW50ZWwtaXNoLWhpZDogaXBj
OiBSZXdvcmsgRUhMIE9PQiB3YWtldXANCg0KSGksIEthaS1IZW5nLA0KDQpJIGFtIGFsc28gbm90
IGZhbWlsaWFyIHdpdGggdGhpcyBTNSB3YWtldXAgdGVzdCBjYXNlLg0KSSBhbHJlYWR5IHNlbnQg
b3V0IG1haWxzIHRvIGFzayBmb3IgaGVscCBvbiBpdC4NCldpbGwgY29tZSBiYWNrIHRvIHlvdSBv
bmNlIEkgZ2V0IGZlZWRiYWNrLg0KVGhhbmtzIQ0KDQpCZXN0IFJlZ2FyZHMsDQpFdmVuIFh1DQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLYWktSGVuZyBGZW5nIDxrYWkuaGVu
Zy5mZW5nQGNhbm9uaWNhbC5jb20+DQpTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxNSwgMjAyMyAy
OjAxIFBNDQpUbzogWHUsIEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPg0KQ2M6IHNyaW5pdmFzIHBh
bmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPjsgamlrb3NAa2Vy
bmVsLm9yZzsgYmVuamFtaW4udGlzc29pcmVzQHJlZGhhdC5jb207IGxpbnV4LXBtQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgTGVlLCBKaWFuIEh1aSA8amlhbmh1
aS5sZWVAY2Fub25pY2FsLmNvbT47IFpoYW5nLCBMaXh1IDxsaXh1LnpoYW5nQGludGVsLmNvbT47
IEJhLCBOYWp1bW9uIDxuYWp1bW9uLmJhQGludGVsLmNvbT47IGxpbnV4LWlucHV0QHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRD
SF0gSElEOiBpbnRlbC1pc2gtaGlkOiBpcGM6IFJld29yayBFSEwgT09CIHdha2V1cA0KDQpIaSBF
dmVuLA0KDQpPbiBGcmksIFNlcCAxNSwgMjAyMyBhdCAxOjMx4oCvUE0gWHUsIEV2ZW4gPGV2ZW4u
eHVAaW50ZWwuY29tPiB3cm90ZToNCj4NCj4gSGksIFNyaW5pdmFzLA0KPg0KPiBTdXJlLCBJIHdp
bGwgdGVzdCBpdC4NCj4gQXMgbG9uZyB0ZXJtIG5vdCB3b3JraW5nIG9uIEVITCwgSSBkb2Vzbid0
IGhhdmUgRUhMIGJvYXJkIG9uIGhhbmQgcmlnaHQgbm93LCBJIGNhbiB0ZXN0IHRoaXMgcGF0Y2gg
b24gb3RoZXIgSVNIIHJlbGF0ZWQgcGxhdGZvcm1zLg0KPiBGcm9tIHRoZSBwYXRjaCwgaXQncyBm
b2N1cyBvbiBFSEwgcGxhdGZvcm0sIEkgYXNzdW1lIEthaS1IZW5nIGFscmVhZHkgdmVyaWZpZWQg
dGhlIGZ1bmN0aW9uIG9uIEVITCBib2FyZC4NCg0KSSBvbmx5IG1hZGUgc3VyZSB0aGUgR1BFIG92
ZXJmbG93IGlzc3VlIGlzIGZpeGVkIGJ5IHRoZSBwYXRjaCwgYnV0IEkgZGlkbid0IHRlc3QgdGhl
IFM1IHdha2V1cC4NClRoYXQncyBiZWNhdXNlIEkgZG9uJ3Qga25vdyBob3cgdG8gdGVzdCBpdCBv
biB0aGUgRUhMIHN5c3RlbSBJIGhhdmUuDQpJJ2xsIHRlc3QgaXQgaWYgeW91IGNhbiBsZXQgbWUg
a25vdyBob3cgdG8gdGVzdCB0aGUgUzUgd2FrZXVwLg0KDQpLYWktSGVuZw0KDQo+IEkgZG9uJ3Qg
dGhpbmsgaXQgd2lsbCB0YWtlIGVmZmVjdCBvbiBvdGhlciBwbGF0Zm9ybXMsIGFueXdheSwgSSB3
aWxsIHRlc3QgaXQgb24gdGhlIHBsYXRmb3JtcyBJIGhhdmUgdG8gcHJvdmlkZSBjcm9zcyBwbGF0
Zm9ybSB2ZXJpZmljYXRpb24uDQo+DQo+IFRoYW5rcyENCj4NCj4gQmVzdCBSZWdhcmRzLA0KPiBF
dmVuIFh1DQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IHNyaW5pdmFz
IHBhbmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBGcmlkYXksIFNlcHRlbWJlciAxNSwgMjAyMyAxMjoxMSBBTQ0KPiBUbzogS2FpLUhlbmcgRmVu
ZyA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPjsgamlrb3NAa2VybmVsLm9yZzsgDQo+IGJl
bmphbWluLnRpc3NvaXJlc0ByZWRoYXQuY29tDQo+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IExlZSwgSmlhbiBIdWkgDQo+IDxqaWFuaHVp
LmxlZUBjYW5vbmljYWwuY29tPjsgWHUsIEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPjsgWmhhbmcs
IExpeHUgDQo+IDxsaXh1LnpoYW5nQGludGVsLmNvbT47IEJhLCBOYWp1bW9uIDxuYWp1bW9uLmJh
QGludGVsLmNvbT47IA0KPiBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gSElEOiBpbnRlbC1pc2gt
aGlkOiBpcGM6IFJld29yayBFSEwgT09CIHdha2V1cA0KPg0KPiBIaSBFdmVuLA0KPg0KPiBPbiBU
aHUsIDIwMjMtMDktMTQgYXQgMTI6MTggKzA4MDAsIEthaS1IZW5nIEZlbmcgd3JvdGU6DQo+ID4g
U3lzdGVtIGNhbm5vdCBzdXNwZW5kIG1vcmUgdGhhbiAyNTUgdGltZXMgYmVjYXVzZSB0aGUgZHJp
dmVyIGRvZXNuJ3QgDQo+ID4gaGF2ZSBjb3JyZXNwb25kaW5nIGFjcGlfZGlzYWJsZV9ncGUoKSBm
b3IgYWNwaV9lbmFibGVfZ3BlKCksIHNvIHRoZSANCj4gPiBHUEUgcmVmY291bnQgb3ZlcmZsb3dz
Lg0KPiA+DQo+ID4gU2luY2UgUENJIGNvcmUgYW5kIEFDUEkgY29yZSBhbHJlYWR5IGhhbmRsZXMg
UENJIFBNRSB3YWtlIGFuZCBHUEUgDQo+ID4gd2FrZSB3aGVuIHRoZSBkZXZpY2UgaGFzIHdha2V1
cCBjYXBhYmlsaXR5LCB1c2UgZGV2aWNlX2luaXRfd2FrZXVwKCkgDQo+ID4gdG8gbGV0IHRoZW0g
ZG8gdGhlIHdha2V1cCBzZXR0aW5nIHdvcmsuDQo+ID4NCj4gPiBBbHNvIGFkZCBhIHNodXRkb3du
IGNhbGxiYWNrIHdoaWNoIHVzZXMgcGNpX3ByZXBhcmVfdG9fc2xlZXAoKSB0byANCj4gPiBsZXQg
UENJIGFuZCBBQ1BJIHNldCBPT0Igd2FrZXVwIGZvciBTNS4NCj4gPg0KPiBQbGVhc2UgdGVzdCB0
aGlzIGNoYW5nZS4NCj4NCj4gVGhhbmtzLA0KPiBTcmluaXZhcw0KPg0KPiA+IEZpeGVzOiAyZTIz
YTcwZWRhYmUgKCJISUQ6IGludGVsLWlzaC1oaWQ6IGlwYzogZmluaXNoIHBvd2VyIGZsb3cgZm9y
IA0KPiA+IEVITCBPT0IiKQ0KPiA+IENjOiBKaWFuIEh1aSBMZWUgPGppYW5odWkubGVlQGNhbm9u
aWNhbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FpLUhlbmcgRmVuZyA8a2FpLmhlbmcuZmVu
Z0BjYW5vbmljYWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlk
L2lwYy9wY2ktaXNoLmMgfCA1OQ0KPiA+ICsrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDQ0IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL3BjaS1p
c2guYw0KPiA+IGIvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pcGMvcGNpLWlzaC5jDQo+ID4g
aW5kZXggNTVjYjI1MDM4ZTYzLi42NWU3ZWViMmZhNjQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9oaWQvaW50ZWwtaXNoLWhpZC9pcGMvcGNpLWlzaC5jDQo+ID4gKysrIGIvZHJpdmVycy9oaWQv
aW50ZWwtaXNoLWhpZC9pcGMvcGNpLWlzaC5jDQo+ID4gQEAgLTExOSw0MiArMTE5LDYgQEAgc3Rh
dGljIGlubGluZSBib29sIGlzaF9zaG91bGRfbGVhdmVfZDBpMyhzdHJ1Y3QgDQo+ID4gcGNpX2Rl
diAqcGRldikNCj4gPiAgICAgICAgIHJldHVybiAhcG1fcmVzdW1lX3ZpYV9maXJtd2FyZSgpIHx8
IHBkZXYtPmRldmljZSA9PSANCj4gPiBDSFZfREVWSUNFX0lEOyAgfQ0KPiA+DQo+ID4gLXN0YXRp
YyBpbnQgZW5hYmxlX2dwZShzdHJ1Y3QgZGV2aWNlICpkZXYpIC17IC0jaWZkZWYgQ09ORklHX0FD
UEkNCj4gPiAtICAgICAgIGFjcGlfc3RhdHVzIGFjcGlfc3RzOw0KPiA+IC0gICAgICAgc3RydWN0
IGFjcGlfZGV2aWNlICphZGV2Ow0KPiA+IC0gICAgICAgc3RydWN0IGFjcGlfZGV2aWNlX3dha2V1
cCAqd2FrZXVwOw0KPiA+IC0NCj4gPiAtICAgICAgIGFkZXYgPSBBQ1BJX0NPTVBBTklPTihkZXYp
Ow0KPiA+IC0gICAgICAgaWYgKCFhZGV2KSB7DQo+ID4gLSAgICAgICAgICAgICAgIGRldl9lcnIo
ZGV2LCAiZ2V0IGFjcGkgaGFuZGxlIGZhaWxlZFxuIik7DQo+ID4gLSAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PREVWOw0KPiA+IC0gICAgICAgfQ0KPiA+IC0gICAgICAgd2FrZXVwID0gJmFkZXYt
Pndha2V1cDsNCj4gPiAtDQo+ID4gLSAgICAgICBhY3BpX3N0cyA9IGFjcGlfZW5hYmxlX2dwZSh3
YWtldXAtPmdwZV9kZXZpY2UsIHdha2V1cC0NCj4gPiA+Z3BlX251bWJlcik7DQo+ID4gLSAgICAg
ICBpZiAoQUNQSV9GQUlMVVJFKGFjcGlfc3RzKSkgew0KPiA+IC0gICAgICAgICAgICAgICBkZXZf
ZXJyKGRldiwgImVuYWJsZSBvc2VfZ3BlIGZhaWxlZFxuIik7DQo+ID4gLSAgICAgICAgICAgICAg
IHJldHVybiAtRUlPOw0KPiA+IC0gICAgICAgfQ0KPiA+IC0NCj4gPiAtICAgICAgIHJldHVybiAw
Ow0KPiA+IC0jZWxzZQ0KPiA+IC0gICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gLSNlbmRpZg0K
PiA+IC19DQo+ID4gLQ0KPiA+IC1zdGF0aWMgdm9pZCBlbmFibGVfcG1lX3dha2Uoc3RydWN0IHBj
aV9kZXYgKnBkZXYpIC17DQo+ID4gLSAgICAgICBpZiAoKHBjaV9wbWVfY2FwYWJsZShwZGV2LCBQ
Q0lfRDApIHx8DQo+ID4gLSAgICAgICAgICAgIHBjaV9wbWVfY2FwYWJsZShwZGV2LCBQQ0lfRDNo
b3QpIHx8DQo+ID4gLSAgICAgICAgICAgIHBjaV9wbWVfY2FwYWJsZShwZGV2LCBQQ0lfRDNjb2xk
KSkgJiYgIWVuYWJsZV9ncGUoJnBkZXYtDQo+ID4gPmRldikpIHsNCj4gPiAtICAgICAgICAgICAg
ICAgcGNpX3BtZV9hY3RpdmUocGRldiwgdHJ1ZSk7DQo+ID4gLSAgICAgICAgICAgICAgIGRldl9k
YmcoJnBkZXYtPmRldiwgImlzaCBpcGMgZHJpdmVyIHBtZSB3YWtlDQo+ID4gZW5hYmxlZFxuIik7
DQo+ID4gLSAgICAgICB9DQo+ID4gLX0NCj4gPiAtDQo+ID4gIC8qKg0KPiA+ICAgKiBpc2hfcHJv
YmUoKSAtIFBDSSBkcml2ZXIgcHJvYmUgY2FsbGJhY2sNCj4gPiAgICogQHBkZXY6ICAgICAgcGNp
IGRldmljZQ0KPiA+IEBAIC0yMjUsNyArMTg5LDcgQEAgc3RhdGljIGludCBpc2hfcHJvYmUoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IA0KPiA+IHN0cnVjdCBwY2lfZGV2aWNlX2lkICplbnQp
DQo+ID4NCj4gPiAgICAgICAgIC8qIEVuYWJsZSBQTUUgZm9yIEVITCAqLw0KPiA+ICAgICAgICAg
aWYgKHBkZXYtPmRldmljZSA9PSBFSExfQXhfREVWSUNFX0lEKQ0KPiA+IC0gICAgICAgICAgICAg
ICBlbmFibGVfcG1lX3dha2UocGRldik7DQo+ID4gKyAgICAgICAgICAgICAgIGRldmljZV9pbml0
X3dha2V1cChkZXYsIHRydWUpOw0KPiA+DQo+ID4gICAgICAgICByZXQgPSBpc2hfaW5pdChpc2h0
cCk7DQo+ID4gICAgICAgICBpZiAocmV0KQ0KPiA+IEBAIC0yNDgsNiArMjEyLDE5IEBAIHN0YXRp
YyB2b2lkIGlzaF9yZW1vdmUoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4gICAgICAgICBpc2hf
ZGV2aWNlX2Rpc2FibGUoaXNodHBfZGV2KTsgIH0NCj4gPg0KPiA+ICsNCj4gPiArLyoqDQo+ID4g
KyAqIGlzaF9zaHV0ZG93bigpIC0gUENJIGRyaXZlciBzaHV0ZG93biBjYWxsYmFjaw0KPiA+ICsg
KiBAcGRldjogICAgICBwY2kgZGV2aWNlDQo+ID4gKyAqDQo+ID4gKyAqIFRoaXMgZnVuY3Rpb24g
c2V0cyB1cCB3YWtldXAgZm9yIFM1ICAqLyBzdGF0aWMgdm9pZCANCj4gPiAraXNoX3NodXRkb3du
KHN0cnVjdCBwY2lfZGV2ICpwZGV2KSB7DQo+ID4gKyAgICAgICBpZiAocGRldi0+ZGV2aWNlID09
IEVITF9BeF9ERVZJQ0VfSUQpDQo+ID4gKyAgICAgICAgICAgICAgIHBjaV9wcmVwYXJlX3RvX3Ns
ZWVwKHBkZXYpOyB9DQo+ID4gKw0KPiA+ICBzdGF0aWMgc3RydWN0IGRldmljZSBfX21heWJlX3Vu
dXNlZCAqaXNoX3Jlc3VtZV9kZXZpY2U7DQo+ID4NCj4gPiAgLyogNTBtcyB0byBnZXQgcmVzdW1l
IHJlc3BvbnNlICovDQo+ID4gQEAgLTM3MCwxMyArMzQ3LDYgQEAgc3RhdGljIGludCBfX21heWJl
X3VudXNlZCBpc2hfcmVzdW1lKHN0cnVjdCANCj4gPiBkZXZpY2UgKmRldmljZSkNCj4gPiAgICAg
ICAgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXZpY2UpOw0KPiA+ICAgICAg
ICAgc3RydWN0IGlzaHRwX2RldmljZSAqZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+
DQo+ID4gLSAgICAgICAvKiBhZGQgdGhpcyB0byBmaW5pc2ggcG93ZXIgZmxvdyBmb3IgRUhMICov
DQo+ID4gLSAgICAgICBpZiAoZGV2LT5wZGV2LT5kZXZpY2UgPT0gRUhMX0F4X0RFVklDRV9JRCkg
ew0KPiA+IC0gICAgICAgICAgICAgICBwY2lfc2V0X3Bvd2VyX3N0YXRlKHBkZXYsIFBDSV9EMCk7
DQo+ID4gLSAgICAgICAgICAgICAgIGVuYWJsZV9wbWVfd2FrZShwZGV2KTsNCj4gPiAtICAgICAg
ICAgICAgICAgZGV2X2RiZyhkZXYtPmRldmMsICJzZXQgcG93ZXIgc3RhdGUgdG8gRDAgZm9yIGVo
bFxuIik7DQo+ID4gLSAgICAgICB9DQo+ID4gLQ0KPiA+ICAgICAgICAgaXNoX3Jlc3VtZV9kZXZp
Y2UgPSBkZXZpY2U7DQo+ID4gICAgICAgICBkZXYtPnJlc3VtZV9mbGFnID0gMTsNCj4gPg0KPiA+
IEBAIC0zOTIsNiArMzYyLDcgQEAgc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVyIGlzaF9kcml2ZXIg
PSB7DQo+ID4gICAgICAgICAuaWRfdGFibGUgPSBpc2hfcGNpX3RibCwNCj4gPiAgICAgICAgIC5w
cm9iZSA9IGlzaF9wcm9iZSwNCj4gPiAgICAgICAgIC5yZW1vdmUgPSBpc2hfcmVtb3ZlLA0KPiA+
ICsgICAgICAgLnNodXRkb3duID0gaXNoX3NodXRkb3duLA0KPiA+ICAgICAgICAgLmRyaXZlci5w
bSA9ICZpc2hfcG1fb3BzLA0KPiA+ICB9Ow0KPiA+DQo+DQo=
