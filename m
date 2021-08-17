Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31023EE750
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 09:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhHQHhI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 03:37:08 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:44741 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234402AbhHQHhH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 03:37:07 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9211B580AD0;
        Tue, 17 Aug 2021 03:36:34 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Tue, 17 Aug 2021 03:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=USSYTk178qdEPxhBDsDqKAfTFU3S
        xrBw7cGjlel5MyQ=; b=TMnZ4IpGw+/Q5qxqjCV5K0lzJ5lO0ZXDjhdOX9rKUPlY
        EUHAzZLpM+0ar9C0ryxYwc7Knb4CrbTYkBo3FZvFd9D0Q/SGLtoGEaFXLLhRMsII
        q0u7kJNWVHOKX84EkhvsddyN1gw9yrsBfiIDpzJ7p1h3zHKbSrvclZ+WsH2IB74O
        gGB7EuTJNrP/2IXbfu69aAS5hWwVCm7NAOqxYlfpvrac9D1zUIs3FzHLX8wQkroh
        5v+FHg6krl1F2H6Hrf855ecfkgdXzLg7hxbhi4Xyp7jd/3MaHObKcCJkL71ZNcGA
        LxNbyTQO3SJoc/TK/dKfZbSYAzQs/5tHtX/p0Q0utw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=USSYTk
        178qdEPxhBDsDqKAfTFU3SxrBw7cGjlel5MyQ=; b=EN4e09ZZMfaSk+IJKlBpC3
        iptwH02WIij0kAlOhUsuASZY02A8KMIwQ/ENcZ+jTRqbz/oawGsc1zjHEHTGOiUi
        0GWEVrFF2TAvQZmqXnY7DG8izUyp2VoIUGeEhnfWequRutB2lO3mGf17BcyED+4X
        iT1K+NWBOhW0mm+azmk4ni0EqtDnjc09MKYzQbJjQEpDdbg2ssDShCSkf0RYBHXf
        h2v2Vl2H1sfKJGxy7Fae0HCOuOQf/O0BJqnxMZQp2190cYV2+BZLdd0/gSrPAyh1
        /h1iaQJB8E8gBixPBweBfl5t1Q3FMEDbIo0GV1BWlnQYWhKEE+fYyJ2/p418SK6w
        ==
X-ME-Sender: <xms:AGcbYcAPN4qAdBEyOkqt1h6eYQEIPWO49FYi0HYLzGZGvipiikCQWg>
    <xme:AGcbYehQjp51p2Akm5_LH4N49d7bwlVuK5LJl6Urv17BPXBvlYIUwysvF_PEvlf-Y
    UOq7IVq0uQg2epHy-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrledvgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:AGcbYfk6iRxUDHHKgBntN54QylHR5NiyV7CwIaklcLTIndHrbryHfA>
    <xmx:AGcbYSw-2QHqW__1ockfgnaHUw1QKaaAbxaJ-bfmaijHYO3H-UhQIg>
    <xmx:AGcbYRTFLqzzzhXS5wCWaQYfYGJfqwrimMAFZxfhyjW1JxqlJd_q1Q>
    <xmx:AmcbYe9BqvMDzIlBZxIPnmTlfi3o-V3O3sSVxXUcb0bncQS_TbXewQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5FF5551C0060; Tue, 17 Aug 2021 03:36:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1118-g75eff666e5-fm-20210816.002-g75eff666
Mime-Version: 1.0
Message-Id: <836a1a93-5031-4218-bc0b-17fc38f93931@www.fastmail.com>
In-Reply-To: <87tujpyrxu.wl-maz@kernel.org>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-3-alyssa@rosenzweig.io> <87a6lj17d1.wl-maz@kernel.org>
 <YRm//JU0otojw+rV@sunset> <87tujpyrxu.wl-maz@kernel.org>
Date:   Tue, 17 Aug 2021 09:35:43 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Marc Zyngier" <maz@kernel.org>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc:     linux-pci@vger.kernel.org, "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Stan Skowronek" <stan@corellium.com>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        "Hector Martin" <marcan@marcan.st>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] PCI: apple: Add driver for the Apple M1
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Mon, Aug 16, 2021, at 23:56, Marc Zyngier wrote:
> [...]
> 
> > > > +	writel(0xfb512fff, port + PORT_INTMSKSET);
> > > 
> > > Magic. What is this for?
> > 
> > Sven's explanation is the most likely. This magic value comes from
> > Corellium via Mark; I assume it's written by macOS.
> 
> I really wish there was no magic values whatsoever, and I've resisted
> posting the PCIe support patch myself for this very reason. Frankly,
> this stuff doesn't give me the warm feeling that we know what we're
> doing.

