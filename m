Return-Path: <linux-pci+bounces-16954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDA09CFC94
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 04:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C280BB21867
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 03:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025E733EC;
	Sat, 16 Nov 2024 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j05R2zBt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A928FF
	for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2024 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731727253; cv=none; b=PEwNgsBmKKTAISAWHyjZj0k5e0WKjYsZv70FpWM9Y6aHzpg4OBsaeAx6FrZBaFSYGBYSE8JNPp3CLXPrDx2TiZ1yO3zrQGAgai7iEzdLjnkROEnye8gk9gg0/nAcdp8X+wIXNEjWsNbhHLPcexOHSfbb5a8ALzZesGUtpKDX8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731727253; c=relaxed/simple;
	bh=5WlkffAhKKHuqRDbWKl5M7usgLVVILpnnAyCQjbD3SM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StTPnjMe6LgE31/VHWPOgZQzCjlKoq7wOPB6e/5PLJuyTcfHhZ+ZbAgl9HtTpGDLQeylADdXAk+dd5Hjl6NoUenKfUAY/T3kvusFeu60QWwnr5bsfxgRKhOu4+Wjc6tHTTHlSmwYfqC6PGvKlxDcIEhPfT30nOVjdaShzI5qXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j05R2zBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B35C4CECF;
	Sat, 16 Nov 2024 03:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731727253;
	bh=5WlkffAhKKHuqRDbWKl5M7usgLVVILpnnAyCQjbD3SM=;
	h=From:To:Cc:Subject:Date:From;
	b=j05R2zBtYjXRI7j0ABsC588d/bVbXEgYOfpt/A6dJDpfS7dX9Zf98eJ+npLXHPQxs
	 JMcvtXVNPDYGUnaSrhgzZkmF/dSs9FpEb5VsAxC9Sx6AfA4THzqkiFaqcwRMky+yLi
	 M6Je5P+mic8whVfE248nuUxxJHd9DJGNN8BSxjkjtBsvo8xtu0OcAaZOyC9FY1+y8b
	 qU83+TKO4NLnRUI+9wS1VCTNWCLibV5D+hn8OUIfs1HdVVBqE7OZlyQadEqtudZeSr
	 HBg+KiC02ologJYupu6Tx0ehouuoUz1eufNE3pxVaI0wbDSiH0wBi9hmb7YBE6F9ef
	 5K3PF7X0p/Tkw==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] misc: pci_endpoint_test: Add consecutive BAR test
Date: Sat, 16 Nov 2024 04:20:45 +0100
Message-ID: <20241116032045.2574168-2-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6476; i=cassel@kernel.org; h=from:subject; bh=5WlkffAhKKHuqRDbWKl5M7usgLVVILpnnAyCQjbD3SM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIt+HsP/8nzSep1u/zsc+zSCTOvaDGGzD73YmXry5Z9+ 1s3Fx1Q7ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEvhsyMmw96JEu+yC69nuU ktrDeRsMkvap5015d6di1m9Ok9wQOVNGhv8nXO8tD5D13W+2V8NAg/nPlgCjJ7w17ezz8pbN5f/ UzAAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a more advanced BAR test that writes all BARs in one go, and then reads
them back and verifies that the value matches the BAR number bitwise OR:ed
with offset, this allows us to verify:
-The BAR number was what we intended to read.
-The offset was what we intended to read.

This allows us to detect potential address translation issues on the EP.

Reading back the BAR directly after writing will not allow us to detect the
case where inbound address translation on the endpoint incorrectly causes
multiple BARs to be redirected to the same memory region (within the EP).

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 88 ++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 tools/pci/pcitest.c              | 16 +++++-
 tools/pci/pcitest.sh             |  1 +
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee2..34cb54aef3d8b 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -322,6 +322,91 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	return true;
 }
 
