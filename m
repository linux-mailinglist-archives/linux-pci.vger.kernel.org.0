Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F804255A8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbhJGOnE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 10:43:04 -0400
Received: from foss.arm.com ([217.140.110.172]:58324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242115AbhJGOnE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 10:43:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F30291FB;
        Thu,  7 Oct 2021 07:41:09 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DCAF3F66F;
        Thu,  7 Oct 2021 07:41:08 -0700 (PDT)
Date:   Thu, 7 Oct 2021 15:41:03 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v12 00/11] Add support for Hikey 970 PCIe
Message-ID: <20211007144103.GA23778@lpieralisi>
References: <20211005112448.2c40dc10@coco.lan>
 <20211005182321.GA1106986@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005182321.GA1106986@bhelgaas>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 05, 2021 at 01:23:21PM -0500, Bjorn Helgaas wrote:
> [+cc Lorenzo]
> 
> On Tue, Oct 05, 2021 at 11:24:48AM +0200, Mauro Carvalho Chehab wrote:
> > Hi Bjorn,
> > 
> > Em Tue, 28 Sep 2021 09:34:10 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
> > >   PCI: kirin: Reorganize the PHY logic inside the driver
> > >   PCI: kirin: Add support for a PHY layer
> > >   PCI: kirin: Use regmap for APB registers
> > >   PCI: kirin: Add support for bridge slot DT schema
> > >   PCI: kirin: Add Kirin 970 compatible
> > >   PCI: kirin: Add MODULE_* macros
> > >   PCI: kirin: Allow building it as a module
> > >   PCI: kirin: Add power_off support for Kirin 960 PHY
> > >   PCI: kirin: fix poweroff sequence
> > >   PCI: kirin: Allow removing the driver
> > 
> > I guess everything is already satisfying the review feedbacks.
> > If so, could you please merge the PCI ones?
> 
> Lorenzo takes care of the native host bridge drivers, so I'm sure this
> is on his list.  I added him to cc: in case not.

Ideally I'd like to see these patches ACKed/Review-ed by the kirin
maintainers - that's what I was waiting for and that's what they
are there for.

Having said that, I will keep an eye on this series so that we
can hopefully queue it for v5.16.

Lorenzo
