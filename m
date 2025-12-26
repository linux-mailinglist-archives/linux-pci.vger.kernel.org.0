Return-Path: <linux-pci+bounces-43725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5E6CDEA11
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 12:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F40E5300647F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8538831A05E;
	Fri, 26 Dec 2025 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKXBVGXb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE431960F
	for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766747521; cv=none; b=afVwUGs28ccw/1Fl2XuWPDesl6BPP/KvNA1Sx4J975N46ipVj3YrY2LMkRj9w/zrWvk3xyjSfCyhgtXGWUIFoYHpu92uEEW4zhscSffmbQNClIauJmctE8uW0NZaI/vkYkYXL6ycqVcal2T2X3HK/YYZNKsgOvbTLLGBKCZf/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766747521; c=relaxed/simple;
	bh=GrEryL+CS0vvELyT36eR2JXYpd/5DcbikdcG9E3uqtc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dLUGpxSEK1OwRfJJh2746xn4g1zK844339MZG+HiOV09JKHbSb7jW5obLUAKE9KRGOHdBHO9JsLkUe8X+QfuT+xd2tYQLI67XvxqpsJ4JcXRFNm3Mizq/rd4B4J0Rj18rjf2NrQzZbZQ1uePmdj1EDUx5PLyo/+4rYIWMrGqEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKXBVGXb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a09757004cso92051495ad.3
        for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 03:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766747519; x=1767352319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrEryL+CS0vvELyT36eR2JXYpd/5DcbikdcG9E3uqtc=;
        b=bKXBVGXb0+jFhCCWBtJoK06x0dX52wc7iXcgg2QaOuJtNNSdY7TWc9oR9ZIYy8LX9X
         jfAvuVFpd563SG/mlGFuOCj1TwcBSyZ8D0NAz2vkQQXSBb40PuK507PWvGXvboIC5K1n
         8du7an+mnYiIjP/XhGWxeiqCNXfSGxY0WAt/77MQwkm8dATzSW1lBFvBIeudjPzoCBlo
         ps3PYX4EujG24kWDIY0CCa68Stw05k0bdvQAoix4f3oNe+t8YhjTlt8+GnkYIJRQh0y8
         jpsIAGLIrLV+W2p8VVjfQwKumDKQ781OI4Zc/DcNG1bWegPSjPikleTyMB4lzGHwB6Mu
         1dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766747519; x=1767352319;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrEryL+CS0vvELyT36eR2JXYpd/5DcbikdcG9E3uqtc=;
        b=YEaUVSdDfdSFQEOMjPGLh+IzFYDc5+0Wgno2sFlDQ6v04JhyZI5gAVD5h+S7utEdxc
         GVOgJ0ppqkcBe8sTq+8T80FDDlyYhKw3NpckS1iek98qpJIHlFBPy8W3mBMJrKrEdT0C
         ByjNyECNVRqWRPp9Bdzw6UTGF6P2g8BtlomQhVrFVM+FqlKGJEiSFB8Yp673t4JVEcM5
         9UEX84/ngbIUiWJSiJ5QsnoGjSu1gZQWOYwRBFu6d0dMFNIJa9rUBag0hZpuNfbBPyTC
         LG0PDmladKbNTd78mW6Q7GAnLGhTIaqW0QTLjrVNCXeI+56G9jQCIFE0VIcBiM/GHnBs
         Encw==
X-Forwarded-Encrypted: i=1; AJvYcCXEe//Mkp7wOa2LqoI6M7mIWbBRosL6F3T6unq4pZpNj4lePbtqbVfX1jCfE6U4UtFo2Bl7o2ZpKA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcFJ3+OG+Nyfy1JY8PvG20PaVzhogavTti/8Rspveb777nfhg8
	m8069OSaAG62ZWCFQ/0DHxpUa//cmMmj/CflgOEzEAHxvJMXP+pW81As
