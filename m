Return-Path: <linux-pci+bounces-6548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440308ADB64
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 03:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A391C21099
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 01:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90339101E6;
	Tue, 23 Apr 2024 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="jsK+vCzc"
X-Original-To: linux-pci@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77778EEA9
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2024 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834327; cv=none; b=ki01YeXVlLwm+cX/JS1k0uxmKpqS8fugny1ZtUeZznVucwT17EOJH2FKHb/HwBfWyE1qBHWB/61dVeQhh/0RXJ/5xkKWNNosX3quwzseBBgGoenwYvQqm0tMYFicmyv4ULivEoVinq5yCv/ibNJ5eaBFl62RNiqWVh1v8Rbk5oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834327; c=relaxed/simple;
	bh=Ys9eBif2EXRWvkxwaOL53LJ7BDs+h10YaUlHu4IfCNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lIdck5nwpK5GL3mk4aeh1r0KXttK89q9t2+B9HxwPmv1St4QBXMSDh2isOQ1KzAKMC5cOUmcRGc3PTGFXO4YzGFTHaJAOvZMZYl9FroOHdRoGdnzFgpFb5+Mq9qy9Y5b8DjR6v30LinEz4dWqfu8w4oeeQ5qIbC9fgX/48j7D7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=jsK+vCzc; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 108D92C0358;
	Tue, 23 Apr 2024 13:05:22 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1713834322;
	bh=Ys9eBif2EXRWvkxwaOL53LJ7BDs+h10YaUlHu4IfCNY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=jsK+vCzcaBHccAezXGTKrK8AAzDWUnEburgXUXL2ZlBRXMnCEZBwAAKN4lVAx9Sbk
	 9wU/eEmBR64QeCjbqjiyOeonjbaqpUEDGzWG83TMJ3y85EwPJGPEAkw+avckN3N7AC
	 wlKafIY04aPFbMKp5Rt1qCyM132gAmNkd0B62ZChzkiXZe+ToAIwkxtwzdNyesiOo8
	 MgC9mkCqPJJFXKqqCXUFAlqYkS6w3HEE7FEsDm1XZ1nuFjSobPkYw/bwW/EdDaNOkW
	 +fUhmJxrHBi4wP/QbU59y9B1iAN6H+UhPH15nqddsoIRUhfvwMjztgFcwsYhO1TbFO
	 7Xv+wkOQKeskQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B662709510001>; Tue, 23 Apr 2024 13:05:21 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 13:05:21 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Tue, 23 Apr 2024 13:05:21 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Herve Codina
	<herve.codina@bootlin.com>
Subject: Re: local bus enumeration beyond a PCI device
Thread-Topic: local bus enumeration beyond a PCI device
Thread-Index: AQHakSa58Ehmqkf3b0um4G7kLubeE7FtlbWAgAazc4A=
Date: Tue, 23 Apr 2024 01:05:21 +0000
Message-ID: <b7589f13-e851-4ec3-ade7-43981b345cb1@alliedtelesis.co.nz>
References: <20240418184531.GA245970@bhelgaas>
In-Reply-To: <20240418184531.GA245970@bhelgaas>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D74C541C61EF714E8AB3F2BDB1A26DBF@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=66270951 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=B1HeB8yAkB6dStQe3HsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
X-SEG-SpamProfiler-Score: 0

