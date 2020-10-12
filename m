Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A9C28AD7B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 07:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgJLFGw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 01:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgJLFGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 01:06:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B346CC0613CE;
        Sun, 11 Oct 2020 22:06:50 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so13171029pgl.2;
        Sun, 11 Oct 2020 22:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2DdiixLGTMMakBs3YqYlJkGVTHUZ/j+fWwWlzawEzt4=;
        b=kwaYSw71fASv9844Z+5fVJ80MgtyB7lC/x2w8h/+xxBHbFOeo7bu+LWpe4/kk+Gss7
         wleKcGvLPIMoqkvouQsWJW2Whx1GfKu/+XDubgvaCXfpaoYoH1NBlaxdg2nriyzDSlwx
         eHE+Fyh9fLaOfqgpZjhQ7+zQiSTksAL625zaEQ+HgdDuGtyXb4RWw7uic/pbjil6b0Si
         Y5y3kId5+DBLGcxvrfAh3zfZ4dNsCLjBcDVqPlbX7QicPYZ/TMoeIDrtHtQL7kNi8449
         zlgN5QLIzuPb/oKL5+j/1FuMlXscEtEWnXDm3/i5Gm8tMaRV1Sc+jLi5JjjNCYNIBxxw
         RjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2DdiixLGTMMakBs3YqYlJkGVTHUZ/j+fWwWlzawEzt4=;
        b=pb8MvyMC+znKtB5F3arW5I96MPpH18oIER6Fa0f0ZZyClTXql+Xv/PaL7dyO5sMkKV
         Q8SZnbVUhYfBX8WDBK55iyOedJZS32a954eFuJ5vH5LmCtoRWpGmHJXWR0J2vhMjovVW
         U+54BZkZYND4kbKwaNos9n6V27BKkGG2l5QK+7m7CGEEhwcQTi7ZbAMfZ6s7W7lbQDHC
         EVsHlwkrMwPaTEn90R8JUWPlVIG25gJFWudOYiaZGrpwBmz8G1DKLQd0wQo/lmb7bch6
         /mZo9zUonRdcAdOyvNRivlMf6ICa38LJ2iQdfwdIBvrqJUzPQ6A1+z0hv0BSIpFmh2ZW
         6h2g==
X-Gm-Message-State: AOAM530cundOREl90KfHCJfwUir7CnhbndphSW7JhqSsewqe74pPH9hq
        hjRJFdAQ5uvPbjoCm5AUDok=
X-Google-Smtp-Source: ABdhPJzFBl071wa3p6/azbM8PJPBsTAJJHrAHmOkUhG8W090nAnPxmta2T7sJnJkzwVo4QN1Txop6A==
X-Received: by 2002:a17:90a:318d:: with SMTP id j13mr18672055pjb.209.1602479210334;
        Sun, 11 Oct 2020 22:06:50 -0700 (PDT)
Received: from skuppusw-mobl5.amr.corp.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id k14sm17666079pfu.163.2020.10.11.22.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 22:06:49 -0700 (PDT)
From:   sathyanarayanan.nkuppuswamy@gmail.com
X-Google-Original-From: sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, okaya@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 1/2] PCI/ERR: Call pci_bus_reset() before calling ->slot_reset() callback
Date:   Sun, 11 Oct 2020 22:03:40 -0700
Message-Id: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently if report_error_detected() or report_mmio_enabled()
functions requests PCI_ERS_RESULT_NEED_RESET, current
pcie_do_recovery() implementation does not do the requested
explicit device reset, but instead just calls the
report_slot_reset() on all affected devices. Notifying about the
reset via report_slot_reset() without doing the actual device
reset is incorrect. So call pci_bus_reset() before triggering
->slot_reset() callback.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/err.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f419d8f9..067c58728b88 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -181,11 +181,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
-		/*
-		 * TODO: Should call platform-specific
-		 * functions to reset slot before calling
-		 * drivers' slot_reset callbacks?
-		 */
+		pci_reset_bus(dev);
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
 		pci_walk_bus(bus, report_slot_reset, &status);
-- 
2.17.1

