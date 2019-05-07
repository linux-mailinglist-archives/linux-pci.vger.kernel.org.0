Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2223C16C04
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEGUM4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 16:12:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40869 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfEGUMz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 16:12:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id h11so170517wmb.5
        for <linux-pci@vger.kernel.org>; Tue, 07 May 2019 13:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWnxiXYjZInuVDA/vvb3HsiV3BJ5ciwWb5fNiHnPcxU=;
        b=ct28vQBco+RonITFZ0Zs+w9pfpxKNMMSgA91k+MMwGNAy6boDcRoidBJBSJO5QgMyS
         lrBS0j+hgV0vZJILmSLFU8J0x0XssRJM4yYfg+puIX1ZMDD99JF1az93XSyN3oxQpMuz
         y1VSKvC3G69loQby4jNua4GdKVh+TUpIM47VUJgiQ/Ly8k2nuh+Cgjp0LCOrSxK9uefk
         VuXK2BITF7TAgGeS5leU0vmsnTKG2+mXpV2FCarEtPvAQnnWAI6RgaczBi2YsaXRLw1b
         61mViGuh4/ovT693atVaPOV2eNe9Qju8otEQFIPb6MNo6apE0WbtVGAhLsfqSik6DJWL
         JHiw==
X-Gm-Message-State: APjAAAX/58mGcMIxe4mpaOuyF0XbsPX1W9t03cVWibYVbqxUAW9ALlpW
        aUbuyiP77wmvuB8xXZRLo1B9yg==
X-Google-Smtp-Source: APXvYqwHz/fQR5i/XrVDQgBaM3nU3N99X8v78gJojAGu+SGzDpD1WNA1lNoQ4fTC42CqR7LJX2ZgXg==
X-Received: by 2002:a1c:eb03:: with SMTP id j3mr153026wmh.15.1557259974177;
        Tue, 07 May 2019 13:12:54 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:ac7d:46be:871b:a956])
        by smtp.gmail.com with ESMTPSA id c10sm31816882wrd.69.2019.05.07.13.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 13:12:53 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Lyude Paul <lyude@redhat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2 2/4] pci: enable pcie link changes for pascal
Date:   Tue,  7 May 2019 22:12:43 +0200
Message-Id: <20190507201245.9295-3-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507201245.9295-1-kherbst@redhat.com>
References: <20190507201245.9295-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drm/nouveau/nvkm/subdev/pci/gk104.c |  8 ++++----
 drm/nouveau/nvkm/subdev/pci/gp100.c | 10 ++++++++++
 drm/nouveau/nvkm/subdev/pci/priv.h  |  5 +++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drm/nouveau/nvkm/subdev/pci/gk104.c b/drm/nouveau/nvkm/subdev/pci/gk104.c
index e6803050..66489018 100644
--- a/drm/nouveau/nvkm/subdev/pci/gk104.c
+++ b/drm/nouveau/nvkm/subdev/pci/gk104.c
@@ -23,7 +23,7 @@
  */
 #include "priv.h"
 
-static int
+int
 gk104_pcie_version_supported(struct nvkm_pci *pci)
 {
 	return (nvkm_rd32(pci->subdev.device, 0x8c1c0) & 0x4) == 0x4 ? 2 : 1;
@@ -108,7 +108,7 @@ gk104_pcie_lnkctl_speed(struct nvkm_pci *pci)
 	return -1;
 }
 
-static enum nvkm_pcie_speed
+enum nvkm_pcie_speed
 gk104_pcie_max_speed(struct nvkm_pci *pci)
 {
 	u32 max_speed = nvkm_rd32(pci->subdev.device, 0x8c1c0) & 0x300000;
@@ -146,7 +146,7 @@ gk104_pcie_set_link_speed(struct nvkm_pci *pci, enum nvkm_pcie_speed speed)
 	nvkm_mask(device, 0x8c040, 0x1, 0x1);
 }
 
-static int
+int
 gk104_pcie_init(struct nvkm_pci * pci)
 {
 	enum nvkm_pcie_speed lnkctl_speed, max_speed, cap_speed;
@@ -178,7 +178,7 @@ gk104_pcie_init(struct nvkm_pci * pci)
 	return 0;
 }
 
-static int
+int
 gk104_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
 {
 	struct nvkm_subdev *subdev = &pci->subdev;
diff --git a/drm/nouveau/nvkm/subdev/pci/gp100.c b/drm/nouveau/nvkm/subdev/pci/gp100.c
index 82c5234a..eb19c7a4 100644
--- a/drm/nouveau/nvkm/subdev/pci/gp100.c
+++ b/drm/nouveau/nvkm/subdev/pci/gp100.c
@@ -35,6 +35,16 @@ gp100_pci_func = {
 	.wr08 = nv40_pci_wr08,
 	.wr32 = nv40_pci_wr32,
 	.msi_rearm = gp100_pci_msi_rearm,
+
+	.pcie.init = gk104_pcie_init,
+	.pcie.set_link = gk104_pcie_set_link,
+
+	.pcie.max_speed = gk104_pcie_max_speed,
+	.pcie.cur_speed = g84_pcie_cur_speed,
+
+	.pcie.set_version = gf100_pcie_set_version,
+	.pcie.version = gf100_pcie_version,
+	.pcie.version_supported = gk104_pcie_version_supported,
 };
 
 int
diff --git a/drm/nouveau/nvkm/subdev/pci/priv.h b/drm/nouveau/nvkm/subdev/pci/priv.h
index c17f6063..a0d4c007 100644
--- a/drm/nouveau/nvkm/subdev/pci/priv.h
+++ b/drm/nouveau/nvkm/subdev/pci/priv.h
@@ -54,6 +54,11 @@ int gf100_pcie_cap_speed(struct nvkm_pci *);
 int gf100_pcie_init(struct nvkm_pci *);
 int gf100_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8);
 
+int gk104_pcie_init(struct nvkm_pci *);
+int gk104_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8 width);
+enum nvkm_pcie_speed gk104_pcie_max_speed(struct nvkm_pci *);
+int gk104_pcie_version_supported(struct nvkm_pci *);
+
 int nvkm_pcie_oneinit(struct nvkm_pci *);
 int nvkm_pcie_init(struct nvkm_pci *);
 #endif
-- 
2.21.0

