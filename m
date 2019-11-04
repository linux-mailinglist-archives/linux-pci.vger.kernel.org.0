Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4124EDCD2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 11:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDKrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 05:47:22 -0500
Received: from foss.arm.com ([217.140.110.172]:39554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbfKDKrW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Nov 2019 05:47:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EDEC31F;
        Mon,  4 Nov 2019 02:47:21 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E82E33F71A;
        Mon,  4 Nov 2019 02:47:20 -0800 (PST)
Date:   Mon, 4 Nov 2019 10:47:19 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
Message-ID: <20191104104718.GK9723@e119886-lin.cambridge.arm.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
 <20191021130339.GP47056@e119886-lin.cambridge.arm.com>
 <661f7e9c-a79f-bea6-08d8-4df54f500019@linux.intel.com>
 <20191025090926.GX47056@e119886-lin.cambridge.arm.com>
 <6f8b2e72-caa3-30b8-4c76-8ad7bb321ce2@linux.intel.com>
 <20191101105902.GB9723@e119886-lin.cambridge.arm.com>
 <ecab7cc2-f4c2-ecc0-7f97-92686db1fd1b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecab7cc2-f4c2-ecc0-7f97-92686db1fd1b@linux.intel.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 04, 2019 at 05:34:54PM +0800, Dilip Kota wrote:
> 
> On 11/1/2019 6:59 PM, Andrew Murray wrote:
> > On Tue, Oct 29, 2019 at 04:59:17PM +0800, Dilip Kota wrote:
> > > On 10/25/2019 5:09 PM, Andrew Murray wrote:
> > > > On Tue, Oct 22, 2019 at 05:04:21PM +0800, Dilip Kota wrote:
> > > > > Hi Andrew Murray,
> > > > > 
> > > > > On 10/21/2019 9:03 PM, Andrew Murray wrote:
> > > > > > On Mon, Oct 21, 2019 at 02:39:19PM +0800, Dilip Kota wrote:
> > > > > > > +
> > > > > > > +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
> > > > > > > +{
> > > > > > > +	u32 val;
> > > > > > > +
> > > > > > > +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > > > > > > +	val &= ~PORT_LOGIC_N_FTS;
> > > > > > > +	val |= n_fts;
> > > > > > > +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > > > > > > +}
> > > > > > I notice that pcie-artpec6.c (artpec6_pcie_set_nfts) also writes the FTS
> > > > > > and defines a bunch of macros to support this. It doesn't make sense to
> > > > > > duplicate this there. Therefore I think we need to update pcie-artpec6.c
> > > > > > to use this new function.
> > > > > I think we can do in a separate patch after these changes get merged and
> > > > > keep this patch series for intel PCIe driver and required changes in PCIe
> > > > > DesignWare framework.
> > > > The pcie-artpec6.c is a DWC driver as well. So I think we can do all this
> > > > together. This helps reduce the technical debt that will otherwise build up
> > > > in duplicated code.
> > > I agree with you to remove duplicated code, but at this point not sure what
> > > all drivers has defined FTS configuration.
> > > Reviewing all other DWC drivers and removing them can be done in one single
> > > separate patch.
> > I'm not asking to set up an FTS configuration for all DWC drivers, but instead
> > to move this helper function you've created to somewhere like pcie-designware.c
> > and call it from this driver and pcie-artpec6.c.
> What i mean is, we need to check how many of the current DWC drivers are
> configuring the FTS
> and call the helper function.
> Today i have grep all the DWC based drivers and i see pcie-artpec6.c is the
> only driver doing FTS configuration.
> 
> I will add the helper function call in pcie-artpec6.c in the next patch
> version.

Thanks that's very much appreciated.

Thanks,

Andrew Murray

> 
> 
> Regards,
> Dilip
> 
> 
> > 
> > Thanks,
> > 
> > Andrew Murray
> > 
> > > Regards,
> > > Dilip
