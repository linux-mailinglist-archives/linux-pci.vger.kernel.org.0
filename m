Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639997505B0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjGLLNY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 07:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjGLLNU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 07:13:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEA019BA;
        Wed, 12 Jul 2023 04:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5ECF61779;
        Wed, 12 Jul 2023 11:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9E8C433C8;
        Wed, 12 Jul 2023 11:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689160397;
        bh=OiQLH0Ur4QsXIAElfzydLwPQ911lsGirTGBgpfbRwNo=;
        h=From:Date:Subject:To:Cc:From;
        b=frwEyun0JjpXRLfmgWx0EACB4r65Sw09om/Zwr++gjKoYfMXPVF3mmiOTNO38vXQi
         RxVgyPE9939/BrBImyl7agITWYf/NzY+sIr+9m1tmDVns19ViQZyfDAoVAELL+bPcN
         nA8Ui96r54vn7fHnPXuLwGTvdDwhVRkbohbN4zaSGJaRulx+6Q66ab7HRmVmH69IfY
         NPmDZNEvRnP4XX7ImKLcCa8+6sFi+s2CrHkc+cVW0RupWBfHOiTom1iQNL4shdiJ++
         9xm3xJwh9ZfYdIouZ2erBUZ8NPIoMBxKEhuzhFAwA7Is7oYuYcVn4O2JIQkVReAw5H
         bgh+tJz234QGw==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Jul 2023 12:02:57 +0100
Subject: [PATCH v2] PCI: dwc: Provide deinit callback for i.MX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-pci-imx-regulator-cleanup-v2-1-3b1f6e9d26bc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGCIrmQC/42OQQ6CMBBFr2K6dkxbghhX3sOwmJYBJmAhU0EM4
 e4WTuDy/eS//1cVSZiiup9WJTRz5CEksOeT8i2GhoCrxMpqm+lCZzB6Bn4tINRMPb4HAd8Thmk
 ENIW/1ZXJyecq9R1GAicYfLsbPoN0ezwK1bwck88yccsxWb7Hg9ns6T9jswED7up1rpGsw+rRk
 QTqL4M0qty27Qdfb40P2gAAAA==
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OiQLH0Ur4QsXIAElfzydLwPQ911lsGirTGBgpfbRwNo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrorJKTA/UiZOQu2QjSLqMPDCl2ntv4BxjlidDeA1
 pVC3nv2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK6KyQAKCRAk1otyXVSH0O7xB/
 0cHgeV5ZgxdoKAdgQwqd6a27YiNNWVV3qVMsJjh20gE7aNaYp/aSY1Er9yDsbc5FlC312XFzcCjJVC
 BaEyhOfctl9Z5SgqQLF7ZYBNHpYjqGciw/mdbxzJ/0g15lKkFbORaX2Of8vL7BnOEqq+T2u5fMWHIt
 Uj1wPvRRsKroRaiWst34CCcyv3nuIp3D/ylAAlfbnOFsRV3uxK+Z0vw4A1smU2tAKWjV4WS+2/7UAH
 ZoSJHJADoqAJtLOn2ySpyRCdkmhyzdan3zplqJA6gSYOVB4cy/SsaeaEtw3pNJTWHN9me6KO6i9mJK
 xjQa0i2nIPnrk8iFpK019lIg5q90Gp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.5-rc1.
- Link to v1: https://lore.kernel.org/r/20230703-pci-imx-regulator-cleanup-v1-1-b6c050ae2bad@kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 27aaa2a6bf39..a18c20085e94 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1040,6 +1040,7 @@ static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
+	.host_deinit = imx6_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230703-pci-imx-regulator-cleanup-a17c8fd15ec5

Best regards,
-- 
Mark Brown <broonie@kernel.org>

