Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D802429696
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhJKSPf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJKSPf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:15:35 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61D0C061570;
        Mon, 11 Oct 2021 11:13:34 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s11so11536218pgr.11;
        Mon, 11 Oct 2021 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xcssxkZTlEueyseAvWLLQTd3E+oYkVw7Pd99PMykLI=;
        b=co5exKtJ6qDmfzZFrPgxDp6dqyVCFIoEid4UcPCcvPulI+0EzTXG61Pdez9ro0k9TS
         rOqlkqHbLbs2QHttLz3uTb6FqVFfYGau8dOoF7d8CZwoS8IEYnHQZBODZEK+ayBNrDC4
         mmf1m5zkVYjFjoFAZO+qn4E//mgIiKpgP9WawSEHMmuJH5366WhZeUNOgVEvJQ9WoKc1
         w1I1YrdkMK4y17nyUPVbWsw/BUl5YZdgZWUWmAuHlTUTRqsnesaIrFsyYA+gGHJdB4+V
         e8K3rRj5c63yQgy8L641j+g+Fp1O3jICAzScshja8m+16hA+t3Fo7xzZfrbZB4ZV8VOd
         Wg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xcssxkZTlEueyseAvWLLQTd3E+oYkVw7Pd99PMykLI=;
        b=KDZIwvN4e2olCKi6pMp98GFAnzw2vBOXIx92iB1QAJvGrnBlsmPB3u9k3HzTorJcO9
         60PQ9OZmvBdcI8qm5Ufp8xHiJIjO4zojX5v59AM0Xs/xne2VDMtlU2A9tl8nrhejIL+C
         /t0ZEQWyGuHOCFviNlnXSZItqq8iU0OeiYwAAY6F66tAmYtFIk8hZEHhH+N9wBLW84aE
         UviC5AACZPuT0o0HjckplOWXxsxbczViZ/SNgb1dOwBMQjHTve84udETBfMEH1d1zH/B
         ZE2EdHuGHdN6idxBmSmBlwaoSeoKReuyZry/NSugosos2CN7npyBHbSHnbBK333ubXQL
         OS0A==
X-Gm-Message-State: AOAM531fJ7WI6rbsL1Q5Bbol75QtaJHCq/LKJ7mkY7A6EqLybqdErO0G
        BunsGlecsy2NWBr5s4+RMdqKdLTIIDfWoQNx
X-Google-Smtp-Source: ABdhPJxLvHgE+mf4PpgZ/Eb4hUwxN9ixlNaScFlJnQ9Fn0zNCjBFQz8suRQ/dY0sjpiLMCC6Zs3adQ==
X-Received: by 2002:a63:1717:: with SMTP id x23mr19276856pgl.182.1633976014242;
        Mon, 11 Oct 2021 11:13:34 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id m7sm8780611pgn.32.2021.10.11.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:13:33 -0700 (PDT)
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
Subject: [PATCH 22/22] PCI: xgene: Use PCI_ERROR_RESPONSE to specify hardware error
Date:   Mon, 11 Oct 2021 23:43:19 +0530
Message-Id: <afbff1fb626206fed8dd73bfde0f836abc2c03b2.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
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

