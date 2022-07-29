Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED1584FA4
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 13:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiG2Ldw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jul 2022 07:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiG2Ldv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2022 07:33:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4B02AE13;
        Fri, 29 Jul 2022 04:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3055EB82748;
        Fri, 29 Jul 2022 11:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F10FC433C1;
        Fri, 29 Jul 2022 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659094427;
        bh=tMQuEz9/O5iN9YupqcwyAfC6BmIM2k+OavS4lms+KSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JU8FkWo6Tq2G0bmNjIfJvnViN9ubzzOgmUtjEW+UPyKj0J8ADt71vHiviOb65+qys
         TFcCpC67YRVqggywTtDsU+6HIQos8D/o6NXgouFBm3lJLZWF07M06OSSeT1y0Pvze1
         DGHNWg1+wCfg/tKfiYVum2kxW9Ho419ZwpARx85NdOw7JRQX/+FnFavQ69I4AcKHP0
         gXUOUWvKs8whgz4PUUX7i/sKTfyR7T8xJJVQDlO7FZK56A8+DRQBWTK7eJUhDj11Ab
         J60web7Uh9kyk4O0a8stKw7a8zA5GgZEdy1DkeNL3Nd8ZNdSNhbNp/Q22m74gn/ZPO
         N6BGJbRM7r/Ew==
Date:   Fri, 29 Jul 2022 06:33:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 15/15] PCI: dwc: Introduce dma-ranges property
 support for RC-host
Message-ID: <20220729113345.GA445581@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729045220.akdabli5szd5lbdt@mobilestation>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 29, 2022 at 07:52:20AM +0300, Serge Semin wrote:
> On Thu, Jul 28, 2022 at 05:11:20PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 24, 2022 at 05:39:47PM +0300, Serge Semin wrote:
> > > In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
> > > property has the same format as the "ranges" property. The only difference
> > > is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
> > > memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
> > > property. Even though the DW PCIe controllers are normally equipped with
> > > the internal Address Translation Unit which inbound and outbound tables
> > > can be used to implement both properties semantics, it was surprising for
> > > me to discover that the host-related part of the DW PCIe driver currently
> > > supports the "ranges" property only while the "dma-ranges" windows are
> > > just ignored. Having the "dma-ranges" supported in the driver would be
> > > very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
> > > mapping and require a customized PCIe memory layout. So let's fix that by
> > > introducing the "dma-ranges" property support.
> 
> > Do we have a platform that requires this yet?  Or does this fix a bug?
> > 
> > I see that dw_pcie_host_init() calls devm_pci_alloc_host_bridge(),
> > which eventually parses "dma-ranges", but I don't see any DWC DT
> > bindings that use it yet.
> > 
> > I'm not clear on what value this adds today.
> 
> There are several points of having this supported.
> First of all, generic PCIe DT-bindings permit having the dma-ranges
> specified for the PCIe RCs. If so having it unsupported by the driver
> just breaks the bindings or at least makes it incomplete.

Are there bindings in the tree that are broken and will be fixed by
this?

> Second, the main point of this patchset is to add the dma-ranges
> support.) Especially seeing some other PCIe RC drivers do have it
> supported too.
> Finally. It is required for our platform (and for all the platforms
> with similar issues). The problem is that the outbound source window
> base address (on CPU-side) is size-unaligned. It resides at the 128MB
> base address (size is somewhat about ~335MB). In case of the
> one-on-one CPU->PCI mapping the peripherals with relatively big BARs
> (at least of 256MB) and which need the BARs having size-aligned memory
> won't be supported. So we had to remap the PCIe space to the
> size-aligned base address. But in its turn that caused the PCIe-CPU
> memory overlap. So PCIe DMA stopped working for the overlapped memory
> due to the implicit P2P transactions. In order to fix that we had to
> add the dma-ranges support to the DW PCIe driver and use it to remap
> the overlapped memory. So please add this patch to the repo. We really
> need it.

Does the above apply to the pending Baikal-T1 driver?  If so, let's
just include this patch in that series.  Then we'll have a user of
this functionality and we'll be able to exercise and test this code.

Bjorn
