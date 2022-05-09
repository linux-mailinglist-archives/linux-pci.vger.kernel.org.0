Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F8C520339
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbiEIRLK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 13:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239523AbiEIRLJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 13:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA3D142809
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 10:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A3DE6153F
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 17:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF982C385AC;
        Mon,  9 May 2022 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652116033;
        bh=7mdyGEpL3OOua4pxGGbQjQ82HdhK59OERf0hhMsH08k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NRjnV2G+B68kKhCzD/QCQ/mkBRN6sB4/GbcIpuNVe2OL5J/qRXvEdh4GuOK65Xa3r
         xudqrXe9uJjNXFLqTWAumdnK5eW4tTaatY4O/+l69Ka47MSnEbfde7wz4b4CHaGqmB
         9JHwPJwUCHMVb3LR5gcnruqadM54mPE1Cw0JQGsvKx4A7nBLfnA/0k4jAdvpk1GyiT
         MSfkkLrK2EPrY9EuLBtCT4MOFdUS6slSRtwHbkJrRwKqT0Lr1ysWX39F4waLxXhYWN
         rLDALggmWKZSAEppgE1cZaNe06ARS9bcJrSC0iAw3eSKAWfv41nr623SX7ypqUy5vi
         RRyXZkcjnLzwA==
Date:   Mon, 9 May 2022 12:07:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cyril Brulebois <kibi@debian.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Jim Quinlan <jim2101024@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>, bjorn@helgaas.com
Subject: Re: [Bug 215925] New: PCIe regression on Raspberry Pi Compute Module
 4 (CM4) breaks booting
Message-ID: <20220509170708.GA604646@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3aa008b9-e477-3e6d-becb-13e28ea91f10@leemhuis.info>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 09:44:29AM +0200, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker. Partly top-posting to
> mnake this easily accessible.
> 
> Jim, what's up here? The regression was reported more than a week ago
> and it seems nothing happened since then. Or was there progress and I
> just missed it?
> 
> Anyway:
> 
> [TLDR: I'm adding this regression report to the list of tracked
> regressions; all text from me you find below is based on a few templates
> paragraphs you might have encountered already already in similar form.]
> 
> On 02.05.22 20:38, Bjorn Helgaas wrote:
> > On Sat, Apr 30, 2022 at 2:53 PM <bugzilla-daemon@kernel.org> wrote:
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=215925
> >>
> >>             Bug ID: 215925
> >>            Summary: PCIe regression on Raspberry Pi Compute Module 4 (CM4)
> >>                     breaks booting
> >>            Product: Drivers
> >>            Version: 2.5
> >>     Kernel Version: v5.17-rc1
> >>           Hardware: ARM
> >>                 OS: Linux
> >>               Tree: Mainline
> >>             Status: NEW
> >>           Severity: normal
> >>           Priority: P1
> >>          Component: PCI
> >>           Assignee: drivers_pci@kernel-bugs.osdl.org
> >>           Reporter: kibi@debian.org
> >>         Regression: No
> >>
> >> Catching up with latest kernel releases in Debian, it turned out that my
> >> Raspberry Pi Compute Module 4, mounted on an official Compute Module 4 IO
> >> Board,
> >> and booting from an SD card, no longer boots: this means a black screen on the
> >> HDMI output, and no output on the serial console.
> >>
> >> Trying various releases, I confirmed that v5.16 was fine, and v5.17-rc1 was the
> >> first (pre)release that wasn't.
> >>
> >> After some git bisect, it turns out the cause seems to be the following commit
> >> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=830aa6f29f07a4e2f1a947dfa72b3ccddb46dd21):
> >>
> >> ```
> >> commit 830aa6f29f07a4e2f1a947dfa72b3ccddb46dd21
> >> Author: Jim Quinlan <jim2101024@gmail.com>
> >> Date:   Thu Jan 6 11:03:27 2022 -0500
> >>
> >>     PCI: brcmstb: Split brcm_pcie_setup() into two funcs
> >> ```
> >>
> >> Starting with this commit, the kernel panics early (before 0.30 seconds), with
> >> an `Asynchronous SError Interrupt`. The backtrace references various
> >> `brcm_pcie_*` functions; I can share a picture or try and transcribe it
> >> manually if that helps (nothing on the serial console…).
> >>
> >> This commit is part of a branch that was ultimately merged as
> >> d0a231f01e5b25bacd23e6edc7c979a18a517b2b; starting with this commit, there's
> >> not even a backtrace anymore, the screen stays black after the usual “boot-up
> >> rainbow”, and there's still nothing on the serial console.
> >>
> >> I confirmed that 88db8458086b1dcf20b56682504bdb34d2bca0e2 (on the master side)
> >> was still booting properly, and that 87c71931633bd15e9cfd51d4a4d9cd685e8cdb55
> >> (from the branch being merged into master) is the last commit showing the
> >> panic.
> >>
> >> Since d0a231f01e5b25bacd23e6edc7c979a18a517b2b is a merge commit that includes
> >> conflict resolutions in drivers/pci/controller/pcie-brcmstb.c, I suppose this
> >> could be consistent with the initial panic being “upgraded” into an even more
> >> serious issue.
> >>
> >> I've also verified that latest master (v5.18-rc4-396-g57ae8a492116) is still
> >> affected by this issue.
> >>
> >> The regular Raspberry Pi 4 B doesn't seem to be affected by this issue: the
> >> exact same image on the same SD card (with latest master) boots fine on it.

Cyril, 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two
funcs") reverts cleanly as of 57ae8a492116.  Does reverting it avoid
the regression?
