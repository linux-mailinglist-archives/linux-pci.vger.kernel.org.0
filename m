Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0644B66844E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 21:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbjALUwC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 15:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjALUvX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 15:51:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF3069B29;
        Thu, 12 Jan 2023 12:23:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F3EFB81E5F;
        Thu, 12 Jan 2023 20:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F103AC433D2;
        Thu, 12 Jan 2023 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673554101;
        bh=eu6oC6p18svRffUOBN2Wg+o/+IqQkvr+YGuw0J4xmfM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sF5xQ/uzmcOJVRxhFlu/jydAsWM7BSEjNKSGB6h4HCE5xUN62UlOR7oB0AkuGpHr7
         x4YVqxzHVTySi+2OZaOZlBynG79mx5u3FIIEdLH4bWsbYNLgxJNbMyKd/34r7pKKkc
         o+8xt3x9y4o77EDaIlQbyhts7aoAOTX13Qf0fkwtubVbIhJHTA0Sgu/luw9QzrMpf+
         OIZ0spVXkhQQyOCgg/sdgd6aSRBVoGsmyTb3zeu5+hGr8TtjUg+RlzGtodQ5k/umV5
         HDugauVm4LTZszSICHvLcNShCeo9CoP9zUdSx/rAa8F4aMz+VkCICUCKPVWbFPPfR3
         sLZaG0TXA6/PA==
Date:   Thu, 12 Jan 2023 14:08:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Zeno R.R. Davatz" <zdavatz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org
Subject: Re: [Bug 216859] New: PCI bridge to bus boot hang at enumeration
Message-ID: <20230112200819.GA1785077@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228120248.GA508080@bhelgaas>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc sound folks]

On Wed, Dec 28, 2022 at 06:02:48AM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> 
> >            Summary: PCI bridge to bus boot hang at enumeration
> >     Kernel Version: 6.1-rc1
> > ...
> 
> > With Kernel 6.1-rc1 the enumeration process stopped working for me,
> > see attachments.
> > 
> > The enumeration works fine with Kernel 6.0 and below.
> > 
> > Same problem still exists with v6.1. and v6.2.-rc1
> 
> Thank you very much for your report, Zeno!
> 
> v6.0 works, v6.1-rc1 fails.  Would you mind booting v6.1-rc1 with the
> "ignore_loglevel initcall_debug" kernel parameters and taking a photo
> when it hangs?
> 
> How did you conclude that the hang is related to a PCI bridge?  I see
> recent PCI messages in the photo, but it looks like the last message
> is from NFS, so I'm wondering if I'm missing some context.  The v6.0
> dmesg shows several other ntfs, fuse, JFS, etc messages before more
> PCI-related things.  Anyway, the "initcall_debug" might help us narrow
> it down a bit.

Thanks very much for the bisection (complete log at [1])!

The bisection claims the first bad commit is:

  833477fce7a1 ("Merge tag 'sound-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound")

with parents:

  7e6739b9336e ("Merge tag 'drm-next-2022-10-05' of git://anongit.freedesktop.org/drm/drm")
  86a4d29e7554 ("Merge tag 'asoc-v6.1' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus")

Both 7e6739b9336e and 86a4d29e7554 tested "good" during the bisection.

There is a minor conflict when merging 86a4d29e7554 into the upstream,
but I can't imagine that being resolved incorrectly.

Would you mind turning off CONFIG_SOUND in your .config and testing
833477fce7a1 again?  I'm a little skeptical that the hang would be
sound-related, but I guess it's a place to start.

Bjorn

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216859#c35
