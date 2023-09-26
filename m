Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C644E7AF569
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 22:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjIZUmB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 16:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjIZUmA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 16:42:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C029120;
        Tue, 26 Sep 2023 13:41:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EC6C433C7;
        Tue, 26 Sep 2023 20:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695760913;
        bh=N2QpnX4X8HwQVgjzeeJZ7MIIAWZJSRZ5g3bKytjYUhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZS5hgKLGvGY2GRwRYPGitNJPG8okzPN1/yY2HHQ9wbn23wvKmBUbmDlGgIIawb2C/
         JNB+b7DgYdDU7T2pcfaDyiKt0HD3AYyHZzlNP9G1p+0yS23P9kdRFKhk/csFQ9a4Rg
         +1j0OLB/N3NS+mV7Kb7ss1xGc8jEeCoVmNwZ67FwY9M6X/XSPtUVXsm5t7vkqsF09v
         aOBZ8Td9pKgS+R3O5hWy0VzsXXBWBmm3nn6zp6cnbIhS8JgkCeirLOwVBqM7aY9Ogy
         LcAzVocL9rMpZ8yp1aK1B8Q+n81hTFfD0OqoPL7zpSYnqBnuRS+sahImFU7xaYDDF1
         K6GxHr0gvKzBw==
Date:   Tue, 26 Sep 2023 15:41:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Suma Hegde <suma.hegde@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, borislav.petkov@amd.com,
        hdegoede@redhat.com, nchatrad@amd.com,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH v2] x86/amd_nb: Add AMD Family MI300 PCI IDs
Message-ID: <20230926204151.GA427239@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926051932.193239-1-suma.hegde@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 26, 2023 at 05:19:32AM +0000, Suma Hegde wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> Add new Root, Device 18h Function 3, and Function 4 PCI IDS
> for AMD F19h Model 90h-9fh (MI300A).
> 
> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> Signed-off-by: Suma Hegde <suma.hegde@amd.com>

As long as the pci_ids.h addition meets the criteria at the top of the
file, which I assume it does because you add other IDs to amd_nb.c:

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# for pci_ids.h

> ---
> v1 of this patch was submitted as part of
> https://lore.kernel.org/linux-edac/20230720125425.3735538-1-muralimk@amd.com/T/#m577beb44c3eceb0371cb0306c9ea0cb51f16b16d
> Submitting this patch separately because this change is needed for HSMP
> driver submitted at
> https://lore.kernel.org/platform-driver-x86/166b4e9d-71e7-a95d-e11a-895f2c5dd2f8@linux.intel.com/T/#u to work on mi300 platform.
> 
>  arch/x86/kernel/amd_nb.c | 5 +++++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 356de955e78d..10c2a3c9114e 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -27,6 +27,7 @@
>  #define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
>  #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
> +#define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
>  
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4	0x15ec
> @@ -43,6 +44,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
>  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
>  #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
> +#define PCI_DEVICE_ID_AMD_MI300_DF_F4		0x152c
>  
>  /* Protect the PCI config register pairs used for SMN. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -62,6 +64,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
>  	{}
>  };
>  
> @@ -93,6 +96,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
>  	{}
>  };
>  
> @@ -115,6 +119,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
>  	{}
>  };
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 5fb3d4c393a9..91b457de262e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -579,6 +579,7 @@
>  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
> +#define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
> -- 
> 2.25.1
> 
