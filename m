Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C819859447
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 08:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfF1GiZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 02:38:25 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:10751 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726648AbfF1GiZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jun 2019 02:38:25 -0400
X-UUID: da96804691c5402e872980591e3bd802-20190628
X-UUID: da96804691c5402e872980591e3bd802-20190628
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 937936099; Fri, 28 Jun 2019 14:38:10 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Jun
 2019 14:38:06 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Jun 2019 14:38:06 +0800
Message-ID: <1561703886.21133.14.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Ryder Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BA=9A=E8=AB=BA=29?= 
        <Ryder.Lee@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?= 
        <youlin.pei@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Honghui Zhang =?UTF-8?Q?=28=E5=BC=A0=E6=B4=AA=E8=BE=89=29?= 
        <Honghui.Zhang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, <jianjun.wang@mediatek.com>
Date:   Fri, 28 Jun 2019 14:38:06 +0800
In-Reply-To: <20190219150352.GA21833@e107981-ln.cambridge.arm.com>
References: <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
         <20181213145517.GB4701@google.com> <1545034779.8528.8.camel@mhfsdcap03>
         <20181217143247.GK20725@google.com>
         <20181217154645.GA24864@e107981-ln.cambridge.arm.com>
         <1545124764.25199.3.camel@mhfsdcap03> <20181220182043.GC183878@google.com>
         <1545651628.5634.57.camel@mhfsdcap03>
         <20190123154023.GA1157@e107981-ln.cambridge.arm.com>
         <1550559699.29794.2.camel@mhfsdcap03>
         <20190219150352.GA21833@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 226F04D099627E20AD2AD93D5DC115D1142A2FAD96C8240667F1D37A93E3DA682000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2019-02-19 at 23:03 +0800, Lorenzo Pieralisi wrote:
> On Tue, Feb 19, 2019 at 03:01:39PM +0800, Jianjun Wang wrote:
> > On Wed, 2019-01-23 at 15:40 +0000, Lorenzo Pieralisi wrote:
> > > On Mon, Dec 24, 2018 at 07:40:28PM +0800, Jianjun Wang wrote:
> > > > On Thu, 2018-12-20 at 12:20 -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Dec 18, 2018 at 05:19:24PM +0800, Jianjun Wang wrote:
> > > > > > On Mon, 2018-12-17 at 15:46 +0000, Lorenzo Pieralisi wrote:
> > > > > > > On Mon, Dec 17, 2018 at 08:32:47AM -0600, Bjorn Helgaas wrote:
> > > > > > > > On Mon, Dec 17, 2018 at 04:19:39PM +0800, Jianjun Wang wrote:
> > > > > > > > > On Thu, 2018-12-13 at 08:55 -0600, Bjorn Helgaas wrote:
> > > > > > > > > > On Thu, Dec 06, 2018 at 09:09:13AM +0800, Jianjun Wang wrote:
> > > > > > > > > > > The read value of BAR0 is 0xffff_ffff, it's size will be
> > > > > > > > > > > calculated as 4GB in arm64 but bogus alignment values at
> > > > > > > > > > > arm32, the pcie device and devices behind this bridge will
> > > > > > > > > > > not be enabled. Fix it's BAR0 resource size to guarantee
> > > > > > > > > > > the pcie devices will be enabled correctly.
> > > > > > > > > > 
> > > > > > > > > > So this is a hardware erratum?  Per spec, a memory BAR has
> > > > > > > > > > bit 0 hardwired to 0, and an IO BAR has bit 1 hardwired to
> > > > > > > > > > 0.
> > > > > > > > > 
> > > > > > > > > Yes, it only works properly on 64bit platform.
> > > > > > > > 
> > > > > > > > I don't understand.  BARs are supposed to work the same
> > > > > > > > regardless of whether it's a 32- or 64-bit platform.  If this is
> > > > > > > > a workaround for a hardware defect, please just say that
> > > > > > > > explicitly.
> > > > > > > 
> > > > > > > I do not understand this either. First thing to do is to describe
> > > > > > > the problem properly so that we can actually find a solution to
> > > > > > > it.
> > > > > > 
> > > > > > This BAR0 is a 64-bit memory BAR, the HW default values for this BAR
> > > > > > is 0xffff_ffff_0000_0000 and it could not be changed except by
> > > > > > config write operation.
> > > > > 
> > > > > If you literally get 0xffff_ffff_0000_0000 when reading the BAR, that
> > > > > is out of spec because the low-order 4 bits of a 64-bit memory BAR
> > > > > cannot all be zero.
> > > > > 
> > > > > A 64-bit BAR consumes two DWORDS in config space.  For a 64-bit BAR0,
> > > > > the DWORD at 0x10 contains the low-order bits, and the DWORD at 0x14
> > > > > contains the upper 32 bits.  Bits 0-3 of the low-order DWORD (the
> > > > > one at 0x10) are read-only, and in this case should contain the value
> > > > > 0b1100 (0xc).  That means the range is prefetchable (bit 3 == 1) and
> > > > > the BAR is 64 bits (bits 2:1 == 10).
> > > > 
> > > > Sorry, I have confused the HW default value and the read value of BAR
> > > > size. The hardware default value is 0xffff_ffff_0000_000c, it's a 64-bit
> > > > BAR with prefetchable range.
> > > > 
> > > > When we start to decoding the BAR, the read value of BAR0 at 0x10 is
> > > > 0x0c, and the value at 0x14 is 0xffff_ffff, so the read value of BAR
> > > > size is 0xffff_ffff_0000_0000, which will be decoded to 0xffff_ffff, and
> > > > it will be set to the end value of BAR0 resource in the pci_dev.
> > > > > 
> > > > > > The calculated BAR size will be 0 in 32-bit platform since the
> > > > > > phys_addr_t is a 32bit value in 32-bit platform.
> > > > > 
> > > > > Either (1) this is a hardware defect that feeds incorrect data to the
> > > > > BAR size calculation, or (2) there's a problem in the BAR size
> > > > > calculation code.  We need to figure out which one and work around or
> > > > > fix it correctly.
> > > > 
> > > > The BAR size is calculated by the code (res->end - res->start + 1) is
> > > > fine, I think it's a hardware defect because that we can not change the
> > > > hardware default value or just disable it since we don't using it.
> > > 
> > > Apologies for the delay in getting back to this.
> > > 
> > > This looks like a kernel defect, not a HW defect.
> > > 
> > > I need some time to make up my mind on what the right fix for this
> > > but it is most certainly not this patch.
> > > 
> > > Lorenzo
> > 
> > Hi Lorenzo,
> > 
> > Is there any better idea about this patch?
> 
> Hi,
> 
> I did not have time to investigate the issue in core code that triggers
> this defect but this patch is not the solution to the problem it is a
> plaster that papers over it, I won't merge it.
> 
> I would appreciate some help. If you could have a look at core code that
> triggers the failure we can analyze what should be done to make it work,
> I do not think it is a defect in your IP.
> 
> Lorenzo

Hi Lorenzo,

This BAR size issue has been fixed by commit
"01b37f851ca150554496fd6e79c6d9a67992a2c0
PCI: Make pci_size() return real BAR size"

So there is no need to add the fixup method, I will remove it in next
version.

Thanks.


