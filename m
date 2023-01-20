Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADEC675A82
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 17:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjATQxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 11:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjATQxO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 11:53:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E449431;
        Fri, 20 Jan 2023 08:53:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF46662007;
        Fri, 20 Jan 2023 16:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF236C433D2;
        Fri, 20 Jan 2023 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674233587;
        bh=ZJyKB5JqJ60CNEaKuQaIeFoM3hgqcsDrG9XWlZAjUt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vR0h1Abc+jBzC0ip7zBVdbnFn2dTYZ7Q281OK6+S9U3aX8HHGl3YP1eBbIRCWET4s
         nEkjhCI5yN/BUuhdRrr6G7oRlkDL6IY7vN5UVO0f/mShmK0rnj4yYYbrOcto2Nsd+A
         UeEFa/GjUuAkgKZmuEv/QCvellWKsXReR5D2gnWq+5hoFtvcheDr9av9HVr+aF+N5n
         qQoCiEjqMJRbk73E/ihYsAwnqyqgpz6o442dhrNj7eb3p0Ads745GsyIdzxEBujOYc
         qErMnZkWoemovVdk0CEl2c4GtY4walkCZi5InpXIZQfBjST1DJgW7r14KmQNeOQolw
         HIXvKDi5Gef3Q==
Date:   Fri, 20 Jan 2023 10:53:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     jiantao zhang <water.zhangjiantao@huawei.com>
Cc:     "zhangjianrong (E)" <zhangjianrong5@huawei.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Exit restore process when device is still powerdown
Message-ID: <20230120165305.GA622765@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42dc3ab2-8129-7186-c777-07848ee01f66@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 20, 2023 at 02:18:24PM +0800, jiantao zhang wrote:
> 在 2023/1/13 6:13, Bjorn Helgaas 写道:
> > On Thu, Dec 22, 2022 at 12:41:04PM +0000, Jiantao Zhang wrote:
> > > We get this stack when the rp doesn't power up in resume noirq:
> > >      dump_backtrace.cfi_jt+0x0/0x4
> > >      dump_stack_lvl+0xb4/0x10c
> > >      show_regs_before_dump_stack+0x1c/0x30
> > >      arm64_serror_panic+0x110/0x1a8
> > >      do_serror+0x16c/0x1cc
> > >      el1_error+0x8c/0x10c
> > >      do_raw_spin_unlock+0x74/0xdc
> > >      pci_bus_read_config_word+0xdc/0x1dc
> > >      pci_restore_msi_state+0x2f4/0x36c
> > >      pci_restore_state+0x13f0/0x1444
> > >      pci_pm_resume_noirq+0x158/0x318
> > >      dpm_run_callback+0x178/0x5e8
> > >      device_resume_noirq+0x250/0x264
> > >      async_resume_noirq+0x20/0xf8
> > >      async_run_entry_fn+0xfc/0x364
> > >      process_one_work+0x37c/0x7f4
> > >      worker_thread+0x3e8/0x754
> > >      kthread+0x168/0x204
> > >      ret_from_fork+0x10/0x18
> > > The ep device uses msix, the restore process will write bar space
> > > in __pci_msix_desc_mask_irq, which will result in accessing the
> > > powerdown area when the rp doesn't power on.
> > 
> > > It makes sense we should do nothing when the device is still powerdown.
> > > 
> > > Signed-off-by: Jianrong Zhang <zhangjianrong5@huawei.com>
> > > Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
> > > ---
> > >   drivers/pci/pci.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index fba95486caaf..279f6e8c5a00 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1764,7 +1764,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
> > >    */
> > >   void pci_restore_state(struct pci_dev *dev)
> > >   {
> > > -	if (!dev->state_saved)
> > > +	if (!dev->state_saved || dev->current_state == PCI_UNKNOWN)
> > >   		return;
> > 
> > This doesn't seem right to me because it seems like we're covering up
> > a problem elsewhere.
> > 
> > If we need access to the endpoint to restore state, shouldn't we
> > ensure that the endpoint is powered up before we try to access it?
> > 
> > We depend on the state being restored, so if we skip the restore here,
> > where *will* it happen?
>
> As the call stack shows the serror happens in pci_pm_resume_noirq(),
> which belongs to pci pm framework. The resume process related to pci
> devices goes like this:
> 
> stage noirq:
> Root Port's call stack: device_resume_noirq() --> pci_pm_resume_noirq() -->
> resume_noirq callback
> endpoint's call stack: device_resume_noirq() --> pci_pm_resume_noirq() -->
> resume_noirq callback
> 
> stage early:
> Root Port's call stack: device_resume_early() --> pci_pm_resume_early() -->
> device resume_early callback
> endpoint's call stack: device_resume_early() --> pci_pm_resume_early() -->
> device resume_early callback
> 
> stage normal:
> Root Port's call stack: device_resume() --> pci_pm_resume() --> device
> resume callback
> endpoint's call stack: device_resume() --> pci_pm_resume() --> device resume
> callback
> 
> The problem is we don't power up the controller in Root Port's
> resume_noirq callback (actually we don't even register resume_noirq
> callback for some reason), so the serror happens because of
> accessing powerdown area when endpoint's pci_pm_resume_noirq() calls
> pci_restore_state() which will call pci_restore_msi_state() to
> restore MSI-X state.

Yes.  So when is the MSI-X state restored?

If I understand correctly, your patch just skips pci_restore_state()
when the device power state is PCI_UNKNOWN.  But I assume we still
need to restore the MSI-X and other state *somewhere*.

Your patch changes the generic code that *all* platforms use, but I
have not heard of this problem on other hardware, so I assume there's
something different about power management on your platform.  That
makes me think the solution would be a platform-specific change, not
this generic code change.

> So we wonder if there is strong restriction that we must poweron in
> Root Port's resume_noirq callback.  The pci_restore_state() can't
> restore anything when the device is still at PCI_UNKNOWN state, and
> if the device is accessible it can't be at PCI_UNKNOWN state, so the
> patch doesn't make any difference for original process.
