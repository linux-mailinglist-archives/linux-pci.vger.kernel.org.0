Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D82C17768A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgCCNCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:02:01 -0500
Received: from 8bytes.org ([81.169.241.247]:49780 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgCCNCB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 08:02:01 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E1C66385; Tue,  3 Mar 2020 14:01:59 +0100 (CET)
Date:   Tue, 3 Mar 2020 14:01:56 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200303130155.GA13185@8bytes.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Eric,

On Tue, Mar 03, 2020 at 11:19:20AM +0100, Auger Eric wrote:
> Michael has pushed this solution (putting the "configuration in the PCI
> config space"), I think for those main reasons:
> - ACPI may not be supported on some archs/hyps

But on those there is device-tree, right?

> - the virtio-iommu is a PCIe device so binding should not need ACPI
> description

The other x86 IOMMUs are PCI devices too and they definitly need a ACPI
table to be configured.

> Another issue with ACPI integration is we have different flavours of
> tables that exist: IORT, DMAR, IVRS

An integration with IORT might be the best, but if it is not possible
ther can be a new table-type for Virtio-iommu. That would still follow
platform best practices.

> x86 ACPI integration was suggested with IORT. But it seems ARM is
> reluctant to extend IORT to support para-virtualized IOMMU. So the VIOT
> was proposed as a different atternative in "[RFC 00/13] virtio-iommu on
> non-devicetree platforms"
> (https://patchwork.kernel.org/cover/11257727/). Proposing a table that
> may be used by different vendors seems to be a challenging issue here.

Yeah, if I am reading that right this proposes a one-fits-all solution.
That is not needed as the other x86 IOMMUs already have their tables
defined and implemented. There is no need to change anything there.

> So even if the above solution does not look perfect, it looked a
> sensible compromise given the above arguments. Please could you explain
> what are the most compelling arguments against it?

It is a hack and should be avoided if at all possible. And defining an
own ACPI table type seems very much possible.


Regards,

	Joerg
