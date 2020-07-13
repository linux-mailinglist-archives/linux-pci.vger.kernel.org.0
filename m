Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FAE21D6E0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgGMNYX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgGMNXK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:10 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCD7C061755;
        Mon, 13 Jul 2020 06:23:09 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n26so17185399ejx.0;
        Mon, 13 Jul 2020 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rplWXqoRmMzG/PAypQDSMVo9rsbsvM0HW4mN54VwCPY=;
        b=qOy7ElWW63EuFj1bTCYdyQLghlNDXNsRyywynTNgzD0Gq2x5qrJkewWFkC7exZ3ZK+
         WszpqO334hwMhryyStOXx4Lr6yXFcseq6PMIyjonDk24NsGX1T9MUDI2QUBUjO3LWGbM
         Li9jO95VLMGwEH/ZoYPlMg5XHj1kZ5ppuN+yX9tYvdA/nj3QJiO8zdIXlSNw2qo2a6nH
         sqbqya0t9Apm7UjW5m5M6YLJRGsvsyAdyWdCif1CyKWabSWLz57vj7tLaSDUILABN/76
         3mqzHZzhgpEV/h5XKdKHPT7Sv3o5sk5cKDjcx7xoPTUKFkv62VAV/8RkNo81Aco4xq90
         zLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rplWXqoRmMzG/PAypQDSMVo9rsbsvM0HW4mN54VwCPY=;
        b=hpoq7FtN3cKq95YYEtH2PFKR155P4ixw93SwsFFEBeLAy9CenaMbEYfRkQQYwjka4S
         VSWzfWNL6aeX3soQWiRVMNPfN4W4tV+Bj/gEPiH37xRRP+n/CFH9yXtwI2fd4nI6oRqv
         fW02dXav+yAJRWZAFFw9I5ziieOGwgM2RBl47MIxJUpbpa7C/2Vdz12b3IVgLBY9YkAr
         86JxMSwpqKzOtenFRv9VQ5vib23Qsoi7/f4FLvsQcG4976eeFJg3ImkIJujQpDk8TNjh
         WPfPZkdlBNavTLcpXEnc3SAWfpYRmFuHQGEooVjrmSU6guiAAiFBeCDncTSvnzqcmMcG
         dblg==
X-Gm-Message-State: AOAM533WUtPBI88HeVi1TkiLEcO1aSqAVj6EDggpPfjjDap2BxY7vyEE
        Ek17vm9jUBD6MKlcG/siZI4=
X-Google-Smtp-Source: ABdhPJwRfcZjb10nMLeLG67GTJhBUEo56JkZJMLUALmO5nYTsFEky+Xkmns5sJRXxh54bY0oHtpWTA==
X-Received: by 2002:a17:906:7115:: with SMTP id x21mr71985610ejj.86.1594646588253;
        Mon, 13 Jul 2020 06:23:08 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:07 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, "David S. Miller" <davem@davemloft.net>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [RFC PATCH 23/35] sparc/PCI: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:35 +0200
Message-Id: <20200713122247.10985-24-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 arch/sparc/kernel/pci_common.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 4759ccd542fe..39175f26f401 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -59,7 +59,7 @@ static int sun4u_read_pci_cfg_host(struct pci_pbm_info *pbm,
 
 	addr = sun4u_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	switch (size) {
 	case 1:
@@ -102,7 +102,7 @@ static int sun4u_read_pci_cfg_host(struct pci_pbm_info *pbm,
 		*value |= tmp32 << 16;
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int sun4u_read_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
@@ -132,7 +132,7 @@ static int sun4u_read_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 
 	addr = sun4u_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	switch (size) {
 	case 1:
@@ -144,7 +144,7 @@ static int sun4u_read_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 		if (where & 0x01) {
 			printk("pci_read_config_word: misaligned reg [%x]\n",
 			       where);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		pci_config_read16((u16 *)addr, &tmp16);
 		*value = (u32) tmp16;
@@ -154,12 +154,12 @@ static int sun4u_read_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 		if (where & 0x03) {
 			printk("pci_read_config_dword: misaligned reg [%x]\n",
 			       where);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		pci_config_read32(addr, value);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int sun4u_write_pci_cfg_host(struct pci_pbm_info *pbm,
@@ -170,7 +170,7 @@ static int sun4u_write_pci_cfg_host(struct pci_pbm_info *pbm,
 
 	addr = sun4u_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	switch (size) {
 	case 1:
@@ -206,7 +206,7 @@ static int sun4u_write_pci_cfg_host(struct pci_pbm_info *pbm,
 					 where + 2, 2, value >> 16);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int sun4u_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
@@ -222,7 +222,7 @@ static int sun4u_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 
 	addr = sun4u_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	switch (size) {
 	case 1:
@@ -233,7 +233,7 @@ static int sun4u_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 		if (where & 0x01) {
 			printk("pci_write_config_word: misaligned reg [%x]\n",
 			       where);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		pci_config_write16((u16 *)addr, value);
 		break;
@@ -242,11 +242,11 @@ static int sun4u_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 		if (where & 0x03) {
 			printk("pci_write_config_dword: misaligned reg [%x]\n",
 			       where);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		pci_config_write32(addr, value);
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops sun4u_pci_ops = {
@@ -284,7 +284,7 @@ static int sun4v_read_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 	}
 
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int sun4v_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
@@ -307,7 +307,7 @@ static int sun4v_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 				     HV_PCI_DEVICE_BUILD(bus, device, func),
 				     where, size, value);
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops sun4v_pci_ops = {
-- 
2.18.2

