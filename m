Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB59278840C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjHYJrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 05:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbjHYJqv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 05:46:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8054B1BDA
        for <linux-pci@vger.kernel.org>; Fri, 25 Aug 2023 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692956809; x=1724492809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2kzpeTULOBgdjKH8IcKe5A4pH9I2HrNIDiNBAP1Ww1A=;
  b=mUfgbgV9QiE2lJAPsnhOtLd0vMyiiaTA0w4yKDH/uIecPz1tXAe1/vcS
   GxAqfLASIDj3orPW2dWeFmYrfPmgMjD2e0TnPrz9M7T0JVAbLY6z/Dum/
   SAOXAHxfESc6CiElRc2k1EAnG/sp9+CwbcKHa7gt+jIm+9qw1iLxkGIrm
   u3uv5psrJ3172Uud3A/bKXHOdVCESSye8P1/ta9orcURO+8QbM6KjiJcH
   0enWxqtP57e3j6oKAE93/lNlJxf1cNZjZXTJlK+b2UPkDEA/IHlsTScQU
   BNbef5K0TATucVh3THg1pzC3XOXSDOsTjhn0P8CN71weBjudINXwnEvu8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="355005925"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="355005925"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="851902078"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="851902078"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Aug 2023 02:46:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3635623A; Fri, 25 Aug 2023 12:46:46 +0300 (EEST)
Date:   Fri, 25 Aug 2023 12:46:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kamil Paral <kparal@redhat.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230825094646.GC3465@black.fi.intel.com>
References: <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
 <20230823050714.GP3465@black.fi.intel.com>
 <CA+cBOTdS5djXL=93VThP9K67pjYKHtjceqSczKf8NQonhpgo5Q@mail.gmail.com>
 <20230823074447.GR3465@black.fi.intel.com>
 <20230823075649.GS3465@black.fi.intel.com>
 <CA+cBOTco17b_8ZMhU8gXy8z2mtZXvVxrEUdKaAuZMhyFYC3yeQ@mail.gmail.com>
 <20230823090525.GT3465@black.fi.intel.com>
 <CA+cBOTeOSBkw_-AM6desmdVQjTXUZbKppK_PDiOM3sXQW5QKiA@mail.gmail.com>
 <20230824114300.GU3465@black.fi.intel.com>
 <CA+cBOTej22hWEFvMOnFfKy16tuzS_+S7kccPPYXNoGVbYMoEdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+cBOTej22hWEFvMOnFfKy16tuzS_+S7kccPPYXNoGVbYMoEdA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

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

Yeah looks good now.

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

I would start by contacting Lenovo because I suspect this is Thunderbolt
firmware (host side not dock) issue so they may pull a newer one for
this one from Intel.
