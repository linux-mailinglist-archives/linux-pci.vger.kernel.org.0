Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81967AC9D2
	for <lists+linux-pci@lfdr.de>; Sun, 24 Sep 2023 15:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjIXNoW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Sep 2023 09:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIXNoW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Sep 2023 09:44:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762983
        for <linux-pci@vger.kernel.org>; Sun, 24 Sep 2023 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695563055; x=1727099055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yXFHrMifaWDbHekYfC2ckQalu8l/ZL7juCFJEozuv2o=;
  b=hETkas+QNnLhSQBQo07FOLqUnxBHaSob/z4/vazja4AZy2lfvFxlcsJI
   y961YsD9cvTuG0mGZnW0Qwmw9uFlVF9bxpC7Ts3fUBzHuQJNak5yXuopS
   YZBnD3ArfI1w8Igfs+aJcbqRf62+oMdTNkjZy5XS69Zkoo/mfjnuGCXBt
   0ZdzNQG9hQFotW/Iqgv0gZauHosWLupdgNlbt6IPxSmi95Yz6w/FdxG/s
   qhEy8zkN1lZiAxdDqqea14sKjB3MENYYcJ23PqVCz2CuJ5c1IYoUQfHe4
   Ngr129KJ2cBEVLGKpTY5GSqzgIulN9JNvbBHpjKR5YgU7R9Q92dnV33qa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360485374"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="360485374"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 06:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818329698"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="818329698"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 06:44:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B39B51C7; Sun, 24 Sep 2023 16:44:11 +0300 (EEST)
Date:   Sun, 24 Sep 2023 16:44:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Kamil Paral <kparal@redhat.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] PCI/PM: Mark devices disconnected if their upstream PCIe
 link is down on resume
Message-ID: <20230924134411.GF3208943@black.fi.intel.com>
References: <20230922044237.GC3208943@black.fi.intel.com>
 <20230922125926.GA367919@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230922125926.GA367919@bhelgaas>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 22, 2023 at 07:59:26AM -0500, Bjorn Helgaas wrote:
> [+cc Thorsten]
> 
> On Fri, Sep 22, 2023 at 07:42:37AM +0300, Mika Westerberg wrote:
> > On Thu, Sep 21, 2023 at 03:19:45PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Sep 18, 2023 at 08:30:41AM +0300, Mika Westerberg wrote:
> > ...
> 
> > > Kamil also bisected a 60+ second resume delay to e8b908146d44
> > > (https://lore.kernel.org/r/CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com),
> > > but IIUC at
> > > https://lore.kernel.org/linux-pci/20230824114300.GU3465@black.fi.intel.com/T/#u
> > > you concluded that Kamil's issue was related to firmware and actually
> > > had nothing to do with e8b908146d44.
> > > 
> > > Do you still think Kamil's issue is unrelated to e8b908146d44 and this
> > > patch?  If so, how do we handle Kamil's issue?  An answer like "users
> > > of v6.4+ must upgrade their Thunderbolt firmware" seems like it would
> > > be kind of a nightmare for users.
> > 
> > It's a different issue. What happens in his system is that the link went
> > down even though the dock was still connected and this should not happen
> > (the firmware should bring the link up during resume). The delay was
> > just a "symptom".
> 
> Do you have any leads for Kamil's issue?  If we had known that
> e8b908146d44 would cause that problem, we never would have applied it
> in the first place.

I explained it in the other email I just sent. I should mention here
that the two issues are different.

> No OS would accept that resume delay, so there must be some way to fix
> that in the OS without requiring a firmware update.

It is not "resume" delay. It is the delay what we wait for the device to
become ready until we decide it is not functional/disconnect. That delay
is completely arbitrary.

> If Kamil's issue is that firmware doesn't bring up the link during
> resume, how *does* the link get brought up, and what does the delay
> have to do with it?

The PCIe tunnel (the "link" above) gets established after D3cold by the
Thunderbolt firmware running inside the host controller. The trigger is
typically when _PR0 ACPI method is called, this sends special command
through the mailbox that makes the firmware re-connect all the tunnels
that were previously connected.

The delay we are talking about here is the PCIe spec required delay
after the device went through a reset that the OS must observe before it
can send configuration requests to that device. Now, the PCIe spec does
not specify how long the OS should wait for device on a link that does
not come up. We increased that delay to the ~60s to fix another issue on
a xHCI controller but forgot the fact that when the device is
deliberately unplugged we still wait for the ~60s which is wasted effort
and just ends up annoying users.
