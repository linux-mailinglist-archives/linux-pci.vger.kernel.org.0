Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FD9436591
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhJUPQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhJUPPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:15:39 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87153C06122C;
        Thu, 21 Oct 2021 08:13:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f21so645644plb.3;
        Thu, 21 Oct 2021 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g4G4Yffk64HxtbjZzw9/E8PSnsLTvUujtQvSwE3J4gU=;
        b=cI4maM6sHC3cIMldIjQc1WksuleNIofwFqWYF4hgi1mSUPjEGy/WmXoWahcRKKe5+w
         j+zLwnck9MFzmr8MftgklxRZ5wNxIbu4G2AheKg9ZMv2lHgNNhGgL2J7UsV3l6gjZExb
         H4tZgM8wyBorCpeRi921+Tm3u0WVTydBr3Tj3cAhZ9aNPzvoqZ4hpLqS+KH5vxfSS8kl
         RuDF/0hlWT9G4JzVK0afVRra+EpY2rFrGAa9crTmNU2ssX8sWEbik9C86qDFbaKzhp+l
         Qiuu1E0eKf6ZEerz3y53kIBw8RH87UqQ0r1zBn0XyLQryf6q11P3qfumh997IU+rjQxH
         8n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4G4Yffk64HxtbjZzw9/E8PSnsLTvUujtQvSwE3J4gU=;
        b=4BEaDgR7WXMTsTe4Hhmh2swoNTEFDsbhCIT0x5j0buBukkAk1fIyEAnqSafCC6pvZu
         id86LgmFzf+pNx5RvmJ/8Bojrzk/Rdxj2yazemefd6HBhHEQ8PpxEoaQITfuItW/osXE
         RMTc6vFaMlW0bGk9NBoda7nE6Jc70pxJdEvCguThwZEmMfz/ScZ4ua9N9750SpJAmLD+
         me6RUVOSpO+a2IW4E+2y6+Yjpa1hWLvv5ezHhAgwOxemcRzbz3WPmqQl1QI8wXazyOsD
         4Cix+I6cHPqbGQXC5o8YbPhi7WXEvHNmbisA/0VEUxvs1AAvmv9E7U4NyTnGIc5ohZys
         Epog==
X-Gm-Message-State: AOAM532gsgqLtreMI6/Hiw4FCDM3XDDG94+aztRg+NQQVbYurGGAoKAI
        PzOptgrU4rYtj8/SRwMjWgM=
X-Google-Smtp-Source: ABdhPJwuN72upSJVb5RV31HWJ0Rk/DS/k3MWELCcfxWrH5dP6+GQCb3WOGhj7YB/ramfc8/eTUFdtQ==
X-Received: by 2002:a17:90b:1a87:: with SMTP id ng7mr7478114pjb.69.1634829192977;
        Thu, 21 Oct 2021 08:13:12 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:13:12 -0700 (PDT)
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
Subject: [PATCH v3 15/25] PCI: rockchip: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:40 +0530
Message-Id: <59113f443210c0c4d9d7696b22274c21ec2b7276.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
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

