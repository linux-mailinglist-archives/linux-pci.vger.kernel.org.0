Return-Path: <linux-pci+bounces-13124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E687E976F1F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 18:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BC22810D2
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3A1BE85B;
	Thu, 12 Sep 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="IwgOxAQC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879C1AD256;
	Thu, 12 Sep 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159742; cv=none; b=bmeMzCMdu3HW+uILiVQfLk7QWv197Jp4R0Zq6MrkfTf1Gj4j/k7+CVD0yK2y0hgjL6Yylmbt2KLWt9D2zToLg+fTy6VT42GYgTxksR1W69ard/4PyhbbWZJ15ms4AYLI0x81dMQnOnryM+mnZdgLB8PosyqPU9F0D6BkL1U4DP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159742; c=relaxed/simple;
	bh=530XNQAEmhOrC7VwRpLecl9sAiK36GwooP77boVE0Lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=D9tQHu+aFLFpDOxRPKAHN+JCSiTbnelVHvkL3/gwPvww2BlgerE/Ql2koEV0ATu9IH6U4xvY4cXvfuRg5imZ8sN81bjYSRqDlyfQE2Pj3KIsxCqvqxkidre4jeaq7vvl/yHwWlMauh78ZQ+/yJKrFLlSTHtcrFa6p0zRrrgaXME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=IwgOxAQC reason="signature verification failed"; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpsz3t1726159696trnlepd
X-QQ-Originating-IP: wEd5VLb+C7DJlBJJc80hO5dQ5BCjltzEjPN05/PxW9k=
Received: from m16.mail.163.com ( [220.197.31.4])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Sep 2024 00:48:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17481997288728720519
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=8XrEsIIS9aI5+bq/hsZocilGWCWX5u1no4Zo+q3KNn4=; b=I
	wgOxAQCYN+9Yyl8LM/872U5Rna63quAW/63FICJvhjG60a/6yexzMOBcPK4cILfz
	Jh38N6nWyvqR+5ZUr2xOvAMRkPYZKPpGdgn6KviDCgtHtXdcA1fOBGkePQh1GY26
	z71IU4Tqfd9Zh/E2yf/Iy+8GtufUhjpeUv22yfAgVk=
Received: from kxwang23$m.fudan.edu.cn ( [104.238.222.239] ) by
 ajax-webmail-wmsvr-40-136 (Coremail) ; Fri, 13 Sep 2024 00:47:39 +0800
 (CST)
Date: Fri, 13 Sep 2024 00:47:39 +0800 (CST)
From: "Kaixin Wang" <kxwang23@m.fudan.edu.cn>
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: 21302010073@m.fudan.edu.cn, 21210240012@m.fudan.edu.cn, dave.jiang@intel.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kurt.schwemmer@microsemi.com, bhelgaas@google.com
Subject: Re: [PATCH] ntb: ntb_hw_switchtec: Fix use after free vulnerability
 in switchtec_ntb_remove due to race condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <dd14d4b8-0215-4d0b-a599-eb75b397447f@deltatee.com>
References: <20240909172007.1863-1-kxwang23@m.fudan.edu.cn>
 <dd14d4b8-0215-4d0b-a599-eb75b397447f@deltatee.com>
X-NTES-SC: AL_Qu2ZBP2etk4u7yCYZukXn0kbjug3WcW0u/0k3oJUNps0sSbJxCIce1FGAHTrzv+TMyOvnjaRQClvyeFHTa9cY5jlf0r4v/rVwiL22O5MRq10
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <BF7FF550B3EEF70F+12371232.c26f.191e7222004.Coremail.kxwang23@m.fudan.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3X5srG+NmLpAFAA--.2953W
X-CM-SenderInfo: zprtkiiuqyikitw6il2tof0z/1tbiwh5Y2GWXw6aYUAAGsF
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

CgoKQXQgMjAyNC0wOS0xMCAwMjoxNzo1NywgIkxvZ2FuIEd1bnRob3JwZSIgPGxvZ2FuZ0BkZWx0
YXRlZS5jb20+IHdyb3RlOgo+Cj4KPk9uIDIwMjQtMDktMDkgMTE6MjAsIEthaXhpbiBXYW5nIHdy
b3RlOgo+PiBJbiB0aGUgc3dpdGNodGVjX250Yl9hZGQgZnVuY3Rpb24sIGl0IGNhbiBjYWxsIHN3
aXRjaHRlY19udGJfaW5pdF9zbmRldgo+PiBmdW5jdGlvbiwgdGhlbiAmc25kZXYtPmNoZWNrX2xp
bmtfc3RhdHVzX3dvcmsgaXMgYm91bmQgd2l0aAo+PiBjaGVja19saW5rX3N0YXR1c193b3JrLiBz
d2l0Y2h0ZWNfbnRiX2xpbmtfbm90aWZpY2F0aW9uIG1heSBiZSBjYWxsZWQKPj4gdG8gc3RhcnQg
dGhlIHdvcmsuCj4+IAo+PiBJZiB3ZSByZW1vdmUgdGhlIG1vZHVsZSB3aGljaCB3aWxsIGNhbGwg
c3dpdGNodGVjX250Yl9yZW1vdmUgdG8gbWFrZQo+PiBjbGVhbnVwLCBpdCB3aWxsIGZyZWUgc25k
ZXYgdGhyb3VnaCBrZnJlZShzbmRldiksIHdoaWxlIHRoZSB3b3JrCj4+IG1lbnRpb25lZCBhYm92
ZSB3aWxsIGJlIHVzZWQuIFRoZSBzZXF1ZW5jZSBvZiBvcGVyYXRpb25zIHRoYXQgbWF5IGxlYWQK
Pj4gdG8gYSBVQUYgYnVnIGlzIGFzIGZvbGxvd3M6Cj4+IAo+PiBDUFUwICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQ1BVMQo+PiAKPj4gICAgICAgICAgICAgICAgICAgICAgICAgfCBj
aGVja19saW5rX3N0YXR1c193b3JrCj4+IHN3aXRjaHRlY19udGJfcmVtb3ZlICAgIHwKPj4ga2Zy
ZWUoc25kZXYpOyAgICAgICAgICAgfAo+PiAgICAgICAgICAgICAgICAgICAgICAgICB8IGlmIChz
bmRldi0+bGlua19mb3JjZV9kb3duKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICB8IC8vIHVz
ZSBzbmRldgo+PiAKPj4gRml4IGl0IGJ5IGVuc3VyaW5nIHRoYXQgdGhlIHdvcmsgaXMgY2FuY2Vs
ZWQgYmVmb3JlIHByb2NlZWRpbmcgd2l0aAo+PiB0aGUgY2xlYW51cCBpbiBzd2l0Y2h0ZWNfbnRi
X3JlbW92ZS4KPgo+VGhhbmsgeW91LCB0aGlzIGxvb2tzIGdvb2QgdG8gbWUuCj4KPlJldmlld2Vk
LWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+Cj4KClRoYW5rcyBmb3Ig
dGhlIHJldmlldyEKCkJlc3QgcmVnYXJkcywKS2FpeGluIFdhbmcK

