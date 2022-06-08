Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D457543D6E
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 22:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiFHUN6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 16:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiFHUNx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 16:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A5138BE7;
        Wed,  8 Jun 2022 13:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 494AB61C5D;
        Wed,  8 Jun 2022 20:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B37FC34116;
        Wed,  8 Jun 2022 20:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654719230;
        bh=aHbJvLTAEf+/7/LFJuiWzns2/o0UaL+AXHjd4hTV9QU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lKrfa2ISi0opyVqfcsNP1Mie+TBDBsXxcl6dzw04KUZzFd5CQNf17qR7Ju85E49/P
         Ev5AfsylLCvVnvJ5ax/Wvih3+2DVdRkvY4yXLwwqbksKlQw765cHdwcDC1Cin5Q8jH
         dQ4MduN9F4MGyNreFN505y41POqwCWkPjk9+eqeBFk6236e4avPpOU7mT0D7XYOipj
         G8e7tMGWEv2/fDwahLfb/MNiMH9rVA22OJNUx26dHxYL/wnBfSLlMnRoFxbjLnnvom
         29PlEwpz9xBCJ57M7/LtWTf2FmW5tn7HJ4rhqy0tuYKA3VifldFNDiDCUtyJRlo5fr
         S5+RmyH2Uz/ug==
Date:   Wed, 8 Jun 2022 15:13:47 -0500
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
        linux-hwmon@vger.kernel.org, babu.moger@amd.com
Subject: Re: [PATCH v2 1/6] x86/amd_nb: Add AMD Family 17h A0-AF IDs
Message-ID: <20220608201347.GA417504@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602201137.1415-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 03:11:32PM -0500, Mario Limonciello wrote:
> Add support for SMN communication on Family 17h Model A0h.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h

> ---
> v1->v2:
>  * Drop fixes tag
>  * Fix commit message and definitions for s/17/19/
> ---
>  arch/x86/kernel/amd_nb.c | 5 +++++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 190e0f763375..60c7bd525237 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -19,12 +19,14 @@
>  #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
>  #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
>  #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
> +#define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
> +#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4 0x1728
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
>  #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
>  #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
> @@ -41,6 +43,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
>  	{}
> @@ -61,6 +64,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> @@ -81,6 +85,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 0178823ce8c2..ec1c226d13e6 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -556,6 +556,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
> +#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3 0x1727
>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
>  #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
> -- 
> 2.34.1
> 
