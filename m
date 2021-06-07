Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA4939E923
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 23:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhFGVfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 17:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230333AbhFGVfl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 17:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623101629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ne0sdd3NZl98G4gVbRdymPLZj6j1uGmDFhwuH8srjsM=;
        b=hqQSjSYvpqBzNCAIHFl24rlfsdiqCIayT9cBO3ZRFfIrhSpc2yN3/YrgheTSbJQtUyWffP
        bJFtBnPxlTyhaaPdXYCmX9dSK717gBn6ISFmhP8Y6mO4Qjgbm/IzZEZhlIj2ic+ApyRCFf
        7s4dJPv6xryDZPogjKcx1oRkHKyZIZY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-XiRWl2-VM0maPb9Nyhb6Gw-1; Mon, 07 Jun 2021 17:33:48 -0400
X-MC-Unique: XiRWl2-VM0maPb9Nyhb6Gw-1
Received: by mail-wm1-f69.google.com with SMTP id f22-20020a1c6a160000b029018f49a7efb7so419230wmc.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Jun 2021 14:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ne0sdd3NZl98G4gVbRdymPLZj6j1uGmDFhwuH8srjsM=;
        b=Rd97OPIf5M7RDCAqRRz/37RtHoNFWmUtM/f0dfu7yWGjIIU3EDYUss4V2Qze2bkqlU
         upC7GcAUeH4cYnSt8XVPlIfpYTf2KyZggrgwSA00gJYtqjdHT8AL6/SkSULsaAPdFYFw
         ZfFpHKsx6qyk0jnXnN6/+SXWrA+PeM3BBgwvPGsOXwF6FP/r3m2MdN7gEKYtX4pM678S
         n1su92AIMoX2dYW1vBEy8dhqJU/n6spHF2rB32M0kcbgmztwUVgDIPwR27HYvX4+p4MC
         LC6ofTtleFfonNoYwt2Og074P1qYxyYjd82439KKU1mTTHZefjI2T+bLFboCV42MGOmN
         J/RQ==
X-Gm-Message-State: AOAM5322k5LQAOYQxSIZQIS5Ei9xZKByQ/hDa3NaN3vd4afqAqRSrHGO
        DsVcchb+Y8MVO7rmciEhGtw35jXreCAfQwpJ0OKCDOUp4XoPzGVj1GR+2DmlnaJJSyV2G5Du5DD
        E+sUueR1caRjFy9d1lFHU
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr19012441wmj.6.1623101627126;
        Mon, 07 Jun 2021 14:33:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4ll9t3EwcCKy3igwdQwoTdXU//20aYaO8amkuTKLrzZN/i3Xio/esdoJJJge80qbLcxBnjQ==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr19012434wmj.6.1623101626926;
        Mon, 07 Jun 2021 14:33:46 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q5sm17659319wrm.15.2021.06.07.14.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 14:33:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] PCI: rockchip: Avoid accessing PCIe registers with clocks gated
Date:   Mon,  7 Jun 2021 23:33:28 +0200
Message-Id: <20210607213328.1711570-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IRQ handlers that are registered for shared interrupts can be called at
any time after have been registered using the request_irq() function.

It's up to drivers to ensure that's always safe for these to be called.

Both the "pcie-sys" and "pcie-client" interrupts are shared, but since
their handlers are registered very early in the probe function, an error
later can lead to these handlers being executed before all the required
have been properly setup.

For example, the rockchip_pcie_read() function used by these IRQ handlers
expects that some PCIe clocks will already be enabled, otherwise trying
to access the PCIe registers causes the read to hang and never return.

The CONFIG_DEBUG_SHIRQ option tests if drivers are able to cope with their
shared interrupt handlers being called, by generating a spurious interrupt
just before a shared interrupt handler is unregistered.

But this means that if the option is enabled, any error in the probe path
of this driver could lead to one of the IRQ handlers to be executed.

In a rockpro64 board, the following sequence of events happens:

  1) "pcie-sys" IRQ is requested and its handler registered.
  2) "pcie-client" IRQ is requested and its handler registered.
  3) probe later fails due readl_poll_timeout() returning a timeout.
  4) the "pcie-sys" IRQ is unregistered.
  5) CONFIG_DEBUG_SHIRQ triggers a spurious interrupt.
  6) "pcie-client" IRQ handler is called for this spurious interrupt.
  7) IRQ handler tries to read PCIE_CLIENT_INT_STATUS with clocks gated.
  8) the machine hangs because rockchip_pcie_read() call never returns.

To avoid cases like this, the handlers don't have to be registered until
very late in the probe function, once all the resources have been setup.

So let's just move all the IRQ init before the pci_host_probe() call, that
will prevent issues like this and seems to be the correct thing to do too.

Reported-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/pci/controller/pcie-rockchip-host.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index f1d08a1b159..78d04ac29cd 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -592,10 +592,6 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
 	if (err)
 		return err;
 
-	err = rockchip_pcie_setup_irq(rockchip);
-	if (err)
-		return err;
-
 	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
 	if (IS_ERR(rockchip->vpcie12v)) {
 		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
@@ -973,8 +969,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto err_vpcie;
 
-	rockchip_pcie_enable_interrupts(rockchip);
-
 	err = rockchip_pcie_init_irq_domain(rockchip);
 	if (err < 0)
 		goto err_deinit_port;
@@ -992,6 +986,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = rockchip;
 	bridge->ops = &rockchip_pcie_ops;
 
+	err = rockchip_pcie_setup_irq(rockchip);
+	if (err)
+		goto err_remove_irq_domain;
+
+	rockchip_pcie_enable_interrupts(rockchip);
+
 	err = pci_host_probe(bridge);
 	if (err < 0)
 		goto err_remove_irq_domain;
-- 
2.31.1

