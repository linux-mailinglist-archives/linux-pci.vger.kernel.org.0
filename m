Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515843F962A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 10:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbhH0IeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 04:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232180AbhH0IeH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 04:34:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74AF460EB3;
        Fri, 27 Aug 2021 08:33:17 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: [PATCH V4 02/10] PCI/VGA: Replace full MIT license text with SPDX identifier
Date:   Fri, 27 Aug 2021 16:31:21 +0800
Message-Id: <20210827083129.2781420-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210827083129.2781420-1-chenhuacai@loongson.cn>
References: <20210827083129.2781420-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Per Documentation/process/license-rules.rst, the SPDX MIT identifier is
equivalent to including the entire MIT license text from
LICENSES/preferred/MIT.

Replace the MIT license text with the equivalent SPDX identifier.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vgaarb.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 949fde433ea2..61b57abcb014 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1,32 +1,11 @@
+// SPDX-License-Identifier: MIT
 /*
  * vgaarb.c: Implements the VGA arbitration. For details refer to
  * Documentation/gpu/vgaarbiter.rst
  *
- *
  * (C) Copyright 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>
  * (C) Copyright 2007 Paulo R. Zanoni <przanoni@gmail.com>
  * (C) Copyright 2007, 2009 Tiago Vignatti <vignatti@freedesktop.org>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
- * DEALINGS
- * IN THE SOFTWARE.
- *
  */
 
 #define pr_fmt(fmt) "vgaarb: " fmt
-- 
2.27.0

