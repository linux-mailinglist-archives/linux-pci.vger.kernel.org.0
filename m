Return-Path: <linux-pci+bounces-43853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1585CEA04C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 16:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA60A3015004
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB59719F137;
	Tue, 30 Dec 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5RiapdL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D79469D;
	Tue, 30 Dec 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767107260; cv=none; b=fdYV+onsBQrImzVSeB0wEOz89ydy9jxVWLcdmLDvH470iG8sKdwBPgSmjl36S2coIUpNUCtulAU5gqZV9xjLj0XBKAPm069A6Dz5h/Wn9LAno4z6iHBrC6P0nHw3jzo41OUc47HjEgmWz+FRN6ZjCVa2B6PmmT57BDHWmPTsaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767107260; c=relaxed/simple;
	bh=/HUbHnhoN+KoA7lEL28DWh1/9SAiXUrJsxGb+QY8XV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qmlVhMbwd01ybE+xtIE5u8nSpjHZdTSHT6QgcNUMSKOsn6iMfH96+7rX8RBhutr4kU2jB+P4EDGDXbOwtJVFH+Pa1fubfLI7yeCAEgK33L5ZCbiG2BeyBF+ZyYD26qb+B56/MfaOTc31pRkUVKNRXQrl5HwpQ+hZAKCey9yCrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5RiapdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A007C116D0;
	Tue, 30 Dec 2025 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767107260;
	bh=/HUbHnhoN+KoA7lEL28DWh1/9SAiXUrJsxGb+QY8XV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u5RiapdLhCUne/QaY83DeNFXxtduRA8tCOrZYTVq978FougiI8xXgTuSqMAqC9D9F
	 kUIpCgFYH4/leXUKAYeX2hdJonoNkF4srMJ+W6fwFEIz+bbOeAR2Npig8SeSKwow0j
	 n9r7kd+b+mJTJWoK3yDEOm+k6IraojpSrAGaEQe+mIGA6YUmT6jJ1I6OzrZCeo+ur/
	 1nVojvSbYyh9WlhUkktRMV64ZgEaiT7pT4Nn0REmVnL5JTkFOVj9gz3u6ZUTDWwYyl
	 HD7zqImMCl5Pko5kfqy6MxbPFpyj0TvfpjF2uWongRmSfIkY8RAZy+U5Gp4omrIgf7
	 5ckpj88l8Ow1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A375EE020B;
	Tue, 30 Dec 2025 15:07:40 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 30 Dec 2025 20:37:32 +0530
Subject: [PATCH v3 1/4] PCI: dwc: Return -ENODEV from
 dw_pcie_wait_for_link() if device is not found
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-pci-dwc-suspend-rework-v3-1-40cd485714f5@oss.qualcomm.com>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
In-Reply-To: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=o/5Daxo7XavRGG4F5ekAsfAm4FYtHGKP45ahA68HQwY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpU+q6HyUDt0e1k2DFsbbs6mTkEAPW0Jk16w1kU
 I84qWb3OiWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVPqugAKCRBVnxHm/pHO
 9Y0MB/9Khom+1EvI9fGD1AfFOjhDdJqp3Yo0arlzCJekLXDOiJ4sXoPFGx3/tCETsFdw8EqCC8x
 gwlBCL83xdEqSugBdkJDhOCc/qgLk38zUsK0fmyEUHWcFIXGgkv4pA1AJkkK2Ltod7fsvyHXHfF
 OjN61CRW6o5TGSld59dYglYmkPckn4VPIcuW5B779SDcb79W8WQpTgvMZabIE84psrRbpaOJsfk
 PZ/y4CkslQgkrO1GKnXhWjxSHHRqvfjKBOrPpnJQ4CTLmFhz94lDHdpGiCmWGioEhL5W6AtmQpm
 y2o3jORt7WwvYpKO3ke17QF/yEFy/JlkVO2WH3qFpEOIaKfE
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The dw_pcie_wait_for_link() function waits up to 1 second for the PCIe link
to come up and returns -ETIMEDOUT for all failures without distinguishing
cases where no device is present on the bus. But the callers may want to
just skip the failure if the device is not found on the bus and handle
failure for other reasons.

So after timeout, if the LTSSM is in Detect.Quiet or Detect.Active state,
return -ENODEV to indicate the callers that the device is not found on the
bus and return -ETIMEDOUT otherwise.

Also add kernel doc to document the parameter and return values.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 345365ea97c7..55c1c60f7f8f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -692,9 +692,16 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
+/**
+ * dw_pcie_wait_for_link - Wait for the PCIe link to be up
+ * @pci: DWC instance
+ *
+ * Returns: 0 if link is up, -ENODEV if device is not found, -ETIMEDOUT if the
+ * link fails to come up for other reasons.
+ */
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
-	u32 offset, val;
+	u32 offset, val, ltssm;
 	int retries;
 
 	/* Check if the link is up or not */
@@ -706,6 +713,17 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	}
 
 	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
+		/*
+		 * If the link is in Detect.Quiet or Detect.Active state, it
+		 * indicates that no device is detected.
+		 */
+		ltssm = dw_pcie_get_ltssm(pci);
+		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
+		    ltssm == DW_PCIE_LTSSM_DETECT_ACT) {
+			dev_info(pci->dev, "Device not found\n");
+			return -ENODEV;
+		}
+
 		dev_info(pci->dev, "Phy link never came up\n");
 		return -ETIMEDOUT;
 	}

-- 
2.48.1



