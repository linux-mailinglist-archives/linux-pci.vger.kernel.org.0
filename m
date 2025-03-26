Return-Path: <linux-pci+bounces-24761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95181A71641
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 13:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5963A3D25
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2071A2632;
	Wed, 26 Mar 2025 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NA/DX2Jf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CC14D2A0
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990966; cv=none; b=PrF6D6N4uIgbgUbsNycBqtZ7qgmuQB5yDXt8dXadgSSGPNN+ScJhR3UV+2O4gFl/jG7Oynd1iuJaH2ALL54NaNklCx7AulgJ2EzfGB2kCojYJFMDx0NuLw26WJJYP1tXvBOfpZxqvxwD7XrEr0Y6Dc1Rlw30dGqVggsNQenhaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990966; c=relaxed/simple;
	bh=an1KaUS0NQleZIpuItIfAMf7HfN+YJhFYzTz0NaJ9oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRS/eExCvFymMxuOHUP0Z9UQJtpVyYUuwEVYDnpEsv69zuEZ0CD9XRPEtvUTbD2puodDI/hxcLef8j3RrFMejYJHZRY0hw7W5k4tRUH1P0s1karZCfTClu0ey7UXqUGTYUd1A0H9r5xmmnzP639ZJABhff0CU2N+v1vKEHW0l1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NA/DX2Jf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso62301755e9.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 05:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742990963; x=1743595763; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=an1KaUS0NQleZIpuItIfAMf7HfN+YJhFYzTz0NaJ9oA=;
        b=NA/DX2Jf/vYkgF99ex6w2FN7Wygc6sxddVQ1zwcxGGvrwwsO1bD6nM4ENsGZO/67Fm
         5RuTT1pyMEIvjFtmsr6XXBPidhrLiFuUUbQL1Q2g8OYkcY6xRhj7gQ41UjYUHeK1SLQW
         9n0nDPgS+fx5BIs7I6ii3TCZbVy6Bp5zWE/CIJUjc/tJw3x/df/F0Nrw5ap8av8vJCnf
         FqtCAn7wxYK24vXIN/RT9jtAR+i5pnfDigsOKHRGttEQxOwEovS/jxj3KbTNchbcolo1
         cKloicsaS0khHHFZlvLkG6fGpesLHN2dJ4o3x0UwX5qEgS8EwsGZDZLua8rY2wo6fqyi
         WS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742990963; x=1743595763;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=an1KaUS0NQleZIpuItIfAMf7HfN+YJhFYzTz0NaJ9oA=;
        b=m1v8+yfmCCB/6WoqPIyHcomE+4QajMLIV8KGZnrb9meJPhXRAgf+uuTDXmhIBQsHhJ
         xyhbCvLq+/sl7CrBPtSmwTSZsOR70cnrwuwO+fB9w5RppPr1m/OWyrpyqJd/GG13aTHa
         H/GaPjnn838JXMRYo0x/87ddhuweHcNJrUlvA/CG9VHzLw0kqHNc2XZLdJahVS9utEDc
         21ei3QG8bQ1c1i6L5xW1icWt7WwUGrPQXTSBFNzaFjX9pWesmYkCHENVxEg5WatNKUmS
         VRelgIi5c8ecrozRwqFdYsbnsqNVuA9o0MuX/ZY3KD4pcCgLyqZuGvmHV/6WdQcxiT9a
         PyjA==
X-Forwarded-Encrypted: i=1; AJvYcCXuQrOksEXxZP9v8SGg5JdkzfBTCtLxI74zc8f9ttOlvau2UKKgPKj9XlmDD+c1JilimCmCg9vVxY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6udjmYVjd6t/v+oNxOIYuy1mBAiosHMRrDxyOfslvhbPiQIEx
	/TWgbPp6ioWK4QEFgvK0YVY1h3pRoyL4FZkxCfXZrGjj0lg7PsoXwDpKgoWYQOc=
X-Gm-Gg: ASbGncvGAW+dDKaeu/jNqiGJ/KYbQIzCcwy4nE0kgV1kIzdI4/10Vx9AaaG5RC1Vc9p
	XpN3tPZBEMRkC59CZCdPzqAO3bZKwCSHkyS2chNRp//ZMVFsG/0zxwIIphCn44ko4OBFTFHClYE
	dtJ+qEyPL5JRtZKVYKABb91VVFwJxXE2JYQxQxN3TsZYRLjKqFkxCI8UfMMxu/1v3WL2SC9Y0xS
	RnyrjdKC701WH5Jre3N6LiusCKOgttiEp1q5lrxNKxSRCJmmHDPbOwxPgraAikTLC4YbfsCHUEv
	XZqrNsuN+VOp4anqesJI5DuhZhpjEkOz7Yv/fFV28/ZdFGkdHz29zx4btuqjWR/2iL1GNAdjJhb
	LoAK+gSZA7PrDac/uHa98tFWBH1KEpuEyRIvA6c1ivIHDueLFbJmNcfF8ixfCNm/sIds52Q==
