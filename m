Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1752A21B217
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 11:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGJJSI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 05:18:08 -0400
Received: from foss.arm.com ([217.140.110.172]:33802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgGJJSI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 05:18:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8DDC31B;
        Fri, 10 Jul 2020 02:18:07 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E09B3F68F;
        Fri, 10 Jul 2020 02:18:06 -0700 (PDT)
Date:   Fri, 10 Jul 2020 10:18:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200710091800.GA3419@e121166-lin.cambridge.arm.com>
References: <20200528143141.29956-1-pali@kernel.org>
 <20200702083036.12230-1-pali@kernel.org>
 <20200709113509.GB19638@e121166-lin.cambridge.arm.com>
 <20200709122208.rmfeuu6zgbwh3fr5@pali>
 <20200709144701.GA21760@e121166-lin.cambridge.arm.com>
 <20200709150959.wq6zfkcy4m6hvvpl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200709150959.wq6zfkcy4m6hvvpl@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 09, 2020 at 05:09:59PM +0200, Pali Roh�r wrote:

[...]

> > I understand that but the bridge bus resource can be trimmed to just
> > contain the root bus because that's the only one where there is a
> > chance you can enumerate a device.
> 
> It is possible to register only root bridge without endpoint?

It is possible to register the root bridge with a trimmed IORESOURCE_BUS
so that you don't enumerate anything other than the root port.

> > I would like to get Bjorn's opinion on this, I don't like these "link is
> > up" checks in config accessors (they are racy and honestly it is a
> > run-time check that does not make much sense, either it is always
> > true/false or it is inevitably racy)
> 
> It is runtime check, but does not have to be always true/false. I have
> tested more Compex wifi cards and under certain conditions they
> "disappear" from the bus during usage.

I would be very grateful if you could describe what happens in HW
when these conditions trigger - I would like to understand if this
issue is aardvark specific or it isn't.

> So I think it still make sense to do this "fast" check as it is only
> optimization.

I will merge this patch but I'd also like to understand the underlying
issue better.

Thanks,
Lorenzo
