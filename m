Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2E71D1C82
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbgEMRoT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 13:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732694AbgEMRoT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 13:44:19 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F350F205ED;
        Wed, 13 May 2020 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589391859;
        bh=HdrRFN+sTaaleT85xWbD2FQudGOmu4rjw1g9hBsphZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B9cMJuSTeFZphshSIL4eovDHpGvv1pb0f+KdFMsR3CzYzebxVw+1FS27Pbq5XVelC
         No0wHOKK9YQRBXxPPNn7WI04nteZQWBnm/fIiTPw+s0J9BwpZIP0GNilqdsR6x/PND
         OhtuPhY3bYf+u3i+eaBOJtYejKLMj2NqoqygpdQE=
Date:   Wed, 13 May 2020 12:44:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Aman Sharma <amanharitsh123@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] PCI: Check for platform_get_irq() failure
 consistently
Message-ID: <20200513174416.GA331366@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501224042.141366-1-helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 05:40:40PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> All callers of platform_get_irq() and related functions interpret a
> negative return value as an error.  A few also interpret zero as an error.
> 
> platform_get_irq() should return either a negative error number or a valid
> non-zero IRQ, so there's no need to check for zero.
> 
> This series:
> 
>   - Extends the platform_get_irq() function comment to say it returns a
>     non-zero IRQ number or a negative error number.
> 
>   - Adds a WARN() if platform_get_irq() ever *does* return zero (this would
>     be a bug in the underlying arch code, and most callers are not prepared
>     for this).
> 
>   - Updates drivers/pci/ to check consistently using "irq < 0".
> 
> This is based on Aman's series [1].  I propose to merge this via the PCI
> tree, given acks from Greg and Thomas.
> 
> [1] https://lore.kernel.org/r/cover.1583952275.git.amanharitsh123@gmail.com
> 
> Aman Sharma (1):
>   PCI: Check for platform_get_irq() failure consistently
> 
> Bjorn Helgaas (1):
>   driver core: platform: Clarify that IRQ 0 is invalid
> 
>  drivers/base/platform.c                       | 40 ++++++++++++-------
>  drivers/pci/controller/dwc/pci-imx6.c         |  4 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  4 +-
>  .../controller/mobiveil/pcie-mobiveil-host.c  |  4 +-
>  drivers/pci/controller/pci-aardvark.c         |  3 ++
>  drivers/pci/controller/pci-v3-semi.c          |  4 +-
>  drivers/pci/controller/pcie-mediatek.c        |  3 ++
>  drivers/pci/controller/pcie-tango.c           |  4 +-
>  8 files changed, 41 insertions(+), 25 deletions(-)

Applied with acks from Greg and Linus W to pci/misc for v5.8.
