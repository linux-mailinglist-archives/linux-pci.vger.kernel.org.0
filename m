Return-Path: <linux-pci+bounces-3388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C393A852CCA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 10:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0761C2636A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B9F364C1;
	Tue, 13 Feb 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b="ZKUW7uXy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.210.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBC286A6;
	Tue, 13 Feb 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.210.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817302; cv=none; b=c+4AbkQSpVlTulaFGIvFvNJjxjnwmUCrM2XjrOGTgqicWTUC9mAzPlc89znq+F7Pge0xcXY/C2ZjHfj9hwcKiISaUrP93h435+Y/ZE4tWTYEwkGnsa5A2ge8ys/QYHLlwpXEqQadC0SD2IP43M6/axFLqNL176lIixkCiusa738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817302; c=relaxed/simple;
	bh=MIns2JF+IYI+MYAJQHKqKYjEvmpYHQ0YIEx0P7Hr5dY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=qLQntGD03TYjAlO2ug22BLbxgXEiuApbEha4XWpZht0jkhxj8phMpfBTGgozRR5jBngCUEfrPI5f+Xwgv88DDrhZxVncvI5WFMimmkuWFaPF3mzZSOW2MD4J142mDBr6SK36ZB1L9Db35pTa3t3Bn3KxEACFytgndfJH5+wIx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com; spf=pass smtp.mailfrom=orange.com; dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b=ZKUW7uXy; arc=none smtp.client-ip=80.12.210.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1707817300; x=1739353300;
  h=message-id:date:mime-version:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:from;
  bh=MIns2JF+IYI+MYAJQHKqKYjEvmpYHQ0YIEx0P7Hr5dY=;
  b=ZKUW7uXyY16cxEEkDWmzWTwCa3ODyYtol2JCy6j2tM2NEtWshgjdMhqe
   uHOTDI3w7bFmsXnKXYutoWUNGy+UTBWRA/G9/A/o7n6tAK6oiYXaSyroo
   8gvuNgxgcLG533x4gW71jcDlwnvreBAuynzmtukWZZZz9yZuOGd0vJnDp
   i5MYuQHmPAaeKT0Ke4+PMnVJPGfVZWhHfosNssJARILlLjLr42DGMOqKS
   N+fqkZqKwiWxXR8o1g6+UuRgeiwxftFa3Ar350ymbsfXaVtS8ShB7+civ
   M2uWRWBrIK0HhCsI2l6ZkgM8opB0sSAh7uqaLQFRwrgeBJ70L7nmEi8aQ
   Q==;
