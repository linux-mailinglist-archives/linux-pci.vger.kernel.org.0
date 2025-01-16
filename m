Return-Path: <linux-pci+bounces-19984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D4DA13E90
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 16:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18EE3AF0DA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93CD22C9E4;
	Thu, 16 Jan 2025 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSSwi8FA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387F1D8A0D;
	Thu, 16 Jan 2025 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043035; cv=none; b=PFC435w5ICiacgVfa5o+xDZ5UVdmqFvwk6qqlr1Ac1rQJ5yWmbhbnoCbViGj1r6h96KGR/Ctr0OMKzODPI7h2/zcUr2OJt5O8Px9gWpMHXwGT1GK0GcD72LAJltWk7bWCfcosMqABPia+6Rqglyl747OimbXxU9swOb2OxNqJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043035; c=relaxed/simple;
	bh=KEtdUJT0n471IWxbiFi9Zey/aFgSZjPFN/XkDBJ0QIo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=r6/pipVnLFl2xvgZaVABnKGAUOGgf86D9a+lcwy31SuYEzbn6yzXzZVrYA+ZZyv/8STLIbp8pc+FhoEVujuKgx2dCu4fpiRHrq4Wpckol18uJz+tujVf4PKIrpAMNFF2lPn0XbOFEAyE70lImWy9p03hgjRkGZFrb38yH6Rkyws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSSwi8FA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43618283d48so7216385e9.1;
        Thu, 16 Jan 2025 07:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737043032; x=1737647832; darn=vger.kernel.org;
        h=cc:autocrypt:subject:from:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEtdUJT0n471IWxbiFi9Zey/aFgSZjPFN/XkDBJ0QIo=;
        b=RSSwi8FAouqp5x+4s5JB0wl4UtyNYmowNUxu81wASdiKDYAQ49KDgNSGQR5+b05/Yl
         Y0YrpKkrYKehEfSdBGQ95vUELKneuAY5+H4aZulnU7sPuSPQm4u5OI2EYoGyPFaYuzAs
         sU7RrAS/0rkx2pNv+PiwKqvzi5DQHxR/Xc78PvhZ40TBDF+WYrPt/qZaeFh9EzwEZYeG
         F7a2yUSr4kao2GsKJ3bXFqeCU0Nji7Ny1romcVXy2GFIK1TNPssmH2FIvZMCNRByVk+Y
         /S29kSu18X6/lNoqraQjf3PPscQfEe5CktkzDDWUkY3+LtiZRi58Sq7MWjYUqor3v/Ou
         6w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737043032; x=1737647832;
        h=cc:autocrypt:subject:from:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KEtdUJT0n471IWxbiFi9Zey/aFgSZjPFN/XkDBJ0QIo=;
        b=A0tcPUsz6SxbfVzXqSEoe3Ga87qsIZp2U6ow7ifzTkG41jdB1fdUBIqTabnWtNU4MB
         +Z6G7XpiLkU7qC5CGJ0o2h8voDUQq9/aHaDMoKFti3eVlfaEIcjmlLTbdFq6/3qD9iut
         MScPUiAsfZ4BttCSHuhmYY7EvHeM0csZdk6iA8A1C+DhTlFPR6f/kS2uW1uL2hD0wNO/
         RJEobMUtMw8a9TL+TznXfvqSjf+ez2GtMnvC68xXrby1yhv9mUmZCMfKMLxMfU8Aj54w
         Z2+qHfr8/ANVicOuyqXRYKq1XZ+TznNs8Db6FVh/TGxwZwucYivdU6YDI1unS9enIJvr
         TroQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTb/MaP++7aI8CNgqwQ8fubDJPLlUPnhX0EkVSBeJSYpFVC24mgeajXyyD1jjqI5yQOD5XgqJxEsS6HDU=@vger.kernel.org, AJvYcCXacTSreDAZZjvkVMjppfPrJa4+gzYWoEh4JuFfSNJXNnN79I2De4vq6wDRJADv5ksVHkk5ZmeirWUN@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYRrY40KsNRMxX/0Ch6JGkJ5Q0mfvlEEVmprogI4Sg9/bdCBs
	dg2wPYHQNlJ1LFzEXZ1PGcKJQ0wziXn7nXpcWS6vFhlOi/q9UhzLf7m/EZa6
