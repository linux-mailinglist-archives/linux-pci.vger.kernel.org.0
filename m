Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA814B01E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 08:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgA1HNF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 02:13:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:5958 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgA1HNF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jan 2020 02:13:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 23:13:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,372,1574150400"; 
   d="scan'208";a="222691665"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2020 23:13:04 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Jan 2020 23:13:03 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 27 Jan 2020 23:13:03 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 27 Jan 2020 23:13:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 27 Jan 2020 23:13:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUmDTu+YrYYz3YVv4cM8vZGjnOxoFEuuskFhnlUrjDo8GHSTkWBqKrVnpKNzb3E/QkoEYXwyA8vrZ7dxm/5Pa7SVA6WTaa5fW6KjP1xrPj5djcPnxAwFbV9jTupRSXQDRDEK3PyTA8PzdhsgZFd/vKdlNZc+vuDSVAe1W1Ltm1HscqUT8irey99Qm/mypctbY80oIn/CDw76DOhv+7Jloo1Cuwnw4lYWpVhwuIk751HGOQxY0jCIrhvFny09ahGNj2vyOnty3AuYPo8qkTisuZNHdu4dHYMrKYduGKrfWd1nrxsajFg7pAupffgyenJeLP+IkYlj418Sc6Xv16dPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUA9X+gnjAyaShl+uZvfz89F3PQ0KKrwKIWl9TSgc4A=;
 b=c+VDJ9qk3Loun9qFEmsmJWRsqr31q16gCPSIaoFhjlinEcJeO9It5UV9USPb5oV7rqNXTehynIYHDmzq5/3iLEEY1Qd/sDG5uUkiBwy7tVznVPI0WNfDSzx3mQd8TFgsYU4rFq974nwiMDC3mZxZeuohtCGkw5A5s4PAMAVUHxcOdsbMCvlBoU5oFeLMI3KVHWibE77nJTKfYQhmhZtu3QmRukUqKBFe6IOK7Ea4wslazzICMhjAEdaMPGSUTqgUKxpSqOkBjgG53bIwYOHbpPEhI2nPs4YLUhpymhZ9+aFSa4Q9IFrPbG3e9N0+Px1pFNlQtBZLrP0WAaysCtE0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUA9X+gnjAyaShl+uZvfz89F3PQ0KKrwKIWl9TSgc4A=;
 b=iMB3QcYGpSbgQ1jGz4IhVWhqXfiF142F43IZSutctr1RFoJbA31OOrQWohijyVTJsZumO1/UAlK6Ih3/e5VMQ3wyMgWC4Gv0Q+5jHAYcj98jcuusyxIe8Ue1ruAs3OfLLc4+bb/KzA/gbtQ6OAme0xyEDigtcvgabykSXPUkj4Y=
