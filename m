Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D137B4EED3A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 14:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbiDAMhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 08:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345905AbiDAMhW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 08:37:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85CB19C5B3
        for <linux-pci@vger.kernel.org>; Fri,  1 Apr 2022 05:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67276B824BD
        for <linux-pci@vger.kernel.org>; Fri,  1 Apr 2022 12:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7F9C340EC;
        Fri,  1 Apr 2022 12:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648816530;
        bh=D5QWtYRrwdxfX5BHP8XuQ3d5AvXKujZDJTaefdy+094=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MvcTsfnKNZNA0AOVoAbalAcH00TfLm6/Lqwlzk5xOPMwJJdD9jQycaqt55F6uYz3X
         LARMrHozxQW4/+LbPcTpt5wo7yrvHupCu2QhCdxTtNu9hTgvfhpVuQFG+G+MDyVyli
         Ach2S/FA0yVgFTIPxgL5nyLLq/2f+EB2yY39pjqJsyq14mIEo5pb69noH7hEOKZzuc
         MB+iN96AC0uySGuWN6IC090l7CXIf3AyijgAvnvSIn/42LhWztC1E0/SqfbY3ksXQI
         SJvlfcmJU6D4q4zRF3wQRX2nrRVh02tr6VGeCJlOYjW1aSDlBNuycXfnElRtYRV9C3
         EtSeYYXUmxKKg==
Date:   Fri, 1 Apr 2022 07:35:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add support to register platform service IRQ
Message-ID: <20220401123528.GA88442@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <473f6f13-cf01-4065-5a92-998b651f11db@denx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 01, 2022 at 08:28:51AM +0200, Stefan Roese wrote:
> On 3/31/22 17:30, Bjorn Helgaas wrote:
> > On Thu, Mar 24, 2022 at 05:52:54PM +0100, Stefan Roese wrote:
> > > On 1/14/22 08:58, Stefan Roese wrote:
> > > > Some platforms have dedicated IRQ lines for platform-specific System Errors
> > > > like AER/PME etc. The root complex on these platform will use these seperate
> > > > IRQ lines to report AER/PME etc., interrupts and will not generate
> > > > MSI/MSI-X/INTx interrupts for these services.
> > > > 
> > > > These patches will add new method for these kind of platforms to register the
> > > > platform IRQ number with respective PCIe services.
> > > > 
> > > > Changes in v4 (Stefan):
> > > > - Remove 2nd check for PCI_EXP_TYPE_ROOT_PORT
> > > > - Change init_platform_service_irqs() from void to return int
> > > > 
> > > > Changes in v3 (Stefan):
> > > > - Restructure patches from 4 patches in v2 to now 2 patches in v3
> > > > - Rename of functions names
> > > > - init_platform_service_irqs() now uses "struct pci_dev *" instead of
> > > >     "struct pci_host_bridge *"
> > > > - pcie_init_platform_service_irqs() is called before pcie_init_service_irqs()
> > > > - Use more PCIe spec terminology as suggested by Bjorn (hopefully enough, I
> > > >     don't have the spec at hand)
> > > 
> > > Bjorn, what's the status of this patchset? I was under the impression,
> > > that it would make it into v5.18. Please let me know if something is
> > > missing.
> > 
> > Sorry, I didn't get to it in time for v5.18, but it's on my list for
> > v5.19.
> > 
> > I thought maybe it got assigned to Lorenzo because it touches
> > drivers/pci/controller/, but I can't find it in patchwork
> > (https://patchwork.kernel.org/project/linux-pci/list/) at all.
> 
> Both patches are in patchwork:
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20220114075834.1938409-2-sr@denx.de/
> https://patchwork.kernel.org/project/linux-pci/patch/20220114075834.1938409-3-sr@denx.de/
> 
> The first one is assigned to you and the 2nd one to Lorenzo.
> 
> > Would you mind posting it again to make sure patchwork picks it up?
> > If it's not in patchwork, it's very likely to get missed.
> 
> Since it's already on patchwork, I did not post the patches again.
> Please let me know if I should re-post them nevertheless.

No, that should be enough.  I spent 10 minutes searching patchwork
yesterday; don't know why I couldn't find it.

> > > > Bharat Kumar Gogada (2):
> > > >     PCI/portdrv: Add option to setup IRQs for platform-specific Service
> > > >       Errors
> > > >     PCI: xilinx-nwl: Add method to init_platform_service_irqs hook
> > > > 
> > > >    drivers/pci/controller/pcie-xilinx-nwl.c | 18 +++++++++++
> > > >    drivers/pci/pcie/portdrv_core.c          | 39 +++++++++++++++++++++++-
> > > >    include/linux/pci.h                      |  2 ++
> > > >    3 files changed, 58 insertions(+), 1 deletion(-)
> > > > 
> > > 
> > > Viele Grüße,
> > > Stefan Roese
> > > 
> > > -- 
> > > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > > Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
> 
> Viele Grüße,
> Stefan Roese
> 
> -- 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
