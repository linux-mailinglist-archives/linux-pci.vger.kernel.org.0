Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B6C29A468
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 07:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506161AbgJ0GCI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 02:02:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:41317 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506160AbgJ0GCI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 02:02:08 -0400
IronPort-SDR: 9VxIJB5bwawfDNDoW2youUAi0ExoGJ+OzARqsrfrOxYnLuFhAI4WatdkK8+EDTiNc084VgZAsJ
 21RjkfXlB8ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155810674"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="155810674"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:01:53 -0700
IronPort-SDR: +UqqIhJdbAw/3VsiF45psvOh0wCUar35/Ru7CXvKDxMZwLkyutrhi1Y/e7qxx8RnOAnw72+0wA
 TCeReUKRdBtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="303775917"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga007.fm.intel.com with ESMTP; 26 Oct 2020 23:01:51 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 0/2] PCI: keembay: Add support for Intel Keem Bay
Date:   Tue, 27 Oct 2020 14:00:09 +0800
Message-Id: <20201027060011.25893-1-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi.

The first patch is to document DT bindings for Keem Bay PCIe controller
for both Root Complex and Endpoint modes.

The second patch is the driver file, a glue driver. Keem Bay PCIe
controller is based on DesignWare PCIe IP.

The patch was tested with Keem Bay evaluation module board, with A0
stepping.

Thank you.

Best regards,
Zainie


Wan Ahmad Zainie (2):
  dt-bindings: PCI: Add Intel Keem Bay PCIe controller
  PCI: keembay: Add support for Intel Keem Bay

 .../bindings/pci/intel,keembay-pcie-ep.yaml   |  86 +++
 .../bindings/pci/intel,keembay-pcie.yaml      | 120 ++++
 drivers/pci/controller/dwc/Kconfig            |  24 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-keembay.c     | 658 ++++++++++++++++++
 5 files changed, 889 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-keembay.c

-- 
2.17.1