Received: from BYAPR11MB2917.namprd11.prod.outlook.com (20.177.225.216) by
 BYAPR11MB2741.namprd11.prod.outlook.com (52.135.223.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 07:13:01 +0000
Received: from BYAPR11MB2917.namprd11.prod.outlook.com
 ([fe80::e91c:4b6e:321d:cbe8]) by BYAPR11MB2917.namprd11.prod.outlook.com
 ([fe80::e91c:4b6e:321d:cbe8%7]) with mapi id 15.20.2665.025; Tue, 28 Jan 2020
 07:13:01 +0000
From:   "Skidanov, Alexey" <alexey.skidanov@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Heilper, Anat" <anat.heilper@intel.com>,
        "Zadicario, Guy" <guy.zadicario@intel.com>
Subject: RE: Disabling ACS for peer-to-peer support
Thread-Topic: Disabling ACS for peer-to-peer support
Thread-Index: AdXU3xN5Q2BD/xtgQwWkaPIJp9pGCAAC1P0AABIj8oAABLQEgAAAJksAABhcvOA=
Date:   Tue, 28 Jan 2020 07:13:01 +0000
Message-ID: <BYAPR11MB2917B3A25964230EEE61F779EE0A0@BYAPR11MB2917.namprd11.prod.outlook.com>
References: <BYAPR11MB29171883468FD79722FF3652EE0B0@BYAPR11MB2917.namprd11.prod.outlook.com>
 <3b62f9d6-5b93-e252-3419-3fe5307f7935@amd.com>
 <c09a2da5-25e5-445c-3f34-ca6c96686130@deltatee.com>
 <1f3f0f67-865b-0657-da17-896c7b1053fb@amd.com>
 <66ed4842-348d-5bb0-52ba-0236f91ef935@deltatee.com>
In-Reply-To: <66ed4842-348d-5bb0-52ba-0236f91ef935@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexey.skidanov@intel.com; 
x-originating-ip: [134.191.233.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 091ae6bc-77ab-47cf-9e98-08d7a3c182d7
x-ms-traffictypediagnostic: BYAPR11MB2741:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2741EE5F8415B5A2D3391400EE0A0@BYAPR11MB2741.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(376002)(346002)(189003)(199004)(76116006)(64756008)(478600001)(66476007)(66556008)(66446008)(33656002)(66946007)(2906002)(4326008)(9686003)(54906003)(53546011)(186003)(26005)(6506007)(8676002)(81156014)(7696005)(8936002)(86362001)(55016002)(52536014)(316002)(110136005)(71200400001)(66574012)(5660300002)(81166006)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB2741;H:BYAPR11MB2917.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yaT95pZH28URSZkavRfAT3LpMA7jTVx+mrayaccyhEdtcS+nqfHEqaue6zbzzntknhoGVFI0PhJcQ5SMnQl9kLOZzG2gFp/NX0l/ZKwgEznTnax62Im9vDEqqj1akbkKpNHk+q/JlXKf5kt+lKx+//efV/Gqq7zxOTNZF/yDolH/+FvNcr2ZxKhyiFNA84/J4kTvLe1osul8491Dp3/IEaWL6O8di4zmhMB9Y1sQXLbZRJYu2EMxfsdVOjbplhuSjRtkUzcE+6YKmUsAXu2Zxbzq3EKHrAu/N2sTz/3ZgminlzfXtVTQo2svvrjyhMlf2F0otCzpRetIlF/geZcuMdvOCA5CLfjUkZM7FLtBuSNwg3KQ5jVFicGguMAVE6pk7lXvXdgxbe0VjHYlz8eHDU0D+Klau7l8hLnvvqiEndZQqyj2KMvlQpsuBMIPy22i
x-ms-exchange-antispam-messagedata: BNc9GVxLMS4a2Je+doP9VsEvoiyXjxy7ZVOnKtQ5Rp5ss+nqrs6HxS/2UG9JNFDLW99g4n8H89TyEwG8VvAjXQiMFQ5hTUIkQ+fzt+gWPXeiEdN70/nbAo3Env5RMXlRx+Cp/XWCsU1N3CII6QAZwg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 091ae6bc-77ab-47cf-9e98-08d7a3c182d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 07:13:01.3929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkpsdB0zH5X0qqi/l6MSTjN5MxdGr5tGPKjKiWq1dTQ/AiO5EVIYqyfTU9ygmoVy6KJCjg6IqbYnAxVd4jccN6G+CZJ2pNEixhlIVjX8tgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2741
X-OriginatorOrg: intel.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pk9uIDIwMjAtMDEtMjcgMTI6MTIgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4+IEFt
IDI3LjAxLjIwIHVtIDE3OjU4IHNjaHJpZWIgTG9nYW4gR3VudGhvcnBlOg0KPj4+DQo+Pj4gT24g
MjAyMC0wMS0yNyAxOjE4IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+Pj4+IEFtIDI3
LjAxLjIwIHVtIDA4OjE4IHNjaHJpZWIgU2tpZGFub3YsIEFsZXhleToNCj4+Pj4+IEhlbGxvLA0K
Pj4+Pj4NCj4+Pj4+IEkgaGF2ZSByZWNlbnRseSBmb3VuZCB0aGUgYmVsb3cgY29tbWl0IHRvIGRp
c2FibGluZyBBQ1MgYml0cy4gVXNpbmcga2VybmVsIHBhcmFtZXRlcg0KPmlzIHByZXR0eSBzaW1w
bGUgYnV0IHJlcXVpcmVzIHRvIGtub3cgaW4gYWR2YW5jZSB3aGljaCBkZXZpY2VzIG1pZ2h0IGJl
IHBhcnRpY2lwYXRlZCBpbg0KPnBlZXItdG8tcGVlciBzZXNzaW9ucy4NCj4+Pj4+DQo+Pj4+PiAg
ICBXaHkgd2UgY2FuJ3QgZGlzYWJsZSB0aGUgQUNTIGJpdHMgKmFmdGVyKiB0aGUgZHJpdmVyIGlz
IGluaXRpYWxpemVkIChhbmQgdGhlcmUgaXMgYQ0KPnJlcXVlc3QgdG8gY29ubmVjdCBiZXR3ZWVu
IHR3byBwZWVycykgYW5kIG5vdCAqZHVyaW5nKiBkZXZpY2UgZGlzY292ZXJpbmc/Lg0KPj4+PiBU
aGF0J3MgZXhhY3RseSB3aGF0IHdhcyBpbml0aWFsbHkgcHJvcG9zZWQgYnV0IHdlIGhhdmUgc2Vl
biBoYXJkd2FyZQ0KPj4+PiB3aGljaCByZWFjdHMgYWxsZXJnaWMgdG8gZGlzYWJsaW5nIHRob3Nl
IGJpdHMgb24gdGhlIGZseS4NCj4+PiBJIHdhc24ndCBhd2FyZSBvZiB0aGF0IGFuZCBoYXZlbid0
IHNlZW4gYW55dGhpbmcgbGlrZSB0aGF0Lg0KPj4+DQo+Pj4+IFBsZWFzZSByZWFkIHVwIHRoZSBk
aXNjdXNzaW9uIG9uIHRoZSBtYWlsaW5nIGxpc3QgbGVhZGluZyB0byB0aGlzIHBhdGNoLg0KPj4+
IFRoZSBpc3N1ZSB3YXMgdGhlIElPTU1VIGNvZGUgZG9lcyBub3QgYWxsb3cgZm9yIGFueSBraW5k
IG9mIGR5bmFtaWMNCj4+PiBjaGFuZ2VzIGluIHRoZSBncm91cHMgZGV2aWNlcyBhcmUgYXNzaWdu
ZWQgaW4uIEluIHRoZW9yeSwgdGhpcyBjb3VsZCBiZQ0KPj4+IHBvc3NpYmxlIGJ1dCB5b3UnZCBz
dGlsbCBhdCBsZWFzdCBoYXZlIHRvIHVuYmluZCB0aGUgZGV2aWNlcyBmcm9tIHRoZWlyDQo+Pj4g
ZHJpdmVyIGJlY2F1c2UgeW91IGRlZmluaXRlbHkgY2FuJ3QgY2hhbmdlIHRoZSBJT01NVSBncm91
cCB3aGlsZSB0aGVyZQ0KPj4+IGFyZSBETUEgcmVxdWVzdHMgaW4gZmxpZ2h0LiBVbHRpbWF0ZWx5
IGl0J3MgZWFzaWVyIGZvciBtb3N0IHVzZSBjYXNlcyB0bw0KPj4+IGp1c3QgZGlzYWJsZSBpdCBv
biBib290Lg0KPj4NCj4+IEFzIGZhciBhcyBJIGtub3cgeW91IGNhbid0IGNoYW5nZSB0aGUgQUNT
IGJpdCBlaXRoZXIgd2hlbiB0aGVyZSBhcmUNCj4+IHRyYW5zYWN0aW9ucyBpbiBmbGlnaHQgb24g
dGhlIGFmZmVjdGVkIGRldmljZXMvYnJpZGdlcy4NCj4NCj5ObywgSSB0aGluayB0aGUgQUNTIGJp
dHMgYXJlIGZpbmUgdG8gY2hhbmdlIGF0IGFueSB0aW1lLiBJJ3ZlIG5ldmVyIGhhZA0KPmFueSBp
c3N1ZSBjaGFuZ2luZyB0aGVtLiBUaGUgcHJvYmxlbSBpcyB0aGUgYWN0IG9mIGNoYW5naW5nIHRo
ZW0gY2hhbmdlcw0KPnRoZSBpc29sYXRpb24gYmV0d2VlbiB0aGUgZGV2aWNlcyB3aGljaCBtZWFu
cyB0aGUgSU9NTVUgZ3JvdXBzIGhhdmUgdG8NCj5jaGFuZ2UuDQo+DQo+SXQncyBjZXJ0YWlubHkg
cG9zc2libGUgdG9kYXkgdG8ganVzdCB1c2Ugc2V0cGNpIHRvIGFkanVzdCB0aG9zZSBiaXRzIGF0
DQo+YW55IHRpbWUuIEl0IGp1c3QgbWVhbnMgdGhlIGlzb2xhdGlvbiB0aGUgSU9NTVUgaXMgZXhw
ZWN0aW5nIHdpbGwgYmUNCj53cm9uZyBhbmQgdGhhdCBtYXkgbWVhbiB5b3UgYnJva2UgdGhlIHNl
Y3VyaXR5IGJldHdlZW4gVk1zIG9uIHlvdXIgbWFjaGluZS4NCj4NCg0KQWNjb3JkaW5nIHRvIHRo
ZSBQQ0llIHNwZWMsIHRoZXJlIGFyZSB0d28gbWVjaGFuaXNtcyB0byBkZWFsIHdpdGggaXNvbGF0
aW9uOg0KLSBSZWRpcmVjdGVkIFJlcXVlc3QgVmFsaWRhdGlvbiBsb2dpYyB3aXRoaW4gdGhlIFJD
IGFuZA0KLSBBQ1MgUDJQIEVncmVzcyBDb250cm9sDQpTbyBhbnlvbmUgd2hvIGNhcmVzIGFib3V0
IHRoZSBpc29sYXRpb24gbXVzdCB1c2UgYXQgbGVhc3Qgb25lIG9mIHRoZXNlIG1lY2hhbmlzbXMu
IA0KSSB3b3VsZCBleHBlY3QgdGhhdCBvbiBWTSBjcmVhdGlvbiwgdGhlIGFib3ZlIG1lY2hhbmlz
bXMgd2lsbCBiZSBjb25maWd1cmVkIGFwcHJvcHJpYXRlbHkuIA0KDQo+PiBPdGhlcndpc2Ugd2hh
dCBjb3VsZCBoYXBwZW4gaXMgdGhhdCB0aGUgcmVzcG9uc2Ugb2YgYW4gdHJhbnNhY3Rpb24gdGFr
ZXMNCj4+IGEgZGlmZmVyZW50IHBhdGggdGhhbiB0aGUgcmVxdWVzdC4gVGhhdCBpbiB0dXJuIGNh
biByZXN1bHQgaW4gcXVpdGUgYQ0KPj4gYnVuY2ggb2Ygb3JkZXJpbmcgcHJvYmxlbSBvbiB0aGUg
UENJZSBidXMuDQo+Pg0KPj4gQnV0IHRoZSBpZGVhIG9mIHVuYmluZGluZyBhIGRldmljZSwgY2hh
bmdpbmcgdGhlIGJpdCBhbmQgcmViaW5kaW5nIGl0DQo+PiB3b3VsZCBwcm9iYWJseSB3b3JrLg0K
Pg0KPldlbGwsIG5vLCB5b3UgY2FuJ3QganVzdCBjaGFuZ2UgdGhlIGJpdCwgeW91IGhhdmUgdG8g
Y2hhbmdlIHRoZSBJT01NVQ0KPmdyb3VwIHRoZSBkZXZpY2UgYmVsb25ncyB0by4gUmlnaHQgbm93
LCB3ZSBkb24ndCBoYXZlIGFueSBpbnRlcmZhY2UgdG8NCj5kbyB0aGF0IGV4Y2VwdCBkdXJpbmcg
c2Nhbm5pbmcgYXQgYm9vdC4NCj4NCj5Mb2dhbg0K
