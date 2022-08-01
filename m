Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A5358723C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 22:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiHAUR3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiHAUR2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 16:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171F3EE28;
        Mon,  1 Aug 2022 13:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C0760DE0;
        Mon,  1 Aug 2022 20:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CEEC433C1;
        Mon,  1 Aug 2022 20:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659385046;
        bh=M+j27qm/eqYXOx+0SN58kDy+Y1kSwRBfbfwHO+ZoT4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lweoCUD89dSDGh4QQEEk9UAtlAYyEjTVeGPzNkZj5f9dbKAZR71H3NRQi1zUE3teX
         WunQBYk/OimeVfHPLIK7jkkbCq5VAJNXBnzdQcZQJwiPExoZJjzwRNIKZCCFwkv5RA
         4P56Hee7LtoaFccn0BYEhom87MkIqGcMstaPC8hzd5xbgjHByQ6VptNWEqgYJFMBmp
         AYrKKwwBBUalM2ZeDwou2RPGJCe2Zv+S1r6Gz9r90IjJe3R4E42ePi0k/moQaxQcgX
         EjZgvZE6uBmwGyChK8w0XI/ag6KxzrG183QpPJHOEbGLmkGHIjeHRzLL5ev4Sz3l0j
         ZtnKgBPB8GZ7w==
Date:   Mon, 1 Aug 2022 15:17:24 -0500
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
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 14/15] PCI: dwc: Check iATU in/outbound ranges
 setup methods status
Message-ID: <20220801201724.GA623582@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801135457.GN93763@thinkpad>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 01, 2022 at 07:24:57PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jun 24, 2022 at 05:39:46PM +0300, Serge Semin wrote:
> > Let's make the DWC PCIe RC/EP safer and more verbose for the invalid or
> > failed inbound and outbound iATU windows setups. Needless to say that
> > silently ignoring iATU regions setup errors may cause unpredictable
> > errors. For instance if for some reason a cfg or IO window fails to be
> > activated, then any CFG/IO requested won't reach target PCIe devices and
> > the corresponding accessors will return platform-specific random values.
> > 
> > First of all we need to convert dw_pcie_ep_outbound_atu() method to check
> > whether the specified outbound iATU range is successfully setup. That
> > method is called by the pci_epc_ops.map_addr callback. Thus we'll make the
> > EP-specific CPU->PCIe memory mappings saver.
> > 
> > Secondly since the iATU outbound range programming method now returns the
> > operation status, it will be handy to take that status into account in the
> > pci_ops.{map_bus,read,write} methods. Thus any failed mapping will be
> > immediately noticeable by the PCIe CFG operations requesters.
> > 
> > Finally we need to convert the dw_pcie_setup_rc() method to returning the
> > operation status, since the iATU outbound ranges setup procedure may now
> > fail. It will be especially handy in case if the DW PCIe RC DT-node has
> > invalid/unsupported (dma-)ranges property. Note since the suggested
> > modification causes having too wide code indentation, it is reasonable
> > from maintainability and readability points of view to move the outbound
> > ranges setup procedure in the separate function.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thank you very much for all your reviews, Manivannan!  I added your
reviewed-by to the appropriate commits.
