Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4746E4ACC3A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 23:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244502AbiBGWpu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 17:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241061AbiBGWps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 17:45:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C7FC061355;
        Mon,  7 Feb 2022 14:45:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23A69CE12FB;
        Mon,  7 Feb 2022 22:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF302C340F0;
        Mon,  7 Feb 2022 22:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644273942;
        bh=qkq40yCflGjOJ7y7JTzQbQGfwF6s4zzKqH433+KJ92U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EP7em8vg/cCJr5iKdH/kyYQXa1Da0wtpS6sxh0EW2W5/Zi2G2gDehBQoES1B722EY
         863M9KTi5IyMdpjVrzSXZRfe+FAaV2BsqwWJh44tv2mpUBkMDfc3WDAwv+uAuo2bZY
         lDQpt4AmDKX/N8k9ia9Kd6nRFHSe24+/6zW8TGYKc5HPwcdcIr93Xmo69B7ianvdf8
         P/4emvsuvRHisUm02S69R5PBKLSPGnhjn4c8L330+yQrM7/w0Wk5brMWCnpKUb3Bwp
         51tk43LFbP2hTF3+cigGAcaZMZXF6Gi+yTQVDOe89Bej8fFpaxnRGtxND0vPbKgg/Z
         z7n9llszolzqw==
Date:   Mon, 7 Feb 2022 16:45:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     joey.corleone@mail.ru, Jan Kiszka <jan.kiszka@siemens.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Bug 215533] [BISECTED][REGRESSION] UI becomes unresponsive
 every couple of seconds
Message-ID: <20220207224540.GA425996@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126121250.GA1694509@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-kernel for visibility]

On Wed, Jan 26, 2022 at 06:12:50AM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 26, 2022 at 08:18:12AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=215533
> > 
> > --- Comment #1 from joey.corleone@mail.ru ---
> > I accidentally sent the report prematurely. So here come my findings:
> > 
> > Since 5.16
> > (1) my system becomes unresponsive every couple of seconds (micro lags), which
> > makes it more or less unusable.
> > (2) wrong(?) CPU frequencies are reported. 
> > 
> > - 5.15 works fine.
> > - Starting from some commit in 5.17, it seems (1) is fixed (unsure), but
> > definitely not (2).
> > 
> > I have bisected the kernel between 5.15 and 5.16, and found that the offending
> > commit is 0e8ae5a6ff5952253cd7cc0260df838ab4c21009 ("PCI/portdrv: Do not setup
> > up IRQs if there are no users"). Bisection log attached.
> > 
> > Reverting this commit on linux-git[1] fixes both (1) and (2).
> > 
> > Important notes:
> > - This regression was reported on a DELL XPS 9550 laptop by two users [2], so
> > it might be related strictly to that model. 
> > - According to user mallocman, the issue can also be fixed by reverting the
> > BIOS version of the laptop to v1.12.
> > - The issue ONLY occurs when AC is plugged in (and stays there even when I
> > unplug it).
> > - When booting on battery power, there is no issue at all.
> > 
> > You can easily observe the regression via: 
> > 
> > watch cat /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_fre
> > 
> > As soon as I plug in AC, all frequencies go up to values around 3248338 and
> > stay there even if I unplug AC. This does not happen at all when booted on
> > battery power. 
> > 
> > Also note: 
> > - the laptop's fans are not really affected by the high frequencies.
> > - setting the governor to "powersave" has no effect on the frequencies (as
> > compared to when on battery power).
> > - lowering the maximum frequency manually works, but does not fix (1).
> > 
> > [1] https://aur.archlinux.org/pkgbase/linux-git/ (pulled commits up to
> > 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8).
> > [2] https://bbs.archlinux.org/viewtopic.php?id=273330

I hope we can find a better solution, but since the responsiveness
issue is a significant regression, I queued up a revert of
0e8ae5a6ff59 ("PCI/portdrv: Do not setup up IRQs if there are no
users") in case we don't find one.

If/when we get to the bottom of this, I'll replace the revert with the
solution.  0e8ae5a6ff59 appeared in v5.16, so we'll have to make sure
we fix that as well.

Bjorn
