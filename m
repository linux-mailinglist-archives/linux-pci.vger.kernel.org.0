Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A8A1071BD
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfKVLxT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 06:53:19 -0500
Received: from mx.socionext.com ([202.248.49.38]:4815 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfKVLxT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Nov 2019 06:53:19 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Nov 2019 20:53:16 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id F1575603AB;
        Fri, 22 Nov 2019 20:53:16 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 22 Nov 2019 20:53:34 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id B562B4031E;
        Fri, 22 Nov 2019 20:53:16 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 88DF0120456;
        Fri, 22 Nov 2019 20:53:16 +0900 (JST)
Date:   Fri, 22 Nov 2019 20:53:16 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] PCI: uniphier: Add checking whether PERST# is deasserted
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20191121164705.GA14229@e121166-lin.cambridge.arm.com>
References: <20191108163026.0DFB.4A936039@socionext.com> <20191121164705.GA14229@e121166-lin.cambridge.arm.com>
Message-Id: <20191122205316.297B.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo,

On Thu, 21 Nov 2019 16:47:05 +0000 <lorenzo.pieralisi@arm.com> wrote:

> On Fri, Nov 08, 2019 at 04:30:27PM +0900, Kunihiko Hayashi wrote:
> > > However, If I understand correctly, doesn't your solution only work some
> > > of the time? What happens if you boot both machines at the same time,
> > > and PERST# isn't asserted prior to the kernel booting?
> > 
> > I think it contains an annoying problem.
> > 
> > If PERST# isn't toggled prior to the kernel booting, PERST# remains asserted
> > and the RC driver can't access PCI bus.
> > 
> > As a result, this patch works and deasserts PERST# (and EP configuration will
> > be lost). So boot sequence needs to include deasserting PERST#.
> 
> I am sorry but I have lost you. Can you explain to us why checking
> that PERST# is deasserted guarantees you that:
> 
> - The EP has bootstrapped
> - It is safe not to toggle it again (and also skip
>   uniphier_pcie_ltssm_enable())
> 
> Please provide details of the HW configuration so that we understand
> what's actually supposed to happen and why this patch fixes the
> issue you are facing.

I tried to connect between the following boards, and do pci-epf-test:
 - "RC board": UniPhier ld20 board that has DWC RC controller
 - "EP board": UniPhier legacy board that has DWC EP controller

This EP has power-on-state configuration, but it's necessary to set
class ID, BAR sizes, etc. after starting up.

In case of that starting up RC board before EP board, the RC driver
can't establish link. So we need to boot EP board first.

 - EP/RC: power on both boards

 - EP: start up the kernel on EP board

 - EP: according to the following guide, configurate pci-epf-test
      https://www.kernel.org/doc/html/latest/PCI/endpoint/pci-test-howto.html

 - RC: start up the kernel on RC board

At that time, because RC driver toggled PERST#, the EP configuration
values are initialized to the power on state. After that, RC can't
access EP collectly.

I think there is a following solution:

 - EP/RC: power on both boards

 - RC: [deassert PERST# by boot firmware]

 - EP: start up the kernel on EP board

 - EP: configurate pci-epf-test

 - RC: start up the kernel on RC board [without toggling PERST# by this patch]

Deasserting PERST# before EP configuration avoids the issue, however,
this relies on boot firmware, so I think this isn't enough to solve
the issue.

Thank you,

---
Best Regards,
Kunihiko Hayashi

