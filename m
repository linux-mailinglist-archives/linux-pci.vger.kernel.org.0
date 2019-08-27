Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7609EAFF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfH0O3B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 10:29:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:58420 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfH0O3B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 10:29:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 07:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="331836540"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 27 Aug 2019 07:28:56 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i2cSt-0004w9-C4; Tue, 27 Aug 2019 17:28:55 +0300
Date:   Tue, 27 Aug 2019 17:28:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        eswara.kota@linux.intel.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        hch@infradead.org, jingoohan1@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
Message-ID: <20190827142855.GG2680@smile.fi.intel.com>
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
 <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com>
 <CAFBinCDSJdq6axcYM7AkqvzUbc6X1zfOZ85Q-q1-FPwVxvgnpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCDSJdq6axcYM7AkqvzUbc6X1zfOZ85Q-q1-FPwVxvgnpA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 26, 2019 at 11:15:48PM +0200, Martin Blumenstingl wrote:
> On Mon, Aug 26, 2019 at 5:31 AM Chuan Hua, Lei
> <chuanhua.lei@linux.intel.com> wrote:

> > As I mentioned, VRX200 was a very old PCIe Gen1.1 product. In our latest
> > SoC Lightning
> >
> > Mountain, we are using synopsys controller 5.20/5.50a. We support
> > Gen2(XRX350/550),
> >
> > Gen3(PRX300) and GEN4(X86 based SoC). We also supported dual lane and
> > single lane.
> >
> > Some of the above registers are needed to control FTS, link width and
> > link speed.
> only now I noticed that I didn't explain why I was asking whether all
> these registers are needed
> my understanding of the DWC PCIe controller driver "library" is that:
> - all functionality which is provided by the DesignWare PCIe core
> should be added to drivers/pci/controller/dwc/pcie-designware*
> - functionality which is built on top/around the DWC PCIe core should
> be added to <vendor specific driver>
> 
> the link width and link speed settings (I don't know about "FTS")
> don't seem Intel/Lantiq controller specific to me
> so the register setup for these bits should be moved to
> drivers/pci/controller/dwc/pcie-designware*

I think it may be done this way. We have already example with stmmac
(DWC network card IP) driver which split in similar way.

> > We can support up to XRX350/XRX500/PRX300 for MIPS SoC since we still
> > sell these products.
> OK, I understand this.
> switching to regmap will give you two benefits:
> - big endian registers writes (without additional code) on the MIPS SoCs
> - you can drop the pcie_app_* helper functions and use
> regmap_{read,write,update_bits} instead

Actually one more, i.e. dump of the registers by request via debugfs, which
I found very helpful.

-- 
With Best Regards,
Andy Shevchenko


