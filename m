Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417B46A54B0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 09:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjB1IsP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 03:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjB1Irq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 03:47:46 -0500
X-Greylist: delayed 84 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Feb 2023 00:46:57 PST
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208BAE384;
        Tue, 28 Feb 2023 00:46:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677573839; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rOKZ7uBdwo9kpAIdNPYWTbYHefAzEZqlUWZRLguaN7uns1UccaGIoj3GplAnjp/74p
    Pf62+PlxRaCbPyM+fFispC5cxJqVpdfKLQ7a43+LEQW4i9L+2p9uglhZ/XH4ckQA9Ks9
    /ACVaupsE2+Hc0UlqFeABliH6yCJvjgnVmC2ZXnTIdB/hLCupxVDjmKIEeEjNqPOczuz
    b2bwgl+x2ZRM1D30nBR07iF85BZOfcDaMQTgPcshtaweL/39hIhcAFjEl8E0CmDzscG/
    we83p9ajoXHDKTgmQkODmTZ3Zo/vwsjr1qm1mKma8uiHpcdh7JcZ/LrUTQAsawVAxeBX
    Sleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1677573839;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=+UOfEgqD4oRECTcBuUsff3LMCbW6CRcg0WZi4nlmdjY=;
    b=hVF4rS/JTgW6RdRiLEt9JLl84hg3WvsRe8OENPW0oVwovL5qYDzu16Pqds0ibMdFfY
    OmKHIKhB28cKXl/lnYZtr5SzN7jWiIbqQdGAJlhBqxVqoIna15ipAHrFKOCtyy8TSNLa
    22u5zRggv1xrQyXmBJ8BRK02EkoiDC/hdSyLqiFns1NEPNWAgVxFdw5x55iydt2c6VdF
    PNDcPi8DJbX36xuVS9WIdnG8pYr0HuKhe1Rs6iaVYKN8xRTOp9+RYu+3NMrrdjX7fxHG
    A8/v/aySHyMmEc8BE/w8v4LCC6sehSEXaknMaGmwHYGPuhQ81pBEKFsDTWWx6xW7dCQ7
    kpuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1677573839;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=+UOfEgqD4oRECTcBuUsff3LMCbW6CRcg0WZi4nlmdjY=;
    b=ZMvzHtkkoGoX5RBqQb3PCk8sE3XFgErKKNaK0Euk60E8jBJASOrSO3SwrO8icbpZ1q
    Rn7KOTq3ui9U/EgvRDQsP5dwkFWp3QOY+RoAIQGdfQMpJ+A44qERdxGifM6Pd5o5yDVD
    gaKj1jUMoIRsXgrCbpEzD7xmSKyM4ltAPbXHPAVtLRF0LxUDsHCLRwPykTM+Pn+2yQ5Y
    l83Pp9IAu5LsyC9kQS0GXW0eUDXdtpdj5r7ngLuv2VQAHPKewBmVzeSJdYnfxtf7Cra5
    qjjrfaijARwvVb1Uk2uXS8hWBoY68RfNANcD1hN5Km5jRNpl+Oe9MygRxNjEKOdx8Sit
    pgWA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1iTDUhfN4hi3qVZrW/J"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id 326d57z1S8htRev
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 28 Feb 2023 09:43:55 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] PCI: imx6: install the fault handler only if we are really running on a compatible device
Date:   Tue, 28 Feb 2023 09:43:54 +0100
Message-Id: <aa1c18c70bea1d6f99c88027dc72c700e8c309a2.1677573834.git.hns@goldelico.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit bb38919ec56e ("PCI: imx6: Add support for i.MX6 PCIe controller")
added a fault hook to this driver in the probe function. So it was only
installed if needed.

commit bde4a5a00e76 ("PCI: imx6: Allow probe deferral by reset GPIO")
moved it from probe to driver init which installs the hook unconditionally
as soon as the driver is compiled into a kernel.

When this driver is compiled as a module, the hook is not registered
until after the driver has been matched with a .compatible and
loaded.

commit 415b6185c541 ("PCI: imx6: Fix config read timeout handling")
extended the fault handling code.

commit 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
added some protection for non-ARM architectures, but this does not
protect non-i.MX ARM architectures.

Since fault handlers can be triggered on any architecture for different
reasons, there is no guarantee that they will be triggered only for the
assumed situation, leading to improper error handling (i.MX6-specific
imx6q_pcie_abort_handler) on foreign systems.

I had seen strange L3 imprecise external abort messages several times on
OMAP4 and OMAP5 devices and couldn't make sense of them until I realized
they were related to this unused imx6q driver because I had
CONFIG_PCI_IMX6=y.

Note that CONFIG_PCI_IMX6=y is useful for kernel binaries that are designed
to run on different ARM SoC and be differentiated only by device tree
binaries. So turning off CONFIG_PCI_IMX6 is not a solution.

Therefore we check the compatible in the init function before registering
the fault handler.

Fixes: bde4a5a00e76 ("PCI: imx6: Allow probe deferral by reset GPIO")
Fixes: 415b6185c541 ("PCI: imx6: Fix config read timeout handling")
Fixes: 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1dde5c579edc8..89774aa187ae8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1402,6 +1402,15 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
 static int __init imx6_pcie_init(void)
 {
 #ifdef CONFIG_ARM
+	const struct of_device_id *reboot_id;
+	struct device_node *np;
+
+	np = of_find_matching_node_and_match(NULL, imx6_pcie_of_match,
+					     &reboot_id);
+	if (!np)
+		return -ENODEV;
+	of_node_put(np);
+
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
-- 
2.38.1

