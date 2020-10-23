Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC682977EE
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 21:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755210AbgJWT5H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 15:57:07 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17004 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755209AbgJWT5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 15:57:07 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f93357d0001>; Fri, 23 Oct 2020 12:56:45 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Oct
 2020 19:57:01 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 23 Oct 2020 19:56:57 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 0/3] Add support to handle prefetchable memory
Date:   Sat, 24 Oct 2020 01:26:52 +0530
Message-ID: <20201023195655.11242-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603483005; bh=b9IZnjk26r3cJfsBfroWtTDFOsnjHPE6ktQY975AN24=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=FN9+Ov5cr2Okws3QhCvV1JJ2LdTMTNTYOLUsXcHkL9/rW2+ML4RYuAAP5Zpxaw0A1
         3OnU2ghoyz5f/LSiNXqS4RDWSZ5FClt6w/aGdsQSNSjZ4l+XZeEwR93k0MiDpbk6Hr
         rYQVtCwpCywpOouR/fBTKtpK4zZBEd0HN00qHmM+hZ40bDAXBPv+QDZWdMM04gyeiT
         MQRkx/cuXzi84gYf0F4+AUZE6xXK+vXETLcZ9219QEtd9nLkvksNPea/TxuQpj7qEe
         1RjSgpc5e649rVJgmmTO54tW6Qgp6wEtCEmRDn0217K/RWcYLJz2ULRVcyhmecXD++
         wN4aWt0dsN9yQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series adds support for configuring the DesignWare IP's ATU
region for prefetchable memory translations.
It first starts by flagging a warning if the size of non-prefetchable
aperture goes beyond 32-bit as PCIe spec doesn't allow it.
And then adds required support for programming the ATU to handle higher
(i.e. >4GB) sizes and then finally adds support for differentiating
between prefetchable and non-prefetchable regions and configuring one of
the ATU regions for prefetchable memory translations purpose.

Vidya Sagar (3):
  PCI: of: Warn if non-prefetchable memory aperture size is > 32-bit
  PCI: dwc: Add support to program ATU for >4GB memory aperture sizes
  PCI: dwc: Add support to handle prefetchable memory mapping

 .../pci/controller/dwc/pcie-designware-host.c | 39 ++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c  | 12 +++---
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
 drivers/pci/of.c                              |  5 +++
 4 files changed, 48 insertions(+), 12 deletions(-)

-- 
2.17.1

