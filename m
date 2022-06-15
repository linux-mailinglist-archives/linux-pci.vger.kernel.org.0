Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AAA54D506
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbiFOXQH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiFOXQG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BB22E9D2;
        Wed, 15 Jun 2022 16:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34B4DB821A6;
        Wed, 15 Jun 2022 23:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFC2C3411A;
        Wed, 15 Jun 2022 23:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334962;
        bh=4iqUq80JHkaYbQjG2AjRBlCG484tE/MeaqdTss1Lc6c=;
        h=From:To:Cc:Subject:Date:From;
        b=sGNb02zcGKRugHeeoUEtGtB6LFwJ91bFbh8DFNlV1OomkcKRZZk0gHsPfh/bmhajb
         ekns+ZrQkYc6WCqYfB2w3WbVdgIjtmtNIrgdbwJUU2HK949lSHMMmUGFA8v+8CXE4a
         9NAR3YWTCAZyDNnBrU0y1oB0+8f81yOEpeijBAjyoT0SyKyz4+MuJgQFo17k0kEI3M
         cR+n4fYA+jXmAzp5rzyJVchs27Dui2tW4xUwHksuKpnTj5nOmJ1FMcH6teE7Q/vq5w
         lvOH0B212cWYlU9HqKU1gDhEs2+g7RIRGlVguOexjuMsLtJ56KqN0o+EA0iRVC8Hi9
         hjy3bMqo5kOEw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 00/13] PCI: imx6: refine codes and add the error propagation
Date:   Wed, 15 Jun 2022 18:15:38 -0500
Message-Id: <20220615231551.1054753-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is a v12 of Richard's series with this description:

> This series patches refine pci-imx6 driver and do the following main changes.
> - Encapsulate the clock enable into one standalone function
> - Add the error propagation from host_init and resume
> - Turn off regulator when the system is in suspend mode
> - Let the probe successfully when link never comes up
> - Do not hide the phy driver callbacks in core reset and clk_enable.
> BTW, this series are verified on i.MX8MM EVK board when one NVME is used.

Main changes from v11 to v12:
  - Add four intro patches to move code around to collect similar things
    (PHY management, reset management) together.  This makes the first
    diff to collect clock enables simpler because it's not cluttered with
    unrelated things that didn't actually change.
  - Factor out ref clock disables so the disable function structure matches
    the enable structure.
  - Drop unused "ret" from "Reduce resume time ..." to avoid bisection
    hole, then add it back in "Do not hide phy driver ..." where we start
    using it again.
  - Add patch to make imx6_pcie_clk_disable() symmetric with
    imx6_pcie_clk_enable() in terms of enable/disable ordering.

> Main changes from v10 to v11:
> No code changes, just do the following operations refer to Bjorn's comments.
>   - Split #6 patch into two patches.
>   - Rebase to v5.19-rc1 based on for-next branch of Shawn's git.
> 
> Main changes from v9 to v10:
> - Add the "Reviewed-by: Lucas Stach <l.stach@pengutronix.de>" tag into #3
>   and #4 patches.
> - Refer to Bjorn's comments:
>   - refine the commit of the first patch
>   - keep alignment of the message format in the second patch
>   - More specific commit and subject of the #5 and #7 patches.
> - Move the regualtor_disable into suspend, turn off the regulator when bus
>   is powered off and system in suspend mode.
> - Let the driver probe successfully, return zero in imx6_pcie_start_link()
>   when PCIe link is down. 
>   In this link down scenario, only start the PCIe link training in resume
>   when the link is up before system suspend to avoid the long latency in
>   the link training period.
> - Don't hide phy driver callbacks in core reset and clk_enable, and refine
>   the error handling accordingly.
> - Drop the #8 patch of v9 series, since the clocks and powers are not gated
>   off anymore when link is down.
> 
> Main changes from v8 to v9:
> - Don't change pcie-designware codes, and do the error exit process only in
>   pci-imx6 driver internally.
> - Move the phy driver callbacks to the proper places
> 
> Main changes from v7 to v8:
> Regarding Bjorn's review comments.
> - Align the format of the dev_info message and refine commit log of
>   #6/7/8 patches.
> - Rename the err_reset_phy label, since there is no PHY reset in the out
> 
> Main changes from v6 to v7:
> - Keep the regulator usage counter balance in the #5 patch of v6 series.
> 
> Main changes from v5 to v6:
> - Refer to the following discussion with Fabio, fix the dump by his patch.
>   https://patchwork.kernel.org/project/linux-pci/patch/1641368602-20401-6-git-send-email-hongxing.zhu@nxp.com/
>   Refine and rebase this patch-set after Fabio' dump fix patch is merged.
> - Add one new #4 patch to disable i.MX6QDL REF clock too when disable clocks
> - Split the regulator refine codes into one standalone patch #5 in this version.
> 
> Main changes from v4 to v5:
> - Since i.MX8MM PCIe support had been merged. Based on Lorenzo's git repos,
>   resend the patch-set after rebase.
> 
> Main changes from v3 to v4:
> - Regarding Mark's comments, delete the regulator_is_enabled() check.
> - Squash #3 and #6 of v3 patch into #5 patch of v4 set.
> 
> Main changes from v2 to v3:
> - Add "Reviewed-by: Lucas Stach <l.stach@pengutronix.de>" tag into
>   first two patches.
> - Add a Fixes tag into #3 patch.
> - Split the #4 of v2 to two patches, one is clock disable codes move,
>   the other one is the acutal clock unbalance fix.
> - Add a new host_exit() callback into dw_pcie_host_ops, then it could be
>   invoked to handle the unbalance issue in the error handling after
>   host_init() function when link is down.
> - Add a new host_exit() callback for i.MX PCIe driver to handle this case
>   in the error handling after host_init.
> 
> Main changes from v1 to v2:
> Regarding Lucas' comments.
>   - Move the placement of the new imx6_pcie_clk_enable() to avoid the
>     forward declarition.
>   - Seperate the second patch of v1 patch-set to three patches.
>   - Use the module_param to replace the kernel command line.
> Regarding Bjorn's comments:
>   - Use the cover-letter for a multi-patch series.
>   - Correct the subject line, and refine the commit logs. For example,
>     remove the timestamp of the logs.

Bjorn Helgaas (5):
  PCI: imx6: Move imx6_pcie_grp_offset(), imx6_pcie_configure_type()
    earlier
  PCI: imx6: Move PHY management functions together
  PCI: imx6: Move imx6_pcie_enable_ref_clk() earlier
  PCI: imx6: Factor out ref clock disable to match enable
  PCI: imx6: Disable clocks in reverse order of enable

Richard Zhu (8):
  PCI: imx6: Move imx6_pcie_clk_disable() earlier
  PCI: imx6: Collect clock enables in imx6_pcie_clk_enable()
  PCI: imx6: Propagate .host_init() errors to caller
  PCI: imx6: Disable i.MX6QDL clock when disabling ref clocks
  PCI: imx6: Turn off regulator when system is in suspend mode
  PCI: imx6: Mark the link down as non-fatal error
  PCI: imx6: Reduce resume time by only starting link if it was up
    before suspend
  PCI: imx6: Do not hide phy driver callbacks and refine the error
    handling

 drivers/pci/controller/dwc/pci-imx6.c | 606 +++++++++++++++-----------
 1 file changed, 342 insertions(+), 264 deletions(-)

-- 
2.25.1

