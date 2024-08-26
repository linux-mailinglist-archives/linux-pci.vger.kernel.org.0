Return-Path: <linux-pci+bounces-12191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0630595ECA7
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 11:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7821C20D62
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD3C7404B;
	Mon, 26 Aug 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wistron.com header.i=@wistron.com header.b="LVgYUfzO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00575502.pphosted.com (mx08-00575502.pphosted.com [143.55.149.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013C84047
	for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2024 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.55.149.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663133; cv=none; b=BopP6kI66oWND6D+GAfTjJlo1RprRdwyLMRKvM2HV/xgHvnzNruE2gfRHb86cvoI13Eehs9vTGrjAFkiEkZ30dvWH1Y3XpCoj6XDtO/A+kn9zVLHre/1UJvdbiJrjHb4cDs48wXB/htASFCHyYKhBlm2cFIvSR+SqfmAs/4rENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663133; c=relaxed/simple;
	bh=MxDcoU4xfXf34O226iO4nTxxURjv2FjOwdCqkDH/FJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BEEHJjWUZZJh6uK4G2O+qqU7Z1HWIGrr7z/5DJ2PWn+SCGRUvrHBRq5MIm5pFh00XTZcR2CvpdP/+iwjgMK1fo8Lz8coAXU+8Ng/18gfQJ8OLcqr1jZsoOetlUW+QrM/kpeaqP0nzQDf04VX7IxgxSUYs+G2zTH4qKZJo7lf3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wistron.com; spf=pass smtp.mailfrom=wistron.com; dkim=pass (2048-bit key) header.d=wistron.com header.i=@wistron.com header.b=LVgYUfzO; arc=none smtp.client-ip=143.55.149.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wistron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wistron.com
Received: from pps.filterd (m0320709.ppops.net [127.0.0.1])
	by mx08-00575502.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PNLMXN000556;
	Mon, 26 Aug 2024 17:05:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wistron.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=POD111722; bh=
	MxDcoU4xfXf34O226iO4nTxxURjv2FjOwdCqkDH/FJc=; b=LVgYUfzOBFgu10jf
	jkqOsQKfdYsIotmPGuVGfgIiiDg/EjAvJN9NbIboFH2prV8vghju/POFlv+5OnsY
	PaUdifFU/ivz7b0X56cityeVohNRHus0aSyfi3cRsitih+s/G/HeFDL+V2wwcLOH
	iVFDL06aAla0k1JpjYsNnPefqzZ2dTYpg6mkXNq7GhN1gFTZm5cBCwSNLsDgITO3
	l8zHcCks0nJcH+6QosXxFmw2KAr8QFkTTJhmeyc7sCpmriuqtQ9wmRohgZ4XLrMg
	cdFveoOGkAzscmBhmKLMMJ70S42w4/QQkQ5sLfZgjSiRz9bV55cBVozX5ChuDYKt
	HqfU2A==
Received: from exchapp02.whq.wistron ([103.200.3.46])
	by mx08-00575502.pphosted.com (PPS) with ESMTPS id 417m8a2cwn-48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 26 Aug 2024 17:05:26 +0800 (WST)
