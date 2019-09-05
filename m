Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3456AABE4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfIETW2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729825AbfIETW2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 15:22:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6521E205ED;
        Thu,  5 Sep 2019 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567711348;
        bh=+rcSeGTBLFPifEAacDA/4ZV6OmXaFqgTgQ/Y1RV665g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BwOSBbFaiDzVCM6kpJm/NSFp0CUZO99T9pzTH1GdM/6faNLRbS2va/Xtrrm4+jZwm
         LtIeCqY3FDGYk8oT8oXe69Y08JZaSmu4DGXH0UTP0AU5PL/Wq+X7Sc9LrHh0AT1iNQ
         o2QWt+/YDLShMPHZqxAkj+1lVhE7gsf+qL91uAfs=
Date:   Thu, 5 Sep 2019 14:22:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v7 0/7] Fix PF/VF dependency issue
Message-ID: <20190905192225.GF103977@google.com>
References: <cover.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 03:14:00PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Current implementation of ATS, PASID, PRI does not handle VF dependencies
> correctly. Following patches addresses this issue.
> 
> Changes since v6:
>  * Removed locking interfaces used in v6.
>  * Made necessary changes to PRI/PASID enable/disable calls to allow
>    register changes only for PF.
> 
> Changes since v5:
>  * Created new patches for PRI/PASID capability caching.
>  * Removed individual locks (pri_lock, pasid_lock) and added common
>    resource lock to synchronize PRI/PASID updates between PF/VF.
>  * Addressed comments from Bjorn Helgaas.
> 
> Changes since v4:
>  * Defined empty functions for pci_pri_init() and pci_pasid_init() for cases
>    where CONFIG_PCI_PRI and CONFIG_PCI_PASID are not enabled.
> 
> Changes since v3:
>  * Fixed critical path (lock context) in pci_restore_*_state functions.
> 
> Changes since v2:
>  * Added locking mechanism to synchronize accessing PF registers in VF.
>  * Removed spec compliance checks in patches.
>  * Addressed comments from Bjorn Helgaas.
> 
> Changes since v1:
>  * Added more details about the patches in commit log.
>  * Removed bulk spec check patch.
>  * Addressed comments from Bjorn Helgaas.
> 
> Kuppuswamy Sathyanarayanan (7):
>   PCI/ATS: Fix pci_prg_resp_pasid_required() dependency issues
>   PCI/ATS: Cache PRI capability check result
>   PCI/ATS: Cache PASID capability check result
>   PCI/ATS: Add PRI support for PCIe VF devices
>   PCI/ATS: Add PASID support for PCIe VF devices
>   PCI/ATS: Disable PF/VF ATS service independently
>   PCI: Skip Enhanced Allocation (EA) initialization for VF device

To make it easier to backport things, I think these should be
reordered so the important fixes are first, e.g., like this:

    PCI/ATS: Add PRI support for PCIe VF devices
    PCI/ATS: Add PASID support for PCIe VF devices
    PCI/ATS: Disable PF/VF ATS service independently
    PCI/ATS: Cache PRI capability check result
    PCI/ATS: Cache PASID capability check result

I don't think the following ones are actually needed:

    PCI: Skip Enhanced Allocation (EA) initialization for VF device
    PCI/ATS: Fix pci_prg_resp_pasid_required() dependency issues

I'll post a v8 with my proposal.

>  drivers/pci/ats.c       | 202 ++++++++++++++++++++++++++++------------
>  drivers/pci/pci.c       |   7 ++
>  include/linux/pci-ats.h |  12 ++-
>  include/linux/pci.h     |   3 +-
>  4 files changed, 159 insertions(+), 65 deletions(-)
> 
> -- 
> 2.21.0
> 
