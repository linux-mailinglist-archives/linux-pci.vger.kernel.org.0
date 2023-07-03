Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F157460B6
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGCQaQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 12:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCQaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 12:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6A190;
        Mon,  3 Jul 2023 09:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 485B760F7B;
        Mon,  3 Jul 2023 16:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916BAC433C7;
        Mon,  3 Jul 2023 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688401809;
        bh=8ZJywgN7zX7HPIQiniWG85bY3ojzDG5dLyrGXUsgDdE=;
        h=From:Date:Subject:To:Cc:From;
        b=bBPtlmYXEp+MmXj+TTq77bJFmzgUBr1/B+iXmcLdcb5xZ9/a1Mv2J0O0bN+hw7UwR
         kcwAQcGEXSfAt/6jbyHy2OXep4xO9aKChH1y12pGV+Sg1Hv/sA3SE9rIc8zXOCBVX2
         xzlPvYpGbjcJQ65OH/AMChnqdjWZLxy6VD1ovIQ7DAuYF3PiJDpzihWq79X7PqXKeK
         RL2OA6+4nh3ZALka3w0A5oxCwnFwXel1vs6KPGr7tY12LEYdfUcjojKBnUnLjYQyAW
         hHQc8CjG3hVzgTr8guGm28TB1w8d7FuGjd3GP9QBfJjjmJzQIdGHXSC7WU57lqDy4x
         c84iIS4ulRtUw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 03 Jul 2023 17:23:09 +0100
Subject: [PATCH] PCI: dwc: Provide deinit callback for i.MX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230703-pci-imx-regulator-cleanup-v1-1-b6c050ae2bad@kernel.org>
X-B4-Tracking: v=1; b=H4sIAO31omQC/x2N0QqDMAxFf0XyvECriGO/MvYQY9Qw15Z0boL47
 6t7PBfOPTtkMZUMt2oHk49mjaGAv1TAM4VJUIfCULu6cZ1rMLGivjY0mdaF3tGQF6GwJiTf8XU
 cfCvcQvF7yoK9UeD5fPhGe55zMhl1+yfvj+P4AXxsmEWCAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8ZJywgN7zX7HPIQiniWG85bY3ojzDG5dLyrGXUsgDdE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkoveMNRJ5ZaJVV2xDxJg/bNmgjsnBBv0SXgdm9jjz
 L1k3vY6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZKL3jAAKCRAk1otyXVSH0AWyB/
 0SUGEefHTTN8YS90X8Fn/ghC+xZkL23oIxw85nsyJ2dZgPwb1Txh3vHr/WSqrKMJhRrE7xcP5zCE/z
 4Td/4VUtE8jFfpmbqiM9ZNYtpW1SjBasiwNqkvZbgd+Fd82VA9jO2ZyvR17oT01q8xJX+d1qCpW5If
 2X5E9QpMGVkBbWwkhhwCe6+PK9rOalVWUNrs+ED7OeQ4PNKwAH3WccpauzRje5xx8xuLm5eU5ay5KC
 RcQxZ+BMMee90Qh35J79LRXvcaVk2oa7GILyGHx6HeuFtHLtddCnsRydvk+XPn+Ta/Ph4NdkGpgwCh
 dN9a4/iM7ZOUogL29hhzTT4xHYqVDb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 52906f999f2b..e4942bd2598d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1039,6 +1039,7 @@ static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
+	.host_deinit = imx6_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {

---
base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
change-id: 20230703-pci-imx-regulator-cleanup-a17c8fd15ec5

Best regards,
-- 
Mark Brown <broonie@kernel.org>

