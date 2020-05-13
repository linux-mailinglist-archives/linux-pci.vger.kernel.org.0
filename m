Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E0E1D1212
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 13:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbgEML7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 07:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbgEML7n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 07:59:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C63B206CC;
        Wed, 13 May 2020 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589371182;
        bh=emjIeu5JHVXvz7EYNp2+SaFasQsTnpCGqjEd+kJZQDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KGupt8pPaud4SWH2sdRuISm1I4BLcdf07N1MndA7qMR/M7PCWlChiOh/FtQohh4hg
         PNstr1A8KkwC01KCERq+7Ju7DpB0uMpe7++J6NOtYtBWYwfGBIGCCYhSQl1mygIgOW
         V4LQaS9tqt4fJQ5RSHaM+Hrj6e3MsCaQTOClr6fc=
Received: by pali.im (Postfix)
        id A80FF774; Wed, 13 May 2020 13:59:40 +0200 (CEST)
Date:   Wed, 13 May 2020 13:59:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     thomas.petazzoni@bootlin.com, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 00/12] PCI: aardvark: Fix support for Turris MOX and
 Compex wifi cards
Message-ID: <20200513115940.fiemtnxfqcyqo6ik@pali>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200513111651.q62dqauatryh6xd6@pali>
 <20200513113314.GB32365@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200513113314.GB32365@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 13 May 2020 12:33:14 Lorenzo Pieralisi wrote:
> On Wed, May 13, 2020 at 01:16:51PM +0200, Pali Rohár wrote:
> > On Thursday 30 April 2020 10:06:13 Pali Rohár wrote:
> > > Hello,
> > > 
> > > this is the fourth version of the patch series for Armada 3720 PCIe
> > > controller (aardvark). It's main purpose is to fix some bugs regarding
> > > buggy ath10k cards, but we also found out some suspicious stuff about
> > > the driver and the SOC itself, which we try to address.
> > > 
> > > Patches are available also in my git branch pci-aardvark:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-aardvark
> > 
> > Hello! Thanks everybody for review and testing of this patch series.
> > 
> > I would like to ask, is there something needed to fix / modify in this
> > patch series? If everything is OK, would you Bjorn or Lorenzo take this
> > patch series into your tree?
> 
> We need Thomas' ACK on the series. We don't have this HW and
> we comment on the generic code, Thomas owns it and must check that
> what you are changing is sound.

Ok, we will wait for Thomas ACK/review.

> On patch 5 I share Rob's concerns - it does not make much sense
> to have something driver specific there, need to look further.

I fully understand yours concerns. I wanted to solve it. Problem is that
I really do not know which timeout is there applicable. I read
information about PERST# more times but I was not able to clearly deduce
that minimal timeout/delay needed for this reset scenario.

So what I was able to do are just experiments. I found out what is the
minimal needed time to correctly initialize wifi cars which I used for
testing.

You can look into my previous email [1] where I wrote which timeouts are
used by which drivers. Basically every driver is using its own custom
timeout and this is something which should be fixed / improved. In my
opinion authors tested their own (wifi) cards and measured minimal
timeout needed for initializing them.

So somebody with deeper PCI knowledge should look at this PERST# problem
and try to address it.

After it happens I see there two scenarios:

1) Timeout according to specification/authority is lower than what we
currently use. In this case it would mean that we have buggy wifi cards
(and we already know that people reported issues with Compex cards) and
we would have to stay with higher timeout. Probably we can define common
macro with timeout value and use it.

2) Timeout according to specification/authority is bigger then what we
currently use. In this case there is no problem to increase it, card
would be just longer in reset state. What could be problematic for
somebody is that this increase boot / initialization time.

[1] - https://lore.kernel.org/linux-pci/20200424092546.25p3hdtkehohe3xw@pali/
