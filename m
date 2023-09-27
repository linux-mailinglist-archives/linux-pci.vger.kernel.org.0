Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399A47B05D2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjI0Nxz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 09:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjI0Nxy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 09:53:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D79711D
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695822831; x=1727358831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=haT1fSV6soV0FUnrzUGyc+avJhyyZ/F8BuUJ1FLT//I=;
  b=W5i5MUKVH5kNUNipNvpFyTWS6hUnERkv+AFKA721zXyYVSGsdn8XBeC9
   zyQ0zDYcnfbMMPQt6UmjmA79T/nud8Biwpxwv/kVahrr7hCu8zaBm+DIN
   lHkzwoZUGJ3wtugWW2cBMKU1S/3iB83gka5KPj+DLpGxZF0A+EPpCB8Fd
   j9BelE7NbfLpCXuBVLH8WXtCRNeQQ7BbWIlAYXX0QkZM+q+94J9UcDFC2
   GjDGXeceiXy0JqikWpyIoGrGS772Kog5GKq8osuN9+WIAzd9CoV/2NSJM
   6S02ekVkRSAVajjqY7yiRHxa041j43zRzM6hrcWarsRY4+V2fXPhmNUvd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="380709183"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="380709183"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="839450067"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="839450067"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2023 06:53:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 10D2B24C; Wed, 27 Sep 2023 16:53:46 +0300 (EEST)
Date:   Wed, 27 Sep 2023 16:53:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kamil Paral <kparal@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230927135346.GJ3208943@black.fi.intel.com>
References: <20230925141930.GA21033@wunner.de>
 <20230926175530.GA418550@bhelgaas>
 <20230927051602.GX3208943@black.fi.intel.com>
 <CA+cBOTds9k1Q2haC_gTpsUvjP02dHOv9vSconFEAu-Fsxwf36A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+cBOTds9k1Q2haC_gTpsUvjP02dHOv9vSconFEAu-Fsxwf36A@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Sep 27, 2023 at 03:43:29PM +0200, Kamil Paral wrote:
>    On Wed, Sep 27, 2023 at 7:16 AM Mika Westerberg
>    <[1]mika.westerberg@linux.intel.com> wrote:
> 
>    > I would also try to change all the BIOS settings back to defaults, see
>    > that it works (it is probably in "user" security level then), then
>    > switch back to "secure" (only change this one option) and try if it now
>    > works. It could be that some setting just did not get commited properly.
> 
>    Hello, I have some interesting findings.
>    I reset the BIOS ("load BIOS defaults"), however that doesn't reset the TB
>    security level option - whatever is set is kept. So I can't really find
>    out what the default value is and whether I changed it. However, to my
>    surprise, the resume was suddenly fast even with the Secure Connect
>    security level. So I went through options one by one and finally
>    discovered that the "Wake by Thunderbolt 3" option makes the difference.
>    It has the following description:
>    "Enable/Disable Wake Feature with Thunderbolt 3 ports. If Enabled, the
>    battery life during low power state may become shorter."
>    It is enabled by default, I had it disabled before. When I enable it, I
>    have a 5 sec resume even with Secure Connect TB security level. The dmesg
>    for such a resume is here:
>    [2]https://bugzilla-attachments.redhat.com/attachment.cgi?id=1990815

Okay that now looks like what is expected. The firmware re-connects the
tunnels and the resume can continue.

I actually don't know what that option does either but I would expect
that it leaves the PME and small power enabled for the port so that
probably allows the firmware to do this even in "secure" mode or so.

>    I'm sorry I haven't spotted and tested such an obviously named option
>    earlier. My understanding was that this option either wakes up my laptop
>    when I connect the cable (tested now, it doesn't appear to do so), or that
>    it wakes it up when I move/click my dock-connected mouse (tested, doesn't
>    appear to do so). So originally I wanted this disabled (and I had no
>    kernel issues with it disabled, prior to e8b908146d44), but it seems I
>    misunderstood what it does. And I'm still unsure what exactly it's
>    supposed to do and why it should kill my battery life in the process,
>    according to its description.
>    Hopefully this helps to bring more light into this?
>    However, I also discovered that even though Wake by TB3 + Secure Connect
>    gives me a fast resume in a normal case, I still see a 60+ sec resume
>    delay when I disconnect and then reconnect the TB cable while the laptop
>    is suspended (which is a frequent use case for me). That doesn't happen
>    with the User Authorization level (regardless of Wake by TB value). So I'm
>    staying with User Authorization for the moment.

If you apply the patch from here:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=pm&id=6786c2941fe1788035f99c98c932672138b3fbc5

Does the problem go away with the disconnect case too (and so that you
have "secure" enabled)?
