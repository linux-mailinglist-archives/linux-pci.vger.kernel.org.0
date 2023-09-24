Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72DD7ACBCD
	for <lists+linux-pci@lfdr.de>; Sun, 24 Sep 2023 22:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjIXUSK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Sep 2023 16:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXUSJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Sep 2023 16:18:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BDDE3
        for <linux-pci@vger.kernel.org>; Sun, 24 Sep 2023 13:18:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF95C433C8;
        Sun, 24 Sep 2023 20:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695586682;
        bh=wzkKs8nM61tPb/cbpTmVydWM/rN37xJ2tQNhVuWGjn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QSzGtzGTwcKSTw2T7rm29OuIobJa5AgJNmSmCPx5n6qiE85tFuB+20RcM2nfcti8F
         j3+IUvh+NNAmA07DWEP5Clu7f5KkIDtLHwg/3b70PHl8fVNzXdl78yjhy2+JVnGdcf
         suf4eI2qR5MvVYrhfwzNfhUXNqqvD7A/5QssnuXQWPJzOXvmr3F3ILI6Bdd/C1Ij3D
         OgoS+F7Qd6VBBgUnQRJcbOQIE2RrqSlfTgiRNYdru94zkborY7xRkfoCcMGnazBZ65
         AfsdLxqimI3ORDiC2X6JEGCRDIJZHbJZvL++d8RiTRLz/P/LGsjCf+xmewm0zYFZDp
         UXF+wD/GmOFkw==
Date:   Sun, 24 Sep 2023 15:18:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Kamil Paral <kparal@redhat.com>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, bhelgaas@google.com,
        chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230924201800.GA375331@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230924132722.GE3208943@black.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 24, 2023 at 04:27:22PM +0300, Mika Westerberg wrote:
> On Sat, Sep 23, 2023 at 05:46:10PM -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 25, 2023 at 10:42:55AM +0200, Kamil Paral wrote:
> > > On Thu, Aug 24, 2023 at 1:43 PM Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> > > > One thing I noticed, probably has nothing to do with this, but you have
> > > > the "security level" set to "secure". Now this is fine and actually
> > > > recommended but I wonder if anything changes if you switch that
> > > > temporarily to "user"? What is happening here is that once the system
> > > > enters S3 the Thunderbolt driver tells the firmware to save the
> > > > connected device list, and then once it exits S3 it is expected to
> > > > re-connect the PCIe tunnels of the devices on that list but this is not
> > > > happening and that's why the dock "dissappears" during resume.
> > > 
> > > That was a great suggestion. After switching to the user security
> > > level, the resume delay is gone, and my dock devices seem to be
> > > working almost immediately after resume! The dmesg for that is here:
> > > https://bugzilla-attachments.redhat.com/attachment.cgi?id=1985262
> > > 
> > > I've done tens of cycles and haven't found any race conditions, unlike
> > > with the TB assist mode. (Only once, my USB mouse wasn't working at
> > > all, but that's something that occasionally happens on most docks I've
> > > worked with and seems to be some different issue).
> > > 
> > > I'm sorry I haven't found this earlier myself. I did try switching
> > > these options, but I bundled it together with enabling the TB assist
> > > mode, which has quirks, so I didn't realize switching just this one
> > > option might have an impact.
> > > 
> > > > In any case we can conclude that the commit in question has nothing to
> > > > do with the issue. This is completely Thunderbolt related problem.
> > > 
> > > Considering the information above, does this appear to be a solely
> > > dock-related issue (bugged firmware), or does it make sense to follow
> > > up on this in some different kernel list? I have to say I'm completely
> > > OK with running the laptop using the "user" TB security level, but if
> > > you think I should follow up somewhere to get the "secure" level fixed
> > > (or some workaround applied, etc), I can.
> > 
> > I'm confused about this issue.  Correct me if I go wrong:
> > 
> > The hierarchy is:
> > 
> >   00:1c.4 Root Port to [bus 04-3c]
> >   04:00.0 Upstream Port (Thunderbolt) to [bus 05-3c]
> >   05:01.0 Downstream Port (Thunderbolt) to [bus 07-3b]
> >   07:00.0 Upstream Port (Thunderbolt) to [bus 08-3b]
> > 
> > With security level=secure, before e8b908146d44 ("PCI/PM: Increase
> > wait time after resume"), resume takes ~5 seconds, but the hierarchy
> > below 05:01.0 gets removed and re-enumerated (dmesg [1]).  After
> > e8b908146d44, the same thing happens except the resume takes 60+
> > seconds (dmesg [2]).  In both cases, the devices (USB mouse, LAN, etc)
> > below 05:01.0 work after resume.
> > 
> > With security level=user, resume takes << 5 seconds regardless of
> > e8b908146d44, and the hierarchy below 05:01.0 does not get removed and
> > re-enumerated (dmesg [3]).
> > 
> > So if that's all accurate, it sounds like we've always had some
> > problem with security level=secure that causes the hierarchy to get
> > removed and re-enumerated, and e8b908146d44 just makes this problem
> > much more visible?
> 
> Yes.
> 
> > I don't know anything at all about how Thunderbolt security levels
> > work.  If "secure" means the hierarchy must be re-enumerated after
> > resume, we can detect that case immediately and get on with it without
> > having to wait for a timeout?
> 
> "secure" means that the Thunderbolt device that is connected can "prove"
> it is the device we "authorized". It basically has a random number we
> generated flashed on the NVM. This is the security "measure" used before
> PC world aligned to use IOMMU instead.
> 
> (there is an explanation of all these here:
> https://docs.kernel.org/admin-guide/thunderbolt.html#security-levels-and-how-to-use-them).

So is there some user-level software that runs between the removal and
re-enumeration?  Something that authorizes the 07:00.0 Upstream Port?

> Now, in case of resume the Thunderbolt firmware is expected to connect
> the PCIe tunnel before the OS gets to resume its PCIe stack but this is
> not happening in this particular system when the security level is set
> to "secure". It could be firmware issue, and also if the BIOS settings
> get changed from the defaults it is entirely possible that the system
> enters paths that are not fully validated. Yes, changing security level
> should definitely work and the PCIe tunnel should be properly
> established but in any case this is Thunderbolt issue not PCIe issue.
> 
> I don't recall if I suggested this already but if not, try to see there
> is a firmware update for your system. Lenovo supports LVFS so if there
> is newer one fwupd should allow you to upgrade it.

I think you have suggested a firmware update, but I don't think that's
a great solution for most users.  An ordinary user who has the
security level set to "secure" and updates to a v6.4 kernel is just
going to think resume is broken.  That user will not be willing or
able to diagnose it as a security setting that could be changed or
firmware that could be updated.

It would be ideal if we could make "secure" resume as fast as "user"
resume, but at the very least, I think we need to make it no worse
than it was in v6.3.

Bjorn
