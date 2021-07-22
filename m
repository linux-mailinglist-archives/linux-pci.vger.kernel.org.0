Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7153D2F24
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 23:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhGVUtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 16:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231824AbhGVUtA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 16:49:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1343660EB4;
        Thu, 22 Jul 2021 21:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626989375;
        bh=+LKRbiNvmHkl8/IrviCxFfiMWC8MpEArh68DHC/vlAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtgsCzGCBCaLunfh+FGJr+czlx/ToitKRHx9PTOSEdRYNpY5kSIN+Mql3RM9noXbv
         aNLootyCBPaLGRBx8E2Riio9M3AmkzDRZdnb95Lj7dK+4a22DX01boSk4t5E+yozQN
         0SG3mtsJOdx+/WTc4/fNyRc1sF5+JL3cBdOU3+my+o3jd0HlRHkiPdMlWiH6YFhn/L
         yzellZ1K+qtdc5sITJ4iRjFcPATcJdnA2Bg073VT4zdAaaMflqtAeYjaLMu0JDzIMM
         iCgF6X3hF9S8O9yIp363jrIZ+LfBddjyRj+/903bHe7pr6dSA5zZvciOjbz1FJ5Zn8
         I/dFyF2DX96bQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/9] PCI/VGA: Use unsigned format string to print lock counts
Date:   Thu, 22 Jul 2021 16:29:14 -0500
Message-Id: <20210722212920.347118-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722212920.347118-1-helgaas@kernel.org>
References: <20210722212920.347118-1-helgaas@kernel.org>
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
---
 drivers/pci/vgaarb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 61b57abcb014..e4153ab70481 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1022,7 +1022,7 @@ static ssize_t vga_arb_read(struct file *file, char __user *buf,
 
 	/* Fill the buffer with infos */
 	len = snprintf(lbuf, 1024,
-		       "count:%d,PCI:%s,decodes=%s,owns=%s,locks=%s(%d:%d)\n",
+		       "count:%d,PCI:%s,decodes=%s,owns=%s,locks=%s(%u:%u)\n",
 		       vga_decode_count, pci_name(pdev),
 		       vga_iostate_to_str(vgadev->decodes),
 		       vga_iostate_to_str(vgadev->owns),
-- 
2.25.1

