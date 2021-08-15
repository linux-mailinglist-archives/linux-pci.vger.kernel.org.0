Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6703B3EC901
	for <lists+linux-pci@lfdr.de>; Sun, 15 Aug 2021 14:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhHOMeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 08:34:09 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33557 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229603AbhHOMeI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Aug 2021 08:34:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4CDC558037E;
        Sun, 15 Aug 2021 08:33:38 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Sun, 15 Aug 2021 08:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=3mHySEgehdbD6Kek++OFQ1ygL9wK
        YmdzyYhN34LmWzw=; b=L6/VQ2hJtQZapFkUx3t/J5MtLrkxncWRe+4yNA5VCV1t
        WUtMgaJx+J0VmGmNKo2DSKWtLK4hUcXW6nnFEBLW5SkvOo+9iuA6wzXcLXQr0TAO
        rodBdySyctqJAcs8vkPhn+Rvcyb8ixjtwReYQZowYOEeX4U8D0G2W8NBkoMElBjV
        LnSLlZ64Lf5NXC/7WpLwPs/sO/vVq56mPhqpxAFxhnPBPZ8eXHcZuRgLIiuoTI4a
        ew/t8StDtZ3kVn+6iUKLWYS85ytt6GJ0yYr4DACiwoUUGtJTCSgg9Uyl7u1vM8XO
        RAFrI+WUWO+i1WEy5SbAmULKXIecCd8Ggx3QwpduSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3mHySE
        gehdbD6Kek++OFQ1ygL9wKYmdzyYhN34LmWzw=; b=YVaqJpaEF/HtRU4Sm9afuI
        9g6ra1H/BLv0E+HUQthN1XNMJN0K3ysetTO13dVkd7xZVig5rtDUa+QEl0BqQeEl
        rj08p5fgSHdtB9uP/D/oZTTzcLkShBQG58u8aTZR2+9mSA+/P0fqT03ZSMRyyfn+
        ukX0aTeIheGkztjDFmduiirAveGzKEjpMjUpnygVVvgUm/UnoQ3HDJ+NUxqsBTUW
        1aodYsRZiKUG8/z34C2f/G7D+GEwlu15AMNOTFhrs1tV1GKHDNbrq42PS8uTrF4b
        heVjpAR6/l85kjwH1cCl0Sz/dj0UgZxFQSvoy7Yb9bbA0z1TD5s5fqf0QaxAkaUQ
        ==
X-ME-Sender: <xms:oAkZYRN7Q06kwy5x2B28mTRelnmL_oMxtt5FPH07QN29qqyTVAJWgQ>
    <xme:oAkZYT-VyCouOd6ckxMHFF3wLlmz2FAdir9eq4uXV0UDK-ZEXxrYUKF8a4B0NGdnw
    dmMWeVPHz3ccdPcoag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeelgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:oAkZYQR-8pymFEOZZZ6-iuy8Bs-K4uhyZEnWQnuMlbdJ9FZ4DGON8g>
    <xmx:oAkZYdurCpkpXm5BveVu24bhIlKOcCI-xNp3GG0PtqG1OSMb5oXCOg>
    <xmx:oAkZYZeyGVTEjxAz3-YyDhhj5cfB5XUumOnv8KlwUFLxW0RDTDA6hA>
    <xmx:ogkZYV55Xg0XCwldIPgFil18_xR8UsivQG3K317gL-tI6u3jcUXUQQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 46AB651C0060; Sun, 15 Aug 2021 08:33:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1082-gccb13bca62-fm-ubox-20210811.001-gccb13bca
Mime-Version: 1.0
Message-Id: <8650c850-2642-4582-ae97-a95134bda3e2@www.fastmail.com>
In-Reply-To: <87a6lj17d1.wl-maz@kernel.org>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-3-alyssa@rosenzweig.io> <87a6lj17d1.wl-maz@kernel.org>
Date:   Sun, 15 Aug 2021 14:33:14 +0200
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



