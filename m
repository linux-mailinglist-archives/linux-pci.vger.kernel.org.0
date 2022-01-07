Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4878E4871CD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 05:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiAGEgR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 23:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiAGEgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 23:36:16 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899FAC061201
        for <linux-pci@vger.kernel.org>; Thu,  6 Jan 2022 20:36:16 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u16so3993107plg.9
        for <linux-pci@vger.kernel.org>; Thu, 06 Jan 2022 20:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fungible.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+b7MRmIj2h+lxy852w49nsLYegYd0GVjsA4LYtvXcE=;
        b=b4NPxRdiCwy3a9d/lZQGDBAe8a+Km2NijpsQOU6UdWAStOZgf53s/bKUQ6a50tlx5Y
         dyN88w1YOVEDHbeZEk2XTVpS58LqSPl269KATYI/xo66Vd/bdy757hxHj7WDTJ1IWVrt
         u78/TAK2g9mNAGGc3Em7AG+yNRpIB7AxGVIQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+b7MRmIj2h+lxy852w49nsLYegYd0GVjsA4LYtvXcE=;
        b=HbQgCRudfwf0L6BM58qDnSu1nUWi3ae4uTmpkE+alHauuKocc5CCpACC59zLNJ7Irb
         fYZ5otJX4VL2qZuk/xZkCXLC3YIpRL+azYZzHtXkrLFPQ0Qadk36vA97fJyyS5avpP8s
         +QffdRkwbw9QeSr8xB1cslLr50gWnSc/JIA+noLxRWU0/+G+K6UuMLbXFqBz4mse1dHL
         TXuLcYqjT/fEjMhQ5du+cOQz1TsBYP/5MdNOlB5SgrU4cEloEXO17A7v+iQN/sdtjAne
         7BDC1BiQOMMp1wkWQ8YRph5pjYBGgdpkCGcH5CqYUIgU+LkBtwVjvN5UdccoXx05n2nL
         4vlQ==
X-Gm-Message-State: AOAM532mCTr7ZSxF41KTXzDm+EkZWPdjpxyj2ZWw80/fAMKoezcvgvRl
        n/R29B46QEjVGmXVkF+sNvkneQ==
X-Google-Smtp-Source: ABdhPJxq/46+nHIs8A1H3QEid2vNflCfJd6JzTrAOE/e/7gxCMRyu8UUbz1ZV4qLwJlqdcWLJlXB6A==
X-Received: by 2002:a17:90b:1d02:: with SMTP id on2mr13887561pjb.204.1641530176048;
        Thu, 06 Jan 2022 20:36:16 -0800 (PST)
Received: from cab09-qa-09.fungible.local ([12.190.10.11])
        by smtp.gmail.com with ESMTPSA id p12sm4297877pfo.95.2022.01.06.20.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 20:36:15 -0800 (PST)
From:   Dimitris Michailidis <d.michailidis@fungible.com>
X-Google-Original-From: Dimitris Michailidis <dmichail@fungible.com>
To:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, d.michailidis@fungible.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH net-next v5 1/8] PCI: add Fungible vendor ID to pci_ids.h
Date:   Thu,  6 Jan 2022 20:36:05 -0800
Message-Id: <20220107043612.21342-2-dmichail@fungible.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107043612.21342-1-dmichail@fungible.com>
References: <20220107043612.21342-1-dmichail@fungible.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Dimitris Michailidis <dmichail@fungible.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 011f2f1ea5bb..c4299dbade98 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2578,6 +2578,8 @@
 
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
+#define PCI_VENDOR_ID_FUNGIBLE		0x1dad
+
 #define PCI_VENDOR_ID_HXT		0x1dbf
 
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
-- 
2.25.1

