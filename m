Return-Path: <linux-pci+bounces-9119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B99134A2
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 17:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDACD284000
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3D154BE7;
	Sat, 22 Jun 2024 15:06:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out198-23.us.a.mail.aliyun.com (out198-23.us.a.mail.aliyun.com [47.90.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7C1E485;
	Sat, 22 Jun 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719068798; cv=none; b=eczqnOSMX/w6INnjKRjK6xjK3uDHXUSDBf7RYoffN0+ENOqTGSWALpPSaoLVleyCpSOeH8f2J7N38MGzQKMSpDz1/r0/c4PbKrmmbJIBHnFj2iDsF03fHa3jzfFAi6ItgdR+9JE3O7JW7iamsttwQfo2psj0LUuNJDW3Zn42Seo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719068798; c=relaxed/simple;
	bh=5L6y9idhEpNsN68qMiG/VdseGq/1D+5+vSNa8y9qbvk=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=XhAXXt2rz5331315CbCchWTuFZ7CMfFlhnmemFhB0EhAnKdprYm8hzhsXduYKIh049qLD2BJt6LmJPzsx45PsK5ZzKgX3JcB7n4T5ezhd/TTD4xksc1D4i6tnuQf9hnBY1y61jYqgLW0ufHZkF44czwqmAdjEvK3MXXraoPv3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=47.90.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09427714|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0736766-0.000805794-0.925518;FP=0|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040120151;MF=zhoushengqing@ttyinfo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Y7hfDjz_1719068777;
Received: from zhoushengqing(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.Y7hfDjz_1719068777)
          by smtp.aliyun-inc.com;
          Sat, 22 Jun 2024 23:06:18 +0800
Date: Sat, 22 Jun 2024 23:06:18 +0800
From: "zhoushengqing@ttyinfo.com" <zhoushengqing@ttyinfo.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	zhoushengqing <zhoushengqing@ttyinfo.com>
Subject: Re: Re: [PATCH] PCI: Enable io space 1k granularity for intel cpu root port
References: <20240621210207.GA1405708@bhelgaas>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.23.121[cn]
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <2024062223061743562815@ttyinfo.com>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Pj4gVGhpcyBwYXRjaCBhZGQgMWsgZ3JhbnVsYXJpdHkgZm9yIGludGVsIHJvb3QgcG9ydCBicmlk
Z2UuSW50ZWwgbGF0ZXN0CgoKCj4+IHNlcnZlciBDUFUgc3VwcG9ydCAxSyBncmFudWxhcml0eSxB
bmQgdGhlcmUgaXMgYW4gQklPUyBzZXR1cCBpdGVtIG5hbWVkCgoKCj4+ICJFTjFLIixidXQgbGlu
dXggZG9lc24ndCBzdXBwb3J0IGl0LiBpZiBhbiBJSU8gaGFzIDUgSU9VIChTUFIgaGFzIDUgSU9V
cykKCgoKPj4gYWxsIGFyZSBiaWZ1cmNhdGVkIDJ4OC5JbiBhIDJQIHNlcnZlciBzeXN0ZW0sVGhl
cmUgYXJlIDIwIFAyUCBicmlkZ2VzCgoKCj4+IHByZXNlbnQuaWYga2VlcCA0SyBncmFudWxhcml0
eSBhbGxvY2F0aW9uLGl0IG5lZWQgMjAqND04MGsgaW8gc3BhY2UsCgoKCj4+IGV4Y2VlZGluZyA2
NGsuSSB0ZXN0IGl0IGluIGEgMTYqbnZpZGlhIDQwOTBzIHN5c3RlbSB1bmRlciBpbnRlbCBlYWds
ZXN0cmVtCgoKCj4+IHBsYXRmb3JtLlRoZXJlIGFyZSBzaXggNDA5MHMgdGhhdCBjYW5ub3QgYmUg
YWxsb2NhdGVkIEkvTyByZXNvdXJjZXMuCgoKCj4+IFNvIEkgYXBwbGllZCB0aGlzIHBhdGNoLkFu
ZCBJIGZvdW5kIGEgc2ltaWxhciBpbXBsZW1lbnRhdGlvbiBpbiBxdWlya3MuYywKCgoKPj4gYnV0
IGl0IG9ubHkgdGFyZ2V0cyB0aGUgSW50ZWwgUDY0SDIgcGxhdGZvcm0uCgoKCj4+CgoKCj4+IFNp
Z25lZC1vZmYtYnk6IFpob3UgU2hlbmdxaW5nIDx6aG91c2hlbmdxaW5nQHR0eWluZm8uY29tPgoK
Cgo+PiAtLS0KCgoKPj7CoCBkcml2ZXJzL3BjaS9wcm9iZS5jIHwgMjIgKysrKysrKysrKysrKysr
KysrKysrKwoKCgo+PsKgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCgoKCj4+CgoK
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wcm9iZS5jIGIvZHJpdmVycy9wY2kvcHJvYmUu
YwoKCgo+PiBpbmRleCA1ZmJhYmI0ZTM0MjUuLjNmMGM5MDFjNjY1MyAxMDA2NDQKCgoKPj4gLS0t
IGEvZHJpdmVycy9wY2kvcHJvYmUuYwoKCgo+PiArKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCgoK
Cj4+IEBAIC00NjEsNiArNDYxLDggQEAgc3RhdGljIHZvaWQgcGNpX3JlYWRfYnJpZGdlX3dpbmRv
d3Moc3RydWN0IHBjaV9kZXYgKmJyaWRnZSkKCgoKPj7CoCB1MzIgYnVzZXM7CgoKCj4+wqAgdTE2
IGlvOwoKCgo+PsKgIHUzMiBwbWVtLCB0bXA7CgoKCj4+ICsgdTE2IHZlbl9pZCwgZGV2X2lkOwoK
Cgo+PiArIHUxNiBlbjFrID0gMDsKCgoKPj7CoCBzdHJ1Y3QgcmVzb3VyY2UgcmVzOwoKCgo+PgoK
Cgo+PsKgIHBjaV9yZWFkX2NvbmZpZ19kd29yZChicmlkZ2UsIFBDSV9QUklNQVJZX0JVUywgJmJ1
c2VzKTsKCgoKPj4gQEAgLTQ3OCw2ICs0ODAsMjYgQEAgc3RhdGljIHZvaWQgcGNpX3JlYWRfYnJp
ZGdlX3dpbmRvd3Moc3RydWN0IHBjaV9kZXYgKmJyaWRnZSkKCgoKPj7CoCB9CgoKCj4+wqAgaWYg
KGlvKSB7CgoKCj4+wqAgYnJpZGdlLT5pb193aW5kb3cgPSAxOwoKCgo+PiArIGlmIChwY2lfaXNf
cm9vdF9idXMoYnJpZGdlLT5idXMpKSB7CgoKCj4+ICsgbGlzdF9mb3JfZWFjaF9lbnRyeShkZXYs
ICZicmlkZ2UtPmJ1cy0+ZGV2aWNlcywgYnVzX2xpc3QpIHsKCgoKPj4gKyBwY2lfcmVhZF9jb25m
aWdfd29yZChkZXYsIFBDSV9WRU5ET1JfSUQsICZ2ZW5faWQpOwoKCgo+PiArIHBjaV9yZWFkX2Nv
bmZpZ193b3JkKGRldiwgUENJX0RFVklDRV9JRCwgJmRldl9pZCk7CgoKCj4+ICsgaWYgKHZlbl9p
ZCA9PSBQQ0lfVkVORE9SX0lEX0lOVEVMICYmIGRldl9pZCA9PSAweDA5YTIpIHsKCgoKPj4gKyAv
KklJTyBNSVNDIENvbnRyb2wgb2Zmc2V0IDB4MWMwKi8KCgoKPj4gKyBwY2lfcmVhZF9jb25maWdf
d29yZChkZXYsIDB4MWMwLCAmZW4xayk7CgoKCj4+ICsgfQoKCgo+PiArIH0KCgoKPj4gKyAvKgoK
Cgo+PiArICpJbnRlbCBJQ1ggU1BSIEVNUiBHTlIKCgoKPj4gKyAqSUlPIE1JU0MgQ29udHJvbCAo
SUlPTUlTQ0NUUkxfMV81XzBfQ0ZHKSDigJQgT2Zmc2V0IDFDMGgKCgoKPj4gKyAqYml0IDI6RW5h
YmxlIDFLIChFTjFLKQoKCgo+PiArICpUaGlzIGJpdCB3aGVuIHNldCwgZW5hYmxlcyAxSyBncmFu
dWxhcml0eSBmb3IgSS9PIHNwYWNlIGRlY29kZQoKCgo+PiArICppbiBlYWNoIG9mIHRoZSB2aXJ0
dWFsIFAyUCBicmlkZ2VzCgoKCj4+ICsgKmNvcnJlc3BvbmRpbmcgdG8gcm9vdCBwb3J0cywgYW5k
IERNSSBwb3J0cy4KCgoKPj4gKyAqLwoKCgo+PiArIGlmIChlbjFrICYgMHg0KQoKCgo+PiArIGJy
aWRnZS0+aW9fd2luZG93XzFrID0gMTsKCgoKPj4gKyB9CgoKCj4KCgoKPkNhbiB5b3UgaW1wbGVt
ZW50IHRoaXMgYXMgYSBxdWlyayBzaW1pbGFyIHRvIHF1aXJrX3A2NGgyXzFrX2lvKCk/CgoKCj4K
CgoKPkkgZG9uJ3Qgd2FudCB0byBjbHV0dGVyIHRoZSBnZW5lcmljIGNvZGUgd2l0aCBkZXZpY2Ut
c3BlY2lmaWMgdGhpbmdzCgoKCj5saWtlIHRoaXMuCgoKCgpJIGhhdmUgYXR0ZW1wdGVkIHRvIGlt
cGxlbWVudCB0aGlzIHBhdGNoIGluIHF1aXJrcy5jLkJ1dCB0aGVyZSBkb2Vzbid0IHNlZW0KCgoK
dG8gYmUgYSBzdWl0YWJsZSBERUNMQVJFX1BDSV9GSVhVUCogdG8gZG8gdGhpcy5iZWNhdXNlIHRo
ZSBwYXRjaCBpcyBub3QgdGFyZ2V0aW5nCgoKCnRoZSBkZXZpY2UgaXRzZWxmLCBJdCB0YXJnZXRz
IG90aGVyIFAyUCBkZXZpY2VzIHdpdGggdGhlIHNhbWUgYnVzIG51bWJlci4KCgoKQW55IG90aGVy
IHN1Z2dlc3Rpb25zPyBUaGFua3MuCgoKPgoKCgo+PsKgIHBjaV9yZWFkX2JyaWRnZV9pbyhicmlk
Z2UsICZyZXMsIHRydWUpOwoKCgo+PsKgIH0KCgoKPj4KCgoKPj4gLS0KCgoKPj4gMi4zOS4yCgoK
Cj4+CgoKCj7CoAoKCgo+IC0tCgoKCj4gMi4zOS4yCgoKCj4KCgo=


