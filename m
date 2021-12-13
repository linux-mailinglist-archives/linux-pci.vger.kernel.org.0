Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D520947357F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbhLMUAS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 15:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241818AbhLMUAQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 15:00:16 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79531C061574;
        Mon, 13 Dec 2021 12:00:16 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id j11so15505886pgs.2;
        Mon, 13 Dec 2021 12:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1v15Gl8TJzLJfCjgx7PA4whHDDqL64AFLHw1EUfuQI4=;
        b=iixQARDtSk/hnynCb+nf6H3vH1Cm6Kj9xlCVLmsA9ylU2hbta+X4HnexkqZW715J7y
         PElmkZlHwrbsoo5f/cPVVe5gXVueC9oHtwbDLASUIeqPIxlYWsO3tNCrBQWSCcYzY0hw
         WR6L94TfIgDmk4kW8Nf1jBfuZlq/tr9KE4n/SDW/UGAlBDKqBWjSrPJHPQkOVr/uD4wY
         lygaWXEMWLHWV5y8uEUR4kbaa3USDon9B/3SxBAyy9cOnovhiOQQrK4OUiFeYAcNWlTE
         j9jCpLn3UdYWPtm2lNXZpMTHW8tJXKfah5mO6kyVRKtKpoUJ7triVX1YLUW7INIXN3K0
         +h1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1v15Gl8TJzLJfCjgx7PA4whHDDqL64AFLHw1EUfuQI4=;
        b=kYXXMjKWxQNRPcejlWo9FyWF3Iu5TP0Fk4HbpdLRcW+ginYw7a1+JcyqirarKkjiib
         beHhXznufznjkqMRc2+bfYVODpT5qtDf1LnIBBXw4Vo9Q8YKRMQUzBSAAF2QPcHVJhx6
         fl/uqgBhM/HqJBH8C+BJWflQIgiNs5JqUHJ8q72AhBEUuFf2Obe52Zvhqtu4ejcvXn0Q
         6nTINDdQjKf+4FCC2BtDjfvFsjC1Q0Vw+PGOdhbiKI3xrKiylZ8TZwml1oaIi4znMQJ2
         74t5EjISKqIIW9QQr7UMlkUlKUx2h8ghSQgNfaPO/ywh6c9pPF73HSMlDhCaIeWUR/Ok
         70yg==
X-Gm-Message-State: AOAM530zbl7Ee6yTzRtKCvpFs4wu1+r9o+rNclzIesGP15Uf0MdldPzb
        rrmhEMZBeGUFtp2KPoAa8Sq/V3IlO30=
X-Google-Smtp-Source: ABdhPJyqRiE3BaxYOaCz2My/zK2+vPXbsf9TRVJhhqR+wuXQFyWdDbqLlc0jY7X+39ePnYL2ReIjKQ==
X-Received: by 2002:a63:6ecb:: with SMTP id j194mr562403pgc.46.1639425615626;
        Mon, 13 Dec 2021 12:00:15 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z14sm13926195pfh.60.2021.12.13.12.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:00:15 -0800 (PST)
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
Subject: [PATCH 3/6] ARM: dts: HR2: Fixed iProc PCIe MSI sub-node
Date:   Mon, 13 Dec 2021 11:02:18 -0800
Message-Id: <20211213190221.355678-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213190221.355678-1-f.fainelli@gmail.com>
References: <20211213190221.355678-1-f.fainelli@gmail.com>
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

