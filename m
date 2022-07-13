Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75279573B80
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 18:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbiGMQqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiGMQp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 12:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547CA2F3AC;
        Wed, 13 Jul 2022 09:45:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E1661C39;
        Wed, 13 Jul 2022 16:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CDBC341C6;
        Wed, 13 Jul 2022 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657730756;
        bh=YyGcbZI3NL+Y5QVRHRBFY4N+xrsu0kQktnkufuB1ylA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JtQcrHn+iu4Eljtfil3G+w7ZnCIPnV/De30FpvG+OHvYj36UIb5UT1YpVDdafVwMo
         Uj5us1IxN+NAxZQkdLOWXkYXyJCNdoroNMnLxH9GCEAqEmodRqoub0jmLGJF39/c/m
         wq/R4WRukhVKfYaXhp5aa6gXbwyVN17Jw453LpwclumMbDgcdc8pOflJMzCvabaY0N
         QVUOTicRojC0z4KssmMQHp7MkPqjNE0GGLTZ05ZvNvlv8fmZm4D3m/hPuLxsSNX0zb
         RQIxkEIYqOAVEVmfxxjfob6rrr+pg+oHO17nC2ebQJM0cJlqCj2c+mOgyMR+hJcmoi
         ub+5AYgaFGhug==
Date:   Wed, 13 Jul 2022 11:45:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v14 0/17] PCI: imx6: refine codes and add the error
 propagation
Message-ID: <20220713164554.GA833183@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711222959.GA701423@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 11, 2022 at 05:29:59PM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 01, 2022 at 11:25:18AM +0800, Richard Zhu wrote:
> > ...

> > Bjorn Helgaas (5):
> >   PCI: imx6: Move imx6_pcie_grp_offset(), imx6_pcie_configure_type()
> >     earlier
> >   PCI: imx6: Move PHY management functions together
> >   PCI: imx6: Move imx6_pcie_enable_ref_clk() earlier
> >   PCI: imx6: Factor out ref clock disable to match enable
> >   PCI: imx6: Disable clocks in reverse order of enable
> > 
> > Richard Zhu (12):
> >   PCI: imx6: Move imx6_pcie_clk_disable() earlier
> >   PCI: imx6: Collect clock enables in imx6_pcie_clk_enable()
> >   PCI: imx6: Propagate .host_init() errors to caller
> >   PCI: imx6: Disable i.MX6QDL clock when disabling ref clocks
> >   PCI: imx6: Call host init function directly in resume
> >   PCI: imx6: Turn off regulator when system is in suspend mode
> >   PCI: imx6: Move regulator enable out of
> >     imx6_pcie_deassert_core_reset()
> >   PCI: imx6: Mark the link down as non-fatal error
> >   PCI: imx6: Reduce resume time by only starting link if it was up
> >     before suspend
> >   PCI: imx6: Do not hide phy driver callbacks and refine the error
> >     handling
> >   PCI: imx6: Reformat suspend callback to keep symmetric with resume
> >   PCI: imx6: Move the imx6_pcie_ltssm_disable() earlier
> > 
> > drivers/pci/controller/dwc/pci-imx6.c | 661 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------------------
> > 1 file changed, 358 insertions(+), 303 deletions(-)
> 
> Applied to pci/ctrl/imx6 for v5.20, thanks a lot for all your work
> here!

I updated the branch with Lucas' acks and with the minor
imx6_pcie_start_link() return value check he suggested.

I did not do anything about the missing IMX8MQ case in
imx6_pcie_ltssm_disable() or the PHY init or regulator or shutdown
issues.  If you want changes there, please make them starting with the
pci/ctrl/imx6 branch and I can just replace it:

  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/imx6&id=7d652ce95e70

Bjorn
