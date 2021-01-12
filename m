Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C212F2F26DF
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 05:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbhALEDd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 23:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbhALEDc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2021 23:03:32 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADC9C0617A2
        for <linux-pci@vger.kernel.org>; Mon, 11 Jan 2021 20:02:16 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id c1so655635pjo.6
        for <linux-pci@vger.kernel.org>; Mon, 11 Jan 2021 20:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ak768gEI6XCH+aPGM5U6EpkG7B0YhsCWJJw1G4ZyE7I=;
        b=JG+Sg8xWVV6o2H7jEpk7k4T+BYMj0g9b6yD/Ot9mOHxD3cId9PvCBaP793TPOW6UDE
         NemddI4QWvvzitpZfeFW+h/oZk7T6Jnj+EEIilx9OvKxUllf+a15pi4wBluJwif15orG
         lxt0Iwhipfxrk6ZW89+/Fvs9cjOHvOjWU7z5Ydl+jyjAJMe1yjselzRW72578Bx2Fyqc
         d3fSSxw4Snb1Eucb/fUPnADWmIUQDqlRl6E6WwlguCH12WUI4466mfh2+DLUIKH0GubQ
         Z+ijve1yEtXLZp0i1ZdOM1OSbmUX0fmUjCnlyPY9JvwvvDhbZnup8zgujXBoFuyz5geq
         1Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ak768gEI6XCH+aPGM5U6EpkG7B0YhsCWJJw1G4ZyE7I=;
        b=YoOJSWLWvPwfMhF3i4xUcDytPblOcvWJvJ48hispZzv08eCXuxwb1S/eLfPEmwoww8
         mgv/2ItHxwGNoPwDYy2E+5Zooc/FoKGGeqsk5nVAR6TtRLMeG6vCUwg6AKG6CwkfSyyE
         NbSPtpP/XgHt12xMR/r4pfZgGvKp17ychUojng4J5GRcG91xHeFLnPrrQG1CNaDYdnv9
         ktWEipjh9jv98h/B0a8qgd3QuGohJWmsL1hveEKPB5k2yb8vGVmpQ4wR2WVybMRKVFsu
         zsBbtXy5da2iAf4Ve/FkBrPQKvcqjPsg5IT6fTs3twX/pxnnBRCrzuCipcimPkXafTAY
         i1RA==
X-Gm-Message-State: AOAM530+hPpUeghlKRhMptrwx/LtJ5wmBRuSua8IWa3X/PhHl+9Vj3St
        pet0iwNx5FNhYCiQfOyzqMx8Zk9xqsCskav8
X-Google-Smtp-Source: ABdhPJyeGpHSwrKQpN/leiMW8w46NVzHLITPTcbviWLsyHqYnfuKcC5BbfnSxl+8REx+Rif+d0Rdxchqd99GuCMG
Sender: "victording via sendgmr" <victording@victording.c.googlers.com>
X-Received: from victording.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:65c7])
 (user=victording job=sendgmr) by 2002:a17:902:c144:b029:dc:292e:a8a1 with
 SMTP id 4-20020a170902c144b02900dc292ea8a1mr3103608plj.13.1610424135755; Mon,
 11 Jan 2021 20:02:15 -0800 (PST)
Date:   Tue, 12 Jan 2021 04:02:04 +0000
In-Reply-To: <20210112040205.4117303-1-victording@google.com>
Message-Id: <20210112040146.1.I9aa2b9dd39a6ac9235ec55a8c56020538aa212fb@changeid>
Mime-Version: 1.0
References: <20210112040205.4117303-1-victording@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/2] PCI/ASPM: Disable ASPM until its LTR and L1ss state is restored
From:   Victor Ding <victording@google.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mmc@vger.kernel.org, Victor Ding <victording@google.com>,
        Alex Levin <levinale@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Right after powering up, the device may have ASPM enabled; however,
its LTR and/or L1ss controls may not be in the desired states; hence,
the device may enter L1.2 undesirably and cause resume performance
penalty. This is especially problematic if ASPM related control
registers are modified before a suspension.

Therefore, ASPM should disabled until its LTR and L1ss states are
fully restored.

Signed-off-by: Victor Ding <victording@google.com>
---

 drivers/pci/pci.c       | 11 +++++++++++
 drivers/pci/pci.h       |  2 ++
 drivers/pci/pcie/aspm.c |  2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index eb323af34f1e..428de433f2e6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1660,6 +1660,17 @@ void pci_restore_state(struct pci_dev *dev)
 	if (!dev->state_saved)
 		return;
 
+	/*
+	 * Right after powering up, the device may have ASPM enabled;
+	 * however, its LTR and/or L1ss controls may not be in the desired
+	 * states; as a result, the device may enter L1.2 undesirably and
+	 * cause resume performance penalty.
+	 * Therefore, ASPM is disabled until its LTR and L1ss states are
+	 * fully restored.
+	 * (enabling ASPM is part of pci_restore_pcie_state)
+	 */
+	pcie_config_aspm_dev(dev, 0);
+
 	/*
 	 * Restore max latencies (in the LTR capability) before enabling
 	 * LTR itself (in the PCIe capability).
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e9ea5dfaa3e0..f774bd6d2555 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -564,6 +564,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val);
 void pci_save_aspm_l1ss_state(struct pci_dev *dev);
 void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
 #else
@@ -571,6 +572,7 @@ static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
+static inline void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val) { }
 static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
 static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
 #endif
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a08e7d6dc248..45535b4e1595 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -778,7 +778,7 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
 	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
 }
 
-static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
+void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
 					   PCI_EXP_LNKCTL_ASPMC, val);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

