Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7087F4393A2
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 12:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhJYK1m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 06:27:42 -0400
Received: from foss.arm.com ([217.140.110.172]:43906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232740AbhJYK1m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 06:27:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A35EFD6E;
        Mon, 25 Oct 2021 03:25:19 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3903F3F70D;
        Mon, 25 Oct 2021 03:25:18 -0700 (PDT)
Date:   Mon, 25 Oct 2021 11:25:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 05/11] PCI: kirin: give more time for PERST# reset to
 finish
Message-ID: <20211025102511.GA10529@lpieralisi>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
 <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
 <20211022151624.mgsgobjsjgyevnyt@pali>
 <20211023103059.6add00e6@sal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211023103059.6add00e6@sal.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 23, 2021 at 10:30:59AM +0100, Mauro Carvalho Chehab wrote:
> Hi Pali,
> 
> Em Fri, 22 Oct 2021 17:16:24 +0200
> Pali Rohár <pali@kernel.org> escreveu:
> 
> > On Tuesday 19 October 2021 07:06:42 Mauro Carvalho Chehab wrote:
> > > Before code refactor, the PERST# signals were sent at the
> > > end of the power_on logic. Then, the PCI core would probe for
> > > the buses and add them.
> > > 
> > > The new logic changed it to send PERST# signals during
> > > add_bus operation. That altered the timings.
> > > 
> > > Also, HiKey 970 require a little more waiting time for
> > > the PCI bridge - which is outside the SoC - to finish
> > > the PERST# reset, and then initialize the eye diagram.  
> > 
> > Hello! Which PCIe port do you mean by PCI bridge device? Do you mean
> > PCIe Root Port? Or upstream port on some external PCIe switch connected
> > via PCIe bus to the PCIe Root Port? Because all of these (virtual) PCIe
> > devices are presented as PCI bridge devices, so it is not clear to which
> > device it refers.
> 
> HiKey 970 uses an external PCI bridge chipset (a Broadcom PEX 8606[1]),
> with 3 elements connected to the bus: an Ethernet card, a M.2 slot and
> a mini PCIe slot. It seems HiKey 970 is unique with regards to PERST# signal,
> as there are 4 independent PERST# signals there:
> 
> 	- one for PEX 8606 (the PCIe root port);
> 	- one for Ethernet;
> 	- one for M.2;
> 	- one for mini-PCIe.
> 
> After sending the PCIe PERST# signals, the device has to wait for 21 ms
> before adjusting the eye diagram.
> 
> [1] https://docs.broadcom.com/docs/PEX_8606_AIC_RDK_HRM_v1.3_06Aug10.pdf
> 
> > Normally PERST# signal is used to reset endpoint card, other end of PCIe
> > link and so PERST# signal should not affect PCIe Root Port at all.
> 
> That's not the case, as PEX 8606 needs to complete its reset sequence
> for the rest of the devices to be visible. If the wait time is reduced
> or removed, the devices behind it won't be detected.

These pieces of information should go into the commit log (or I can add
a Link: tag to this discussion) - it is fundamental to understand these
changes.

I believe we can merge this series but we have to document this
discussion appropriately.

Lorenzo
