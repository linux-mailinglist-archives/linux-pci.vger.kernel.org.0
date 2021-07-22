Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF61F3D2F22
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 23:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhGVUs7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 16:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhGVUs7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74D5460EB6;
        Thu, 22 Jul 2021 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626989373;
        bh=yT2wSQrJaNFX4K2jAtoq62rmvkHA7eOZeZyOwW2EwGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GeFDo7pdnWk5KDQ1Bie7jWD+3Vf2FZb/YWDJQ7sP6z1gRDurYold0JVb2+/o5PCbE
         Ujc95zZ0pAivm/XIBKHPV+6Pj+ZOxE85IFMxIdT/LUja4ZP1Hp2Fs/Y4T7CrXm6E7n
         vOmYVDavw2t+U9R6Lq8TIsccPRSAohhVIwPOTuyNAZLInXwzVVZIewG55txL8Qj79L
         SApTDydyAzyZzyrAa7v70lMOzemeFkMiJ/rRwNLVl82sJVV53ffUU5UVXifgY82Lxi
         SCT076FgDixTzAA3ptZb4HdhgdxDrNl+UVpT3WLkjYPDB7k9dRVq308B1MVHubSuCm
         6sZmEeW+CB2Cw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/9] PCI/VGA: Replace full MIT license text with SPDX identifier
Date:   Thu, 22 Jul 2021 16:29:13 -0500
Message-Id: <20210722212920.347118-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722212920.347118-1-helgaas@kernel.org>
References: <20210722212920.347118-1-helgaas@kernel.org>
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
2.25.1

