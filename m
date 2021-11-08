Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D46449C64
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 20:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbhKHT1g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 14:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbhKHT1d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 14:27:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEB4C061570;
        Mon,  8 Nov 2021 11:24:49 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so683639pjb.4;
        Mon, 08 Nov 2021 11:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjOZTPQcvz2Ej/nInPoBz2bFdjF7rfN41XOQujZZQow=;
        b=WrcP6KsVG7dWdD8AbJgaaMq7W7XxkJordouYWRSGf/N/xqSQmTLrDkW5EGL5PrmTd9
         U+srJG0LSfUdyJC4FXzyGulhGCIFi/ZBdXR3qciqMM9FRQ14lv19yM5jHmi/608IZHRi
         +NXZrwTeuAJ9lYCpRzxtioM981fqGcse3SdTHySeZMeuKBqpbXLI/xduG1cSDry0L3oD
         6Hn91shlEZAvg7UKegLeMXZNCuJ2FvnOxiuHJGzlVL/te9bxRyx9bSWl8RHdALEmzqaV
         Rh/qS2BwiXTipChUafUWO+hasas58NhRjpevwc9B3zgm4lK4gW/Qm+mxnBvGIEWP9K8H
         HqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjOZTPQcvz2Ej/nInPoBz2bFdjF7rfN41XOQujZZQow=;
        b=US4RUTmLThbturBEj6uQ3Mdthy0BZqbRawvQXaW4M0mOI7e+V1u7/28Pg5ldLFQDev
         i5G9dxFUyVivkGjlZcIwZvbZIxX2BJEE70f/lPC/ZodHJFApvCoSTn3tR4RqxGp6gRVe
         ucVyPYDUMIiiPCysoffWyfL5w/RAU5GolZpAWl2CmNGuiOrIAdouzhKjTg0FXFuGCxzD
         5p/Qm5HMAtyNrAqOpMFsK2QhrvLvpH3/4YVLGwxwUSfu6OGA3tP10MgYq21cJFyattS0
         zP81i9dFYf2fiJqfNFQDXDG3ldfjIVPIr9Pxup1FDfx1Vsdxs2L0fYZ/ROCh402+hN5G
         GePQ==
X-Gm-Message-State: AOAM530PmI1qXo4/R4S66ZL8Emwmcdfgz9HvlnZ/RPhFmpFvb1/vYNNV
        ZyJJcW00tJ5YBsGWGhk/5gS9NqXgKio=
X-Google-Smtp-Source: ABdhPJxGdPTj9Zr1FUCcTAgsUXoWb+YSFFAhwky7pkUZhWZEer5lpKzPnigO9zFKkM2MdC7vDdeppA==
X-Received: by 2002:a17:902:b7c8:b0:141:9ddb:33e7 with SMTP id v8-20020a170902b7c800b001419ddb33e7mr1391113plz.60.1636399488246;
        Mon, 08 Nov 2021 11:24:48 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m3sm17573242pfk.190.2021.11.08.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:24:47 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mips@vger.kernel.org (open list:MIPS),
        linux-kernel@vger.kernel.org (open list),
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH 2/2] PCI: brcmstb: Allow building for BMIPS_GENERIC
Date:   Mon,  8 Nov 2021 11:24:32 -0800
Message-Id: <20211108192432.1589507-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211108192432.1589507-1-f.fainelli@gmail.com>
References: <20211108192432.1589507-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BMIPS_GENERIC denotes support for the MIPS-based Broadcom STB platforms
which this driver can support.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index e917bb3652bb..93b141110537 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -270,7 +270,8 @@ config VMD
 
 config PCIE_BRCMSTB
 	tristate "Broadcom Brcmstb PCIe host controller"
-	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM4908 || COMPILE_TEST
+	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM4908 || \
+		   BMIPS_GENERIC || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	default ARCH_BRCMSTB
-- 
2.25.1

