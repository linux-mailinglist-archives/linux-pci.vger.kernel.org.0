Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C337A46CBE7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 05:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhLHEIP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 23:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244082AbhLHEIN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 23:08:13 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C98C061574;
        Tue,  7 Dec 2021 20:04:42 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 71so963881pgb.4;
        Tue, 07 Dec 2021 20:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1v15Gl8TJzLJfCjgx7PA4whHDDqL64AFLHw1EUfuQI4=;
        b=FU1QcCpCE7EGNyFNHu48B9UcmAm3UYXrZkZ7MaZceXZGKkJcGLY67bUXNYtkDe9Zw/
         hZJxeySLlkSjRAUKEZLe3xDC+BboqUmaiIQvrkCs/3+oNKsIMiN6h2fn5LnxCwn3rUw/
         3kr9fIiCLyEh6hDFOZmWvNoAUfCjSfVah2qct3XseCiO2AeADtvHP8zKUw4Ias+05cKz
         Ptc7i82BmQl6OZH6pJs+XMhXhveakvPPZP5F6fXiHx2HeCw+Sa+OdXQZVob8J9aEVmoS
         wMFib8k576EvJNz2JH7HoZ6tciWsE/HZct24LmRP7z7bpsfgah2Wfy0GRT8L2ZAI5RTQ
         tp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1v15Gl8TJzLJfCjgx7PA4whHDDqL64AFLHw1EUfuQI4=;
        b=CaVQE9ZUzCdAOS+/Balo5uesdEx8zbW01LVPV9kUDJ+rWM4YGje6JjI3pV/4yaNPmA
         9jNyghVYSZb2LWTUTZM76KUkvHUBweoeqsmVOJQlap7KlTNSav8VfGh7EgTSkLbtfms7
         iciNwQttURGkpN4p8aryu7kRD5nthCfUrhKZge1uK1N9z5CfmZ2fm3KAPaNbOHmJgyuW
         HTUuiwytdJSsf+eHpBe0B3zD35GB1PxZr51EvORI6s7lP6GmJGSgBH47sL1HKqDWqs3L
         p7yiWg2pBDK2bL5MgjSJUxneYfSZsOx6KV3QCjG04HzdfBbyK3kZJzeXoE9YXOSmiuTA
         2HZw==
X-Gm-Message-State: AOAM532OEkUz0ePZq0GYZ+p+eFELzspn7HxtUj3On4oy6oE2DStb2StG
        9Ni5RskgdOU8kRnYqcdc/P9mIynRLIY=
X-Google-Smtp-Source: ABdhPJzh2O808XvLmB994pj/JZZ0i94ctZlVmqhtaGF16YifWsv51Gg/0FN2yWXb5KskySsIbn0SHQ==
X-Received: by 2002:a63:81c8:: with SMTP id t191mr27145508pgd.369.1638936281529;
        Tue, 07 Dec 2021 20:04:41 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c18sm1320684pfl.201.2021.12.07.20.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 20:04:41 -0800 (PST)
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
Subject: [PATCH v3 3/6] ARM: dts: HR2: Fixed iProc PCIe MSI sub-node
Date:   Tue,  7 Dec 2021 20:04:29 -0800
Message-Id: <20211208040432.3658355-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208040432.3658355-1-f.fainelli@gmail.com>
References: <20211208040432.3658355-1-f.fainelli@gmail.com>
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

