Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9DE6326E3
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKUOvY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKUOul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:50:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B0C1F49;
        Mon, 21 Nov 2022 06:42:48 -0800 (PST)
Message-ID: <20221121140050.322564760@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BsahiWAKXFVJNJh44POfSovZLxdrhfjFryH8JdnSUvg=;
        b=PR53tmTt10lyQW8LlIx/PyT+1Nwg6hlPDXIQcLRf5Q22DV1dMMXq8ggOlWrdIN2B0Gk+en
        BLEYhIeWc0u73XGOG0S5eSnH4U91VqDWy+tCRIFBLy3528SNFP2T+9AsdU4nx/8BzK0AIy
        6JqgDVGRTua3bU+CAr4StsXEuRVfqCwSwNzq8EIyg89676MuCUb9RwNxryWEbZQ3OCNHtD
        v5U1IcmeCzeVkYJXmzJ2h8iUSNZet81amIAwvi3AwkII7DTKtN5bhX6VgpNsoDFvSvDg81
        bphqeOprxQq9kras4E8qEN9rA3Nvm5s3du7g6IkbpjLXXyobrzsXzsPLfeH/YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BsahiWAKXFVJNJh44POfSovZLxdrhfjFryH8JdnSUvg=;
        b=HQ5Yx+4UF17bUmcln2P+uBe4p0mVVcmgNYPOgbUkeviPuXl5M6nQ/kBiImIbMI7aNTdljT
        rKTZG/Cs8/s2gUCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 32/40] genirq/msi: Provide MSI_FLAG_PARENT_PM_DEV
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:08 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platform-MSI implementations require that power management is
redirected to the underlying interrupt chip device. To make this work
with per device MSI domains provide a new feature flag and let the
core code handle the setup of dev->pm_dev when set during device MSI
domain creation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    2 ++
 kernel/irq/msi.c    |    2 ++
 2 files changed, 4 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -538,6 +538,8 @@ enum {
 	MSI_FLAG_NOMASK_QUIRK		= (1 << 7),
 	/* Use dev->fwnode for MSI device domain creation */
 	MSI_FLAG_USE_DEV_FWNODE		= (1 << 8),
+	/* Set parent->dev into domain->pm_dev on device domain creation */
+	MSI_FLAG_PARENT_PM_DEV		= (1 << 9),
 
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -884,6 +884,8 @@ static struct irq_domain *__msi_create_i
 		if (!domain->name && info->chip)
 			domain->name = info->chip->name;
 		irq_domain_update_bus_token(domain, info->bus_token);
+		if (info->flags & MSI_FLAG_PARENT_PM_DEV)
+			domain->pm_dev = parent->pm_dev;
 	}
 
 	return domain;

