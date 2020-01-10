Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4A71376C5
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 20:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgAJTPJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 14:15:09 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1659 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgAJTPJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2020 14:15:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e18cd2a0000>; Fri, 10 Jan 2020 11:14:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Jan 2020 11:15:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Jan 2020 11:15:08 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 19:15:08 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 10 Jan 2020 19:15:08 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e18cd380000>; Fri, 10 Jan 2020 11:15:07 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <andrew.murray@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 0/2] PCI: Add MCFG quirks for Tegra194 host controllers
Date:   Sat, 11 Jan 2020 00:44:58 +0530
Message-ID: <20200110191500.9538-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106082709.14370-1-vidyas@nvidia.com>
References: <20200106082709.14370-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578683690; bh=ijKK/DiU1QbdSZI//ZXmG99ZEoUzM/+Rr+0S/t1xBHU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=a9XjmD7vpFdKxUPscAV1tPEV+9JDgitMBH9OKMH3NETpDRHbK+JlZwqHKIIF0xJbU
         fnabinmenQjQjf3Ys7EUXue4hATK3hFof/wbfZLzOANr1C1tgFL+/koGp5KN/R2tsL
         tVjga8Jup/uU+FKx2yDW8LDrEaok3SzUrvNJwrrG7+I9XPio4uCLDJxtO0DsggFXgB
         Duwa7xXH35P0ijXtfSmM5zXbSUZnsk6G9wdpXEGBVE01ERa2jJfEzslXr5hm8/SphO
         NNQCkL2IJ5jaCzoae1BPlC7y1S9eg1hhyJOGwlhXzvLsr1WLFd/baB0oqx+uU7QiE/
         eUZf3Bk+HSeVg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe controller in Tegra194 SoC is not completely ECAM-compliant.
With the current hardware design limitations in place, ECAM can be enabled
only for one controller (C5 controller to be precise) with bus numbers
starting from 160 instead of 0. A different approach is taken to avoid this
abnormal way of enabling ECAM for just one controller but to enable
configuration space access for all the other controllers. In this approach,
ops are added through MCFG quirk mechanism which access the configuration
spaces by dynamically programming iATU (internal AddressTranslation Unit)
to generate respective configuration accesses just like the way it is
done in DesignWare core sub-system.
To increase the size of ECAM, a device-tree change is pushed in this series
to move the IO window from 32-bit PCIe aperture to 64-bit PCIe aperture leaving
the entire 32MB of 32-bit aperture for configuration space access.

V3:
* Pushed a device-tree change in the series to enable more space for ECAM

Vidya Sagar (2):
  arm64: tegra: Re-order PCIe aperture mappings to support ACPI boot
  PCI: Add MCFG quirks for Tegra194 host controllers

 arch/arm64/boot/dts/nvidia/tegra194.dtsi   |  36 ++++----
 drivers/acpi/pci_mcfg.c                    |   7 ++
 drivers/pci/controller/dwc/Kconfig         |   3 +-
 drivers/pci/controller/dwc/Makefile        |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c | 102 +++++++++++++++++++++
 include/linux/pci-ecam.h                   |   1 +
 6 files changed, 131 insertions(+), 20 deletions(-)

-- 
2.17.1

