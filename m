Return-Path: <linux-pci+bounces-8530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF0901F20
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 12:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB534B24CD2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 10:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6867868B;
	Mon, 10 Jun 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBW7MHxB"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1B38DEC
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014806; cv=none; b=rfUuG85cIN/u9KewiUDzIIdcOwad8aviOowttTjZluBc7lP4/Nke5yXUOZEBsj2RCUTCC+Og6y+OcCid76KYNj98UFKs9FTqFO4EYb9B/hmpZsTvSy3ji/Rs1SCnRYsewUw7JZG5dbhe/rPHJa3KG1GprNywU4MAGWZFHZOWMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014806; c=relaxed/simple;
	bh=qMvcynBHrWYs0cALHqvZH4z7O+79T1qe0EY88237L2Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RTVUc/53W6P+S4zV2k4ddQpgb+R0nWmdt9AKK8QaCO9vmro7Y2ANz084DMTjysxvM7T5xoJEKsLhhtBi7Rv17GukWpzCeZDtIvZXP1kDYZDDQ5Kq1Sbidg3N4eSV+OBvuKkybKbbTTyzd2RukQvGubWxznDM8Y/KZaa6ZcyXV3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBW7MHxB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718014803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMvcynBHrWYs0cALHqvZH4z7O+79T1qe0EY88237L2Q=;
	b=NBW7MHxB3VnabskEXEBIl5UoJO/xYeGfhLNNKhtkMDc5QRpCwvvwdYdoEL6eu+LBVuWSiu
	hQjEGidvbJusLVp3E9aelquBbUr8RWTWXVUGCC3I9Noj0fEoEF1C8jdsMncZzBFT1I+826
	sNl3Xc3B+1QMC7GHA2tY8kwV17feBcc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-5AvHUw3PP7WHz2IcVosgKA-1; Mon, 10 Jun 2024 06:20:01 -0400
X-MC-Unique: 5AvHUw3PP7WHz2IcVosgKA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42180a0730dso1874195e9.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 03:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014801; x=1718619601;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMvcynBHrWYs0cALHqvZH4z7O+79T1qe0EY88237L2Q=;
        b=fMIgByN5QdnKOHloldPY92bj8kmN8uMqDHO8E4PcikY7pK39cVVLZQzydH3Ks4hB55
         PpgC/mfpOe1bwdZT932rcfU7fIxxUbZChAIhPSsic7YuV42fGNki0L5kTuInRD4EYzCR
         xALPC0EQ24CCVk8nUj9K4Rxf5IqTqzxEbQrqd3mH60J0pSF4PxlpnzrU/duTeU5GtUWK
         DGrnasavVJBsxZa+mpBAvg5mAz1zzBJRcRX4UoCZqcN9Gxn74Yr1udVFDfmH+gDgaup9
         2K5dXaPglX39QOahK4w0jKoMTqjTyrBqzpcmzqr4ALJk47ROu1c/cApsWh2gpLuqdmjt
         cytw==
X-Forwarded-Encrypted: i=1; AJvYcCVajKfr9eQZWDTkO0EDF6S0HlfRJ6gNc0eUl3Je0CbetXOG8foTijGdDunZXP6AlVsOcAVSC4CHhT1bdWukAB6N9pcmSVhQaa2p
X-Gm-Message-State: AOJu0Yxl452m+ZVsFrR7lBEm20pBht4tS24ZgKmBhBoYZDAcAUJGUT8z
	76qLBxi7pfnTyWfsymis6x8TinfQMoCulh2r35MiXas/8yoZcil14AKu9joOpk20CtgRM+L2NPW
	5Nviwo58W3RA3q2XJBDi0fEX2AGYYNFYlieUTBgDAFmfGUlJz+w9riNJMBw==
X-Received: by 2002:a05:6000:1888:b0:35f:2584:7714 with SMTP id ffacd0b85a97d-35f258478aamr1140493f8f.5.1718014800761;
        Mon, 10 Jun 2024 03:20:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVQ5ssyCFjkZt4UK3b3fOfN9lD0Xt7ezocPi7jiouFZYIFIOKhrohlDydb/DJLIIVw0DW8BA==
