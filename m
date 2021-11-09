Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8257C44B080
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 16:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbhKIPjm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 10:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhKIPjl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 10:39:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92E1C61205;
        Tue,  9 Nov 2021 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636472215;
        bh=BVyEi1q18iAZndYF8L3mnCIhR5p7GvwcJ1qjVq3aPPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pGJpreiSXn8AE+iAkrtOqhlrz0h0lzWRPxDauCTgO2Y79JN4/n5KYksS3Yas5EjLy
         31nvWt9c7ICo2sxOmFbCRJN0WchpxJw5MydUx2ngcLw11oU3TUPfaEAy07rSc0oLZc
         Tx+kHyAgRasWYrgwT9tjbXUA1U6gGjQnGc01fIvsC1retaf/myHJRhafoFRnDdIZnE
         z7T73iM8Y0Vz4eGnn49+FEzm9R/P/raTMk3j+Z15evaDOWLmWDkA+Za7+h9MfwFIE+
         eKB/NGVuwVeQ4P0y6kXdGaiCyhLP+XH0lHS82a8+c5tE4HC42P95kaUDn2ZkKdmr76
         rhjuOgpkup4qw==
Date:   Tue, 9 Nov 2021 09:36:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Babu Moger <babu.moger@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        clemens@ladisch.de, jdelvare@suse.com, linux@roeck-us.net,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and
 (A0h-AFh) PCI IDs
Message-ID: <20211109153654.GA1147640@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163640828133.955062.18349019796157170473.stgit@bmoger-ubuntu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 08, 2021 at 03:51:21PM -0600, Babu Moger wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Add the new PCI Device IDs to support new generation of AMD 19h family of
> processors.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_ids.h

> ---
>  arch/x86/kernel/amd_nb.c |    5 +++++
>  include/linux/pci_ids.h  |    1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index c92c9c774c0e..f3e885f3dd0f 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -19,12 +19,14 @@
>  #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
>  #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
>  #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
> +#define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
> +#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
>  #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> @@ -39,6 +41,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
>  	{}
>  };
> @@ -61,6 +64,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>  	{}
> @@ -78,6 +82,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 011f2f1ea5bb..b5248f27910e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -555,6 +555,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
> +#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
> 
> 
