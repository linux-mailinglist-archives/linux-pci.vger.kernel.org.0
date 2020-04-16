Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1B01AC686
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 16:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394442AbgDPOlI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 10:41:08 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:7707 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392865AbgDPOk6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2020 10:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587048059; x=1618584059;
  h=date:from:to:subject:message-id:mime-version;
  bh=V5smWBbOOXuVbvgelgTYa696GvPO7TMp629r0FYTLdU=;
  b=YFr2GvIWdSDBX5CheXqM42AcJgvrrfFftXXlvztfzD6/ETLqpBdSfjPC
   9NplNJD4Cfcpq20rYUF9I7dU7bDiD/wwLOHe17mtp4AeAuu7BkfW4AMxp
   GYe5VU/gcwTfoRQhPDWvPpAMDx11aIpAfSuyDj6bEhJVkCICVSQbuUt1Y
   2vn2+B3dN3ZM4OWfNu/A6jJnBMRnATHxcG0yTJbpmNqTtDWIGz7fHdS1L
   K892C2eYdCOXL8XAL0Jpep3uJPckGNY0ngZiOP/V4yUxBJcjNfCB3H0TY
   z872B9+0HYipYg6oDwQgm59H45WZZ0Ny9hlcPK48V9mk6xb2SPLzRDI+o
   A==;
IronPort-SDR: bmF9yVi2W5auEceSbVx69ARGf+iFWCLuKPN2bqiwqwXx+VlAR6897ZJDo9J4t1eIw4QHW1hqzZ
 LGGxndz7cJuGfgFiLSBbwuOuy+uyXd2obnWH/vCtBuEDjEmyPZ/s5yQQKRFQV6ksCZxg7yEm7a
 sULWR7B4r5zfmw00j/8wsjIUncpu8YbUXjabC6h4mVQ5wEhzJ2fb0aifeRAFryGRPJgINIni9Y
 51nUvV5KSgjDARSBhhRK/ZDgU//dhf4FQdi06c6PZx6tejSQsFIVMW7HCplshVTtb+k2+vqCrF
 5QQ=
X-IronPort-AV: E=Sophos;i="5.72,391,1580799600"; 
   d="scan'208";a="72749731"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Apr 2020 07:40:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Apr 2020 07:41:02 -0700
Received: from IRE-LT-SPARE06.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Apr 2020 07:40:55 -0700
Date:   Thu, 16 Apr 2020 15:40:53 +0100
From:   Daire McNamara <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <amurray@thegoodpenguin.co.uk>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v7 0/1] PCI: microchip: Add host driver for Microchip PCIe
 controller
Message-ID: <20200416144053.GA2740@IRE-LT-SPARE06.mchp-main.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This v7 patch adds support for the Microchip PCIe PolarFire PCIe
controller when configured in host (Root Complex) mode.

Updates since v6:
* Refactored to use common eCAM driver
* Updated to CONFIG_PCIE_MICROCHIP_HOST etc
* Formatting improvements
* Removed code for selection between bridge 0 and 1

Updates since v5:
* Fixed Kconfig typo noted by Randy Dunlap
* Updated with comments from Bjorn Helgaas

Updates since v4:
* Fix compile issues.

Updates since v3:
* Update all references to Microsemi to Microchip
* Separate MSI functionality from legacy PCIe interrupt handling functionality

Updates since v2:
* Split out DT bindings and Vendor ID updates into their own patch
  from PCIe driver.
* Updated Change Log

Updates since v1:
* Incorporate feedback from Bjorn Helgaas

Daire McNamara (1):
  PCI: microchip: Add host driver for Microchip PCIe controller

 .../bindings/pci/microchip-pcie.txt           |  64 ++
 drivers/pci/controller/Kconfig                |   9 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pcie-microchip-host.c  | 702 ++++++++++++++++++
 4 files changed, 776 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/microchip-pcie.txt
 create mode 100644 drivers/pci/controller/pcie-microchip-host.c


base-commit: c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d
--
2.17.1

