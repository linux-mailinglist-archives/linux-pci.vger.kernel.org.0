Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EC76F0A34
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbjD0QsV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 12:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243883AbjD0QsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 12:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB9E1FD3;
        Thu, 27 Apr 2023 09:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DCFF618B3;
        Thu, 27 Apr 2023 16:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BEEC433D2;
        Thu, 27 Apr 2023 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682614098;
        bh=T0rLCI9XgjgU7NCOg8dPs1VgXJlChr+LXaa8cgXxdVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N/tIPz/i6iljBz++XKfKc8EeLHEZ8BILNYPh4jQvZtEIYzFOmutcogNmSBE30/5II
         lq8h7uyIoRxPSanGJLayU1D654Q6zUBRtY//75DXxqSIJKHGnDL2b96OPeQ2OMfOK4
         ojeg1qXGFC1B+Ro9lAi5Dw6fUqWMxYiR5w9TM0h2qXXuWjt7PO2RgYEOLYpkTAzTED
         2gEN31zHe0hrQw2o79jE7MD0H+u0DYvW6hFI1y0CmUWrze1IrRkwQdj16Rixie9zWM
         08VEloLZm7+x1CqCXoVYq1DkEA93aXC6oY5saCehG0avsTv6mXMKWfQ4F2wPcSK5sS
         p7Qcue3ikQpZg==
Date:   Thu, 27 Apr 2023 11:48:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Richard gong <richard.gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Message-ID: <20230427164816.GA255750@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427053338.16653-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 27, 2023 at 12:33:36AM -0500, Mario Limonciello wrote:
> s2idle previously worked on this system, but it regressed in kernel
> 6.4 due to commit 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN
> index 0 for driver probe").
> 
> The reason for the regression is that before this commit the SMN
> communication was hardcoded, but after amd_smn_read() is used which
> relies upon the misc PCI ID used by DF function 3 being included in
> a table.  The ID was missing for model 78h, so this meant that the
> amd_smn_read() wouldn't work.
> 
> Add the missing ID into amd_nb, restoring s2idle on this system.
> 
> Fixes: 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN index 0 for driver probe")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Grudgingly, because this really isn't a maintainable strategy:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_ids.h

> ---
>  arch/x86/kernel/amd_nb.c | 2 ++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 4266b64631a4..7e331e8f3692 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -36,6 +36,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
>  #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
>  #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
> +#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
>  
>  /* Protect the PCI config register pairs used for SMN. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -79,6 +80,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
>  	{}
>  };
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 45c3d62e616d..95f33dadb2be 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -567,6 +567,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>  #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
>  #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
> +#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
> -- 
> 2.34.1
> 
