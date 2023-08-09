Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878C37753BB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjHIHKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 03:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjHIHKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 03:10:44 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD95B1FDC
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 00:10:42 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9FDA83200934;
        Wed,  9 Aug 2023 03:10:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 09 Aug 2023 03:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691565041; x=1691651441; bh=eb
        SSyd7sDYt0Yru+YTZUFCPWBRSp4UGynnDfbD/M1DQ=; b=QPm9feMweqYqngVpsO
        6Nd5yv+FEfHUFwcRaPuVs4mIl476Q6o6e/GUqVFfHWcUUNhMBNrqkdOk5EPPeiQ/
        FVXyziTKk+tIkP7exl62bI4/58A/Rxk1KtTdVPMbAse4efFRFEOQWqzZSwqQgi97
        Hm+5r7tbhr3HwFDy/FpBi7NotWikcKE0oLBdBFDTqZkB2KKLUj08eLDphYISCIu+
        YfKbEm7vKnx46a0Ayk7B9aBQd/mkNvvndfsPjQ8gmew/+14sax86qX/vzGhRRq7z
        /OQ7yqD+7Zv7rs2eAdrrDtwF1RWkhnu61um4eV1kjZoX+9Ib2rjtzn/lafwk8h3k
        UJgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691565041; x=1691651441; bh=ebSSyd7sDYt0Y
        ru+YTZUFCPWBRSp4UGynnDfbD/M1DQ=; b=EX5y9FAQu/UHgOizKEjJyjxm+MyW8
        4jxXRakBtJayJK4gzNuAjSi9pDHVc2rSpbg4dB7FEJBsYrYOOvkyZFAfwwxAZDkN
        zNSbIDTejuYIpsIFPUkwOjlULvWrZWR0EY1m6+20A60vm+FyW147wupuLMNirzd/
        40YvIuReM+56rSKvqanktr2BlVrKYNDEoW70/AuLyOnVTRmO6rzL8RXEo+pTME1E
        iRn8glhNXKvX9FgyhD0RlvgBOeFCvnAlvKWrlrmsGJG/NFPyFvjGRZYxvtw2KYkV
        Ox1Xx2kwHuZ4jMzTlSPjtIWU5LzOGsGY7Gl5MC25RYiPNtVTKrqUXcnRw==
X-ME-Sender: <xms:8DvTZMylbN-B5r3AUbaIQ41SePS7Ecma3LnTDJbKqIO2MfTMlVYuPg>
    <xme:8DvTZAT8PcYL5rYDlL2hsnXT2JQNsOYPwL70x1RB6VL6fyrEBeKYTWKk_XNbU6Gvz
    WXAlLTi7njmn5MhutM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleefgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8DvTZOU94Nu2Uaf07TxCgco7Z_rDI1De7kYnPmBacmfJxpZXKRR4cg>
    <xmx:8DvTZKiEFQAvuzSRNQtnVEjS3MsK3VBIgXD3df2-tzQDDkYq8vAN8Q>
    <xmx:8DvTZOAvfJVqg0AKvz5nQoUdtFxif6QBbUkN8w1NZClh5-ncmqyCHA>
    <xmx:8TvTZJMI5UU6mljkWS0d_20sVrr-29ZB5qTeWTRD0uCULKg3ZeH8Iw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D678CB60089; Wed,  9 Aug 2023 03:10:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <9b1213cf-a8f4-41b3-8918-a00bf0ff7f28@app.fastmail.com>
In-Reply-To: <87sf8t58di.wl-me@linux.beauty>
References: <189cff865f3.fc7e71c96186.1411633612292556520@linux.beauty>
 <20230808070357.GC4990@thinkpad>
 <344b8ccd-23c9-4476-9493-1d2b9c23590d@app.fastmail.com>
 <87sf8t58di.wl-me@linux.beauty>
Date:   Wed, 09 Aug 2023 09:10:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Li Chen" <me@linux.beauty>
Cc:     "Manivannan Sadhasivam" <mani@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>
Subject: Re: [RFC] add __iomem cookie for EPF BAR
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 9, 2023, at 03:09, Li Chen wrote:
> On Tue, 08 Aug 2023 15:44:44 +0800,
> Arnd Bergmann wrote:
>> On Tue, Aug 8, 2023, at 09:03, mani wrote:
>> > On Mon, Aug 07, 2023 at 08:28:30PM +0800, Li Chen wrote:
>
>> If the cache is coherent with the device, then reading from the cache
>> is clearly the right thing to do,
>
> I guess that even SoCs with CCI support might not handle cache for RC
> access if specific bus interfaces are not connected.

Correct, each device in the system can be cache-coherent or
noncoherent, independent of the others, and needs to be marked
correctly in the DT. The dma_alloc_coherent() call will either
allocate cacheable or noncachable memory based on what the
kernel thinks is required for the particular device.

>> but the mentioned "stall" problem may
>> be related to the store buffers, where an dma_wmb() after the
>> WRITE_ONCE() is missing. Similarly, a dma_rmb() might be missing before
>> a READ_ONCE() to prevent prefetching during out-of-order execution.
>> 
>> With readl()/writel(), you already get very heavy barriers, so it may
>> end up working by accident, but these barriers are at the other side
>> of the access (before writel and after readl) and may be the wrong
>> type of barrier depending on the CPU.
>
> For systems that aren't cache-coherent, is it accurate to say that the 
> store
> buffer might still be utilized, and that there might still be a need 
> for dma_wmb and dma_rmb?

Yes, the ordering is really independent of the cache, so these will
be needed for portable code either way, the same way you need
smp_wmb()/smp_rmb() between CPUs accessing shared memory locally.

     Arnd
