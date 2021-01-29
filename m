Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F60C308FAF
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 22:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhA2V5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 16:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232535AbhA2V5B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 16:57:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91D9D64DDB;
        Fri, 29 Jan 2021 21:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611957381;
        bh=dypjTuYXyR6gLCOHJWW9+7erzHAmZ8hQ6zLYMGrE3JY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rfopaU5h9kVf6LpwGaTOUSFzN0A/NXs6NggJJlw5LLwCpNvUnRYmOXzs+c+Lnff5P
         8Abhs6OXcoVzwgyGJ8fT/NeOY+cQ87N5YxRaJXNq5TzMWpF7cRfSupzNu0rtsojC6K
         ltxLOYpbnX47Id3Y0WDSCGUuomxMC/DnZiklPK1NiuKQrYEG14q7mIiduPKdc/oTOA
         uN8bbPJej7z6xXOSzrZ66mk+PQ0wOmSA/H9AzfVK2CQEGvfoHLea8CCn8fQcksgrvg
         tNASIw9VfHfz1eE+hgnH3B3pCRdF6RmaipbsHEfNhWfZlGB78soAj3sC0HtFJxTBA1
         bYN9LksU53+7w==
Date:   Fri, 29 Jan 2021 15:56:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Alex G." <mr.nuke.me@gmail.com>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Jan Vesely <jano.vesely@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dave Airlie <airlied@gmail.com>,
        Ben Skeggs <skeggsb@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "A. Vladimirov" <vladimirov.atanas@gmail.com>
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
Message-ID: <20210129215619.GA114790@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6106d30-cbdb-6ba5-8910-086cee92875e@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28, 2021 at 06:07:36PM -0600, Alex G. wrote:
> On 1/28/21 5:51 PM, Sinan Kaya wrote:
> > On 1/28/2021 6:39 PM, Bjorn Helgaas wrote:
> > > AFAICT, this thread petered out with no resolution.
> > > 
> > > If the bandwidth change notifications are important to somebody,
> > > please speak up, preferably with a patch that makes the notifications
> > > disabled by default and adds a parameter to enable them (or some other
> > > strategy that makes sense).
> > > 
> > > I think these are potentially useful, so I don't really want to just
> > > revert them, but if nobody thinks these are important enough to fix,
> > > that's a possibility.
> > 
> > Hide behind debug or expert option by default? or even mark it as BROKEN
> > until someone fixes it?
> > 
> Instead of making it a config option, wouldn't it be better as a kernel
> parameter? People encountering this seem quite competent in passing kernel
> arguments, so having a "pcie_bw_notification=off" would solve their
> problems.

I don't want people to have to discover a parameter to solve issues.
If there's a parameter, notification should default to off, and people
who want notification should supply a parameter to enable it.  Same
thing for the sysfs idea.

I think we really just need to figure out what's going on.  Then it
should be clearer how to handle it.  I'm not really in a position to
debug the root cause since I don't have the hardware or the time.  If
nobody can figure out what's going on, I think we'll have to make it
disabled by default.

> As far as marking this as broken, I've seen no conclusive evidence of to
> tell if its a sw bug or actual hardware problem. Could we have a sysfs to
> disable this on a per-downstream-port basis?
> 
> e.g.
>     echo 0 > /sys/bus/pci/devices/0000:00:04.0/bw_notification_enabled
> 
> This probably won't be ideal if there are many devices downtraining their
> links ad-hoc. At worst we'd have a way to silence those messages if we do
> encounter such devices.
> 
> Alex
