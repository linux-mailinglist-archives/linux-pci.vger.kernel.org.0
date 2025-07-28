Return-Path: <linux-pci+bounces-32998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE6B135B9
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 09:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A7F1893D44
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 07:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1373213D51E;
	Mon, 28 Jul 2025 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valdikss.org.ru header.i=@valdikss.org.ru header.b="dkx9C76s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.valdk.tel (mail.valdk.tel [185.177.150.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D41A2398
	for <linux-pci@vger.kernel.org>; Mon, 28 Jul 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.177.150.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687869; cv=none; b=NNAlZsbgByUHaISQPT7KYhugqattQA7pJGRxlwHhqePSMC0iP+NbwZH3ce/i1DHhS36LsyaF1z46fbFvLgdEGl2JCwUv6rjvwrySfe7qm0Afc+pjV9XRIhxOcFbol+ECsizfb4d7QghyPLkR+se/v1Ki4Pm4WCEdt6+mehA8RY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687869; c=relaxed/simple;
	bh=BoNudzfzzStNOvxZoFXfnOkdrkHVOIts3zeGJ9r4bWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4dgkmFhcHGdzHjuR73wkvyU1rBOouo2NZuxlgCkL8GHtzpZpdmd09+Yl619SSuize+sFUNTgwsDOSkJCKMEECVZ36D5ZlZzy55k2qVhxE7tUvyWVkQzpVhh5NBl3HhiMMaF/zz8BM8B8ajlJlfgLKnQoeaB1mA8RT1zk1tfDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valdikss.org.ru; spf=pass smtp.mailfrom=valdikss.org.ru; dkim=pass (2048-bit key) header.d=valdikss.org.ru header.i=@valdikss.org.ru header.b=dkx9C76s; arc=none smtp.client-ip=185.177.150.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valdikss.org.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valdikss.org.ru
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BEE61B6AA70;
	Mon, 28 Jul 2025 10:24:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valdikss.org.ru;
	s=msrv; t=1753687500;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-language:in-reply-to:references:autocrypt;
	bh=BoNudzfzzStNOvxZoFXfnOkdrkHVOIts3zeGJ9r4bWM=;
	b=dkx9C76sO1o5EF6BxBmOt6p6KxaCpTjLf+GauwCTmyhmbylviJG3wjOAr2OAA9oP4g67i5
	5Qbf67K8R9LcRHLITV4WQq+JOiCE0uQDs7cx3e9p9tSzDtw200qHzmV5o2lY3RjlnEV28i
	XWqdfXm7EZ/llrGmHCMZs0ik/csWC5aN9b3OhFKEB6YRMWLb+OVVgTk1dTop5bLpXOzJTv
	iwz8Zi0AoPh/1jUVb2aZ3Ljg/NJKHpSJniDZz9qJdDnW4d6Ah17XSgqq4ssIsdCOd5Xo+v
	6l4NN6t1ZB3gITLcPf/mshLDcaiE3nWK5S3c0iPkK+BhJMrE0/otbNc+dr0Hog==
Message-ID: <b99f8cdd-4adc-451e-9ccf-ba40f34fdb58@valdikss.org.ru>
Date: Mon, 28 Jul 2025 10:24:55 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] igc: fix disabling L1.2 PCI-E link substate on I226 on
 init
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@osuosl.org, vitaly.lifshits@intel.com,
 linux-pci@vger.kernel.org
References: <8d1e606d-7320-4f02-98fe-e899702ac6e7@molgen.mpg.de>
 <20250727204331.564435-1-iam@valdikss.org.ru>
 <c3713450-605d-4b1e-ae41-bbbcaedc946f@molgen.mpg.de>
Content-Language: ru, en-US
From: ValdikSS <iam@valdikss.org.ru>
Autocrypt: addr=iam@valdikss.org.ru; keydata=
 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
 OEcVmRU/pw5/zoQyQg==
In-Reply-To: <c3713450-605d-4b1e-ae41-bbbcaedc946f@molgen.mpg.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8ISjlwmQ4xgEwhv0eOuvCt0f"
X-Last-TLS-Session-Version: TLSv1.3

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8ISjlwmQ4xgEwhv0eOuvCt0f
Content-Type: multipart/mixed; boundary="------------wqMm6sZG28JzJBVqFDyJhGWp";
 protected-headers="v1"
From: ValdikSS <iam@valdikss.org.ru>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@osuosl.org, vitaly.lifshits@intel.com,
 linux-pci@vger.kernel.org
