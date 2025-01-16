Return-Path: <linux-pci+bounces-19987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2309DA13F7B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635013A9BB5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDCB22CBDD;
	Thu, 16 Jan 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSe9FbSF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5D1E766F;
	Thu, 16 Jan 2025 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044869; cv=none; b=EjUdv68u+XhwBEcpryaSPz5BaiGsPnpdYGwgV7bv5t3/PpKKWHrjbG5kScyCxwNEDvjMQ2cXm6Gzajuq5DCMdEJvrc8X5Om3Aivcp5tfpbfJxj3RTgtS5HxwXKxXrOUp5MAigfc17Y/dKZu8qPtqrp3MxjA+lr1aHsH4eNqC8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044869; c=relaxed/simple;
	bh=gX4szOhZkGZt5BWTPAKZMHjpXxcm9Hy6lY0teioqQx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMw5Dl8pcuTFhqBOi/oKpi7oAECFZlz8c3UO4vMYZ0Rr5k65v01ka3pc5TFG8StymcFCneO7kXdSNhReQqpNPwj7TyrEtGWXYDHZkW5/UdhBUNd05TM6yap0Lt4ORWSZHBjWKh+iJRjWtUkOdrKJP2vf9BTDBILToDoNF8W2TRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSe9FbSF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43623f0c574so7619605e9.2;
        Thu, 16 Jan 2025 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044866; x=1737649666; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gX4szOhZkGZt5BWTPAKZMHjpXxcm9Hy6lY0teioqQx4=;
        b=iSe9FbSFcAdh8BubiOD8Gs5HKnTPO6TJpWW+JoKmlr9fEPqFr/XXiRZjZAZEQbEq/d
         Q+xUrhQFLF+jP4dDMe5tZoXcRsSU7OQGUvKA8qMwgSrLmvCPc6ppUQN1IV/ip1hmHW6o
         pj59w4hNWlqkC5KG/ABifgvFAd8OGMws+e2CYKzUcop74o7BYvOLEcw3Yb9nBRYd+8Lc
         u4qKR++8cezo7TKnX7/fMPImZZsRxAmynlRBHJSteQKz9C/PvER2txw74b5UPABIvacE
         1ZbRi6Bwgrv/8w10Hb4hiKA/OZotI1HZpYfBL6VhPGo3deEmozq07o50n0J4a6xwAsRb
         I98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044866; x=1737649666;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gX4szOhZkGZt5BWTPAKZMHjpXxcm9Hy6lY0teioqQx4=;
        b=cvSbpW42zvVGDNuDGcOpcCyE1vncrBRBM2EyHJi0wlfUm4x7BJLVziHkrlgogi2KSq
         ibwBDyxg/E8hV2A5fXAvcs1vfKVJg2UujEI4+bZ3NQgRyzLYyXyGQ/5FdaC+WTFiWDlD
         t9DgPT3MrnEJ4y7mc65Hp3hbhHJiFS1Lz+wheUMvFw0DDUxIRCvXwkFEo46goLNjGoQB
         Lt+b4FxDMRguRWEZ0h50g+m4/xg1S69YsntqomjrvhMHoiwh7Npup0m347+9Z3no386S
         G/HYVPqz5h6xpmqrUWI1un+sUMghkRdR+WRoKLiyqMqj/KmTWxbqZQDb4aoMRrjibnL9
         HcVA==
X-Forwarded-Encrypted: i=1; AJvYcCVyDbZrb6VpF3L3RxYbKw25+yuvKiaHfr4Qkq77xZJdtTZJl/ltM7o5y4e8zqT3DBDZ9USDeacD/uWiZqo=@vger.kernel.org, AJvYcCWTVMYyX4POZCQuHBmnrQ02fw7m/hmROYNjUcRn2z9Owi5O+nWhwjO+7lDBvpGzE0/5BmDYHx1+te3Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUFPNMjNx42exO2rkHF15B9MZqOXsQqwWz2KuSXa6ZcnVPrzy
	22SoGOy3UJBJ2urJq9plmpyQwcYxui+eNkIupodj1Uld5tn/cHoX
X-Gm-Gg: ASbGncswRQUvUkjjAmmM9Fk49U1w6FlTJEE+k0n+AlY5sqUFe5cCj8N3Aj45YpJ7Jwf
	qnDQSCSN4Y7eyDpIMTrAqd4kwbyKfIaiqlQ98BUxQpXNIaziw5WUnxh6jqgr4QyeWN2SpOp/Imp
	ph+5eBEURKcgjMLGz9NEe6zdrbSsCSwLmccJ0e7v33Vu8tT81wlXWfZtEwsYAoBJ5hfU75+mXqz
	r69QqbXXXNKF842b4Tsxd5pyh+Jy7hdnszoAhQOP7lqtRPBC0Sf4P8/pcIw8u039Q==
