Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4076468CE
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 06:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLHF6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 00:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLHF6R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 00:58:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F057273F50
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 21:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670479096; x=1702015096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJt4mgiSinyqIxnJdTeWh8dPKKKSras9ewZrHm75T1w=;
  b=PbkdNmiE0aGQgX92loioZWcMPceyFpxWs3vd/6O1RVgZ8KKvo2hTxZuG
   PHxxxikqMrNyEU9A1eAz2NUa+unAtrLQQhmmTE9YEBMHQ01UZTslsleh0
   BTqKYrQ/VGBmXzc4dt/gbuKDqhGyfQcDFbOZW7JyRUPiBJPkhlZWot1rt
   GNI43MF50OweEfGBnSrzUSkJzraC1ZCJ+ivCmAHvPqhRngEJTE3OURyi0
   q7c+XDZy7QZLDBV6AlpdwEA9Ln1vlSxt398lnYvRk98t+hg4N/pNWgi5j
   g+dc/yiJEkgktWR1kCWG+nzXrU2rWqjxBwt2IiWTOP/VDUoBqUJR/7y89
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="381375105"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="381375105"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 21:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="715466869"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="715466869"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2022 21:58:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3D81D11D; Thu,  8 Dec 2022 07:58:42 +0200 (EET)
Date:   Thu, 8 Dec 2022 07:58:42 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Message-ID: <Y5F9EnsNqyc3hEeK@black.fi.intel.com>
References: <20221207084105.84947-1-mika.westerberg@linux.intel.com>
 <20221207223537.GA1480175@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221207223537.GA1480175@bhelgaas>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 07, 2022 at 04:35:37PM -0600, Bjorn Helgaas wrote:
> Hi Mika,
> 
> On Wed, Dec 07, 2022 at 10:41:05AM +0200, Mika Westerberg wrote:
> > Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
> > or endpoints on the other hand only send messages (that get collected by
> > the former). For this reason do not require PCIe switch ports and
> > endpoints to use interrupt if they support AER.
> > 
> > This allows portdrv to attach PCIe switch ports of Intel DG1 and DG2
> > discrete graphics cards. These do not declare MSI or legacy interrupts.
> 
> Help me understand more about this situation.  I guess we want portdrv
> to attach not to a GPU itself, but to a switch port on the card that
> *leads* to the GPU?

Yes correct.

> >From the patch, it looks like the only PCIe port service this switch
> port advertises is AER (not PME, DPC, hotplug, etc), and it doesn't
> have MSI or MSI-X.

Correct.

> So aerdriver should be able to register for PCIE_PORT_SERVICE_AER, but
> aer_probe() ignores everything except Root Ports and RCECs.  What's
> the benefit then?  I must be missing something.

The portdrv is needed for power management and everything else PCI even
if there is no actual "service" attached.