On Sun, Aug 15, 2021, at 09:42, Marc Zyngier wrote:
> On Sun, 15 Aug 2021 05:25:25 +0100,
> Alyssa Rosenzweig <alyssa@rosenzweig.io> wrote:
[...]
> > +
> > +static int apple_pcie_setup_port(struct apple_pcie *pcie, unsigned int i)
> > +{
> > +	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
> > +	void __iomem *port;
> > +	struct gpio_desc *reset;
> > +	uint32_t stat;
> > +	int ret;
> > +
> > +	port = devm_of_iomap(pcie->dev, to_of_node(fwnode), i + 3, NULL);
> > +
> > +	if (IS_ERR(port))
> > +		return -ENODEV;
> > +
> > +	reset = devm_gpiod_get_index(pcie->dev, "reset", i, 0);
> > +	if (IS_ERR(reset))
> > +		return PTR_ERR(reset);
> > +
> > +	gpiod_direction_output(reset, 0);
> > +
> > +	rmwl(0, PORT_APPCLK_EN, port + PORT_APPCLK);
> > +
> > +	ret = apple_pcie_setup_refclk(pcie->rc, port, i);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	rmwl(0, PORT_PERST_OFF, port + PORT_PERST);
> > +	gpiod_set_value(reset, 1);
> > +
> > +	ret = readl_poll_timeout(port + PORT_STATUS, stat,
> > +				 stat & PORT_STATUS_READY, 100, 250000);
> > +	if (ret < 0) {
> > +		dev_err(pcie->dev, "port %u ready wait timeout\n", i);
> > +		return ret;
> > +	}
> > +
> > +	rmwl(PORT_REFCLK_CGDIS, 0, port + PORT_REFCLK);
> > +	rmwl(PORT_APPCLK_CGDIS, 0, port + PORT_APPCLK);
> > +
> > +	ret = readl_poll_timeout(port + PORT_LINKSTS, stat,
> > +				 !(stat & PORT_LINKSTS_BUSY), 100, 250000);
> > +	if (ret < 0) {
> > +		dev_err(pcie->dev, "port %u link not busy timeout\n", i);
> > +		return ret;
> > +	}
> > +
> > +	writel(0xfb512fff, port + PORT_INTMSKSET);
> 
> Magic. What is this for?

The magic comes from the original Corellium driver. It first masks everything
except for the interrupts in the next line, then acks the interrupts it keeps
enabled and then probably wants to wait for PORT_INT_LINK_UP (or any of the
other interrupts which seem to indicate various error conditions) to fire but
instead polls for PORT_LINKSTS_UP.

> 
> > +
> > +	writel(PORT_INT_LINK_UP | PORT_INT_LINK_DOWN | PORT_INT_AF_TIMEOUT |
> > +	       PORT_INT_REQADDR_GT32 | PORT_INT_MSI_ERR |
> > +	       PORT_INT_MSI_BAD_DATA | PORT_INT_CPL_ABORT |
> > +	       PORT_INT_CPL_TIMEOUT | (1 << 26), port + PORT_INTSTAT);
> > +
> > +	usleep_range(5000, 10000);
> > +
> > +	rmwl(0, PORT_LTSSMCTL_START, port + PORT_LTSSMCTL);
> > +
> > +	ret = readl_poll_timeout(port + PORT_LINKSTS, stat,
> > +				 stat & PORT_LINKSTS_UP, 100, 500000);
> > +	if (ret < 0) {
> > +		dev_err(pcie->dev, "port %u link up wait timeout\n", i);
> > +		return ret;
> > +	}
> 
> I have the strong feeling that a lot of things in the above is to get
> an interrupt when the port reports an event. Why the polling then?


I'm pretty sure this is true. The same registers are also used to setup
and handle legacy interrupts.

My current understanding is that PORT_INTSTAT is used to retrieve the fired
interrupts and ack them, and PORT_INTMSK are the masked interrupts.
And then PORT_INTMSKSET and PORT_INTMSKCLR can be used to manipulate
individual bits of PORT_INTMSK with a single store.



> 
> > +
> > +	writel(DOORBELL_ADDR, port + PORT_MSIADDR);
> > +	writel(0, port + PORT_MSIBASE);
> 
> So here you go, the MSI doorbell *is* configurable. Should it be
> placed somewhere else? Shouldn't it be configured before the link is
> up?

Yes, I'm pretty sure it should be configured before triggering PORT_LTSSMCTL_START.


> 
> > +	writel((5 << PORT_MSICFG_L2MSINUM_SHIFT) | PORT_MSICFG_EN,
> > +	       port + PORT_MSICFG);
> 
> Ah, that one actually makes sense (enables 32 MSIs for the port).

Same as above, I think this also should be done before PORT_LTSSMCTL_START.




Best,


Sven
