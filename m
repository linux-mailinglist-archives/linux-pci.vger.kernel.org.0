Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756093ECEAA
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 08:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhHPGiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 02:38:12 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59429 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230442AbhHPGiM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Aug 2021 02:38:12 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id B0A415803F4;
        Mon, 16 Aug 2021 02:37:40 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Mon, 16 Aug 2021 02:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=Y+Y8bItjRSuIneNwxBw1hKFEPXmc
        Y/iN7ZOtGJL3Lbo=; b=SOZkP1zZ4kebx+16BqgC2h35QLRiEtZqUKLdnyVBAL2q
        pQbit3dsS61mSZekzCyN0BC0QXaYvUw1Hve6wvtzyKKpLTSc3o6+ZbdEtoCkVljm
        YwNpOaivlHIBya2RqdCPc4fWjK+xJfyvu8bKzZh88eNE/6bijFlkLX1C2ESOD37H
        iP67dAgChuRx+19mK3sx23lk7iEhO5XxLDn9O7KQtUtJrI0qqZqJk+atjDLvYMOh
        V2fQ9MIijYIu189HwELEo4arypW1PVbLQZyeGY5TWQWihemUXvd0sudxF8GKf5Dm
        B4f4xmmhxa7FfnXsGCMqtSoIA6l2X3sSk+xOMyMomA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Y+Y8bI
        tjRSuIneNwxBw1hKFEPXmcY/iN7ZOtGJL3Lbo=; b=t7FVMQbvBXdKASCSel4B3U
        BRLMx3ZifZ9shiQxD1QpjiZCyD+DouCWaeNvwe0YVoZFgqbBZp1NUB4C8hq9yS4v
        LADfoWgIhsI6phpOespB0FZMhIie655+7QjAtlb9OOLWAlNZIE1JIUWUbuiQllHU
        uXCpo31YwASjIH6ouN/Ig0RMxWgASfz2lVswgRdRrYnkAEY69n5hpwkKU/3E/iTo
        7LCjM0Rv3bSsM7an8NPmQTpQ0n/FVsQym1P7KbWk40lZZM5eZh4cTq/52gKBseFi
        aOUcSXpR122CvyHzNgrMqi3qPV6viJ+RwMlDlRqLtYD3v5f/m6wIiGgrkdFhon6w
        ==
X-ME-Sender: <xms:sgcaYf5xBgFd8o_mUsDs8gETRxVNMcnBjYzs-KSEteXXV2IbsTA4mw>
    <xme:sgcaYU7ZRtz_liAxsP4o8B4jUMnh_1e0G6k7ZtqX_97GmIriQi68lXuR8eER-DWDI
    4HtC7EFMV599MKOF68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrledtgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:sgcaYWfyrmCZWgx6n7fvWRm5Fuspqk-SviX3GAJYIVJmbk9p8YTyIg>
    <xmx:sgcaYQIsHWZb34YwarIoAh8USLQVC5SoFJvDPHj3grI_hxAMseOqkA>
    <xmx:sgcaYTJNETr3IJ_Yd-TmRROxyBnKC7goYD0oWrKh_dKzgAJ-lN3Xsg>
    <xmx:tAcaYUVRvfX99w0Ux9Ev7cFNZSlccnGDR8WLLZ5qTeKdOXKkgyp-6g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 97F7B51C0060; Mon, 16 Aug 2021 02:37:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1118-g75eff666e5-fm-20210816.002-g75eff666
Mime-Version: 1.0
Message-Id: <6c97e086-52f6-4f2f-8238-d9b1c24fe8da@www.fastmail.com>
In-Reply-To: <871r6u1wlz.wl-maz@kernel.org>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-3-alyssa@rosenzweig.io> <87a6lj17d1.wl-maz@kernel.org>
 <8650c850-2642-4582-ae97-a95134bda3e2@www.fastmail.com>
 <871r6u1wlz.wl-maz@kernel.org>
Date:   Mon, 16 Aug 2021 08:37:07 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Marc Zyngier" <maz@kernel.org>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        linux-pci@vger.kernel.org, "Bjorn Helgaas" <bhelgaas@google.com>,
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



