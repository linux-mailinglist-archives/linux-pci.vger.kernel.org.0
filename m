Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DB75990C9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 01:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbiHRXAc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 19:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHRXAZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 19:00:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D6C9E89;
        Thu, 18 Aug 2022 16:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4664DB82472;
        Thu, 18 Aug 2022 23:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C89C433D6;
        Thu, 18 Aug 2022 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660863622;
        bh=2la/ff+NBqPCkMvAfag+oGxK/IDDz4CPd6xHU8h3PkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=StUvr8pU9gmccO8uwX9Udvmo7WHQHhBTkSE0A/o7zd+SXcB3qER26ODW1SGPEw/HK
         dbtgkSzm6hNGSbJ4uUWKGiGCt8FX5naksjoS61NsXP2dF4uQL1SMWcZKqUVW90DYNq
         gRxxOMG/HHa2xmhNO08SIr3Txp1rTx7SvkzhgcobNxy+PgdI1BGx1KQmpNeEX00m4f
         tvRWBD/MU65l7cYaFCJBMXf9Dourv0aroZ4l19Gs46sXcVaaXilhDqN8R0Ykp+wajb
         LCW/I+s7vH37DXKLRotbNgRlq8dADo65T0Kjb7cbGUFAdZ2aJVujBdkKdHAstjtPsy
         Yhb8k2nNzI9KA==
Date:   Thu, 18 Aug 2022 18:00:20 -0500
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
Message-ID: <20220818230020.GA2401272@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4399d3-ee71-b209-4996-12e9a5ffe118@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 07:53:15PM +0800, Baolu Lu wrote:
> On 2022/8/18 05:17, Bjorn Helgaas wrote:
> > On Wed, Aug 17, 2022 at 09:20:15AM +0800, Lu Baolu wrote:
> > > Some configurations of the PCI fabric will route device originated TLP
> > > packets based on the memory addresses.
> > This makes it sound like a few unusual configurations will route TLPs
> > based on memory addresses, but address routing is the default for all
> > PCIe Memory Requests, and ACS provides a way to override that default.
> > 
> > > These configurations are incompatible with PASID as the PASID
> > > packets form a distinct address space.
> > I would say "the Requester ID/PASID combination forms a distinct
> > address space."
> > 
> > > For instance, any configuration where switches are present
> > > without ACS enabled is incompatible.
> > > 
> > > This enhances the pci_enable_pasid() interface by requiring the ACS to
> > > support Source Validation, Request Redirection, Completer Redirection,
> > > and Upstream Forwarding. This effectively means that devices cannot
> > > spoof their requester ID, requests and completions cannot be redirected,
> > > and all transactions are forwarded upstream, even as it passes through a
> > > bridge where the target device is downstream.
> >
> > I think your patch actually requires all those features to be not just
> > "supported" but actually*enabled*  for the entire path leading to the
> > device.
> > 
> > To use the terms from the spec:
> > 
> >    "P2P Request Redirect"
> >    "P2P Completion Redirect"
> >    "Requester ID, Requests, and Completions"
> > 
> > and maybe something like:
> > 
> >    ... even if the TLP looks like a P2P Request because its memory
> >    address (ignoring the PASID) would fall in a bridge window and would
> >    normally be routed downstream.
> 
> Thank you for the suggestions. I will rephrase the commit message
> accordingly like this:
> 
> 
> PCI: Allow PASID only when ACS enforced on upstreaming path

PCI: Enable PASID only when ACS RR & UF enabled on upstream path

The Requester ID/Process Address Space ID (PASID) combination
identifies an address space distinct from the PCI bus address space,
e.g., an address space defined by an IOMMU.

But the PCIe fabric routes Memory Requests based on the TLP address,
ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with PASID that
*should* go upstream to the IOMMU may instead be routed as a P2P
Request if its address falls in a bridge window.

To ensure that all Memory Requests with PASID are routed upstream,
only enable PASID if ACS P2P Request Redirect and Upstream Forwarding
are enabled for the path leading to the device.

> The PCIe fabric routes TLPs based on memory addresses for all PCIe Memory
> Requests regardless of whether TLPs have PASID prefixes. This is stated in
> section "2.2.10.2 End-End TLP Prefix Processing" of the specification:
> 
>   The presence of an End-End TLP Prefix does not alter the routing of a
>   TLP. TLPs are routed based on the routing rules covered in Section
>   2.2.4 .
> 
> As the Requester ID/PASID combination forms a distinct address space. The
> memory address based routing is not compatible for PASID TLPs anymore.
> Therefore we have to rely on ACS to override that default.
> 
> This enhances pci_enable_pasid() interface by requiring the ACS features
> to be enabled for the entire path leading to the device. So that even if
> the TLP looks like a P2P Request because its memory address (ignoring the
> PASID) would fall in a bridge window and would normally be routed
> downstream.
> 
> Best regards,
> baolu
