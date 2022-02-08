Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C274AD00B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 05:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbiBHECs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 23:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbiBHECq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 23:02:46 -0500
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 20:02:45 PST
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E95C0401DC;
        Mon,  7 Feb 2022 20:02:45 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 10DFF1A0C48;
        Tue,  8 Feb 2022 04:56:56 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CCB9E1A0956;
        Tue,  8 Feb 2022 04:56:55 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 43634183AC96;
        Tue,  8 Feb 2022 11:56:54 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com, festevam@gmail.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v6 0/8] PCI: imx6: refine codes and add compliance tests mode support 
Date:   Tue,  8 Feb 2022 11:25:27 +0800
Message-Id: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series patches refine pci-imx6 driver and do the following changes.
- Encapsulate the clock enable into one standalone function
- Add the error propagation from host_init
- Balance the usage of the regulator and clocks when link never came up
- Add the compliance tests mode support

Main changes from v5 to v6:
- Refer to the following discussion with Fabio, fix the dump by his patch.
  https://patchwork.kernel.org/project/linux-pci/patch/1641368602-20401-6-git-send-email-hongxing.zhu@nxp.com/
  Refine and rebase this patch-set after Fabio' dump fix patch is merged.
- Add one new #4 patch to disable i.MX6QDL REF clock too when disable clocks
- Split the regulator refine codes into one standalone patch #5 in this version.

Main changes from v4 to v5:
- Since i.MX8MM PCIe support had been merged. Based on Lorenzo's git repos,
  resend the patch-set after rebase.

Main changes from v3 to v4:
- Regarding Mark's comments, delete the regulator_is_enabled() check.
- Squash #3 and #6 of v3 patch into #5 patch of v4 set.

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

drivers/pci/controller/dwc/pci-imx6.c             | 213 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
drivers/pci/controller/dwc/pcie-designware-host.c |   5 ++-
drivers/pci/controller/dwc/pcie-designware.h      |   1 +
3 files changed, 142 insertions(+), 77 deletions(-)

[PATCH v6 1/8] PCI: imx6: Encapsulate the clock enable into one
[PATCH v6 2/8] PCI: imx6: Add the error propagation from host_init
[PATCH v6 3/8] PCI: imx6: Move imx6_pcie_clk_disable() earlier
[PATCH v6 4/8] PCI: imx6: Disable imx6qdl pcie ref clk
[PATCH v6 5/8] PCI: imx6: Refine the regulator usage
[PATCH v6 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit() callback
[PATCH v6 7/8] PCI: imx6: Disable enabled clocks and regulators after
[PATCH v6 8/8] PCI: imx6: Add the compliance tests mode support
