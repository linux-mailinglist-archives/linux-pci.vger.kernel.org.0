Return-Path: <linux-pci+bounces-32382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDBFB08BEC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 13:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90351AA5F67
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84FC28C013;
	Thu, 17 Jul 2025 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV17Kfxl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCEC2882BD;
	Thu, 17 Jul 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752919; cv=none; b=iStOKcSU8Wu7TNZyTlYE4DZ2/P1w9GcitVYamN3ohxmkXhlvOEPBAGFNiq1WMHUbTh/osC1Q4EbqYKUbJNwRvtYDPqYMObwvJS5iZlOtxP0Fq/WJrc3zp1tKfDL6vrIHlDnxM/3esWIYFtre3hfcJb3Lg67qn7yd9UvgK4qdVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752919; c=relaxed/simple;
	bh=WZ+J9R8TGMa/CMfNpwjphgOyW3Fhm5qGw27wYXk/fL8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=aWU0d98zUQRE4CfOop3SVohof2VBJuLAskaGhmyFnproHiDpy5IH/GpU0LvJ0EYN03r+MKBeis+5Fp0B7pOz5dVyAjFbagjvkbNLNEiRcW6DJppO3Fkk2dzSPctdFhIm2vWjovwvRi9czxVjREDk39o3rF6d+NoUQzbQ5VsQIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SV17Kfxl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so823178f8f.0;
        Thu, 17 Jul 2025 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752752914; x=1753357714; darn=vger.kernel.org;
        h=cc:subject:autocrypt:from:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZ+J9R8TGMa/CMfNpwjphgOyW3Fhm5qGw27wYXk/fL8=;
        b=SV17KfxlzrAq/y3ZANmv+OHYAuNJQWYbn2GgE/igvO2lnNhcxw49EgQ7voSDjGS8eI
         6/RM9ecMHyijT0a2ZEeohY6THE+HYpF0QAvYbAZIBCs3QBbzQqSWaC/4ML+xJ7KQvcX5
         CWX+qU7rIwHrw33P9kJHviOV0w5tbof8AphrkaX8RpCd+D/9hq1oQDFwjNVREG28QafE
         BHFbWQpuOHXpFkXCUuChzzcD+wCzE/pcap+t6CJxHjHJqEz1gP3OJUpKIi9B1+pCAsP8
         qPAYEKDJh/GRN51uigZkiFog59XJj6pKyWs6WqR7Q3SgD7IbzbafAuKDoqmsO5ASXo0+
         5WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752752914; x=1753357714;
        h=cc:subject:autocrypt:from:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WZ+J9R8TGMa/CMfNpwjphgOyW3Fhm5qGw27wYXk/fL8=;
        b=uhlGRu4y+7qmXZHzARgIpFpmoMUL56CDMI3tvGT7CMaPQXBV08OAJ0FdR3PaQ4V5MQ
         xk7HtrE/pfZ1HirPf8HodISYolxvimlcZ2MU3nL8l3S1eBlA7JlLkQxWFrBmWGf+lg/+
         rDVmZcBGolO6QK5yL3//ZHgbmBcSgO9vTEuYONJJW9LZlpQCSr1h7ri+ialoqaUDJRGk
         yNzkAG2CfCzXmipm5RhLFxLVsysPG1Ct4ZaK5glUYsBAGPE1kFtVEmw3R3FOfxBNkCZP
         wCLPGXsutw5prFbliI7d6oo8vHqiXwuhL/s6bRI7lHWhbtm0wmDxFBXZA7XIZaggA6tr
         zHvA==
X-Forwarded-Encrypted: i=1; AJvYcCUO/BFkPqAS9hJsz59OqsNbIOSZpaRv3Aa3rcXQV4aEET7QsuDfGMOR4q6K05pn6kKTqDwehuQXW+x56dI=@vger.kernel.org, AJvYcCVYlL0vLZTEsSd+Zvpv3qGAb+aoecv0MpkBN/Zbbf1WqCdX7BaNZmAlzvJbQ0nSQ68QEZKJz3ENltaD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5nbGUaa7e4s/Le2DTLM3VSXJEuohUswO2pO4jWE/lOIr6ID0
	23/TVI3HLAg5p2p+tNZI7H7zEDe9mmor6Ofxw8RceXIE7N5+2OtO2H4j
X-Gm-Gg: ASbGncuCo9g3H1yCfURwyWePzrMUhijFjYGae+x+1atZ6tx8+9oto1PiJey4ySSFA/6
	dsu1xcHtY7YqbIPWUZ5Hy+Ze0De8XE6KFGgZZkaQwrsMLhJwRYhmdFuobRIppJJBgsW9XDkJnoT
	yvrGb+J0PAQULS2zae1BVCkjdzZOjbeMiz+eky7oKCpL9Z3/+Plv7dgIt49SJk1gY3o/jJP5p/D
	cqSvT3I/jF0SYh4cx48Xun1FyJ5+ceuVq4YoMxTInid/xFrTwC0Uh78+fX0l8d4dWhJhGaSAzou
	x/IAoK0ED5RC2tqknQ1Jb1XNP1n3vR2HzD4fZf8BKnlvHy5iLNa+aD63UbvLDdeOH0jvg9/yZRD
	2s1jCImzuFTiBbGkcbfi1aNJyrF/tHAeCeST0Oag=
X-Google-Smtp-Source: AGHT+IH5Ltn91ZNFoeuAtt2VnBZlMKZl9vmhF2q/ravSawYnRTvWz0Hth4nX/1FJ2Uz5MZH5w7aiiQ==
X-Received: by 2002:a05:6000:2b01:b0:3b1:9259:3ead with SMTP id ffacd0b85a97d-3b60dd7332dmr3791096f8f.28.1752752914003;
        Thu, 17 Jul 2025 04:48:34 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d76fsm20875141f8f.64.2025.07.17.04.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:48:33 -0700 (PDT)
