Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C62B3D2F53
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 23:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhGVVFO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 17:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhGVVFO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 17:05:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 746F360C41;
        Thu, 22 Jul 2021 21:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626990348;
        bh=EBmOSwSOsL3dJPBqFWHFUv5cMpQ2pBwuY5c9bJ/ux4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IWtDdSYpkGTExyIa3TYGQqEeXaspfAqi/QKkHY90XlK811zSw6By669LoSy0k1zh5
         cZbwCuwoTTKjoXxXNv7v+wyZfiTIU1PMMGOxT6Um177wUU1KTYaKfoYTLOmA/wGaYb
         hDWJkOfjAgzHH757hxY8rF/poqmgSCg/e/SITySDXeuBclYVxPk9my0IwQ0iNzijSM
         MV2zYU0LoINEUIbc+9cIidJtZW9v5cZ7+Zgna/3CQit1ct/trn27G3obb4YlFsNkV8
         4WAr2L2KXOxOVleNzYUaThAc/H2PtMpUm9TezfP5HFtlAqHKyXr4bkxX/95alSA6+f
         nQ+Ol4Tq2EmAw==
Date:   Thu, 22 Jul 2021 16:45:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: [patch 2/8] PCI/MSI: Mask all unused MSI-X entries
Message-ID: <20210722214547.GA349909@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721192650.268814107@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 09:11:28PM +0200, Thomas Gleixner wrote:
> When MSI-X is enabled the ordering of calls is:
> 
>   msix_map_region();
>   msix_setup_entries();
>   pci_msi_setup_msi_irqs();
>   msix_program_entries();
> 
> This has a few interesting issues:
> 
>  1) msix_setup_entries() allocates the msi descriptors and initializes them

s/msi/MSI/ (one or two more below)

>     except for the msi_desc:masked member which is left zero initialized.
> 
>  2) pci_msi_setup_msi_irqs() allocates the interrupt descriptors and sets
>     up the MSI interrupts which ends up in pci_write_msi_msg() unless the
>     interrupt chip provides it's own irq_write_msi_msg() function.

s/it's/its/

>  3) msix_program_entries() does not do what the name suggests. It solely
>     updates the entries array (if not NULL) and initializes the masked
>     member for each msi descriptor by reading the hardware state and then
>     masks the entry.
