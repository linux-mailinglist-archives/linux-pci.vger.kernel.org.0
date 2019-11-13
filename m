Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E89FAC92
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 10:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfKMJI7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 04:08:59 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14414 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfKMJI7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 04:08:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcbc82d0000>; Wed, 13 Nov 2019 01:09:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 01:08:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 01:08:58 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 09:08:58 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Nov 2019 09:08:58 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dcbc8260003>; Wed, 13 Nov 2019 01:08:58 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 0/4] Add support to defer core initialization
Date:   Wed, 13 Nov 2019 14:38:47 +0530
Message-ID: <20191113090851.26345-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573636141; bh=oD8oTA0a2UX+17Bvup9RvEqjWuCUJIivzQuwAOx+Ltk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=MsuCvWRjzkoA4bHynJjGaktkx/znYP/HyYvbCYtqF9Cys/vqmkswufI4OrC6edVJ/
         YAgSIPFaDGgJuv8QAjaB0mqAFBvD79pKYxnmldEUKZ0TtXQsvQAZWL5ckvfgPlJOVJ
         Zkph0V7y41wugPQ5J8gXdg9Fbleu29RmP9Hs6PRxuAPt0MtgxszViYyOxJoUoFI4Ss
         3saeJQfzxkxXUSEBbm3H0/iXuA8+vvyDNtsz52gZIP8F5F6QCqgAkCCSpKwPbfPBZU
         s9z/andb1hRYrWVH2UDmyuowyZ/Y3VV1ML4TVXqis/aQbQZbl1bRJHuaFgDqPok8Qi
         5v0Dju27rcorQ==
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

Vidya Sagar (4):
  PCI: dwc: Add new feature to skip core initialization
  PCI: endpoint: Add notification for core init completion
  PCI: dwc: Add API to notify core initialization completion
  PCI: pci-epf-test: Add support to defer core initialization

 .../pci/controller/dwc/pcie-designware-ep.c   |  79 +++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  11 ++
 drivers/pci/endpoint/functions/pci-epf-test.c | 114 ++++++++++++------
 drivers/pci/endpoint/pci-epc-core.c           |  19 ++-
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |   5 +
 6 files changed, 164 insertions(+), 66 deletions(-)

-- 
2.17.1