Message-ID: <013ea925-accc-4927-aca5-7fad4043377b@gmail.com>
Date: Thu, 17 Jul 2025 12:48:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
Subject: PCI: vmd: repeated kfree of vmdirq
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------d0720FeeJEDn7gU6TvKp0xTh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------d0720FeeJEDn7gU6TvKp0xTh
Content-Type: multipart/mixed; boundary="------------t07Bx1qFsjmj29HXQDKjUidE";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Nam Cao <namcao@linutronix.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <013ea925-accc-4927-aca5-7fad4043377b@gmail.com>
Subject: PCI: vmd: repeated kfree of vmdirq

--------------t07Bx1qFsjmj29HXQDKjUidE
Content-Type: multipart/mixed; boundary="------------FznG08C3HWgLKuMflbuQk35X"

--------------FznG08C3HWgLKuMflbuQk35X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNClN0YXRpYyBhbmFseXNpcyBmb3VuZCBhbiBpc3N1ZSBpbiB0aGUgZm9sbG93aW5n
IGNvbW1pdCBpbiBsaW51eC1uZXh0Og0KDQpjb21taXQgMmI5NmJlZmZhNDI3NjA1MTM1Njc5
MTlhYTI3ZWI3MjAzNWYyZGI1OA0KQXV0aG9yOiBOYW0gQ2FvIDxuYW1jYW9AbGludXRyb25p
eC5kZT4NCkRhdGU6ICAgVGh1IEp1biAyNiAxNjo0ODowNiAyMDI1ICswMjAwDQoNCiAgICAg
UENJOiB2bWQ6IFN3aXRjaCB0byBtc2lfY3JlYXRlX3BhcmVudF9pcnFfZG9tYWluKCkNCg0K
DQpUaGUgaXNzdWUgaXMgYXMgZm9sbG93czoNCg0Kc3RhdGljIHZvaWQgdm1kX21zaV9mcmVl
KHN0cnVjdCBpcnFfZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGludCB2aXJxLCANCnVuc2ln
bmVkIGludCBucl9pcnFzKQ0Kew0KICAgICAgICAgc3RydWN0IHZtZF9pcnEgKnZtZGlycSA9
IGlycV9nZXRfY2hpcF9kYXRhKHZpcnEpOw0KDQogICAgICAgICBmb3IgKGludCBpID0gMDsg
aSA8IG5yX2lycXM7ICsraSkgew0KICAgICAgICAgICAgICAgICBzeW5jaHJvbml6ZV9zcmN1
KCZ2bWRpcnEtPmlycS0+c3JjdSk7DQoNCiAgICAgICAgICAgICAgICAgLyogWFhYOiBQb3Rl
bnRpYWwgb3B0aW1pemF0aW9uIHRvIHJlYmFsYW5jZSAqLw0KICAgICAgICAgICAgICAgICBz
Y29wZWRfZ3VhcmQocmF3X3NwaW5sb2NrX2lycSwgJmxpc3RfbG9jaykNCiAgICAgICAgICAg
ICAgICAgICAgICAgICB2bWRpcnEtPmlycS0+Y291bnQtLTsNCg0KICAgICAgICAgICAgICAg
ICBrZnJlZSh2bWRpcnEpOw0KICAgICAgICAgfQ0KfQ0KDQpUaGUgZm9yLWxvb3AgaXMgcmVw
ZWF0ZWRseSBrZnJlZSdpbmcgdm1kaXJxIHdoaWNoIHNlZW1zIGluY29ycmVjdC4NCg0KQ29s
aW4NCg==
--------------FznG08C3HWgLKuMflbuQk35X
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

--------------FznG08C3HWgLKuMflbuQk35X--

--------------t07Bx1qFsjmj29HXQDKjUidE--

--------------d0720FeeJEDn7gU6TvKp0xTh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmh44vIFAwAAAAAACgkQaMKH38aoAiaK
OA//cT3cIfe6TQ3PieaOXIzl41MlPo1iILkONeM2coW3VYA7KolEGE7E2ilPmviayRMPnjG15jnG
MVJkJoHR65XPd6pDNJrcqCNT0DCFRYpjp6z9WJu8uNyqg5nvjQt0Dhlu0aQ4t7CQ9zoVY3vl8Z3U
LdvWW7BZrqidIkCP0nSZWXVSn/rWN59xjC6F38rP2RP+XDaBPJCEgEAfhmYlGNye8u/s/yTcL6OC
x9psQ+rnqFJdeYw9d4w8XllcGG5tBIri6eNHbXvit61xOUtpbd1CREH16cvDLLFonB1Z3D/fYNPt
KbCjsq461vFvpcFj3fT7a9m/HYNvYRjQxaZBHh3UGTWnNsIIHDhLkOt581BARCm9Vu/ttkxuYcT3
knPK73DhwKxu6UwyspZajj52FD6lP33xWEln1OHkI3y4UM1PBhs/oHsgSreqk5ROibpb5nG96Y6Q
XzhvAkTBHBCXjk8JyWTieCK8KIRdhi1qJIye5T8xDEKKSxaaNPulW9FGlZHWR+/bWN3S+12WclL4
IxpfRR1KE/kdq86qYo6VMbZShJqDO5cNaMnFQMwhvjRRblA54/eC19fenVnIP15iaBynJrboPh2r
n8srygK/FtvLkjA0aHJTZxIF9hBZc+L3xXZiqnP+hkh0zEZBVz8i7OSF2yirKjYWlIeu3qD2r+jm
sWo=
=uxXW
-----END PGP SIGNATURE-----

--------------d0720FeeJEDn7gU6TvKp0xTh--

