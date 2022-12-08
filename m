Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E2647138
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 14:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiLHN7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 08:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiLHN6u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 08:58:50 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9E465E5
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 05:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670507873; x=1702043873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cYsbhRN8GrZZHekuGuUX3l5ZDsR/pym3K88msgypVUo=;
  b=aiSYxmkmH2pCL8ZPdOSmnglMqNZ5MgoqkuZOZTxqUz0HsGfq3YrCoPz8
   1vtg3m/eTNzFAkLra+Gk4gxBpz8fwykrdkKtj8sARrW+tOxtaqRBiOb17
   aFB4UTzFsFkh7xKU0cLPoNmH2bG8/ileNvpxImulGPVgPjjVa02WpipkX
   7AqvTCsk6ZZeB+sPbMRX9okuNlJyz1QNJxbHcEgtPJa9mnWdZ7rlF2A+b
   hhI/3iofQWNg1eUdhe+0f+P9FMecEQunRQO4oF+MHT/AO/+w8ZQ9bqvpi
   cOcTMyOawTYr8R3tt2uqTUC0VP5VbOVPPKg8Xjm9B973PbGvdN9+sPE1M
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="379336174"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="379336174"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 05:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="649144802"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="649144802"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 Dec 2022 05:57:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5A7B111D; Thu,  8 Dec 2022 15:58:19 +0200 (EET)
Date:   Thu, 8 Dec 2022 15:58:19 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Message-ID: <Y5HtezTzYaU6ZOcM@black.fi.intel.com>
References: <Y5F9EnsNqyc3hEeK@black.fi.intel.com>
 <20221208122349.GA1525911@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221208122349.GA1525911@bhelgaas>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Dec 08, 2022 at 06:23:49AM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 08, 2022 at 07:58:42AM +0200, Mika Westerberg wrote:
> > On Wed, Dec 07, 2022 at 04:35:37PM -0600, Bjorn Helgaas wrote:
> > > On Wed, Dec 07, 2022 at 10:41:05AM +0200, Mika Westerberg wrote:
> > > > Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
> > > > or endpoints on the other hand only send messages (that get collected by
> > > > the former). For this reason do not require PCIe switch ports and
> > > > endpoints to use interrupt if they support AER.
> > > > 
> > > > This allows portdrv to attach PCIe switch ports of Intel DG1 and DG2
> > > > discrete graphics cards. These do not declare MSI or legacy interrupts.
> > > 
> > > Help me understand more about this situation.  I guess we want portdrv
> > > to attach not to a GPU itself, but to a switch port on the card that
> > > *leads* to the GPU?
> > 
> > Yes correct.
> > 
> > > From the patch, it looks like the only PCIe port service this switch
> > > port advertises is AER (not PME, DPC, hotplug, etc), and it doesn't
> > > have MSI or MSI-X.
> > 
> > Correct.
> > 
> > > So aerdriver should be able to register for PCIE_PORT_SERVICE_AER, but
> > > aer_probe() ignores everything except Root Ports and RCECs.  What's
> > > the benefit then?  I must be missing something.
> > 
> > The portdrv is needed for power management and everything else PCI even
> > if there is no actual "service" attached.
> 
> Thanks!  I'm trying to connect the dots to get to the specific bug fix
> or improvement made by this patch.

Sure :)

> The pcie_pme_driver itself doesn't seem involved because it registers
> for PCIE_PORT_SERVICE_PME, and that's only set for Root Ports and
> RCECs.
> 
> The pcie_portdrv_pm_ops would be another possibility, but with the
> exception of pcie_port_runtime_idle(), all those ops just iterate over
> service drivers, which aren't involved.
> 
> So I'm guessing this has to do with setting
> DPM_FLAG_NO_DIRECT_COMPLETE and DPM_FLAG_SMART_SUSPEND in
> pcie_portdrv_probe().  Does the lack of portdrv mean the GPU can't
> suspend?  Does this reduce power consumption?  How would a user know
> this change would help their system?

If there is no driver attached to PCI device (this case upstream port)
it will not enter low power states. It allows GPU to suspend but it
does not allow the whole topology to enter low power states.
