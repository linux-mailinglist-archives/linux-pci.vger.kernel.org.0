Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D0D773B89
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 17:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjHHPwM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 11:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHHPut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 11:50:49 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC8E1FFA
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 08:42:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CC6725C00BD;
        Tue,  8 Aug 2023 03:45:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 08 Aug 2023 03:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691480706; x=1691567106; bh=gj
        z6OiMLrclZFMOUDCUupdUehHVLB5u//qoVBb28758=; b=Zs1XR4Mpb4b6OHtphg
        7fhSC6urXg/c1oB2RqwiSpHOSqGeYr8got8RKvBlXlsqV0yh27q8outTFwUBtIvo
        2Q9JG3yKc3VrpmSpzgjC8lYENkZWHGniBqRglvSU7FR55Y12jFzveDa1VJsXPUPK
        qKGhm/XEOLr+doQLI8J5EnCPLSHkLZ1FAkyoZU0HyxbELopFidStirDzHhZKgSqF
        lO/kiZMwxDnIzw5ZocKKw9QkpwFLwzKnvmAb5mfa+vM8GUmW0UrNuDqDpsePyjC2
        gzW9RzI9X8g3wROVk8yy0GiIIWTb5zvsgWuiUFPzPxL/WZsTk1Lz477x3sV5y0Sb
        OhgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691480706; x=1691567106; bh=gjz6OiMLrclZF
        MOUDCUupdUehHVLB5u//qoVBb28758=; b=i4fi9+pb0Go1yVsuU9zo7pqGl7iru
        JSbYFrI0aBEJ0q3Uxu6d3GZPHdRNREVBDrzcNfqETD6SrbYBf2E/LOm0eYeAQv9t
        YICd+WAInSszDs2GOQhG2EQQQIuR6fCKVdhCN1/myT4WUWjDOas55zoL2gM5OHOV
        kBrCPwpQAy3Jj490SIxRlBQ7mWU1SdYjR9UZ6Lgp7mrehSErDihR2IbQIl4jmzrS
        PwadcC/wgcGM01lXPTpirkOmd1xrtq2kTOcbZ1V2fKM94m+xX4wX2tZw4wgRKqY+
        0nUUyzm8IDqZKiPWbX7DM5yzqCZG1t2H9q8hSbTVavSvXT3NjuEoC+02g==
X-ME-Sender: <xms:gvLRZLUow1VgUUEqFGi7yRLafPkT5Hr10QU10M8VuwkF8FAVqZvLFA>
    <xme:gvLRZDkPfZ-jCjtiUoxXdfB0CK9U1kMyscXaLGFd7r0cPvlVuASyhc99UyPSWK5r3
    uHKTetrtJ4gClmGEWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gvLRZHYJ2bGlUtNvvIwMfyeG1KpP76Fsh1sAtB_VBDQPsZD3KLEBdw>
    <xmx:gvLRZGV3lAlemTTVW-ONrcOwKj7RqV-sSEeZ8OmzLTZeKX3-767gwQ>
    <xmx:gvLRZFlY21pxcWJqKfQEWhEzJat1pjmNKRGxoG4EHHxFCqwgcVTugA>
    <xmx:gvLRZLjFKuYtLsmQSPhsmybpqtzZt7FWEPiyBexxedgvaKFaKvjngg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6458BB60089; Tue,  8 Aug 2023 03:45:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <344b8ccd-23c9-4476-9493-1d2b9c23590d@app.fastmail.com>
In-Reply-To: <20230808070357.GC4990@thinkpad>
References: <189cff865f3.fc7e71c96186.1411633612292556520@linux.beauty>
 <20230808070357.GC4990@thinkpad>
Date:   Tue, 08 Aug 2023 09:44:44 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Manivannan Sadhasivam" <mani@kernel.org>,
        "Li Chen" <me@linux.beauty>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>
Subject: Re: [RFC] add __iomem cookie for EPF BAR
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 8, 2023, at 09:03, mani wrote:
> On Mon, Aug 07, 2023 at 08:28:30PM +0800, Li Chen wrote:
>> 
>> Currently, the EPF's bar is allocated by pci_epf_alloc_space, which internally uses dma_alloc_coherent and the caching behavior of dma_alloc_coherent may vary depending on platforms.
>> 
>> The bar space is exported to RC, which means that RC may modify it without EP being aware of it, so EP still read from the cache and get stalled data. To address this issue, the bar space should be treated as iomem instead and forced to use io read/write APIs, which enforces volatile. 
>> 
>
> We already had a similar discussion on using volatile for BAR space and settled
> with {WRITE/READ}_ONCE macros in EPF Test driver [1].
>
> Since the BAR space allocated in endpoint is not a MMIO, I don't think it should
> be forced as iomem. Rather EPF drivers should use _ONCE macros to access the
> fields to avoid coherency issues as suggested by Arnd earlier.

Using readl/writel is clearly the wrong solution here as I explained
before, but I assume that Li Chen is dealing with a real problem.

If the cache is coherent with the device, then reading from the cache
is clearly the right thing to do, but the mentioned "stall" problem may
be related to the store buffers, where an dma_wmb() after the
WRITE_ONCE() is missing. Similarly, a dma_rmb() might be missing before
a READ_ONCE() to prevent prefetching during out-of-order execution.

With readl()/writel(), you already get very heavy barriers, so it may
end up working by accident, but these barriers are at the other side
of the access (before writel and after readl) and may be the wrong
type of barrier depending on the CPU.

       Arnd
