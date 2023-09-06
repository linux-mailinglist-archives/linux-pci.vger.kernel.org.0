Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49007941E5
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbjIFRMT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjIFRMR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 13:12:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCB81998;
        Wed,  6 Sep 2023 10:12:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BE9C433C8;
        Wed,  6 Sep 2023 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694020333;
        bh=6qE2Q4/atC55i1H6dYfBesBmcKopLfm2pz+aZeXFQ2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DwkOcC8gHrOgLq7zzce7tTdFCw+TO40y7Uhdrz8IM+s1i67NClqGOOilTOS/mVuue
         vxakKwPUMdsrLoR+0Lj5M6Q8wckbEnvpN1tZgTqpS07rBj7Y7Cp0Mh8sl42TCU5RJZ
         KqY1QQahlHr8dLff/uso80ntevVNt9DszpRLIsxry2W+cc+H/iWhkyPGYhMPrnwmwd
         PiuIxyBHYqNtewucjtihEp8RBiS6XgKnRdqJtmrG88XM1IqzCvpRrfOiaAXPQK9uHR
         B37MAZcoKadPzMcVXE/KaRQ/wOWkdQ0kbHM0wXddZV/zY09DLpnm5fn5B2ZgYHtPPL
         GjuhVBzNrs3JA==
Date:   Wed, 6 Sep 2023 12:12:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sharath.kumar.d.m@intel.com
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPGA
Message-ID: <20230906171211.GA230112@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906110918.1501376-3-sharath.kumar.d.m@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Capitalize subject line similarly.

s/suport/support/

On Wed, Sep 06, 2023 at 04:39:18PM +0530, sharath.kumar.d.m@intel.com wrote:
> From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>

Needs a commit log.  It's ok to repeat the subject line.

> +#define AGLX_BDF_REG 0x00002004
> +#define AGLX_ROOT_PORT_IRQ_STATUS 0x14c
> +#define AGLX_ROOT_PORT_IRQ_ENABLE 0x150
> +#define CFG_AER                   (1<<4)

This seems to be AGLX-specific so maybe should have a prefix?

> +static u32 port_conf_off;

port_conf_off looks like something that should be per-controller.

> +static int aglx_rp_read_cfg(struct altera_pcie *pcie, u8 busno, u32 devfn,
> +			int where, int size, u32 *value)
> +{
> +	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
> +
> +	switch (size) {
> +	case 1:
> +		*value = readb(addr);
> +		break;
> +	case 2:
> +		*value = readw(addr);
> +		break;
> +	default:
> +		*value = readl(addr);
> +		break;
> +	}
> +
> +	/* interrupt pin not programmed in hardware
> +	 */

Use single-line comment style:

  /* interrupt pin not programmed in hardware */

> +	if (where == 0x3d)
> +		*value = 0x01;
> +	if (where == 0x3c)
> +		*value |= 0x0100;

Use PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.

> +	return PCIBIOS_SUCCESSFUL;
> +}

> +static void aglx_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct altera_pcie *pcie;
> +	struct device *dev;
> +	u32 status;
> +	int ret;
> +
> +	chained_irq_enter(chip, desc);
> +	pcie = irq_desc_get_handler_data(desc);
> +	dev = &pcie->pdev->dev;
> +
> +	status = readl((pcie->hip_base + port_conf_off
> +		+ AGLX_ROOT_PORT_IRQ_STATUS));
> +	if (status & CFG_AER) {
> +		ret = generic_handle_domain_irq(pcie->irq_domain, 0);
> +		if (ret)
> +			dev_err_ratelimited(dev, "unexpected IRQ,\n");

Remove the comma at end (or maybe you meant to add something else?)
Looks like the place it was copied from had "unexpected IRQ, INT%d".

> +	if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
> +		pcie->cs_base =
> +			devm_platform_ioremap_resource_byname(pdev, "Cs");
> +		if (IS_ERR(pcie->cs_base))
> +			return PTR_ERR(pcie->cs_base);
> +		of_property_read_u32(pcie->pdev->dev.of_node, "port_conf_stat",
> +			&port_conf_off);
> +		dev_info(&pcie->pdev->dev, "port_conf_stat_off =%x\n", port_conf_off);

Is this a debug message?  Doesn't look like something we need all the
time.  If you want it all the time, use %#x so it's clear that it's
hex.

> +static const struct altera_pcie_data altera_pcie_3_0_data = {
> +	.ops = &altera_pcie_ops_3_0,
> +	.version = ALTERA_PCIE_V3,
> +	.cap_offset = 0x70,

> +	.cfgrd0 = 0,
> +	.cfgrd1 = 0,
> +	.cfgwr0 = 0,
> +	.cfgwr1 = 0,

cfgrd0, ..., cfgwr1 aren't used here, so no need to initialize them.
