Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083CC1B7686
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 15:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgDXNKI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 09:10:08 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:59560 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgDXNKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 09:10:07 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 89E0B2049C;
        Fri, 24 Apr 2020 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587733794; bh=NE5sCt6ssdL9diqa/uHtsH6X8dScz66rvMdDwvKjb94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQdNKTrq4hjEUOjpAq+0bEdnMwI1+HBwBGmevMxwByx2FC/iK9/SrbXpOgdTPmQ+j
         wwsp6tGx+i0ALTtwb8pidNshvb+4iGxVghtPBKFviUxhtikbqUIskPCflMcWhEfLNB
         IxlOr4Ix2GO6UW/nVAyCoYusaCIAVztUyQiHBs0d7Z63QXv6IvGPUmrGbSGj8ps/V9
         iVQ0y5IpC6CX7M4kywqE8j2lUWm0QnX6DoHmGR7NUD702Vo2KOM3RYdv5bDQQU5jx8
         oyyjCcAQGtPGzd2nxVGl/QNcEUBMfV8Nm6zRwWuUynrsZzXtaIXCJwGzJ6b2cD0w8K
         OAJCyA0d10zOg==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v5 2/6] PCI: Don't disable decoding when mmio_always_on is set
Date:   Fri, 24 Apr 2020 21:08:33 +0800
Message-Id: <20200424130847.328584-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200424130847.328584-1-jiaxun.yang@flygoat.com>
References: <20200424130847.328584-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't disable MEM/IO decoing when a device have both non_compliant_bars
and mmio_always_on.

That would allow us quirk devices with junk in BARs but can't disable
their decoding.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
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
2.26.0.rc2

