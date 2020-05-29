Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393CE1E7E17
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 15:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2NMP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 09:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgE2NMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 09:12:14 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B96EC03E969
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2020 06:12:14 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C4025327; Fri, 29 May 2020 15:12:11 +0200 (CEST)
Date:   Fri, 29 May 2020 15:12:10 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 0/3] iommu/vt-d: real DMA sub-device info allocation
Message-ID: <20200529131210.GD14598@8bytes.org>
References: <20200527165617.297470-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527165617.297470-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 27, 2020 at 10:56:14AM -0600, Jon Derrick wrote:
> Jon Derrick (3):
>   iommu/vt-d: Only clear real DMA device's context entries
>   iommu/vt-d: Allocate domain info for real DMA sub-devices
>   iommu/vt-d: Remove real DMA lookup in find_domain
> 
>  drivers/iommu/intel-iommu.c | 31 +++++++++++++++++++++++--------
>  include/linux/intel-iommu.h |  1 +
>  2 files changed, 24 insertions(+), 8 deletions(-)

Applied, thanks.
