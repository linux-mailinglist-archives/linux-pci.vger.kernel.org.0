Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B74C391D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 23:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiBXWtX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 17:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbiBXWtB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 17:49:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08417AEC1;
        Thu, 24 Feb 2022 14:48:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADACA61B71;
        Thu, 24 Feb 2022 22:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4585C340E9;
        Thu, 24 Feb 2022 22:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645742906;
        bh=etvCtvE2dnjsW/1pUOALGGQFm8wZpzxHqa4i0OnZD/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qG8arAVauhLUN8nQ/us0Pyix+gd92fczmJNQst8Zazyc6hCEIrf97GkcJvnkC/iJq
         Fuo+okUAxXh4Y+Dnrn11JQWARsV75ZcWRdq09Q+LcAxjpZCAGbjwoWryhzYzNKGqpo
         IIqnXUcqe4RzHnhTOw3V/lMoY9PTpRLUClW9yW53+2A9iWmXk9L2kZbJMCjzeh38pS
         3L+ljK5xy9dVYqUKG5RJtrqNWem4weHzyZChAdQxXX+BLNjEi5rSgeeeS1bCgrEnXF
         6MdOHZpG4WVVAlcc4DcQ1T0dFQTZW5ClRlB/wUBFpG/C+s6kYaC24ehAjjD/HyjgiV
         owuQrHWvnbVXw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v9 11/11] PCI/VGA: Replace full MIT license text with SPDX identifier
Date:   Thu, 24 Feb 2022 16:47:53 -0600
Message-Id: <20220224224753.297579-12-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224224753.297579-1-helgaas@kernel.org>
References: <20220224224753.297579-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index d6e77c6a9a1a..f80b6ec88dc3 100644
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

