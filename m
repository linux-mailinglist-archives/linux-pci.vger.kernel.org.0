Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C019F6FF5D5
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbjEKPYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbjEKPY2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 11:24:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF67CF;
        Thu, 11 May 2023 08:24:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ECA364EFD;
        Thu, 11 May 2023 15:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451A5C433EF;
        Thu, 11 May 2023 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683818666;
        bh=gTCIsTeyvWVF7CNHhHZqQxWhHlR+f/E82arExFViVMw=;
        h=From:Date:Subject:To:Cc:From;
        b=VhUgQka3XsqdVpNVOu3b0Ofus2BN683WIdaE8dHh6/OFIT59zLXdCx/jTPsXJe4Za
         i7fhpyMEKAozHakcAsWM3PhFZoFbbC6yFpRrBbDtFb9ecdXrk0CCQaXp1d6Y7r3o+/
         zVyE3sBNpvgb11fkEJCOJBDDUzsxLzIyA9ICtDnxoVTXn+6LqUAjsLWXuqW7IOlv5h
         xrtPyMHIEZTSkAUsjVl6wxAsS/Yz1GnduqJaPf/XSP8sqgoCtSfS3MdyFwrMUcJ9AS
         Mhg58ZBjL9O9Er4tfQm1RR6RSg/3gWU1Yoia4pbaEdEbDOZpQOEM/DypmW00bRqFUH
         DPQBLbrFd754A==
From:   Simon Horman <horms@kernel.org>
Date:   Thu, 11 May 2023 17:24:18 +0200
Subject: [PATCH] PCI: microchip: Avoid cast to incompatible function type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230511-pci-microchip-clk-cast-v1-1-7674f4d4e218@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKEIXWQC/x2N0QrCMAwAf2Xk2cA6rWX+iuyhy6IN1q40KsLYv
 xt8vIPjNlBuwgqXboPGH1FZi4E7dEApljujLMYw9MOx985hJcGnUFspSUXKD6SoL/TLOYyjP7n
 AASyeozLOLRZKlpd3ziZr45t8/7frtO8/GrgVU30AAAA=
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rather than casting clk_disable_unprepare to an incompatible function type,
update the type to match that expected by devm_add_action_or_reset.

Reported by clang-16 with W-1:

 .../pcie-microchip-host.c:866:32: warning: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
         devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare,
                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ./include/linux/device.h:265:38: note: expanded from macro 'devm_add_action_or_reset'
         __devm_add_action_or_reset(release, action, data, #action)
                                             ^~~~~~
No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/pci/controller/pcie-microchip-host.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 5e710e485464..d8aa6e3cdbff 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -848,6 +848,11 @@ static const struct irq_domain_ops event_domain_ops = {
 	.map = mc_pcie_event_map,
 };
 
+inline void mc_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static inline struct clk *mc_pcie_init_clk(struct device *dev, const char *id)
 {
 	struct clk *clk;
@@ -863,8 +868,7 @@ static inline struct clk *mc_pcie_init_clk(struct device *dev, const char *id)
 	if (ret)
 		return ERR_PTR(ret);
 
-	devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare,
-				 clk);
+	devm_add_action_or_reset(dev, mc_clk_disable_unprepare, clk);
 
 	return clk;
 }

