Return-Path: <linux-pci+bounces-5716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B86898202
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 09:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4752F28B908
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A155A10F;
	Thu,  4 Apr 2024 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFNdt7be"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13F8612EC
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214923; cv=none; b=GHEM00UZYDcwvMv6kg4wV/G+oR8RcR6U2BDbVR7nEunS8YHWbiRpnU376HyWcI0cHFNe9bhsEWHzLTgA30x70X1ffETIKRTB+ZR8k8eOObXcHBVxJmK3LtHo7VO7w7tILlZR/0buVDVfO93q+qSg+2qFa43gx1uLt/Y2AbFbKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214923; c=relaxed/simple;
	bh=gkYBTBav5Zq+juoA2YijekuzHYoS9mPvuxnyh5mqC/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BuGOQf9pAr/bFn0pb/YWufrb5E/+G8mm8VKF5YRboKvlZ1G8HH2wsUfNTErgpQCJOubs4hpRY6G1E8ny/85uhFMUCBUik/Oe9yCYhAUyXFrKQ7d5F7tGSJ5shy+JfMqbUW3mnqAT0YcLUtN9I9FSdMyrwRNLuiEE9FkI3/9c7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFNdt7be; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712214920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkYBTBav5Zq+juoA2YijekuzHYoS9mPvuxnyh5mqC/Y=;
	b=FFNdt7beYwLTEb0fKgbhkgTkxMs9hjN7V1dMo9yozzKiAr2BEQBQZeePvMQbVHPL4HoCru
	EC2mkleelw5w/2nfLwEAHN3XyQiEomEEkszJA3urMbX7kNye5iVbsNynxHVBWSPWl3+/WF
	LkUQJFc4268JPba5gxBJzEXbYN3x1kg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-wbl8qoThMP2bq6NUz6Lm0g-1; Thu, 04 Apr 2024 03:15:19 -0400
X-MC-Unique: wbl8qoThMP2bq6NUz6Lm0g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4155db7b540so1538965e9.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2024 00:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214918; x=1712819718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkYBTBav5Zq+juoA2YijekuzHYoS9mPvuxnyh5mqC/Y=;
        b=RUaUo7XW45mZfS5wmveNgiLug3oP+iaJfbtPsg9bxKyv5RBrJcMcYOQFjL9s6hdCyZ
         gzuB5jPZz9duFQQ9SNdUKfSE0aQ6LkTLC+CTErmJvIBt+1XmoYKmcH4FVtTYUnoqXEo9
         Zcy9rux8gz/uE1J3KHFbO+kBYNOjTaTwBfnh3qdp341eV7l75103dMEYS1y0U+Iycn6n
         yhPSV8ecx+Bap4rhVvYCBmw+SBuRwMX1e4+Sx9on3gsFL6Xkw/z3JcnYw8Ha0SIbU1vQ
         AA3vv8Hgde/ycDorcfYDcUQuIr1eypkqpqAONhX26vTQsqSkhkHPjAIa7xFIqWiH7MSj
         MjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXouasrfjqf3Ulnq43cwMKT5JKf5SD3VZDnptnUHhtAByGQoO4tEaWsty4mBhKdKlbgwNXIIju6HortFKf50tLd+I6svAC7M0vg
X-Gm-Message-State: AOJu0Yz3DY+izzu1hEmPxPGPR9jqVpSpNGMiVqefFD+3Kpi9SlaRKL7G
	Vx92DwAsEXglmbLwGkR7afNXz8tlCQG7AAkbIbiod9jdobphNDHJJbeitXnuacD9CQN20RcUtZH
	eSJtXj09hFfqiOVVnb5BWsFxuUhM1dImJCul/y8JL7r8Bgneqx81Iu74iydbgtDIvrA==
X-Received: by 2002:a05:6000:1e84:b0:33e:c97c:a24 with SMTP id dd4-20020a0560001e8400b0033ec97c0a24mr1115591wrb.5.1712214918163;
        Thu, 04 Apr 2024 00:15:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWY9/cd1aqzBczEu4p4tIf7VmRWnNYN2GN8td9lcbGNfJha/rCCq4b4IGsGjcqLhKb+SmZaQ==
X-Received: by 2002:a05:6000:1e84:b0:33e:c97c:a24 with SMTP id dd4-20020a0560001e8400b0033ec97c0a24mr1115578wrb.5.1712214917730;
        Thu, 04 Apr 2024 00:15:17 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id c3-20020adfef43000000b003439d2a5f99sm3169981wrp.55.2024.04.04.00.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:15:17 -0700 (PDT)
