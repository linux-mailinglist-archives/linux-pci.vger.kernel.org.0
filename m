Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3A8686C4B
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 17:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjBAQ66 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 11:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjBAQ66 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 11:58:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EAF76A3;
        Wed,  1 Feb 2023 08:58:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 483C1B821D4;
        Wed,  1 Feb 2023 16:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D7CC433EF;
        Wed,  1 Feb 2023 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675270734;
        bh=9Cau6PyVE2GtVxFGlwOHuWzyHir/3fJpWhTQRdW+NkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ipvF/xaMGsJj1RPkbilfTBacfCIfc+CnK8ILbhc7Rzg0XOfdyBC0z9uLdGlLdaRMg
         lANpe4Ci0BO9cv/Wo3kqTttJUkQvb0L7266E6398ztRx0NBbw1CYRA+1VPn32Pl1Ng
         Zd6H2FDYHAcFx1Uh1FJARqDqD9XTG001++RAWsRWmt9RIL6gCsJ96aovqsR6xmc24a
         SDel2H0tkqxQzwgMpt+QvNNDRs64Z2IZv2AVtzDMxUO32boZAzU2msep7wcbN4UorQ
         7+EvjNSNGRSmxqRaC8AkMr7wjP8MqLseRGZ6vORyEkoDvr/xHE6KRJ/XF+RF5inE2A
         7dhJIj7SSsBVw==
Date:   Wed, 1 Feb 2023 10:58:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
Message-ID: <20230201165852.GA1775862@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cb478bf-db44-0a8f-8521-771529ca0706@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 31, 2023 at 08:25:05PM +0800, Baolu Lu wrote:
> On 2023/1/31 2:38, Bjorn Helgaas wrote:
> > PCIe r6.0, sec 6.20.1:
> > 
> >    A Function is not permitted to generate Requests using Translated
> >    Addresses and a PASID unless both PASID Enable and Translated
> >    Requests with PASID Enable are Set.
> > 
> > You want AMD graphics devices to do DMA with translated addresses and
> > PASID, right?  pci_enable_pasid() sets PASID Enable
> > (PCI_PASID_CTRL_ENABLE), but I don't see where "Translated Requests
> > with PASID Enable" is set.  We don't even have a #define for it.
> > 
> > I would think we should check "Translated Requests with PASID
> > Supported" before setting "Translated Requests with PASID Enable",
> > too?
> 
> This seems to be an ECN for PCIe 5.x:
> 
> https://members.pcisig.com/wg/PCI-SIG/document/14929
> 
> What I read from this ECN is that,
> 
> With this ECN, translated memory requests for PASIDs are not allowed to
> carry a PASID prefix if "Translated Requests with PASID Enabled" is not
> set. It does not mean whether the device can generate translated memory
> requests for PASID, but whether the memory request can carry a PASID
> prefix.

My assumption that "you want AMD graphics devices to do DMA with
translated addresses and PASID" was wrong.

Per Jason [1], it sounds like the AMD GPU generates Translation
Requests (sec 10.2.2) with a PASID.  The GPU will cache the translated
address from the Translation Completion in its local ATC, and will do
DMA (MemRd/Wr) with that translated address but *without* PASID
prefixes.

That makes sense because (PASID, IOVA) maps to a translated address,
e.g., a a CPU physical address, and the GPU can DMA to that address
directly without needing the PASID.

Bjorn

[1] https://lore.kernel.org/r/Y9nQK9P3HOxEeZ4U@nvidia.com