+static u32 bar_test_pattern_with_offset(enum pci_barno barno, int offset)
+{
+	u32 val;
+
+	/* Keep the BAR pattern in the top byte. */
+	val = bar_test_pattern[barno] & 0xff000000;
+	/* Store the (partial) offset in the remaining bytes. */
+	val |= offset & 0x00ffffff;
+
+	return val;
+}
+
+static bool pci_endpoint_test_bars_write_bar(struct pci_endpoint_test *test,
+					     enum pci_barno barno)
+{
+	struct pci_dev *pdev = test->pdev;
+	int j, size;
+
+	size = pci_resource_len(pdev, barno);
+
+	if (barno == test->test_reg_bar)
+		size = 0x4;
+
+	for (j = 0; j < size; j += 4)
+		writel_relaxed(bar_test_pattern_with_offset(barno, j),
+			       test->bar[barno] + j);
+
+	return true;
+}
+
+static bool pci_endpoint_test_bars_read_bar(struct pci_endpoint_test *test,
+					    enum pci_barno barno)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int j, size;
+	u32 val;
+
+	size = pci_resource_len(pdev, barno);
+
+	if (barno == test->test_reg_bar)
+		size = 0x4;
+
+	for (j = 0; j < size; j += 4) {
+		u32 expected = bar_test_pattern_with_offset(barno, j);
+
+		val = readl_relaxed(test->bar[barno] + j);
+		if (val != expected) {
+			dev_err(dev,
+				"BAR%d incorrect data at offset: %#x, got: %#x expected: %#x\n",
+				barno, j, val, expected);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static bool pci_endpoint_test_bars(struct pci_endpoint_test *test)
+{
+	enum pci_barno bar;
+	bool ret;
+
+	/* Write all BARs in order (without reading). */
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		if (test->bar[bar])
+			pci_endpoint_test_bars_write_bar(test, bar);
+
+	/*
+	 * Read all BARs in order (without writing).
+	 * If there is an address translation issue on the EP, writing one BAR
+	 * might have overwritten another BAR. Ensure that this is not the case.
+	 * (Reading back the BAR directly after writing can not detect this.)
+	 */
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (test->bar[bar]) {
+			ret = pci_endpoint_test_bars_read_bar(test, bar);
+			if (!ret)
+				return ret;
+		}
+	}
+
+	return true;
+}
+
 static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
 {
 	u32 val;
@@ -768,6 +853,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 			goto ret;
 		ret = pci_endpoint_test_bar(test, bar);
 		break;
+	case PCITEST_BARS:
+		ret = pci_endpoint_test_bars(test);
+		break;
 	case PCITEST_INTX_IRQ:
 		ret = pci_endpoint_test_intx_irq(test);
 		break;
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 94b46b043b536..acd261f498666 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -20,6 +20,7 @@
 #define PCITEST_MSIX		_IOW('P', 0x7, int)
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
+#define PCITEST_BARS		_IO('P', 0xa)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001
diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 470258009ddc2..2ce56ea56202c 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -22,6 +22,7 @@ static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
 struct pci_test {
 	char		*device;
 	char		barnum;
+	bool		consecutive_bar_test;
 	bool		legacyirq;
 	unsigned int	msinum;
 	unsigned int	msixnum;
@@ -57,6 +58,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->consecutive_bar_test) {
+		ret = ioctl(fd, PCITEST_BARS);
+		fprintf(stdout, "Consecutive BAR test:\t\t");
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	if (test->set_irqtype) {
 		ret = ioctl(fd, PCITEST_SET_IRQTYPE, test->irqtype);
 		fprintf(stdout, "SET IRQ TYPE TO %s:\t\t", irq[test->irqtype]);
@@ -172,7 +182,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:Cm:x:i:deIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -182,6 +192,9 @@ int main(int argc, char **argv)
 		if (test->barnum < 0 || test->barnum > 5)
 			goto usage;
 		continue;
+	case 'C':
+		test->consecutive_bar_test = true;
+		continue;
 	case 'l':
 		test->legacyirq = true;
 		continue;
@@ -230,6 +243,7 @@ int main(int argc, char **argv)
 			"Options:\n"
 			"\t-D <dev>		PCI endpoint test device {default: /dev/pci-endpoint-test.0}\n"
 			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
+			"\t-C			Consecutive BAR test\n"
 			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
 			"\t-x <msix num>	\tMSI-X test (msix number between 1..2048)\n"
 			"\t-i <irq type>	\tSet IRQ type (0 - Legacy, 1 - MSI, 2 - MSI-X)\n"
diff --git a/tools/pci/pcitest.sh b/tools/pci/pcitest.sh
index 75ed48ff29900..770f4d6df34b6 100644
--- a/tools/pci/pcitest.sh
+++ b/tools/pci/pcitest.sh
@@ -11,6 +11,7 @@ do
 	pcitest -b $bar
 	bar=`expr $bar + 1`
 done
+pcitest -C
 echo
 
 echo "Interrupt tests"
-- 
2.47.0


