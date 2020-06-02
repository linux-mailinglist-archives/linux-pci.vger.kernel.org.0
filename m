Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD081EB935
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 12:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgFBKKX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 06:10:23 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1496 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFBKJv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 06:09:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed6250e0001>; Tue, 02 Jun 2020 03:08:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Jun 2020 03:09:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Jun 2020 03:09:50 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Jun
 2020 10:09:49 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 2 Jun 2020 10:09:49 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ed625690000>; Tue, 02 Jun 2020 03:09:48 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 0/2] PCI: dwc: Add support to handle prefetchable memory separately
Date:   Tue, 2 Jun 2020 15:39:38 +0530
Message-ID: <20200602100940.10575-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591092494; bh=1uGn02QKaOXJYVBhwuDHd/6FbkjwMiXrYVwOxseNzTk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=hyNPaTpUhys+jzxBMTZGgyl2EnY+0o8pMtHpek97IEbLD0mCOohZsQAesYVbw6s6f
         pbWQ0yhJWElOKDV7Oy6QKZTUP/uZ4i+cTKnqlnCDc/mBQN/i3Uqk6nsBT+63On9Nh3
         wIlKJ9sZ7jrhT1tbVkCi8IdsqyDnSY9H4uyvm+vxPDfR3qG2kOGqdBz+ZeGQ6+btRI
         adGWhKXMc8sGSQ3bfWOgoQhFWjZwfw1PgneB64YH2yESUr49heinCpBlzgb4n5eLU2
         VotG6UN3bA5a0zTeGrxSTUataby/aF3+fpsMcWcD0x7+yoYxaHJlq7YagcacW67tSo
         UA/reLv1yp0fw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In this patch series,
Patch-1
adds required infrastructure to deal with prefetchable memory region
information coming from 'ranges' property of the respective device-tree node
separately from non-prefetchable memory region information.
Patch-2
Adds support to use ATU region-3 for establishing the mapping between CPU
addresses and PCIe bus addresses.
It also changes the logic to determine whether mapping is required or not by
checking both CPU address and PCIe bus address for both prefetchable and
non-prefetchable regions. If the addresses are same, then, it is understood
that 1:1 mapping is in place and there is no need to setup ATU mapping
whereas if the addresses are not the same, then, there is a need to setup ATU
mapping. This is certainly true for Tegra194 and what I heard from our HW
engineers is that it should generally be true for any DWC based implementation
also.
Hence, I request Synopsys folks (Jingoo Han & Gustavo Pimentel ??) to confirm
the same so that this particular patch won't cause any regressions for other
DWC based platforms.

Vidya Sagar (2):
  PCI: dwc: Add support to handle prefetchable memory separately
  PCI: dwc: Use ATU region to map prefetchable memory region

 .../pci/controller/dwc/pcie-designware-host.c | 46 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.c  |  6 ++-
 drivers/pci/controller/dwc/pcie-designware.h  |  8 +++-
 3 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.17.1

