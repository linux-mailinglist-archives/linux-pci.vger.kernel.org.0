Return-Path: <linux-pci+bounces-22571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE7A482F1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344207A4DF8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 15:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670026B2D5;
	Thu, 27 Feb 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LEK0yOKI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F626B2B2
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670195; cv=none; b=JlVY8q5QHG86/jkjOr70+cbQsVg1CoCivB9zGpZgMULLTMvdouVZrfBeNLG57vFVv0a9sOU9uckPL6CiVjnXEWQEgm+sgKo78poZN+vlzY/VOgcj1UpDR22k0kNaONGeaQ8F4n8/gmpfzcZ98OGcLrRErVYn9+xQrtRb70dP0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670195; c=relaxed/simple;
	bh=Or2S1BxI2J4T6rUeUCechS9x46+OBNBRa9Xv5USJ24g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZXot7uzBPN5ZCZEhdBAzYCDzrmAECZaxk1xgTBMfPM1Hoj+cY1iX8n2PzAv75N+GrGVpS8JoMUztgiI1EPcp9vZp33DYD2Ymzrh2eK3Me7B/77+r9tI+5msMD+NxnSNSW/YAK+T62BsmTASHQSwldCFkORAA0QxjYinRP0/tjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LEK0yOKI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso612977f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 07:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740670191; x=1741274991; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Or2S1BxI2J4T6rUeUCechS9x46+OBNBRa9Xv5USJ24g=;
        b=LEK0yOKIkCwSLsXXkIFW+HjOgDZQeWesQvemmm/laikGa9AbONoTopsUdnbMSRIgD6
         +a39V0xzunxcBPbEDB2dBB86l5wmAEn5YVKIwmbECpMZ62Wa0Qqwp3FtDA58+lR5z7a5
         E/B7D8054A8luguftYCBM4Y0rMtAqN9L4qC53Axk3FRgaMEOAKlkrEcGpwX/Vc79tQhT
         TbkQrOWLqmpoQD+pw7bERWoN9Dz7jdN//HrC4BZLpOJdNt1hM+/GaCMaUmZxnzJUcNn/
         foZPco6fnbpGCB8PFxD0lng6/4V6Dd/7isnpB+t77n1TCCmRH9NvEyNDelBeup8tmFtw
         dAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740670191; x=1741274991;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Or2S1BxI2J4T6rUeUCechS9x46+OBNBRa9Xv5USJ24g=;
        b=ED9AqS5Yn8SVjzv8KSdlQfcdTDqQ9jXrGP8hEr5wK+BQygaAFfxKrshvizdEtzDdbr
         w8ScyhoIrqmKilSNI1YhRIMtxuB+h1ZCBor7CF+GEXwZXIzQ7wK3ENLW8Iv8HBjrJhNO
         pDF632ktvJpthy2hs+tdQ3WaL8cgfrjxl3VKxRCIK+4wdUEw6UVylj+knsBhIiMHwcaH
         fXWdGcjlk+g0rYWamR2tJ2IrM5yY8iMtFo+68fli08Rn2I9VC/JydCUcaj+KO2gmuw8i
         lyJVZhWRiibGd22cRa4i87T0UbLI79ETx6tBq+bnlp1KaCT/cVS/At8XcyoZa1iquKyC
         bUPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoP1QK8c8QaJiL/KCl2XQSTVCcWT7Mni4rgAml5FBUuXpnE5mDCkaiw6x6gVPXh7VKxq27xkkXB5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKQmV/8A5aHz3kjNAk9GVeGG7liP/OQFOuUjEZfg9CPGTO2AB9
	Socc6vMJqbOdyCr+++kxddLXgwVJegF8hp5kS5IYbzxaqKy0xp+1Bqf2eFrxyh4=
X-Gm-Gg: ASbGncsRHWxgYNlsx3ym9xhYEFrl6MPDpEXCBnHdcew70fAl17oLB3fV/LIDpmTM2lq
	77iaEixQ9/yARZ8o7N1Atf5KovqK2kOd/QjvFLrGGzYC1i6sPBrFyPNIMUz21Wptx787dB26F6Q
	TZB4qDz1jWb66N/WmO4ylVYuOmgDhrcmHhUKzXq7vceegr1TMU//sJnDTxSch6xy3NbLDPKNN8N
	gYa2YXZKTBx4MbuJXTsuUXmpVpCtV0QZePeUzyJC8irGjt8yIrOWsnQFUvTeglOxUclQs7l8b+V
	BxjH2Lo0IAGe9I0W8jWIbUayakR6vnoCHSjpp/yaiAKUSze9DknA/WWKdNNXWGSett6fXvIfN01
	jq2JYygS6VHdq/iEjwfjKfoio8h+HER2hfwM0XPEFAp4Wyeuj
X-Google-Smtp-Source: AGHT+IGH10U3HyZQcpCiisEuijVuw2MOgcBfgz1zzdVm0lxcjFU8PN77WNGtsIcXGRFK59YQ6Qwlog==
X-Received: by 2002:a05:6000:4026:b0:38d:e3e2:27e5 with SMTP id ffacd0b85a97d-390cc5f5cc8mr9793609f8f.5.1740670191455;
        Thu, 27 Feb 2025 07:29:51 -0800 (PST)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm61247035e9.26.2025.02.27.07.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 07:29:51 -0800 (PST)
Message-ID: <03c90be4-7546-42cf-be5d-3fd6bcf20849@suse.com>
Date: Thu, 27 Feb 2025 16:29:50 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xen: Add support for XenServer 6.1 platform device
To: Frediano Ziglio <frediano.ziglio@cloud.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250225140400.23992-1-frediano.ziglio@cloud.com>
 <20250227145016.25350-1-frediano.ziglio@cloud.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20250227145016.25350-1-frediano.ziglio@cloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yA7AouVOlM5ktrrfJTheyd6D"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yA7AouVOlM5ktrrfJTheyd6D
