Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF8841B926
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 23:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbhI1VXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 17:23:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242879AbhI1VXB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 17:23:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CDDF610C8;
        Tue, 28 Sep 2021 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632864081;
        bh=uLpgVG1summajGOu4aGPD+c/1s9mDD4IVkYgS7nf3KM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s1Ww067ArBV+jTOqLf2SRlbBVX2AmtZUFzA6aGNpJOasTgFmkouUW9RtGOS+NCpqj
         SBWB8a7z/OgVkfRnW/Pb/N7FiMUKR8NRrRjNU1njltdgeod4PPlxh8f6cCLR0sussL
         fdTl9Pai2cbZF+x4hojuccRJ4ru236RJNBEFXzVYOUmWfYbmYATkbmiw2WwHHg8+G2
         JNkKEtgXcagbcVA+0x9KTNaPArX8J0CewVEoDoK+80rHbXCpMnjR/R6IuPx0CXxPmu
         H0RC64++j1IMvB703M9dkqW4cGjHl8vvUtt86uj/PJQhQlpnyANCf+UYUWiZ8QwOwf
         8FDtjxp8CgxJA==
Date:   Tue, 28 Sep 2021 16:21:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de
Subject: Re: [PATCH v3 0/4] PCI/ACPI: Simplify PCIe _OSC feature negotiation
Message-ID: <20210928212119.GA735813@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824122054.29481-1-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 24, 2021 at 02:20:50PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Hi,
> 
> here is the third version of my patches to simplify the _OSC
> negotiation of PCIe features between Linux and the firmware.
> 
> This version is a complete rewrite, so there is no changelog to the
> previous version. Patches 1-3 are cleanups and small restructurings of
> the code as a preparation for patch 4.
> 
> The last patch gets rid of the dedicated _OSC query to check for _OSC
> support and merges that functionality into acpi_pci_osc_control_set().
> 
> This allows to simplify and/or remove other functions and consilidate
> error handling in negotiate_os_control().
> 
> I have tested the patches with and without 'pcie_ports=compat' and
> found no regressions on my test machine.
> 
> Please review.
> 
> Thanks,
> 
> 	Joerg
> 
> 
> 
> Joerg Roedel (4):
>   PCI/ACPI: Remove OSC_PCI_SUPPORT_MASKS and OSC_PCI_CONTROL_MASKS
>   PCI/ACPI: Move supported and control calculations to separaten
>     functions
>   PCI/ACPI: Move _OSC query checks to separate function
>   PCI/ACPI: Check for _OSC support in acpi_pci_osc_control_set()
> 
>  drivers/acpi/pci_root.c | 161 +++++++++++++++++++++-------------------
>  include/linux/acpi.h    |   2 -
>  2 files changed, 84 insertions(+), 79 deletions(-)

Applied with Rafael's reviewed-by to pci/acpi for v5.16, thanks!
