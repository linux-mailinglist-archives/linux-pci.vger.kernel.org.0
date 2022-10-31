Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA09613A4E
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 16:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiJaPkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiJaPkK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 11:40:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C6311828;
        Mon, 31 Oct 2022 08:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24A5CB818ED;
        Mon, 31 Oct 2022 15:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B1FC43141;
        Mon, 31 Oct 2022 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667230805;
        bh=d2qwTVjIOLKmzm2jp8sYlOBb+EYG7A7QejDW//F0bVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xx6ewcqT8jUXOJmJKlk1a/DS5oUrpS9k0H8XxYkycnfRz8fZSVPkuLBscXAB6uZg8
         COdRhuwSrkmb8zeVOEMlaypMNnmwUDmU6YRlvwNthETWisXBy7kX/ho+YYwTFDG6By
         klqgObmuRyn0Whg0qtZEvlTetbtwEXLN2RjoSduTg1ztMtxgTac5FIytRQY8iaAyrO
         sr44zA32UrGTNx52JUtpzrzYsm6g8Si2Tpn9MbVxC7DSvVwyY2VuC2/QGk0DQzSdVi
         GbIMiHBI7VYixt1UzYD8L9MX7/zn4TXWByLI5sPpKRoVF7iGkuyAgY0pDH9ciKX+HG
         npICMhPsu3P9w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Joyce Ooi <joyce.ooi@intel.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 3/5] PCI: mvebu: Include <linux/irqdomain.h> explicitly
Date:   Mon, 31 Oct 2022 10:39:52 -0500
Message-Id: <20221031153954.1163623-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031153954.1163623-1-helgaas@kernel.org>
References: <20221031153954.1163623-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci-mvebu.c uses irq_domain_add_linear() and related interfaces but relies
on <linux/irqdomain.h> but doesn't include it directly; it relies on the
fact that <linux/of_irq.h> includes it.

Include <linux/irqdomain.h> directly to remove this implicit dependency.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 1ced73726a26..73db99035c2b 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/mbus.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
-- 
2.25.1

