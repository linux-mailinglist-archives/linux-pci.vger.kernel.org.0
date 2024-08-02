Return-Path: <linux-pci+bounces-11193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE39945F4B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C7F284605
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF772134AB;
	Fri,  2 Aug 2024 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RpB68tc9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUY19Y9H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4F1E4873
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608386; cv=none; b=ay0qowudnegBYTn8O1usluiJ7hQUlzwkWwjTc7fiqVsa3zWL9BdPhjPNX3uAn/mqtdmy6293WgtyVDVzDjp3GBFtwDFlBxkptSyDNwVY6MWlk0hnReFQz56LQK1b7CaF4Fn5Ig98egcbBfb495eyqdp0zj3GZlXT1ZskeQpZuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608386; c=relaxed/simple;
	bh=sp5nmTimtJ6ialuCM+Vl3rd6ShehXJViH0m3CdXU5F8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 In-Reply-To:MIME-Version:Content-Type:References; b=ZRVJgHQEM33iptft2x6WgaaFGUq9CkSgZOSCMcJBDt0ZvWCzLbw1eveDj1wZNRal5oBk88eRObAZcyOo74lABsebF9HBAroOBDhdviqqYTPWpMoWQMyPIUcPo3zkDxPDeatCNtuSyqGlQ9xqM8yT9iRJbOBOgg8UgEoVxnxzOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RpB68tc9; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lUY19Y9H reason="signature verification failed"; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240802141941epoutp03b7861dae62b732b9e66f062ae0e8eb2e~n7zIwMMZi2476224762epoutp03i
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2024 14:19:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240802141941epoutp03b7861dae62b732b9e66f062ae0e8eb2e~n7zIwMMZi2476224762epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722608381;
	bh=4bTCs8K985i5CFCahmn7vRGZ2OihK5sL5VFKayqhc28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:In-Reply-To:List-ID:
	 References:From;
	b=RpB68tc9qBIer1unHGXhswOrhrDhQ6hnzV4F++RFDoO3Tz2E9x7uIfb/q68PFniIh
	 e56UHxoUuZcp5XxnlW8lBCqrj7+/42GMzI2XGuxc8W8f20ACTzcSpq38Hr8Si8gQsH
	 OlB5XNoCNuyjKT2S1j1yh8sOJ+pPIEcjqOiD2Axs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240802141940epcas5p4ae62aafc5557422b2d3c4320c99a05ae~n7zHvMuDW0244302443epcas5p4G;
	Fri,  2 Aug 2024 14:19:40 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Wb7JB4P71z4x9Pq; Fri,  2 Aug
	2024 14:19:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FE.9A.19863.AFAECA66; Fri,  2 Aug 2024 23:19:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240802115633epcas5p2197506addfde16093062d44ca18313e5~n52Kb7e782224722247epcas5p2T;
	Fri,  2 Aug 2024 11:56:33 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240802115633epsmtrp25941dd9acd046a0e8ffea2ff9d276c7b~n52KZzpST0536405364epsmtrp2K;
	Fri,  2 Aug 2024 11:56:33 +0000 (GMT)
X-AuditID: b6c32a50-c73ff70000004d97-ac-66aceafa5192
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.FF.19367.079CCA66; Fri,  2 Aug 2024 20:56:32 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240802115631epsmtip293b0a19f7279ccd32dfe628fb4b67249~n52I7XcLH2147421474epsmtip2M;
	Fri,  2 Aug 2024 11:56:31 +0000 (GMT)
From: Hrishikesh Deleep <hrishikesh.d@samsung.com>
To: manivannan.sadhasivam@linaro.org, kishon@ti.com,
	gregkh@linuxfoundation.org, lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mie@igel.co.jp,
	kw@linux.com, stable@vger.kernel.org
Subject: [PATCH v2 1/5] misc: pci_endpoint_test: Fix the return value of
 IOCTL
