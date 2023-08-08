Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B7E77481B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjHHT0W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjHHTZ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:25:57 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE828098
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=omTutFJKGD7UzmjljwieTfFqYLS300Fx7i03sl6BDtM=; b=oztci1FPyJF9q/cffc7i5wEISZ
        pGthHnwqu4JDOEYqIpz8c25YWfTB5grBaHFle/uMppyRObT075pz207Ag6MjL8jnn3yJxN2jUUG6I
        0KWyXl0dTNkF999qVOe2LgfpNaoouQFJZrKsojU9y5KZfVQjLBwl+b5sJQEDd/hr++cVRMud900ZC
        7yWqhs9HOAU7Dp1ZIuoYgWdn9uBcx1BFq1f/HAfVqWw1Z2covLPpJgK4Bd+m046QuP8Gt30QzzM1L
        EfSG5dquMIAtdzUWroDt9+OZYVyF5CKu8QO9fA3mM01eF4icuqEp/LXFmpV1k7/mC9PSawDhZ3Nie
        3d+P5lUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50822)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qTIIF-0006ps-0q;
        Tue, 08 Aug 2023 09:42:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qTIIF-0007wK-9K; Tue, 08 Aug 2023 09:42:19 +0100
Date:   Tue, 8 Aug 2023 09:42:19 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <ZNH/6zlAxeXqTcAs@shell.armlinux.org.uk>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230808072605.n3rjfsxuogza7qth@pali>
 <ZNH8rM/EJQrEKsgo@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNH8rM/EJQrEKsgo@shell.armlinux.org.uk>
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

On Tue, Aug 08, 2023 at 09:28:28AM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 08, 2023 at 09:26:05AM +0200, Pali Rohár wrote:
> > On Friday 04 August 2023 12:35:13 Russell King (Oracle) wrote:
> > > Hi,
> > > 
> > > So it seems this patch got applied, but it wasn't Cc'd to
> > > linux-arm-kernel or anyone else, so those of us with platforms never
> > > had a chance to comment on it.
> > 
> > You have received more changes and fixes for last 2 years for these
> > issues and you have done **nothing**. You even not said anything.
> > So you are the last one who can complain here.
> 
> That's because I can't help - what I have *works*. I have *zero*
> issues with the PCI interfaces on Armada 388.
> 
> > You should have come up and start solving issues. And not complaining
> > now.
> 
> How can one solve issues when they're probably hardware related and
> one doesn't experience them?
> 
> Sorry, but no. If you feel as strongly as you do, walk away.

... and how dare you tell me what I should work on - you are *not* my
boss.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
