Return-Path: <linux-pci+bounces-8390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4966B8FE060
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 10:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0BAB24EB1
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D9313B28A;
	Thu,  6 Jun 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqbNN5sv"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E313BC23
	for <linux-pci@vger.kernel.org>; Thu,  6 Jun 2024 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660787; cv=none; b=C895qxB+M8eXj+PzN5WbbpFbbyhWBuE5eNfLMAg3cFJoaMWzAJVTMkNKSyhnJ0w8wYkkIgQcqz+K2maA0xSpc5DR0iLsc34OY/lNpi3dZqoXCEh+rhT+MSTdP3WLmzcAF/R9lM2eDm/fKOmgFhuNQdLyk6Ompm01OMARpe3cMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660787; c=relaxed/simple;
	bh=Mk/4fFk2IORAea27C9IdZ1tLJIMPn5C6VTpjLf6KOC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3onUSCufnS2/onTr+qfa+UbmBFq5bhk4Kd0/5eKERTs9KcTd8Wk1UkCSWPiDZG54Im5NaEKVGtTPS+xWzkM9NU0uMIedYp8eMXpFoCkTT1ZxUJ5m0BlKxwXKXECMeXgKzN5uEiSLlkUELuHSCOvaWF1IF6mwHU+ALcKrGsRHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqbNN5sv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717660785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mk/4fFk2IORAea27C9IdZ1tLJIMPn5C6VTpjLf6KOC8=;
	b=YqbNN5svTb0my8yRQ3h7RMYFa9QMNqB7KNcJK2sPp4S583YVMvN+PtQJ8/ez7JL3Z9BXjF
	yDGMMlxCKE8u7fIXZR6EPbnKyBtrV7t2Ioo6a7jJcitQ4Hhs8ISYZsyZw3HNJTcEvPRMh/
	yTu22LO1PRUqyu+VX/PcRqO0GL+2uSw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-4Dt1GjKXOc6dBJRM932c8w-1; Thu, 06 Jun 2024 03:59:43 -0400
X-MC-Unique: 4Dt1GjKXOc6dBJRM932c8w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421599b8911so1135025e9.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Jun 2024 00:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660782; x=1718265582;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mk/4fFk2IORAea27C9IdZ1tLJIMPn5C6VTpjLf6KOC8=;
        b=PqbJDgoe4Kf5vVTm8GLdbgOQDg08IpNSQnL2CoUxQTH6plp0TBObPSs+nPnHebBD1n
         0tQ7xXoHcrgl3U0Dv/qPWUYfHc5podEC+EaZNIqcEajGYqOBECksdcDlM0IdHCJLPH/F
         bcFAiZYlFRpGFzPgGbe82e8tei7aKlcBVRuvi5M74Wxv3thd6DH/CpH1koyzUx6hjpM+
         RmyztpmHqXY+bve9RrXe8XorGjLmPqfrgfagOMUjAZ7+0YmiQgJ5pHi9PZLMd1EEGNku
         8+cP0bF2wa4jhrKJ9lBsfQDPJkAv8sKZvFP0WzckYumiQfG0+XR4xNfHRZic6rVeoaRR
         +lAw==
X-Forwarded-Encrypted: i=1; AJvYcCV5/KNxYdj/q8yWgC2SDIUGfeIfPtVk6risI7248sPyCSOyj2B3KpMClRFV6fQDQjsheA9A3ZZwilPqz3ckSFCvuicak+4Y+rG+
X-Gm-Message-State: AOJu0YwC6PKusqbUPPdRb+x6ZAm5gxOFJp3+CgQP/nF0AhLbwkGKe/CD
	1lE0Rgm2I1umlhvIA6Pmk8KLK87DOVD2cBy0qlYaDsEgVEq6qOvTpxKORjDpWyRhCClbxeLlonf
	ty+ifYO+/xXZEm0Y1qm2rLDkQmhbEa/UN+pLTUDIBFuPbSUlHMaq4rzrRgQAI5Wl9/w==
X-Received: by 2002:a05:600c:3550:b0:419:f4d6:5044 with SMTP id 5b1f17b1804b1-4215633e751mr35821885e9.2.1717660782338;
        Thu, 06 Jun 2024 00:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGUivM8mTO4gESausagxMuauIee1AR3Fy2H3uz4r7VZZRJPl8dNT+bxzFFZ+Bi3JsZ54tp9Q==
