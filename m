Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37942279E60
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 07:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgI0FM2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 01:12:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:48862 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbgI0FM1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 01:12:27 -0400
IronPort-SDR: uibSI+toTIxUceJMzHkZFfJ7uzEql3g80d3ypqKmVRzo3R1o3qEKLxMhbLRQqJa8bY5SYiEczC
 H4cF6E7oIFIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="162735639"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="162735639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 22:12:26 -0700
IronPort-SDR: QL9qkwhSdbphl5cB6rvYJeZ70+p8gO3qsao5mp1wD+szQHQ3iatYJqzpWWWwSN2uArpEmTJ5xf
 CI9AJkyMRcqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="349442097"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2020 22:12:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 26 Sep 2020 22:12:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 26 Sep 2020 22:12:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 26 Sep 2020 22:12:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 26 Sep 2020 22:12:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoIhd9ntgW6cnSxw5oCc3MsFPmCdR/0hn6NylNFjkNLNmYn7aGNTIaIMinvRoI3g9DSk+rSLkTEQHQeZwl77AuoLXUSSHFpS5EjkWxt8/Vyv8lrl8O+0CdYFwGQMKdkzFwJ1B3UBJZY8BnvdJyl3UXgbtcCawc6G8UgeoA4euUecNrQeWgH/fhaZxzyA2txRb6KvB9zfcEDk121BsdQHzF0SyvJfEf/klGLf+PbjnQlpXclBQx6zuagcHqRYKzQ5Unh3S8Tn0O3K3Jh9bwSUNjxoxJbUVOwpMLy+upVl2LwzxMCbrTQeo9Rt1ATWk6QGf/mBtQaFLv42v39p9jhJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUEf8a5scXCgmRrPyerm4vIGM7XaPoFAozQZENt0E6s=;
 b=fVzo65cEBq9HUpu+xz+FtVEP4eC53avsNkHK8RxOfAE++0ocrm0IIHh1T50xY2yg0ndov4Nkrl5Fo/JzrF+Sk8x3zrygMo5mK/kJ5dGu9IAoRMSbco8IaqTM57miRg3Rzv8eRvZAO3AxsOitB7tXnRAjKcSO6mgFU5JAZ0Ecj/mON6Vp5ELG3xXaekh+Ftj54MuyvSfzHhkFePCwvHqz/DFlBnjMrlJ6UeTH2teGacXZY9quhciN3bV1iK0jDTfrnADyYbtlq9lHXR81aaAPujNjD0O6Zhuax0fQVB95Jpvk59/BG7zQQz6GWFrsuBxNWDPDJXkP5ByIHHnN8PeFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUEf8a5scXCgmRrPyerm4vIGM7XaPoFAozQZENt0E6s=;
 b=kKC7Gj7VxhlpF05Dc0jxg2u4GxoJTerfyhoErw+2VGsfXAa3Z94FSU9FhvbgWGfIP8WfLFeiZTYoXABSAvbjSdOQX8+RmJLkFmdlTZyURjXBZWU+m67Yb618RsaUVHHzaHLOdq13RX4zMA7rem3ynFDGqO8a5zUUVL4tVPfPu7A=
Received: from MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23)
 by MWHPR11MB1773.namprd11.prod.outlook.com (2603:10b6:300:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Sun, 27 Sep
 2020 05:12:23 +0000
Received: from MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f]) by MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f%2]) with mapi id 15.20.3412.025; Sun, 27 Sep 2020
 05:12:23 +0000
From:   "Zhao, Haifeng" <haifeng.zhao@intel.com>
To:     Joe Perches <joe@perches.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        "ashok.raj@linux.intel.com" <ashok.raj@linux.intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Subject: RE: [PATCH 4/5 V2] PCI: only return true when dev io state is really
 changed
Thread-Topic: [PATCH 4/5 V2] PCI: only return true when dev io state is really
 changed
Thread-Index: AQHWlH6RY/tM0tjyJ0GGQRBn9ZZuhal74PgAgAAPOSA=
Date:   Sun, 27 Sep 2020 05:12:23 +0000
Message-ID: <MWHPR11MB1696110AAA42CD4AB60ED66297340@MWHPR11MB1696.namprd11.prod.outlook.com>
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
         <20200927032829.11321-5-haifeng.zhao@intel.com>
 <5e22dba6543b4fc09c5c18c839eab42bd31b18f6.camel@perches.com>
