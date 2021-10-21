Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661C1436552
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhJUPOM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhJUPOM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:14:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CEDC0613B9;
        Thu, 21 Oct 2021 08:11:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m14so906582pfc.9;
        Thu, 21 Oct 2021 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zEq2AfHmzmiP6iMn6OVsjvfYEnKpi8akIlRzP+t4I8=;
        b=pX96mXwiXPeCcU/ZLXG+82KZ6X1WwZf7RX3Kw1oTJXJycww++ljoclt7YyZKGpMDD+
         5l7uHnUBBtAH9GLNcQIhXR7I/ykoIVERhA0RlU5kuEWYgPTonPpKkAEhltbqXzkLMfnA
         rYYVpWcaqQQQtDXee/oBhUP9Gu6Ht6SlR6A9LzEh4O/+QIMrqFdUz0hY1NGJguRPysU6
         4DLYEssZQTX1tZuyhgkcVMlLKa3vx39CbBG/mb+9U8PJuwX8QNXI1nFrl/1UXWIWiELP
         b6KgYX+FV0mh5PcY7vBfUmlJ8cv4vrqjyLIIyaPLyEKOJvTTbLQAfPNoHGbINcyC30n+
         uklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zEq2AfHmzmiP6iMn6OVsjvfYEnKpi8akIlRzP+t4I8=;
        b=q58pSKX4YtuQ4VLLhwDLqtv/peqddX4iBQ5aM8NGWWdocyeuLe3Cjue+5Twbukjaym
         8mSqDyGGJteSm8OyUhYHGs+61L3Qe5/MWTw3Ocdn321wVL5RZN+K76d+5UBT9sCnMV01
         MLruE0XPN8Tk6I5vnyCiKD8JkcjW9g8YXuK5T9nuRBm98o91xMb9rT3m6nwC9AZaYWbw
         U8R6RNxwrlddMReP6bdYiFjgDWFXb4BcIEAVKILex+y4a+SHrpq781vIDjcetzHE9prE
         LGp8qOdRWgGSgr7uZqB+XaoC8Xei+zqhSPYswoVpsOeRiqMwMJx2rIy6ABd66+/CtbCw
         etQA==
X-Gm-Message-State: AOAM530h4Mf6tGXyzLveVEOjtNPuxvWlroGhSosZZWTbyVc+Twg6zSKD
        XIbj4FCOz9qXttJB7g1yLR1V0vaS9lu1jj9h
X-Google-Smtp-Source: ABdhPJyOLoEwlKV3KvkQhGAg1lxKYQIxIPxhV0ueMTAUdFskUAKjBG6cDkUpWJ/2X1ITIVPBwFiEJQ==
X-Received: by 2002:aa7:9099:0:b0:44c:a3b5:ca52 with SMTP id i25-20020aa79099000000b0044ca3b5ca52mr6578798pfa.85.1634829115365;
        Thu, 21 Oct 2021 08:11:55 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:11:54 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        AARDVARK (Marvell Armada 3700))
Subject: [PATCH v3 11/25] PCI: aardvark: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:36 +0530
Message-Id: <cbf7437d33551cd267135d2ed2a33bb789369e85.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/pci-aardvark.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 596ebcfcc82d..1af772c76d06 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -893,10 +893,8 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	u32 reg;
 	int ret;
 
-	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
-		*val = 0xffffffff;
+	if (!advk_pcie_valid_device(pcie, bus, devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	if (pci_is_root_bus(bus))
 		return pci_bridge_emul_conf_read(&pcie->bridge, where,
@@ -920,7 +918,6 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			*val = CFG_RD_CRS_VAL;
 			return PCIBIOS_SUCCESSFUL;
 		}
-		*val = 0xffffffff;
 		return PCIBIOS_SET_FAILED;
 	}
 
@@ -955,16 +952,13 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			*val = CFG_RD_CRS_VAL;
 			return PCIBIOS_SUCCESSFUL;
 		}
-		*val = 0xffffffff;
 		return PCIBIOS_SET_FAILED;
 	}
 
 	/* Check PIO status and get the read result */
 	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
-	if (ret < 0) {
-		*val = 0xffffffff;
+	if (ret < 0)
 		return PCIBIOS_SET_FAILED;
-	}
 
 	if (size == 1)
 		*val = (*val >> (8 * (where & 3))) & 0xff;
-- 
2.25.1

