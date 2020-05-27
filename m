Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092931E50B5
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 23:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgE0Vs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 17:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgE0Vs6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 17:48:58 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E2420899;
        Wed, 27 May 2020 21:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590616137;
        bh=VxwMLFdqxnAPqgauCV5/DmruSIHLnC3MfEd40C7RVU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IpcKZczFI5hF0S/9QZvgZXV01DR4F6ARqI3uemTIeFK8l/MTr9yu6EHtp015tu7hI
         mAAnFzMQXfnTBxcLPAZ3Unkl1HD+yThZSGFX10dc/5CuJQPgbMKvHC0Xh4B1YyvFww
         tNkDwHQBm/+uzNzRpAKSMHCow//9CCvSTA9a4dWQ=
Date:   Wed, 27 May 2020 16:48:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Rename _DSM constants to align with PCI Firmware
 specification
Message-ID: <20200527214855.GA267502@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526213905.2479381-1-kw@linux.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 09:39:05PM +0000, Krzysztof Wilczyński wrote:
> Rename PCI-related _DSM constants to better align them with the PCI
> Firmware specification (see PCI Firmware Specification, Revision 3.2,
> Section 4.6., p. 58).  All the constants names should correlate more
> strongly with the descriptions in the aforementioned specification to
> make them unambiguous.
> 
> Additionally, all of the renamed constants will use the DSM_ prefix,
> similarly to the PCI _OSC constants that use the OSC_ prefix, to make it
> clear what these are.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/misc for v5.8, thanks!

> ---
>  drivers/acpi/pci_root.c  |  2 +-
>  drivers/pci/pci-acpi.c   |  4 ++--
>  drivers/pci/pci-label.c  |  4 ++--
>  include/linux/pci-acpi.h | 10 ++++++----
>  4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ac8ad6cb82aa..ee4d0bf717fd 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -938,7 +938,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	 * assignments made by firmware for this host bridge.
>  	 */
>  	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
> -	                        IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> +				DSM_PCI_IGNORE_BOOT_CONFIG, NULL);
>  	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
>  		host_bridge->preserve_config = 1;
>  	ACPI_FREE(obj);
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index d21969fba6ab..a2e9f01434de 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1128,7 +1128,7 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>  		return;
>  
>  	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
> -				RESET_DELAY_DSM, NULL);
> +				DSM_PCI_POWER_ON_RESET_DELAY, NULL);
>  	if (!obj)
>  		return;
>  
> @@ -1193,7 +1193,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  		pdev->d3cold_delay = 0;
>  
>  	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 3,
> -				FUNCTION_DELAY_DSM, NULL);
> +				DSM_PCI_DEVICE_READINESS_DURATIONS, NULL);
>  	if (!obj)
>  		return;
>  
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index a5910f942857..69db1fd10f21 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -178,7 +178,7 @@ static int dsm_get_label(struct device *dev, char *buf,
>  		return -1;
>  
>  	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 0x2,
> -				DEVICE_LABEL_DSM, NULL);
> +				DSM_PCI_PCIE_DEVICE_NAME, NULL);
>  	if (!obj)
>  		return -1;
>  
> @@ -218,7 +218,7 @@ static bool device_has_dsm(struct device *dev)
>  		return false;
>  
>  	return !!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 0x2,
> -				1 << DEVICE_LABEL_DSM);
> +				1 << DSM_PCI_PCIE_DEVICE_NAME);
>  }
>  
>  static umode_t acpi_index_string_exist(struct kobject *kobj,
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 2d155bfb8fbf..21b32fe47607 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -107,10 +107,12 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>  #endif
>  
>  extern const guid_t pci_acpi_dsm_guid;
> -#define IGNORE_PCI_BOOT_CONFIG_DSM	0x05
> -#define DEVICE_LABEL_DSM		0x07
> -#define RESET_DELAY_DSM			0x08
> -#define FUNCTION_DELAY_DSM		0x09
> +
> +/* _DSM Definitions for PCI */
> +#define DSM_PCI_IGNORE_BOOT_CONFIG		0x05
> +#define DSM_PCI_PCIE_DEVICE_NAME		0x07
> +#define DSM_PCI_POWER_ON_RESET_DELAY		0x08
> +#define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
>  
>  #ifdef CONFIG_PCIE_EDR
>  void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
> -- 
> 2.26.2
> 
