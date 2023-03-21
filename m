Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2596C3C57
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 21:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCUU7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 16:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCUU7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 16:59:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B64170E;
        Tue, 21 Mar 2023 13:59:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AC04B81A06;
        Tue, 21 Mar 2023 20:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C9FC433EF;
        Tue, 21 Mar 2023 20:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679432350;
        bh=U2nlH3LUzDvD9qs2WLh0pyrk82Sg3pNDNbGG12XhlYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SYNv6yt/XGQnYUI14pSX9O9P3lkJxNUfXDWzEt25/zjAKgOzR0zg8tAUwrYuonUpH
         ag/wmz2lIsdyWQFCViGxmv64iivY0CKmNZsV00vSAfYWGHQm2/I10US3YajAWbTMHr
         1jhuAaL5tHB//Q0acQNbXQClTlL6KE3LaGXipefr/PwKRZsPSSo4XbUK++Dd2tQOIh
         5FdGdDNviZG0R0duoaJJw9A5iicviRdSauQFUHpp6eaGavy54oBRZkvIqj7x+qr+DH
         h3cPwAdInFSggA5JDkzXc8X4rw2lENFhW2HvjPtumKVLBEeHdpuaO2W/EiM5Kethk5
         8Qfx8NKsWHthg==
Date:   Tue, 21 Mar 2023 15:59:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, leoyang.li@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        kw@linux.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v2 1/1] PCI: layerscape: Add power management support
Message-ID: <20230321205909.GA2409982@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321160220.2785909-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 21, 2023 at 12:02:20PM -0400, Frank Li wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add PME_Turn_Off/PME_TO_Ack handshake sequence to PCIe devices, such as
> NVME or wifi module, and finally put the PCIe controller into D3 state
> after the L2/L3 ready state transition process completion.
> 
> However, it's important to note that not all devices may be able to
> tolerate the PME_Turn_Off command. In general, fixed PCIe devices
> connected to Layerscape, such as NXP wifi devices, are able to handle
> this command.

I know this paragraph is here because I asked whether all PCIe devices
could tolerate PME_Turn_Off.  I don't know much about that level of
the protocol, but it does look to me like PME_Turn_Off is required,
e.g., PCIe r6.0, sec 5.3.3.2.1, 5.3.3.4.

So I'm not sure this paragraph adds anything useful.  If the spec
requires it, this paragraph is like saying "it's important to note
that some PCIe devices may not follow the spec," which is pointless.

This functionality results in any downstream devices being put in
D3cold, right?  I think that *would* be worth mentioning.  There are a
few cases where we try to avoid putting devices in D3cold, e.g.,
no_d3cold, and I suspect this functionality would put them in D3cold
regardless of no_d3cold.  Those are corner cases that you would
probably never see on your platform, so a brief mention here is
probably enough.

> +static void ls_pcie_set_dstate(struct ls_pcie *pcie, u32 dstate)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> +	u32 val;
> +
> +	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
> +	val &= ~PCI_PM_CTRL_STATE_MASK;
> +	val |= dstate;
> +	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);

Is this a power management register for the *Root Port*, i.e., as
defined by PCIe r6.0 sec 7.5.2?

Or is it a similar register for the *Root Complex* as a whole that is
defined by a Layerscape or DesignWare spec and coincidentally uses the
same Capability ID and control register layout as the PCIe one?

The Root Port programming model is defined by the PCIe spec.  Things
like .send_turn_off_message() and .exit_from_l2() are clearly part of
the Root *Complex* programming model that is device-specific and not
defined by the PCIe spec.

I'm asking about ls_pcie_set_dstate() because it's written using the
PCIe constants (PCI_CAP_ID_PM, PCI_PM_CTRL, etc) but it's mixed in
with these Root Complex things that are *not* part of the PCIe spec.

> +static bool ls_pcie_pm_supported(struct ls_pcie *pcie)
> +{
> +	if (!dw_pcie_link_up(pcie->pci)) {
> +		dev_dbg(pcie->pci->dev, "Endpoint isn't present\n");
> +		return false;
> +	}
> +
> +	return pcie->pm_support;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ls_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct ls_pcie *pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = pcie->pci;
> +	u32 val;
> +	int ret;
> +
> +	if (!ls_pcie_pm_supported(pcie))
> +		return 0;
> +
> +	pcie->drvdata->pm_ops->send_turn_off_message(pcie);
> +
> +	/* 10ms timeout to check L2 ready */
> +	ret = readl_poll_timeout(pci->dbi_base + PCIE_PORT_DEBUG0,
> +				 val, LS_PCIE_IS_L2(val), 100, 10000);
> +	if (ret) {
> +		dev_err(dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
> +		return ret;
> +	}
> +
> +	ls_pcie_set_dstate(pcie, 0x3);
> +
> +	return 0;
> +}
> +
> +static int ls_pcie_resume_noirq(struct device *dev)
> +{
> +	struct ls_pcie *pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = pcie->pci;
> +	int ret;
> +
> +	if (!ls_pcie_pm_supported(pcie))
> +		return 0;

How does this work?  You're checking whether the link is up *here*,
and if it's already up, you go on below to (I guess) set the PCIe
controller to D0, call dw_pcie_setup_rc() and dw_pcie_wait_for_link().
Most drivers call dw_pcie_setup_rc() *before* starting the link.

It looks like when you call ls_pcie_pm_supported() here,
dw_pcie_link_up() should always return false because the link isn't up
so it looks like there's no downstream device.  But I must be missing
something because if that were the case you would never wake anything
up below.

> +	ls_pcie_set_dstate(pcie, 0x0);
> +
> +	pcie->drvdata->pm_ops->exit_from_l2(pcie);
> +
> +	ret = ls_pcie_host_init(&pci->pp);
> +	if (ret) {
> +		dev_err(dev, "PCIe host init failed! ret = 0x%x\n", ret);
> +		return ret;
> +	}
> +
> +	dw_pcie_setup_rc(&pci->pp);
> +
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret) {
> +		dev_err(dev, "Wait link up timeout! ret = 0x%x\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
