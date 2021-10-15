Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A2242F5F9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhJOOrS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbhJOOrQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:47:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0972C061765;
        Fri, 15 Oct 2021 07:45:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so9492091pjc.3;
        Fri, 15 Oct 2021 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6PFmrQZfsZKbN43caoyPHUp+nOh1/rI/bPUZ2uC0hc=;
        b=nGikGQ9yK7YQbbTiDAZTKAQWSsgNQckh4RY8XQhGoaHkcigKBYQY2KHF0qvQic/nLu
         HfVplvAxNgmCVh7h2rARubH+bh3ouSbu9d5OxLS0JXDzPEoEc/IVvBaRDS9cVuRMi8O/
         ZHXXxMQ81BZpguTrosbAkvo/7HdvmNco2zoCXMSBHRImbrj/B+/P0Xd3xa5bxW+8Tuhc
         dpjlahkygD3lnVFrzemLItYDD9cWMY5OSbTo9ySaULEcDvkUXAyYLkdU1KWIP1Y8qJeO
         ytsG1qXrrCK/WmotzKXOHUMtVGbcHnWebuTQWggz99VPx8/Qx7fuLdjSggU/4SjRL7nR
         2hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6PFmrQZfsZKbN43caoyPHUp+nOh1/rI/bPUZ2uC0hc=;
        b=krPHEVvQBCnkucqqoOPO6FWckEQWAHN302sFngo4fkt9vg7STfYCL5tR++NoouOj/v
         A3R3b6GtF5LR1+vfQ4sLd6yB5a7G5TDQ23Cp7nxGVr66Bfjmcid1kkIrnp4qLMkaEejK
         UZfCWYNEwNdyJDTjXCNCy+rVZEtBKZ2zOkDxbv7aLhAeMQpnq7gEZRGBg9m/HmSEkifr
         ImaA0i++81KH+riW/kiZBp9J4YeZ/j9G3mNNqMnEHOgg+rY0+Wtqsk8fd3s6pxOD6F6s
         tbkL4YEKLlMv3yzrZrO72guwgfsByBu2mkiBZ213+uu6TQ52yEp//xHGlIO9iOosycaU
         9AfQ==
X-Gm-Message-State: AOAM530OyfkHs3dazKr4n3pXqnxddst/GiTInnKyO3gmgOv2nieD0MZR
        ZFKfrUCgQFVBeN6awubGbQyeeXW1tilp17pc
X-Google-Smtp-Source: ABdhPJzHSLLbZkANpEOmJJt9ZjgNl/FuqEkna0HiGHGREYtwtMfcmNXWKWFJV4RAIPngKcmcRn/n6g==
X-Received: by 2002:a17:90a:e552:: with SMTP id ei18mr28228052pjb.239.1634309109171;
        Fri, 15 Oct 2021 07:45:09 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:45:08 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v2 12/24] PCI: mvebu: Remove redundant error fabrication when device read fails
Date:   Fri, 15 Oct 2021 20:08:53 +0530
Message-Id: <3d1ade234a33d6140497b396ca6d02eba06ba235.1634306198.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/pci-mvebu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index ed13e81cd691..70a96af8cd2f 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -653,20 +653,16 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	int ret;
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
-	if (!port) {
-		*val = 0xffffffff;
+	if (!port)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	/* Access the emulated PCI-to-PCI bridge */
 	if (bus->number == 0)
 		return pci_bridge_emul_conf_read(&port->bridge, where,
 						 size, val);
 
-	if (!mvebu_pcie_link_up(port)) {
-		*val = 0xffffffff;
+	if (!mvebu_pcie_link_up(port))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	/* Access the real PCIe interface */
 	ret = mvebu_pcie_hw_rd_conf(port, bus, devfn,
-- 
2.25.1

