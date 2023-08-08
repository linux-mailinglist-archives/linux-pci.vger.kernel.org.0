Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80766774CA9
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 23:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjHHVOA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 17:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbjHHVNs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 17:13:48 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F091524E
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 12:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=goBkLM4m1+9NN7sozAy1ASlXXKEHqmAjatpbwtYKgAk=; b=0oERYyMhj6Uv9YH9dx0EX6IKF3
        n/wpw/2IN++n2C3b971eQxNZQ55hU1jPReVQ3WbHgDlmiGv+ECcJfhorYt4TXEtzP2VoQaXDer4he
        stW2liJMG/t/AOXrgGAXcVspWaiO9bHzq9LTUbHELcWVk2cqkKNm2ZyLU28CYeZ/YMDsFnRTzRI68
        Kob8KyH81EdATCgLra47dCmsIJdMadARAnZnwbYuY8gHe1J94JRdE/14EiHTgueACgp0P3cMgE2bY
        8i8vCkAZAShce8WwGI3PO+pUw9+FrZh76N3oFxzK64RwAjdUmNK//MkJbzcQvgagi+daOyyZQsig0
        SuScP4Fw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34968)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qTSmV-0001fo-0V;
        Tue, 08 Aug 2023 20:54:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qTSmV-0008Pl-25; Tue, 08 Aug 2023 20:54:15 +0100
Date:   Tue, 8 Aug 2023 20:54:15 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kwilczynski@kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <ZNKdZ1/CE3rjf6z4@shell.armlinux.org.uk>
References: <20230808072605.n3rjfsxuogza7qth@pali>
 <20230808162627.GA314706@bhelgaas>
 <20230808192026.t65ebdii5bv2xx5b@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808192026.t65ebdii5bv2xx5b@pali>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 09:20:26PM +0200, Pali Rohár wrote:
> There area other options which can be done now, if there are only people
> like Russel who are complaining but refusing to do absolutely nothing.

Fucking hell, here we go with the accusations again.

And you can't even be bothered to spell my name correctly.

Let's start over at your first accusation in this thread, because this
says everything about what the problem here is:

"You have received more changes and fixes for last 2 years for these
issues and you have done **nothing**. You even not said anything.
So you are the last one who can complain here.

And I'm stopped communicating with people who do not want to communicate
with me. This is pretty normal situation and you should have think about
it. No?"

Let's go through my points one by one, maybe you'll then understand,
because right now you seem to be totally immune to any appreciation
of anyone's situation other than your own.

1. pci-mvebu works 100% fine for me.

2. I do not see any problems with the hardware I have. If I have no
   problems, then by definition it works fine. How can I test - for
   example, failure to bring up the PCIe link (which I believe some
   of your patches were trying to address) when I HAVE NO PROBLEM WITH
   THE PCIe LINK NOT COMING UP? FFS, take a moment to think about that.

3. I have not asked you to work on it.

4. You do not have the right to demand that I do anything with it.

5. You decided to pick up some patches that I had in my tree and
   merge them into the kernel.

6. You objected when I rebased my branches on top of what you had
   merged (which were modified versions of my patches). I wanted to
   keep my changes intact.

   (Again, you have no damn right in this whole damned world to
   complain about what I do in my own git tree.)

7. You decided on your own back to mark the driver BROKEN - and you
   did that in such a way to *ensure* that no one who would have
   been using it would notice until after the patch was merged. That
   is underhand tactics. You effectively admit to that in my above
   quotation, which effectively states that you _actively_ decided
   to exclude me from that because I didn't interact with you.

> For example mark driver as experimental (there is some Kconfig symbol
> for it). Or add a new menuconfig selectable symbol which appropriately
> warn all distributions about problems and would be dependency for mvebu.
> (if you do not like broken symbol).

So distributions end up crippling systems that they've stated that they
support? That is the side effect of your patch?

I welcome your resignation as maintainer of this driver - and at this
point I think that is the best course of action given everything that
has happened. Yes - you have now driven me to actively seek your
resignation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
