Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6955E92F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347636AbiF1PRL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347627AbiF1PRL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 11:17:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8807832057;
        Tue, 28 Jun 2022 08:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5E2960F42;
        Tue, 28 Jun 2022 15:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FE3C341CA;
        Tue, 28 Jun 2022 15:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656429429;
        bh=DBXqYXloIRq7gtt1JLSyQnXCazRN48PhRsR8N/Hm5gM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U9ghLwiOpO3l7qWKf0l2xK//4CSieUDO+YULkT4V5FbEPXWTevvVobxUArmx7sQT9
         XPRrRNEkJiFDc/6zbgRwP5IfSlCpWgC8aZegpmLZUOY1sBp9nO5Z4enVR+aqVLj6mk
         DsYqLw5G5IFlXyRQLGr22wmyhQGnahT/lm02kC7l+Q0gse/ereI2BFsJQ8z+YxMiFN
         Ngw5tfSaftNXlV8eKs1bEl2kUW1RXpY3CxDMBZuBtbHudaxf8OfFZgzDl1b++yKnDo
         dOvHADB+rJK3jeSgkrANht4XkaCyP1K/byCAyiU0vamLpkQy2W3vtBbYfi6JT2uKr/
         sMrdXSbpcpjZg==
Date:   Tue, 28 Jun 2022 10:17:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/17] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20220628151707.GA1838891@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628122356.ao6b3usaiwtvz4s7@mobilestation>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 03:23:56PM +0300, Serge Semin wrote:
> Bjorn,
> Do you have anything to say based on the notes below?

I'm focused on the first series for now.

> On Wed, Jun 22, 2022 at 08:04:37PM +0300, Serge Semin wrote:
> > On Tue, Jun 21, 2022 at 01:29:41PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Jun 20, 2022 at 08:13:47PM +0300, Serge Semin wrote:
> > > > On Wed, Jun 15, 2022 at 11:48:48AM -0500, Bjorn Helgaas wrote:
> > > > > On Fri, Jun 10, 2022 at 11:57:05AM +0300, Serge Semin wrote:

> > > > > > +struct dw_pcie_ops bt1_pcie_dw_ops = {
> > > > > > +	.read_dbi = bt1_pcie_read_dbi,
> > > > > > +	.write_dbi = bt1_pcie_write_dbi,
> > > > > > +	.write_dbi2 = bt1_pcie_write_dbi2,
> > > > > > +	.start_link = bt1_pcie_start_ltssm,
> > > > > > +	.stop_link = bt1_pcie_stop_ltssm,
> > > > > > +};
> > > 
> > > > > Please rename to "dw_pcie_ops" as most drivers use. 
> > > > 
> > > > IMO matching the structure and its instance names is not a good idea.
> > > > Other than confusing objects nature, at the very least it forces you to
> > > > violate the local namespace convention. Thus in the line of the
> > > > dw_pcie->ops initialization it looks like you use some generic
> > > > operations while in fact you just refer to the locally defined
> > > > DW PCIe ops instance with the generic variable name. Moreover AFAICS
> > > > the latest platform drivers mainly use the vendor-specific prefix in
> > > > the dw_pcie_ops structure instance including the ones acked by you,
> > > > Lorenzo and Gustavo. What makes my code any different from them?
> > 
> > > That's fair.  I suggest "bt1_pcie_ops" or "bt1_dw_pcie_ops" to match
> > > the other drivers that include the driver name:
> > > 
> > >   intel_pcie_ops
> > >   keembay_pcie_ops
> > >   kirin_dw_pcie_ops
> > >   tegra_dw_pcie_ops
> > 
> > +   ks_pcie_dw_pcie_ops
> > 
> > which is even further from the suggested names.)

As I said, they're not 100% consistent, but they almost all end in
"pcie_ops".  Yours ends in "pcie_dw_ops", which is why I suggested
renaming to be similar to the others.

I don't want to make a huge deal about this, but I do want as much
similarity across drivers as possible.  I get that it doesn't benefit
*you*, but it's a huge benefit to everybody else.

> > > They're not 100% consistent, but hopefully we can at least not make
> > > things *less* consistent.
> > 
> > I don't think we can make something less consistent if there is no real
> > consistency.) There are at most five ops descriptors can be defined in
> > the DW PCIe platform drivers:
