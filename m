Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C18134F11
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 22:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgAHVrc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 16:47:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgAHVrc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 16:47:32 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E5120692;
        Wed,  8 Jan 2020 21:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578520050;
        bh=IaGGzdrgRQajWKZsD3t0eI8I52MhXUkIdlflteIv+6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F2kUJO0eN8HqowhRuXaTxUp80jqmtV4HHjFf8S1Gp69Z4/f22cb6H8QCr2LwLBKi3
         9Hb5wuOEv7ifu9k3ERWWEXLhy0E93fJYHQDSqio1jD++B4Q9SxYHVo/skgs6TUiUSK
         Ma8Ho8fYI4p8DlDQFPhbSaLRb4WO5TK9fZ98038g=
Date:   Wed, 8 Jan 2020 15:47:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>
Subject: Re: [PATCH 00/12]  Switchtec Fixes and Gen4 Support
Message-ID: <20200108214728.GA209478@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106190337.2428-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 06, 2020 at 12:03:25PM -0700, Logan Gunthorpe wrote:
> Hi,
> 
> Please find a bunch of patches for the switchtec driver collected over the
> last few months.
> 
> The first 2 patches fix a couple of minor bugs. Patch 3 adds support for
> a new event that is available in specific firmware versions. Patches 4 and
> 5 are some code cleanup changes to simplify the logic. And the last 6
> patches implement support for the new Gen4 hardware.
> 
> This patchset is based on v5.5-rc5 and a git branch is available here:
> 
> https://github.com/sbates130272/linux-p2pmem switchtec-next
> 
> Thanks,
> 
> Logan
> 
> --
> 
> Kelvin Cao (3):
>   PCI/switchtec: Add gen4 support in struct flash_info_regs
>   PCI/switchtec: Add permission check for the GAS access MRPC commands
>   PCI/switchtec: Introduce gen4 variant IDS in the device ID table
> 
> Logan Gunthorpe (6):
>   PCI/switchtec: Fix vep_vector_number ioread width
>   PCI/switchtec: Add support for new events
>   PCI/switchtec: Introduce Generation Variable
>   PCI/switchtec: Separate out gen3 specific fields in the sys_info_regs
>     structure
>   PCI/switchtec: Add gen4 support in struct sys_info_regs
>   PCI: Apply switchtec DMA aliasing quirk to GEN4 devices
> 
> Wesley Sheng (3):
>   PCI/switchtec: Use dma_set_mask_and_coherent()
>   PCI/switchtec: Remove redundant valid PFF number count
>   PCI/switchtec: Move check event id from mask_event() to
>     switchtec_event_isr()

Current order is:

  [PATCH 01/12] PCI/switchtec: Use dma_set_mask_and_coherent()
  [PATCH 02/12] PCI/switchtec: Fix vep_vector_number ioread width
  [PATCH 03/12] PCI/switchtec: Add support for new events
  [PATCH 04/12] PCI/switchtec: Remove redundant valid PFF number count
  [PATCH 05/12] PCI/switchtec: Move check event id from mask_event() to switchtec_event_isr()
  [PATCH 06/12] PCI/switchtec: Introduce Generation Variable
  [PATCH 07/12] PCI/switchtec: Separate out gen3 specific fields in the sys_info_regs structure
  [PATCH 08/12] PCI/switchtec: Add gen4 support in struct sys_info_regs
  [PATCH 09/12] PCI/switchtec: Add gen4 support in struct flash_info_regs
  [PATCH 10/12] PCI/switchtec: Add permission check for the GAS access MRPC commands

10/12 looks lonely in the middle of the gen4 stuff, and it looks like
it's unrelated to gen3/gen4?  Maybe it could be moved up after 05/12?

  [PATCH 11/12] PCI/switchtec: Introduce gen4 variant IDS in the device ID table
  [PATCH 12/12] PCI: Apply switchtec DMA aliasing quirk to GEN4 devices

I speculatively reordered the permission check patch and applied these
to my pci/switchtec branch for v5.6 (reverse order from "git log"):

  b96abab6314f ("PCI/switchtec: Add permission check for the GAS access MRPC commands")
  5f23367bd4df ("PCI/switchtec: Move check event ID from mask_event() to switchtec_event_isr()")
  6722d609bc82 ("PCI/switchtec: Remove redundant valid PFF number count")
  3f3a521ecc81 ("PCI/switchtec: Add support for intercom notify and UEC Port")
  9375646b4cf0 ("PCI/switchtec: Fix vep_vector_number ioread width")
  aa82130a22f7 ("PCI/switchtec: Use dma_set_mask_and_coherent()")

If you rework any of the subsequent ones, you can just post those
without reposting these first six.

Bjorn