Date: Fri,  2 Aug 2024 17:14:47 +0530
Message-Id: <20220824123010.51763-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220824123010.51763-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Submitter: Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
X-Patchwork-Id: 12953470
X-Patchwork-Delegate: lorenzo.pieralisi@arm.com
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18]) by
	smtp.lore.kernel.org (Postfix) with ESMTP id D56A6C32793 for
	<linux-pci@archiver.kernel.org>; Wed, 24 Aug 2022 12:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S237441AbiHXMaa (ORCPT <rfc822;linux-pci@archiver.kernel.org>); Wed, 24 Aug
	2022 08:30:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
	[IPv6:2607:f8b0:4864:20::42d]) by lindbergh.monkeyblade.net (Postfix) with
	ESMTPS id 212CD5A2FB for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022
	05:30:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y141so16334995pfb.7 for
	<linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org;
	s=google; h=content-transfer-encoding:mime-version:references:in-reply-to
	:message-id:date:subject:cc:to:from:from:to:cc;
	bh=jx5D2mTV+ExxV8ji9PCBz7vQf+NrUEKj5YJ/dsZ+EGc=;
	b=lUY19Y9Hd9OS3UivjnlZCoXY1Bh/MTUqfkDMO9l+Ox5gj32ooZicggfrJnvlMXKAxd
	i6VcOEC9xDtmg24ihkGf9Bwg0RxIXqixVTMjVD+GZeN7ef5DdDVkFH5+DHSC9RPtO9V4
	jth5ptsa24LpkiVe5qvE6wUGZyi5npyqj+m8k2axWb3fVLkZTlxCuzsOTa0xXY21QB6Z
	gEp/5lAH7mxAkaw1gmfsBWG/yAv9K3ssyIdSpy2Lxcuvv6q1JlNqo2goBU4dYUOOoif2
	BnMNA10IN8KB8dU0VZdV/C4Uo43b7vpAVGp3FCFR1c6EKo1L2vnAbMGTlHnP1khhB6Ga kR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net;
	s=20210112; h=content-transfer-encoding:mime-version:references:in-reply-to
	:message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
	bh=jx5D2mTV+ExxV8ji9PCBz7vQf+NrUEKj5YJ/dsZ+EGc=;
	b=Za0dPsOoK5+1NPclHRzhVFpYy1cs9BWFa0RJNH2vuWTcrrDurAFO1y2Fq8LrGOqKRx
	7oPqmf4Vz7bsWuKEGV8YUAlfYBtIQ1y0C6y2Ad3wVYcC1GcW9Jq4V8/Pz1qtGk9Qe77g
	fUIVRbpxt1hA6KE7X+IQLoxp3O4lP3WXiqW4zEgSk9j9pGUinNSaWMq/0BLCDn1zLcuk
	WS72mZbF+atyNK/3wTtoeJNH27omSGSxLk/T59Cte9I6jeYMb7CAYtLvXF+6mDu00wDv
	afCso3tV5lyjRGBJKsi5e4qbJ6cJPzxwO1IR14LMAIj5+epWr1kbFo0oy8K9b6raf2Zt u+eg==
X-Gm-Message-State: ACgBeo23FKPuMZ02A8htvJJ8iFgRAVTKHuM42HfjT8pcjL8j5wQnsRbo
	FNkoGeEBA8y7hWt0DWkipq8u
X-Google-Smtp-Source: AA6agR7P9b6IBewqy9DpjGisAzgO74uYCSE7ZBWKK8Cwk+n3NWqNf/c1nYyvvIjanHpCkx2UCcg9ig==
X-Received: by 2002:a05:6a00:842:b0:52e:2515:d657 with SMTP id
	q2-20020a056a00084200b0052e2515d657mr29276965pfk.31.1661344223508; Wed, 24
	Aug 2022 05:30:23 -0700 (PDT)
