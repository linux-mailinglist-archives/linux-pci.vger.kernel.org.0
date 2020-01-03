Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0866612F68B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 11:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgACKHx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 05:07:53 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9099 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgACKHw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 05:07:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0f12680000>; Fri, 03 Jan 2020 02:07:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 02:07:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 02:07:51 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 10:07:51 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 10:07:51 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0f12720058>; Fri, 03 Jan 2020 02:07:50 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 1/5] PCI: endpoint: Add core init notifying feature
Date:   Fri, 3 Jan 2020 15:37:32 +0530
Message-ID: <20200103100736.27627-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103100736.27627-1-vidyas@nvidia.com>
References: <20200103100736.27627-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578046056; bh=ZGS66YvIi/B+9woRlbOt3YnbjLoJjEyLMauJaqifX90=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=I8wE0jskqTddrVj4uYAJ0Qpjj1lPU4AAe6VrirwQPtwO3DwEk+O2vq9O9sKr8mfP8
         4SUEEFY1DqwB99Ies9m2G571NkSJeX1c7iytlPwucwYngb0nXAZPVW/XaAWx7csSmo
         A/IRTOTEm8iR5AqRHvT5o8ST5VQSHReDMJcuYmxRvIIr/jY0wbIVFGoGm8jEPuTZJT
         xU6rMMNzHdI94s1y2H+4/88807z7WDtSECAIDL43izWdpBBYurafYBjV2Lpl2/S4zh
         SjaZoM+HQumESF1/GWSAMhA7mDPRD05rQeyBuamcEOGwbHBAvFpE+Lc7xi1hl/z41g
         UnFa7uInhOXbw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new feature core_init_notifier for cores that can notify about
their availability for initialization (Ex:- Tegra194).

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* This is a new patch in this series

 include/linux/pci-epc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 36644ccd32ac..ec8d4d896564 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -115,6 +115,7 @@ struct pci_epc {
  */
 struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
+	unsigned int	core_init_notifier : 1;
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
 	u8	reserved_bar;
-- 
2.17.1

