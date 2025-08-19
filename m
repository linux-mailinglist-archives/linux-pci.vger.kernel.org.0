Return-Path: <linux-pci+bounces-34245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E25B2BA35
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380DA4E6D15
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C0A1E1E00;
	Tue, 19 Aug 2025 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w0nr3Qld"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5E3451A7
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587360; cv=none; b=Y9YRt+ZJB3KzGFop1ZHZDKa3t3wAC25yW839t4OJYRm8r7D/UzuiZSWnxSc5O5cRcic3loO1CPnNjhC4+dMyy+/WQJ/Lpn//sRP9z89kYdYUMuUOuvQ44VBc77lcAgCUlPmk0xEaRgfUm1ouMBLQGRX/V5JNFUpx7dHPNOQY/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587360; c=relaxed/simple;
	bh=5D/nmJnJ1XA+AVF8bguPS+P5S2/TNu9to75f9J8fewI=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=V+Uun1tAVZTtpgQ9PQc6epw+jNi2MZkmI3vWC33/rAlyhsyi6P94zk1zhWhDVzabL5o5ESTv00uCYU5tlYZcFTx19gGuuY7j+QS7nwi6reFLdpmTf491qpYbam/bcCg3zKL6Wh6tA7y7iApgX1TlqovMW9uIK6Jjiw41lWb34mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w0nr3Qld; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755587347; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=5D/nmJnJ1XA+AVF8bguPS+P5S2/TNu9to75f9J8fewI=;
	b=w0nr3QldGvBESBm1jeL/yScCSmMpIlNO5f0aUDdj2hiOyxHV9WJgjR+/woxqCTg5faMe/HBONpvptyjZ09Tk102LQRoH5/SSTMbMx275Q8hKLspCgelT1f49Dg8YqnbF01NPjZHuFEatN290AHpCPXKjL3kEUBdKndHc6qSdzDg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037014023;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DW;RN=4;SR=0;TI=W4_0.2.3_v5ForWebDing_212537CB_1755587347343_o7001c1091;
Received: from WS-web (guanghuifeng@linux.alibaba.com[W4_0.2.3_v5ForWebDing_212537CB_1755587347343_o7001c1091] cluster:ay36) at Tue, 19 Aug 2025 15:09:07 +0800
Date: Tue, 19 Aug 2025 15:09:07 +0800
From: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
To: "Lukas Wunner" <lukas@wunner.de>
Cc: "bhelgaas" <bhelgaas@google.com>,
  "alikernel-developer" <alikernel-developer@linux.alibaba.com>,
  "linux-pci" <linux-pci@vger.kernel.org>
