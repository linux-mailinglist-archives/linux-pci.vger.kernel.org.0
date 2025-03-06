Return-Path: <linux-pci+bounces-23067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87972A551D5
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 17:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF03B165249
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE2A254AE0;
	Thu,  6 Mar 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="K+1U2b2s"
X-Original-To: linux-pci@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639F720C46A;
	Thu,  6 Mar 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279913; cv=none; b=lzyzcwjWI7rVfsmDa1qBzqjvpkySrCFHCigvt5Dj7AdS84fYwayoe55hml7TdXCQ1vHVljujfdiptqC0DT6iiWFx5EsZsfdQ7+ESdChnpKDfaYz8tMm7X3YVoitzmro265nc6J6IW2bTnA93povUpOvr6csK//EAR14JXiqAfio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279913; c=relaxed/simple;
	bh=cE1yEJj0gMGvn5F1IF6vuXcIQ+CL40SZ6KD27QX4buk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yv7Y4bJ4SqUCGp7EGwzGlprgzK3yr4eeIatrYwC9+L6GjJaYx963nbJyQQj9mIc9A0FwLRtCTrY30PRkaaPlSWRS3MFh4PlALxZnwx7EOYWG2BRx9EsMG+lp3/xfFY11cPWFDD3S6tjXl9R1pgbukttLYuEHKd5Z13e7H74LUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=K+1U2b2s; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 526GpLlxD3684601, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741279881; bh=cE1yEJj0gMGvn5F1IF6vuXcIQ+CL40SZ6KD27QX4buk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=K+1U2b2sCVikq2OfSeaILFwqJWGniV9wsFFhbHx1D1sf1yT2cIc7nEbtlHsEezvMr
	 naB+YUfsMqRx4DZm78o2B+lGM2d2hnbfKD+2qKZi+NgOA5M0S4hj+LdnpfrLxuLqD9
	 Hy59BMJc/xvqhsWwNf/upsNh5i9IWJdg5hk0JcHKb8nkgs5vd0474Sbdz7BNNatI5L
	 i8N7qG+eK6AsKZT3lHvh00FK/djMa/dZ83D2vPsgQ+Q8FuZu2Xif++IySpcuSGignh
	 E7bEomWv+XKK86wPDjBOTNbeoQIILb06fM4RoThaWpEMbuW725r4BU2Fa8pFtE2ltB
	 3DUSTVsBUIe5A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 526GpLlxD3684601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 00:51:21 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Mar 2025 00:51:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 7 Mar 2025 00:51:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 7 Mar 2025 00:51:20 +0800
From: Hau <hau@realtek.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: nic_swsd <nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH net-next 2/3] r8169: enable RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126 LTR support
Thread-Topic: [PATCH net-next 2/3] r8169: enable
 RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126 LTR support
Thread-Index: AQHbhDDVTTVwV7w1uka8N0QzZpghkbNRokGAgAUD0QD//6gagIAGi+OAgAmMNOA=
Date: Thu, 6 Mar 2025 16:51:20 +0000
Message-ID: <4f1486d2bf5248809f943d4c22fbd521@realtek.com>
References: <20250224190013.GA469168@bhelgaas>
 <7b32aa88-d3bc-4414-a124-59befc3dc098@gmail.com>
