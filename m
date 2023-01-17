Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92566E673
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 19:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjAQSvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 13:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjAQSr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 13:47:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF114DCE8
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 10:15:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B3E2B81911
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 18:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844DEC433F0;
        Tue, 17 Jan 2023 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979325;
        bh=C/Rlqd06hTG+sBwbmTa7yjDrxvllM1QBeEIK/4R580U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h5YI8X8Gh6D7f0v217gVFzrElT63JOXfaFiPoFYnb+2a70/7JiXk4dxDu+Y49xv45
         CpjhosyXT0I4pE3UI4pnu6cmRo8/U3c8L3GPtKKwQQDh88laoJuFeBCxx+0ZHGT8uP
         klFHIwr5Bx83MLr26hcDbmGujlEnn/YuLCupEirE75GW6BzkBiYUFoWuFZeOLRNnqG
         uxfyctBOR0yXPQxoUB9plz4worqNoanVgYWXYPGvStlM3XBaWlaWOtEg9XtNqbr4Fz
         PUlsu3ZBEltblSAA4ZMkd3w6L88ERSo6hb9SaVlszyv4n8QlbPwd/3xPQbuXAbmYhL
         MvbBmVmHXKPdQ==
Date:   Tue, 17 Jan 2023 12:15:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huang Adrian <adrianhuang0701@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Adrian Huang <ahuang12@lenovo.com>,
        Jon Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH v2 1/1] PCI: vmd: Avoid acceidental enablement of window
 when zeroing config space of VMD root ports
Message-ID: <20230117181523.GA134569@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHKZfL1PPo=fyukj8UA5=m4TUSjFiUj65wC4FmU6w-XW1mJyqw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 17, 2023 at 05:50:05PM +0800, Huang Adrian wrote:
> On Wed, Jan 11, 2023 at 11:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > When memset_io() clears prefetchable base 32 bits register, the
> > > prefetchable memory becomes 0000000000000000-575000fffff, which
> > > is enabled.  This behavior (accidental enablement of window)
> > > causes that config accesses get routed to the wrong place, and
> > > the access content of PCI configuration space of VMD root ports
> > > is 0xff after invoking memset_io() in vmd_domain_reset():
> >
> > I was thinking the problem was only between clearing
> > PCI_PREF_MEMORY_BASE and PCI_PREF_BASE_UPPER32, but that would be
> > a pretty small window, and you're seeing a lot of config accesses
> > going wrong.  Why is that?  Is there enumeration that races with
> > this domain reset?
> 
> Well, I didn't see the races. The problem is that: memset_io() uses
> enhanced REP STOSB, fast-string operation or legacy method (see
> arch/x86/lib/memset_64.S) to *sequentially* clear the memory
> location from lower memory location to higher one.

Obviously we can't *ever* clear both PCI_PREF_MEMORY_BASE and
PCI_PREF_BASE_UPPER32 atomically, whether it's via memset_io(),
writel(), or whatever.  I understand that.

> When clearing at PCI_PREF_BASE_UPPER32, the prefetchable memory
> window is accidentally enabled. The subsequent accesses (each read
> returns 0xff, and each write does not take any effect) cannot be
> made correctly. In this case, clearing at PCI_PREF_LIMIT_UPPER32
> cannot take any effect. So, we're unable to configure VMD devices
> anymore for subsequent writes.

I understand the mechanism that temporarily enables the window.  But I
don't understand the part about "clearing PCI_PREF_LIMIT_UPPER32
*cannot* take any effect."

Is it impossible to clear PCI_PREF_LIMIT_UPPER32 while the window is
enabled?  Given the normal PCI rules, I don't understand why that
would be.

This sequence is problematic because the window is accidentally
enabled:

  1)  clear PCI_PREF_MEMORY_BASE
  2)  <window is enabled here>
  3)  clear PCI_PREF_BASE_UPPER32

and the following sequence works as desired:

  clear PCI_PREF_BASE_UPPER32
  clear PCI_PREF_MEMORY_BASE

The interval between 1) and 3) above should be short: there are only a
few config writes between them.

But you're seeing DMAR VT-d config reads that fail.  Why are those
happening at the same time as VMD enumeration?  And apparently you can
also run lspci and see *those* config reads fail.

There has to be more going on here than a window that is accidentally
enabled for a few milliseconds.  *That* is my question.

Bjorn
