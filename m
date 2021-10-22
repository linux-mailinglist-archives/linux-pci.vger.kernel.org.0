Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C335E4372D5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 09:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhJVHkI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 03:40:08 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45906 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbhJVHkI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 03:40:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D7651201B52;
        Fri, 22 Oct 2021 09:37:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FC132005EC;
        Fri, 22 Oct 2021 09:37:49 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4D5BB183AC94;
        Fri, 22 Oct 2021 15:37:48 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v3 0/7] PCI: imx6: refine codes and add compliance tests mode support
Date:   Fri, 22 Oct 2021 15:12:23 +0800
Message-Id: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series patches refine pci-imx6 driver and do the following changes.
- Encapsulate the clock enable into one standalone function
- Add the error propagation from host_init
- Add one new host_exit callback, used to balance the usage of the
  regulator and clocks when link never came up
- Add the compliance tests mode support

Main changes from v2 to v3:
- Add "Reviewed-by: Lucas Stach <l.stach@pengutronix.de>" tag into
  first two patches.
- Add a Fixes tag into #3 patch.
- Split the #4 of v2 to two patches, one is clock disable codes move,
  the other one is the acutal clock unbalance fix.
- Add a new host_exit() callback into dw_pcie_host_ops, then it could be
  invoked to handle the unbalance issue in the error handling after
  host_init() function when link is down.
- Add a new host_exit() callback for i.MX PCIe driver to handle this case
  in the error handling after host_init.

Main changes from v1 to v2:
Regarding Lucas' comments.
  - Move the placement of the new imx6_pcie_clk_enable() to avoid the
    forward declarition.
  - Seperate the second patch of v1 patch-set to three patches.
  - Use the module_param to replace the kernel command line.
Regarding Bjorn's comments:
  - Use the cover-letter for a multi-patch series.
  - Correct the subject line, and refine the commit logs. For example,
    remove the timestamp of the logs.

drivers/pci/controller/dwc/pci-imx6.c             | 176 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
drivers/pci/controller/dwc/pcie-designware-host.c |   5 ++-
drivers/pci/controller/dwc/pcie-designware.h      |   1 +
3 files changed, 119 insertions(+), 63 deletions(-)

[PATCH v3 1/7] PCI: imx6: Encapsulate the clock enable into one
[PATCH v3 2/7] PCI: imx6: Add the error propagation from host_init
[PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never came
[PATCH v3 4/7] PCI: imx6: move the clock disable function to a proper
[PATCH v3 5/7] PCI: dwc: add a new callback host exit function into
[PATCH v3 6/7] PCI: imx6: Fix the reference handling unbalance when
[PATCH v3 7/7] PCI: imx6: Add the compliance tests mode support
