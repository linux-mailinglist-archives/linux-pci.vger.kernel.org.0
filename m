Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0854215FA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 20:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhJDSE3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 14:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbhJDSE2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 14:04:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F384C06174E;
        Mon,  4 Oct 2021 11:02:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y5so463861pll.3;
        Mon, 04 Oct 2021 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25oPhBAQkpYHQtBYswx+vS6+yZtQwuBWM057qnMpNgo=;
        b=a+i/D2I2zafjFRyVlx3zfqTHD/dvxl0+TVAzlmofD0s5Qm7DQxny3W3HPYBfFYfg7U
         DPQwS1MXFkOlOEpIdsFNgW8RFIwa5dUjs31vNl+2J46pcKEmEZJJO6cHIAAfEXRsgpHg
         7SwyOHal9fLukzQPAoo44doJJpZoZSEa8MLs0kOFAtuH+etLAEp3iHhVG3baosWkdLjq
         4mMw8HON7jV2S6toLxJWlPp/fmwhz5Yh+8izA9POP5P7hU1PGWxFjBJiB4w2TPhM/Vi4
         m5L3pOMuyKVbbnUWI2LL6mA8/H5aPbRdQ5dJQSCCj5/1kq4gAWl/sn6rxKpJORaP1S+d
         Jkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25oPhBAQkpYHQtBYswx+vS6+yZtQwuBWM057qnMpNgo=;
        b=ZBSLPDoW6SNomPi+37ehcFf7Nrxc1U3e/wrUG6zuukuWmP6nrDkKQvKLBeGRv7kRF+
         UzNJtbb72ZCtPjtYB/cu9RDZrx1feYBr5pmkCAMx0YPom/QgW/ni4DbGrFd/ADjg+ZwC
         M2l01yWeqo+aBIbA8xbHFkiDM3sH0JlGxgYA1Ji2XAO2DSHlWJXptY2OxH5SUihiHRAe
         +vFxyMPO36iEWev4crTXIsZ1mKBYGPdfOanW6FKrgBmPNh3j3usWO6oI071SzJHtBshY
         OokES6y9QGdrx1unEIK2CJXkgPffe54SKkrt+ruSEs41rLaMCACtSzVD9tfxev7w2kUL
         WQug==
X-Gm-Message-State: AOAM531/9qP6ouYkW1kplSMFGZNrWIgx7015sRafqGGBdwiWJUOPL57d
        FBculNW9QSHqnQ5OljwNHo0=
X-Google-Smtp-Source: ABdhPJxv6QIzFS3p/UlJANVCJKP+PWKnIFZqL4BNZk5cQPC6u6+nGacnfaojYfhuU38H2X9HnRDehA==
X-Received: by 2002:a17:90a:428e:: with SMTP id p14mr38364317pjg.92.1633370558785;
        Mon, 04 Oct 2021 11:02:38 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id z2sm3641004pfe.210.2021.10.04.11.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:02:38 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, tsbogend@alpha.franken.de
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH 5/6] MIPS: OCTEON: Remove redundant ECRC Generation Enable
Date:   Mon,  4 Oct 2021 23:29:31 +0530
Message-Id: <6d0856b6953765463aac43fbd641d26f19dc7e11.1633369560.git.naveennaidu479@gmail.com>
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

Currently when CONFIG_PCIEAER=y, ECRC generation is enabled by
pcie_set_ecrc_checking() in the aer_probe() path.

It is now no longer necessary for Octeon code to enable ECRC since
it's done when PCIe bus loads the AER service driver.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 arch/mips/pci/pci-octeon.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index a82cf48f00ab..b973fc464c21 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -124,15 +124,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 		 */
 		/* PCI_ERR_UNCOR_SEVER - Uncorrectable Error Severity */
 
-		/* Advanced Error Capabilities */
-		pci_read_config_dword(dev, pos + PCI_ERR_CAP, &dconfig);
-		/* ECRC Generation Enable */
-		if (config & PCI_ERR_CAP_ECRC_GENC)
-			config |= PCI_ERR_CAP_ECRC_GENE;
-		/* ECRC Check Enable */
-		if (config & PCI_ERR_CAP_ECRC_CHKC)
-			config |= PCI_ERR_CAP_ECRC_CHKE;
-		pci_write_config_dword(dev, pos + PCI_ERR_CAP, dconfig);
 		/* PCI_ERR_HEADER_LOG - Header Log Register (16 bytes) */
 		/* Report all errors to the root complex */
 		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND,
-- 
2.25.1

