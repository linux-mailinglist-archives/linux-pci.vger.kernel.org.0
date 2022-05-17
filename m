Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2C8529F28
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 12:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbiEQKRX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 06:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344382AbiEQKQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 06:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6554E1D335;
        Tue, 17 May 2022 03:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01F49615A2;
        Tue, 17 May 2022 10:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C545C385B8;
        Tue, 17 May 2022 10:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652782428;
        bh=pwPflkY6883sgamo1V6UO6qAd1DW0795Cg7hqZS4LZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ykhO7ngSFIqUuUkptf+X/kohsqKTZ54ModnsOpD4KyVBRPnV3KZ5tnhFcybG2L3DY
         cYhO76EsdNFgojIIAqxdBJAMBXqfDMj53iZCT19Xv4sz0xbDgT9X3XwUzjtGW+QAvg
         lUn62ixjbTT4bKKKNvRnrEYbH5eETCMFNs3l07U0=
Date:   Tue, 17 May 2022 12:13:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tanjore Suresh <tansuresh@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <YoN1VC0v4RNFC+0s@kroah.com>
References: <20220412224348.1038613-1-tansuresh@google.com>
 <20220412224348.1038613-2-tansuresh@google.com>
 <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
 <CALVARr6v5hcY0Vcf1izPUX-tXNJyyNXBMANbKX4CW9wfRf-pYQ@mail.gmail.com>
 <YmzqrqfVLQ9/4KXp@kroah.com>
 <CALVARr50MWexNpCf_PoZ4-pdnexiZiibz7Nd0PH+b-EVnBUN6w@mail.gmail.com>
 <CALVARr71u8VD0+zaWbm=6A-1_6gO=bYUm7OM4K5b6kOVz09XOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALVARr71u8VD0+zaWbm=6A-1_6gO=bYUm7OM4K5b6kOVz09XOA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 02:02:08PM -0700, Tanjore Suresh wrote:
> Greg
> 
> On Mon, May 2, 2022 at 12:13 PM Tanjore Suresh <tansuresh@google.com> wrote:
> >
> > On Sat, Apr 30, 2022 at 12:52 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > A: http://en.wikipedia.org/wiki/Top_post
> > > Q: Were do I find info about this thing called top-posting?
> > > A: Because it messes up the order in which people normally read text.
> > > Q: Why is top-posting such a bad thing?
> > > A: Top-posting.
> > > Q: What is the most annoying thing in e-mail?
> > >
> > > A: No.
> > > Q: Should I include quotations after my reply?
> > >
> > > http://daringfireball.net/2007/07/on_top
> > >
> > > On Fri, Apr 29, 2022 at 11:03:07AM -0700, Tanjore Suresh wrote:
> > > > Rafael,
> > > >
> > > > That is a good observation, however, many of the use cases in data
> > > > centers (deployment of devices in data centers) do not exploit device
> > > > power management. Therefore, I'm not sure that is the right way to
> > > > design this.
> > >
> > > Yes it is, enable device power management and use that interface please.
> > > Devices in data centers should of course be doing the same thing as
> > > everyone else, as it actually saves real money in power costs.  To not
> > > do so is very odd.
> > >
> >
> > I guess we are intermixing the  terminology of device power management
> > with shutdown.
> > My second, third reasoning in my previous e-mail, thought it brings
> > out that difference. Maybe not.
> > I will try one more time, my thought process on this one.
> >
> > This patch is only for shutdown. The shutdown can be done in a system
> > in various flavors,
> > (this may include a power being pulled from the system components when
> > all the devices
> > are quiescent and it can also be soft shutdown, where power is not
> > removed from the system, but system
> > could be attempting a reboot)
> >
> > The device power management allows the device to bring down any
> > devices that may be idle to various power states that
> > device may support in a selective manner & based on the transition
> > allowed by the device. Such a transition initiated by
> > the system can be achieved using the 'dpm' interface for runtime power
> > management (more for extending laptop battery life).
> > It can also be exploited for system sleep models (suspend and resume -
> > where state is preserved and restarted from where it left off
> > --> More applicable for laptops/desktops). That does not mean data
> > center devices cannot exploit, but they worry about slight latency
> > variation in any
> > I/O initiated to any device. Such power management could introduce
> > more latency when it transitions from one state to another.
> > Therefore, the use case is more apt for Laptops, in certain cases
> > desktops in my opinion or understanding.
> >
> > The shutdown entry point has been traditionally different and the
> > semantics is that the whole system is going down to a
> > quiescent state and power may be pulled or may not be, IMO, i am
> > seeing both are independent requirements, in my view.
> > Let me know if I am mistaken. I am not sure why we should break the
> > shutdown semantics as understood by driver developers and
> > overload it with dpm requirements?
> >
> 
> I have not seen additional comments, I request your help
> in moving this further, please. If i have missed something,
> Please let me know.

Please rebase and resubmit your series with the extra information you
have provided here in the changelog text so we can review it again.  The
patch series is long gone from my queue, sorry.

thanks,

greg k-h
