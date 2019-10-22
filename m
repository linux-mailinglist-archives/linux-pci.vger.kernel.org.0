Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA2BE048F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 15:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfJVNJJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 09:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbfJVNJI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 09:09:08 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B46062184C;
        Tue, 22 Oct 2019 13:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571749748;
        bh=qbwfDtY+gjN70QK4vfeGu6QOKlIe/RCNosirjkTKnMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bHBhYl7TxUI7VNA5PzjW5w96MU9y2nVDNjayeOwE+FDwo2K5pKSx240WTnyBuxxlx
         /rJ0xdo1XpVzV5cUXYHqCsJjVu/2JtxbF2DQa0ffc/nV+AYDUMu/pPA5a7Lis/oYpf
         Oz+Gk6dpXMkBvWWyiwQaVqvQUlxXJK4EF8TMxZbY=
Date:   Tue, 22 Oct 2019 08:09:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
Message-ID: <20191022130905.GA133961@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0914051f-b726-f15f-7f86-c0b26ff0f04c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 22, 2019 at 05:07:47PM +0800, Dilip Kota wrote:
> On 10/22/2019 1:17 AM, Bjorn Helgaas wrote:
> > On Mon, Oct 21, 2019 at 02:39:19PM +0800, Dilip Kota wrote:
> > > Add support to PCIe RC controller on Intel Gateway SoCs.
> > > PCIe controller is based of Synopsys DesignWare pci core.
> > > 
> > > Intel PCIe driver requires Upconfig support, fast training
> > > sequence configuration and link speed change. So adding the
> > > respective helper functions in the pcie DesignWare framework.
> > > It also programs hardware autonomous speed during speed
> > > configuration so defining it in pci_regs.h.
> > > 
> > > +static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
> > > +{
> > > +	u32 val;
> > > +
> > > +	val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCAP);
> > > +	lpp->max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
> > > +	lpp->max_width = FIELD_GET(PCI_EXP_LNKCAP_MLW, val);
> > > +
> > > +	val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> > > +
> > > +	val &= ~(PCI_EXP_LNKCTL_LD | PCI_EXP_LNKCTL_ASPMC);
> > > +	val |= (PCI_EXP_LNKSTA_SLC << 16) | PCI_EXP_LNKCTL_CCC |
> > > +	       PCI_EXP_LNKCTL_RCB;

> > PCI_EXP_LNKCTL_CCC is RW.  But doesn't it depend on the components on
> > both ends of the link?  Do you know what device is at the other end?
> > I would have assumed that you'd have to start with CCC==0, which
> > should be most conservative, then set CCC=1 only if you know both ends
> > have a common clock.
> PCIe RC and endpoint device are having the common clock so set the CCC=1.

How do you know what the endpoint device is?  Is this driver only for
a specific embedded configuration where the endpoint is always
soldered down?  There's no possibility of this RC being used with a
connector?

Shouldn't this be either discoverable or configurable via DT or
something?  pcie_aspm_configure_common_clock() seems to do something
similar, but I can't really vouch for its correctness.

Bjorn
