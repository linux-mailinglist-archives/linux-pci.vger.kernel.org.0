Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0A29E688
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 09:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgJ2IjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 04:39:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11551 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgJ2IjH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 04:39:07 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9a55a20001>; Wed, 28 Oct 2020 22:39:47 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 05:40:06 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 29 Oct 2020 05:40:02 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 0/2] Add support to configure DWC for ECRC
Date:   Thu, 29 Oct 2020 11:09:57 +0530
Message-ID: <20201029053959.31361-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603949987; bh=0k0o3hi13e04jBvYXuffIfmjxQS/pJMRPBKHdQc2v6k=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=jvpZtBjZPPDlI74paYWLdx3HLwin5k1VdcF+YdtA7QvqtxOmeHQDpBry4aeY15ium
         5VwVr8sTtL1gm7vN9UL+tWKKBbSlV5KoO+EVIr+s84O1kAeQvL87HD9fX4UMjzR9yT
         UFdJ137wiby16HXkLx7edSIh6RCKrMtZ2e1OAjUs9CRNkHfBhPphrI9O2vFeLu4RW8
         MU8jWndeU/ic0q2l+4ee4LfhcDQfEIaj0+CqaVvl+0Hf8VmNqTAtRs7wSh+JTcYj2V
         XuoIoiKOb9o0cEeO49Z8fZXYKPNcxvLPql3fKBTDJY+Jg6p5k7avJ8CjvMDfLq17IH
         ps9DY+ZsaSMwQ==
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

V3:
* Addressed Ethan Zhao's comments for patch-1

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

