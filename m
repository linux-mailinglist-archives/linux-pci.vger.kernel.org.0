Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F1853B01B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiFAWbB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 18:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiFAWbB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 18:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7ED101CB;
        Wed,  1 Jun 2022 15:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12B9660C98;
        Wed,  1 Jun 2022 22:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1C1C385A5;
        Wed,  1 Jun 2022 22:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654122658;
        bh=Is0lHUzMG8//soZVMgz0ruaa6kON13kwXAtlgdtJw6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nGsYQX3k61YJkwTPy7HflD3pb9VyTIcNuEwF6KgKAgIfAXRZWcDtnrSLg994KU1mc
         Wew5o1hEVzoOUJjWmMmTW6AbA6NK364G4371JXHvAOVC5kPYnQW9ZLE2z4hQAmBUio
         H0zbgpAAcL5GUlmjy8vcAc1iVGNANcpIFFT7rMkny31SGA02nBZefeW4YTw/cpJW/Z
         Hfdx58KX+G0MGoKv5vGWpEXfjhBFshZDQ4pSd9JPl545mjFgH/Pg0F2xNe/dN9Cx+n
         FjtijbkCrnHOkD7qWqzI0zieHUo6bmmpXfZpH9wvlAI0EWi7EALMHUWpaM6dkIUCrg
         9hZ0e247MZ4fQ==
Date:   Wed, 1 Jun 2022 17:30:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        babu.moger@amd.com
Subject: Re: [PATCH 1/2] x86/amd_nb: Add AMD Family 19h A0-AF IDs
Message-ID: <20220601223056.GA10215@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601172121.18612-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 01, 2022 at 12:21:18PM -0500, Mario Limonciello wrote:
> commit 4fb0abfee424 ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh)
> and (A0h-AFh) PCI IDs") had claimed to add the IDs for models A0h-AFh,
> but it appears to only have added the models 10h-1Fh.
> 
> Add the actual IDs for A0-AF which are needed for SMN communication to
> work properly in amd_nb.
> 
> Fixes: 4fb0abfee424 ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and (A0h-AFh) PCI IDs")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/amd_nb.c | 5 +++++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 190e0f763375..cc8c7cfa9068 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -25,11 +25,13 @@
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
> +#define PCI_DEVICE_ID_AMD_19H_MA0H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
>  #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
>  #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> +#define PCI_DEVICE_ID_AMD_19H_MA0H_DF_F4 0x1728
>  
>  /* Protect the PCI config register pairs used for SMN. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -43,6 +45,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_ROOT) },
>  	{}
>  };
>  
> @@ -67,6 +70,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3) },
>  	{}
>  };
>  
> @@ -85,6 +89,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>  	{}
>  };
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 0178823ce8c2..05b4c67a8a2a 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -560,6 +560,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
> +#define PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3 0x1727

This file is nominally sorted by numeric device ID inside the vendor
section, but that has really deteriorated over time.

I can't quite figure out the rationale for deciding whether to put
things in amd_nb.c vs pci_ids.h.  The IDs in amd_nb.c look basically
the same as this one.

Normally we put things in pci_ids.h if they are used more than one
place.  PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3 looks like it's only used in
one place.

>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
> -- 
> 2.34.1
> 
