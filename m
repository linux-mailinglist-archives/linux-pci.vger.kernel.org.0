Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E36276E19
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 12:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIXKC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 06:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXKC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 06:02:59 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A345C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 03:02:59 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 55BF8295; Thu, 24 Sep 2020 12:02:57 +0200 (CEST)
Date:   Thu, 24 Sep 2020 12:02:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924100255.GM27174@8bytes.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924053159-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 05:38:13AM -0400, Michael S. Tsirkin wrote:
> On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> > On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> > > OK so this looks good. Can you pls repost with the minor tweak
> > > suggested and all acks included, and I will queue this?
> > 
> > My NACK still stands, as long as a few questions are open:
> > 
> > 	1) The format used here will be the same as in the ACPI table? I
> > 	   think the answer to this questions must be Yes, so this leads
> > 	   to the real question:
> 
> I am not sure it's a must.

It is, having only one parser for the ACPI and MMIO descriptions was one
of the selling points for MMIO in past discussions and I think it makes
sense to keep them in sync.

> We can always tweak the parser if there are slight differences
> between ACPI and virtio formats.

There is no guarantee that there only need to be "tweaks" until the
ACPI table format is stablized.

Regards,

	Joerg

