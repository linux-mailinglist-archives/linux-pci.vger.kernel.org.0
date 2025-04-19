Return-Path: <linux-pci+bounces-26286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F89A94399
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 15:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48608A2628
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBF32AE86;
	Sat, 19 Apr 2025 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iH28avn5"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A3F1BC5C;
	Sat, 19 Apr 2025 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745069501; cv=none; b=h2BCThbJHt4k+JePhsDbVuIgJ7pNKOWl7M9PZv6Rgq6VOOM4thqUrhYlRTwvzqBixp50jTuoQB5CHzZvW026A3rFHO/t1wSAufav9IDYYwPRJxdaUKb9ZSLf/hWlWlAQyEv0oV3wp1LJO/7GgH4aKvqHkUpVfPBs/Da4PVjtquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745069501; c=relaxed/simple;
	bh=ssXIJJuGP95RkgCpmKHU+tZmzEYFmzhw+s+rRGRogrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgVr9CrApjJqruubZzLh8/Fx+rSq43HSeM0WxIJGZLNGlfmFqzALPT5Ee4A81YHMmsYv2dXah9qqwQ/VTv35ImwDLyowng5u9ON3t5kPSvuKWCj4lD0uui1Udnc3+IlNpfsiAIDAzeXpv092fbpvJxKIKH5h0UA+Fh34lnef5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iH28avn5; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aV77m
	p3/Eh1DGD/CUm+p8HEbcIqk8afWhv5HTlvgT6c=; b=iH28avn58vigPgrFxGndf
	5FsCVpP6yq9qdnH4zeX1F6frMbjdguMcogQkrpoWzszqPHzjN+8OuvdHBQxbcx++
	DCNhnkcMwmEGWu0lV0kxER4IdG5/VzF5eXATgzgdC1KAIylfha227FqOhTkKdsEp
	ZaR2dQbMQ7xkOiJhbAXbgo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAXnlSVpQNokyeUBA--.14018S2;
	Sat, 19 Apr 2025 21:31:02 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s-vadapalli@ti.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2] PCI: cadence: Fix runtime atomic count underflow.
Date: Sat, 19 Apr 2025 21:30:58 +0800
Message-Id: <20250419133058.162048-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXnlSVpQNokyeUBA--.14018S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw18ArWUXryDXr18Cr15urg_yoW8XF1UpF
	ZFgryxJ3WfXayYvan7Z3ZrXFyayasxt34DJ392kw1fZF13C3yUtrsFkFyjqFy7KrZFqr13
	J3WqqasxCF45JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi7PE3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx80o2gDoOGcEwAAs2

If the call to pci_host_probe() in cdns_pcie_host_setup()
fails, PM runtime count is decremented in the error path using
pm_runtime_put_sync().But the runtime count is not incremented by this
driver, but only by the callers (cdns_plat_pcie_probe/j721e_pcie_probe).
And the callers also decrement theruntime PM count in their error path.
So this leads to the below warning from the PM core:

runtime PM usage count underflow!

So fix it by getting rid of pm_runtime_put_sync() in the error path and
directly return the errno.

Fixes: 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe controller")

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8af95e9da7ce..741e10a575ec 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -570,14 +570,5 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	if (!bridge->ops)
 		bridge->ops = &cdns_pcie_host_ops;
 
-	ret = pci_host_probe(bridge);
-	if (ret < 0)
-		goto err_init;
-
-	return 0;
-
- err_init:
-	pm_runtime_put_sync(dev);
-
-	return ret;
+	return pci_host_probe(bridge);
 }

base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
-- 
2.25.1


