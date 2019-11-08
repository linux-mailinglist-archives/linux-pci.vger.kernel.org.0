Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D014F415E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 08:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKHHa3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Nov 2019 02:30:29 -0500
Received: from mx.socionext.com ([202.248.49.38]:10541 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfKHHa3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Nov 2019 02:30:29 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Nov 2019 16:30:27 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 95741180B84;
        Fri,  8 Nov 2019 16:30:27 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 8 Nov 2019 16:30:35 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 635E740364;
        Fri,  8 Nov 2019 16:30:27 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 27386121B00;
        Fri,  8 Nov 2019 16:30:27 +0900 (JST)
Date:   Fri, 08 Nov 2019 16:30:27 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 2/2] PCI: uniphier: Add checking whether PERST# is deasserted
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20191107124617.GA43905@e119886-lin.cambridge.arm.com>
References: <20191107205239.65C1.4A936039@socionext.com> <20191107124617.GA43905@e119886-lin.cambridge.arm.com>
Message-Id: <20191108163026.0DFB.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,
+CC Kishon

On Thu, 7 Nov 2019 12:46:17 +0000 <andrew.murray@arm.com> wrote:

> On Thu, Nov 07, 2019 at 08:52:39PM +0900, Kunihiko Hayashi wrote:
> > Hi Andrew,
> > Thank you for your comments.
> > 
> > On Thu, 7 Nov 2019 10:02:08 +0000 <andrew.murray@arm.com> wrote:
> > 
> > > On Thu, Nov 07, 2019 at 01:58:15PM +0900, Kunihiko Hayashi wrote:
> > > > When PERST# is asserted once, EP configuration will be initialized.
> > > 
> > > I don't quite understand this - does the EP/RC mode depend on how often
> > > PERST# is toggled?
> > 
> > I think of connecting this RC controller and EP based on `Linux PCI
> > endpoint framework' in another machine.
> > 
> > While this RC driver is probing, the EP driver might be also probing and
> > configurating itself using configfs. If PERST# is toggled after the EP
> > has done its configuration, this configuration will be lost.
> > 
> > I expect that the EP configurates after RC has toggled PERST#, however,
> > there is no way to synchronize both of them.
> > 
> 
> OK I understand where you are coming from now. Please ensure the commit
> message gives this rationale.

I'll explain about that in the commit message next.

> However, If I understand correctly, doesn't your solution only work some
> of the time? What happens if you boot both machines at the same time,
> and PERST# isn't asserted prior to the kernel booting?

I think it contains an annoying problem.

If PERST# isn't toggled prior to the kernel booting, PERST# remains asserted
and the RC driver can't access PCI bus.

As a result, this patch works and deasserts PERST# (and EP configuration will
be lost). So boot sequence needs to include deasserting PERST#.

> The only way you can ensure the EP is started after the RC is initialised
> is to start the EP after the RC is initialised.

Yes, it's the only soution for now.

> I'm not sure what the solution is here, but it feels like this approach
> only partially solves it.

Surely relying on outside of the driver doesn't seem to be a complete solution.

If there is the way that `Linux PCI endpoint framework' assumes,
I'd like to follow it, however, I can't find the other way.

Thank you,

---
Best Regards,
Kunihiko Hayashi


