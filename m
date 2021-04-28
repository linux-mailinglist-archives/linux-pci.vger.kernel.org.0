Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A620336D059
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 03:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhD1BnA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 21:43:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:4280 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhD1BnA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Apr 2021 21:43:00 -0400
IronPort-SDR: w/DCItA8iKz63h1dKPYyH7LmucsX3/eaDy7OjF2Y9MYfSTzYdwYW6PFFBiKrA18NGUBAGXvWrY
 MiD+XCzgxEzg==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="196186134"
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="196186134"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 18:42:15 -0700
IronPort-SDR: Z6/O1+qS+1me6EvyR8T3/MCKQXN1XfPIix0qQ+Q8Oe55zjCS7YBYh1AiKT+0R/Wr5SJNakUbx4
 +2wK5rv8yJHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="386343726"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 27 Apr 2021 18:42:15 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 27 Apr 2021 18:42:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 27 Apr 2021 18:42:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 27 Apr 2021 18:42:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpukdNZ3lrRyoySZrtmA5Xmvc4sUD2IKTdaKfMSXBuJiixg8G5qORXQkbz8iy7FUtd90dr/ONynJlasx3pH7uV53clc/dP5G2A5hEvTpX1Bnv8xZ/ckN5nzJ2g6IJfcThetU1sA2V8mOTzeSYZYb0hHd1ubkQHXh2QTcSLeGE61WMb1TGufrfY7bFFlxdoimW7Fe4rA1TNe3bAdn6CuxEw28dtmYDjpuPh9Q2vypjTh+HG11raQw1D9JVPUzmktgppSN+Ybpwz4shiqxuy8VTiAzw0/V732sJrEzmWczChyXJBIl0OXGiq2/rcgQ1eeDp/NCH3VQh/MlZRy+gUsA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thRRubsej+AKEOr6khyDWjxpIUTjMt7vYNOOOkGzygU=;
 b=HIMsfrt2tSHHn7F2esLw+rLslK+69wIi3dxpCeRF7vN3+477AugAIGgNhwGmvhDvIXputc3AvprBaCBbIZMXKVYIhViQB8Lw930i0l62IoaI0bfF+UT7AlK3zL+Z5XUf2OloZyl/OUcZj6rBcUg37YIq8heN3IZPcC6fopq+VsycYaA9ZrKMoYDTFTkn04NV1XdIcA7z5ZoWVBY/beUFVMOVeFASEF+uyVru1mupNQ9XWVzyFuZlFRUO3nJLoW86NMOksSVcjOqU5ZRsRTm6wi3KrjMozNVXlJqaA/pG1REm0+X00uBrrrXwi1Cc1LoDavoGiqjhNJkOQxf/SUoneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thRRubsej+AKEOr6khyDWjxpIUTjMt7vYNOOOkGzygU=;
 b=OktOzSo9qWUclJgpG6BmViu1oOPCjYmAKe9ofUj/GwwMJK2C6EO8htgyXQuHEFaEanMRDqFZ+P2k82eVMBKGPsfel6IZEXfFEnQNonx6GSMtc9UxFMPpOV09JGQybPIRxSW0DC7jbDkccUC3v7D07ca399/wvjbWEacjkGjgEpM=
Received: from MWHPR11MB1982.namprd11.prod.outlook.com (2603:10b6:300:10f::22)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 01:42:12 +0000
Received: from MWHPR11MB1982.namprd11.prod.outlook.com
 ([fe80::31af:72e4:2193:8880]) by MWHPR11MB1982.namprd11.prod.outlook.com
 ([fe80::31af:72e4:2193:8880%11]) with mapi id 15.20.4065.027; Wed, 28 Apr
 2021 01:42:12 +0000
From:   "Zhao, Haifeng" <haifeng.zhao@intel.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     Sinan Kaya <okaya@kernel.org>, "Raj, Ashok" <ashok.raj@intel.com>,
        "Keith Busch" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
