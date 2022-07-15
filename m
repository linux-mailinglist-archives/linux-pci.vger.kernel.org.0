Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5D1575AEB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 07:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiGOFX1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 01:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiGOFX1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 01:23:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03517796BD;
        Thu, 14 Jul 2022 22:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7AC7B82A82;
        Fri, 15 Jul 2022 05:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD89C34115;
        Fri, 15 Jul 2022 05:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657862603;
        bh=N9kZf8J3OLfWT/WXjnXDjNhEr7GzkCL77vVDKBJ27lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShnkLtwKRmyZz1e02qAAxB40b/ZdmDJasYCxMaT3bMvNd0u/6DMTrZc+qeN3VIGUx
         8QvdXP99K73jllcDy1ezdmdl3vafq+2c3xyd1O5W4RWhsK0d3fylMytl8PMnN/muH1
         3EC15oFAms0ZiPdMjWHUhih9tvi4yr/bebwgTLG4=
Date:   Fri, 15 Jul 2022 07:23:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Tony Luck <tony.luck@intel.com>,
        Christoph Hellwig <hch@lst.de>, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 03/28] cxl/acpi: Track CXL resources in iomem_resource
Message-ID: <YtD5yBAFF5LvFrrZ@kroah.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
 <165784325943.1758207.5310344844375305118.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165784325943.1758207.5310344844375305118.stgit@dwillia2-xfh.jf.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 05:00:59PM -0700, Dan Williams wrote:
> Recall that CXL capable address ranges, on ACPI platforms, are published
> in the CEDT.CFMWS (CXL Early Discovery Table: CXL Fixed Memory Window
> Structures). These windows represent both the actively mapped capacity
> and the potential address space that can be dynamically assigned to a
> new CXL decode configuration (region / interleave-set).
> 
> CXL endpoints like DDR DIMMs can be mapped at any physical address
> including 0 and legacy ranges.
> 
> There is an expectation and requirement that the /proc/iomem interface
> and the iomem_resource tree in the kernel reflect the full set of
> platform address ranges. I.e. that every address range that platform
> firmware and bus drivers enumerate be reflected as an iomem_resource
> entry. The hard requirement to do this for CXL arises from the fact that
> facilities like CONFIG_DEVICE_PRIVATE expect to be able to treat empty
> iomem_resource ranges as free for software to use as proxy address
> space. Without CXL publishing its potential address ranges in
> iomem_resource, the CONFIG_DEVICE_PRIVATE mechanism may inadvertently
> steal capacity reserved for runtime provisioning of new CXL regions.
> 
> So, iomem_resource needs to know about both active and potential CXL
> resource ranges. The active CXL resources might already be reflected in
> iomem_resource as "System RAM". insert_resource_expand_to_fit() handles
> re-parenting "System RAM" underneath a CXL window.
> 
> The "_expand_to_fit()" behavior handles cases where a CXL window is not
> a strict superset of an existing entry in the iomem_resource tree. The
> "_expand_to_fit()" behavior is acceptable from the perspective of
> resource allocation. The expansion happens because a conflicting
> resource range is already populated, which means the resource boundary
> expansion does not result in any additional free CXL address space being
> made available. CXL address space allocation is always bounded by the
> orginal unexpanded address range.
> 
> However, the potential for expansion does mean that something like
> walk_iomem_res_desc(IORES_DESC_CXL...) can only return fuzzy answers on
> corner case platforms that cause the resource tree to expand a CXL
> window resource over a range that is not decoded by CXL. This would be
> an odd platform configuration, but if it becomes a problem in practice
> the CXL subsytem could just publish an API that returns definitive
> answers.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
