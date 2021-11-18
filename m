Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D004455D80
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhKROLN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbhKROLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:11:13 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4DDC061570;
        Thu, 18 Nov 2021 06:08:13 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x131so6105167pfc.12;
        Thu, 18 Nov 2021 06:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g4G4Yffk64HxtbjZzw9/E8PSnsLTvUujtQvSwE3J4gU=;
        b=FEbJrXxCeKEEGR3YZzQOCO7CCSBIhw9NTelVNkIxCZruozHn8xhBs2z7SKtVg3Y7mb
         Spm+q3WhNteQeCkW5pRlBczWhIVXYdP5caVWHfusUnz+MFU142BG/j/2/ZuZy+4ddBav
         YTe7rJsZ3tvLaL8BMpNjkewMFAYPWnLS8iYtZ9oWwSjUtrH3/r1aacSIWAJNgCgv2Rbx
         9JjrlPIcL64R5NbYNUUSJy7V8FwH1P6BD8BvQ7gbdYKGISMWkSGLaV1qc5T70ka6GpX0
         HiymHCl5lSCgQHx8uSdIFmYjYITQV5yefpf3EZUJSFtCTZbG2Ychrh85/HhM6Dr5hIOM
         3fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4G4Yffk64HxtbjZzw9/E8PSnsLTvUujtQvSwE3J4gU=;
        b=hZ3LfeRaKsw1Jlcgs2T77/FwVe8rbzxAyDL0uAQheJdAI5DDi7JWzXIfxZqTMVOU4P
         /k9lGkIfZstceS7gshc5XfpXtlKNutKtFcJPqLCHqvOeMLYguTGrJqYN5atUR04ZhoPK
         +xfZb3mP0UR5pQrEb7OheKlkzC+DQerbPYEyAoyKsqB7xBm2gVFu3Xzi1NK8Q9tX8+pq
         oW2/6UrlwDJcfeE8eUDTeazPCneb4wQKjR4DbVkIMa4jyXue2CHJtU5RADzxuWMmH9QY
         gdZGOEyjjMbgXh+3gKH/GztqunOHyElr7hTJSGRrpx57RWjvDmyXw49zj5Oq4RLzstjz
         ODEQ==
X-Gm-Message-State: AOAM532kRf/ng/AGTqvj1pjwxAk94qY0bu8Omld1FXMdo0/AjfHO5erW
        sfgPW93aeHAbfc+isbaZXD0=
X-Google-Smtp-Source: ABdhPJx6ZoumMEGNj/EK6eVg69IbF74XwG8Czzauu8jXNtFO2IC2J8wksDYPCGoh99ek/ZBkGjo1RA==
X-Received: by 2002:a63:7d01:: with SMTP id y1mr11448956pgc.343.1637244492845;
        Thu, 18 Nov 2021 06:08:12 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:08:12 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org (open list:PCIE DRIVER FOR ROCKCHIP),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support)
Subject: [PATCH v4 15/25] PCI: rockchip: Remove redundant error fabrication when device read fails
Date:   Thu, 18 Nov 2021 19:33:25 +0530
Message-Id: <50f9a6fa16521a86cb24d2f27c1f66eb3568cb9a.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index c52316d0bfd2..45a28880f322 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -221,10 +221,8 @@ static int rockchip_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 {
 	struct rockchip_pcie *rockchip = bus->sysdata;
 
-	if (!rockchip_pcie_valid_device(rockchip, bus, PCI_SLOT(devfn))) {
-		*val = 0xffffffff;
+	if (!rockchip_pcie_valid_device(rockchip, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	if (pci_is_root_bus(bus))
 		return rockchip_pcie_rd_own_conf(rockchip, where, size, val);
-- 
2.25.1

