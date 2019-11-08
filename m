Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE3F440B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 10:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfKHJ7S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Nov 2019 04:59:18 -0500
Received: from foss.arm.com ([217.140.110.172]:39712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbfKHJ7R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Nov 2019 04:59:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C544531B;
        Fri,  8 Nov 2019 01:59:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AC3D3F719;
        Fri,  8 Nov 2019 01:59:15 -0800 (PST)
Date:   Fri, 8 Nov 2019 09:59:14 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/2] PCI: uniphier: Add checking whether PERST# is
 deasserted
Message-ID: <20191108095913.GD43905@e119886-lin.cambridge.arm.com>
References: <20191107205239.65C1.4A936039@socionext.com>
 <20191107124617.GA43905@e119886-lin.cambridge.arm.com>
 <20191108163026.0DFB.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108163026.0DFB.4A936039@socionext.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 08, 2019 at 04:30:27PM +0900, Kunihiko Hayashi wrote:
> Hi Andrew,
> +CC Kishon
> 
> On Thu, 7 Nov 2019 12:46:17 +0000 <andrew.murray@arm.com> wrote:
> 
> > On Thu, Nov 07, 2019 at 08:52:39PM +0900, Kunihiko Hayashi wrote:
> > > Hi Andrew,
> > > Thank you for your comments.
> > > 
> > > On Thu, 7 Nov 2019 10:02:08 +0000 <andrew.murray@arm.com> wrote:
> > > 
> > > > On Thu, Nov 07, 2019 at 01:58:15PM +0900, Kunihiko Hayashi wrote:
> > > > > When PERST# is asserted once, EP configuration will be initialized.
> > > > 
> > > > I don't quite understand this - does the EP/RC mode depend on how often
> > > > PERST# is toggled?
> > > 
> > > I think of connecting this RC controller and EP based on `Linux PCI
> > > endpoint framework' in another machine.
> > > 
> > > While this RC driver is probing, the EP driver might be also probing and
> > > configurating itself using configfs. If PERST# is toggled after the EP
> > > has done its configuration, this configuration will be lost.
> > > 
> > > I expect that the EP configurates after RC has toggled PERST#, however,
> > > there is no way to synchronize both of them.
> > > 
> > 
> > OK I understand where you are coming from now. Please ensure the commit
> > message gives this rationale.
> 
> I'll explain about that in the commit message next.
> 
> > However, If I understand correctly, doesn't your solution only work some
> > of the time? What happens if you boot both machines at the same time,
> > and PERST# isn't asserted prior to the kernel booting?
> 
> I think it contains an annoying problem.
> 
> If PERST# isn't toggled prior to the kernel booting, PERST# remains asserted
> and the RC driver can't access PCI bus.
> 
> As a result, this patch works and deasserts PERST# (and EP configuration will
> be lost). So boot sequence needs to include deasserting PERST#.
> 
> > The only way you can ensure the EP is started after the RC is initialised
> > is to start the EP after the RC is initialised.
> 
> Yes, it's the only soution for now.
> 
> > I'm not sure what the solution is here, but it feels like this approach
> > only partially solves it.
> 
> Surely relying on outside of the driver doesn't seem to be a complete solution.
> 
> If there is the way that `Linux PCI endpoint framework' assumes,
> I'd like to follow it, however, I can't find the other way.

Indeed, this must be a common problem - many host controller drivers in the
tree toggle perst on start up.

Keen for any feedback from Kishon on this.

Thanks,

Andrew Murray

> 
> Thank you,
> 
> ---
> Best Regards,
> Kunihiko Hayashi
> 
> 
