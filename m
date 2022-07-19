Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D787557AA41
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 01:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbiGSXLF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 19:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiGSXLE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 19:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D113275FA;
        Tue, 19 Jul 2022 16:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4290609FB;
        Tue, 19 Jul 2022 23:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9EAC341C6;
        Tue, 19 Jul 2022 23:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658272261;
        bh=SILE2Uf05N+hXwooEnGRd9dVKavfRJ4L+hm1oY80Jow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bspYiaxgsVhdVPLVSuLrqojP/Sa/fCUWvaUwM8wfSa2d9mphEFlKitZv6oE8CRZvE
         asworTjG0vWTKG3B8qo0IzpECWCLOC33txj0F3MXA8fZyywh1vQIFpcv1metKcR7Cl
         z+hWenwuWcYKkMJlK7sOaPQTGFj2e4C5pP14p6EIfnKo3Fsha5LLgG82KUBOk+yJv1
         brSkHXqlkD9xe97C0hIlWkbPcrAglqF8OxtMHWET0XC5vagTKdZmZcIYPR5AzaN7Dy
         lIFSpV27D/LsjepSLOpnfv2B+G3klSsHHAjsAaZZ/BXfsIEMR586l8pC4Sa6CVuud+
         cejevhtQ0QQTA==
Date:   Tue, 19 Jul 2022 18:10:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
        bhelgaas@google.com, robh+dt@kernel.org, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v15 17/17] PCI: imx6: Reformat suspend callback to keep
 symmetric with resume
Message-ID: <20220719231059.GA1590187@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718131900.GA4002775@roeck-us.net>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 06:19:00AM -0700, Guenter Roeck wrote:
> On Thu, Jul 14, 2022 at 03:31:09PM +0800, Richard Zhu wrote:
> > Create imx6_pcie_stop_link() and imx6_pcie_host_exit() functions.
> > Encapsulate clocks, regulators disables and PHY uninitialization into
> > imx6_pcie_host_exit().
> > 
> > To keep suspend/resume symmetric as much as possible, invoke these two
> > new created functions in suspend callback.
> > 
> > To be symmetric with imx6_pcie_host_exit(), move imx6_pcie_clk_enable()
> > to imx6_pcie_host_init() from imx6_pcie_deassert_core_reset().
> > 
> > Link: https://lore.kernel.org/r/1656645935-1370-18-git-send-email-hongxing.zhu@nxp.com
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> 
> If CONFIG_PM_SLEEP=n:
> 
> Error log:
> drivers/pci/controller/dwc/pci-imx6.c:973:13: error: 'imx6_pcie_host_exit' defined but not used [-Werror=unused-function]
>   973 | static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
>       |             ^~~~~~~~~~~~~~~~~~~
> drivers/pci/controller/dwc/pci-imx6.c:904:13: error: 'imx6_pcie_stop_link' defined but not used [-Werror=unused-function]
>   904 | static void imx6_pcie_stop_link(struct dw_pcie *pci)

Thanks, Guenter, I added a patch that should fix this:
https://lore.kernel.org/r/20220719210427.GA1568454@bhelgaas
