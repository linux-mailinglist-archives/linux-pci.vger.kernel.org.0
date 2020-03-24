Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44827191C05
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 22:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCXVhO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 17:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbgCXVhO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 17:37:14 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBF25206F6;
        Tue, 24 Mar 2020 21:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585085833;
        bh=UNlXwsF42X4sIO9wlTklVc3GtL/vn7nadjDze7rmO1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=yvxgOatxE84HrWUg9e5hWjCasWCWUc9HJ7MaL5RWQ3MUsOt/U1/8iYkSKDf2JzRtY
         OGr8A+ko/b3FYBlfIk3Z0CyYyaks/WOU8WOzk8aJEz9pegLw2y8AiFI+P7O2IbKXlu
         76BSgnkKh589t/u3iWwQjo/okKJuVoPEFEWnCF2Y=
Date:   Tue, 24 Mar 2020 16:37:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v18 10/11] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20200324213710.GA48671@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f91fe6d25c13f9d2255d2ce97ca15be307e1bb.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 23, 2020 at 05:26:07PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Error Disconnect Recover (EDR) is a feature that allows ACPI firmware to
> notify OSPM that a device has been disconnected due to an error condition
> (ACPI v6.3, sec 5.6.6).  OSPM advertises its support for EDR on PCI devices
> via _OSC (see [1], sec 4.5.1, table 4-4).  The OSPM EDR notify handler
> should invalidate software state associated with disconnected devices and
> may attempt to recover them.  OSPM communicates the status of recovery to
> the firmware via _OST (sec 6.3.5.2).
> 
> For PCIe, firmware may use Downstream Port Containment (DPC) to support
> EDR.  Per [1], sec 4.5.1, table 4-6, even if firmware has retained control
> of DPC, OSPM may read/write DPC control and status registers during the EDR
> notification processing window, i.e., from the time it receives an EDR
> notification until it clears the DPC Trigger Status.
> 
> Note that per [1], sec 4.5.1 and 4.5.2.4,
> 
>   1. If the OS supports EDR, it should advertise that to firmware by
>      setting OSC_PCI_EDR_SUPPORT in _OSC Support.
> 
>   2. If the OS sets OSC_PCI_EXPRESS_DPC_CONTROL in _OSC Control to request
>      control of the DPC capability, it must also set OSC_PCI_EDR_SUPPORT in
>      _OSC Support.
> 
> Add an EDR notify handler to attempt recovery.
> 
> [1] Downstream Port Containment Related Enhancements ECN, Jan 28, 2019,
>     affecting PCI Firmware Specification, Rev. 3.2
>     https://members.pcisig.com/wg/PCI-SIG/document/12888
> Link: https://lore.kernel.org/r/9ae1d3285beeb81bbf85571a89b8f3d4451eae8f.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com
> Link: https://lore.kernel.org/r/246aa05acca8f0a7e6d20a65ab05af0027f60118.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com
> [bhelgaas: squash add/enable patches into one]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

> +static int acpi_enable_dpc(struct pci_dev *pdev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +	union acpi_object *obj, argv4, req;
> +	int status;
> +
> +	/*
> +	 * Some firmware implementations will return default values for
> +	 * unsupported _DSM calls. So checking acpi_evaluate_dsm() return
> +	 * value for NULL condition is not a complete method for finding
> +	 * whether given _DSM function is supported or not. So use
> +	 * explicit func 0 call to find whether given _DSM function is
> +	 * supported or not.
> +	 */
> +        status = acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> +				1ULL << EDR_PORT_DPC_ENABLE_DSM);

This is really ugly.  What's the story on this firmware?  It sounds
defective to me.

Or is everybody that uses _DSM supposed to check before evaluating it?
E.g.,

  if (!acpi_check_dsm(...))
    return -EINVAL;

  obj = acpi_evaluate_dsm(...);

If everybody is supposed to do this, it seems like the check part
should be moved into acpi_evaluate_dsm().

> +        if (!status)
> +                return 0;
> +
> +	status = 0;
> +	req.type = ACPI_TYPE_INTEGER;
> +	req.integer.value = 1;
> +
> +	argv4.type = ACPI_TYPE_PACKAGE;
> +	argv4.package.count = 1;
> +	argv4.package.elements = &req;
> +
> +	/*
> +	 * Per Downstream Port Containment Related Enhancements ECN to PCI
> +	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
> +	 * optional.  Return success if it's not implemented.
> +	 */
> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> +				EDR_PORT_DPC_ENABLE_DSM, &argv4);
> +	if (!obj)
> +		return 0;
