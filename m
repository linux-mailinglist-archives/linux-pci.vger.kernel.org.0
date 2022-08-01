Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38951587214
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiHAUMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 16:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiHAUL7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 16:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E554A32452;
        Mon,  1 Aug 2022 13:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 230F260A07;
        Mon,  1 Aug 2022 20:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B6EC43470;
        Mon,  1 Aug 2022 20:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659384715;
        bh=OSqIQPfvYpzTMvxqawaSlG0ztJzt6V5STNgZXTe0fuk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n3VA8XWEWImLnSFoDbftmNWnGl2LpOR6WfCL0l/z4/qXaMLMsmRlR4TFlTadFAhNW
         AmfQGx82DBpm3WiUjTW44FAzY51y8Frvh/Erc3eRgTyXK/tKm/PzdisTk8ugOUxZv5
         LRiunU+dY5vEKGPMvaHjaTBa1g5USOG2QDAZKbCNnH+GS++coY8YXXPrv3zfNuZlhV
         IYeUF5K4mrdM3sfmYKO0qKq38h/SC2mot3Nz4e+lPemjzooVFi4VsZUDApg6oQSjEd
         QEOzDBnApfeU5BSQX0R/cg7lAHBowEtAWWkr4q1Iep/dYxKa+Lc1BH6Ee/2JyTSALm
         UyJgmIjb5sxsA==
Date:   Mon, 1 Aug 2022 15:11:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH RESEND v4 11/15] PCI: dwc: Simplify in/outbound iATU
 setup methods
Message-ID: <20220801201153.GA622787@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801135057.GK93763@thinkpad>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 01, 2022 at 07:20:57PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jun 24, 2022 at 05:39:43PM +0300, Serge Semin wrote:
> > From maintainability and scalability points of view it has been wrong to
> > use different iATU inbound and outbound regions accessors for the viewport
> > and unrolled versions of the iATU CSRs mapping. Seeing the particular iATU
> > region-wise registers layout is almost fully compatible for different
> > IP-core versions, there were no much points in splitting the code up that
> > way since it was possible to implement a common windows setup methods for
> > both viewport and unrolled iATU CSRs spaces. While what we can observe in
> > the current driver implementation of these methods, is a lot of code
> > duplication, which consequently worsen the code readability,
> > maintainability and scalability. Note the current implementation is a bit
> > more performant than the one suggested in this commit since it implies
> > having less MMIO accesses. But the gain just doesn't worth having the
> > denoted difficulties especially seeing the iATU setup methods are mainly
> > called on the DW PCIe controller and peripheral devices initialization
> > stage.
> > 
> > Here we suggest to move the iATU viewport and unrolled CSR access
> > specifics in the dw_pcie_readl_atu() and dw_pcie_writel_atu() method, and
> > convert the dw_pcie_prog_outbound_atu() and
> > dw_pcie_prog_{ep_}inbound_atu() functions to being generic instead of
> > having a different methods for each viewport and unrolled types of iATU
> > CSRs mapping. Nothing complex really. First of all the dw_pcie_readl_atu()
> > and dw_pcie_writel_atu() are converted to accept relative iATU CSRs
> > address together with the iATU region direction (inbound or outbound) and
> > region index. If DW PCIe controller doesn't have the unrolled iATU CSRs
> > space, then the accessors will need to activate a iATU viewport based on
> > the specified direction and index, otherwise a base address for the
> > corresponding region CSRs will be calculated by means of the
> > PCIE_ATU_UNROLL_BASE() macro. The CSRs macro have been modified in
> > accordance with that logic in the pcie-designware.h header file.
> > 
> > The rest of the changes in this commit just concern converting the iATU
> > in-/out-bound setup methods and iATU regions detection procedure to be
> > compatible with the new accessors semantics. As a result we've dropped the
> > no more required dw_pcie_prog_outbound_atu_unroll(),
> > dw_pcie_prog_inbound_atu_unroll() and dw_pcie_iatu_detect_regions_unroll()
> > methods.
> > 
> > Note aside with the denoted code improvements, there is an additional
> > positive side effect of this change. If at some point an atomic iATU
> > configs setup procedure is required, it will be possible to be done with
> > no much effort just by adding the synchronization into the
> > dw_pcie_readl_atu() and dw_pcie_writel_atu() accessors.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> One nitpick mentioned below. With that fixed,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> > +static inline void __iomem *dw_pcie_select_atu(struct dw_pcie *pci, u32 dir,
> 
> This could be renamed to "dw_pcie_get_atu_base()" since we are anyway getting
> the base address of iATU.

I can see it both ways.  It definitely returns a base address, so
"get_atu_base" makes sense.  But it also writes PCIE_ATU_VIEWPORT, and
"select_atu" hints at that side effect while "get_atu_base" does not.

> > +					       u32 index)
> >  {
> > +	void __iomem *base = pci->atu_base;
> > +
> > +	if (pci->iatu_unroll_enabled)
> > +		base += PCIE_ATU_UNROLL_BASE(dir, index);
> > +	else
> > +		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, dir | index);
> > +
> > +	return base;
> > +}
