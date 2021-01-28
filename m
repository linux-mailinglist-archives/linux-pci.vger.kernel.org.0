Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B73D30762A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 13:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhA1M3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 07:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhA1M3M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 07:29:12 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DA5C061756
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 04:28:26 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id o11so1038682pgn.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 04:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=KQRxmbkqnVfcFdMWoNI1FcaCAHf3VakR0zyATmOVZLg=;
        b=NiEN2RXjNnyyA1aD6pItplvLFhcRqc0fl33qILL57dK8zoOLNNTnP9UJhpZPPhptgz
         TDyuuRWmiCn4UDZ3P8NxBR1dCQwWvRwxYXDUx4Gk0cfn2ANsgZ1r5SVftz8ZnU+Ubnke
         UXp2FTqwKUbv6dyU1fv1WhpWaV4LLFTzYWtxk3iJJt3eYHQux8BiuhlGGGp7+OjusUUx
         e2OpJMrr6dZM8Q2Z44EmGpFlBZmbKEOa172YWfMvnFeLIIC2VHWpmVjzjru3TvvH+SkC
         cQo1+6Z+Q84/bSj1JNMb66n7OV2UMv/4pv+RVlx1u4LrCMfMEWUcoOl6y1SC3nrJuJ2c
         wTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=KQRxmbkqnVfcFdMWoNI1FcaCAHf3VakR0zyATmOVZLg=;
        b=NPHHZuSf4/JenQROggG1VoHH2tpXI0lwrwh0b/wnthuL4+dsqlZT5Zke/bhuyF8Ube
         LReN3o4PlyCqGMZf/0w4ZlJZqwTL1vy81y/cEicIv9JGA3A8jYSPkID/YJkt0x/HEVzT
         liA8tTWQrD1XO3INZqlAT+skvM2jpf4q9xDiQMvQUSrmTulZbZTxOFVLzl+71U3zk/yh
         eMarq0TxZM1haZ3B/boav2SaXsxwNgkNUXNSVor/QNxiGowDnJ6Vld+SjfvEPw1qDS7t
         ix7b6j2owy9lMgvOcIZFdCughHhGRYkyb3vJNNp4AjD+n4oCKumdpYe8BIWWFl1cWmMi
         sOhw==
X-Gm-Message-State: AOAM531oT8IBqmWjlBtbytxMDH2yOnj4kbcTYp1uqxumnbR4OnNMMwLX
        jR6b2WvEQjPaDf3RjRH78/X770tNEk8KV5yA
X-Google-Smtp-Source: ABdhPJzHPUJozEO9IhoK+J+fdPwIzudsS5MDpsiCcLzp30hVMfgHC1ekwqAWwALMnAPFd5DnNYROM+fFEfzz1YpP
Sender: "victording via sendgmr" <victording@victording.c.googlers.com>
X-Received: from victording.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:65c7])
 (user=victording job=sendgmr) by 2002:a17:902:b212:b029:df:ec2e:6a1f with
 SMTP id t18-20020a170902b212b02900dfec2e6a1fmr16016023plr.24.1611836905911;
 Thu, 28 Jan 2021 04:28:25 -0800 (PST)
Date:   Thu, 28 Jan 2021 12:27:54 +0000
Message-Id: <20210128122311.1.I42c1001f8b0eaac973a99e1e5c2170788ee36c9c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] PCI/ASPM: Disable ASPM when save/restore PCI state
From:   Victor Ding <victording@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Ding <victording@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
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

Therefore, this patch proposes to disable ASPM during a suspend/resume
process.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211187
Signed-off-by: Victor Ding <victording@google.com>

---

 drivers/pci/pci.c       | 18 +++++++++++++++---
 drivers/pci/pci.h       |  6 ++++++
 drivers/pci/pcie/aspm.c | 26 ++++++++++++++++++++++++++
 include/linux/pci.h     |  1 +
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 32011b7b4c04..a925a7075063 100644
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
+		goto Exit;
 
 	i = pci_save_pcix_state(dev);
 	if (i != 0)
-		return i;
+		goto Exit;
 
 	pci_save_ltr_state(dev);
 	pci_save_aspm_l1ss_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
-	return pci_save_vc_state(dev);
+	i = pci_save_vc_state(dev);
+
+Exit:
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
index a08e7d6dc248..519b9f1b067a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -105,6 +105,12 @@ static const char *policy_str[] = {
 
 #define LINK_RETRAIN_TIMEOUT HZ
 
+void pcie_disable_aspm(struct pci_dev *pdev)
+{
+	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
+						PCI_EXP_LNKCTL_ASPMC, 0);
+}
+
 static int policy_to_aspm_state(struct pcie_link_state *link)
 {
 	switch (aspm_policy) {
@@ -680,6 +686,26 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 }
 
+void pcie_save_aspm_control(struct pci_dev *dev)
+{
+	u16 lnkctl;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	pci_read_config_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+	dev->saved_aspm_ctl = lnkctl & PCI_EXP_LNKCTL_ASPMC;
+}
+
+void pcie_restore_aspm_control(struct pci_dev *dev)
+{
+	if (!pci_is_pcie(dev))
+		return;
+
+	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
+					PCI_EXP_LNKCTL_ASPMC, dev->saved_aspm_ctl);
+}
+
 /* Configure the ASPM L1 substates */
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
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

