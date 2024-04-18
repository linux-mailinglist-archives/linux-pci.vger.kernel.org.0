Return-Path: <linux-pci+bounces-6385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 373798A8FFA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 02:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA572B2232C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE0D382;
	Thu, 18 Apr 2024 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="opzSoicw"
X-Original-To: linux-pci@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2D10FA
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 00:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399857; cv=none; b=LyOZpOX/yQla9uyiV5/1woYBMYBCVDU8CdD041niJwjqbZcx4hXNVDxaE2+VGSWAaHXHI9m+WRckKiUOdNalpI7rDf6RZjm/ZufwuqlgGtIiUwtAzihWeYAsKX2/F4P9vxOe5x2xmwQc5zPOhSiCpqZDpsGNxjCZ3bsXki/BBGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399857; c=relaxed/simple;
	bh=0iN+zs7FbJTFFZKHkZZGXu99GW8qS8VPabqrDqZaBXg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VOzB8VBLHFneBdI2w7CTWFj5pq2cHnwxUnF51dVCnVzBp77j4OepCyO+4zVq4p3UEQAm+vMaOVLni6K6+QQCZDi9cDIveNNXCpR3o/jMp+DJdGlr7k5CU6OAG3K38CtB2CkE0cmQjoMn4+6B2NSVXegh47toLgndj6nLd4JImH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=opzSoicw; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D92022C02B0;
	Thu, 18 Apr 2024 12:24:06 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1713399846;
	bh=0iN+zs7FbJTFFZKHkZZGXu99GW8qS8VPabqrDqZaBXg=;
	h=From:To:Subject:Date:From;
	b=opzSoicw9JjaW0tmG3jy3zTWlNXpjW61G70j/xhSyqsmyaR0RXbMcAGbgeH15yrfu
	 WjWwScogSc9UUvG2L74+sI93VE7f39uM+SMXJwLIIhCC6N6vFaMURjfVdsJhEgIAG6
	 /phbJ3yQasPJ750KVUfdO8Zv6CVLgj+TZVsz2YSit2z4QS7ToQ7zFu1AFALfapqjfg
	 NOYzSP+k0e88OPV6ybEEnkF6Ir9ZqSnIf+t1fxlsrTyy3xb5Ydsa4a5NJO8sCMIqCY
	 CaEeGorViz02l5nupoPOLTRgCSlnJ1XnrNyhrq1XlYg+BcODm6UeGqYAh8hkSaTntL
	 yvW9+q2L/DGCA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B662068260000>; Thu, 18 Apr 2024 12:24:06 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 12:24:06 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Thu, 18 Apr 2024 12:24:06 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: local bus enumeration beyond a PCI device
