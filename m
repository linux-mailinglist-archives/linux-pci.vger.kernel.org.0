Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66DF6A3920
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 03:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjB0C4B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Feb 2023 21:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjB0Cz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Feb 2023 21:55:58 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C2612064;
        Sun, 26 Feb 2023 18:55:49 -0800 (PST)
Date:   Mon, 27 Feb 2023 02:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1677466548; bh=s+R+iT0x1iNvvwUvUPl39IwKnJPRvBOzNR/yqTatfOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g127leCTLJI90j4qbQYmqcH3Kqg/0M9NoCbLMiFFthSAFmoPKahi9a9+XpyTNCOBw
         gwbO/NoMW5wL2GziqVMZyP6ECAxs2eQQ6xhrx7jx1v2TfcTHlt4F74SMso6ss5mEnA
         tMZHkZI6YZXfh29V1bbnmfQG8t152oRc5aBWdfOo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Add quirk for platforms running Windows
Message-ID: <67eac531-d808-4fc8-b282-754204b4bad0@t-8ch.de>
References: <20230227021221.17980-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227021221.17980-1-shawn.guo@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Feb 27, 2023 at 10:12:21AM +0800, Shawn Guo wrote:
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
        ^^^
       const

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
