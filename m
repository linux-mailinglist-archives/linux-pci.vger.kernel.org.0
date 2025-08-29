Return-Path: <linux-pci+bounces-35081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F2AB3B3AD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 08:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858BE5823CE
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 06:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7BD25F79A;
	Fri, 29 Aug 2025 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DlQmDITM"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22156226CF7
	for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2025 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450400; cv=none; b=Bqjxa4gbIonKnmLq/tHyebCmebe2kx+3E1A+24uqRT7lH7ByfMuA5qfVSSHTYV9EMidFP3IqdeS00Pjw2wkesMHFxMQi016/JQXLMDAwkod1cmucJcIG+jP6DQjeI5tgkk69H6Dc2sOtOJa2ibk6aPtHf4+x0/2aG1o1MRO2JmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450400; c=relaxed/simple;
	bh=elng48DCS0kijsHqDTYOFsPf4nf3s8PyUxdwfHrSP1o=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=mc7gvAQMZHDKW5BD6BIiENtsDiHIET/uH2hmrhQCcsmQhirVDgxCwM0EwnLSWbhiNO/HLtP/QlAPmjFVCcBWIu1ErLrlLl3XRbtNX1Oo2ObpEYVk4XvEi1LRFsp8AnfJhsEDHssss/YRqCx4kfUdtjammdhSF/RmNT8WiK0Lhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DlQmDITM; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756450386; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=elng48DCS0kijsHqDTYOFsPf4nf3s8PyUxdwfHrSP1o=;
	b=DlQmDITMFR9BVgp5Sdsx+apVd+ptoMv6nwrL3SfESekQQwce4NTASDH7RH0vMMZbk4hoBqGZtpAuqkqts7WMUP6WraRNiy7bz/dqSdAlmoSfRJhl77oJIoRo9nIHvB3FbGma4ZK45vBG0AlcsB2ENJFJOES4Aw1yuQbuAGKTwbo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033018103103;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DW;RN=4;SR=0;TI=W4_0.2.3_v5ForWebDing_211777F2_1756450386085_o7001c107u;
Received: from WS-web (guanghuifeng@linux.alibaba.com[W4_0.2.3_v5ForWebDing_211777F2_1756450386085_o7001c107u] cluster:ay36) at Fri, 29 Aug 2025 14:53:06 +0800
Date: Fri, 29 Aug 2025 14:53:06 +0800
From: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
To: "Lukas Wunner" <lukas@wunner.de>
Cc: "bhelgaas" <bhelgaas@google.com>,
  "alikernel-developer" <alikernel-developer@linux.alibaba.com>,
  "linux-pci" <linux-pci@vger.kernel.org>
Reply-To: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Message-ID: <aea17a04-f516-46c2-9689-2e0863d70453.guanghuifeng@linux.alibaba.com>
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
References: <20250818040641.3848174-1-guanghuifeng@linux.alibaba.com>,<aKLI-qrOpvkbJTwx@wunner.de>,<60d7bd98-8644-4bd0-ae73-d56f537914ec.guanghuifeng@linux.alibaba.com>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_sgcTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NDsgcnY6MTQyLjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvMTQyLjA=2N
In-Reply-To: <60d7bd98-8644-4bd0-ae73-d56f537914ec.guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

