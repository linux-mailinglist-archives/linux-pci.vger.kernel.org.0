Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BB45BD78A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 00:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiISWkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 18:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiISWkV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 18:40:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B679A28723;
        Mon, 19 Sep 2022 15:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CACDB821B1;
        Mon, 19 Sep 2022 22:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5A8C433D6;
        Mon, 19 Sep 2022 22:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663627217;
        bh=pHkxeihtgeIsqW4rQKtSSh7KacdZKQcvFCJJxp9CxfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UKkyDLXshPs9BjzEnqCZwuuzULGSnMIo9y60Po5KHO/dMV9NgJ6zpVpp6T/+giI6d
         M0hfZTk6xkpHhq4XZv2joyau5p9mc4N5kMpuvHGXM9qefyPMO9rUkptJPEPbicw4FQ
         MEm0B93IbpVPZpZOxff5XxjCVNUawm4jfzv/0nMRAqfrTJI0xmbayCW2s/HXNXyT/Y
         aMBuwaodI1qDZZUg9kihlrO8mAo7wtxXmPA0bY6SJdMzM2kom4aqkj5T8RcnRPZ9YX
         QvHA+V+F6BNVGs8k4G64rLHtTEIWzoDAaFn4cA7/TnPCSGiOKIRXzRdCNsjX5z7hfd
         6YIzAzdQqXjfw==
Date:   Mon, 19 Sep 2022 17:40:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, dmitry.baryshkov@linaro.org,
        linmq006@gmail.com, ffclaire1224@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 0/3] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20220919224014.GA1030798@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919183342.4090-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 20, 2022 at 12:03:39AM +0530, Vidya Sagar wrote:
> This series attempts to fix the issue with core register (Ex:- DBI) accesses
> causing system hang issues in platforms where there is a dependency on the
> availability of PCIe Reference clock from the host for their core
> initialization.
> This series is verified on Tegra194 & Tegra234 platforms.

I think this design is just kind of weird, specifically, the fact that
setting .core_init_notifier makes dw_pcie_ep_init() bail out early.
The usual pattern is more like "if the specific driver sets this
function pointer, the generic code calls it."

The name "dw_pcie_ep_init_complete()" is not as helpful as it could
be: it tells us something about what has happened before this point,
but it doesn't tell us anything about what dw_pcie_ep_init_complete()
*does*.

Same thing with dw_pcie_ep_init_notify() -- it doesn't tell us
anything about what the function *does*.  I see that it calls
pci_epc_init_notify(), which calls a notifier call chain (currently
always empty except for a test case).  I think pci_epc_linkup() is a
better name because it says something about what's happening: the link
is now up and we're telling somebody about it.  "pci_epc_init_notify()"
doesn't convey that.  "pci_epc_core_initialized()" might.

It looks like both qcom and tegra wait for an interrupt before calling
dw_pcie_ep_init_notify(), but I'm a little concerned because I can't
figure out what specifically they do to start the process that
ultimately generates the interrupt.  Presumably they request the IRQ
*before* starting the process, but there's not much between the
devm_request_threaded_irq() and the interrupt handler, which makes me
wonder if both are racy.

> Manivannan, could you please verify on qcom platforms?
> 
> V4:
> * Addressed review comments from Bjorn and Manivannan
> * Added .ep_init_late() ops
> * Added patches to refactor code in qcom and tegra platforms
> 
> Vidya Sagar (3):
>   PCI: designware-ep: Fix DBI access before core init
>   PCI: qcom-ep: Refactor EP initialization completion
>   PCI: tegra194: Refactor EP initialization completion
> 
>  .../pci/controller/dwc/pcie-designware-ep.c   | 112 ++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  27 +++--
>  drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
>  4 files changed, 85 insertions(+), 68 deletions(-)
> 
> -- 
> 2.17.1
> 
