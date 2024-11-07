Return-Path: <linux-pci+bounces-16243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3B59C0911
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6FE1F21043
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10363212D0B;
	Thu,  7 Nov 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EzIyusrH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42331F8EFF
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990296; cv=none; b=QkrkWupQUemkN0n5YJ7KEdbUlro4z+R/aM2ZFDYGC0Zuuj9eLrwmOeYmvARsj8/Gg+PwE3+BhqXEnoPH3Ahk17k0mHCLWGsSROwbdkLfvdYyi+BgLp9XBcAHzkRCxnl4fNu4c94ZNaCCmj22XYPYaH5lYLtt8uCFIy4hjw2ovO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990296; c=relaxed/simple;
	bh=+//tYRZ2pj95k/0HCphckqrFk8TZ2PPvWYm549pQdRw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HOcUkxptNwKAsToFVCm5eGe10zE+7ulee9BvsfRjzT+Zowb56R90yvfQrFAo9XgHaXMyrHSbVlHq5SpZfjakAOQ4+JISvJQJyiCqG1Y9SVaZqq+7chY89Yhq759A0Cl2bXd+X6pvbbd++bohJqiLjuxijaHLFHmr1Nk52tSoiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EzIyusrH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720e94d36c8so1977968b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 07 Nov 2024 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730990292; x=1731595092; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wL5FDRhPfeyJSPnDftlIi6tQzypn+DUnCGufSshoMeI=;
        b=EzIyusrHV94mk4XVJUBBEGWKqlESovVcB0Ns6bS50L0rklCD0grAN0X/eM4hluy5KG
         ozXNR8HlIXUE+0J5LyPlw5OC99vjmz6dLZ5+l15hnx3X7ENTt0Puy+tYWj3h04fCZhB2
         lSd6nYJN7VYRe+IWpdiZUxC3e0Djsav/wCLLM8gU2pj9uGF2+1ehnsjs6bNAaaRK9blr
         s9EU3aCKiOpxF+swNULGBGmLyCBB6QlfdrU+Cosdsxr4FbN9Zm137FDdingqm7Oc92AP
         oahhqPGAQwra4KdTAS2CkhA8NcZyHwP8Za1IbaqvJz//D4H6bvfyq0B0JI25mBp/mymY
         1SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730990292; x=1731595092;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wL5FDRhPfeyJSPnDftlIi6tQzypn+DUnCGufSshoMeI=;
        b=ZHgQiOWaPnkzDBXefVhieFc0Eeukk+LdzwvCZeBGLdLBlAZ/6NnKPssr1HQ2wngYUB
         pGeS4fX8CMyNMW/kd+t0dC72G23jgud00VwnCPzqolaCGhshZxDkjleTZuXABvFysGcZ
         HF7uG5YfydSKfPDN8/YKFXncazQY7XIdpnjqaivou6m2OrcBlda4EQ+ZHIuygIGZZCrN
         8KAZ2QKF3my2Db2etr++mdUSI2ufsPqYEo3Ul0s4IGOmqGgUVkvqUvi9WQ6e7NLFJ2rZ
         gR1FOpTVV7YSOKl3nyQ5ius/Uc9FRy7eBOBFcyvvJjqbgf0rCfuXBH/5+qzFvZKzkKp7
         xhqw==
X-Gm-Message-State: AOJu0YyHwmsKGXXRS2xAMsR7lhfuFTZ87pBIsLSA6xB1M9Akkjlxk3V/
	j1b44qgEUZ3YwejjNX7riKFKx9ex1wszWf6StPPV86i2rDje3NuonY2kH6K3cHU=
X-Google-Smtp-Source: AGHT+IG20qa8SvuiM/MDu1UgLQkGwgxBXyCUgUI6UBnitN6mJQysCwLmO4P4trtchp727A7EvWqetQ==
X-Received: by 2002:a05:6a20:d81a:b0:1d9:3acf:8bdd with SMTP id adf61e73a8af0-1dc1e465066mr272204637.22.1730990292157;
        Thu, 07 Nov 2024 06:38:12 -0800 (PST)
Received: from 5CG3510V44-KVS.localdomain ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5e9eb5sm1478629a12.45.2024.11.07.06.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:38:11 -0800 (PST)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: bhelgaas@google.com,
	macro@orcam.me.uk
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	guojinhui.liam@bytedance.com
Subject: [RFC] PCI: Fix the issue of link speed downgrade after link retraining
Date: Thu,  7 Nov 2024 22:37:58 +0800
Message-Id: <20241107143758.12643-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The link speed is downgraded to 2.5 GT/s when a Samsung NVMe device
is hotplugged into a Intel PCIe root port [8086:0db0].

```
+-[0000:3c]-+-00.0  Intel Corporation Ice Lake Memory Map/VT-d
|           ...
|           +02.0-[3d]----00.0  Samsung Electronics Co Ltd Device a80e
```

Some printing information can be obtained when the issue emerges.
"Card present" is reported twice via external interrupts due to
a slight tremor when the Samsung NVMe device is plugged in.
The failure of the link activation for the first time leads to
the link speed of the root port being mistakenly downgraded to 2.5G/s.

```
[ 8223.419682] pcieport 0000:3d:02.0: pciehp: Slot(1): Card present
[ 8224.449714] pcieport 0000:3d:02.0: broken device, retraining non-functional downstream link at 2.5GT/s
[ 8225.518723] pcieport 0000:3d:02.0: pciehp: Slot(1): Card present
[ 8225.518726] pcieport 0000:3d:02.0: pciehp: Slot(1): Link up
```

To avoid wrongly setting the link speed to 2.5GT/s, only allow
specific pcie devices to perform link retrain.

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/pci/quirks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dccb60c1d9cc..59858156003b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -91,7 +91,8 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	int ret = -ENOTTY;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
-	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
+	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting ||
+		!pci_match_id(ids, dev))
 		return ret;
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
@@ -119,8 +120,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	}
 
 	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
-	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
-	    pci_match_id(ids, dev)) {
+	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
 		u32 lnkcap;
 
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
-- 
2.20.1