X-Gm-Gg: ASbGnct7Z4pEn9Dm+8a9pqBrqrQthjnMAicszlXVKcyogzhmbV03awgFunmufg4pWft
	gIDqwqpnISc/pKOR85/ESTq6gGk7EgI/0yUBhqkoXSL/x83CS2no/uWXlcZO+2T8IPRpBYtx3H2
	WdbjqLZoYM+n6In2dJSdflLrDR7TZhIWEuYNokSYgoveyprdGPHR9qXLQFhIKq3kyqLfER7AZSZ
	S0IKb3m/+dkHqjcYbeEfGqSAV+UNpASWLIa8piosWTVLxGs6Bf5G/aivUBc7lk0/g==
X-Google-Smtp-Source: AGHT+IHVrAMGqPnfBKaUo4LXR1u49QUJTVDNNE07IYSxzUn3AXmVvL2gaYE0LQDX34yeTTQFj1ewqg==
X-Received: by 2002:a5d:64eb:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38a87312d2emr29208480f8f.32.1737043031951;
        Thu, 16 Jan 2025 07:57:11 -0800 (PST)
Received: from [192.168.1.248] ([194.120.133.72])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43890408a66sm3519925e9.5.2025.01.16.07.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 07:57:11 -0800 (PST)
Message-ID: <a2f75da3-7065-4592-aa64-5e3590ce5f91@gmail.com>
Date: Thu, 16 Jan 2025 15:57:05 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: PCI: Add TLP Prefix reading to pcie_read_tlp_log()
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0t2u56miF5iL7s0aUcQgX0jQ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0t2u56miF5iL7s0aUcQgX0jQ
Content-Type: multipart/mixed; boundary="------------ljYLobFK54GFogKS6MF4B9pr";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <a2f75da3-7065-4592-aa64-5e3590ce5f91@gmail.com>
Subject: re: PCI: Add TLP Prefix reading to pcie_read_tlp_log()

--------------ljYLobFK54GFogKS6MF4B9pr
Content-Type: multipart/mixed; boundary="------------MlBd6WvjN0L7PyJTRsvBsJLp"

