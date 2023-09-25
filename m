Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D847ACF4C
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 06:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjIYE7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 00:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjIYE7j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 00:59:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CBADA
        for <linux-pci@vger.kernel.org>; Sun, 24 Sep 2023 21:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695617973; x=1727153973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pdaB8lXOLYn4cozBzE1hRgyOBU92AGkqXVw8MKc21s8=;
  b=E97U9vv3EM2xaCJIoYalZX034YYpbRu1oG0lVnRXvuZM4cF8pN/bwwyx
   ihqR9rd+eG51Fm0iBlkbs2vRSID2kkpeNes8HvrbqjN+aQE3ytTAt9iOT
   ecMf8QKQJZMftdKEsY5X0uCbt4n2XdIiFq534udgSyWERFs3FhINWjYxg
   IPrv5Mnod+fauXZBOpn7lwX622Gl9uQokNisRIWwSoe675XttaMqzhdGv
   zfo+WmS6QqbQcQeLY+x1Dzez3ZMtt5Z9rzYsljOWDQbbep4Iek9dbsMo7
   pCbuosMXGVCs5ZM6wKyLzYKpMP2EzTwktapOg5oZWWp56OM26wKVZ0i0W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384996310"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="384996310"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 21:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="741781123"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="741781123"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2023 21:59:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 07CDB1C7; Mon, 25 Sep 2023 07:59:28 +0300 (EEST)
Date:   Mon, 25 Sep 2023 07:59:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kamil Paral <kparal@redhat.com>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, bhelgaas@google.com,
        chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230925045928.GH3208943@black.fi.intel.com>
References: <20230924132722.GE3208943@black.fi.intel.com>
 <20230924201800.GA375331@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230924201800.GA375331@bhelgaas>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 24, 2023 at 03:18:00PM -0500, Bjorn Helgaas wrote:
