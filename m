Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BE11D5772
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 19:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgEORTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 13:19:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:49774 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEORTu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 13:19:50 -0400
IronPort-SDR: fNpcD1fy91Q7ZVeSifuAu3Gb2+7juBFTef8SnJxNW1UdTRBxPAja17QXREOerwYNYTft0ePNsF
 Y7jim3BQIPIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 10:19:49 -0700
IronPort-SDR: eZEoXLPhr5Cv4k9IWYM8gN4137BapxcAi4vssr/dR789L2+dXVQmk1JPIhPZN2nFL5mp2ML7hg
 BUSPg6BHnf6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="281283658"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by orsmga002.jf.intel.com with ESMTP; 15 May 2020 10:19:49 -0700
Date:   Fri, 15 May 2020 10:19:49 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com, will@kernel.org, alex.williamson@redhat.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 0/4] PCI, iommu: Factor 'untrusted' check for ATS
 enablement
Message-ID: <20200515171948.GC75440@otc-nc-03>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
 <20200515154351.GA6546@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515154351.GA6546@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph

On Fri, May 15, 2020 at 08:43:51AM -0700, Christoph Hellwig wrote:
> Can you please lift the untrusted flag into struct device?  It really
> isn't a PCI specific concept, and we should not have code poking into
> pci_dev all over the iommu code.

Just for clarification: All IOMMU's today mostly pertain to only PCI devices
and for devices that aren't PCI like HPET for instance we give a PCI
identifier. Facilities like ATS for instance require the platform to have 
an IOMMU.

what additional problems does moving this to struct device solve?

Cheers,
Ashok

