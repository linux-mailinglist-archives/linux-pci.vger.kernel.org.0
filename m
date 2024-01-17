Return-Path: <linux-pci+bounces-2251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981B68301CD
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422A32895DE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01C3EAD8;
	Wed, 17 Jan 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjtX6At7"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9C13FED
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482132; cv=none; b=cM1sTOMsyzwPslkuYFfMgTDBqCRWXvlw9DQDEbiybiCDP0OtqkKXPNj0rI2GVjWmsr1iQ9ZV6qgn5Gmo+zV43Gy0qZSvi3Ta+qRJJ7iAme4+Jp/SfV2L0QjQL3aVTolazjRgp8jfp0cyS7hN62mYjSAZTdVzQdPsqwdRLyjcUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482132; c=relaxed/simple;
	bh=fCONQQwfnvvNZ57uYSX9Ww6ZAzspw0P6ttTs+4QytSA=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=T5AsRxvgINQmqPtttMDjiCwVSp+EmIZVJ3HeopFYP2lrwAcLrFrYu9UJkGP/mPPmaRnLsN/Lc1sg/VGlhXQ1+D6jijsg6DdFuvbVQ7v7zThGygQa9WY3QXVZ6DjCeqAjC17zzL5bFpkXk7NRdHM6xSfQNZHRMJej90nfFTu21b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjtX6At7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705482130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCONQQwfnvvNZ57uYSX9Ww6ZAzspw0P6ttTs+4QytSA=;
	b=BjtX6At7N+s/TV5ngC51ifGmxsHr0lzAoKQ7pyCcYR/a86Hh5aw02ZR2HBI6RFD0oMqbF0
	7sjTGZxp7bDOsPXe66RXUuWUdieHbm6IaiDEDTXbTLWXD7ENWynJyDK9JkhQJcTYykzL3O
	2lTHQkgP3Yo+tK0h+PQf0dCMWC0uXn4=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-YCTBpq_wPMKjvcvkb6tyOw-1; Wed, 17 Jan 2024 04:02:08 -0500
X-MC-Unique: YCTBpq_wPMKjvcvkb6tyOw-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-46982d5905bso52749137.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 01:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705482128; x=1706086928;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCONQQwfnvvNZ57uYSX9Ww6ZAzspw0P6ttTs+4QytSA=;
        b=a/HnQkKTsCxL2nRaV+Eaa6Fi4vN1hPEdgyGY9JgCs7xck+KpHgWPnT5eK60gK5Hyyj
         tK1uRJUKyfnDHiJMk22rkQgFL/FBO0gkHtFySgzUVnq/qsr3mrleiagbp7v+D9uNw/+n
         Fc36gcws8FTrubLjFGyxxFW03KfU6H/j2rIBzqwqU6C8/j068cocQfDYzj9/wHoz36PJ
         QCn/hb2dHeXRfX9ZgpQoR3KBwMiCKydzVvSbOEIug68XcU74bdSfP1gtiL0Eta+dduNE
         WJPj1LyRFe2pBxcnmCflVMCU9k7JNIPz7VLO7uM/oVFFICrX4cefHOAh9Zk8O6Ye7Q3p
         yTdQ==
X-Gm-Message-State: AOJu0YyafoFEHTCxg1tnhIjWPE1+atbDWqldJoBNJi4d1rzSaLHBlsS8
	RT41He3Ol5j/6Dbkhd21h2kEC/TOz+xwqWlq1sWqkAF3kiTVVGsIvyFBGnO2QvAVY/PIP+TGEmO
	4+qMogJ536dD6RdWK8RTO5MHvWxcn
X-Received: by 2002:a05:6122:2029:b0:4b6:bcd6:d681 with SMTP id l41-20020a056122202900b004b6bcd6d681mr9240692vkd.1.1705482128345;
        Wed, 17 Jan 2024 01:02:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSW7MGVMWJ53fx5lTmyx/I+jCrJWCGo0zLc3cwUMI3wUvles0VfwOaB22xcjo5NeZC4lGwoQ==
X-Received: by 2002:a05:6122:2029:b0:4b6:bcd6:d681 with SMTP id l41-20020a056122202900b004b6bcd6d681mr9240670vkd.1.1705482128078;
        Wed, 17 Jan 2024 01:02:08 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id c9-20020a0cd609000000b00681119814f4sm4845166qvj.6.2024.01.17.01.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 01:02:07 -0800 (PST)
