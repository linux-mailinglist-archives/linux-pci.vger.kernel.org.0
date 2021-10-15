Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038A442F62B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbhJOOtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240811AbhJOOtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:49:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51922C061774;
        Fri, 15 Oct 2021 07:47:05 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e65so6421752pgc.5;
        Fri, 15 Oct 2021 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xcssxkZTlEueyseAvWLLQTd3E+oYkVw7Pd99PMykLI=;
        b=Iy+AonqojkrW8rKIV3iaCTVCXCGDTy7haLOxTS468QgbAhuk81NQIp7kYWZHskLo6s
         v8sCPrmS67ugEEigbj1fwjQdlU8RKGwOO/eUToxWh16fJjtH/QhnDiUGh0FhHudjtVx/
         coEpyt11LgRWe1SNGFFBvYZWHHPjeQjG5hOnqzu3Cr4OetheCAwq0JtAuDiWWAVj94tI
         uOjJnJyPXMyHjlxrzw/eNa6/zMYBiDOQ1GZaF0cBSSMAyJhDdFjnXvawtpTM/tYzX3Lh
         beQ3GoX5EjQwIB64IWMv93LWrndytwEQtQwba9QMabTYbWyrF0rHqfuGQlg1WEpBo22L
         X6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xcssxkZTlEueyseAvWLLQTd3E+oYkVw7Pd99PMykLI=;
        b=rYDS4HrYpSYW5uEI+yy9eCuB2R5VYPFSaaHpm8MZZy98YdKZteqvL+DGQ+a/HQ3cIJ
         6VQtuX1pePvDPtkkYF7Adk+sMKuO91uyHwBc807k86C64iESMHsuWWPQcWSs7vLjoR+w
         q3g+Gzznq4nR9MauRZSHD6Kjs2Zlefv6WS4PojStifGf04pClfbf54aoekNM1it29Z8x
         5P1hW+hVWznCUWjf6zRULy81AOblFGYqh5MLJMY1FhCGN+Vh/DeF4W5z6ZPeEJGUsFPN
         ECW01HdgYbHeRzNK5MlR5yaHCI6a3WeHIA1welLUoBoBRf7dNkc2g5wRa5xPRxbfubIQ
         wY+w==
X-Gm-Message-State: AOAM530iQ67C2+QwqFLEQsnhEgqq2BiizN6O1b8KLLuowYDi1CX1fohB
        Vggmkbz24OJvj2V7jxO9s5a0Fz9rR2Eui/Yl
X-Google-Smtp-Source: ABdhPJwi/McjAR5PneaBPmW4CRufrgJrhsRVQ8oeQWMqZvCjg+NqlGDu+MFUmairIcko2zay8NCKPw==
X-Received: by 2002:a63:e516:: with SMTP id r22mr9610343pgh.197.1634309224790;
        Fri, 15 Oct 2021 07:47:04 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:47:04 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        APPLIEDMICRO XGENE)
Subject: [PATCH v2 24/24] PCI: xgene: Use PCI_ERROR_RESPONSE to specify hardware error
Date:   Fri, 15 Oct 2021 20:09:05 +0530
Message-Id: <d5791e3697e6b78f0283c39dd58ba247a429d3c7.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include PCI_ERROR_RESPONSE along with 0xffffffff in the comment to
specify a hardware error. This makes finding where MMIO read error
occurs easier.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pci-xgene.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index e64536047b65..4b10794e1ba1 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -176,10 +176,10 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 	 * Retry Status (CRS) logic: when CRS Software Visibility is
 	 * enabled and we read the Vendor and Device ID of a non-existent
 	 * device, the controller fabricates return data of 0xFFFF0001
-	 * ("device exists but is not ready") instead of 0xFFFFFFFF
-	 * ("device does not exist").  This causes the PCI core to retry
-	 * the read until it times out.  Avoid this by not claiming to
-	 * support CRS SV.
+	 * ("device exists but is not ready") instead of
+	 * 0xFFFFFFFF (PCI_ERROR_RESPONSE) ("device does not exist"). This causes
+	 * the PCI core to retry the read until it times out.
+	 * Avoid this by not claiming to support CRS SV.
 	 */
 	if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
 	    ((where & ~0x3) == XGENE_V1_PCI_EXP_CAP + PCI_EXP_RTCTL))
-- 
2.25.1

