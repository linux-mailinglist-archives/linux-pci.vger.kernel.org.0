Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8EA16C05
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfEGUM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 16:12:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40752 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfEGUM5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 16:12:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so4771318wre.7
        for <linux-pci@vger.kernel.org>; Tue, 07 May 2019 13:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93Jcsgep0R0A0N9Dr5m56DS8FTS0C2WwOTkkQWhbHyo=;
        b=pRkqh4ECA0gjsVeYSI/hwVrhbhwuqvV5/hOgT9q0oq93wZxAv2EL2JaKwslA1b8GOy
         PCqvngoqb5+ZUM4/PiY1xgeVGyIl80vtuimZlsXGZm8Ej/pxdmMXZb7bAierhb4LNvZg
         TUsHn7EarbMfbsIRXKC2lab+3kIHTGslRVFjNmaUD3alrDp5io9uuqSHFN4Lk+BLny1n
         a6gXtHJZY41ev6wCo8qx3NVP+cxlapR5InXcqSDhYOO7xbXrMbr71FTZ3536rO5F5BHa
         uzoB0w22JaiFzPTCxndDcGP9YoZYPoG+K4Q6nxCyWygh42s+njB1/MTYrskjk2Jg5bau
         SEQA==
X-Gm-Message-State: APjAAAU6Sn1mypffAHtp4pFflJuCMrX03lQ1VOA30dUutRrnIT4j2m3w
        HbWZmj1hC3ni0ZJmRX95JnBK2g==
X-Google-Smtp-Source: APXvYqx4e2uhHe+Go510Nty8fUqVTqbLfz8UfSFIX+gESi/Tdp6VeYde/Z4aQ2jARnVlLg3tW8gUEQ==
X-Received: by 2002:a5d:4704:: with SMTP id y4mr21681200wrq.86.1557259976061;
        Tue, 07 May 2019 13:12:56 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:ac7d:46be:871b:a956])
        by smtp.gmail.com with ESMTPSA id c10sm31816882wrd.69.2019.05.07.13.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 13:12:55 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Lyude Paul <lyude@redhat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2 3/4] pci: add nvkm_pcie_get_speed
Date:   Tue,  7 May 2019 22:12:44 +0200
Message-Id: <20190507201245.9295-4-kherbst@redhat.com>
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
 drm/nouveau/include/nvkm/subdev/pci.h | 1 +
 drm/nouveau/nvkm/subdev/pci/pcie.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drm/nouveau/include/nvkm/subdev/pci.h b/drm/nouveau/include/nvkm/subdev/pci.h
index 23803cc8..1fdf3098 100644
--- a/drm/nouveau/include/nvkm/subdev/pci.h
+++ b/drm/nouveau/include/nvkm/subdev/pci.h
@@ -53,4 +53,5 @@ int gp100_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
 
 /* pcie functions */
 int nvkm_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8 width);
+enum nvkm_pcie_speed nvkm_pcie_get_speed(struct nvkm_pci *);
 #endif
diff --git a/drm/nouveau/nvkm/subdev/pci/pcie.c b/drm/nouveau/nvkm/subdev/pci/pcie.c
index d71e5db5..70ccbe0d 100644
--- a/drm/nouveau/nvkm/subdev/pci/pcie.c
+++ b/drm/nouveau/nvkm/subdev/pci/pcie.c
@@ -163,3 +163,11 @@ nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
 
 	return ret;
 }
+
+enum nvkm_pcie_speed
+nvkm_pcie_get_speed(struct nvkm_pci *pci)
+{
+	if (!pci || !pci_is_pcie(pci->pdev) || !pci->pcie.cur_speed)
+		return -ENODEV;
+	return pci->func->pcie.cur_speed(pci);
+}
-- 
2.21.0

