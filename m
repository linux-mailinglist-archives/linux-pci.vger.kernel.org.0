Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAD417917B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 14:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgCDNhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 08:37:12 -0500
Received: from 8bytes.org ([81.169.241.247]:49992 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbgCDNhM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Mar 2020 08:37:12 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3690C3A4; Wed,  4 Mar 2020 14:37:11 +0100 (CET)
Date:   Wed, 4 Mar 2020 14:37:08 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200304133707.GB4177@8bytes.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303105523-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Michael,

On Tue, Mar 03, 2020 at 11:09:41AM -0500, Michael S. Tsirkin wrote:
> No. It's coded into the hardware. Which might even be practical
> for bare-metal (e.g. on-board flash), but is very practical
> when the device is part of a hypervisor.

If its that way on PPC, than fine for them. But since this is enablement
for x86, it should follow the x86 platform best practices, and that
means describing hardware through ACPI.

> This "hardware" is actually part of hypervisor so there's no
> reason it can't be completely self-descriptive. It's specified
> by the same entity as the "firmware".

That is just an implementation detail. Yes, QEMU emulates the hardware
and builds the ACPI tables. But it could also be implemented in a way
where the ACPI tables are build by guest firmware.

> I don't see why it would be much faster. The interface isn't that
> different from command queues of VTD.

VirtIO IOMMU doesn't need to build page-tables that the hypervisor then
has to shadow, which makes things much faster. If you emulate one of the
other IOMMUs (VT-d or AMD-Vi) the code has to shadow the full page-table
at once when device passthrough is used. VirtIO-IOMMU doesn't need that,
and that makes it much faster and efficient.

> Making ACPI meet the goals of embedded projects such as kata containers
> would be a gigantic task with huge stability implications.  By
> comparison this 400-line parser is well contained and does the job.  I
> didn't yet see compelling reasons not to merge this, but I'll be
> interested to see some more specific concerns.

An ACPI table parse wouldn't need more lines of code. For embedded
systems there is still the DT way of describing things.

Regards,

	Joerg
