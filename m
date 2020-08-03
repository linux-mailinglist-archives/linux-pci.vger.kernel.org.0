Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60C2239DE2
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 05:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHCDmu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 23:42:50 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:60541 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgHCDmu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 23:42:50 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4FB80891B4;
        Mon,  3 Aug 2020 15:42:46 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1596426166;
        bh=UK5Yesl8PcfKR6GB5T/S8h+q9R2i2f165crNPy23iy4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=F+hHrVSFbu5hVas+QLi1cBPyg3l02W5jRa8QR9fnlkEVchnd5kYiDDA8eNQubZ91X
         xID8SAGmd9pf8SFkV/GsSlVC5e1zclRnblA9f3LjyOsts/4gYZRt5yE8JW+pK+2lmm
         H4NhXMf775ezWF9R4W5nqdwIzY8oLlgWLClQiRR/ftNDRbZIlcYTWY0wn5o21CM/py
         22tzY8I8rpkGEASYcL7JienBC4qiU5faKM+pHPxA7JrfuvnBMghCrBkUuDTTOo877q
         qYeMPZ/ZSe4tfOXsw3AHwCPHQw26shSejDSbG88kDCVBAC6rMDKa81Qscx5P40Fv2p
         GqeycldDkzFZg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f2787b60000>; Mon, 03 Aug 2020 15:42:46 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 3 Aug 2020 15:42:44 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Mon, 3 Aug 2020 15:42:44 +1200
From:   Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "ray.jui@broadcom.com" <ray.jui@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: Reduce warnings on possible RW1C corruption
Thread-Topic: [PATCH v2 2/2] PCI: Reduce warnings on possible RW1C corruption
Thread-Index: AQHWZuxKf5vjrrPtKkak35HkNMZ1kakhCJAAgAPwtwA=
Date:   Mon, 3 Aug 2020 03:42:44 +0000
Message-ID: <3dd532237ef5e332fc87d60c3a680e1c085f622e.camel@alliedtelesis.co.nz>
References: <20200731033956.6058-1-mark.tomlinson@alliedtelesis.co.nz>
         <20200731033956.6058-2-mark.tomlinson@alliedtelesis.co.nz>
         <CAL_JsqJgD_Ys3xjoJYuQ3R9bL7gUC+NKwkq71eTngj5uvcpk6Q@mail.gmail.com>
In-Reply-To: <CAL_JsqJgD_Ys3xjoJYuQ3R9bL7gUC+NKwkq71eTngj5uvcpk6Q@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:23:6972:428b:bb4b:5f2c]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C6A70295E38EA438D1BA4660595426D@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTMxIGF0IDA5OjMyIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
DQo+IElmIHdlIGRvbid0IHdhbnQgdG8ganVzdCB3YXJuIHdoZW4gYSA4IG9yIDE2IGJpdCBhY2Nl
c3Mgb2NjdXJzIChJJ20NCj4gbm90IHN1cmUgaWYgMzItYml0IG9ubHkgYWNjZXNzZXMgaXMgcG9z
c2libGUgb3IgY29tbW9uLiBTZWVtcyBsaWtlDQo+IFBDSV9DT01NQU5EIHdvdWxkIGFsd2F5cyBn
ZXQgd3JpdHRlbj8pLCB0aGVuIGEgc2ltcGxlIHdheSB0byBkbyB0aGlzDQo+IGlzIGp1c3QgbW92
ZSB0aGlzIG91dCBvZiBsaW5lIGFuZCBkbyBzb21ldGhpbmcgbGlrZSB0aGlzIHdoZXJlIHRoZSBi
dXMNCj4gb3IgZGV2aWNlIGlzIGNyZWF0ZWQvcmVnaXN0ZXJlZDoNCj4gDQo+IGlmIChidXMtPm9w
cy0+d3JpdGUgPT0gcGNpX2dlbmVyaWNfY29uZmlnX3dyaXRlMzIpDQo+ICAgICB3YXJuKCkNCj4g
DQpUaGlzIGRvZXNuJ3Qgd29yayBmb3IgbWFueSBvZiB0aGUgUENJIGRyaXZlcnMsIHNpbmNlIHRo
ZXkgd3JhcCB0aGUgY2FsbA0KdG8gcGNpX2dlbmVyaWNfY29uZmlnX3dyaXRlMzIoKSBpbiB0aGVp
ciBvd24gZnVuY3Rpb24uDQoNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9w
Y2kuaCBiL2luY2x1ZGUvbGludXgvcGNpLmgNCj4gPiBpbmRleCAzNGMxYzRmNDUyODguLjViNmFi
NTkzYWUwOSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BjaS5oDQo+ID4gKysrIGIv
aW5jbHVkZS9saW51eC9wY2kuaA0KPiA+IEBAIC02MTMsNiArNjEzLDcgQEAgc3RydWN0IHBjaV9i
dXMgew0KPiA+ICAgICAgICAgdW5zaWduZWQgY2hhciAgIHByaW1hcnk7ICAgICAgICAvKiBOdW1i
ZXIgb2YgcHJpbWFyeSBicmlkZ2UgKi8NCj4gPiAgICAgICAgIHVuc2lnbmVkIGNoYXIgICBtYXhf
YnVzX3NwZWVkOyAgLyogZW51bSBwY2lfYnVzX3NwZWVkICovDQo+ID4gICAgICAgICB1bnNpZ25l
ZCBjaGFyICAgY3VyX2J1c19zcGVlZDsgIC8qIGVudW0gcGNpX2J1c19zcGVlZCAqLw0KPiA+ICsg
ICAgICAgYm9vbCAgICAgICAgICAgIHVuc2FmZV93YXJuOyAgICAvKiB3YXJuZWQgYWJvdXQgUlcx
QyBjb25maWcgd3JpdGUgKi8NCj4gDQo+IE1ha2UgdGhpcyBhIGJpdGZpZWxkIG5leHQgdG8gJ2lz
X2FkZGVkJy4NCg0KV2lsbCBkbywgdGhhbmtzLg0KDQoNCg==
