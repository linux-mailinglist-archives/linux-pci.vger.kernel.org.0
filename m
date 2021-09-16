Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB040D49D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 10:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhIPIe5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 04:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235069AbhIPIe5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Sep 2021 04:34:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04CB861242;
        Thu, 16 Sep 2021 08:33:34 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V6 05/12] PCI/VGA: Prefer VGA device belongs to integrated GPU
Date:   Thu, 16 Sep 2021 16:29:34 +0800
Message-Id: <20210916082941.3421838-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210916082941.3421838-1-chenhuacai@loongson.cn>
References: <20210916082941.3421838-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch is the third step of the rework: A VGA device belongs to
integrated GPU is more preferred than those not belong to.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/vga/vgaarb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 1ffc3decc9cb..1daf2a011f83 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -605,6 +605,11 @@ static void vga_arb_update_default_device(struct vga_device *vgadev)
 		vgaarb_info(dev, "overriding boot VGA device\n");
 		vga_set_default_device(pdev);
 	}
+
+	if (vga_arb_integrated_gpu(dev) && vgadev->pdev != vga_default_device()) {
+		vgaarb_info(dev, "overriding boot VGA device\n");
+		vga_set_default_device(pdev);
+	}
 }
 
 /*
-- 
2.27.0

