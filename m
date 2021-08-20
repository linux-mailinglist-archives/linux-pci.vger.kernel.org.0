Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29F83F3453
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhHTTLy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 15:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhHTTLx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 15:11:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69DF861057;
        Fri, 20 Aug 2021 19:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629486675;
        bh=+lnS2uhPrhRCUE+VxVlLNxa0MLY4D5p562mgZIoQvcE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mLTremNUBXufGJG4IAdVgkGtRJzOJWqQOjFAKNLLJY9ReTw+n69H1Sf+N5cL/oQ/g
         NlqH0KiJyN3qT0mJciCKIlPU7Ef3tnt0mRjB4eWCM3iZUZeBUdeHoDRIkkQix7EnUS
         YHTuK973kuq4mWcp+xrBF7gbHs//d0+elKMbyyBxPE/wYFwVcDai5tXj5e5CNxv/MM
         CiRb/25Fnzub9oNHuIduUNUjr3dcc5gBAwZyza9v6llacIpATie/xQeXEUoDFQR5Q1
         skgSLlTr+RaY6duKPKY6kkYoivSeHURTgBwCnqCnvQCZnOUY9G8G4s8vbV3/QfYQau
         wgt/7KnqgnwLg==
Date:   Fri, 20 Aug 2021 14:11:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, sdonthineni@nvidia.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] CM4 ACPI PCIe quirk
Message-ID: <20210820191114.GA3341026@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819215655.84866-1-jeremy.linton@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 19, 2021 at 04:56:51PM -0500, Jeremy Linton wrote:
> The PFTF CM4 is an ACPI platform that is following the Arm PCIe SMC
> (DEN0115) standard because its PCIe config space isn't ECAM compliant
> since it is split into two parts. One part describes the root port
> registers, and another contains a moveable window pointing at a given
> device's 4K config space. Thus it doesn't have an MCFG table. As
> Linux doesn't support the PCI/SMC, a host bridge specific _DSD is
> added and associated with custom ECAM ops and cfgres.  The custom cfg
> op selects between those two regions, as well as disallowing
> problematic accesses.
> 
> V1->V2:
> 	Only move register definitions to new .h file, add
> 	     include guards.
> 	Change quirk namespace identifier.
> 	Update Maintainers file.
> 	A number of whitespace, grammar, etc fixes.
> 
> 
> Jeremy Linton (4):
>   PCI: brcmstb: Break register definitions into separate header
>   PCI: brcmstb: Add ACPI config space quirk
>   PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
>   MAINTAINERS: Widen brcmstb PCIe file scope
> 
>  MAINTAINERS                                |   2 +-
>  drivers/acpi/pci_mcfg.c                    |  13 ++
>  drivers/pci/controller/Makefile            |   1 +
>  drivers/pci/controller/pcie-brcmstb-acpi.c |  74 ++++++++++
>  drivers/pci/controller/pcie-brcmstb.c      | 150 +-------------------
>  drivers/pci/controller/pcie-brcmstb.h      | 155 +++++++++++++++++++++
>  include/linux/pci-ecam.h                   |   1 +
>  7 files changed, 247 insertions(+), 149 deletions(-)
>  create mode 100644 drivers/pci/controller/pcie-brcmstb-acpi.c
>  create mode 100644 drivers/pci/controller/pcie-brcmstb.h

I'm fine with all of these, given the minor comments I made.

Lorenzo, if you want to pick this up after Jeremy updates it:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

