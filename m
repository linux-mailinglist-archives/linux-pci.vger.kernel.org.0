Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA71C374D92
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 04:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhEFCfD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 22:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231370AbhEFCfD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 22:35:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB232613B5;
        Thu,  6 May 2021 02:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620268446;
        bh=6euE7plfLogA6Ce8dtdEE2r1lNhAqCx4K/hLCH1gwlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o50JsoOhxl62kGhcrKIH3+Zb5IRf3f/vrNPOstLYAVlXr62PiRlxfGn9VBrPJ9y1t
         5RQD+WC61RaR8cgqSoF+pyAAU75zqivONa0nqYEsFbYaIVvxZnDeCWw7vMKxfgl1fk
         rm+OzjbSAz3Zk+8GKtR8+1kcurOWlGP7b2rNDOSq/4g1gZLD6ilyetp50c6m5ZBHkn
         cJ1s+PqbyvjFF0BLhSNnaP4hVxpglE9sumu3zo8OX2QF8LWL1OlXWSs82eRZPqQ7dm
         8j9pA71V1oyvhv9rrsZfglfVI99IbNMCVklZC+bUFW/aS2DaTYHct1lVu7mnc/zXvn
         flWOiXSK0GUBQ==
Date:   Wed, 5 May 2021 19:34:03 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Add support for PCIe SSD status LED management
Message-ID: <20210506023403.GB1187168@dhcp-10-100-145-180.wdc.com>
References: <20210416192010.3197-1-stuart.w.hayes@gmail.com>
 <20210506014827.GA175453@rocinante.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506014827.GA175453@rocinante.localdomain>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 06, 2021 at 03:48:27AM +0200, Krzysztof Wilczyński wrote:
> > >cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/supported_states
> > ok                              0x0004 [ ]
> > locate                          0x0008 [*]
> > fail                            0x0010 [ ]
> > rebuild                         0x0020 [ ]
> > pfa                             0x0040 [ ]
> > hotspare                        0x0080 [ ]
> > criticalarray                   0x0100 [ ]
> > failedarray                     0x0200 [ ]
> > invaliddevice                   0x0400 [ ]
> > disabled                        0x0800 [ ]
> > --
> > supported_states = 0x0008
> > 
> > >cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/current_states
> > locate                          0x0008 [ ]
> 
> As per what Keith already noted, this is a very elaborate output as far
> as sysfs goes - very human-readable, but it would be complex to parse
> should some software would be interested in showing this values in a way
> or another.
> 
> I would propose output similar to this one:
> 
>   $ cat /sys/block/sda/queue/scheduler
>   mq-deadline-nodefault [bfq] none
> 
> If you prefer to show the end-user a string, rather than a numeric
> value.  This approach could support both the supported and current
> states (similarly to how it works for the I/O scheduler), thus there
> would be no need to duplicate the code between the two attributes.
> 
> What do you think?

Some enclosures may support just one blinky state at a time. Other
implementations might have multiple LEDs and colors, so you could, for
example, "locate" something that is also "failed", with both states
visible simultaneously. You could capture the current states with the
"scheduler" type display, but setting new states may be more
complicated.
