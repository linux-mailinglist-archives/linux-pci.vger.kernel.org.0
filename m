Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198E04AC664
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 17:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241109AbiBGQqb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 11:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390297AbiBGQdg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 11:33:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D09C0401D2;
        Mon,  7 Feb 2022 08:33:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DED5F60AEB;
        Mon,  7 Feb 2022 16:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6B5C004E1;
        Mon,  7 Feb 2022 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644251614;
        bh=YStYf4ucIzT6Pp4vPG9FLBRd38te+ElsNSNwIkQkQIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VvOWNT1bEakGUB3rk8C84JoC5A8CHa9ZlUCn5yK0NR4HokD8oNDnUl3ZB+ft+4WzC
         YRzT9FD6utLDS2lwcRcuI19u71/rOJrnPOBfpwuUW7WHK7Uw788CLKi2DD4Vj0kGoW
         o+XxOQ2wwe5o2YD7Tf+SnCIMrSFUiGXg3ENLdZmWNWa+oeCOXuoj8ZkoKJUwojGnwy
         low6gKFnu8uh/uhcq3nxXGxQr3X9QvEKX4L/Yqof7HIX6te3POVJJEq65CxLuSB9kj
         qe0hofIBOqUBvyhxPb+GIN1OB5KvgFO+ugLfJV0BYWHOuAH9aDYtk7FoKT+J1ERbxK
         bPav69BslH5dg==
Date:   Mon, 7 Feb 2022 10:33:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        kai.heng.feng@canonical.com, chris.packham@alliedtelesis.co.nz,
        yangyicong@hisilicon.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <20220207163332.GA397884@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12fe557f-7336-1970-d8f0-5a93529cf8c1@panix.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 05, 2022 at 09:30:07AM -0800, Kenneth R. Crudup wrote:
> > > If you'd like, I could try re-applying the previous problem
> > > commit or your attempted fix on top of Linus' master if you'd
> > > like to see if something was fixed somewhere else in the PCIe
> > > subsystem, but if you think it's not worth- while I'm satisfied
> > > with the current fix (or probably more-exactly for my particular
> > > machine, lack of regression).
> 
> On Sat, 5 Feb 2022, Vidya Sagar wrote:
> 
> > That would be a good starting point to understand it better. In fact if the
> > previous problematic patch works fine on master, then, we are sure that
> > something in the sub-system would have fixed the issue.
> 
> So this is my report of the regression I'd found with Bjorn's original commit:
> ----
> Date: Fri, 25 Dec 2020 16:38:56
> From: Kenneth R. Crudup <kenny@panix.com>
> To: vidyas@nvidia.com
> Cc: bhelgaas@google.com
> Subject: Commit 4257f7e0 ("PCI/ASPM: Save/restore L1SS Capability for suspend/resume") causing hibernate resume
>     failures
> 
> I've been running Linus' master branch on my laptop (Dell XPS 13 2-in-1). With
> this commit in place, after resuming from hibernate my machine is essentially
> useless, with a torrent of disk I/O errors on my NVMe device (at least, and
> possibly other devices affected) until a reboot.
> 
> I do use tlp to set the PCIe ASPM to "performance" on AC and "powersupersave"
> on battery.
> 
> Let me know if you need more information.
> ----
> 
> I just reapplied it on top of Linus' master and not only did it go
> in cleanly(!), NOW I'm not getting any issues after a
> suspend/resume.

So on 12/25/2020 (just before v5.11-rc1), you saw I/O errors after
resume from hibernate, and you apparently went to the trouble to
bisect it to 4257f7e008ea ("PCI/ASPM: Save/restore L1SS Capability for
suspend/resume").

We reverted 4257f7e008ea, and the revert appeared in v5.11-rc7.

I assume you re-applied 4257f7e008ea ("PCI/ASPM: Save/restore L1SS
Capability for suspend/resume") on top of something between v5.17-rc2
and v5.17-rc3, and you don't see those I/O errors.

It's possible something was fixed elsewhere between v5.11-rc1 and
v5.17-rc2, but I'm not really convinced by that theory.

I think it's more likely that something changed in BIOS settings or
other configuration, which means other people may trip over it even if
you don't see it.  Do you remember any BIOS updates, BIOS setup
tweaks, hardware changes, kernel parameter changes, etc?

If the problem really was fixed by some change elsewhere, it *should*
still happen on v5.11-rc1.  I think we should verify that and try to
figure out what the other change was.  People who want to backport the
L1SS save/restore will need to know that anyway.

Bjorn
