Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAA37EEF7
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 01:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhELWjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 18:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347115AbhELVpV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 17:45:21 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCC2C08C5E2
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 14:33:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so17929638oto.0
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 14:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/15MHiAlc6xz1A6elcIFgCFPSVpeTQDZmFuJCLKfLc=;
        b=It7ou8gkunxD0e0MqNavUH/urf+BrjD8CdBJzdUNBwHcp1IE7eEY2UEo/FNA3mfXNC
         z/CLgSzgc1i05BZQoD4DvMVpoIwnOP2e8m4dMgjBElog+6gei8lBT03B0C4AIcuV9xmV
         +fkHOwMXvDFHSUVOOLuFB8dyBzEns3IEz7wNiIGKv2oXtVqGrIXGI8Dk2TV0fvV5p8xp
         0wsaGaRpU0IxV9coomZYsW2SiCu9jFTVewcx//Z+KyLqN2W/EIkwgUy4fdCPnUNfoI0E
         wDyQ+lZ8/B0KDLW9aAlq/0t+nkIa2+SNx2t4QHEymCWZz5IQGQYIb+YDs9zQw423JYGs
         sfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/15MHiAlc6xz1A6elcIFgCFPSVpeTQDZmFuJCLKfLc=;
        b=nV5mJ404fGs4POEjC/QKd6PMNxYzPPI5+Lzy5MoQsrjkH6NFujrY8EtNGmc/9JQMe2
         KjECmvdMMxCHqVY7j9803r2GlZIF47f4f/2Mix79RbUxA+JVw3KR4BFx7RuXMedJaW4t
         nNvoepL+LepRrMXyk5h2hUPaHAnF0OjK2iUX2gGGh4VzYblTcU+tATdZtf//coNbsyiN
         VdVOXOrOoefYaBPsnTJqB/E7FWvnu0ujjZHJ09wCEWqPL7QeSn3AvDsAp1TDXRaLQvuW
         2FQBIqQZwir3r/zuT6ASdeOxxfp0efURGuH4LZYBT3TIPzQkxv8GfnCfr4y6FpP6B/es
         8opQ==
X-Gm-Message-State: AOAM530VFWC0wnqS3F4/t63Z495Psq6869LrxuFW90S+OCTJYUmDum1h
        WHvPNY6ef7wN9Fe3isXkCHo=
X-Google-Smtp-Source: ABdhPJyJRVnJSS8A/A5iBFX5k/6XFRfAivozN76+M9HRjDBw66ey/2kK+BTUOus+0/ZWvba8dm4e1Q==
X-Received: by 2002:a05:6808:6cf:: with SMTP id m15mr26781884oih.30.1620855220851;
        Wed, 12 May 2021 14:33:40 -0700 (PDT)
Received: from localhost.localdomain ([14.141.145.218])
        by smtp.gmail.com with ESMTPSA id z6sm244962oiz.39.2021.05.12.14.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 14:33:40 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2] PCI/portdrv: Use link bandwidth notification capability bit
Date:   Thu, 13 May 2021 03:03:14 +0530
Message-Id: <20210512213314.7778-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcieport driver can fail to attach to a downstream port that doesn't
support bandwidth notification.  This can happen when, in
pcie_port_device_register(), pci_init_service_irqs() tries (and fails) to
set up a bandwidth notification IRQ for a device that doesn't support it.

This patch changes get_port_device_capability() to look at the link
bandwidth notification capability bit in the link capabilities register of
the port, instead of assuming that all downstream ports have that
capability.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---

changes from v1:
	- corrected spelling errors in commit message
	- added Lukas' reviewed-by:

---
 drivers/pci/pcie/portdrv_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e1fed6649c41..3ee63968deaa 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -257,8 +257,13 @@ static int get_port_device_capability(struct pci_dev *dev)
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
-	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		services |= PCIE_PORT_SERVICE_BWNOTIF;
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+		u32 linkcap;
+
+		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
+		if (linkcap & PCI_EXP_LNKCAP_LBNC)
+			services |= PCIE_PORT_SERVICE_BWNOTIF;
+	}
 
 	return services;
 }
-- 
2.27.0

