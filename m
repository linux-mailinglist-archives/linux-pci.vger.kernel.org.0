Return-Path: <linux-pci+bounces-42012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA935C83735
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 07:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E86C3A9B23
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 06:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD850157487;
	Tue, 25 Nov 2025 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fGUwDsWn"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8EEAF9
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764051622; cv=none; b=F2vv0KI91P0VmgyyuBWNCczU2ChAsULi4u/N3RGR3Fekg20IL6AmoqFQ9KOuhM7OPHt3TxcEmcAkEMLDoXlwgHjjz9uLRht+Ka9q2AVsfAsKKM1Fx67z2HO6IDFp4CKnTwHE/j3uvOeNHwiS6vGBmZ96psSp7ABvMZ7UAFSnMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764051622; c=relaxed/simple;
	bh=vQ0cGnxhQndUjYvDk0Ojw+QXOKt4L69WlfcQPYxa/v4=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=nqOxo7ouIzqy7R7DKc8r2Rkt9kw3tb3oY77J0XcH5ufMyCaS0NsJ8f5DsFNBtkCXiRofwztiNCwmC/8SpZh4XEoOajKa/+34d5TAyYNHTM9CC32cBTmX0VUJ+EWAvgZmXk3QYlRz2uMw3luzz8P4OHTlto+9w46wWjCXc/1vgic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fGUwDsWn; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764051611; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=vQ0cGnxhQndUjYvDk0Ojw+QXOKt4L69WlfcQPYxa/v4=;
	b=fGUwDsWny2FJoB4pjNTWHvBznWzEyNxrTds3eBj9ITkWFRsD6GE2zaQzj4mMuPn1ULdgBtLJiB7IMj9uIVxL/9lT+0V4WzdDARqr+2pTGzlOANO7vZ+RjMKpLvEigkTmaiWT7glmNsDQr+lviIcCYhV/O6q8XgiFyMItvfhfGOk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DW;RN=5;SR=0;TI=W4_0.2.3_v5ForWebDing_21418606_1764051288404_o7001c184a;
Received: from WS-web (guanghuifeng@linux.alibaba.com[W4_0.2.3_v5ForWebDing_21418606_1764051288404_o7001c184a] cluster:ay36) at Tue, 25 Nov 2025 14:20:10 +0800
Date: Tue, 25 Nov 2025 14:20:10 +0800
From: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "bhelgaas" <bhelgaas@google.com>,
  "linux-pci" <linux-pci@vger.kernel.org>,
  "kanie" <kanie@linux.alibaba.com>,
  "alikernel-developer" <alikernel-developer@linux.alibaba.com>
Reply-To: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Message-ID: <a4a2a5ee-1f4e-4560-b8cf-c9c10ae475dd.guanghuifeng@linux.alibaba.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gUENJOiBGaXggUENJZSBTQlIgZGV2L2xpbmsgd2FpdCBlcnJvcg==?=
X-Mailer: [Alimail-Mailagent revision 372][W4_0.2.3][v5ForWebDing][Firefox]
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20251124104502.777141-1-guanghuifeng@linux.alibaba.com>,<20251124235858.GA2726643@bhelgaas>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_sgcTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NDsgcnY6MTQ1LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvMTQ1LjA=2N
In-Reply-To: <20251124235858.GA2726643@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

