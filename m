Return-Path: <linux-pci+bounces-6708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95068B42E5
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 01:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D271283B25
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 23:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373503BBED;
	Fri, 26 Apr 2024 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNw+LN/n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA33A1B9;
	Fri, 26 Apr 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175877; cv=none; b=ULjbyFpSBbKwXFV3EyOCOY8sTq9qXeSxiw6LAAvOzmzjq/HdYVKh+NR8MopO3fnVVRQbIycV6wJlLRHTRy6bQBFaz9YKIZf1qfhikCAVmDtHflidUzTj9UWsK1KbF2dYESbr8J++NmA6SVA7cmovgGdr8ADraByRpM9rDB7gzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175877; c=relaxed/simple;
	bh=VWDQ+kgcL2E2ExZkJ0IakR/zd/jtc/hVVlIIfoNlQM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uDbvkUQui+7matw7qiVQPYINX7ckS+axHQ/DllFKvkTzJ2zWJ/m34eo075/SFR1IyqbvGZZqNvJPQf4XdmR7V/BmSJ/29qrPNnV9WjM6WuxbvzBGszP14tRNu63tNpnITCwN1XLbadqiOD3zrH5sotZ/bJ0wo+Cj3eWOp9oLDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNw+LN/n; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714175876; x=1745711876;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VWDQ+kgcL2E2ExZkJ0IakR/zd/jtc/hVVlIIfoNlQM0=;
  b=eNw+LN/njfFpv9owOSzuIUxLf+LLWBFCOX9Vu0rraLhkY6rFeHIg0cBz
   iQ+pnk2o8hQEmH8ZCiOjL9FNRCzMnUvGtG4NT6djVXV7g1ix6+LQcGYuV
   EcCF/u1eqj4ZC1giv3zbWdo6FmD/hcCVDOBd4KbZ8cuBA4VXBpwDwNeCW
   NyP0fMHxT3+JEFGtY80x90OfqXvWgcr4G7piY6VulzE0TmrVOWLNVgFuM
   JoMWLc1IxuSKsTmvZO8K61m0EYZbI0Tqf32LxsNE3tzY3HVE+9i+9BKPq
   8QPdu5HaBMQp9LKUHEGN3AIR6UlPbzrZfQGI7c9sblvj/WZpgoDKICrhk
   Q==;
