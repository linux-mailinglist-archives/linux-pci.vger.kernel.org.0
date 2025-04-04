Return-Path: <linux-pci+bounces-25281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D36A7B8B5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 10:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B393B5A27
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 08:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5B190696;
	Fri,  4 Apr 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwqP+8n+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B461624E9;
	Fri,  4 Apr 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743754950; cv=none; b=hgJpoLk6Yo1cHTH3M75hutWdGPOPu9urZQi+ApOVShTAy66vh8oN0vADYFmdoMobqNRSG3qF+4gTCVFjQlZGsunqzCwKnEEA/xuHDsxij62t4APAlBh0FM6fP56H9U6FzQUTMTdar6oc9DRL3fgs6LrgiuDutIkFzQnJoPsoTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743754950; c=relaxed/simple;
	bh=ua1AiLFy13t+lITso/yoUhh+okg9epvqJ/2iV5gE6Wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lehgy607+XCHQcscOJ05Vy141iTdZ0l2+m5OvV0I/dwn2ngEQwSV/Xa1XuKhjgqB7ZelV2kpbvoWRweqFNvSEKAqi0rxRbnFJfrYeX7P7kGok9xo9qPs2+JifuFwPMCPdY+DBosUjL2bN5/UFYhtD8vvjJ+x7qd218Bcel5RAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwqP+8n+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BF84C4CEE9;
	Fri,  4 Apr 2025 08:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743754950;
	bh=ua1AiLFy13t+lITso/yoUhh+okg9epvqJ/2iV5gE6Wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AwqP+8n+2VR6cDMkt+4EkFfYl9lZqigOxSqs0YnfEWjK/qOVrTnkFcKzI+0I1+m8p
	 68KHfT8inDWq7PyaIpyh/WBxLhvxX4xCMkMDuFglf4Ai5OyQKj4OXHhWjkaxSaGIDq
	 F6FR/cCspb9kuWHeGbwFb0dJI0x7TWkWqKqNO4gokQFpYHJyraWV00tfV7gR+fBcXP
	 l1a5SzKRndJwQjq2KjgtKBUsCmiduXzdRS3TkJRLwF87BH+zfwzQmeMa/sGmx/N/xK
	 07KrAm2rrCFvPpicQCjZmGS2t2BEaNmEXU/0YKz+6lePKpv1dnU1XdEEl71Hpf3vxl
	 wasL5j6dTRhRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E111C369A1;
	Fri,  4 Apr 2025 08:22:30 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 04 Apr 2025 13:52:22 +0530
Subject: [PATCH 2/4] PCI/ERR: Add support for resetting the slot in a
 platforms specific way
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-pcie-reset-slot-v1-2-98952918bf90@linaro.org>
References: <20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org>
In-Reply-To: <20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: dingwei@marvell.com, cassel@kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=J1pulK/QhUxJluY/dbX4w+yX5yzsNUDKLf1Z3h6Znak=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBn75bDRHEqWRk4266lWr88ralCgC34yIDiJDcQy
 8j9qOiUwGWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ++WwwAKCRBVnxHm/pHO
 9Rq8B/9yjNScPcrhP4xoodQVe2UhQ06wX8j3FIiW/HCvPsWMdhDIXtFqRnnQJemw74T7Px8Rnpi
 c+ZVMPISLnO/A687KVnD3VDdzk9QBaViKfRPnVzVmTbudjSJWyHiR9EyLaAxH+hG26BSoSnbP1w
 aouo/8LRfXNRQlMdCh1CR7h6303yWBHTisq6wRfHyG/1lbuHN04IqZ7aflwaISj7dloF9c3uP7w
 o23Vh7HOHfwPK7JkrXyuY/H7xqBi77K63hN77hyDimtJiJhhR3sXumd5x0u+k2Z/YXwTuNXXnL1
 LEQ8T/VGLFZZ1a7uOZqhnslwXXjmxwachAAHMA+U3CJdFmjZ
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

When the PCI error handling requires resetting the slot, reset it using the
host bridge specific 'reset_slot' callback if available before calling the
'slot_reset' callback of the PCI drivers.

The 'reset_slot' callback is responsible for resetting the given slot
referenced by the 'pci_dev' pointer in a platform specific way and bring it
back to the working state if possible. If any error occurs during the slot
reset operation, relevant errno should be returned.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pcie/err.c | 15 ++++++++++-----
 include/linux/pci.h    |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index de6381c690f5c21f00021cdc7bde8d93a5c7db52..77ce9354532afee209f658175b86e625bba8a5ee 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -234,11 +234,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
-		/*
-		 * TODO: Should call platform-specific
-		 * functions to reset slot before calling
-		 * drivers' slot_reset callbacks?
-		 */
+		if (host->reset_slot) {
+			ret = host->reset_slot(host, bridge);
+			if (ret) {
+				pci_err(bridge, "failed to reset slot: %d\n",
+					ret);
+				status = PCI_ERS_RESULT_DISCONNECT;
+				goto failed;
+			}
+		}
+
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



