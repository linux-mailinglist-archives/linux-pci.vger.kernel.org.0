Return-Path: <linux-pci+bounces-22787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AC9A4CCD8
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613887A111F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1AF23536E;
	Mon,  3 Mar 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpvY6BhD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A223498F;
	Mon,  3 Mar 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034543; cv=none; b=hNr06zuo163D9aIFXI0tHYku97O54CK4TQVKglDCKzz6onJN/qp5fs2qI/9WlJG2bOaPfqGmiYy6PcK+f3iJFToAIXIh0eGb++m6Hpuj+EXS6yULDcXUBTN0O5OlEvjSmUJyNywOml3utTt3cM6VmGXDYM6JYG/3T1HDYwi4OfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034543; c=relaxed/simple;
	bh=a8NqEGH4Go2X33QSyJUSV4V00gL0zvouKu13WLgAJUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RVE+sAagOxvkrtNUMNmhcH566rGdfgRGV/E76ocATvCyZhXAjdjEYViC/vmR/huuKUJ8+6q5IuHjyacQ4DYFhJEsZ4SyOYvKbTd1MRe3jqRH5P77q+LTloMBOkSXibQIA2Pv2FBgs/2yDPKZtpeN5k7D3CoR3ABuY3rpLtaRVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpvY6BhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFB0C4CED6;
	Mon,  3 Mar 2025 20:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741034543;
	bh=a8NqEGH4Go2X33QSyJUSV4V00gL0zvouKu13WLgAJUA=;
	h=From:To:Cc:Subject:Date:From;
	b=DpvY6BhDDPOHSP8AmH6eHpBK2rAPsdpXgUVsZXFssR/i8e0q+1/ABRDMU9M6eR+Hs
	 E1ljDCS5yS1wgK/P//nMhUPLc5IhCGlZQX7VPUHyMcjJghgSabl8RQKGvr0OLo034u
	 nLiGiR13jUY6d7NO5xOVMQQ3dG6qFj+YDu30xHWgRYcmFETO3z9Ixytos8l4IObluP
	 rcsewjVrqgl+xEgq3A7fFBxuzhxrVaBj6JJ4Ml23+f9stp/M1VdBvEdIltmToio5wR
	 5BG76uJOOU3W7RMjIUqJOdSSZ77gPRKtQivNR6PV9vmtjyTdIo/3W4PfQSbK+sp2LA
	 LWYS7X6gBf5YQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Todd Kjos <tkjos@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Log debug messages about reset method
Date: Mon,  3 Mar 2025 14:42:20 -0600
Message-Id: <20250303204220.197172-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Log pci_dbg() messages about the reset methods we attempt and any errors
(-ENOTTY means "try the next method").

Set CONFIG_DYNAMIC_DEBUG=y and enable by booting with
dyndbg="file drivers/pci/* +p" or enable at runtime:

  # echo "file drivers/pci/* +p" > /sys/kernel/debug/dynamic_debug/control

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..3d13bb8e5c53 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5230,6 +5230,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 int __pci_reset_function_locked(struct pci_dev *dev)
 {
 	int i, m, rc;
+	const struct pci_reset_fn_method *method;
 
 	might_sleep();
 
@@ -5246,9 +5247,13 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 		if (!m)
 			return -ENOTTY;
 
-		rc = pci_reset_fn_methods[m].reset_fn(dev, PCI_RESET_DO_RESET);
+		method = &pci_reset_fn_methods[m];
+		pci_dbg(dev, "reset via %s\n", method->name);
+		rc = method->reset_fn(dev, PCI_RESET_DO_RESET);
 		if (!rc)
 			return 0;
+
+		pci_dbg(dev, "%s failed with %d\n", method->name, rc);
 		if (rc != -ENOTTY)
 			return rc;
 	}
-- 
2.34.1


