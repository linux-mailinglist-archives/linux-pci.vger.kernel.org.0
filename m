Return-Path: <linux-pci+bounces-597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F6F807B97
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 23:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C821C20FF2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 22:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70837364;
	Wed,  6 Dec 2023 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlZfUNOq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D22DF94
	for <linux-pci@vger.kernel.org>; Wed,  6 Dec 2023 22:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF022C433C7;
	Wed,  6 Dec 2023 22:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701902564;
	bh=hxM1IqtzAU7BiNojl8vsj+19zxebOt7Ey++poguftDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YlZfUNOqCiUR8pGApkpmaP+V44at9k1507c7BwV1zzncNfobRNhMLfI2WyMjUsFjm
	 27edqPyiJttSwkBvUmXNIaEiSlUQLZDNi6dGcHoTt4+/iMJc7Z3pN3AdyzK1zEl/dY
	 l6aYfjIBlCD9YxyUXPda6iUwJeXv1ef416UqPeo0hsYVEIDuG9u8qapWg+ERkCLjsN
	 WZeBQ/QyLvH9kTPQXUEv9C4lKmteraeqZWaFw67/H0/7BgS9tHkz7DJ/930BWt2oS6
	 v8mZD24D/av/nEW17SjCkp9BhfQtZMNFvljb2ftgqs2V3MBDD6+LCJRLU2Ntoxg5gm
	 X8QGZxeMAOjUg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] PCI/AER: Use explicit register sizes for struct members
Date: Wed,  6 Dec 2023 16:42:31 -0600
Message-Id: <20231206224231.732765-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206224231.732765-1-helgaas@kernel.org>
References: <20231206224231.732765-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

aer_irq() reads the AER Root Error Status and Error Source Identification
(PCI_ERR_ROOT_STATUS and PCI_ERR_ROOT_ERR_SRC) registers directly into
struct aer_err_source.  Both registers are 32 bits, so declare the members
explicitly as "u32" instead of "unsigned int".

Similarly, aer_get_device_error_info() reads the AER Header Log
(PCI_ERR_HEADER_LOG) registers, which are also 32 bits, into struct
aer_header_log_regs.  Declare those members as "u32" as well.

No functional changes intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 4 ++--
 include/linux/aer.h    | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2ff6bac9979f..60f84414ec2a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -41,8 +41,8 @@
 #define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
 
 struct aer_err_source {
-	unsigned int status;
-	unsigned int id;
+	u32 status;			/* PCI_ERR_ROOT_STATUS */
+	u32 id;				/* PCI_ERR_ROOT_ERR_SRC */
 };
 
 struct aer_rpc {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index f6ea2f57d808..ae0fae70d4bd 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -19,10 +19,10 @@
 struct pci_dev;
 
 struct aer_header_log_regs {
-	unsigned int dw0;
-	unsigned int dw1;
-	unsigned int dw2;
-	unsigned int dw3;
+	u32 dw0;
+	u32 dw1;
+	u32 dw2;
+	u32 dw3;
 };
 
 struct aer_capability_regs {
-- 
2.34.1


