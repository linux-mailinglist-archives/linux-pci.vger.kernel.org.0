Return-Path: <linux-pci+bounces-5539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B2C8955C2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 15:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D4E1F23211
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105884A4D;
	Tue,  2 Apr 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSE/qStf"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA56634E5
	for <linux-pci@vger.kernel.org>; Tue,  2 Apr 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065862; cv=none; b=CYNiRUfpJnuXLXjlQih5x6UHl2bBnUL6/X4/R0IrGj/+KpOGr/Sm5fH/k/L6a9hK4+127oJin98Sl/lro6YUbaMgZKZh8LF6sGejGC3T8jizQaARz9eyTC3//sQsGI/36hoI8EPuVA2R6azxe7VeRrtbNTKVw+g/NmGnepcf55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065862; c=relaxed/simple;
	bh=eqI/etK+6fM35n5Im41/9uswJPpLC4StttMZzqjpoQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNnObWmXP/2GryG5TN7aqcvzG7L0NrJychcnArAOBeu6abtIEVwH+sTbB1RZQBU/P9I05r1nGbJ3g65zb0tVE8bfluvKwkk9jbBSOQl9zuXRVcAneDAeJdTcleYVFCmqmX+6kHolE/Z4IvaPjdsa+K6lQR9HpkW3j3A7Z3a34RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSE/qStf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712065859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqI/etK+6fM35n5Im41/9uswJPpLC4StttMZzqjpoQM=;
	b=gSE/qStfUXhVaC0DC1UD7FDC9pHA2Upz6Mg0M1yCIiwXnoDSTK0P4lyfYNQlTee34xb10o
	7aR6MBAGs0Z5A3LLNMtrJ4nBHlJfV/CHVV5njtPK0iMDMybHhgnUCFjiyL139AB+ZstwsZ
	8KDY02nEucp7jqhZiiRMgN3euWgkHPA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-a2HOxxBPNcak5jwygHjS_g-1; Tue, 02 Apr 2024 09:50:58 -0400
X-MC-Unique: a2HOxxBPNcak5jwygHjS_g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34365bed121so181903f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2024 06:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065856; x=1712670656;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqI/etK+6fM35n5Im41/9uswJPpLC4StttMZzqjpoQM=;
        b=gNgU2QfJCo4HL09DItGnUYcuAq+KlwLOnW4lScoWw79RSltl2rpGX//7zpYhQEj6Ci
         i8qSP1IpFlxCDOP0+/q33VjtosxtMVNTotTvbLvPon6rQdXBx3GIbcf8EPRI0cuRSIYd
         B8UdQscxV1grsjQnYFPypfxvWNLALkhTq08hT2OsUMBsgZBdUW8VflwtH63KR9ClFugK
         V1iS6Io4X3vIwqkyo0R8EL/Qj0vuqpZHTmftCdJk4HpwYZL2FYlLRCB3dOmgPYfGtV6/
         tPxqRfYNclg3NyMsR7jlxYQPJTiY2EBUm4l+zdrsB2J/p/7FMK3fLsnjIE9LR/8B3Nec
         77Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWcYc/+sYYADKN+z8Jz9qk62rYWSdkJGwujY8Q0+BUsuTMRpuB+gm6Jdpf2xjMFkjYD3dFJOngcCFGbrqejf42BtLEK8+MscOSL
X-Gm-Message-State: AOJu0Yz7nblLqnQJjQrmb9hhYxAGbD0Yf+oQQ1pu017HAZifiadrRe5Q
	VIxb/W95uQGwoYi5NIAghImNo4mVAq4yw5FrWeXfWIddus8fHtZtckKXgdO7sU1zS9NrR2LBG2i
	5DgeG4X1inw9L3orwoEqleh09Xd7aq+tAZFFQBi0dS0GeREMFIa1+yUwkTg==
X-Received: by 2002:a05:600c:1d13:b0:414:8f6c:be3 with SMTP id l19-20020a05600c1d1300b004148f6c0be3mr8749383wms.4.1712065856323;
        Tue, 02 Apr 2024 06:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi0bMcqLr4YTfkVFhGuXpH0Odl2avYorLgigrrV+EZkmHYjNhlOYELBpEJuaDdVn8BKbRuYw==
X-Received: by 2002:a05:600c:1d13:b0:414:8f6c:be3 with SMTP id l19-20020a05600c1d1300b004148f6c0be3mr8749362wms.4.1712065855892;
        Tue, 02 Apr 2024 06:50:55 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0041493aae77esm21293773wms.23.2024.04.02.06.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:50:55 -0700 (PDT)
