Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43910455D76
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhKROKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhKROKs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:10:48 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D814C061766;
        Thu, 18 Nov 2021 06:07:48 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x5so6175320pfr.0;
        Thu, 18 Nov 2021 06:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxis35XdZSIgJr6mklaAXMEQHUEVDMfz+GZuoz2m4I8=;
        b=CfdlCofkOkudUS2qd1NsvEsYuT7jk4wE1tunfAm4T9FgxQkNInv2u6Ao0B3dgzI+cp
         MBMg06DQ2ISnqX1E8DL4tFvodGh3V26fGl4gI90ndgXwt0ILK6dyREzbrk/ntTcRfLsO
         NQ1vJyHsPH6wdr2gr2WuWe0A4rPL7km89KeGF+8FimeuZLbRPpfQcn4+a9QU41Rmj/A4
         xlqTGNv7PzYykiz1mzFRyJ9jBQm55fQwg/ZITxxqAhJ7/PoZSHQlVA8GGeCaejFzyMGZ
         zraEelTYLMHHqHjeKMhYs8nVXwQaV4/5e09WsMghtAsMGemsv/R/ne8JoFLJB4WZCfrz
         lx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxis35XdZSIgJr6mklaAXMEQHUEVDMfz+GZuoz2m4I8=;
        b=xPF9xSy4udoyyvo38hGOn7wNTBgm/A1K1IkknocjJ8E9/euK6HQXWFEK1w1sNlHT4U
         UkPthpEjsOyeJt1jYUgcyCJUAWfkumsRrtGXATNEUufZX7KhV5sMPUx/MuePIyQ2FmvF
         6SxD47D+0U2/watpqtUnhnlcbetyh4gef7DggpPjjMgAGwXXLLZn0GtWsLP1uryKunm3
         ye+WmuaD3KBS9XdCWfDVq5IIZVZi6XhILvDgNJ0P0uqR6QiEkmbpMKEZ8ngu4zzH1KEl
         iGwHvRJriZpYHpon/agINfSeKf0SdmotgGCoWoNlH5VvAHnhvn+YSujFvkzZGyM0mFA0
         V9ZA==
X-Gm-Message-State: AOAM530etGU0dBA3mAVYHWPAeLJc5DRV96jQbw8AKcY7cCwiU8ai4kIQ
        vg8VYT/xgQCEjNx28XI5l1qiVLxGRdRE9uiV
X-Google-Smtp-Source: ABdhPJyKNAsM7vj4XKSIROaJKxPYIQuQZ53f9v5gQ+OOMhKVWBQJbsKOev6gGAPfsMdgsSBm2WrYFw==
X-Received: by 2002:a05:6a00:248b:b0:49f:9d7f:84e2 with SMTP id c11-20020a056a00248b00b0049f9d7f84e2mr56766723pfv.40.1637244467554;
        Thu, 18 Nov 2021 06:07:47 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:07:47 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Joyce Ooi <joyce.ooi@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v4 13/25] PCI: altera: Remove redundant error fabrication when device read fails
Date:   Thu, 18 Nov 2021 19:33:23 +0530
Message-Id: <ed5020e5b008b28c33a90c9c1670cef2393d3b7e.1637243717.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/pcie-altera.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 2513e9363236..a6bdf9aff833 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -510,10 +510,8 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn))) {
-		*value = 0xffffffff;
+	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	return _altera_pcie_cfg_read(pcie, bus->number, devfn, where, size,
 				     value);
-- 
2.25.1

