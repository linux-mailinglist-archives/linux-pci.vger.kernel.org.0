Return-Path: <linux-pci+bounces-6549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E158ADB6C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 03:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CB71F21223
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 01:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774BA10949;
	Tue, 23 Apr 2024 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="BC5m/mQn"
X-Original-To: linux-pci@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A61F9D4
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2024 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834758; cv=none; b=Yu+K/ZKkfVqvbaioEEwBMo8eAeYxsWTxA+TBHn0kuKuifKQ7MAdFpeQ9QKKxuADi8QlkG2fCBCLNdOyqqjenL6bv4qofmFnuWdO6iRytObYkMK0u2m25WNcRSagWIxecQp31knrj2c3nLAClmjSqsJ/2x0rWBQUlXFClkQu2w44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834758; c=relaxed/simple;
	bh=obnCv2ejxmQAf1KycED7Pt69rTtXHiQl8HcqBdTJCQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lTfvwaFcQYaqcTeyn79yNAuxZjptnKrBzUylNjpzJX8D+o5asSaFRfdKwoubedYpkTOjRr6qPIlLyFkBTBMhx/cOZcrPrt4IrzbWZM0CcpC1qG71nD29xUTu8IqC5LehUwKgkJoLyKKRKsyB45X4ZR7NUCGEM8lyx7X32dnr+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=BC5m/mQn; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CABA22C0358;
	Tue, 23 Apr 2024 13:12:33 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1713834753;
	bh=obnCv2ejxmQAf1KycED7Pt69rTtXHiQl8HcqBdTJCQo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BC5m/mQnUrLM3l59KEzW8jJf9nqvN8ESoerGXmDQJ7o7nOBtsF9RL5z5m3SsCnFSv
	 +R7z7SeYLTPbvnUaO0Nf0O6PK/W7prlA4+L+6Uyq5XFfZ+N7mcBnIwnBUj3lY8azRW
	 wqtvL36X9YXLX3+d7A3eQ6pVCk/e9nNeyl0qm3aQ7Gyig+En1uteHjTzeA4QsD6ND4
	 N13lLqTPYFtSyfd6o3Hm+zmhvGHYyoqziB/rJzaoSFTsDQqjZBXh2M8W6Ywa+EV+Ud
	 xw7YI7fkhGoOZnmAcg1kJZj0pwBYNUbyC26x7KEhtFFCSHzNlqtoy9GTNtHZ/xjTRO
	 vezjD8JR5lWXA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66270b010001>; Tue, 23 Apr 2024 13:12:33 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 13:12:33 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Tue, 23 Apr 2024 13:12:33 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Herve Codina
	<herve.codina@bootlin.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: local bus enumeration beyond a PCI device
Thread-Topic: local bus enumeration beyond a PCI device
Thread-Index: AQHakSa58Ehmqkf3b0um4G7kLubeE7FzKqIAgAEgiYA=
Date: Tue, 23 Apr 2024 01:12:33 +0000
Message-ID: <11b9ff3a-514e-4c50-88c2-fd6f53398b9c@alliedtelesis.co.nz>
References: <bad63409-ed2b-4cef-988b-3c143636e9fa@alliedtelesis.co.nz>
 <ZiYY9u7uL7hnetFU@surfacebook.localdomain>