Received: from localhost.localdomain ([117.207.24.28]) by smtp.gmail.com
	with ESMTPSA id
	b3-20020a1709027e0300b00173031308fdsm3539220plm.158.2022.08.24.05.30.19
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Wed, 24 Aug
	2022 05:30:23 -0700 (PDT)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Precedence: bulk
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmuu6vV2vSDG5ekbRoXryezeLC0x42
	i4ae36wWl3fNYbM4O+84m0XLnxYWi7stnawWUxbZWizY+IjRgdOj8bmEx6ZVnWwed67tYfN4
	cmU6k8f+uWvYPY7f2M7k8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWF
	uZJCXmJuqq2Si0+ArltmDtBhSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK9
	4sTc4tK8dL281BIrQwMDI1OgwoTsjPmz5zAXTMmp+NOr0sDYG97FyMkhIWAiMWnGK8YuRi4O
	IYE9jBLTXvyEcj4xSvzouojg3Fr3mA2m5cKjPcwQiZ2MEtcfrWKDcFqZJDYdX88CUsUmYCTx
	rWkvmC0ikCGxsWMBWDezQLHEqgcPGEFsYYEAiT8TXrCD2CwCqhJ37t0Ai/MKuEqs2/+QHWKb
	vMTqDQeAtnFwcAq4SfyZ7gdRIihxcuYTFoiSQIn55/5ClUtIfLr7kRnC1pdo/LIbKp4pMf1K
	OwvEnacYJe4cWgOWEBJYxyhx9wIPROI3o8TOw+uhvnnHKPF56VZoAPQzSqxa8xzMYRG4xyLx
	Zt43dhBHQuA3i8TEhtdQW9Il5s2fxQphp0l8+vkPqmg1o8SjM0/ZIDZ2M0l8ns4J893MS9/Z
	JzCazkLyFTqbGahs+9s5zLOAgcAsoCmxfpf+AkaWVYxSqQXFuempyaYFhrp5qeXweE/Oz93E
	CE6+WgE7GFdv+Kt3iJGJg/EQowQHs5IIr9DJlWlCvCmJlVWpRfnxRaU5qcWHGE2B/prILCWa
	nA9M/3kl8YYmlgYmZmZmJpbGZoZK4ryvW+emCAmkJ5akZqemFqQWwfQxcXBKNTDNXrN+UWiz
	1TyeLy+4PO/cOFXUuP70t5IPmw5+Y3ASn+dxt0j9KUtzl1jxlNAuKedXjX3L7mSf6anNqvBa
	x+G1L26t6eUnB7qNkrarndR7zcI4ab19g3Led7l/aWs8Z5/cr3I/s+8wj+UsyTsnGSIfrHx2
	z801mVmecWuQg1f40S3Hd5qbxyqeDP8revm5Ac+Gw/u3XFiw58w0Jdl1P9Xr2Z6bdtzbX2Zs
	NkVnsmaduH3DA9f0lw8s+f+lHmXVEqrRUbnL7G+bWXdkCjvDz6nelT3M/b9+LGYK/qrPu/mp
	4ufzdSpBkjO1+518P+r/vLSMQ7lpzp1PQhua+fmeFhmwFLcqXWg8JrLhpk/CFG4lluKMREMt
	5qLiRAAbxQlMRwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7bCSvG7ByTVpBqebrCyaF69ns7jwtIfN
	oqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5LJ6vFlEW2Fgs2PmJ04PRofC7hsWlVJ5vHnWt72Dye
	XJnO5LF/7hp2j+M3tjN5fN4kF8AexWWTkpqTWZZapG+XwJUxf/Yc5oIpORV/elUaGHvDuxg5
	OSQETCQuPNrDDGILCWxnlJh0yRIiLiNxdd1JNghbWGLlv+fsXYxcQDXNTBJ7X1wCS7AJGEl8
	a9rLAmKLCORI7DoxlwnEZhaolNhy/wM7iC0s4Cexdfs1sBoWAVWJO/duMILYvAKuEuv2P2SH
	WCAvsXrDAaAjODg4Bdwk/kz3g7jHVWLjvD+sIGFmAU2J9bv0IToFJU7OfMIC0ekvsXLTNqgp
	EhKf7n5khrD1JRq/7IaKp0t8awDZCnL+MUaJltfnmCGcVYwSX57fYIJwvjJK/DzVC/XlC0aJ
	9S86oDK9jBIX72wG62EROMcicfPCUbCMhMBrFonrUy5DrUmVOLBiPyPMyuWHlrBC2MsZJU7P
	rIWH3sY1s1lhvp556Tv7BEb1WQgfzkLyITqbGahj+9s5zAsYWVYxiqYWFOem5yYXGOoVJ+YW
	l+al6yXn525iBCcqraAdjMvW/9U7xMjEwXiIUYKDWUmEV+jkyjQh3pTEyqrUovz4otKc1OJD
	jNIcLErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGJn7uFQclu8pTHt4+qmPHEzhtndlDqcef
	f+56/jsnqyW2aefXzatO7NyXyCC/es38V2vFTaq8WmW/zX36sXum7qGlOxh5NR48vRRYtkHG
	Of116paJlS7uMx45LO/25OpSnpfTLl/Ecc/bWZhR+96S0w6nXa0uJ14OfnBk4k9WUf/LEoVX
	rn5KKtqpYn5H8tfsCknVwAPHch2rLuaVrf6pV8vmm/rv1qTzx3fHiP0xXRLkZG+6RXNf2hqv
	vd1uHAzvIn5cvdpYnRG65HVBbauf8srlChab1zVrqZYF6G159mXBg6u64ucSnmu3ROWtdbg7
	kSlEONidVUlHfJq14N103+adBhcKaw9779oTcePoLiWW4oxEQy3mouJEAET/qf/DAwAA
