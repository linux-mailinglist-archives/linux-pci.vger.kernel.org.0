Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F901667E83
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 19:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjALS7A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 13:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjALS6c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 13:58:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1E3266E;
        Thu, 12 Jan 2023 10:34:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51D586214C;
        Thu, 12 Jan 2023 18:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B66C433D2;
        Thu, 12 Jan 2023 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673548463;
        bh=M36E0az9apj/WWDPm0/qsCtZyG5YVmwB7+9Ke5kQ8LU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sPSsKpSMDwEcWp40JGwOPacz6FK0Cr2zqz0qCkOPDZ8q7+P9fxiCSb/9sksSbOR9x
         M1aOoEkm0rO8Bv+1/l4jtqekz5zEI8kbU6mqWCZHwv58ut/km0/wGEBUA6Imv6PpXP
         2ngfp9Aino6ysyS1BMe4eQebFM65xlVnArOuS+D/RHCISDY6qKELCTi49Y6A1kHX/H
         9A5hC+9aZdHTOPNAMgDRA9maQ0aBgMaJ3P1UC5SURxqVsVJYPf5sHiLZoZH2qurC0m
         4yJXHqztabzDiFVA7s4KzandIcus89kPPAERFSUn63FRBm67QwN0j1jc0HAdjzNuJy
         5/zHqWxz5T1kg==
Date:   Thu, 12 Jan 2023 12:34:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH 1/1] PCI: Add translated request only opt-in for
 pci_enable_pasid()
Message-ID: <20230112183422.GA1778973@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a15f05-29d7-9dd3-175a-3915e7357c11@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 09:25:25PM +0800, Baolu Lu wrote:
> On 2023/1/12 20:38, Jason Gunthorpe wrote:
> > On Thu, Jan 12, 2023 at 04:46:29PM +0800, Lu Baolu wrote:
> > 
> > > -int pci_enable_pasid(struct pci_dev *pdev, int features);
> > > +int pci_enable_pasid(struct pci_dev *pdev, int features, bool
> > > transled_only);
      ^^^^^^^^

> + * @flags: device-specific flags
> + *   - PCI_PASID_TRANSLED_REQ_ONLY: The PCI device only issues PASID
> + *                                  memory requests of translated type.
                    ^^^^^^^^

I don't like "transled" since it's not a word itself or an obvious
combination of "translated" and something else.

Not sure whether you need to abbreviate it, but if you do, "xlate" is
a common shortening of "translate".

Bjorn
