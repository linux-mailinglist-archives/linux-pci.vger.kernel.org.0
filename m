Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7A34E6B03
	for <lists+linux-pci@lfdr.de>; Fri, 25 Mar 2022 00:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345671AbiCXXKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 19:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244602AbiCXXKG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 19:10:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4684CDEB6
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 16:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F527CE27F4
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 23:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22D4C340EC;
        Thu, 24 Mar 2022 23:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648163310;
        bh=+fj3xaPsRDI45y26mcpbyMANJHN2oWzqbVm6E13VufQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qWUagAfSFaRrInakkkvfjQ37dKj8Y2F82T4diC8uWkivev2qVapTGPOoO/bp3+yV7
         ob4sj54T0jmZMpJuGgRap5irxWQvYtRfTTgn5fgj5tcRrCbCCwBZFReKBcNZNwjoiy
         7zsC/vh1AJ8fTqNpI4yLZrSfXeSQkmBc5v/JrN4PuM5bAVGwd1A+WFBZ5bQZExQMIt
         Igghbdunjh3PyObdvlDTO3dpx2cdkJiu28Ukgqjda5xSw8c40qb7tiTGt/X4MvRcqy
         Et/myiP7dJp/bx6RxtBIi7GNKUKvgXKMJ3KHQfCaL4kzAb70QRUUhfSRMhORGxHC0J
         DAOBghm4wQyMQ==
Date:   Thu, 24 Mar 2022 18:08:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Message-ID: <20220324230828.GA1486615@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e9fca2f-0af1-3684-6c97-4c35befd5019@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 09:34:30PM +0100, Hans de Goede wrote:
> Hi Mark,
> 
> Thank you for the report.
> 
> On 3/24/22 18:52, Mark Brown wrote:
> > On Wed, Mar 23, 2022 at 11:47:08PM -0700, KernelCI bot wrote:
> > 
> > The KernelCI bisection bot has identified commit 5949965ec9340cfc0e
> > ("x86/PCI: Preserve host bridge windows completely covered by E820")
> > as causing a boot regression in next on asus-C523NA-A20057-coral (a
> > Chromebook AIUI).  Unfortunately there's no useful output when starting
> > the kernel.  I've left the full report below including links to the web
> > dashboard.
> > 
> > The last successful boot in -next had this log:
> > 
> >    https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
> 
> So the interesting bits from this log are:
> 
>  1839 17:54:41.406548  <6>[    0.000000] BIOS-provided physical RAM map:
>  1840 17:54:41.413121  <6>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] type 16
>  1841 17:54:41.419712  <6>[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
>  1842 17:54:41.430192  <6>[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
>  1843 17:54:41.436207  <6>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000fffffff] usable
>  1844 17:54:41.446353  <6>[    0.000000] BIOS-e820: [mem 0x0000000010000000-0x0000000012150fff] reserved
>  1845 17:54:41.453290  <6>[    0.000000] BIOS-e820: [mem 0x0000000012151000-0x000000007a9fcfff] usable
>  1846 17:54:41.459966  <6>[    0.000000] BIOS-e820: [mem 0x000000007a9fd000-0x000000007affffff] type 16
>  1847 17:54:41.469549  <6>[    0.000000] BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
>  1848 17:54:41.476685  <6>[    0.000000] BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
>  1849 17:54:41.486439  <6>[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
>  1850 17:54:41.492994  <6>[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed17fff] reserved
>  1851 17:54:41.503008  <6>[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000017fffffff] usable
> ...
>  2030 17:54:42.809183  <6>[    0.313771] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>  2031 17:54:42.819092  <6>[    0.314424] pci_bus 0000:00: root bus resource [mem 0x7b800000-0xe0000000 window]
> 
> Since the main [mem 0x7b800000-0xe0000000 window] is not fully
> covered by a single e820 entry, for that resource there should be no
> change.
> 
> But the ISA MMIO window: [mem 0x000a0000-0x000bffff window] is fully
> covered by:
> 
> BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> 
> So that will now become available as memory to assign some resources
> to, where before it was not.
> 
> So I guess we should try adding a patch to skip the "fully covered"
> tests for ISA MMIO space and see if that helps ?
> 
> Bjorn do you agree?

Maybe.  Certainly 5949965ec934 should only make a difference if
there's an E820 entry that completely covers a resource.  In that
"completely covered" case we used to clip and now we don't.

I didn't try to work out all the possible clipping cases.  The
[mem 0x000a0000-0x000bffff window] is certainly one, but there could
be others.  remove_e820_regions() was added by 4dc2287c1805 ("x86:
avoid E820 regions when allocating address space"), and it was not
intended to protect the 0xa0000-0xbffff region, so I expect there
should be another reason why we don't allocate from that area.

I assume that since the bot bisected this, there should be successful
boot logs from the commit preceding 5949965ec9340cfc0e, right?

  # good: [d13f73e9108a75209d03217d60462f51092499fe] x86/PCI: Log host bridge window clipping for E820 regions

Those logs should show all the places we clip, and then we could work
out which place(s) are affected by 5949965ec934.

It's unfortunate that 4dc2287c1805 ("x86: avoid E820 regions
when allocating address space") put remove_e820_regions() in the
generic allocation path, when I think what we really wanted was just
to clip PCI host bridge windows.

I'll be on vacation until Monday, so won't be able to spend much time
until then.

Bjorn
