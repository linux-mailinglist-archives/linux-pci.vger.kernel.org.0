Return-Path: <linux-pci+bounces-13973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F9B993356
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 18:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95501C21DAB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7611D4164;
	Mon,  7 Oct 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Mi3RzaeR"
X-Original-To: linux-pci@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAB1E520
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318873; cv=none; b=Gm6vJR9GWSC/ctxq0G03WOeW1LE1FDVspg1GR1Fcku4h4WqBgmj76H47SYrLYiGRiokXRA506fWaWg5qeNpJ/nq7Z7z8xH2ukqDZS4XYbVN7SwrvTPJQY6RCZ3cHZXhPxagZPgIHVvV3qqoV8Fe0brr5kf7psNRA2eBjSEWAbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318873; c=relaxed/simple;
	bh=wLEsSBiMSxUiNNjLLs1N0iBOc7fUyjZ6Uq4MaHFAti8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=baBQnjhwRDXJRWHY0EIYQlCAVN0wzzrecQCh3PSJN5Vt98WUaE12Efq9Iwz2WF2EJm2BSVn3Avv04cZXCUj9QYYHFlJKqkAMU6dv6T2JB0qTr1qht3g0eCa6hQg2tkqhkgsayM3vecAilIAv273NXAXQC9jpVASjlah+DY87v4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Mi3RzaeR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EAF2B201E4;
	Mon,  7 Oct 2024 18:34:28 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bHw4WM2yzWtA; Mon,  7 Oct 2024 18:34:28 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 41703201AE;
	Mon,  7 Oct 2024 18:34:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 41703201AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728318868;
	bh=wLEsSBiMSxUiNNjLLs1N0iBOc7fUyjZ6Uq4MaHFAti8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Mi3RzaeRG/ZXUnYeSOMblyqXKm0BetKMfBNBSZkt5WwDaGaw2RQNqAcfy3XqxahW1
	 yc0j2NXbs+tkjBUqtRQmd6QiEisfgrYIZQej5n0Yq78D5OPh2/hcsKU5VSrJwChdoY
	 jsdHwGyZy7ScVxlKxb15tmBOo134WwkKB1PqDpZocaw49hPbSvjJCzz2GLHC74fHPl
	 mXH5QCFLsSIEzwGugq9XQlbJYsR5z24tL9/SE8xasv4BIhOVqaTACkGRup9oaHYiNL
	 9WQ1a4c+5gQgMZYDJN4cyIRSYILmdb+WCBORlrseS3lA65bONyRstv75rLV88VFE7A
	 u5oO8JWKP8wnw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 18:34:28 +0200
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 18:34:27 +0200
Received: from mbx-essen-01.secunet.de ([fe80::1522:bd4f:78cd:ce75]) by
 mbx-essen-01.secunet.de ([fe80::1522:bd4f:78cd:ce75%6]) with mapi id
 15.01.2507.039; Mon, 7 Oct 2024 18:34:27 +0200
From: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
To: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "mika.westerberg@linux.intel.com"
	<mika.westerberg@linux.intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mpearson-lenovo@squebb.ca"
	<mpearson-lenovo@squebb.ca>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "minipli@grsecurity.net"
	<minipli@grsecurity.net>, "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: UAF during boot on MTL based devices with attached dock
Thread-Topic: UAF during boot on MTL based devices with attached dock
Thread-Index: AQHbCmrFODsoF+chTk2MBvuiMq/CLbJlMIIAgAF4p4CAAeJvgIABdkQAgBF1VIA=
Date: Mon, 7 Oct 2024 16:34:27 +0000
Message-ID: <67e3fc901fcb76a5386cb6378be4381c94039670.camel@secunet.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
	 <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
	 <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
	 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
	 <289bcd4d-099a-810b-0854-b11223f50a9c@linux.intel.com>
In-Reply-To: <289bcd4d-099a-810b-0854-b11223f50a9c@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <05B98C4A1330D946919D8E310FAEA8FA@secunet.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

