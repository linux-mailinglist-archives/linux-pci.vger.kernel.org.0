Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0D97AC5BB
	for <lists+linux-pci@lfdr.de>; Sun, 24 Sep 2023 00:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjIWWqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Sep 2023 18:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWWqT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Sep 2023 18:46:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA6193
        for <linux-pci@vger.kernel.org>; Sat, 23 Sep 2023 15:46:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81E7C433C7;
        Sat, 23 Sep 2023 22:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695509173;
        bh=4UfwH6VmlNKKImeBmtrRRLIIR9fj+duJLOrCRpOD3Sg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SwmsMaoE/wtzt8ANF73jdoqN1Ru9HGVV4hqFTjNe1WOKuT3CHje0vbx1KlDbsAc6o
         g5iK7+sxmLMMkR/RgPDW/YqsJKwkm+B8xWvdBIMYFX8XC8C0CbAPEDSVeZHbs7uDdL
         80aB0wNpMnyzYSbU8roADRyR2mSyW3VR4zKQHpFfk0AO+GbcieJYZ6aAZFb1EiAxLb
         IdLGLOKKJ1ExhV8PnLc3Xjgy9yYNDAFTwTNjmwP0Bn/XLYMGeEICfu9rVG198r4c96
         BGlfAnm2wavGIsOa4VqSX+EnJxUGt0Yl+ewjMowCqB8StevwLgZOKRFisAISaN3nPS
         yVbGkYvgtQiEA==
Date:   Sat, 23 Sep 2023 17:46:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kamil Paral <kparal@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230923224610.GA371821@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+cBOTej22hWEFvMOnFfKy16tuzS_+S7kccPPYXNoGVbYMoEdA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 10:42:55AM +0200, Kamil Paral wrote:
> On Thu, Aug 24, 2023 at 1:43 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > One thing I noticed, probably has nothing to do with this, but you have
> > the "security level" set to "secure". Now this is fine and actually
> > recommended but I wonder if anything changes if you switch that
> > temporarily to "user"? What is happening here is that once the system
> > enters S3 the Thunderbolt driver tells the firmware to save the
> > connected device list, and then once it exits S3 it is expected to
> > re-connect the PCIe tunnels of the devices on that list but this is not
> > happening and that's why the dock "dissappears" during resume.
> 
> That was a great suggestion. After switching to the user security
> level, the resume delay is gone, and my dock devices seem to be
> working almost immediately after resume! The dmesg for that is here:
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1985262
> 
> I've done tens of cycles and haven't found any race conditions, unlike
> with the TB assist mode. (Only once, my USB mouse wasn't working at
> all, but that's something that occasionally happens on most docks I've
> worked with and seems to be some different issue).
> 
> I'm sorry I haven't found this earlier myself. I did try switching
> these options, but I bundled it together with enabling the TB assist
> mode, which has quirks, so I didn't realize switching just this one
> option might have an impact.
> 
> > In any case we can conclude that the commit in question has nothing to
> > do with the issue. This is completely Thunderbolt related problem.
> 
> Considering the information above, does this appear to be a solely
> dock-related issue (bugged firmware), or does it make sense to follow
> up on this in some different kernel list? I have to say I'm completely
> OK with running the laptop using the "user" TB security level, but if
> you think I should follow up somewhere to get the "secure" level fixed
> (or some workaround applied, etc), I can.

I'm confused about this issue.  Correct me if I go wrong:

The hierarchy is:

  00:1c.4 Root Port to [bus 04-3c]
  04:00.0 Upstream Port (Thunderbolt) to [bus 05-3c]
  05:01.0 Downstream Port (Thunderbolt) to [bus 07-3b]
  07:00.0 Upstream Port (Thunderbolt) to [bus 08-3b]

With security level=secure, before e8b908146d44 ("PCI/PM: Increase
wait time after resume"), resume takes ~5 seconds, but the hierarchy
below 05:01.0 gets removed and re-enumerated (dmesg [1]).  After
e8b908146d44, the same thing happens except the resume takes 60+
seconds (dmesg [2]).  In both cases, the devices (USB mouse, LAN, etc)
below 05:01.0 work after resume.

With security level=user, resume takes << 5 seconds regardless of
e8b908146d44, and the hierarchy below 05:01.0 does not get removed and
re-enumerated (dmesg [3]).

So if that's all accurate, it sounds like we've always had some
problem with security level=secure that causes the hierarchy to get
removed and re-enumerated, and e8b908146d44 just makes this problem
much more visible?

I don't know anything at all about how Thunderbolt security levels
work.  If "secure" means the hierarchy must be re-enumerated after
resume, we can detect that case immediately and get on with it without
having to wait for a timeout?

Bjorn

[1] https://bugzilla-attachments.redhat.com/attachment.cgi?id=1984726
[2] https://bugzilla-attachments.redhat.com/attachment.cgi?id=1984803
[3] https://bugzilla-attachments.redhat.com/attachment.cgi?id=1985262
