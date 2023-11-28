Return-Path: <linux-pci+bounces-215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A577FB3D2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 09:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157F3B215F2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 08:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8151640A;
	Tue, 28 Nov 2023 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkpLci41"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5517988;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D744C433CD;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701159324;
	bh=G81lMNlYRmVBLpcYlNH0IxVp3LwH9UwmbbiIFMtSKyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkpLci41j5c4/RwAOvrCgGLQRVEQeNuHQfWRex0yjoXcD/1OPbV51okOYGbrbtuXN
	 pwEHt9iQjIV+MtIMRR1bNOTphsf5f5iWUWubq5Vy+kyQ2FcSz4TDDFM6MeS2398tD1
	 EUj8RzvEG2KVMbzgamNshxoXTgOhdALZa/uNc+7EstsNp2iGrWvPxbuuHS/MMvT5tE
	 Sp1kPyrpE8sys1JQL5bhhIugjcaRYnkljbld6Xe03/hfjAVKa4ckkbk8MPykltfONQ
	 ZtW4bCl4e+sLxTtPN2eYm8A7tt4LBVoD16+Q/YFgYir9yN7UBlb5cbItr4TFLM/a2u
	 UBVw3iTDj4/6Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r7tG4-00053p-1c;
	Tue, 28 Nov 2023 09:15:52 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Cc: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Michael Bottini <michael.a.bottini@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link state
Date: Tue, 28 Nov 2023 09:15:07 +0100
Message-ID: <20231128081512.19387-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128081512.19387-1-johan+linaro@kernel.org>
References: <20231128081512.19387-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper for enabling link states that can be used in contexts where
a pci_bus_sem read lock is already held (e.g. from pci_walk_bus()).

This helper will be used to fix a couple of potential deadlocks where
the current helper is called with the lock already held, hence the CC
stable tag.

Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
Cc: stable@vger.kernel.org	# 6.3
Cc: Michael Bottini <michael.a.bottini@linux.intel.com>
Cc: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/pcie/aspm.c | 53 +++++++++++++++++++++++++++++++----------
 include/linux/pci.h     |  3 +++
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 50b04ae5c394..5eb462772354 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1109,17 +1109,7 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
 }
 EXPORT_SYMBOL(pci_disable_link_state);
 
-/**
- * pci_enable_link_state - Clear and set the default device link state so that
- * the link may be allowed to enter the specified states. Note that if the
- * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
- * touch the LNKCTL register. Also note that this does not enable states
- * disabled by pci_disable_link_state(). Return 0 or a negative errno.
- *
- * @pdev: PCI device
- * @state: Mask of ASPM link states to enable
- */
-int pci_enable_link_state(struct pci_dev *pdev, int state)
+static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
@@ -1136,7 +1126,8 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
 		return -EPERM;
 	}
 
-	down_read(&pci_bus_sem);
+	if (!locked)
+		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	link->aspm_default = 0;
 	if (state & PCIE_LINK_STATE_L0S)
@@ -1157,12 +1148,48 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
 	pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	mutex_unlock(&aspm_lock);
-	up_read(&pci_bus_sem);
+	if (!locked)
+		up_read(&pci_bus_sem);
 
 	return 0;
 }
+
+/**
+ * pci_enable_link_state - Clear and set the default device link state so that
+ * the link may be allowed to enter the specified states. Note that if the
+ * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
+ * touch the LNKCTL register. Also note that this does not enable states
+ * disabled by pci_disable_link_state(). Return 0 or a negative errno.
+ *
+ * @pdev: PCI device
+ * @state: Mask of ASPM link states to enable
+ */
+int pci_enable_link_state(struct pci_dev *pdev, int state)
+{
+	return __pci_enable_link_state(pdev, state, false);
+}
 EXPORT_SYMBOL(pci_enable_link_state);
 
+/**
+ * pci_enable_link_state_locked - Clear and set the default device link state
+ * so that the link may be allowed to enter the specified states. Note that if
+ * the BIOS didn't grant ASPM control to the OS, this does nothing because we
+ * can't touch the LNKCTL register. Also note that this does not enable states
+ * disabled by pci_disable_link_state(). Return 0 or a negative errno.
+ *
+ * @pdev: PCI device
+ * @state: Mask of ASPM link states to enable
+ *
+ * Context: Caller holds pci_bus_sem read lock.
+ */
+int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
+{
+	lockdep_assert_held_read(&pci_bus_sem);
+
+	return __pci_enable_link_state(pdev, state, true);
+}
+EXPORT_SYMBOL(pci_enable_link_state_locked);
+
 static int pcie_aspm_set_policy(const char *val,
 				const struct kernel_param *kp)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768bc867..dea043bc1e38 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1829,6 +1829,7 @@ extern bool pcie_ports_native;
 int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 int pci_enable_link_state(struct pci_dev *pdev, int state);
+int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
@@ -1839,6 +1840,8 @@ static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 { return 0; }
 static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
+static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
+{ return 0; }
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
-- 
2.41.0


