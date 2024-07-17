Return-Path: <linux-pci+bounces-10459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D819934297
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 21:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542EE2837EF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF46D18410F;
	Wed, 17 Jul 2024 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUA6B7CN"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A21822CE
	for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244520; cv=none; b=up7HOrAU3/N0HynZkINrvQ0onrs8reFs4sE2BtZLWQzqxrFIhVUFY/N0C/g0WL1Zw9mLgTo8J44CwkeKMixvmj6Dlp7iV5QH0hCD0Aj5WePzdP43NbsbOQZQZTg0p6fYhfz2E5hH947r8Z1mvJ7ab+Z12aA9tve2Hpk7Dnri4HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244520; c=relaxed/simple;
	bh=0pD4HSoaZH2Ej/3hmFwgITFmR3sRWzcOIGw2wjyvXQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJDQGaMUnONHZ/6TkIBK6pOTkAFVlwUoe3K5kwIrVA+FwsvFuOxrjju2yN5dYalUtkvdYEyucvCX9JBoNYqJAS6lpTobEZzO0EI9jamdZJA8wh7MPNzlWVncgjfWO2TiSY44fdgwEfIxzz/4Zf5tXM9RRcKjaB8EjpE8CRktxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUA6B7CN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721244517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pD4HSoaZH2Ej/3hmFwgITFmR3sRWzcOIGw2wjyvXQ4=;
	b=hUA6B7CNFjFQxuoaGnwSHevK6WBaimmetl9hmMyzrQw94mD3nJsek1FMnEzzwWy6xQ01Oo
	ittuvsltqDUFX+Yaoxqj7Q2fbS0zXUf1CnKQg4WK5/YljDDtjgeoMPOUmQJCFiq2bAoNFC
	PasiY4dHtDrQVk89vDJyKRHqNgI/bpo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-h3KsiGjjM_-cQobcr-wXzw-1; Wed, 17 Jul 2024 15:28:35 -0400
X-MC-Unique: h3KsiGjjM_-cQobcr-wXzw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a0d7d02a8aso107826a12.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 12:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721244513; x=1721849313;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pD4HSoaZH2Ej/3hmFwgITFmR3sRWzcOIGw2wjyvXQ4=;
        b=luz2KmJaHAAIynT/tDjwCZ9LBSsE6h6Vl1UsheELjjHidQpWfsn5PIFKyh97nZL+0u
         CA53G8sNwkgYCFBCJMt74n4vCXDryvOZM1/5yL6W8g6LzGG8YFDSzedPIJ3Om4XGw7jL
         bqbC7LJ3xenhpiyzrl5t9PpSjNlWXE+bTP187oxoi15Ur83O+I12CcXIkLQYluiLhTw7
         cUxvitk8ScasPqsuStdGxPa7oGmXwXA9lKgDa7TPO+j7z/X+FY7jVl17spUS0rbtjBzw
         Z3FF7XFWu1eKa2KWNATGRQCAslrwoR8JaKnmkxQmkpfjR56wE7pcEq4P2ZrA9e1sFfVS
         DCYA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Uu4JcP6bbcN39Ga3uP8d+DEHHpo8B6gLZZbnUePckvIzQEOtgpwAWaSHqc4QGwNteywQujI4lHlst28nZNhmYsrj/SVMC2tO
X-Gm-Message-State: AOJu0YwqajjeEl4b17pGyC/C7R1GFIjKW3CXKE24qkloLuPtToEbBOcw
	Z4G8zqdNanMxAm8ywqUapdoieRxnN3tDP95WeFnOSZ7rF+w3maCOLEYLanphEQb2IZTc6U8xDjD
	CbQeG07BDxPAThlMQDcZOXajsBEVAgNCxum0smOzcOlcBKf/8asaMSpzVjA==
X-Received: by 2002:a17:906:70d:b0:a77:af07:b978 with SMTP id a640c23a62f3a-a7a011388e8mr111275066b.1.1721244513423;
        Wed, 17 Jul 2024 12:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Ct2o1CBrr9w66JQWmdhXnrdu96P9BJ0eFvdM9l9nNYPtt56Gm4OdxI26zMMWwRGUsRcKMg==
