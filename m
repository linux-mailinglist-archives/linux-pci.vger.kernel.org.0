Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2D39F05E
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 10:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFHIGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 04:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230313AbhFHIGJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 04:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623139456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eRLfIlExKhLKW3ohxS3QmcrC8PB6Pwunoa93O+xqbII=;
        b=D2zd8bJgok0SvLPT69Bf+0IYBaLtMG6ggeUwwDn2wZJxhsvbhBIDhdAQ/TgHYEsehNwdyw
        +kJB5lyO7j1OVejSP+jJ5eZ9GX+kB6st2WSh1/HYb3M46Z+lxxLiPavtkRmtT0wRSNLQIT
        cl53VMNmAcw2XFntLyuX3flJnLnp5FU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-NAV-zGoROqm2jVUgxFDQOA-1; Tue, 08 Jun 2021 04:04:14 -0400
X-MC-Unique: NAV-zGoROqm2jVUgxFDQOA-1
Received: by mail-wr1-f72.google.com with SMTP id u5-20020adf9e050000b029010df603f280so9063481wre.18
        for <linux-pci@vger.kernel.org>; Tue, 08 Jun 2021 01:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eRLfIlExKhLKW3ohxS3QmcrC8PB6Pwunoa93O+xqbII=;
        b=hgfl0uaUB/rkvIjas9zWcqqyEhTe+6n2XFBXd+AY5XU+i92yquLvBp9ohjUzFgMmXT
         wtBjMuMpphJeUXBMFxnOom1VyxDtaaoDB3hJOCBPexvCvfoiXRCmqXvWGy1PXuq0UAg9
         qv9Ht+onjSvv8kbFCb+athGhSXZohW5BxB5obNuchy4EV+YXKbrDa3VvXNmPQlMMc4k+
         smBhcW1FPp+HiCIayUov2j3+0yfZBICffHCCXbDFoFCZIE0RJTOGFmA9ET0YtVE1nEYD
         8y6KBk8Tl7LEynFYrxrukcaY/ZTeujguPtHNUW18GdRpb1erJyHjMBlUuOqOheboKd95
         vaKg==
X-Gm-Message-State: AOAM530lYvhNZO5Z+2r/yhIJf/P7DD4EI09iOLm2pN0YTYnN14iLw0lM
        AZJsFvu/qAzhCJJu7BN2ghS8WxNPixEpRmjiu5qVacH7LrfVG6DMZe9qzzLmVO8spkoPYgmypSR
        Ey/rr+2FwMV0YrfdlXPhd
X-Received: by 2002:a5d:5983:: with SMTP id n3mr8801719wri.241.1623139453734;
        Tue, 08 Jun 2021 01:04:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMZdm0lOV6CTzcaqjiMsts4ZrMuE5GRipe8Uouaz7yC1zHJCdwRHLBh8j5A6Gyo/laf6JPcw==
X-Received: by 2002:a5d:5983:: with SMTP id n3mr8801701wri.241.1623139453534;
        Tue, 08 Jun 2021 01:04:13 -0700 (PDT)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q11sm18515680wrx.80.2021.06.08.01.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 01:04:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with clocks gated
Date:   Tue,  8 Jun 2021 10:04:09 +0200
Message-Id: <20210608080409.1729276-1-javierm@redhat.com>
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
resources have been properly setup.

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
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- Add missing word in the commit message.
- Include Shawn Lin's Acked-by tag.

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

