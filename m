Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF9D4A904
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfFRSCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:02:20 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8292 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfFRSCT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:02:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d09272a0000>; Tue, 18 Jun 2019 11:02:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:02:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Jun 2019 11:02:18 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:02:18 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:02:15 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 01/27] soc/tegra: pmc: Export tegra_powergate_power_on()
Date:   Tue, 18 Jun 2019 23:31:40 +0530
Message-ID: <20190618180206.4908-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880938; bh=xtLHSEdQwl/76q/3Bc+wyzd8dixzZ95V0/kAnCbp/bo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bokVhSD663sIC/TuM+UkuP3bJUxkMk+9hl0W5up2mNpRJrsASMaR0/VBSu/UE5pET
         /s8rdl1ZREw5atDjP4n0sML5z5rfMFBxwqxQ+HGiWDSWuNrTXK7pvdvrRQYXKYDzq2
         LVVbd/o08i547uxeOZObfmWREwB38rS9rwve6wtcHWyWUqgtiWfOsuzyJ1iD70b7SD
         lqC2bCcGLxcy8wNyXnUGYIG109U0Rce9zb4xoiRxL3TU8QAtyW0VmHEWz2ZFc5RWqU
         hETkjW8BOhSjn1mGXhWWVSnsBAcKm8ZkRJymoiuv9ow+nCGTd/IPBzQow2EtyqgXQB
         sz8vozMnzk4aA==
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
V6: No change

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

