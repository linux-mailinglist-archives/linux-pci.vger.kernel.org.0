Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D861AD234
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 23:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDPVvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 17:51:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44109 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgDPVvR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2020 17:51:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id j4so4392312otr.11
        for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2020 14:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7M3k+FxFM2t4ExxYTaDGkabiudch2FpP3FcpmG1/ak=;
        b=Y8LlsyM5i2YtGkSoC2W9Z4FR+JMEJG05PhPoYF7uBnqNg7biGHAEyaG6c/ZeZ+3YXm
         cjGPsq+HnLkjmiXbPVl9xSrqISwC1QLCViY+y+a/j8nNM2sS8nua46dKjQMCTAlYL09e
         izIFO+nYzvnQAcOtSjjMbQQfxuIak6dfFTWh7GONRu0mVNRB8tpU7A35QoZQlVqho60O
         dNmdRmBGLWuQ4nMDccYWQC7YHLYAog66PpVUhq5X8AocsHulPSLfkKM8lRMnO935Oy2B
         MYu3zBG046YxRsefDgNIwD3I2H0z7UWPSX+WKiEhmY76ah2mj+IaZxktZIsPUXTcoJ13
         3aOA==
X-Gm-Message-State: AGi0PuaeoBI3N/TdryRt+mNHSd8kpRT4Dy1U09TLSGhYutgGrsAcGcHi
        pRBToWWgZ+0sXl1G1OhQ+g==
X-Google-Smtp-Source: APiQypLorbM+YGCvyVCHjhxXKdsUcPK96qQ5LqT3sag6/2WHfdgbhXtSImcI2eO6SFiUXSzTws3LMg==
X-Received: by 2002:a05:6830:157:: with SMTP id j23mr167039otp.93.1587073876082;
        Thu, 16 Apr 2020 14:51:16 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id q3sm205776oom.12.2020.04.16.14.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:51:15 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Use of_node_name_eq for node name comparisons
Date:   Thu, 16 Apr 2020 16:51:14 -0500
Message-Id: <20200416215114.7715-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/hotplug/rpaphp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 6504869efabc..9887c9de08c3 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -435,7 +435,7 @@ static int rpaphp_drc_add_slot(struct device_node *dn)
  */
 int rpaphp_add_slot(struct device_node *dn)
 {
-	if (!dn->name || strcmp(dn->name, "pci"))
+	if (!of_node_name_eq(dn, "pci"))
 		return 0;
 
 	if (of_find_property(dn, "ibm,drc-info", NULL))
-- 
2.20.1

