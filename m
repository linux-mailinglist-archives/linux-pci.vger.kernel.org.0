Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1192A307A15
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 16:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhA1Pxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 10:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhA1Pxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 10:53:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FB4C061573
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 07:52:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c13so6427646ybg.8
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 07:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=bFlfFxExoP+T7uD5u0dP5DT6ACFMtzqiCrzF6r4rSzw=;
        b=Ec94lJS+bCj3aaejQFC8FxQfhMx9FPQoE9aoIeYMmD8lpwJ2TYXNRYfvWRXREJXKGb
         9DUiIjwKodL1rRPmgGG2bQBl9dL97cUCGZtfl67XkT60Nb8gCCsn4KYB9tro3NPpfWye
         sTkajKmFUmZXY8+tIWaVJQvafFEV9n+mhoCFaDxO72djUzptYje/DjGpT90Y1yCZIgvM
         qP96ZEHgMkSOXea7+yDtZiobKdP8qBNVUUr/KfwRXKy68f3QU/yLSTiurPo8a58EGyiv
         /xVzwofhbrA24QGjeLqiPyULLXsl1K3Efn+WWdAeZkaNDvGLNQpsadRaIMBL7Vtzf+cd
         pjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=bFlfFxExoP+T7uD5u0dP5DT6ACFMtzqiCrzF6r4rSzw=;
        b=fWayCCKvCq8XAlyw7fmBnBfBTGaguMCR+lTHwyAo5y8ealcrM4zCXYdveeh0ZoZlM5
         30ceTWE0aYUFToXRbqvdiwFgLlxmNLRthg8HrNs2JrJsQQOmhv5lmpa9RhtBvYVhnis1
         nhfR2+Oo7qOzBsV4m5BgpGwqrtqpcYy42GVaJheqo8bqJAJs4KGBOvUkndybzhCuMHTt
         AWAr3ii4e8Av4uy4FZ5TwCpS21IKr4C+xuf/IZstmH4AJZgWCoKKP5UEZKsweEwvWYEL
         8No4Oowriv6gvSlxosgilhr0SrPC4qPyvK/xhi810bZcwvs7VI7fvvTBEfHa4/snbYy4
         fC/g==
X-Gm-Message-State: AOAM531Q32p7Vp7nieYTSCvTXbb9+RcnwdxK9cZ6xIfhLM/zQtgvwicL
        FDnUf0UVng3z4k56gWeLXELTwee83CJOhfIu
X-Google-Smtp-Source: ABdhPJy1hTEk/Mwopo0IgkxsLRQWHo/tNwR21dmvZx1FY3dDUfkStKEAAh4AHkF69Ltyk1Fxeq8pDctjdrOMrtV0
Sender: "victording via sendgmr" <victording@victording.c.googlers.com>
X-Received: from victording.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:65c7])
 (user=victording job=sendgmr) by 2002:a25:d2c8:: with SMTP id
 j191mr23967268ybg.279.1611849168928; Thu, 28 Jan 2021 07:52:48 -0800 (PST)
Date:   Thu, 28 Jan 2021 15:52:42 +0000
Message-Id: <20210128155237.v2.1.I42c1001f8b0eaac973a99e1e5c2170788ee36c9c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2] PCI/ASPM: Disable ASPM when save/restore PCI state
From:   Victor Ding <victording@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Victor Ding <victording@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Certain PCIe devices (e.g. GL9750) have high penalties (e.g. high Port
T_POWER_ON) when exiting L1 but enter L1 aggressively. As a result,
such devices enter and exit L1 frequently during pci_save_state and
pci_restore_state; eventually causing poor suspend/resume performance.

Based on the observation that PCI accesses dominance pci_save_state/
pci_restore_state plus these accesses are fairly close to each other, the
actual time the device could stay in low power states is negligible.
Therefore, the little power-saving benefit from ASPM during suspend/resume
does not overweight the performance degradation caused by high L1 exit
penalties.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211187
Signed-off-by: Victor Ding <victording@google.com>

---