In-Reply-To: <7b32aa88-d3bc-4414-a124-59befc3dc098@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpbmVyIEthbGx3ZWl0
IFttYWlsdG86aGthbGx3ZWl0MUBnbWFpbC5jb21dDQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAx
LCAyMDI1IDY6NTggQU0NCj4gVG86IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz47
IEhhdSA8aGF1QHJlYWx0ZWsuY29tPg0KPiBDYzogbmljX3N3c2QgPG5pY19zd3NkQHJlYWx0ZWsu
Y29tPjsgYW5kcmV3K25ldGRldkBsdW5uLmNoOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVt
YXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyBC
am9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsNCj4gbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHBjaUB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCAyLzNdIHI4MTY5OiBlbmFi
bGUNCj4gUlRMODE2OEgvUlRMODE2OEVQL1JUTDgxNjhGUC9SVEw4MTI1L1JUTDgxMjYgTFRSIHN1
cHBvcnQNCj4gDQo+IA0KPiBFeHRlcm5hbCBtYWlsIDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZy
b20gb3V0c2lkZSB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QNCj4gcmVwbHksIGNsaWNrIGxpbmtz
LCBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5k
DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiANCj4gT24gMjQuMDIuMjAy
NSAyMDowMCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPiBPbiBNb24sIEZlYiAyNCwgMjAyNSBh
dCAwNDozMzo1MFBNICswMDAwLCBIYXUgd3JvdGU6DQo+ID4+PiBPbiAyMS4wMi4yMDI1IDA4OjE4
LCBDaHVuSGFvIExpbiB3cm90ZToNCj4gPj4+PiBUaGlzIHBhdGNoIHdpbGwgZW5hYmxlDQo+IFJU
TDgxNjhIL1JUTDgxNjhFUC9SVEw4MTY4RlAvUlRMODEyNS9SVEw4MTI2DQo+ID4+Pj4gTFRSIHN1
cHBvcnQgb24gdGhlIHBsYXRmb3JtcyB0aGF0IGhhdmUgdGVzdGVkIHdpdGggTFRSIGVuYWJsZWQu
DQo+ID4+Pg0KPiA+Pj4gV2hlcmUgaW4gdGhlIGNvZGUgaXMgdGhlIGNoZWNrIHdoZXRoZXIgcGxh
dGZvcm0gaGFzIGJlZW4gdGVzdGVkIHdpdGgNCj4gTFRSPw0KPiA+Pj4NCj4gPj4gTFRSIGlzIGZv
ciBMMSwyLiBCdXQgTDEgd2lsbCBiZSBkaXNhYmxlZCB3aGVuIHJ0bF9hc3BtX2lzX3NhZmUoKQ0K
PiA+PiByZXR1cm4gZmFsc2UuIFNvIExUUiBuZWVkcyBydGxfYXNwbV9pc19zYWZlKCkgdG8gcmV0
dXJuIHRydWUuDQo+ID4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogQ2h1bkhhbyBMaW4gPGhhdUBy
ZWFsdGVrLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVh
bHRlay9yODE2OV9tYWluLmMgfCAxMDgNCj4gPj4+PiArKysrKysrKysrKysrKysrKysrKysrDQo+
ID4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxMDggaW5zZXJ0aW9ucygrKQ0KPiA+Pj4+DQo+ID4+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+
ID4+Pj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPiA+Pj4+
IGluZGV4IDczMTMwMjM2MTk4OS4uOTk1M2VhYTAxYzlkIDEwMDY0NA0KPiA+Pj4+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+ID4+Pj4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4gPj4+PiBAQCAtMjk1NSw2
ICsyOTU1LDExMSBAQCBzdGF0aWMgdm9pZCBydGxfZGlzYWJsZV9leGl0X2wxKHN0cnVjdA0KPiA+
Pj4gcnRsODE2OV9wcml2YXRlICp0cCkNCj4gPj4+PiAgICAgICB9DQo+ID4+Pj4gIH0NCj4gPj4+
Pg0KPiA+Pj4+ICtzdGF0aWMgdm9pZCBydGxfc2V0X2x0cl9sYXRlbmN5KHN0cnVjdCBydGw4MTY5
X3ByaXZhdGUgKnRwKSB7DQo+ID4+Pj4gKyAgICAgc3dpdGNoICh0cC0+bWFjX3ZlcnNpb24pIHsN
Cj4gPj4+PiArICAgICBjYXNlIFJUTF9HSUdBX01BQ19WRVJfNzA6DQo+ID4+Pj4gKyAgICAgY2Fz
ZSBSVExfR0lHQV9NQUNfVkVSXzcxOg0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29j
cF93cml0ZSh0cCwgMHhjZGQwLCAweDkwMDMpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhf
bWFjX29jcF93cml0ZSh0cCwgMHhjZGQyLCAweDhjMDkpOw0KPiA+Pj4+ICsgICAgICAgICAgICAg
cjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGQ4LCAweDkwMDMpOw0KPiA+Pj4+ICsgICAgICAg
ICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGQ0LCAweDkwMDMpOw0KPiA+Pj4+ICsg
ICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGRhLCAweDkwMDMpOw0KPiA+
Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGQ2LCAweDkwMDMp
Ow0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGRjLCAw
eDkwMDMpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhj
ZGU4LCAweDg4N2EpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0
cCwgMHhjZGVhLCAweDkwMDMpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93
cml0ZSh0cCwgMHhjZGVjLCAweDhjMDkpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFj
X29jcF93cml0ZSh0cCwgMHhjZGVlLCAweDkwMDMpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgx
NjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGYwLCAweDhhNjIpOw0KPiA+Pj4+ICsgICAgICAgICAg
ICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGYyLCAweDkwMDMpOw0KPiA+Pj4+ICsgICAg
ICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGY0LCAweDg4M2UpOw0KPiA+Pj4+
ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGY2LCAweDkwMDMpOw0K
PiA+Pj4+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4+Pj4gKyAgICAgY2FzZSBSVExfR0lHQV9N
QUNfVkVSXzYxIC4uLiBSVExfR0lHQV9NQUNfVkVSXzY2Og0KPiA+Pj4+ICsgICAgICAgICAgICAg
cjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGQwLCAweDkwMDMpOw0KPiA+Pj4+ICsgICAgICAg
ICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGQyLCAweDg4OWMpOw0KPiA+Pj4+ICsg
ICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGQ4LCAweDkwMDMpOw0KPiA+
Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGQ0LCAweDhjMzAp
Ow0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGRhLCAw
eDkwMDMpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhj
ZGQ2LCAweDkwMDMpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0
cCwgMHhjZGRjLCAweDkwMDMpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93
cml0ZSh0cCwgMHhjZGU4LCAweDg4M2UpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFj
X29jcF93cml0ZSh0cCwgMHhjZGVhLCAweDkwMDMpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgx
NjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGVjLCAweDg4OWMpOw0KPiA+Pj4+ICsgICAgICAgICAg
ICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGVlLCAweDkwMDMpOw0KPiA+Pj4+ICsgICAg
ICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGYwLCAweDhDMDkpOw0KPiA+Pj4+
ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGYyLCAweDkwMDMpOw0K
PiA+Pj4+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4+Pj4gKyAgICAgY2FzZSBSVExfR0lHQV9N
QUNfVkVSXzQ2IC4uLiBSVExfR0lHQV9NQUNfVkVSXzUzOg0KPiA+Pj4+ICsgICAgICAgICAgICAg
cjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGQ4LCAweDkwMDMpOw0KPiA+Pj4+ICsgICAgICAg
ICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGRhLCAweDkwMDMpOw0KPiA+Pj4+ICsg
ICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGRjLCAweDkwMDMpOw0KPiA+
Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGQyLCAweDg4M2Mp
Ow0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhjZGQ0LCAw
eDhjMTIpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhj
ZGQ2LCAweDkwMDMpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4+Pj4gKyAgICAg
ZGVmYXVsdDoNCj4gPj4+PiArICAgICAgICAgICAgIGJyZWFrOw0KPiA+Pj4+ICsgICAgIH0NCj4g
Pj4+PiArfQ0KPiA+Pj4+ICsNCj4gPj4+PiArc3RhdGljIHZvaWQgcnRsX3Jlc2V0X3BjaV9sdHIo
c3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHApIHsNCj4gPj4+PiArICAgICBzdHJ1Y3QgcGNpX2Rl
diAqcGRldiA9IHRwLT5wY2lfZGV2Ow0KPiA+Pj4+ICsgICAgIHUxNiBjYXA7DQo+ID4+Pj4gKw0K
PiA+Pj4+ICsgICAgIHBjaWVfY2FwYWJpbGl0eV9yZWFkX3dvcmQocGRldiwgUENJX0VYUF9ERVZD
VEwyLCAmY2FwKTsNCj4gPj4+PiArICAgICBpZiAoY2FwICYgUENJX0VYUF9ERVZDVEwyX0xUUl9F
Tikgew0KPiA+Pj4+ICsgICAgICAgICAgICAgcGNpZV9jYXBhYmlsaXR5X2NsZWFyX3dvcmQocGRl
diwgUENJX0VYUF9ERVZDVEwyLA0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgUENJX0VYUF9ERVZDVEwyX0xUUl9FTik7DQo+ID4+Pj4gKyAgICAgICAgICAg
ICBwY2llX2NhcGFiaWxpdHlfc2V0X3dvcmQocGRldiwgUENJX0VYUF9ERVZDVEwyLA0KPiA+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBDSV9FWFBfREVWQ1RMMl9M
VFJfRU4pOw0KPiA+Pj4NCj4gPj4+IEknZCBwcmVmZXIgdGhhdCBvbmx5IFBDSSBjb3JlIGRlYWxz
IHdpdGggdGhlc2UgcmVnaXN0ZXJzIChmdW5jdGlvbnMNCj4gPj4+IGxpa2UgcGNpX2NvbmZpZ3Vy
ZV9sdHIoKSkuIEFueSBzcGVjaWZpYyByZWFzb24gZm9yIHRoaXMgcmVzZXQ/IElzIGl0DQo+ID4+
PiBzb21ldGhpbmcgd2hpY2ggY291bGQgYmUgYXBwbGljYWJsZSBmb3Igb3RoZXIgZGV2aWNlcyB0
b28sIHNvIHRoYXQNCj4gPj4+IHRoZSBQQ0kgY29yZSBzaG91bGQgYmUgZXh0ZW5kZWQ/DQo+ID4+
Pg0KPiA+PiBJdCBpcyBmb3Igc3BlY2lmaWMgcGxhdGZvcm0uIE9uIHRoYXQgcGxhdGZvcm0gZHJp
dmVyIG5lZWRzIHRvIGRvIHRoaXMNCj4gPj4gdG8gbGV0IExUUiB3b3Jrcy4NCj4gPg0KPiBJIGlu
dGVycHJldCB0aGlzIGluIGEgd2F5IHRoYXQgdGhlIGNoaXAgdHJpZ2dlcnMgc29tZSBpbnRlcm5h
bCBMVFIgY29uZmlndXJhdGlvbg0KPiBhY3Rpdml0eSBpZiBpdCBkZXRlY3RzIGJpdCBQQ0lfRVhQ
X0RFVkNUTDJfTFRSX0VOIGNoYW5naW5nIGZyb20gMCB0byAxLiBBbmQNCj4gdGhpcyBuZWVkZWQg
YWN0aXZpdHkgaXNuJ3QgdHJpZ2dlcmVkIGlmIFBDSV9FWFBfREVWQ1RMMl9MVFJfRU4gaXMgc2V0
IGFscmVhZHkNCj4gYW5kIGRvZXNuJ3QgY2hhbmdlLg0KPiBIYXUsIGlzIHRoaXMgY29ycmVjdD8N
Cj4gDQpJdCBtYXkgYmUgdGhlIHJlYXNvbiBmb3IgdGhlIExUUiAgb2YgdGhlc2UgcGxhdGZvcm1z
IHRvIHdvcmsuIEJ1dCBJIHdpbGwgcmVtb3ZlIHRoaXMNCnF1aXJrIGZyb20gbmV4dCB2ZXJzaW9u
ICBwYXRjaC4NCg0KPiBTbyB0aGUgUENJX0VYUF9ERVZDVEwyX0xUUl9FTiByZXNldCBpcyBzb21l
IGtpbmQgb2YgbmVlZGVkIHF1aXJrLg0KPiBIb3dldmVyIFBDSSBxdWlya3MgYXJlIGFwcGxpZWQg
dG9vIGVhcmx5LCBiZWZvcmUgd2UgZXZlbiBkZXRlY3RlZCB0aGUgY2hpcA0KPiB2ZXJzaW9uIGlu
IHByb2JlKCkuIFRoZXJlZm9yZSBJIGFsc28gdGhpbmsgYSBoZWxwZXIgZm9yIHRoaXMgcmVzZXQg
aW4gUENJIGNvcmUNCj4gd291bGQgYmUgYmVzdC4NCj4gDQo+IEFuZCB3aGF0IGhhc24ndCBiZWVu
IG1lbnRpb25lZCB5ZXQ6IFdlIGhhdmUgdG8gc2tpcCB0aGUgY2hpcC1zcGVjaWZpYyBMVFINCj4g
Y29uZmlndXJhdGlvbiBpZiBwY2lfZGV2LT5sdHJfcGF0aCBpc24ndCBzZXQuDQo+IA0KSSB3aWxs
IGFkZCBjaGVja2luZyBwY2lfZGV2LT5sdHJfcGF0aCBpbiBuZXh0IHZlcnNpb24gcGF0Y2guDQoN
Cj4gPiBUaGlzIGRlZmluaXRlbHkgbG9va3MgbGlrZSBjb2RlIHRoYXQgc2hvdWxkIG5vdCBiZSBp
biBhIGRyaXZlci4NCj4gPiBEcml2ZXJzIHNob3VsZG4ndCBuZWVkIHRvIHRvdWNoIEFTUE0gb3Ig
TFRSIGNvbmZpZ3VyYXRpb24gdW5sZXNzDQo+ID4gdGhlcmUncyBhIGRldmljZSBkZWZlY3QgdG8g
d29yayBhcm91bmQsIGFuZCB0aGF0IHNob3VsZCB1c2UgYSBQQ0kgY29yZQ0KPiA+IGludGVyZmFj
ZS4gIERlcGVuZGluZyBvbiB3aGF0IHRoZSBkZWZlY3QgaXMsIHdlIG1heSBuZWVkIHRvIGFkZCBh
IG5ldw0KPiA+IGludGVyZmFjZS4NCj4gPg0KPiA+IFRoaXMgY2xlYXIvc2V0IG9mIFBDSV9FWFBf
REVWQ1RMMl9MVFJfRU4gd2hlbiBpdCB3YXMgYWxyZWFkeSBzZXQgY291bGQNCj4gPiB3b3JrIGFy
b3VuZCBzb21lIGtpbmQgb2YgZGV2aWNlIGRlZmVjdCwgb3IgaXQgY291bGQgYmUgYSBoaW50IHRo
YXQNCj4gPiBzb21ldGhpbmcgaW4gdGhlIFBDSSBjb3JlIGlzIGJyb2tlbi4gIE1heWJlIHRoZSBj
b3JlIGlzIGNvbmZpZ3VyaW5nDQo+ID4gQVNQTS9MVFIgaW5jb3JyZWN0bHkuDQo+ID4NCj4gPiBC
am9ybg0KDQo=