Thread-Topic: local bus enumeration beyond a PCI device
Thread-Index: AQHakSa58Ehmqkf3b0um4G7kLubeEw==
Date: Thu, 18 Apr 2024 00:24:06 +0000
Message-ID: <bad63409-ed2b-4cef-988b-3c143636e9fa@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A3D632F701D594E939AE2FF35281DCD@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=66206826 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=HKGT0sa775DmyZdDYaUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGksDQoNCldlJ3ZlIGdvdCBhIGN1c3RvbSB4ODZfNjQgYmFzZWQgZGVzaWduIHRoYXQgaXMgdXNp
bmcgYW4gQVNJWDkxMDAgdG8gDQpwcm92aWRlIGEgUENJIHRvIGxvY2FsIGJ1cyBicmlkZ2UuIEF0
dGFjaGVkIHRvIHRoYXQgbG9jYWwgYnVzIGlzIGFuIEZQR0EgDQp3aGljaCBtb3N0bHkgcHJvdmlk
ZXMgc29tZSBHUElPcyBhY2Nlc3NlZCB2aWEgcmVnaXN0ZXJzIG9uIHRoZSBsb2NhbCANCmJ1cy4g
UmlnaHQgbm93IHdlJ3ZlIGdvdCBhIGN1c3RvbSBkcml2ZXIgdGhhdCBidW5kbGVzIGV2ZXJ5dGhp
bmcgDQp0b2dldGhlciBzbyBlZmZlY3RpdmVseSB3ZSd2ZSBnb3QgYSBQQ0kgZGV2aWNlIHRoYXQg
cHJvdmlkZXMgR1BJT3MuDQoNCkJ1dCBhcyB0aGluZ3MgY2FuIGNoYW5nZSBiYXNlZCBvbiB0aGUg
RlBHQSBwcm9ncmFtIEknZCBsaWtlIHNvbWUgDQpmbGV4aWJpbGl0eSB0byB0cmVhdCBpdCBzZXBh
cmF0ZWx5IGZyb20gdGhlIFBDSSBicmlkZ2UuIFNvIHJlYWxseSBJJ2QgDQpsaWtlIHRvIGhhdmUg
YSBQQ0kgZGV2aWNlIGRyaXZlciBmb3IgdGhlIEFTSVg5MTAwIHRoYXQgcHJvdmlkZXMgYSBsb2Nh
bCANCmJ1cyBjb250cm9sbGVyIGFuZCBhIChwbGF0Zm9ybT8pIGRyaXZlciBmb3IgdGhlIEZQR0Eg
dGhhdCBwcm92aWRlcyB0aGUgDQpHUElPcyB3aGVyZSBJIGNhbiBoYXZlIGRpZmZlcmVudCBjb21w
YXRpYmxlcyBmb3IgdGhlIGRpZmZlcmVudCANCmltcGxlbWVudGF0aW9ucy4NCg0KVGhlbiBpbiB0
aGUgQUNQSSBvdmVybGF5IEknZCBoYXZlIHNvbWV0aGluZyBsaWtlDQoNCiDCoMKgwqAgU2NvcGUg
KFxfU0IuUENJMC5EMEIwKQ0KIMKgwqDCoCB7DQogwqDCoMKgwqDCoMKgwqAgRGV2aWNlIChBU0lY
KQ0KIMKgwqDCoMKgwqDCoMKgIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5hbWUgKF9BRFIs
IDB4MDAwMCkNCg0KIMKgwqDCoCDCoMKgwqAgwqDCoMKgIERldmljZSAoRlBHQSkNCiDCoMKgwqAg
wqDCoMKgIMKgwqDCoCB7DQogwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgTmFtZSAoX0hJRCwgIlBSUDAwMDEiKQ0KIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIE5hbWUgKF9EU0QsIFBhY2thZ2UgKCkNCiDCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCB7DQpUb1VVSUQoImRhZmZkODE0LTZlYmEtNGQ4Yy04YTkx
LWJjOWJiZjRhYTMwMSIpLA0KIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIFBhY2thZ2UgKCkNCiDCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCB7DQogwqDCoMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgUGFja2FnZSAoKSB7IA0KImNvbXBhdGlibGUiLCAibXktcGxhdGZv
cm0tZHJpdmVyLWZvci1mcGdhIiB9LA0KIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIH0NCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCB9KQ0KIMKgwqDCoCDCoMKgwqAgwqDCoMKgIH0NCiDCoMKgwqDC
oMKgwqDCoCB9DQogwqDCoMKgIH0NCg0KIMKgwqAgU2NvcGUoXF9TQikNCiDCoMKgIHsNCiDCoMKg
wqAgwqDCoMKgIERldmljZShPVEhSKQ0KIMKgwqDCoCDCoMKgwqAgew0KIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIEdwaW9JbyAoRXhjbHVzaXZlLCBQdWxsVXAsIDAsIDAsIElvUmVzdHJpY3Rpb25JbnB1
dE9ubHksIA0KIlxcX1NCLlBDSTAuRDBCMC5BU0lYLkZQR0EiLCkgeyAwIH0NCiDCoMKgwqAgwqDC
oMKgIH0NCiDCoMKgIH0NCg0KSXMgaXQgZXZlbiBwb3NzaWJsZSB0byByZWdpc3RlciBhIGhvc3Qg
Y29udHJvbGxlciBmb3IgYW5vdGhlciBwbGF0Zm9ybSBidXM/DQoNClRoYW5rcywNCkNocmlzDQo=