VGhhbmtzIGZvciB5b3VyIHJlc3BvbnNlLgoKMS4gV2hlbiBhIG11bHRpZnVuY3Rpb24gZGV2aWNl
IGlzIGNvbm5lY3RlZCB0byBhIFBDSWUgc2xvdCB0aGF0IHN1cHBvcnRzIGhvdHBsdWcsIAogICBk
dXJpbmcgdGhlIHBhc3N0aHJvZ2ggZGV2aWNlIHRvIGd1ZXN0IHByb2Nlc3MgYmFzZWQgb24gVkZJ
Tywgc29tZSBkZXZpY2VzCiAgIG5lZWQgdG8gcGVyZm9ybSBhIGhvdCByZXNldCB0byBpbml0aWFs
aXplIHRoZSBkZXZpY2U6CiAgIHZmaW9fcGNpX2Rldl9zZXRfaG90X3Jlc2V0IC0tLT4gX19wY2lf
cmVzZXRfc2xvdC9fX3BjaV9yZXNldF9idXMgLS0tPgogICBwY2lfYnJpZGdlX3NlY29uZGFyeV9i
dXNfcmVzZXQgLS0tPiBwY2lfYnJpZGdlX3dhaXRfZm9yX3NlY29uZGFyeV9idXMuCgogICBBZnRl
ciBfX3BjaV9yZXNldF9zbG90L19fcGNpX3Jlc2V0X2J1cyBjYWxscyBwY2lfYnJpZGdlX3dhaXRf
Zm9yX3NlY29uZGFyeV9idXMsCiAgIHRoZSBkZXZpY2Ugd2lsbCBiZSByZXN0b3JlZCB2aWEgcGNp
X2Rldl9yZXN0b3JlLiBIb3dldmVyLCB3aGVuIGEgbXVsdGlmdW5jdGlvbiBQQ0llIGRldmljZQog
ICBpcyBjb25uZWN0ZWQsIGV4ZWN1dGluZyBwY2lfYnJpZGdlX3dhaXRfZm9yX3NlY29uZGFyeV9i
dXMgb25seSBndWFyYW50ZWVzIHRoZSByZXN0b3JhdGlvbgogICBvZiBhIHJhbmRvbSBkZXZpY2Uu
IEZvciBvdGhlciBkZXZpY2VzIHRoYXQgYXJlIHN0aWxsIHJlc3RvcmluZywgZXhlY3V0aW5nIHBj
aV9kZXZfcmVzdG9yZSBjYW5ub3QKICAgcmVzdG9yZSB0aGUgZGV2aWNlIHN0YXRlIG5vcm1hbGx5
LCByZXN1bHRpbmcgaW4gZXJyb3JzIG9yIGV2ZW4gZGV2aWNlIG9mZmxpbmUuCgoyLiBJbiB0aGUg
UENJZSBkcGNfaGFuZGxlciBwcm9jZXNzLCBkbyBwY2llX2RvX3JlY292ZXJ5KHBkZXYsIHBjaV9j
aGFubmVsX2lvX2Zyb3plbiwgZHBjX3Jlc2V0X2xpbmspCiAgIHRvIHJlc3RvcmVzIHRoZSBQQ0ll
IGxpbmsuIAogICBCdXQgZHBjX3Jlc2V0X2xpbmsgd2FpdHMgZm9yIHRoZSBsaW5rIHRvIHJlY292
ZXIgdmlhIHBjaV9icmlkZ2Vfd2FpdF9mb3Jfc2Vjb25kYXJ5X2J1cyBiZWZvcmUgcmV0dXJuaW5n
LgogICBTaW1pbGFybHksIHBjaWVfZG9fcmVjb3ZlcnkgcmVzdG9yZXMgZGV2aWNlcyB2aWEgcGNp
X3dhbGtfYnJpZGdlKGJyaWRnZSwgcmVwb3J0X3Jlc3VtZSwgJnN0YXR1cyksCiAgIHdoaWNoIGFs
c28gcmVxdWlyZXMgcGNpX2JyaWRnZV93YWl0X2Zvcl9zZWNvbmRhcnlfYnVzIHRvIHdhaXQgZm9y
IGFsbCBkZXZpY2VzIHRvIHJlY292ZXIgY29tcGxldGVseS4KICAgRm9yIG90aGVyIGRldmljZXMg
dGhhdCBhcmUgc3RpbGwgcmVzdG9yaW5nLCBleGVjdXRpbmcgcmVwb3J0X3Jlc3VtZSBjYW5ub3Qg
cmVzdG9yZSB0aGUgZGV2aWNlIHN0YXRlIG5vcm1hbGx5LAogICByZXN1bHRpbmcgaW4gZXJyb3Jz
IG9yIGV2ZW4gZGV2aWNlIG9mZmxpbmUuCgpPbiBNb24sIE5vdiAyNCwgMjAyNSBhdCAwNjo0NTow
MlBNICswODAwLCBHdWFuZ2h1aSBGZW5nIHdyb3RlOgo+IFdoZW4gZXhlY3V0aW5nIGEgUENJZSBz
ZWNvbmRhcnkgYnVzIHJlc2V0LCBhbGwgZG93bnN0cmVhbSBzd2l0Y2hlcyBhbmQKPiBlbmRwb2lu
dHMgd2lsbCBnZW5lcmF0ZSByZXNldCBldmVudHMuIFNpbXVsdGFuZW91c2x5LCBhbGwgUENJZSBs
aW5rcwo+IHdpbGwgdW5kZXJnbyByZXRyYWluaW5nLCBhbmQgZWFjaCBsaW5rIHdpbGwgaW5kZXBl
bmRlbnRseSByZS1leGVjdXRlIHRoZQo+IExUU1NNIHN0YXRlIG1hY2hpbmUgdHJhaW5pbmcuIFRo
ZXJlZm9yZSwgYWZ0ZXIgZXhlY3V0aW5nIHRoZSBTQlIsIGl0IGlzCj4gbmVjZXNzYXJ5IHRvIHdh
aXQgZm9yIGFsbCBkb3duc3RyZWFtIGxpbmtzIGFuZCBkZXZpY2VzIHRvIGNvbXBsZXRlCj4gcmVj
b3ZlcnkuIE90aGVyd2lzZSwgYWZ0ZXIgdGhlIFNCUiByZXR1cm5zLCBhY2Nlc3NpbmcgZGV2aWNl
cyB3aXRoIHNvbWUKPiBsaW5rcyBvciBlbmRwb2ludHMgbm90IHlldCBmdWxseSByZWNvdmVyZWQg
bWF5IHJlc3VsdCBpbiBkcml2ZXIgZXJyb3JzLAo+IG9yIGV2ZW4gdHJpZ2dlciBkZXZpY2Ugb2Zm
bGluZSBpc3N1ZXMuCgpJIGd1ZXNzIHRoaXMgc29sdmVzIGEgcHJvYmxlbSB5b3UgaGF2ZSBvYnNl
cnZlZD8KCkFyZSB0aGVyZSBhbnkgc3BlY2lmaWMgZGV0YWlscyB5b3UgY2FuIHNoYXJlIHRoYXQg
d291bGQgaGVscAppbGx1c3RyYXRlIHRoZSBwcm9ibGVtP8KgIEUuZy4sIGNhc2VzIHdoZXJlIHdl
IGRvIGEgU2Vjb25kYXJ5IEJ1cwpSZXNldCwgdGhlbiBhY2Nlc3MgYSBkb3duc3RyZWFtIGRldmlj
ZSB0b28gZWFybHksIGFuZCBhbiBlcnJvcgpoYXBwZW5zPwoKQmpvcm4K

