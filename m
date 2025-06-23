Return-Path: <linux-pci+bounces-30390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288D8AE4187
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BEA3A311A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F242417C3;
	Mon, 23 Jun 2025 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn9WYSvd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF261FE471;
	Mon, 23 Jun 2025 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683774; cv=none; b=GQVVIUUk7wBZf698hv7IUb05TZVNN3czrpAu8uOXsduqD78Lglq6VMEtZldoEir1OPyVVymcyy8AYQwUsop+KjVjHqykatrqmQX8U2eteKUnYeS8z51uaauM90MdUYhCCMJkvSfEiIFLACMPSmiDCcu3ZOgB6QIDTp9ExuxoLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683774; c=relaxed/simple;
	bh=Xeq6Pg8sZ2aLK1lGygK2fp4t32hS7q4ZlgEzaRC00Tc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jQczK7CzGQT5UfMbt+iXqDvkRsDXME96/+GoCbHZc8CfKTkTmhJYPUbyXBqH9CC53kEdT4om1gyRECL4DClK9Ai1ms9Abz6z+V5T46Gl6hW9l9eGL8618mRCVZY7lojVzozJ2VBC8DlZjtI21MwhRFIAlILmo5tkIb+Donxmw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn9WYSvd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747ef5996edso3059051b3a.0;
        Mon, 23 Jun 2025 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750683772; x=1751288572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xeq6Pg8sZ2aLK1lGygK2fp4t32hS7q4ZlgEzaRC00Tc=;
        b=fn9WYSvdge8o2NN+uKg18sg50Cqis+re3/b8FrHhBsbAKSAVGmEuW4c0D2np2mfWhf
         /bFw4eO+Gzpz06Tz9b0Ct5nU/A8H41ic5sx34fEpllfmmSNR+wzdT7HLAwEmuQhJ2iBz
         jV0FiVXzCyG9WvG9KJRro13uAlU/j4Rw+ZQvefSMgDixgmdUfhMJoMq//fNnUn18ak1i
         Lg8N6DfB167V72OMONqAPAUBARp4u8VKj4e3Whs1Cn9dwMeobRfbBxbTHDzgLDFQQWfg
         VYQXQGYtekN/0zLIU7FkPNjFrF6b/DDkcMMuNr9rFsb0p4t4Wd3m0OghULOOrWTPisDq
         411g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750683772; x=1751288572;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xeq6Pg8sZ2aLK1lGygK2fp4t32hS7q4ZlgEzaRC00Tc=;
        b=ok5Tg9n8b/gly8KQ1TImj00CLJ90dcF8msEwXo8EWpsE5j82A6Sj+0eMwphGx+sxaO
         I42lddCNZBULnmiabCRVrDnJ3HhIXEGBcAEpEO+6bffVAE/M/BC9QM2AEDe7IXSsCd9y
         Ofhny7MSEz1ENr4lpuGor2kyh5PkN9fxd58bnWt1NzUCV4MdycNf1uPZedC+A/1Dqh4H
         6nQ6XATzmwvYWebleVP08sl9f7jkKf5dFZLEH9XOEF2QSGH5NrOsDJCpmc0vnc/XOLRv
         AUHq53l9NsZ4r0Cy5glPDUu0RL8NZnSsmE1C/0wTaJib2j70S55lEJ6hXqw3FPw4Rfzc
         X8fw==
X-Forwarded-Encrypted: i=1; AJvYcCUAOpD/UV5uV0jMVAQENWPBS9iUjY33KQMSO5JKH3UrGa72EkPQ6qanzw3l3kHBQcmeXihAyHnW/ALmSF6W@vger.kernel.org, AJvYcCUfgb+MQQuFIjBnVzhhZLjIqwEcevsm0qwz2C3x0Zm+ZJ2OfCxEWSaYM0yzrnUhpQJqT0rIt9t0@vger.kernel.org, AJvYcCUhSHxZ5nvwKIOt2N5y0+ST5eExdPdktAeSRFyz9TIc/QgREMw8Z0Xs/SzGNj9IRKNIlRPA7fFGYgAIjXtE1tI=@vger.kernel.org, AJvYcCXGJ9tqhGWdTwH8D3QOFZAwEFKwyuTQC05wpAPJzPhTHVb4+qMgzd2RzucSHZ/m9RcTdJ/sl1Wg42Ws@vger.kernel.org, AJvYcCXwHz62AcPGPb40XxTRYB9pFcwPLQp/OUVLqVbjhwRcL0t/uwgOYFXN1kfCOxM1W1PoFZRHaFU1dubn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dCshTQEwXIMxEzwcyldw6V74HBu/FIRtfFKi4r9JsFOPGmJo
	9oDj9DksSWheIhNPFGGkQLCcwuW2vmlGdqqJqSXiC7kNju/MiUBhoWbj