X-CMS-MailID: 20240802115633epcas5p2197506addfde16093062d44ca18313e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240802115633epcas5p2197506addfde16093062d44ca18313e5
References: <20220824123010.51763-2-manivannan.sadhasivam@linaro.org>
	<CGME20240802115633epcas5p2197506addfde16093062d44ca18313e5@epcas5p2.samsung.com>

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

IOCTLs are supposed to return 0 for success and negative error codes for
failure. Currently, this driver is returning 0 for failure and 1 for
success, that's not correct. Hence, fix it!

Cc: stable@vger.kernel.org #5.10
Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Hi Mani,

Moving forward, I will be working on Kselftest patch for PCIe [1].

In the Kselftest patch, there was a review comment to resubmit the selftest
patch after your change which is modifying the return values of IOCTLs. For easy
reference, I am giving link of earlier discussion [2].

But I noticed that this patch series [3] is still not merged. May I know if you
are going to take it forward?

If needed I can work on this patch as well for addressing review comment.

[1]: https://patchwork.kernel.org/project/linux-kselftest/patch/20221007053934.5188-1-aman1.gupta@samsung.com/#25042830
[2]: https://www.spinics.net/lists/linux-pci/msg131679.html
[3]: https://patchwork.ozlabs.org/project/linux-pci/patch/20220824123010.51763-2-manivannan.sadhasivam@linaro.org/

Thanks,
Hrishikesh
 drivers/misc/pci_endpoint_test.c | 163 ++++++++++++++-----------------
 1 file changed, 76 insertions(+), 87 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8f786a225dcf..a7d8ae9730f6 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -174,13 +174,12 @@ static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
 	test->irq_type = IRQ_TYPE_UNDEFINED;
 }
 
-static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
+static int pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
 						int type)
 {
-	int irq = -1;
+	int irq = -ENOSPC;
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
-	bool res = true;
 
 	switch (type) {
 	case IRQ_TYPE_LEGACY:
@@ -202,15 +201,16 @@ static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
 		dev_err(dev, "Invalid IRQ type selected\n");
 	}
 
+	test->irq_type = type;
+
 	if (irq < 0) {
-		irq = 0;
-		res = false;
+		test->num_irqs = 0;
+		return irq;
 	}
 
-	test->irq_type = type;
 	test->num_irqs = irq;
 
-	return res;
+	return 0;
 }
 
 static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
@@ -225,7 +225,7 @@ static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
 	test->num_irqs = 0;
 }
 
-static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
+static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 {
 	int i;
 	int err;
@@ -240,7 +240,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 			goto fail;
 	}
 
-	return true;
+	return 0;
 
 fail:
 	switch (irq_type) {
@@ -260,10 +260,10 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 		break;
 	}
 
-	return false;
+	return err;
 }
 
-static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
+static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
 	int j;
@@ -272,7 +272,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	struct pci_dev *pdev = test->pdev;
 
 	if (!test->bar[barno])
