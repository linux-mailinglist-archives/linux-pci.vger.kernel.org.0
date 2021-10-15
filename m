Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E6642F602
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbhJOOrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240718AbhJOOrm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:47:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88430C061570;
        Fri, 15 Oct 2021 07:45:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so2937109pjd.1;
        Fri, 15 Oct 2021 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g4G4Yffk64HxtbjZzw9/E8PSnsLTvUujtQvSwE3J4gU=;
        b=flHW2Jb/AbysBVvJNNr6JwH4MLrEHqIfdfTJWIOUpBUFJwLO86Ww3lJYUN7rYZqGJh
         I/lLA1GbwqNXEqeL89Z3FnLGzNne+/JrIebWPKmh9G+HFumicXJhgPMP/FcWxH3Qo12+
         Q0ZxbrKvgId5wRbJMk7X2tyZjOWKJ1dQkwD56X7y0ajeoKXdAStXPcstCBSbsF4aWum2
         zF22ZFS6E/jaZgCPFP68wJmWfS9nwNR3Mf74lov/0SXtOEeA6Pe3kS0PlgMvknpXbjei
         UoH4eIy6X67PmTd7h87bfKgIgkE3H+Tq1rJ5p5b5NVrQLGDERDaJut6pmY8fSOHCLf0a
         bQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4G4Yffk64HxtbjZzw9/E8PSnsLTvUujtQvSwE3J4gU=;
        b=bZhTXKMr2vF2KPemwXwEnx60GZ0GZo6ANFimsApScv1EhVAhqSkm6dBTTDfxRcHz+v
         YYkq6IyJjbr5wJKQg2EVrKBeHzL7j1KESvdTg+hs+wy9h08QlVilBK0txNFrYfy/RMXW
         xF6bXSxVXoKZU6PH0+1wYgNVcb0hAPa2YgH2YHMBVpVNi+1WkLdyHby9LE3XPGIq6VXq
         lo84DVIYQYCOOp5MnGHySwv2HzCt5/ZUZYuw2LIn8vL9wFaWsYgrrAd0rDf22kWXySlo
         QPxVzV32ECbIeDpN1cweKT1rDVksWDx9agX+TL2GDmnVmBYBdyk/Ye9Ddr6LMw9p5omu
         IZ7g==
X-Gm-Message-State: AOAM532qd4OOv0Ua/ccQTLoiADplMq6jrmmhShJguwYjG4K6mo5UyAYS
        6IMJzy7Or1H7Pv4HW9OfwKbht3CJwoX//KYk
X-Google-Smtp-Source: ABdhPJzyBRhAH58hfG57hRWt1brI24x/g9MveoCJoOB1DDAWMEjJsf6dfeFJ3flcCuWG22yuJmFJEg==
X-Received: by 2002:a17:90b:38c6:: with SMTP id nn6mr13976286pjb.206.1634309134963;
        Fri, 15 Oct 2021 07:45:34 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:45:34 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org (open list:PCIE DRIVER FOR ROCKCHIP),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support)
Subject: [PATCH v2 15/24] PCI: rockchip: Remove redundant error fabrication when device read fails
Date:   Fri, 15 Oct 2021 20:08:56 +0530
Message-Id: <4fe27c1af8b43e87c2eaf31fced8015b81478c8f.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
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

