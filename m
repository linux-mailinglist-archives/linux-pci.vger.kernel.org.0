Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B69455D98
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhKROMl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbhKROMk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:12:40 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01BAC061570;
        Thu, 18 Nov 2021 06:09:40 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id v19so5335386plo.7;
        Thu, 18 Nov 2021 06:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnLnMx9TiMvb2DdIMVT7WpH5F3wdHvIfMbTto6KwZSg=;
        b=ZlyJBwCs9fX3OI3DBnfqs1+YetJVATb6F0OrBd/S15BMkfSIVB/4Ev46eCRb8qAhFp
         LmSRZI/TQJhrxZ1gmjQjaxQpQbN+6izQvAxoAWq7Oq+7n3Rm6jz5+4m64bzC03P+7KmA
         wZRCUkmwTrDqmqw+AQW4/hBiAIUgNKJWk588rt95Xb1J1d/K7PqaFok+TMLfDHMiN5Zx
         R2hueyMZ8J4ycNg+p60PrfZcVPwI5vxvsYmwS9qyLcMrnZgJk6rqo/Z4Va0DLJ3s71Rb
         ol62Uoee1JVICrGAheOqOPnfTDWPjGrlTz/b4+rR0Yt435keV/RScmYW5oGVPZUCgKV+
         lzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnLnMx9TiMvb2DdIMVT7WpH5F3wdHvIfMbTto6KwZSg=;
        b=GvJk8SCfloh34Z1UEeLSOLTj/UvbQt+DGVL2z48y3iV8Of4Aryn9LV3udzmV0xTQri
         Zw/cgA0szEl1zVbjWGcfDxxmFJTuLBigpAObTC0qwnOJ66TyXdRQSsuRwd1pMoVNR2xy
         +K/dvJb2KbIlur30BrZ6oZsWLSpyPCjYqP2u2SpJbBrSe3JC5T+TKXN6d4B1b6LAUYxn
         YtbmwjetbjYLSxrMF3I8lBgSVfBC1xAe52UzgslLIHkTmcZnEvr7Qdhxek5O2pFSYQaH
         7HnMGnzzE0fblY2OfbFNWVCwFX5kTLR1DkzUdJWd6Ddf+995BIZz3wdp2ctsqTMRYY6/
         P7HQ==
X-Gm-Message-State: AOAM5339gnTBlJErjvzWtduTjaETwyrrOqf+acgcJX365vGWRzeQPrCZ
        x5KaPS59QrnrjDPBkCVm6cs=
X-Google-Smtp-Source: ABdhPJx6bAYCBNMopBObWn1R/36X8oy51voH2S7zgf1akIZRIAsvFVTFdhusBzEyksz1DU35UcQp2Q==
X-Received: by 2002:a17:902:b189:b0:143:8079:3d3b with SMTP id s9-20020a170902b18900b0014380793d3bmr66696974plr.71.1637244580292;
        Thu, 18 Nov 2021 06:09:40 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:09:40 -0800 (PST)
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
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 23/25] PCI: keystone: Use PCI_ERROR_RESPONSE to specify hardware error
Date:   Thu, 18 Nov 2021 19:33:33 +0530
Message-Id: <6ae6b071d92052dc511407513e2a7c0035aff9e7.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
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