--------------MlBd6WvjN0L7PyJTRsvBsJLp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNClN0YXRpYyBhbmFseXNpcyBzaG93cyB0aGVyZSBpcyBhIHBvdGVudGlhbCBpc3N1
ZSBpbiB0aGUgZm9sbG93aW5nIGNvbW1pdDoNCg0KY29tbWl0IDAwMDQ4YzJkNWYxMTNiYjRl
ODJhMGEzMGRmYzRlZTEyNTkwYjgxZjUNCkF1dGhvcjogSWxwbyBKw6RydmluZW4gPGlscG8u
amFydmluZW5AbGludXguaW50ZWwuY29tPg0KRGF0ZTogICBUdWUgSmFuIDE0IDE5OjA4OjM5
IDIwMjUgKzAyMDANCg0KICAgICBQQ0k6IEFkZCBUTFAgUHJlZml4IHJlYWRpbmcgdG8gcGNp
ZV9yZWFkX3RscF9sb2coKQ0KDQoNClRoZSBpc3N1ZSBpcyBkZXNjcmliZWQgYXMgZm9sbG93
czoNCg0KdW5zaWduZWQgaW50IGFlcl90bHBfbG9nX2xlbihzdHJ1Y3QgcGNpX2RldiAqZGV2
LCB1MzIgYWVyY2MpDQp7DQogICAgICAgICByZXR1cm4gUENJRV9TVERfTlVNX1RMUF9IRUFE
RVJMT0cgKw0KICAgICAgICAgICAgICAgIChhZXJjYyAmIFBDSV9FUlJfQ0FQX1BSRUZJWF9M
T0dfUFJFU0VOVCkgPw0KICAgICAgICAgICAgICAgIGRldi0+ZWV0bHBfcHJlZml4X21heCA6
IDA7DQp9DQoNCg0Kc3RhdGljIGFuYWx5c2lzIGlzIHdhcm5pbmcgdGhhdCB0aGUgbGVmdCBo
YW5kIHNpemUgb2YgdGhlID8gb3BlcmF0b3IgaXMgDQphbHdheXMgdHJ1ZSBhbmQgc28gZGV2
LT5lZXRscF9wcmVmaXhfbWF4IGlzIGFsd2F5cyBiZWluZyByZXR1cm5lZCBhbmQgDQp0aGUg
MCBpcyBuZXZlciByZXR1cm5lZCAoZGVhZCBjb2RlKS4NCg0KSSBzdXNwZWN0IHRoZSBleHBl
Y3RlZCBiZWhhdmlvdXIgaXMgYXMgZm9sbG93czoNCg0KICAgICAgICAgcmV0dXJuIFBDSUVf
U1REX05VTV9UTFBfSEVBREVSTE9HICsNCiAgICAgICAgICAgICAgICAoKGFlcmNjICYgUENJ
X0VSUl9DQVBfUFJFRklYX0xPR19QUkVTRU5UKSA/DQogICAgICAgICAgICAgICAgZGV2LT5l
ZXRscF9wcmVmaXhfbWF4IDogMCk7DQoNCi4uSSdtIHJlbHVjdGFudCB0byBzZW5kIGEgZml4
IGluIGNhc2UgdGhpcyBpcyBub3QgdGhlIG9yaWdpbmFsIGludGVudGlvbi4NCg0KQ29saW4N
Cg==
--------------MlBd6WvjN0L7PyJTRsvBsJLp
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

--------------MlBd6WvjN0L7PyJTRsvBsJLp--

--------------ljYLobFK54GFogKS6MF4B9pr--

--------------0t2u56miF5iL7s0aUcQgX0jQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmeJLFIFAwAAAAAACgkQaMKH38aoAiZc
og/+IhY31JnRN8L/9iFdL7LDxu9RwWCXZkxTCSV6JFBo6EkF06hk1X6FNmrBdV/gKF8oHku/qW5g
gi8grCjPv/hbCoePkzVmF7EsDYs0ZDKjscFWX3Mriau0bvf4fwhlU/JbNch9G8F4llIXHgfQc1Cq
+dhrR3MeXBRDUlEokguM2naKF2mgsgknRChqdiqEL1Rny/VPRTyygdROk2nRrOCtJ1sp0RwHqz1G
A/DNrRtM06oOnX5mx8UzFyacbea4deh5/+8tDOFsHRuvbMrK+f9hmCMRj7OsphonvN5ZM5zFjF9N
vvjWGhKxFatgOanugCWKS7/5+9mb2LGYOh0pCgPNe0jwCEwYH6cYVeeeBy4S5Ht0UCCc5WxLYmeM
SDeJUsepQQwOfJvIACcOeLuuwpmZRlCVG7wEtKSUXgSEQQkuMRgOQseI/13jJHRlm1A+R0rwaW8v
ffz13vRo37IHj1+rL7ujuBTWLb6kLicWO7e8kIgSoTGatYNyQWSC7LbKQznHLYUxe3nWySwh4Xgr
mczvTNXko22MwZLMpcYJoilC/vmTk12jMjJLEoRaryfFwJ/bFOH56j5tbhqwczBnsCnFD+c0fA3L
T1L+DnQmE3hhnWCysFMNhnSV5IMdzsI6KlBMSEH4l3NgP9kHiJhRDXF8JRpfKEU910zYh3WVdfQC
HdM=
=gBPP
-----END PGP SIGNATURE-----

--------------0t2u56miF5iL7s0aUcQgX0jQ--

