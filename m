Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8F0674C64
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 06:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjATFaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 00:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjATF2x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 00:28:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAAB72C33;
        Thu, 19 Jan 2023 21:23:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E504BB82671;
        Thu, 19 Jan 2023 17:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71553C433D2;
        Thu, 19 Jan 2023 17:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674147604;
        bh=IsPO8S/oCSzGPZ8455uZgGSwmix/EjYODvjeJWwsjEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O6eOYocHeXXxAvmJL57obWdcak0zyidIdD/Y4h6WcW3rWpgn+/IS7jZ6BgmZYUgOO
         dZIBuUYgGFO3pK3BOjmu0JzO6BqqpWxKf4eOkQ+H7ZlaGblFpbh6nrf3Jf9a2JQSNs
         QaTr/dD47vaDLEm5XVMKNcu4G3RueX0kw1RTasT6HsmWo/+IHCs6kcSC3HgHHV4TFW
         xLog8lPDBI1sJVUI38NGMwD/PocFVFu8/TW37AQQFrBVf0sV5wVHYahlM8sYvFd8no
         PLr7PfLFsxoRRvqEsqiF0bIZZe60p/afuUfUDDLr2haFsG46QvxNEGRlrtJ8CSkUn0
         SS7KXsBHV5ycw==
Date:   Thu, 19 Jan 2023 11:00:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zeno Davatz <zdavatz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Moreira-Guedes <brunodout.dev@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bjorn@helgaas.com>
Subject: Re: [Bug 216859] New: PCI bridge to bus boot hang at enumeration
Message-ID: <20230119170003.GA316230@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119000458.GA275446@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc bjorn@helgaas.com to avoid spamassassin]

On Wed, Jan 18, 2023 at 06:04:58PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 06, 2023 at 05:42:33PM +0100, Zeno Davatz wrote:
> > On Fri, Dec 30, 2022 at 7:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Dec 28, 2022 at 12:42:34PM -0600, Bjorn Helgaas wrote:
> > > > On Wed, Dec 28, 2022 at 06:42:38PM +0100, Zeno Davatz wrote:
> > > > > On Wed, Dec 28, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> > > > > >
> > > > > > >            Summary: PCI bridge to bus boot hang at enumeration
> > > > > > >     Kernel Version: 6.1-rc1
> > > > > > > ...
> > > > > >
> > > > > > > With Kernel 6.1-rc1 the enumeration process stopped working for me,
> > > > > > > see attachments.
> > > > > > >
> > > > > > > The enumeration works fine with Kernel 6.0 and below.
> > > > > > >
> > > > > > > Same problem still exists with v6.1. and v6.2.-rc1
> > > > > >
> > > > > > Thank you very much for your report, Zeno!
> > > > > >
> > > > > > v6.0 works, v6.1-rc1 fails.  Would you mind booting v6.1-rc1 with the
> > > > > > "ignore_loglevel initcall_debug" kernel parameters and taking a photo
> > > > > > when it hangs?
> > > > >
> > > > > I will try this after Januar 7th 2023.
> > 
> > I updated the issue:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> > 
> > I booted with the option: "ignore_loglevel initcall_debug"
> 
> Thanks!  There's so much pcie output in that picture that we can't see
> any of the initcall logging.  Can you capture another movie, but use
> kernel parameters like "ignore_loglevel initcall_debug boot_delay=100"
> to slow things down?  The full-speed boot is too fast for the camera
> to capture all the output.  You can do this on any convenient kernel
> that hangs.

Thanks for the new movie!  The last initcalls I see before the hang
are:

  init_mqueue_fs
  key_proc_init
  jent_mod_init

We must have returned from jent_mod_init() because I think the "saving
config space" messages we see at the hang are from
pcie_portdrv_init().

I built 833477fce7a1 ("Merge tag 'sound-6.1-rc1' of
git://git.kernel.org/pub/scl) with your .config and when I boot it on
qemu, I see this:

  calling  jent_mod_init+0x0/0x32 @ 1
  initcall jent_mod_init+0x0/0x32 returned 0 after 27185 usecs
  calling  af_alg_init+0x0/0x45 @ 1
  NET: Registered PF_ALG protocol family
  ...
  calling  sg_pool_init+0x0/0xb4 @ 1
  initcall sg_pool_init+0x0/0xb4 returned 0 after 462 usecs
  calling  pcie_portdrv_init+0x0/0x43 @ 1
  pcieport 0000:00:1c.0: vgaarb: pci_notify
  pcieport 0000:00:1c.0: runtime IRQ mapping not provided by arch
  pcieport 0000:00:1c.0: enabling bus mastering
  pcieport 0000:00:1c.0: PME: Signaling with IRQ 24
  pcieport 0000:00:1c.0: AER: enabled with IRQ 24
  pcieport 0000:00:1c.0: saving config space at offset 0x0 (reading 0x34208086)
  pcieport 0000:00:1c.0: saving config space at offset 0x4 (reading 0x100507)
  pcieport 0000:00:1c.0: saving config space at offset 0x8 (reading 0x6040002)
  ...

Would you mind trying again with "boot_delay=1000 pcie_ports=compat"?

"boot_delay=1000" should slow it down more (all the action is in the
last 3 seconds and it's still hard to see) and "pcie_ports=compat"
should turn off the PCIe port driver.

Bjorn
