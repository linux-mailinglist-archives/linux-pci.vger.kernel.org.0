Return-Path: <linux-pci+bounces-10554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5246E937977
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 17:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2DB285256
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D29144D15;
	Fri, 19 Jul 2024 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="UzSM0UjW"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A9513C9A9
	for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401278; cv=none; b=cRnpgxP0IHW32F2Xg0Xcs7VcZ3QCDsA5O5S2tmsWPRQC/0l/fNlQmbYzGfrpxkb/TZVTVChmoPHxtGV2UfCRoNdISqWfUdtmI7E+uRXaIg7r+DGtJC+OWSsR8AGNx/5R1kPCbiL2aL9gBISlexuBRI3Im52+dZFPZM4OaBM4tdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401278; c=relaxed/simple;
	bh=B1FnEhqHjhNxdagA7QmoURfeDZKjcaJ9u6aX+Q2IM3k=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=pTRyaW5V5i05VR+2dl0NYYEkbdPJg0srOKNX5k8SkG5VchGdCQe15IUQdEePRcjoSFpcoUolcd8NhmvnWBrtVAdD7xVHhlW8GfqsjOU9fR4I5cv8c9jcYwLYdm1fapEMdbVsQaZ9D+6ln/zGNOYYNDfaYY02sZDl6OdarzW3ehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=UzSM0UjW reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=wf7sN89kDSeR2t4X+8ZWVgDsr4lkPsvDeR8CN721Brw=; b=U
	zSM0UjW9JYlbsyRts3EbT4n2Tio4HdaHk9QQQTG2KmtSvjPCJarlbiKdj4csu+8R
	9uUb6VQXijbW+oOZtJBJCsdyKbJsSgOTjWoY22cx9OuQD4q5uCsT/5LhsMTb8st5
	IQWeMDFCuOJy0KJyICIue+AD3OniUjcQe0mCkuKU2E=
Received: from steven_ygui$163.com ( [183.129.67.13] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Fri, 19 Jul 2024 23:01:11 +0800
 (CST)
Date: Fri, 19 Jul 2024 23:01:11 +0800 (CST)
From: steven <steven_ygui@163.com>
To: linux-pci@vger.kernel.org
Subject: does dtb not support pci acs enable?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2ZA/ibvkos5ySeYekXn08agOY5Wsa1ufkn3YBWPJ80iCXt5goGVFZiPEDO8/qLJiavmTGqegNSzthRUK9RXJ1I284Bvx45xWO3uq8g93ir
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <429b2adf.a5a3.190cb82e4ae.Coremail.steven_ygui@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3_1+3f5pmV7otAA--.18774W
X-CM-SenderInfo: xvwh4v5qb1w3rl6rljoofrz/1tbisBAhI2V4KnUi0wABsQ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGVsbG8sCgpJIGFtIGEgbmV3IHBlcnNvbiBpbiBQQ0ksIEkgYW0gdHJ5aW5nIHRvIGRvIHNvbWV0
aGluZyBmb3IgaW9tbXUgZ3JvdXAgb24gYXJtNjQgcGxhdGZvcm0sIEkgZm91bmQgaWYgSSBib290
IHRoZSBsaW51eCAoNS4xMCBrZXJuZWwpIGtlcm5lbCB1c2luZyBVRUZJICsgQUNQSSwgaXQgd2ls
bCB3b3JrIGNvcnJlY3RseS4gQnV0IGlmIEkgYm9vdCBpdCB1c2luZyBVRUZJICsgRFRCLCB0aGUg
aW9tbXUgZ3JvdXAgbm90IHdvcmssIG9ubHkgb25lIGdyb3VwIHByZXNlbnQuCgpJIHJlYWQgdGhl
IGNvZGUsIGZvdW5kIHRoYXQgcGNpX2Fjc19lbmFibGUgaXMgc2V0IHRvIDEgZHVyaW5nIGFjcGlf
aW5pdCwgYnV0IEkgY2FuIG5vdCBmaW5kIGFueSBjb2RlIGZvciBkdGIgYm9vdGluZywgc28gaXQg
d2lsbCByZXR1cm4gImRpc2FibGVfYWNzX3JlZGlyICIgZHVyaW5nIGNhbGwgcGNpX2VuYWJsZV9h
Y3MuIApzdGF0aWMgdm9pZCBwY2lfZW5hYmxlX2FjcyhzdHJ1Y3QgcGNpX2RldiAqZGV2KQp7CiAg
ICBpZiAoIXBjaV9hY3NfZW5hYmxlKQogICAgICAgIGdvdG8gZGlzYWJsZV9hY3NfcmVkaXI7Cgog
ICAgaWYgKCFwY2lfZGV2X3NwZWNpZmljX2VuYWJsZV9hY3MoZGV2KSkKICAgICAgICBnb3RvIGRp
c2FibGVfYWNzX3JlZGlyOwoKICAgIHBjaV9zdGRfZW5hYmxlX2FjcyhkZXYpOwoKCgoKU08sIGlz
IGl0IG5vdCBzdXBwb3J0IGluIGR0Yj8KCg==

