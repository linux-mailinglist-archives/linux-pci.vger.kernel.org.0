Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC53862379E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 00:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiKIXmO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 18:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKIXmN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 18:42:13 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C272D741
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 15:42:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4CFFB3200955;
        Wed,  9 Nov 2022 18:42:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Nov 2022 18:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668037328; x=1668123728; bh=+pZyUNAp1v
        s4PEJAOC6J6SmXC2JO2ckuc1mWQfT/a2g=; b=0F3KlWsxliGnawcoUdq0HQkje0
        ePXFvAXUWRZOShX8gWHte/i5FHLEI/O4UZR3H8nG89eKBpzG+EQ/ARTWjuUSRW2h
        5EMV90DbpJ+C45rDi/7MUzNm34vSicSa2/Gr5R15aqPZabVu87d1Cz2t8JIlyhFR
        Y1UksWeEKQSA9RNMQbtuvioVIwPUkPkQ1bcQCHU5iGxZE/7wnHq3mh6Y7FmbcjVW
        4knIAIS1aCr/KaKpl7IKjwoiEjBVTKp1xHJ9cYofsLYTSkjG7qSHjUJiYkQirNZg
        JI+o0LH1Q3JQBNpDEp9Y0y8R9L/KazH3Jm7hhjBU3y/Ekg/1FPjkZfaj8fIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668037328; x=1668123728; bh=+pZyUNAp1vs4PEJAOC6J6SmXC2JO
        2ckuc1mWQfT/a2g=; b=boij4X2rcz8AOx+G8Fw8LikCi39HLWnD2kyQtV6QTUnI
        PKkkPYzTi3bA8t+ePWaruP4W+UoALTvV6O6jSDE7nIxRTAqhVZWHOCpdcIrHBAo/
        Eqvwk2oi5HqMzCosHLjU+pdsxh1E1kLaHUjocpcoTluTOsWRmPCx0iYUFo+NeGMK
        44Tme4Hw/HXpz+1by2z7twDDjjwQ5lXjbvfzMNY35n68nKvE6m7UC4MWZGWkgTxF
        tFktdUEWRNG/3NIFRgKLKPs1A66cNiz9nCX+VVU3LpvvRqWynqxD8kfeBsNbemMR
        4Mbj3A56yh5JnrM4ne4iVPbrdchx4VYmIqkBv/GT8A==
X-ME-Sender: <xms:0DpsY-Ti5vy4L2lwH3f35PKTQpF1gToV9IaAKgVmsbqpiJ1T3dlCLQ>
    <xme:0DpsYzyPTUiqfTKfqA3zqRH7NnaXkDinSiPVSYZsLB5h-duEu4oGsapLX83DOxwIW
    AcORT5xsklQVqO7e40>
X-ME-Received: <xmr:0DpsY708ZoLgbmolo98DqzrjwQYLHDE0nnFhdqS3JLi-_KM5K1ax-OZPrEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeefgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpedfvfihlhgv
    rhcujfhitghkshculdfoihgtrhhoshhofhhtmddfuceotghouggvsehthihhihgtkhhsrd
    gtohhmqeenucggtffrrghtthgvrhhnpefgudehjedtleettdeikeeitedvheejheettdek
    gedtveefieelledtgfduteetveenucffohhmrghinhepheduvddrphhinhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehthihh
    ihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:0DpsY6AWOYliv206BJxBUEjH5ZX-YcURhch-ru_1wH865_OzbumZpw>
    <xmx:0DpsY3gmZo8mPVhGjuK4sqijqWcNsKSzyOWr_SXkyUUTcuPPX3Uzqw>
    <xmx:0DpsY2rNlNzczxvvoLozAYf8CT89CNsUerYmdwR_GkzA33QDay4wRw>
    <xmx:0DpsY3efRYCTOSyc8OFlKTmMwtnYT4tfuTQrUUwDMwCgm5RcxSP9AA>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Nov 2022 18:42:07 -0500 (EST)
Date:   Wed, 9 Nov 2022 17:41:46 -0600
From:   "Tyler Hicks (Microsoft)" <code@tyhicks.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Message-ID: <20221109234146.qkdx5qw4vjdehlgh@sequoia>
References: <20221027225149.GA846989@bhelgaas>
 <20221103221429.GA47218@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103221429.GA47218@bhelgaas>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-11-03 17:14:29, Bjorn Helgaas wrote:
> On Thu, Oct 27, 2022 at 05:51:49PM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 25, 2022 at 12:07:47AM -0500, Tyler Hicks wrote:
> > > On 2022-10-20 15:24:37, Bjorn Helgaas wrote:
> 
> > > I've been talking to the firmware folks on why SAFE mode was selected,
> > > based on Keith's question from Wednesday. From what I've been told,
> > > U-Boot doesn't seed the RP MPS with a value so the kernel sees a value
> > > of 128 for p_mps in pci_configure_mps() when using the DEFAULT mode.
> > > Apparently UEFI does seed the RP MPS but we don't get that with U-Boot.
> > > Therefore, SAFE mode was selected to get an initial, tuned RP MPS value
> > > set to 256.
> > 
> > Are there any devices below the RP at the time we set MPS=256?
> > 
> > > > A subsequent hot-add will do nothing in pci_configure_mps(), and
> > > > pcie_bus_configure_settings() looks like it would set the RP and EP
> > > > MPS to the minimum of the RP and EP MPS_Supported.
> > > > 
> > > > Is that what you see?  What would you like to see instead?
> > > 
> > > No, not quite. After hot-add, we see the EP MPS set to 128 with SAFE
> > > mode even though the RP MPS is 256.
> > 
> > Can you add the relevant topology here so we can work through the
> > concrete details?

# lspci -t
-[0000:00]---00.0-[01-ff]--+-00.0
                           +-00.1
                           +-00.2
                           +-00.3
                           \-00.4


> > Is the endpoint hot-added directly below a Root Port?  Or is there a
> > switch involved?

There's not a switch involved. The multifunction endpoint is hot-added directly
below the root port.

> > What are the MPS_Supported values for all the devices?  If there's a switch
> > in the picture, it looks like we currently restrict to 128, I think because
> > it's possible an endpoint that can only do 128 may be added.

0000:00's MPS_Supported value is 256.

The multifunction endpoint's MPS_Supported is 512.

> Ping?  I'd like to talk about a concrete scenario.  It's too hard for
> me to imagine all the possible things that could go wrong.

Sorry for the slow reply here. Thanks for your interest in getting more
details.

> I guess part of what's interesting here is that things work better
> when firmware has already configured MPS?  It doesn't seem like we
> should *depend* on firmware having done that.

Our firmware folks felt the same way.

Tyler

> 
> Bjorn
