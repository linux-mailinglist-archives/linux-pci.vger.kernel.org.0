Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0BC42F5E2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhJOOpR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbhJOOpR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:45:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A18C061570;
        Fri, 15 Oct 2021 07:43:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s1so4713247plg.12;
        Fri, 15 Oct 2021 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3o5gBqF0m60j/685v1gCV+85CWmYdPsbI4M53MCV74=;
        b=i6fqth5uZU8VCAy4RPMnbl7AIp+Tdvs11/vzA7yll5FwjxTWdkRv88xIyhz0rk2t9u
         d4AiJSDP9CeHws6FKjuMBjxyhe3oEKOlHBeRvXqqSONxYvGaf/uu/y8kCDk7Z6bc4uW5
         WrvJWL+UYcG1TwCL22/zI+7Y27VKBRtvBou8+Mxw+Buv+EtieEQ5ZlJLDA+ryKzQv7tM
         GVcKbxBrGR/WZOyeKmiDwtFpl0kCPqLy5BzU+2dkv32Q9ciLg3lI1SEDECWR9dA4q9Vb
         t3SUiEXFtf2kXoqI+thdO7iaXuabp1MfEWNiLcGvQ84iWwAbAw22BL5ZTmVth5ZnWwiD
         qTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3o5gBqF0m60j/685v1gCV+85CWmYdPsbI4M53MCV74=;
        b=XlHOkX0/dW2yD4DsMQYYOjMSL6MMfqvRjh38xyYu/M0dnOff5rzr6W/QzIDxTtxZWx
         9WrEeyVdQwj5hRz/XYIqfQtyUN47VszFlwT22+HFVE7N9jdZtEwdV2YAeNIWxIgwOM6v
         QbHrEpmQVNrpCLXVXcW7CWHkIUrB7JS/X0P8S+6TZPfQIX74IdAwwWqDUfvWYUorTLAI
         MOrcKvvYQRwvo9nRrDSHwmJG+tHPiqkGzfUYHUu2sexguA5gHvMZB5K/heNlwCvLRXnP
         EoCKimvrqWmrtNIj4KCTisNbXMOIAyPKGej34MaBr3b245yZLj2nINlagqvjK/FJiCth
         jxTA==
X-Gm-Message-State: AOAM531XfkJUhtiHwH4s2anFzceHQvC/0CwQYmSvfgfTIbdf/GqHRxIG
        M6jKJdfteiX0p1lwn2MNg+c=
X-Google-Smtp-Source: ABdhPJzkMtVHGIdaTQNm5//+Jby5D/TcsxlUwCEhyb9oKSRH7DSUsXLOHVItXyEfjnr7nGsywbcjyw==
X-Received: by 2002:a17:90b:390d:: with SMTP id ob13mr13887102pjb.49.1634308990354;
        Fri, 15 Oct 2021 07:43:10 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:43:09 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE)
Subject: [PATCH v2 06/24] PCI: iproc: Remove redundant error fabrication when device read fails
Date:   Fri, 15 Oct 2021 20:08:47 +0530
Message-Id: <71757601a719e2ff6ca27615183e322a7709ff65.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pcie-iproc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 30ac5fbefbbf..e3d86416a4fb 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -659,10 +659,8 @@ static int iproc_pci_raw_config_read32(struct iproc_pcie *pcie,
 	void __iomem *addr;
 
 	addr = iproc_pcie_map_cfg_bus(pcie, 0, devfn, where & ~0x3);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	*val = readl(addr);
 
-- 
2.25.1

