Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DBA6C6154
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 09:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjCWIKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 04:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjCWIKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 04:10:18 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C536210269;
        Thu, 23 Mar 2023 01:10:15 -0700 (PDT)
Received: from robin.home.jannau.net (p54accbe8.dip0.t-ipconnect.de [84.172.203.232])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 49A6626F9C9;
        Thu, 23 Mar 2023 09:10:13 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Thu, 23 Mar 2023 09:10:12 +0100
Subject: [PATCH v3] PCI: apple: Set only available ports up
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-apple_pcie_disabled_ports-v3-1-0dfb908f5976@jannau.net>
X-B4-Tracking: v=1; b=H4sIAGMJHGQC/42OwW7DIAxAf6XiPFcxVCPdqf8xVZEBs3iqCAIWd
 ary7yO97dbjs+zn91CVi3BVH4eHKrxKlSV1MG8H5WdKXwwSOis9aDOYwQLlfOMpe+EpSCV34zD
 lpbQKg0cbnaWTNaPq944qgyuU/LwbqNIs8H7UgFMbETWEtq/lwlHuz4TPa+dZalvK77NoxX36y
 vMVAcEZzfGMkSKeL9+UEv0cEze1a1f9sqoXgjcuYAzajnT6p9q27Q96ytgbNQEAAA==
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=j@jannau.net;
 h=from:subject:message-id; bh=0umd/q2E/2yCKUdqoXB1gXPCtNUy4oDYSDsb9V1CGRY=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhhQZzpSnT66o/zmw6Ifa9ZfHKz4u4fTYbv+m+q2ohciM6
 OxAkV1ZHaUsDGIcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACbiVcnI8GG56Gymc/cSl54/
 c7zk/Y+pjsc27OIwzUmddXb/1gbjt82MDG3u1zdMlKroPHrnk9jxZ2L5RfdC94YpWO/NndBYzGu
 0lQEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=1.5 required=5.0 tests=RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Apple SoC devicetrees used to delete unused PCIe ports. Avoid to set
up disabled PCIe ports to keep the previous behaviour. MacOS initialized
also only ports with a known device.

Use for_each_available_child_of_node instead of for_each_child_of_node
which takes the "status" property into account.

Link: https://lore.kernel.org/asahi/20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net/
Link: https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v3:
- dropped Cc: stable
- rewritten commit message since the warning is fixed by 6fffbc7ae137 ("PCI: Honor firmware's
device disabled status")
- Link to v2: https://lore.kernel.org/r/20230307-apple_pcie_disabled_ports-v2-1-c3bd1fd278a4@jannau.net

Changes in v2:
- rewritten commit message with more details and corrections
- collected Marc's "Reviewed-by:"
- Link to v1: https://lore.kernel.org/r/20230307-apple_pcie_disabled_ports-v1-1-b32ef91faf19@jannau.net
---
 drivers/pci/controller/pcie-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 66f37e403a09..f8670a032f7a 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -783,7 +783,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	cfg->priv = pcie;
 	INIT_LIST_HEAD(&pcie->ports);
 
-	for_each_child_of_node(dev->of_node, of_port) {
+	for_each_available_child_of_node(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
 			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);

---
base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
change-id: 20230307-apple_pcie_disabled_ports-0c17fb7a4738

Best regards,
-- 
Janne Grunau <j@jannau.net>

