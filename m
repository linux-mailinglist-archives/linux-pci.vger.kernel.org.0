Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF06B116F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 19:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCHSxU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 13:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCHSxQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 13:53:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5DF5DECC;
        Wed,  8 Mar 2023 10:53:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41FF5B81D92;
        Wed,  8 Mar 2023 18:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9494C433EF;
        Wed,  8 Mar 2023 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678301591;
        bh=6u4ouGmDXPS3X05hD5mdCPbvxLPTCxxxqFjo2s4jTxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nOWxDHcn4aOKzSEz3ERVVNCl1NyOYQI2fPgNCuTQljE659tecxzGLVtu1Si6a5jwe
         FrBNz86n1pzVIa8LQMyP2SCqa6ts3wwcXUvVuUAUKng+P5xYd8zYVT77RVQkFOeLtC
         0IabTmFgKprmxTJGQshe1WOhLeSNEyQpCgRqh5Gvy1oAkK1KRuap1iCm5ApwLiWvD0
         /G4l8iQsu1EE6jTnIKGpdRFjV1kP2klDG/ZQ38ZhQ+P1ddzNSEK0bx5sTFVJqYSDso
         xgIcENLIJUFxxHG01MB0zfzzj7/SnHe9deXZVaKVcN8skpMO4Tm88RVlZmoSuG1sgl
         7DUweUpvweClw==
Date:   Wed, 8 Mar 2023 12:53:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Add quirk for platforms running Windows
Message-ID: <20230308185310.GA1030878@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227021221.17980-1-shawn.guo@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 27, 2023 at 10:12:21AM +0800, Shawn Guo wrote:
> Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
> host bridge windows") introduced a check to remove host bridge register
> resources for all arm64 platforms, with the assumption that the PNP0A03
> _CRS resources would always be host bridge registers and never as windows
> on arm64.
> 
> The assumption stands true until Qualcomm Snapdragon Windows laptops
> emerge.  These laptops describe host bridge windows in PNP0A03 _CRS
> resources instead.  For example, the Microsoft Surface Pro X has host
> bridges defined as
> 
>     Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
>     Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> 
>     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>     {
>         Name (RBUF, ResourceTemplate ()
>         {
>             Memory32Fixed (ReadWrite,
>                 0x60200000,         // Address Base
>                 0x01DF0000,         // Address Length
>                 )
>             WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
>                 0x0000,             // Granularity
>                 0x0000,             // Range Minimum
>                 0x0001,             // Range Maximum
>                 0x0000,             // Translation Offset
>                 0x0002,             // Length
>                 ,, )
>         })
>         Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
>     }
> 
> The Memory32Fixed holds a host bridge window, but it's not properly
> defined as a "producer" resource.  Consequently the resource gets
> removed by kernel, and the BAR allocation fails later on:
> 
>     [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
>     [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
>     [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
>     [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> 
> This eventually prevents the PCIe NVME drive from being accessible.
> 
> Add a quirk for these platforms to avoid the resource being removed.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> We are running into the issue on more devices than just Surface Pro X
> now, so trying to sort it out with a quirk as suggested by Lorenzo [1].

One thing I don't like about this application of quirks is that the
list of affected platforms is likely to grow, which is an ongoing
burden for users and developers.

Can we have a conversation with Qualcomm about how they *intend* this
to work?  Linux is probably doing something wrong (interpreting
something differently than Windows does), and if we could fix that, we
have a better chance of future platforms working without quirks.

> [1] https://lore.kernel.org/all/20210527093200.GA16444@lpieralisi/
> 
>  arch/arm64/kernel/pci.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 2276689b5411..896dbd028b67 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -109,16 +109,42 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  	return 0;
>  }
>  
> +#define QCOM_DSDT_QUIRK "Host bridge windows in PNP0A03 _CRS"
> +
> +static struct acpi_platform_list qcom_platlist[] = {
> +	/* Thinkpad X13s */
> +	{ "LENOVO", "SDM8280 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
> +	/* Microsoft Surface Pro 9 (5G) and Windows Dev Kit 2023 */
> +	{ "QCOMM ", "SDM8280 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
> +	/* Microsoft Surface Pro X */
> +	{ "QCOMM ", "SDM8180 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
> +	{ }
> +};
> +
>  static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>  {
>  	struct resource_entry *entry, *tmp;
>  	int status;
> +	int idx;
>  
>  	status = acpi_pci_probe_root_resources(ci);
> +
> +	/*
> +	 * Most arm64 platforms that do not run Windows describe host bridge
> +	 * registers in PNP0A03 _CRS resources, but some like Qualcomm
> +	 * Snapdragon Windows laptops describe host bridge windows in there.
> +	 * We do not want to destroy the resources for these platforms.
> +	 */
> +	idx = acpi_match_platform_list(qcom_platlist);
> +	if (idx >= 0)
> +		goto done;
> +
>  	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
>  		if (!(entry->res->flags & IORESOURCE_WINDOW))
>  			resource_list_destroy_entry(entry);
>  	}
> +
> +done:
>  	return status;
>  }
>  
> -- 
> 2.17.1
> 
