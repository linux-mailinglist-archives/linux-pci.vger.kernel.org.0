Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F6A774844
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbjHHTaC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjHHT3s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:29:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B52127568
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 12:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D66E62AB5
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 19:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26B9C433C9;
        Tue,  8 Aug 2023 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691521573;
        bh=8S1xEjxPxCZE2Eq9dmX2B325fLGIgjNUDHsBaNzfPRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dg9LQCT9LBA393toHc759kXULDNeseZLmTpsejOqT03E9TYOlganuAkG1J2hHm/9i
         vYe5zENzmckIrcFENoG1OxUAxNt2T0pNh3nhxn73HKbIC/e9ePSmhlNmcoJo7ubcbS
         3g7KXGs+ztb3UPqozO1y+5QEMUZdKu07IRy83Hd+tqUTrMGOxNNOaGz/AmShsDhpr8
         XjQG/NqzNi30Rejlaw4pAg2lr6CJ5wJv0auAdhUiqOpz15AspU+wG89Gd1nsH+mQa4
         vLDHcg9UtL731WMctFXvvToS+4OPes+4LHmu8BkpwjV9GY9IdXe0JD25Tw/7vaxRBT
         euUwNLEacYwjQ==
Received: by pali.im (Postfix)
        id E9F7C687; Tue,  8 Aug 2023 21:06:09 +0200 (CEST)
Date:   Tue, 8 Aug 2023 21:06:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808190609.d7sbfklwlfo522lp@pali>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230808072605.n3rjfsxuogza7qth@pali>
 <ZNH8rM/EJQrEKsgo@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNH8rM/EJQrEKsgo@shell.armlinux.org.uk>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 08 August 2023 09:28:28 Russell King (Oracle) wrote:
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

Perfect, apply your patch on your kernel setup and stop complaining
here. Nobody is interested for one Russel's user setup.

> > You should have come up and start solving issues. And not complaining
> > now.
> 
> How can one solve issues when they're probably hardware related and
> one doesn't experience them?
> 
> Sorry, but no.

Ok, if you do not want, that we have nothing to discuss here, and your
patch should be rejected.

> If you feel as strongly as you do, walk away.

What? You should go away and never return. Nobody is interested for one
nobody Russel user. Thanks.

And if you not agree with me, then go ahead and send a patch to remove
my maintainer line from this driver and explain to all people that you
are best one user on the world and that everybody should do what you
wrote.
