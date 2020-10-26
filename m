Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9129871E
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 08:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770784AbgJZGzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 02:55:08 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18143 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768361AbgJZGzI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 02:55:08 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9672b70000>; Sun, 25 Oct 2020 23:54:47 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 06:55:05 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 06:55:01 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 0/4] Enhancements to Tegra194 PCIe driver
Date:   Mon, 26 Oct 2020 12:24:55 +0530
Message-ID: <20201026065459.28509-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603695287; bh=Vc7F9dI+dtmRRbfZ0o3BhIjaR59C4FSZIanwvlrLzr4=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=DDAeJUAK/0hotCFoO4SwdZUOawKoOHewfNjiwXAuN9y6mjCltLb+AyeR1j595TvU7
         tq1aoAxU8dXiVaiqiJXbGQRgxQghRuRXbRkBCIvpbHLjE4yW9wEXTmrjbU9fGUjAop
         M9xSHE+vXvI4FUoERf0Ol7mkxxRo0jkGIpBqVy6eAepS8aktmsaWHtY1Dx0IrYUs+O
         LBTLnbNBqbo85jgLjL+b6d9TNg6z0Ip5Md+iu4GFwFcekQ0DzkA2t3KhdRxEA2lU57
         5lr/dRXrEn+5CXi2ocOCnk6X2p8LIIkw9V1oTBRUOHfmjfAr+LoqV0NtisA53ugQrz
         DhOeHBjQ1+tBA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches do some enhancements and some bug fixes to the
Tegra194 PCIe platform driver like
- Fixing Vendor-ID corruption
- Mapping DBI space correctly
- Updating DWC IP version
- Handling error conditions properly

Vidya Sagar (4):
  PCI: tegra: Fix ASPM-L1SS advertisement disable code
  PCI: tegra: Map configuration space as strongly ordered
  PCI: tegra: Set DesignWare IP version
  PCI: tegra: Handle error conditions properly

 drivers/pci/controller/dwc/pcie-tegra194.c | 62 +++++++++++-----------
 1 file changed, 30 insertions(+), 32 deletions(-)

-- 
2.17.1

