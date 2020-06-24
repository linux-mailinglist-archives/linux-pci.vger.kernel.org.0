Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEDF207BD3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 20:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406203AbgFXSzE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 14:55:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:45383 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406019AbgFXSzE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 14:55:04 -0400
IronPort-SDR: 5vFrg2Gpi18PUvIhmJYwDyTr0Iju2BNTStiPq+VJ5UXvrH37HmJecX4B/O3+8pVZ36q+Vn/mne
 kmChtDpUMeLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="142080699"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="142080699"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 11:55:04 -0700
IronPort-SDR: aANov6vjSZGZtORqh4D03erAF1CDI6QmLcOFKgsk2+UG6alKTWdnmcBssRFT9bmvXPZYPwMFTs
 UiQr4ybHUO5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="385254827"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2020 11:55:04 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id D77E65804D6;
        Wed, 24 Jun 2020 11:55:03 -0700 (PDT)
Message-ID: <12d36fdcdbcf438dd3aac7769e8366afd9d5aa1a.camel@linux.intel.com>
Subject: Re: [PATCH V2 0/2] nvme: Add support for ACPI StorageD3Enable
 property
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     shyjumon.n@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, dan.j.williams@intel.com, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Wed, 24 Jun 2020 11:55:03 -0700
In-Reply-To: <20200612204820.20111-1-david.e.box@linux.intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
         <20200612204820.20111-1-david.e.box@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Friendly reminder. Thanks.

David

On Fri, 2020-06-12 at 13:48 -0700, David E. Box wrote:
> This patch set implements a solution for a BIOS hack used on some
> currently
> shipping Intel systems to address issues with power management policy
> decisions concerning PCIe NVMe drives. Some newer Intel platforms,
> like
> some Comet Lake systems, require that PCIe devices use D3 when doing
> suspend-to-idle in order to allow the platform to realize maximum
> power
> savings. This is particularly needed to support ATX power supply
> shutdown
> on desktop systems. In order to ensure this happens for root ports
> with
> storage devices, Microsoft apparently created this ACPI _DSD property
> as a
> way to override their driver policy. To my knowledge this property
> has not
> been discussed with the NVME specification body.
> 
> Though the solution is not ideal, it addresses a problem that also
> affects
> Linux since the NVMe driver's default policy of using NVMe APST
> during
> suspend-to-idle would lead to higher power consumption for these
> platforms.
> 
> Patch 1 provides a symbol in the PCI/ACPI layer to read the property.
> Patch 2 uses the symbol in the NVMe driver to select D3 as a quirk if
> set.
> 
> Changes from V2:
> 	- Export the pci_acpi_storage_d3 function for use by drivers as
> 	  needed instead of modifying the pci header.
> 	- Add missing put on acpi device handle.
> 	- Add 'noacpi' module parameter to allow undoing this change.
> 	- Add info message that this is a platform quirk.
> 
> David E. Box (2):
>   PCI: Add ACPI StorageD3Enable _DSD support
>   drivers/nvme: Add support for ACPI StorageD3Enable property
> 
>  drivers/acpi/property.c |  3 +++
>  drivers/nvme/host/pci.c | 14 ++++++++++
>  drivers/pci/pci-acpi.c  | 59
> +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h     |  2 ++
>  4 files changed, 78 insertions(+)
> 

