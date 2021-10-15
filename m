Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF642F627
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhJOOtd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240967AbhJOOsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:48:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285FAC061762;
        Fri, 15 Oct 2021 07:46:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t11so6526734plq.11;
        Fri, 15 Oct 2021 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKrtrnYSDksMWdgmUznUR/Q64gwdi8mvvQO4UVqOm9E=;
        b=Inc1Q7qKweM0tGJP+CWhPMXm+v1Axi75stMnqo37FnW41/u8uhJxSram8OfhxWJmx7
         ingaTUh91Stnkx0O8obZeD0ODKeAEBTvLoxyuFRrCsHd8M66Gg9ny36i7KlXtQxFB34I
         bu13sSJTRQ+p1DB2XGXPOl23hHG9V93RWK/KXQc8Q+KMejYlj1Nj0VaMOdSAfrGUZvhi
         iIujdDQUwH2Ev7bP2bKX4VAELQlWe/tMlrj6FSetMmjSJRxYctzqpkO9jeE8voBVMUx5
         O+EjlmJhNBiUt0b7PGFLNmO6W5v4ZYluSBFJonLeVVk7BM3MtPWUX/bBkdQaGdPiqtKZ
         FnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKrtrnYSDksMWdgmUznUR/Q64gwdi8mvvQO4UVqOm9E=;
        b=A16bMRT8OeARl4TEYflkaun/Dgs9n+nZfC0FIUb/ZuB9m8Za5IerJbLSv6kpTa4dso
         m12Ml61rnhZ0Jc9WiTvetuMBmflmXdoSNy645nF41LdVfRn2B4xm6cTEh+K6o/UOzEBA
         1Wm2DDeX/+F6WqEYD/ozHAYuzQJcFkVYUbvPrnx3Mpd9xaPT0PqwLicsPivjLBg3E+tX
         hXVyPDjA7ScAqePinl53iqqymc8a4zY/A+/wLjAPsu1hXVg6SeSfP2ukJzHJh9RPKlA8
         0/XHyzKoDFVpDQVta0dx9kppKw/KpPaxzhvuJlCWsF+3b7aOYsHVtPq4EUhVM7IM73/j
         9lGA==
X-Gm-Message-State: AOAM5304oUnBC2Cmq7ZXxlPiK3NmEbRWwDNBu0906M1H0jo7ceA4RRHE
        JOM/mtKCL9LvA4GehhGREmI=
X-Google-Smtp-Source: ABdhPJyJ8FQ16vD47i4rGFglTPo9H74I0SPwjWN0ikhEg5awUxLojaILYXXw4ixmXnGPJB0ufC3kUw==
X-Received: by 2002:a17:90a:c6:: with SMTP id v6mr28477261pjd.172.1634309203633;
        Fri, 15 Oct 2021 07:46:43 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:46:43 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 22/24] PCI: keystone: Use PCI_ERROR_RESPONSE to specify hardware error
Date:   Fri, 15 Oct 2021 20:09:03 +0530
Message-Id: <a5d08c57881d92e0f3fbfc7886be875886f527c9.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include PCI_ERROR_RESPONSE along with 0xffffffff in the comment to
specify a hardware error. This helps finding where MMIO read error
occurs easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 865258d8c53c..25b11610b500 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -748,8 +748,8 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 #ifdef CONFIG_ARM
 /*
  * When a PCI device does not exist during config cycles, keystone host gets a
- * bus error instead of returning 0xffffffff. This handler always returns 0
- * for this kind of faults.
+ * bus error instead of returning 0xffffffff (PCI_ERROR_RESPONSE).
+ * This handler always returns 0 for this kind of faults.
  */
 static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 			 struct pt_regs *regs)
-- 
2.25.1

