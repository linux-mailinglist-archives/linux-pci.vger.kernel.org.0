Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6BD43354E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhJSMEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 08:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhJSMEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 08:04:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DC9C06161C;
        Tue, 19 Oct 2021 05:02:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1852145pjc.3;
        Tue, 19 Oct 2021 05:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VstgBb1WpAFxmjgEF016s8/N6/G+uWbCOyA3bqA7yQQ=;
        b=TEA9MLqbOVq7RmcYakd/vziXUhkxFHx37bojiSprOG0B+lJljwJ3j8RTVyJBupUm7y
         BsCv9dM5yV0Y3rOiGvPTTHgBlnTMdAPNKEpM0lXj1seh3nMtseBRliPvxebKOWniXi90
         EXvh+7M4LagBLuy9DIwmuZyCW8KDENmbYU1/J5qXQxjIyIHXL61mJejhQKbC2Px+43EU
         10Q3LPuZHm7xw3p9WOKmhrqY/esfqW3biW9TGeFRDLE7s2ZUzDBSMPT4FWkedcfF2gr3
         ylELmaBb/HkMgjt6p3saFqt0yDnl5w1KFCuoUIGeNb3LStbQB6v2dhX0Ilt1EMQiJu0i
         2WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VstgBb1WpAFxmjgEF016s8/N6/G+uWbCOyA3bqA7yQQ=;
        b=1NhbGFh3hDqswDLgi3K/CCMr2+jxHAkVyBGtAorHW5pvwcm86IQpvRo7F4ISpEf26a
         9c35vdBYTfv8P2PqHQR5k7OZaClITR0IKoO4fWxgqzZ0jx686Yw/fyR8x5TIFDCQ0Uz5
         hzGCN4fkvh92CYRB6JOFIITE8W+ggyM4L4v4O+m0c8TNBp+BSjbkycr/LpkPjdbFpr4b
         H8V9c2E6BhwS+fX1Mz6RCwnwbFCXXZODqHjoG2+4Zq1VJCLGVh84hx3sQDlLVEmG2R4s
         MMxyq3J/CnqyGSoDgpK//assBarPnQZZshut57kCGRdkCwsHrZsxp+0k/SY0WAf+VwZ8
         yVzg==
X-Gm-Message-State: AOAM530xF5smY0TQEGMhpzyV1dV93lsWhA3gPyoal20bzwrAHydqWfp1
        E6ybsjXTv9R6NIJIFEVMiRM=
X-Google-Smtp-Source: ABdhPJxIoXyH2q5MFgLvewo8I/0kFS3bsLZV6rGrGRmcdHiOhFs/xoHutOFv7TkODOqxHrjgPRSCaA==
X-Received: by 2002:a17:90a:cc15:: with SMTP id b21mr6267146pju.113.1634644943521;
        Tue, 19 Oct 2021 05:02:23 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id 197sm16048248pfv.6.2021.10.19.05.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:02:22 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>, robh@kernel.org,
        kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] PCI: rockchip: Enable the phy driver when controller is enabled
Date:   Tue, 19 Oct 2021 21:02:15 +0900
Message-Id: <20211019120215.793794-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI controller on rk3399 requires the phy to correctly initialise
the PCIE phy. Without phy initialisation the host and end-point
controllers cannot be used.

To prevent building an unusable PCIe driver on rk3399, enable the phy
driver when the host or end-point driver is enabled.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
---
Hi,

I've been caught out many times when booting off of PCI and finding
that the kernel cannot find rootfs due to the missing phy driver. The
patch should prevents this by fixing the Kconfig dependency
enablement. 

Thanks,
Punit

 drivers/pci/controller/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 326f7d13024f..1965df38c4a3 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -214,6 +214,7 @@ config PCIE_ROCKCHIP_HOST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
+	select PHY_ROCKCHIP_PCIE
 	help
 	  Say Y here if you want internal PCI support on Rockchip SoC.
 	  There is 1 internal PCIe port available to support GEN2 with
@@ -226,6 +227,7 @@ config PCIE_ROCKCHIP_EP
 	depends on PCI_ENDPOINT
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
+	select PHY_ROCKCHIP_PCIE
 	help
 	  Say Y here if you want to support Rockchip PCIe controller in
 	  endpoint mode on Rockchip SoC. There is 1 internal PCIe port
-- 
2.33.0

