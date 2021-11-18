Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE9455D5D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhKROIk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhKROIk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:08:40 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545FC061570;
        Thu, 18 Nov 2021 06:05:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b11so5299042pld.12;
        Thu, 18 Nov 2021 06:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZn4SxDZvh+tavMY8+enW7L1nqxNB0bRzV0t3A5PNmg=;
        b=JG5K9Trd1o3s4rrA6V+Ay1LKEJnXRI5kjwDECp3bKxrUj+eDe+iJmCOxM5RXaT7FBj
         wEHlIjohorJgsIIb/ELmE0bh34ntCQCc9Wp6Vmbtq00W4kdPbwQ6n4rCIphJNy7Fju6Q
         4Zpx3SndARG4CvzkOtorq1A1jbfbAR1UKd3x99AELcG7XRA9l2y5lW2KpA3wWXJEJBHb
         OKyIlxB8PqJ9RUWcV89WDhgxB/ptMVQjvisEzBZa7VsepHzxGFkyKJdWXHT6u4GqyuO6
         STb6sTk5n2jjW1HfkB+mxZZlHikXjN73pqTyz7JjsHdJXKPEEuHDwx3tYkTN2fb8yLz3
         Mwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZn4SxDZvh+tavMY8+enW7L1nqxNB0bRzV0t3A5PNmg=;
        b=wm2MvKLOHifsAbq9BbVVhuIofB3zlwTBKkqd9QCtwQ7Nrkrr3IHxM+MC65WK9PFOZp
         fU+4Ku0xe9O+XUC9QNUeZwMZ8gDGQT6jAwCNYD+M2iOdaNJnQvJfh0gFc5lWLAhFvCdQ
         e0oKQ0GzyK4We52A2H4x/xt+KXMfHvS5wwXsX9qkyH68ZhBDaOgFz/4bBsKlTL02HAaK
         ah6ybTZx9zZdHmHibteMsMeLJDMbcpYSeJLpYkdQ/Q0UzRcP+t8ady1u1oMTpl0qvT22
         Tf25ogl3a+pbiRp7+YQceA/ghf8uZdY4CS1GzTgx8PBNjgYWzUZN2LgyQTOboboqbsjs
         5uXw==
X-Gm-Message-State: AOAM5312HL0RpLZ/T54ZcIUy1A1/NgyNGqIqUKvPvLQAEvkoPwkIQYmQ
        8gWeoiUNAaZu7huc74N+oQI=
X-Google-Smtp-Source: ABdhPJz9L+8is2Ip8jLLWfzTNi/us5Q4tilWZCGXKU5MU+FnoFZb+E4/5NFsc5dQ6k9M0TzIAtqBrA==
X-Received: by 2002:a17:90a:d49:: with SMTP id 9mr11086261pju.115.1637244339812;
        Thu, 18 Nov 2021 06:05:39 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:05:39 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE)
Subject: [PATCH v4 06/25] PCI: iproc: Remove redundant error fabrication when device read fails
Date:   Thu, 18 Nov 2021 19:33:16 +0530
Message-Id: <b95defa3db834789a4207df5d6b0216c8b610524.1637243717.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/pcie-iproc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 36b9d2c46cfa..b3e75bc61ff1 100644
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

