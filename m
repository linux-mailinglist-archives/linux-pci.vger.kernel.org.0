Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED03621090B
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 12:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgGAKPp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 06:15:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:54624 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbgGAKPp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Jul 2020 06:15:45 -0400
IronPort-SDR: jNktE/SKMS8+zqMAglWyzpyxS5kYLCCFS33QOU5+A0KZgW3SUUB5pWqdVLh/Mh5A7ck48wJece
 YFuyyOzPynKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="208035459"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="208035459"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 03:15:44 -0700
IronPort-SDR: tA64YbS8G6dDa/FPkn0ALytSVod8koFHzYH4r4y8p5mDGz8FTPqAJqVoyUN9LdR+2QHqVbfNfL
 LCgCDqnNcDxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="386969400"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 01 Jul 2020 03:15:42 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 01 Jul 2020 13:15:41 +0300
Date:   Wed, 1 Jul 2020 13:15:41 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Make pcie_find_root_port() work for PCIe root ports
 as well
Message-ID: <20200701101541.GO5180@lahna.fi.intel.com>
References: <20200630220107.GA3489322@bjorn-Precision-5520>
 <c4282c55-8312-53a0-d9e6-4818b9206c1f@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4282c55-8312-53a0-d9e6-4818b9206c1f@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 01, 2020 at 09:53:51AM +0800, Yicong Yang wrote:
> >  static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
> >  {
> > -	struct pci_dev *bridge = pci_upstream_bridge(dev);
> > -
> > -	while (bridge) {
> > -		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
> > -			return bridge;
> > -		bridge = pci_upstream_bridge(bridge);
> > +	while (dev) {
> > +		if (pci_is_pcie(dev) &&
> > +		    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> > +			return dev;
> > +		dev = pci_upstream_bridge(dev);
> >  	}
> >  
> 
> We may have some problems here, as after pcie_find_root_port() called, *dev will
> be either root port or NULL but users may want it unchanged. One such usage is
> in acpi_pci_bridge_d3(), drivers/pci/pci-acpi.c, *dev is used as origin
> after called this.
> 
> So we should use a temporary point to *dev rather than directly modify it.

dev is already a copy of what is passed by the caller so it does not
matter if it gets changed here. You would need to pass it through struct
pci_dev **dev in order to modify the passed pointer.
