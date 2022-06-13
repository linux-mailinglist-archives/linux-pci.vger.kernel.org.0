Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361C35482BE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 11:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbiFMJJb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 05:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbiFMJJ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 05:09:28 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04266EE1E;
        Mon, 13 Jun 2022 02:09:26 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 666C61A1D80;
        Mon, 13 Jun 2022 11:09:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D5C641A0B76;
        Mon, 13 Jun 2022 11:09:24 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0EA39180222D;
        Mon, 13 Jun 2022 17:09:22 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v10 0/7] PCI: imx6: refine codes and add the error propagation
Date:   Mon, 13 Jun 2022 16:55:31 +0800
Message-Id: <1655110538-10914-1-git-send-email-hongxing.zhu@nxp.com>
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

This series patches refine pci-imx6 driver and do the following main changes.
- Encapsulate the clock enable into one standalone function
- Add the error propagation from host_init and resume
- Turn off regulator when the system is in suspend mode
- Let the probe successfully when link never comes up
- Do not hide the phy driver callbacks in core reset and clk_enable.
BTW, this series are verified on i.MX8MM EVK board when one NVME is used.

Main changes from v9 to v10:
- Add the "Reviewed-by: Lucas Stach <l.stach@pengutronix.de>" tag into #3
  and #4 patches.
Refer to Bjorn's comments:
- refine the commit of the first patch
- keep alignment of the message format in the second patch
- More specific commit and subject of the #5 and #7 patches.
Refer to Lucas' comments:
- Move the regualtor_disable into suspend, turn off the regulator when bus
  is powered off and system in suspend mode.
- Let the driver probe successfully, return zero in imx6_pcie_start_link()
  when PCIe link is down. 
  In this link down scenario, only start the PCIe link training in resume
  when the link is up before system suspend to avoid the long latency in
  the link training period.
- Don't hide phy driver callbacks in core reset and clk_enable, and refine
  the error handling accordingly.
- Drop the #8 patch of v9 series, since the clocks and powers are not gated
  off anymore when link is down.

Main changes from v8 to v9:
- Don't change pcie-designware codes, and do the error exit process only in
  pci-imx6 driver internally.
- Move the phy driver callbacks to the proper places

Main changes from v7 to v8:
Regarding Bjorn's review comments.
- Align the format of the dev_info message and refine commit log of
  #6/7/8 patches.
- Rename the err_reset_phy label, since there is no PHY reset in the out

Main changes from v6 to v7:
- Keep the regulator usage counter balance in the #5 patch of v6 series.

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

drivers/pci/controller/dwc/pci-imx6.c | 241 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
1 file changed, 157 insertions(+), 84 deletions(-)

[PATCH v10 1/7] PCI: imx6: Encapsulate the clock enable into one
[PATCH v10 2/7] PCI: imx6: Add the error propagation from host_init
[PATCH v10 3/7] PCI: imx6: Move imx6_pcie_clk_disable() earlier
[PATCH v10 4/7] PCI: imx6: Disable iMX6QDL PCIe REF clock when
[PATCH v10 5/7] PCI: imx6: Turn off regulator when the system is in
[PATCH v10 6/7] PCI: imx6: Mark the link down as none fatal error
[PATCH v10 7/7] PCI: imx6: Do not hide phy driver callbacks and
