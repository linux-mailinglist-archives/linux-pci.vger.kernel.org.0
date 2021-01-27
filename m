Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DBC306037
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhA0PvM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 10:51:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235493AbhA0PvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 10:51:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ED7B207B7;
        Wed, 27 Jan 2021 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611762626;
        bh=3lSogROR7eblCTF10SVJeAABAapek6VwIQuPU+LvZnI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZH8tAPulqtV+01DssnEN3ps2dW0ccm7v0EBAh/S4Owpdj5DRFnMYj7yVwF6EQXypG
         gRqaAHab+oft1jovSoXOa6xZCsGG1vNfl24+ifYHobm9wRkR31Zo4mgsaekb00BBVo
         r97dLeUmsDek8yH8uF8sFhhl/6YINXBpJoGBy3d0DbYXzO0f8oL1loBvXHnQJfL/pi
         JFaKQGFgkc8B1kp/uotpmyrFNU+RlmqUyZE9dQtt5g4skA5ikYy/SeE+GMm1So+Aml
         nOitgwEDMeD3kRrZT/Qls/Qo4RN7jE/dS3Nys0RT7JC98BOnKoAfw4n9Q+T4POpFdg
         g4w28p32BuJBg==
Date:   Wed, 27 Jan 2021 09:50:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 4257f7e0 ("PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume") causing hibernate resume failures
Message-ID: <20210127155023.GA2988674@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2563ba4a-81bc-d27-2670-cae48690db5e@panix.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 22, 2021 at 12:11:08PM -0800, Kenneth R. Crudup wrote:
> > > From: Kenneth R. Crudup <kenny@panix.com>
> > > I've been running Linus' master branch on my laptop (Dell XPS 13
> > > 2-in-1).  With this commit in place, after resuming from hibernate
> > > my machine is essentially useless, with a torrent of disk I/O errors
> > > on my NVMe device (at least, and possibly other devices affected)
> > > until a reboot.
> > >
> > > I do use tlp to set the PCIe ASPM to "performance" on AC and
> > > "powersupersave" on battery.
> 
> On Sun, 27 Dec 2020, Bjorn Helgaas wrote:
> 
> > Thanks a lot for the report, and sorry for the breakage.
> > 4257f7e008ea restores PCI_L1SS_CTL1, then PCI_L1SS_CTL2.  I think it
> > should do those in the reverse order, since the Enable bits are in
> > PCI_L1SS_CTL1.  It also restores L1SS state (potentially enabling
> > L1.x) before we restore the PCIe Capability (potentially enabling ASPM
> > as a whole).  Those probably should also be in the other order.
> 
> Any new news on this? Disabling "tlp" (which just shifts the problem around
> on my machine) shouldn't be a solution for this issue.

Agreed; disabling "tlp" is a workaround but not a solution.

> I'd thought it may have been tied to some of the PM regressions of the last
> week of December, but all of those have been fixed but this still remains.

I haven't seen anything yet and haven't had a chance to look into it
more myself.

We're at v5.11-rc5 already, so I guess we'll have to think about
reverting 4257f7e008ea ("PCI/ASPM: Save/restore L1SS Capability for
suspend/resume") before v5.11-final unless we can make some progress.

That would mean ASPM L1 substate configuration would be lost by a
suspend/resume, so we'd give up some power saving.  But that's better
than the regression you're seeing.

I'll tentatively queue up a revert on for-linus pending progress on a
better fix.  For some reason I can't find your initial report of the
regression.  The first thing I can find is this:

https://lore.kernel.org/linux-pci/20201228040513.GA611645@bjorn-Precision-5520/

Do you have a URL for your initial report that I could include in the
revert commit log?

Bjorn
