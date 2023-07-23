Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6297E75E4E5
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jul 2023 22:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGWUjG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jul 2023 16:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWUjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jul 2023 16:39:05 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED23E49;
        Sun, 23 Jul 2023 13:39:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BA3613200035;
        Sun, 23 Jul 2023 16:39:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 23 Jul 2023 16:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1690144740; x=1690231140; bh=NV
        7k/N80dOAADhSM9J12JfLW++A3+GdGL/V6Zz2j2C0=; b=fPWTBoXpkB56qtTjok
        3e3s5L7XCe4y1hhcsKbHkaSp8TjVhA5i0Ux98l6IEZ+1zXwO4B6IoneOs+S43Oem
        6wn+W696K9xYJLCpMybZ85DRMPeZBnl3tLrN5k69WFOwgeYiVab1IegVfqe0abci
        jKhF653DQsnurP3nTp0gWCIGZ4HiaSR5aiAAhd33Tr1+Uin2S0VhZwVNQ9L4QU6R
        LHbFLyPw/zcLT0Q9i/7Nljs2E5wFkcFjomg5ILZ4uuAZlbwb/t0Pj2aG9jnFi7eL
        /cW2jhziimDGAwnUjp7c7tqRfuZ7C99eLo97AtRR5ZksCsOstaMn31cNJ/QqaJd2
        CVEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690144740; x=1690231140; bh=NV7k/N80dOAAD
        hSM9J12JfLW++A3+GdGL/V6Zz2j2C0=; b=KBQkDcB3o5zDygvA1JjP0lJaHT06m
        VxNPkhZbYVpT2uIAzH5j2zBTFnzrQyTd4i966To6VRPu0TW3wFrdzqqMgivDuFIx
        UMAI/AEwcez6rSAr3CJ8jj81XdQFnaRSUhIP7OJP4vZ+Qd0GotKyKzqENfMPAh07
        q9Q14NK0ohdp6uNE5hhen/NJ/TxnJdjANiKWwrxBMksrXTINbSZSEjNELRZbf7TU
        YeeAm1G/jbK5ONF3fcmaQLlLPZFb5NgGtafzo3TZcapvuIPWzjQku15zrI/Jjjx9
        W9PT6Lf/h5mrp5z/e+ZiKwjQ9Q4FYiHchfjouDhYJFAsyxdrJhW74ziiQ==
X-ME-Sender: <xms:5I-9ZIdgeVjtMP2q8sgaORYg2XR-vNSbF3_5DZKcIwVwatx09JSsyQ>
    <xme:5I-9ZKN_0Q64Rl3R2hWy-Q9tEcb-81k__IiXb7FlN_rnFcwZW-87yOjSbML9DwOSo
    qTNdZH7CgpyYA>
X-ME-Received: <xmr:5I-9ZJgihIOcgIu6qGNblaNlW1NQ7KydLy-C0lLd0xLZU_2NfDgLNVMYomLip3z9Lz22t5DKaBEl3KurWKhElRYaO3vOSe7Zf1MP-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheeigdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:5I-9ZN-2Wq-ZSNrsmwdZZ6d_pm0sBjq66T8ZFbsWPXTvSyu3-MlHIQ>
    <xmx:5I-9ZEv7w10kVJgMbwtlWKAyXvIgJ1_Kbw4BAezyxLoNQI2koPf74Q>
    <xmx:5I-9ZEH9QTRSy4tltcRSGdePsefFd7rkGEJ0iQay9OhRVvdYIKPUpQ>
    <xmx:5I-9ZIj1K3LxIZXMpKcSUCL4bNtc8-dPDAF9vsTu3Y-VqVKDj3W3Mg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jul 2023 16:38:59 -0400 (EDT)
Date:   Sun, 23 Jul 2023 22:38:56 +0200
From:   Greg KH <greg@kroah.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Wireless mailing list <linux-wireless@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        PCI mailing list <linux-pci@vger.kernel.org>
Subject: Re: Nomenclature for USB-connected WiFi devices
Message-ID: <2023072345-snowboard-isolated-e390@gregkh>
References: <8ce5288f-9ed2-4df9-a0a2-bb46941089fb@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce5288f-9ed2-4df9-a0a2-bb46941089fb@rowland.harvard.edu>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 23, 2023 at 12:04:50PM -0400, Alan Stern wrote:
> If you've got a WiFi device that connects to the host computer via USB, 
> do you refer to it as a "wireless USB device" or as a "USB wireless 
> device"?

A "USB wifi device", just like the "PCI wifi device" in my desktop.

Or "USB keyboard", or "USB mouse", or "USB thermometer", etc.

> The second would seem to be more logical, by analogy with things like a 
> USB mouse or a USB thumbdrive -- we don't say "mouse USB device" or 
> "thumbdrive USB device"!

Exactly.

> Furthermore, the first ("Wireless USB") is in fact the name of a defunct 
> specification for an Ultra-WideBand interface that would run the USB 
> communication protocol over a wireless connection.

Exactly, let's not get things confused with that obsolete and dead
technology please.

> Nevertheless there are quite a few places in the kernel source that use 
> "wireless USB" where they really mean "USB wireless".  (A few of them 
> are gray cases, like "Sierra Wireless USB-to-WWAN", although here the 
> word "Wireless" evidently is redundant -- maybe it is part of a brand 
> name?)
> 
> Would there be any objection to a patch that does a wholesale conversion 
> from "wireless USB" to "USB wireless"?

I would be glad to take such a patch.

> PS: Similar reasoning applies to the term "wireless PCIe device", 
> although here the number of offenders is smaller.

Hah, I should have read the whole email :)

thanks,

greg k-h