Message-ID: <b99f8cdd-4adc-451e-9ccf-ba40f34fdb58@valdikss.org.ru>
Subject: Re: [PATCH] igc: fix disabling L1.2 PCI-E link substate on I226 on
 init
References: <8d1e606d-7320-4f02-98fe-e899702ac6e7@molgen.mpg.de>
 <20250727204331.564435-1-iam@valdikss.org.ru>
 <c3713450-605d-4b1e-ae41-bbbcaedc946f@molgen.mpg.de>
In-Reply-To: <c3713450-605d-4b1e-ae41-bbbcaedc946f@molgen.mpg.de>

--------------wqMm6sZG28JzJBVqFDyJhGWp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDcuMjAyNSAxMDowMyBBTSwgUGF1bCBNZW56ZWwgd3JvdGU6DQo+IERlYXIgVmFs
ZGlrU1MsDQo+IA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLiBQbGVhc2UgbWFr
ZSBzdXJlIHRvIHVzZSBgZ2l0IGZvcm1hdC1wYXRjaCAtIA0KPiB2PE4+YCAocmVyb2xsIGNv
dW50KSB0byBtYXJrIHRoZSBpdGVyYXRpb24gb2YgdGhlIHBhdGNoLg0KPiANCj4gQW0gMjcu
MDcuMjUgdW0gMjI6NDMgc2NocmllYiBWYWxkaWtTUzoNCj4+IERldmljZSBJRCBjb21wYXJp
c29uIGluIGlnY19pc19kZXZpY2VfaWRfaTIyNiBpcyBwZXJmb3JtZWQgYmVmb3JlDQo+PiB0
aGUgSUQgaXMgc2V0LCByZXN1bHRpbmcgaW4gYWx3YXlzIGZhaWxpbmcgY2hlY2sgb24gaW5p
dC4NCj4+DQo+PiBCZWZvcmUgdGhlIHBhdGNoOg0KPj4gKiBMMS4yIGlzIG5vdCBkaXNhYmxl
ZCBvbiBpbml0DQo+PiAqIEwxLjIgaXMgcHJvcGVybHkgZGlzYWJsZWQgYWZ0ZXIgc3VzcGVu
ZC1yZXN1bWUgY3ljbGUNCj4+DQo+PiBXaXRoIHRoZSBwYXRjaDoNCj4+ICogTDEuMiBpcyBw
cm9wZXJseSBkaXNhYmxlZCBib3RoIG9uIGluaXQgYW5kIGFmdGVyIHN1c3BlbmQtcmVzdW1l
DQo+Pg0KPj4gSG93IHRvIHRlc3Q6DQo+PiBDb25uZWN0IHRvIHRoZSAxRyBsaW5rIHdpdGgg
MzAwKyBtYml0L3MgSW50ZXJuZXQgc3BlZWQsIGFuZCBydW4NCj4+IHRoZSBkb3dubG9hZCBz
cGVlZCB0ZXN0LCBzdWNoIGFzOg0KPj4NCj4+IMKgwqDCoMKgIGN1cmwgLW8gL2Rldi9udWxs
IGh0dHA6Ly9zcGVlZHRlc3Quc2VsZWN0ZWwucnUvMUdCDQo+Pg0KPj4gV2l0aG91dCBMMS4y
IGRpc2FibGVkLCB0aGUgc3BlZWQgd291bGQgYmUgbm8gbW9yZSB0aGFuIH4yMDAgbWJpdC9z
Lg0KPj4gV2l0aCBMMS4yIGRpc2FibGVkLCB0aGUgc3BlZWQgd291bGQgcmVhY2ggMSBnYml0
L3MuDQo+PiBOb3RlOiBpdCdzIHJlcXVpcmVkIHRoYXQgdGhlIGxhdGVuY3kgYmV0d2VlbiB5
b3VyIGhvc3QgYW5kIHRoZSByZW1vdGUNCj4+IGJlIGFyb3VuZCAzLTUgbXMsIHRoZSB0ZXN0
IGluc2lkZSBMQU4gKDwxIG1zIGxhdGVuY3kpIHdvbid0IHRyaWdnZXIgdGhlDQo+PiBpc3N1
ZS4NCj4gDQo+IGBzdWRvIGxzcGNpIC12diAtcyA8eD5gIGNhbiBiZSB1c2VkIHRvIGNoZWNr
IEwxLjIgZW5hYmxlbWVudCB1bmRlciANCj4gYEwxU3ViQ3RsMWAuDQoNCklzIHRoaXMgd2hh
dCB5b3Ugc3VnZ2VzdCBtZSB0byBpbmNsdWRlIGFuZCBzZW5kIHRoZSBwYXRjaCBhZ2Fpbj8N
CkknZCBwcmVmZXIgbm90IHRvIGJlIGludm9sdmVkIGluIHRoZSBidWcgZml4aW5nIHByb2Nl
c3MuIEkganVzdCBzZW50IGEgDQpwYXRjaCBiZWNhdXNlIGl0IHdvcmtzIGZvciBtZSwgYXMg
dGhlIHN1Z2dlc3Rpb24gZm9yIHRoZSBmaXguIEkgZGlkIG5vdCANCmtub3cgaXQgd291bGQg
cmVxdWlyZSBtZSB0byBiZSBpbnZvbHZlZCBpbiB0aGUgcHJvY2Vzcy4NCg0KPiANCj4+DQo+
PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9pbnRlbC13aXJlZC0gDQo+PiBsYW4v
MTUyNDhiNGYtMzI3MS00MmRkLThlMzUtMDJiZmM5MmIyNWUxQGludGVsLmNvbQ0KPj4gRml4
ZXM6IDAzMjUxNDNiNTljNiAoImlnYzogZGlzYWJsZSBMMS4yIFBDSS1FIGxpbmsgc3Vic3Rh
dGUgdG8gYXZvaWQgDQo+PiBwZXJmb3JtYW5jZSBpc3N1ZSIpDQo+PiBTaWduZWQtb2ZmLWJ5
OiBWYWxkaWtTUyA8aWFtQHZhbGRpa3NzLm9yZy5ydT4NCj4+IFJldmlld2VkLWJ5OiBWaXRh
bHkgTGlmc2hpdHMgPHZpdGFseS5saWZzaGl0c0BpbnRlbC5jb20+DQo+PiAtLS0NCj4+IMKg
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jIHwgMTQgKysrKysr
Ky0tLS0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2lnYy9pZ2NfbWFpbi5jIGIvZHJpdmVycy9uZXQvIA0KPj4gZXRoZXJuZXQvaW50ZWwv
aWdjL2lnY19tYWluLmMNCj4+IGluZGV4IDAzMWMzMzJmNi4uMWI0NDY1ZDZiIDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj4+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jDQo+PiBA
QCAtNzExNSw2ICs3MTE1LDEzIEBAIHN0YXRpYyBpbnQgaWdjX3Byb2JlKHN0cnVjdCBwY2lf
ZGV2ICpwZGV2LA0KPj4gwqDCoMKgwqDCoCBhZGFwdGVyLT5wb3J0X251bSA9IGh3LT5idXMu
ZnVuYzsNCj4+IMKgwqDCoMKgwqAgYWRhcHRlci0+bXNnX2VuYWJsZSA9IG5ldGlmX21zZ19p
bml0KGRlYnVnLCBERUZBVUxUX01TR19FTkFCTEUpOw0KPj4gK8KgwqDCoCAvKiBQQ0kgY29u
ZmlnIHNwYWNlIGluZm8gKi8NCj4+ICvCoMKgwqAgaHctPnZlbmRvcl9pZCA9IHBkZXYtPnZl
bmRvcjsNCj4+ICvCoMKgwqAgaHctPmRldmljZV9pZCA9IHBkZXYtPmRldmljZTsNCj4+ICvC
oMKgwqAgaHctPnJldmlzaW9uX2lkID0gcGRldi0+cmV2aXNpb247DQo+PiArwqDCoMKgIGh3
LT5zdWJzeXN0ZW1fdmVuZG9yX2lkID0gcGRldi0+c3Vic3lzdGVtX3ZlbmRvcjsNCj4+ICvC
oMKgwqAgaHctPnN1YnN5c3RlbV9kZXZpY2VfaWQgPSBwZGV2LT5zdWJzeXN0ZW1fZGV2aWNl
Ow0KPj4gKw0KPj4gwqDCoMKgwqDCoCAvKiBEaXNhYmxlIEFTUE0gTDEuMiBvbiBJMjI2IGRl
dmljZXMgdG8gYXZvaWQgcGFja2V0IGxvc3MgKi8NCj4+IMKgwqDCoMKgwqAgaWYgKGlnY19p
c19kZXZpY2VfaWRfaTIyNihodykpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX2Rpc2Fi
bGVfbGlua19zdGF0ZShwZGV2LCBQQ0lFX0xJTktfU1RBVEVfTDFfMik7DQo+PiBAQCAtNzE0
MSwxMyArNzE0OCw2IEBAIHN0YXRpYyBpbnQgaWdjX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2LA0KPj4gwqDCoMKgwqDCoCBuZXRkZXYtPm1lbV9zdGFydCA9IHBjaV9yZXNvdXJjZV9z
dGFydChwZGV2LCAwKTsNCj4+IMKgwqDCoMKgwqAgbmV0ZGV2LT5tZW1fZW5kID0gcGNpX3Jl
c291cmNlX2VuZChwZGV2LCAwKTsNCj4+IC3CoMKgwqAgLyogUENJIGNvbmZpZyBzcGFjZSBp
bmZvICovDQo+PiAtwqDCoMKgIGh3LT52ZW5kb3JfaWQgPSBwZGV2LT52ZW5kb3I7DQo+PiAt
wqDCoMKgIGh3LT5kZXZpY2VfaWQgPSBwZGV2LT5kZXZpY2U7DQo+PiAtwqDCoMKgIGh3LT5y
ZXZpc2lvbl9pZCA9IHBkZXYtPnJldmlzaW9uOw0KPj4gLcKgwqDCoCBody0+c3Vic3lzdGVt
X3ZlbmRvcl9pZCA9IHBkZXYtPnN1YnN5c3RlbV92ZW5kb3I7DQo+PiAtwqDCoMKgIGh3LT5z
dWJzeXN0ZW1fZGV2aWNlX2lkID0gcGRldi0+c3Vic3lzdGVtX2RldmljZTsNCj4+IC0NCj4+
IMKgwqDCoMKgwqAgLyogQ29weSB0aGUgZGVmYXVsdCBNQUMgYW5kIFBIWSBmdW5jdGlvbiBw
b2ludGVycyAqLw0KPj4gwqDCoMKgwqDCoCBtZW1jcHkoJmh3LT5tYWMub3BzLCBlaS0+bWFj
X29wcywgc2l6ZW9mKGh3LT5tYWMub3BzKSk7DQo+PiDCoMKgwqDCoMKgIG1lbWNweSgmaHct
PnBoeS5vcHMsIGVpLT5waHlfb3BzLCBzaXplb2YoaHctPnBoeS5vcHMpKTsNCj4gDQo+IFJl
dmlld2VkLWJ5OiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPiANCj4g
DQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCg0K