SGksDQoNCk9uIDE5LzA0LzI0IDA2OjQ1LCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiBbK2NjIEhl
cnZlXQ0KPg0KPiBPbiBUaHUsIEFwciAxOCwgMjAyNCBhdCAxMjoyNDowNkFNICswMDAwLCBDaHJp
cyBQYWNraGFtIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gV2UndmUgZ290IGEgY3VzdG9tIHg4Nl82
NCBiYXNlZCBkZXNpZ24gdGhhdCBpcyB1c2luZyBhbiBBU0lYOTEwMCB0bw0KPj4gcHJvdmlkZSBh
IFBDSSB0byBsb2NhbCBidXMgYnJpZGdlLiBBdHRhY2hlZCB0byB0aGF0IGxvY2FsIGJ1cyBpcyBh
biBGUEdBDQo+PiB3aGljaCBtb3N0bHkgcHJvdmlkZXMgc29tZSBHUElPcyBhY2Nlc3NlZCB2aWEg
cmVnaXN0ZXJzIG9uIHRoZSBsb2NhbA0KPj4gYnVzLiBSaWdodCBub3cgd2UndmUgZ290IGEgY3Vz
dG9tIGRyaXZlciB0aGF0IGJ1bmRsZXMgZXZlcnl0aGluZw0KPj4gdG9nZXRoZXIgc28gZWZmZWN0
aXZlbHkgd2UndmUgZ290IGEgUENJIGRldmljZSB0aGF0IHByb3ZpZGVzIEdQSU9zLg0KPiBXaGF0
J3MgdGhlIGxvY2FsIGJ1cz8gIFRoZSBBU0lYOTEwMCAoZm9yIHdoaWNoIEdvb2dsZSBkb2Vzbid0
IGZpbmQgYW55DQo+IGRldGFpbHMpIHdvdWxkIGhhdmUgYSBQQ0kgaW50ZXJmYWNlIG9uIHRoZSBw
cmltYXJ5ICh1cHN0cmVhbSkgc2lkZS4NCj4gV2hhdCdzIHRoZSBsb2NhbCBidXMgb24gdGhlIHNl
Y29uZGFyeSAoZG93bnN0cmVhbSkgc2lkZT8gIEJlbG93IHlvdQ0KPiBtZW50aW9uICJQQ0kgYnJp
ZGdlIiwgd2hpY2ggbm9ybWFsbHkgbWVhbnMgYm90aCB0aGUgcHJpbWFyeSBhbmQNCj4gc2Vjb25k
YXJ5IHNpZGVzIGFyZSBQQ0kgYnVzZXMuDQoNClRoZSBBU0lYOTEwMCBpcyBhIG11bHRpIHB1cnBv
c2UgY2hpcCB3aXRoIGEgZmV3IG9wdGlvbnMgZm9yIHByb3ZpZGluZyANCkdQSU8vSTJDL1NQSS9l
dGMuIEluIG91ciBoYXJkd2FyZSBjb25maWd1cmF0aW9uIHdlJ3JlIHVzaW5nIGl0IHRvIA0KcHJv
dmlkZSBhIDE2LWJpdCBwYXJhbGxlbCBidXMgd2hpY2ggd2UncmUgdXNpbmcgZm9yIHJlZ2lzdGVy
IGFjY2VzcyB0byANCnRoZSBGUEdBLiBUaGVyZSdzIGFuIG91dHNpZGUgY2hhbmNlIHNvbWVvbmUg
bWlnaHQgYXNrIHVzIHRvIGhhbmcgb3RoZXIgDQpwYXJhbGxlbCBkZXZpY2VzIGxpa2UgYW4gU1JB
TSBvciBzb21lIE5PUiBGbGFzaCBvZmYgaXQgYXMgd2VsbC4gVGhlc2UgDQphcmUgYWxsIHRoaW5n
cyB3ZSd2ZSBkb25lIG9uIG90aGVyIHByb2R1Y3RzIHdpdGggbW9yZSB0cmFkaXRpb25hbCANCmVt
YmVkZGVkIFNvQ3MgdGhhdCBoYXZlIGEgcGFyYWxsZWwgYnVzIGludGVyZmFjZS4NCg0KPiBJZiB0
aGUgbG9jYWwgYnVzIGlzIG5vdCBQQ0ksIEkgZ3Vlc3MgdGhlIEFTSVg5MTAwIHdvdWxkIGxvb2sg
dG8gdGhlIE9TDQo+IGxpa2UgYW4gZW5kcG9pbnQsIGkuZS4sIFBDSV9IRUFERVJfVFlQRV9OT1JN
QUwsIGFuZCB0aGUgQVNJWDkxMDANCj4gZHJpdmVyIHdvdWxkIGhhbmRsZSBhbnkgImJyaWRnZSIg
ZnVuY3Rpb25hbGl0eSBjb21wbGV0ZWx5IGludGVybmFsbHk/DQoNCkkgbWlnaHQgYmUgdXNpbmcg
dGhlIHRlcm1pbm9sb2d5IHdyb25nLiBFc3NlbnRpYWxseSB0aGUgQVNJWDkxMDAgaXMgYSANClBD
SS1lIGVuZHBvaW50IChzbyBhIGRldmljZSBmcm9tIHRoZSBQQ0kgc3Vic3lzdGVtcyBwb2ludCBv
ZiB2aWV3KSBidXQgDQp0aGF0IGRldmljZSBjYW4gYmUgYSBJMkMsIFNQSSBvciBwYXJhbGxlbCBi
dXMgY29udHJvbGxlciBvbnRvIHdoaWNoIA0Kb3RoZXIgZGV2aWNlcyBhcmUgY29ubmVjdGVkLkhl
bmNlIGl0J3MgcHJvdmlkaW5nIGEgYnJpZGdlIGJldHdlZW4gUENJIA0KYW5kIDE2LWJpdCBwYXJh
bGxlbCBidXNzZXMuDQoNCj4gTWF5YmUgSGVydmUncyB3b3JrIGF0DQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNDAzMjUxNTM5MTkuMTk5MzM3LTEtaGVydmUuY29kaW5hQGJvb3RsaW4u
Y29tDQo+IHdvdWxkIGJlIHJlbGV2YW50Pw0KDQpJJ3ZlIGhhZCBhIHF1aWNrIGxvb2sgYXQgdGhh
dCBzZXJpZXMuIEknbSBub3QgMTAwJSBzdXJlIGl0J2xsIGhlbHAuIFRoZSANCnBsYXRmb3JtIEkn
bSBkZWFsaW5nIHdpdGggaXMgeDg2XzY0IGFuZCBkb2Vzbid0IGhhdmUgZGV2aWNlIHRyZWUgc3Vw
cG9ydCANCihpZiBzb21lb25lIGNhbiBzYXkgImhleSBkbyB4eXogYW5kIHlvdSdsbCBnZXQgRFQg
b24geDg2IiB0aGF0J2QgYmUgDQpncmVhdCkuQnV0IEknbGwgdGFrZSBhIGNsb3NlciBsb29rIGF0
IGl0IGFuZCBhdCB0aGUgb3JpZ2luYWwgIkdlbmVyYXRlIA0KZGV2aWNlIHRyZWUgbm9kZSBmb3Ig
cGNpIGRldmljZXMiIHNlcmllcy4NCg0KPj4gQnV0IGFzIHRoaW5ncyBjYW4gY2hhbmdlIGJhc2Vk
IG9uIHRoZSBGUEdBIHByb2dyYW0gSSdkIGxpa2Ugc29tZQ0KPj4gZmxleGliaWxpdHkgdG8gdHJl
YXQgaXQgc2VwYXJhdGVseSBmcm9tIHRoZSBQQ0kgYnJpZGdlLiBTbyByZWFsbHkgSSdkDQo+PiBs
aWtlIHRvIGhhdmUgYSBQQ0kgZGV2aWNlIGRyaXZlciBmb3IgdGhlIEFTSVg5MTAwIHRoYXQgcHJv
dmlkZXMgYSBsb2NhbA0KPj4gYnVzIGNvbnRyb2xsZXIgYW5kIGEgKHBsYXRmb3JtPykgZHJpdmVy
IGZvciB0aGUgRlBHQSB0aGF0IHByb3ZpZGVzIHRoZQ0KPj4gR1BJT3Mgd2hlcmUgSSBjYW4gaGF2
ZSBkaWZmZXJlbnQgY29tcGF0aWJsZXMgZm9yIHRoZSBkaWZmZXJlbnQNCj4+IGltcGxlbWVudGF0
aW9ucy4NCj4+DQo+PiBUaGVuIGluIHRoZSBBQ1BJIG92ZXJsYXkgSSdkIGhhdmUgc29tZXRoaW5n
IGxpa2UNCj4+DQo+PiAgIMKgwqDCoCBTY29wZSAoXF9TQi5QQ0kwLkQwQjApDQo+PiAgIMKgwqDC
oCB7DQo+PiAgIMKgwqDCoMKgwqDCoMKgIERldmljZSAoQVNJWCkNCj4+ICAgwqDCoMKgwqDCoMKg
wqAgew0KPj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5hbWUgKF9BRFIsIDB4MDAwMCkNCj4+
DQo+PiAgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIERldmljZSAoRlBHQSkNCj4+ICAgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgew0KPj4gICDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqDCoCBOYW1lIChfSElELCAiUFJQMDAwMSIpDQo+PiAgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIE5hbWUgKF9EU0QsIFBhY2thZ2UgKCkNCj4+ICAgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgew0KPj4gVG9VVUlEKCJkYWZmZDgxNC02
ZWJhLTRkOGMtOGE5MS1iYzliYmY0YWEzMDEiKSwNCj4+ICAgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgUGFja2FnZSAoKQ0KPj4g
ICDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqDCoCB7DQo+PiAgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIFBhY2thZ2UgKCkgew0K
Pj4gImNvbXBhdGlibGUiLCAibXktcGxhdGZvcm0tZHJpdmVyLWZvci1mcGdhIiB9LA0KPj4gICDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqDCoCB9DQo+PiAgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIH0p
DQo+PiAgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIH0NCj4+ICAgwqDCoMKgwqDCoMKgwqAgfQ0KPj4g
ICDCoMKgwqAgfQ0KPj4NCj4+ICAgwqDCoCBTY29wZShcX1NCKQ0KPj4gICDCoMKgIHsNCj4+ICAg
wqDCoMKgIMKgwqDCoCBEZXZpY2UoT1RIUikNCj4+ICAgwqDCoMKgIMKgwqDCoCB7DQo+PiAgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIEdwaW9JbyAoRXhjbHVzaXZlLCBQdWxsVXAsIDAsIDAsIElvUmVz
dHJpY3Rpb25JbnB1dE9ubHksDQo+PiAiXFxfU0IuUENJMC5EMEIwLkFTSVguRlBHQSIsKSB7IDAg
fQ0KPj4gICDCoMKgwqAgwqDCoMKgIH0NCj4+ICAgwqDCoCB9DQo+Pg0KPj4gSXMgaXQgZXZlbiBw
b3NzaWJsZSB0byByZWdpc3RlciBhIGhvc3QgY29udHJvbGxlciBmb3IgYW5vdGhlciBwbGF0Zm9y
bSBidXM/DQo+Pg0KPj4gVGhhbmtzLA0KPj4gQ2hyaXM=

