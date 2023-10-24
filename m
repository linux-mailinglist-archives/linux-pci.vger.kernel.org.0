Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBBA7D59F8
	for <lists+linux-pci@lfdr.de>; Tue, 24 Oct 2023 19:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjJXRw7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJXRw6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 13:52:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8192810D3;
        Tue, 24 Oct 2023 10:52:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBD1C433C7;
        Tue, 24 Oct 2023 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698169976;
        bh=KUF7e+OQ3Cmah38SMoodhEwyDPQhM9qKHEvTf9JRMLA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=szEiV2H2y6V69DSMmIjRsYCrp7HLNV/OYuRJb36ATW03CYFhw7JwfTZ7CE3WiiunT
         IoMGGD+iW3gjfdM5coQnjSmuYY57kaitDfZG+vVWYuEmpF/W/TrEudTZP5J3hDKRpz
         nTzMTiUHC3esNZ+ZqhB+LxOwRpxcbNgCohlcUegpEXuT3LncyOCpGY3CCJUvOThe/h
         hyN+7Dv1qPOApEdX2Xif3Rbb72hl53NwpT/I2Bf0OHRQZaNG0VYw8ZDsqi4wy2zq2P
         ixonxQTg+4Y7pKbQo8XdnBSzp/FiAHOgGLpH/jRqE2WRPdazUQFCecbe7oiv5iB+zU
         xqeGovmWrEOTg==
Date:   Tue, 24 Oct 2023 12:52:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v9 19/20] PCI: starfive: Add JH7110 PCIe controller
Message-ID: <20231024175253.GA1662387@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020104341.63157-20-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 20, 2023 at 06:43:40PM +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller platform
> driver codes, JH7110 with PLDA host PCIe core.

Wrap all your commit logs to fill about 75 columns (as suggested
before).  "git log" adds a few spaces, so if you fill to 75 columns,
the result will still fit in a default 80 column window.

> +config PCIE_STARFIVE_HOST
> +	tristate "StarFive PCIe host controller"
> +	depends on OF && PCI_MSI
> +	select PCIE_PLDA_HOST
> +	help
> +	  Say Y here if you want to support the StarFive PCIe controller
> +	  in host mode. StarFive PCIe controller uses PLDA PCIe
> +	  core.

Add blank line between paragraphs.  Wrap to fill 75-78 columns.

> +	  If you choose to build this driver as module it will
> +	  be dynamically linked and module will be called
> +	  pcie-starfive.ko

> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -6,14 +6,26 @@
>  #ifndef _PCIE_PLDA_H
>  #define _PCIE_PLDA_H
>  
> +#include <linux/phy/phy.h>

I don't think you need to #include this.  In this file you only use a
pointer to struct phy, so declaring the struct should be enough, e.g.,

  struct phy;

You will have to #include it in pcie-starfive.c where you actually
*use* phy, of course.

> +#define CONFIG_SPACE_ADDR			0x1000u

This looks like an *offset* that you add to ->bridge_addr.  Adding two
addresses together doesn't really make sense.

> +static int starfive_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> +				      int where, int size, u32 value)
> +{
> +	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;

I think this should probably return PCIBIOS_SUCCESSFUL.  There's
nothing wrong with the register number; you just want to pretend that
it's hardwired to zero.  That means ignore writes and always return 0
for reads.

> +	return pci_generic_config_write(bus, devfn, where, size, value);
> +}
> +
> +static int starfive_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +				     int where, int size, u32 *value)
> +{
> +	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;

Set *value to zero and return PCIBIOS_SUCCESSFUL.

> +	return pci_generic_config_read(bus, devfn, where, size, value);
> +}
> +
> +static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie, struct device *dev)

95% of this driver (and the rest of drivers/pci) is wrapped to fit in
80 columns, e.g.,

  static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie,
                                    struct device *dev)

> +	domain_nr = of_get_pci_domain_nr(dev->of_node);
> +
> +	if (domain_nr < 0 || domain_nr > 1)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "failed to get valid pcie id\n");

"id" is too generic and doesn't hint about where the problem is.
Update the message ("pcie id") to mention "domain" so it corresponds
with the source ("linux,pci-domain" from DT).

> +	ret = reset_control_deassert(pcie->resets);
> +	if (ret) {
> +		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> +		dev_err_probe(dev, ret, "failed to resets\n");

"failed to ... resets" is missing a word.  "Failed to deassert
resets", I guess?

> +	/* Ensure that PERST has been asserted for at least 100 ms,
> +	 * the sleep value is T_PVPERL from PCIe CEM spec r2.0 (Table 2-4)
> +	 */

Use multiline comment formatting (also below):

  /*
   * Ensure ...
   */

> +	msleep(100);
> +	if (pcie->reset_gpio)
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +
> +	/* As the requirement in PCIe base spec r6.0, system (<=5GT/s) must
> +	 * wait a minimum of 100 ms following exit from a conventional reset
> +	 * before sending a configuration request to the device.

Mention sec 6.6.1, where (I think) this value comes from.  Eventually
we should make a #define for this because it's not specific to any one
PCIe controller.

> +	msleep(100);
> +
> +	if (starfive_pcie_host_wait_for_link(pcie))
> +		dev_info(dev, "port link down\n");
> +
> +	return ret;

We know the value here, so return it explicitly:

  return 0;

> +static int starfive_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
> +
> +	if (!pcie)
> +		return 0;

How could it happen that "pcie" is zero?  I think it could only happen
if there were a driver bug or a memory corruption.  Either way, we
should remove the check so we take a NULL pointer fault and find out
about the problem.

> +static int starfive_pcie_resume_noirq(struct device *dev)
> +{
> +	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = starfive_pcie_enable_phy(dev, &pcie->plda);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clocks\n");
> +		starfive_pcie_disable_phy(&pcie->plda);
> +		return ret;
> +	}
> +
> +	return ret;

  return 0;

Bjorn
