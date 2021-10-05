Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19DB422BED
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 17:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhJEPMf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 11:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhJEPMe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 11:12:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7604613AC;
        Tue,  5 Oct 2021 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633446644;
        bh=Oj/dpsXfZsdFT7IwiB6sdPRCjBt10BrnkG8D+uo6sIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AufutoAB69XX17b/4aQLtRhiBG9Avh+kvxdspsskno6fEhAuWl4qN+adoAG9BKH2P
         PyXghsGrmDUcR7jDXCAFw++X8BZsXNYN7zOR53H1AmRYXgM6JpRZGBx7nA5cFD+fGY
         4/3jwswfV3hInmbo80Ko1w6scY0FmY23rBNsnUHrP34WCluoZYylOrXW8+BF3e2pau
         ms6H1zZZrVQhH6kpk5U2zKhSbUrwIHZqUAEm3Jh5kcQCa1RNbyruYlvMkxT0hiQ7PI
         ZcFUN0Vcl2HsjPrKsrN2er50Qnr/0+QMiPO3ME2XqfLxeergohRnJJ+gT53QLfYgEj
         lV4jvS5wK36sg==
Date:   Tue, 5 Oct 2021 10:10:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
Message-ID: <20211005151042.GA1083482@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826071557.29239-4-jeremy.linton@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 26, 2021 at 02:15:56AM -0500, Jeremy Linton wrote:
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

From a reviewing perspective, it's not obvious why soc must be exactly
ACPI_OEM_ID_SIZE.  Does that imply space-padding in the DT string or
something?

Is there any documentation for this DT property?

Also not obvious why strlen() is safe here.  I mean, I looked a couple
levels deep in fwnode_property_read_string(), but whatever guarantees
null termination is buried pretty deep.

It seems a little weird to use an MCFG quirk mechanism when there's no
MCFG at all on this platform.

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