On Sun, Aug 15, 2021, at 18:49, Marc Zyngier wrote:
> On Sun, 15 Aug 2021 13:33:14 +0100,
> "Sven Peter" <sven@svenpeter.dev> wrote:
> > 
> > 
> > 
> > On Sun, Aug 15, 2021, at 09:42, Marc Zyngier wrote:
> > > On Sun, 15 Aug 2021 05:25:25 +0100,
> > > Alyssa Rosenzweig <alyssa@rosenzweig.io> wrote:
> > [...]
> > > > +
> > > > +static int apple_pcie_setup_port(struct apple_pcie *pcie, unsigned int i)
> > > > +{
> > > > +	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
> > > > +	void __iomem *port;
> > > > +	struct gpio_desc *reset;
> > > > +	uint32_t stat;
> > > > +	int ret;
> > > > +
> > > > +	port = devm_of_iomap(pcie->dev, to_of_node(fwnode), i + 3, NULL);
> > > > +
> > > > +	if (IS_ERR(port))
> > > > +		return -ENODEV;
> > > > +
> > > > +	reset = devm_gpiod_get_index(pcie->dev, "reset", i, 0);
> > > > +	if (IS_ERR(reset))
> > > > +		return PTR_ERR(reset);
> > > > +
> > > > +	gpiod_direction_output(reset, 0);
> > > > +
> > > > +	rmwl(0, PORT_APPCLK_EN, port + PORT_APPCLK);
> > > > +
> > > > +	ret = apple_pcie_setup_refclk(pcie->rc, port, i);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	rmwl(0, PORT_PERST_OFF, port + PORT_PERST);
> > > > +	gpiod_set_value(reset, 1);
> > > > +
> > > > +	ret = readl_poll_timeout(port + PORT_STATUS, stat,
> > > > +				 stat & PORT_STATUS_READY, 100, 250000);
> > > > +	if (ret < 0) {
> > > > +		dev_err(pcie->dev, "port %u ready wait timeout\n", i);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	rmwl(PORT_REFCLK_CGDIS, 0, port + PORT_REFCLK);
> > > > +	rmwl(PORT_APPCLK_CGDIS, 0, port + PORT_APPCLK);
> > > > +
> > > > +	ret = readl_poll_timeout(port + PORT_LINKSTS, stat,
> > > > +				 !(stat & PORT_LINKSTS_BUSY), 100, 250000);
> > > > +	if (ret < 0) {
> > > > +		dev_err(pcie->dev, "port %u link not busy timeout\n", i);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	writel(0xfb512fff, port + PORT_INTMSKSET);
> > > 
> > > Magic. What is this for?
> > 
> > The magic comes from the original Corellium driver. It first masks everything
> > except for the interrupts in the next line, then acks the interrupts it keeps
> > enabled and then probably wants to wait for PORT_INT_LINK_UP (or any of the
> > other interrupts which seem to indicate various error conditions) to fire but
> > instead polls for PORT_LINKSTS_UP.
> > 
> > > 
> > > > +
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
> > 
> > I'm pretty sure this is true. The same registers are also used to setup
> > and handle legacy interrupts.
> >
> > My current understanding is that PORT_INTSTAT is used to retrieve the fired
> > interrupts and ack them, and PORT_INTMSK are the masked interrupts.
> > And then PORT_INTMSKSET and PORT_INTMSKCLR can be used to manipulate
> > individual bits of PORT_INTMSK with a single store.
> 
> So this really should be modelled as an interrupt controller. If
> someone comes up with a bit of a spec (though the bit assignment is
> relatively clear), I can update the interrupt code to handle
> that. After all, I moan enough at people writing horrible PCI driver
> code, I might as well write an example myself and point them to it.

Thanks for the offer!
Unfortunately, what I've written above is almost everything I know about this
hardware. If you tell me what additional details you need to know I can see
what I'm able to figure out though and write a small summary.

Thanks,


Sven
