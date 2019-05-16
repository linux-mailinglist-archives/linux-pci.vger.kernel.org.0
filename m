Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB01FEE9
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfEPFxT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:53:19 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8888 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFxT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:53:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfad50000>; Wed, 15 May 2019 22:53:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:53:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:53:18 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:18 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:17 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:53:14 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 01/28] soc/tegra: pmc: Export tegra_powergate_power_on()
Date:   Thu, 16 May 2019 11:22:40 +0530
Message-ID: <20190516055307.25737-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986005; bh=6APKzMSZRpzI1awpaf9edpQ8Rcrz4hkmGWWPwPTktdk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=dw6mLKUDSa74uIQTQZVvY4ugHeJHQW209hnP6Jt/c8eAtQgNnDNuBlZV5AeEJpdK5
         iEhN6gfYYEL1RI9xtzEqfxW5esMtRf2wPukPhPq/n/jZW57xej0wZCRKhTfHcWymkw
         4CZ10hQe5oCryA7+IUo75RZ94SRYK2Z7BunNUTRx+zlmsXzOtUpQ77Fb0TWR+FcDvs
         ZUZWY++h9YnUFMVefAFG8UY1cnsSJuy19EOSsNwBlsTRm04078j0waysaa+3Gg5XaM
         GCtDwwusAutrzP4HC3t2ym18oLivvPsF5QgOric/0T9r4ADpiHP5npywM79s+V8BC9
         Mx8G0376A8qVw==
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

