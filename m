Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1033154A0C8
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbiFMVFm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353300AbiFMVFK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:05:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57112618;
        Mon, 13 Jun 2022 13:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E491B815AA;
        Mon, 13 Jun 2022 20:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA53BC34114;
        Mon, 13 Jun 2022 20:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655152885;
        bh=DtUBLCpqiFD/uEnfXEFgkHOj+PJpXolzAMo1fE5cIyQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CrIwV0BJMOvNKe8nLYvYEguwyu7+7BTrDPHrnYx54x2U/d1TqFVmB8i8paOrzOp9g
         I3stVkmVZQAVBpGJUtKotb1uZVBv3QloPQ4q436RynozkzF0H+4uAMlFIXrLLS0Hi6
         ONP3xxiksrvk7BSKyEotDgyhk+KAqWDgF3yut41Z8ywJpJsVCCoZ8X4VxeoLWcVmFW
         qaKM7wPITKustfnmaposwtRnDb34mmVYpzcFKnHRaKIlc+kP66bXgOGdeRrA9lMAbo
         qEcyZJQ6EYkVPxfXuaW5bHkjjuYlYrKidqxXNvGq5zVcOVoizr001/Q5zYjDMoa7y3
         HnLtJINegrx1A==
Date:   Mon, 13 Jun 2022 15:41:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v10 0/7] PCI: imx6: refine codes and add the error
 propagation
Message-ID: <20220613204123.GA716053@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655110538-10914-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 04:55:31PM +0800, Richard Zhu wrote:
> This series patches refine pci-imx6 driver and do the following main changes.
> - Encapsulate the clock enable into one standalone function
> - Add the error propagation from host_init and resume
> - Turn off regulator when the system is in suspend mode
> - Let the probe successfully when link never comes up
> - Do not hide the phy driver callbacks in core reset and clk_enable.

This doesn't apply on v5.19-rc1 for me.  Am I missing something:

  03:38:06 ~/linux (main)$ git checkout -b wip/richard-imx6-power-v10 v5.19-rc1
  Switched to a new branch 'wip/richard-imx6-power-v10'
  03:38:14 ~/linux (wip/richard-imx6-power-v10)$ b4 am -om/ https://lore.kernel.org/r/1655110538-10914-1-git-send-email-hongxing.zhu@nxp.com
  Looking up https://lore.kernel.org/r/1655110538-10914-1-git-send-email-hongxing.zhu%40nxp.com
  Analyzing 9 messages in the thread
  Checking attestation on all messages, may take a moment...
  ---
    [PATCH v10 1/7] PCI: imx6: Encapsulate the clock enable into one standalone function
    [PATCH v10 2/7] PCI: imx6: Add the error propagation from host_init
    [PATCH v10 3/7] PCI: imx6: Move imx6_pcie_clk_disable() earlier
    [PATCH v10 4/7] PCI: imx6: Disable iMX6QDL PCIe REF clock when disable PCIe clocks
    [PATCH v10 5/7] PCI: imx6: Turn off regulator when the system is in suspend mode
    [PATCH v10 6/7] PCI: imx6: Mark the link down as none fatal error
    [PATCH v10 7/7] PCI: imx6: Do not hide phy driver callbacks and refine the error handling
  ---
  Total patches: 7
  ---
  Cover: m/v10_20220613_hongxing_zhu_pci_imx6_refine_codes_and_add_the_error_propagation.cover
   Link: https://lore.kernel.org/r/1655110538-10914-1-git-send-email-hongxing.zhu@nxp.com
   Base: not specified
	 git am m/v10_20220613_hongxing_zhu_pci_imx6_refine_codes_and_add_the_error_propagation.mbx
  03:38:27 ~/linux (wip/richard-imx6-power-v10)$ git am m/v10_20220613_hongxing_zhu_pci_imx6_refine_codes_and_add_the_error_propagation.mbx
  Applying: PCI: imx6: Encapsulate the clock enable into one standalone function
  error: patch failed: drivers/pci/controller/dwc/pci-imx6.c:539
  error: drivers/pci/controller/dwc/pci-imx6.c: patch does not apply
  Patch failed at 0001 PCI: imx6: Encapsulate the clock enable into one standalone function
  hint: Use 'git am --show-current-patch' to see the failed patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".

