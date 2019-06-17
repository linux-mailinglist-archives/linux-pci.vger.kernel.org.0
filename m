Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5948A56
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfFQRkE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:40:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10836 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRkD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:40:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0720002>; Mon, 17 Jun 2019 10:40:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:40:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 10:40:02 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:40:02 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:39:59 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 01/27] soc/tegra: pmc: Export tegra_powergate_power_on()
Date:   Mon, 17 Jun 2019 23:09:26 +0530
Message-ID: <20190617173952.29363-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793202; bh=rr4xEqoqqI76YW01sv+ca9Ph0DZyDxqrToEtCmFUOfY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=GjgbsS7FtvU/GvgBzDEod+rfOwYATopVqqXkoMAwiQZFPUapzSyZ909Bf8D0FDShR
         YobSfrw6R2pCRkk7fLeqrx1jfpW5eqjWO/1c0cqIjfG9l7m8X0QlHKTyd/qwfE+8ef
         h2z4S6CnHzlq/ffdMELImWxJXimA437mVLExOQb019f9tURyiFov9wO3yPprf6HsI9
         vI+05unPBFJkXjCWH8VuNr9ORNThHUCv2y3XtH751CUGUGsTaVwox9YetnWSNczTVt
         j0SBYf1HvdXfKoJbAsUXdl2wFSqyh1uLCpiyAOvLYUJZ7DGfxwNDeUcjXpLh5H+k25
         kQyw6TY+uFr+w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tegra_powergate_sequence_power_up() powers up partition and also enables
clock & reset. However, if a controller like PCIe have multiple clocks
& resets and they need to be enabled in a sequence, driver must use
standalone function tegra_powergate_power_on() to power up partition.

Export tegra_powergate_power_on() to allow Tegra controller drivers to
unpower gate partition independent to clock & reset.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V5: No change

V4: No change

V3: No change

V2: No change

 drivers/soc/tegra/pmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 0c5f79528e5f..cb3de81348bd 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -701,6 +701,7 @@ int tegra_powergate_power_on(unsigned int id)
 
 	return tegra_powergate_set(pmc, id, true);
 }
+EXPORT_SYMBOL(tegra_powergate_power_on);
 
 /**
  * tegra_powergate_power_off() - power off partition
-- 
2.17.1

