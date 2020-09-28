Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D3127A594
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 04:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgI1CyX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 22:54:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:12030 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI1CyX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 22:54:23 -0400
IronPort-SDR: Bt+SvoAg11uwAnWgaAi0k09MhMzl74lJo3Jv+TQft29Uo7Bt8p7OUUgmH/4K94+oUqgCL8Gt55
 MyIFsbxVU1Cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="161989287"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="161989287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 19:54:22 -0700
IronPort-SDR: WcSGJE88fWsMNYE0cSl6J9YytMkM91B9ICZiIA/ixB1MUXjPXlElq+fT0PymEdN0hdGLgJ4/Xd
 XUZYxpZAgykg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="311608789"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2020 19:54:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 27 Sep 2020 19:54:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 27 Sep 2020 19:54:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 27 Sep 2020 19:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIpqNHhCb8iqn2pmeuDyDIPYoIf7e4bLNSAgzywGKfKBx/vkuJX+E2ApJsFwTRFSgO5WOHJ+H5vonBHxzGorvm/D844lQjq5tktTKRw+AzjU94E+L/mSTpCcA6pQooZnjhPsePOZ/Eb9N+RLycfbvAif8I6zgDT/0toN90Py1bW13qj1drInx6x4pFbdLemwQHDIP9FO6GmEvot+Od4cWX/ESaimvbzk19lUrRguQ/RGfgio3etWAhy0Lhwc3lL2hlrkyNYQVVS1Llb0FLgtYrIq8QT+V07Ky4hZgQK7WRhOq7hzn5sG2x4Sd3GAVtknK+RKEYjsE3voRfbdp6SDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxhbESn1dM3zDyNgTATfhRLgzT2VeTaYK/BrI1FlYCc=;
 b=nndo/OLsX9WL8he43ZS9gDY+jfFlnawH3wwNZE8Pd+C4NWjXPUw2HtGaH4pDAxuqaBvaO7blg+5CEFTt3q3O14xMTYaO33QxROt1V1/eJISSCPo8wGnyjZ+07gxCQVCJhP4LpGkUTekzBWSsHh2H4iy1/Sv/3k4xj8Rp3poMbEQEPzeqBGA8RkoYmyYp/GLu0XM0HF4TQyCWwWOl9nvYCYjZdDKqjG5COpB243pMbsWqXUdta5M0V8UVA7CCRh77PZkjdYvWvm6C7I6Xiz2nBvk0OpN5WQOyBpxCcclO94QZZhjM0ZC+1PFD3C+nngf6rqyQ+i3e23WgaODbUAOk+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxhbESn1dM3zDyNgTATfhRLgzT2VeTaYK/BrI1FlYCc=;
 b=SFA9Jp7Iuneqbc4WFyPhUI2SgYS7PIyxKoczj+0weJHKrenCGfHWD+r1V8kMkzrXWoDCVepz2mW/EzLNbp4Id9xiKEgigPEKRljS75OfgEGfyjO1vTa8lxT5kau/HERuRrTOGPvKamMTyOAtxdZLtglThwci1d925Y8hEvO1r2I=
Received: from MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23)
 by MWHPR11MB1998.namprd11.prod.outlook.com (2603:10b6:300:1e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Mon, 28 Sep
 2020 02:54:06 +0000
Received: from MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f]) by MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f%2]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 02:54:06 +0000
From:   "Zhao, Haifeng" <haifeng.zhao@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        "ashok.raj@linux.intel.com" <ashok.raj@linux.intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>
Subject: RE: [PATCH 2/5 V4] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
Thread-Topic: [PATCH 2/5 V4] PCI: pciehp: check and wait port status out of
 DPC before handling DLLSC and PDC
Thread-Index: AQHWlKhPcHloAk19Z0SY0Cvs9G9XwKl8MqgAgAEo6vA=
Date:   Mon, 28 Sep 2020 02:54:06 +0000
Message-ID: <MWHPR11MB169614255D11537617AE4B0D97350@MWHPR11MB1696.namprd11.prod.outlook.com>
References: <20200927082736.14633-1-haifeng.zhao@intel.com>
 <20200927082736.14633-3-haifeng.zhao@intel.com>
 <CAHp75VdnwfcNFZ3puPcKSyQk1WbtJJefVDMSC=o8r016nHEgcA@mail.gmail.com>