X-Gm-Gg: AY/fxX4zJAFT1jaFTXRFBf9LnwDyx6NJSIyGEK7dRvLKhgIbLPXCqtj74MO4KidwF/K
	fiVbpAC17doPdGWKzYrmeQh9yUfO7EAXPINbOnw1H5SIpQ4xdBPnFVVUgySbxlQHPX+octYQu67
	jcyIHNhP5QuCwLi3nUtXTnnVkJBFb6BEJd5dgo9i+4U0RcQGjKP9WQkup/1vSrBoiwD7glV2tfB
	LcArD73sqqevWimuIZ5pcZouTcEPW5a4EMV+YOUiJT6UgU+dPhngjfHnnkQyJn5QKGSHGSv2a5L
	mp1W8P4ZB65AV7Brg0skmGd0u2NKgUlUq9mQRx1aCfCLMYfXNrPKKjpnfmUZLO5Z1UFl1mEpskS
	B4f9Q2OlCNICYInBK9cxqkXUXSjTWws4iGfwZMc2ccj/dHeeptA8RoYgg64LIvrIsXiXL00tfqC
	Od+21K4SmPCPt6VOOjsADkhkstYoly2WncEpE+daKiueeeMttJRe3VqvqqvPQXq8AzSiw=
X-Google-Smtp-Source: AGHT+IGGipCbhgaQOoY2a9zGN67p1m3gUlBc7Gwg4kuol771fhfZChu6DYeHJHsL/FtWYs3YsAKz1Q==
X-Received: by 2002:a17:903:190d:b0:2a0:a09b:7b0 with SMTP id d9443c01a7336-2a2f2c5f2d3mr236489945ad.61.1766747519188;
        Fri, 26 Dec 2025 03:11:59 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c6661esm199723195ad.2.2025.12.26.03.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 03:11:57 -0800 (PST)
Date: Fri, 26 Dec 2025 20:11:42 +0900 (JST)
Message-Id: <20251226.201142.1049434388098064267.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, miguel.ojeda.sandonis@gmail.com,
 dakr@kernel.org, bhelgaas@google.com, ojeda@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, joelagnelf@nvidia.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, buaajxlj@163.com
Subject: Re: [PATCH] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aU0PnCV69l7lV2aS@tardis-2.local>
References: <CANiq72n1SX4OGFR4wNzurNX2RQki_ZmD13bBfywxxOEmw6cGZg@mail.gmail.com>
	<20251225.183631.866118259815088053.fujita.tomonori@gmail.com>
	<aU0PnCV69l7lV2aS@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVGh1LCAyNSBEZWMgMjAyNSAxODoxOTowOCArMDgwMA0KQm9xdW4gRmVuZyA8Ym9xdW4uZmVu
