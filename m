Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FD6774CDC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 23:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjHHVUH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 17:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbjHHVTz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 17:19:55 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525DE93E8
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5dZLbm5Rli6MEFhiPPpRrh69sgXJDsI+XE+070W2AII=; b=ByV3MQ9SAHplBux+RJ82xsCd4s
        CQXJHSCYe5sPj5jLJx1jQUMsPUQ48GJi91cfXtKIESevDnguwJVz8JD2Lf8olm4GU1Dc+0xbCHZVT
        /MnxKiofyObfXl58mg503ZkSO/OORwnrDxxHbN4YAOi6V6qzNpe7q89bStvf6d9kTdwqH/mNDJ7J8
        awnurFTS81VBHIBlblnCTTBKp6c4g8BxvFG3ltuNVogNdS4yRybKGDq7NErvC0dMst4UjuxXwexLa
        abWZE0c2qlBIuz3xHzDviBTbma2Xe5ULWYxLO9FlifdJJWMQxoLioFgutS9oeDKuMCvhDXDvbZFQZ
        YdpfuqsA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39384)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qTSOp-0001dq-2X;
        Tue, 08 Aug 2023 20:29:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qTSOp-0008OU-Q1; Tue, 08 Aug 2023 20:29:47 +0100
Date:   Tue, 8 Aug 2023 20:29:47 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <ZNKXq0dhJTRfYLS1@shell.armlinux.org.uk>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230808072605.n3rjfsxuogza7qth@pali>
 <ZNH8rM/EJQrEKsgo@shell.armlinux.org.uk>
 <20230808190609.d7sbfklwlfo522lp@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808190609.d7sbfklwlfo522lp@pali>
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

On Tue, Aug 08, 2023 at 09:06:09PM +0200, Pali Rohár wrote:
> On Tuesday 08 August 2023 09:28:28 Russell King (Oracle) wrote:
> > On Tue, Aug 08, 2023 at 09:26:05AM +0200, Pali Rohár wrote:
> > > On Friday 04 August 2023 12:35:13 Russell King (Oracle) wrote:
> > > > Hi,
> > > > 
> > > > So it seems this patch got applied, but it wasn't Cc'd to
> > > > linux-arm-kernel or anyone else, so those of us with platforms never
> > > > had a chance to comment on it.
> > > 
> > > You have received more changes and fixes for last 2 years for these
> > > issues and you have done **nothing**. You even not said anything.
> > > So you are the last one who can complain here.
> > 
> > That's because I can't help - what I have *works*. I have *zero*
> > issues with the PCI interfaces on Armada 388.
> 
> Perfect, apply your patch on your kernel setup and stop complaining
> here. Nobody is interested for one Russel's user setup.

What the fuck?

What patch? I'm not proposing a patch. What I am asking for is the
damage that you have caused (by making the driver depend on BROKEN
because you don't want to support it anymore) be reverted so that
those of us for whom IT IS WORKING can continue to use the driver.

> > > You should have come up and start solving issues. And not complaining
> > > now.
> > 
> > How can one solve issues when they're probably hardware related and
> > one doesn't experience them?
> > 
> > Sorry, but no.
> 
> Ok, if you do not want, that we have nothing to discuss here, and your
> patch should be rejected.

What patch? You are making this crap up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
