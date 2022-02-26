Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0034C54DF
	for <lists+linux-pci@lfdr.de>; Sat, 26 Feb 2022 10:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiBZJYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Feb 2022 04:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBZJYR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Feb 2022 04:24:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E711B2AD5;
        Sat, 26 Feb 2022 01:23:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DA1760FD8;
        Sat, 26 Feb 2022 09:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0388C340E8;
        Sat, 26 Feb 2022 09:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645867423;
        bh=Drm593FxdaMjEXv54XpM7u4sTVgfw1fpSFTqP+vF/Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R63McLfGxlNO1VVtTzVyhZlBLD/EdO2emxiJNDbz0alK4WVE7OKub43ux5C4Ugmg8
         1nXjfBjm0q2kAjRCE10MS+A9w2pHM1ZiEcM2NVW+cs5fXFhq7lZ1lhQX4tPyVBVIAd
         SDEoE+lP3n6p7TDMn7+03zaddaLLSvgMdAR4t8K8Qdk5WTuF9yzmmnJCHrhjqxPhD+
         l8Y2w4r3wj+T79am2nam0R7RhUyBFx6ZF4E5Jzy8P49wNOdE+x/Pb4tRk0EX75wSfp
         KoZ25z876TdL7bdDhYfCJMw74mLW3znqCGrzLp564ypky7UjG4tjNszKbBj8TCpgMt
         S+xpYFFMHKdmw==
Date:   Sat, 26 Feb 2022 17:15:42 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix integrated MSI Receiver mask reg setting
 during resume
Message-ID: <YhnvvnPNgDNkTHXO@xhacker>
References: <20211226074019.2556-1-jszhang@kernel.org>
 <Ye1D4lYAIpDe7qAN@xhacker>
 <20220223114622.GA27645@lpieralisi>
 <YhZbcU3yNuuBDXm/@xhacker>
 <20220224140847.GA4839@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224140847.GA4839@lpieralisi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 24, 2022 at 02:08:47PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Feb 24, 2022 at 12:06:09AM +0800, Jisheng Zhang wrote:
> > On Wed, Feb 23, 2022 at 11:46:22AM +0000, Lorenzo Pieralisi wrote:
> > > On Sun, Jan 23, 2022 at 08:02:42PM +0800, Jisheng Zhang wrote:
> > > > On Sun, Dec 26, 2021 at 03:40:19PM +0800, Jisheng Zhang wrote:
> > > > > If the host which makes use of the IP's integrated MSI Receiver losts
> > > > > power during suspend, we call dw_pcie_setup_rc() to reinit the RC. But
> > > > > dw_pcie_setup_rc() always set the pp->irq_mask[ctrl] as ~0, so the mask
> > > > > register is always set as 0xffffffff incorrectly, thus the MSI can't
> > > > > work after resume.
> > > > > 
> > > > > Fix this issue by moving pp->irq_mask[ctrl] initialization to
> > > > > dw_pcie_host_init(), so we can correctly set the mask reg during both
> > > > > boot and resume.
> > > > > 
> > > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > 
> > > > Hi all,
> > > > 
> > > > This patch can still be applied to the latest linus tree. Do you want
> > > > me to rebase and send out a new version?
> > > > 
> > > > Without this patch, dwc host MSI interrupt(if use the IP's integrated
> > > > MSI receiver) can't work after resume. Could it be picked up as a fix
> > > > for v5.17?
> > > 
> > > The tricky bit with this patch is that it is not clear what piece of
> > > logic is lost on power down and what not. IIUC MSI interrupt controller
> > > logic is kept so it does not need to be saved/restored (but in
> > 
> > You may mean the external MSI interrupt controller case, but here the
> > focus is the integrated MSI Receiver in the IP. Normally, after
> > suspending to ram, the dwc IP would lost power, so the integrated MSI
> > Receiver also lost power.
> > 
> > > dw_pcie_setup_rc() we overwrite PCIE_MSI_INTR0_ENABLE even if it
> > > is not needed on resume - actually, it can even be destructive).
> > > 
> > 
> > For the integrated MSI Receiver case, since the entire IP power is lost,
> > so the PCIE_MSI_INTR0_MASK|ENABLE setting is lost, we need to resume the
> > mask to the one before suspending. For PCIE_MSI_INTR0_ENABLE register(s),
> > since it's always 0xffffffff, so current code is fine.
> > 
> > > Maybe we need to write suspend/resume hooks for the dwc core instead
> > > of moving code around to fix these bugs ?
> > > 
> > 
> > Even with suspend/resume hooks, we still need to fix the
> > PCIE_MSI_INTR0_MASK wrong setting with always ~0. After the fix, msi works
> > so we don't need suspend/resume hooks any more.
> 
> I don't understand. The fix removes code that is writing into
> PCIE_MSI_INTR0_MASK (in dw_pcie_setup_rc()). Where that register

No, the patch just moves the irq_mask[] array setting from
dw_pcie_setup_rc() to dw_pcie_host_init(), the code which writes
irq_mask[] array into PCIE_MSI_INTR0_MASK is still kept there.

> content is restored on power up to the correct value then ?

the irq_mask[] array.