Reply-To: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Message-ID: <60d7bd98-8644-4bd0-ae73-d56f537914ec.guanghuifeng@linux.alibaba.com>
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
b25kYXJ5X2J1c19yZXNldC4gCihUaGUgYWJvdmUgW1JGQ10gcGF0Y2ggYWxzbyByZXF1aXJlcyBh
ZGp1c3RtZW50cyB0byBoYW5kbGUgc2l0dWF0aW9ucyBsaWtlIGxvbmctaGVsZCBsb2NrcyBhbmQg
dW5leHBlY3RlZCBkZXZpY2Ugb2ZmbGluZXMuKQoKVGhhbmtzCgoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkZyb206THVr
YXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+ClNlbmQgVGltZToyMDI1IEF1Zy4gMTggKE1vbi4p
IDE0OjMyClRvOkd1YW5naHVpIEZlbmc8Z3VhbmdodWlmZW5nQGxpbnV4LmFsaWJhYmEuY29tPgpD
QzpiaGVsZ2FhczxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgImFsaWtlcm5lbC1kZXZlbG9wZXIiPGFs
aWtlcm5lbC1kZXZlbG9wZXJAbGludXguYWxpYmFiYS5jb20+OyAibGludXgtcGNpIjxsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnPgpTdWJqZWN0OlJlOiBbUEFUQ0hdIFtSRkNdIFBDSTogZml4IHBj
aWUgc2Vjb25kYXJ5IGJ1cyByZXNldCByZWFkaW5lc3MgY2hlY2sKCgpPbiBNb24sIEF1ZyAxOCwg
MjAyNSBhdCAxMjowNjo0MFBNICswODAwLCBHdWFuZ2h1aSBGZW5nIHdyb3RlOgo+IFdoZW4gZXhl
Y3V0aW5nIGEgc2Vjb25kYXJ5IGJ1cyByZXNldCBvbiBhIGJyaWRnZSBkb3duc3RyZWFtIHBvcnQs
IGFsbAo+IGRvd25zdHJlYW0gZGV2aWNlcyBhbmQgc3dpdGNoZXMgd2lsbCBiZSByZXNldGVkLiBC
ZWZvcmUKPiBwY2lfYnJpZGdlX3NlY29uZGFyeV9idXNfcmVzZXQgcmV0dXJucywgZW5zdXJlIHRo
YXQgYWxsIGF2YWlsYWJsZQo+IGRldmljZXMgaGF2ZSBjb21wbGV0ZWQgcmVzZXQgYW5kIGluaXRp
YWxpemF0aW9uLiBPdGhlcndpc2UsIHVzaW5nIGEKPiBkZXZpY2UgYmVmb3JlIGluaXRpYWxpemF0
aW9uIGNvbXBsZXRlZCB3aWxsIHJlc3VsdCBpbiBlcnJvcnMgb3IgZXZlbgo+IGRldmljZSBvZmZs
aW5lLgoKSSByZWNlbnRseSByZWNlaXZlZCBhIHJlcG9ydCBvZmYtbGlzdCBmb3Igd2hhdCBsb29r
cyBsaWtlIHRoZSBzYW1lIGlzc3VlCmFuZCBjYW1lIHVwIHdpdGggdGhlIHBhdGNoIGJlbG93LgoK
V291bGQgaXQgZml4IHRoZSBpc3N1ZSBmb3IgeW91PwoKSXQncyBub3QgeWV0IGEgcHJvcGVybHkg
Zmxlc2hlZC1vdXQgcGF0Y2gsIGp1c3QgYSBwcm9vZiBvZiBjb25jZXB0LgpCdXQgaXQncyBzbWFs
bGVyIGFuZCBzaW1wbGVyIHRoYW4gdGhlIGFwcHJvYWNoIHlvdSd2ZSB0YWtlbi4KClRoaXMgcGF0
Y2ggaXMgZm9yIGEgU2Vjb25kYXJ5IEJ1cyBSZXNldCBpc3N1ZWQgYnkgQUVSLsKgIElzIHRoZSBi
dXMgcmVzZXQKbGlrZXdpc2UgaGFwcGVuaW5nIHRocm91Z2ggQUVSIGluIHlvdXIgY2FzZSBvciB3
aGF0J3MgdGhlIGNvZGUgcGF0aApsZWFkaW5nIHRvIHRoZSBidXMgcmVzZXQ/CgotLSA+OCAtLQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvcG9ydGRydi5jIGIvZHJpdmVycy9wY2kvcGNp
ZS9wb3J0ZHJ2LmMKaW5kZXggZmE4M2ViZC4uOGI0MjdhOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9w
Y2kvcGNpZS9wb3J0ZHJ2LmMKKysrIGIvZHJpdmVycy9wY2kvcGNpZS9wb3J0ZHJ2LmMKQEAgLTc2
MSw2ICs3NjEsMTAgQEAgc3RhdGljIHBjaV9lcnNfcmVzdWx0X3QgcGNpZV9wb3J0ZHJ2X3Nsb3Rf
cmVzZXQoc3RydWN0IHBjaV9kZXYgKmRldikKIArCoCBwY2lfcmVzdG9yZV9zdGF0ZShkZXYpOwrC
oCBwY2lfc2F2ZV9zdGF0ZShkZXYpOworCisgaWYgKHBjaV9icmlkZ2Vfd2FpdF9mb3Jfc2Vjb25k
YXJ5X2J1cyhkZXYsICJob3QgcmVzZXQiKSkKK8KgIHJldHVybiBQQ0lfRVJTX1JFU1VMVF9ESVND
T05ORUNUOworCsKgIHJldHVybiBQQ0lfRVJTX1JFU1VMVF9SRUNPVkVSRUQ7CiB9CiAKCgo=

