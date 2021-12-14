Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE7F473BC9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 04:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhLND6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 22:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhLND6b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 22:58:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9DAC061748;
        Mon, 13 Dec 2021 19:58:31 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id l18so11594119pgj.9;
        Mon, 13 Dec 2021 19:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PtQ+iCOtg8wKI/383IxFyqZ9i0rudNbH4n4NHCffbA=;
        b=DZhJTuI7YzW03odBx/bNqEurSo33emVPAj/azvE7XrsemmvRymdUBsKJBff4HbXKL2
         cnSjxAD0V8TCBQegRSQlL+p0cgFJMvRJ1wJbXAfZi1y34kZYEk6AwnM+89LQBT5BG/Gx
         TLDlsGdZNcSXZghV/JbjO+CQKgmkVmsk29Qqdk2nWMy5rLqJlV2/U0pE6Jv9gEk4xq+/
         3KHIYynY4PhX/vuw3djmgN7GA/Q39Zc65HDLyr0AXnaEkHd13V65VJyfbC4/rgGQZ9DT
         YmJHkEVbcALis4r63k2ABnepHaAqCawCwDzISMYVrtVLoOHh3CzPgDf486gRtqKM0MlI
         Oh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PtQ+iCOtg8wKI/383IxFyqZ9i0rudNbH4n4NHCffbA=;
        b=LBrxgmlMFljoeW2wuMWurXOSk1e9H1oOfhe0TfctjQDkF3Atyo0CE6CAtJ/fq7Gs9c
         whgihaB6gVxHBEirXiwL0EXDdeXz3qjXXCT9X34NsyEC6l+bd4HxLgKBnPBrXhlZc5wa
         KievA+H56kS5DGsGTbjGXA9uoP8lohnLlt2gkY0RzfbRJb8EeawTKjl2LhdbLhH1uoQA
         MgwKM3tJbm7n8vysAEJdP1QhVTvdRHltJ/Kjo6AX8kvgbMv071eBHIgpQWBBR5Zo60TN
         iYCcrLmJZnmfc1xwNtDhN5kubTpVSpJZc81L8fecB1Ip4gUWSns3vZjWbPNJqyTBlpR2
         e4gw==
X-Gm-Message-State: AOAM533w0ZK/8xs3GjjP6ouodS/irOxQsyVk24Uh2GgJVPtTOJW+4Alz
        2bBpzahhF0eS2II5GlNerjJOJIBzaMQ=
X-Google-Smtp-Source: ABdhPJxV9k0ZL4Gqs67Vg9VKizi/lSyC7nsQ/hfmdjfPA6IUerHTOc5040md/BDFUMBR4ca4StXqUg==
X-Received: by 2002:a62:8103:0:b0:4ae:d63e:9d85 with SMTP id t3-20020a628103000000b004aed63e9d85mr2108727pfd.69.1639454310360;
        Mon, 13 Dec 2021 19:58:30 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o17sm11430356pgb.42.2021.12.13.19.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 19:58:29 -0800 (PST)
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
Subject: [PATCH v6 4/6] ARM: dts: NSP: Fixed iProc PCIe MSI sub-node
Date:   Mon, 13 Dec 2021 19:58:18 -0800
Message-Id: <20211214035820.2984289-5-f.fainelli@gmail.com>
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

