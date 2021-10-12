Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85542A512
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 15:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhJLNIY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 09:08:24 -0400
Received: from foss.arm.com ([217.140.110.172]:41118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232851AbhJLNIY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 09:08:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84C2FED1;
        Tue, 12 Oct 2021 06:06:22 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1FB63F70D;
        Tue, 12 Oct 2021 06:06:20 -0700 (PDT)
Date:   Tue, 12 Oct 2021 14:06:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Songxiaowei (Kirin_DRV)" <songxiaowei@hisilicon.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>,
        Mauro Carvalho Chehab <mauro.chehab@huawei.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "Wangbinghui (Biggio, Kirin_DRV)" <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v12 00/11] Add support for Hikey 970 PCIe
Message-ID: <20211012130615.GA27771@lpieralisi>
References: <cd22c1e143b94f55a78d969193847812@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd22c1e143b94f55a78d969193847812@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 09, 2021 at 01:44:24AM +0000, Songxiaowei (Kirin_DRV) wrote:
> Ack-by Xiaowei Song.

First of all, you should not top-post:

https://kernelnewbies.org/PatchCulture

Second the format does not match the guidelines:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

So let's retry to send your ACK a third time please.

Thanks,
Lorenzo

> 
> > Hi Lorenzo,
> > 
> > Em Thu, 7 Oct 2021 15:41:03 +0100
> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> escreveu:
> > 
> > > On Tue, Oct 05, 2021 at 01:23:21PM -0500, Bjorn Helgaas wrote:
> > > > [+cc Lorenzo]
> > > > 
> > > > On Tue, Oct 05, 2021 at 11:24:48AM +0200, Mauro Carvalho Chehab wrote:  
> > > > > Hi Bjorn,
> > > > > 
> > > > > Em Tue, 28 Sep 2021 09:34:10 +0200
> > > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:  
> > > >   
> > > > > >   PCI: kirin: Reorganize the PHY logic inside the driver
> > > > > >   PCI: kirin: Add support for a PHY layer
> > > > > >   PCI: kirin: Use regmap for APB registers
> > > > > >   PCI: kirin: Add support for bridge slot DT schema
> > > > > >   PCI: kirin: Add Kirin 970 compatible
> > > > > >   PCI: kirin: Add MODULE_* macros
> > > > > >   PCI: kirin: Allow building it as a module
> > > > > >   PCI: kirin: Add power_off support for Kirin 960 PHY
> > > > > >   PCI: kirin: fix poweroff sequence
> > > > > >   PCI: kirin: Allow removing the driver  
> > > > > 
> > > > > I guess everything is already satisfying the review feedbacks.
> > > > > If so, could you please merge the PCI ones?  
> > > > 
> > > > Lorenzo takes care of the native host bridge drivers, so I'm sure this
> > > > is on his list.  I added him to cc: in case not.  
> > > 
> > > Ideally I'd like to see these patches ACKed/Review-ed by the kirin
> > > maintainers - that's what I was waiting for and that's what they
> > > are there for.
> > > 
> > > Having said that, I will keep an eye on this series so that we
> > > can hopefully queue it for v5.16.
> > 
> > Not sure if you received the e-mail from Xiaowei with his ack.
> 
> I have not (and it did not make it to linux-pci either).
> 
> > At least here, I only received on my internal e-mail (perhaps because
> > the original e-mail was base64-encoded with gb2312 charset). 
> > 
> > So, let me forward his answer to you, c/c the mailing lists.
> 
> Patches should be acked with tags that tooling recognize, this
> would help me.
> 
> > Thanks,
> > Mauro
> > 
> 
> Thanks.
