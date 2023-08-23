Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2378539F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 11:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjHWJPM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 05:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjHWJMU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 05:12:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AC1172A
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 02:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692781534; x=1724317534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NlDtiuNoTa06J6TdkXaQq1gMsjcxGXExnbW9+T10Bcs=;
  b=NML9tWJljRE5+SyqqxGk+/9aVYUYwKtpjn43mq38Twuu1NRsi5Yhpelu
   ICMk+rzWzqnyPNFvQwUYEckgFDcs0yg3J2QP4CAz7je/F0HJwUMLOr+iK
   Byuu6ymE1zb0O09CmjFvG9PfwPODUM9uGDhTDHkHncouSOh0riZBFZ9gq
   BALIwOho2akFOtIf/h+ogiWk7j0ilQUW3RBS2PUG1E8UntvjXAtcjK9HW
   T5aeBGUKnkkUif1DaycAMfV04kzG/WkanTCBLJJHT16vAqGUCu3WdLso+
   spzas9cjcXp8jjIUwSdabg90tSIW6pPg2809k/uLRFjyDEvpbJX2IJi6o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="364286849"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364286849"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 02:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="802022722"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="802022722"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 23 Aug 2023 02:05:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 405772FF; Wed, 23 Aug 2023 12:05:25 +0300 (EEST)
Date:   Wed, 23 Aug 2023 12:05:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kamil Paral <kparal@redhat.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230823090525.GT3465@black.fi.intel.com>
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
 <20230821131223.GJ3465@black.fi.intel.com>
 <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
 <20230823050714.GP3465@black.fi.intel.com>
 <CA+cBOTdS5djXL=93VThP9K67pjYKHtjceqSczKf8NQonhpgo5Q@mail.gmail.com>
 <20230823074447.GR3465@black.fi.intel.com>
 <20230823075649.GS3465@black.fi.intel.com>
 <CA+cBOTco17b_8ZMhU8gXy8z2mtZXvVxrEUdKaAuZMhyFYC3yeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+cBOTco17b_8ZMhU8gXy8z2mtZXvVxrEUdKaAuZMhyFYC3yeQ@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Aug 23, 2023 at 10:20:52AM +0200, Kamil Paral wrote:
> On Wed, Aug 23, 2023 at 9:56 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > So directly after resume the PCIe link (tunnel) from the Thunderbolt host router
> > PCIe downstream port does not get re-established and this brings down
> > the whole device hierarchy behind that port. The delay just made it take
> > longer but the actual problem is not the delay but why the tunnel is not
> > re-established properly.
> 
> If you want to compare it to a "fast" resume (~5 sec, before commit
> e8b908146d44), here's dmesg:
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1984726
> 
> Even when the resume is fast, it takes a few extra seconds before the
> devices on the dock are usable in the OS. For example, my USB mouse
> connected to the dock doesn't work immediately, I have to wait a few
> more seconds. The ethernet on the dock also reconnects only after a
> few extra seconds.

Yes, this is exactly the issue. The PCIe tunnel is not up and that makes
the OS to remove the devices during resume. The delay just makes it more
"visible".

> > Next question is that what's the Thunderbolt firmware version? You can
> > check it throughs sysfs: /sys/bus/thunderbolt/devices/0-0/nvm_version
> 
> $ sudo cat /sys/bus/thunderbolt/devices/0-0/nvm_version
> 20.0

OK, this is "Alpine Ridge Low Power" and for that the firmware seems to
be quite recent.

> Here's whole `fwupdmgr get-devices` output, if that helps:
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1984728
> 
> Before reporting this bug, I updated the firmware on the Dock itself
> to the latest version (had to use Windows for that). The dock should
> have now this firmware:
> https://pcsupport.lenovo.com/us/en/downloads/DS506176
> Which is:
>     Tool package V1.0.25
>     TBT FW: C44
>     PD FW: 1.38.07
>     DP hub: 3.13.005
>     Audio: 04-0E-87_Rev_0087
> according to the Readme file. That seems to match the "44" version in
> the fwupdmgr output.

[You could do that in Linux too but Lenovo does not seem to ship the
firmware through LVFS.]

> > I
> > see the BIOS you have seems to be quite recent (06/12/2023) so that
> > probably should be good enough.
> 
> Lenovo seems to support it through LVFS, so that's what I use for
> updating the BIOS. Version 0.1.54 was updated quite recently and it
> seems to be also the latest version they have on their website.

OK. Did you change any BIOS settings from the defaults that might have
affect on this? Sometimes these are exposed to through the BIOS menu and
the user can change those (Lenovo typically does not, expose them
though).

Can you also attach output of acpidump to and dmesg with
"thunderbolt.dyndbg=+p" in the command line?
