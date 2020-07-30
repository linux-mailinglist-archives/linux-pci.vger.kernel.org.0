Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705D8233B9C
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 00:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgG3W6L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 18:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgG3W6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2020 18:58:09 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0CBC061574
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 15:58:09 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7876B8066C;
        Fri, 31 Jul 2020 10:58:04 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1596149884;
        bh=RbVCEkYiIo113LiclSdCPmwd7Z4op8xK+9phR72pNYA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=TILig4iYZQds39R0cOsd1QzFQet+TJRHuGsv3iJAbH9Ij1yIrnVEEk/v3uWS8sBok
         iftR+T6Ci/C0iHt8fodJaBPJCN+vQp0q68Qichh09UlVqIuPzWpL2/RWss5eJnfWgk
         asvRhaR/23fSrD2wAtlCAUdm0xPHnDWT2yAx1Vajja/tx0h4fayM977fN3DqDjvXL2
         bLcaWBkCftlKv4VU295eqB6nx/1/4TbGH55wyCOpbQ6XR+CMAvMOCM1z6PjzbbpNlY
         R8kO3A3ElVhA1+46+Vzb2vTv8Wwhd3Ko9mwgHjZgDfzCNX5lM15hHOM8PWGQqOLHoV
         nNuRZEVUp44AQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f23507a0001>; Fri, 31 Jul 2020 10:58:02 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 31 Jul 2020 10:58:04 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Fri, 31 Jul 2020 10:58:04 +1200
From:   Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI: iproc: Stop using generic config read/write
 functions
Thread-Topic: [PATCH 2/3] PCI: iproc: Stop using generic config read/write
 functions
Thread-Index: AQHWZiLShW7/hIyd+02gOchr4KBXl6kfgk0AgAByBYA=
Date:   Thu, 30 Jul 2020 22:58:03 +0000
Message-ID: <5ee5e0f76435883d6f5eec9f6483e283e2e652e0.camel@alliedtelesis.co.nz>
References: <20200730160958.GA2038661@bjorn-Precision-5520>
In-Reply-To: <20200730160958.GA2038661@bjorn-Precision-5520>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:23:2150:a287:ad2f:f26b]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA0756D425D80245996E0B8C5C7B91E5@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTA3LTMwIGF0IDExOjA5IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBJIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byBoYXZlIGEgd2FybmluZyBvbmNlIHBlciBk
ZXZpY2UsIHNvIGlmDQo+IFhZWiBkZXZpY2UgaGFzIGEgcHJvYmxlbSBhbmQgd2UgbG9vayBhdCB0
aGUgZG1lc2cgbG9nLCB3ZSB3b3VsZCBmaW5kIGENCj4gc2luZ2xlIG1lc3NhZ2UgZm9yIGRldmlj
ZSBYWVogYXMgYSBoaW50LiAgV291bGQgdGhhdCByZWR1Y2UgdGhlDQo+IG51aXNhbmNlIGxldmVs
IGVub3VnaD8NCg0KV2Ugd291bGQgYmUgT0sgd2l0aCB0aGF0Lg0KDQo+IFNvIEkgdGhpbmsgSSBk
aWQgaXQgd3JvbmcgaW4gZmIyNjU5MjMwMTIwICgiUENJOiBXYXJuIG9uIHBvc3NpYmxlIFJXMUMN
Cj4gY29ycnVwdGlvbiBmb3Igc3ViLTMyIGJpdCBjb25maWcgd3JpdGVzIikuICBSYXRlbGltaXRp
bmcgaXMgdGhlIHdyb25nDQo+IGNvbmNlcHQgYmVjYXVzZSB3aGF0IHdlIHdhbnQgaXMgYSBzaW5n
bGUgd2FybmluZyBwZXIgZGV2aWNlLCBub3QgYQ0KPiBsaW1pdCBvbiB0aGUgc2ltaWxhciBtZXNz
YWdlcyBmb3IgKmFsbCogZGV2aWNlcywgbWF5YmUgc29tZXRoaW5nIGxpa2UNCj4gdGhpczoNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9hY2Nlc3MuYyBiL2RyaXZlcnMvcGNpL2FjY2Vz
cy5jDQo+IGluZGV4IDc5YzRhMmVmMjY5YS4uZTVmOTU2YjdlM2I3IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3BjaS9hY2Nlc3MuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9hY2Nlc3MuYw0KPiBAQCAt
MTYwLDkgKzE2MCwxMiBAQCBpbnQgcGNpX2dlbmVyaWNfY29uZmlnX3dyaXRlMzIoc3RydWN0IHBj
aV9idXMgKmJ1cywgdW5zaWduZWQgaW50IGRldmZuLA0KPiAgCSAqIHdyaXRlIGhhcHBlbiB0byBo
YXZlIGFueSBSVzFDICh3cml0ZS1vbmUtdG8tY2xlYXIpIGJpdHMgc2V0LCB3ZQ0KPiAgCSAqIGp1
c3QgaW5hZHZlcnRlbnRseSBjbGVhcmVkIHNvbWV0aGluZyB3ZSBzaG91bGRuJ3QgaGF2ZS4NCj4g
IAkgKi8NCj4gLQlkZXZfd2Fybl9yYXRlbGltaXRlZCgmYnVzLT5kZXYsICIlZC1ieXRlIGNvbmZp
ZyB3cml0ZSB0byAlMDR4OiUwMng6JTAyeC4lZCBvZmZzZXQgJSN4IG1heSBjb3JydXB0IGFkamFj
ZW50IFJXMUMgYml0c1xuIiwNCj4gKwlpZiAoIShidXMtPnVuc2FmZV93YXJuICYgKDEgPDwgZGV2
Zm4pKSkgew0KPiArCQlkZXZfd2FybigmYnVzLT5kZXYsICIlZC1ieXRlIGNvbmZpZyB3cml0ZSB0
byAlMDR4OiUwMng6JTAyeC4lZCBvZmZzZXQgJSN4IG1heSBjb3JydXB0IGFkamFjZW50IFJXMUMg
Yml0c1xuIiwNCj4gIAkJCSAgICAgc2l6ZSwgcGNpX2RvbWFpbl9ucihidXMpLCBidXMtPm51bWJl
ciwNCj4gIAkJCSAgICAgUENJX1NMT1QoZGV2Zm4pLCBQQ0lfRlVOQyhkZXZmbiksIHdoZXJlKTsN
Cj4gKwkJYnVzLT51bnNhZmVfd2FybiB8PSAxIDw8IGRldmZuOw0KPiArCX0NCg0KQXMgSSB1bmRl
cnN0YW5kIGl0LCBkZXZmbiBpcyBhbiA4LWJpdCB2YWx1ZSB3aXRoIGZpdmUgYml0cyBvZiBkZXZp
Y2UNCmFuZCB0aHJlZSBiaXRzIG9mIGZ1bmN0aW9uLiBTbyAoMSA8PCBkZXZmbikgaXMgbm90IGdv
aW5nIHRvIGZpdCBpbiBhbg0KOC1iaXQgbWFzay4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZyBoZXJl
PyAoSSBkbyBhZG1pdCB0aGF0IG15IFBDSQ0Ka25vd2xlZGdlIGlzIG5vdCBncmVhdCkuDQoNCg0K
