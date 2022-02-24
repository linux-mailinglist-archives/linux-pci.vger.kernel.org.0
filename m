Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B844C2DE9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 15:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiBXOJ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 09:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiBXOJZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 09:09:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2E2229456D;
        Thu, 24 Feb 2022 06:08:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74410ED1;
        Thu, 24 Feb 2022 06:08:54 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58CC83F66F;
        Thu, 24 Feb 2022 06:08:53 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:08:47 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix integrated MSI Receiver mask reg setting
 during resume
Message-ID: <20220224140847.GA4839@lpieralisi>
References: <20211226074019.2556-1-jszhang@kernel.org>
 <Ye1D4lYAIpDe7qAN@xhacker>
 <20220223114622.GA27645@lpieralisi>
 <YhZbcU3yNuuBDXm/@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhZbcU3yNuuBDXm/@xhacker>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 24, 2022 at 12:06:09AM +0800, Jisheng Zhang wrote:
> On Wed, Feb 23, 2022 at 11:46:22AM +0000, Lorenzo Pieralisi wrote:
> > On Sun, Jan 23, 2022 at 08:02:42PM +0800, Jisheng Zhang wrote:
> > > On Sun, Dec 26, 2021 at 03:40:19PM +0800, Jisheng Zhang wrote:
> > > > If the host which makes use of the IP's integrated MSI Receiver losts
> > > > power during suspend, we call dw_pcie_setup_rc() to reinit the RC. But
> > > > dw_pcie_setup_rc() always set the pp->irq_mask[ctrl] as ~0, so the mask
> > > > register is always set as 0xffffffff incorrectly, thus the MSI can't
> > > > work after resume.
> > > > 
> > > > Fix this issue by moving pp->irq_mask[ctrl] initialization to
> > > > dw_pcie_host_init(), so we can correctly set the mask reg during both
> > > > boot and resume.
> > > > 
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > 
> > > Hi all,
> > > 
> > > This patch can still be applied to the latest linus tree. Do you want
> > > me to rebase and send out a new version?
> > > 
> > > Without this patch, dwc host MSI interrupt(if use the IP's integrated
> > > MSI receiver) can't work after resume. Could it be picked up as a fix
> > > for v5.17?
> > 
> > The tricky bit with this patch is that it is not clear what piece of
> > logic is lost on power down and what not. IIUC MSI interrupt controller
> > logic is kept so it does not need to be saved/restored (but in
> 
> You may mean the external MSI interrupt controller case, but here the
> focus is the integrated MSI Receiver in the IP. Normally, after
> suspending to ram, the dwc IP would lost power, so the integrated MSI
> Receiver also lost power.
> 
> > dw_pcie_setup_rc() we overwrite PCIE_MSI_INTR0_ENABLE even if it
> > is not needed on resume - actually, it can even be destructive).
> > 
> 
> For the integrated MSI Receiver case, since the entire IP power is lost,
> so the PCIE_MSI_INTR0_MASK|ENABLE setting is lost, we need to resume the
> mask to the one before suspending. For PCIE_MSI_INTR0_ENABLE register(s),
> since it's always 0xffffffff, so current code is fine.
> 
> > Maybe we need to write suspend/resume hooks for the dwc core instead
> > of moving code around to fix these bugs ?
> > 
> 
> Even with suspend/resume hooks, we still need to fix the
> PCIE_MSI_INTR0_MASK wrong setting with always ~0. After the fix, msi works
> so we don't need suspend/resume hooks any more.

I don't understand. The fix removes code that is writing into
PCIE_MSI_INTR0_MASK (in dw_pcie_setup_rc()). Where that register
content is restored on power up to the correct value then ?

I assume those registers when the IP loses power are reset
to their reset value, so something does not add up.

Lorenzo
