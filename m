Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E14F869A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 19:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346625AbiDGRxR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 13:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346630AbiDGRxP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 13:53:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29B722EB35;
        Thu,  7 Apr 2022 10:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C510B82901;
        Thu,  7 Apr 2022 17:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E26C385A0;
        Thu,  7 Apr 2022 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649353869;
        bh=cmP0BZ3fNUvcP7KxHKtR0yiNgwGpwH3espXWf6j0OxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ib2H7AYJZPo72aQsw1/OYImofH7OAeCmw1QztjPZCt5O7vxkDFE3uXOi5E3ORoV/K
         GHIbKSEdMghvbX/hZBM7JZxdjReU0uda2rUmEpwYxyRgZNtv7daLjG0NvC53UhnWSO
         lOr+jHVCnKOJR19X1z+r2NAlMzRtN6UzKqfxz+4AHbnWalXuJHl8a3CvsmJf65gXHc
         TrLgEGJD3Vgwv7EvremvCWzqboi9Tod94Y4FAGtJ+ICkXc7fNGUr0nEfJWkiW+ADSk
         Nz9CghzPAtZZ0CpoFIfYZEeKMvooc/1zoVfFxKkP64oNi7RFkuEYDDXui6ZlspGzxs
         K9/WHcmwdmfLQ==
Date:   Thu, 7 Apr 2022 12:51:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 3/3] PCI: ACPI: PM: Power up devices in D3cold before
 scanning them
Message-ID: <20220407175107.GA252647@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5729439.MhkbZ0Pkbq@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 04, 2022 at 05:25:04PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The initial configuration of ACPI power resources on some systems
> implies that some PCI devices on them are initially in D3cold.
> 
> In some cases, especially for PCIe Root Ports, this is a "logical"
> D3cold, meaning that the configuration space of the device is
> accessible, but some of its functionality may be missing, but it
> very well may be real D3cold, in which case the device will not
> be accessible at all.  However, the PCI bus type driver will need
> to access its configuration space in order to enumerate it.
> 
> To prevent possible device enumeration failures that may ensue as
> a result of ACPI power resources being initially in the "off"
> state, power up all children of the host bridge ACPI device object
> that hold valid _ADR objects (which indicates that they will be
> enumerated by the PCI bus type driver) and do that to all children
> of the ACPI device objects corresponding to PCI bridges (including
> PCIe ports).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/acpi/pci_root.c |    2 ++
>  drivers/pci/pci-acpi.c  |    3 +++
>  2 files changed, 5 insertions(+)
> 
> Index: linux-pm/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/pci_root.c
> +++ linux-pm/drivers/acpi/pci_root.c
> @@ -927,6 +927,8 @@ struct pci_bus *acpi_pci_root_create(str
>  		host_bridge->preserve_config = 1;
>  	ACPI_FREE(obj);
>  
> +	acpi_dev_power_up_children_with_adr(device);
> +
>  	pci_scan_child_bus(bus);
>  	pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
>  				    info);
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -1374,6 +1374,9 @@ void pci_acpi_setup(struct device *dev,
>  
>  	acpi_pci_wakeup(pci_dev, false);
>  	acpi_device_power_add_dependent(adev, dev);
> +
> +	if (pci_is_bridge(pci_dev))
> +		acpi_dev_power_up_children_with_adr(adev);
>  }
>  
>  void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)
> 
> 
> 
