Return-Path: <linux-pci+bounces-3139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBB884B180
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 10:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7590228686D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE8D12D163;
	Tue,  6 Feb 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYUu/u/j"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316612D14E
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212482; cv=none; b=KVz8vJY4nBH7VCc9XN1HNivNpJUI5Y5N2JaXCON2xEwfz7H8suKV3SY/1LrJtQ2ErG8sioTgVGT6JKj7Ya0vYlZEuPRAksjqxMXoi1gyPEf7kyxC0sC7DqV9Nvpza/2nY2GfTwndU0kvNjmN7771JpobE5A26e0hq0oi8V8x6jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212482; c=relaxed/simple;
	bh=PS7FDfG+KJoasqQRxO3VrowxY9G2OSe3PNqnq4tkY48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXSbytq36Dd9Qj54wCFTc73umJQTSJCMbUEZ2yIXqMhdt8JVEWeilgq+ELsHosv3thCI3GFhAUfaFBpsx3PuhXmmundu7r+tz5AUQ0x/WCCH770dnznl1CLFDCdWP4XHlBPZHlJ2dRlAYanWEZ2RbC5YcT2Hd1NoAgEknomvjEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYUu/u/j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707212479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS7FDfG+KJoasqQRxO3VrowxY9G2OSe3PNqnq4tkY48=;
	b=FYUu/u/jBA+tEKvmHQhq5Zti1rdPmUaw89U/IA/ZfBl4jJszPPfPQE6COnOFhJEEp6nrMs
	4cbzXU++IV2PjhR65xw8saDpnqh1g5qPSa7Q+I/R9B8OsblpNzzDUi778jQsCOmaCP7Yyo
	LRZRJx/529+uZqRhpAD7tVWD0s8FKTE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-bVbKbQ-XM06O48T5aA-mwg-1; Tue, 06 Feb 2024 04:41:18 -0500
X-MC-Unique: bVbKbQ-XM06O48T5aA-mwg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42a89aea9aeso11498211cf.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2024 01:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212478; x=1707817278;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PS7FDfG+KJoasqQRxO3VrowxY9G2OSe3PNqnq4tkY48=;
        b=sd5GTsR5112dYzn6EbYYHb3yN0KV/6K/oVYUsrp+166r4meD0y62u6sD9BvUsUPn+l
         oJuywzMYkh2VldsNxRBZYs73AZMpXg77FdlAJcdUOfBlW273rNE0j4LKmXm5ZL90MBfS
         5NxNx+RGQmqPK3FCIDrRGeJvgVLLcWJpIIdMPdc4PH730Kys4W2Norkb/30hoYy3EDWE
         Xk3m19AfFBLJ8UPTQGIfYpFateD+b2FJ70oVrpqHQT+K/bo+h96C6a3QAVhTubC5/Yu3
         VPNinKafddMP5nFtHTZvjVgXZGCHxXwYQ13U0TMSyhEIsN15x3gX/5Za0UZZBaushURm
         4JYg==
X-Gm-Message-State: AOJu0Yy4kcObiowH1z29G46Sdr8Z8wkKrDlYObs23obvNZ48U2KlSM7E
	jhRawhzLs2xj26F5sP2K+qO1kiSkbnxwVJiZy1gP7PyCs61fk0AV865KTKm/Ioa5KwN7FDeO6gy
	HDtVqynoBPD2aeoKmhhqQMd8xMJwb4nTyYvmnxMl06Heg6R65zM8zUAwZnA==
X-Received: by 2002:a05:622a:287:b0:42c:239c:d87b with SMTP id z7-20020a05622a028700b0042c239cd87bmr2109366qtw.1.1707212477981;
        Tue, 06 Feb 2024 01:41:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPwOtJwoBj0o9iD/y81KvrC9NDjv+GvZjnfPUHrQ3iRktuwoj5UA2yWl9XCSI2hrawY6IgDA==
