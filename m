Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CB53D6BF5
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 04:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhG0Btr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 21:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhG0Btr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jul 2021 21:49:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D44FC061757;
        Mon, 26 Jul 2021 19:30:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b1-20020a17090a8001b029017700de3903so1638652pjn.1;
        Mon, 26 Jul 2021 19:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lClEageFRMCE8DUCewTHpIp65fpquDBhSKpdSUstzo=;
        b=bg/xZcytHhyJAAAM+Y6wTFw75X9e3K/l4J7WSxzajW9Xf1t9oLSe2DdtbNvzrrX9ZK
         L5Zv38zXyHQ+v1bQhhRtvwX1v4LRlKxTl5AfUX+kokKSsj4tsRqCSX7vVmQg4kL/3EjJ
         NGWSzi10GGBGfGEFoh8v90GahoGiOFGetABXggcAGBkZu3UIafEWqQD6pvVhuzXPyxG2
         Nd8gsM/yy4ototik7+u8kXUf5B3x+1ECTEoWecXrQiI1XuI58XpO9ffaD9GxW/8a3Fsa
         b0AvQdigSlYWyv3xGkVcKeSxzVkMoAyfpevjAj5Hmyw56shyKiiHwbp21OynbI+i54WX
         SJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lClEageFRMCE8DUCewTHpIp65fpquDBhSKpdSUstzo=;
        b=Bfho4AqcWqbMxs59g83/DcrDXxGDi1AlHNKCpx1veud7L0ewaK6eW3aTdUQF4AeiY2
         Dsqu/2PVQRe36rTRxuWnL2FxzxLJiR3MyldgyQVWKHwPfLblMNb4+YxvLeihy7dBAMCo
         sF6u81a1S5pYVS8GyOs85BOVkweYDpRZTqwWzgkB3PyNC7iGRPsMfw36kkm/PojzyheR
         3HHGcXIAfWE8By8mvlj8sU9LwuGbnc6udLcXkdodrVPXTd+W40AyfL2sUQjbP0oxwY0/
         eYUACI8vQWPTG8T4E3ynC5bajrKaZPTwPEHjSVT5OOwTuOuqrebXm8xHYreF+6BRmOl+
         kMIQ==
X-Gm-Message-State: AOAM532ydjyWsb9gY/c6V71Mh931Ouvi10vySGSw88LSs5fQfKQoF1ks
        y/fubBgSaf/6HEvuJ5YqbVU=
X-Google-Smtp-Source: ABdhPJzMeiVSuP/fXcXTTi1mHCsB1uniJXVmTS2VzGmikhuzE9YBcg5doqw1QtwWm6hxSBF4VJtR+A==
X-Received: by 2002:aa7:8b4c:0:b029:314:5619:d317 with SMTP id i12-20020aa78b4c0000b02903145619d317mr20941089pfd.60.1627353013642;
        Mon, 26 Jul 2021 19:30:13 -0700 (PDT)
Received: from localhost.localdomain (104.194.74.249.16clouds.com. [104.194.74.249])
        by smtp.gmail.com with ESMTPSA id r29sm1414076pfq.102.2021.07.26.19.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 19:30:13 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     yue.wang@Amlogic.com, khilman@baylibre.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        jbrunet@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2] PCI: DWC: meson: add 256 bytes MRRS quirk
Date:   Tue, 27 Jul 2021 10:30:00 +0800
Message-Id: <20210727023000.1030525-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

256 bytes maximum read request size. They can't handle
anything larger than this. So force this limit on
any devices attached under these ports.

Come-from: https://lkml.org/lkml/2021/6/18/160
Come-from: https://lkml.org/lkml/2021/6/19/19

It only affects PCIe in P2P, in non-P2P is will certainly affect
transfers on the internal SoC/Processor/Chip internal bus/fabric.

These quirks are currently implemented in the
controller driver and only applies when the controller has been probed
and to each endpoint detected on this particular controller.

Continue having separate quirks for each controller if the core
isn't the right place to handle MPS/MRRS.

>> Neil

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 686ded034..1498950de 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -466,6 +466,37 @@ static int meson_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void meson_mrrs_limit_quirk(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	int mrrs, mrrs_limit = 256;
+	static const struct pci_device_id bridge_devids[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3) },
+		{ 0, },
+	};
+
+	/* look for the matching bridge */
+	while (!pci_is_root_bus(bus)) {
+		/*
+		 * 256 bytes maximum read request size. They can't handle
+		 * anything larger than this. So force this limit on
+		 * any devices attached under these ports.
+		 */
+		if (!pci_match_id(bridge_devids, bus->self)) {
+			bus = bus->parent;
+			continue;
+		}
+
+		mrrs = pcie_get_readrq(dev);
+		if (mrrs > mrrs_limit) {
+			pci_info(dev, "limiting MRRS %d to %d\n", mrrs, mrrs_limit);
+			pcie_set_readrq(dev, mrrs_limit);
+		}
+		break;
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_mrrs_limit_quirk);
+
 static const struct of_device_id meson_pcie_of_match[] = {
 	{
 		.compatible = "amlogic,axg-pcie",
-- 
2.25.1

