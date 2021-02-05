Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66039310716
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 09:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBEIxC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 03:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhBEIxC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2021 03:53:02 -0500
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Feb 2021 00:52:21 PST
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777A9C0613D6
        for <linux-pci@vger.kernel.org>; Fri,  5 Feb 2021 00:52:21 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5561038F; Fri,  5 Feb 2021 09:45:51 +0100 (CET)
Date:   Fri, 5 Feb 2021 09:45:49 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/2] VMD MSI Remapping Bypass
Message-ID: <20210205084549.GD27686@8bytes.org>
References: <20210204190906.38515-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204190906.38515-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 04, 2021 at 12:09:04PM -0700, Jon Derrick wrote:
> Jon Derrick (2):
>   iommu/vt-d: Use Real PCI DMA device for IRTE
>   PCI: vmd: Disable MSI/X remapping when possible
> 
>  drivers/iommu/intel/irq_remapping.c |  3 +-
>  drivers/pci/controller/vmd.c        | 60 +++++++++++++++++++++++------
>  2 files changed, 50 insertions(+), 13 deletions(-)

This probably goes via Bjorn's tree, so

	Acked-by: Joerg Roedel <jroedel@suse.de>