X-Google-Smtp-Source: AGHT+IHqbKTw8sq0PFP3Rd+LBMHwgo9goLFcJ5y96u4aNEZFD5V+EYD9caSNKgzzoPvIriKhhfSzGQ==
X-Received: by 2002:a05:600c:1c8b:b0:434:f5c0:32b1 with SMTP id 5b1f17b1804b1-436e26a7578mr327987315e9.15.1737044866266;
        Thu, 16 Jan 2025 08:27:46 -0800 (PST)
Received: from [192.168.1.248] ([194.120.133.72])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c0f03984sm66145705e9.0.2025.01.16.08.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 08:27:45 -0800 (PST)
Message-ID: <17192051-ddd4-4cc8-a3a1-d8b2ac6a0b71@gmail.com>
Date: Thu, 16 Jan 2025 16:27:41 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI: Add TLP Prefix reading to pcie_read_tlp_log()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a2f75da3-7065-4592-aa64-5e3590ce5f91@gmail.com>
 <de2a07a1-ea99-20d7-69c5-8fdf2f432750@linux.intel.com>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <de2a07a1-ea99-20d7-69c5-8fdf2f432750@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SXsGUiaKDBfMyG30eB0GToJm"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------SXsGUiaKDBfMyG30eB0GToJm
Content-Type: multipart/mixed; boundary="------------MOF8mpKYMMPlxZHP6ewn0ImD";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <17192051-ddd4-4cc8-a3a1-d8b2ac6a0b71@gmail.com>
Subject: Re: PCI: Add TLP Prefix reading to pcie_read_tlp_log()
References: <a2f75da3-7065-4592-aa64-5e3590ce5f91@gmail.com>
 <de2a07a1-ea99-20d7-69c5-8fdf2f432750@linux.intel.com>
In-Reply-To: <de2a07a1-ea99-20d7-69c5-8fdf2f432750@linux.intel.com>

--------------MOF8mpKYMMPlxZHP6ewn0ImD
Content-Type: multipart/mixed; boundary="------------n0iDhQ3R3Ml0WZLjtoFP02DM"

