Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DFF42E8D6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 08:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhJOGV0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 02:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231152AbhJOGV0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 02:21:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89CF561090;
        Fri, 15 Oct 2021 06:19:18 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V7 05/11] PCI/VGA: Prefer VGA device belongs to integrated GPU
Date:   Fri, 15 Oct 2021 14:15:06 +0800
Message-Id: <20211015061512.2941859-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015061512.2941859-1-chenhuacai@loongson.cn>
References: <20211015061512.2941859-1-chenhuacai@loongson.cn>
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

