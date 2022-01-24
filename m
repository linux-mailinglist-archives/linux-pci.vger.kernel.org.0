Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F022497DF5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 12:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiAXLaM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 06:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbiAXLaK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 06:30:10 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00128C06173D;
        Mon, 24 Jan 2022 03:30:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso19454024wmh.4;
        Mon, 24 Jan 2022 03:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFXh+U6gV0rVqtSI/fZKKaMEH8mcFoZZQHL/CbCcpBo=;
        b=KNdG6zMcSoQbEg7btkjR6HFyycn3hKVkO4BEMKu/Hj9UYIrPTNmzUfwjRi4yUSZPZE
         OB21fvLtDoS3r3oKoQ+rD9hwpsCyBqeNejsuYXidz7XHQetWohUhhJcWNy6ds28eBAc9
         4bf39waGmNwKy6eBgivy0qbDf9TwULE4RIlFxf4dx2YoN2NVOV4GmN95e6rfD6b07xvm
         Y30Qnxo750wUzIh7n3TI4HM29stcFoJ8HxhvmEjKp68Aat+JAxKqhhnZ4LbTv9U304YD
         5wUqiyhtkj/vkrfhwyYe/JkulV7QGQKcXO36KY7gWCM81FzRb7ng98eMV/LML64z9Ux+
         fpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFXh+U6gV0rVqtSI/fZKKaMEH8mcFoZZQHL/CbCcpBo=;
        b=18clPgBdjAukG3wx+geJF/uCN5nW1rbKe1IJHLcaWrx/i7s+h7zIzOmTd8Coe8TED7
         ko01b7hbseAdwlL94f9HHMDxjO2JMLW3itXz/zZQk1cSRS0PreUXslerRg1GbPQ7S00e
         8Bsl/tlZm7kcR7yFb+SVSlWYL6vF3cauJ8TUPNif/+rmc7FKzMMtWpLvMLUjg0sxj9Hy
         4H/2Xz7e/BHDO/Td5wOHfoV9WF6YGQH/b8bWdGGGRF1fwT1B6RcdHr9l9UpA9NCn6RRb
         kfqXRI1EGSyEm6aHA85ltux3XSd16Y0rcU+L7VeUYj33oRJ928TDIHHsy4/pXyNQVpck
         qeZQ==
X-Gm-Message-State: AOAM533a9Vwtv7HyNtG7Sygz33tRY/3WIljYdV73pQbmjGyZ+Ekxewny
        XxxytoIBQNAT7c2zs/MnIJgbgqA1qF7irw==
X-Google-Smtp-Source: ABdhPJz4Ghnx0dAKrBXjPFAxC1JWCHgIsTFyxuiiHD4dALOuhlNNZWjRlN3BKMYdMSVrXR8b2Mis0g==
X-Received: by 2002:a1c:c917:: with SMTP id f23mr1463435wmb.10.1643023808401;
        Mon, 24 Jan 2022 03:30:08 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id y15sm3328927wrd.51.2022.01.24.03.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 03:30:07 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] PCI: mt7621: remove unused function pcie_rmw()
Date:   Mon, 24 Jan 2022 12:30:03 +0100
Message-Id: <20220124113003.406224-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124113003.406224-1-sergio.paracuellos@gmail.com>
References: <20220124113003.406224-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Function pcie_rmw() is not being used at all and be deleted. Hence get rid
of it. This fix the following complain warning:

drivers/pci/controller/pcie-mt7621.c:112:20: warning: unused function 'pcie_rmw' [-Wunused-function]

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index f2e567282d3e..33eb37a2225c 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -109,15 +109,6 @@ static inline void pcie_write(struct mt7621_pcie *pcie, u32 val, u32 reg)
 	writel_relaxed(val, pcie->base + reg);
 }
 
-static inline void pcie_rmw(struct mt7621_pcie *pcie, u32 reg, u32 clr, u32 set)
-{
-	u32 val = readl_relaxed(pcie->base + reg);
-
-	val &= ~clr;
-	val |= set;
-	writel_relaxed(val, pcie->base + reg);
-}
-
 static inline u32 pcie_port_read(struct mt7621_pcie_port *port, u32 reg)
 {
 	return readl_relaxed(port->base + reg);
-- 
2.25.1

