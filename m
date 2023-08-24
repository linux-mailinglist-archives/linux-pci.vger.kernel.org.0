Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55A6786E31
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 13:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjHXLnd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 07:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241168AbjHXLnJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 07:43:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259221996
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692877384; x=1724413384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=62a01Rcd08HGwq/gnR3atk3pLVRr4J1sjtgZj4dbFFo=;
  b=EdUnlvY7Giek6BS+Jb4962OjrojX8y0OVkjWrSYU01rcZVwWkr2AgV3m
   jZewXZALva/xOaM0bju7JtkzsgGCNXWrWhz7wYLQGSLKTUdmOQ8Vlb53T
   vTYSOUO6sADqg+Syd1/pKolLzkXqU2Polsiz1YBqcS70RYJsY3el/c/x3
   xQQfxSVH9TVwkGeL0Q5I320rl+6d5zlzvd+zANfbZBmy5yCyxwj06/EkC
   4TRp0fcFlpenek+2LQ1ErfAZfHH6a1T8e5UvEe5D552LmPIWGx9dFCIB6
   CPlUxAAiKac1XYCEYbxxYiYXMcNYP4qkTPfKWNRdLkXr5Of2E/Fytp97A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373295989"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="373295989"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880771849"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 04:43:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CB50217F; Thu, 24 Aug 2023 14:43:00 +0300 (EEST)
Date:   Thu, 24 Aug 2023 14:43:00 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kamil Paral <kparal@redhat.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230824114300.GU3465@black.fi.intel.com>
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
 <20230821131223.GJ3465@black.fi.intel.com>
 <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
 <20230823050714.GP3465@black.fi.intel.com>
 <CA+cBOTdS5djXL=93VThP9K67pjYKHtjceqSczKf8NQonhpgo5Q@mail.gmail.com>
 <20230823074447.GR3465@black.fi.intel.com>
 <20230823075649.GS3465@black.fi.intel.com>
 <CA+cBOTco17b_8ZMhU8gXy8z2mtZXvVxrEUdKaAuZMhyFYC3yeQ@mail.gmail.com>
 <20230823090525.GT3465@black.fi.intel.com>
 <CA+cBOTeOSBkw_-AM6desmdVQjTXUZbKppK_PDiOM3sXQW5QKiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+cBOTeOSBkw_-AM6desmdVQjTXUZbKppK_PDiOM3sXQW5QKiA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 04:02:06PM +0200, Kamil Paral wrote:
> On Wed, Aug 23, 2023 at 11:05 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > OK. Did you change any BIOS settings from the defaults that might have
> > affect on this? Sometimes these are exposed to through the BIOS menu and
> > the user can change those (Lenovo typically does not, expose them
> > though).
> 
> These BIOS pages seem they could be relevant:
> https://imgur.com/a/vEltxpj
> 
> And heureka, "Thunderbolt BIOS Assist Mode" affects this! It was
> disabled (not sure if that's the default or I changed it before).
> After I enable it, the resume 60+ second delay is gone, it resumes in
> standard ~5 seconds. The dock devices (mouse, LAN) still take a few
> extra seconds to activate. The dmesg for a resume with TB assist mode
> is here:
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1984785

I think the correct setting for this is to have it disabled. This means
it is native PCIe with the runtime D3 support and looking at the ACPI
dump you shared this seems to be the case.

> Unfortunately, it seems to have its own quirks. There seems to be
> something like ~20% chance that the dock devices are no longer
> available after resume. I see the dock as connected in boltctl, but I
> no longer see the devices in lsusb. Reconnecting the dock doesn't
> help, more suspend&resume cycles don't help, only system reboot helps.
> I captured this situation in this dmesg (there are multiple resume
> events, the devices disappear after the last one):
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1984786
> 
> This might be the same problem that I described regarding
> pcie_aspm=off to Bjorn, but I'd need to check. Either way, this wasn't
> happening when the TB assist mode was disabled.
> 
> > Can you also attach output of acpidump to and dmesg with
> > "thunderbolt.dyndbg=+p" in the command line?
> 
> acpidump:
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1984802
> 
> dmesg with "thunderbolt.dyndbg=+p" and one suspend&resume cycle:
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1984803
> 
> I'm currently running kernel 6.4.8 packaged in Fedora 38 for these
> experiments, I hope that's OK. If needed, I can switch to the latest
> kernel.

I did not find anything "unusual" in the ACPI dump but I keep looking.

One thing I noticed, probably has nothing to do with this, but you have
the "security level" set to "secure". Now this is fine and actually
recommended but I wonder if anything changes if you switch that
temporarily to "user"? What is happening here is that once the system
enters S3 the Thunderbolt driver tells the firmware to save the
connected device list, and then once it exits S3 it is expected to
re-connect the PCIe tunnels of the devices on that list but this is not
happening and that's why the dock "dissappears" during resume.

In any case we can conclude that the commit in question has nothing to
do with the issue. This is completely Thunderbolt related problem.
