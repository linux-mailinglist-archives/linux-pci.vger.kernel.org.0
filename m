Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660CF5847FD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 00:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiG1WL0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 18:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiG1WLZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 18:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147D1785A6;
        Thu, 28 Jul 2022 15:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A3C61B54;
        Thu, 28 Jul 2022 22:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EB9C433D6;
        Thu, 28 Jul 2022 22:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659046282;
        bh=vp6m+L9NT4VOGQFGhTGWKhJ+KeHAmVR6ZlUE3kmLqwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OVWwxA6TrLNqjrPLMMlsdyH5BSH0sI2F2NZpv/X4HtMwy8C36kYfRBPUJgmZ6W6XP
         t4ii7bUoL+B2HUSGLNdl4UglXKyEg03AR2eEy1+ms4DUqKMKOK8fTdxL3lMDQUnEUo
         3irc0aMX511EfdFlP9OZDZuul86sq3cYe1876wH3lX9VJ6V0BjtwFaY+Z0aT/mA1BC
         rMpmKBPSIzMdWATDtErF+FKsWVNNVa7fuY+hZJT0XNKNSbDjrNKKNBPu3C2A7ZZqyb
         MIJCr9p33GFqz1g+XFIQfV63LePmtZ6V+eIFiTSB04bAH/HUcWzVMLlC0VYNX+azzH
         fjp4lvB7x6Psw==
Date:   Thu, 28 Jul 2022 17:11:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 15/15] PCI: dwc: Introduce dma-ranges property
 support for RC-host
Message-ID: <20220728221120.GA330510@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624143947.8991-16-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:47PM +0300, Serge Semin wrote:
> In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
> property has the same format as the "ranges" property. The only difference
> is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
> memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
> property. Even though the DW PCIe controllers are normally equipped with
> the internal Address Translation Unit which inbound and outbound tables
> can be used to implement both properties semantics, it was surprising for
> me to discover that the host-related part of the DW PCIe driver currently
> supports the "ranges" property only while the "dma-ranges" windows are
> just ignored. Having the "dma-ranges" supported in the driver would be
> very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
> mapping and require a customized PCIe memory layout. So let's fix that by
> introducing the "dma-ranges" property support.

Do we have a platform that requires this yet?  Or does this fix a bug?

I see that dw_pcie_host_init() calls devm_pci_alloc_host_bridge(),
which eventually parses "dma-ranges", but I don't see any DWC DT
bindings that use it yet.

I'm not clear on what value this adds today.

Bjorn