X-Gm-Gg: ASbGncvlbvYketEzQ/Q5BkLQ00e9tt47mfPoe5yYWfkLYBMot5JP0eWfrcCROynT/AI
	zQqGtav8x4OeStfmOqoROXeyyfOb8ViQWUWBYZSjfAEHmf6hlNAs1zWU06KZ/scAE8wATrMlNtg
	ySFKjSc9BzHKR9wRXF9wGeYW4rv5jgGXNCyJnGRyiN2uXbpMeMO84MrPnaTERB5WrK1MvTO8PuY
	umbAnVuOnQz+X399w8Mv1s9lQyMdf8AglFprGFcTYP0y7J/EzX17jXllrWcffWijVGnPkw18lrD
	mlJa3DF/we2bmBoaWAzFJG1jdoUtOBcve2uFPy06soSTDAUExamkK/jpV9sMklStZHjzWVLdUdw
	xJduf4HTqY9IMBirblPRcS5QYVyplgcxPDd+byAzM
X-Google-Smtp-Source: AGHT+IGVNpouSlsRfTymPicwQT8PGziSWLGKudqEY8gNHmmkVArq8YNTueGaKZ2uytmMoxjPxrHKfw==
X-Received: by 2002:a05:6a20:72a1:b0:21f:fef9:d9f0 with SMTP id adf61e73a8af0-22026f59641mr18050899637.21.1750683771985;
        Mon, 23 Jun 2025 06:02:51 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1241f4asm6611886a12.44.2025.06.23.06.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 06:02:51 -0700 (PDT)
Date: Mon, 23 Jun 2025 22:02:35 +0900 (JST)
Message-Id: <20250623.220235.715005847758063914.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com, dakr@kernel.org,
 gregkh@linuxfoundation.org, ojeda@kernel.org, rafael@kernel.org,
 robh@kernel.org, saravanak@google.com, a.hindborg@kernel.org,
 aliceryhl@google.com, bhelgaas@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, david.m.ertman@intel.com,
 devicetree@vger.kernel.org, gary@garyguo.net, ira.weiny@intel.com,
 kwilczynski@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lossin@kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v1 3/3] rust: net::phy Change module_phy_driver macro
 to use module_device_table macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72k0sdUoBxVYghgh50+ZRV2gbDkgVjuZgJLtj=4s9852xg@mail.gmail.com>
References: <20250623060951.118564-1-fujita.tomonori@gmail.com>
	<20250623060951.118564-4-fujita.tomonori@gmail.com>
	<CANiq72k0sdUoBxVYghgh50+ZRV2gbDkgVjuZgJLtj=4s9852xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gTW9uLCAyMyBKdW4gMjAyNSAxMToyMTo1OSArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBNb24sIEp1biAyMywgMjAy
