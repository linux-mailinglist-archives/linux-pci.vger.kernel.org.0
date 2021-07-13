Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064703C6770
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 02:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhGMA2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 20:28:17 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54917 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhGMA2R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 20:28:17 -0400
Received: by mail-wm1-f54.google.com with SMTP id k32so9268739wms.4
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 17:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q1JaKWz4ljmDgmlS6XOgBpL8dJbggktcA486snVdwEo=;
        b=CD37hZHid8KIx308NRAyxf8RSnYZ/hqK7YMVx1U/jJCklzuGp1rN0LW+UTJlb3g4cb
         ree5+Y52dw9TWLkYAh57vhGoGUW4ejILLbAKpmJwXU3SdiKZF104SMEftQZDtTFphI1s
         uUTzwU0Zg1V6vrlKRbqfsrkfp3LNE6vgsz4caZZ1qPUSN8WxcFNaDM2CKWp5TyimXL0q
         2JA/l2hnykpvM0dWnaE/mpq2E19GFmSIHv9Lge/5DqXk5jBFYQBuiEhckWMc/+jYmXJa
         UZVX9IIIke/LVuqeapWxVow65/Go0XytkDQplPaFkJ506R+MA5viWKMZuoMDXqpP/ndS
         zh7A==
X-Gm-Message-State: AOAM532Fd32yaWJ52CgcckJmIGAweJAJnDcos72jUyqPAIeQOZxQB1jV
        apdFlZ6ncgXbJolRDr+vkVs=
X-Google-Smtp-Source: ABdhPJziVUbprznFZuoOf+eG8kg08hyPDAKraPFSp2ML3Rde1dpKkVWCkubdOfyTsnbJzZC0XgepIQ==
X-Received: by 2002:a05:600c:a45:: with SMTP id c5mr17728264wmq.153.1626135927526;
        Mon, 12 Jul 2021 17:25:27 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p5sm38895wme.2.2021.07.12.17.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 17:25:27 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: Use pcie_reset_state_t type in function arguments
Date:   Tue, 13 Jul 2021 00:25:24 +0000
Message-Id: <20210713002525.203840-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcie_reset_state_t type has been introduced in the commit
f7bdd12d234d ("pci: New PCI-E reset API") along with the enum
pcie_reset_state, but it has never been used for anything else
other than to define the members of the enumeration set in the
enum pcie_reset_state.

Thus, replace the direct use of enum pcie_reset_state in function
arguments and replace it with pcie_reset_state_t type so that the
argument type matches the type used in enum pcie_reset_state.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci.c   | 4 ++--
 include/linux/pci.h | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575c15cf..5c3386a73eb1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2194,7 +2194,7 @@ EXPORT_SYMBOL(pci_disable_device);
  * implementation. Architecture implementations can override this.
  */
 int __weak pcibios_set_pcie_reset_state(struct pci_dev *dev,
-					enum pcie_reset_state state)
+					pcie_reset_state_t state)
 {
 	return -EINVAL;
 }
@@ -2206,7 +2206,7 @@ int __weak pcibios_set_pcie_reset_state(struct pci_dev *dev,
  *
  * Sets the PCI reset state for the device.
  */
-int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
+int pci_set_pcie_reset_state(struct pci_dev *dev, pcie_reset_state_t state)
 {
 	return pcibios_set_pcie_reset_state(dev, state);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f6..15f93de69e6a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -191,7 +191,6 @@ enum {
 };
 
 typedef unsigned int __bitwise pcie_reset_state_t;
-
 enum pcie_reset_state {
 	/* Reset is NOT asserted (Use to deassert reset) */
 	pcie_deassert_reset = (__force pcie_reset_state_t) 1,
@@ -1205,7 +1204,7 @@ extern unsigned int pcibios_max_latency;
 void pci_set_master(struct pci_dev *dev);
 void pci_clear_master(struct pci_dev *dev);
 
-int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state);
+int pci_set_pcie_reset_state(struct pci_dev *dev, pcie_reset_state_t state);
 int pci_set_cacheline_size(struct pci_dev *dev);
 int __must_check pci_set_mwi(struct pci_dev *dev);
 int __must_check pcim_set_mwi(struct pci_dev *dev);
@@ -2079,7 +2078,7 @@ extern u8 pci_cache_line_size;
 void pcibios_disable_device(struct pci_dev *dev);
 void pcibios_set_master(struct pci_dev *dev);
 int pcibios_set_pcie_reset_state(struct pci_dev *dev,
-				 enum pcie_reset_state state);
+				 pcie_reset_state_t state);
 int pcibios_add_device(struct pci_dev *dev);
 void pcibios_release_device(struct pci_dev *dev);
 #ifdef CONFIG_PCI
-- 
2.32.0

