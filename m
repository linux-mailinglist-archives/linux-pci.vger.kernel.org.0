Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCC859FF67
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 18:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiHXQX1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 12:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiHXQX1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 12:23:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF6789829;
        Wed, 24 Aug 2022 09:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 018DCB82573;
        Wed, 24 Aug 2022 16:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EB5C433C1;
        Wed, 24 Aug 2022 16:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661358203;
        bh=XSXFpv+5ICvX6u7PFgTnIbovxgX7dzn3lDWPwFjos7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Gt2yhcnvhiD+FyXHyKQDrBuBy0DeGGbqO1rRoMpT1n2gUW/DC0cStVd39O7Wb6pAV
         TC5nJZ509G5hvluuXVdLgVVZyFC36Vuxqc3eaOAJ7FjaEarbRL+iU8SefIw8cC/0I3
         MhanBM8bGXQ6ZhgAfYKrjfHYiwvvbSTnVXOh5BNsEkScMPDERSvkywfjLbVJExEEUK
         2r9LB8UVRA4mbJ5dRKZhwi5DG3v+ydcaqaxSJp953eOWE+LRNTasrmdBEg6kqLYZ74
         HO95WEM9JYzEwmeVTQvIRIY29ccu+BJ00EGLXEsqp7CL/cSDG3GWMOWlmGVqzh9MZT
         2g2yWYbizmIcg==
Date:   Wed, 24 Aug 2022 11:23:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/13] PCI: Allow PASID only when ACS enforced on
 upstreaming path
Message-ID: <20220824162321.GA2783649@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35517add-de1c-f62a-aca2-8a627854e296@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 23, 2022 at 03:05:53PM +0800, Baolu Lu wrote:
> On 2022/8/19 07:00, Bjorn Helgaas wrote:

> > PCI: Enable PASID only when ACS RR & UF enabled on upstream path
> > 
> > The Requester ID/Process Address Space ID (PASID) combination
> > identifies an address space distinct from the PCI bus address space,
> > e.g., an address space defined by an IOMMU.
> > 
> > But the PCIe fabric routes Memory Requests based on the TLP address,
> > ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with PASID that
> > *should*  go upstream to the IOMMU may instead be routed as a P2P
> > Request if its address falls in a bridge window.
> > 
> > To ensure that all Memory Requests with PASID are routed upstream,
> > only enable PASID if ACS P2P Request Redirect and Upstream Forwarding
> > are enabled for the path leading to the device.
> 
> Yours is clear and straight-forward. I will update the patch with above.
> Thank you and very appreciated!

With the update to only require RR and UF and the commit log update,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!
