Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0029579939E
	for <lists+linux-pci@lfdr.de>; Sat,  9 Sep 2023 02:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjIIA0D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 20:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345567AbjIIAZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 20:25:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F63212F;
        Fri,  8 Sep 2023 17:25:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B3FC433B6;
        Sat,  9 Sep 2023 00:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694218993;
        bh=KFZsGGyD0P7y0oh9GMll0hj/TXO8KOZJBtkIG+3Tpb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAM0RA3bN9G7Ew/wLJ6AfDZTf9mWZ/NsKaJsVWEDSfNyo2Ax7igGgxu0cvwNpk9/W
         Sp0uoifNUlizM7CUpapDirrWoGNzJ5pWa5iKFdBxvJOu+dH7evqUusqvjhPiLR8OUf
         V0BLN+uAxpl8upvFVMUvD6nKG/q+/T2CHqN0qpr2JldgGpPNpCP4FgzYH9zHgWW/Ys
         WOpVzurF1AhyDH6zQnMXzEYxpTL5U7Rqc0ZXLW9g3t0TDsBWs79W2ykfzP6ns4GNir
         ic21tSuXR/M8SSLGMO4gTZ0/NNJ0ntjpGdSlS4yAqv2g8DKTI27SPf87NOjXd2rIz+
         hrMDyPTnTHGbw==
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
Subject: [PATCH AUTOSEL 6.1 4/9] PCI: dwc: Provide deinit callback for i.MX
Date:   Fri,  8 Sep 2023 20:22:55 -0400
Message-Id: <20230909002302.3578361-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002302.3578361-1-sashal@kernel.org>
References: <20230909002302.3578361-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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
index 47db2d20568ef..388354a8e31cf 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -999,6 +999,7 @@ static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
+	.host_deinit = imx6_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-- 
2.40.1

