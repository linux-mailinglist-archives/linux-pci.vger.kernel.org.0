Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9B421DCB
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 20:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfEQSsc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 14:48:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54308 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQSsc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 14:48:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0658661952; Fri, 17 May 2019 18:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558118911;
        bh=OV/Plnh2chiiFpl1tPau4te8Ie4x49eB+//wLShrquY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLbsqWe5pg04GvaQ+/fmWgFjQ9vQgU0r6W6w4D75Q49UVpLOasUzByiGdcnCDgPai
         t4/T+TZQshgdfeSzVLz94992RuInbqAEoBCLsIceSSPr6Zt4eiR/k6bJ0CVdILKQd3
         e5nUdVe9NDgiApnat9fnZASHgfaWAOwRvX62jpcY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F01AD619CC;
        Fri, 17 May 2019 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558118905;
        bh=OV/Plnh2chiiFpl1tPau4te8Ie4x49eB+//wLShrquY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q5qKpN3dzD5EBfg8X33uOuhjvsyIAfJF6baPusIbikdtrA7fSJA4JsOWL4C85cVDC
         6FtobZvYMtIuxiz15DDKOE+LomXOAc/mc8XvGNFwKs80DvTeeluNDTIpqXyNMmQIN8
         HYC2NEdjPmNHGdOTajB64JomRehH+pSN1aUwCpA8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F01AD619CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, joro@8bytes.org,
        robin.murphy@arm.com, will.deacon@arm.com, kernel-team@android.com,
        pratikp@codeaurora.org, lmark@codeaurora.org
Subject: [RFC/PATCH 4/4] iommu: Add probe deferral support for IOMMU kernel modules
Date:   Fri, 17 May 2019 11:47:37 -0700
Message-Id: <1558118857-16912-5-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
References: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the IOMMU core assumes that all IOMMU drivers
will be built into the kernel. This makes it so that all
the IOMMU core will stop deferring probes when all of the
builtin kernel drivers have finished probing (i.e. when
initcalls are finished).

This is problematic if an IOMMU driver is generated as a module,
because the registration of the IOMMU driver may happen at an
unknown point in time after all builtin drivers have finished
probing.

Thus, if there exists a chance for the IOMMU driver
to be a module, then allow for clients to wait indefinitely
for the IOMMU driver to be loaded. Otherwise, rely on the
driver core to dictate when clients should stop deferring
their probes.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/of_iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index f04a6df..1e7e323 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -116,8 +116,12 @@ static int of_iommu_xlate(struct device *dev,
 	 * IOMMU device we're waiting for, which will be useful if we ever get
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
-	if (!ops)
-		return driver_deferred_probe_check_state(dev);
+	if (!ops) {
+		if (IS_ENABLED(CONFIG_MODULES))
+			return -EPROBE_DEFER;
+		else
+			return driver_deferred_probe_check_state(dev);
+	}
 
 	return ops->of_xlate(dev, iommu_spec);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

