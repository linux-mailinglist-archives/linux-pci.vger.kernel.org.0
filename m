Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03606423138
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 22:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhJEUEW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 16:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhJEUEV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 16:04:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 606C26120A;
        Tue,  5 Oct 2021 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633464150;
        bh=m2Pch5PBNpHn9fpdx33/OXtGVAsq5SNn8+Ee+4hkSvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2eBNKq0Ek/OFeyD3p7RsKRBXx+3RsdkR8iD1OSFUXnriuwOeB98FR40Sbg1ugWRs
         X1HUcb3mKDBrS/RotPZ4xg+LowBFy/hQVKTquPfSzERCO3scHEK79IyHzbUtOAIgWQ
         7UhPphi/d3DkY8k1QIuSSz9cXlsQnPqYT4RNfQ98mHpL2VoFMRqXVxK7Sa07VvQUDp
         PKLpxtDEA4j5VSFr1ELLTmXN1THAPsnubILodciQqYzRZeayQFHL8H3N2dD1O0qomj
         8RQ1eik93nT1nEIVI3lMs6HLkS5BFc4tnU8x/S0D3knTHH1l/pLRQLEnvnxZF9nWtx
         fqDmyybsHgpxQ==
Received: by pali.im (Postfix)
        id DDD28812; Tue,  5 Oct 2021 22:02:27 +0200 (CEST)
Date:   Tue, 5 Oct 2021 22:02:27 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     bhelgaas@google.com, Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
Message-ID: <20211005200227.ltl6owwksfn7l4xx@pali>
References: <20210826071557.29239-1-jeremy.linton@arm.com>
 <20210826071557.29239-4-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826071557.29239-4-jeremy.linton@arm.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 26 August 2021 02:15:56 Jeremy Linton wrote:
> Now that there is a bcm2711 quirk, it needs to be enabled when the
> MCFG is missing. Use an ACPI namespace _DSD property
> "linux-ecam-quirk-id" as an alternative to the MCFG OEM.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/acpi/pci_mcfg.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 53cab975f612..04c517418365 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>  	ALTRA_ECAM_QUIRK(1, 13),
>  	ALTRA_ECAM_QUIRK(1, 14),
>  	ALTRA_ECAM_QUIRK(1, 15),
> +
> +	{ "bc2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
> +	  DEFINE_RES_MEM(0xFD500000, 0xA000) },

Hello!

According to discussion described in email [1], adding a new MCFG quirk
(like above) into kernel requires adding some errata entry for
documenting buggy HW.

But this patch series does not introduce any new errata entry.

Bjorn, could you look at how to properly document these "hw bugs"?
I guess there would be lot of more requests for adding MCFG quirks as
now according to [1], doors are open for them. And it is possible that
after more years nobody would be able to maintain these quirks if would
not be properly documented.

[1] - https://lore.kernel.org/linux-pci/20210325131231.GA18590@e121166-lin.cambridge.arm.com/

>  };
>  
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> @@ -198,8 +201,22 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>  	u16 segment = root->segment;
>  	struct resource *bus_range = &root->secondary;
>  	struct mcfg_fixup *f;
> +	const char *soc;
>  	int i;
>  
> +	/*
> +	 * This may be a machine with a PCI/SMC conduit, which means it doesn't
> +	 * have an MCFG. Use an ACPI namespace definition instead.
> +	 */
> +	if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
> +					 "linux-ecam-quirk-id", &soc)) {
> +		if (strlen(soc) != ACPI_OEM_ID_SIZE)
> +			dev_err(&root->device->dev, "ECAM quirk should be %d characters\n",
> +				ACPI_OEM_ID_SIZE);
> +		else
> +			memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
> +	}
> +
>  	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
>  		if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
>  			if (f->cfgres.start)
> -- 
> 2.31.1
> 
