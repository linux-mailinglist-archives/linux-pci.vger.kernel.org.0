Return-Path: <linux-pci+bounces-34244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9037DB2BA0F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98F9168A3D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9744223D298;
	Tue, 19 Aug 2025 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AD4L/Ihq"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71264259CBC
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586870; cv=none; b=kq3UYelzYjULoU5bQLZFAfEcSjXEIe4M2NAE/qy7r0eStNswuB64ikMIuIL7qt6BQDNne8LpFb0N0n8zU9RoUqgHW2kCQejF4H+kWa0ZhjXJpatR5fWFgGldh5pneRwl2t4ZxjvS80uk+L/4+/hHIKsdUvhMb+uU+GdpTg60zqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586870; c=relaxed/simple;
	bh=AMy0d1mdp8JkyIGuiLbmzUnmob7U9eVpcdMxu5/Nqh4=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=IbU1ON0AKTONFwbzBYQ64CmkPzfNYK8tfWA/2rUnCDYhhyJjKBaNE89aLMV/L0VmxLftrAZFOYVGPiOVVRRS3n/7wbaf93KaJ44Bm36KqKdTG1pKUpyX3G7dPgCuNydXWTMKCYjXn2J6AurXtY6EqCquoJZJluAMk0kO5O1KDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AD4L/Ihq; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755586864; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=AMy0d1mdp8JkyIGuiLbmzUnmob7U9eVpcdMxu5/Nqh4=;
	b=AD4L/IhqK9KhNovL3bVtdLMF1gjMuYI50LSFauOs0BQX661DeyrcAVS1PFeMv04jkoKoLfJ1sJM7rkebX9IPe8bAlItUrZl/GMHeidN4ck6ztUfwZ6VliwNCS4t5HhamNg7u1P+Y03CN6uf1EMNT/9ur9EzgbB7kIGth/CPLvl0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023056217;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DW;RN=4;SR=0;TI=W4_0.2.3_v5ForWebDing_212510D9_1755586811554_o7001c3d;
Received: from WS-web (guanghuifeng@linux.alibaba.com[W4_0.2.3_v5ForWebDing_212510D9_1755586811554_o7001c3d] cluster:ay36) at Tue, 19 Aug 2025 15:01:03 +0800
Date: Tue, 19 Aug 2025 15:01:03 +0800
From: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
To: "Lukas Wunner" <lukas@wunner.de>
Cc: "bhelgaas" <bhelgaas@google.com>,
  "alikernel-developer" <alikernel-developer@linux.alibaba.com>,
  "linux-pci" <linux-pci@vger.kernel.org>
Disposition-Notification-To: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Reply-To: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Message-ID: <21dbe442-ace5-4556-9c86-7511949437fb.guanghuifeng@linux.alibaba.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gW1JGQ10gUENJOiBmaXggcGNpZSBzZWNvbmRhcnkgYnVzIHJlc2V0IHJl?=
  =?UTF-8?B?YWRpbmVzcyBjaGVjaw==?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Firefox]
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20250818040641.3848174-1-guanghuifeng@linux.alibaba.com>,<aKLI-qrOpvkbJTwx@wunner.de>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_sgcTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NDsgcnY6MTQxLjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvMTQxLjA=2N
In-Reply-To: <aKLI-qrOpvkbJTwx@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

