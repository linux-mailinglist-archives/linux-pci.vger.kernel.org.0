Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696783EDF8A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 23:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhHPV5F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 16 Aug 2021 17:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232067AbhHPV5F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 17:57:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 564BE60F39;
        Mon, 16 Aug 2021 21:56:33 +0000 (UTC)
Received: from 109-170-232-56.xdsl.murphx.net ([109.170.232.56] helo=wait-a-minute.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mFkas-005O0k-7z; Mon, 16 Aug 2021 22:56:30 +0100
Date:   Mon, 16 Aug 2021 22:56:29 +0100
Message-ID: <87tujpyrxu.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] PCI: apple: Add driver for the Apple M1
In-Reply-To: <YRm//JU0otojw+rV@sunset>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
        <20210815042525.36878-3-alyssa@rosenzweig.io>
        <87a6lj17d1.wl-maz@kernel.org>
        <YRm//JU0otojw+rV@sunset>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: 109.170.232.56
X-SA-Exim-Rcpt-To: alyssa@rosenzweig.io, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 16 Aug 2021 02:31:40 +0100,
Alyssa Rosenzweig <alyssa@rosenzweig.io> wrote:
> 
> Hi Marc,
> 
> Thank you for the review.

I wouldn't call that a review. Only a cursory look and a quick mention
of what I found really odd. Without specs, this thing is impossible to
properly review.

[...]

> > Please use relaxed accessors. If the barriers are actually needed,
> > please document what you are ordering against. This applies throughout
> > the patch.
> 
> Relaxed accessors are used throughout in v2... it Works For Me™ but no
> guarantees I didn't introduce a race...

That's not exactly what I wanted to read... You really need to make an
informed decision on the need of barriers. If the MMIO write needs to
be ordered after a main memory write (i.e. a memory write that is
consumed by the device you are subsequently writing to), you then need
a barrier. If, as I suspect, the device isn't DMA capable and doesn't
require ordering with the rest of the memory accesses, then no
barriers are required.

> 
> > This also begs the question: can this be called concurrently?
> 
> I'm not sure. Sven, any idea how Apple devices are usually
> structured here?

Nothing here is Apple specific. If you can get two CPUs to issue a RMW
on the same register, this piece of code is broken. This code has an
undocumented assumption of being single threaded, and it is pretty
unclear whether this assumption holds or not.

[...]

> > > +	writel(0xfb512fff, port + PORT_INTMSKSET);
> > 
> > Magic. What is this for?
> 
> Sven's explanation is the most likely. This magic value comes from
> Corellium via Mark; I assume it's written by macOS.

I really wish there was no magic values whatsoever, and I've resisted
posting the PCIe support patch myself for this very reason. Frankly,
this stuff doesn't give me the warm feeling that we know what we're
doing.

> 
> > > +	writel(PORT_INT_LINK_UP | PORT_INT_LINK_DOWN | PORT_INT_AF_TIMEOUT |
> > > +	       PORT_INT_REQADDR_GT32 | PORT_INT_MSI_ERR |
> > > +	       PORT_INT_MSI_BAD_DATA | PORT_INT_CPL_ABORT |
> > > +	       PORT_INT_CPL_TIMEOUT | (1 << 26), port + PORT_INTSTAT);
> > > +
> > > +	usleep_range(5000, 10000);
> > > +
> > > +	rmwl(0, PORT_LTSSMCTL_START, port + PORT_LTSSMCTL);
> > > +
> > > +	ret = readl_poll_timeout(port + PORT_LINKSTS, stat,
> > > +				 stat & PORT_LINKSTS_UP, 100, 500000);
> > > +	if (ret < 0) {
> > > +		dev_err(pcie->dev, "port %u link up wait timeout\n", i);
> > > +		return ret;
> > > +	}
> > 
> > I have the strong feeling that a lot of things in the above is to get
> > an interrupt when the port reports an event. Why the polling then?
> 
> I reordered the code to have the configuration after this happen
> before the START command as suggested (this works), and then removed
> the poll entirely (this also works?). It's possible the poll here
> was just a debug leftover in the original code.

What happens if the core PCI code probes the ports without the link
being up yet?

> It's possible it's needed in the original but not needed in the
> interrupt-driven common code (if the link doesn't come up yet,
> nothing happens, so we don't have to block on it ourselves..)
> 
> It's also possible I've introduced a race that we happen to win every time.
> 
> Without specs, it's exceedingly hard to know which it is...

Indeed, and I hate this "finger in the air" approach. Specially when
you need to trust your data to it.

> The poll isn't what we want at any rate, so I've removed the poll in
> v2. But we may want extra interrupt handling code for v3.

Indeed. I need to rework the MSI patch anyway after the discussion
with Rob, and I'll see what I can do for the rest of the event stuff.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
