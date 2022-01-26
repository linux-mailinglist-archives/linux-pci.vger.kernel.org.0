Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7C849C958
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 13:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiAZMMz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 07:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiAZMMz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 07:12:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3269AC06161C
        for <linux-pci@vger.kernel.org>; Wed, 26 Jan 2022 04:12:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE18DB81CBB
        for <linux-pci@vger.kernel.org>; Wed, 26 Jan 2022 12:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5946AC340E3;
        Wed, 26 Jan 2022 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643199172;
        bh=YX5baDbE1GWQCRxqExBo0eSccknGG7xkF0mfrtJFsx4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oPnLc5bvP/gg0s11qeRiLbts8HJzbwx5TP+GmnBG8Ovk7oMKuX5pk039ylc07UA6o
         9xuRkSq7gpzmq7QNfvivYQgCNRdCqUmo3O2iJLquQX4OHQM0DASJ6GpF0q1BFGTVWD
         OjFsgZnxQ/5RyBapmtez/nUlh/bpABh8kugGS+wmLaFd3c52aiNeniIjdVLAGhLrkb
         PWekGTxBdKlv+6tm/2TNrhFYxxcim9cA28cXm00KkLqMnZP9TdWsCh2AlZxx4Z6emH
         fe0PAWwliiS8YDOnyHp1xapGOiRCli2j7LVMvgNs/3Lfx8DmT7ZIWcO7OlHnM/3ob9
         cyj90GybD88Zg==
Date:   Wed, 26 Jan 2022 06:12:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     joey.corleone@mail.ru, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [Bug 215533] [BISECTED][REGRESSION] UI becomes unresponsive
 every couple of seconds
Message-ID: <20220126121250.GA1694509@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-215533-41252-1JFKZyUc5S@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jan, author of 0e8ae5a6ff59, linux-pci]

On Wed, Jan 26, 2022 at 08:18:12AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215533
> 
> --- Comment #1 from joey.corleone@mail.ru ---
> I accidentally sent the report prematurely. So here come my findings:
> 
> Since 5.16
> (1) my system becomes unresponsive every couple of seconds (micro lags), which
> makes it more or less unusable.
> (2) wrong(?) CPU frequencies are reported. 
> 
> - 5.15 works fine.
> - Starting from some commit in 5.17, it seems (1) is fixed (unsure), but
> definitely not (2).
> 
> I have bisected the kernel between 5.15 and 5.16, and found that the offending
> commit is 0e8ae5a6ff5952253cd7cc0260df838ab4c21009 ("PCI/portdrv: Do not setup
> up IRQs if there are no users"). Bisection log attached.
> 
> Reverting this commit on linux-git[1] fixes both (1) and (2).
> 
> Important notes:
> - This regression was reported on a DELL XPS 9550 laptop by two users [2], so
> it might be related strictly to that model. 
> - According to user mallocman, the issue can also be fixed by reverting the
> BIOS version of the laptop to v1.12.
> - The issue ONLY occurs when AC is plugged in (and stays there even when I
> unplug it).
> - When booting on battery power, there is no issue at all.
> 
> You can easily observe the regression via: 
> 
> watch cat /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_fre
> 
> As soon as I plug in AC, all frequencies go up to values around 3248338 and
> stay there even if I unplug AC. This does not happen at all when booted on
> battery power. 
> 
> Also note: 
> - the laptop's fans are not really affected by the high frequencies.
> - setting the governor to "powersave" has no effect on the frequencies (as
> compared to when on battery power).
> - lowering the maximum frequency manually works, but does not fix (1).
> 
> [1] https://aur.archlinux.org/pkgbase/linux-git/ (pulled commits up to
> 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8).
> [2] https://bbs.archlinux.org/viewtopic.php?id=273330
> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are watching the assignee of the bug.
