Return-Path: <linux-pci+bounces-11345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841A1948797
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 04:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F52C284B8C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 02:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E093B676;
	Tue,  6 Aug 2024 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WkDUs0Lj"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E28AC2E9;
	Tue,  6 Aug 2024 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722911301; cv=none; b=lk45e5SbwRxQZCpOFKGVlTZ/cLcWRcPUnSHXH4Agwxr4rBUh2fuFnppyEaNiT5ZksGO733/z8SB5MuzqY6d/MDsn86HTao2o71sOecQfW76/E2AsiHRX7qDBVKXFWaUTzk2fZWvIeCFXTaM4BolqHEXBhT2UC9jvMFvuU0qqI+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722911301; c=relaxed/simple;
	bh=Ok5IyM9cODLgOEOn+ngLz0QnHWQqyfqYUh9Njtc+OD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B/K9KRSP1qhbMwqEj/BJ71aLFItrYadpC+KNuRIMjq84oKeDAqkDYCo8byQJTScZ+ctOitmbCT4BogNCWBuRLgj7mFRQ8dXQ5VvOOjjto/0V4AR4MhHNdExckwO9F/n0cCJUTw8k+274SFnvXmAAY0HgNQXR606BXtGSWHLHR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WkDUs0Lj; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aMg9+
	wed2us6zRKb+KThXcbHtzIR+oePvzW8XQ58eQQ=; b=WkDUs0Lj2LUcd0GV2GWXF
	XFupjHVDd4DHyGVUe4n5yWURuod7BiW2YeyxPUuA0O5PzdjWHhMaGOt5fDXwKNB1
	M31kCBrHMXuJYlwNpVSqLFJQIfPMEcQJ2H2VzTFeDGIXVU0MQP9YbyhUXhjGRPSV
	VgKT3ZCvxvbX1W2gGrSvP0=
Received: from localhost.localdomain (unknown [116.128.244.169])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3nwgmirFm7yshAg--.2169S2;
	Tue, 06 Aug 2024 10:27:51 +0800 (CST)
From: 412574090@163.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: [PATCH] PCI: Add PCI_EXT_CAP_ID_PL_64GT define
Date: Tue,  6 Aug 2024 10:27:46 +0800
Message-Id: <20240806022746.16353-1-412574090@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nwgmirFm7yshAg--.2169S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW7tw1kWr4DGw47Gr45Jrb_yoWDGrb_Ga
	4a9FWUGr1Yywnayw47t34kXr15trnxAa1SgF9YqFWUZFy8tF4qyws5KasrtF1UWa1DWry5
	Xa98XrZav3ZxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1nYwUUUUUU==
X-CM-SenderInfo: yursklauqziqqrwthudrp/xtbBFQ8tAGXAmqDH+wAEsQ

From: weiyufeng <weiyufeng@kylinos.cn>

PCIe r6.0, sec 7.7.7.1, defines a new 64.0 GT/s PCIe Extended Capability
ID,Add the define for PCI_EXT_CAP_ID_PL_64GT for drivers that will want
this whilst doing Gen6 accesses.

Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
---
 include/uapi/linux/pci_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 94c00996e633..cc875534dae1 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -741,6 +741,7 @@
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
+#define PCI_EXT_CAP_ID_PL_64GT  0x31    /* Physical Layer 64.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
 
-- 
2.25.1


