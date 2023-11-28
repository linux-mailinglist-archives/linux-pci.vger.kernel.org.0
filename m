Return-Path: <linux-pci+bounces-216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 416297FB3D1
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 09:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5490B215DF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4C016408;
	Tue, 28 Nov 2023 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KePGVFYk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B3F182CF;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1DFC433CC;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701159324;
	bh=ldSxVLm151+9Q08xzcfgehlwNmHacduIvn8mLdpw3MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KePGVFYkKCg+fXwzHWo2HnyjhX9Zr2jHkmy1eiykrci56JAFiNLHSHkkizTcxo6eR
	 uV0uD5HK0PstpCYwy9pmIUtUF5y29g+cvKeBILu5wlhdTCUa9W1cazuJSw8mi5eWLP
	 /AN5grugmjvSA13X9F2lbf2ThCiNRQXxQ+pLo+A/7idYbx1GVcXs7pBpepX7aY0hk0
	 MrRzhRjdR7dcz1dBvDcOxRdD6dliCErptS7/zOTehlO1g/C1CHzmsKZsC9Pb73EI5P
	 EpJpJoiD7TctTPQO4SHuVY5TcDNc+3fK9GvCZvqRVAjS095HAK8WgTlbJFPqsj2fNN
	 TxIQQDR1TthLQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r7tG4-00053t-2C;
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
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/6] PCI: qcom: Fix deadlock when enabling ASPM
Date: Tue, 28 Nov 2023 09:15:09 +0100
Message-ID: <20231128081512.19387-4-johan+linaro@kernel.org>
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

The qcom_pcie_enable_aspm() helper is called from pci_walk_bus() during
host init to enable ASPM.

Since pci_walk_bus() already holds a pci_bus_sem read lock, use the new
locked helper to enable link states in order to avoid a potential
deadlock (e.g. in case someone takes a write lock before reacquiring
the read lock).

This issue was reported by lockdep:

   ============================================
   WARNING: possible recursive locking detected
   6.7.0-rc1 #4 Not tainted
   --------------------------------------------
   kworker/u16:6/147 is trying to acquire lock:
   ffffbf3ff9d2cfa0 (pci_bus_sem){++++}-{3:3}, at: pci_enable_link_state+0x74/0x1e8

   but task is already holding lock:
   ffffbf3ff9d2cfa0 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x34/0xbc

   other info that might help us debug this:
    Possible unsafe locking scenario:

          CPU0
          ----
     lock(pci_bus_sem);
     lock(pci_bus_sem);

    *** DEADLOCK ***

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ce3ece28fed2..21523115f6a4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -971,7 +971,7 @@ static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
 {
 	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
 	pci_set_power_state(pdev, PCI_D0);
-	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 
 	return 0;
 }
-- 
2.41.0


