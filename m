Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C5EC176
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 11:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfKAK7G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 06:59:06 -0400
Received: from foss.arm.com ([217.140.110.172]:33942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbfKAK7G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 06:59:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94D7F1FB;
        Fri,  1 Nov 2019 03:59:05 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFE7A3F6C4;
        Fri,  1 Nov 2019 03:59:04 -0700 (PDT)
Date:   Fri, 1 Nov 2019 10:59:03 +0000
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
Message-ID: <20191101105902.GB9723@e119886-lin.cambridge.arm.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
 <20191021130339.GP47056@e119886-lin.cambridge.arm.com>
 <661f7e9c-a79f-bea6-08d8-4df54f500019@linux.intel.com>
 <20191025090926.GX47056@e119886-lin.cambridge.arm.com>
 <6f8b2e72-caa3-30b8-4c76-8ad7bb321ce2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f8b2e72-caa3-30b8-4c76-8ad7bb321ce2@linux.intel.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 04:59:17PM +0800, Dilip Kota wrote:
> 
> On 10/25/2019 5:09 PM, Andrew Murray wrote:
> > On Tue, Oct 22, 2019 at 05:04:21PM +0800, Dilip Kota wrote:
> > > Hi Andrew Murray,
> > > 
> > > On 10/21/2019 9:03 PM, Andrew Murray wrote:
> > > > On Mon, Oct 21, 2019 at 02:39:19PM +0800, Dilip Kota wrote:
> > > > > +
> > > > > +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
> > > > > +{
> > > > > +	u32 val;
> > > > > +
> > > > > +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > > > > +	val &= ~PORT_LOGIC_N_FTS;
> > > > > +	val |= n_fts;
> > > > > +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > > > > +}
> > > > I notice that pcie-artpec6.c (artpec6_pcie_set_nfts) also writes the FTS
> > > > and defines a bunch of macros to support this. It doesn't make sense to
> > > > duplicate this there. Therefore I think we need to update pcie-artpec6.c
> > > > to use this new function.
> > > I think we can do in a separate patch after these changes get merged and
> > > keep this patch series for intel PCIe driver and required changes in PCIe
> > > DesignWare framework.
> > The pcie-artpec6.c is a DWC driver as well. So I think we can do all this
> > together. This helps reduce the technical debt that will otherwise build up
> > in duplicated code.
> I agree with you to remove duplicated code, but at this point not sure what
> all drivers has defined FTS configuration.
> Reviewing all other DWC drivers and removing them can be done in one single
> separate patch.

I'm not asking to set up an FTS configuration for all DWC drivers, but instead
to move this helper function you've created to somewhere like pcie-designware.c
and call it from this driver and pcie-artpec6.c.

Thanks,

Andrew Murray

> 
> Regards,
> Dilip
