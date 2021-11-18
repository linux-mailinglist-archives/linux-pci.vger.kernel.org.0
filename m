Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69970455D8D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhKROMQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhKROMP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:12:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D949CC061764;
        Thu, 18 Nov 2021 06:09:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gt5so5230971pjb.1;
        Thu, 18 Nov 2021 06:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEAi0JFFmcVSfLYqvSz9Q36wWsFfdlN527IzY0Xl91w=;
        b=BNYCIDqXF+9y4b/vF54ZSXcAvHm4L/wOgKJ/UAkZhYW0nozO7Zv8Bks/tDz5yrZ4OD
         DnPhR2IdEnwjppvTVmQkRGPuCiIl0QVMJNewSDmcbRdga9pHVy8S13vilB1txU8u87tb
         H7SJ4o1SKk44fDZwqtM5tZc7vZlRH9O4XBhjatHklAJQffJRieEN7xrzQn+flJq9o6LI
         Himzw2igxlwHQSzjflP/bLgEKcJqNWOHrS2bDE4ZsUfmNPJi7RxiPm92CcH0S0Khe/Cv
         qZSmJMQdLKSW80RcvtU+J0e4r4E/76uplT2xL+3pucAxz50waGVHUBU9cnZyCl7pIhyM
         ibZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEAi0JFFmcVSfLYqvSz9Q36wWsFfdlN527IzY0Xl91w=;
        b=u6AKamwP3PDPuLf61lj4oSCwMPWdpdT7Z/QogXQvnyyYUtRib5FyVzKrgKP+howcqd
         HsPoFlx5QWIq1EAYieMdKRGPHuX6qa3NtmZf86unW8IzI8Rt3nRGotoIJBUoyNpe1LWl
         qQpi0TFQQQoI5jM4m3wE7tsprGtsVZV+wfkZz3axCDR8fEDlDqtBYrX73QsBFh3Qlbqy
         JQmF90m78w6/wQaOhpRtuLZcoNXpW1qFONooA7spEHdOG1OB1sevXrOtUj53h886am6/
         fyk284PuFrnkdzsG6++653Wp9eJXLVCD/jOZw93VITGqI3IgPRvnADhKYGhujUkWQXLp
         FFBQ==
X-Gm-Message-State: AOAM5328Ang7mhU0unmwKtyIu5MoiZ0jh75Z8uhlienZoRJo5RvBNV9b
        8H/vs6QLJhzq8bYGXU516Pk=
X-Google-Smtp-Source: ABdhPJx0eGowQg8TSYbw2PJfbQZPFwpWcMyafhZX/7yhfmbbQRXIJXEOBIrKypVY6wqJ7VQxAwOcEw==
X-Received: by 2002:a17:90b:4f44:: with SMTP id pj4mr11118669pjb.150.1637244555360;
        Thu, 18 Nov 2021 06:09:15 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:09:15 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Sean V Kelley <sean.v.kelley@intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v4 20/25] PCI/PME: Use PCI_POSSIBLE_ERROR() to check read from hardware
Date:   Thu, 18 Nov 2021 19:33:30 +0530
Message-Id: <679ce049bccf10df3ca9ef4918ee2c3235afdaea.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use PCI_POSSIBLE_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/pme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 1d0dd77fed3a..ef8ce436ead9 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -224,7 +224,7 @@ static void pcie_pme_work_fn(struct work_struct *work)
 			break;
 
 		pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
-		if (rtsta == (u32) ~0)
+		if (PCI_POSSIBLE_ERROR(rtsta))
 			break;
 
 		if (rtsta & PCI_EXP_RTSTA_PME) {
@@ -274,7 +274,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
 	spin_lock_irqsave(&data->lock, flags);
 	pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
 
-	if (rtsta == (u32) ~0 || !(rtsta & PCI_EXP_RTSTA_PME)) {
+	if (PCI_POSSIBLE_ERROR(rtsta) || !(rtsta & PCI_EXP_RTSTA_PME)) {
 		spin_unlock_irqrestore(&data->lock, flags);
 		return IRQ_NONE;
 	}
-- 
2.25.1