-		return false;
+		return -ENOMEM;
 
 	size = pci_resource_len(pdev, barno);
 
@@ -285,13 +285,13 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	for (j = 0; j < size; j += 4) {
 		val = pci_endpoint_test_bar_readl(test, barno, j);
 		if (val != 0xA0A0A0A0)
-			return false;
+			return -EIO;
 	}
 
-	return true;
+	return 0;
 }
 
-static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
+static int pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
 {
 	u32 val;
 
@@ -303,12 +303,12 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
-		return false;
+		return -ETIMEDOUT;
 
-	return true;
+	return 0;
 }
 
-static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
+static int pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 				       u16 msi_num, bool msix)
 {
 	u32 val;
@@ -324,19 +324,18 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
-		return false;
+		return -ETIMEDOUT;
 
-	if (pci_irq_vector(pdev, msi_num - 1) == test->last_irq)
-		return true;
+	if (pci_irq_vector(pdev, msi_num - 1) != test->last_irq)
+		return -EIO;
 
-	return false;
+	return 0;
 }
 
-static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
+static int pci_endpoint_test_copy(struct pci_endpoint_test *test,
 				   unsigned long arg)
 {
 	struct pci_endpoint_test_xfer_param param;
-	bool ret = false;
 	void *src_addr;
 	void *dst_addr;
 	u32 flags = 0;
@@ -360,12 +359,12 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
 	if (err) {
 		dev_err(dev, "Failed to get transfer param\n");
-		return false;
+		return -EFAULT;
 	}
 
 	size = param.size;
 	if (size > SIZE_MAX - alignment)
-		goto err;
+		return -EINVAL;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
@@ -373,22 +372,21 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 
 	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
+		return -EINVAL;
 	}
 
 	orig_src_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_src_addr) {
 		dev_err(dev, "Failed to allocate source buffer\n");
-		ret = false;
-		goto err;
+		return -ENOMEM;
 	}
 
 	get_random_bytes(orig_src_addr, size + alignment);
 	orig_src_phys_addr = dma_map_single(dev, orig_src_addr,
 					    size + alignment, DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, orig_src_phys_addr)) {
+	err = dma_mapping_error(dev, orig_src_phys_addr);
+	if (err) {
 		dev_err(dev, "failed to map source buffer address\n");
-		ret = false;
 		goto err_src_phys_addr;
 	}
 
@@ -412,15 +410,15 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	orig_dst_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_dst_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
-		ret = false;
+		err = -ENOMEM;
 		goto err_dst_addr;
 	}
 
 	orig_dst_phys_addr = dma_map_single(dev, orig_dst_addr,
 					    size + alignment, DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, orig_dst_phys_addr)) {
+	err = dma_mapping_error(dev, orig_dst_phys_addr);
+	if (err) {
 		dev_err(dev, "failed to map destination buffer address\n");
-		ret = false;
 		goto err_dst_phys_addr;
 	}
 
@@ -453,8 +451,8 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 			 DMA_FROM_DEVICE);
 
 	dst_crc32 = crc32_le(~0, dst_addr, size);
-	if (dst_crc32 == src_crc32)
-		ret = true;
+	if (dst_crc32 != src_crc32)
+		err = -EIO;
 
 err_dst_phys_addr:
 	kfree(orig_dst_addr);
@@ -465,16 +463,13 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 
 err_src_phys_addr:
 	kfree(orig_src_addr);
-
-err:
-	return ret;
+	return err;
 }
 
