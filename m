Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611151D7E73
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgERQ3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 12:29:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:14935 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERQ3M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 12:29:12 -0400
IronPort-SDR: 4mqiyMCU/B+VzeDVzhlN/Pek2nEmqlwG0szJLPJVcQ/U+lmRkEmvgKRyEQaFUj9LAXICslpKv8
 BeaCGdw/7YyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:29:12 -0700
IronPort-SDR: IsfGIPgmh9ow/1nMPOsWe8QHvrerOLaKz4ePIfTIl77UGc9ouzE5GO46eu84skAVC9ndMGi6C3
 DnATkJggKVCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="308152106"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by FMSMGA003.fm.intel.com with ESMTP; 18 May 2020 09:29:11 -0700
Date:   Mon, 18 May 2020 09:29:11 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com, will@kernel.org, alex.williamson@redhat.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 0/4] PCI, iommu: Factor 'untrusted' check for ATS
 enablement
Message-ID: <20200518162911.GA92942@otc-nc-03>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
 <20200515154351.GA6546@infradead.org>
 <20200515171948.GC75440@otc-nc-03>
 <3ce5d02db49254e50883224771ffb35cf436845f.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce5d02db49254e50883224771ffb35cf436845f.camel@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 18, 2020 at 04:47:17PM +0100, David Woodhouse wrote:
> On Fri, 2020-05-15 at 10:19 -0700, Raj, Ashok wrote:
> > Hi Christoph
> > 
> > On Fri, May 15, 2020 at 08:43:51AM -0700, Christoph Hellwig wrote:
> > > Can you please lift the untrusted flag into struct device?  It really
> > > isn't a PCI specific concept, and we should not have code poking into
> > > pci_dev all over the iommu code.
> > 
> > Just for clarification: All IOMMU's today mostly pertain to only PCI devices
> > and for devices that aren't PCI like HPET for instance we give a PCI
> > identifier. Facilities like ATS for instance require the platform to have 
> > an IOMMU.
> > 
> > what additional problems does moving this to struct device solve?
> 
> Even the Intel IOMMU supports ACPI devices for which there is no struct
> pci_dev; only a B/D/F in the ANDD record indicating which entry in the
> context table to use.

Yes, spaced out :-).. just don't work on those platforms on a daily
basis and its easy to forget :-(