X-Received: by 2002:a05:622a:287:b0:42c:239c:d87b with SMTP id z7-20020a05622a028700b0042c239cd87bmr2109350qtw.1.1707212477710;
        Tue, 06 Feb 2024 01:41:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW02GSkdtkEVcCB0rGUiv9DRBd1zjZ8LddiDrSMXsyASTobjGW9NuSrarIZIzLiMxjuwwYqMInwnChcTJLIuNQU4odVW1PqV0Ed5Cry4MTH35lt5TYhmNeWgd1oQ+keBNlfm9XPwhGsJ6wh2TJBnl175Ym2e26wYqELtjfm5TUovGpFqbnNztWTzZ6FvSwTFW8j4bRruOQYUplo2SkFfEKzkii1mcQ+B0HtoUkkO51gNylEg0t7i3B7xmUYk7IG+z+bTSQecqUFBI88y/QTOZGXJ9/iTOepV+H0DfcBqtPkmWku6ovriT5KE7Ceg4MwPov8qoX5m61Zycrtbx0b0ksAeV0eJc3meQLAER2Ypb6Q6O22Ga66CFsSe9+EVchBTJfKjklxxVS7bnfG6zu+MpvV+9FXcoofBiHT15F3wLnvafoKR/jaA+O+CQjiGTAJrvTEP28TMaVYAGeqKr3icT2YbsyAPivpaENRQJl49sGmgGiv4II84grTQSJqvon/x3IFbc20UszUYpKICKbrIeqGJE2fwiw75awDA3ZYDYJF0RblOuBjXBbWcRhlfdRmwtIiKHnEfpcEeK8NWBaDfM/kMFDLxi5XGCYDHkdws/1LYLoewFDHcFbt9wzJnzejcg0Orsa5lct0nbW96Z40ljRqeUP1dLCH2yucWEuXDRsVBz/t3fr8vmSFHyATtiz/jGfrb9tMbELht7zjv+D/tzlyKMB7Fw0HNq97YWMB7BHplgy25WfdVWZ0ji603aZsIkArUvFVPqGpy2g1YGDZ+tKge0Duom8fFda/8bgoZdRVAmhSfaA00aFSTb7XoxyPd14gTTq7W8K1fg==
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id x25-20020ac85399000000b0042aaa37e316sm735315qtp.22.2024.02.06.01.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:41:17 -0800 (PST)
Message-ID: <1f1be7418b6f52854abdd25ad7b1c526a9a7e35d.camel@redhat.com>
Subject: Re: [PATCH v6 0/4] Regather scattered PCI-Code
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Berg <johannes@sipsolutions.net>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>,  John Sanpe
 <sanpeqf@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Kees Cook
 <keescook@chromium.org>, Rae Moar <rmoar@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas
 Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
 dakr@redhat.com, linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 06 Feb 2024 10:41:13 +0100
