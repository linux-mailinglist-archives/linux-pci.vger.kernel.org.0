Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9F42E902
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 08:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhJOGcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 02:32:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37166 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231612AbhJOGcq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 02:32:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2463F1A15D8;
        Fri, 15 Oct 2021 08:30:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E162A1A15E5;
        Fri, 15 Oct 2021 08:30:37 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AF278183AC94;
        Fri, 15 Oct 2021 14:30:36 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [RESEND v2 0/5] PCI: imx6: refine codes and add compliance tests mode support
Date:   Fri, 15 Oct 2021 14:05:36 +0800
Message-Id: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series patches refine pci-imx6 driver and do the following changes.
- Encapsulate the clock enable into one standalone function
- Add the error propagation from host_init
- Balance the usage of the regulator and clocks when link never came up
- Add the compliance tests mode support

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

drivers/pci/controller/dwc/pci-imx6.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------
1 file changed, 105 insertions(+), 61 deletions(-)

[RESEND v2 1/5] PCI: imx6: Encapsulate the clock enable into one
[RESEND v2 2/5] PCI: imx6: Add the error propagation from host_init
[RESEND v2 3/5] PCI: imx6: Fix the regulator dump when link never
[RESEND v2 4/5] PCI: imx6: Fix the clock reference handling unbalance
[RESEND v2 5/5] PCI: imx6: Add the compliance tests mode support
