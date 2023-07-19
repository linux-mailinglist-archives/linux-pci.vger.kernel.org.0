Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F15B759B5C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 18:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGSQtF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 12:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGSQtB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 12:49:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9501110CB;
        Wed, 19 Jul 2023 09:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15A756178E;
        Wed, 19 Jul 2023 16:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94CAC433C7;
        Wed, 19 Jul 2023 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689785334;
        bh=1HBKVki0O0wNw4bhjdzJwsp6wEBaBoJaQE76IJ1szgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=X7N2d/2yj1WdtbiS2soZExEPhMcqvLSQZB7JPhkGBwOS0KQAbfIVhRHHVOtWqE1W4
         bqnZ5DmTLWWAcgya0/zqzoRPSuSBUYb1PPQF713srTHra/T2B0s4ao2xvIyXKYLbG8
         1ogSJKWzjC0cPH91ZlqUuoTH7sifnzDyRqqY4lkbYtMnEDg/uRNZjra7JPNJa5xn5H
         I/qkeXMNDlog4n3EmwXpZZ7/3WXAF4kjh/VD16ugzOUPOYSmBH0VjSyQAmJ/k+r6zX
         kgeOcEHp7paSGLoPh9D7OmG1DZSiDwz9b2axobKpjT5hh+5px6AknnKCSIf5rQKixF
         GEatizIpbiXeA==
Date:   Wed, 19 Jul 2023 11:48:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
Message-ID: <20230719164851.GA505840@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719102057.22329-9-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 06:20:56PM +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller platform
> driver codes.

Rewrap all the commit logs to fill 75 columns or so.

>  #define PCIE_PCI_IDS_DW1		0x9c
> -
> +#define  IDS_CLASS_CODE_SHIFT		16
> +#define PCI_MISC			0xB4

Surrounding code uses lower-case hex.  Make it all match.

> +#define STG_SYSCON_AXI4_SLVL_ARFUNC_MASK	GENMASK(22, 8)
> +#define STG_SYSCON_AXI4_SLVL_ARFUNC_SHIFT	8

When practical, use FIELD_GET() and FIELD_PREP() to avoid the need for
*_SHIFT macros.

> +struct starfive_jh7110_pcie {
> +	struct plda_pcie	plda;
> +	struct reset_control *resets;
> +	struct clk_bulk_data *clks;
> +	struct regmap *reg_syscon;
> +	struct gpio_desc *power_gpio;
> +	struct gpio_desc *reset_gpio;
> +
> +	u32 stg_arfun;
> +	u32 stg_awfun;
> +	u32 stg_rp_nep;
> +	u32 stg_lnksta;
> +
> +	int num_clks;

If you indent one member with tabs, e.g., "struct plda_pcie        plda",
they should all be indented to match.

> + * The BAR0/1 of bridge should be hidden during enumeration to
> + * avoid the sizing and resource allocation by PCIe core.
> + */
> +static bool starfive_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
> +				      int offset)
> +{
> +	if (pci_is_root_bus(bus) && !devfn &&
> +	    (offset == PCI_BASE_ADDRESS_0 || offset == PCI_BASE_ADDRESS_1))
> +		return true;
> +
> +	return false;
> +}
> +
> +int starfive_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> +			       int where, int size, u32 value)
> +{
> +	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;

I think you are trying present BARs 0 & 1 as unimplemented.  Such BARs
are hardwired to zero, so you should make them behave that way (both
read and write).  Many callers of config accessors don't check the
return value, so I don't think it's reliable to just return
PCIBIOS_BAD_REGISTER_NUMBER.

> +static int starfive_pcie_is_link_up(struct starfive_jh7110_pcie *pcie)
> +{
> +	struct device *dev = pcie->plda.dev;
> +	int ret;
> +	u32 stg_reg_val;
> +
> +	/* 100ms timeout value should be enough for Gen1/2 training */
> +	ret = regmap_read_poll_timeout(pcie->reg_syscon,
> +				       pcie->stg_lnksta,
> +				       stg_reg_val,
> +				       stg_reg_val & DATA_LINK_ACTIVE,
> +				       10 * 1000, 100 * 1000);
> +
> +	/* If the link is down (no device in slot), then exit. */
> +	if (ret == -ETIMEDOUT) {
> +		dev_info(dev, "Port link down, exit.\n");
> +		return 0;
> +	} else if (ret == 0) {
> +		dev_info(dev, "Port link up.\n");
> +		return 1;
> +	}

Please copy the naming and style of the "*_pcie_link_up()" functions
in other drivers.  These are boolean functions with no side effects,
including no timeouts.

Some drivers have "*wait_for_link()" functions if polling is needed.

> +		return dev_err_probe(dev, ret,
> +			"failed to initialize pcie phy\n");

Driver messages should match (all capitalized or none capitalized).

> +	/* Enable root port */

Superfluous comment, since the function name says the same.

> +	plda_pcie_enable_root_port(plda);

> +	/* Ensure that PERST has been asserted for at least 100 ms */
> +	msleep(300);
> +	gpiod_set_value_cansleep(pcie->reset_gpio, 0);

At least 100 ms, but you sleep *300* ms?  This is probably related to
https://lore.kernel.org/r/20230718155515.GA483233@bhelgaas

Please include a comment with the source of the delay value.  I assume
it's T_PVPERL and T_PERST-CLK from the PCIe CEM spec.  This way we can
someday share those #defines across drivers.

> +#ifdef CONFIG_PM_SLEEP
> +static int __maybe_unused starfive_pcie_suspend_noirq(struct device *dev)

I think you can dispense with some of these #ifdefs and the
__maybe_unused as in
https://lore.kernel.org/all/20220720224829.GA1667002@bhelgaas/

> +{
> +	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
> +
> +	if (!pcie)
> +		return 0;

How can this happen?  If we're only detecting memory corruption, it's
not worth it.

Bjorn
