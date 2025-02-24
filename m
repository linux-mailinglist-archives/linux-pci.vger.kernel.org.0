Return-Path: <linux-pci+bounces-22235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F69A42775
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D304167F74
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D54625A626;
	Mon, 24 Feb 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cd/sX5Sg"
X-Original-To: linux-pci@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA62F18A6C5;
	Mon, 24 Feb 2025 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413395; cv=none; b=HupoY8KEj+h8b5ddtu5z6EujOE2xw2MXcej6UWQ8DEIEjA/Ris5yoQnBwapfISfZZHODvYHvOFDkmYgqdUPZp74gITeqU304vcK8P99DCU3I2eUJdX1JpNf6PUBjcVD7YytotUptK79OYOkpgZNuaXxISzhGfvq3JKiDPvUD4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413395; c=relaxed/simple;
	bh=L9CWPAygDat2kwgV7NCLs+GA+v1omXAmM01KJFWX3UM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ILLqP+vhGV11wVsHS17dSPdqwl12fezzNc81neE020QPXSKgm9sskZOnvT7hjI3OwD35arWImvveuE1Nngkkv9pSsJarKpJa2nnhgxX0gFnm3bl/BnTUd0dY7Sf/5Zg5onvx1nAUmBcwMNxLeJfrazYIkhssgTHYtEfErTcGwxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cd/sX5Sg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51OG9IGF03862788, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740413358; bh=L9CWPAygDat2kwgV7NCLs+GA+v1omXAmM01KJFWX3UM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cd/sX5SgXgt6oRaboEvF8VH1DOHRhz5xpGLGOqqUlnzc77Dm6DCszXv3lNQ9Jvjzw
	 S48i+yjWndsOdSggFIvR6aEv/ZPX0MeHIvaswYHraBelf9TTr/7UaH6M+jVGfSftqt
	 3dRf8zkMAfVwAn07IQVDtj8CUYcDXPGnqfLaWlpzX+eDnKFvmHIFEr90lpgN5cPm/A
	 aCSPowC7WaAiwsT4IbTG9NXNETni6sBERh1jWarpCeX0IbVpSXmN2Kt0jkxZt3kLcD
	 OLmgNFACbiegAlbiiKxWRfhKgUbqrprETUMUkjTku2v4jCx9VxXcJkTVMCTMBJFSQt
	 OErorTAcjOuRA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51OG9IGF03862788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 00:09:18 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Feb 2025 00:09:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 25 Feb 2025 00:09:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Tue, 25 Feb 2025 00:09:17 +0800
From: Hau <hau@realtek.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd <nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH net-next 3/3] r8169: disable RTL8126 ZRX-DC timeout
Thread-Topic: [PATCH net-next 3/3] r8169: disable RTL8126 ZRX-DC timeout
Thread-Index: AQHbhDDVoVMCNA5PVkmxjTBHmfHyG7NRqDuAgAT2WwA=
Date: Mon, 24 Feb 2025 16:09:17 +0000
Message-ID: <021a99efc4ad4462a86f048d52e73ef0@realtek.com>
References: <20250221071828.12323-439-nic_swsd@realtek.com>
 <20250221071828.12323-442-nic_swsd@realtek.com>
 <8eadd7db-aeb8-4c2a-8758-e4dbd06788ca@gmail.com>