V2hlbiBwYXNzaW5nIHRocm91Z2ggbXVsdGlwbGUgZGV2aWNlcyBhdHRhY2hlZCB0byBQQ0llIHN3
aXRjaCBkb3duc3RyZWFtIHBvcnQgdGhyb3VnaCB0aGUgdmZpbyBtb2R1bGUsCndlIGNhbiBpbml0
aWF0ZSBhIHNlY29uZGFyeSBidXMgcmVzZXQgKF9fcGNpX3Jlc2V0X2J1cyAtLS0gcGNpX2JyaWRn
ZV9zZWNvbmRhcnlfYnVzX3Jlc2V0KQp1c2luZyB0aGUgdmZpbyBWRklPX0RFVklDRV9QQ0lfSE9U
X1JFU0VUIGNhbGwuIEhvd2V2ZXIsIGl0J3MgY3J1Y2lhbCB0byBlbnN1cmUgdGhhdCBhbGwgZGV2
aWNlcwpoYXZlIGNvbXBsZXRlZCByZXNldCBhbmQgaW5pdGlhbGl6YXRpb24gYmVmb3JlIHBjaV9i
cmlkZ2Vfc2Vjb25kYXJ5X2J1c19yZXNldCByZXR1cm5zLiBPdGhlcndpc2UsCmRpcmVjdGx5IGFj
Y2Vzc2luZyBhbiB1bnJlc2V0IGRldmljZSBjYW4gdHJpZ2dlciBhIGRldmljZSBlcnJvciBvciBl
dmVuIGNhdXNlIGl0IHRvIGdvIG9mZmxpbmUuCgpUaGVyZWZvcmUsIGl0J3MgbmVjZXNzYXJ5IHRv
IHdhaXQgZm9yIGFsbCBkZXZpY2VzIHRvIGNvbXBsZXRlIHJlc2V0IGluIHBjaV9icmlkZ2Vfc2Vj
b25kYXJ5X2J1c19yZXNldC7CoAooVGhlIGFib3ZlIFtSRkNdIHBhdGNoIGFsc28gcmVxdWlyZXMg
YWRqdXN0bWVudHMgdG8gaGFuZGxlIHNpdHVhdGlvbnMgbGlrZSBsb25nLWhlbGQgbG9ja3MgYW5k
IHVuZXhwZWN0ZWQgZGV2aWNlIG9mZmxpbmVzLikKClRoYW5rcwoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkZyb206THVr
YXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+ClNlbmQgVGltZToyMDI15bm0OOaciDE45pelKOWR
qOS4gCkgMTQ6MzIKVG86R3VhbmdodWkgRmVuZzxndWFuZ2h1aWZlbmdAbGludXguYWxpYmFiYS5j
b20+CkNDOmJoZWxnYWFzPGJoZWxnYWFzQGdvb2dsZS5jb20+OyAiYWxpa2VybmVsLWRldmVsb3Bl
ciI8YWxpa2VybmVsLWRldmVsb3BlckBsaW51eC5hbGliYWJhLmNvbT47ICJsaW51eC1wY2kiPGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+ClN1YmplY3Q6UmU6IFtQQVRDSF0gW1JGQ10gUENJOiBm
aXggcGNpZSBzZWNvbmRhcnkgYnVzIHJlc2V0IHJlYWRpbmVzcyBjaGVjawoKCk9uIE1vbiwgQXVn
IDE4LCAyMDI1IGF0IDEyOjA2OjQwUE0gKzA4MDAsIEd1YW5naHVpIEZlbmcgd3JvdGU6Cj4gV2hl
biBleGVjdXRpbmcgYSBzZWNvbmRhcnkgYnVzIHJlc2V0IG9uIGEgYnJpZGdlIGRvd25zdHJlYW0g
cG9ydCwgYWxsCj4gZG93bnN0cmVhbSBkZXZpY2VzIGFuZCBzd2l0Y2hlcyB3aWxsIGJlIHJlc2V0
ZWQuIEJlZm9yZQo+IHBjaV9icmlkZ2Vfc2Vjb25kYXJ5X2J1c19yZXNldCByZXR1cm5zLCBlbnN1
cmUgdGhhdCBhbGwgYXZhaWxhYmxlCj4gZGV2aWNlcyBoYXZlIGNvbXBsZXRlZCByZXNldCBhbmQg
aW5pdGlhbGl6YXRpb24uIE90aGVyd2lzZSwgdXNpbmcgYQo+IGRldmljZSBiZWZvcmUgaW5pdGlh
bGl6YXRpb24gY29tcGxldGVkIHdpbGwgcmVzdWx0IGluIGVycm9ycyBvciBldmVuCj4gZGV2aWNl
IG9mZmxpbmUuCgpJIHJlY2VudGx5IHJlY2VpdmVkIGEgcmVwb3J0IG9mZi1saXN0IGZvciB3aGF0
IGxvb2tzIGxpa2UgdGhlIHNhbWUgaXNzdWUKYW5kIGNhbWUgdXAgd2l0aCB0aGUgcGF0Y2ggYmVs
b3cuCgpXb3VsZCBpdCBmaXggdGhlIGlzc3VlIGZvciB5b3U/CgpJdCdzIG5vdCB5ZXQgYSBwcm9w
ZXJseSBmbGVzaGVkLW91dCBwYXRjaCwganVzdCBhIHByb29mIG9mIGNvbmNlcHQuCkJ1dCBpdCdz
IHNtYWxsZXIgYW5kIHNpbXBsZXIgdGhhbiB0aGUgYXBwcm9hY2ggeW91J3ZlIHRha2VuLgoKVGhp
cyBwYXRjaCBpcyBmb3IgYSBTZWNvbmRhcnkgQnVzIFJlc2V0IGlzc3VlZCBieSBBRVIuwqAgSXMg
dGhlIGJ1cyByZXNldApsaWtld2lzZSBoYXBwZW5pbmcgdGhyb3VnaCBBRVIgaW4geW91ciBjYXNl
IG9yIHdoYXQncyB0aGUgY29kZSBwYXRoCmxlYWRpbmcgdG8gdGhlIGJ1cyByZXNldD8KCi0tID44
IC0tCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpZS9wb3J0ZHJ2LmMgYi9kcml2ZXJzL3Bj
aS9wY2llL3BvcnRkcnYuYwppbmRleCBmYTgzZWJkLi44YjQyN2E5IDEwMDY0NAotLS0gYS9kcml2
ZXJzL3BjaS9wY2llL3BvcnRkcnYuYworKysgYi9kcml2ZXJzL3BjaS9wY2llL3BvcnRkcnYuYwpA
QCAtNzYxLDYgKzc2MSwxMCBAQCBzdGF0aWMgcGNpX2Vyc19yZXN1bHRfdCBwY2llX3BvcnRkcnZf
c2xvdF9yZXNldChzdHJ1Y3QgcGNpX2RldiAqZGV2KQogCsKgIHBjaV9yZXN0b3JlX3N0YXRlKGRl
dik7CsKgIHBjaV9zYXZlX3N0YXRlKGRldik7CisKKyBpZiAocGNpX2JyaWRnZV93YWl0X2Zvcl9z
ZWNvbmRhcnlfYnVzKGRldiwgImhvdCByZXNldCIpKQorwqAgcmV0dXJuIFBDSV9FUlNfUkVTVUxU
X0RJU0NPTk5FQ1Q7CisKwqAgcmV0dXJuIFBDSV9FUlNfUkVTVUxUX1JFQ09WRVJFRDsKIH0KIAoK
Cg==

