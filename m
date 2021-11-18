Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED079455D61
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhKROJA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhKROJA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:09:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CDCC061570;
        Thu, 18 Nov 2021 06:06:00 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k4so5310213plx.8;
        Thu, 18 Nov 2021 06:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJKYZ0DmEpP1c+Cyc4zstBHahVie6foEwa+j6qM9UhA=;
        b=jR4j+uWajdUBW8ioVx4f5AGVPE7plrg5Zo34hJRLJitbZCha37QIAEH8v3C2MoJa7L
         q5wQ/GZsXlkwhuooU5p0AbAlaFsADi6OUHnZsNN0WnvMrj6hC6uvKz8BX1vW1VuX64VR
         VTrlRCt4jn5QRUohdQMSMtX1OifQ1IZnPX7w+5MyfhrI1JMAd4mjkd2C8nmmPK0L7UPF
         f2YNQcjanKRL62xIjI+ejIjkPwS1WNldYOfy1AQukRqjRNKSndUpwb9Mb/9Ot4hEXnJH
         Pp6a8QIVJs25PViapKLN86m1IC+q/kZSX+IZfMehrG1tO9WDiiLbBnlnELHSAgcCwOYU
         TKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJKYZ0DmEpP1c+Cyc4zstBHahVie6foEwa+j6qM9UhA=;
        b=OS5C6l6yfk2MlES0BGsARAi25JdYyI4LoQcjSK9Y2hjDM0TYu3SkLNYb0kI9HKAbv4
         vT07oCexBLj9JD8PpjYTuCh1YFKX1KUntQ5lmp/3jXjEGzhBfsSIxR8wbP4eG05GZGHC
         h6K517sPmVfVKPO8tkoumJN6xcvhAT9Ji9EZzU6PqqYnFeT0Im0QDbJUKYnj1VrxPmrg
         WmN2smc59sKa1FXhrbmbRhW4ighdSteO4EyLe+ksaFsl2jQMeDOQxFHItuQj0khVWE8l
         rnIEZFjJsiA/Ul5sX1fhD4oKh46MxQvmLniqp+lKlzElZEjrEK1tslcbDDiVZ/tLGklH
         gyFA==
X-Gm-Message-State: AOAM5313lfkPvRCcMvOlGN7mN395XMVP+NtwlwIkTAlion3an/HYyrl+
        SewI9+5++0zEHvq5YbWt+VM=
X-Google-Smtp-Source: ABdhPJzzq68/X527KYUYiq6BXWx7Pi6UkM26Xbb7lDccllJj01D67EBk5gsrY3Egw/rUWXJ/CLdhdA==
X-Received: by 2002:a17:90a:1f45:: with SMTP id y5mr11000237pjy.138.1637244359702;
        Thu, 18 Nov 2021 06:05:59 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:05:59 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        SAMSUNG EXYNOS),
        linux-samsung-soc@vger.kernel.org (open list:PCI DRIVER FOR SAMSUNG
        EXYNOS)
Subject: [PATCH v4 08/25] PCI: exynos: Remove redundant error fabrication when device read fails
Date:   Thu, 18 Nov 2021 19:33:18 +0530
Message-Id: <765c2f27d85fcee4eb137023dc0a8f864eee9e36.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/dwc/pci-exynos.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c24dab383654..f9526d6de160 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -216,10 +216,8 @@ static int exynos_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	if (PCI_SLOT(devfn)) {
-		*val = ~0;
+	if (PCI_SLOT(devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	*val = dw_pcie_read_dbi(pci, where, size);
 	return PCIBIOS_SUCCESSFUL;
-- 
2.25.1

