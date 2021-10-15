Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1742E993
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 09:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhJOHCQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 03:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233954AbhJOHCM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 03:02:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A83706108B;
        Fri, 15 Oct 2021 07:00:04 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V7 10/11] PCI/VGA: Use unsigned format string to print lock counts
Date:   Fri, 15 Oct 2021 14:58:43 +0800
Message-Id: <20211015065844.2957617-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015065844.2957617-1-chenhuacai@loongson.cn>
References: <20211015061512.2941859-1-chenhuacai@loongson.cn>
 <20211015065844.2957617-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

In struct vga_device, io_lock_cnt and mem_lock_cnt are unsigned, but we
previously printed them with "%d", the signed decimal format.  Print them
with the unsigned format "%u" instead.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/gpu/vga/vgaarb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 7f52db439c11..8d07279cb49d 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -1103,7 +1103,7 @@ static ssize_t vga_arb_read(struct file *file, char __user *buf,
 
 	/* Fill the buffer with infos */
 	len = snprintf(lbuf, 1024,
-		       "count:%d,PCI:%s,decodes=%s,owns=%s,locks=%s(%d:%d)\n",
+		       "count:%d,PCI:%s,decodes=%s,owns=%s,locks=%s(%u:%u)\n",
 		       vga_decode_count, pci_name(pdev),
 		       vga_iostate_to_str(vgadev->decodes),
 		       vga_iostate_to_str(vgadev->owns),
-- 
2.27.0

