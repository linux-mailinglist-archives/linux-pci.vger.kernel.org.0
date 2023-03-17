Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130256BF4C1
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 22:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCQV5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 17:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCQV5W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 17:57:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD285298D5;
        Fri, 17 Mar 2023 14:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BB01B825C3;
        Fri, 17 Mar 2023 21:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DC6C433EF;
        Fri, 17 Mar 2023 21:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679090211;
        bh=RcXRkLZJ0QUiQo2PkgHUJgLw7K4eCtZTz+7xcLtd8gc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LQ52gPcq7B7KpQewa8arpjOH/RHGDvWniPMgCTUt08BidUSzn57gVqCgbA/UJfQQw
         2noMdjLPJVPIru50MD0BA+8HhW0eI9nnyoNGvJRs7DDOUwHgFjaRwjLzllptVfpR99
         00CFMbcc4AWGYT4e6Gq9L5KRkscAryhZFb3yBBejqT1OvdxwTZ6cVBlXWJrOrY3VMc
         KSTQVL+pLrh1jl1JzsXvmmmdHBKwQvJ/yTtcNznvtoZuRFm4CQ6gZZw9OUqVcHgrp/
         PkoTjUF1DLvgg0dk2YqynfsQYOxQfWr69Env2PfEABv9VkP1IKYrMmwrSpzkq3b6x7
         5h4SCeHq9s9Vg==
Date:   Fri, 17 Mar 2023 16:56:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     lorenzo.pieralisi@arm.com, kw@linux.com, Zhiqiang.Hou@nxp.com,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org
Subject: Re: [PATCH 1/1] PCI: layerscape: Add power management support
Message-ID: <20230317215650.GA1973940@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317200528.2481154-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 17, 2023 at 04:05:28PM -0400, Frank Li wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add PME_Turn_Off/PME_TO_Ack handshake sequence, and finally
> put the PCIe controller into D3 state after the L2/L3 ready
> state transition process completion.

Can you please include a sentence or two about what this means for
devices below the PCIe controller?  Is this guaranteed to be safe for
them, i.e., can all PCIe devices tolerate PME_Turn_Off, etc., and
resume correctly afterwards?

I suspect other drivers will copy this sort of pattern if it is safe
and useful.

>  struct ls_pcie {
>  	struct dw_pcie *pci;
> +	const struct ls_pcie_drvdata *drvdata;
> +	void __iomem *pf_base;
> +	void __iomem *lut_base;
> +	bool big_endian;
> +	bool ep_presence;

This means "any downstream device present", right?  Could be an
Endpoint or could be a Switch Upstream Port?  I guess it's basically a
cache of dw_pcie_link_up() at ls_pcie_host_init()-time.

> +	bool pm_support;
> +	struct regmap *scfg;
> +	int index;
>  };

> +static void ls1021a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
> +{
> +	u32 val;
> +
> +	if (!pcie->scfg) {
> +		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
> +		return;
> +	}
> +
> +	/* Send Turn_off message */
> +	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
> +	val |= PMXMTTURNOFF;
> +	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
> +
> +	/*
> +	 * Components with an upstream port must respond to
> +	 * PME_Turn_Off with PME_TO_Ack but we can't check.
> +	 *
> +	 * The standard recommends a 1-10ms timeout after which to
> +	 * proceed anyway as if acks were received.

Spec citation please.

> +	 */
> +	mdelay(10);
> +
> +	/* Clear Turn_off message */
> +	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
> +	val &= ~PMXMTTURNOFF;
> +	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
> +}

> +static bool ls_pcie_pm_check(struct ls_pcie *pcie)

This is used as a boolean ("if (!ls_pcie_pm_check())") so it needs a
better name.  "Check" doesn't give any hint about what a true or false
return value means.  Something like "pm_supported" *would* give a
hint because "if (!ls_pcie_pm_supported())" is a sensible question to
ask.

> +{
> +	if (!pcie->ep_presence) {
> +		dev_dbg(pcie->pci->dev, "Endpoint isn't present\n");
> +		return false;
> +	}
> +
> +	if (!pcie->pm_support)
> +		return false;

Why test the negative ("!pcie->pm_support") and then return false?
How about:

  if (pcie->pm_support)
    return true;

  return false;

or even better, just:

  return pcie->pm_support;

> +	return true;
> +}
