Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8BE688818
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 21:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjBBUM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 15:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjBBUMz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 15:12:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D3580F9F;
        Thu,  2 Feb 2023 12:12:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50AEAB827D6;
        Thu,  2 Feb 2023 20:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A003CC433EF;
        Thu,  2 Feb 2023 20:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675368772;
        bh=MQKMITOOkVxwlfpaG6ybSkQudYIrm/IEf9Xq09VMI4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ij6k1W+x/btHjzibEPP+mqaOcORyoeROaRTKdXR0bqowRVwYIzV0mZ8tt3Z2tfEYy
         5j7kv3AtMz37z1ZRatjdsDESWXFI6G3dfvrYN4dFp5hwgMviQU9g0fxM34HB/mmddk
         KcM/5lGPrDWiZ/8lx07wvvv833yy+88EC4dVLYdlPCVyjr1NXUJtiktYSFjHsSP0ud
         UwNboaJUXukFznvNekv4QWnohI7QPvbTdwOtBvvljr/Ka09+FAJRJrcK65ZIhjiR7S
         /BovMJY8UilkkZ591J9xncErp1HuUL25+d5nbX5eQi9s9pG9t3oTmtX9xSyn1L0z0s
         p0Yb83XECJJVg==
Date:   Thu, 2 Feb 2023 14:12:49 -0600
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
Message-ID: <20230202201249.GA1963053@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75a5a94-a962-f88e-149e-7d23982a7ad2@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Joerg, you may be able to answer this.  Patch under discussion is:
https://lore.kernel.org/r/20230114073420.759989-1-baolu.lu@linux.intel.com]

On Thu, Feb 02, 2023 at 11:08:25AM +0800, Baolu Lu wrote:
> ...

> ACS is unnecessary for the devices that only use translated memory request
> for PASID. All translated addresses are granted by the Linux kernel which
> ensures that such addresses will never be in a P2P address, i.e., it's not
> contained in any bridge aperture, will *always* be routed toward the RC.

Re 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on
upstream path"), does that commit actually *fix* anything?  I wonder
whether we could revert it completely.

The intent of 201007ef707a is to use ACS to prevent misrouting, which
would happen if a TLP contained an address that *looked* like a PCI
bus address, i.e., it was inside a host bridge aperture, but was
*intended* to reach an IOMMU or main memory directly.

201007ef707a only affects pci_enable_pasid(), so I think we already
avoid this misrouting by restricting DMA address allocation for both
non-IOMMU scenarios and non-PASID IOMMU scenarios.

So what about PASID mappings, e.g., consider a mapping of (Requester
ID, PASID, Untranslated Address) -> Translated Address?  If either the
Untranslated Address or the Translated Address looks like a PCI bus
address, a Memory Request or Translation Request could be misrouted.

Does that actually happen?  I assume it does not happen for Translated
Addresses because that's basically the non-IOMMU case, and we don't
need ACS to prevent misrouting there.

Do IOMMUs allocate (PASID, Untranslated Addresses) that look like PCI
bus addresses?

Bjorn
