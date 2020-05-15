Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8971D5785
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 19:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgEORV7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 13:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgEORV7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 13:21:59 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35B82073E;
        Fri, 15 May 2020 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563318;
        bh=0P8rL+XmxOR/BVtEmlu60acHvGkwGm2FDdjswXIkm68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRNC4iSbHX8O2WHd1MLCSQ+5chG8FCYLWzzSuJ1Sdqejq2+A6bxxojc3r++wZatCU
         VsAw+NehG0ZYH8SSRm4A0HLaqagynOVtuaGeMneX4jImS9u7o8WEQgMdCyR8aNkbYU
         e9y0qROMvVqwlLtcwPde3eSYl8XtXXZr11HwXh5M=
Date:   Fri, 15 May 2020 18:21:53 +0100
From:   Will Deacon <will@kernel.org>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com, alex.williamson@redhat.com,
        robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH 0/4] PCI, iommu: Factor 'untrusted' check for ATS
 enablement
Message-ID: <20200515172152.GC23334@willie-the-truck>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
 <20200515154351.GA6546@infradead.org>
 <20200515171948.GC75440@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515171948.GC75440@otc-nc-03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, May 15, 2020 at 10:19:49AM -0700, Raj, Ashok wrote:
> On Fri, May 15, 2020 at 08:43:51AM -0700, Christoph Hellwig wrote:
> > Can you please lift the untrusted flag into struct device?  It really
> > isn't a PCI specific concept, and we should not have code poking into
> > pci_dev all over the iommu code.
> 
> Just for clarification: All IOMMU's today mostly pertain to only PCI devices
> and for devices that aren't PCI like HPET for instance we give a PCI
> identifier. Facilities like ATS for instance require the platform to have 
> an IOMMU.
> 
> what additional problems does moving this to struct device solve?

ATS is PCI specific, but IOMMUs certainly aren't! The vast majority of
IOMMUs deployed in arm/arm64 SoCs are /not/ using any sort of PCI.

Will
