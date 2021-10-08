Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7179426FA1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 19:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhJHRg4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 13:36:56 -0400
Received: from foss.arm.com ([217.140.110.172]:38150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234255AbhJHRgz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 13:36:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 838C51063;
        Fri,  8 Oct 2021 10:34:59 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1FC83F766;
        Fri,  8 Oct 2021 10:34:57 -0700 (PDT)
Date:   Fri, 8 Oct 2021 18:34:51 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v12 00/11] Add support for Hikey 970 PCIe
Message-ID: <20211008173451.GA32193@lpieralisi>
References: <20211005112448.2c40dc10@coco.lan>
 <20211005182321.GA1106986@bhelgaas>
 <20211007144103.GA23778@lpieralisi>
 <20211008125521.0aa31beb@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008125521.0aa31beb@coco.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 08, 2021 at 12:55:21PM +0200, Mauro Carvalho Chehab wrote:
> Hi Lorenzo,
> 
> Em Thu, 7 Oct 2021 15:41:03 +0100
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> escreveu:
> 
> > On Tue, Oct 05, 2021 at 01:23:21PM -0500, Bjorn Helgaas wrote:
> > > [+cc Lorenzo]
> > > 
> > > On Tue, Oct 05, 2021 at 11:24:48AM +0200, Mauro Carvalho Chehab wrote:  
> > > > Hi Bjorn,
> > > > 
> > > > Em Tue, 28 Sep 2021 09:34:10 +0200
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:  
> > >   
> > > > >   PCI: kirin: Reorganize the PHY logic inside the driver
> > > > >   PCI: kirin: Add support for a PHY layer
> > > > >   PCI: kirin: Use regmap for APB registers
> > > > >   PCI: kirin: Add support for bridge slot DT schema
> > > > >   PCI: kirin: Add Kirin 970 compatible
> > > > >   PCI: kirin: Add MODULE_* macros
> > > > >   PCI: kirin: Allow building it as a module
> > > > >   PCI: kirin: Add power_off support for Kirin 960 PHY
> > > > >   PCI: kirin: fix poweroff sequence
> > > > >   PCI: kirin: Allow removing the driver  
> > > > 
> > > > I guess everything is already satisfying the review feedbacks.
> > > > If so, could you please merge the PCI ones?  
> > > 
> > > Lorenzo takes care of the native host bridge drivers, so I'm sure this
> > > is on his list.  I added him to cc: in case not.  
> > 
> > Ideally I'd like to see these patches ACKed/Review-ed by the kirin
> > maintainers - that's what I was waiting for and that's what they
> > are there for.
> > 
> > Having said that, I will keep an eye on this series so that we
> > can hopefully queue it for v5.16.
> 
> Not sure if you received the e-mail from Xiaowei with his ack.

I have not (and it did not make it to linux-pci either).

> At least here, I only received on my internal e-mail (perhaps because
> the original e-mail was base64-encoded with gb2312 charset). 
> 
> So, let me forward his answer to you, c/c the mailing lists.

Patches should be acked with tags that tooling recognize, this
would help me.

> Thanks,
> Mauro
> 
> -------- Forwarded Message --------
> From: Songxiaowei (Kirin_DRV) <songxiaowei@hisilicon.com>
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <helgaas@kernel.org>
> CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Linuxarm <linuxarm@huawei.com>, Mauro Carvalho Chehab <mauro.chehab@huawei.com>, Krzysztof Wilczyński <kw@linux.com>, Wangbinghui (Biggio, Kirin_DRV) <wangbinghui@hisilicon.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.org <linux-phy@lists.infradead.org>, Kongfei <kongfei@hisilicon.com>
> Subject: Re: [PATCH v12 00/11] Add support for Hikey 970 PCIe
> Date: Fri, 8 Oct 2021 11:45:06 +0100
> Message-ID: <e718dc06633e4f87a6b6e1626e8c098e@hisilicon.com>
> 
> Hi Bjorn,
> 
> ACKed, it seems ok to me and Binghui.

For Xiaowei:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

and your email must make it to the mailing list; if it does not
it does not exist as far as I am concerned. I will apply the
ACK manually for this time but let's keep this in mind please.

Thanks,
Lorenzo
> 
> Thanks a lot.
> 
> B. R.
> 
> -----邮件原件-----
> 发件人: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> 发送时间: 2021年10月7日 22:41
> 收件人: Bjorn Helgaas <helgaas@kernel.org>
> 抄送: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; Linuxarm <linuxarm@huawei.com>; Mauro Carvalho Chehab <mauro.chehab@huawei.com>; Krzysztof Wilczyński <kw@linux.com>; Wangbinghui (Biggio, Kirin_DRV) <wangbinghui@hisilicon.com>; Rob Herring <robh@kernel.org>; Songxiaowei (Kirin_DRV) <songxiaowei@hisilicon.com>; linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; linux-phy@lists.infradead.org
> 主题: Re: [PATCH v12 00/11] Add support for Hikey 970 PCIe
> 
> On Tue, Oct 05, 2021 at 01:23:21PM -0500, Bjorn Helgaas wrote:
> > [+cc Lorenzo]
> > 
> > On Tue, Oct 05, 2021 at 11:24:48AM +0200, Mauro Carvalho Chehab wrote:  
> > > Hi Bjorn,
> > > 
> > > Em Tue, 28 Sep 2021 09:34:10 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:  
> >   
> > > >   PCI: kirin: Reorganize the PHY logic inside the driver
> > > >   PCI: kirin: Add support for a PHY layer
> > > >   PCI: kirin: Use regmap for APB registers
> > > >   PCI: kirin: Add support for bridge slot DT schema
> > > >   PCI: kirin: Add Kirin 970 compatible
> > > >   PCI: kirin: Add MODULE_* macros
> > > >   PCI: kirin: Allow building it as a module
> > > >   PCI: kirin: Add power_off support for Kirin 960 PHY
> > > >   PCI: kirin: fix poweroff sequence
> > > >   PCI: kirin: Allow removing the driver  
> > > 
> > > I guess everything is already satisfying the review feedbacks.
> > > If so, could you please merge the PCI ones?  
> > 
> > Lorenzo takes care of the native host bridge drivers, so I'm sure this 
> > is on his list.  I added him to cc: in case not.  
> 
> Ideally I'd like to see these patches ACKed/Review-ed by the kirin maintainers - that's what I was waiting for and that's what they are there for.
> 
> Having said that, I will keep an eye on this series so that we can hopefully queue it for v5.16.
> 
> Lorenzo
> 
> 
