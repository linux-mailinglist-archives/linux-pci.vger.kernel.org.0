Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C40A4215FE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhJDSEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 14:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbhJDSEi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 14:04:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA2BC061746;
        Mon,  4 Oct 2021 11:02:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l6so447889plh.9;
        Mon, 04 Oct 2021 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKklRx9y5Qor/aGWnNnuo+lS2V9yeaUbLzR0QD7Qli0=;
        b=EjT1r3PfOqOTV9SjziQCZVpG3EQgBHx0RG8Xv1lR0WpTgXkde6DDI2XQGrKGdHGuOu
         sF8twN+l6PEyjaQgO2BIbkDAnZOxsyGpLSQx0bkTBfWz4phFythCJUO4BZRv3/Z/8zKr
         1//l0509wxgBJzdQE3exb9ktxgeL1GX8XjLoF24duAVx1O1TZSBk2RSLHje65Qnxn8tD
         choOqeAKFsYBiq3gwXktjQK6A0LUWmGLIwhm3ekrXBemHgpW2KSXMwBP7rUFeKDPmjfS
         WWxTDvX8wjrXjFPuwm3Fey5YCsR27a1Yb26TkgNatJpgQGXQF46aJ9xIPDup4JAZPfGu
         OtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKklRx9y5Qor/aGWnNnuo+lS2V9yeaUbLzR0QD7Qli0=;
        b=HUqCVuFIcd5uuOUKHaHLHcZbNTB1pk1qtXrlefC+qC8gWglQpY5Z0shn5SBaz7AVui
         4P33HKZflSue4k97zueShSA8+nOpru69GiJ5t6o7dPrRju6+mVffyEWDjyfDi+q38Zp4
         DKQsJpF/9fh5fx6C0oRSiCP67noRrk2DCALV4Ktejja48xalsX/P06+KenEMl3cnzXkY
         8FghdiaVEuFq66vN6Z6iFb2oLyutVXLLe786ng+8CHnWcsPr/USDULjNptpwinNxtwYL
         jt5R3au2IbIYNv9C/Rm46h6b9dv63K4w4MIEh8+jvo9leIM4Qipp+xgj7ZNFQyn8lUbb
         PPWA==
X-Gm-Message-State: AOAM530eJGyu7RaX4jQHMV8O75apboG1gCzXG4SaL8faCU+01GhfAFK4
        RRIM5x7O9jWehe9Zv2iAdfbU+XYbBg2NIH4O
X-Google-Smtp-Source: ABdhPJyBIls+LLr17tvrEzq80SP4CQurse34IktWPG8aqV9f13TkQAW/TRNDg2X5+MjZ3loaaHOhLw==
X-Received: by 2002:a17:90a:8912:: with SMTP id u18mr31155201pjn.69.1633370568999;
        Mon, 04 Oct 2021 11:02:48 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id z2sm3641004pfe.210.2021.10.04.11.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:02:48 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, tsbogend@alpha.franken.de
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH 6/6] MIPS: OCTEON: Remove redundant enable of RP error reporting
Date:   Mon,  4 Oct 2021 23:29:32 +0530
Message-Id: <66ad4e435d11d191ca71b491a15e1487e07fc204.1633369560.git.naveennaidu479@gmail.com>
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

Currently when CONFIG_PCIEAER=y, root port's error reporting is
enabled by aer_enable_rootport() in the aer_probe() path.

It is now no longer necessary for Octeon code to enable RP's error
reporting since it's done when PCIe bus loads the AER service driver.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 arch/mips/pci/pci-octeon.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index b973fc464c21..239eec8ac942 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -114,24 +114,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, config);
 	}
 
-	/* Find the Advanced Error Reporting capability */
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-	if (pos) {
-		/*
-		 * Leave severity at HW default. This only controls if
-		 * errors are reported as uncorrectable or
-		 * correctable, not if the error is reported.
-		 */
-		/* PCI_ERR_UNCOR_SEVER - Uncorrectable Error Severity */
-
-		/* PCI_ERR_HEADER_LOG - Header Log Register (16 bytes) */
-		/* Report all errors to the root complex */
-		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND,
-				       PCI_ERR_ROOT_CMD_COR_EN |
-				       PCI_ERR_ROOT_CMD_NONFATAL_EN |
-				       PCI_ERR_ROOT_CMD_FATAL_EN);
-	}
-
 	return 0;
 }
 
-- 
2.25.1

