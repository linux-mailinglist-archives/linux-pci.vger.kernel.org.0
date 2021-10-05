Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF1D422FB4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhJESL7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234632AbhJESL7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:11:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70ACA6115B;
        Tue,  5 Oct 2021 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457408;
        bh=XRWTS9jfPVzNNBmZWDyD304RTTJU12al2/+nn7eOtyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbBk1jmmXYeObxtelrWU/GePAWEBgU5KKX23zIMeoGzuArkeefxgA/oQxidwODFex
         JSLhIyd3mmnp+hnjydA1PNQJ5H9HnizKJYDU4I7OKw6tbe0IE389+R4SmbC8wru7Wi
         Dtg1rtxp+3Z4q2zIZaKmitCPtpSoUM3usuxV8GtVpfKTYHZBeMuWSVAulwuaZ0YP23
         rfu6yMnnZpvu4Zrw+R3qTaprek/8a3pG6qFUbK/f2fGXOZE2KyaZHXtW4nGIjcew50
         C8KTSDPxz1LxnhPPJysiMasB57AijZPGcJiZFSwU2iVJX5sFEGteuLieI2E7IOaSEO
         p8b8i9jehSK2Q==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 09/13] PCI: aardvark: Implement re-issuing config requests on CRS response
Date:   Tue,  5 Oct 2021 20:09:48 +0200
Message-Id: <20211005180952.6812-10-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211005180952.6812-1-kabel@kernel.org>
References: <20211005180952.6812-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") fixed
handling of CRS response and when CRSSVE flag was not enabled it marked CRS
response as failed transaction (due to simplicity).

But pci-aardvark.c driver is already waiting up to the PIO_RETRY_CNT count
for PIO config response and so we can with a small change implement
re-issuing of config requests as described in PCIe base specification.

This change implements re-issuing of config requests when response is CRS.
Set upper bound of wait cycles to around PIO_RETRY_CNT, afterwards the
transaction is marked as failed and an all-ones value is returned as
before.

We do this by returning appropriate error codes from function
advk_pcie_check_pio_status(). On CRS we return -EAGAIN and caller then
reissues transaction.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 67 +++++++++++++++++----------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index cd5be284789e..efe8b5f7bf8c 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -603,6 +603,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 	u32 reg;
 	unsigned int status;
 	char *strcomp_status, *str_posted;
+	int ret;
 
 	reg = advk_readl(pcie, PIO_STAT);
 	status = (reg & PIO_COMPLETION_STATUS_MASK) >>
@@ -627,6 +628,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 	case PIO_COMPLETION_STATUS_OK:
 		if (reg & PIO_ERR_STATUS) {
 			strcomp_status = "COMP_ERR";
+			ret = -EFAULT;
 			break;
 		}
 		/* Get the read result */
@@ -634,9 +636,11 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
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
@@ -654,6 +658,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 			 */
 			*val = CFG_RD_CRS_VAL;
 			strcomp_status = NULL;
+			ret = 0;
 			break;
 		}
 		/* PCIe r4.0, sec 2.3.2, says:
@@ -669,21 +674,24 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
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
@@ -693,7 +701,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 	dev_dbg(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
 		str_posted, strcomp_status, reg, advk_readl(pcie, PIO_ADDR_LS));
 
-	return -EFAULT;
+	return ret;
 }
 
 static int advk_pcie_wait_pio(struct advk_pcie *pcie)
@@ -701,13 +709,13 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
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
 
@@ -898,6 +906,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			     int where, int size, u32 *val)
 {
 	struct advk_pcie *pcie = bus->sysdata;
+	int retry_count;
 	bool allow_crs;
 	u32 reg;
 	int ret;
@@ -940,16 +949,22 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the data strobe */
 	advk_writel(pcie, 0xf, PIO_WR_DATA_STRB);
 
-	/* Clear PIO DONE ISR and start the transfer */
-	advk_writel(pcie, 1, PIO_ISR);
-	advk_writel(pcie, 1, PIO_START);
+	retry_count = 0;
+	do {
+		/* Clear PIO DONE ISR and start the transfer */
+		advk_writel(pcie, 1, PIO_ISR);
+		advk_writel(pcie, 1, PIO_START);
 
-	ret = advk_pcie_wait_pio(pcie);
-	if (ret < 0)
-		goto try_crs;
+		ret = advk_pcie_wait_pio(pcie);
+		if (ret < 0)
+			goto try_crs;
+
+		retry_count += ret;
+
+		/* Check PIO status and get the read result */
+		ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
+	} while (ret == -EAGAIN && retry_count < PIO_RETRY_CNT);
 
-	/* Check PIO status and get the read result */
-	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
 	if (ret < 0)
 		goto fail;
 
@@ -981,6 +996,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	struct advk_pcie *pcie = bus->sysdata;
 	u32 reg;
 	u32 data_strobe = 0x0;
+	int retry_count;
 	int offset;
 	int ret;
 
@@ -1022,19 +1038,22 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the data strobe */
 	advk_writel(pcie, data_strobe, PIO_WR_DATA_STRB);
 
-	/* Clear PIO DONE ISR and start the transfer */
-	advk_writel(pcie, 1, PIO_ISR);
-	advk_writel(pcie, 1, PIO_START);
+	retry_count = 0;
+	do {
+		/* Clear PIO DONE ISR and start the transfer */
+		advk_writel(pcie, 1, PIO_ISR);
+		advk_writel(pcie, 1, PIO_START);
 
-	ret = advk_pcie_wait_pio(pcie);
-	if (ret < 0)
-		return PCIBIOS_SET_FAILED;
+		ret = advk_pcie_wait_pio(pcie);
+		if (ret < 0)
+			return PCIBIOS_SET_FAILED;
 
-	ret = advk_pcie_check_pio_status(pcie, false, NULL);
-	if (ret < 0)
-		return PCIBIOS_SET_FAILED;
+		retry_count += ret;
 
-	return PCIBIOS_SUCCESSFUL;
+		ret = advk_pcie_check_pio_status(pcie, false, NULL);
+	} while (ret == -EAGAIN && retry_count < PIO_RETRY_CNT);
+
+	return ret < 0 ? PCIBIOS_SET_FAILED : PCIBIOS_SUCCESSFUL;
 }
 
 static struct pci_ops advk_pcie_ops = {
-- 
2.32.0

