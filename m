Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26522EAC30
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 14:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbhAENox (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 08:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbhAENow (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2021 08:44:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D27C061795
        for <linux-pci@vger.kernel.org>; Tue,  5 Jan 2021 05:44:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v14so3076571wml.1
        for <linux-pci@vger.kernel.org>; Tue, 05 Jan 2021 05:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hp+FXY/j+HS1RZY1QPCjRJHJ011MN+/S057cH09kSZs=;
        b=Bxrd3/zrHtZFlcg9No5k3H03zGO6iHX15NG1AZTMYc7Ng9vEIpuGlqq44W73lwetV6
         fMA7uOIIsPAPsg1f1CxdrWL164L3qJlgJG1h7vaSLiapwq414qWh5D3JH4poemMxla6E
         4B2kkt/gejIKWcR+j6lfgmcoM0VmfDkaLTRgcLxQDFSG7Zd3ubJTBjyMj57mT5AOyIyw
         CBWhTDiFlD83wSML+AgFYErqJxS5dvHUjzesuzGM25DKt99PKAAZB46Vyq1THUNSlh8g
         7CexgOJ0G5RWhTvh3VEgC0474S/KnMYExwLNwOGfVdyVw4ZIj1IePFHf9kxhMbYcMTNc
         Rpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hp+FXY/j+HS1RZY1QPCjRJHJ011MN+/S057cH09kSZs=;
        b=J1UnghxIoEzh3roMKEhow9kWBbg3x1T113UsPKGV2TZirqrSJJ0AXDRbjiLoWtUI3A
         955ByoBx19ab9MXBTU/pCf7xF6q1qeKJIUpadedKg/yGkm72+5JyS/iguQk1bdtJ+WwI
         jFsuTUu7YX4bPPDsy5eNQyEs9WztOegvCG9bkt7NFSrjTVsDJfahPXx7cxC0rUH5WHNF
         61hSkJ9/VRuls5RFvqJl/7dfFHP5dVA8clefB4G97fRDCZYFyQ9V8vyzQGeYz9lIWow0
         pOA80XBW1/ZIQZ9CcPTFsgzevjSFnZsFaAZLhNhVk2FxdINTjHerFdkfDbDsh0jGKii+
         Zrpw==
X-Gm-Message-State: AOAM531FZbJBBwpsdoDM1H4nE+J7cwDiOjeFxTm6CM+SNIEgJEyk6AX+
        UB3diVhVTQItFuPCFi+UlWY=
X-Google-Smtp-Source: ABdhPJz7Dxb6nnjRrvu9rS/LYHVJIiS73Lk13z8bDFfT28Aif2E3DZKCZs3vAjf70aQm1RjwchIn9A==
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr3563620wma.18.1609854250423;
        Tue, 05 Jan 2021 05:44:10 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:3137:60b9:8d8f:7f55])
        by smtp.gmail.com with ESMTPSA id l20sm102191243wrh.82.2021.01.05.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:44:10 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     bhelgaas@google.com
Cc:     devspam@moreofthesa.me.uk, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/4] pci: add BAR bytes->size helper & expose size->bytes helper v2
Date:   Tue,  5 Jan 2021 14:44:02 +0100
Message-Id: <20210105134404.1545-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105134404.1545-1-christian.koenig@amd.com>
References: <20210105134404.1545-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Darren Salt <devspam@moreofthesa.me.uk>

This is to assist driver modules which do BAR resizing.

v2 (chk): Use ilog2 and make the new funtion extra defensive.
	  Also use the new function on the two existing ocassions.

Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +--
 drivers/pci/pci.c                          |  2 +-
 drivers/pci/pci.h                          |  4 ----
 include/linux/pci.h                        | 12 ++++++++++++
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dce0e66b2364..70acd673e3f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1089,8 +1089,7 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
  */
 int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 {
-	u64 space_needed = roundup_pow_of_two(adev->gmc.real_vram_size);
-	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) - 1;
+	u32 rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
 	struct pci_bus *root;
 	struct resource *res;
 	unsigned i;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ef80ed451415..16216186b51c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1648,7 +1648,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
 		res = pdev->resource + bar_idx;
-		size = ilog2(resource_size(res)) - 20;
+		size = pci_rebar_bytes_to_size(resource_size(res));
 		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
 		ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
 		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 640ae7d74fc3..0fa31ff3d4e4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -610,10 +610,6 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
-static inline u64 pci_rebar_size_to_bytes(int size)
-{
-	return 1ULL << (size + 20);
-}
 
 struct device_node;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9999040cfad9..673606f871b7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1226,6 +1226,18 @@ void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
 void pci_release_resource(struct pci_dev *dev, int resno);
+
+static __always_inline int pci_rebar_bytes_to_size(u64 bytes)
+{
+	bytes = roundup_pow_of_two(bytes);
+	return max(ilog2(bytes), 20) - 20;
+}
+
+static __always_inline u64 pci_rebar_size_to_bytes(int size)
+{
+	return 1ULL << (size + 20);
+}
+
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
-- 
2.25.1