X-Google-Smtp-Source: AGHT+IGPSooWruGylPNfCoqdo+i7PIf/B0nuh1gk8WAeqjo3Wgsfm+TauvfWZT95goYR8rULUrwiXw==
X-Received: by 2002:a05:600c:4512:b0:43c:fcbc:968c with SMTP id 5b1f17b1804b1-43d509ed7d2mr216869185e9.7.1742990962971;
        Wed, 26 Mar 2025 05:09:22 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b? (p200300e5873d1a008e99ce06aa4a2e7b.dip0.t-ipconnect.de. [2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdec51sm233617845e9.27.2025.03.26.05.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 05:09:22 -0700 (PDT)
Message-ID: <f56cc306-3c80-45ce-9955-f7fd36defa4e@suse.com>
Date: Wed, 26 Mar 2025 13:09:21 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI
 backends
To: Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Daniel Gomez <da.gomez@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
 <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
 <Z-GbuiIYEdqVRsHj@macbook.local>
 <kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
 <Z-Gv6TG9dwKI-fvz@macbook.local> <87y0wtzg0z.ffs@tglx> <87v7rxzct0.ffs@tglx>
 <87iknwyp2o.ffs@tglx>
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
In-Reply-To: <87iknwyp2o.ffs@tglx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------G6wryYg7If1ZodK44IqIwnFh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------G6wryYg7If1ZodK44IqIwnFh
Content-Type: multipart/mixed; boundary="------------FgOLYyKFe0izuOaKvrlnginI";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Daniel Gomez <da.gomez@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <f56cc306-3c80-45ce-9955-f7fd36defa4e@suse.com>
Subject: Re: [PATCH] PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI
 backends
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
 <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
 <Z-GbuiIYEdqVRsHj@macbook.local>
 <kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
 <Z-Gv6TG9dwKI-fvz@macbook.local> <87y0wtzg0z.ffs@tglx> <87v7rxzct0.ffs@tglx>
 <87iknwyp2o.ffs@tglx>
In-Reply-To: <87iknwyp2o.ffs@tglx>

--------------FgOLYyKFe0izuOaKvrlnginI
Content-Type: multipart/mixed; boundary="------------r4gtUqOQuE5FyviO00L0sdjw"

--------------r4gtUqOQuE5FyviO00L0sdjw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDMuMjUgMTM6MDUsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gVGhlIGNvbnZl
cnNpb24gb2YgdGhlIFhFTiBzcGVjaWZpYyBnbG9iYWwgdmFyaWFibGUgcGNpX21zaV9pZ25v
cmVfbWFzayB0byBhDQo+IE1TSSBkb21haW4gZmxhZywgbWlzc2VkIHRoZSBmYWN0cyB0aGF0
Og0KPiANCj4gICAgICAxKSBMZWdhY3kgYXJjaGl0ZWN0dXJlcyBkbyBub3QgcHJvdmlkZSBh
IGludGVycnVwdCBkb21haW4NCj4gICAgICAyKSBQYXJlbnQgTVNJIGRvbWFpbnMgZG8gbm90
IG5lY2Vzc2FyaWx5IGhhdmUgYSBkb21haW4gaW5mbyBhdHRhY2hlZA0KPiAgICAgDQo+IEJv
dGggY2FzZXMgcmVzdWx0IGluIGFuIHVuY29uZGl0aW9uYWwgTlVMTCBwb2ludGVyIGRlcmVm
ZXJlbmNlLg0KPiANCj4gQ3VyZSB0aGlzIGJ5IHVzaW5nIHRoZSBleGlzdGluZyBwY2lfbXNp
X2RvbWFpbl9zdXBwb3J0cygpIGhlbHBlciwgd2hpY2gNCj4gaGFuZGxlcyBhbGwgcG9zc2li
bGUgY2FzZXMgY29ycmVjdGx5Lg0KPiANCj4gRml4ZXM6IGMzMTY0ZDJlMGQxOCAoIlBDSS9N
U0k6IENvbnZlcnQgcGNpX21zaV9pZ25vcmVfbWFzayB0byBwZXIgTVNJIGRvbWFpbiBmbGFn
IikNCj4gUmVwb3J0ZWQtYnk6IERhbmllbCBHb21leiA8ZGEuZ29tZXpAa2VybmVsLm9yZz4N
Cj4gUmVwb3J0ZWQtYnk6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gVGVz
dGVkLWJ5OiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+DQo+
IFRlc3RlZC1ieTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFRlc3RlZC1i
eTogRGFuaWVsIEdvbWV6IDxkYS5nb21lekBrZXJuZWwub3JnPg0KDQpBcyB0aGUgcGF0Y2gg
aW50cm9kdWNpbmcgdGhlIHByb2JsZW0gd2VudCBpbiB2aWEgdGhlIFhlbiB0cmVlLCBzaG91
bGQNCnRoaXMgZml4IGdvIGluIHZpYSB0aGUgWGVuIHRyZWUsIHRvbz8NCg0KDQpKdWVyZ2Vu
DQo=
--------------r4gtUqOQuE5FyviO00L0sdjw
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------r4gtUqOQuE5FyviO00L0sdjw--

--------------FgOLYyKFe0izuOaKvrlnginI--

--------------G6wryYg7If1ZodK44IqIwnFh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfj7nEFAwAAAAAACgkQsN6d1ii/Ey9g
LQf/XG0ZVGipQKdiKFm9K0qDJa+Fd/bd6y6M9Ol9Sl/JeB41FlS6eECjEjekzIAcVhGd3rlEKG1v
x8r6p2ax3HPSru1O2rsCF5D1BRzaXwvV7qe8RLgkHvaFR5jM8SofcRLqEKrIyjJMCnm4zhS35XHn
G0JFBc5redWdHWzGHbquUjFn+rvZ/FcgwAscwBQb0jXeXZQ6hVptr5o55SgveH+4XR9uGXFUq3sK
5KWQCsKeSDWMat87msSeNIT8Y7FW9RBU/puz3rdjEQnQR4umoRP730600nS7C7nYgfCnCnzMi0JR
YYUHYuwIM6VLZzqgwf9RKWG/bzPyg9/ESV573kVhnA==
=xjFw
-----END PGP SIGNATURE-----

--------------G6wryYg7If1ZodK44IqIwnFh--

