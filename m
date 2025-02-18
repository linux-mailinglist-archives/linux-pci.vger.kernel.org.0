Return-Path: <linux-pci+bounces-21689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858EEA3937F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 07:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872C93B2901
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FEE1B21B5;
	Tue, 18 Feb 2025 06:40:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA311AF0CB;
	Tue, 18 Feb 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739860822; cv=none; b=HnpIFIORpsJGSFP+7DBkGnFIJW8Omhf4/cM99b3oldL6iF1fXFLTYf2yoMpnNrM0ta/YzkmnAR8YpKb7VfeU/RNCv26FjhStmLE9DwgqMKqpcZFcrTnQnu+VbGR6Ns2OcCXRsL6Xf/X8nYuo3Dc6O64aWIvpwepFgkBZDWszyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739860822; c=relaxed/simple;
	bh=gWA0mp9lzX73W6VeZFbkd8g8OujawD8K4wzGZK3wLPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D7irUxLgd9Ao9tfYp2ytbgckUpJ4eIYJ2rp+OapMRgoWwGWlzh0PZNQht6SKSRY8EXliCQjk7BkdDGOUwQEBk5tEvU2wKa2jym55zRTcKu3p6CbPzeITJNQJQAltkrz+NIT19o1iZCe2k704/wXToi1SC2kX4KERqrJsi7LfMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAHjS1HK7Rn3muoAw--.21393S2;
	Tue, 18 Feb 2025 14:40:07 +0800 (CST)
Received: from localhost.localdomain (unknown [219.142.137.151])
	by mail (Coremail) with SMTP id AQAAfwAXHIhEK7RnFd4qAA--.6215S2;
	Tue, 18 Feb 2025 14:40:06 +0800 (CST)
From: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] PCI: Update Resizable BAR Capability Register fields
Date: Tue, 18 Feb 2025 14:40:03 +0800
Message-ID: <20250218064003.238868-1-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAXHIhEK7RnFd4qAA--.6215S2
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=daizhiyuan
	@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7AF1kXw47Jr4xZw1kWF47XFb_yoW8AF1rpF
	Z5Ca93KrWrGFZF9r4kA3WFyr45Ka9FvrWIkrWfu3sru3ZIyas2qF4Fka45tF97XF4kZF45
	XF9Fq345u3s0vaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

This commit modifies the Resizable BAR Capability Register fields to better
support varying BAR sizes. Additionally, the function `pci_rebar_get_possible_sizes`
has been updated with a more detailed comment to clarify its role in querying
and returning the supported BAR sizes.

For more details, refer to PCI Express® Base Specification Revision 5.0, Section 7.8.6.2.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 drivers/pci/pci.c             | 2 +-
 include/uapi/linux/pci_regs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 661f98c6c63a..03fe5e6e1d72 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3752,7 +3752,7 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
  * @bar: BAR to query
  *
  * Get the possible sizes of a resizable BAR as bitmask defined in the spec
- * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
+ * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
  */
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1601c7ed5fab..ce99d4f34ce5 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1013,7 +1013,7 @@
 
 /* Resizable BARs */
 #define PCI_REBAR_CAP		4	/* capability register */
-#define  PCI_REBAR_CAP_SIZES		0x00FFFFF0  /* supported BAR sizes */
+#define  PCI_REBAR_CAP_SIZES		0xFFFFFFF0  /* supported BAR sizes */
 #define PCI_REBAR_CTRL		8	/* control register */
 #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
 #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
-- 
2.43.0