Received: from EXCHAPP02.whq.wistron (10.37.38.25) by EXCHAPP02.whq.wistron
 (10.37.38.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 26 Aug
 2024 17:05:21 +0800
Received: from EXCHAPP02.whq.wistron ([fe80::a868:98a2:1a02:a09e]) by
 EXCHAPP02.whq.wistron ([fe80::a868:98a2:1a02:a09e%5]) with mapi id
 15.01.2507.037; Mon, 26 Aug 2024 17:05:21 +0800
From: <Erin_Tsao@wistron.com>
To: <mj@ucw.cz>
CC: <linux-pci@vger.kernel.org>
Subject: RE: Issue about PCI physical slot fetch incorrect number
Thread-Topic: Issue about PCI physical slot fetch incorrect number
Thread-Index: Adr1PvX6/qcTVDyjSamqZ+r0sIAGuAAC4PIAAJMcP4A=
Date: Mon, 26 Aug 2024 09:05:21 +0000
Message-ID: <706e4367f1724a9cad739a1b88618791@wistron.com>
References: <a600fc09c06d4ca28b045668ad1e63cb@wistron.com>
 <mj+md-20240823.185024.10254.nikam@ucw.cz>
In-Reply-To: <mj+md-20240823.185024.10254.nikam@ucw.cz>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: D6E396C5ED51EA47370597927C3400C6FE1C00668DB2E2D815AC84944C5089422000:8
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: WUX0Orq9L5JfHHhSw-fa3zA9-3Mzmo4m
X-Proofpoint-ORIG-GUID: WUX0Orq9L5JfHHhSw-fa3zA9-3Mzmo4m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_14,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1031 malwarescore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=700 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260071
Content-Type: text/plain; charset="utf-8"

SGkgTWFydGluLA0KVGhhbmtzIGZvciBoZWxwaW5nIG1lIGZvcndhcmRpbmcgdGhlIG1haWwuDQpI
b3BlIHRvIGhhdmUgZ29vZCBuZXdzIGZyb20gdGhlbS4NCg0KV2lzaCB5b3UgaGF2ZSBhIGdvb2Qg
ZGF5IQ0KDQpCUiwNCkVyaW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1h
cnRpbiBNYXJlxaEgPG1qQHVjdy5jej4gDQpTZW50OiBTYXR1cmRheSwgQXVndXN0IDI0LCAyMDI0
IDI6NTIgQU0NClRvOiBFcmluIFRzYW8vV0hRL1dpc3Ryb24gPEVyaW5fVHNhb0B3aXN0cm9uLmNv
bT4NCkNjOiBMaW51eC1QQ0kgTWFpbGluZyBMaXN0IDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
Pg0KU3ViamVjdDogUmU6IElzc3VlIGFib3V0IFBDSSBwaHlzaWNhbCBzbG90IGZldGNoIGluY29y
cmVjdCBudW1iZXINCg0KSGkhDQoNCj4gVGhpcyBpcyBFcmluIGZyb20gVGFpd2FuLiBJIGhhdmUg
YSBxdWVzdGlvbiBhYm91dCBwaHlzaWNhbCBzbG90IG51bWJlci4NCj4gQ3VycmVudGx5IHdlIGFy
ZSB3b3JraW5nIG9uIHRoZSBQQ0lFIHNsb3QgbnVtYmVyIGFzc2lnbmluZyBieSBQQ0lFIHN3aXRj
aC4gSW4gdGhlIFBDSWUgc2xvdCBhc3NpZ25tZW50IHByb2Nlc3MsIHRoZSBzbG90IG51bWJlcnMg
YXJlIGFzc2lnbmVkIHRvIGJyaWRnZXMgZmlyc3QsIGFuZCB0aGVuIHRoZSBlbmQgZGV2aWNlcyBm
ZXRjaCB0aGUgc2xvdCBJRCBmcm9tIHRoZSBicmlkZ2UgaW4gdGhlIHVwcGVyIGxheWVyLg0KPiAN
Cj4gSSBoYXZlIG9ic2VydmVkIHRoYXQgdW5kZXIgb3VyIFBDSUUgc3dpdGNoLCBHUFVzIHdpbGwg
Y3JlYXRlIGEgYnJpZGdlIGJlZm9yZSByZWFjaGluZyB0aGUgZW5kIGRldmljZS4gSWYgR1BVcyBh
bHNvIGZldGNoIHRoZSBzbG90IElEIGZyb20gdGhlIHVwcGVyIGJyaWRnZSBsYXllciwgdGhleSBt
YXkgcmV0cmlldmUgaW5jb3JyZWN0IHZhbHVlcy4NCj4gDQo+IE91ciBHUFUgd2lsbCBnZXQgdGhl
IHBoeXNpY2FsIHNsb3QgbnVtYmVyIHdpdGggbnVtYmVyIOKAnDDigJ0sIGFuZCBzaG93IHRoZSBz
bG90IG51bWJlciDigJww4oCd44CB4oCdMC0x4oCdICwgZXRjLg0KPiBNYXkgSSBhc2sNCj4gDQo+
ICAgMS4gIFdoeSBHUFUgd2lsbCBmZXRjaCB0aGUgc2xvdCBudW1iZXIg4oCcMOKAnT8gSXMgdGhl
IHNsb3QgbnVtYmVyIGFzc2lnbmVkIHRvIEdQVSByZWxhdGVkIHRvIGFueSByZWdpc3Rlcj8gT3Ig
Y2FuIHdlIHNldCBhbnkgYml0IHRvIGZldGNoIHRoZSByaWdodCBudW1iZXI/DQo+ICAgMi4gIElz
IHRoZXJlIGFueSBwb3NzaWJsZSBmb3IgdXMgbm90IHRvIHNob3cgdGhlIHBoeXNpY2FsIHNsb3Qg
bnVtYmVyIG9mIEdQVT8NCj4gDQo+IEkgaGF2ZSBjaGVja2VkIHdpdGggdGhlIGNvZGUgb24gdGhl
IGdpdCwgdW5mb3J0dW5hdGVseSBJIGRpZG7igJl0IG9idGFpbiBhbnkgYW5zd2VyLg0KPiBJdCB3
aWxsIHJlYWxseSBiZSBoZWxwZnVsIHRvIGdldCB0aGUgcmVzcG9uc2UgZnJvbSB5b3UuDQo+IEhv
cGUgdG8gaGVhciBmcm9tIHlvdSBzb29uLCB0aGFua3MgaW4gYWR2YW5jZS4NCg0KSXQncyBhIGxv
bmcgbG9uZyB0aW1lIHNpbmNlIEkgd2FzIHRoZSBtYWludGFpbmVyIG9mIHRoZSBQQ0kgbGF5ZXIg
aW4gdGhlIGtlcm5lbC4gTm93IEkgbWFpbnRhaW4ganVzdCB0aGUgUENJIHV0aWxpdGllcyB3aGlj
aCBkaXNwbGF5IHdoYXRldmVyIHRoZSBrZXJuZWwgdGVsbHMgdGhlbS4NCg0KSSBhbSBmb3J3YXJk
aW5nIHlvdXIgcXVlc3Rpb24gdG8gdGhlIGxpbnV4LXBjaSBtYWlsaW5nIGxpc3Qgd2hlcmUgaXQg
aG9wZWZ1bGx5IGZpbmRzIGEgYmV0dGVyIGF1ZGllbmNlLg0KDQoJCQkJTWFydGluDQoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRoaXMgZW1haWwgY29udGFp
bnMgY29uZmlkZW50aWFsIG9yIGxlZ2FsbHkgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbiBhbmQgaXMg
Zm9yIHRoZSBzb2xlIHVzZSBvZiBpdHMgaW50ZW5kZWQgcmVjaXBpZW50LgpBbnkgdW5hdXRob3Jp
emVkIHJldmlldywgdXNlLCBjb3B5aW5nIG9yIGRpc3RyaWJ1dGlvbiBvZiB0aGlzIGVtYWlsIG9y
IHRoZSBjb250ZW50IG9mIHRoaXMgZW1haWwgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4KSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91IG1heSByZXBseSB0byB0aGUgc2Vu
ZGVyIGFuZCBzaG91bGQgZGVsZXRlIHRoaXMgZS1tYWlsIGltbWVkaWF0ZWx5LgotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K

