Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8349B769550
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjGaLzK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 07:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGaLzK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 07:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39391A3;
        Mon, 31 Jul 2023 04:55:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74B796104B;
        Mon, 31 Jul 2023 11:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018F9C433C8;
        Mon, 31 Jul 2023 11:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690804507;
        bh=OiQLH0Ur4QsXIAElfzydLwPQ911lsGirTGBgpfbRwNo=;
        h=From:Date:Subject:To:Cc:From;
        b=Gp8L3cIX/YchDpHcrZzplSGCO8NXaBnSbRvUxa3GZznPnFhCRO5PRqKIzdfMcsafl
         0ssi9FO0gguKNjm0m1avf5B+hwol66ttDYEOKY9MshYsPb+lNhHaTAxniHyAFo+76l
         U4YZcunUoaFQterr8PMZbezMfOJvRZwelQpd+WU2sa96EkWfZsaMh+gkiRp/pEx7eS
         dg4ZfQOHvguQz7PY/mV1JwRRRWy1UYxlEq9OBumUz+m0B1i0HGAUG3bfsNIIbqeHkv
         DeD20tiKBAJGkSVSoDIYGeJ/JGMI0MFdhWzhl/7Sjgug/bHUeiuylQ6s1qVXP2ijtT
         4U7UbQN4g1eDA==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 31 Jul 2023 12:55:01 +0100
Subject: [PATCH RESEND v2] PCI: dwc: Provide deinit callback for i.MX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-pci-imx-regulator-cleanup-v2-1-fc8fa5c9893d@kernel.org>
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
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBkx6EXdxRz1dTT/OShq0p+bzBjHKJQarXXyyX7DZCP
 xpUHn0OJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMehFwAKCRAk1otyXVSH0Jz6B/
 j7M6pqTOungd9oa6NmOq9Ps6fa/WLCmxbVm2DutkAeWjfVtQm6MWoFNnSceaavenIn8HH/DgjResM0
 nQZ+NlYhtGiHe+c1aN5TNFF9iQD9/CvMXCCdTdLLIOEiiVrhHdrAYbZWg5ehxOK9GfX1kkWjkAufiX
 2f/PsZtlkEuC2p4EAu6IKnWBVEx2PCLyhVa7jA91NUunHp7N7x75M1K+7FojQN77eVH2H57Tx4XaO2
 ooNhdHd+eD0HuP1DZ4NmtDJaHZcb+JhjzYMO8ONSTDOY686nUxQ0zlHSYmAd4NbRBRADsxpeNUUvY4
 E12cGp1MIDUKg37LH2H6omLcwUOLQ=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