Thread-Topic: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
Thread-Index: AQHXI6+udlf71UAyWUy6GAXnNNJKcqqdBgSAgCxAkoCAABCL8A==
Date:   Wed, 28 Apr 2021 01:42:12 +0000
Message-ID: <MWHPR11MB1982F7F0B3C1FAB941284C4597409@MWHPR11MB1982.namprd11.prod.outlook.com>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
 <13bbd4f9-dff4-be79-d80a-342399961939@linux.intel.com>
 <c7a09e8d-d2a9-02c9-8ac1-224147bd7827@linux.intel.com>
In-Reply-To: <c7a09e8d-d2a9-02c9-8ac1-224147bd7827@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c9a501c-9353-49f5-416e-08d909e6d820
x-ms-traffictypediagnostic: CO1PR11MB4769:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB47691C188EBA7FAB806BD93597409@CO1PR11MB4769.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N9Ap2heXXJ7u/sWbPngQHrSUZ45FXJlzlh2iYDYONzUjDRYuvGToIIUsTBMjKUuRcrW1l6jgFZFWYwRWYzH7rnX/XJIWAyU4W8VZkAbYQqXYc57j/s9+l+AetKb+oD6kf969QpzYFkuC+790bomWcDa+jgRUXJuSrDguCo2+ajQUx8GElcen7ihPWntF/290/3VxJCSDyiFk5HL+Ewhat6EvmZvahe6vJZZpZt0QtJSio97knrEMXds7hKqakmCseg2x4C1Onwpo+RNtS33O7Myz8ucr66BEBheQ7FhvMg+SnyTCd6Gzo+bIn2KMVvZWqVhc5n6c9p9ziBPTvg+0vKGZqihKx3oQhkofW7OE0Umf/uIuj92tbAF6ytkmYfp2+GKAVpWArhLmFZBjt6fH0WIGeMWnuWYrKpWJuQD5z+gkqArM4YHFaTwQlRQVqqpAu37fM7WwrIrXYGkLPUGcOSCB0loC4IWWcajACPG+XJX96UDIUPqRjtE4PsYfcBzxVMAUMO2yP8REtXlS5mYriRFFE8rGCoJPGE5cBeNzGhxG9o+UQl+BQPNMjoO1gCR1rhFoe3xwbXtBamWaWH4bLi42s7Nd2owIc/lhjBDmC4VDomiieOn8DayQSJ/F+BqodsXSTZSAf36AsofbOKW8r3cbjXrizx1dOrextlBb3G2mylReAQlGBgQn7DaId+Ob
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1982.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(122000001)(8676002)(8936002)(86362001)(7696005)(186003)(7416002)(53546011)(2906002)(64756008)(4326008)(966005)(66476007)(33656002)(66446008)(66556008)(6636002)(66946007)(71200400001)(52536014)(6506007)(55016002)(5660300002)(26005)(83380400001)(110136005)(54906003)(38100700002)(478600001)(316002)(76116006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?K0FxMWgxWHIrdy84UzdZSllXWFNGSFVDMGQ0eW1GbVVpQjhUWHI0eWZWOUlN?=
 =?utf-8?B?VG0rejhyRTRad3J4UEVLSE5rOTZINmRqazk2Y3lvUkx6R096YmkrODArSHVW?=
 =?utf-8?B?OVh6T3d0cmIwTU9vVkhnQ2FWS0RSbUtUeTFwUlhFQUVsRXh5eWpTRFRJbHRk?=
 =?utf-8?B?bndUTlIwVXZoQXh5NXFxcE8xZ0w5ZVBlNzN4WEhNVi9LK3J0VDNPRWJuL2tH?=
 =?utf-8?B?ZXduOVlXVHo1OTNKNkppNmF4ZTZWUnRmM09UV0pjVlhzMUxvWGZ2eEFQWHA3?=
 =?utf-8?B?dkozbG1FZ2lMZUZraHJuTWdsVWZMTkUwSWI0czRzU2liSS9iTUxyQVdVS2k5?=
 =?utf-8?B?WXIyUzFwdmNPTVNyalMrbm1FdzJQQjdKNmNqdThoRVdrcmVFMXRkQ0Viemt0?=
 =?utf-8?B?UERXbEhQVDNSLzJhQ1I3dmgrVlhVSk9CMWdLT1FFY21uZFlaN1VuVGVTelF4?=
 =?utf-8?B?WVBBekVBQkZwYWJQNHEwd1pLOUh1c2ZtaTlaMWgvR3lMODhsdmVnb1BqNU5r?=
 =?utf-8?B?UWJ5NThNUGxLOE1tM0VaUWwxUHQzRW91VWt2Qlowcysxd0NRTU1yM3l6SEND?=
 =?utf-8?B?ZzIzKzRsWXZ3VThWRHRVOW1DMHRmUUhuNGFKUzNyT2dhdm04RlAxS1VCWUlX?=
 =?utf-8?B?MGFTUmVBSlMrMkhKbnc3V0JwVUg0aVZ1ZjBhQWZWTTQrcm5jdlc2RDYybkE4?=
 =?utf-8?B?dUhMYkw5dXM5bmFvV0JBUE1aU0RweWFJakpHVm92WEVxYW5XRCs5U2gzdHhS?=
 =?utf-8?B?V3IvT0pnNjBWY3Ywc1hrd3k1WER6WHFUelRHVWpORXZ5K2Q2bngxMGhhcnhU?=
 =?utf-8?B?MXhlVi9tdXdmaitZTldQOHlGYW9WdEViR24vSVBCV0tkUkFraWlndnpWbVV6?=
 =?utf-8?B?TGZOL3ZSZno3VUpsS3JoWjdScWpDeGhxVFZkNDUyTlNSZmFkTGtlVDZQWDdi?=
 =?utf-8?B?YWxPNzY4dGtTS1pnOVdQWTNFY0Z4VGNQNHZCWUxXZFBWZjF2QkxVb3cvaHA0?=
 =?utf-8?B?dVVER0Z5OVNpUDJ1c2RhdXRFUDZPbkZkWkdZZWhRNStuKy9UcUY5eG5wN0gr?=
 =?utf-8?B?MkMyR3lScG81VXBpQjRmRmNsT3JkSkdOV1JYM1A5VEdGc05WOGxyNDZmSk1q?=
 =?utf-8?B?cDVxZGkxZHI4cENKMkxhcFdrcFBrU2MrdXJTWjh3alJLUjRJTTVLOTJJMkRp?=
 =?utf-8?B?TGkrZ1YrWVd3Z2o5UklmamlOaDlqM3paY1NROG1HRDhxSDg0emxvWDBFR3Fz?=
 =?utf-8?B?aUFuLytUKzlKVkw5cWdTejBlVStaNkI1TXJnMC9nZVJ2MnNLWGN0RkhGL0g3?=
 =?utf-8?B?QStzeFpScnY5VDdxYlVvc0cwVFhzc2lsdlE3OHQ3akNMcUVlUzErSmFVcHhy?=
 =?utf-8?B?a3dYb29YNVNNajB2ZFBpaXU5MGtxZlFBemRaOVpCMFZkUWFpdmdBZDBEd2Jz?=
 =?utf-8?B?eXUxcmJadDJnMXVReEhyOXV6cXZxOVQwUjUxUjNjeEtUWldzYnoyL2Z6b2sz?=
 =?utf-8?B?SVFldmEwSjJiSnIrY3lwNUxHVHNvMjRZbjRpSHYyOGZiaHZTV1ZZMmZHY08y?=
 =?utf-8?B?Q2hTWW5JRDI0MDF1UVhWNXVWSllPZkVnWW51Tml4a3ZubWg0VjJaRnNaUXdN?=
 =?utf-8?B?bmk2dktsMTV4NlBkWjlVaUF5UkdIdjBYc2FnRHhseGRDU0ZUWUxjSktMRTJK?=
 =?utf-8?B?alBzcTJ2OHJMVHpEdUFET2duSFY4RysxWS9LQ1BlY1JiU3Zyd0NtS042K3hD?=
 =?utf-8?Q?O12ToZlCCzf4LJvEIAL1uJpRjesm69ass2duCvO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1982.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9a501c-9353-49f5-416e-08d909e6d820
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 01:42:12.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qoaz9OHprkg3JrLWG630ZwpG1c3bBIZ5IV4UkmJfvagbG8VFvSWvlrtrl1K/ZmmWRtidVcZRVCSNBcIlwfG9EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SSB0aG91Z2h0IGl0IHdvdWxkIGJlIG1lcmdlZCBpbnRvIDUuMTIgcmVsZWFzZS4gIEEgbGl0dGxl
IGRpc2FwcG9pbnRlZCAgOjwgLCANCldoYXQgY2FuIEkgZG8gdG8gaGVscCA/DQoNClRoYW5rcywN
CkV0YW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1cHB1c3dhbXksIFNh
dGh5YW5hcmF5YW5hbiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29t
PiANClNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjgsIDIwMjEgODo0MCBBTQ0KVG86IEx1a2FzIFd1
bm5lciA8bHVrYXNAd3VubmVyLmRlPjsgQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3Jn
PjsgV2lsbGlhbXMsIERhbiBKIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQpDYzogWmhhbywg
SGFpZmVuZyA8aGFpZmVuZy56aGFvQGludGVsLmNvbT47IFNpbmFuIEtheWEgPG9rYXlhQGtlcm5l
bC5vcmc+OyBSYWosIEFzaG9rIDxhc2hvay5yYWpAaW50ZWwuY29tPjsgS2VpdGggQnVzY2ggPGti
dXNjaEBrZXJuZWwub3JnPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgUnVzc2VsbCBDdXJy
ZXkgPHJ1c2N1ckBydXNzZWxsLmNjPjsgT2xpdmVyIE8nSGFsbG9yYW4gPG9vaGFsbEBnbWFpbC5j
b20+OyBTdHVhcnQgSGF5ZXMgPHN0dWFydC53LmhheWVzQGdtYWlsLmNvbT47IE1pa2EgV2VzdGVy
YmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIFBDSTogcGNpZWhwOiBJZ25vcmUgTGluayBEb3duL1VwIGNhdXNlZCBieSBEUEMNCg0KSGkg
Qmpvcm4sDQoNCk9uIDMvMzAvMjEgMTo1MyBQTSwgS3VwcHVzd2FteSwgU2F0aHlhbmFyYXlhbmFu
IHdyb3RlOg0KPj4gRG93bnN0cmVhbSBQb3J0IENvbnRhaW5tZW50IChQQ0llIEJhc2UgU3BlYywg
c2VjLiA2LjIuMTApIGRpc2FibGVzIA0KPj4gdGhlIGxpbmsgdXBvbiBhbiBlcnJvciBhbmQgYXR0
ZW1wdHMgdG8gcmUtZW5hYmxlIGl0IHdoZW4gaW5zdHJ1Y3RlZCANCj4+IGJ5IHRoZSBEUEMgZHJp
dmVyLg0KPj4NCj4+IEEgc2xvdCB3aGljaCBpcyBib3RoIERQQy0gYW5kIGhvdHBsdWctY2FwYWJs
ZSBpcyBjdXJyZW50bHkgYnJvdWdodCANCj4+IGRvd24gYnkgcGNpZWhwIG9uY2UgRFBDIGlzIHRy
aWdnZXJlZCAoZHVlIHRvIHRoZSBsaW5rIGNoYW5nZSkgYW5kIA0KPj4gYnJvdWdodCB1cCBvbiBz
dWNjZXNzZnVsIHJlY292ZXJ5LsKgIFRoYXQncyB1bmRlc2lyYWJsZSwgdGhlIHNsb3QgDQo+PiBz
aG91bGQgcmVtYWluIHVwIHNvIHRoYXQgdGhlIGhvdHBsdWdnZWQgZGV2aWNlIHJlbWFpbnMgYm91
bmQgdG8gaXRzIA0KPj4gZHJpdmVyLsKgIERQQyBub3RpZmllcyB0aGUgZHJpdmVyIG9mIHRoZSBl
cnJvciBhbmQgb2Ygc3VjY2Vzc2Z1bCANCj4+IHJlY292ZXJ5IGluIHBjaWVfZG9fcmVjb3Zlcnko
KSBhbmQgdGhlIGRyaXZlciBtYXkgdGhlbiByZXN0b3JlIHRoZSBkZXZpY2UgdG8gd29ya2luZyBz
dGF0ZS4NCj4+DQo+PiBNb3Jlb3ZlciwgU2luYW4gcG9pbnRzIG91dCB0aGF0IHR1cm5pbmcgb2Zm
IHNsb3QgcG93ZXIgYnkgcGNpZWhwIG1heSANCj4+IGZvaWwgcmVjb3ZlcnkgYnkgRFBDOsKgIFBv
d2VyIG9mZi9vbiBpcyBhIGNvbGQgcmVzZXQgY29uY3VycmVudGx5IHRvIA0KPj4gRFBDJ3Mgd2Fy
bSByZXNldC7CoCBTYXRoeWFuYXJheWFuYW4gcmVwb3J0cyBleHRlbmRlZCBkZWxheXMgb3IgZmFp
bHVyZSANCj4+IGluIGxpbmsgcmV0cmFpbmluZyBieSBEUEMgaWYgcGNpZWhwIGJyaW5ncyBkb3du
IHRoZSBzbG90Lg0KPj4NCj4+IEZpeCBieSBkZXRlY3Rpbmcgd2hldGhlciBhIExpbmsgRG93biBl
dmVudCBpcyBjYXVzZWQgYnkgRFBDIGFuZCANCj4+IGF3YWl0aW5nIHJlY292ZXJ5IGlmIHNvLsKg
IE9uIHN1Y2Nlc3NmdWwgcmVjb3ZlcnksIGlnbm9yZSBib3RoIHRoZSANCj4+IExpbmsgRG93biBh
bmQgdGhlIHN1YnNlcXVlbnQgTGluayBVcCBldmVudC4NCj4+DQo+PiBBZnRlcndhcmRzLCBjaGVj
ayB3aGV0aGVyIHRoZSBsaW5rIGlzIGRvd24gdG8gZGV0ZWN0IHN1cnByaXNlLXJlbW92YWwgDQo+
PiBvciBhbm90aGVyIERQQyBldmVudCBpbW1lZGlhdGVseSBhZnRlciBEUEMgcmVjb3ZlcnkuwqAg
RW5zdXJlIHRoYXQgdGhlIA0KPj4gY29ycmVzcG9uZGluZyBETExTQyBldmVudCBpcyBub3QgaWdu
b3JlZCBieSBzeW50aGVzaXppbmcgaXQgYW5kIA0KPj4gaW52b2tpbmcgaXJxX3dha2VfdGhyZWFk
KCkgdG8gdHJpZ2dlciBhIHJlLXJ1biBvZiBwY2llaHBfaXN0KCkuDQo+Pg0KPj4gVGhlIElSUSB0
aHJlYWRzIG9mIHRoZSBob3RwbHVnIGFuZCBEUEMgZHJpdmVycywgcGNpZWhwX2lzdCgpIGFuZCAN
Cj4+IGRwY19oYW5kbGVyKCksIHJhY2UgYWdhaW5zdCBlYWNoIG90aGVyLsKgIElmIHBjaWVocCBp
cyBmYXN0ZXIgdGhhbiANCj4+IERQQywgaXQgd2lsbCB3YWl0IHVudGlsIERQQyByZWNvdmVyeSBj
b21wbGV0ZXMuDQo+Pg0KPj4gUmVjb3ZlcnkgY29uc2lzdHMgb2YgdHdvIHN0ZXBzOsKgIFRoZSBm
aXJzdCBzdGVwICh3YWl0aW5nIGZvciBsaW5rDQo+PiBkaXNhYmxlbWVudCkgaXMgcmVjb2duaXph
YmxlIGJ5IHBjaWVocCB0aHJvdWdoIGEgc2V0IERQQyBUcmlnZ2VyIA0KPj4gU3RhdHVzIGJpdC7C
oCBUaGUgc2Vjb25kIHN0ZXAgKHdhaXRpbmcgZm9yIGxpbmsgcmV0cmFpbmluZykgaXMgDQo+PiBy
ZWNvZ25pemFibGUgdGhyb3VnaCBhIG5ld2x5IGludHJvZHVjZWQgUENJX0RQQ19SRUNPVkVSSU5H
IGZsYWcuDQo+Pg0KPj4gSWYgRFBDIGlzIGZhc3RlciB0aGFuIHBjaWVocCwgbmVpdGhlciBvZiB0
aGUgdHdvIGZsYWdzIHdpbGwgYmUgc2V0IA0KPj4gYW5kIHBjaWVocCBtYXkgZ2xlYW4gdGhlIHJl
Y292ZXJ5IHN0YXR1cyBmcm9tIHRoZSBuZXcgUENJX0RQQ19SRUNPVkVSRUQgZmxhZy4NCj4+IFRo
ZSBmbGFnIGlzIHplcm8gaWYgRFBDIGRpZG4ndCBvY2N1ciBhdCBhbGwsIGhlbmNlIERMTFNDIGV2
ZW50cyBhcmUgDQo+PiBub3QgaWdub3JlZCBieSBkZWZhdWx0Lg0KPj4NCj4+IFRoaXMgY29tbWl0
IGRyYXdzIGluc3BpcmF0aW9uIGZyb20gcHJldmlvdXMgYXR0ZW1wdHMgdG8gc3luY2hyb25pemUg
DQo+PiBEUEMgd2l0aCBwY2llaHA6DQo+Pg0KPj4gQnkgU2luYW4gS2F5YSwgQXVndXN0IDIwMTg6
DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAxODA4MTgwNjUxMjYuNzc5
MTItMS1va2F5YUBrZXJuZWwNCj4+IC5vcmcvDQo+Pg0KPj4gQnkgRXRoYW4gWmhhbywgT2N0b2Jl
ciAyMDIwOg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMjAxMDA3MTEz
MTU4LjQ4OTMzLTEtaGFpZmVuZy56aGFvDQo+PiBAaW50ZWwuY29tLw0KPj4NCj4+IEJ5IFNhdGh5
YW5hcmF5YW5hbiBLdXBwdXN3YW15LCBNYXJjaCAyMDIxOg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtcGNpLzU5Y2IzMGY1ZTVhYzZkNjU0MjdjZWFhZGYxMDEyYjJiYThkDQo+PiBi
ZjY2Yy4xNjE1NjA2MTQzLmdpdC5zYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRl
bC5jb20vDQo+Pg0KPiBMb29rcyBnb29kIHRvIG1lLiBUaGlzIHBhdGNoIGZpeGVzIHRoZSByZXBv
cnRlZCBpc3N1ZSBpbiBvdXIgZW52aXJvbm1lbnQuDQo+IA0KPiBSZXZpZXdlZC1ieTogS3VwcHVz
d2FteSBTYXRoeWFuYXJheWFuYW4gDQo+IDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51
eC5pbnRlbC5jb20+DQo+IFRlc3RlZC1ieTogS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4gDQo+
IDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+DQoNCkFueSB1cGRh
dGUgb24gdGhpcyBwYXRjaD8gaXMgdGhpcyBxdWV1ZWQgZm9yIG1lcmdlPyBPbmUgb2Ygb3VyIGN1
c3RvbWVycyBpcyBsb29raW5nIGZvciB0aGlzIGZpeC4gU28gd29uZGVyaW5nIGFib3V0IHRoZSBz
dGF0dXMuDQoNCi0tDQpTYXRoeWFuYXJheWFuYW4gS3VwcHVzd2FteQ0KTGludXggS2VybmVsIERl
dmVsb3Blcg0K
