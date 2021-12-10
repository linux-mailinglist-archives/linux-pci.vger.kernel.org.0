Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B301470B71
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 21:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbhLJUIw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 15:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbhLJUIj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 15:08:39 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36828C061A32;
        Fri, 10 Dec 2021 12:05:04 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 200so117819pgg.3;
        Fri, 10 Dec 2021 12:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PtQ+iCOtg8wKI/383IxFyqZ9i0rudNbH4n4NHCffbA=;
        b=P9PK+g5pd0zUN7vBecpw5kRKHQ4ONdv3uxggvZWCKMk1DeNsbq4AhePgOSAn/qBhZL
         eMsd6kZtO81nZyzVD6eew1+4VUkymIvPZdsNNIFqCdxorwyl2LXPXOj6d1KsDQIfVGcu
         SvoaR1DtpNpEJQv/ziyGmY5F37jhzPk4JnUI5oLur0u5/h/D+K1vrJ3rQrwiAj4JnvOM
         i06TYdLNy28DdnO0d2iH4pMZ6iwdHhYXKKte6OUP3iJXkeGdnchinryksaDlT+VTz2BX
         6o04JaH/63H28H8XPHc5YMNN4uaEzTR+KMzcMVWECNvwmkj09btB9va9GbxFQSvCbtcA
         lV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PtQ+iCOtg8wKI/383IxFyqZ9i0rudNbH4n4NHCffbA=;
        b=rxEVYkPsNzOTHn1fF9pZnfs31wMgTkDFWjxNkxtbaj8N6Vxe4v0t5e9iaNp63LUKYa
         IQtTZ5EmdWKAO28JFJqeKIywsHBtfHiCjT0qX9GUyl0XYMMhS1erDGRfSe4S46KZ941A
         AziHxZTrB/k2SUAQSCqWPeG+TvRXLjkbKdEHMXMTz8hlUnBSe84X16JvVhR8TV74wuU2
         5fyw/6LJbTsEXUSeg4ntGiR0fDhQ55VKoeNLV06fUdedR4HItevhY2tqw/Zn1drZEpzw
         TubJQ6iKrw1lAvu3pfQMMTi+koe9YBiq02guIPCGIax+2SMt7NdzQscqJad6JN0eDsDZ
         5lgg==
X-Gm-Message-State: AOAM533hSpYIYoIr8sl0ZCwL7+mwH0f/mfEgDHS8XWg06ckdVuLOXdmK
        qC5X9r7eef64oW6sv6aByfE19Hif3xQ=
X-Google-Smtp-Source: ABdhPJzLai1LzHaLHJ983CX/T7ku5ydPVdpFfHWVtadiam0qshf38kLWDsCvkH8YA+FI6tdnC6TyFg==
X-Received: by 2002:a05:6a00:21c4:b0:4a7:ec46:34b7 with SMTP id t4-20020a056a0021c400b004a7ec4634b7mr19891146pfj.15.1639166703345;
        Fri, 10 Dec 2021 12:05:03 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g13sm3474463pjc.39.2021.12.10.12.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:05:02 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/6] ARM: dts: NSP: Fixed iProc PCIe MSI sub-node
Date:   Fri, 10 Dec 2021 12:04:49 -0800
Message-Id: <20211210200451.3849106-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210200451.3849106-1-f.fainelli@gmail.com>
References: <20211210200451.3849106-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename the msi controller unit name to 'msi' to avoid collisions with
the 'msi-controller' boolean property.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 1c08daa18858..f242763c3bde 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -587,7 +587,7 @@ pcie0: pcie@18012000 {
 		status = "disabled";
 
 		msi-parent = <&msi0>;
-		msi0: msi-controller {
+		msi0: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
@@ -624,7 +624,7 @@ pcie1: pcie@18013000 {
 		status = "disabled";
 
 		msi-parent = <&msi1>;
-		msi1: msi-controller {
+		msi1: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
@@ -661,7 +661,7 @@ pcie2: pcie@18014000 {
 		status = "disabled";
 
 		msi-parent = <&msi2>;
-		msi2: msi-controller {
+		msi2: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-- 
2.25.1