I'm pretty sure we can get rid of most magic since we have register names for
almost everything we need and since m1n1 does the really obscure black magic
involving the PHY layer and those tunables thanks to Mark.

As I mentioned earlier, all bits missing in 0xfb512fff are those used in
the writel one line below. This line only keeps a set of interrupts unmasked
and the next one acks exactly this set (which isn't correct, but that's what
this code does).
There only unknown interrupt here is BIT(26) but this whole sequence is like a
cargo cult anyway right now since nothing checks for these interrupts.

> 
> > 
> > > > +	writel(PORT_INT_LINK_UP | PORT_INT_LINK_DOWN | PORT_INT_AF_TIMEOUT |
> > > > +	       PORT_INT_REQADDR_GT32 | PORT_INT_MSI_ERR |
> > > > +	       PORT_INT_MSI_BAD_DATA | PORT_INT_CPL_ABORT |
> > > > +	       PORT_INT_CPL_TIMEOUT | (1 << 26), port + PORT_INTSTAT);
> > > > +
> > > > +	usleep_range(5000, 10000);
> > > > +
> > > > +	rmwl(0, PORT_LTSSMCTL_START, port + PORT_LTSSMCTL);
> > > > +
> > > > +	ret = readl_poll_timeout(port + PORT_LINKSTS, stat,
> > > > +				 stat & PORT_LINKSTS_UP, 100, 500000);
> > > > +	if (ret < 0) {
> > > > +		dev_err(pcie->dev, "port %u link up wait timeout\n", i);
> > > > +		return ret;
> > > > +	}
> > > 
> > > I have the strong feeling that a lot of things in the above is to get
> > > an interrupt when the port reports an event. Why the polling then?
> > 
> > I reordered the code to have the configuration after this happen
> > before the START command as suggested (this works), and then removed
> > the poll entirely (this also works?). It's possible the poll here
> > was just a debug leftover in the original code.
> 
> What happens if the core PCI code probes the ports without the link
> being up yet?

We pretty much rely on everything being slow enough that the ports aren't probed
if there's no readl_poll_timeout and no waiting for the link up interrupt.
Now it doesn't take long for the link to be up after the LTSSM has been
started, but it's still a few cycles and this is not a good idea.
This needs to wait for the interrupt.

I don't know yet what the first usleep_range is used for, but I'm willing to
bet it's either waiting for another interrupt to fire or sometimes the link doesn't
come up the first time and you just have to try again and the usleep prevents that.
(I'm less inclined to bet on this one, but: this might be required for the first
port with the WiFi/bluetooth radios which will never come up unless power has been
enabled by talking to another co-processor first. That usleep_range might be a hack
so that this code always runs after power has been enabled.)

That same LTSSM retry flow is used for Thunderbolt hotplugging fwiw:
Wait for the NHI layer to notify you, start the link training, wait for the
link up interrupt (or the link down or error interrupt and just try link training
again a few times), rescan the port.

> 
> > It's possible it's needed in the original but not needed in the
> > interrupt-driven common code (if the link doesn't come up yet,
> > nothing happens, so we don't have to block on it ourselves..)
> > 
> > It's also possible I've introduced a race that we happen to win every time.
> > 
> > Without specs, it's exceedingly hard to know which it is...
> 
> Indeed, and I hate this "finger in the air" approach. Specially when
> you need to trust your data to it.
> 
> > The poll isn't what we want at any rate, so I've removed the poll in
> > v2. But we may want extra interrupt handling code for v3.
> 
> Indeed. I need to rework the MSI patch anyway after the discussion
> with Rob, and I'll see what I can do for the rest of the event stuff.

Again, thanks a lot for this! As I said in the other mail, if you need
any specific information about this hardware just let me know.
I won't be able to give you an accurate spec but I can try to figure out
most details you need.

Thanks,


Sven
