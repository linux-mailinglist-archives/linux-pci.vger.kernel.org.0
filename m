Return-Path: <linux-pci+bounces-24306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316F2A6B59B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 09:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BDF4828BE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 08:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC91EE7D8;
	Fri, 21 Mar 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J0u0L1cT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BF1E5B67
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544014; cv=none; b=bW9U3rDs70Kq59y4+DDqzv9P6ouVxKI4nR81/jkicHrPpRgicvfmJ7K0P+fPWFliskc+V9wQy7ZvV/C7IAOaXZIGnK+9rV11Sy36u9BlaNOxh8iC+Hv7vQXdXiFP3uw5iKGpOpQ3TDvpThys1AeZB8eMIpS0mb5QN2BJBPC0Dto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544014; c=relaxed/simple;
	bh=vjjhz+0BKJZc+PM8VAF41DpdlFYjkYGT1L08hZsgtuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0gnlpNpBI4+xitj2Nu1I/ismeu+72yUGKcSpMpebC0bWmkQMFqStjftL1ZMiKPqAocIVg19tzD7za/CN+Im/QNQcc/uhV5MgpYgYaMKgQsc67zj4cEpEZi5eLtDHNkI4mu4TQv/Db7c+3kjk91VC7KaJ/D3eIIbM24Ap1kiocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J0u0L1cT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso113709766b.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742544011; x=1743148811; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vjjhz+0BKJZc+PM8VAF41DpdlFYjkYGT1L08hZsgtuI=;
        b=J0u0L1cT4Lyl9vVJK58qVD5dUqMdQVvoVEa7K6ZwkqfrY8zhD7pzUvf0LOBhvpPZHm
         WxFRiPYMUeCTpA6vffUXIou2/kHajIoVqPmKjHkQa3gX7dRtQ9g2dbC9UllTEU3k77+p
         UXkKzuBuvnpVIHv0UKro6OucJ0DW/Go999mx/MuXiqWO4cKAU2LPr4Sav4hsCY07JEwZ
         8aomOjBn6Va9wa0hkBT/6m/UmzXA9GfUC+U0nx3OrqrHArpPrenFskFd/pPqfrNCdEhF
         zpHiFYD1CiliIUyIgixIbrHRArghtYCaNI462sHD+qJC2ZNzryM8OcSRgh4Y5C+1AY2D
         yvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742544011; x=1743148811;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjjhz+0BKJZc+PM8VAF41DpdlFYjkYGT1L08hZsgtuI=;
        b=j7u6SBaNUwBk4ibF+bioHCkPzxqoix61eoaah940Fo6dQvAt7Whmto63W9IaYlo37Y
         T6bvELE4yGUc0MLImAiDxnT2zpDn9EZ5tJbbK9ndiDZG0CefPeTNYqErD9ALBG8YwhkQ
         +fYkwQbWrT9C64qo3hvcqE0x7wPNjqurW4XS4WCJdknaZn2Qv76sO2jlo+UtuQSZmxoj
         DH/RjXcSdNLsQ2J5M89u/UNT691E0ROtcIrQZvfSgeLC17FfDSVHSyYk/gmKaqghbauJ
         zRMOv8jpzH2d7DYhROXsMiOdFxQ835hesU+rdgcBPmmzZfpQp6svv5aichIR1m6783KJ
         t4tg==
X-Forwarded-Encrypted: i=1; AJvYcCUrAfMHXHgJN3EU1HJVm1WJ1RYV/BpFhNm5xLo4q8ZpcdefxLEXpB/3uAEmXNjwwwOaNWQjw/shRfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytwKWBePayEKMGwo1VC6frjhtwRs/exDFoUNtV5SFiN8fSSSJN
	LjgZna7B/dsvM3CMjUAutW+C10Zd+YOEBDu4LY+vhrDek5VKKMDOsmwkLMC9YbdCL/0qNLOgutV
	eKXQ=
X-Gm-Gg: ASbGnctUJqaijvBBMV/W4U6S57vNd+IhmYo8dL52Cwcv2nPTqJVWL+EYX0aZVWAv/ZA
	JqkhCRGm+91GSoHKCD6iDLMRxBuE7jwVSYf7/byZdQrgPSLMqFNOYXGYnVh9hq6/8NEKa9eAsUD
	0u8hJyoNdcz1yn2TYK6hf7oDpaKZPh0EQ1VpjgJDJWQ3PlK+XbpoisPylvxZtnsXzX6GKJCPh+p
	icqax4NPCyGXdB7Yh/H7UG9JmExFK78WbpPdPL6zUsKUwr5lfKIOUxDWaIlEan9GpOfZrSA/E0Z
	93Nq3T4ap8LhTQHoRJT6Lit+RDkumKj/ZaPDX7WkjR/pI6fw2qxtekR1mq7wq5D3hSZG49IhfI3
	y94+5joXSygaWp+7hGVg6uoXp50k4WrmdxzcnHoRkSMjtPpIga0pj/yo248Plzs5hKrtP/A==
