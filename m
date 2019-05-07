Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A6C16C06
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 22:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEGUM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 16:12:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36720 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfEGUM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 16:12:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id o4so24052037wra.3
        for <linux-pci@vger.kernel.org>; Tue, 07 May 2019 13:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RROi8SlwMJ02bHieui3zTPkNYxQoLW/1VbRtWb7o0cQ=;
        b=XWRKbRGTcO9fbaLOPYb+J+eZiaoDCjDanT8OlwufM9m8HwOJq3ClJ5xn2hsdjmnUBy
         wMg2EW3LVtw6+67MFjF20sUa2bFNuwE4s6NsAVf7bYzew+ZCzZxJpO9WrW7NS7xdyQpf
         vP86Zz74kW+/r2p/hzhcswqNGJ0PldcVxve//OdSHtSnXbu2t1bvSo2p2/3S2Td4W4bT
         04MJMUoMOzdnCTCM47WKcdFnJWRnvBRgCIXeboyZ405QtkYrnhbt0urHrCglW5+rIf7C
         bJU/s4ykKwuvU0g3ARHcsM+aT98szGdOnqWTO/toRknMFyHqzFtNwfb3fu/DQg5wxDNo
         IMFQ==
X-Gm-Message-State: APjAAAUDqI3GMn39JFaMybvKSfzsDlRvTqifffdPuaUpRE4lUdvqO10C
        L3K0vh7vbGzvDj1wmKfjaiuBXQ==
X-Google-Smtp-Source: APXvYqyO80NngiFbIywObAHb8DiWkgblM37tAnYiuApiyBX1bXCJMfqXmCbQilfWDxpHgNxw1gaU+Q==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr23786304wrm.329.1557259977546;
        Tue, 07 May 2019 13:12:57 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:ac7d:46be:871b:a956])
        by smtp.gmail.com with ESMTPSA id c10sm31816882wrd.69.2019.05.07.13.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 13:12:56 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Lyude Paul <lyude@redhat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2 4/4] pci: save the boot pcie link speed and restore it on fini
Date:   Tue,  7 May 2019 22:12:45 +0200
Message-Id: <20190507201245.9295-5-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507201245.9295-1-kherbst@redhat.com>
References: <20190507201245.9295-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Apperantly things go south if we suspend the device with a different PCIE
link speed set than it got booted with. Fixes runtime suspend on my gp107.

This all looks like some bug inside the pci subsystem and I would prefer a
fix there instead of nouveau, but maybe there is no real nice way of doing
that outside of drivers?

v2: squashed together patch 4 and 5

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drm/nouveau/include/nvkm/subdev/pci.h |  5 +++--
 drm/nouveau/nvkm/subdev/pci/base.c    |  9 +++++++--
 drm/nouveau/nvkm/subdev/pci/pcie.c    | 24 ++++++++++++++++++++----
 drm/nouveau/nvkm/subdev/pci/priv.h    |  2 ++
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drm/nouveau/include/nvkm/subdev/pci.h b/drm/nouveau/include/nvkm/subdev/pci.h
index 1fdf3098..b23793a2 100644
--- a/drm/nouveau/include/nvkm/subdev/pci.h
+++ b/drm/nouveau/include/nvkm/subdev/pci.h
@@ -26,8 +26,9 @@ struct nvkm_pci {
 	} agp;
 
 	struct {
-		enum nvkm_pcie_speed speed;
-		u8 width;
+		enum nvkm_pcie_speed cur_speed;
+		enum nvkm_pcie_speed def_speed;
+		u8 cur_width;
 	} pcie;
 
 	bool msi;
diff --git a/drm/nouveau/nvkm/subdev/pci/base.c b/drm/nouveau/nvkm/subdev/pci/base.c
index ee2431a7..d9fb5a83 100644
--- a/drm/nouveau/nvkm/subdev/pci/base.c
+++ b/drm/nouveau/nvkm/subdev/pci/base.c
@@ -90,6 +90,8 @@ nvkm_pci_fini(struct nvkm_subdev *subdev, bool suspend)
 
 	if (pci->agp.bridge)
 		nvkm_agp_fini(pci);