SGksDQoNCg0KT24gVGh1LCAyMDI0LTA5LTI2IGF0IDE2OjU4ICswMzAwLCBJbHBvIErDpHJ2aW5l
biB3cm90ZToNCj4gT24gV2VkLCAyNSBTZXAgMjAyNCwgV2Fzc2VuYmVyZywgRGVubmlzIHdyb3Rl
Og0KPiA+IE9uIFR1ZSwgMjAyNC0wOS0yNCBhdCAxMzo1MSArMDMwMCwgSWxwbyBKw6RydmluZW4g
d3JvdGU6DQo+ID4gPiBPbiBNb24sIDIzIFNlcCAyMDI0LCBXYXNzZW5iZXJnLCBEZW5uaXMgd3Jv
dGU6DQo+ID4gPiANCj4gPiA+ID4gSGkgdG9nZXRoZXIsDQo+ID4gPiA+IA0KPiA+ID4gPiB3ZSBk
aWQgc29tZSBmdXJ0aGVyIGFuYWx5c2lzIG9uIHRoaXM6DQo+ID4gPiA+IA0KPiA+ID4gPiBCZWNh
dXNlIHdlIGFyZSB3b3JraW5nIG9uIGtlcm5lbCA2LjguMTIsIEkgd2lsbCB1c2Ugc29tZSBsb2dz
IGZyb20gdGhpcyBrZXJuZWwgdmVyc2lvbiwganVzdCBmb3IgZGVtb25zdHJhdGlvbi4NCj4gPiA+
ID4gVGhlDQo+ID4gPiA+IGluaXRpYWwgcmVwb3J0IHdhcyBiYXNlZCBvbiA2LjExLg0KPiA+ID4g
PiANCj4gPiA+ID4gQWZ0ZXIgd2UgdHJpZWQgYSBLQVNBTiBidWlsZCAoZG1lc2ctcmFtb29wcy1r
YXNhbikgaXQgbG9va3MgbGlrZSBpdCBpcyBleGFjdGx5IHRoZSBzYW1lIHBjaWVocCBmbG93IHdo
aWNoIGxlYWRzDQo+ID4gPiA+IHRvDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBVQUYuDQo+ID4gPiA+
IEJvdGggZ29pbmcgdGhyb3VnaCBwY2llaHBfaXN0IC0+IHBjaWVocF9kaXNhYmxlX3Nsb3QgLT4g
cGNpZWhwX3VuY29uZmlndXJlX2RldmljZSAtPiBwY2lfcmVtb3ZlX2J1c19kZXZpY2UgLT4NCj4g
PiA+ID4gLi4uDQo+ID4gPiA+IFRoaXMgbWVhbnMgdGhlcmUgYXJlIHR3byBjb25zZWN1dGl2ZSBp
bnRlcnJ1cHRzLCBydW5uaW5nIG9uIENQVSAxMiBhbmQgYm90aCB3aWxsIGV4ZWN1dGUgdGhlIHNh
bWUgZmxvdy4NCj4gPiA+ID4gQXQgdGhlIGxhdGVzdCB0aGUgcGNpX2xvY2tfcmVzY2FuX3JlbW92
ZSBzaG91bGQgYmUgdGFrZW4gaW4gcGNpZWhwX3VuY29uZmlndXJlX2RldmljZSB0byBwcmV2ZW50
IGFjY2Vzc2luZyB0aGUNCj4gPiA+ID4gcGNpL2J1cw0KPiA+ID4gPiBzdHJ1Y3R1cmVzIGluIHBh
cmFsbGVsLg0KPiA+ID4gPiANCj4gPiA+ID4gSSBoYWQgYSBsb29rIGlmIHRoZXJlIGFyZSBzaGFy
ZWQgZGF0YSBzdHJ1Y3R1cmVzIGFjY2Vzc2VkIGluIHRoaXMgY29kZSBwYXRoOg0KPiA+ID4gPiBG
b3IgbWUgdGhlIGFjY2VzcyB0byAiKnBhcmVudCA9IGN0cmwtPnBjaWUtPnBvcnQtPnN1Ym9yZGlu
YXRlOyIgbG9va3MgZmlzaHkgaW4gcGNpZWhwX3VuY29uZmlndXJlX2RldmljZS4gVGhlDQo+ID4g
PiA+IHBhcmVudA0KPiA+ID4gPiBwdHINCj4gPiA+ID4gd2lsbCBiZSBvYnRhaW5lZCBiZWZvcmUg
Z2V0dGluZyB0aGUgbG9jayAocGNpX2xvY2tfcmVzY2FuX3JlbW92ZSkuIE5vdywgaWYgdGhlcmUg
YXJlIHR3byBjb25jdXJyZW50L2NvbnNlY3V0aXZlDQo+ID4gPiA+IGZsb3dzDQo+ID4gPiA+IGNv
bWUgaW50byB0aGlzIGZ1bmN0aW9uLCBib3RoIHdpbGwgZ2V0IHRoZSBwb2ludGVyIHRvIHRoZSBw
YXJlbnQgYnJpZGdlL3N1Ym9yZGluYXRlLiBPbmUgdGhyZWFkIHdpbGwgZW50ZXIgdGhlDQo+ID4g
PiA+IGxvY2sNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IHRoZSBvdGhlciBvbmUgaXMgd2FpdGluZyB1
bnRpbCB0aGUgbG9jayBpcyBnb25lLiBUaGUgdGhyZWFkIHdoaWNoIGVudGVycyB0aGUgbG9jayBh
dCBmaXJzdCB3aWxsIGNvbXBsZXRlbHkNCj4gPiA+ID4gcmVtb3ZlDQo+ID4gPiA+IHRoZQ0KPiA+
ID4gPiBicmlkZ2UgYW5kIHRoZSBzdWJvcmRpbmF0ZTogcGNpZWhwX3VuY29uZmlndXJlX2Rldmlj
ZSAtPiBwY2lfc3RvcF9hbmRfcmVtb3ZlX2J1c19kZXZpY2UgLT4gcGNpX3JlbW92ZV9idXNfZGV2
aWNlDQo+ID4gPiA+IC0+DQo+ID4gPiA+IHBjaV9kZXN0cm95X2RldjogVGhpcyB3aWxsIGRlc3Ry
b3kgdGhlIHBjaV9kZXYgYW5kIHRoZSBzdWJvcmRpbmF0ZSBpcyBhIHBhcnQgdGhlIHRoaXMgc3Ry
dWN0dXJlIGFzIHdlbGwuIE5vdw0KPiA+ID4gPiBldmVyeXRoaW5nDQo+ID4gPiA+IGlzIGdvbmUg
YmVsb3cgdGhpcyBwY2lfYnVzIChjaGlsZHMgaW5jbHVkZWQpLiBJbiBwY2lfcmVtb3ZlX2J1c19k
ZXZpY2UgdGhlcmUgaXMgYSBsb29wIHdoaWNoIGl0ZXJhdGVzIG92ZXIgYWxsDQo+ID4gPiA+IGNo
aWxkDQo+ID4gPiA+IGRldmljZXMgYW5kIGNhbGwgcGNpX3JlbW92ZV9idXNfZGV2aWNlIGFnYWlu
LiBUaGlzIG1lYW5zIGV2ZW4gdGhlIGNoaWxkIGJyaWRnZXMgb2YgdGhlIGN1cnJlbnQgYnJpZGdl
IHdpbGwgYmUNCj4gPiA+ID4gZGVsZXRlZC4NCj4gPiA+ID4gSW4gdGhlIGVuZDogZXZlcnl0aGlu
ZyBpcyBnb25lIGJlbG93IHRoZSBicmlkZ2Ugd2hpY2ggaXMgcmVnYXJkZWQgaGVyZSBhdCBmaXJz
dC4NCj4gPiA+IA0KPiA+ID4gRG9lc24ndCB0aGF0IGVuZCB1cCByZW1vdmluZyBwb3J0ZHJ2L2hv
dHBsdWcgdG9vIHNvIHBjaWVocF9yZW1vdmUoKSBkb2VzIA0KPiA+ID4gcmVsZWFzZSBjdHJsPyBJ
J20gbm90IHN1cmUgaWYgY3RybCBjYW4gYmUgc2FmZWx5IGFjY2Vzc2VkIGV2ZW4gaWYgdGhlIA0K
PiA+ID4gbG9jayBpcyB0YWtlbiBmaXJzdD8NCj4gPiANCj4gPiBZZXMsIGl0IGxvb2tzIGxpa2Ug
aXQgZW5kcyB1cCBpbiByZW1vdmluZyBwb3J0ZHJ2L2hvdHBsdWcgdG9vLiBJIGFtIG5vdCBzdXJl
IGlmIHRoaXMgY2FuIGJlIHNhZmVseSBhY2Nlc3NlZC4gRm9yDQo+ID4gdGVzdGluZw0KPiA+IEkg
YWRkZWQgInNldF9zZXJ2aWNlX2RhdGEoZGV2LCBOVUxMKTsiIGF0IHRoZSBlbmQgb2YgcGNpZWhw
X3JlbW92ZS4gVGhpcyBzaG91bGQgbWFrZSBzdXJlIHRoYXQgaXQgaXMgbm90IHBvc3NpYmxlIHRv
DQo+ID4gYWNjZXNzIGZyZWVkIGN0cmwuIElmIHRoZXJlIGlzIGEgZmxvdyB3aGljaCBhY2Nlc3Nl
cyB0aGlzLCBpdCBzaG91bGQgcmVzdWx0IGluIGEgbnVsbC1wdHIgaW5zdGVhZCBvZiBVQUYuIEkg
ZGlkIHNvbWUNCj4gPiBydW5zIHdpdGggdGhpcyBjaGFuZ2UgYnV0IEkgYWx3YXlzIHJhbiBpbnRv
IHRoZSBVQUYuDQo+IA0KPiBPa2F5LCBwZXJoYXBzIGl0IGRvZXNuJ3Qgb2NjdXIgZm9yIHNvbWUg
cmVhc29uLiBJIHN1cHBvc2UgdGhlIHJlYXNvbiBpcyANCj4gdGhhdCB0aGUgY29uY3VycmVudCBw
Y2llaHBfaXN0KCkgd2FpdHMgZm9yIHRoZSBsb2NrIGluIA0KPiBwY2llaHBfdW5jb25maWd1cmVf
ZGV2aWNlKCkgYW5kIHNpbmNlIGl0IGhhcyBub3QgeWV0IHJldHVybmVkLA0KPiBmcmVlX2lycSgp
IGlzIHdoYXQga2VlcHMgdGhlIGhvdHBsdWcgJiBjdHJsIGdldHRpbmcgcmVtb3ZlZC4NCj4gU28g
aXQgc2VlbXMgdG8gbWUgeW91ciBjaGFuZ2UgaXMgZmluZS4NCj4gDQo+ID4gRm9yIG1lIGl0IGxv
b2tzIG1vcmUgcmVsYXRlZCB0byB0aGUgc2xvdCBvYmplY3QuIElmIEkgY29tcGFyZSB0d28gcnVu
cyAob25lIHdpdGggZHluZGJnIGVuYWJsZWQgZm9yIHBjaSBhbmQgb25lDQo+ID4gd2l0aG91dCkN
Cj4gPiBpdCB3aWxsIGFjY2VzcyB0aGUgZmFpbGluZyBhZGRyZXNzIGluIHRoZSBfX2R5bmFtaWNf
ZGV2X2RiZyBwb3J0aW9uIGF0IHBjaV9kZXN0cm95X3Nsb3QgaW4gY2FzZSBvZiB0aGUgZHluZGJn
DQo+ID4gZW5hYmxlZA0KPiA+IHJ1bi4gSW4gY2FzZSBvZiB0aGUgbm9uIGR5bmRiZyBydW4gaXQg
d2lsbCBmYWlsIHdoaWxlIGFjY2Vzc2luZw0KPiA+ICJrb2JqZWN0X3B1dCgmc2xvdC0+a29iaik7
IiBpbiBwY2lfZGVzdHJveV9zbG90Lg0KPiANCj4gVGhlIGZpcnN0IGVycm9yIGlzDQo+IA0KPiA8
Mz5bICAgMTAuMjQ0NDIzXSBCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIHBjaV9z
bG90X3JlbGVhc2UrMHgzNmUvMHgzZTANCj4gDQo+IHNvIGhvdyB5b3UgaW5mZXJyZWQgaXQgb2Nj
dXJzIGluIHBjaV9kZXN0cm95X3Nsb3QoKT8NCk9rLCB5ZXMuIFlvdSBhcmUgcmlnaHQuIEkgd2Fz
IGJsaW5kZWQgYnkgZGV2X2RiZyBpbiBwY2lfZGVzdHJveV9zbG90IDspDQoNCj4gDQo+ID4gVW5m
b3J0dW5hdGVseSBJIGhhdmUgY3VycmVudGx5IG5vIGNsdWUgYWJvdXQgaG93IGNhbiB0aGlzIHNs
b3Qgb2JqZWN0IA0KPiA+IGV2ZXIgYmVlbiBkZXN0cm95ZWQgcHJlbWF0dXJlbHkuIA0KPiANCj4g
VGhlcmUgYXJlIGRldl9kYmcoKXMgb24gdGhlIHBhdGhzIHRoYXQgbGVhZCB0byBkZXN0cnVjdGlv
biBvZiB0aGUgc2xvdCANCj4gb2JqZWN0LiBJIGRvbid0IHNlZSBhbnkgb2YgdGhvc2UgbGluZXMg
aW4geW91ciBsb2dzIHNvIEkgZG9uJ3QgYmVsaWV2ZSANCj4gdGhhdCBoYXMgb2NjdXJyZWQgaGVy
ZS4NCj4gDQo+ID4gSSBhdHRhY2ggdGhlIGxvZ3Mgb2YgYm90aCBydW5zLiBJIGtub3csIG9uZSBp
cyBiYXNlZCBvbiBhbiBvdGhlciBrZXJuZWwgdmVyc2lvbiBidXQgdGhlcmUgaXQgaXMgbW9yZSBl
YXN5IHRvDQo+ID4gcmVwcm9kdWNlDQo+ID4gd2l0aCBLQVNBTiBlbmFibGVkLg0KPiANCj4gV2hh
dCBpbiB0aGVzZSBsb2dzIGluZGljYXRlIHRvIHlvdSBpdCB3b3VsZCBiZSBzbG90IGFjY2VzcyB3
aGljaCBmYWlscz8gVG8gDQo+IG1lIGl0IGxvb2tzIGluIGJvdGggY2FzZXMgYWNjZXNzIHRvIC0+
YnVzIGlzIHRoZSBjdWxwcml0IChpdCBhbHNvIGV4cGxhaW5zIA0KPiB3aHkgZHluZGJnIG9uL29m
ZiBtYXR0ZXJzIGJlY2F1c2UgcGNpX2Rlc3Ryb3lfc2xvdCgpIHdpbGwgbm90IGFjY2VzcyAtPmJ1
cyANCj4gb3RoZXJ3aXNlIHNvIGl0IGNhbiBnZXQgYWxsIHRoZSB3YXkgaW50byBwY2lfc2xvdF9y
ZWxlYXNlKCkgYmVmb3JlIA0KPiBibG93aW5nIHVwKS4NCj4gDQoNCg==

