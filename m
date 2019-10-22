Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 025B0E0342
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 13:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbfJVLoT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 07:44:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:5068 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387444AbfJVLoT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 07:44:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 04:44:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="209652734"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 22 Oct 2019 04:44:13 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iMsaD-0002wn-7j; Tue, 22 Oct 2019 14:44:13 +0300
Date:   Tue, 22 Oct 2019 14:44:13 +0300
From:   "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
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
Message-ID: <20191022114413.GG32742@smile.fi.intel.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
 <CH2PR12MB400751D01BCEE7ABB708280BDA690@CH2PR12MB4007.namprd12.prod.outlook.com>
 <28b5a21b-b636-f7e4-2d27-23c5d900b0d3@linux.intel.com>
 <e86116b7-b65f-f31e-abb7-a4533aa6d592@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e86116b7-b65f-f31e-abb7-a4533aa6d592@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 22, 2019 at 06:18:57PM +0800, Dilip Kota wrote:
> On 10/21/2019 6:44 PM, Dilip Kota wrote:
> > On 10/21/2019 4:29 PM, Gustavo Pimentel wrote:
> > > On Mon, Oct 21, 2019 at 7:39:19, Dilip Kota
> > > <eswara.kota@linux.intel.com>
> > > wrote:

First of all, it's a good behaviour to avoid way long quoting.

> > > > +static void pcie_update_bits(void __iomem *base, u32 mask, u32
> > > > val, u32 ofs)
> > > > +{
> > > > +    u32 orig, tmp;
> > > > +
> > > > +    orig = readl(base + ofs);
> > > > +
> > > > +    tmp = (orig & ~mask) | (val & mask);
> > > > +
> > > > +    if (tmp != orig)
> > > > +        writel(tmp, base + ofs);
> > > > +}
> > > I'd suggest to the a take on FIELD_PREP() and FIELD_GET() and use more
> > > intuitive names such as new and old, instead of orig and tmp.
> > Sure, i will update it.
> I tried using FIELD_PREP and FIELD_GET but it is failing because FIELD_PREP
> and FIELD_GET
> are expecting mask should be constant macro. u32 or u32 const are not
> accepted.

If you look at bitfield.h carefully you may find in particular
u32_replace_bits().

-- 
With Best Regards,
Andy Shevchenko


