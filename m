Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2666B2B80
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 18:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCIRDY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 12:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCIRCr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 12:02:47 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D5ADBB59;
        Thu,  9 Mar 2023 08:57:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678380992; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Urcr1g8b7Xuzokx6dlPrgXfCTOjIv2+ITDDy5Gb41ZQG2ha1JQYcwRG93x2cQ8beAe
    QH3JGZbR/lnlDob23t925D4Rvea75E4mFVzL7bgBOuK4NGWEw4Xg9FIYMK0AYIunBjF9
    ZTQscOyw2YijPx1/OgOdVs9IK3OpFn1ZcGvHzfC/JIfeAjgnL+ro8KtqA3cX+VRLFYvQ
    H29DoHtdywXd8u4dCb0uf50j5amaC9e3kIL2FGyWk0xQU1ikvS7K0d72FveLZb2I1bKI
    t6CWNtLeIWFw6+rVxypHcTbsbIa7GpCFmIUN58cEkSLcOYH2AV9y6YvHrb0HwzQ3sA0p
    +roQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1678380992;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=wHpk4aIfXvwZ9L9eYQkKUD5TX9p8N/0ABhLYcRfGxXU=;
    b=cJdK6kzAnjm/r4GZRpV17dOIhnnZa8tnA7cMenQAk4Is6xmwl8wsuDXSIi+3tbuXxz
    mI8l39vc3+wKiShC8aX5uCJrtFGfniiNh8PiWN642TmK3ozMgh1Z7j9Qo4WJYuqzQTTz
    zDbxKN650svUkkx0SSUQrsHlaz13adsRNZou4C3TZcGFju41K920jbeKjdDqKhPrxekB
    wB6u2YBPjVLqnlt3oSwee3M30YhQ+QJE44POa+TcZIzJjoFazTqfSydhEYU+6yKT7TuK
    tiTG7lE7KPYfl3420g7AdkGfPR985ZP8Q0Zo1ii2xu9Sm1rbto+0EtyWIRF8T4WgbHu9
    SY0A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1678380992;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=wHpk4aIfXvwZ9L9eYQkKUD5TX9p8N/0ABhLYcRfGxXU=;
    b=cw0tAsyD9VgZpZmtbT5TXzmlEK+/TtENmVTOWt47tbAsKCa6gCvlKGo7pyl15vXQQg
    zxdTNQ//B+7fcDwHOc9UUONbY7jeZgu8mdfeqyoyJKM+/AYXCAICMJlD7ZpcO09EgPcL
    RQp57FLqQGOTq+V5lv6yuZMbNluwwSaI7rEWFFC4nFg+q2+yxFCJgovpPL05iyZofOqS
    Tv2h7F/ozx3bmvIsN/ekMIYIOfaPE/fFWDFD5mheZrfB1MW9SgMOkESC6xxcBxjOsoF+
    Mtu8mUOgKg2GKzd8EqNHzB11+2xaEeMhyXiiLvB4JLhcdpXPSR3XNFRbOAdTf7yS74NF
    MoJA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1iTDUhfN4hi3qVZrWzJ"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id 2faf7dz29GuWbnB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 9 Mar 2023 17:56:32 +0100 (CET)
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
Subject: [PATCH v2] PCI: imx6: install the fault handler only if we are really running on a compatible device
Date:   Thu,  9 Mar 2023 17:56:31 +0100
Message-Id: <e1bcfc3078c82b53aa9b78077a89955abe4ea009.1678380991.git.hns@goldelico.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes since v1:
    
    - replace of_find_matching_node_and_match() by of_find_matching_node()
      (suggested by Bjorn Helgaas <helgaas@kernel.org>)
    
    - v1 was Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>

 drivers/pci/controller/dwc/pci-imx6.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 55a0405b921d6..52906f999f2bb 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1566,6 +1566,13 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
 static int __init imx6_pcie_init(void)
 {
 #ifdef CONFIG_ARM
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, imx6_pcie_of_match);
+	if (!np)
+		return -ENODEV;
+	of_node_put(np);
+
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
-- 
2.38.1

