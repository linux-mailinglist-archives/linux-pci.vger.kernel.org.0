Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDB774DE3F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jul 2023 21:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjGJTdG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 15:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjGJTcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 15:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E201B1;
        Mon, 10 Jul 2023 12:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54799611C0;
        Mon, 10 Jul 2023 19:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C36C433C8;
        Mon, 10 Jul 2023 19:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689017569;
        bh=VO939+UHAARObDvVdftwDAAwyOD9ujQLDJhFUZ6alak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c6iRjdZfW5RwF8Ejv599j9TjVkZEqLIm9tpq6ajwWtLhko9+fB4WUIks0zTOr6t9X
         7pF59S+7gk3oUTleeOvgVfrxgzGfvApH4ESv0AH1B/aQjfCDR+OcWIBz8OXeG7MHLN
         g+gX+TpHXhyq/A0KxFBFkB33yBppE3X0PtkFJT3PjtJz7rCKoxsFxrwMvZwURav2+l
         agraie9m/K/LIt9uLu/L09bqJS7vjNcIJVYicajvDK2VLXnslD82bCGELP6S36KwvE
         kIFaELsw0CzU+iZ4NJ3V5iRGst4DeOUeoBeMPgIegsHUx8U5KziSEewKvdPMezuOTB
         LO87S2WT3h20Q==
Date:   Mon, 10 Jul 2023 14:32:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        stable@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>
Subject: Re: [PATCH v6 1/1] PCI: Avoid putting some root ports into D3 on
 some Ryzen chips
Message-ID: <20230710193247.GA218021@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708214457.1229-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 08, 2023 at 04:44:57PM -0500, Mario Limonciello wrote:
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> sets the policy that all PCIe ports are allowed to use D3.  When
> the system is suspended if the port is not power manageable by the
> platform and won't be used for wakeup via a PME this sets up the
> policy for these ports to go into D3hot.
> 
> This policy generally makes sense from an OSPM perspective but it leads
> to problems with wakeup from suspend on laptops with AMD chips:
> 
> - On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
>   interrupt.
> - On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
> 
> Add a quirk for the PCI device ID used by the problematic root port on
> both chips to ensure that these root ports are not put into D3hot at
> suspend.

What is problematic about these root ports?  Is this a hardware
erratum?  Some corner of the ACPI spec that allows undefined behavior?

Does AMD have any guidance about generic ways to use D3, or does AMD
expect to add quirks piecemeal as problems are discovered?  How does
Windows handle all this?

Adding quirks as we discover random devices that don't behave
correctly for reasons unknown is not very sustainable.

Bjorn

> Cc: stable@vger.kernel.org # 6.1+
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/quirks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 321156ca273d5..e0346073e5855 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3867,6 +3867,22 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>  			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>  			       quirk_apple_poweroff_thunderbolt);
> +
> +/*
> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
> + * may cause problems when the system attempts wake up from s2idle.
> + *
> + * On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
> + * interrupt.
> + * On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
> + */
> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
> +{
> +	if (!acpi_pci_power_manageable(pdev))
> +		pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
>  #endif
>  
>  /*
> -- 
> 2.34.1
> 
