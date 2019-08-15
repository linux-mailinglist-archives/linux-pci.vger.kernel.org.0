Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4B68F6E7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 00:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfHOWTn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 18:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfHOWTn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 18:19:43 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09F320644;
        Thu, 15 Aug 2019 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565907582;
        bh=3Lja1m6qKvTa5D/Fu2RpysWN0cdisHNqrJv0JOtAxIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VU9mw5R6r87eeHzlzu+WyatBjP2M7dcK3JDoN6kv+PXkBw/a3xXNehEV59Fg5xhtj
         ru6XTF4jWQb/8a7TwKquLx5BabeBysBrU3JJlaBCCoJ5vrk57Om73ed+LqBd/MfJN2
         aKpLrXmMN5YAoyWSgqgORhvDlpoTNNYe5pUjj2Mg=
Date:   Thu, 15 Aug 2019 17:19:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 3/9] PCI/ACPI: Expose EDR support via _OSC to BIOS
Message-ID: <20190815221934.GK253360@google.com>
References: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c2841a077e304b3173e1c6f95f7fe488d1e15030.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2841a077e304b3173e1c6f95f7fe488d1e15030.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 02:43:13PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per PCI firmware specification r3.2 Downstream Port Containment
> Related Enhancements ECN, sec 4.5.1, table 4-4, if OS supports EDR,
> it should expose its support to BIOS by setting bit 7 of _OSC Support
> Field.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/acpi/pci_root.c | 3 +++
>  include/linux/acpi.h    | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 73b08f40b0da..988d09d788b6 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -132,6 +132,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
>  	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
>  	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
>  	{ OSC_PCI_MSI_SUPPORT, "MSI" },
> +	{ OSC_PCI_EDR_SUPPORT, "EDR" },
>  	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-Type3" },
>  };
>  
> @@ -442,6 +443,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
>  	if (pci_msi_enabled())
>  		support |= OSC_PCI_MSI_SUPPORT;
> +	if (IS_ENABLED(CONFIG_PCIE_EDR))
> +		support |= OSC_PCI_EDR_SUPPORT;

Do we really support it here?  This is patch [3/9] and it looks like
patch [6/9] might be where EDR support really gets added.  It's good
to split changes into small pieces, but only if each piece is
logically self-contained.

>  	decode_osc_support(root, "OS supports", support);
>  	status = acpi_pci_osc_support(root, support);
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 8959ed322e15..b6b43da85d26 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -515,6 +515,7 @@ extern bool osc_pc_lpi_support_confirmed;
>  #define OSC_PCI_CLOCK_PM_SUPPORT		0x00000004
>  #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
>  #define OSC_PCI_MSI_SUPPORT			0x00000010
> +#define OSC_PCI_EDR_SUPPORT			0x00000080
>  #define OSC_PCI_HPX_TYPE_3_SUPPORT		0x00000100
>  #define OSC_PCI_SUPPORT_MASKS			0x0000011f

You defined a new bit above but didn't update OSC_PCI_SUPPORT_MASKS to
include that bit.  This looks broken.
