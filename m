Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92AB1611AD
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 13:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgBQMKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 07:10:45 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2658 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgBQMKp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 07:10:45 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4a82b60000>; Mon, 17 Feb 2020 04:10:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Feb 2020 04:10:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Feb 2020 04:10:44 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Feb
 2020 12:10:44 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Feb 2020 12:10:44 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4a82c00000>; Mon, 17 Feb 2020 04:10:43 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 0/5] Add support to defer core initialization
Date:   Mon, 17 Feb 2020 17:40:31 +0530
Message-ID: <20200217121036.3057-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581941430; bh=G+TCTgGYyb/7NJSBkD2cISCV8tcJmRltzI9xyL6GCdk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=NuCMyIusrCLbnT9wJm7UdE+qjLgloFLg6wldtrjn+WeOmYQdtun/nenfC1CdGgikm
         pl27PMX93crTmwpL1ETwF0GQXnqEYcjR1dXR6iNVMQVdUQm70be5Fhoodq3ymsYJXk
         L33Cj+nkRwTAHxkGR+EYg+8xB/pTF+6mN0r34wRNQO6Mwgs31PUQUZZPoW/sAJRfom
         XDg1la8xR9ixrIEZnbmycnXK4dpt87CqT4x8MxZw1dTUutAXrcCw6xTwjAIGTS2FmU
         I9qgluVg6dHYRfJ9rfRnPYBKWvTc9a6Yk4rBdr9KfVXeF1+lAn/8m6wCGDcz5wty5h
         AsM0VoNXKXmeA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

EPC/DesignWare core endpoint subsystems assume that the core registers are
available always for SW to initialize. But, that may not be the case always.
For example, Tegra194 hardware has the core running on a clock that is derived
from reference clock that is coming into the endpoint system from host.
Hence core is made available asynchronously based on when host system is going
for enumeration of devices. To accommodate this kind of hardwares, support is
required to defer the core initialization until the respective platform driver
informs the EPC/DWC endpoint sub-systems that the core is indeed available for
initiaization. This patch series is attempting to add precisely that.
This series is based on Kishon's patch that adds notification mechanism
support from EPC to EPF @ http://patchwork.ozlabs.org/patch/1236793/ from the
series @ http://patchwork.ozlabs.org/project/linux-pci/list/?series=158088

V3:
* Rebased this series on top of kishon's new patch series as mentioned above
* Added Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

V2:
* Addressed review comments from Kishon

Vidya Sagar (5):
  PCI: endpoint: Add core init notifying feature
  PCI: dwc: Refactor core initialization code for EP mode
  PCI: endpoint: Add notification for core init completion
  PCI: dwc: Add API to notify core initialization completion
  PCI: pci-epf-test: Add support to defer core initialization

 .../pci/controller/dwc/pcie-designware-ep.c   |  79 +++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  11 ++
 drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++------
 drivers/pci/endpoint/pci-epc-core.c           |  19 ++-
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |   5 +
 6 files changed, 164 insertions(+), 70 deletions(-)

-- 
2.17.1

