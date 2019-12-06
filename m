Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27400114DD2
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 09:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfLFI6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 03:58:17 -0500
Received: from mx.socionext.com ([202.248.49.38]:51748 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfLFI6R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Dec 2019 03:58:17 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 06 Dec 2019 17:58:14 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 1E951603AB;
        Fri,  6 Dec 2019 17:58:15 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 6 Dec 2019 17:58:42 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 853AD4037A;
        Fri,  6 Dec 2019 17:58:14 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 57E4B120456;
        Fri,  6 Dec 2019 17:58:14 +0900 (JST)
Date:   Fri, 06 Dec 2019 17:58:14 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/2] PCI: uniphier: Add checking whether PERST# is deasserted
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <c40da2f3-ea5d-b1fc-0190-f90f031eef4c@ti.com>
References: <20191204190547.333C.4A936039@socionext.com> <c40da2f3-ea5d-b1fc-0190-f90f031eef4c@ti.com>
Message-Id: <20191206175813.E6B2.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Fri, 6 Dec 2019 12:28:29 +0530 <kishon@ti.com> wrote:

> Hi,
> 
> On 04/12/19 3:35 pm, Kunihiko Hayashi wrote:
> > On Fri, 22 Nov 2019 20:53:16 +0900 <hayashi.kunihiko@socionext.com> wrote:
> > >> Hello Lorenzo,
> >>
> >> On Thu, 21 Nov 2019 16:47:05 +0000 <lorenzo.pieralisi@arm.com> wrote:
> >>
> >>> On Fri, Nov 08, 2019 at 04:30:27PM +0900, Kunihiko Hayashi wrote:
> >>>>> However, If I understand correctly, doesn't your solution only work some
> >>>>> of the time? What happens if you boot both machines at the same time,
> >>>>> and PERST# isn't asserted prior to the kernel booting?
> >>>>
> >>>> I think it contains an annoying problem.
> >>>>
> >>>> If PERST# isn't toggled prior to the kernel booting, PERST# remains asserted
> >>>> and the RC driver can't access PCI bus.
> >>>>
> >>>> As a result, this patch works and deasserts PERST# (and EP configuration will
> >>>> be lost). So boot sequence needs to include deasserting PERST#.
> >>>
> >>> I am sorry but I have lost you. Can you explain to us why checking
> >>> that PERST# is deasserted guarantees you that:
> >>>
> >>> - The EP has bootstrapped
> >>> - It is safe not to toggle it again (and also skip
> >>>    uniphier_pcie_ltssm_enable())
> >>>
> >>> Please provide details of the HW configuration so that we understand
> >>> what's actually supposed to happen and why this patch fixes the
> >>> issue you are facing.
> >>
> >> I tried to connect between the following boards, and do pci-epf-test:
> >>   - "RC board": UniPhier ld20 board that has DWC RC controller
> >>   - "EP board": UniPhier legacy board that has DWC EP controller
> >>
> >> This EP has power-on-state configuration, but it's necessary to set
> >> class ID, BAR sizes, etc. after starting up.
> >>
> >> In case of that starting up RC board before EP board, the RC driver
> >> can't establish link. So we need to boot EP board first.
> > > At that point, I've considered why RC can't establish link,
> > and found that the waitng time was too short.
> > > - EP/RC: power on both boards
> > > - RC: start up the kernel on RC board
> > > - RC: wait for link up (long time enough)
> > > - EP: start up the kernel on EP board
> > > - EP: configurate pci-epf-test
> > > When the endpoint  configuration is done and the EP driver enables LTSSM,
> > the RC driver will quit from waiting for link up.
> > > Currently DWC RC driver calls dwc_pcie_wait_for_link(), however,
> > the function tries to link up 10 times only, that is defined
> > as LINK_WAIT_MAX_RETRIES in pcie-designware.h, it's too short
> > to configurate the endpoint.
> > > Now the patch to bypass PERST# is not necessary.
> > > Instead for DWC RC drivers, I think that the number of retries
> > should be changed according to the usage.
> > And the same issue remains with other RC drivers.
> 
> If EP is configured using Linux, then PERST# cannot be used as it's difficult to boot linux and initialize EP within the specified time interval. Can't you prevent PERST from being propagated at all?

Surely it might be difficult for RC to decide the time to wait for EP.
Since RC almost toggles PERST# in boot time, I'd like to think about
how to prevent from first PERST# at least.

Thank you,

---
Best Regards,
Kunihiko Hayashi