RG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIGZvciB0aGlzIG1vZGlmaWNhdGlvbj8KClRoYW5r
cwotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KRnJvbTpndWFuZ2h1aS5mZ2ggPGd1YW5naHVpZmVuZ0BsaW51eC5hbGliYWJh
LmNvbT4KU2VuZCBUaW1lOjIwMjUgQXVnLiAxOSAoVHVlLikgMTU6MDkKVG86THVrYXMgV3VubmVy
PGx1a2FzQHd1bm5lci5kZT4KQ0M6YmhlbGdhYXM8YmhlbGdhYXNAZ29vZ2xlLmNvbT47ICJhbGlr
ZXJuZWwtZGV2ZWxvcGVyIjxhbGlrZXJuZWwtZGV2ZWxvcGVyQGxpbnV4LmFsaWJhYmEuY29tPjsg
ImxpbnV4LXBjaSI8bGludXgtcGNpQHZnZXIua2VybmVsLm9yZz4KU3ViamVjdDpSZTogW1BBVENI
XSBbUkZDXSBQQ0k6IGZpeCBwY2llIHNlY29uZGFyeSBidXMgcmVzZXQgcmVhZGluZXNzIGNoZWNr
CgoKV2hlbiBwYXNzaW5nIHRocm91Z2ggbXVsdGlwbGUgZGV2aWNlcyBhdHRhY2hlZCB0byBQQ0ll
IHN3aXRjaCBkb3duc3RyZWFtIHBvcnQgdGhyb3VnaCB0aGUgdmZpbyBtb2R1bGUsCndlIGNhbiBp
bml0aWF0ZSBhIHNlY29uZGFyeSBidXMgcmVzZXQgKF9fcGNpX3Jlc2V0X2J1cyAtLS0gcGNpX2Jy
aWRnZV9zZWNvbmRhcnlfYnVzX3Jlc2V0KQp1c2luZyB0aGUgdmZpbyBWRklPX0RFVklDRV9QQ0lf
SE9UX1JFU0VUIGNhbGwuIEhvd2V2ZXIsIGl0J3MgY3J1Y2lhbCB0byBlbnN1cmUgdGhhdCBhbGwg
ZGV2aWNlcwpoYXZlIGNvbXBsZXRlZCByZXNldCBhbmQgaW5pdGlhbGl6YXRpb24gYmVmb3JlIHBj
aV9icmlkZ2Vfc2Vjb25kYXJ5X2J1c19yZXNldCByZXR1cm5zLiBPdGhlcndpc2UsCmRpcmVjdGx5
IGFjY2Vzc2luZyBhbiB1bnJlc2V0IGRldmljZSBjYW4gdHJpZ2dlciBhIGRldmljZSBlcnJvciBv
ciBldmVuIGNhdXNlIGl0IHRvIGdvIG9mZmxpbmUuCgpUaGVyZWZvcmUsIGl0J3MgbmVjZXNzYXJ5
IHRvIHdhaXQgZm9yIGFsbCBkZXZpY2VzIHRvIGNvbXBsZXRlIHJlc2V0IGluIHBjaV9icmlkZ2Vf
c2Vjb25kYXJ5X2J1c19yZXNldC4gCihUaGUgYWJvdmUgW1JGQ10gcGF0Y2ggYWxzbyByZXF1aXJl
cyBhZGp1c3RtZW50cyB0byBoYW5kbGUgc2l0dWF0aW9ucyBsaWtlIGxvbmctaGVsZCBsb2NrcyBh
bmQgdW5leHBlY3RlZCBkZXZpY2Ugb2ZmbGluZXMuKQoKVGhhbmtzCgoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkZyb206
THVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+ClNlbmQgVGltZToyMDI1IEF1Zy4gMTggKE1v
bi4pIDE0OjMyClRvOkd1YW5naHVpIEZlbmc8Z3VhbmdodWlmZW5nQGxpbnV4LmFsaWJhYmEuY29t
PgpDQzpiaGVsZ2FhczxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgImFsaWtlcm5lbC1kZXZlbG9wZXIi
PGFsaWtlcm5lbC1kZXZlbG9wZXJAbGludXguYWxpYmFiYS5jb20+OyAibGludXgtcGNpIjxsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnPgpTdWJqZWN0OlJlOiBbUEFUQ0hdIFtSRkNdIFBDSTogZml4
IHBjaWUgc2Vjb25kYXJ5IGJ1cyByZXNldCByZWFkaW5lc3MgY2hlY2sKCgpPbiBNb24sIEF1ZyAx
OCwgMjAyNSBhdCAxMjowNjo0MFBNICswODAwLCBHdWFuZ2h1aSBGZW5nIHdyb3RlOgo+IFdoZW4g
ZXhlY3V0aW5nIGEgc2Vjb25kYXJ5IGJ1cyByZXNldCBvbiBhIGJyaWRnZSBkb3duc3RyZWFtIHBv
cnQsIGFsbAo+IGRvd25zdHJlYW0gZGV2aWNlcyBhbmQgc3dpdGNoZXMgd2lsbCBiZSByZXNldGVk
LiBCZWZvcmUKPiBwY2lfYnJpZGdlX3NlY29uZGFyeV9idXNfcmVzZXQgcmV0dXJucywgZW5zdXJl
IHRoYXQgYWxsIGF2YWlsYWJsZQo+IGRldmljZXMgaGF2ZSBjb21wbGV0ZWQgcmVzZXQgYW5kIGlu
aXRpYWxpemF0aW9uLiBPdGhlcndpc2UsIHVzaW5nIGEKPiBkZXZpY2UgYmVmb3JlIGluaXRpYWxp
emF0aW9uIGNvbXBsZXRlZCB3aWxsIHJlc3VsdCBpbiBlcnJvcnMgb3IgZXZlbgo+IGRldmljZSBv
ZmZsaW5lLgoKSSByZWNlbnRseSByZWNlaXZlZCBhIHJlcG9ydCBvZmYtbGlzdCBmb3Igd2hhdCBs
b29rcyBsaWtlIHRoZSBzYW1lIGlzc3VlCmFuZCBjYW1lIHVwIHdpdGggdGhlIHBhdGNoIGJlbG93
LgoKV291bGQgaXQgZml4IHRoZSBpc3N1ZSBmb3IgeW91PwoKSXQncyBub3QgeWV0IGEgcHJvcGVy
bHkgZmxlc2hlZC1vdXQgcGF0Y2gsIGp1c3QgYSBwcm9vZiBvZiBjb25jZXB0LgpCdXQgaXQncyBz
bWFsbGVyIGFuZCBzaW1wbGVyIHRoYW4gdGhlIGFwcHJvYWNoIHlvdSd2ZSB0YWtlbi4KClRoaXMg
cGF0Y2ggaXMgZm9yIGEgU2Vjb25kYXJ5IEJ1cyBSZXNldCBpc3N1ZWQgYnkgQUVSLsKgIElzIHRo
ZSBidXMgcmVzZXQKbGlrZXdpc2UgaGFwcGVuaW5nIHRocm91Z2ggQUVSIGluIHlvdXIgY2FzZSBv
ciB3aGF0J3MgdGhlIGNvZGUgcGF0aApsZWFkaW5nIHRvIHRoZSBidXMgcmVzZXQ/CgotLSA+OCAt
LQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvcG9ydGRydi5jIGIvZHJpdmVycy9wY2kv
cGNpZS9wb3J0ZHJ2LmMKaW5kZXggZmE4M2ViZC4uOGI0MjdhOSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9wY2kvcGNpZS9wb3J0ZHJ2LmMKKysrIGIvZHJpdmVycy9wY2kvcGNpZS9wb3J0ZHJ2LmMKQEAg
LTc2MSw2ICs3NjEsMTAgQEAgc3RhdGljIHBjaV9lcnNfcmVzdWx0X3QgcGNpZV9wb3J0ZHJ2X3Ns
b3RfcmVzZXQoc3RydWN0IHBjaV9kZXYgKmRldikKIArCoCBwY2lfcmVzdG9yZV9zdGF0ZShkZXYp
OwrCoCBwY2lfc2F2ZV9zdGF0ZShkZXYpOworCisgaWYgKHBjaV9icmlkZ2Vfd2FpdF9mb3Jfc2Vj
b25kYXJ5X2J1cyhkZXYsICJob3QgcmVzZXQiKSkKK8KgIHJldHVybiBQQ0lfRVJTX1JFU1VMVF9E
SVNDT05ORUNUOworCsKgIHJldHVybiBQQ0lfRVJTX1JFU1VMVF9SRUNPVkVSRUQ7CiB9CiAKCgoK

