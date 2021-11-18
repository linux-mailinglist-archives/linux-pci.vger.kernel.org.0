Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41D4455D91
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhKROM2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhKROM1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:12:27 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DB8C061766;
        Thu, 18 Nov 2021 06:09:27 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r132so5412093pgr.9;
        Thu, 18 Nov 2021 06:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tG2Z+jbkFRvw9IYmwc/ViuisLBeS5zDki/9SkrDHf8E=;
        b=ct9yZCQ5VcjePNT24JBl3ImNLFFun3txYvUKafBcydv3zyDa84ktDQQ2ia5k5KpeTh
         ZCiBhggoB3y63rJJWsK7gP5v3mWIppoyd5nlThMhVLLb5G1yepYQzzADNR1syEQmbRF1
         aVQOrkLI6jAFp0gOkI7OSKbiETUZQKqjsa2zSV+rs1FZPT4NX/FRyP8l1/vFf5yQOlAs
         miQDTNz718Gy4ghr1f5tRjgNbOfzvbqPP8We2aXm8L9IEQ94OdoHFktgneA9JR4AjMNe
         j1oP9Oj7+1ZpkRLNqDviue/No0zniTPSayURrAOCqFlioIeUkbb6kw63FgODNF5u71w1
         K1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tG2Z+jbkFRvw9IYmwc/ViuisLBeS5zDki/9SkrDHf8E=;
        b=dd8s+z3hTLOVpyv2zs875d0pInsUg/kTZBryV+cV+VrbifjHLE6/8Fz/aknn8fbcDa
         5pY/B0qGNhrADxNF2eZI/wXqX/cCEUBWDv5+H09UmRtz2RvP+kAF4OFAOpBLzj02PAxG
         oPHpf44oZrzHDA5/yJV+VokdGRh2Jl+HLhN6hA/RWEIDYFY8KpoD9vbKjqiuzc8Ship6
         LS6u+P2R9pzVBgM5j+xx14iirrvFmZCbRq1rPDVr5aWhSHFYgeFlXggWQFzD7jmctsij
         nn7eVbSJtAiLYwnVohQGeXdKA9c9uEGmGoSMtCj9D0rRn2GvWpc/Vr+E87byI42Q918M
         NR/g==
X-Gm-Message-State: AOAM533bS2UavA1lfrM/kFoguxPfwTPfEarJC700+FFkceYRV/yafMKY
        CDvBrlEAoX2zL1TlHm8yhPMslOy6z1v4QQ8x
X-Google-Smtp-Source: ABdhPJw11oe0nh0XBOBBqnfa0shN0dahRuIrHjoMwAfFlkTwGFIRQ/teuzpWXSmFw87mZvdJ6FFqhw==
X-Received: by 2002:a63:7d01:: with SMTP id y1mr11455196pgc.343.1637244566532;
        Thu, 18 Nov 2021 06:09:26 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:09:26 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH v4 22/25] PCI: Use PCI_ERROR_RESPONSE to specify hardware error
Date:   Thu, 18 Nov 2021 19:33:32 +0530
Message-Id: <866e2db544df45af70df7e64659bf02e03998ae3.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include PCI_ERROR_RESPONSE along with 0xFFFF and 0xFFFFFFFF in the
comment to specify a hardware error. This makes MMIO read errors
easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index a92637627845..a07b76761d74 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -413,8 +413,8 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
 		/*
 		 * Reset *val to 0 if pci_read_config_word() fails, it may
-		 * have been written as 0xFFFF if hardware error happens
-		 * during pci_read_config_word().
+		 * have been written as 0xFFFF (PCI_ERROR_RESPONSE) if hardware error
+		 * happens during pci_read_config_word().
 		 */
 		if (ret)
 			*val = 0;
@@ -448,8 +448,8 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
 		/*
 		 * Reset *val to 0 if pci_read_config_dword() fails, it may
-		 * have been written as 0xFFFFFFFF if hardware error happens
-		 * during pci_read_config_dword().
+		 * have been written as 0xFFFFFFFF (PCI_ERROR_RESPONSE) if hardware
+		 * error happens during pci_read_config_dword().
 		 */
 		if (ret)
 			*val = 0;
-- 
2.25.1

