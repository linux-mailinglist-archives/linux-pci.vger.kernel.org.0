Return-Path: <linux-pci+bounces-2065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D91482B2F2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 17:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026E11F2677E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191544F8A0;
	Thu, 11 Jan 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVEldWFo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA14F8A1;
	Thu, 11 Jan 2024 16:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956CDC433C7;
	Thu, 11 Jan 2024 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704990535;
	bh=dAHvLx4ykQf5j2gmvDOelggdw+uJittaxBF6vTFPQlA=;
	h=From:To:Cc:Subject:Date:From;
	b=WVEldWFox6syrS6zUzvNTMrBFhW2gYoUG/N9/7C3yay5Ed1fW1wu0DG2oEjwsmu6k
	 xTLjDE052qpQVeHv89aCkAgs6v6noXP3C95oU32nitwBRorLUqti/5UXhUFKzU2ILX
	 sPD71yRza8ffO04dv0GGzTqfr0yfLf+SN11jGqm9WFkiABrcXf8Xo7dsg9QHL3JxJz
	 m4sJgIfwHZdB3C6ZtDRWUS5sv7n9gAmsu1CjhkKxMT6zJ7kF+cqEkm1c5WmSnYMi1N
	 BtpRo/KmtrAog1Ebt6MuPgs9XpZRMtBzoG/JgEMD/syLPXp0DTwdbAx3tCjXUxmpNe
	 QOGnmD0kMSEzg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sui Jingfeng <suijingfeng@loongson.cn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Fix kernel-doc issues
Date: Thu, 11 Jan 2024 10:28:50 -0600
Message-Id: <20240111162850.2177655-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix kernel-doc issues reported by
"find include -name \*pci\* | xargs scripts/kernel-doc -none":

  include/linux/pci.h:731: warning: Function parameter or member 'pdev' not described in 'pci_is_vga'
  include/linux/pci-epc.h:154: warning: Function parameter or member 'list_lock' not described in 'pci_epc'
  include/linux/pci-epf.h:83: warning: expecting prototype for struct pci_epf_event_ops. Prototype was for struct pci_epc_event_ops instead

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci-epc.h | 2 +-
 include/linux/pci-epf.h | 2 +-
 include/linux/pci.h     | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 5cb694031072..bfe41b03b70c 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -122,7 +122,7 @@ struct pci_epc_mem {
  * struct pci_epc - represents the PCI EPC device
  * @dev: PCI EPC device
  * @pci_epf: list of endpoint functions present in this EPC device
- * list_lock: Mutex for protecting pci_epf list
+ * @list_lock: Mutex for protecting pci_epf list
  * @ops: function pointers for performing endpoint operations
  * @windows: array of address space of the endpoint controller
  * @mem: first window of the endpoint controller, which corresponds to
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 3f44b6aec477..92d0b71d33d7 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -68,7 +68,7 @@ struct pci_epf_ops {
 };
 
 /**
- * struct pci_epf_event_ops - Callbacks for capturing the EPC events
+ * struct pci_epc_event_ops - Callbacks for capturing the EPC events
  * @core_init: Callback for the EPC initialization complete event
  * @link_up: Callback for the EPC link up event
  * @link_down: Callback for the EPC link down event
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1a89dc66f89a..eb45087d7e00 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -715,6 +715,7 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
 
 /**
  * pci_is_vga - check if the PCI device is a VGA device
+ * @pdev: PCI device
  *
  * The PCI Code and ID Assignment spec, r1.15, secs 1.4 and 1.1, define
  * VGA Base Class and Sub-Classes:
-- 
2.34.1