Content-Type: multipart/mixed; boundary="------------8ZEcR8NSrsXN84ey7Sr6gk1B";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Frediano Ziglio <frediano.ziglio@cloud.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <03c90be4-7546-42cf-be5d-3fd6bcf20849@suse.com>
Subject: Re: [PATCH v2] xen: Add support for XenServer 6.1 platform device
References: <20250225140400.23992-1-frediano.ziglio@cloud.com>
 <20250227145016.25350-1-frediano.ziglio@cloud.com>
In-Reply-To: <20250227145016.25350-1-frediano.ziglio@cloud.com>

--------------8ZEcR8NSrsXN84ey7Sr6gk1B
Content-Type: multipart/mixed; boundary="------------i3L8E5rkH9J0WAm0l6tsHHi4"

--------------i3L8E5rkH9J0WAm0l6tsHHi4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDIuMjUgMTU6NTAsIEZyZWRpYW5vIFppZ2xpbyB3cm90ZToNCj4gT24gWGVuU2Vy
dmVyIG9uIFdpbmRvd3MgbWFjaGluZSBhIHBsYXRmb3JtIGRldmljZSB3aXRoIElEIDIgaW5z
dGVhZCBvZg0KPiAxIGlzIHVzZWQuDQo+IA0KPiBUaGlzIGRldmljZSBpcyBtYWlubHkgaWRl
bnRpY2FsIHRvIGRldmljZSAxIGJ1dCBkdWUgdG8gc29tZSBXaW5kb3dzDQo+IHVwZGF0ZSBi
ZWhhdmlvdXIgaXQgd2FzIGRlY2lkZWQgdG8gdXNlIGEgZGV2aWNlIHdpdGggYSBkaWZmZXJl
bnQgSUQuDQo+IA0KPiBUaGlzIGNhdXNlcyBjb21wYXRpYmlsaXR5IGlzc3VlcyB3aXRoIExp
bnV4IHdoaWNoIGV4cGVjdHMsIGlmIFhlbg0KPiBpcyBkZXRlY3RlZCwgdG8gZmluZCBhIFhl
biBwbGF0Zm9ybSBkZXZpY2UgKDU4NTM6MDAwMSkgb3RoZXJ3aXNlIGNvZGUNCj4gd2lsbCBj
cmFzaCBkdWUgdG8gc29tZSBtaXNzaW5nIGluaXRpYWxpemF0aW9uIChzcGVjaWZpY2FsbHkg
Z3JhbnQNCj4gdGFibGVzKS4gU3BlY2lmaWNhbGx5IGZyb20gZG1lc2cNCj4gDQo+ICAgICAg
UklQOiAwMDEwOmdudHRhYl9leHBhbmQrMHgyOS8weDIxMA0KPiAgICAgIENvZGU6IDkwIDBm
IDFmIDQ0IDAwIDAwIDU1IDMxIGQyIDQ4IDg5IGU1IDQxIDU3IDQxIDU2IDQxIDU1IDQxIDg5
IGZkDQo+ICAgICAgICAgICAgNDEgNTQgNTMgNDggODMgZWMgMTAgNDggOGIgMDUgN2UgOWEg
NDkgMDIgNDQgOGIgMzUgYTcgOWEgNDkgMDINCj4gICAgICAgICAgICA8OGI+IDQ4IDA0IDhk
IDQ0IDM5IGZmIGY3IGYxIDQ1IDhkIDI0IDA2IDg5IGMzIGU4IDQzIGZlIGZmIGZmDQo+ICAg
ICAgICAgICAgNDQgMzkNCj4gICAgICBSU1A6IDAwMDA6ZmZmZmJhMzRjMDFmYmM4OCBFRkxB
R1M6IDAwMDEwMDg2DQo+ICAgICAgLi4uDQo+IA0KPiBUaGUgZGV2aWNlIDIgaXMgcHJlc2Vu
dGVkIGJ5IFhhcGkgYWRkaW5nIGRldmljZSBzcGVjaWZpY2F0aW9uIHRvDQo+IFFlbXUgY29t
bWFuZCBsaW5lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJlZGlhbm8gWmlnbGlvIDxmcmVk
aWFuby56aWdsaW9AY2xvdWQuY29tPg0KDQpBY2tlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdy
b3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg==
--------------i3L8E5rkH9J0WAm0l6tsHHi4
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------i3L8E5rkH9J0WAm0l6tsHHi4--

--------------8ZEcR8NSrsXN84ey7Sr6gk1B--

--------------yA7AouVOlM5ktrrfJTheyd6D
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfAhO4FAwAAAAAACgkQsN6d1ii/Ey9f
5wf9HV/lZMWX0xsB+MafliORx3rBgJOGFut1zjcx0JFDHLfg2rLT6VmFPvhFd4ECcqxXFQ3Yv5pQ
PQUn9KLbsRY3QUlmp/GcHVZHyhlaDlTKwud/CcEAeVQWATqD4bWDtNeUWnffrJEJDxV/hX8geYaR
cvIAP83Bl51liDw8DIzLoxvFBS6OUSN5Y2jhc5cDP5XGH40QKJxHDMDKm3XMcimjRhpsnpTCPiZA
b/ev9kOM0FLVV5quTrreH10kCRy5i4cHMRp51awwEp4BRhf215699BfqBt/ZQFg1nl4bkRlcY1eu
pzTukrc5dNF5VwsnhQ7qeEPrbwnk+gPVAlvqOv1Z3Q==
=X8qy
-----END PGP SIGNATURE-----

--------------yA7AouVOlM5ktrrfJTheyd6D--

