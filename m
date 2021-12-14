Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9FE473BC7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 04:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhLND6c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 22:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhLND6a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 22:58:30 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4409C0613F8;
        Mon, 13 Dec 2021 19:58:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y7so12702981plp.0;
        Mon, 13 Dec 2021 19:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1v15Gl8TJzLJfCjgx7PA4whHDDqL64AFLHw1EUfuQI4=;
        b=LB04x1mOY0EfpsXQFHT0385OPgqMxqnezuCSRKRQIYyV6pHq07SFep9Rt02ThAbs2I
         DxTXNnwE4be66eoZQNGf7cra+MMNFl8RRYSPC4RfH4zQfjUdy8h++hK4GdetaNgWK2c+
         fP9bQl2Sb7Lcy8MABVfDISe7k7SK+XvQwdp0Edb+vFX5vr/5YoYMxY9w7maK2JXr/8jM
         DUrtVTWQywQBYdGZjgJ3SmAGHoCXzUQXIjaJMvi5QvtEcILy7kEfYHPCXSx+BC0GRdI9
         CJWMR6AyVZ6fr4eNQn3XwdrnbHe3sDntjgXNCvhpNwOuoF4YIZsjUoedxspVQbKtCzdH
         qAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1v15Gl8TJzLJfCjgx7PA4whHDDqL64AFLHw1EUfuQI4=;
        b=a1LHWgc0WDaco6VEIsZv0e02c3jdwZpW4bcR9sSpah6gmwQQNFkhuufLhdzGIneSle
         5SZMd+u9zPlk1c4jK8EepB6+45WWPbW6vYw1MErMBCEZGg/PnK5FHizbJKT6TSVRkQ/5
         Gdbjl8qD7w8jmKKPEl+ymlq04nNIW6Zu9UzD8USTaVHAAuNnhfo1PbtLXzcBI3o046Zd
         SGiViAWvzrxf0DA1zEvynedaPfH0SIZcCtDPwgUvM+olXJflUgK+H25zMQbv6RX8PaSg
         erPCI6T0W3Xh788+V6FCjUSp85eZI+qPCRb+/CFF9AfM/GQiImmkx2VwJYQQ0DwuayCS
         Jbuw==
X-Gm-Message-State: AOAM530LdBxwg915zKICxaaAi1QlFUo4mU7OA4NOdjwrcNO2ESZXxsFH
        O7Uwrz/j+u+y+d2YdaYBSFyPymuKAPw=
X-Google-Smtp-Source: ABdhPJzVRDHpnHWBHT00swMJfpAiOoxy6pc2oZirFVhtc9kKMEzF7ReJK7ShOmRr8oRz3H+yHDc36g==
X-Received: by 2002:a17:903:408c:b0:142:45a9:672c with SMTP id z12-20020a170903408c00b0014245a9672cmr3379296plc.7.1639454308767;
        Mon, 13 Dec 2021 19:58:28 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o17sm11430356pgb.42.2021.12.13.19.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 19:58:28 -0800 (PST)
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
Subject: [PATCH v6 3/6] ARM: dts: HR2: Fixed iProc PCIe MSI sub-node
Date:   Mon, 13 Dec 2021 19:58:17 -0800
Message-Id: <20211214035820.2984289-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214035820.2984289-1-f.fainelli@gmail.com>
References: <20211214035820.2984289-1-f.fainelli@gmail.com>
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