Changes in v2:
- Updated commit message to remove unnecessary information
- Fixed a bug reading wrong register in pcie_save_aspm_control
- Updated to reuse existing pcie_config_aspm_dev where possible
- Fixed goto label style

 drivers/pci/pci.c       | 18 +++++++++++++++---
 drivers/pci/pci.h       |  6 ++++++
 drivers/pci/pcie/aspm.c | 27 +++++++++++++++++++++++++++
 include/linux/pci.h     |  1 +
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 32011b7b4c04..9ea88953f90b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1542,6 +1542,10 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
 int pci_save_state(struct pci_dev *dev)
 {
 	int i;
+
+	pcie_save_aspm_control(dev);
+	pcie_disable_aspm(dev);
+
 	/* XXX: 100% dword access ok here? */
 	for (i = 0; i < 16; i++) {
 		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
@@ -1552,18 +1556,22 @@ int pci_save_state(struct pci_dev *dev)
 
 	i = pci_save_pcie_state(dev);
 	if (i != 0)
-		return i;
+		goto exit;
 
 	i = pci_save_pcix_state(dev);
 	if (i != 0)
-		return i;
+		goto exit;
 
 	pci_save_ltr_state(dev);
 	pci_save_aspm_l1ss_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
-	return pci_save_vc_state(dev);
+	i = pci_save_vc_state(dev);
+
+exit:
+	pcie_restore_aspm_control(dev);
+	return i;
 }
 EXPORT_SYMBOL(pci_save_state);
 
@@ -1661,6 +1669,8 @@ void pci_restore_state(struct pci_dev *dev)
 	if (!dev->state_saved)
 		return;
 
+	pcie_disable_aspm(dev);
+
 	/*
 	 * Restore max latencies (in the LTR capability) before enabling
 	 * LTR itself (in the PCIe capability).
@@ -1689,6 +1699,8 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_enable_acs(dev);
 	pci_restore_iov_state(dev);
 
+	pcie_restore_aspm_control(dev);
+
 	dev->state_saved = false;
 }
 EXPORT_SYMBOL(pci_restore_state);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a81459159f6d..e074a0cbe73c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -584,6 +584,9 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 void pci_save_aspm_l1ss_state(struct pci_dev *dev);
 void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
+void pcie_save_aspm_control(struct pci_dev *dev);
+void pcie_restore_aspm_control(struct pci_dev *dev);
+void pcie_disable_aspm(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
@@ -591,6 +594,9 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
 static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
+static inline void pcie_save_aspm_control(struct pci_dev *dev) { }
+static inline void pcie_restore_aspm_control(struct pci_dev *dev) { }
+static inline void pcie_disable_aspm(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a08e7d6dc248..e1e97db32e8b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -784,6 +784,33 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 					   PCI_EXP_LNKCTL_ASPMC, val);
 }
 
+void pcie_disable_aspm(struct pci_dev *pdev)
+{
+	if (!pci_is_pcie(pdev))
+		return;
+
+	pcie_config_aspm_dev(pdev, 0);
+}
+
+void pcie_save_aspm_control(struct pci_dev *pdev)
+{
+	u16 lnkctl;
+
+	if (!pci_is_pcie(pdev))
+		return;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnkctl);
+	pdev->saved_aspm_ctl = lnkctl & PCI_EXP_LNKCTL_ASPMC;
+}
+
+void pcie_restore_aspm_control(struct pci_dev *pdev)
+{
+	if (!pci_is_pcie(pdev))
+		return;
+
+	pcie_config_aspm_dev(pdev, pdev->saved_aspm_ctl);
+}
+
 static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 {
 	u32 upstream = 0, dwstream = 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b32126d26997..a21bfd6e3f89 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -387,6 +387,7 @@ struct pci_dev {
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
 	u16		l1ss;		/* L1SS Capability pointer */
+	u16		saved_aspm_ctl; /* ASPM Control saved at suspend time */
 #endif
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
-- 
2.30.0.280.ga3ce27912f-goog