X-Received: by 2002:a17:906:70d:b0:a77:af07:b978 with SMTP id a640c23a62f3a-a7a011388e8mr111273966b.1.1721244513006;
        Wed, 17 Jul 2024 12:28:33 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (200116b82dca8a00524d280e0718aac8.dip.versatel-1u1.de. [2001:16b8:2dca:8a00:524d:280e:718:aac8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3650sm487656566b.17.2024.07.17.12.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:28:32 -0700 (PDT)
Message-ID: <757f5fcdc14c8f22e52a34974f2e48fe2dcea4d5.camel@redhat.com>
Subject: Re: [PATCH v2 1/8] x86/PCI: Move some logic to new function
From: Philipp Stanner <pstanner@redhat.com>
To: Stewart Hildebrand <stewart.hildebrand@amd.com>, Bjorn Helgaas
	 <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ilpo
	=?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 17 Jul 2024 21:28:31 +0200
In-Reply-To: <20240716193246.1909697-2-stewart.hildebrand@amd.com>
References: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
	 <20240716193246.1909697-2-stewart.hildebrand@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA3LTE2IGF0IDE1OjMyIC0wNDAwLCBTdGV3YXJ0IEhpbGRlYnJhbmQgd3Jv
dGU6Cj4gLi4uIHRvIHJlZHVjZSBpbmRlbnRhdGlvbiBsZXZlbC4gVGFrZSB0aGUgb3Bwb3J0dW5p
dHkgdG8gcmVtb3ZlCj4gcmVkdW5kYW50IGluZm8gZnJvbSBkZWJ1ZyBwcmludCBzdHJpbmcuCgpJ
cyB0aGF0IGludGVuZGVkIHRvIGJlIHRoZSBmaW5hbCBjb21taXQgbWVzc2FnZSBvciBpcyBpdCBz
dGlsbCBhIGRyYWZ0PwoKSSdkIGNhbGwgdGhlIGNvbW1pdCAieDg2L1BDSTogSW1wcm92ZSBjb2Rl
IHJlYWRhYmlsaXR5IiAob3Igc3RoIGxpa2UKdGhhdCkgc2luY2UgdGhhdCBpcyB3aGF0IHRoZSBj
b21taXQgaXMgYWJvdXQuIEl0J3Mgbm90IHNvIG11Y2ggYWJvdXQKdGhlIGNvZGUgbW92ZSBwZXIg
c2UuCgphbmQgaGF2ZSBhIHNob3J0IG1lc3NhZ2Ugc3VjaCBhczoKCiIKVGhlIGluZGVudGF0aW9u
IGluIHBjaWJpb3NfYWxsb2NhdGVfZGV2X3Jlc291cmNlcygpIGlzIHVudXNhbGx5IGRlZXAuCgpJ
bXByb3ZlIHRoYXQgYnkgbW92aW5nIHNvbWUgb2YgaXRzIGNvZGUgdG8gdGhlIG5ldyBmdW5jdGlv
bgphbGxvY19yZXNvdXJjZSgpLgoKQXMgd2UncmUgYXQgaXQsIHJlbW92ZSByZWR1bmRhbnQgaW5m
b3JtYXRpb24gZnJvbSBkZXZfZGJnKCkuCiIKCgpSZWdhcmRzLApQLgoKPiAKPiBTaWduZWQtb2Zm
LWJ5OiBTdGV3YXJ0IEhpbGRlYnJhbmQgPHN0ZXdhcnQuaGlsZGVicmFuZEBhbWQuY29tPgo+IC0t
LQo+IHYxLT52MjoKPiAqIG5ldyBwYXRjaAo+IC0tLQo+IMKgYXJjaC94ODYvcGNpL2kzODYuYyB8
IDM4ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L3BjaS9pMzg2LmMgYi9hcmNoL3g4Ni9wY2kvaTM4Ni5jCj4gaW5kZXggZjJmNGE1
ZDUwYjI3Li4zYWJkNTU5MDJkYmMgMTAwNjQ0Cj4gLS0tIGEvYXJjaC94ODYvcGNpL2kzODYuYwo+
ICsrKyBiL2FyY2gveDg2L3BjaS9pMzg2LmMKPiBAQCAtMjQ2LDYgKzI0NiwyNSBAQCBzdHJ1Y3Qg
cGNpX2NoZWNrX2lkeF9yYW5nZSB7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBlbmQ7Cj4gwqB9Owo+
IMKgCj4gK3N0YXRpYyB2b2lkIGFsbG9jX3Jlc291cmNlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGlu
dCBpZHgsIGludCBwYXNzKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHJlc291cmNlICpy
ID0gJmRldi0+cmVzb3VyY2VbaWR4XTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgZGV2X2RiZygmZGV2
LT5kZXYsICJCQVIgJWQ6IHJlc2VydmluZyAlcHIgKHA9JWQpXG4iLCBpZHgsIHIsCj4gcGFzcyk7
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmIChwY2lfY2xhaW1fcmVzb3VyY2UoZGV2LCBpZHgpIDwg
MCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoci0+ZmxhZ3MgJiBJT1JF
U09VUkNFX1BDSV9GSVhFRCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZGV2X2luZm8oJmRldi0+ZGV2LCAiQkFSICVkICVwUiBpcwo+IGltbW92YWJs
ZVxuIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWR4LCByKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
fSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC8qIFdlJ2xsIGFzc2lnbiBhIG5ldyBhZGRyZXNzIGxhdGVyICovCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwY2liaW9zX3NhdmVfZndfYWRkcihkZXYs
IGlkeCwgci0+c3RhcnQpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgci0+ZW5kIC09IHItPnN0YXJ0Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgci0+c3RhcnQgPSAwOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICt9Cj4gKwo+IMKgc3RhdGljIHZvaWQg
cGNpYmlvc19hbGxvY2F0ZV9kZXZfcmVzb3VyY2VzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludAo+
IHBhc3MpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBpZHgsIGRpc2FibGVkLCBpOwo+IEBA
IC0yNzEsMjMgKzI5MCw4IEBAIHN0YXRpYyB2b2lkCj4gcGNpYmlvc19hbGxvY2F0ZV9kZXZfcmVz
b3VyY2VzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBwYXNzKQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkaXNhYmxlZCA9
ICEoY29tbWFuZCAmCj4gUENJX0NPTU1BTkRfSU8pOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVsc2UKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGlzYWJsZWQgPSAhKGNvbW1h
bmQgJgo+IFBDSV9DT01NQU5EX01FTU9SWSk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocGFzcyA9PSBkaXNhYmxlZCkgewo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9k
YmcoJmRldi0+ZGV2LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiQkFSICVkOiByZXNlcnZpbmcg
JXByIChkPSVkLAo+IHA9JWQpXG4iLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZHgsIHIsIGRp
c2FibGVkLCBwYXNzKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocGNpX2NsYWltX3Jlc291cmNlKGRldiwgaWR4KSA8
IDApCj4gewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoci0+ZmxhZ3MgJgo+IElPUkVTT1VS
Q0VfUENJX0ZJWEVEKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBk
ZXZfaW5mbygmZGV2LT5kZXYsCj4gIkJBUiAlZCAlcFIgaXMgaW1tb3ZhYmxlXG4iLAo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZHgsIHIp
Owo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9IGVsc2Ugewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLyogV2UnbGwgYXNzaWduIGEgbmV3Cj4gYWRkcmVzcyBsYXRlciAq
Lwo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGNpYmlvc19zYXZl
X2Z3X2FkZHIoZGUKPiB2LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZHgsCj4gci0+c3RhcnQpOwo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgci0+ZW5kIC09IHItPnN0YXJ0Owo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgci0+c3RhcnQgPSAwOwo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKHBhc3MgPT0gZGlzYWJsZWQpCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWxsb2NfcmVzb3Vy
Y2UoZGV2LCBpZHgsIHBhc3MpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+
IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXBhc3MpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHIgPSAmZGV2LT5yZXNvdXJjZVtQQ0lfUk9NX1JFU09VUkNFXTsKCg==


