Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508C867EC69
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jan 2023 18:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjA0Ral (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Jan 2023 12:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjA0Rak (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2023 12:30:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3BE4224;
        Fri, 27 Jan 2023 09:30:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16F41B821A5;
        Fri, 27 Jan 2023 17:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B906C433EF;
        Fri, 27 Jan 2023 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674840636;
        bh=yNZFiu9qy7zJ/EWkc4F3j8vLQAcYNj9Evf58Zwkbeqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hELv7tqy2E2JcNBXCVZVUgeW8Vbk8OKW5dB4gWmFyjf4+zZHRL+qK/GypbQPELczq
         anwBM9lrjhtm5uCVGLvcxaVUjMRMpIxU6IeqANqTmQTCNZKyL31ZxkhuSHN0yHOPBr
         nwsAOmzd1RwFZ+0L/ePrQqmvbySpWVQrdS3ML5ysK6y+yjlJ0CfLU74glIgClebaDA
         PtYjFFnq3APo7Zyut44Cfr/3OjUbLe4X/fIreJ/eceSr2zAzaH2HAydg38k2/82JWe
         TB2j62wtqEWAn6suHGZhaQYwSsAlAgQYyJBkeA+Aj0aGaVletrQmv24df8F6rdgNcn
         pE5SpoFj+zNDg==
Date:   Fri, 27 Jan 2023 11:30:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <20230127173035.GA994835@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114073420.759989-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 14, 2023 at 03:34:20PM +0800, Lu Baolu wrote:
> The PCIe fabric routes Memory Requests based on the TLP address, ignoring
> the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
> Enable PASID only when ACS RR & UF enabled on upstream path") requires
> some ACS features being supported on device's upstream path when enabling
> PCI/PASID.
> 
> One alternative is ATS/PRI which lets the device resolve the PASID + addr
> pair before a memory request is made into a routeable TLB address through
> the translation agent.

This sounds like "ATS/PRI" is a solution to a problem, but we haven't
stated the problem yet.

> Those resolved addresses are then cached on the
> device instead of in the IOMMU TLB and the device always sets translated
> bit for PASID. One example of those devices are AMD graphic devices that
> always have ACS or ATS/PRI enabled together with PASID.
> 
> This adds a flag parameter in the pci_enable_pasid() helper, with which
> the device driver could opt-in the fact that device always sets the
> translated bit for PASID.

Nit: "Add a flag ..." and "Apply this opt-in ..." (below).

> It also applies this opt-in for AMD graphic devices. Without this change,
> kernel boots to black screen on a system with below AMD graphic device:
> 
> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
>         [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
>         (prog-if 00 [VGA controller])
> 	DeviceName: ATI EG BROADWAY
> 	Subsystem: Hewlett-Packard Company Device 8332

What is the underlying failure here?  "Black screen" is useful but we
should say *why* that happens, e.g., transactions went the wrong place
or whatever.

> At present, it is a common practice to enable/disable PCI PASID in the
> iommu drivers. Considering that the device driver knows more about the
> specific device, we will follow up by moving pci_enable_pasid() into
> the specific device drivers.

> @@ -353,12 +353,15 @@ void pci_pasid_init(struct pci_dev *pdev)
>   * pci_enable_pasid - Enable the PASID capability
>   * @pdev: PCI device structure
>   * @features: Features to enable
> + * @flags: device-specific flags
> + *   - PCI_PASID_XLATED_REQ_ONLY: The PCI device always use translated type
> + *                                for all PASID memory requests.

s/use/uses/

I guess PCI_PASID_XLATED_REQ_ONLY is something only the driver knows,
right?  We can't deduce from architected config space that the device
will produce PASID prefixes for every Memory Request, can we?

Bjorn
