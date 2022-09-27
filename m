Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B055EBD3E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiI0I3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 04:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiI0I3g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 04:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9F960F3
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 01:29:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F0DB61628
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E77FC433D6;
        Tue, 27 Sep 2022 08:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664267372;
        bh=2CeOPmycerE5TVJWmbnN8knOvsJihI1Ky45q1XLPPkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQsNajcHM9SsFAr2spVtKGoTZbjYESD05DOrM7/lhh62jBz4mJ8FwQWeUaT1D+qyU
         MeeOLz+ff1Dd8AfjHM8x8dLFhVYTXzDUj5pjiNF84V9QQTK8RCkQXdeKC1MBaYmtC0
         jLH9UoaHVrsoMbN9/Od0IUdQqsKjq6lWKCkpAzWXji0x8iw3qL5WeLR7rJwXEqVB5C
         EVEYra/OVsYQmkyz6GOcoUXl/R0FWXSAb8kekajQ8q+l5QK3BoCrxxDWyduAGu6uaS
         OSIqlWbCfpqF6/WlFPkiN3AfVyOGAu0EyjpgvKHj9fwzEVrc4xmisvP4UsYHcCtbn2
         5AQQYytV27/Mw==
Date:   Tue, 27 Sep 2022 10:29:26 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 03/11] PCI: aardvark: Add support for DLLSC and hotplug
 interrupt
Message-ID: <YzK0Zo6+5OoVwirK@lpieralisi>
References: <20220818135140.5996-1-kabel@kernel.org>
 <20220818135140.5996-4-kabel@kernel.org>
 <YxtUR0+dBZut8QZH@lpieralisi>
 <20220916182302.4eba1b48@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220916182302.4eba1b48@dellmb>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 16, 2022 at 06:23:02PM +0200, Marek Behún wrote:
> On Fri, 9 Sep 2022 16:57:11 +0200
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> 
> > [+Marc, Thomas - I can't merge this code without them reviewing it,
> > I am not sure at all you can mix the timer/IRQ code the way you do]
> > 
> > On Thu, Aug 18, 2022 at 03:51:32PM +0200, Marek Behún wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > 
> > > Add support for Data Link Layer State Change in the emulated slot
> > > registers and hotplug interrupt via the emulated root bridge.
> > > 
> > > This is mainly useful for when an error causes link down event. With
> > > this change, drivers can try recovery.
> > > 
> > > Link down state change can be implemented because Aardvark supports Link
> > > Down event interrupt. Use it for signaling that Data Link Layer Link is
> > > not active anymore via Hot-Plug Interrupt on emulated root bridge.
> > > 
> > > Link up interrupt is not available on Aardvark, but we check for whether
> > > link is up in the advk_pcie_link_up() function. By triggering Hot-Plug
> > > Interrupt from this function we achieve Link up event, so long as the
> > > function is called (which it is after probe and when rescanning).
> > > Although it is not ideal, it is better than nothing.  
> > 
> > So before even coming to the code review: this patch does two things.
> > 
> > 1) It adds support for handling the Link down state
> > 2) It adds some code to emulate a Link-up event
> > 
> > Now, for (2). IIUC you are adding code to make sure that an HP
> > event is triggered if advk_pcie_link_up() is called and it
> > detects a Link-down->Link-up transition, that has to be notified
> > through an HP event.
> > 
> > If that's correct, you have to explain to me please what this is
> > actually achieving and a specific scenario where we want this to be
> > implemented, in fine details; then we add it to the commit log.
> 
> Hello Lorenzo, sorry for not replying earlier.
> 
> Would something like this be sufficient?
> 
>   DLLSC is needed by the pciehp driver, which handles hotplug, but also
>   link state change events. AFAIK no Aardvark devices support hotplug,
>   but link state change events are required for graceful driver
>   unbinding in case of link down event.
> 
>   So with this change we achieve graceful driver unbind for example
>   when WiFi card PCIe link goes down (we've seen this with ath10k and
>   mt76 WiFi cards). Before the WiFi driver started spitting out errors,
>   or even taking the whole system down.
> 
>   Since after link goes down, it can come back up if the WiFi card can
>   recover (or if reset pin is used to reset the card), we need to be
>   able to recognize link up event. Since AFAIK Aardvark does not have
>   interrupt for link up event, the best thing we can do is simulate it
>   - whenever we read the link state, find it is up, and have cached
>   value saying it is down, we trigger the link up event. We read link
>   state whenever the configuration space is read, for example by
>   writing 1 to /sys/bus/pci/rescan.

Better, certainly. Question, also related to Marc's query. Do you
rely on the hotplug (emulated IRQ) to be run _before_ carrying on
with PCI config space accesses following a link-up detection ?

How was the jiffies + 1 expiration time determined ? I assume you
want to run the emulated HP IRQ asap - the question though is
how fast should it be ?

Lorenzo
> 
> Marek
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