In-Reply-To: <5e22dba6543b4fc09c5c18c839eab42bd31b18f6.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efaab65d-adb0-4073-f72b-08d862a3eb27
x-ms-traffictypediagnostic: MWHPR11MB1773:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1773ACC74FE32F43E6C575B097340@MWHPR11MB1773.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BMioF/NdaftLjdgc2goGAhCnMFgg/TFjo0d1nhSsaEEkpSzIIUoXoVcbnGiO7p8orwq/QwyoDuo3YoUc7BzPzQW9yBhv0eEiDIlmbMPg7CJNFrjKVjPVzjPhI/tEP/F7NXONp40Xg+0xk78vP9hjpQ+7hd7csUNxhDhhMo/yBOAUCTZ20BF5uNuYt6lCuBRMT3OkDUp3pPzCyurrFVmHadeZLCou0U+lmC7QnGQ/wEzqkTfUy/s6Ocr11GDoz/peAU04/vVT44IW39Fsll0oQnWakIFLj8HgjqGjiqMeybEh4EgTZeyy6W7k3PgrlDmAYQSwFUNf+HtVONky/U3fOYj03gd9T4h9p0DyDnelKGmAlCQk6SrJkxJyP1rbaQ+Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1696.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(8936002)(66946007)(2906002)(55016002)(478600001)(6506007)(53546011)(4326008)(26005)(7416002)(8676002)(7696005)(9686003)(316002)(186003)(54906003)(110136005)(83380400001)(66476007)(66556008)(64756008)(66446008)(71200400001)(76116006)(52536014)(33656002)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BTgSFhfTo8traZ2DhjdZdGgj8H4u3xXv/PxNNSscs2SxIzarRfBW2EvAwpt/X0Pn240H4JmCEw/cZxvmBYQT+znSOHTdhTkn7r06uEHGWfCvehu+ql77EQlRwAENYOYRpsL5TIolzqUkabv0Q2MhKicuc7SC9xq7dWmP27uIpMm7MdvygKCUaltSydgr0NOAzjSH2QLWA3lxT/3ur8Y9+WJ2zRDkMvuQ/4qkiEtEMcAB+JGvYOPIGawuqAvk/naMNHxWLlHSKnBkY1TUduLPvK67FqoRrDdqbHOqQbsj6VftkbfI9aXM5WqalTdII9mdH3RBSMf451OSB9ONZi1HUSrcDUQeEyAKhqOl2yzJK56lFegGkiIpjr9A6gaCMzmLTJvrTMWrY4MyPLAoCz0LIMUWJ9RYW9U/Nia5YVvDl1EeOZ9pwVnZ78mnikcKxjKHIF2cAkzqVKoKvTkunz2SRL/2mmJl6QJP7T9r5ChqOKTgC5COP1yRU7B0Mw8eWj0Mnrs63EUGC4i4KHeY+WclmlS1QhuWd6yG4oIZz33wcSGadMh7EzgqG9J047kAVn0r4bQYyTbhFCNWuYGOeAHMtDliD6XVSF1YqTE5khCnE2r+7rSKwLtXgmAvtkqIx/xQRlb5S2kI239beQYmJJYg7w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1696.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efaab65d-adb0-4073-f72b-08d862a3eb27
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 05:12:23.5892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFlc4G1BmlMmiSVgrWKsmgfSYPhpB3+skKk/QJjSWDH9d/TGdNNTPRWwZwoswVTu5pqHNliiy9na+Qf7VhlE6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1773
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

8J+YiiAgZGVmaW5pdGVseSBzaW1wbGVyICENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEpvZSBQZXJjaGVzIDxqb2VAcGVyY2hlcy5jb20+IA0KU2VudDogU3VuZGF5LCBTZXB0
ZW1iZXIgMjcsIDIwMjAgMTI6MTcgUE0NClRvOiBaaGFvLCBIYWlmZW5nIDxoYWlmZW5nLnpoYW9A
aW50ZWwuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgb29oYWxsQGdtYWlsLmNvbTsgcnVzY3Vy
QHJ1c3NlbGwuY2M7IGx1a2FzQHd1bm5lci5kZTsgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50
ZWwuY29tOyBzdHVhcnQudy5oYXllc0BnbWFpbC5jb207IG1yLm51a2UubWVAZ21haWwuY29tOyBt
aWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tDQpDYzogbGludXgtcGNpQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSmlhLCBQZWkgUCA8cGVpLnAuamlh
QGludGVsLmNvbT47IGFzaG9rLnJhakBsaW51eC5pbnRlbC5jb207IEt1cHB1c3dhbXksIFNhdGh5
YW5hcmF5YW5hbiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAaW50ZWwuY29tPg0KU3ViamVj
dDogUmU6IFtQQVRDSCA0LzUgVjJdIFBDSTogb25seSByZXR1cm4gdHJ1ZSB3aGVuIGRldiBpbyBz
dGF0ZSBpcyByZWFsbHkgY2hhbmdlZA0KDQpPbiBTYXQsIDIwMjAtMDktMjYgYXQgMjM6MjggLTA0
MDAsIEV0aGFuIFpoYW8gd3JvdGU6DQo+IHNpbXBsaWZ5IHRoZSBwY2lfZGV2X3NldF9pb19zdGF0
ZSgpIGZ1bmN0aW9uIHRvIG9ubHkgcmV0dXJuIHRydWUgd2hlbiANCj4gZGV2LT5lcnJvcl9zdGF0
ZSBpcyBjaGFuZ2VkLg0KW10NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS5oIGIvZHJp
dmVycy9wY2kvcGNpLmgNCltdDQo+IEBAIC0zNjIsMzUgKzM2MiwxMSBAQCBzdGF0aWMgaW5saW5l
IGJvb2wgcGNpX2Rldl9zZXRfaW9fc3RhdGUoc3RydWN0IHBjaV9kZXYgKmRldiwNCj4gIAlib29s
IGNoYW5nZWQgPSBmYWxzZTsNCltdDQo+ICsJaWYgKGRldi0+ZXJyb3Jfc3RhdGUgPT0gbmV3KQ0K
PiArCQlyZXR1cm4gY2hhbmdlZDsNCj4gKw0KPiArCWRldi0+ZXJyb3Jfc3RhdGUgPSBuZXc7DQo+
ICsJY2hhbmdlZCA9IHRydWU7DQo+ICAJcmV0dXJuIGNoYW5nZWQ7DQo+ICB9DQoNClRoaXMgd291
bGQgYmUgc2ltcGxlciByZW1vdmluZyB0aGUgdW5uZWNlc3NhcnkgY2hhbmdlZCBhdXRvbWF0aWMN
Cg0KLi4uDQoNCglpZiAoZGV2LT5lcnJvcl9zdGF0ZSA9PSBuZXcpDQoJCXJldHVybiBmYWxzZTsN
Cg0KCWRldi0+ZXJyb3Jfc3RhdGUgPSBuZXc7DQoNCglyZXR1cm4gdHJ1ZTsNCn0NCg0KDQo=
