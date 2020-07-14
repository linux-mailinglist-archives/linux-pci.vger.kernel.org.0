Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B15B21F5D4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgGNPI1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 11:08:27 -0400
Received: from foss.arm.com ([217.140.110.172]:38354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNPI0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 11:08:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFDDC30E;
        Tue, 14 Jul 2020 08:08:25 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FD5B3F792;
        Tue, 14 Jul 2020 08:08:24 -0700 (PDT)
Date:   Tue, 14 Jul 2020 16:08:22 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v2] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for
 bridge_class_quirk()
Message-ID: <20200714150822.GB14416@e121166-lin.cambridge.arm.com>
References: <1591925417-27665-1-git-send-email-yangtiezhu@loongson.cn>
 <43b4409d-ff0f-9711-0b8f-1cfb19d31f24@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43b4409d-ff0f-9711-0b8f-1cfb19d31f24@loongson.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 14, 2020 at 03:37:51PM +0800, Tiezhu Yang wrote:
> On 06/12/2020 09:30 AM, Tiezhu Yang wrote:
> > Use DECLARE_PCI_FIXUP_EARLY instead of DECLARE_PCI_FIXUP_HEADER
> > for bridge_class_quirk() in pci-loongson.c, otherwise the fixup
> > has no effect.
> > 
> > Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> > 
> > v2:
> >    - modify the patch subject used with lower case "loongson"
> > 
> > This patch is based on mips-next tree.
> > 
> >   drivers/pci/controller/pci-loongson.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > index 459009c..58b862a 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -37,11 +37,11 @@ static void bridge_class_quirk(struct pci_dev *dev)
> >   {
> >   	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> >   }
> > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >   			DEV_PCIE_PORT_0, bridge_class_quirk);
> > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >   			DEV_PCIE_PORT_1, bridge_class_quirk);
> > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >   			DEV_PCIE_PORT_2, bridge_class_quirk);
> >   static void system_bus_quirk(struct pci_dev *pdev)
> 
> Hi,
> 
> Any comments?

(1) how was this driver tested if this patch is required ? Is it because
    you are testing on a different platform ?
(2) Please explain why it is needed (I mean describe what happens
    in current code and how this fixes it) in the commit log, it is
    useful for people who may need to tweak this code further

I will apply it then, thanks.

Lorenzo

> Could you please apply this patch?
> 
> Thanks,
> Tiezhu
> 
