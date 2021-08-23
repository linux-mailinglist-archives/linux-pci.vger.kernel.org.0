Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9640E3F4A3D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 14:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhHWMD2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 08:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236795AbhHWMDT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 08:03:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 422C56127B;
        Mon, 23 Aug 2021 12:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629720157;
        bh=ifwUjDyFSqqkA3hwClsFSHtAhhdvvpwuRsxtfKGX8wM=;
        h=From:To:Cc:Subject:Date:From;
        b=MTz566SFRIMc2soTXqSRUumGmzgT+2Oo1mJX78Mp+QarCDYeTcyjcKIOrtwkwAO9M
         hP2qcOWHPSTgnp101bhjvOUJM1qa4Q6E5ypsjm2WSR3gFr4uX4mVkPZIaKRkDEO4Tz
         MMm042b6K9UcdmFsHgQi2EpTcd60FNiLLRpceErmfFlF3+fa4plIx8dFVz5oHkCGcE
         Ahh95ddZckyg/jfXDt+JASmYB135FQUdGNoWRZxzqmPQ675zXY9cQbKz9I1gvOO72S
         eTH9m8tHnmtD1hcgV8xeupkItC4tOytSMmC6dRokJI8XZ6ZEd/OOC2/Bx5cQMwensL
         LTbpiMBNduwtw==
Received: by pali.im (Postfix)
        id A905AFC2; Mon, 23 Aug 2021 14:02:34 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: aardvark: Implement re-issuing config requests on CRS response
Date:   Mon, 23 Aug 2021 14:02:14 +0200
Message-Id: <20210823120214.24837-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") fixed
handling of CRS response and when CRSSVE flag was not enabled it marked CRS
response as failed transaction (due to simplicity).

But pci-aardvark.c driver is already waiting up to the PIO_RETRY_CNT count
for PIO config response and implementation of re-issuing config requests
according to PCIe base specification is therefore simple.

This change implements re-issuing of config requests when response is CRS.
And to prevent infinite loop set upper bound to around PIO_RETRY_CNT value,
after which is transaction marked as failed and 0xFFFFFFFF is returned like
before.

Implementation is done by returning appropriate error codes from function
advk_pcie_check_pio_status(). On CRS is returned -EAGAIN and caller then
reissue transaction up to the PIO_RETRY_CNT count. As advk_pcie_wait_pio()
function waits some cycles, return number of these cycles and add them to
the retry count. So the total time for config request would be only linear
O(PIO_RETRY_CNT) and not quadratic O(PIO_RETRY_CNT^2) in the worst case.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value")
---
 drivers/pci/controller/pci-aardvark.c | 36 ++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index abc93225ba20..99f244190eae 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -470,6 +470,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 	u32 reg;
 	unsigned int status;
 	char *strcomp_status, *str_posted;
+	int ret;
 
 	reg = advk_readl(pcie, PIO_STAT);
 	status = (reg & PIO_COMPLETION_STATUS_MASK) >>
@@ -494,6 +495,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 	case PIO_COMPLETION_STATUS_OK:
 		if (reg & PIO_ERR_STATUS) {
 			strcomp_status = "COMP_ERR";
+			ret = -EFAULT;
 			break;
 		}
 		/* Get the read result */
@@ -501,9 +503,11 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 			*val = advk_readl(pcie, PIO_RD_DATA);
 		/* No error */
 		strcomp_status = NULL;
+		ret = 0;
 		break;
 	case PIO_COMPLETION_STATUS_UR:
 		strcomp_status = "UR";
+		ret = -EOPNOTSUPP;
 		break;
 	case PIO_COMPLETION_STATUS_CRS:
 		if (allow_crs && val) {
@@ -521,6 +525,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 			 */
 			*val = CFG_RD_CRS_VAL;
 			strcomp_status = NULL;
+			ret = 0;
 			break;
 		}
 		/* PCIe r4.0, sec 2.3.2, says:
@@ -536,21 +541,24 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 		 * Request and taking appropriate action, e.g., complete the
 		 * Request to the host as a failed transaction.
 		 *
-		 * To simplify implementation do not re-issue the Configuration
-		 * Request and complete the Request as a failed transaction.
+		 * So return -EAGAIN and caller (pci-aardvark.c driver) will
+		 * re-issue request again up to the PIO_RETRY_CNT retries.
 		 */
 		strcomp_status = "CRS";
+		ret = -EAGAIN;
 		break;
 	case PIO_COMPLETION_STATUS_CA:
 		strcomp_status = "CA";
+		ret = -ECANCELED;
 		break;
 	default:
 		strcomp_status = "Unknown";
+		ret = -EINVAL;
 		break;
 	}
 
 	if (!strcomp_status)
-		return 0;
+		return ret;
 
 	if (reg & PIO_NON_POSTED_REQ)
 		str_posted = "Non-posted";
@@ -560,7 +568,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 	dev_err(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
 		str_posted, strcomp_status, reg, advk_readl(pcie, PIO_ADDR_LS));
 
-	return -EFAULT;
+	return ret;
 }
 
 static int advk_pcie_wait_pio(struct advk_pcie *pcie)
@@ -568,13 +576,13 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 	struct device *dev = &pcie->pdev->dev;
 	int i;
 
-	for (i = 0; i < PIO_RETRY_CNT; i++) {
+	for (i = 1; i <= PIO_RETRY_CNT; i++) {
 		u32 start, isr;
 
 		start = advk_readl(pcie, PIO_START);
 		isr = advk_readl(pcie, PIO_ISR);
 		if (!start && isr)
-			return 0;
+			return i;
 		udelay(PIO_RETRY_DELAY);
 	}
 
@@ -764,6 +772,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			     int where, int size, u32 *val)
 {
 	struct advk_pcie *pcie = bus->sysdata;
+	int retry_count;
 	bool allow_crs;
 	u32 reg;
 	int ret;
@@ -816,6 +825,9 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the data strobe */
 	advk_writel(pcie, 0xf, PIO_WR_DATA_STRB);
 
+	retry_count = 0;
+
+retry:
 	/* Clear PIO DONE ISR and start the transfer */
 	advk_writel(pcie, 1, PIO_ISR);
 	advk_writel(pcie, 1, PIO_START);
@@ -834,8 +846,12 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_SET_FAILED;
 	}
 
+	retry_count += ret;
+
 	/* Check PIO status and get the read result */
 	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
+	if (ret == -EAGAIN && retry_count < PIO_RETRY_CNT)
+		goto retry;
 	if (ret < 0) {
 		*val = 0xffffffff;
 		return PCIBIOS_SET_FAILED;
@@ -855,6 +871,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	struct advk_pcie *pcie = bus->sysdata;
 	u32 reg;
 	u32 data_strobe = 0x0;
+	int retry_count;
 	int offset;
 	int ret;
 
@@ -896,6 +913,9 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the data strobe */
 	advk_writel(pcie, data_strobe, PIO_WR_DATA_STRB);
 
+	retry_count = 0;
+
+retry:
 	/* Clear PIO DONE ISR and start the transfer */
 	advk_writel(pcie, 1, PIO_ISR);
 	advk_writel(pcie, 1, PIO_START);
@@ -904,7 +924,11 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (ret < 0)
 		return PCIBIOS_SET_FAILED;
 
+	retry_count += ret;
+
 	ret = advk_pcie_check_pio_status(pcie, false, NULL);
+	if (ret == -EAGAIN && retry_count < PIO_RETRY_CNT)
+		goto retry;
 	if (ret < 0)
 		return PCIBIOS_SET_FAILED;
 
-- 
2.20.1

