Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD1792DC3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 20:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbjIESvg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjIESvf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 14:51:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793D6E59;
        Tue,  5 Sep 2023 11:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2FED8CE1271;
        Tue,  5 Sep 2023 16:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8B2C433C7;
        Tue,  5 Sep 2023 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693931261;
        bh=6OD2DtqpQyrf+VYg+lhq13/Z18Z/KJYFIEncqN8AVJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qWXXETCWpvfvJCm4x1IJ64Ctc18TlZM2MzkaMuhtTOpYRZUNxtRFeHm+6TwJgAssj
         sHIY0UwfGW62Iej5s51hlDNGJ+tThvIAsA6pnpTrrHA262Z1hFNt07zg1UmpQmjdu+
         SJS7ml6xMTQIXFLs0cDuVf5BKnp7MdkQE7u1TeMkSGSajp7m6JwRHrcIT76Nt6vjPq
         SKfQ94A4wJ+hFrLL6WJnvHcjGNdClDfkRXC1KxjJylcvCTfpjNXbTHWSPVzPG/Er4W
         99qNWA6OE0jKKenj6mt7WaQh9/7z54LsVJGuGuK1d3m9sw7o8Xs4RZv/PeKmgH+Jq4
         F81l1aIe5db1A==
Date:   Tue, 5 Sep 2023 11:27:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Achal Verma <a-verma1@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] pci: j721e: Enable reference clock output from
 serdes
Message-ID: <20230905162739.GA175146@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905114816.2993628-3-a-verma1@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previous j721e subject line history is like this:

  c86f4bd6008e ("PCI: j721e: Convert to platform remove callback returning void")
  053ca37c87af ("PCI: j721e: Initialize pcie->cdns_pcie before using it")
  19e863828acf ("PCI: j721e: Drop redundant struct device *")
  72de208f2bda ("PCI: j721e: Drop pointless of_device_get_match_data() cast")
  496bb18483cc ("PCI: j721e: Fix j721e_pcie_probe() error path")
  c8a375a8e15a ("PCI: j721e: Add PCIe support for AM64")

Match capitalization style, i.e., "PCI: " instead of "pci: "

On Tue, Sep 05, 2023 at 05:18:16PM +0530, Achal Verma wrote:
> PCIe1 in J7AHP EVM has EP side connector reference clock connection from
> serdes named SOC_SERDES0_REFCLK(PCIE_REFCLK_OUT) unlike PCIe0 which has
> reference clock connection from on-board serdes. To enable this reference
> clock out, ACSPCIE clock buffer pads have to be enabled.
> 
> This change enables ACSPCIE clock buffer pads and select clock source for
> reference clock output.

s/This change enables/Enable/
s/and select/and selects/

> +static int j721e_enable_acspcie(struct j721e_pcie *pcie)
> +{
> +	struct device *dev = pcie->cdns_pcie->dev;
> +	struct device_node *node = dev->of_node;
> +	struct of_phandle_args args;
> +	unsigned int lock2_kick0_offset, lock2_kick1_offset;
> +	unsigned int acspcie_pad_offset, refclk_clksel_offset;
> +	unsigned int refclk_clksel_source;
> +	struct regmap *syscon;
> +	u32 val = 0, mask = 0;

Looks like these initializations are unnecessary?

> +	syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-pcie-refclk-out");

Looks like this and the of_parse_phandle_with_fixed_args() below don't
fit in 80 columns like the rest of the file.

> +	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-pcie-refclk-out", 5,
> +						0, &args);

> +	/* Enable ACSPCIe PADS  */

Spurious extra space at end of comment.

> +	/*
> +	 * Enable ACSPCIe clock buffer to source out reference clock for EP
> +	 */

Looks like it could be a single-line comment, e.g.,

  /* Enable ACSPCIe clock buffer to source out reference clock for EP */