X-CSE-ConnectionGUID: TGtWOeRxSRCw3ejM4cwkbw==
X-CSE-MsgGUID: IbglsRLwQ5ea2AoEdN4Zmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9757620"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="9757620"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 16:57:55 -0700
X-CSE-ConnectionGUID: 10hkVjRuQJSA6kJ7uiCg5Q==
X-CSE-MsgGUID: 1X7IECe+SzW+YjOmPNvyBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="56483360"
Received: from ckshirot-mobl1.amr.corp.intel.com ([10.209.32.101])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 16:57:55 -0700
Message-ID: <09a7091e8731371199686328121335896f71db9a.camel@linux.intel.com>
Subject: Re: [PATCH v5 3/4] PCI/ASPM: Introduce aspm_get_l1ss_cap()
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Jian-Hong Pan <jhp@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>,  linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 16:57:54 -0700
In-Reply-To: <20240424110047.21766-2-jhp@endlessos.org>
References: <20240424110047.21766-2-jhp@endlessos.org>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTA0LTI0IGF0IDE5OjAwICswODAwLCBKaWFuLUhvbmcgUGFuIHdyb3RlOgo+
IEludHJvZHVjZSBhc3BtX2dldF9sMXNzX2NhcCgpIHdoaWNoIGlzIGV4dHJhY3RlZCBmcm9tIGFz
cG1fbDFzc19pbml0KCkgdG8KPiBnZXQgdGhlIFBDSWUncyBMMVNTIGNhcGFiaWxpdHkuIFRoaXMg
ZG9lcyBub3QgY2hhbmdlIGFueSBiZWhhdmlvciwgYnV0Cj4gYXNwbV9nZXRfbDFzc19jYXAoKSBj
YW4gYmUgcmV1c2VkIGxhdGVyLgo+IAo+IExpbms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9y
Zy9zaG93X2J1Zy5jZ2k/aWQ9MjE4Mzk0Cj4gU2lnbmVkLW9mZi1ieTogSmlhbi1Ib25nIFBhbiA8
amhwQGVuZGxlc3Nvcy5vcmc+Cj4gLS0tCj4gwqBkcml2ZXJzL3BjaS9wY2llL2FzcG0uYyB8IDIz
ICsrKysrKysrKysrKysrLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpZS9h
c3BtLmMgYi9kcml2ZXJzL3BjaS9wY2llL2FzcG0uYwo+IGluZGV4IDkxYThiMzViMWFlMi4uYzU1
YWMxMWZhYTczIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jCj4gKysrIGIv
ZHJpdmVycy9wY2kvcGNpZS9hc3BtLmMKPiBAQCAtNjEyLDYgKzYxMiwxOCBAQCBzdGF0aWMgdm9p
ZCBwY2llX2FzcG1fY2hlY2tfbGF0ZW5jeShzdHJ1Y3QgcGNpX2Rldgo+ICplbmRwb2ludCkKPiDC
oMKgwqDCoMKgwqDCoMKgfQo+IMKgfQo+IMKgCj4gK3N0YXRpYyB1MzIgYXNwbV9nZXRfbDFzc19j
YXAoc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqB1MzIgbDFzc19j
YXA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHBjaV9yZWFkX2NvbmZpZ19kd29yZChwZGV2LCBwZGV2
LT5sMXNzICsgUENJX0wxU1NfQ0FQLCAmbDFzc19jYXApOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBp
ZiAoIShsMXNzX2NhcCAmIFBDSV9MMVNTX0NBUF9MMV9QTV9TUykpCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGwxc3NfY2FwID0gMDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJu
IGwxc3NfY2FwOwo+ICt9Cj4gKwo+IMKgLyogQ2FsY3VsYXRlIEwxLjIgUE0gc3Vic3RhdGUgdGlt
aW5nIHBhcmFtZXRlcnMgKi8KPiDCoHN0YXRpYyB2b2lkIGFzcG1fY2FsY19sMTJfaW5mbyhzdHJ1
Y3QgcGNpZV9saW5rX3N0YXRlICpsaW5rLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1MzIgcGFyZW50X2wxc3NfY2FwLCB1
MzIgY2hpbGRfbDFzc19jYXApCj4gQEAgLTcyMiwxNSArNzM0LDggQEAgc3RhdGljIHZvaWQgYXNw
bV9sMXNzX2luaXQoc3RydWN0IHBjaWVfbGlua19zdGF0ZSAqbGluaykKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBTZXR1
cCBMMSBzdWJzdGF0ZSAqLwo+IC3CoMKgwqDCoMKgwqDCoHBjaV9yZWFkX2NvbmZpZ19kd29yZChw
YXJlbnQsIHBhcmVudC0+bDFzcyArIFBDSV9MMVNTX0NBUCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnBhcmVudF9sMXNzX2NhcCk7
Cj4gLcKgwqDCoMKgwqDCoMKgcGNpX3JlYWRfY29uZmlnX2R3b3JkKGNoaWxkLCBjaGlsZC0+bDFz
cyArIFBDSV9MMVNTX0NBUCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgJmNoaWxkX2wxc3NfY2FwKTsKPiAtCj4gLcKgwqDCoMKgwqDC
oMKgaWYgKCEocGFyZW50X2wxc3NfY2FwICYgUENJX0wxU1NfQ0FQX0wxX1BNX1NTKSkKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFyZW50X2wxc3NfY2FwID0gMDsKPiAtwqDCoMKg
wqDCoMKgwqBpZiAoIShjaGlsZF9sMXNzX2NhcCAmIFBDSV9MMVNTX0NBUF9MMV9QTV9TUykpCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNoaWxkX2wxc3NfY2FwID0gMDsKPiArwqDC
oMKgwqDCoMKgwqBwYXJlbnRfbDFzc19jYXAgPSBhc3BtX2dldF9sMXNzX2NhcChwYXJlbnQpOwo+
ICvCoMKgwqDCoMKgwqDCoGNoaWxkX2wxc3NfY2FwID0gYXNwbV9nZXRfbDFzc19jYXAoY2hpbGQp
Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoC8qCj4gwqDCoMKgwqDCoMKgwqDCoCAqIElmIHdlIGRv
bid0IGhhdmUgTFRSIGZvciB0aGUgZW50aXJlIHBhdGggZnJvbSB0aGUgUm9vdCBDb21wbGV4CgpS
ZXZpZXdlZC1ieTogRGF2aWQgRS4gQm94IDxkYXZpZC5lLmJveEBsaW51eC5pbnRlbC5jb20+Cgo=


