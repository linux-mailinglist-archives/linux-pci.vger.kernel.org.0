Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017F8AA1A9
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 13:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfIELkW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 07:40:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:7598 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730753AbfIELkW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 07:40:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 04:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; 
   d="scan'208";a="187951270"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 05 Sep 2019 04:40:17 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i5q7c-0007GF-5F; Thu, 05 Sep 2019 14:40:16 +0300
Date:   Thu, 5 Sep 2019 14:40:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v3 2/2] dwc: PCI: intel: Intel PCIe RC controller driver
Message-ID: <20190905114016.GF2680@smile.fi.intel.com>
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <35316bac59d3bc681e76d33e0345f4ef950c4414.1567585181.git.eswara.kota@linux.intel.com>
 <20190905104517.GX9720@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905104517.GX9720@e119886-lin.cambridge.arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 11:45:18AM +0100, Andrew Murray wrote:
> On Wed, Sep 04, 2019 at 06:10:31PM +0800, Dilip Kota wrote:
> > Add support to PCIe RC controller on Intel Universal
> > Gateway SoC. PCIe controller is based of Synopsys
> > Designware pci core.

> > +config PCIE_INTEL_AXI

I think that name here is too generic. Classical x86 seems not using this.

> > +        bool "Intel AHB/AXI PCIe host controller support"
> > +        depends on PCI_MSI
> > +        depends on PCI
> > +        depends on OF
> > +        select PCIE_DW_HOST
> > +        help
> > +          Say 'Y' here to enable support for Intel AHB/AXI PCIe Host
> > +	  controller driver.
> > +	  The Intel PCIe controller is based on the Synopsys Designware
> > +	  pcie core and therefore uses the Designware core functions to
> > +	  implement the driver.

-- 
With Best Regards,
Andy Shevchenko


