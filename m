Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5916585D4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Dec 2022 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiL1Smj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Dec 2022 13:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiL1Smi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2022 13:42:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB121277B;
        Wed, 28 Dec 2022 10:42:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D576E615B5;
        Wed, 28 Dec 2022 18:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072CAC433EF;
        Wed, 28 Dec 2022 18:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672252956;
        bh=TKiX1PVB5u9G4qARr/t9Qb4uVt5o5+ndHDIWsWb5Vy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jqnP+LETaHGdxc9M0X1qj8ONaWeWiejJVMeYeJa0xZkM6np/LOBNDh0OpbhkKfcGv
         NXCTymA/F7e4zENICfBw5+F02x/UznOdgUfshXVnmHk7mzOcaFLRfNPg+kYzIo93Av
         ga0t7MyKCvuxnV62ZaAUmYU8MG9LE3k4/mxPU17XiTmFadLHdRai+MXmeM3DweqMrL
         BTokrSUVE9u9WfOLmPb+szym/0wbpdYx9FwfEDQmioIN9z46ft8Vr5gV1StUa0B4B1
         0mxTJVQqvOtQ5/cVvJHUEybXeg1wdFQjgFBakwW99ghQkzCF9CZ5GxNP8R2kTzuz0f
         xLcPBecnlyfRw==
Date:   Wed, 28 Dec 2022 12:42:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zeno Davatz <zdavatz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug 216859] New: PCI bridge to bus boot hang at enumeration
Message-ID: <20221228184234.GA530399@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOkhzLXr_+oydSFVm+LdwzCU+qZ_A=m4dcV+r=Uf-OjQnNdJqA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 28, 2022 at 06:42:38PM +0100, Zeno Davatz wrote:
> Dear Bjorn
> 
> On Wed, Dec 28, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc linux-pci, linux-kernel]
> >
> > On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> >
> > >            Summary: PCI bridge to bus boot hang at enumeration
> > >     Kernel Version: 6.1-rc1
> > > ...
> >
> > > With Kernel 6.1-rc1 the enumeration process stopped working for me,
> > > see attachments.
> > >
> > > The enumeration works fine with Kernel 6.0 and below.
> > >
> > > Same problem still exists with v6.1. and v6.2.-rc1
> >
> > Thank you very much for your report, Zeno!
> >
> > v6.0 works, v6.1-rc1 fails.  Would you mind booting v6.1-rc1 with the
> > "ignore_loglevel initcall_debug" kernel parameters and taking a photo
> > when it hangs?
> 
> I will try this after Januar 7th 2023.

Sounds good, thanks!

> > How did you conclude that the hang is related to a PCI bridge?  I see
> > recent PCI messages in the photo, but it looks like the last message
> > is from NFS, so I'm wondering if I'm missing some context.  The v6.0
> > dmesg shows several other ntfs, fuse, JFS, etc messages before more
> > PCI-related things.  Anyway, the "initcall_debug" might help us narrow
> > it down a bit.
> 
> I did not really conclude that. I just saw "PCI" as one of the last
> messages being outputted before the boot process stopped.

OK.  We'll figure it out!

Bjorn