Z0BnbWFpbC5jb20+IHdyb3RlOg0KDQo+IE9uIFRodSwgRGVjIDI1LCAyMDI1IGF0IDA2OjM2OjMx
UE0gKzA5MDAsIEZVSklUQSBUb21vbm9yaSB3cm90ZToNCj4+IE9uIFRodSwgMjUgRGVjIDIwMjUg
MTA6MTA6MDQgKzAxMDANCj4+IE1pZ3VlbCBPamVkYSA8bWlndWVsLm9qZWRhLnNhbmRvbmlzQGdt
YWlsLmNvbT4gd3JvdGU6DQo+PiANCj4+ID4gT24gTW9uLCBEZWMgMTUsIDIwMjUgYXQgMzo1NOKA
r0FNIEJvcXVuIEZlbmcgPGJvcXVuLmZlbmdAZ21haWwuY29tPiB3cm90ZToNCj4+ID4+DQo+PiA+
PiBDb21taXQgNDczYjlmMzMxNzE4ICgicnVzdDogcGNpOiBmaXggYnVpbGQgZmFpbHVyZSB3aGVu
IENPTkZJR19QQ0lfTVNJDQo+PiA+PiBpcyBkaXNhYmxlZCIpIGZpeGVkIGEgYnVpbGQgZXJyb3Ig
YnkgcHJvdmlkaW5nIHJ1c3QgaGVscGVycyB3aGVuDQo+PiA+PiBDT05GSUdfUENJX01TST1uLiBI
b3dldmVyIHRoZSBydXN0IGhlbHBlcnMgcmVseSBvbiB0aGUNCj4+ID4+IHBjaV9hbGxvY19pcnFf
dmVjdG9ycygpIGZ1bmN0aW9uIGlzIGRlZmluZWQsIHdoaWNoIGlzIG5vdCB0cnVlIHdoZW4NCj4+
ID4+IENPTkZJR19QQ0k9bi4gVGhlcmUgYXJlIG11bHRpcGxlIHdheXMgdG8gZml4IHRoaXMsIGUu
Zy4gYSBwb3NzaWJsZSBmaXgNCj4+ID4+IGNvdWxkIGJlIGp1c3QgcmVtb3ZlIHRoZSBjYWxsaW5n
IG9mIHBjaV9hbGxvY19pcnFfdmVjdG9ycygpIHNpbmNlIGl0J3MNCj4+ID4+IGVtcHR5IHdoZW4g
Q09ORklHX1BDSV9NU0k9biBhbnl3YXkuIEhvd2V2ZXIsIHNpbmNlIFBDSSBpcnEgQVBJcywgc3Vj
aCBhcw0KPj4gPj4gcGNpX2FsbG9jX2lycV92ZWN0b3JzKCksIGFyZSBhbHJlYWR5IGRlZmluZWQg
ZXZlbiB3aGVuIENPTkZJR19QQ0k9biwgdGhlDQo+PiA+PiBtb3JlIHJlYXNvbmFibGUgZml4IGlz
IHRvIGRlZmluZSBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMoKSB3aGVuDQo+PiA+PiBDT05GSUdfUENJ
PW4gYW5kIHRoaXMgYWxpZ25zIHdpdGggdGhlIHNpdHVhdGlvbnMgb2Ygb3RoZXIgcHJpbWl0aXZl
cyBhcw0KPj4gPj4gd2VsbC4NCj4+ID4+DQo+PiA+PiBGaXhlczogNDczYjlmMzMxNzE4ICgicnVz
dDogcGNpOiBmaXggYnVpbGQgZmFpbHVyZSB3aGVuIENPTkZJR19QQ0lfTVNJIGlzIGRpc2FibGVk
IikNCj4+ID4+IFNpZ25lZC1vZmYtYnk6IEJvcXVuIEZlbmcgPGJvcXVuLmZlbmdAZ21haWwuY29t
Pg0KPj4gPiANCj4+ID4gUmVsYXRlZDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcnVzdC1mb3It
bGludXgvMjAyNTEyMDkwMTQzMTIuNTc1OTQwLTEtZnVqaXRhLnRvbW9ub3JpQGdtYWlsLmNvbS8N
Cj4+ID4gDQo+PiA+IEkgZ3Vlc3MgaXQgY291bnRzIGFzIGEgcmVwb3J0LCBzbyB3ZSBtYXkgd2Fu
dCBhIFJlcG9ydGVkLWJ5IChDYydpbmcgVG9tbykuDQo+PiANCj4+IFNpbmNlIHBjaS5ycyBpcyBv
bmx5IGNvbXBpbGVkIHdoZW4gQ09ORklHX1BDSSBpcyBlbmFibGVkLiBTbyBpdCBzZWVtcw0KPj4g
Y29uc2lzdGVudCB0byB0cmVhdCB0aGUgUENJIGhlbHBlcnMgdGhlIHNhbWUgd2F5LiBUaGF0IHNh
aWQsIHRoaXMNCj4+IGFwcHJvYWNoIGlzIGFsc28gZmluZSBieSBtZTogaXQncyBhbHJlYWR5IGlu
Y29uc2lzdGVudCB0aGF0DQo+PiBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMoKSBoYXMgYSBzdHVmIGRl
ZmluaXRpb24sIHdoaWxlDQo+PiBwY2lfZnJlZV9pcnFfdmVjdG9ycyBkb2VzIG5vdC4NCj4gDQo+
IFllcywgSSB0aGluayBwcm92aWRpbmcgYSBzdHViIHBjaV9mcmVlX2lycV92ZWN0b3JzKCkgaXMg
dGhlIHdheSB0byBnby4NCj4gSWYgeW91IGFyZSBPSyB3aXRoIGl0LCBJIGNvdWxkIHNlbmQgYSB2
MiB3aXRoIHlvdXIgYW5kIExpYW5nIEppZSdzDQo+IFJlcG9ydGVkLWJ5Lg0KDQpJdCB3b3JrcyBm
b3IgbWUuIFBsZWFzZSBnbyBhaGVhZC4NCg0K

