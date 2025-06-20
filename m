Return-Path: <linux-pci+bounces-30265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FCDAE1F8A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 17:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB60189AF02
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298D2D5434;
	Fri, 20 Jun 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RYMbneu9"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157CD2D4B42;
	Fri, 20 Jun 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434965; cv=none; b=EvUvIPXt5q/WYD0CwXfrootBYO/51/AXkMEq1IMv5nsSSnIlo+fBUMGmzO25Zqc+DbYgzR+x17ihinWX0IzntV/Ai8TUfaKFP0Yfpuntjf/La+/SUVoP+H3uJqXn9x1Kn61hwZuKwjQe0DnNok4D6TxdR2DIQFyQ4Pbrwy5aguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434965; c=relaxed/simple;
	bh=ty515ubSKgSJNqoxUVlAvMYB52snnsnwNSDiZDCJWgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUTRM+PU4IoQEHf8k6q2Tyj7t390yN3qyykRRm/6Cr9mgk/hAIdMxiGEkDhdyvlLfUF37aQ3P9jeTmKGtgixqlmTWraFrm6NtyEgqUxpMAW5s8x+S2JNdzX7AlFASA16gzWD2ofMiaYofqU1OoEOdrcdBXwQKSBqloiTshcbmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RYMbneu9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=i8
	TapiMRiV+/DhKkWGWqqhK/Kqxyy8HtlXWR339Cxls=; b=RYMbneu9ctyb7xsH69
	wODmw1d5sYKMXuugkeZtFbY20GNjqE0jBAHZ7P46kpjvsUHNEev+VJqPvrsqOGvn
	Ehd/XYdEqJW17yxh86TQEPhH1mZuJSzCflXZIlBHj3hca/KBs1FntbKaKSNXlYjS
	dwd3h12MskT3faw5Plb/4leS8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDHyCldhFVo3bDnAg--.55764S3;
	Fri, 20 Jun 2025 23:55:11 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	mani@kernel.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 1/2] PCI: Configure root port MPS during host probing
Date: Fri, 20 Jun 2025 23:55:06 +0800
Message-Id: <20250620155507.1022099-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250620155507.1022099-1-18255117159@163.com>
References: <20250620155507.1022099-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHyCldhFVo3bDnAg--.55764S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw17Gw1DuryUZFyrZF17GFg_yoW5Xryxpa
	yUJws3AFZ7GFyfWa1kX3W09ryYv3Z7Cry7JrZ8Cr9093Z8AF1DJrWaya1rA3s7Gr9av34Y
	vr4qqryUu3Z5uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pivJP_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgRyo2hVfXVwHQACs1

Current PCIe initialization logic may leave root ports operating with
non-optimal Maximum Payload Size (MPS) settings. While downstream device
configuration is handled during bus enumeration, root port MPS values
inherited from firmware or hardware defaults might not utilize the full
capabilities supported by the controller hardware. This can result in
suboptimal data transfer efficiency across the PCIe hierarchy.

During host controller probing phase, when PCIe bus tuning is enabled,
the implementation now configures root port MPS settings to their
hardware-supported maximum values. Specifically, when configuring the MPS
for a PCIe device, if the device is a root port and the bus tuning is not
disabled (PCIE_BUS_TUNE_OFF), the MPS is set to 128 << dev->pcie_mpss to
match the Root Port's maximum supported payload size. The Max Read Request
Size (MRRS) is subsequently adjusted through existing companion logic to
maintain compatibility with PCIe specifications.

Note that this initial setting of the root port MPS to the maximum might
be reduced later during the enumeration of downstream devices if any of
those devices do not support the maximum MPS of the root port.

Explicit initialization at host probing stage ensures consistent PCIe
topology configuration before downstream devices perform their own MPS
negotiations. This proactive approach addresses platform-specific
requirements where controller drivers depend on properly initialized
root port settings, while maintaining backward compatibility through
PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
utilized without altering existing device negotiation behaviors.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/probe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..9f8803da914c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2178,6 +2178,16 @@ static void pci_configure_mps(struct pci_dev *dev)
 		return;
 	}
 
+	/*
+	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
+	 * start off by setting root ports' MPS to MPSS. Depending on the MPS
+	 * strategy, and the MPSS of the devices below the root port, the MPS
+	 * of the root port might get overridden later.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
+		pcie_set_mps(dev, 128 << dev->pcie_mpss);
+
 	if (!bridge || !pci_is_pcie(bridge))
 		return;
 
-- 
2.25.1