NSBhdCA4OjEw4oCvQU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwu
Y29tPiB3cm90ZToNCj4+DQo+PiArLy8gU0FGRVRZOiBbYERldmljZUlkYF0gaXMgYSBgI1tyZXBy
KHRyYW5zcGFyZW50KWAgd3JhcHBlciBvZiBgc3RydWN0IG1kaW9fZGV2aWNlX2lkYA0KPiANCj4g
Tm8gbmVlZCBmb3IgaW50cmEtZG9jIGxpbmsgaW4gbm9ybWFsIGNvbW1lbnRzLg0KDQpPb3BzLiBJ
J2xsIGZpeC4NCg0KPiBBbHNvLCBtaXNzaW5nIGJyYWNrZXQgKHdoaWNoIGFwcGFyZW50bHkgY29t
ZXMgZnJvbSBhbm90aGVyIGNvbW1lbnQsIHNvDQo+IHByb2JhYmx5IGNvcHktcGFzdGVkKS4NCg0K
WWVhaCwgaXQgd2FzIGNvcGllZCBmcm9tIHRoZSBQQ0kgY29kZS4gVGhlIHNhbWUgdHlwbyBleGlz
dHMgaW4NCm11bHRpcGxlIGZpbGVzLCBzbyBJ4oCZbGwgc2VuZCBhIGZpeCBmb3IgdGhlbSBsYXRl
ci4NCg0KPj4gKyAgICAvLyBUaGlzIHNob3VsZCBuZXZlciBiZSBjYWxsZWQuDQo+PiArICAgIGZu
IGluZGV4KCZzZWxmKSAtPiB1c2l6ZSB7DQo+PiArICAgICAgICAwDQo+PiArICAgIH0NCj4gDQo+
IEhtbS4uLiBUaGlzIGlzbid0IGdyZWF0LiBDb3VsZCB0aGlzIHBlcmhhcHMgYmUgZGVzaWduZWQg
ZGlmZmVyZW50bHk/DQo+IGUuZy4gc3BsaXQgaW50byB0d28gdHJhaXRzLCBwb3NzaWJseSBiYXNl
ZCBvbmUgb24gYW5vdGhlciwgb3Igc2ltaWxhcj8NCg0KWWVhaCwgSSBkb27igJl0IHJlYWxseSBs
aWtlIGl0IGVpdGhlci4NCg0KSSB0aGluayB3ZSBjb3VsZCBzcGxpdCB0aGUgUmF3RGV2aWNlSWQg
dHJhaXQgaW50byB0d286IFJhd0RldmljZUlkIGFuZA0KUmF3RGV2aWNlSWRJbmRleC4gRGV2aWNl
IElEIHN0cnVjdHVyZXMgdGhhdCBkbyBub3QgY29udGFpbg0KY29udGV4dC9kYXRhIGZpZWxkIChs
aWtlIG1kaW9fZGV2aWNlIGZvciBQSFkpIHdvdWxkIGltcGxlbWVudCBvbmx5DQpSYXdEZXZpY2VJ
ZCwgd2hpbGUgcGNpIGFuZCBvdGhlcnMgd291bGQgaW1wbGVtZW50IGJvdGguDQoNClRvIGF2b2lk
IGR1cGxpY2F0ZSBjb2RlLCB0aGUgbmV3KCkgZnVuY3Rpb24gaGFzIGJlZW4gc3BsaXQgaW50byB0
d28gYXMNCmZvbGxvd3MuIEknbSBhbHNvIGZpbmUgd2l0aCBzaW1wbHkgYWRkaW5nIGFuIGFzc2Vy
dCB0byBpbmRleCgpLg0KDQpkaWZmIC0tZ2l0IGEvcnVzdC9rZXJuZWwvZGV2aWNlX2lkLnJzIGIv
cnVzdC9rZXJuZWwvZGV2aWNlX2lkLnJzDQppbmRleCAzZGM3MmNhOGNmYzIuLmY5MjA1ZWEyYTA1
ZSAxMDA2NDQNCi0tLSBhL3J1c3Qva2VybmVsL2RldmljZV9pZC5ycw0KKysrIGIvcnVzdC9rZXJu
ZWwvZGV2aWNlX2lkLnJzDQpAQCAtMzUsNyArMzUsOSBAQCBwdWIgdW5zYWZlIHRyYWl0IFJhd0Rl
dmljZUlkIHsNCiAgICAgLy8vDQogICAgIC8vLyBJZCB0YWJsZXMgY3JlYXRlZCBmcm9tIFtgU2Vs
ZmBdIGFyZSBnb2luZyB0byBob2xkIHRoaXMgdHlwZSBpbiBpdHMgemVyby10ZXJtaW5hdGVkIGFy
cmF5Lg0KICAgICB0eXBlIFJhd1R5cGU6IENvcHk7DQorfQ0KIA0KK3B1YiB1bnNhZmUgdHJhaXQg
UmF3RGV2aWNlSWRJbmRleCB7DQogICAgIC8vLyBUaGUgb2Zmc2V0IHRvIHRoZSBjb250ZXh0L2Rh
dGEgZmllbGQuDQogICAgIGNvbnN0IERSSVZFUl9EQVRBX09GRlNFVDogdXNpemU7DQogDQpAQCAt
NjUsMTAgKzY3LDcgQEAgcHViIHN0cnVjdCBJZEFycmF5PFQ6IFJhd0RldmljZUlkLCBVLCBjb25z
dCBOOiB1c2l6ZT4gew0KIH0NCiANCiBpbXBsPFQ6IFJhd0RldmljZUlkLCBVLCBjb25zdCBOOiB1
c2l6ZT4gSWRBcnJheTxULCBVLCBOPiB7DQotICAgIC8vLyBDcmVhdGVzIGEgbmV3IGluc3RhbmNl
IG9mIHRoZSBhcnJheS4NCi0gICAgLy8vDQotICAgIC8vLyBUaGUgY29udGVudHMgYXJlIGRlcml2
ZWQgZnJvbSB0aGUgZ2l2ZW4gaWRlbnRpZmllcnMgYW5kIGNvbnRleHQgaW5mb3JtYXRpb24uDQot
ICAgIHB1YiBjb25zdCBmbiBuZXcoaWRzOiBbKFQsIFUpOyBOXSkgLT4gU2VsZiB7DQorICAgIGNv
bnN0IGZuIGluaXRfaWRzKGlkczogWyhULCBVKTsgTl0pIC0+IChbTWF5YmVVbmluaXQ8VDo6UmF3
VHlwZT47IE5dLCBbTWF5YmVVbmluaXQ8VT47IE5dKSB7DQogICAgICAgICBsZXQgbXV0IHJhd19p
ZHMgPSBbY29uc3QgeyBNYXliZVVuaW5pdDo6PFQ6OlJhd1R5cGU+Ojp1bmluaXQoKSB9OyBOXTsN
CiAgICAgICAgIGxldCBtdXQgaW5mb3MgPSBbY29uc3QgeyBNYXliZVVuaW5pdDo6dW5pbml0KCkg
fTsgTl07DQogDQpAQCAtNzcsMjQgKzc2LDE4IEBAIGltcGw8VDogUmF3RGV2aWNlSWQsIFUsIGNv
bnN0IE46IHVzaXplPiBJZEFycmF5PFQsIFUsIE4+IHsNCiAgICAgICAgICAgICAvLyBTQUZFVFk6
IGJ5IHRoZSBzYWZldHkgcmVxdWlyZW1lbnQgb2YgYFJhd0RldmljZUlkYCwgd2UncmUgZ3VhcmFu
dGVlZCB0aGF0IGBUYCBpcw0KICAgICAgICAgICAgIC8vIGxheW91dC13aXNlIGNvbXBhdGlibGUg
d2l0aCBgUmF3VHlwZWAuDQogICAgICAgICAgICAgcmF3X2lkc1tpXSA9IHVuc2FmZSB7IGNvcmU6
Om1lbTo6dHJhbnNtdXRlX2NvcHkoJmlkc1tpXS4wKSB9Ow0KLSAgICAgICAgICAgIC8vIFNBRkVU
WTogYnkgdGhlIHNhZmV0eSByZXF1aXJlbWVudCBvZiBgUmF3RGV2aWNlSWRgLCB0aGlzIHdvdWxk
IGJlIGVmZmVjdGl2ZWx5DQotICAgICAgICAgICAgLy8gYHJhd19pZHNbaV0uZHJpdmVyX2RhdGEg
PSBpO2AuDQotICAgICAgICAgICAgdW5zYWZlIHsNCi0gICAgICAgICAgICAgICAgcmF3X2lkc1tp
XQ0KLSAgICAgICAgICAgICAgICAgICAgLmFzX211dF9wdHIoKQ0KLSAgICAgICAgICAgICAgICAg
ICAgLmJ5dGVfYWRkKFQ6OkRSSVZFUl9EQVRBX09GRlNFVCkNCi0gICAgICAgICAgICAgICAgICAg
IC5jYXN0Ojo8dXNpemU+KCkNCi0gICAgICAgICAgICAgICAgICAgIC53cml0ZShpKTsNCi0gICAg
ICAgICAgICB9DQogDQogICAgICAgICAgICAgLy8gU0FGRVRZOiB0aGlzIGlzIGVmZmVjdGl2ZWx5
IGEgbW92ZTogYGluZm9zW2ldID0gaWRzW2ldLjFgLiBXZSBtYWtlIGEgY29weSBoZXJlIGJ1dA0K
ICAgICAgICAgICAgIC8vIGxhdGVyIGZvcmdldCBgaWRzYC4NCiAgICAgICAgICAgICBpbmZvc1tp
XSA9IE1heWJlVW5pbml0OjpuZXcodW5zYWZlIHsgY29yZTo6cHRyOjpyZWFkKCZpZHNbaV0uMSkg
fSk7DQogICAgICAgICAgICAgaSArPSAxOw0KICAgICAgICAgfQ0KLQ0KICAgICAgICAgY29yZTo6
bWVtOjpmb3JnZXQoaWRzKTsNCiANCisgICAgICAgIChyYXdfaWRzLCBpbmZvcykNCisgICAgfQ0K
Kw0KKyAgICBjb25zdCBmbiBidWlsZF9pZHMocmF3X2lkczogW01heWJlVW5pbml0PFQ6OlJhd1R5
cGU+OyBOXSwgaW5mb3M6IFtNYXliZVVuaW5pdDxVPjsgTl0pIC0+IFNlbGYgew0KICAgICAgICAg
U2VsZiB7DQogICAgICAgICAgICAgcmF3X2lkczogUmF3SWRBcnJheSB7DQogICAgICAgICAgICAg
ICAgIC8vIFNBRkVUWTogdGhpcyBpcyBlZmZlY3RpdmVseSBgYXJyYXlfYXNzdW1lX2luaXRgLCB3
aGljaCBpcyB1bnN0YWJsZSwgc28gd2UgdXNlDQpAQCAtMTA5LDEyICsxMDIsNDcgQEAgaW1wbDxU
OiBSYXdEZXZpY2VJZCwgVSwgY29uc3QgTjogdXNpemU+IElkQXJyYXk8VCwgVSwgTj4gew0KICAg
ICAgICAgfQ0KICAgICB9DQogDQorICAgIC8vLyBDcmVhdGVzIGEgbmV3IGluc3RhbmNlIG9mIHRo
ZSBhcnJheS4NCisgICAgLy8vDQorICAgIC8vLyBUaGUgY29udGVudHMgYXJlIGRlcml2ZWQgZnJv
bSB0aGUgZ2l2ZW4gaWRlbnRpZmllcnMgYW5kIGNvbnRleHQgaW5mb3JtYXRpb24uDQorICAgIC8v
IG9uY2UgdGhlIHNwZWNpYWxpemF0aW9uIGZlYXR1cmUgYmVjb21lcyBzdGFibGUsIHdlIGNhbiB1
c2UgYG5ldygpYCBuYW1lLg0KKyAgICBwdWIgY29uc3QgZm4gbmV3X3dpdGhvdXRfaW5kZXgoaWRz
OiBbKFQsIFUpOyBOXSkgLT4gU2VsZiB7DQorICAgICAgICBsZXQgKHJhd19pZHMsIGluZm9zKSA9
IFNlbGY6OmluaXRfaWRzKGlkcyk7DQorDQorICAgICAgICBTZWxmOjpidWlsZF9pZHMocmF3X2lk
cywgaW5mb3MpDQorICAgIH0NCisNCiAgICAgLy8vIFJlZmVyZW5jZSB0byB0aGUgY29udGFpbmVk
IFtgUmF3SWRBcnJheWBdLg0KICAgICBwdWIgY29uc3QgZm4gcmF3X2lkcygmc2VsZikgLT4gJlJh
d0lkQXJyYXk8VCwgTj4gew0KICAgICAgICAgJnNlbGYucmF3X2lkcw0KICAgICB9DQogfQ0KIA0K
K2ltcGw8VDogUmF3RGV2aWNlSWQgKyBSYXdEZXZpY2VJZEluZGV4LCBVLCBjb25zdCBOOiB1c2l6
ZT4gSWRBcnJheTxULCBVLCBOPiB7DQorICAgIC8vLyBDcmVhdGVzIGEgbmV3IGluc3RhbmNlIG9m
IHRoZSBhcnJheS4NCisgICAgLy8vDQorICAgIC8vLyBUaGUgY29udGVudHMgYXJlIGRlcml2ZWQg
ZnJvbSB0aGUgZ2l2ZW4gaWRlbnRpZmllcnMgYW5kIGNvbnRleHQgaW5mb3JtYXRpb24uDQorICAg
IHB1YiBjb25zdCBmbiBuZXcoaWRzOiBbKFQsIFUpOyBOXSkgLT4gU2VsZiB7DQorICAgICAgICBs
ZXQgKG11dCByYXdfaWRzLCBpbmZvcykgPSBTZWxmOjppbml0X2lkcyhpZHMpOw0KKw0KKyAgICAg
ICAgbGV0IG11dCBpID0gMHVzaXplOw0KKyAgICAgICAgd2hpbGUgaSA8IE4gew0KKyAgICAgICAg
ICAgIC8vIFNBRkVUWTogYnkgdGhlIHNhZmV0eSByZXF1aXJlbWVudCBvZiBgUmF3RGV2aWNlSWRg
LCB0aGlzIHdvdWxkIGJlIGVmZmVjdGl2ZWx5DQorICAgICAgICAgICAgLy8gYHJhd19pZHNbaV0u
ZHJpdmVyX2RhdGEgPSBpO2AuDQorICAgICAgICAgICAgdW5zYWZlIHsNCisgICAgICAgICAgICAg
ICAgcmF3X2lkc1tpXQ0KKyAgICAgICAgICAgICAgICAgICAgLmFzX211dF9wdHIoKQ0KKyAgICAg
ICAgICAgICAgICAgICAgLmJ5dGVfYWRkKFQ6OkRSSVZFUl9EQVRBX09GRlNFVCkNCisgICAgICAg
ICAgICAgICAgICAgIC5jYXN0Ojo8dXNpemU+KCkNCisgICAgICAgICAgICAgICAgICAgIC53cml0
ZShpKTsNCisgICAgICAgICAgICB9DQorICAgICAgICAgICAgaSArPSAxOw0KKyAgICAgICAgfQ0K
Kw0KKyAgICAgICAgU2VsZjo6YnVpbGRfaWRzKHJhd19pZHMsIGluZm9zKQ0KKyAgICB9DQorfQ0K
Kw0KIC8vLyBBIGRldmljZSBpZCB0YWJsZS4NCiAvLy8NCiAvLy8gVGhpcyB0cmFpdCBpcyBvbmx5
IGltcGxlbWVudGVkIGJ5IGBJZEFycmF5YC4NCmRpZmYgLS1naXQgYS9ydXN0L2tlcm5lbC9wY2ku
cnMgYi9ydXN0L2tlcm5lbC9wY2kucnMNCmluZGV4IGY2YjE5NzY0YWQxNy4uMjVlZDdlNWM1NmZh
IDEwMDY0NA0KLS0tIGEvcnVzdC9rZXJuZWwvcGNpLnJzDQorKysgYi9ydXN0L2tlcm5lbC9wY2ku
cnMNCkBAIC04LDYgKzgsNyBAQA0KICAgICBhbGxvYzo6ZmxhZ3M6OiosDQogICAgIGJpbmRpbmdz
LCBjb250YWluZXJfb2YsIGRldmljZSwNCiAgICAgZGV2aWNlX2lkOjpSYXdEZXZpY2VJZCwNCisg
ICAgZGV2aWNlX2lkOjpSYXdEZXZpY2VJZEluZGV4LA0KICAgICBkZXZyZXM6OkRldnJlcywNCiAg
ICAgZHJpdmVyLA0KICAgICBlcnJvcjo6e3RvX3Jlc3VsdCwgUmVzdWx0fSwNCkBAIC0xNjcsNyAr
MTY4LDkgQEAgcHViIGNvbnN0IGZuIGZyb21fY2xhc3MoY2xhc3M6IHUzMiwgY2xhc3NfbWFzazog
dTMyKSAtPiBTZWxmIHsNCiAvLyAqIGBEUklWRVJfREFUQV9PRkZTRVRgIGlzIHRoZSBvZmZzZXQg
dG8gdGhlIGBkcml2ZXJfZGF0YWAgZmllbGQuDQogdW5zYWZlIGltcGwgUmF3RGV2aWNlSWQgZm9y
IERldmljZUlkIHsNCiAgICAgdHlwZSBSYXdUeXBlID0gYmluZGluZ3M6OnBjaV9kZXZpY2VfaWQ7
DQorfQ0KIA0KK3Vuc2FmZSBpbXBsIFJhd0RldmljZUlkSW5kZXggZm9yIERldmljZUlkIHsNCiAg
ICAgY29uc3QgRFJJVkVSX0RBVEFfT0ZGU0VUOiB1c2l6ZSA9IGNvcmU6Om1lbTo6b2Zmc2V0X29m
IShiaW5kaW5nczo6cGNpX2RldmljZV9pZCwgZHJpdmVyX2RhdGEpOw0KIA0KICAgICBmbiBpbmRl
eCgmc2VsZikgLT4gdXNpemUgew0K

