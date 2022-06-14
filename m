Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CFE54AA29
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 09:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353536AbiFNHNI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 03:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353462AbiFNHM6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 03:12:58 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324E918353;
        Tue, 14 Jun 2022 00:12:52 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 691FA20004F;
        Tue, 14 Jun 2022 09:12:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 06DAE2000C2;
        Tue, 14 Jun 2022 09:12:51 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 67BCC1802205;
        Tue, 14 Jun 2022 15:12:49 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v11 0/8] PCI: imx6: refine codes and add the error propagation
Date:   Tue, 14 Jun 2022 14:58:54 +0800
Message-Id: <1655189942-12678-1-git-send-email-hongxing.zhu@nxp.com>
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

Main changes from v10 to v11:
No code changes, just do the following operations refer to Bjorn's comments.
  - Split #6 patch into two patches.
  - Rebase to v5.19-rc1 based on for-next branch of Shawn's git.

Main changes from v9 to v10:
- Add the "Reviewed-by: Lucas Stach <l.stach@pengutronix.de>" tag into #3
  and #4 patches.
- Refer to Bjorn's comments:
  - refine the commit of the first patch
  - keep alignment of the message format in the second patch
  - More specific commit and subject of the #5 and #7 patches.
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
[PATCH v11 1/8] PCI: imx6: Encapsulate the clock enable into one
[PATCH v11 2/8] PCI: imx6: Add the error propagation from host_init
[PATCH v11 3/8] PCI: imx6: Move imx6_pcie_clk_disable() earlier
[PATCH v11 4/8] PCI: imx6: Disable iMX6QDL PCIe REF clock when
[PATCH v11 5/8] PCI: imx6: Turn off regulator when the system is in
[PATCH v11 6/8] PCI: imx6: Mark the link down as none fatal error
[PATCH v11 7/8] PCI: imx6: Reduce resume time by only starting link
[PATCH v11 8/8] PCI: imx6: Do not hide phy driver callbacks and