> On Sun, Sep 24, 2023 at 04:27:22PM +0300, Mika Westerberg wrote:
> > On Sat, Sep 23, 2023 at 05:46:10PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Aug 25, 2023 at 10:42:55AM +0200, Kamil Paral wrote:
> > > > On Thu, Aug 24, 2023 at 1:43 PM Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > > > > One thing I noticed, probably has nothing to do with this, but you have
> > > > > the "security level" set to "secure". Now this is fine and actually
> > > > > recommended but I wonder if anything changes if you switch that
> > > > > temporarily to "user"? What is happening here is that once the system
> > > > > enters S3 the Thunderbolt driver tells the firmware to save the
> > > > > connected device list, and then once it exits S3 it is expected to
> > > > > re-connect the PCIe tunnels of the devices on that list but this is not
> > > > > happening and that's why the dock "dissappears" during resume.
> > > > 
> > > > That was a great suggestion. After switching to the user security
> > > > level, the resume delay is gone, and my dock devices seem to be
> > > > working almost immediately after resume! The dmesg for that is here:
> > > > https://bugzilla-attachments.redhat.com/attachment.cgi?id=1985262
> > > > 
> > > > I've done tens of cycles and haven't found any race conditions, unlike
> > > > with the TB assist mode. (Only once, my USB mouse wasn't working at
> > > > all, but that's something that occasionally happens on most docks I've
> > > > worked with and seems to be some different issue).
> > > > 
> > > > I'm sorry I haven't found this earlier myself. I did try switching
> > > > these options, but I bundled it together with enabling the TB assist
> > > > mode, which has quirks, so I didn't realize switching just this one
> > > > option might have an impact.
> > > > 
> > > > > In any case we can conclude that the commit in question has nothing to
> > > > > do with the issue. This is completely Thunderbolt related problem.
> > > > 
> > > > Considering the information above, does this appear to be a solely
> > > > dock-related issue (bugged firmware), or does it make sense to follow
> > > > up on this in some different kernel list? I have to say I'm completely
> > > > OK with running the laptop using the "user" TB security level, but if
> > > > you think I should follow up somewhere to get the "secure" level fixed
> > > > (or some workaround applied, etc), I can.
> > > 
> > > I'm confused about this issue.  Correct me if I go wrong:
> > > 
> > > The hierarchy is:
> > > 
> > >   00:1c.4 Root Port to [bus 04-3c]
> > >   04:00.0 Upstream Port (Thunderbolt) to [bus 05-3c]
> > >   05:01.0 Downstream Port (Thunderbolt) to [bus 07-3b]
> > >   07:00.0 Upstream Port (Thunderbolt) to [bus 08-3b]
> > > 
> > > With security level=secure, before e8b908146d44 ("PCI/PM: Increase
> > > wait time after resume"), resume takes ~5 seconds, but the hierarchy
> > > below 05:01.0 gets removed and re-enumerated (dmesg [1]).  After
> > > e8b908146d44, the same thing happens except the resume takes 60+
> > > seconds (dmesg [2]).  In both cases, the devices (USB mouse, LAN, etc)
> > > below 05:01.0 work after resume.
> > > 
> > > With security level=user, resume takes << 5 seconds regardless of
> > > e8b908146d44, and the hierarchy below 05:01.0 does not get removed and
> > > re-enumerated (dmesg [3]).
> > > 
> > > So if that's all accurate, it sounds like we've always had some
> > > problem with security level=secure that causes the hierarchy to get
> > > removed and re-enumerated, and e8b908146d44 just makes this problem
> > > much more visible?
> > 
> > Yes.
> > 
> > > I don't know anything at all about how Thunderbolt security levels
> > > work.  If "secure" means the hierarchy must be re-enumerated after
> > > resume, we can detect that case immediately and get on with it without
> > > having to wait for a timeout?
> > 
> > "secure" means that the Thunderbolt device that is connected can "prove"
> > it is the device we "authorized". It basically has a random number we
> > generated flashed on the NVM. This is the security "measure" used before
> > PC world aligned to use IOMMU instead.
> > 
> > (there is an explanation of all these here:
> > https://docs.kernel.org/admin-guide/thunderbolt.html#security-levels-and-how-to-use-them).
> 
> So is there some user-level software that runs between the removal and
> re-enumeration?  Something that authorizes the 07:00.0 Upstream Port?

No.

They get "authorized" upon plug by boltd based on user decision and
after that the firmware should keep them authorized as long as the
device is connected, including also resume.

> > Now, in case of resume the Thunderbolt firmware is expected to connect
> > the PCIe tunnel before the OS gets to resume its PCIe stack but this is
> > not happening in this particular system when the security level is set
> > to "secure". It could be firmware issue, and also if the BIOS settings
> > get changed from the defaults it is entirely possible that the system
> > enters paths that are not fully validated. Yes, changing security level
> > should definitely work and the PCIe tunnel should be properly
> > established but in any case this is Thunderbolt issue not PCIe issue.
> > 
> > I don't recall if I suggested this already but if not, try to see there
> > is a firmware update for your system. Lenovo supports LVFS so if there
> > is newer one fwupd should allow you to upgrade it.
> 
> I think you have suggested a firmware update, but I don't think that's
> a great solution for most users.  An ordinary user who has the
> security level set to "secure" and updates to a v6.4 kernel is just
> going to think resume is broken.  That user will not be willing or
> able to diagnose it as a security setting that could be changed or
> firmware that could be updated.

It does not affect every single system there with security level set to
"secure". It is just this one AFAICT. Like I said the firmware is
expected to connect the PCIe tunnel (and for some unknown reason in this
particular system it does not).

> It would be ideal if we could make "secure" resume as fast as "user"
> resume, but at the very least, I think we need to make it no worse
> than it was in v6.3.

Well what else can we do here? The link goes down regardless what we do
in the PCI stack. If you want to revert the patch that caused the delay,
fine but that does not cure the problem tha thet device stack get torn
down upon resume. For instance if there is USB stick connected to the
dock and the filesystem is mounted, all that is gone upon resume
regardless of the delay. If you want to detect the "secure" vs. "user"
fine feel free to do so but keep in mind that there are other systems
out there where this works just fine so avoid breaking them.