X-Google-Smtp-Source: AGHT+IEyhXmYb6FAeAQpssphlgI5bCA/1n9XQl25hiFt+bIE0R/awEMtlQr5iS/96IVIgN9jxBoHbg==
X-Received: by 2002:a17:907:3e8b:b0:ac3:d0e4:3a9e with SMTP id a640c23a62f3a-ac3f251f1fbmr200217166b.43.1742544010725;
        Fri, 21 Mar 2025 01:00:10 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b? (p200300e5873d1a008e99ce06aa4a2e7b.dip0.t-ipconnect.de. [2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c74b9sm873693a12.62.2025.03.21.01.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 01:00:10 -0700 (PDT)
Message-ID: <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
Date: Fri, 21 Mar 2025 09:00:09 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
To: Bjorn Helgaas <helgaas@kernel.org>, Roger Pau Monne <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20250320210741.GA1099701@bhelgaas>
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
In-Reply-To: <20250320210741.GA1099701@bhelgaas>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------W0xkH04NA68e5Z3Jr2U2a3uN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------W0xkH04NA68e5Z3Jr2U2a3uN
Content-Type: multipart/mixed; boundary="------------e8uEugkV0n8TkbLUq7aeRrvm";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Roger Pau Monne <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
References: <20250320210741.GA1099701@bhelgaas>
In-Reply-To: <20250320210741.GA1099701@bhelgaas>

--------------e8uEugkV0n8TkbLUq7aeRrvm
Content-Type: multipart/mixed; boundary="------------DcVMOhtx0fYQGrcD75hxrseI"

--------------DcVMOhtx0fYQGrcD75hxrseI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDMuMjUgMjI6MDcsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+IE9uIFdlZCwgRmVi
IDE5LCAyMDI1IGF0IDEwOjIwOjU3QU0gKzAxMDAsIFJvZ2VyIFBhdSBNb25uZSB3cm90ZToN
Cj4+IFNldHRpbmcgcGNpX21zaV9pZ25vcmVfbWFzayBpbmhpYml0cyB0aGUgdG9nZ2xpbmcg
b2YgdGhlIG1hc2sgYml0IGZvciBib3RoDQo+PiBNU0kgYW5kIE1TSS1YIGVudHJpZXMgZ2xv
YmFsbHksIHJlZ2FyZGxlc3Mgb2YgdGhlIElSUSBjaGlwIHRoZXkgYXJlIHVzaW5nLg0KPj4g
T25seSBYZW4gc2V0cyB0aGUgcGNpX21zaV9pZ25vcmVfbWFzayB3aGVuIHJvdXRpbmcgcGh5
c2ljYWwgaW50ZXJydXB0cyBvdmVyDQo+PiBldmVudCBjaGFubmVscywgdG8gcHJldmVudCBQ
Q0kgY29kZSBmcm9tIGF0dGVtcHRpbmcgdG8gdG9nZ2xlIHRoZSBtYXNrYml0LA0KPj4gYXMg
aXQncyBYZW4gdGhhdCBjb250cm9scyB0aGUgYml0Lg0KPj4NCj4+IEhvd2V2ZXIsIHRoZSBw
Y2lfbXNpX2lnbm9yZV9tYXNrIGJlaW5nIGdsb2JhbCB3aWxsIGFmZmVjdCBkZXZpY2VzIHRo
YXQgdXNlDQo+PiBNU0kgaW50ZXJydXB0cyBidXQgYXJlIG5vdCByb3V0aW5nIHRob3NlIGlu
dGVycnVwdHMgb3ZlciBldmVudCBjaGFubmVscw0KPj4gKG5vdCB1c2luZyB0aGUgWGVuIHBJ
UlEgY2hpcCkuICBPbmUgZXhhbXBsZSBpcyBkZXZpY2VzIGJlaGluZCBhIFZNRCBQQ0kNCj4+
IGJyaWRnZS4gIEluIHRoYXQgc2NlbmFyaW8gdGhlIFZNRCBicmlkZ2UgY29uZmlndXJlcyBN
U0koLVgpIHVzaW5nIHRoZQ0KPj4gbm9ybWFsIElSUSBjaGlwICh0aGUgcElSUSBvbmUgaW4g
dGhlIFhlbiBjYXNlKSwgYW5kIGRldmljZXMgYmVoaW5kIHRoZQ0KPj4gYnJpZGdlIGNvbmZp
Z3VyZSB0aGUgTVNJIGVudHJpZXMgdXNpbmcgaW5kZXhlcyBpbnRvIHRoZSBWTUQgYnJpZGdl
IE1TSQ0KPj4gdGFibGUuICBUaGUgVk1EIGJyaWRnZSB0aGVuIGRlbXVsdGlwbGV4ZXMgc3Vj
aCBpbnRlcnJ1cHRzIGFuZCBkZWxpdmVycyB0bw0KPj4gdGhlIGRlc3RpbmF0aW9uIGRldmlj
ZShzKS4gIEhhdmluZyBwY2lfbXNpX2lnbm9yZV9tYXNrIHNldCBpbiB0aGF0IHNjZW5hcmlv
DQo+PiBwcmV2ZW50cyAodW4pbWFza2luZyBvZiBNU0kgZW50cmllcyBmb3IgZGV2aWNlcyBi
ZWhpbmQgdGhlIFZNRCBicmlkZ2UuDQo+Pg0KPj4gTW92ZSB0aGUgc2lnbmFsaW5nIG9mIG5v
IGVudHJ5IG1hc2tpbmcgaW50byB0aGUgTVNJIGRvbWFpbiBmbGFncywgYXMgdGhhdA0KPj4g
YWxsb3dzIHNldHRpbmcgaXQgb24gYSBwZXItZG9tYWluIGJhc2lzLiAgU2V0IGl0IGZvciB0
aGUgWGVuIE1TSSBkb21haW4NCj4+IHRoYXQgdXNlcyB0aGUgcElSUSBjaGlwLCB3aGlsZSBs
ZWF2aW5nIGl0IHVuc2V0IGZvciB0aGUgcmVzdCBvZiB0aGUNCj4+IGNhc2VzLg0KPj4NCj4+
IFJlbW92ZSBwY2lfbXNpX2lnbm9yZV9tYXNrIGF0IG9uY2UsIHNpbmNlIGl0IHdhcyBvbmx5
IHVzZWQgYnkgWGVuIGNvZGUsIGFuZA0KPj4gd2l0aCBYZW4gZHJvcHBpbmcgdXNhZ2UgdGhl
IHZhcmlhYmxlIGlzIHVubmVlZGVkLg0KPj4NCj4+IFRoaXMgZml4ZXMgdXNpbmcgZGV2aWNl
cyBiZWhpbmQgYSBWTUQgYnJpZGdlIG9uIFhlbiBQViBoYXJkd2FyZSBkb21haW5zLg0KPj4N
Cj4+IEFsYmVpdCBEZXZpY2VzIGJlaGluZCBhIFZNRCBicmlkZ2UgYXJlIG5vdCBrbm93biB0
byBYZW4sIHRoYXQgZG9lc24ndCBtZWFuDQo+PiBMaW51eCBjYW5ub3QgdXNlIHRoZW0uICBC
eSBpbmhpYml0aW5nIHRoZSB1c2FnZSBvZg0KPj4gVk1EX0ZFQVRfQ0FOX0JZUEFTU19NU0lf
UkVNQVAgYW5kIHRoZSByZW1vdmFsIG9mIHRoZSBwY2lfbXNpX2lnbm9yZV9tYXNrDQo+PiBi
b2RnZSBkZXZpY2VzIGJlaGluZCBhIFZNRCBicmlkZ2UgZG8gd29yayBmaW5lIHdoZW4gdXNl
IGZyb20gYSBMaW51eCBYZW4NCj4+IGhhcmR3YXJlIGRvbWFpbi4gIFRoYXQncyB0aGUgd2hv
bGUgcG9pbnQgb2YgdGhlIHNlcmllcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBQ
YXUgTW9ubsOpIDxyb2dlci5wYXVAY2l0cml4LmNvbT4NCj4+IFJldmlld2VkLWJ5OiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4+IEFja2VkLWJ5OiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IA0KPiBBY2tlZC1ieTogQmpvcm4gSGVsZ2Fh
cyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gDQo+IEkgYXNzdW1lIHlvdSdsbCBtZXJnZSB0
aGlzIHNlcmllcyB2aWEgdGhlIFhlbiB0cmVlLiAgTGV0IG1lIGtub3cgaWYNCj4gb3RoZXJ3
aXNlLg0KDQpJJ3ZlIHB1c2hlZCB0aGUgc2VyaWVzIHRvIHRoZSBsaW51eC1uZXh0IGJyYW5j
aCBvZiB0aGUgWGVuIHRyZWUuDQoNCg0KSnVlcmdlbg0K
--------------DcVMOhtx0fYQGrcD75hxrseI
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------DcVMOhtx0fYQGrcD75hxrseI--

--------------e8uEugkV0n8TkbLUq7aeRrvm--

--------------W0xkH04NA68e5Z3Jr2U2a3uN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfdHIkFAwAAAAAACgkQsN6d1ii/Ey/b
BQf/Q2PqhCQ0qvYW9+nRKZRkjb4qRgweKxGektgR3BrRBCNlfxZXaS+jZk3VVRoCcl5Aw2qibsMP
SM5IPAqZvksgA7PiI3+Ph+N9RPdyH7zoSbk5Q4FjqB/TWVv78P+vyXtpGjB7xo78y4e/62ybzI99
Z+aF1vy7NHwPH4y0ouk2Vy+zZj7O0YnnGikXyKuGcSzKV6xxhNuaoYsbO7lyWzfEwMCO9nY3SjFk
z+6wbwuOuty9FDMv8g4DthgeyEhs9+dFQEUljoLYjJdtksSkDQcvx4htHK93K1ONklw9/Zdni/x6
dCsL+BiOhdtPQ3N4l/+EQnLBDGT0dKBpoTvitTd5pQ==
=Ep0A
-----END PGP SIGNATURE-----

--------------W0xkH04NA68e5Z3Jr2U2a3uN--