X-Received: by 2002:a05:6000:1888:b0:35f:2584:7714 with SMTP id ffacd0b85a97d-35f258478aamr1140471f8f.5.1718014800347;
        Mon, 10 Jun 2024 03:20:00 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1846574esm5666493f8f.117.2024.06.10.03.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:19:59 -0700 (PDT)
Message-ID: <bae495cf171db1415cf14c44fb450b81148a6e0d.camel@redhat.com>
Subject: Re: [PATCH v8 08/13] PCI: Move pinned status bit to struct pci_dev
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Date: Mon, 10 Jun 2024 12:19:58 +0200
In-Reply-To: <20240610093149.20640-9-pstanner@redhat.com>
References: <20240610093149.20640-1-pstanner@redhat.com>
	 <20240610093149.20640-9-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA2LTEwIGF0IDExOjMxICswMjAwLCBQaGlsaXBwIFN0YW5uZXIgd3JvdGU6
Cj4gVGhlIGJpdCBkZXNjcmliaW5nIHdoZXRoZXIgdGhlIFBDSSBkZXZpY2UgaXMgY3VycmVudGx5
IHBpbm5lZCBpcyBzdG9yZWQKPiBpbiBzdHJ1Y3QgcGNpX2RldnJlcy4gVG8gY2xlYW4gdXAgYW5k
IHNpbXBsaWZ5IHRoZSBQQ0kgZGV2cmVzIEFQSSwgaXQncwo+IGJldHRlciBpZiB0aGlzIGluZm9y
bWF0aW9uIGlzIHN0b3JlZCBpbiBzdHJ1Y3QgcGNpX2Rldi4KPiAKPiBUaGlzIHdpbGwgbGF0ZXIg
cGVybWl0IHNpbXBsaWZ5aW5nIHBjaW1fZW5hYmxlX2RldmljZSgpLgo+IAo+IE1vdmUgdGhlICdw
aW5uZWQnIGJvb2xlYW4gYml0IHRvIHN0cnVjdCBwY2lfZGV2Lgo+IAo+IFJlc3RydWN0dXJlIGJp
dHMgaW4gc3RydWN0IHBjaV9kZXYgc28gdGhlIHBtIC8gcG1lIGZpZWxkcyBhcmUgbmV4dCB0bwo+
IGVhY2ggb3RoZXIuCj4gCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBTdGFubmVyIDxwc3Rhbm5l
ckByZWRoYXQuY29tPgo+IC0tLQo+IMKgZHJpdmVycy9wY2kvZGV2cmVzLmMgfCAxNCArKysrLS0t
LS0tLS0tLQo+IMKgZHJpdmVycy9wY2kvcGNpLmjCoMKgwqAgfMKgIDEgLQo+IMKgaW5jbHVkZS9s
aW51eC9wY2kuaMKgIHzCoCA0ICsrKy0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvZGV2cmVz
LmMgYi9kcml2ZXJzL3BjaS9kZXZyZXMuYwo+IGluZGV4IDlkMjU5NDBjZTI2MC4uMjY5NmJhZWY1
YzJjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcGNpL2RldnJlcy5jCj4gKysrIGIvZHJpdmVycy9w
Y2kvZGV2cmVzLmMKPiBAQCAtNDAzLDcgKzQwMyw3IEBAIHN0YXRpYyB2b2lkIHBjaW1fcmVsZWFz
ZShzdHJ1Y3QgZGV2aWNlICpnZW5kZXYsIHZvaWQgKnJlcykKPiDCoMKgwqDCoMKgwqDCoMKgaWYg
KHRoaXMtPnJlc3RvcmVfaW50eCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBj
aV9pbnR4KGRldiwgdGhpcy0+b3JpZ19pbnR4KTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGlmIChw
Y2lfaXNfZW5hYmxlZChkZXYpICYmICF0aGlzLT5waW5uZWQpCj4gK8KgwqDCoMKgwqDCoMKgaWYg
KHBjaV9pc19lbmFibGVkKGRldikgJiYgIWRldi0+cGlubmVkKQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcGNpX2Rpc2FibGVfZGV2aWNlKGRldik7Cj4gwqB9Cj4gwqAKPiBAQCAt
NDU5LDE4ICs0NTksMTIgQEAgRVhQT1JUX1NZTUJPTChwY2ltX2VuYWJsZV9kZXZpY2UpOwo+IMKg
ICogcGNpbV9waW5fZGV2aWNlIC0gUGluIG1hbmFnZWQgUENJIGRldmljZQo+IMKgICogQHBkZXY6
IFBDSSBkZXZpY2UgdG8gcGluCj4gwqAgKgo+IC0gKiBQaW4gbWFuYWdlZCBQQ0kgZGV2aWNlIEBw
ZGV2LsKgIFBpbm5lZCBkZXZpY2Ugd29uJ3QgYmUgZGlzYWJsZWQgb24KPiAtICogZHJpdmVyIGRl
dGFjaC7CoCBAcGRldiBtdXN0IGhhdmUgYmVlbiBlbmFibGVkIHdpdGgKPiAtICogcGNpbV9lbmFi
bGVfZGV2aWNlKCkuCj4gKyAqIFBpbiBtYW5hZ2VkIFBDSSBkZXZpY2UgQHBkZXYuIFBpbm5lZCBk
ZXZpY2Ugd29uJ3QgYmUgZGlzYWJsZWQgb24gZHJpdmVyCj4gKyAqIGRldGFjaC4gQHBkZXYgbXVz
dCBoYXZlIGJlZW4gZW5hYmxlZCB3aXRoIHBjaW1fZW5hYmxlX2RldmljZSgpLgo+IMKgICovCj4g
wqB2b2lkIHBjaW1fcGluX2RldmljZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKPiDCoHsKPiAtwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgcGNpX2RldnJlcyAqZHI7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoGRy
ID0gZmluZF9wY2lfZHIocGRldik7Cj4gLcKgwqDCoMKgwqDCoMKgV0FSTl9PTighZHIgfHwgIXBj
aV9pc19lbmFibGVkKHBkZXYpKTsKPiAtwqDCoMKgwqDCoMKgwqBpZiAoZHIpCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRyLT5waW5uZWQgPSAxOwo+ICvCoMKgwqDCoMKgwqDCoHBk
ZXYtPnBpbm5lZCA9IHRydWU7Cj4gwqB9Cj4gwqBFWFBPUlRfU1lNQk9MKHBjaW1fcGluX2Rldmlj
ZSk7Cj4gwqAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLmggYi9kcml2ZXJzL3BjaS9w
Y2kuaAo+IGluZGV4IGQ3ZjAwYjQzYjA5OC4uNmUwMmJhMWI1OTQ3IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvcGNpL3BjaS5oCj4gKysrIGIvZHJpdmVycy9wY2kvcGNpLmgKPiBAQCAtODIxLDcgKzgy
MSw2IEBAIHN0YXRpYyBpbmxpbmUgcGNpX3Bvd2VyX3QgbWlkX3BjaV9nZXRfcG93ZXJfc3RhdGUo
c3RydWN0IHBjaV9kZXYgKnBkZXYpCj4gwqAgKiB0aGVuIHJlbW92ZSB0aGVtIGZyb20gaGVyZS4K
PiDCoCAqLwo+IMKgc3RydWN0IHBjaV9kZXZyZXMgewo+IC3CoMKgwqDCoMKgwqDCoHVuc2lnbmVk
IGludCBwaW5uZWQ6MTsKPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IG9yaWdfaW50eDox
Owo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgcmVzdG9yZV9pbnR4OjE7Cj4gwqDCoMKg
wqDCoMKgwqDCoHVuc2lnbmVkIGludCBtd2k6MTsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9wY2kuaCBiL2luY2x1ZGUvbGludXgvcGNpLmgKPiBpbmRleCBmYjAwNGZkNGU4ODkuLmNjOTI0
N2Y3ODE1OCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BjaS5oCj4gKysrIGIvaW5jbHVk
ZS9saW51eC9wY2kuaAo+IEBAIC0zNjcsMTAgKzM2NywxMiBAQCBzdHJ1Y3QgcGNpX2RldiB7Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRoaXMgaXMgRDAtRDMsIEQwIGJlaW5nIGZ1bGx5
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZ1bmN0aW9uYWwsIGFuZCBEMyBiZWluZyBv
ZmYuICovCj4gwqDCoMKgwqDCoMKgwqDCoHU4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBt
X2NhcDvCoMKgwqDCoMKgwqDCoMKgwqAvKiBQTSBjYXBhYmlsaXR5IG9mZnNldCAqLwo+IC3CoMKg
wqDCoMKgwqDCoHVuc2lnbmVkIGludMKgwqDCoMKgaW1tX3JlYWR5OjE7wqDCoMKgwqAvKiBTdXBw
b3J0cyBJbW1lZGlhdGUgUmVhZGluZXNzICovCj4gwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGlu
dMKgwqDCoMKgcG1lX3N1cHBvcnQ6NTvCoMKgLyogQml0bWFzayBvZiBzdGF0ZXMgZnJvbSB3aGlj
aCBQTUUjCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhbiBiZSBnZW5lcmF0ZWQgKi8K
PiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50wqDCoMKgwqBwbWVfcG9sbDoxO8KgwqDCoMKg
wqAvKiBQb2xsIGRldmljZSdzIFBNRSBzdGF0dXMgYml0ICovCj4gK8KgwqDCoMKgwqDCoMKgdW5z
aWduZWQgaW50wqDCoMKgwqBlbmFibGVkOjE7wqDCoMKgwqDCoMKgLyogV2hldGhlciB0aGlzIGRl
diBpcyBlbmFibGVkICovCgpBaCBjcmFwLCBoZXJlIGl0IHN1cnZpdmVkIGZvciBzb21lIHJlYXNv
bi4uLgoKU2hvdWxkIGp1c3QgYmUgZGVhZCBjb2RlIGFuZCBub3QgaGF2ZSBhbnkgZWZmZWN0LiBJ
biBhbnkgY2FzZSwgd2UKc2hvdWxkIHJlbW92ZSBpdC4KCkBCam9ybjogRmVlbCBmcmVlIHRvIHJl
bW92ZSBpdCB5b3Vyc2VsZi4gT3RoZXJ3aXNlIEkgY291bGQgcHJvdmlkZSBhIHY5CnRvZ2V0aGVy
IHdpdGggcG90ZW50aWFsIGZ1cnRoZXIgZmVlZGJhY2sgdGFrZW4gaW50byBhY2NvdW50IGluIGEg
ZmV3CmRheXMKClRoeCwKUC4KCj4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50wqDCoMKgwqBw
aW5uZWQ6MTvCoMKgwqDCoMKgwqDCoC8qIFdoZXRoZXIgdGhpcyBkZXYgaXMgcGlubmVkICovCj4g
K8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50wqDCoMKgwqBpbW1fcmVhZHk6MTvCoMKgwqDCoC8q
IFN1cHBvcnRzIEltbWVkaWF0ZSBSZWFkaW5lc3MgKi8KPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWdu
ZWQgaW50wqDCoMKgwqBkMV9zdXBwb3J0OjE7wqDCoMKgLyogTG93IHBvd2VyIHN0YXRlIEQxIGlz
IHN1cHBvcnRlZCAqLwo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnTCoMKgwqDCoGQyX3N1
cHBvcnQ6MTvCoMKgwqAvKiBMb3cgcG93ZXIgc3RhdGUgRDIgaXMgc3VwcG9ydGVkICovCj4gwqDC
oMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludMKgwqDCoMKgbm9fZDFkMjoxO8KgwqDCoMKgwqDCoC8q
IEQxIGFuZCBEMiBhcmUgZm9yYmlkZGVuICovCgo=


