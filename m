Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF5B10C524
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 09:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfK1Ibl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 03:31:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:62975 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfK1Ibk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Nov 2019 03:31:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 00:31:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,252,1571727600"; 
   d="scan'208";a="409288003"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 28 Nov 2019 00:31:35 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, rdunlap@infradead.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v1 0/1]Fix build warning and errors
Date:   Thu, 28 Nov 2019 16:31:12 +0800
Message-Id: <cover.1574929426.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mark Intel PCIe driver depends on MSI IRQ Domain to fix
the below warnings and respective build errors.

WARNING: unmet direct dependencies detected for PCIE_DW_HOST
  Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
  Selected by [y]:
  - PCIE_INTEL_GW [=y] && PCI [=y] && OF [=y] && (X86 [=y] || COMPILE_TEST [=n])

Dilip Kota (1):
  PCI: dwc: Kconfig: Mark intel PCIe driver depends on MSI IRQ Domain

 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.11.0

