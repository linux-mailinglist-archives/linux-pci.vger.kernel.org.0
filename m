Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F262B7FBC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 15:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgKROqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 09:46:42 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5344 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgKROqm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 09:46:42 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb533c80000>; Wed, 18 Nov 2020 06:46:32 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 14:46:39 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Nov 2020 14:46:35 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 1/2] PCI: of: Warn if non-prefetchable memory aperture size is > 32-bit
Date:   Wed, 18 Nov 2020 20:16:25 +0530
Message-ID: <20201118144626.32189-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201118144626.32189-1-vidyas@nvidia.com>
References: <20201118144626.32189-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605710792; bh=ePpcn4keTqHeYJe7Bo2sIdBFTSQVj6QSpdB6WzWqwI4=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=ZMQQFi23Nxd2MCMeTWa3zs2UduEDQO+QiUJGFZbekcAnsvNJguigdLIpgBTSO9zV0
         HnAzf8ntV1j0HOIwQ0XlbXKvMdvxxQMODo7VlQ1BUXaDMb5rAauyd9avrJSmr/WnWX
         AbWTwxQZWh3knPxW3YJ3hJUVdudoWjcc29WgPObfhf7XMiAFn78gxkhCUCUtIJOUN9
         sdBwdXeisQev/iSkuO4HAYzF0dYm5uVCkbSLwWiVpYnK8XgCYups7LHtPbGZVautcD
         7SS2fn+MaRBBcJsRIKR4EqQ4pPTgnXQHlECcoaGRnvCVZ5f5GMve//yrG1OsHDp9je
         /dW+QFjIuR/tQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per PCIe spec r5.0, sec 7.5.1.3.8 only 32-bit BAR registers are defined
for non-prefetchable memory and hence a warning should be reported when
the size of them go beyond 32-bits.

Tested-by: Thierry Reding <treding@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V2:
* Added 'Tested-by' and 'Reviewed-by'

 drivers/pci/of.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index ac24cd5439a9..5ea472ae22ac 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -556,6 +556,11 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 			break;
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
+
+			if (!(res->flags & IORESOURCE_PREFETCH))
+				if (upper_32_bits(resource_size(res)))
+					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
+
 			break;
 		}
 	}
-- 
2.17.1

