Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B365029A615
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 09:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508679AbgJ0IDp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 04:03:45 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18936 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508680AbgJ0IDk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 04:03:40 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f97d4470000>; Tue, 27 Oct 2020 01:03:19 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 08:03:36 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 27 Oct 2020 08:03:32 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 0/2] Add support to configure DWC for ECRC
Date:   Tue, 27 Oct 2020 13:33:28 +0530
Message-ID: <20201027080330.8877-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603785799; bh=ZAWrTnsJdsZBg4TX4fkbfnoBs45cYd0AJJa1fauq/mY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=GZzYa62KE36Sso9uw0od7w/l+3Zt2rKtEZyeyZA8l8ijHdfV+oHt/27Bj9owD4JFX
         jU5wSR8pF1ceZO7TuxjleH/v9RZXHQ9nQDf0tt8D4jwQyk7PlKHFrSGSwpAfAKW1Zu
         LNitf98aDI1NU6fWzbesjlZge71X8JxhAgsva8ntCN9zPMH9Ye7N+J4cU7k9MV0JCC
         E1YFVSTlzfoJM8iguStfb9ThfGWb64wsUPBjiE6tHl77EOu+kZtA0xyocEX5SQJ5R1
         DklAEQe8nrKGA2eGlQ0Wvf3ixqx+GWWGPTDZvuweuYV5whRQhBDZo7tDMWcedV0eKP
         f1PAGwDC8rQRA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series has two patches.

Patch-1: Adds a public API to query if the system has ECRC policty turned on.

Patch-2: DesignWare core PCIe IP has a TLP Digest (TD) override bit in one of
its control registers of ATU. This bit needs to be programmed for proper ECRC
functionality. This is currently identified as an issue with DesignWare
IP version 4.90a. DWC code queries the PCIe sub-system through the API added
in Patch-1 to find out if ECRC is turned on or not and configures ATU
accordingly.

V2:
* Addressed Jingoo's review comments

Vidya Sagar (2):
  PCI/AER: Add pcie_is_ecrc_enabled() API
  PCI: dwc: Add support to configure for ECRC

 drivers/pci/controller/dwc/pcie-designware.c |  8 ++++++--
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 drivers/pci/pci.h                            |  2 ++
 drivers/pci/pcie/aer.c                       | 11 +++++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.17.1