In-Reply-To: <CAHp75VdnwfcNFZ3puPcKSyQk1WbtJJefVDMSC=o8r016nHEgcA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad80868c-fd73-4472-af80-08d86359c40c
x-ms-traffictypediagnostic: MWHPR11MB1998:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1998BDCEECC105DFF6631E4097350@MWHPR11MB1998.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z7+ktIcUTHIlCauyNXGBO26SzVWPCvtgKHrEsbWmj6goKoG0mv8sG5Rh+5eoWT7hh1FPilEfy9WHRzGErzov1Ygzr8FgAE+Ue7C/4cntGSqXEvyo2VQeO9tXNSkF390ndT11tcF4kTCXs3+eR+53Z2D/9J1da/ci3TieH1QxoEdWmsaIGhqhwnrauSCk1nR/BxKTJeaER+8Er1AdN+KdvP2Ryw+qwkx1X0/MFoYhEbbWS5QIdeIVsKklxGnzEBr217c6TIMuWXEFIvOL1WBtPsn4EhLTynPgdhAg3YFBGGKIzrlvliKJ5Z4IxXxNR+vZ28tHObCNWuMoNADaNvLR85BNDHaCHH+W9DoLRUYTUW1hJtk2iAliO3fAWec5W1gAfS6IEVMp0GxnUmclW7MFlIy9aaCqhpjF8rvgP7qoOhCAfb1kk8Fae6LqDUQjd9QgX/ACYoPp1n6MB+4lv2P1+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1696.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(966005)(110136005)(7416002)(45080400002)(7696005)(4326008)(5660300002)(55016002)(316002)(83380400001)(186003)(9686003)(53546011)(66446008)(66476007)(6506007)(26005)(66556008)(54906003)(2906002)(64756008)(33656002)(8676002)(86362001)(76116006)(66946007)(52536014)(478600001)(6636002)(8936002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /cQ+q2O5qCt9MrW4/ytC7RN7WFuIfA62eST6l8c2yNVWu+rnPYDxn6Au1JgrPtGx3FfRBamUu1ZZ0NC1iuKDbD4Ds1f/DM5dbKGgHPjZQBDWNZE/TttmUkGP7bxRRLRtedvHTUyCHtTEm7vHxQEVsUixusOaj/pp7oZ4SW/57EFRjW6/ckan/sr/xR3kE839nORjbzJleeb3jor8mZZWbUgK7N+qhxo8Hkvz2+zlUbxih9kv+7k03D81wN+dih6oF47qAaDcVQ3sgiKT8RwzAaugVf6EJiDNIBhYnk11I+HNsM5AFDI77J8nh6Cax1Af1TfsoGLnrkYINsnSg/g+heayFuYmHJKdXC13NJny7+YyjEWHFniTl65RpOpTlVU4jxFm7fr6AyoGEzsgpU2j0ENik5wOZA8XYCSBg6L11HFYP4ynsyskdqwkoTEiEojeJLSdLpu/Q+Rpkal0BwR93OYk1xNZHQWkfZM7YlFa5mMAUkc/ijwgBIi+gH8La33Q8YddMqqzWxG8j3uTRx4UNgRT75zwrVdw/seTLhNz3nEWRA/WQ0Wj07ZH0vAAQqvf0sKY07tiPrLQ+nyJyYaoFnQlMUiBb4y3snVzoNpbjEtySJfg9UzqmfV1McrNPe5ydjmqSRsIT8xLSm9ahWBD1Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1696.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad80868c-fd73-4472-af80-08d86359c40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 02:54:06.1731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csT4NQN8c3AT4bUtYzdjkeXI9rcGr1CbKTVxrlxiMGgKaW/UThiTjHIHO6caKUvc0Nsh1boeraB9ZCS4SGBo0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1998
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW5keSwgDQogICBNYXkgSSBhc2sgd2hpY2ggbGluZSBvZiB0aGUgT29wcyBpcyAiIHlvdSByYW5k
b21seSBkaWQgc29tZXRoaW5nICIgPyBhbmQgc2hvdWxkIGJlIHJlbW92ZWQgPw0KDQpUaGFua3Ms
DQpFdGhhbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQW5keSBTaGV2Y2hl
bmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiANClNlbnQ6IFN1bmRheSwgU2VwdGVtYmVy
IDI3LCAyMDIwIDU6MTAgUE0NClRvOiBaaGFvLCBIYWlmZW5nIDxoYWlmZW5nLnpoYW9AaW50ZWwu
Y29tPjsgSGFuc2VuLCBEYXZlIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+DQpDYzogQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IE9saXZlciA8b29oYWxsQGdtYWlsLmNvbT47IHJ1
c2N1ckBydXNzZWxsLmNjOyBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT47IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPjsgU3R1YXJ0IEhheWVz
IDxzdHVhcnQudy5oYXllc0BnbWFpbC5jb20+OyBBbGV4YW5kcnUgR2Fnbml1YyA8bXIubnVrZS5t
ZUBnbWFpbC5jb20+OyBNaWthIFdlc3RlcmJlcmcgPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRl
bC5jb20+OyBsaW51eC1wY2kgPGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJu
ZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgSmlhLCBQZWkg
UCA8cGVpLnAuamlhQGludGVsLmNvbT47IGFzaG9rLnJhakBsaW51eC5pbnRlbC5jb207IEt1cHB1
c3dhbXksIFNhdGh5YW5hcmF5YW5hbiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAaW50ZWwu
Y29tPjsgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPjsgSm9lIFBlcmNoZXMg
PGpvZUBwZXJjaGVzLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi81IFY0XSBQQ0k6IHBjaWVo
cDogY2hlY2sgYW5kIHdhaXQgcG9ydCBzdGF0dXMgb3V0IG9mIERQQyBiZWZvcmUgaGFuZGxpbmcg
RExMU0MgYW5kIFBEQw0KDQpPbiBTdW4sIFNlcCAyNywgMjAyMCBhdCAxMTozMSBBTSBFdGhhbiBa
aGFvIDxoYWlmZW5nLnpoYW9AaW50ZWwuY29tPiB3cm90ZToNCj4NCj4gV2hlbiByb290IHBvcnQg
aGFzIERQQyBjYXBhYmlsaXR5IGFuZCBpdCBpcyBlbmFibGVkLCB0aGVuIHRyaWdnZXJlZCBieSAN
Cj4gZXJyb3JzLCBEUEMgRExMU0MgYW5kIFBEQyBpbnRlcnJ1cHRzIHdpbGwgYmUgc2VudCB0byBE
UEMgZHJpdmVyLCANCj4gcGNpZWhwIGRyaXZlciBhdCB0aGUgc2FtZSB0aW1lLg0KPiBUaGF0IHdp
bGwgY2F1c2UgZm9sbG93aW5nIHJlc3VsdDoNCj4NCj4gMS4gTGluayBhbmQgZGV2aWNlIGFyZSBy
ZWNvdmVyZWQgYnkgaGFyZHdhcmUgRFBDIGFuZCBzb2Z0d2FyZSBEUEMgZHJpdmVyLA0KPiAgICBk
ZXZpY2UNCj4gICAgaXNuJ3QgcmVtb3ZlZCwgYnV0IHRoZSBwY2llaHAgbWlnaHQgdHJlYXQgaXQg
YXMgZGV2aWNlIHdhcyBob3QgcmVtb3ZlZC4NCj4NCj4gMi4gUmFjZSBjb25kaXRpb24gaGFwcGVu
cyBiZXR0d2VlbiBwY2llaHBfdW5jb25maWd1cmVfZGV2aWNlKCkgY2FsbGVkIGJ5DQo+ICAgIHBj
aWVocF9pc3QoKSBpbiBwY2llaHAgZHJpdmVyIGFuZCBwY2lfZG9fcmVjb3ZlcnkoKSBjYWxsZWQg
YnkNCj4gICAgZHBjX2hhbmRsZXIgaW4gRFBDIGRyaXZlci4gbm8gbHVjaywgdGhlcmUgaXMgbm8g
bG9jayB0byBwcm90ZWN0DQo+ICAgIHBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZSgpDQo+
ICAgIGFnYWluc3QgcGNpX3dhbGtfYnVzKCksIHRoZXkgaG9sZCBkaWZmZXJlbnQgc2FtcGhvcmUg
YW5kIG11dGV4LA0KPiAgICBwY2lfc3RvcF9hbmRfcmVtb3ZlX2J1c19kZXZpY2UgaG9sZHMgcGNp
X3Jlc2Nhbl9yZW1vdmVfbG9jaywgYW5kDQo+ICAgIHBjaV93YWxrX2J1cygpIGhvbGRzIHBjaV9i
dXNfc2VtLg0KPg0KPiBUaGlzIHJhY2UgY29uZGl0aW9uIGlzIG5vdCBwdXJlbHkgY29kZSBhbmFs
eXNpcywgaXQgY291bGQgYmUgdHJpZ2dlcmVkIA0KPiBieSBmb2xsb3dpbmcgY29tbWFuZCBzZXJp
ZXM6DQo+DQo+ICAgIyBzZXRwY2kgLXMgNjQ6MDIuMCAweDE5Ni53PTAwMGEgLy8gNjQ6MDIuMCBy
b290cG9ydCBoYXMgRFBDIGNhcGFiaWxpdHkNCj4gICAjIHNldHBjaSAtcyA2NTowMC4wIDB4MDQu
dz0wNTQ0ICAvLyA2NTowMC4wIE5WTWUgU1NEIHBvcHVsYXRlZCBpbiBwb3J0DQo+ICAgIyBtb3Vu
dCAvZGV2L252bWUwbjFwMSBudm1lDQo+DQo+IE9uZSBzaG90IHdpbGwgY2F1c2Ugc3lzdGVtIHBh
bmljIGFuZCBOVUxMIHBvaW50ZXIgcmVmZXJlbmNlIGhhcHBlbmVkLg0KPiAodGVzdGVkIG9uIHN0
YWJsZSA1LjggJiBJQ1MoSWNlIExha2UgU1AgcGxhdGZvcm0sIHNlZQ0KPiBodHRwczovL2VuLndp
a2ljaGlwLm9yZy93aWtpL2ludGVsL21pY3JvYXJjaGl0ZWN0dXJlcy9pY2VfbGFrZV8oc2VydmVy
DQo+ICkpDQo+DQo+ICAgIEJ1ZmZlciBJL08gZXJyb3Igb24gZGV2IG52bWUwbjFwMSwgbG9naWNh
bCBibG9jayAzMzI4LCBhc3luYyBwYWdlIHJlYWQNCj4gICAgQlVHOiBrZXJuZWwgTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDUwDQo+ICAgICNQRjogc3Vw
ZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KPiAgICAjUEY6IGVycm9yX2NvZGUo
MHgwMDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UNCj4gICAgUEdEIDANCg0KU2VlbXMgbGlrZSB5b3Ug
cmFuZG9tbHkgZGlkIHNvbWV0aGluZyBhYm91dCB0aGUgc2VyaWVzIGFuZCB3b3VsZCBsaWtlIGl0
IHRvIGJlIGFwcGxpZWQ/ISBJdCdzIG5vIGdvIQ0KUGxlYXNlLCByZWFkIG15IGNvbW1lbnRzIGFn
YWluIHYxIG9uZSBtb3JlIHRpbWUgYW5kIGNhcmVmdWxseSBjb21tZW50IG9yIGFkZHJlc3MuDQoN
CldoeSBkbyB5b3Ugc3RpbGwgaGF2ZSB0aGVzZSAoc29tZSBhYm92ZSwgc29tZSBiZWxvdyB0aGlz
IGNvbW1lbnQpIG5vbi1yZWxldmFudCBsaW5lcyBvZiBvb3BzPw0KDQo+ICAgIE9vcHM6IDAwMDAg
WyMxXSBTTVAgTk9QVEkNCj4gICAgQ1BVOiAxMiBQSUQ6IDUxMyBDb21tOiBpcnEvMTI0LXBjaWUt
ZHAgTm90IHRhaW50ZWQgNS44LjAgZWw4Lng4Nl82NCsgIzENCj4gICAgUklQOiAwMDEwOnJlcG9y
dF9lcnJvcl9kZXRlY3RlZC5jb2xkLjQrMHg3ZC8weGU2DQo+ICAgIENvZGU6IGI2IGQwIGU4IGU4
IGZlIDExIDAwIGU4IDE2IGM1IGZiIGZmIGJlIDA2IDAwIDAwIDAwIDQ4IDg5IGRmIGU4IGQzDQo+
ICAgIDY1IGZmIGZmIGI4IDA2IDAwIDAwIDAwIGU5IDc1IGZjIGZmIGZmIDQ4IDhiIDQzIDY4IDQ1
IDMxIGM5IDw0OD4gOGIgNTANCj4gICAgNTAgNDggODMgM2EgMDAgNDEgMGYgOTQgYzEgNDUgMzEg
YzAgNDggODUgZDIgNDEgMGYgOTQgYzANCj4gICAgUlNQOiAwMDE4OmZmOGUwNmNmODc2MmZkYTgg
RUZMQUdTOiAwMDAxMDI0Ng0KPiAgICBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZjRlM2Vh
YWNmNDJhMDAwIFJDWDogZmY0ZTNlYjMxZjIyM2MwMQ0KPiAgICBSRFg6IGZmNGUzZWFhY2Y0MmEx
NDAgUlNJOiBmZjRlM2ViMzFmMjIzYzAwIFJESTogZmY0ZTNlYWFjZjQyYTEzOA0KPiAgICBSQlA6
IGZmOGUwNmNmODc2MmZkZDAgUjA4OiAwMDAwMDAwMDAwMDAwMGJmIFIwOTogMDAwMDAwMDAwMDAw
MDAwMA0KPiAgICBSMTA6IDAwMDAwMGViOGViZWFiNTMgUjExOiBmZmZmZmZmZjkzNDUzMjU4IFIx
MjogMDAwMDAwMDAwMDAwMDAwMg0KPiAgICBSMTM6IGZmNGUzZWFhY2Y0MmExMzAgUjE0OiBmZjhl
MDZjZjg3NjJmZTJjIFIxNTogZmY0ZTNlYWI0NDczMzgyOA0KPiAgICBGUzogIDAwMDAwMDAwMDAw
MDAwMDAoMDAwMCkgR1M6ZmY0ZTNlYWIxZmQwMDAwMCgwMDAwKSBrbmwNCj4gICAgR1M6MDAwMDAw
MDAwMDAwMDAwMA0KPiAgICBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAw
MDgwMDUwMDMzDQo+ICAgIENSMjogMDAwMDAwMDAwMDAwMDA1MCBDUjM6IDAwMDAwMDBmOGY4MGEw
MDQgQ1I0OiAwMDAwMDAwMDAwNzYxZWUwDQo+ICAgIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6
IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwDQo+ICAgIERSMzogMDAwMDAw
MDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+
ICAgIFBLUlU6IDU1NTU1NTU0DQo+ICAgIENhbGwgVHJhY2U6DQo+ICAgID8gcmVwb3J0X25vcm1h
bF9kZXRlY3RlZCsweDIwLzB4MjANCj4gICAgcmVwb3J0X2Zyb3plbl9kZXRlY3RlZCsweDE2LzB4
MjANCj4gICAgcGNpX3dhbGtfYnVzKzB4NzUvMHg5MA0KPiAgICA/IGRwY19pcnErMHg5MC8weDkw
DQo+ICAgIHBjaWVfZG9fcmVjb3ZlcnkrMHgxNTcvMHgyMDENCj4gICAgPyBpcnFfZmluYWxpemVf
b25lc2hvdC5wYXJ0LjQ3KzB4ZTAvMHhlMA0KPiAgICBkcGNfaGFuZGxlcisweDI5LzB4NDANCj4g
ICAgaXJxX3RocmVhZF9mbisweDI0LzB4NjANCj4gICAgaXJxX3RocmVhZCsweGVhLzB4MTcwDQo+
ICAgID8gaXJxX2ZvcmNlZF90aHJlYWRfZm4rMHg4MC8weDgwDQo+ICAgID8gaXJxX3RocmVhZF9j
aGVja19hZmZpbml0eSsweGYwLzB4ZjANCj4gICAga3RocmVhZCsweDEyNC8weDE0MA0KPiAgICA/
IGt0aHJlYWRfcGFyaysweDkwLzB4OTANCj4gICAgcmV0X2Zyb21fZm9yaysweDFmLzB4MzANCj4g
ICAgTW9kdWxlcyBsaW5rZWQgaW46IG5mdF9maWJfaW5ldC4uLi4uLi4uLg0KPiAgICBDUjI6IDAw
MDAwMDAwMDAwMDAwNTANCg0KPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXku
c2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQoNCkFuZCBubywgdGhpcyBpcyBub3QgaG93IHRo
ZSB0YWdzIGFyZSBiZWluZyBhcHBsaWVkLg0KDQoNCi0tDQpXaXRoIEJlc3QgUmVnYXJkcywNCkFu
ZHkgU2hldmNoZW5rbw0K