--------------n0iDhQ3R3Ml0WZLjtoFP02DM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYvMDEvMjAyNSAxNjoxOCwgSWxwbyBKw6RydmluZW4gd3JvdGU6DQo+IE9uIFRodSwg
MTYgSmFuIDIwMjUsIENvbGluIEtpbmcgKGdtYWlsKSB3cm90ZToNCj4gDQo+PiBIaSwNCj4+
DQo+PiBTdGF0aWMgYW5hbHlzaXMgc2hvd3MgdGhlcmUgaXMgYSBwb3RlbnRpYWwgaXNzdWUg
aW4gdGhlIGZvbGxvd2luZyBjb21taXQ6DQo+Pg0KPj4gY29tbWl0IDAwMDQ4YzJkNWYxMTNi
YjRlODJhMGEzMGRmYzRlZTEyNTkwYjgxZjUNCj4+IEF1dGhvcjogSWxwbyBKw6RydmluZW4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPj4gRGF0ZTogICBUdWUgSmFuIDE0
IDE5OjA4OjM5IDIwMjUgKzAyMDANCj4+DQo+PiAgICAgIFBDSTogQWRkIFRMUCBQcmVmaXgg
cmVhZGluZyB0byBwY2llX3JlYWRfdGxwX2xvZygpDQo+Pg0KPj4NCj4+IFRoZSBpc3N1ZSBp
cyBkZXNjcmliZWQgYXMgZm9sbG93czoNCj4+DQo+PiB1bnNpZ25lZCBpbnQgYWVyX3RscF9s
b2dfbGVuKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUzMiBhZXJjYykNCj4+IHsNCj4+ICAgICAg
ICAgIHJldHVybiBQQ0lFX1NURF9OVU1fVExQX0hFQURFUkxPRyArDQo+PiAgICAgICAgICAg
ICAgICAgKGFlcmNjICYgUENJX0VSUl9DQVBfUFJFRklYX0xPR19QUkVTRU5UKSA/DQo+PiAg
ICAgICAgICAgICAgICAgZGV2LT5lZXRscF9wcmVmaXhfbWF4IDogMDsNCj4+IH0NCj4+DQo+
Pg0KPj4gc3RhdGljIGFuYWx5c2lzIGlzIHdhcm5pbmcgdGhhdCB0aGUgbGVmdCBoYW5kIHNp
emUgb2YgdGhlID8gb3BlcmF0b3IgaXMgYWx3YXlzDQo+PiB0cnVlIGFuZCBzbyBkZXYtPmVl
dGxwX3ByZWZpeF9tYXggaXMgYWx3YXlzIGJlaW5nIHJldHVybmVkIGFuZCB0aGUgMCBpcyBu
ZXZlcg0KPj4gcmV0dXJuZWQgKGRlYWQgY29kZSkuDQo+Pg0KPj4gSSBzdXNwZWN0IHRoZSBl
eHBlY3RlZCBiZWhhdmlvdXIgaXMgYXMgZm9sbG93czoNCj4+DQo+PiAgICAgICAgICByZXR1
cm4gUENJRV9TVERfTlVNX1RMUF9IRUFERVJMT0cgKw0KPj4gICAgICAgICAgICAgICAgICgo
YWVyY2MgJiBQQ0lfRVJSX0NBUF9QUkVGSVhfTE9HX1BSRVNFTlQpID8NCj4+ICAgICAgICAg
ICAgICAgICBkZXYtPmVldGxwX3ByZWZpeF9tYXggOiAwKTsNCj4+DQo+PiAuLkknbSByZWx1
Y3RhbnQgdG8gc2VuZCBhIGZpeCBpbiBjYXNlIHRoaXMgaXMgbm90IHRoZSBvcmlnaW5hbCBp
bnRlbnRpb24uDQo+IA0KPiBZb3VyIGZpeCBsb29rcyBjb3JyZWN0LCBpdCBzaG91bGQgaGF2
ZSB0aGUgcGFyZW50aGVzaXMgZHVlIHRvIG9wZXJhdG9yDQo+IHByZWNlZGVuY2UgcnVsZXMu
IFRoZSBpbnRlbnRpb24gaXMgdG8gY2FsY3VsYXRlIDQgRFdzICsgb3B0aW9uYWxseSBuIEUt
RQ0KPiBUTFAgcHJlZml4ZXMuDQo+IA0KDQpPSywgSSdsbCBzZW5kIGEgcGF0Y2ggbGF0ZXIg
dG9kYXkuDQoNCkNvbGluDQo=
--------------n0iDhQ3R3Ml0WZLjtoFP02DM
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------n0iDhQ3R3Ml0WZLjtoFP02DM--

--------------MOF8mpKYMMPlxZHP6ewn0ImD--

--------------SXsGUiaKDBfMyG30eB0GToJm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmeJM34FAwAAAAAACgkQaMKH38aoAib/
JA//YlOXxZN36D1b5Z9/ZLBdTfDZbc41+MqBbXIwUdfHUL6y3LE3nHnRALLFKUXa1LpqA4jsD7xd
PSiCAv4camu/1vtpCHvfJJcNfzhkxXufhj6DMUBSqsTrIJAPnUQrJy0geAIo/wxTYj/Tt2YyX0ci
G8xLOrPcgf4jO5r3fc1lFaogcQ9YPlqeWyKWJS6g6v3/aDyt1lnVfRMotcR59n3OHQGt44T9gf/P
e7koaoZdqIP8tGso87v+hyCeC2ghBjaJhWP59LohP50Cm2qw+ZZQwqdBTcAr9vqRsr6muQgankuv
JDGUlsAapS0yi4OTUspAkXotVCnp+Xzgx6ruATYjZdwtBCWsW3f2K5V/JOxGvs7VpWUUnLP1A2IX
E7/5hMRmc24DWWj/YAKQPt2UC9i+au5lVWiQcwc2stsDbZJF9euelWqHSfdwJdVbaGHATavU5MiT
uf12qGCgtWGaMDpZbvzqDgEUjGSyiryyR0xeFwkoFpob3iXB8LWYuZdkVMVoPHbnQ8QFCVg49koN
NjzZeHYIGRAuiE5soCuaglY0maxfrfica6O1SfqdVCvswVSw2W73/aP3uCR5QN+w2mLMmoe68SDl
Mfn3D9iXVscoFPFFx1FJJdva6HBToTTmQGA/SyY189Ne9OYDYpneMgIlFIxezPPzF/VYDCQ9URY8
V3w=
=iYB3
-----END PGP SIGNATURE-----

--------------SXsGUiaKDBfMyG30eB0GToJm--

