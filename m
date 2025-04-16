Return-Path: <linux-pci+bounces-26018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BF6A908EF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 18:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDA3190621A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11152212B2E;
	Wed, 16 Apr 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucPkNdZI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86FD211A39;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820955; cv=none; b=U+w8Hx4vhlghTFrFOsc3P6dQ1eG7JwLHvGR7cCGaaviU4xIGndDkXD+Gw1HYJ8vGtJip+jGv5ZD8beYPwHUqC8YByWWBOZisW6peKeHghGt55LdCbpKIV5uUFAQ4BxAutdH9W4Js+buuioxq2U6NIMRKaR1r8JdwhUtyQfFJmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820955; c=relaxed/simple;
	bh=j7a1MWfbRFpfxfm/Ng5E8w9b6pWr++a/2lyhhriAkgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qvjr37veWFVlVxOMZVFDTjY1oSN/wzdcHYmmjgUHEfFz0uGhzTt3gtvUFEToPuwtXzWwPapZlRw42JVf6XI2/ZuIK/CUXKjULwX1iAvgYOklEZvvyOHjWYGANgzu9+J3u4lBolaMGdCRo9KndgWn43t6F8TaoNmwXcFgckzGauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucPkNdZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5247EC4CEEE;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744820955;
	bh=j7a1MWfbRFpfxfm/Ng5E8w9b6pWr++a/2lyhhriAkgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ucPkNdZIG2w/r6/fz5JZk/qs61NNDlEpYY7H7aqvoxWCKi7PQZ86Ld0SVT1KjvuDk
	 C0C/7s20L2WV4kZkbRPbyxpPB/vHaxKzkZi/LwjsuU8gt1LRPi+B87zBuVpDkYr3Fj
	 avjfj6uMKCyNy2AmisGa4avLGHD41a2Co91Lawe+Ja7+Q4iwErgBB7cywZQSFVjD9w
	 jNjhIcILWMuGuDL7xItMcyqRC/DrVyMxxH6HP8f8W+F8t9a+5vooe+6/SjjZCIhd2f
	 aUhJe1szUUIaN+m6UDulgc7E9Gue+kPbOOiEQASSCNuSZ+rGm2C3EJS0FJotY0u6L+
	 66zgCckN8q0bg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A00C369C5;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 16 Apr 2025 21:59:04 +0530
Subject: [PATCH v2 2/4] PCI/ERR: Add support for resetting the slots in a
 platform specific way
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-pcie-reset-slot-v2-2-efe76b278c10@linaro.org>
References: <20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org>
In-Reply-To: <20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2766;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=DxjgbttCz+WbWbTBQh3uh5PZxc6tk82mAeHt4QTMKaE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBn/9rXPir56LKePoLEBXt0d8b+kq7X+ZFgid+RI
 JzzZ1AKKwuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ//a1wAKCRBVnxHm/pHO
 9WTDB/9DvoXiP4Dq0I6q4cMG31g9lImU8jRuTybuyvxvopbn/Mixdu1u8Dy4W5c7xzTqjMNMTIi
 R22LFIph88ll3whCEIsdH7n45oO3SwPgXOvaQlC2imWxUPVKfL9SGTTOlrDX6yRGlXNSxpRpo1F
 TfNNPT2bqFz1knIxaskBgdyollmA67HYaOMXmgW7hEK53TIWWxbSHb/6ASfjm0HyUIVmjLpZAN1
 Sc3z32OoK/DMMvGF1dRxrWuj9Qfz/NeQcHb5uuLXur5L2QlkkDB6YjtjrSM1NTcwS5h7QfKtPxm
 VapGFs7dlSZ7/g/ZJqdw2gr9Z2DMQ8Jmtxqr1RB1jKHmYF4U
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Some host bridge devices require resetting the slots in a platform specific
way to recover them from error conditions such as Fatal AER errors, Link
Down etc... So introduce pci_host_bridge::reset_slot callback and call it
from pcibios_reset_secondary_bus() if available.

The 'reset_slot' callback is responsible for resetting the given slot
referenced by the 'pci_dev' pointer in a platform specific way and bring it
back to the working state if possible. If any error occurs during the slot
reset operation, relevant errno should be returned.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pci.c      | 12 ++++++++++++
 drivers/pci/pcie/err.c |  5 -----
 include/linux/pci.h    |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64ea24ec754a135a2585c99489cfa641a9..13709bb898a967968540826a2b7ee8ade6b7e082 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4982,7 +4982,19 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 
 void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	int ret;
+
+	if (host->reset_slot) {
+		ret = host->reset_slot(host, dev);
+		if (ret)
+			pci_err(dev, "failed to reset slot: %d\n", ret);
+
+		return;
+	}
+
 	pci_reset_secondary_bus(dev);
+
 }
 
 /**
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index de6381c690f5c21f00021cdc7bde8d93a5c7db52..b834fc0d705938540d3d7d3d8739770c09fe7cf1 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -234,11 +234,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
-		/*
-		 * TODO: Should call platform-specific
-		 * functions to reset slot before calling
-		 * drivers' slot_reset callbacks?
-		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(bridge, "broadcast slot_reset message\n");
 		pci_walk_bridge(bridge, report_slot_reset, &status);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e8e3fd77e96713054388bdc82f439e51023c1bf..8d7d2a49b76cf64b4218b179cec495e0d69ddf6f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -599,6 +599,7 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
+	int (*reset_slot)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */

-- 
2.43.0



