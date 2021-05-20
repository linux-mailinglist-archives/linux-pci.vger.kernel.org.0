Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B7938BA97
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 01:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhETX4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 19:56:32 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:42126 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233104AbhETX4b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 19:56:31 -0400
Received: from myt5-e6241e9902a2.qloud-c.yandex.net (myt5-e6241e9902a2.qloud-c.yandex.net [IPv6:2a02:6b8:c12:4108:0:640:e624:1e99])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 431EC4201684;
        Fri, 21 May 2021 02:55:08 +0300 (MSK)
Received: from myt4-1dda227af9a8.qloud-c.yandex.net (myt4-1dda227af9a8.qloud-c.yandex.net [2a02:6b8:c00:3c83:0:640:1dda:227a])
        by myt5-e6241e9902a2.qloud-c.yandex.net (mxback/Yandex) with ESMTP id dQ7N38SRJ9-t7K8uL0Y;
        Fri, 21 May 2021 02:55:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1621554908;
        bh=TEOQo0lsytBfoRBP6xT3b7hriGhgnxgxQf0zcm7WU90=;
        h=In-Reply-To:References:Date:Subject:To:From:Message-Id:Cc;
        b=I3juSpzPMK7bTreWcA8LMhVs7Q2xwqKkLxdu5XboC9Io3txkLUuoAjaUClI6OLpQd
         sb7UrD3Al+CUplZKBAFMA1LtXzeg1pasnvtF8WodqRrq+6seP8v3mRvbZzV8zat7iE
         OVW3QT9rljSf/c1qLgQmYfGVTIyZp8stZOFJ0TDI=
Authentication-Results: myt5-e6241e9902a2.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt4-1dda227af9a8.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id JLlFlICQTn-t7LqcBN7;
        Fri, 21 May 2021 02:55:07 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Konstantin Kharlamov <Hi-Angel@yandex.ru>
To:     linux-pci@vger.kernel.org
Cc:     hi-angel@yandex.ru, helgaas@kernel.org, lukas@wunner.de,
        rjw@rjwysocki.net, andreas.noever@gmail.com
Subject: [PATCH v2] PCI: don't call firmware hooks on suspend unless it's fw-controlled
Date:   Fri, 21 May 2021 02:55:01 +0300
Message-Id: <20210520235501.917397-1-Hi-Angel@yandex.ru>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520194935.GA348608@bjorn-Precision-5520>
References: <20210520194935.GA348608@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Macbook 2013 resuming from s2idle resulted in external monitor no
longer being detected, and dmesg having errors like:

    pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config space inaccessible)

and a stacktrace. The reason is that in s2idle (and in S1 as noted by
Rafael) we do not call firmware code to handle suspend, and as result
while waking up firmware also does not handle resume.

This means, for the Thunderbolt controller that gets disabled in the
quirk by calling the firmware methods, there's no one to wake it back up
on resume.

To quote Rafael Wysocki:

> "Passing control to the platform firmware" means letting
> some native firmware code (like SMM code) run which happens at the end
> of S2/S3/S4 suspend transitions and it does not happen during S1
> (standby) and s2idle suspend transitions.
>
> That's why using SXIO/SXFP/SXLF is only valid during S2/S3/S4 suspend
> transitions and it is not valid during s2idle and S1 suspend
> transitions (and yes, S1 is also affected, so s2idle is not special in
> that respect at all).

Thus, return early from the quirk when suspend mode isn't one that calls
firmware.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767
Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..f86b6388a04a 100644
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
@@ -3646,6 +3647,15 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 		return;
 	if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
 		return;
+
+	/*
+	 * SXIO/SXFP/SXLF turns off power to the Thunderbolt controller.  We don't
+	 * know how to turn it back on again, but firmware does, so we can only use
+	 * SXIO/SXFP/SXLF if we're suspending via firmware.
+	 */
+	if (!pm_suspend_via_firmware())
+		return;
+
 	bridge = ACPI_HANDLE(&dev->dev);
 	if (!bridge)
 		return;
-- 
2.31.1

