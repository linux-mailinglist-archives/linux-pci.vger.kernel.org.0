Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89387E43EE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 16:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbjKGPsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 10:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjKGPsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:48:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C91999;
        Tue,  7 Nov 2023 07:47:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD04C433CB;
        Tue,  7 Nov 2023 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372074;
        bh=WtcUiSA5dnfv2VK8lmxzh4gugyNnWTsAs4G6Ahd3Vm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kq44vCINqU9FIKFrqni2LlbpyLpYildaPAydBFkt8QHCH9srpJbn4ESRHDwNvTiJ9
         jHxG/z5MMlMQTY/y+/Zh+R0+qAM7zFf3HOjG7H92Tbz2TgkLcWeU2H2RzzmlM0tbZm
         P/ZKmulqKzHaC3d+yDI8gPWEzT5pzrjY1hAc5oYd6kqlDYqdUWXJlRo7S4WSCOY/ny
         VJrTGU2yhLGpr/rVLypiC4n8hEyQFujgLLb1MghVn1UXVnDHpeaKxpiRFen3kwuV74
         YCIaMzQYIEHTBeJUXPWebYHjVQ9FqNbM7M7VRJEafWeaoS160VSj1FrwAQlWw0LkwB
         YtgxvjozH22GA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 25/36] PCI: Use FIELD_GET() to extract Link Width
Date:   Tue,  7 Nov 2023 10:46:07 -0500
Message-ID: <20231107154654.3765336-25-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit d1f9b39da4a5347150246871325190018cda8cb3 ]

Use FIELD_GET() to extract PCIe Negotiated and Maximum Link Width fields
instead of custom masking and shifting.

Link: https://lore.kernel.org/r/20230919125648.1920-7-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[bhelgaas: drop duplicate include of <linux/bitfield.h>]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-sysfs.c | 5 ++---
 drivers/pci/pci.c       | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d9eede2dbc0e1..5a6241044c3c8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -12,7 +12,7 @@
  * Modeled after usb's driverfs.c
  */
 
-
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
@@ -230,8 +230,7 @@ static ssize_t current_link_width_show(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	return sysfs_emit(buf, "%u\n",
-		(linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT);
+	return sysfs_emit(buf, "%u\n", FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat));
 }
 static DEVICE_ATTR_RO(current_link_width);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5e51e8bd5c13a..ec43ebfc24a5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6260,8 +6260,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 
 		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
-		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
-			PCI_EXP_LNKSTA_NLW_SHIFT;
+		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
 
 		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
 
@@ -6333,7 +6332,7 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 	if (lnkcap)
-		return (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+		return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
 
 	return PCIE_LNK_WIDTH_UNKNOWN;
 }
-- 
2.42.0

