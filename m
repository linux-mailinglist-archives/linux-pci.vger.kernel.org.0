Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1540659B83
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 19:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiL3SuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 13:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiL3SuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 13:50:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B261AD82;
        Fri, 30 Dec 2022 10:50:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C80DD61B76;
        Fri, 30 Dec 2022 18:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AC7C433EF;
        Fri, 30 Dec 2022 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672426208;
        bh=6U1QtAg/fnbIKQ7BjeKrptun4t3AzEhRj/fvZlEBeLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ruzzPgB/hftcNihTSwd6QXLW3eZ4j2qvaXJ6TT/58/btkPBGLMAf4RvsKNAPkUydQ
         1ux+MCf0l1qJOduK5fib2ajmotTx0dgj+YWoYVJW/ZAsvFwAM37geSwptqdKP6Q0Cj
         GJuIgP1LnWCPusb80b85g6dlxneTqy8oeSaLyUiXEV18YKv+G5bAt+IdEzkadxoBhp
         5T/xTM/UJVLd2GrEsuAAlcKbqgSiSGfO1/wyMegRrbuJHLV87l2nNtAPf/bn0tyARj
         9sNNb+2VrX6WcATjN9rbQGkLmB3XfWImPVTm1smlRm6baHT5kZNF0A2DT22wFITeJ/
         eC5aEI0x7XJgg==
Date:   Fri, 30 Dec 2022 12:50:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zeno Davatz <zdavatz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Moreira-Guedes <brunodout.dev@gmail.com>
Subject: Re: [Bug 216859] New: PCI bridge to bus boot hang at enumeration
Message-ID: <20221230185006.GA695815@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228184234.GA530399@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Bruno, to include you here as well as the bugzilla]

On Wed, Dec 28, 2022 at 12:42:34PM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 28, 2022 at 06:42:38PM +0100, Zeno Davatz wrote:
> > On Wed, Dec 28, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> > >
> > > >            Summary: PCI bridge to bus boot hang at enumeration
> > > >     Kernel Version: 6.1-rc1
> > > > ...
> > >
> > > > With Kernel 6.1-rc1 the enumeration process stopped working for me,
> > > > see attachments.
> > > >
> > > > The enumeration works fine with Kernel 6.0 and below.
> > > >
> > > > Same problem still exists with v6.1. and v6.2.-rc1
> > >
> > > Thank you very much for your report, Zeno!
> > >
> > > v6.0 works, v6.1-rc1 fails.  Would you mind booting v6.1-rc1 with the
> > > "ignore_loglevel initcall_debug" kernel parameters and taking a photo
> > > when it hangs?
> > 
> > I will try this after Januar 7th 2023.
> 
> Sounds good, thanks!
> 
> > > How did you conclude that the hang is related to a PCI bridge?  I see
> > > recent PCI messages in the photo, but it looks like the last message
> > > is from NFS, so I'm wondering if I'm missing some context.  The v6.0
> > > dmesg shows several other ntfs, fuse, JFS, etc messages before more
> > > PCI-related things.  Anyway, the "initcall_debug" might help us narrow
> > > it down a bit.
> > 
> > I did not really conclude that. I just saw "PCI" as one of the last
> > messages being outputted before the boot process stopped.
> 
> OK.  We'll figure it out!
> 
> Bjorn
