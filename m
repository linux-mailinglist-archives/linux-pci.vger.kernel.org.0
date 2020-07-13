Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C29E21D6DD
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgGMNXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgGMNXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ABCC061755;
        Mon, 13 Jul 2020 06:23:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lx13so17143399ejb.4;
        Mon, 13 Jul 2020 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a4qclUpgkVLODkm3qmb6k0l4x97EWCpj9W69r9J7+M4=;
        b=qhqR5FlSBoF6xGgJ9myL6BEHj3SWp6zu5kQf3Ik4Rr69Vd1gY84Qi4wolwrTt0qgYW
         plapG8w+tVKsouDRp8WFKqpLN6+pXFT173QI0rIgfIm6txt4X73hrtNVlJqsil9mcPHZ
         NQXZcfqCsCGOxQtxhIsBMR/rdNPGE7633fXpVIxFTIrj51dp+3llmstY0ZDnzbZSNE8X
         gWVRu/J5Iyotd+NeBiu+FhV1zTqL09iLZivT8tlxugX9yFAWU/fipl6u5iIi6ocyCcBT
         u+aNZEHAH7qCFKogHZPz0pjyycFT3CC6gU4Ows7yZIUpmdHa6u4qBDHFpopfJgiPZW7d
         5Mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a4qclUpgkVLODkm3qmb6k0l4x97EWCpj9W69r9J7+M4=;
        b=CZcnWHbyq8HmkHMfTjyTqQOVb7iZofxsccbEgqD77n1kQ7hxkpkRpTsy+oWm7Y+6Dw
         UTWDzU4MuXEfBV+rj5ny2eFWjaXbcki59cI7e1uvYaKQLnCXoqnNrinOB3FF3WCkDG/F
         eYkij29J0bpmTj95bS+qMWZq16qUtvyZphxvoHwSxkhHi2zu9yxQpYrSwbTBEaD9gg0D
         z5rRk/668RbTJElc38udJONkoP44wkZnJ0jaNJoQAw1rpOmDwtp/G1HUDPazY40+ITsh
         bqsCwUQGhWZdKmgdin9gHV//otWzZOx7uFPh/fTj2KjJJrdRVDQuxK0RTStsPhtyf/Nv
         UYgg==
X-Gm-Message-State: AOAM533SlBDT+J2hTIu6Q/YOrIL91aWlGDI4CIR2sNOafG8oGtvDparL
        nMbRx5Ho36I7Co14H1f9Hl0=
X-Google-Smtp-Source: ABdhPJwhwgHzEzV8y9RxY4MQVGO6CwCxft/SH/sDeVCsCsqstTlIeftQpN2hNpcjN9TS7Mn+dSK4Eg==
X-Received: by 2002:a17:906:2b52:: with SMTP id b18mr75602949ejg.158.1594646590832;
        Mon, 13 Jul 2020 06:23:10 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:10 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [RFC PATCH 25/35] sh: Tidy Success/Failure checks
Date:   Mon, 13 Jul 2020 14:22:37 +0200
Message-Id: <20200713122247.10985-26-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary check for 0.

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
This patch depends on PATCH 24/35

 arch/sh/drivers/pci/common.c     | 3 +--
 arch/sh/drivers/pci/ops-sh7786.c | 4 ++--
 arch/sh/drivers/pci/pci.c        | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
index ee27cdfd3e68..676907e6a514 100644
--- a/arch/sh/drivers/pci/common.c
+++ b/arch/sh/drivers/pci/common.c
@@ -60,8 +60,7 @@ int __init pci_is_66mhz_capable(struct pci_channel *hose,
 		if (PCI_FUNC(pci_devfn))
 			continue;
 		if (early_read_config_word(hose, top_bus, current_bus,
-					   pci_devfn, PCI_VENDOR_ID, &vid) !=
-		    0)
+					   pci_devfn, PCI_VENDOR_ID, &vid))
 			continue;
 		if (vid == 0xffff)
 			continue;
diff --git a/arch/sh/drivers/pci/ops-sh7786.c b/arch/sh/drivers/pci/ops-sh7786.c
index 7c329e467360..c1be0ac2508a 100644
--- a/arch/sh/drivers/pci/ops-sh7786.c
+++ b/arch/sh/drivers/pci/ops-sh7786.c
@@ -101,7 +101,7 @@ static int sh7786_pcie_read(struct pci_bus *bus, unsigned int devfn,
 	raw_spin_lock_irqsave(&pci_config_lock, flags);
 	ret = sh7786_pcie_config_access(PCI_ACCESS_READ, bus,
 					devfn, where, &data);
-	if (ret != 0) {
+	if (ret) {
 		*val = 0xffffffff;
 		goto out;
 	}
@@ -137,7 +137,7 @@ static int sh7786_pcie_write(struct pci_bus *bus, unsigned int devfn,
 	raw_spin_lock_irqsave(&pci_config_lock, flags);
 	ret = sh7786_pcie_config_access(PCI_ACCESS_READ, bus,
 					devfn, where, &data);
-	if (ret != 0)
+	if (ret)
 		goto out;
 
 	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x "
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 77130f035fdd..19e9a211c23e 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -204,7 +204,7 @@ pcibios_bus_report_status_early(struct pci_channel *hose,
 			continue;
 		ret = early_read_config_word(hose, top_bus, current_bus,
 					     pci_devfn, PCI_STATUS, &status);
-		if (ret != 0)
+		if (ret)
 			continue;
 		if (status == 0xffff)
 			continue;
-- 
2.18.2

