Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF665ED72F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 10:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiI1ILL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 04:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiI1ILI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 04:11:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B163F3B;
        Wed, 28 Sep 2022 01:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E70D2B81F4E;
        Wed, 28 Sep 2022 08:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3063C433D6;
        Wed, 28 Sep 2022 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664352659;
        bh=ZOOO0MWPjQs3iC2W6p1C6FjEUQTUaQp8JdKtNdUAINk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EodwKMluZotcrJvTeRhAWXbLL5ieFuKvuvVjHsdScMLw3pD3aOzVqcdXnX9zBSesP
         UGpS03Z/o/9vKInjrYZXpovGDgGCctadzq5YD8yvueUxy2CDPQ9SLL8butB3Sz/SuV
         lFNZJflb0oZWIJJYwFBE52aafzLGLAkF8m0easwvQJeDXAosKQhVr77Bsp5I+E0fvA
         qTjNGdy9eHr+UY4DKDusG8Ds9eV2A8ynYbDiiEdwsz1pORv4D6qZ03NQAO3BNfn/hv
         2BtTiW/q2C0FHyzAa9s7VKIicMitNCDaEk8kyrvBR35Ke7550UDb/2cwZljj+ZdAlk
         Uytwy7tGs+MXg==
Date:   Wed, 28 Sep 2022 10:10:52 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 00/15] PCI: dwc: Add hw version and dma-ranges
 support
Message-ID: <YzQBjHYI9REEaqeL@lpieralisi>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220729023645.GA423256@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729023645.GA423256@bhelgaas>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 28, 2022 at 09:36:45PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 24, 2022 at 05:39:32PM +0300, Serge Semin wrote:
> > This patchset is a second one in the series created in the framework of
> > my Baikal-T1 PCIe/eDMA-related work:
> 
> > Serge Semin (15):
> >   PCI: dwc: Add more verbose link-up message
> >   PCI: dwc: Detect iATU settings after getting "addr_space" resource
> >   PCI: dwc: Convert to using native IP-core versions representation
> >   PCI: dwc: Add IP-core version detection procedure
> >   PCI: dwc: Introduce Synopsys IP-core versions/types interface
> >   PCI: intel-gw: Drop manual DW PCIe controller version setup
> >   PCI: tegra194: Drop manual DW PCIe controller version setup
> >   PCI: dwc: Add host de-initialization callback
> >   PCI: dwc: Drop inbound iATU types enumeration - dw_pcie_as_type
> >   PCI: dwc: Drop iATU regions enumeration - dw_pcie_region_type
> >   PCI: dwc: Simplify in/outbound iATU setup methods
> >   PCI: dwc: Add iATU regions size detection procedure
> >   PCI: dwc: Verify in/out regions against iATU constraints
> >   PCI: dwc: Check iATU in/outbound ranges setup methods status
> 
> I applied the above to pci/ctrl/dwc for v5.20, thanks!
> 
> >   PCI: dwc: Introduce dma-ranges property support for RC-host
> 
> I deferred this one for now because the current value isn't clear yet.
> If we have a user for it, I'll be glad to add it.

This one is still deferred and I agree with Bjorn it should be part of
a series that actually requires it - it would also simplify the review.

Lorenzo