Message-ID: <cd60599bee1b857ba069e25a8adb41ee2bc25699.camel@redhat.com>
Subject: Re: [PATCH v5 02/10] PCI: Deprecate iomap-table functions
From: Philipp Stanner <pstanner@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev, 
 Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <helgaas@kernel.org>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Date: Thu, 04 Apr 2024 09:15:16 +0200
In-Reply-To: <c59ff5c5-7551-41ca-a5cc-9c214051a20d@moroto.mountain>
References: <c59ff5c5-7551-41ca-a5cc-9c214051a20d@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8sCgpPbiBUaHUsIDIwMjQtMDQtMDQgYXQgMDk6MjkgKzAzMDAsIERhbiBDYXJwZW50ZXIg
d3JvdGU6Cj4gSGkgUGhpbGlwcCwKPiAKPiBrZXJuZWwgdGVzdCByb2JvdCBub3RpY2VkIHRoZSBm
b2xsb3dpbmcgYnVpbGQgd2FybmluZ3M6Cj4gCj4gaHR0cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dp
dC1mb3JtYXQtcGF0Y2gjX2Jhc2VfdHJlZV9pbmZvcm1hdGlvbl0KPiAKPiB1cmw6wqDCoMKgCj4g
aHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3AvbGludXgvY29tbWl0cy9QaGlsaXBwLVN0
YW5uZXIvUENJLUFkZC1uZXctc2V0LW9mLWRldnJlcy1mdW5jdGlvbnMvMjAyNDA0MDMtMTYwOTMy
Cj4gYmFzZTrCoMKgCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvcGNpL3BjaS5naXTCoG5leHQKPiBwYXRjaCBsaW5rOsKgwqDCoAo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3IvMjAyNDA0MDMwODA3MTIuMTM5ODYtNS1wc3Rhbm5lciU0MHJlZGhhdC5j
b20KPiBwYXRjaCBzdWJqZWN0OiBbUEFUQ0ggdjUgMDIvMTBdIFBDSTogRGVwcmVjYXRlIGlvbWFw
LXRhYmxlIGZ1bmN0aW9ucwo+IGNvbmZpZzogaTM4Ni1yYW5kY29uZmlnLTE0MS0yMDI0MDQwNAo+
IChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyNDA0MDQvMjAyNDA0
MDQwOTIwLlFJeGhOZQo+IE11LWxrcEBpbnRlbC5jb20vY29uZmlnKQo+IGNvbXBpbGVyOiBnY2Mt
NyAoVWJ1bnR1IDcuNS4wLTZ1YnVudHUyKSA3LjUuMAo+IAo+IElmIHlvdSBmaXggdGhlIGlzc3Vl
IGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGEgbmV3Cj4gdmVyc2lv
biBvZgo+IHRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZ3MK
PiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4KPiA+IFJl
cG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+Cj4gPiBD
bG9zZXM6Cj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwNDA0MDkyMC5RSXhoTmVN
dS1sa3BAaW50ZWwuY29tLwo+IAo+IHNtYXRjaCB3YXJuaW5nczoKPiBkcml2ZXJzL3BjaS9kZXZy
ZXMuYzo4OTcgcGNpbV9pb21hcF9yZWdpb25zX3JlcXVlc3RfYWxsKCkgZXJyb3I6IHdlCj4gcHJl
dmlvdXNseSBhc3N1bWVkICdsZWdhY3lfaW9tYXBfdGFibGUnIGNvdWxkIGJlIG51bGwgKHNlZSBs
aW5lIDg5NCkKPiAKPiB2aW0gKy9sZWdhY3lfaW9tYXBfdGFibGUgKzg5NyBkcml2ZXJzL3BjaS9k
ZXZyZXMuYwo+IAo+IGFjYzIzNjRmZTY2MTA2IFBoaWxpcHAgU3Rhbm5lciAyMDI0LTAxLTMxwqAg
ODY1wqAgaW50Cj4gcGNpbV9pb21hcF9yZWdpb25zX3JlcXVlc3RfYWxsKHN0cnVjdCBwY2lfZGV2
ICpwZGV2LCBpbnQgbWFzaywKPiBhY2MyMzY0ZmU2NjEwNiBQaGlsaXBwIFN0YW5uZXIgMjAyNC0w
MS0zMcKgCj4gODY2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKm5hbWUpCj4gYWNjMjM2NGZl
NjYxMDYgUGhpbGlwcCBTdGFubmVyIDIwMjQtMDEtMzHCoCA4NjfCoCB7Cj4gMzRlOTBiOTY2NTA0
ZjMgUGhpbGlwcCBTdGFubmVyIDIwMjQtMDQtMDPCoCA4NjjCoMKgwqDCoMKgwqDCoMKgwqDCoHNo
b3J0IGJhcjsKPiAzNGU5MGI5NjY1MDRmMyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0wNC0wM8KgIDg2
OcKgwqDCoMKgwqDCoMKgwqDCoMKgaW50IHJldDsKPiAzNGU5MGI5NjY1MDRmMyBQaGlsaXBwIFN0
YW5uZXIgMjAyNC0wNC0wM8KgIDg3MMKgwqDCoMKgwqDCoMKgwqDCoMKgdm9pZCBfX2lvbWVtCj4g
KipsZWdhY3lfaW9tYXBfdGFibGU7Cj4gYWNjMjM2NGZlNjYxMDYgUGhpbGlwcCBTdGFubmVyIDIw
MjQtMDEtMzHCoCA4NzHCoCAKPiAzNGU5MGI5NjY1MDRmMyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0w
NC0wM8KgIDg3MsKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0KPiBwY2ltX3JlcXVlc3RfYWxsX3Jl
Z2lvbnMocGRldiwgbmFtZSk7Cj4gMzRlOTBiOTY2NTA0ZjMgUGhpbGlwcCBTdGFubmVyIDIwMjQt
MDQtMDPCoCA4NzPCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQgIT0gMCkKPiAzNGU5MGI5NjY1
MDRmMyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0wNC0wM8KgCj4gODc0wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiBhY2MyMzY0ZmU2NjEwNiBQaGlsaXBwIFN0
YW5uZXIgMjAyNC0wMS0zMcKgIDg3NcKgIAo+IDM0ZTkwYjk2NjUwNGYzIFBoaWxpcHAgU3Rhbm5l
ciAyMDI0LTA0LTAzwqAgODc2wqDCoMKgwqDCoMKgwqDCoMKgwqBmb3IgKGJhciA9IDA7Cj4gYmFy
IDwgUENJX1NURF9OVU1fQkFSUzsgYmFyKyspIHsKPiAzNGU5MGI5NjY1MDRmMyBQaGlsaXBwIFN0
YW5uZXIgMjAyNC0wNC0wM8KgIDg3N8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmCj4gKCFtYXNrX2NvbnRhaW5zX2JhcihtYXNrLCBiYXIpKQo+IDM0ZTkwYjk2NjUwNGYzIFBo
aWxpcHAgU3Rhbm5lciAyMDI0LTA0LTAzwqAKPiA4NzjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7Cj4gMzRlOTBiOTY2NTA0ZjMgUGhp
bGlwcCBTdGFubmVyIDIwMjQtMDQtMDPCoCA4NznCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZgo+ICghcGNpbV9pb21hcChwZGV2LCBiYXIsIDApKQo+IDM0ZTkwYjk2NjUwNGYz
IFBoaWxpcHAgU3Rhbm5lciAyMDI0LTA0LTAzwqAKPiA4ODDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnI7Cj4gMzRlOTBiOTY2NTA0ZjMg
UGhpbGlwcCBTdGFubmVyIDIwMjQtMDQtMDPCoCA4ODHCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiAz
NGU5MGI5NjY1MDRmMyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0wNC0wM8KgIDg4MsKgIAo+IDM0ZTkw
Yjk2NjUwNGYzIFBoaWxpcHAgU3Rhbm5lciAyMDI0LTA0LTAzwqAgODgzwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gMDsKPiAzNGU5MGI5NjY1MDRmMyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0wNC0w
M8KgIDg4NMKgIAo+IDM0ZTkwYjk2NjUwNGYzIFBoaWxpcHAgU3Rhbm5lciAyMDI0LTA0LTAzwqAg
ODg1wqAgZXJyOgo+IDM0ZTkwYjk2NjUwNGYzIFBoaWxpcHAgU3Rhbm5lciAyMDI0LTA0LTAzwqAg
ODg2wqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+IDM0ZTkwYjk2NjUwNGYzIFBoaWxpcHAgU3Rhbm5l
ciAyMDI0LTA0LTAzwqAgODg3wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBIZXJlIGl0Cj4gZ2V0cyB0
cmlja3k6IHBjaW1faW9tYXAoKSBhYm92ZSBoYXMgbW9zdCBsaWtlbHkKPiAzNGU5MGI5NjY1MDRm
MyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0wNC0wM8KgIDg4OMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
ZmFpbGVkCj4gYmVjYXVzZSBpdCBnb3QgYW4gT09NIHdoZW4gdHJ5aW5nIHRvIGNyZWF0ZSB0aGUK
PiAzNGU5MGI5NjY1MDRmMyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0wNC0wM8KgIDg4OcKgwqDCoMKg
wqDCoMKgwqDCoMKgICogbGVnYWN5LQo+IHRhYmxlLgo+IDM0ZTkwYjk2NjUwNGYzIFBoaWxpcHAg
U3Rhbm5lciAyMDI0LTA0LTAzwqAgODkwwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBXZSBjaGVjawo+
IGhlcmUgaWYgdGhhdCBoYXMgaGFwcGVuZWQuIElmIG5vdCwgcGNpbV9pb21hcCgpCj4gMzRlOTBi
OTY2NTA0ZjMgUGhpbGlwcCBTdGFubmVyIDIwMjQtMDQtMDPCoCA4OTHCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqIG11c3QgaGF2ZQo+IGZhaWxlZCBiZWNhdXNlIG9mIEVJTlZBTC4KPiAzNGU5MGI5NjY1
MDRmMyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0wNC0wM8KgIDg5MsKgwqDCoMKgwqDCoMKgwqDCoMKg
ICovCj4gMzRlOTBiOTY2NTA0ZjMgUGhpbGlwcCBTdGFubmVyIDIwMjQtMDQtMDPCoAo+IDg5M8Kg
wqDCoMKgwqDCoMKgwqDCoMKgbGVnYWN5X2lvbWFwX3RhYmxlID0gKHZvaWQgX19pb21lbQo+ICoq
KXBjaW1faW9tYXBfdGFibGUocGRldik7Cj4gMzRlOTBiOTY2NTA0ZjMgUGhpbGlwcCBTdGFubmVy
IDIwMjQtMDQtMDMgQDg5NMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0KPiBsZWdhY3lfaW9tYXBf
dGFibGUgPyAtRUlOVkFMIDogLUVOT01FTTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IF5eXl5eXl5eXl5eXl5eXl5e
Xgo+IENoZWNrIGZvciBOVUxMCj4gCj4gMzRlOTBiOTY2NTA0ZjMgUGhpbGlwcCBTdGFubmVyIDIw
MjQtMDQtMDPCoCA4OTXCoCAKPiAzNGU5MGI5NjY1MDRmMyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0w
NC0wM8KgIDg5NsKgwqDCoMKgwqDCoMKgwqDCoMKgd2hpbGUgKC0tYmFyCj4gPj0gMCkKPiAzNGU5
MGI5NjY1MDRmMyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0wNC0wMwo+IEA4OTfCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwY2ltX2lvdW5tYXAocGRldiwgbGVnYWN5X2lvbWFwX3Rh
YmxlW2Jhcl0pOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIF5eXl5eXl5eXl5eXl5eXl5eXgo+IFVuY2hlY2tlZCBkZXJlZmVyZW5jZQoKSSB0
aGluayB0aGlzIGlzIGZpbmUgYmVjYXVzZSBgYmFyYCBjYW4gb25seSBiZSBsYXJnZXIgMCBpZiBh
dCBsZWFzdCBvbmUKbWFwcGluZyBoYXMgYmVlbiBjcmVhdGVkLCB0aHVzLCB3aGVuIGl0IHdhcyBw
b3NzaWJsZSB0byBjcmVhdGUKbGVnYWN5X2lvbWFwX3RhYmxlLCB3aGljaCBpcyB0aGVuIHZhbGlk
LgpTbyB0aGUgc2Vjb25kIGZvci1sb29wIG9ubHkgZXhlY3V0ZXMgd2hlbiBpdCdzIG5vdCBOVUxM
LgoKSSBndWVzcyB3ZSBjb3VsZCBzaWxlbmNlIHRoZSB3YXJuaW5nIGJ5IGRvaW5nCgpyZXQgPSBi
YXIgPiAwID8gLUVJTlZBTCA6IC1FTk9NRU07CgpXb3VsZCBldmVuIHNhdmUgb25lIGxpbmUgb2Yg
Y29kZQoKClAuCgoKPiAKPiAzNGU5MGI5NjY1MDRmMyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0wNC0w
M8KgIDg5OMKgIAo+IDM0ZTkwYjk2NjUwNGYzIFBoaWxpcHAgU3Rhbm5lciAyMDI0LTA0LTAzwqAK
PiA4OTnCoMKgwqDCoMKgwqDCoMKgwqDCoHBjaW1fcmVsZWFzZV9hbGxfcmVnaW9ucyhwZGV2KTsK
PiAzNGU5MGI5NjY1MDRmMyBQaGlsaXBwIFN0YW5uZXIgMjAyNC0wNC0wM8KgIDkwMMKgIAo+IDM0
ZTkwYjk2NjUwNGYzIFBoaWxpcHAgU3Rhbm5lciAyMDI0LTA0LTAzwqAgOTAxwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gcmV0Owo+IGFjYzIzNjRmZTY2MTA2IFBoaWxpcHAgU3Rhbm5lciAyMDI0
LTAxLTMxwqAgOTAywqAgfQo+IAoK


