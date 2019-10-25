Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48132E4686
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 11:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404999AbfJYJB0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 05:01:26 -0400
Received: from foss.arm.com ([217.140.110.172]:37212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407770AbfJYJB0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 05:01:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B74128;
        Fri, 25 Oct 2019 02:01:25 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 143DB3F71F;
        Fri, 25 Oct 2019 02:01:24 -0700 (PDT)
Date:   Fri, 25 Oct 2019 10:01:23 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
Subject: Re: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
Message-ID: <20191025090122.GW47056@e119886-lin.cambridge.arm.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
 <CH2PR12MB400751D01BCEE7ABB708280BDA690@CH2PR12MB4007.namprd12.prod.outlook.com>
 <28b5a21b-b636-f7e4-2d27-23c5d900b0d3@linux.intel.com>
 <e86116b7-b65f-f31e-abb7-a4533aa6d592@linux.intel.com>
 <20191022114413.GG32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191022114413.GG32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 22, 2019 at 02:44:13PM +0300, andriy.shevchenko@intel.com wrote:
> On Tue, Oct 22, 2019 at 06:18:57PM +0800, Dilip Kota wrote:
> > On 10/21/2019 6:44 PM, Dilip Kota wrote:
> > > On 10/21/2019 4:29 PM, Gustavo Pimentel wrote:
> > > > On Mon, Oct 21, 2019 at 7:39:19, Dilip Kota
> > > > <eswara.kota@linux.intel.com>
> > > > wrote:
> 
> First of all, it's a good behaviour to avoid way long quoting.
> 
> > > > > +static void pcie_update_bits(void __iomem *base, u32 mask, u32
> > > > > val, u32 ofs)
> > > > > +{
> > > > > +    u32 orig, tmp;
> > > > > +
> > > > > +    orig = readl(base + ofs);
> > > > > +
> > > > > +    tmp = (orig & ~mask) | (val & mask);
> > > > > +
> > > > > +    if (tmp != orig)
> > > > > +        writel(tmp, base + ofs);
> > > > > +}
> > > > I'd suggest to the a take on FIELD_PREP() and FIELD_GET() and use more
> > > > intuitive names such as new and old, instead of orig and tmp.
> > > Sure, i will update it.
> > I tried using FIELD_PREP and FIELD_GET but it is failing because FIELD_PREP
> > and FIELD_GET
> > are expecting mask should be constant macro. u32 or u32 const are not
> > accepted.
> 
> If you look at bitfield.h carefully you may find in particular
> u32_replace_bits().

Thanks Andy - I was looking for something like this when I was reviewing the
patch but wasn't able to find it.

Andrew Murray

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
