Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143DD42E999
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 09:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhJOHDV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 03:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234350AbhJOHDU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 03:03:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E839161163;
        Fri, 15 Oct 2021 07:01:12 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V7 11/11] PCI/VGA: Replace full MIT license text with SPDX identifier
Date:   Fri, 15 Oct 2021 14:58:44 +0800
Message-Id: <20211015065844.2957617-3-chenhuacai@loongson.cn>
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

Per Documentation/process/license-rules.rst, the SPDX MIT identifier is
equivalent to including the entire MIT license text from
LICENSES/preferred/MIT.

Replace the MIT license text with the equivalent SPDX identifier.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/gpu/vga/vgaarb.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 8d07279cb49d..ee9e4dab6b35 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
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

