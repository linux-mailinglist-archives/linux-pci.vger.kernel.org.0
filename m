Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989E11E1E51
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgEZJWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgEZJWP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 05:22:15 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E24EC03E97E;
        Tue, 26 May 2020 02:22:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 7981C20CF1;
        Tue, 26 May 2020 09:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590484934; bh=UMhG/by/8Wp7J9w58d3h4mj/vGWz5v4HoSv8qq/dykU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFBIc/55J+5liL658ygPg/B+HR9bn0Kw47dumVpAwHjlZPsphCF7f72YeMATKVYGE
         U3XJMDkQX/JelWxEJCauNEG6+PY9jd0hOGK5U3+Mc2zxo7J8KUJ0sSgbP5ob4Uep0N
         8n3k8tNqdPFFmxwE7R4HQpIkCwqKWrc1qqBKNYS3qAUgepLl3NNG9xwvzwHP6bk3R9
         KIn/Qe5L/uWil1AIKl3Td+NIGGGQ0U66o3fNZO8cPCB7LtDd2rixF5rI+kB3CV5NMw
         bdExZf/NlXrQh/U2kK5KxACxCZ+1wxtjyyjKbokMOmXnzmlCOyzoO3lyYT0VS/n27Z
         wsvN1dV2gXM1Q==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v11 1/5] PCI: Don't disable decoding when mmio_always_on is set
Date:   Tue, 26 May 2020 17:21:12 +0800
Message-Id: <20200526092130.145550-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200526092130.145550-1-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200526092130.145550-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't disable MEM/IO decoding when a device have both non_compliant_bars
and mmio_always_on.

That would allow us quirk devices with junk in BARs but can't disable
their decoding.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Acked-by: Bjorn Helgaas <helgaas@kernel.org>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 77b8a145c39b..d9c2c3301a8a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1822,7 +1822,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Device class may be changed after fixup */
 	class = dev->class >> 8;
 
-	if (dev->non_compliant_bars) {
+	if (dev->non_compliant_bars && !dev->mmio_always_on) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
 			pci_info(dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
-- 
2.27.0.rc0