-static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
+static int pci_endpoint_test_write(struct pci_endpoint_test *test,
 				    unsigned long arg)
 {
 	struct pci_endpoint_test_xfer_param param;
-	bool ret = false;
 	u32 flags = 0;
 	bool use_dma;
 	u32 reg;
@@ -492,14 +487,14 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	int err;
 
 	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
-	if (err != 0) {
+	if (err) {
 		dev_err(dev, "Failed to get transfer param\n");
-		return false;
+		return -EFAULT;
 	}
 
 	size = param.size;
 	if (size > SIZE_MAX - alignment)
-		goto err;
+		return -EINVAL;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
@@ -507,23 +502,22 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 
 	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
+		return -EINVAL;
 	}
 
 	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate address\n");
-		ret = false;
-		goto err;
+		return -ENOMEM;
 	}
 
 	get_random_bytes(orig_addr, size + alignment);
 
 	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
 					DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, orig_phys_addr)) {
+	err = dma_mapping_error(dev, orig_phys_addr);
+	if (err) {
 		dev_err(dev, "failed to map source buffer address\n");
-		ret = false;
 		goto err_phys_addr;
 	}
 
@@ -556,24 +550,21 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	wait_for_completion(&test->irq_raised);
 
 	reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
-	if (reg & STATUS_READ_SUCCESS)
-		ret = true;
+	if (!(reg & STATUS_READ_SUCCESS))
+		err = -EIO;
 
 	dma_unmap_single(dev, orig_phys_addr, size + alignment,
 			 DMA_TO_DEVICE);
 
 err_phys_addr:
 	kfree(orig_addr);
-
-err:
-	return ret;
+	return err;
 }
 
-static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
+static int pci_endpoint_test_read(struct pci_endpoint_test *test,
 				   unsigned long arg)
 {
 	struct pci_endpoint_test_xfer_param param;
-	bool ret = false;
 	u32 flags = 0;
 	bool use_dma;
 	size_t size;
@@ -592,12 +583,12 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
 	if (err) {
 		dev_err(dev, "Failed to get transfer param\n");
-		return false;
+		return -EFAULT;
 	}
 
 	size = param.size;
 	if (size > SIZE_MAX - alignment)
-		goto err;
+		return -EINVAL;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
@@ -605,21 +596,20 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 
 	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
+		return -EINVAL;
 	}
 
 	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
-		ret = false;
-		goto err;
+		return -ENOMEM;
 	}
 
 	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
 					DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, orig_phys_addr)) {
+	err = dma_mapping_error(dev, orig_phys_addr);
+	if (err) {
 		dev_err(dev, "failed to map source buffer address\n");
-		ret = false;
 		goto err_phys_addr;
 	}
 
@@ -651,50 +641,51 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 			 DMA_FROM_DEVICE);
 
 	crc32 = crc32_le(~0, addr, size);
-	if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
-		ret = true;
+	if (crc32 != pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
+		err = -EIO;
 
 err_phys_addr:
 	kfree(orig_addr);
-err:
-	return ret;
+	return err;
 }
 
-static bool pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
+static int pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
 {
 	pci_endpoint_test_release_irq(test);
 	pci_endpoint_test_free_irq_vectors(test);
-	return true;
+
+	return 0;
 }
 
-static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
+static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 				      int req_irq_type)
 {
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
+	int err;
 
 	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
-		return false;
+		return -EINVAL;
 	}
 
 	if (test->irq_type == req_irq_type)
-		return true;
+		return 0;
 
 	pci_endpoint_test_release_irq(test);
 	pci_endpoint_test_free_irq_vectors(test);
 
-	if (!pci_endpoint_test_alloc_irq_vectors(test, req_irq_type))
-		goto err;
-
-	if (!pci_endpoint_test_request_irq(test))
-		goto err;
+	err = pci_endpoint_test_alloc_irq_vectors(test, req_irq_type);
+	if (err)
+		return err;
 
-	return true;
+	err = pci_endpoint_test_request_irq(test);
+	if (err) {
+		pci_endpoint_test_free_irq_vectors(test);
+		return err;
+	}
 
-err:
-	pci_endpoint_test_free_irq_vectors(test);
-	return false;
+	return 0;
 }
 
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
@@ -812,10 +803,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type)) {
-		err = -EINVAL;
+	err = pci_endpoint_test_alloc_irq_vectors(test, irq_type);
+	if (err)
 		goto err_disable_irq;
-	}
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
@@ -852,10 +842,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		goto err_ida_remove;
 	}
 
-	if (!pci_endpoint_test_request_irq(test)) {
-		err = -EINVAL;
+	err = pci_endpoint_test_request_irq(test);
+	if (err)
 		goto err_kfree_test_name;
-	}
 
 	misc_device = &test->miscdev;
 	misc_device->minor = MISC_DYNAMIC_MINOR;

