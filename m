Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33ACF3BB475
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 01:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhGEAAN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jul 2021 20:00:13 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:36666 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGEAAM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jul 2021 20:00:12 -0400
Received: by mail-ed1-f45.google.com with SMTP id h2so21481632edt.3
        for <linux-pci@vger.kernel.org>; Sun, 04 Jul 2021 16:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zsJ12EGxba1PvEuauYMRSCCrS1obdvbtRZvPvKXCc6c=;
        b=f3HCixkkdisf8ALVAUiBdlJrENjcSJsZa7i64SXC9lRvh1kuVz1sQ2sOdrGWlWUZ7T
         FTIOcrtsTJKOXnG6mSCd8JuHEos91ynGR9eFkC1ViTJNufvLmoi2Fk5l1HNvhX5YrMNc
         yJU2GrcaCYiRyiQ3ipB49lqMlkl6nYgsiCPslk3u3I+FlLXA/StiSt5YouO5I26oZraN
         wTUWmci1rQ0YKaHppZZpcJbEXoWx7RFoNbLxKrF2sVuluJcQlt3fiFIvfdzL0E9cw6gM
         2/5JP9/0Koro0d70smUbmIePUUxHbzD5SFxK903YTFhYWL3yIzahbfb4nUUajPrQMb4C
         RZVA==
X-Gm-Message-State: AOAM530cfPjQrHrJpcxdaxYboHMamGlZr4Hs2O1jS9pkYImzUnH7rp7k
        u/rmzHFhysvxF2+t3kUX0O8=
X-Google-Smtp-Source: ABdhPJxzGD8TTAXccfB3p7HDiKGnjkO8AYpcxHUUgA+vEbCJ7Sf6kLBHt3UgtpKTX12RDaOsE2o1Xg==
X-Received: by 2002:a05:6402:220e:: with SMTP id cq14mr12114655edb.140.1625443055174;
        Sun, 04 Jul 2021 16:57:35 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id cf22sm1115453ejb.33.2021.07.04.16.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 16:57:34 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: tegra: Remove unused struct tegra_pcie_bus
Date:   Sun,  4 Jul 2021 23:57:33 +0000
Message-Id: <20210704235733.2514131-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Following the code refactoring completed in the commit 1fd92928bab5
("PCI: tegra: Refactor configuration space mapping code") there are no
more known users of struct tegra_pcie_bus.

Thus, remove declaration of struct tegra_pcie_bus as it's no longer
needed and does not have any existing users left.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pci-tegra.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 8069bd9232d4..64adb3fc22d6 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -372,11 +372,6 @@ struct tegra_pcie_port {
 	struct gpio_desc *reset_gpio;
 };
 
-struct tegra_pcie_bus {
-	struct list_head list;
-	unsigned int nr;
-};
-
 static inline void afi_writel(struct tegra_pcie *pcie, u32 value,
 			      unsigned long offset)
 {
-- 
2.32.0

