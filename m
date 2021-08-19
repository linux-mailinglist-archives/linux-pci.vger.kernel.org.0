Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5C3F1C34
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbhHSPHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 11:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239492AbhHSPHk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 11:07:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F19360EFE;
        Thu, 19 Aug 2021 15:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629385624;
        bh=uhjeJBvoPP2I+RVs+SoGGKsC/Dn1zb4WfhRW47bY984=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j317V0SqW9Mg/CaN2/8iQOjT6xni1VRsFam0vx4gbktvO1xO/hU3F5XegTUCkEZOm
         KYVcgIKWGDsokLcL8jJYijATiS7Xn7NGCAGjTOK7GHGSyofnuPVQKa2B1lND6PGF9S
         sOOHE52g9tDKkUmDJVGpRqXzC1Bjn3fuJhgLpieuNb+/uy2iF+Nnsbrqw4ZlHzQgrW
         KQKrN9vkrtZ7kOz6hnCOhEDxU3NSDxOybKbghcIHg9wiDkZknSjho7s54zwVhW/Zrj
         3tStUBo5QtLVngXfk+3bYNDuEK1Oq5Bo3x7fYGLyl1jhfaBc7mbHGS35aPON8CfuRb
         Dq9wmQWd9qNKA==
Date:   Thu, 19 Aug 2021 10:07:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] mei: improve Denverton HSM & IFSI support
Message-ID: <20210819150703.GA3204796@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819145114.21074-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Thu, Aug 19, 2021 at 04:51:14PM +0200, Lukas Bulwahn wrote:
> The Intel Denverton chip provides HSM & IFSI. In order to access
> HSM & IFSI at the same time, provide two HECI hardware IDs for accessing.
> 
> Suggested-by: Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Tomas, please pick this quick helpful extension for the hardware.
> 
>  drivers/misc/mei/hw-me-regs.h | 3 ++-
>  drivers/misc/mei/pci-me.c     | 1 +
>  drivers/pci/quirks.c          | 3 +++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
> index cb34925e10f1..c1c41912bb72 100644
> --- a/drivers/misc/mei/hw-me-regs.h
> +++ b/drivers/misc/mei/hw-me-regs.h
> @@ -68,7 +68,8 @@
>  #define MEI_DEV_ID_BXT_M      0x1A9A  /* Broxton M */
>  #define MEI_DEV_ID_APL_I      0x5A9A  /* Apollo Lake I */
>  
> -#define MEI_DEV_ID_DNV_IE     0x19E5  /* Denverton IE */
> +#define MEI_DEV_ID_DNV_IE	0x19E5  /* Denverton for HECI1 - IFSI */
> +#define MEI_DEV_ID_DNV_IE_2	0x19E6  /* Denverton 2 for HECI2 - HSM */
>  
>  #define MEI_DEV_ID_GLK        0x319A  /* Gemini Lake */
>  
> diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
> index c3393b383e59..30827cd2a1c2 100644
> --- a/drivers/misc/mei/pci-me.c
> +++ b/drivers/misc/mei/pci-me.c
> @@ -77,6 +77,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
>  	{MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},
>  
>  	{MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE, MEI_ME_PCH8_CFG)},
> +	{MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE_2, MEI_ME_PCH8_SPS_CFG)},
>  
>  	{MEI_PCI_DEVICE(MEI_DEV_ID_GLK, MEI_ME_PCH8_CFG)},
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6899d6b198af..2ab767ef8469 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4842,6 +4842,9 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_rciep_acs },
> +	/* Denverton */
> +	{ PCI_VENDOR_ID_INTEL, 0x19e5, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_INTEL, 0x19e6, pci_quirk_mf_endpoint_acs },

This looks like it should be a separate patch with a commit log that
explains it.  For example, see these:

  db2f77e2bd99 ("PCI: Add ACS quirk for Broadcom BCM57414 NIC")
  3247bd10a450 ("PCI: Add ACS quirk for Intel Root Complex Integrated Endpoints")
  299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports")
  0325837c51cb ("PCI: Add ACS quirk for Zhaoxin multi-function devices")
  76e67e9e0f0f ("PCI: Add ACS quirk for Amazon Annapurna Labs root ports")
  46b2c32df7a4 ("PCI: Add ACS quirk for iProc PAXB")
  01926f6b321b ("PCI: Add ACS quirk for HXT SD4800")

It should be acked by somebody at Intel since this quirk relies on
behavior of the device for VM security.

>  	/* QCOM QDF2xxx root ports */
>  	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
>  	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
> -- 
> 2.26.2
> 