Message-ID: <a61ed5ab7bbdb8797062bfe708a1adc98ca291bb.camel@redhat.com>
Subject: Re: [PATCH 06/10] pci: move pinned status bit to pci_dev struct
From: Philipp Stanner <pstanner@redhat.com>
To: andy.shevchenko@gmail.com
Cc: Jonathan Corbet <corbet@lwn.net>, Hans de Goede <hdegoede@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas
 <bhelgaas@google.com>, Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,  linux-pci@vger.kernel.org
Date: Wed, 17 Jan 2024 10:02:04 +0100
In-Reply-To: <Zab2dC6HVmk2gEwn@surfacebook.localdomain>
References: <20240115144655.32046-2-pstanner@redhat.com>
	 <20240115144655.32046-8-pstanner@redhat.com>
	 <Zab2dC6HVmk2gEwn@surfacebook.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTAxLTE2IGF0IDIzOjM0ICswMjAwLCBhbmR5LnNoZXZjaGVua29AZ21haWwu
Y29tIHdyb3RlOgo+IE1vbiwgSmFuIDE1LCAyMDI0IGF0IDAzOjQ2OjE3UE0gKzAxMDAsIFBoaWxp
cHAgU3Rhbm5lciBraXJqb2l0dGk6Cj4gPiBUaGUgYml0IGRlc2NyaWJpbmcgd2hldGhlciB0aGUg
UENJIGRldmljZSBpcyBjdXJyZW50bHkgcGlubmVkIGlzCj4gPiBzdG9yZWQKPiA+IGluIHRoZSBQ
Q0kgZGV2cmVzIHN0cnVjdC4gVG8gY2xlYW4gdXAgYW5kIHNpbXBsaWZ5IHRoZSBwY2ktZGV2cmVz
Cj4gPiBBUEksCj4gCj4gIlBDSSBkZXZyZXMiLCAncGNpLWRldnJlcycsIC4uLgo+IFNob3VsZG4n
dCB0aGVzZSAoYW5kIGFjcm9zcyBlbnRpcmUgc2VyaWVzKSBiZSBjb25zaXN0ZW50IHRlcm1zPwo+
IEUuZy4sICJQQ0kgZGV2cmVzIEFQSSIuCgpZZXMsIHdlIHNob3VsZCBhZ3JlZSBvbiBhIGNhbm9u
aWNhbCB0ZXJtIHByb2JhYmx5LgpQcm9iYWJseSAiUENJIGRldnJlcyIgaXMgZ29vZC4KCj4gCj4g
PiBpdCdzIGJldHRlciBpZiB0aGlzIGluZm9ybWF0aW9uIGlzIHN0b3JlZCBpbiB0aGUgcGNpX2Rl
diBzdHJ1Y3QsCj4gPiBiZWNhdXNlCj4gCj4gcGNpX2RldiBzdHJ1Y3QgLS0+IHN0cnVjdCBwY2lf
ZGV2Cj4gCj4gPiBpdCBhbGxvd3MgZm9yIGNoZWNraW5nIHRoYXQgZGV2aWNlJ3MgcGlubmVkLXN0
YXR1cyBkaXJlY3RseSB0aHJvdWdoCj4gPiB0aGUKPiA+IGRldmljZSBzdHJ1Y3QuCj4gPiBUaGlz
IHdpbGwgbGF0ZXIgcGVybWl0IHNpbXBsaWZ5aW5nwqAgcGNpbV9lbmFibGVfZGV2aWNlKCkuCj4g
Cj4gPiBNb3ZlIHRoZSAncGlubmVkJyBib29sZWFuIGJpdCB0byBzdHJ1Y3QgcGNpX2Rldi4KPiAK
PiAuLi4KPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqB1OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBwbV9jYXA7wqDCoMKgwqDCoMKgwqDCoMKgLyogUE0gY2FwYWJpbGl0eSBvZmZzZXQgKi8KPiA+
IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnTCoMKgwqDCoGVuYWJsZWQ6MTvCoMKgwqDCoMKg
wqAvKiBXaGV0aGVyIHRoaXMgZGV2IGlzCj4gPiBlbmFibGVkICovCj4gPiArwqDCoMKgwqDCoMKg
wqB1bnNpZ25lZCBpbnTCoMKgwqDCoHBpbm5lZDoxO8KgwqDCoMKgwqDCoMKgLyogV2hldGhlciB0
aGlzIGRldiBpcwo+ID4gcGlubmVkICovCj4gPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50
wqDCoMKgwqBpbW1fcmVhZHk6MTvCoMKgwqDCoC8qIFN1cHBvcnRzIEltbWVkaWF0ZQo+ID4gUmVh
ZGluZXNzICovCj4gPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50wqDCoMKgwqBwbWVfc3Vw
cG9ydDo1O8KgwqAvKiBCaXRtYXNrIG9mIHN0YXRlcyBmcm9tCj4gPiB3aGljaCBQTUUjCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FuIGJlIGdlbmVyYXRlZCAqLwo+IAo+IEZpcnN0
IG9mIGFsbCwgSSB0aGluayBpdCdzIGJldHRlciB0byBncm91cCBQTSBzdHVmZiwgbGlrZQoKQUNL
Cgo+IAo+IMKgwqDCoMKgwqDCoMKgwqB1OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwbV9j
YXA7wqDCoMKgwqDCoMKgwqDCoMKgLyogUE0gY2FwYWJpbGl0eSBvZmZzZXQgKi8KPiDCoMKgwqDC
oMKgwqDCoMKgdW5zaWduZWQgaW50wqDCoMKgwqBwbWVfc3VwcG9ydDo1O8KgwqAvKiBCaXRtYXNr
IG9mIHN0YXRlcyBmcm9tCj4gd2hpY2ggUE1FIwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjYW4gYmUgZ2VuZXJhdGVkICovCj4gwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludMKgwqDC
oMKgaW1tX3JlYWR5OjE7wqDCoMKgwqAvKiBTdXBwb3J0cyBJbW1lZGlhdGUKPiBSZWFkaW5lc3Mg
Ki8KPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50wqDCoMKgwqBlbmFibGVkOjE7wqDCoMKg
wqDCoMKgLyogV2hldGhlciB0aGlzIGRldiBpcwo+IGVuYWJsZWQgKi8KPiDCoMKgwqDCoMKgwqDC
oMKgdW5zaWduZWQgaW50wqDCoMKgwqBwaW5uZWQ6MTvCoMKgwqDCoMKgwqDCoC8qIFdoZXRoZXIg
dGhpcyBkZXYgaXMgcGlubmVkCj4gKi8KPiAKPiBTZWNvbmQsIGRvZXMgdGhpcyBsYXlvdXQgYW55
aG93IHJlbGF0ZWQgdG8gdGhlIEhXIGxheW91dD8gKEZvcgo+IGV4YW1wbGUsCj4gUE1FIGJpdHMg
YW5kIHRoZWlyIGxvY2F0aW9uIGluIHNvbWUgSFcgcmVnaXN0ZXIgdnMuIHRoZXNlIGJpdGZpZWxk
cykKPiBJZiBzbywgYnV0IG5vdCBzdXJlLCBpdCBtaWdodCBiZSBnb29kIHRvIHByZXNlcnZlICh0
byBzb21lIGV4dGVudCkKPiB0aGUKPiBvcmRlci4KCkFzIGZhciBhcyBJIGtub3csIG9uZSBvZiB0
aGUgZ3JlYXRlc3Qgd2Vha25lc3NlcyBvZiBDIGlzIHRoYXQgbmVpdGhlcgpSaXRjaGllIG5vciB0
aGUgc3RhbmRhcmQgZXZlciBzYWlkIGFueXRoaW5nIGFib3V0IHRoZSBmaWVsZHMnIG9yZGVyLgpI
ZW5jZSwgZXZlcnkgZmllbGQtb3JkZXIgaXMgcHVyZWx5IGltcGxlbWVudGF0aW9uLWRlZmluZWQg
YW5kIGluIG5vIHdheQpwb3J0YWJsZS4KU28gSSBjYW4ndCBpbWFnaW5lIGEgYml0ZmllbGQgd2ls
bCBldmVyIGRpcmVjdGx5IG1hcHAgdG8gYSBIVy1sYXlvdXQ/CgpUaGUgZmllbGRzIG9yZGVyIGlz
IHB1cmVseSBhZXN0aGV0aWMgLyBmb3IgdGhlIGh1bWFuIHJlYWRlci4KCgpQLgoKPiAKCg==


