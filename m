Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4377A1757
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 09:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjIOH0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 03:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjIOH0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 03:26:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6685A1BDC;
        Fri, 15 Sep 2023 00:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694762794; x=1726298794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1A8W5P/4pgfyyZnQvA5d0n7U7YInZTVf1OxtVFTtmQk=;
  b=LUSeqirkNQ8S7plZo9sb3Ql7GzzGuG9umMTu9zDxcqObmOgtLEJDwjtW
   rkk+9lAUzyy43kbZy5uql6oXmOXpwkQ8p7oTolUOG8j9gE7REw34/Kp0B
   8tzONRVF2s1kXtWYChWvJK9c7TwXcWWEqY95T+cVXPgjyhj/uZXrECzWl
   /s1ZQqKGkelxxgVreKZPuYBUwXB70eHoNpuFctfVGDL6ObeoL61mN2Q8z
   wC0C8brCJ5QI4J8K/4YGtQVbBrysVPVSokvgJT7oenjATnyWkQXDA37FP
   1qdRHTysqA7JN9VgrCaltrr0Djy0ODmqVI0Q38hS+Kr62unyVcl/ufGFy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359442086"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="359442086"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 00:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="835097141"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="835097141"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 00:26:33 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 00:26:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 00:26:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 00:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPjYy1TK/Ic8LS+ELY+AaVvhdGrzv9bhUpmV8mQsTmSnLNWXEnGNZF3Uqo6kbfKDXCAK33/9edgbif91lDljeh896T5SeFl7+BjPcIB4NaLgxrwGbunvtw8EOgNX7aKY3r7EC4EJpPqt8LbzWWsQPABl4riZ1NYFVRbZICkDS9ii6/3bvYUgwKjBjVAN0w1EUnd6EUOWKfPV+aZZnV9QaCT26dUVBqEybzpXd5u0SYBMvatpqw0Twk3l7c7vNqPYcKlVlxnrcwU3qg6Fi0eNzwQF8szJBJCqULMP384Y4l0XqOp30OhKBFyRmUbz/KGH/7Mw/pBUhySi4fC//LDqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1A8W5P/4pgfyyZnQvA5d0n7U7YInZTVf1OxtVFTtmQk=;
 b=PAbRrxQGttH/63PjO2N8YrMPsQRzaFc1N0+/3A/+FoETupWHgFOS/bFJoy8zdbBwHRwzwPExB+bWYtaZnj2JRNrkPM9G6DYskvsx6iyv2EYJZLdjHl5yp2SIlNQL0lCmnU2ffj7GCKpGrhbJZzhymqRncP0SstOTl02Tl2io+Wf2QE0BEK1QFg6YElcdVs1PSLgVa8pTBS/whb6Jvxuc1JuXqokCXM1xlgSexl6Se9KeD8iS5Q/KMfaEvLL1juio22eRLwsIJDjCTWxFP65yn0Pwlf77KkJGt5BvLYk8VXyvenLfFUrPgedhBeW0mm3NXXiyNpT7fH7MTtAt7L5RpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB2624.namprd11.prod.outlook.com (2603:10b6:805:64::14)
 by SJ0PR11MB4814.namprd11.prod.outlook.com (2603:10b6:a03:2d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 07:26:31 +0000
Received: from SN6PR11MB2624.namprd11.prod.outlook.com
 ([fe80::ab1a:364e:5c0:430b]) by SN6PR11MB2624.namprd11.prod.outlook.com
 ([fe80::ab1a:364e:5c0:430b%7]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 07:26:31 +0000
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
Thread-Index: AQHZ5sKmjsJQWHkOtEGLHUKsvcaerrAafreAgAC8T9CAACtvgIAAFvPA
Date:   Fri, 15 Sep 2023 07:26:30 +0000
Message-ID: <SN6PR11MB262473E2BF4057F4D285A613F4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
References: <20230914041806.816741-1-kai.heng.feng@canonical.com>
 <7b45ac2ed091497b4e21a6a5c19956161175ba16.camel@linux.intel.com>
 <SN6PR11MB26245C44E84C37C1B551260EF4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
 <CAAd53p5ywMVKWzhn0nYzvBnW_Bc=sntgBttJdcVUuf_a4AnX5w@mail.gmail.com>
In-Reply-To: <CAAd53p5ywMVKWzhn0nYzvBnW_Bc=sntgBttJdcVUuf_a4AnX5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2624:EE_|SJ0PR11MB4814:EE_
x-ms-office365-filtering-correlation-id: 9cb61fed-f65f-49d5-3e38-08dbb5bd1516
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fb4waGF6GdEZ4uHoM/MEOqSINvoIkAFOr8mY9CF6bzN1SsHo5JYg0+CgKJpsPoSI8r96tTV1S8iAm89UytSwtoN0zgtAaFg+6gNMys9JqmrEnc6NeqfgCvNW3Sj4ZcBZxfaMl2AAiOR4rfSzRvm+6HYZ7opQniM+JPKnJy/OXLk5vLgMX14Sxy5j5ViAYPllc0LKTEbIPLx4ERfpdnMeOE9DZHVxACD568cpt1g1N4dAwRyLoAZJJugwVUGz/m9mndlt0Ik+uUVQ5N+gi/8YRvekDgPTeaaxCWdEH2ryOwDiZORGVeyKGmOlSjS3ui962Mjkwes2r4dfI+LVyKV3OiCKy0dFI77YOFogwQr53SklwSK4NLIoiURKbh/M0AR9Br5IuUXQsR8PdWHtM2gH7W4HjeXWJBK/elURsJ/j1jcRl8oBEzgsf7AM7JMxpRv4y7aBdk8KqkgtvrxuH+AFqXa96+HMmNh8KDqO64NXBBuAEVCm9yOMUOTlPJdKHZSIL/0thIB0N1t0bQXgTHzxK7wrCMUwqrfmmhYGEGAl+35KM4FU1xd3JcpLvuIEc85qOY+ebFfjO+EktYI/TlcNAgI5sl0sjM/3CMo1QWKnz/gMobY2axnBrTBVdjb45jUF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(186009)(1800799009)(451199024)(52536014)(33656002)(5660300002)(122000001)(64756008)(55016003)(316002)(478600001)(4326008)(82960400001)(8676002)(71200400001)(8936002)(38100700002)(38070700005)(2906002)(53546011)(9686003)(6506007)(7696005)(76116006)(66446008)(66476007)(66946007)(66556008)(54906003)(6916009)(41300700001)(86362001)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2h5V2I1dGdDVWpVM1JyK1Urbi9EWllCUHJWWEU2Zld4WDc1M1YzelczeFQ2?=
 =?utf-8?B?c1F2MGwrNHNXVFJHdzd1bVRLcVA5bTk4R000aDYrU081bm5iNlgrdGRrbzB2?=
 =?utf-8?B?M3NsRmZqS3MzSk8wT2l5SlViSnVVMmxGVjNXczdZVy9acW9FYkFXd04rUU5x?=
 =?utf-8?B?cUhiVFZmN21ablBoRVZYa2E5MGh4OVVXbjJzNkY5R2dsSWZTU082K1JJVGJ5?=
 =?utf-8?B?MmpvQ1FEVU1UTzREM3AvTWxaTjRDMXVVVWx3VzljS3VHUW5WUmY1OTZDYzND?=
 =?utf-8?B?WEU1TjBCd0IwZHJqcFllbTlJYUU1ck9BcmJiWE1ic0d5WEkvTHh1MlRYQ1Fj?=
 =?utf-8?B?VVRpcXFEM2p1RmlVbFJJU1dYU0JVRkRrSjl5UnJCZXRFVnRpVzFEanJYdEts?=
 =?utf-8?B?N2RUSU8vZUk2MFI4TW1uLy9uOEozRXVSNmdUaEtNbzBEbGF0K1drQjAraEFz?=
 =?utf-8?B?V3dSandEOExsNGlQdmxIRzRWTG9rcTQyYzZNbG9FOHpEQXhRblJhUDM3ZGxm?=
 =?utf-8?B?aTcvMG91Y09ldzFZVUNkTjRxajFCNUY5WmZoUk1nVXFYSU9rYTdCOEpoTE5w?=
 =?utf-8?B?ZGVBMnRGQjRzd2ordUc3REhXSFJESVpCKzU1WjdMdXlyWFF3dU00ODBFUVY3?=
 =?utf-8?B?M3BHMFh2Mlk1TVAwM051L1UvQWpDWXBmUlVJVUUya2NXWERyKy9xalprT3B0?=
 =?utf-8?B?MW5rdldYRjIvekNYMjYrVTJTayttUFBaQzNoclJjdWs5WE1TSXpxbmxUSHdu?=
 =?utf-8?B?L21WYlFMSU5CSGV0WDZPbVQzTmpGYWQvdHFUcUpHa2ZVcXd4cFNIZ1N5MEtZ?=
 =?utf-8?B?VEhETE1nMVg3cER1cnJYL0NZWnh5OVd4ekNaeE1LdlEyeVBPa1lGZWRyaFRD?=
 =?utf-8?B?ZEh2S3Y3ZTduVWFyODNsWXp5TmxPTmJyc2NhTTIwTzhTeTU2SjcwaDRDd1ZV?=
 =?utf-8?B?TEFRV0xVZU1aajlRMVBmeDRXVUl5YkZLaktKblJXZ1FYL3lyR1NqL3RSdGIw?=
 =?utf-8?B?NWZXcFR5QjNhd3RDaWo4TkxGb1crMnhqUDhoaGJJSWRYZVNhU1F0R2RtdW9H?=
 =?utf-8?B?dWpwUlZuK2lmR0UybU9DNHI1VUpBT0MyQk1qYisybEwyMHdzYWpOK2trL3lw?=
 =?utf-8?B?NDlNOXptdTFwc2VTRmhhR3VkcmFoQUxEUjBOVzlIY0Jvc3VUcTBmZnB1Wllh?=
 =?utf-8?B?a2c3SnRJOVZod2U0MFJVVDJ3NWw4ck5idWFoUXN6V2ZLajlYQ3MwTFk1eGph?=
 =?utf-8?B?cUgxaDhMUWRTeFdSK2NGcUcwQ0lJbm90YVZscXFGU3pGNTd1UVBvME9CWmZ4?=
 =?utf-8?B?cVp4VHp5c3JFL3lodEN3WUNuTUJOZmhkWEV3NFFpaW1wRWxYYXEzbjlnUnBX?=
 =?utf-8?B?dzgrcW5HUHdoeEtVT1RIQlBiMjBFS0xQZTJKenlzeTQ2MGcyWUlqTHBoMUsw?=
 =?utf-8?B?VDVCZFQvSTZWcUNWN0pEWWVXNW9lSWhCUEE5Y05TaGV3emszcHRtVGdIazUv?=
 =?utf-8?B?QTZDdGlRM09CbStvNEZydndHVStIQzJDZEtKOE01MUVEd3IxOXVQU1NGODFU?=
 =?utf-8?B?Q2ZjREM2NXFOUkNkdTd1c0FHMFQwNkRvdVI4ajBJQXNDZmhjUFVtdmZ0MVNv?=
 =?utf-8?B?bEcvWGpSVWwrU0U3WWwxVDFYejFqblZpZjlva0xZWWowb1VRZk9KQlUrQmE0?=
 =?utf-8?B?UldUc2c5TnNLK2t3SUFVSzdsdnJPMlI3eE1vK1VhRDlTNmhqcFY2QWtjUWF4?=
 =?utf-8?B?OTNlQzhmUUJpb2pJZjNDK1JxWVRzSUFNOU9jdHpvZnl2ZHdMNzhlYmluc3RY?=
 =?utf-8?B?NTFRK0FIdzZoamorRXRiUTYrSEZhS2Iydm5jQkcyc0dNakxLOWkwb0c4MmI0?=
 =?utf-8?B?K3piMW5GdDBQdHdVWXF2Umx6YUFMbkdGNWZQamhXUHpuUHJPNFdrT0pRbGtC?=
 =?utf-8?B?cFd6N1NuUDRSbG1Fb1BzSXJ1Vk0waVc5ZzEvcWNrZ1VLM1Bxek1SRjREZXJR?=
 =?utf-8?B?MEdDMDFQYXVtY0tmY08vQlZSYk4rZmhsUzJyTlJTOTZjeGdEekF4L0RYZ1Zh?=
 =?utf-8?B?NGdTM0VkRHNvcDFvelNyd0VYUHZwTUNFN3ZDTTdCMUxldHNLcjBPUXgwRmpD?=
 =?utf-8?Q?LJQU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb61fed-f65f-49d5-3e38-08dbb5bd1516
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 07:26:30.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNv3YQ0qkOLJ5WDRDaa5t0rPysqbfCGSZMa0K1yZEmOGops0PGsHzAGt3T8vd9u1QGGbjR2OskSlQjDVbum3SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4814
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksIEthaS1IZW5nLA0KDQpJIGFtIGFsc28gbm90IGZhbWlsaWFyIHdpdGggdGhpcyBTNSB3YWtl
dXAgdGVzdCBjYXNlLg0KSSBhbHJlYWR5IHNlbnQgb3V0IG1haWxzIHRvIGFzayBmb3IgaGVscCBv
biBpdC4NCldpbGwgY29tZSBiYWNrIHRvIHlvdSBvbmNlIEkgZ2V0IGZlZWRiYWNrLg0KVGhhbmtz
IQ0KDQpCZXN0IFJlZ2FyZHMsDQpFdmVuIFh1DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNhbm9uaWNhbC5jb20+IA0KU2Vu
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjMgMjowMSBQTQ0KVG86IFh1LCBFdmVuIDxldmVu
Lnh1QGludGVsLmNvbT4NCkNjOiBzcmluaXZhcyBwYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT47IGppa29zQGtlcm5lbC5vcmc7IGJlbmphbWluLnRpc3NvaXJl
c0ByZWRoYXQuY29tOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7IExlZSwgSmlhbiBIdWkgPGppYW5odWkubGVlQGNhbm9uaWNhbC5jb20+OyBaaGFu
ZywgTGl4dSA8bGl4dS56aGFuZ0BpbnRlbC5jb20+OyBCYSwgTmFqdW1vbiA8bmFqdW1vbi5iYUBp
bnRlbC5jb20+OyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIEhJRDogaW50ZWwtaXNoLWhpZDogaXBj
OiBSZXdvcmsgRUhMIE9PQiB3YWtldXANCg0KSGkgRXZlbiwNCg0KT24gRnJpLCBTZXAgMTUsIDIw
MjMgYXQgMTozMeKAr1BNIFh1LCBFdmVuIDxldmVuLnh1QGludGVsLmNvbT4gd3JvdGU6DQo+DQo+
IEhpLCBTcmluaXZhcywNCj4NCj4gU3VyZSwgSSB3aWxsIHRlc3QgaXQuDQo+IEFzIGxvbmcgdGVy
bSBub3Qgd29ya2luZyBvbiBFSEwsIEkgZG9lc24ndCBoYXZlIEVITCBib2FyZCBvbiBoYW5kIHJp
Z2h0IG5vdywgSSBjYW4gdGVzdCB0aGlzIHBhdGNoIG9uIG90aGVyIElTSCByZWxhdGVkIHBsYXRm
b3Jtcy4NCj4gRnJvbSB0aGUgcGF0Y2gsIGl0J3MgZm9jdXMgb24gRUhMIHBsYXRmb3JtLCBJIGFz
c3VtZSBLYWktSGVuZyBhbHJlYWR5IHZlcmlmaWVkIHRoZSBmdW5jdGlvbiBvbiBFSEwgYm9hcmQu
DQoNCkkgb25seSBtYWRlIHN1cmUgdGhlIEdQRSBvdmVyZmxvdyBpc3N1ZSBpcyBmaXhlZCBieSB0
aGUgcGF0Y2gsIGJ1dCBJIGRpZG4ndCB0ZXN0IHRoZSBTNSB3YWtldXAuDQpUaGF0J3MgYmVjYXVz
ZSBJIGRvbid0IGtub3cgaG93IHRvIHRlc3QgaXQgb24gdGhlIEVITCBzeXN0ZW0gSSBoYXZlLg0K
SSdsbCB0ZXN0IGl0IGlmIHlvdSBjYW4gbGV0IG1lIGtub3cgaG93IHRvIHRlc3QgdGhlIFM1IHdh
a2V1cC4NCg0KS2FpLUhlbmcNCg0KPiBJIGRvbid0IHRoaW5rIGl0IHdpbGwgdGFrZSBlZmZlY3Qg
b24gb3RoZXIgcGxhdGZvcm1zLCBhbnl3YXksIEkgd2lsbCB0ZXN0IGl0IG9uIHRoZSBwbGF0Zm9y
bXMgSSBoYXZlIHRvIHByb3ZpZGUgY3Jvc3MgcGxhdGZvcm0gdmVyaWZpY2F0aW9uLg0KPg0KPiBU
aGFua3MhDQo+DQo+IEJlc3QgUmVnYXJkcywNCj4gRXZlbiBYdQ0KPg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzcmluaXZhcyBwYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5k
cnV2YWRhQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMTUsIDIw
MjMgMTI6MTEgQU0NCj4gVG86IEthaS1IZW5nIEZlbmcgPGthaS5oZW5nLmZlbmdAY2Fub25pY2Fs
LmNvbT47IGppa29zQGtlcm5lbC5vcmc7IA0KPiBiZW5qYW1pbi50aXNzb2lyZXNAcmVkaGF0LmNv
bQ0KPiBDYzogbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOyBMZWUsIEppYW4gSHVpIA0KPiA8amlhbmh1aS5sZWVAY2Fub25pY2FsLmNvbT47IFh1LCBF
dmVuIDxldmVuLnh1QGludGVsLmNvbT47IFpoYW5nLCBMaXh1IA0KPiA8bGl4dS56aGFuZ0BpbnRl
bC5jb20+OyBCYSwgTmFqdW1vbiA8bmFqdW1vbi5iYUBpbnRlbC5jb20+OyANCj4gbGludXgtaW5w
dXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIEhJRDogaW50ZWwtaXNoLWhpZDogaXBjOiBSZXdvcmsgRUhMIE9PQiB3
YWtldXANCj4NCj4gSGkgRXZlbiwNCj4NCj4gT24gVGh1LCAyMDIzLTA5LTE0IGF0IDEyOjE4ICsw
ODAwLCBLYWktSGVuZyBGZW5nIHdyb3RlOg0KPiA+IFN5c3RlbSBjYW5ub3Qgc3VzcGVuZCBtb3Jl
IHRoYW4gMjU1IHRpbWVzIGJlY2F1c2UgdGhlIGRyaXZlciBkb2Vzbid0IA0KPiA+IGhhdmUgY29y
cmVzcG9uZGluZyBhY3BpX2Rpc2FibGVfZ3BlKCkgZm9yIGFjcGlfZW5hYmxlX2dwZSgpLCBzbyB0
aGUgDQo+ID4gR1BFIHJlZmNvdW50IG92ZXJmbG93cy4NCj4gPg0KPiA+IFNpbmNlIFBDSSBjb3Jl
IGFuZCBBQ1BJIGNvcmUgYWxyZWFkeSBoYW5kbGVzIFBDSSBQTUUgd2FrZSBhbmQgR1BFIA0KPiA+
IHdha2Ugd2hlbiB0aGUgZGV2aWNlIGhhcyB3YWtldXAgY2FwYWJpbGl0eSwgdXNlIGRldmljZV9p
bml0X3dha2V1cCgpIA0KPiA+IHRvIGxldCB0aGVtIGRvIHRoZSB3YWtldXAgc2V0dGluZyB3b3Jr
Lg0KPiA+DQo+ID4gQWxzbyBhZGQgYSBzaHV0ZG93biBjYWxsYmFjayB3aGljaCB1c2VzIHBjaV9w
cmVwYXJlX3RvX3NsZWVwKCkgdG8gDQo+ID4gbGV0IFBDSSBhbmQgQUNQSSBzZXQgT09CIHdha2V1
cCBmb3IgUzUuDQo+ID4NCj4gUGxlYXNlIHRlc3QgdGhpcyBjaGFuZ2UuDQo+DQo+IFRoYW5rcywN
Cj4gU3Jpbml2YXMNCj4NCj4gPiBGaXhlczogMmUyM2E3MGVkYWJlICgiSElEOiBpbnRlbC1pc2gt
aGlkOiBpcGM6IGZpbmlzaCBwb3dlciBmbG93IGZvciANCj4gPiBFSEwgT09CIikNCj4gPiBDYzog
SmlhbiBIdWkgTGVlIDxqaWFuaHVpLmxlZUBjYW5vbmljYWwuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEthaS1IZW5nIEZlbmcgPGthaS5oZW5nLmZlbmdAY2Fub25pY2FsLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pcGMvcGNpLWlzaC5jIHwgNTkgDQo+ID4g
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gPiAtLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTUg
aW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pcGMvcGNpLWlzaC5jDQo+ID4gYi9kcml2ZXJzL2hpZC9p
bnRlbC1pc2gtaGlkL2lwYy9wY2ktaXNoLmMNCj4gPiBpbmRleCA1NWNiMjUwMzhlNjMuLjY1ZTdl
ZWIyZmE2NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlkL2lwYy9w
Y2ktaXNoLmMNCj4gPiArKysgYi9kcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlkL2lwYy9wY2ktaXNo
LmMNCj4gPiBAQCAtMTE5LDQyICsxMTksNiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNoX3Nob3Vs
ZF9sZWF2ZV9kMGkzKHN0cnVjdCANCj4gPiBwY2lfZGV2ICpwZGV2KQ0KPiA+ICAgICAgICAgcmV0
dXJuICFwbV9yZXN1bWVfdmlhX2Zpcm13YXJlKCkgfHwgcGRldi0+ZGV2aWNlID09IA0KPiA+IENI
Vl9ERVZJQ0VfSUQ7ICB9DQo+ID4NCj4gPiAtc3RhdGljIGludCBlbmFibGVfZ3BlKHN0cnVjdCBk
ZXZpY2UgKmRldikgLXsgLSNpZmRlZiBDT05GSUdfQUNQSQ0KPiA+IC0gICAgICAgYWNwaV9zdGF0
dXMgYWNwaV9zdHM7DQo+ID4gLSAgICAgICBzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXY7DQo+ID4g
LSAgICAgICBzdHJ1Y3QgYWNwaV9kZXZpY2Vfd2FrZXVwICp3YWtldXA7DQo+ID4gLQ0KPiA+IC0g
ICAgICAgYWRldiA9IEFDUElfQ09NUEFOSU9OKGRldik7DQo+ID4gLSAgICAgICBpZiAoIWFkZXYp
IHsNCj4gPiAtICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJnZXQgYWNwaSBoYW5kbGUgZmFp
bGVkXG4iKTsNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gLSAgICAg
ICB9DQo+ID4gLSAgICAgICB3YWtldXAgPSAmYWRldi0+d2FrZXVwOw0KPiA+IC0NCj4gPiAtICAg
ICAgIGFjcGlfc3RzID0gYWNwaV9lbmFibGVfZ3BlKHdha2V1cC0+Z3BlX2RldmljZSwgd2FrZXVw
LQ0KPiA+ID5ncGVfbnVtYmVyKTsNCj4gPiAtICAgICAgIGlmIChBQ1BJX0ZBSUxVUkUoYWNwaV9z
dHMpKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiZW5hYmxlIG9zZV9ncGUg
ZmFpbGVkXG4iKTsNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+ID4gLSAgICAg
ICB9DQo+ID4gLQ0KPiA+IC0gICAgICAgcmV0dXJuIDA7DQo+ID4gLSNlbHNlDQo+ID4gLSAgICAg
ICByZXR1cm4gLUVOT0RFVjsNCj4gPiAtI2VuZGlmDQo+ID4gLX0NCj4gPiAtDQo+ID4gLXN0YXRp
YyB2b2lkIGVuYWJsZV9wbWVfd2FrZShzdHJ1Y3QgcGNpX2RldiAqcGRldikgLXsNCj4gPiAtICAg
ICAgIGlmICgocGNpX3BtZV9jYXBhYmxlKHBkZXYsIFBDSV9EMCkgfHwNCj4gPiAtICAgICAgICAg
ICAgcGNpX3BtZV9jYXBhYmxlKHBkZXYsIFBDSV9EM2hvdCkgfHwNCj4gPiAtICAgICAgICAgICAg
cGNpX3BtZV9jYXBhYmxlKHBkZXYsIFBDSV9EM2NvbGQpKSAmJiAhZW5hYmxlX2dwZSgmcGRldi0N
Cj4gPiA+ZGV2KSkgew0KPiA+IC0gICAgICAgICAgICAgICBwY2lfcG1lX2FjdGl2ZShwZGV2LCB0
cnVlKTsNCj4gPiAtICAgICAgICAgICAgICAgZGV2X2RiZygmcGRldi0+ZGV2LCAiaXNoIGlwYyBk
cml2ZXIgcG1lIHdha2UNCj4gPiBlbmFibGVkXG4iKTsNCj4gPiAtICAgICAgIH0NCj4gPiAtfQ0K
PiA+IC0NCj4gPiAgLyoqDQo+ID4gICAqIGlzaF9wcm9iZSgpIC0gUENJIGRyaXZlciBwcm9iZSBj
YWxsYmFjaw0KPiA+ICAgKiBAcGRldjogICAgICBwY2kgZGV2aWNlDQo+ID4gQEAgLTIyNSw3ICsx
ODksNyBAQCBzdGF0aWMgaW50IGlzaF9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qg
DQo+ID4gc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkNCj4gPg0KPiA+ICAgICAgICAgLyogRW5h
YmxlIFBNRSBmb3IgRUhMICovDQo+ID4gICAgICAgICBpZiAocGRldi0+ZGV2aWNlID09IEVITF9B
eF9ERVZJQ0VfSUQpDQo+ID4gLSAgICAgICAgICAgICAgIGVuYWJsZV9wbWVfd2FrZShwZGV2KTsN
Cj4gPiArICAgICAgICAgICAgICAgZGV2aWNlX2luaXRfd2FrZXVwKGRldiwgdHJ1ZSk7DQo+ID4N
Cj4gPiAgICAgICAgIHJldCA9IGlzaF9pbml0KGlzaHRwKTsNCj4gPiAgICAgICAgIGlmIChyZXQp
DQo+ID4gQEAgLTI0OCw2ICsyMTIsMTkgQEAgc3RhdGljIHZvaWQgaXNoX3JlbW92ZShzdHJ1Y3Qg
cGNpX2RldiAqcGRldikNCj4gPiAgICAgICAgIGlzaF9kZXZpY2VfZGlzYWJsZShpc2h0cF9kZXYp
OyAgfQ0KPiA+DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogaXNoX3NodXRkb3duKCkgLSBQQ0kg
ZHJpdmVyIHNodXRkb3duIGNhbGxiYWNrDQo+ID4gKyAqIEBwZGV2OiAgICAgIHBjaSBkZXZpY2UN
Cj4gPiArICoNCj4gPiArICogVGhpcyBmdW5jdGlvbiBzZXRzIHVwIHdha2V1cCBmb3IgUzUgICov
IHN0YXRpYyB2b2lkIA0KPiA+ICtpc2hfc2h1dGRvd24oc3RydWN0IHBjaV9kZXYgKnBkZXYpIHsN
Cj4gPiArICAgICAgIGlmIChwZGV2LT5kZXZpY2UgPT0gRUhMX0F4X0RFVklDRV9JRCkNCj4gPiAr
ICAgICAgICAgICAgICAgcGNpX3ByZXBhcmVfdG9fc2xlZXAocGRldik7IH0NCj4gPiArDQo+ID4g
IHN0YXRpYyBzdHJ1Y3QgZGV2aWNlIF9fbWF5YmVfdW51c2VkICppc2hfcmVzdW1lX2RldmljZTsN
Cj4gPg0KPiA+ICAvKiA1MG1zIHRvIGdldCByZXN1bWUgcmVzcG9uc2UgKi8NCj4gPiBAQCAtMzcw
LDEzICszNDcsNiBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGlzaF9yZXN1bWUoc3RydWN0
IA0KPiA+IGRldmljZSAqZGV2aWNlKQ0KPiA+ICAgICAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXYg
PSB0b19wY2lfZGV2KGRldmljZSk7DQo+ID4gICAgICAgICBzdHJ1Y3QgaXNodHBfZGV2aWNlICpk
ZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7DQo+ID4NCj4gPiAtICAgICAgIC8qIGFkZCB0aGlz
IHRvIGZpbmlzaCBwb3dlciBmbG93IGZvciBFSEwgKi8NCj4gPiAtICAgICAgIGlmIChkZXYtPnBk
ZXYtPmRldmljZSA9PSBFSExfQXhfREVWSUNFX0lEKSB7DQo+ID4gLSAgICAgICAgICAgICAgIHBj
aV9zZXRfcG93ZXJfc3RhdGUocGRldiwgUENJX0QwKTsNCj4gPiAtICAgICAgICAgICAgICAgZW5h
YmxlX3BtZV93YWtlKHBkZXYpOw0KPiA+IC0gICAgICAgICAgICAgICBkZXZfZGJnKGRldi0+ZGV2
YywgInNldCBwb3dlciBzdGF0ZSB0byBEMCBmb3IgZWhsXG4iKTsNCj4gPiAtICAgICAgIH0NCj4g
PiAtDQo+ID4gICAgICAgICBpc2hfcmVzdW1lX2RldmljZSA9IGRldmljZTsNCj4gPiAgICAgICAg
IGRldi0+cmVzdW1lX2ZsYWcgPSAxOw0KPiA+DQo+ID4gQEAgLTM5Miw2ICszNjIsNyBAQCBzdGF0
aWMgc3RydWN0IHBjaV9kcml2ZXIgaXNoX2RyaXZlciA9IHsNCj4gPiAgICAgICAgIC5pZF90YWJs
ZSA9IGlzaF9wY2lfdGJsLA0KPiA+ICAgICAgICAgLnByb2JlID0gaXNoX3Byb2JlLA0KPiA+ICAg
ICAgICAgLnJlbW92ZSA9IGlzaF9yZW1vdmUsDQo+ID4gKyAgICAgICAuc2h1dGRvd24gPSBpc2hf
c2h1dGRvd24sDQo+ID4gICAgICAgICAuZHJpdmVyLnBtID0gJmlzaF9wbV9vcHMsDQo+ID4gIH07
DQo+ID4NCj4NCg==
