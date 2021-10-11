Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D48429623
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 19:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhJKR7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 13:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhJKR7C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 13:59:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9A3C061570;
        Mon, 11 Oct 2021 10:57:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so398985pjq.0;
        Mon, 11 Oct 2021 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7RrUpXHMBa2MwBawvpLvvfXUYK2I60jM60gXD0OcNcw=;
        b=aFKSeSU9TUVFaXej6wCpVX9/y2VkyNsObwut8UG+KBB1iM+cAKidTntIyGBKH2MpqK
         LVRyCohtyUwvZD2JxaGi5L1v7+6l6lpRDK7nxeNBwbagnnV0jdNyPbk+cARwno9xzFFo
         2cSc8RmUIwa0SxN5eusnLPxfdk/61Tn2jn8QNKhjKrzhGgJplaN13DDVd2+QE6dccu9I
         Cnju10J0TmrK355V/qOihT3zOdRm00gfo6LHeixT6iJi2dQpr8WAeh0fXOmlDAi0r9Jf
         GiBjIiI9P2lCYGnpFCUkRbBLXXqWpyCFWCVCq1mgLyapdG1OEcXwHfTga7YFrzxmObhq
         3vBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RrUpXHMBa2MwBawvpLvvfXUYK2I60jM60gXD0OcNcw=;
        b=LCoDSLNQWfhfcFC8htD19inomVK12DUs8JBvuDcewM21RtZkIEF5L0zpSfW/ok4rNA
         Dz6hykzgKdGtBwPxReGAKC9PFus8O9N0H5xJbuCd/yxB7YEYZ6yWgBX+59jZaPcXj4ET
         +02jj+yk2ZCZvbDl4nub7l/qhjp6v/ZoERvNae4270hA4EbPF0pBFaJkHHHVj4TRWSQT
         yNbhZcrlvEOYJY3p8UcVtwTQZ6QhAna1TnXUglgeykUVeuWD+jetwdwwMZEBaCy62vK+
         HWEwOs0uGfAkLcF10mgPp/+9UpjOthlME3dPLCuPsP4RqhAg6U3y/LAkjER5sO9srhaC
         Gp9Q==
X-Gm-Message-State: AOAM533O+aci32TM/R/DV9MLLdbWxPqlfvSdoCrtddHwIW2aiX8CMUub
        m4ni9u/WUOe9ftce2QJvrzs=
X-Google-Smtp-Source: ABdhPJw3QWO1mlONGLv7GoXUJ2hPIaiKmw49nqybsAjQgzX7+kDu53tNplQvJQB2nPNbvtjMfbJ3pA==
X-Received: by 2002:a17:90a:578e:: with SMTP id g14mr481855pji.184.1633975022173;
        Mon, 11 Oct 2021 10:57:02 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id k3sm109053pjg.43.2021.10.11.10.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:57:01 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        AARDVARK (Marvell Armada 3700))
Subject: [PATCH 09/22] PCI: aardvark: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Mon, 11 Oct 2021 23:26:33 +0530
Message-Id: <f423dc9cc90e345680d289d5df7ff469e9b89c60.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pci-aardvark.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 596ebcfcc82d..dc2f820ef55f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -894,7 +894,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	int ret;
 
 	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
-		*val = 0xffffffff;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
@@ -920,7 +920,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			*val = CFG_RD_CRS_VAL;
 			return PCIBIOS_SUCCESSFUL;
 		}
-		*val = 0xffffffff;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_SET_FAILED;
 	}
 
@@ -955,14 +955,14 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			*val = CFG_RD_CRS_VAL;
 			return PCIBIOS_SUCCESSFUL;
 		}
-		*val = 0xffffffff;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_SET_FAILED;
 	}
 
 	/* Check PIO status and get the read result */
 	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
 	if (ret < 0) {
-		*val = 0xffffffff;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_SET_FAILED;
 	}
 
-- 
2.25.1