In-Reply-To: <20240131210842.GA599075@bhelgaas>
References: <20240131210842.GA599075@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTAxLTMxIGF0IDE1OjA4IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+
IE9uIFdlZCwgSmFuIDMxLCAyMDI0IGF0IDEwOjAwOjE5QU0gKzAxMDAsIFBoaWxpcHAgU3Rhbm5l
ciB3cm90ZToKPiA+IEBCam9ybjoKPiA+IEkgZGVjaWRlZCB0aGF0IGl0J3Mgbm93IGFjdHVhbGx5
IHBvc3NpYmxlIHRvIGp1c3QgZW1iZWQgdGhlIGRvY3UKPiA+IHVwZGF0ZXMKPiA+IHRvIHRoZSBy
ZXNwZWN0aXZlIHBhdGNoZXMsIGluc3RlYWQgb2YgYSBzZXBhcmF0ZSBwYXRjaC4KPiA+IEFsc28g
ZHJvcHBlZCB0aGUgaW9wb3J0X3VubWFwKCkgZm9yIG5vdy4KPiAKPiBUaGFua3MuwqAgSSBkaWRu
J3Qgc2VlIGFueSBkb2N1bWVudGF0aW9uIHVwZGF0ZXMgKG90aGVyIHRoYW4gdGhvc2UKPiByZWxh
dGVkIHRvIHRoZSBjaGFuZ2VkIHBhdGggbmFtZXMpIGluIHRoaXMgc2VyaWVzLCBzbyBJIGFzc3Vt
ZSB0aGUKPiB1cGRhdGVzIHlvdSBtZW50aW9uIHdvdWxkIGJlIGluIGEgZnV0dXJlIHNlcmllcy4K
Ck5vLCBJIGFjdHVhbGx5IG1lYW50IHRoZSBjaGFuZ2VkIHBhdGggbmFtZXMuCgpUaGUgbmV4dCBz
ZXJpZXMgKG5ldyBkZXZyZXMgZnVuY3Rpb25zKSBqdXN0IGFkZHMgbW9yZSBkb2NzdHJpbmdzIHRv
CmlvbWFwLmMsIGRldnJlcy5jIGFuZCBwY2kuYyBpbiBkcml2ZXJzL3BjaS8sIHdoaWNoLCBhZnRl
ciB0aGlzIHNlcmllcwpoZXJlIGlzIGFwcGxpZWQsIGFyZSBhbGwgYWxyZWFkeSBhZGRlZCB0byB0
aGUgRG9jdS4KCj4gCj4gPiAuLi4KPiA+IFBoaWxpcHAgU3Rhbm5lciAoNCk6Cj4gPiDCoCBsaWIv
cGNpX2lvbWFwLmM6IGZpeCBjbGVhbnVwIGJ1ZyBpbiBwY2lfaW91bm1hcCgpCj4gPiDCoCBsaWI6
IG1vdmUgcGNpX2lvbWFwLmMgdG8gZHJpdmVycy9wY2kvCj4gPiDCoCBsaWI6IG1vdmUgcGNpLXNw
ZWNpZmljIGRldnJlcyBjb2RlIHRvIGRyaXZlcnMvcGNpLwo+ID4gwqAgUENJOiBNb3ZlIGRldnJl
cyBjb2RlIGZyb20gcGNpLmMgdG8gZGV2cmVzLmMKPiA+IAo+ID4gwqBEb2N1bWVudGF0aW9uL2Ry
aXZlci1hcGkvZGV2aWNlLWlvLnJzdCB8wqDCoCAyICstCj4gPiDCoERvY3VtZW50YXRpb24vZHJp
dmVyLWFwaS9wY2kvcGNpLnJzdMKgwqAgfMKgwqAgNiArCj4gPiDCoE1BSU5UQUlORVJTwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEg
LQo+ID4gwqBkcml2ZXJzL3BjaS9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqAgNSArCj4gPiDCoGRyaXZlcnMvcGNpL01ha2VmaWxlwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKy0KPiA+IMKgZHJpdmVycy9wY2kvZGV2
cmVzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0NTAKPiA+ICsrKysr
KysrKysrKysrKysrKysrKysrKysKPiA+IMKgbGliL3BjaV9pb21hcC5jID0+IGRyaXZlcnMvcGNp
L2lvbWFwLmMgfMKgwqAgNSArLQo+ID4gwqBkcml2ZXJzL3BjaS9wY2kuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI0OSAtLS0tLS0tLS0tLS0tLQo+ID4gwqBk
cml2ZXJzL3BjaS9wY2kuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMjQgKysKPiA+IMKgbGliL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyAtCj4gPiDCoGxpYi9NYWtlZmlsZcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
MSAtCj4gPiDCoGxpYi9kZXZyZXMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAyMDggKy0tLS0tLS0tLS0tCj4gPiDCoDEyIGZpbGVzIGNoYW5n
ZWQsIDQ5MCBpbnNlcnRpb25zKCspLCA0NjcgZGVsZXRpb25zKC0pCj4gPiDCoGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL3BjaS9kZXZyZXMuYwo+ID4gwqByZW5hbWUgbGliL3BjaV9pb21hcC5j
ID0+IGRyaXZlcnMvcGNpL2lvbWFwLmMgKDk5JSkKPiAKPiBBcHBsaWVkIHRvIHBjaS9kZXZyZXMg
Zm9yIHY2LjksIHRoYW5rcyEKClRoeCEKCg==


