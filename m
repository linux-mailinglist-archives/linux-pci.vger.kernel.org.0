Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D559112F68D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 11:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgACKH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 05:07:56 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10104 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgACKHy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 05:07:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0f12690000>; Fri, 03 Jan 2020 02:07:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 02:07:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 02:07:53 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 10:07:44 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 10:07:44 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0f126c0000>; Fri, 03 Jan 2020 02:07:43 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 0/5] Add support to defer core initialization
Date:   Fri, 3 Jan 2020 15:37:31 +0530
Message-ID: <20200103100736.27627-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578046057; bh=dl13GPM9AbiWil3yHZjKpRFuwuDi44Uw7VHC0WTHXtE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=AxV8nRlk6FlZdSKu2lEQ1a7Lokso0TbKcNSb+dCY2dmk2PWpxjn6qXmEfDO3//037
         eF+5PIDe9c2zH6kPCJI90nfCKmnQz34hpmKsaqzeNIez8F2V/n6/s/XwpdXok/Lpl3
         4rCeJXzV3/6YUY1nfbbZl7hPnvOkzxek/OfGUkNdSIvJ+oQFXMnCPCnKQ5Q1XEOjzj
         hTHTi+xQSTv7Dd+J/0uV+r5MO1FacFEPMzVoox6Ee6YsoCtObYBwhGiRhS4byt3qPO
         XLZAO9eTSGUOdb9ti2pk4qx/oSMEJK+i37T1w+M+6Jnpew8FlLd9W/riCdWfEm8pu7
         RmrxPwwniAvAQ==
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
support from EPC to EPF @ http://patchwork.ozlabs.org/patch/1109884/

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

