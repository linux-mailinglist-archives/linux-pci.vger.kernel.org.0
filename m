Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA635F6B31
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 18:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiJFQGN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 12:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiJFQGI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 12:06:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7859259;
        Thu,  6 Oct 2022 09:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D51C7CE16E7;
        Thu,  6 Oct 2022 16:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE91BC433C1;
        Thu,  6 Oct 2022 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665072360;
        bh=f94pwl0hhMrqUms4ljEoV8OAyf65irTFica1hj68xmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cCF7994xhD3I4nm71UhUBzFiCkXsaLcSgd51R0nt99nKX5++plUdNttaNKDfrrGta
         RH+RyCkz/VjsAXoCVEzfCwWz1runKitrCqq022ezyZ4Vh2KUi15MjdG6AIeki6rmmZ
         TBUxuACTuhRZM3Rs6w0YaswmXiR42uBgwjKd/rWycoojrFKPODtCg6yFfhats8vDp8
         36SGLOEHUkR00auFg00N0/9P4K03D2IjgkjljFwuMAJrue0oPMxo6qBXfL6q4B2LCs
         /Zn7KYkygMRgl6c26Qpe2GXcSwjLt91/2IVwjjSlxQuPJr3n6dkr2msFlJ5edQEcoj
         1iAuis9YByYmQ==
Date:   Thu, 6 Oct 2022 11:05:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>,
        Yuval Shaia <yshaia@marvell.com>, raza <raza@marvell.com>
Subject: Re: [PATCH 1/2] PCI: armada8k: Add AC5 SoC support
Message-ID: <20221006160558.GA2467717@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006111110.8574-2-vadym.kochan@plvision.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 06, 2022 at 02:11:09PM +0300, Vadym Kochan wrote:
> From: raza <raza@marvell.com>
> 
> pcie-armada8k driver is utilized to serve also AC5.
> Driver assumes interrupt mask registers are located in the same address in
> both CPUs.
> This assumption is incorrect - fix it for AC5.

Rewrap into one paragraph or add blank lines between paragraphs.

> Co-developed-by: Yuval Shaia <yshaia@marvell.com>
> Signed-off-by: Yuval Shaia <yshaia@marvell.com>
> Signed-off-by: raza <raza@marvell.com>

Real name for "raza"?  See this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.18#n407

> +		/* Set the PCIe master AxCache attributes */
> +		dw_pcie_writel_dbi(pci, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
> +		dw_pcie_writel_dbi(pci, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);

Rewrap to fit in 80 columns like the rest of the file.

> +static u32 ac5_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +			     u32 reg, size_t size)
> +{
> +	u32 val;
> +
> +	/* Handle AC5 ATU access */
> +	if ((reg & ~0xfffff) == 0x300000) {
> +		reg &= 0xfffff;
> +		reg = 0xc000 | (0x200 * (reg >> 9)) | (reg & 0xff);
> +	} else if ((reg & 0xfffff000) == PCIE_VENDOR_REGS_OFFSET)
> +		reg += 0x8000; /* PCIE_VENDOR_REGS_OFFSET in ac5 is 0x10000 */

There are lots of magic numbers here; looks like there should be some
#defines or something.

Bjorn