In-Reply-To: <8eadd7db-aeb8-4c2a-8758-e4dbd06788ca@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiANCj4gRXh0ZXJuYWwgbWFpbCA6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
dGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90DQo+IHJlcGx5LCBjbGljayBsaW5rcywgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+IE9uIDIxLjAyLjIwMjUgMDg6MTgsIENo
dW5IYW8gTGluIHdyb3RlOg0KPiA+IERpc2FibGUgaXQgZHVlIHRvIGl0IGRvc2Ugbm90IG1lZXQg
WlJYLURDIHNwZWNpZmljYXRpb24uIElmIGl0IGlzDQo+ID4gZW5hYmxlZCwgZGV2aWNlIHdpbGwg
ZXhpdCBMMSBzdWJzdGF0ZSBldmVyeSAxMDBtcy4gRGlzYWJsZSBpdCBmb3INCj4gPiBzYXZpbmcg
bW9yZSBwb3dlciBpbiBMMSBzdWJzdGF0ZS4NCj4gPg0KPiBJcyB0aGlzIGNvbXBsaWFudCB3aXRo
IHRoZSBQQ0llIHNwZWM/IE5vdCBiZWluZyBhbiBleHBlcnQgb24gdGhpcyB0b3BpYywgYnV0DQo+
IHdoZW4gSSByZWFkIGUuZy4gdGhlIGZvbGxvd2luZyB0aGVuIG15IHVuZGVyc3RhbmRpbmcgaXMg
dGhhdCB0aGlzIHdha2V1cA0KPiBldmVyeSAxMDBtcyBpcyB0aGUgZXhwZWN0ZWQgYmVoYXZpb3Iu
DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMTYxMDAzMzMyMy0xMDU2MC00LWdp
dC1zZW5kLWVtYWlsLQ0KPiBzaHJhZGhhLnRAc2Ftc3VuZy5jb20vVC8NCj4NClpSWC1EQyB0aW1l
b3V0IGlzIGZvciBMMS5JZGxlLCBub3QgZm9yIEwxIFN1YnN0YXRlLiBBbmQgYWNjb3JkaW5nIHRv
IHRoZSBzcGVjIGJlbG93LCBiZWNhdXNlIGl0IHdpbGwgcmVkdWNlIHBvd2VyIHNhdmluZywgaXQg
aXMgbm90IGVuY291cmFnZWQgdG8gaW1wbGVtZW50Lg0KU28gd2UgZGlzYWJsZSBpdCBmb3Igc2F2
aW5nIHBvd2VyLg0KDQpOZXh0IHN0YXRlIGlzIFJlY292ZXJ5IGFmdGVyIGEgMTAwIG1zIHRpbWVv
dXQgaWYgdGhlIGN1cnJlbnQgZGF0YSByYXRlIGlzIDguMCBHVC9zIG9yIGhpZ2hlciBhbmQgdGhl
IFBvcnTigJlzDQpSZWNlaXZlcnMgZG8gbm90IG1lZXQgdGhlIFpSWC1EQyBzcGVjaWZpY2F0aW9u
IGZvciAyLjUgR1QvcykuIEFsbCBQb3J0cyBhcmUgcGVybWl0dGVkLCBidXQgbm90IGVuY291cmFn
ZWQsIHRvDQppbXBsZW1lbnQgdGhlIHRpbWVvdXQgYW5kIHRyYW5zaXRpb24gdG8gUmVjb3Zlcnkg
d2hlbiB0aGUgZGF0YSByYXRlIGlzIDguMCBHVC9zIG9yIGhpZ2hlci4NCg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IENodW5IYW8gTGluIDxoYXVAcmVhbHRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jIHwgMTYgKysrKysrKysrKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+ID4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPiA+IGluZGV4IDk5NTNl
YWEwMWM5ZC4uN2E1Yjk5ZDU0ZTEyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
cmVhbHRlay9yODE2OV9tYWluLmMNCj4gPiBAQCAtMjg1MSw2ICsyODUxLDIxIEBAIHN0YXRpYyB1
MzIgcnRsX2NzaV9yZWFkKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwLA0KPiBpbnQgYWRkcikN
Cj4gPiAgICAgICAgICAgICAgIFJUTF9SMzIodHAsIENTSURSKSA6IH4wOyAgfQ0KPiA+DQo+ID4g
K3N0YXRpYyB2b2lkIHJ0bF9kaXNhYmxlX3pyeGRjX3RpbWVvdXQoc3RydWN0IHJ0bDgxNjlfcHJp
dmF0ZSAqdHApIHsNCj4gPiArICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRwLT5wY2lfZGV2
Ow0KPiA+ICsgICAgIHU4IHZhbDsNCj4gPiArDQo+ID4gKyAgICAgaWYgKHBkZXYtPmNmZ19zaXpl
ID4gMHgwODkwICYmDQo+ID4gKyAgICAgICAgIHBjaV9yZWFkX2NvbmZpZ19ieXRlKHBkZXYsIDB4
MDg5MCwgJnZhbCkgPT0gUENJQklPU19TVUNDRVNTRlVMDQo+ICYmDQo+ID4gKyAgICAgICAgIHBj
aV93cml0ZV9jb25maWdfYnl0ZShwZGV2LCAweDA4OTAsIHZhbCAmIH5CSVQoMCkpID09DQo+IFBD
SUJJT1NfU1VDQ0VTU0ZVTCkNCj4gPiArICAgICAgICAgICAgIHJldHVybjsNCj4gPiArDQo+ID4g
KyAgICAgbmV0ZGV2X25vdGljZV9vbmNlKHRwLT5kZXYsDQo+ID4gKyAgICAgICAgICAgICAiTm8g
bmF0aXZlIGFjY2VzcyB0byBQQ0kgZXh0ZW5kZWQgY29uZmlnIHNwYWNlLCBmYWxsaW5nIGJhY2sg
dG8NCj4gQ1NJXG4iKTsNCj4gPiArICAgICBydGxfY3NpX3dyaXRlKHRwLCAweDA4OTAsIHJ0bF9j
c2lfcmVhZCh0cCwgMHgwODkwKSAmIH5CSVQoMCkpOyB9DQo+ID4gKw0KPiA+ICBzdGF0aWMgdm9p
ZCBydGxfc2V0X2FzcG1fZW50cnlfbGF0ZW5jeShzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCwg
dTgNCj4gPiB2YWwpICB7DQo+ID4gICAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0cC0+cGNp
X2RldjsgQEAgLTM5MzAsNiArMzk0NSw3IEBAIHN0YXRpYw0KPiA+IHZvaWQgcnRsX2h3X3N0YXJ0
XzgxMjVkKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwKQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lk
IHJ0bF9od19zdGFydF84MTI2YShzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCkgIHsNCj4gPiAr
ICAgICBydGxfZGlzYWJsZV96cnhkY190aW1lb3V0KHRwKTsNCj4gPiAgICAgICBydGxfc2V0X2Rl
Zl9hc3BtX2VudHJ5X2xhdGVuY3kodHApOw0KPiA+ICAgICAgIHJ0bF9od19zdGFydF84MTI1X2Nv
bW1vbih0cCk7DQo+ID4gIH0NCg0K

