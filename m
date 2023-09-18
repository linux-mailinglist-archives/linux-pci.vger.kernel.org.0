Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD187A531E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 21:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjIRTap (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 15:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRTao (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 15:30:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BDAF7;
        Mon, 18 Sep 2023 12:30:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D40FC433C8;
        Mon, 18 Sep 2023 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695065438;
        bh=p7IPFFhDWDJlqnFmvsGW8of4RYlTgW4b+UUjXQpcHHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PgCFKrO7BV4plQE5cwbEKbKIDUds7IpTWm7kQNCjw4EXM2c7Pxu/Hs7RscrXIeYHf
         6rPjlwBpEWUyY1q5XPbtPtkBGOwym5bBbkhyvn+mcAZKl8LNaWcsi3aWGaFKOobe7W
         or/79UI2rmxha+7ZaeHUeDAnM/B5iQSkuLUAS6bJWNhjtD6YMapwBSikBIiXoi1Frp
         EIXUqdmyqQQJNXpAfXnBh+XZaOSssSz+p75prERSZ8T/z5e+aILNmCIK6fkhT1Ycl7
         omqIaBIOez7Zyh1M+eyDoSuQLiiPm78OoZjYxnWhAE6CNqZgf4bpHlvGBq0psr0La3
         3eyCEQUNhSsYQ==
Date:   Mon, 18 Sep 2023 14:30:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v2 07/30] drivers/pci: SH7751 PCI Host bridge
 controller driver.
Message-ID: <20230918193036.GA203163@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f25af9e93fbb84c8e4fe6da3c0c13b0a6be2c73.1694596125.git.ysato@users.sourceforge.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 06:23:32PM +0900, Yoshinori Sato wrote:

See subject line comments at
https://lore.kernel.org/r/20230918191602.GA201859@bhelgaas

Please add a commit log.  Repeating the subject line is fine, but
there's a little more detail that could be included here, e.g., a hint
about what platforms this is useful for.

> + * SH7751 PCI driver
> + * Copyright (C) 2023 Yoshinori Sato
> + *

Spurious blank line.

> +#define pcic_writel(val, reg) __raw_writel(val, pci_reg_base + (reg))
> +#define pcic_readl(reg) __raw_readl(pci_reg_base + (reg))

Best to include a pointer to a struct in the macro arguments so this
doesn't depend on local variable names in the users.  See advk_readl()
and advk_writel(), for example.

> +DEFINE_RAW_SPINLOCK(pci_config_lock);

Should be static.

> +	pcic_writel(0x0c000000, SH7751_PCICONF5);
> +	pcic_writel(0xd0000000, SH7751_PCICONF6);
> +	pcic_writel(0x0c000000, SH4_PCILAR0);
> +	pcic_writel(0x00000000, SH4_PCILAR1);

The header file uses upper-case hex, but this file looks like mostly
lower-case.  Maybe make them consistent?

> + * Since SH4 only does 32bit access we'll have to do a read,
> + * mask,write operation.

This RMW corrupts some registers; see comments and warning in
pci_generic_config_write32().  A comment here is probably enough.

> + * We'll allow an odd byte offset, though it should be illegal.
> + */
> +static int sh4_pci_write(struct pci_bus *bus, unsigned int devfn,
> +			 int where, int size, u32 val)

> +static int area_sdram_check(void __iomem *pci_reg_base,
> +			    void __iomem *bcr,
> +			    unsigned int area)
> +{
> +	unsigned long word;
> +
> +	word = __raw_readl(bcr + SH7751_BCR1);
> +	/* check BCR for SDRAM in area */
> +	if (((word >> area) & 1) == 0) {
> +		pr_info("PCI: Area %d is not configured for SDRAM. BCR1=0x%lx\n",

Use dev_info().  Will require passing a controller struct around,
which is common style in drivers/pci/controller/.

> +	dev_info(&pdev->dev, "PCI core found at %p\n",
> +		pci_reg_base);

Use %pR.

> +	/* use round robin mode to stop a device starving/overruning */

overrunning

Bjorn