Received: from unknown (HELO opfedv3rlp0b.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2024 10:40:29 +0100
Received: from unknown (HELO OPE16NORMBX204.corporate.adroot.infra.ftgroup)
 ([x.x.x.x]) by opfedv3rlp0b.nor.fr.ftgroup with
 ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 10:40:29 +0100
Received: from [x.x.x.x] [x.x.x.x] by OPE16NORMBX204.corporate.adroot.infra.ftgroup
 [x.x.x.x] with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35;
 Tue, 13 Feb 2024 10:40:29 +0100
From: pierre.cregut@orange.com
X-IronPort-AV: E=Sophos;i="6.06,156,1705359600"; 
   d="scan'208";a="105395682"
Message-ID: <2ba3b9d5-4017-49bb-8e22-7232a143e829@orange.com>
Date: Tue, 13 Feb 2024 10:40:28 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
To: Jim Harris <jim.harris@samsung.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Leon Romanovsky <leonro@nvidia.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Alex
 Williamson <alex.williamson@redhat.com>
References: <20240211084844.GA805332@unreal>
 <20240212202714.GA1142983@bhelgaas>
 <CGME20240212225904uscas1p19a3d7743607a0abe3627fb8c4829f27b@uscas1p1.samsung.com>
 <ZcqitnWTh+zQ+H4p@ubuntu>
Content-Language: en-US
In-Reply-To: <ZcqitnWTh+zQ+H4p@ubuntu>
X-ClientProxiedBy: OPE16NORMBX107.corporate.adroot.infra.ftgroup (10.115.27.4)
 To OPE16NORMBX204.corporate.adroot.infra.ftgroup (10.115.26.9)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Rmlyc3Qgc29ycnkgZm9yIG5vdCBhbnN3ZXJpbmcgZWFybGllciBidXQgaXQgaXMgYSBsb25nIHRp
bWUgYWdvLiBJIGRvCm5vdCB3b3JrIG9uIHRoZSB0b3BpYyBhbnkgbW9yZSAoYSBtb25pdG9yaW5n
IHRvb2wgU2t5ZGl2ZSwgYW4gb3Blbgpzb3VyY2UgcHJvamVjdCBubyBtb3JlIGFjdGl2ZWx5IGRl
dmVsb3BlZCBhcyBmYXIgYXMgSSBrbm93KSBhbmQgb25seQpoYXZlIHZhZ3VlIG1lbW9yaWVzIG9m
IGl0LgoKPiAKPiAgICAgIGtvYmplY3RfdWV2ZW50KCZkZXYtPmRldi5rb2JqLCBLT0JKX0NIQU5H
RSk7Cj4gICAgICBpb3YtPm51bV9WRnMgPSBucl92aXJ0Zm47Cj4gCj4gd2hpY2ggaXMgaWRlbnRp
Y2FsIHRvIGhvdyB0aGUgY29kZSBsb29rcyB0b2RheS4gSXMgaXQgcG9zc2libGUgdGhhdAo+IHVz
ZXJzcGFjZSBjb3VsZCByZWFjdCB0byB0aGlzIHVldmVudCBhbmQgcmVhZCB0aGUgc3RhbGUgbnVt
X1ZGcyBiZWZvcmUKPiBpb3YtPm51bV9WRnMgZ2V0cyB3cml0dGVuIGhlcmU/IEkgbWVhbiwgdGhl
b3JldGljYWxseSBpdCdzIHBvc3NpYmxlLCBidXQKPiBmcm9tIHRoZSBidWcgcmVwb3J0IGl0IHNl
ZW1zIGxpa2UgdGhlIHNjZW5hcmlvIFBpZXJyZSB3YXMgZmFjaW5nIHdhcwo+IDEwMCUgcmVwcm9k
dWNpYmxlLgogRnJvbSBteSBtZW1vcmllcyB5ZXMgdGhhdCB3YXMgZXhhY3RseSB0aGUgcHJvYmxl
bS4gQW55IHN0YWJsZSBtZXRob2QKdGhhdCBjb3VsZCBkZXRlY3QgdGhlIGNoYW5nZSBvZiBjb25m
aWd1cmF0aW9uIGluIHVzZXIgbGFuZCBhbmQgZW5zdXJlCnRoYXQgd2UgZ2V0IGEgcmVsaWFibGUg
dmFsdWUgb2YgbnVtX3ZmcyBhZnRlciB3ZSByZWNlaXZlZCBpdCB3b3VsZCBiZQpmaW5lLgoKQmVz
dCByZWdhcmRzLAoKUGllcnJlIENyw6lndXQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KQ2UgbWVzc2FnZSBldCBzZXMgcGllY2VzIGpvaW50ZXMg
cGV1dmVudCBjb250ZW5pciBkZXMgaW5mb3JtYXRpb25zIGNvbmZpZGVudGllbGxlcyBvdSBwcml2
aWxlZ2llZXMgZXQgbmUgZG9pdmVudCBkb25jDQpwYXMgZXRyZSBkaWZmdXNlcywgZXhwbG9pdGVz
IG91IGNvcGllcyBzYW5zIGF1dG9yaXNhdGlvbi4gU2kgdm91cyBhdmV6IHJlY3UgY2UgbWVzc2Fn
ZSBwYXIgZXJyZXVyLCB2ZXVpbGxleiBsZSBzaWduYWxlcg0KYSBsJ2V4cGVkaXRldXIgZXQgbGUg
ZGV0cnVpcmUgYWluc2kgcXVlIGxlcyBwaWVjZXMgam9pbnRlcy4gTGVzIG1lc3NhZ2VzIGVsZWN0
cm9uaXF1ZXMgZXRhbnQgc3VzY2VwdGlibGVzIGQnYWx0ZXJhdGlvbiwNCk9yYW5nZSBkZWNsaW5l
IHRvdXRlIHJlc3BvbnNhYmlsaXRlIHNpIGNlIG1lc3NhZ2UgYSBldGUgYWx0ZXJlLCBkZWZvcm1l
IG91IGZhbHNpZmllLiBNZXJjaS4NCg0KVGhpcyBtZXNzYWdlIGFuZCBpdHMgYXR0YWNobWVudHMg
bWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG9yIHByaXZpbGVnZWQgaW5mb3JtYXRpb24gdGhhdCBt
YXkgYmUgcHJvdGVjdGVkIGJ5IGxhdzsNCnRoZXkgc2hvdWxkIG5vdCBiZSBkaXN0cmlidXRlZCwg
dXNlZCBvciBjb3BpZWQgd2l0aG91dCBhdXRob3Jpc2F0aW9uLg0KSWYgeW91IGhhdmUgcmVjZWl2
ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGFuZCBkZWxl
dGUgdGhpcyBtZXNzYWdlIGFuZCBpdHMgYXR0YWNobWVudHMuDQpBcyBlbWFpbHMgbWF5IGJlIGFs
dGVyZWQsIE9yYW5nZSBpcyBub3QgbGlhYmxlIGZvciBtZXNzYWdlcyB0aGF0IGhhdmUgYmVlbiBt
b2RpZmllZCwgY2hhbmdlZCBvciBmYWxzaWZpZWQuDQpUaGFuayB5b3UuCg==


