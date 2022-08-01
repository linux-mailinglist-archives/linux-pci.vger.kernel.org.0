Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969B85871F5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 22:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiHAUGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 16:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiHAUGL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 16:06:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978C527B00;
        Mon,  1 Aug 2022 13:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C431B8168A;
        Mon,  1 Aug 2022 20:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BCCC433D6;
        Mon,  1 Aug 2022 20:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659384367;
        bh=WEfadwtwz1ZbDqKtLh/CEmqHOJQ2a2CMdD1ufn/kk+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sIfw4sa5IQatyQgEjM6DSnnr6BY9jgW7F9hxQxRPoVhZ4kRT3AHxD3HdZIQZ2kSxm
         eeFlGhAhQ3YtiZEHX8kHJyQrsfRIBNnQ7tKcqiK9uSiXuqqPxl+NCKRuWbT9CrgMgW
         K4lhnu3x00yaIjB6upiUJeNYNvElcI0R9TVH0NdZyxB5G6Bv3rwYB3aCGqcGc8+2fx
         inSGq3c2asCQ7OMXTU7SJVTyG7Cd4QX5Z10b5FHvZ7XcX8BFhOl0o+SiZ/r1p035U1
         Q//HjPiIRxk7pbjW1O8ruaExBRaqR75vz9QPuhqFjnJkOFuPul+jsnDErYnT9IB1BC
         T0q0tBRFEjmIQ==
Date:   Mon, 1 Aug 2022 15:06:06 -0500
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
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 04/15] PCI: dwc: Add IP-core version detection
 procedure
Message-ID: <20220801200606.GA622066@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801131219.GD93763@thinkpad>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 01, 2022 at 06:42:19PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jun 24, 2022 at 05:39:36PM +0300, Serge Semin wrote:
> > Since DWC PCIe v4.70a the controller version and version type can be read
> > from the PORT_LOGIC.PCIE_VERSION_OFF and PORT_LOGIC.PCIE_VERSION_TYPE_OFF
> > registers respectively. Seeing the generic code has got version-dependent
> > parts let's use these registers to find out the controller version.  The
> > detection procedure is executed for both RC and EP modes right after the
> > platform-specific initialization. We can't do that earlier since the
> > glue-drivers can perform the DBI-related setups there including the bus
> > reference clocks activation, without which the CSRs just can't be read.
> > 
> > Note the CSRs content is zero on the older DWC PCIe controller. In that
> > case we have no choice but to rely on the platform setup.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> > Reviewed-by: Rob Herring <robh@kernel.org>

> > @@ -711,6 +711,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	ep->phys_base = res->start;
> >  	ep->addr_size = resource_size(res);
> >  
> > +	dw_pcie_version_detect(pci);
> > +
> 
> There is still an ongoing debate about moving all DBI accesses to
> init_complete. But this is fine atm.

Well, if I understand it correctly, e966f7390da9 ("PCI: dwc: Refactor
core initialization code for EP mode") claims that all DBI accesses
should be in dw_pcie_ep_init_complete(), so it's not so much a debate
as a discussion about how best to achieve that.

But you're right, we can fix that up later if necessary.

> >  	dw_pcie_iatu_detect(pci);
