Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0FF603C7
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfGEKHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:07:06 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47748 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfGEKHG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 06:07:06 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1AC10200703;
        Fri,  5 Jul 2019 12:07:03 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F8BF200706;
        Fri,  5 Jul 2019 12:06:54 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 20295402DF;
        Fri,  5 Jul 2019 18:06:44 +0800 (SGT)
From:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6 00/28] PCI: mobiveil: fixes for Mobiveil PCIe Host Bridge IP driver
Date:   Fri,  5 Jul 2019 17:56:28 +0800
Message-Id: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set is to add fixes for Mobiveil PCIe Host driver.
Splited #2, #3, #9 and #10 of v5 patches.

Hou Zhiqiang (28):
  PCI: mobiveil: Unify register accessors
  PCI: mobiveil: Remove the flag MSI_FLAG_MULTI_PCI_MSI
  PCI: mobiveil: Fix PCI base address in MEM/IO outbound windows
  PCI: mobiveil: Update the resource list traversal function
  PCI: mobiveil: Use WIN_NUM_0 explicitly for CFG outbound window
  PCI: mobiveil: Use the 1st inbound window for MEM inbound
    transactions
  PCI: mobiveil: Fix the Class Code field
  PCI: mobiveil: Move the link up waiting out of mobiveil_host_init()
  PCI: mobiveil: Move IRQ chained handler setup out of DT parse
  PCI: mobiveil: Initialize Primary/Secondary/Subordinate bus numbers
  PCI: mobiveil: Fix devfn check in mobiveil_pcie_valid_device()
  dt-bindings: PCI: mobiveil: Change gpio_slave and apb_csr to optional
  PCI: mobiveil: Reformat the code for readability
  PCI: mobiveil: Make the register updating more readable
  PCI: mobiveil: Revise the MEM/IO outbound window initialization
  PCI: mobiveil: Fix the returned error number
  PCI: mobiveil: Remove an unnecessary return value check
  PCI: mobiveil: Remove redundant var definitions and register read
    operations
  PCI: mobiveil: Fix the valid check for inbound and outbound window
  PCI: mobiveil: Add the statistic of initialized inbound windows
  PCI: mobiveil: Clear the target fields before updating the register
  PCI: mobiveil: Mask out the lower 10-bit hardcode window size
  PCI: mobiveil: Add upper 32-bit CPU base address setup in outbound
    window
  PCI: mobiveil: Add upper 32-bit PCI base address setup in inbound
    window
  PCI: mobiveil: Fix the CPU base address setup in inbound window
  PCI: mobiveil: Move PCIe PIO enablement out of inbound window routine
  PCI: mobiveil: Fix infinite-loop in the INTx process
  PCI: mobiveil: Fix the potential INTx missing problem

 .../devicetree/bindings/pci/mobiveil-pcie.txt      |    2 +
 drivers/pci/controller/pcie-mobiveil.c             |  529 ++++++++++++--------
 2 files changed, 318 insertions(+), 213 deletions(-)

