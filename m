Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79330436569
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhJUPO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhJUPOu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:14:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C5C061220;
        Thu, 21 Oct 2021 08:12:34 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j190so643072pgd.0;
        Thu, 21 Oct 2021 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6PFmrQZfsZKbN43caoyPHUp+nOh1/rI/bPUZ2uC0hc=;
        b=cx5p5aIYC4iBC/rybqZ91xTecfYjNtHqUHOdXqzsxJDyMTRFonGrj9ly3a8JLr+Jqi
         FsOHOkaeHXKHoT2r6uMySNoymLbA9n6itWBwP5xcH3wVrVj/LDyOWDcAg0P7Hgb4MjYI
         gcJqzThpvQ1cJRP3ceL6aQw11A+KcLIBeVAbK97WFFofjPVyBGwkwoIS3mprp72yPkQx
         aZZ4VLEAhL9+Vr+lJjfnIobegCV0nF+Tyd+UFuRCuw1uka8pDyEf6pMpfKvPIVrEWy97
         mBxeBj5m3sLwbBHRQfDPJzz6dqRVB7VyUdyzisc8JXQ9jQ7GWSeLqc91ci5KZCIg+5o/
         Yycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6PFmrQZfsZKbN43caoyPHUp+nOh1/rI/bPUZ2uC0hc=;
        b=N/1Js9VTGlwlk0AxXQnbqdEHHKDVY3t+Mk+Rv2zTv3kXZivVNC1cGQbC8p9vWkN3CO
         UiVK8GpO4gebsZMMLfRUpFTWFf1KTn6lsmZqKTPg+q2e/Ifg6hi7zDnSKXufjnBy0c/A
         9kwziWa43v3wK8hp5w8wwZFv2nZIWL18xUpRh/VNif69LUAoLpxdcgWwH0Hvu4iJ1ok9
         gZAuev+OtTnKHI6ozg0JVgO5ztG9+6ZDWqJZwysYgPlm33eVfLU8KCNOTuxb1KZAK6k0
         wv1474sOq6JpTLOBTL0WmkRfBdW1b8jyMv8q131t1yjfSZwX5Ai7Z9FfpdUROdc4nvuz
         5Dkw==
X-Gm-Message-State: AOAM533fsJ8fhIDpYycZNFjET+unlH76KB7PSZN/KOHdTq8oBKawgw9I
        WLs+QGhfZQ4nNuKMKgu4sis=
X-Google-Smtp-Source: ABdhPJxOw8KnEwKd2flVyMc4Jc2QOyKNOmOKWuKX5gVjXqvy+QZPzirbEwbZ/Pwfv3SywVvO16oIQg==
X-Received: by 2002:a62:84d5:0:b0:44d:7cf:e6dc with SMTP id k204-20020a6284d5000000b0044d07cfe6dcmr6453657pfd.12.1634829153838;
        Thu, 21 Oct 2021 08:12:33 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:12:33 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 12/25] PCI: mvebu: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:37 +0530
Message-Id: <ec9bea12f3a1647dfae871083369ed95c1bb16eb.1634825082.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/pci-mvebu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index ed13e81cd691..70a96af8cd2f 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -653,20 +653,16 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	int ret;
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
-	if (!port) {
-		*val = 0xffffffff;
+	if (!port)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	/* Access the emulated PCI-to-PCI bridge */
 	if (bus->number == 0)
 		return pci_bridge_emul_conf_read(&port->bridge, where,
 						 size, val);
 
-	if (!mvebu_pcie_link_up(port)) {
-		*val = 0xffffffff;
+	if (!mvebu_pcie_link_up(port))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	/* Access the real PCIe interface */
 	ret = mvebu_pcie_hw_rd_conf(port, bus, devfn,
-- 
2.25.1

