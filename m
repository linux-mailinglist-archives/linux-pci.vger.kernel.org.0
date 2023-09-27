Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4A7AF9FC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 07:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjI0FVJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 01:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjI0FU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 01:20:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D9E270C
        for <linux-pci@vger.kernel.org>; Tue, 26 Sep 2023 22:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695791766; x=1727327766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ETJatUXksZxv7GcmiGmwoAcRbp77sOm1M4V6YfLhYAE=;
  b=lYrmUpgnMF0x5GXUdPXImih1r8eUs8S4ZfgvsIMozrRc+mpH+4EpGWcE
   g+k7uqinyzL4fDjv/KjUIUrpbOt5W2T3F0PtdwbIc+co54eXQu91L6WUi
   E19mlXV1uwRTv0PGClQwiW+lzmjgv/2v09S2SWR+iZfCxWvcfGQu/feyI
   HpAqsW0ViX1ObJqV3xRxxrAqwflJhbqjQTV/L1C02OoyrIzNRdAqq4QJz
   o9tCEoCj/EPXyk9QUbPpUo/k8g29NaWyEzz7ASfrvylXRYRg8KbmB1aa3
   ljndOof+A5n1BQMTho1fN082xbd9rIuF6wV6aSWiO0bSmP5tQ1OrL8YWF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="379014371"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="379014371"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 22:16:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819285800"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="819285800"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2023 22:16:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B2D6B177; Wed, 27 Sep 2023 08:16:02 +0300 (EEST)
Date:   Wed, 27 Sep 2023 08:16:02 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Kamil Paral <kparal@redhat.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230927051602.GX3208943@black.fi.intel.com>
References: <20230925141930.GA21033@wunner.de>
 <20230926175530.GA418550@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926175530.GA418550@bhelgaas>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 26, 2023 at 12:55:30PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 25, 2023 at 04:19:30PM +0200, Lukas Wunner wrote:
> > On Mon, Sep 25, 2023 at 08:48:41AM -0500, Bjorn Helgaas wrote:
> > > Now pciehp thinks the slot is occupied and the link is up, so we
> > > re-enumerate the hierarchy.  Is this because thunderbolt did something
> > > to 06:00.0 that made the link from 05:01.0 come up?
> > 
> > PCIe TLPs are encapsulated into Thunderbolt packets and transmitted
> > alongside DisplayPort and other data over the same physical link.
> > 
> > For this to work, PCIe tunnels need to be set up between the Thunderbolt
> > host controller and attached devices.  Once a tunnel is established,
> > the PCIe link magically goes up and TLPs can be transmitted.
> > 
> > There are two ways to establish those tunnels:
> > 
> > 1/ By a firmware in the Thunderbolt host controller.
> >    (firmware or "internal" connection manager, drivers/thunderbolt/icm.c)
> > 
> > 2/ Natively by the kernel.
> >    (software connection manager)
> > 
> > I'm assuming that the laptop in question exclusively uses the firmware
> > connection manager, hence the kernel is reliant on that firmware to
> > establish tunnels and can't really do anything if it fails to do so.
> 
> Thanks for the background; that improves my meager understanding a
> lot.
> 
> Since this seems to be a firmware issue, it does sound like this
> laptop uses a firmware connection manager.  But there still seems to
> be some kernel connection because pre-e8b908146d44, the link came up
> in <5 seconds, and after the minor e8b908146d44 change, it takes >60
> seconds.

In both cases (with or without) the commit what happens is that after
resume is finished the firmware connection manager notices the
connection, announces it to the Thunderbolt driver that exposes it to
the userspace where boltd re-authorizes the device. This brings up the
PCIe tunnel again and things get working.

(What is expected to happen is that during the resume the firmware
 connection manager re-connects the PCIe tunnel.)

This took previously the ~5s before resume is complete so that the above
steps can happen where as after the commit it got delayed more up to the
arbitrary ~60s because we started to use that with the commit
e8b908146d44 (PCIE_RESET_READY_POLL_MS).

> I'm kind of at a loss here because I don't have a clear path forward.
> What I'm hearing is that the real fix is a firmware update or a BIOS
> setting change (Thunderbolt "user" instead of "secure" mode).

There are lots of firmares involved so, say if any of them are turned
from the default value the system may enter code paths that are not
fully validated unfortunately.

I would also try to change all the BIOS settings back to defaults, see
that it works (it is probably in "user" security level then), then
switch back to "secure" (only change this one option) and try if it now
works. It could be that some setting just did not get commited properly.

> That is problematic for users, who will think resume got broken and
> they don't know how to fix it.  It's problematic for me, because it
> *looks* like a PCI issue and a PCI change exposed it, so I'll have to
> deal with the reports.

I'm sorry about that. Trying best I can to remedy this.
