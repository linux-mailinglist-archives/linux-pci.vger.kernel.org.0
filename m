Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E0159037E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 18:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiHKQ0n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbiHKQ0M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 12:26:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7602A405B;
        Thu, 11 Aug 2022 09:07:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 613E7613F8;
        Thu, 11 Aug 2022 16:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BAEC433C1;
        Thu, 11 Aug 2022 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660234046;
        bh=7QoczvgOuOfMe4Jd+WK4SX4WdFG16qmwH7KOQtIynuU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uVZHGAwTaYEUuMVQ9Bw5yPZjVShkv34lmZOmZSFsBQZ9Zi1g6zK4SzNlKMJDMchAp
         8dDx9FbJtN/O2k0MbWpD9y/JdZX0ReYTCv5fWieVVzAHmdEh2CoXiLElf6VhJGvejO
         9DN9jsi6ING+cHCIhrtmtLtQM4VXKX65pvweWYvZhk/hJiSFypjPPITOl0OnT3mIV0
         NVRSn8fv1kerfMkqpDyQK/QuU4HZwW9FWQBcrejy0/STsrSKQPDslfRLoRp792x8RR
         jyStYLOLzLzvyjHxKTEsa11+233qJR7rk4SG0SjGu5dkcMsBjjA1ruYG5QTGy6Obqt
         2G5M8U/CsZf4g==
Date:   Thu, 11 Aug 2022 11:07:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/2] PCI: dwc: add support for 64-bit MSI target
 address
Message-ID: <20220811160725.GA1526733@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810231445.2242126-3-willmcvicker@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No need to rush the versions (I see v1 on 8/9, v2 and v3 on 8/10).

But if/when you update this, capitalize the subject lines
("PCI: dwc: Add support ...") to match previous history.

On Wed, Aug 10, 2022 at 11:14:44PM +0000, Will McVicker wrote:
> Since not all devices require a 32-bit MSI address, add support to the
> PCIe host driver to allow setting the DMA mask to 64-bits. This allows
> kernels to disable ZONE_DMA32 and bounce buffering (swiotlb) without
> risking not being able to get a 32-bit address during DMA allocation.
> Basically, in the slim chance that there are no 32-bit allocations
> available, the current PCIe host driver will fail to allocate the
> msi_msg page due to a DMA address overflow (seen in [1]).

> With this patch, the PCIe driver can advertise 64-bit support via
> it's MSI capabilities to hint to the PCIe host driver to set the DMA
> mask to 64-bits.

s/via it's/via its/

I'm not quite sure what this sentence is saying.  I think it's
actually the *device* (not the PCIe driver) that advertises 64-bit
support in its MSI capability.

> +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
> +{
> +	u8 offset;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> +	return dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_msi_capabilities);

Why does this need to be exported?  CONFIG_PCIE_DW and
CONFIG_PCIE_DW_HOST are both bool, so I don't see any callers from
modules.

I see there are some other functions in pcie-designware.c that are
exported, but I'm a little dubious about those, too.  There are
several DWC drivers that are tristate (PCI_DRA7XX, PCI_EXYNOS, etc),
but they select PCIE_DW_HOST and PCIE_DW, which are bool.  I guess
this means the DWC core code gets built-in while the dra7xx, exynos,
etc code is a module.

If we want these to be modules, it would make more sense to me to have
the module include both the DWC core code and the specific driver.
I.e., the DWC core code would not be statically included at all, and
the dra7xx module would contain DWC core and dra7xx, the exynos module
would contain DWC core and exynos, etc.

Maybe Kconfig isn't expressive enough for that?  I don't know Kconfig
well enough.

Bjorn