+	else if (pci_is_pcie(pci->pdev))
+		nvkm_pcie_fini(pci);
 
 	return 0;
 }
@@ -100,6 +102,8 @@ nvkm_pci_preinit(struct nvkm_subdev *subdev)
 	struct nvkm_pci *pci = nvkm_pci(subdev);
 	if (pci->agp.bridge)
 		nvkm_agp_preinit(pci);
+	else if (pci_is_pcie(pci->pdev))
+		nvkm_pcie_preinit(pci);
 	return 0;
 }
 
@@ -193,8 +197,9 @@ nvkm_pci_new_(const struct nvkm_pci_func *func, struct nvkm_device *device,
 	pci->func = func;
 	pci->pdev = device->func->pci(device)->pdev;
 	pci->irq = -1;
-	pci->pcie.speed = -1;
-	pci->pcie.width = -1;
+	pci->pcie.cur_speed = -1;
+	pci->pcie.def_speed = -1;
+	pci->pcie.cur_width = -1;
 
 	if (device->type == NVKM_DEVICE_AGP)
 		nvkm_agp_ctor(pci);
diff --git a/drm/nouveau/nvkm/subdev/pci/pcie.c b/drm/nouveau/nvkm/subdev/pci/pcie.c
index 70ccbe0d..731dd30e 100644
--- a/drm/nouveau/nvkm/subdev/pci/pcie.c
+++ b/drm/nouveau/nvkm/subdev/pci/pcie.c
@@ -85,6 +85,13 @@ nvkm_pcie_oneinit(struct nvkm_pci *pci)
 	return 0;
 }
 
+int
+nvkm_pcie_preinit(struct nvkm_pci *pci)
+{
+	pci->pcie.def_speed = nvkm_pcie_get_speed(pci);
+	return 0;
+}
+
 int
 nvkm_pcie_init(struct nvkm_pci *pci)
 {
@@ -105,12 +112,21 @@ nvkm_pcie_init(struct nvkm_pci *pci)
 	if (pci->func->pcie.init)
 		pci->func->pcie.init(pci);
 
-	if (pci->pcie.speed != -1)
-		nvkm_pcie_set_link(pci, pci->pcie.speed, pci->pcie.width);
+	if (pci->pcie.cur_speed != -1)
+		nvkm_pcie_set_link(pci, pci->pcie.cur_speed,
+				   pci->pcie.cur_width);
 
 	return 0;
 }
 
+int
+nvkm_pcie_fini(struct nvkm_pci *pci)
+{
+	if (!IS_ERR_VALUE(pci->pcie.def_speed))
+		return nvkm_pcie_set_link(pci, pci->pcie.def_speed, 16);
+	return 0;
+}
+
 int
 nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
 {
@@ -146,8 +162,8 @@ nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
 		speed = max_speed;
 	}
 
-	pci->pcie.speed = speed;
-	pci->pcie.width = width;
+	pci->pcie.cur_speed = speed;
+	pci->pcie.cur_width = width;
 
 	if (speed == cur_speed) {
 		nvkm_debug(subdev, "requested matches current speed\n");
diff --git a/drm/nouveau/nvkm/subdev/pci/priv.h b/drm/nouveau/nvkm/subdev/pci/priv.h
index a0d4c007..e7744671 100644
--- a/drm/nouveau/nvkm/subdev/pci/priv.h
+++ b/drm/nouveau/nvkm/subdev/pci/priv.h
@@ -60,5 +60,7 @@ enum nvkm_pcie_speed gk104_pcie_max_speed(struct nvkm_pci *);
 int gk104_pcie_version_supported(struct nvkm_pci *);
 
 int nvkm_pcie_oneinit(struct nvkm_pci *);
+int nvkm_pcie_preinit(struct nvkm_pci *);
 int nvkm_pcie_init(struct nvkm_pci *);
+int nvkm_pcie_fini(struct nvkm_pci *);
 #endif
-- 
2.21.0

