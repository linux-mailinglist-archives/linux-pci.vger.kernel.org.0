Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9904365AD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhJUPRv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhJUPRj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:17:39 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED38C06122F;
        Thu, 21 Oct 2021 08:15:09 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q5so596633pgr.7;
        Thu, 21 Oct 2021 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnLnMx9TiMvb2DdIMVT7WpH5F3wdHvIfMbTto6KwZSg=;
        b=Pz90wycD5upk/N58ukfuJBvjKYqKsAyX4N450DRmxX4zYZVm0RPibszRSrLn5sdpI9
         FKZ+aPYSXF/Or6ZgkVzut9V3jpVIXKsuc/v3DQFo55OOxou9RnWIX3+FDU31DvOeZgKY
         +/2F5azh1KpxVUTG5N9u9SpciwITX0Jsknvx/RPRbr74yQvxjl2WfIJ9fBN0HE4nSee7
         P5CXaEc+60zwqa1WGjVapTn3Si4vLCdcvmI/EfEGrUXwTl7bQuj2hQpMOKlV9O1TWpIN
         Ge3lkIG02jxKfxrY3FzNMJYMUb0SA+miwzfSn1dbx2nfplo046yERVVHhtXn/9PDdXje
         yiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnLnMx9TiMvb2DdIMVT7WpH5F3wdHvIfMbTto6KwZSg=;
        b=cd6zCYo9MDrqpjhuRY1liUs+k1YlBEKK+9DHIV6ruGfuy1ihKfEJjmPSBBGRNIGYaX
         FVhKUrdSZnoGzc7rwfxP+RmZOTZV7o3EEN1glAJE/WoGl4KmV5XVABs/nDQyyXvAdTFR
         9cyNT9dxFwoJkDC0ZiRGdhlPfIWIoClG5BnPT6CCv6Y8w6o9Vkfu1VdGu4kbLisVUxvn
         UZ0q/DmdfOzRYCfG7hPTLK4K1gFba/sAu9ZyxvPXjMu8f0wdW7n18EdmLdk1dEBgzaUH
         QmzPeQPFsNxbczct8j3MLbh2UHLuY6G9Qi0Z/gqKxZ7YiclAT+ahKLg9LelHYh7BAxYJ
         PDmg==
X-Gm-Message-State: AOAM531mi5JG/fsJTXHKBrox+7zi9i2lOLb6tKkVOBLtbNZ23fXqIa8R
        1ix9/JgB3i1D2mrvClhSofoqiszB4a1Mw9ZK
X-Google-Smtp-Source: ABdhPJxhnoG9TmriCOt6ZGRxqyZUvT6HOxT0Utz32C1JLwzEnJCfreF0x30Y/PMIEkJMKLIaaf9lXA==
X-Received: by 2002:a05:6a00:852:b0:46c:d325:e95b with SMTP id q18-20020a056a00085200b0046cd325e95bmr4500656pfk.78.1634829308613;
        Thu, 21 Oct 2021 08:15:08 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:15:08 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 23/25] PCI: keystone: Use PCI_ERROR_RESPONSE to specify hardware error
Date:   Thu, 21 Oct 2021 20:37:48 +0530
Message-Id: <e4a15164ab72c57a8d1b8bf6afd5a357fe70981f.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include PCI_ERROR_RESPONSE along with 0xffffffff in the comment to
specify a hardware error. This makes MMIO read errors easier to find.

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

