Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FF64215E9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 20:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhJDSDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 14:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbhJDSDn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 14:03:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA186C061783;
        Mon,  4 Oct 2021 11:01:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t11so439322plq.11;
        Mon, 04 Oct 2021 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKIE676lAIQP3K8bm7VIPKhomAuX7+QEcMrA2aQJQD4=;
        b=AugnioZW9Cfwp3G3sNl3PuDtrwA4HVrVhrt63Bz71r+RGC1t3iLk0OWnjXCn2HzCE6
         5VLLw9uWj8X20O9E6kRZQVDSCzFySiieYyi1go8qwoMWFMlEYInBaj+UetkT5NuiFqF8
         gA1+VS9y3JlY42eo2CfT5sLY4QqJs5cGD8wx+OzuRO6m2iSV0/+GQSoj2OdeM7QMG2fJ
         k4YnZXRFoD+NYvwhBACyAT1vXcybc8AMlZlFQXQZ3uWF4zOcGbE7z2Uw2lfzGdSYT4EE
         pX4uVbEG9xk0yVMjEHx4mXJw9RB3lw2+RDxii46mp35C4vOv2WwthkGOon3yCKWxKLaK
         UrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKIE676lAIQP3K8bm7VIPKhomAuX7+QEcMrA2aQJQD4=;
        b=Tno29s8E9gqRjBItUbHE7xO3UWOEHTYjjnc9rn4euOOIViOuttGyFs2mSrCnpzqmd6
         sJdPrBNxaKyqb4bMsbrmmKiZ/fmAAJ3+hfZE+gW0/mET7ZlZDYgPu6GMhif7uQtgvR22
         iWObUkyinRpQOjqbSQQfITJKB+XEldYejsoVGq6WlEkXTYPQXWCm3NRuLdBzPeoR0+qJ
         XnBVGGL6aFTuU/1qdgXSyyMYBPYgGSUwJmtcGlH0YWDMX94yItVAFD1AvkYQ8KSq8evQ
         ztdCgPXSltuipfsHjsPY6klvR1Us9HdxZUEy2NE6bmyRL2HJQstW5fNM9RiJSoJ4/o2P
         bj8A==
X-Gm-Message-State: AOAM533eK+G7+dTXD2eJN90RjD99dt28rmtNCj/wrxX9cJV3RLdnLtt9
        wjalzbJ8+2JiSNVQ+HqKMnM=
X-Google-Smtp-Source: ABdhPJyBFAGowvpqQWLMH1+/Hh4N7CQei+7CS2x8RoVdpaytMm113MtrGmeFWEovPG7dbGJUjiueFQ==
X-Received: by 2002:a17:902:ee93:b0:13e:c846:c902 with SMTP id a19-20020a170902ee9300b0013ec846c902mr972060pld.88.1633370513074;
        Mon, 04 Oct 2021 11:01:53 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id z2sm3641004pfe.210.2021.10.04.11.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:01:52 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, tsbogend@alpha.franken.de
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH 2/6] MIPS: OCTEON: Remove redundant clearing of AER status registers
Date:   Mon,  4 Oct 2021 23:29:28 +0530
Message-Id: <81597ce8ee30ad01da86fe1edf0fab76aa9b9710.1633369560.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633369560.git.naveennaidu479@gmail.com>
References: <cover.1633369560.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

e8635b484f64 ("MIPS: Add Cavium OCTEON PCI support.") added MIPS
specific code to enable PCIe and AER error reporting (*irrespective
of CONFIG_PCIEAER value*) because PCI core didn't do that at the time.

Currently when CONFIG_PCIEAER=y, the Uncorrectable Error status,
Correctable Error status and Root status registers are cleared
during the PCI Bus enumeration path by pci_aer_init() via
pci_init_capabilities()

It is now no longer necessary for Octeon code to clear AER status
registers since it's done by PCI core.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 arch/mips/pci/pci-octeon.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index fc29b85cfa92..8e8b282226cc 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -124,11 +124,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	/* Find the Advanced Error Reporting capability */
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (pos) {
-		/* Clear Uncorrectable Error Status */
-		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
-				      &dconfig);
-		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
-				       dconfig);
 		/* Enable reporting of all uncorrectable errors */
 		/* Uncorrectable Error Mask - turned on bits disable errors */
 		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, 0);
@@ -138,9 +133,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 		 * correctable, not if the error is reported.
 		 */
 		/* PCI_ERR_UNCOR_SEVER - Uncorrectable Error Severity */
-		/* Clear Correctable Error Status */
-		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &dconfig);
-		pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS, dconfig);
 		/* Enable reporting of all correctable errors */
 		/* Correctable Error Mask - turned on bits disable errors */
 		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, 0);
@@ -159,9 +151,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 				       PCI_ERR_ROOT_CMD_COR_EN |
 				       PCI_ERR_ROOT_CMD_NONFATAL_EN |
 				       PCI_ERR_ROOT_CMD_FATAL_EN);
-		/* Clear the Root status register */
-		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &dconfig);
-		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, dconfig);
 	}
 
 	return 0;
-- 
2.25.1

