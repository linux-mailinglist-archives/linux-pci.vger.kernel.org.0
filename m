Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8354D4ED
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350793AbiFOXBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiFOXBS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:01:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23D21242;
        Wed, 15 Jun 2022 16:01:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D699B821A5;
        Wed, 15 Jun 2022 23:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990CFC3411A;
        Wed, 15 Jun 2022 23:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334074;
        bh=RjcmWRwQhZbNhnUkDtDWbV7ROtGcBvDZqWFahbsTuYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OCG3K5JDCEeSTOG4YptWBYN36OhOjDnb7FBKBxf2U88N3WVsEYjrH3PP27QG+ee1u
         btxQv5OZbHxCrWatiL34a11sQY62LiwtG153ZQoeMPr2UQ77vGc52xn95zzKnJDdPK
         J51Pv2rSQ+9m3zVJ6gOyRqESosWwLgCvUt+y8XZlK9gNks6aAaE841ZDBd8WQdcvSA
         YQNSptzulcQ3Ruc71CUZ7MkJ5SPt84hcsDMFNBQnumTRhW+hzQ+tBrc0lF7AaUVcec
         xY/0VSe61TIcXurmxm0RdIPXmTdzOvMoNEnQyFYUOjZ1nT4SpE4A6yweKp2bSb4RMd
         Ya8PILdP1gUpg==
Date:   Wed, 15 Jun 2022 18:01:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v11 0/8] PCI: imx6: refine codes and add the error
 propagation
Message-ID: <20220615230113.GA1054155@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655189942-12678-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 14, 2022 at 02:58:54PM +0800, Richard Zhu wrote:
> This series patches refine pci-imx6 driver and do the following main changes.
> - Encapsulate the clock enable into one standalone function
> - Add the error propagation from host_init and resume
> - Turn off regulator when the system is in suspend mode
> - Let the probe successfully when link never comes up
> - Do not hide the phy driver callbacks in core reset and clk_enable.
> BTW, this series are verified on i.MX8MM EVK board when one NVME is used.

I applied these on pci/ctrl/imx6, but I noticed a few more things
while applying, so I'm going to post a v12 with a little rework for
your approval.

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
> 
> drivers/pci/controller/dwc/pci-imx6.c | 241 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
> 1 file changed, 157 insertions(+), 84 deletions(-)
> [PATCH v11 1/8] PCI: imx6: Encapsulate the clock enable into one
> [PATCH v11 2/8] PCI: imx6: Add the error propagation from host_init
> [PATCH v11 3/8] PCI: imx6: Move imx6_pcie_clk_disable() earlier
> [PATCH v11 4/8] PCI: imx6: Disable iMX6QDL PCIe REF clock when
> [PATCH v11 5/8] PCI: imx6: Turn off regulator when the system is in
> [PATCH v11 6/8] PCI: imx6: Mark the link down as none fatal error
> [PATCH v11 7/8] PCI: imx6: Reduce resume time by only starting link
> [PATCH v11 8/8] PCI: imx6: Do not hide phy driver callbacks and
