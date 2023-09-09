Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF718799391
	for <lists+linux-pci@lfdr.de>; Sat,  9 Sep 2023 02:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjIIAZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 20:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345524AbjIIAZo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 20:25:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6D2705;
        Fri,  8 Sep 2023 17:25:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF15CC113C9;
        Sat,  9 Sep 2023 00:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219074;
        bh=cB6ddkVcttJmN0WANwNBY0DVzGE1tj3HG4JPnwCrU94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laV0L+K3dKsMmhOm+q1KZo5KQfZqTmzRPQ5X99Sux/scqfn8BsWccyoAjVBzf12P5
         +EYoIC6Cd8jPw7mkN5ehjGehwjCIHcbDS9JciSPnUCLk5j+WLvSD6N7GE/yA+kksN8
         DenUx5iNsC4YPhMZlTSuqFxLfRrugIjKFFhzNekkz4csyIbVLsZi1ZPAeQQtRhyH19
         MOG+bxf2BpEjBx79lkvWaVQj3H7rZL0LiX++pZ0DUVAm33mDfGsKzv4IxIta9owy8d
         RNc3DGa64eIotXAcVtr1VhFqtoMQ9tWStu8SXZ7AqH36S9mq80rzdM+Fn+105l5TLz
         ZnGRGn0KqukUw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sasha Levin <sashal@kernel.org>, l.stach@pengutronix.de,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 4/6] PCI: dwc: Provide deinit callback for i.MX
Date:   Fri,  8 Sep 2023 20:24:20 -0400
Message-Id: <20230909002424.3578867-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002424.3578867-1-sashal@kernel.org>
References: <20230909002424.3578867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.294
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

[ Upstream commit fc8b24c28bec19fc0621d108b9ee81ddfdedb25a ]

The i.MX integration for the DesignWare PCI controller has a _host_exit()
operation which undoes everything that the _host_init() operation does but
does not wire this up as the host_deinit callback for the core, or call it
in any path other than suspend. This means that if we ever unwind the
initial probe of the device, for example because it fails, the regulator
core complains that the regulators for the device were left enabled:

imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 16G
imx6q-pcie 33800000.pcie: Phy link never came up
imx6q-pcie 33800000.pcie: Phy link never came up
imx6q-pcie: probe of 33800000.pcie failed with error -110
------------[ cut here ]------------
WARNING: CPU: 2 PID: 46 at drivers/regulator/core.c:2396 _regulator_put+0x110/0x128

Wire up the callback so that the core can clean up after itself.

Link: https://lore.kernel.org/r/20230731-pci-imx-regulator-cleanup-v2-1-fc8fa5c9893d@kernel.org
Tested-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3b2ceb5667289..c949d11f95507 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -642,6 +642,7 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
+	.host_deinit = imx6_pcie_host_exit,
 };
 
 static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
-- 
2.40.1

