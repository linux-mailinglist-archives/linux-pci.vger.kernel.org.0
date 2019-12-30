Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC412D08E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 15:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfL3OT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 09:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfL3OT6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Dec 2019 09:19:58 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79EBC20718;
        Mon, 30 Dec 2019 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577715597;
        bh=dd6+tGCT8NlO6Dd8N+gs4yzTMQKMExjtYDjH4i21Tvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hdWViqndKTgQwxb2ub7r+6S/ddxsjJ9/eIidx7On2Tg0zavkZbfj+0uLpgN5i3s/0
         KNEx92FFsYLLvrNyc1nx9vphqSaOSLCB8YjB15U5wwLmd/3OenY0ArAQKfnaTUlADM
         YV3XAeqvDBRWX7GrnWVt2ru9JVii3bBzEZQw4VUA=
Date:   Mon, 30 Dec 2019 08:19:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bjorn@helgaas.com, andrew.murray@arm.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        wangkefeng.wang@huawei.com, huawei.libin@huawei.com,
        guohanjun@huawei.com
Subject: Re: [PATCH v2] PCI: Add quirk for HiSilicon NP 5896 devices
Message-ID: <20191230141956.GA186256@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfd3ad93-7c17-abb2-b620-99df5c984fd4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 30, 2019 at 04:11:50PM +0800, Xiongfeng Wang wrote:
> Hi, Bjorn
> 
> On 2019/12/18 22:28, Bjorn Helgaas wrote:
> > On Wed, Dec 18, 2019 at 05:16:03PM +0800, Xiongfeng Wang wrote:
> >> On 2019/12/11 12:10, Bjorn Helgaas wrote:
> >>> On Tue, Dec 10, 2019 at 9:28 PM Xiongfeng Wang
> >>> <wangxiongfeng2@huawei.com> wrote:
> >>>> On 2019/12/7 2:10, Bjorn Helgaas wrote:
> >>>>> On Fri, Dec 06, 2019 at 03:01:45PM +0800, Xiongfeng Wang wrote:
> >>>>>> HiSilicon PCI Network Processor 5896 devices misreport the
> >>>>>> class type as 'NOT_DEFINED', but it is actually a network
> >>>>>> device. Also the size of BAR3 is reported as 265T, but this BAR
> >>>>>> is actually unused.  This patch modify the class type to
> >>>>>> 'CLASS_NETWORK' and disable the unused BAR3.
> > 
> >>>>> The question is not whether the BAR is used by the driver; the
> >>>>> question is whether the device responds to accesses to the
> >>>>> region described by the BAR when PCI_COMMAND_MEMORY is turned
> >>>>> on.
> >>>>
> >>>> I asked the hardware engineer. He said I can not write an address
> >>>> into that BAR.
> >>>
> >>> If the BAR is not writable, I think sizing should fail, so I
> >>> suspect some of the bits are actually writable.
> >>
> >> Sorry for the delayed response. It's not so convenient for me to get
> >> to the hardware guys.  BAR0 BAR1 BAR2 are 32-bit and can be used to
> >> access the registers and memory within 5896 devices. These three
> >> BARs can meet the need for most scenario.  BAR3 is 64-bit and can be
> >> used to access all the registers and memory within 5896 devices.
> >> (BAR3 is writable. Sorry for the non-confirmed information before.)
> >> But BAR3 is not used by the driver and the size is very
> >> large（larger than 100G, still didn't get the precise size）.  So I
> >> think maybe we can disable this BAR for now, otherwise the
> >> unassigned resource will cause 'pci_enable_device()' returning
> >> failure.
> > 
> > Here's the problem: the proposed patch (below) clears the struct
> > resource corresponding to BAR 3, but that doesn't actually disable the
> > BAR.  It hides the BAR from Linux, so Linux will pretend it doesn't
> > exist, but it's still there in the hardware.
> > 
> > The hardware BAR 3 still contains some value (possibly zero), and if
> > PCI_COMMAND_MEMORY is set (which you need to do if you want to use
> > *any* memory BARs on the device), the device will respond to any
> > transactions in the BAR 3 range.  Depending on the topology and all
> > the other BAR and window assignments, this may cause address
> > conflicts.
> 
> I have checked with the hardware engineer. He said the transactions
> have some bits to indicate whether the address is 32-bit or 64-bit.
> The device will respond only when the 64-bit address transactions is
> in the BAR3 range.
> 
> So I think, if I clear the resource corresponding to BAR3, the
> 64-bit window of the downport is empty. There will be no 64-bit
> address transaction sent to the device.

Sorry to repeat myself, but your patch only clears the struct
resource, which is in memory.  It doesn't touch the BAR (the hardware
register in the device) at all.  It does not disable the BAR.  It does
not guarantee that the memory windows of the Downstream Port leading
to the device will be disabled.  It does not prevent upper level
software from generating transactions that will match BAR 3.

> > + * HiSilicon NP 5896 devices BAR3 size is reported as 256T and causes problem
> > + * when assigning the resources. But this BAR is actually unused by the driver,
> > + * so let's disable it.
> > + */
> > +static void quirk_hisi_fixup_np_bar(struct pci_dev *pdev)
> > +{
> > +       struct resource *r = &pdev->resource[3];
> > +
> > +       r->start = 0;
> > +       r->end = 0;
> > +       r->flags = 0;
> > +
> > +       pci_info(pdev, "Disabling invalid BAR 3\n");
> > 
> > .
> > 
> 