Message-ID: <ffe0e534166f14483d0a6a37342136b7aec9c850.camel@redhat.com>
Subject: Re: [PATCH v4 10/10] drm/vboxvideo: fix mapping leaks
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, stable@kernel.vger.org
Date: Tue, 02 Apr 2024 15:50:54 +0200
In-Reply-To: <20240328175549.GA1574238@bhelgaas>
References: <20240328175549.GA1574238@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTAzLTI4IGF0IDEyOjU1IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+
IE9uIEZyaSwgTWFyIDAxLCAyMDI0IGF0IDEyOjI5OjU4UE0gKzAxMDAsIFBoaWxpcHAgU3Rhbm5l
ciB3cm90ZToKPiA+IFdoZW4gdGhlIFBDSSBkZXZyZXMgQVBJIHdhcyBpbnRyb2R1Y2VkIHRvIHRo
aXMgZHJpdmVyLCBpdCB3YXMKPiA+IHdyb25nbHkKPiA+IGFzc3VtZWQgdGhhdCBpbml0aWFsaXpp
bmcgdGhlIGRldmljZSB3aXRoIHBjaW1fZW5hYmxlX2RldmljZSgpCj4gPiBpbnN0ZWFkCj4gPiBv
ZiBwY2lfZW5hYmxlX2RldmljZSgpIHdpbGwgbWFrZSBhbGwgUENJIGZ1bmN0aW9ucyBtYW5hZ2Vk
Lgo+ID4gCj4gPiBUaGlzIGlzIHdyb25nIGFuZCB3YXMgY2F1c2VkIGJ5IHRoZSBxdWl0ZSBjb25m
dXNpbmcgUENJIGRldnJlcyBBUEkKPiA+IGluCj4gPiB3aGljaCBzb21lLCBidXQgbm90IGFsbCwg
ZnVuY3Rpb25zIGJlY29tZSBtYW5hZ2VkIHRoYXQgd2F5Lgo+ID4gCj4gPiBUaGUgZnVuY3Rpb24g
cGNpX2lvbWFwX3JhbmdlKCkgaXMgbmV2ZXIgbWFuYWdlZC4KPiA+IAo+ID4gUmVwbGFjZSBwY2lf
aW9tYXBfcmFuZ2UoKSB3aXRoIHRoZSBhY3R1YWxseSBtYW5hZ2VkIGZ1bmN0aW9uCj4gPiBwY2lt
X2lvbWFwX3JhbmdlKCkuCj4gPiAKPiA+IENDOiA8c3RhYmxlQGtlcm5lbC52Z2VyLm9yZz4gIyB2
NS4xMCsKPiAKPiBUaGlzIGlzIG1hcmtlZCBmb3Igc3RhYmxlIGJ1dCBkZXBlbmRzIG9uIHRoZSBw
cmVjZWRpbmcgcGF0Y2hlcyBpbgo+IHRoaXMKPiBzZXJpZXMsIHdoaWNoIGFyZSBub3QgbWFya2Vk
IGZvciBzdGFibGUuCj4gCj4gVGhlIHJlc3Qgb2YgdGhpcyBzZXJpZXMgbWlnaHQgYmUgcGlja2Vk
IHVwIGF1dG9tYXRpY2FsbHkgZm9yIHN0YWJsZSwKPiBidXQgSSBwZXJzb25hbGx5IHdvdWxkbid0
IHN1Z2dlc3QgYmFja3BvcnRpbmcgaXQgYmVjYXVzZSBpdCdzIHF1aXRlIGEKPiBsb3Qgb2YgY2hh
bmdlIGFuZCBJIGRvbid0IHRoaW5rIGl0IGZpdHMgcGVyCj4gRG9jdW1lbnRhdGlvbi9wcm9jZXNz
L3N0YWJsZS1rZXJuZWwtcnVsZXMucnN0LgoKSSBhZ3JlZSwgaWYgSSB3ZXJlIGEgc3RhYmxlIG1h
aW50YWluZXIgSSB3b3VsZG4ndCBhcHBseSBpdC4KSSBqdXN0IHB1dCB0aGVtIGluIENDIHNvIHRo
YXQgdGhleSBjYW4gbWFrZSB0aGlzIGRlY2lzaW9uIHRoZW1zZWx2ZXMuCgo+IFNvIEkgdGhpbmsg
dGhlIGJlc3Qgd2F5IHRvIGZpeCB0aGUgdmJveHZpZGVvIGxlYWtzIHdvdWxkIGJlIHRvIGZpeAo+
IHRoZW0gaW5kZXBlbmRlbnRseSBvZiB0aGlzIHNlcmllcywgdGhlbiBpbmNsdWRlIGFzIGEgc2Vw
YXJhdGUgcGF0Y2ggYQo+IGNvbnZlcnNpb24gdG8gdGhlIG5ldyBwY2ltX2lvbWFwX3JhbmdlKCkg
aW4gdGhpcyBzZXJpZXMgKG9yIHBvc3NpYmx5Cj4gZm9yIHRoZSBuZXh0IG1lcmdlIHdpbmRvdyB0
byBhdm9pZCBtZXJnZSBjb25mbGljdHMpLgoKSXQgaXMgaGFyZCB0byBmaXggaW5kZXBlbmRlbnRs
eSBvZiBvdXIgbmV3IGRldnJlcyB1dGlsaXR5LgpSZWFzb24gYmVpbmcgdGhhdCBpdCdzIF9pbXBv
c3NpYmxlXyB0byBoYXZlIHBhcnRpYWwgQkFSIG1hcHBpbmdzICp3aXRoKgp0aGUgY3VycmVudCBQ
Q0kgZGV2cmVzIEFQSS4KCkNvbnNlcXVlbnRseSwgYSBwb3J0YWJsZSB2Ym94dmlkZW8gd291bGQg
aGF2ZSB0byByZXZlcnQgdGhlIGVudGlyZQpjb21taXQgODU1OGRlNDAxYjVmIGFuZCBiZWNvbWUg
YW4gdW5tYW5hZ2VkIGRyaXZlciBhZ2Fpbi4KCkkgZ3Vlc3MgeW91IGNvdWxkIGRvIGEgaGFja3kg
Zml4IHdoZXJlIHRoZSByZWdpb25zIGFyZSBoYW5kbGVkIGJ5CmRldnJlcyBhbmQgdGhlIG1hcHBp
bmdzIGFyZSBjcmVhdGVkIGFuZCBkZXN0cm95ZWQgbWFudWFsbHkgd2l0aApwY2lfaW9tYXBfcmFu
Z2UoKSDigJMgYnV0IGRvIHdlIHJlYWxseSB3YW50IHRoYXQuLi4/CgpUaGUgbGVhayBvbmx5IG9j
Y3VycyB3aGVuIGRyaXZlciBhbmQgZGV2aWNlIGRldGFjaCwgc28gaG93IG9mdGVuIGRvZXMKdGhh
dCBoYXBwZW4uLi4gYW5kIGFzIGZhciBhcyBJIGNhbiB0ZWxsIGl0J3MgYWxzbyBub3QgYW4gZXhw
bG9pdGFibGUKbGVhaywgc28gb25lIGNvdWxkIG1ha2UgdGhlIGRlY2lzaW9uIHRvIGp1c3QgbGVh
dmUgaXQgaW4gdGhlIHN0YWJsZQprZXJuZWxzLi4uCgpASGFuczoKV2hhdCBkbyB5b3Ugc2F5PwoK
ClAuCgo+IAo+ID4gRml4ZXM6IDg1NThkZTQwMWI1ZiAoImRybS92Ym94dmlkZW86IHVzZSBtYW5h
Z2VkIHBjaSBmdW5jdGlvbnMiKQo+ID4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBTdGFubmVyIDxw
c3Rhbm5lckByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiDCoGRyaXZlcnMvZ3B1L2RybS92Ym94dmlk
ZW8vdmJveF9tYWluLmMgfCAyMCArKysrKysrKystLS0tLS0tLS0tLQo+ID4gwqAxIGZpbGUgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS92Ym94dmlkZW8vdmJveF9tYWluLmMKPiA+IGIvZHJpdmVycy9n
cHUvZHJtL3Zib3h2aWRlby92Ym94X21haW4uYwo+ID4gaW5kZXggNDJjMmQ4YTk5NTA5Li5kNGFk
ZTkzMjU0MDEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdmJveHZpZGVvL3Zib3hf
bWFpbi5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdmJveHZpZGVvL3Zib3hfbWFpbi5jCj4g
PiBAQCAtNDIsMTIgKzQyLDExIEBAIHN0YXRpYyBpbnQgdmJveF9hY2NlbF9pbml0KHN0cnVjdCB2
Ym94X3ByaXZhdGUKPiA+ICp2Ym94KQo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIFRha2UgYSBjb21t
YW5kIGJ1ZmZlciBmb3IgZWFjaCBzY3JlZW4gZnJvbSB0aGUgZW5kIG9mCj4gPiB1c2FibGUgVlJB
TS4gKi8KPiA+IMKgwqDCoMKgwqDCoMKgwqB2Ym94LT5hdmFpbGFibGVfdnJhbV9zaXplIC09IHZi
b3gtPm51bV9jcnRjcyAqCj4gPiBWQlZBX01JTl9CVUZGRVJfU0laRTsKPiA+IMKgCj4gPiAtwqDC
oMKgwqDCoMKgwqB2Ym94LT52YnZhX2J1ZmZlcnMgPSBwY2lfaW9tYXBfcmFuZ2UocGRldiwgMCwK
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2Ym94LQo+ID4gPmF2YWlsYWJsZV92
cmFtX3NpemUsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmJveC0+bnVtX2Ny
dGNzICoKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWQlZBX01JTl9CVUZGRVJf
U0laRSk7Cj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoIXZib3gtPnZidmFfYnVmZmVycykKPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsKPiA+ICvCoMKgwqDC
oMKgwqDCoHZib3gtPnZidmFfYnVmZmVycyA9IHBjaW1faW9tYXBfcmFuZ2UoCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBkZXYsIDAsIHZib3gtPmF2
YWlsYWJsZV92cmFtX3NpemUsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHZib3gtPm51bV9jcnRjcyAqIFZCVkFfTUlOX0JVRkZFUl9TSVpFKTsKPiA+
ICvCoMKgwqDCoMKgwqDCoGlmIChJU19FUlIodmJveC0+dmJ2YV9idWZmZXJzKSkKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gUFRSX0VSUih2Ym94LT52YnZhX2J1ZmZl
cnMpOwo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgdmJveC0+bnVt
X2NydGNzOyArK2kpIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdmJ2YV9z
ZXR1cF9idWZmZXJfY29udGV4dCgmdmJveC0+dmJ2YV9pbmZvW2ldLAo+ID4gQEAgLTExNiwxMSAr
MTE1LDEwIEBAIGludCB2Ym94X2h3X2luaXQoc3RydWN0IHZib3hfcHJpdmF0ZSAqdmJveCkKPiA+
IMKgwqDCoMKgwqDCoMKgwqBEUk1fSU5GTygiVlJBTSAlMDh4XG4iLCB2Ym94LT5mdWxsX3ZyYW1f
c2l6ZSk7Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIE1hcCBndWVzdC1oZWFwIGF0IGVu
ZCBvZiB2cmFtICovCj4gPiAtwqDCoMKgwqDCoMKgwqB2Ym94LT5ndWVzdF9oZWFwID0KPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoCBwY2lfaW9tYXBfcmFuZ2UocGRldiwgMCwgR1VFU1RfSEVBUF9P
RkZTRVQodmJveCksCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBHVUVTVF9IRUFQX1NJWkUpOwo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKCF2
Ym94LT5ndWVzdF9oZWFwKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biAtRU5PTUVNOwo+ID4gK8KgwqDCoMKgwqDCoMKgdmJveC0+Z3Vlc3RfaGVhcCA9IHBjaW1faW9t
YXBfcmFuZ2UocGRldiwgMCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgR1VFU1RfSEVBUF9PRkZTRVQodmJveCksIEdVRVNUX0hFQVBfU0laRSk7Cj4g
PiArwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKHZib3gtPmd1ZXN0X2hlYXApKQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBQVFJfRVJSKHZib3gtPmd1ZXN0X2hlYXAp
Owo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqAvKiBDcmVhdGUgZ3Vlc3QtaGVhcCBtZW0tcG9v
bCB1c2UgMl40ID0gMTYgYnl0ZSBjaHVua3MgKi8KPiA+IMKgwqDCoMKgwqDCoMKgwqB2Ym94LT5n
dWVzdF9wb29sID0gZGV2bV9nZW5fcG9vbF9jcmVhdGUodmJveC0+ZGRldi5kZXYsIDQsCj4gPiAt
MSwKPiA+IC0tIAo+ID4gMi40My4wCj4gPiAKPiAKCg==


