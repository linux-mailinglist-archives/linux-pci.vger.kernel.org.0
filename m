Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D029E452
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 08:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgJ2Hha (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 03:37:30 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11927 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgJ2Hh2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 03:37:28 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9a50be0001>; Wed, 28 Oct 2020 22:18:54 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 05:18:46 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 29 Oct 2020 05:18:42 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 0/4] Enhancements to Tegra194 PCIe driver
Date:   Thu, 29 Oct 2020 10:48:35 +0530
Message-ID: <20201029051839.11245-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603948734; bh=RFj9prVj4gRc7xq8//qO2rhJicqL3FLhfGNno+ny5Mk=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=D7EE5FFZmX0LvvaVvOgyBC43rQ0PwyY51ZrazoleH2lkeGPvpexwJQIl3Btm6V++B
         Y+vM4w6csIXsev1PwLRUx+upe7AX1MRMRzEpURpbvA3HNvmtr92vLsQonEf3aQx2AF
         /1EI4I7p65+phxjj/VVRlCS+VP3Kq4olhDzNVZa8vmkef+P4aSRR0vllUE9p4iLJqd
         8BryOfuE1RT7xErISWOiUgKhJfohsw92ZFBbguKiMiDljfSTioPA7SL4ZgktOApGdp
         Ys+iRivO6L044MYNKQ8skZ8mSXU2acXKY1gZL6lz14tpTBHpRirsHoppWcRu3ERcqy
         s/Ak+9GT9TDvw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches do some enhancements and some bug fixes to the
Tegra194 PCIe platform driver like
- Fixing Vendor-ID corruption
- Mapping DBI space correctly
- Updating DWC IP version
- Handling error conditions properly

V2;
* Addressed Rob's comments. Changed 'Strongly Ordered' to 'nGnRnE'

Vidya Sagar (4):
  PCI: tegra: Fix ASPM-L1SS advertisement disable code
  PCI: tegra: Map configuration space as nGnRnE
  PCI: tegra: Set DesignWare IP version
  PCI: tegra: Handle error conditions properly

 drivers/pci/controller/dwc/pcie-tegra194.c | 62 +++++++++++-----------
 1 file changed, 30 insertions(+), 32 deletions(-)

-- 
2.17.1

