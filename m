Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0243E470B67
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 21:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbhLJUIk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 15:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhLJUIj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 15:08:39 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF7DC0617A2;
        Fri, 10 Dec 2021 12:05:02 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id v19so6968818plo.7;
        Fri, 10 Dec 2021 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1v15Gl8TJzLJfCjgx7PA4whHDDqL64AFLHw1EUfuQI4=;
        b=eYd82nxXj99XAzuy/n2QL3B+R/sx3F/CGh+idNIxBYnBn54ihrA7sXJMhCumODMg3Z
         HmDbLuaBcEc/WI5hWOJRfKzTU/avFf/WPbkSyUnO38MIpeTvEDlrIQ8ZbW1nyK2JcFjt
         P84huueaUEFvTFH0kQeryCrP5cycsDPmALR1dCkdJ4ubW2igjoRUiD3l6ERMw+shJP0n
         mX+6eS23ix7KZkQrxdd1t5X/I1zCIq8bhoweGSrqTZsCbPhMJkT3DgDO3jMlVYoRSP1W
         SanV1bkuuOkgz6P/52VMjp8t/5wVXBWuwDqRwnTGCtN/dOOAoeCccJUOFWblLfiyX96J
         5EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1v15Gl8TJzLJfCjgx7PA4whHDDqL64AFLHw1EUfuQI4=;
        b=JsYpEhA8GH+tvnR1bi0pHwLU/XrgRsQXfa+k4YMbHVg5MCCIB0ssIgb+w0X3AQ3Btz
         TgVaNGOuB7IiS6eT40hu63dnn5kVmAw0S/WVYkE1c3iE2y0Wwje8Qc9uGqw2V5SyQe/v
         y7IUq+J1t+QNR5OQXwdg8GasvM/WuarZ7NFeIazKYxgGTRA7cWxNJhRAX86TAoVm/sM4
         pzoPkhRVjDR4vE/1jzQAjvdTMB5bY8n76hBblQKsfZgk8FJGPFlY+5a1Nvnk4Jgfn/Ex
         Ca48LVcgrgxnHKfU1JNi8QfYwXMnwJIslCDU1SGURrMqNHxJMBFQbWsACsVtso7UpMTP
         Iovw==
X-Gm-Message-State: AOAM532drXwT4AiYSN79udthXlNrU4P8toPsFdbkHPJlqgtAgAZMnDSA
        XDqierTbhdr8dDIm7w2YcKaLOCizXDE=
X-Google-Smtp-Source: ABdhPJy2CvSYTDXrKVVt74mgJ83Q8JVCCtw4oYVrg6NcHWl0FTiP1Vb0AKz+Vvz6Hbs+iqRmwKpwMA==
X-Received: by 2002:a17:90b:4f86:: with SMTP id qe6mr26450942pjb.224.1639166701791;
        Fri, 10 Dec 2021 12:05:01 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g13sm3474463pjc.39.2021.12.10.12.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:05:01 -0800 (PST)
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
Subject: [PATCH v4 3/6] ARM: dts: HR2: Fixed iProc PCIe MSI sub-node
Date:   Fri, 10 Dec 2021 12:04:48 -0800
Message-Id: <20211210200451.3849106-4-f.fainelli@gmail.com>
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
 arch/arm/boot/dts/bcm-hr2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index 84cda16f68a2..33e6ba63a1ee 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -318,7 +318,7 @@ pcie0: pcie@18012000 {
 		status = "disabled";
 
 		msi-parent = <&msi0>;
-		msi0: msi-controller {
+		msi0: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
@@ -354,7 +354,7 @@ pcie1: pcie@18013000 {
 		status = "disabled";
 
 		msi-parent = <&msi1>;
-		msi1: msi-controller {
+		msi1: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-- 
2.25.1

