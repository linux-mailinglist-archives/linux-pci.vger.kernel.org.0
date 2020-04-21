Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9C01B1CD1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 05:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgDUD2K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 23:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgDUD2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 23:28:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B984C061A0E
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 20:28:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e6so772034pjt.4
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 20:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UvuF2obS/vz7r5RB7yYAYMg8ibynstpwr3rLEw1flsc=;
        b=y3NyXrgpMV0LtSEwCxBH1cIXrKNb1rgvPCI4mPP4YqbBHnLpEEhYotoKHRbsQbhEYw
         GPxZy5OTbxg748olxqu8muf+44T8hwQqR7j/HfRBSb+3cg8H/LEgsaCmOIdSrj1gsZ0H
         IymVjfA4IM4KEuec6mKqKUw6lc6I79Y8fFXn6uL5iUWpr8cteat2LuOdbrvlv5pLO91U
         fJZINDQk5dmwusjgZqiX3VAJpGFd+5Wwjc8HyIFniFvaPex0NgXGUr3WSXWgbda9RagF
         Zib682h8M7u4cIJiTCCGy7PBxh1Veg1o15Y4xNuBmk3wRPSsJdfyxRPKPTKgnYkFelDf
         ZZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UvuF2obS/vz7r5RB7yYAYMg8ibynstpwr3rLEw1flsc=;
        b=unFXl23NTWhZpuB5lNtUkrlouGIH9te9F9Hiak6qUTHxae15PuY/60jIzRF597bFLQ
         jUXAy+Bq0QR62EEl7w+2Zq86TDTrViGKOCjEpXlG3PwibinpKKTpwTtFtLbtBuXpgDLD
         46duJyEQtqmK2uaDoyYzV+YLV2keGFFWoiH1R50NQ3xhhC5bm9uySCCUDhFRdRBQFWuj
         Jx9kRXg5r73W2oEu8E/TGYqwpGoxFN2zCTzhtjUXcUc964NiatDd9bo+BIRdwIaet3np
         X2UvImq8r4nL1sWWgRgCVzmjOh1NvRNldGihp6AvWKR7Af6lfAT8pi8rypPog2nJH5fO
         ejxw==
X-Gm-Message-State: AGi0PuaqA3KzfxgYopFa6UmucGlcp3GtHFmE0P0y/siTMCZBjyEA+XUp
        aiv/xyBGf/T4aM8pHsabvzDz7Q==
X-Google-Smtp-Source: APiQypI5WOqfV+BNdwG2elZiOjsNXt4z0SamM3dBgTM8llKL4HUvMwa58yu1y9cgwLhbQ9rAJkP5PQ==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr7266625plt.211.1587439688499;
        Mon, 20 Apr 2020 20:28:08 -0700 (PDT)
Received: from localhost.localdomain ([115.96.129.58])
        by smtp.gmail.com with ESMTPSA id i9sm944868pfk.199.2020.04.20.20.28.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 20:28:07 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     Ani Sinha <ani@anisinha.ca>, Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: pciehp: Cleanup unused EMI() and HP_SUPR_RM() macros
Date:   Tue, 21 Apr 2020 08:57:50 +0530
Message-Id: <1587439673-39652-1-git-send-email-ani@anisinha.ca>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We do not use PCIE hotplug surprise (PCI_EXP_SLTCAP_HPS) bit anymore.
Consequently HP_SUPR_RM() macro is no longer used. Let's clean it up.
EMI() macro also seems to be unused. So removing it as well. Thanks
Mika Westerberg <mika.westerberg@linux.intel.com> for
pointing it out.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index ae44f46..4fd200d 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -148,8 +148,6 @@ struct controller {
 #define MRL_SENS(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
 #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
 #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
-#define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
-#define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
 
-- 
2.7.4