--------------wqMm6sZG28JzJBVqFDyJhGWp--

--------------8ISjlwmQ4xgEwhv0eOuvCt0f
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEMiogvXcpmS32v71gXNcgLu+I93IFAmiHJccFAwAAAAAACgkQXNcgLu+I93KH
4BAAgYSyZkRukzq7lnC28eW4oF8Ij3VsPjVKWNW4WEopVlOY2IZQdUt7U40IXh5Ajj6xzJAlIW1A
2PLgM04Q3xUKBRlZJlR3r4pNxDH1qnLNGhm9JPwXL8PDKE6ABecFllrTeYAA7rt7D9ErhhLDWysw
qepwH4ti0qQxJycCt5hfQT7rowSAaV6dYn0l0iPZVLavoQICLaSGFboJw//A7Mrqo6WH3vFx6HxW
V5K8g1jA+7yzoSlaJPEEKy37AgWuhbGAFe4s1L5B3aFijcMQdoSNBtSnsdNOgbz0+mv6EvR/mssK
XwymHFiI/eY/hqGw5x4vg8kwV8qhnmqw/A514Aky5vz/KGVUim45nKgP+qxCtb40WjgbFVSF1+Rr
DTSDO91Id8i0P7i8dFLX2MJXEFdRhwvlzq6Q3+lMd1BkrE0ZK4Nw0gKzvNIvB7iNfnbHwQEzMlsG
1uBzcCAdM+Bvxy+RAggH6jOJ8IMT/QY8VN1osv+Ofrd0CACOXFQ3hPT0o3xlz6+3NsZBRqKeiOHZ
p0p7miIiqOJEp9JosN0H9h1MTTBD+8OxY4w53eGRGM6ilgdJjFi4qR4Ek/txUf+6vmdSQShsWtUS
RL117+pn0pXULAubNqct8hwYU65xkDsWHLMck+xPwi7euzqxtw+z9fcibUU9JJn/ppRKSH34axJq
hiI=
=rn7v
-----END PGP SIGNATURE-----

--------------8ISjlwmQ4xgEwhv0eOuvCt0f--

