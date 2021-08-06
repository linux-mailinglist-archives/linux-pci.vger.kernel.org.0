Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC6A3E318D
	for <lists+linux-pci@lfdr.de>; Sat,  7 Aug 2021 00:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245427AbhHFWNP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 18:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231577AbhHFWNO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 18:13:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 291E761179;
        Fri,  6 Aug 2021 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628287978;
        bh=ntBblkw27DzG1SDuhwy9/ADL5F68jkVcbJJtcTu4720=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nTUpXNwatcS8bNHyLfP0yBfT8MRCkrXawEWlGkn+Y7ZWiwzgz/Fo7WGrVHb5Zu2Nf
         /7g+YxnSxlnrDJ3YyFMOLHgmurdVnQRU59bID88Ia6SAOlaKPyax6Yua+aqsxPfB5d
         zL2mZ/ospnIZW4FLU82UBzvdaOLSkK8ls6vRWHWyANh3AMakQAeDkQyo/uBIdVddZ3
         w/DuweOx1bZrolnnKh2FbjE4lQLirPjj0/jWNTmdiFe0N4Z04Gmqg+ZRKNr5qLLVJ6
         P5FpBeQFVJ5tcEgY2dnjA9ymLy7XqOmHQulbUH2rH8LWMsISaGTeC8t/IREtcqYSSL
         aejk4FTUA+TiQ==
Date:   Fri, 6 Aug 2021 17:12:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI/ACPI: Add new quirk detection, enable bcm2711
Message-ID: <20210806221256.GA1891371@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805211200.491275-4-jeremy.linton@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, this or similar would match history:

  PCI/ACPI: Add Broadcom bcm2711 MCFG quirk

On Thu, Aug 05, 2021 at 04:12:00PM -0500, Jeremy Linton wrote:
> Now that we have a bcm2711 quirk, we need to be able to
> detect it when the MCFG is missing. Use a namespace
> property as an alternative to the MCFG OEM.

Rewrap to use ~75 columns.

Mention the DT namespace property here.

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pci_mcfg.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 53cab975f612..7d77fc72c2a4 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>  	ALTRA_ECAM_QUIRK(1, 13),
>  	ALTRA_ECAM_QUIRK(1, 14),
>  	ALTRA_ECAM_QUIRK(1, 15),
> +
> +	{ "bcm2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
> +	  DEFINE_RES_MEM(0xFD500000, 0xA000) },
>  };
>  
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> @@ -198,8 +201,19 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>  	u16 segment = root->segment;
>  	struct resource *bus_range = &root->secondary;
>  	struct mcfg_fixup *f;
> +	const char *soc;
>  	int i;
>  
> +	/*
> +	 * This could be a machine with a PCI/SMC conduit,
> +	 * which means it doens't have MCFG. Get the machineid from
> +	 * the namespace definition instead.

s/SMC/SMCCC/ ?  Cover letter uses SMCCC (not sure it's relevant anyway)
s/doens't/doesn't/

Rewrap comment to use ~80 columns.

Seems pretty reasonable that a platform without standard ECAM might
not have MCFG, since MCFG basically implies ECAM.

Is "linux,pcie-quirk" the right property to look for?  It doesn't
sound very generic, and it doesn't sound like anything related to
ECAM.  Is it new?  I don't see it in the tree yet.  Should it be in
Documentation/devicetree/bindings/pci/pci.txt so we don't get a
different property name for every new platform?

> +	 */
> +	if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
> +					 "linux,pcie-quirk", &soc)) {
> +		memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
> +	}
> +
>  	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
>  		if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
>  			if (f->cfgres.start)
> -- 
> 2.31.1
> 