X-Received: by 2002:a05:600c:3550:b0:419:f4d6:5044 with SMTP id 5b1f17b1804b1-4215633e751mr35821745e9.2.1717660781967;
        Thu, 06 Jun 2024 00:59:41 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2a6225sm12525895e9.25.2024.06.06.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:59:41 -0700 (PDT)
Message-ID: <3ba34cca64c5146c954f1395b3e20215afc255ec.camel@redhat.com>
Subject: Re: [PATCH v7 07/13] PCI: Move dev-enabled status bit to struct
 pci_dev
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Thu, 06 Jun 2024 09:59:40 +0200
In-Reply-To: <20240605211111.GA779780@bhelgaas>
References: <20240605211111.GA779780@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTA2LTA1IGF0IDE2OjExIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+
IE9uIFdlZCwgSnVuIDA1LCAyMDI0IGF0IDEwOjE1OjU5QU0gKzAyMDAsIFBoaWxpcHAgU3Rhbm5l
ciB3cm90ZToKPiA+IFRoZSBiaXQgZGVzY3JpYmluZyB3aGV0aGVyIHRoZSBQQ0kgZGV2aWNlIGlz
IGN1cnJlbnRseSBlbmFibGVkIGlzCj4gPiBzdG9yZWQKPiA+IGluIHN0cnVjdCBwY2lfZGV2cmVz
LiBCZXNpZGVzIHRoaXMgc3RydWN0IGJlaW5nIHN1YmplY3Qgb2YgYQo+ID4gY2xlYW51cAo+ID4g
cHJvY2Vzcywgc3RydWN0IHBjaV9kZXZpY2UgaXMgaW4gZ2VuZXJhbCB0aGUgcmlnaHQgcGxhY2Ug
dG8gc3RvcmUKPiA+IHRoaXMKPiA+IGluZm9ybWF0aW9uLCBzaW5jZSBpdCBpcyBub3QgZGV2cmVz
LXNwZWNpZmljLgo+ID4gCj4gPiBNb3ZlIHRoZSAnZW5hYmxlZCcgYm9vbGVhbiBiaXQgdG8gc3Ry
dWN0IHBjaV9kZXYuCj4gCj4gSSB0aGluayB0aGlzIChhbmQgdGhlIHNpbWlsYXIgJ3Bpbm5lZCcg
cGF0Y2gpIGFwcGVhcmVkIGluIHY2LgoKWWVzLiBUaGlzIHBhdGNoIGFuZCBpdHMgYnJvdGhlcnMg
c2VydmUgdG8gcmVtb3ZlIG1lbWJlcnMgZnJvbQpzdHJ1Y3QgcGNpX2RldnJlcyBzdGVwIGJ5IHN0
ZXAsIHNvIGl0IGNhbiB1bHRpbWF0ZWx5IGJlIHJlbW92ZWQsIHNvCnRoYXQgd2Ugd29uJ3QgaGF2
ZSBhIGdlbmVyaWMgZGV2cmVzIHN0cnVjdCBhbnltb3JlLCBidXQgYWN0dWFsCnJlc291cmNlLXNw
ZWNpZmljIHN0cnVjdHMuCgo+IAo+IEl0IHNvdW5kcyBwbGF1c2libGUgdG8gaGF2ZSB0aGlzIGlu
IHN0cnVjdCBwY2lfZGV2LCBidXQgaXQncwo+IGNvbmZ1c2luZwo+IHRvIGhhdmUgYm90aDoKPiAK
PiDCoCBwY2lfZGV2LmVuYWJsZWQKPiDCoCBwY2lfZGV2LmVuYWJsZV9jbnQsIHVzZWQgYnkgcGNp
X2lzX2VuYWJsZWQoKQo+IAo+IEkgaGF2ZW4ndCBsb29rZWQgaGFyZCBlbm91Z2ggdG8gc2VlIHdo
ZXRoZXIgYm90aCBhcmUgcmVxdWlyZWQuwqAgSWYKPiB0aGV5IGFyZSwgSSB0aGluayB3ZSBzaG91
bGQgcmVuYW1lICJlbmFibGVkIiB0byBzb21ldGhpbmcgZGVzY3JpcHRpdmUKPiBlbm91Z2ggdG8g
bWFrZSBpdCBvYnZpb3VzbHkgZGlmZmVyZW50IGZyb20gImVuYWJsZV9jbnQiLgoKSSB0b29rIGEg
bG9vayBhdCBpdCBhbmQgSSB0aGluayB3ZSBjYW4gYWN0dWFsbHkgZHJvcCAiZW5hYmxlZCIgYW5k
IHVzZQoiZW5hYmxlX2NudCIgZm9yIGV2ZXJ5dGhpbmcuIFRoYXQgd291bGQgZXZlbiBzaW1wbGlm
eSB0aGluZ3MgbW9yZSwgSSdkCnNheS4KCkxldCBtZSBwcm92aWRlIHRoYXQgaW4gdjguCgoKUC4K
Cj4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwIFN0YW5uZXIgPHBzdGFubmVyQHJlZGhhdC5j
b20+Cj4gPiAtLS0KPiA+IMKgZHJpdmVycy9wY2kvZGV2cmVzLmMgfCAxMSArKysrLS0tLS0tLQo+
ID4gwqBkcml2ZXJzL3BjaS9wY2kuY8KgwqDCoCB8IDE3ICsrKysrKysrKystLS0tLS0tCj4gPiDC
oGRyaXZlcnMvcGNpL3BjaS5owqDCoMKgIHzCoCAxIC0KPiA+IMKgaW5jbHVkZS9saW51eC9wY2ku
aMKgIHzCoCAxICsKPiA+IMKgNCBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNSBk
ZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2RldnJlcy5jIGIv
ZHJpdmVycy9wY2kvZGV2cmVzLmMKPiA+IGluZGV4IDU3MmE0ZTE5Mzg3OS4uZWE1OTBjYWY4OTk1
IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9wY2kvZGV2cmVzLmMKPiA+ICsrKyBiL2RyaXZlcnMv
cGNpL2RldnJlcy5jCj4gPiBAQCAtMzk4LDcgKzM5OCw3IEBAIHN0YXRpYyB2b2lkIHBjaW1fcmVs
ZWFzZShzdHJ1Y3QgZGV2aWNlICpnZW5kZXYsCj4gPiB2b2lkICpyZXMpCj4gPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKHRoaXMtPnJlc3RvcmVfaW50eCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcGNpX2ludHgoZGV2LCB0aGlzLT5vcmlnX2ludHgpOwo+ID4gwqAKPiA+IC3CoMKg
wqDCoMKgwqDCoGlmICh0aGlzLT5lbmFibGVkICYmICF0aGlzLT5waW5uZWQpCj4gPiArwqDCoMKg
wqDCoMKgwqBpZiAoIXRoaXMtPnBpbm5lZCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcGNpX2Rpc2FibGVfZGV2aWNlKGRldik7Cj4gPiDCoH0KPiA+IMKgCj4gPiBAQCAtNDQx
LDE0ICs0NDEsMTEgQEAgaW50IHBjaW1fZW5hYmxlX2RldmljZShzdHJ1Y3QgcGNpX2RldiAqcGRl
dikKPiA+IMKgwqDCoMKgwqDCoMKgwqBkciA9IGdldF9wY2lfZHIocGRldik7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgaWYgKHVubGlrZWx5KCFkcikpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAtRU5PTUVNOwo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKGRyLT5lbmFibGVk
KQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ID4gwqAKPiA+
IMKgwqDCoMKgwqDCoMKgwqByYyA9IHBjaV9lbmFibGVfZGV2aWNlKHBkZXYpOwo+ID4gLcKgwqDC
oMKgwqDCoMKgaWYgKCFyYykgewo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKCFyYykKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGRldi0+aXNfbWFuYWdlZCA9IDE7Cj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHItPmVuYWJsZWQgPSAxOwo+ID4gLcKgwqDCoMKg
wqDCoMKgfQo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByYzsKPiA+IMKgfQo+ID4g
wqBFWFBPUlRfU1lNQk9MKHBjaW1fZW5hYmxlX2RldmljZSk7Cj4gPiBAQCAtNDY2LDcgKzQ2Myw3
IEBAIHZvaWQgcGNpbV9waW5fZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+ID4gwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCBwY2lfZGV2cmVzICpkcjsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDC
oMKgZHIgPSBmaW5kX3BjaV9kcihwZGV2KTsKPiA+IC3CoMKgwqDCoMKgwqDCoFdBUk5fT04oIWRy
IHx8ICFkci0+ZW5hYmxlZCk7Cj4gPiArwqDCoMKgwqDCoMKgwqBXQVJOX09OKCFkciB8fCAhcGRl
di0+ZW5hYmxlZCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGRyKQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBkci0+cGlubmVkID0gMTsKPiA+IMKgfQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGNpL3BjaS5jIGIvZHJpdmVycy9wY2kvcGNpLmMKPiA+IGluZGV4IDhkZDcx
MWI5YTI5MS4uMDRhY2NkZmFiN2NlIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9wY2kvcGNpLmMK
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaS5jCj4gPiBAQCAtMjAxMSw2ICsyMDExLDkgQEAgc3Rh
dGljIGludCBkb19wY2lfZW5hYmxlX2RldmljZShzdHJ1Y3QKPiA+IHBjaV9kZXYgKmRldiwgaW50
IGJhcnMpCj4gPiDCoMKgwqDCoMKgwqDCoMKgdTE2IGNtZDsKPiA+IMKgwqDCoMKgwqDCoMKgwqB1
OCBwaW47Cj4gPiDCoAo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGRldi0+ZW5hYmxlZCkKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+ICsKPiA+IMKgwqDCoMKg
wqDCoMKgwqBlcnIgPSBwY2lfc2V0X3Bvd2VyX3N0YXRlKGRldiwgUENJX0QwKTsKPiA+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoZXJyIDwgMCAmJiBlcnIgIT0gLUVJTykKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGVycjsKPiA+IEBAIC0yMDI1LDcgKzIwMjgsNyBAQCBz
dGF0aWMgaW50IGRvX3BjaV9lbmFibGVfZGV2aWNlKHN0cnVjdAo+ID4gcGNpX2RldiAqZGV2LCBp
bnQgYmFycykKPiA+IMKgwqDCoMKgwqDCoMKgwqBwY2lfZml4dXBfZGV2aWNlKHBjaV9maXh1cF9l
bmFibGUsIGRldik7Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChkZXYtPm1zaV9lbmFi
bGVkIHx8IGRldi0+bXNpeF9lbmFibGVkKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiAwOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gc3Vj
Y2Vzc19vdXQ7Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoHBjaV9yZWFkX2NvbmZpZ19ieXRl
KGRldiwgUENJX0lOVEVSUlVQVF9QSU4sICZwaW4pOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChw
aW4pIHsKPiA+IEBAIC0yMDM1LDYgKzIwMzgsOCBAQCBzdGF0aWMgaW50IGRvX3BjaV9lbmFibGVf
ZGV2aWNlKHN0cnVjdAo+ID4gcGNpX2RldiAqZGV2LCBpbnQgYmFycykKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbWQgJgo+ID4gflBDSV9DT01NQU5EX0lOVFhfRElTQUJM
RSk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gwqAKPiA+ICtzdWNjZXNzX291dDoKPiA+ICvC
oMKgwqDCoMKgwqDCoGRldi0+ZW5hYmxlZCA9IHRydWU7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIDA7Cj4gPiDCoH0KPiA+IMKgCj4gPiBAQCAtMjE5Myw2ICsyMTk4LDkgQEAgc3RhdGljIHZv
aWQgZG9fcGNpX2Rpc2FibGVfZGV2aWNlKHN0cnVjdAo+ID4gcGNpX2RldiAqZGV2KQo+ID4gwqB7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdTE2IHBjaV9jb21tYW5kOwo+ID4gwqAKPiA+ICvCoMKgwqDC
oMKgwqDCoGlmICghZGV2LT5lbmFibGVkKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybjsKPiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKgwqBwY2lfcmVhZF9jb25maWdfd29y
ZChkZXYsIFBDSV9DT01NQU5ELCAmcGNpX2NvbW1hbmQpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGlm
IChwY2lfY29tbWFuZCAmIFBDSV9DT01NQU5EX01BU1RFUikgewo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBwY2lfY29tbWFuZCAmPSB+UENJX0NPTU1BTkRfTUFTVEVSOwo+ID4g
QEAgLTIyMDAsNiArMjIwOCw3IEBAIHN0YXRpYyB2b2lkIGRvX3BjaV9kaXNhYmxlX2RldmljZShz
dHJ1Y3QKPiA+IHBjaV9kZXYgKmRldikKPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoAo+ID4g
wqDCoMKgwqDCoMKgwqDCoHBjaWJpb3NfZGlzYWJsZV9kZXZpY2UoZGV2KTsKPiA+ICvCoMKgwqDC
oMKgwqDCoGRldi0+ZW5hYmxlZCA9IGZhbHNlOwo+ID4gwqB9Cj4gPiDCoAo+ID4gwqAvKioKPiA+
IEBAIC0yMjI3LDEyICsyMjM2LDYgQEAgdm9pZCBwY2lfZGlzYWJsZV9lbmFibGVkX2RldmljZShz
dHJ1Y3QKPiA+IHBjaV9kZXYgKmRldikKPiA+IMKgICovCj4gPiDCoHZvaWQgcGNpX2Rpc2FibGVf
ZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpkZXYpCj4gPiDCoHsKPiA+IC3CoMKgwqDCoMKgwqDCoHN0
cnVjdCBwY2lfZGV2cmVzICpkcjsKPiA+IC0KPiA+IC3CoMKgwqDCoMKgwqDCoGRyID0gZmluZF9w
Y2lfZHIoZGV2KTsKPiA+IC3CoMKgwqDCoMKgwqDCoGlmIChkcikKPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBkci0+ZW5hYmxlZCA9IDA7Cj4gPiAtCj4gPiDCoMKgwqDCoMKgwqDC
oMKgZGV2X1dBUk5fT05DRSgmZGV2LT5kZXYsIGF0b21pY19yZWFkKCZkZXYtPmVuYWJsZV9jbnQp
IDw9Cj4gPiAwLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJkaXNhYmxpbmcgYWxyZWFkeS1kaXNhYmxlZCBkZXZpY2UiKTsKPiA+IMKgCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvcGNpLmggYi9kcml2ZXJzL3BjaS9wY2kuaAo+ID4gaW5kZXggOWZk
NTBiYzk5ZTZiLi5lMjIzZTBmN2RhZGEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9wY2ku
aAo+ID4gKysrIGIvZHJpdmVycy9wY2kvcGNpLmgKPiA+IEBAIC04MjMsNyArODIzLDYgQEAgc3Rh
dGljIGlubGluZSBwY2lfcG93ZXJfdAo+ID4gbWlkX3BjaV9nZXRfcG93ZXJfc3RhdGUoc3RydWN0
IHBjaV9kZXYgKnBkZXYpCj4gPiDCoCAqIHRoZW4gcmVtb3ZlIHRoZW0gZnJvbSBoZXJlLgo+ID4g
wqAgKi8KPiA+IMKgc3RydWN0IHBjaV9kZXZyZXMgewo+ID4gLcKgwqDCoMKgwqDCoMKgdW5zaWdu
ZWQgaW50IGVuYWJsZWQ6MTsKPiA+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgcGlubmVk
OjE7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IG9yaWdfaW50eDoxOwo+ID4gwqDC
oMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCByZXN0b3JlX2ludHg6MTsKPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3BjaS5oIGIvaW5jbHVkZS9saW51eC9wY2kuaAo+ID4gaW5kZXggMTY0
OTM0MjZhMDRmLi4xMTA1NDhmMDBiM2IgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3Bj
aS5oCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3BjaS5oCj4gPiBAQCAtMzY3LDYgKzM2Nyw3IEBA
IHN0cnVjdCBwY2lfZGV2IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aGlzIGlz
IEQwLUQzLCBEMCBiZWluZwo+ID4gZnVsbHkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmdW5jdGlvbmFsLCBhbmQgRDMgYmVpbmcKPiA+IG9mZi4gKi8KPiA+IMKgwqDCoMKgwqDCoMKg
wqB1OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwbV9jYXA7wqDCoMKgwqDCoMKgwqDCoMKg
LyogUE0gY2FwYWJpbGl0eSBvZmZzZXQgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGlu
dMKgwqDCoMKgZW5hYmxlZDoxO8KgwqDCoMKgwqDCoC8qIFdoZXRoZXIgdGhpcyBkZXYgaXMKPiA+
IGVuYWJsZWQgKi8KPiA+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnTCoMKgwqDCoGltbV9y
ZWFkeToxO8KgwqDCoMKgLyogU3VwcG9ydHMgSW1tZWRpYXRlCj4gPiBSZWFkaW5lc3MgKi8KPiA+
IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnTCoMKgwqDCoHBtZV9zdXBwb3J0OjU7wqDCoC8q
IEJpdG1hc2sgb2Ygc3RhdGVzIGZyb20KPiA+IHdoaWNoIFBNRSMKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjYW4gYmUgZ2VuZXJhdGVkICovCj4gPiAtLSAKPiA+IDIuNDUuMAo+ID4g
Cj4gCgo=


