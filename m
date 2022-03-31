Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70E14EDCCC
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiCaPcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiCaPcJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 11:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5D51BE0EF
        for <linux-pci@vger.kernel.org>; Thu, 31 Mar 2022 08:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B69F61ACC
        for <linux-pci@vger.kernel.org>; Thu, 31 Mar 2022 15:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B818EC340ED;
        Thu, 31 Mar 2022 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740621;
        bh=/N4Y0EKhF+pCDd76IHd99ighgTzFUCI7/1gc4Vh8nrU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CAyn9QLLkkZYulLeIuoCpn9j1y4va6TPa9r+n9kLoqcgNM3p2Fl98u5VfXCSilOkT
         QWjjjPm7iWKkWm0rDCFVRoYlRWYj2g3st9x1w+48xqmnYi6wL6/dKId2jPD3GPZwah
         BSjstuQI8d2i5rtY0zuIL6OMk1PssLc5ame7rRNOEEKLIkQkjYiLhSrn6ByDZSnBaT
         NHhiVBufw9OvlxUDg4xqVjYjwg1RvFTgaEJIIiE+dt5j9itEMSwlK6Fo1X/USH1/SQ
         CXMu4L/Hd5fO9+4GI/zaKhJaVS6jws/fIFFs+xvxJ99wPUmfWqOIAuLNwm6vJCB6lw
         9clfdDqMLjvMg==
Date:   Thu, 31 Mar 2022 10:30:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add support to register platform service IRQ
Message-ID: <20220331153019.GA10982@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1cb00f8-175e-a9c8-4d01-9ae8baa963e5@denx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 05:52:54PM +0100, Stefan Roese wrote:
> On 1/14/22 08:58, Stefan Roese wrote:
> > Some platforms have dedicated IRQ lines for platform-specific System Errors
> > like AER/PME etc. The root complex on these platform will use these seperate
> > IRQ lines to report AER/PME etc., interrupts and will not generate
> > MSI/MSI-X/INTx interrupts for these services.
> > 
> > These patches will add new method for these kind of platforms to register the
> > platform IRQ number with respective PCIe services.
> > 
> > Changes in v4 (Stefan):
> > - Remove 2nd check for PCI_EXP_TYPE_ROOT_PORT
> > - Change init_platform_service_irqs() from void to return int
> > 
> > Changes in v3 (Stefan):
> > - Restructure patches from 4 patches in v2 to now 2 patches in v3
> > - Rename of functions names
> > - init_platform_service_irqs() now uses "struct pci_dev *" instead of
> >    "struct pci_host_bridge *"
> > - pcie_init_platform_service_irqs() is called before pcie_init_service_irqs()
> > - Use more PCIe spec terminology as suggested by Bjorn (hopefully enough, I
> >    don't have the spec at hand)
> 
> Bjorn, what's the status of this patchset? I was under the impression,
> that it would make it into v5.18. Please let me know if something is
> missing.

Sorry, I didn't get to it in time for v5.18, but it's on my list for
v5.19.

I thought maybe it got assigned to Lorenzo because it touches
drivers/pci/controller/, but I can't find it in patchwork
(https://patchwork.kernel.org/project/linux-pci/list/) at all.  

Would you mind posting it again to make sure patchwork picks it up?
If it's not in patchwork, it's very likely to get missed.

Bjorn

> > Bharat Kumar Gogada (2):
> >    PCI/portdrv: Add option to setup IRQs for platform-specific Service
> >      Errors
> >    PCI: xilinx-nwl: Add method to init_platform_service_irqs hook
> > 
> >   drivers/pci/controller/pcie-xilinx-nwl.c | 18 +++++++++++
> >   drivers/pci/pcie/portdrv_core.c          | 39 +++++++++++++++++++++++-
> >   include/linux/pci.h                      |  2 ++
> >   3 files changed, 58 insertions(+), 1 deletion(-)
> > 
> 
> Viele Grüße,
> Stefan Roese
> 
> -- 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