In-Reply-To: <ZiYY9u7uL7hnetFU@surfacebook.localdomain>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8B84613AFE57E4BBCE3BA997CE1CF2F@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=66270b01 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=Xj66QVUaDVOFW09HLocA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyMi8wNC8yNCAxOTo1OSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBUaHUsIEFwciAx
OCwgMjAyNCBhdCAxMjoyNDowNkFNICswMDAwLCBDaHJpcyBQYWNraGFtIGtpcmpvaXR0aToNCj4+
IEhpLA0KPj4NCj4+IFdlJ3ZlIGdvdCBhIGN1c3RvbSB4ODZfNjQgYmFzZWQgZGVzaWduIHRoYXQg
aXMgdXNpbmcgYW4gQVNJWDkxMDAgdG8NCj4+IHByb3ZpZGUgYSBQQ0kgdG8gbG9jYWwgYnVzIGJy
aWRnZS4gQXR0YWNoZWQgdG8gdGhhdCBsb2NhbCBidXMgaXMgYW4gRlBHQQ0KPj4gd2hpY2ggbW9z
dGx5IHByb3ZpZGVzIHNvbWUgR1BJT3MgYWNjZXNzZWQgdmlhIHJlZ2lzdGVycyBvbiB0aGUgbG9j
YWwNCj4+IGJ1cy4gUmlnaHQgbm93IHdlJ3ZlIGdvdCBhIGN1c3RvbSBkcml2ZXIgdGhhdCBidW5k
bGVzIGV2ZXJ5dGhpbmcNCj4+IHRvZ2V0aGVyIHNvIGVmZmVjdGl2ZWx5IHdlJ3ZlIGdvdCBhIFBD
SSBkZXZpY2UgdGhhdCBwcm92aWRlcyBHUElPcy4NCj4+DQo+PiBCdXQgYXMgdGhpbmdzIGNhbiBj
aGFuZ2UgYmFzZWQgb24gdGhlIEZQR0EgcHJvZ3JhbSBJJ2QgbGlrZSBzb21lDQo+PiBmbGV4aWJp
bGl0eSB0byB0cmVhdCBpdCBzZXBhcmF0ZWx5IGZyb20gdGhlIFBDSSBicmlkZ2UuDQo+IFdoeT8g
QUZBSVUgdGhlIGFyY2hpdGVjdHVyZSwgeW91IGhhdmUgYW4gRlBHQSB3aXRoIGEgcmVhbCBQQ0kg
YnJpZGdlIC8gc3dpdGNoLA0KPiBubz8gSWYgaXQncyB0aGUgY2FzZSwgdGhlIHNvZnR3YXJlIHNo
b3VsZG4ndCBjYXJlIGlmIHRoZSByZXNwZWN0aXZlIElQIGNvbWVzDQo+IGZyb20gRlBHQSBvciBT
b0MuDQoNCk5vIHRoZSBGUEdBIGhhcyBhIHBhcmFsbGVsIGludGVyZmFjZS4gV2UgZGlkIHRyeSB0
byBwdXNoIHRoZSBIVyANCmRlc2lnbmVycyBpbnRvIHVzaW5nIGEgRlBHQSB3aXRoIGEgcHJvcGVy
IFBDSS1lIGludGVyZmFjZSBidXQgdGhleSANCnNpZ2h0ZWQgcmVhc29ucyBvZiBjb3N0IGFuZCBz
Y2hlZHVsZSBzbyB0aGV5IGVuZGVkIHVwIGFkZGluZyB0aGUgDQpBU0lYOTEwMCBzbyB0aGV5IGNv
dWxkIHJlLXVzZSBhIGxvdCBvZiB0aGUgZGVzaWduIHRoZXkgaGFkIGZyb20gYW4gb2xkZXIgDQpw
cm9kdWN0Lg0KDQo+DQo+PiBTbyByZWFsbHkgSSdkDQo+PiBsaWtlIHRvIGhhdmUgYSBQQ0kgZGV2
aWNlIGRyaXZlciBmb3IgdGhlIEFTSVg5MTAwIHRoYXQgcHJvdmlkZXMgYSBsb2NhbA0KPj4gYnVz
IGNvbnRyb2xsZXIgYW5kIGEgKHBsYXRmb3JtPykgZHJpdmVyIGZvciB0aGUgRlBHQSB0aGF0IHBy
b3ZpZGVzIHRoZQ0KPj4gR1BJT3Mgd2hlcmUgSSBjYW4gaGF2ZSBkaWZmZXJlbnQgY29tcGF0aWJs
ZXMgZm9yIHRoZSBkaWZmZXJlbnQNCj4+IGltcGxlbWVudGF0aW9ucy4NCj4+DQo+PiBUaGVuIGlu
IHRoZSBBQ1BJIG92ZXJsYXkgSSdkIGhhdmUgc29tZXRoaW5nIGxpa2UNCj4+DQo+PiAgIMKgwqDC
oCBTY29wZSAoXF9TQi5QQ0kwLkQwQjApDQo+PiAgIMKgwqDCoCB7DQo+PiAgIMKgwqDCoMKgwqDC
oMKgIERldmljZSAoQVNJWCkNCj4+ICAgwqDCoMKgwqDCoMKgwqAgew0KPj4gICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIE5hbWUgKF9BRFIsIDB4MDAwMCkNCj4+DQo+PiAgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIERldmljZSAoRlBHQSkNCj4+ICAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgew0KPj4gICDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBOYW1lIChfSElELCAiUFJQ
MDAwMSIpDQo+PiAgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIE5h
bWUgKF9EU0QsIFBhY2thZ2UgKCkNCj4+ICAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgew0KPj4gVG9VVUlEKCJkYWZmZDgxNC02ZWJhLTRkOGMtOGE5MS1iYzliYmY0
YWEzMDEiKSwNCj4+ICAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgUGFja2FnZSAoKQ0KPj4gICDCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCB7DQo+PiAgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgwqDCoMKgIFBhY2thZ2UgKCkgew0KPj4gImNvbXBhdGlibGUiLCAibXkt
cGxhdGZvcm0tZHJpdmVyLWZvci1mcGdhIiB9LA0KPj4gICDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCB9DQo+PiAgIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIH0pDQo+PiAgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIH0NCj4+ICAgwqDCoMKgwqDCoMKgwqAgfQ0KPj4gICDCoMKgwqAgfQ0KPj4NCj4+ICAg
wqDCoCBTY29wZShcX1NCKQ0KPj4gICDCoMKgIHsNCj4+ICAgwqDCoMKgIMKgwqDCoCBEZXZpY2Uo
T1RIUikNCj4+ICAgwqDCoMKgIMKgwqDCoCB7DQo+PiAgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIEdw
aW9JbyAoRXhjbHVzaXZlLCBQdWxsVXAsIDAsIDAsIElvUmVzdHJpY3Rpb25JbnB1dE9ubHksDQo+
PiAiXFxfU0IuUENJMC5EMEIwLkFTSVguRlBHQSIsKSB7IDAgfQ0KPj4gICDCoMKgwqAgwqDCoMKg
IH0NCj4+ICAgwqDCoCB9DQo+Pg0KPj4gSXMgaXQgZXZlbiBwb3NzaWJsZSB0byByZWdpc3RlciBh
IGhvc3QgY29udHJvbGxlciBmb3IgYW5vdGhlciBwbGF0Zm9ybSBidXM/DQo+IEFGQUlLIHRoZXJl
IGlzIGFuIEZQR0EgZnJhbWV3b3JrIGluIHRoZSBrZXJuZWwgYW5kIHRoZSBpZGVhIGlzIHRoYXQg
ZWFjaCBGUEdBDQo+IGNvbmZpZ3VyYXRpb24gcHJvdmlkZXMgYSBjb21wbGltZW50YXJ5IERUIHRv
IGRlc2NyaWJlIHRoZSBoYXJkd2FyZSBzZXR1cC4gQXMNCj4gQmpvcm4gQ2MnZWQgdGhpcyB0byBI
ZXJ2ZSB5b3UgbWF5IGdldCB0aGUgYW5zd2VyIG9uIHdoYXQncyBnb2luZyBvbiB0aGVyZSBtdWNo
DQo+IGJldHRlciBhcyBJJ20gbm90IGludm9sdmVkIGluIHRoZSBkZXZlbG9wbWVudCBvZiB0aGF0
IHRvcGljLg0KSSBkbyBuZWVkIHRvIGhhdmUgYSBiZXR0ZXIgbG9vayBhdCB0aGUgRlBHQSBmcmFt
ZXdvcmsgaW4gdGhlIGtlcm5lbC4gDQpXZSd2ZSBtb3N0bHkgZG9uZSB3aXRob3V0IGl0IG9uIG90
aGVyIHByb2R1Y3RzLg==

