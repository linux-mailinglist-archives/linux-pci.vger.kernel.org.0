Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59734765799
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjG0P2W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 11:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjG0P2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 11:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B021B30DC
        for <linux-pci@vger.kernel.org>; Thu, 27 Jul 2023 08:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 108AD61EBD
        for <linux-pci@vger.kernel.org>; Thu, 27 Jul 2023 15:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C962C433C7;
        Thu, 27 Jul 2023 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690471682;
        bh=izxQ/NRJBO6j/aIHrUmKUiuLXeceL8X6rh8Ywm6hmA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kajoPCjYdOfvWbO4QlS1jjP1vh8MWPPIbAb8s6W4Sofyw9Vijl/6q4Bkr4Up981RV
         aCAcjDmrQelGAi+N/z0/ius6UAOKHOrz0joQ3OAKQwMlUxaQCT4qsxj8f88QUCXnlY
         9DYAqfT/xMMbHkv3Q94PoacrpAav4MGF1TMw+EFmsgIpSt1EmRlxtLnCsHGKEHYCSi
         UCjDPjQUgsvjhKP0JGMp3BdR+ATfRrfOfB17H8vbNSu14dgfr9mGrHWfC+R1Wf0i1r
         uhMZh6ci5uTGbP9OcxzAQblMoPzvbea9h405UbzLNN/y6nTf+QE9GUjv/LkvUkIJkN
         W+Tvztl2QsSKQ==
Date:   Thu, 27 Jul 2023 17:27:57 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     daire.mcnamara@microchip.com, conor@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 7/8] PCI: microchip: Rename and refactor
 mc_pcie_enable_msi()
Message-ID: <ZMKM/f3q1o7N/bBv@lpieralisi>
References: <20230630154859.2049521-8-daire.mcnamara@microchip.com>
 <20230719174135.GA507746@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719174135.GA507746@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 12:41:35PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 30, 2023 at 04:48:58PM +0100, daire.mcnamara@microchip.com wrote:
> > From: Daire McNamara <daire.mcnamara@microchip.com>
> > 
> > After improving driver to get MSI-related information from
> > configuration registers (set at power on from the Libero FPGA
> > design), its now clear that mc_pcie_enable_msi() is not a good
> 
> it's (contraction of "it is")
> 
> > name for this function.  The function is better named as
> > mc_pcie_fixup_ecam() as its purpose is to correct the queue
> > size of the MSI CAP CTRL.
> 
> > -static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *base)
> > +static void mc_pcie_fixup_ecam(struct mc_pcie *port, void __iomem *ecam)
> 
> Since the purpose of this seems to be to fix stuff in the MSI cap,
> removing "msi" from the name seems weird.  The fact that it uses ECAM
> to access the registers is incidental.
> 
> > -	msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
> > -	msg_ctrl |= queue_size << 4;
> > -	writew_relaxed(msg_ctrl, base + cap_offset + PCI_MSI_FLAGS);
> > +	reg &= ~PCI_MSI_FLAGS_QSIZE;
> > +	reg |= queue_size << 4;
> 
> Could maybe use FIELD_PREP() instead of the shift?  I guess this would
> go in the "Gather MSI information" patch.

Daire,

can you follow up on these review comments please ?

Thanks,
Lorenzo

> 
> Bjorn
