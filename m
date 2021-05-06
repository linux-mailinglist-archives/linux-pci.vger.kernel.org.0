Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772FA375998
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 19:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbhEFRon (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 13:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbhEFRon (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 May 2021 13:44:43 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 May 2021 10:43:44 PDT
Received: from forward100j.mail.yandex.net (forward100j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AA0C061574
        for <linux-pci@vger.kernel.org>; Thu,  6 May 2021 10:43:44 -0700 (PDT)
Received: from myt5-70642c4590a1.qloud-c.yandex.net (myt5-70642c4590a1.qloud-c.yandex.net [IPv6:2a02:6b8:c12:2898:0:640:7064:2c45])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 5B5E850E0C1C
        for <linux-pci@vger.kernel.org>; Thu,  6 May 2021 20:38:28 +0300 (MSK)
Received: from myt3-5a0d70690205.qloud-c.yandex.net (myt3-5a0d70690205.qloud-c.yandex.net [2a02:6b8:c12:4f2b:0:640:5a0d:7069])
        by myt5-70642c4590a1.qloud-c.yandex.net (mxback/Yandex) with ESMTP id K7QNBTepQ9-cSIealA8;
        Thu, 06 May 2021 20:38:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1620322708;
        bh=0oTNph2dZC4eU/f0xJby8Sol/6DD5xZ3ZIoc3TSMnG0=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=tgEQayaCcuPkSmgPu2976zOCyne1f5CEqh7aRb84Q2JHSV03Bb8q26lrObi9GyDuf
         BIRJg79u8KunnHrGmw6W8XFgfj/9q8/zAwE1xmEMqb4EZLir6vyA7TVA+XVgNrF25G
         8qEHrSkW/MdUaqUjkfS8Bb94yi6Addhj7BTU7kuY=
Authentication-Results: myt5-70642c4590a1.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt3-5a0d70690205.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id dz985aXWLX-cRLedSm6;
        Thu, 06 May 2021 20:38:27 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Konstantin Kharlamov <Hi-Angel@yandex.ru>
To:     linux-pci@vger.kernel.org
Cc:     hi-angel@yandex.ru
Subject: [PATCH] PCI: don't power-off apple thunderbolt controller on s2idle
Date:   Thu,  6 May 2021 20:38:20 +0300
Message-Id: <20210506173820.21876-1-Hi-Angel@yandex.ru>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Macbook 2013 resuming from s2idle results in external monitor no
longer being detected, and dmesg having errors like:

    pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config space inaccessible)

and a stacktrace. The reason turned out that the hw that the quirk
powers off does not get powered on back on resume.

Thus, add a check for s2idle to the quirk, and do nothing if the suspend
mode is s2idle.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767
Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..86fedcec37e2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -27,6 +27,7 @@
 #include <linux/nvme.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
+#include <linux/suspend.h>
 #include <linux/switchtec.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
@@ -3646,6 +3647,13 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 		return;
 	if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
 		return;
+
+	/*
+	 * If suspend mode is s2idle, power won't get restored on resume.
+	 */
+	if (!pm_suspend_via_firmware())
+		return;
+
 	bridge = ACPI_HANDLE(&dev->dev);
 	if (!bridge)
 		return;
-- 
2.31.1

