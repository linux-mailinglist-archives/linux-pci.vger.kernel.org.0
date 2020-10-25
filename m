Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7082980A7
	for <lists+linux-pci@lfdr.de>; Sun, 25 Oct 2020 08:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767792AbgJYHbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Oct 2020 03:31:21 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12799 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1767791AbgJYHbU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2020 03:31:20 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9529d00000>; Sun, 25 Oct 2020 00:31:28 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 25 Oct
 2020 07:31:20 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Sun, 25 Oct 2020 07:31:16 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 0/2] Add support to configure DWC for ECRC
Date:   Sun, 25 Oct 2020 13:01:11 +0530
Message-ID: <20201025073113.31291-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603611088; bh=Z7I/w0Qyshk5wSGbJUe74d+c8TI8tu2umpG5oTytpqc=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=eSzkpf5WzMAfMmZmfHFEhluMCG3ASNSTNZx3juOm9Yp95wvG66w/ic+0U9g2ZBZAb
         1jZqM6jLZJZzud+zbIoWNK+mQNLxhioU3yyHRtJ+N0G4AV8IrqzUTy2AAq8wzcELCP
         D+Bvhrx6xBhNYsLl014M4wS9j/+rJTzAp7O+GNVkgf0KrPXjQsYgovZTnOgqWH7hWy
         Nu7683MK95koV43jm8BnPqxR3V4lUlF9hzrqvcLXFkqJZxt01I38WK4MBwJYlWPRg5
         7rioP4mWa7qvkxIgHjlCSkgSbdyGN9PSjMF7f9x9dKzIgmnBqjDX5XgfSDoCsDGKN1
         YJr2fQ08t/cuQ==
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

Vidya Sagar (2):
  PCI/AER: Add pcie_is_ecrc_enabled() API
  PCI: dwc: Add support to configure for ECRC

 drivers/pci/controller/dwc/pcie-designware.c |  8 ++++++--
 drivers/pci/controller/dwc/pcie-designware.h |  2 ++
 drivers/pci/pci.h                            |  2 ++
 drivers/pci/pcie/aer.c                       | 11 +++++++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.17.1

