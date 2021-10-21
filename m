Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE74365A7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhJUPR1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhJUPRR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:17:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103B3C07978C;
        Thu, 21 Oct 2021 08:14:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y1so617768plk.10;
        Thu, 21 Oct 2021 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FjWSerZb+dWA69lxPfira4z913yuChERYmgQMsWZtRA=;
        b=iGh3AHug5XPwueQdVcAQr4MP740tduvSvglgnF1J0evD83ER61uw+1QC2rufw2YuiX
         1xYvMHoj2Jjn5E25nql1ikj9XKxyXY1lQrlpG3JAyaB4Xgwzsz//bWGkcv+xd5w9ltRC
         P/huvBwEUI5w0CCYlkrzwvcnc1Q8PkSzAVknEH05giViW1UQUN35mJaI11FGoYCXNVBl
         LtUKtEfE8ZRKrqtDh0FxqikjObvPO9OP5/N5hKR8DGJT7VPmu9rGO36jvyImqLg1IPpA
         LqdlVVkGq8g8PP3dfJVhMpU2YjqtsHIINKQ1XJ4aGX6vWegKqqhj3HNT6hLalCVn2j/c
         S8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FjWSerZb+dWA69lxPfira4z913yuChERYmgQMsWZtRA=;
        b=0SLkfwLRSc8u/56b5TW44G6LQrXcUO4ugN9hFRlTeZxVeHFM94Xe9KJVkPdLaysslV
         ytQDSm8KYU+wyb/xky1fpW1p7JHWq2Q/tWmrkyQP5QkZhJ2RtXOKer0LAqlTyycrQWf1
         +X3BAhPQPUwMmj5ltOwHuNhjMzOMZJyoFFH3bR6Uduq8c3RyCRz4ZaAvgqTEcHqVUdTo
         0d1hRH5vDvTOVkr/xAaJmSk1vl6nHnErLF4lpfm/8ty8hta6lOGppe1RCKpHwORn1dt4
         1bAwIG/4FbAX6/vgfipthL/cEuaNj2KBvVSX2vsSOxuvxLhianMB5KkULEHe3waR5JB2
         kMaQ==
X-Gm-Message-State: AOAM532zBAHACifyq0XFfABXYycKij/yO6ivestQK9/8/7obXgO3gH5y
        TCl89v8Tp2jK5sYj85T+MjI=
X-Google-Smtp-Source: ABdhPJzXSIGg25L/CN5xu8J0iwX/Cnu6VHjnxns/agf5UjmuVd4y83yG4NP8dNx4oCnosyvdmddVEA==
X-Received: by 2002:a17:902:9a97:b0:13e:2da4:8132 with SMTP id w23-20020a1709029a9700b0013e2da48132mr5758192plp.34.1634829254500;
        Thu, 21 Oct 2021 08:14:14 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:14:14 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v3 20/25] PCI/PME: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Thu, 21 Oct 2021 20:37:45 +0530
Message-Id: <236b7af1f36698b34c01857d0a2a18c4ab850c5f.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/pme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 1d0dd77fed3a..bad7ba420c18 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -224,7 +224,7 @@ static void pcie_pme_work_fn(struct work_struct *work)
 			break;
 
 		pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
-		if (rtsta == (u32) ~0)
+		if (RESPONSE_IS_PCI_ERROR(rtsta))
 			break;
 
 		if (rtsta & PCI_EXP_RTSTA_PME) {
@@ -274,7 +274,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
 	spin_lock_irqsave(&data->lock, flags);
 	pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
 
-	if (rtsta == (u32) ~0 || !(rtsta & PCI_EXP_RTSTA_PME)) {
+	if (RESPONSE_IS_PCI_ERROR(rtsta) || !(rtsta & PCI_EXP_RTSTA_PME)) {
 		spin_unlock_irqrestore(&data->lock, flags);
 		return IRQ_NONE;
 	}
-- 
2.25.1

