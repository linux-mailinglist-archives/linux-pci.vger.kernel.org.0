Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A571CEE72
	for <lists+linux-pci@lfdr.de>; Tue, 12 May 2020 09:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgELHrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 May 2020 03:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgELHrN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2020 03:47:13 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E144C061A0C;
        Tue, 12 May 2020 00:47:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 4E06F20F0D;
        Tue, 12 May 2020 07:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1589269631; bh=eJnR5u9wxpZzi1TozIj3O/mYN+6KO3jlz58PZP+YVW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbYyrnF3hSjwCtirbdGDp0J4DGKLQ7ysSKyPS362UyOEuwQxvwDSoZ84jzBWqT9Gl
         IDn2YIflZhAldAnNG0RD5p2UOB9XndcAmc5aqLMb4WUP+KDD/vHUZgP09A/53ddyWN
         gOpdmztyzkrLQtrRlMEvGqbUOmbWiNZC0Ovj8nawL1pK3dVCnx22ubhwRzGnT7s6ch
         J2zewRI6vCOCd58Vx44bsXIA9D0xZAPxPzzUhaZ+Ctg87aqVPwt4fsl/iDejmOegSS
         ZBe8RzTnXt5UpYUQpb3JQpfFSlKWhwC3KFscIJgostZeoxOQp2RYJavXngADIX1m2K
         pjahXVDheWarA==
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
Subject: [PATCH v9 1/5] PCI: Don't disable decoding when mmio_always_on is set
Date:   Tue, 12 May 2020 15:43:55 +0800
Message-Id: <20200512074413.3557835-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
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
2.26.2

