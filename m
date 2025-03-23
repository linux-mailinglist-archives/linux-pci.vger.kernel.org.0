Return-Path: <linux-pci+bounces-24470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE6EA6D021
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 17:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D58DA7A68DC
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B79B1624EB;
	Sun, 23 Mar 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p6k6f5RQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C5156C76;
	Sun, 23 Mar 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742748627; cv=none; b=BX//azCPN6IjNgSiyx2TY1kutZaWQbOxN+ev9WsWDo7Eq4q3OhRJg8zA3dM8Us6y/fiWI3dh2vjATF3VaAr0B2ILEPUz5dT/G47giQqZ+YW3CQd+Q9lkXaaW06zplFuSyMHrxt5COYpHaQttHdtOcxWToRDwMGADOamp+tku6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742748627; c=relaxed/simple;
	bh=jDYviVSssQTJpNIhsPtVrwLPnVpArMGN+aeQj/hqC6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MC7RcRwWtZFb5QvG4vQSKvnMGuUGMarz7hQrM4pLAmbI72+iHmMuJkw/FCX7JtNfVKZfhB366EOCOnHx8ggBSDBOctDXSxkSeNf+pi7fNsYCulXi8oXiik0Fj44xEANW+dLPBAcEm69YVF7iLokfW9sF7YpQwZ775p9N7hZD+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p6k6f5RQ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5EAGM
	V7SwM4hXg2KpoIhfhVyUycJB3dJKNluHvxyOBg=; b=p6k6f5RQFqtYWW3fY05sU
	LbmiJosZu0BhPCezKQSW49HvT4agmMtTvi1aSLFDHZuzfXsIiGu+kdK+HT/fniez
	c+0RjZ+Yp4/UkSE5h1PzjI0qNxCTj37v1rFyFYC5reGmcLPgyV9rYM0p84++o1e1
	xxaG6QpWnRaBMvdJfvI8nQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXX3qlO+Bnk_g8AA--.12082S7;
	Mon, 24 Mar 2025 00:49:46 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v6 5/5] MAINTAINERS: Add entry for PCI host controller helpers
Date: Mon, 24 Mar 2025 00:48:52 +0800
Message-Id: <20250323164852.430546-6-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250323164852.430546-1-18255117159@163.com>
References: <20250323164852.430546-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXX3qlO+Bnk_g8AA--.12082S7
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4xur48tFWUKw1fKF17KFg_yoWDJFc_Cr
	18GFWxZr4UGFyFkay0kFZ2vryayw4jqrn3uas7twsrAayUXFy5Jr1ktrWq9w1UZr4fGrWa
	qF98tF1xCr17CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_lApUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhgZo2fgNS+dHwAAsH

Add maintenance entry for the newly introduced PCI host controller helper
functions. These functions provide common infrastructure for capability
scanning and other shared operations across PCI host controller drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00e94bec401e..9b3236704b83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18119,6 +18119,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
 F:	drivers/pci/controller/pci-ixp4xx.c
 
+PCI DRIVER FOR HELPER FUNCTIONS
+M:	Hans Zhang <18255117159@163.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	drivers/pci/controller/pci-host-helpers.c
+
 PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
 M:	Nirmal Patel <nirmal.patel@linux.intel.com>
 R:	Jonathan Derrick <jonathan.derrick@linux.dev>
-- 
2.25.1


