Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C177823E3FC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Aug 2020 00:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHFW1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Aug 2020 18:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgHFW1P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Aug 2020 18:27:15 -0400
Received: from localhost (130.sub-72-107-113.myvzw.com [72.107.113.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D17221E2;
        Thu,  6 Aug 2020 22:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596752834;
        bh=WgdGpbjoOqKRB5xCJJB1QUUR3NAm5AiI/g2A57rj4KI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qPv7UMmumdkk5aGIxvQqVqqb18le/xYKnvT2NLDxW1vNEmC3Ph4Qht7skoNahofop
         f4yilJWzb9U+BSlCfhrRXW+mYxFr3x4aM7SMY6d+2qsXOAomi/LJl0WMvWd4RgfyQy
         b/Rd8PhebQXbHyz/CLBputTdShNapNUxGxWiVOIc=
Date:   Thu, 6 Aug 2020 17:27:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Add Ampere Altra SOC MCFG quirk
Message-ID: <20200806222713.GA704188@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596751055-12316-1-git-send-email-tuanphan@os.amperecomputing.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 06, 2020 at 02:57:34PM -0700, Tuan Phan wrote:
> Ampere Altra SOC supports only 32-bit ECAM reading. Therefore,
> add an MCFG quirk for the platform.

This is interesting.  So this host bridge supports sub 32-bit config
*writes*, but not reads?

I actually don't know whether that complies with the spec or not.  If
config registers are not allowed to have side effects on read, this
*would* be compliant.

PCIe r5.0, sec 7.4, doesn't list any register types with read side
effects, so there shouldn't be any in the registers defined by the
spec.  But I would think device-specific registers could do whatever
they wanted, e.g., reading an interrupt status register or something
could clear it.

And I think sec 7.2.2 about ECAM implicitly requires sub 32-bit
accesses because it mentions the access size and byte enables.

Is this a one-off situation where future hardware will allow sub
32-bit reads and writes?  We don't want a stream of quirks for future
devices.

> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
>  drivers/acpi/pci_mcfg.c  | 20 ++++++++++++++++++++
>  drivers/pci/ecam.c       | 10 ++++++++++
>  include/linux/pci-ecam.h |  1 +
>  3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 54b36b7ad47d..e526571e0ebd 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -142,6 +142,26 @@ static struct mcfg_fixup mcfg_quirks[] = {
>  	XGENE_V2_ECAM_MCFG(4, 0),
>  	XGENE_V2_ECAM_MCFG(4, 1),
>  	XGENE_V2_ECAM_MCFG(4, 2),
> +
> +#define ALTRA_ECAM_QUIRK(rev, seg) \
> +	{ "Ampere", "Altra   ", rev, seg, MCFG_BUS_ANY, &pci_32b_read_ops }
> +
> +	ALTRA_ECAM_QUIRK(1, 0),
> +	ALTRA_ECAM_QUIRK(1, 1),
> +	ALTRA_ECAM_QUIRK(1, 2),
> +	ALTRA_ECAM_QUIRK(1, 3),
> +	ALTRA_ECAM_QUIRK(1, 4),
> +	ALTRA_ECAM_QUIRK(1, 5),
> +	ALTRA_ECAM_QUIRK(1, 6),
> +	ALTRA_ECAM_QUIRK(1, 7),
> +	ALTRA_ECAM_QUIRK(1, 8),
> +	ALTRA_ECAM_QUIRK(1, 9),
> +	ALTRA_ECAM_QUIRK(1, 10),
> +	ALTRA_ECAM_QUIRK(1, 11),
> +	ALTRA_ECAM_QUIRK(1, 12),
> +	ALTRA_ECAM_QUIRK(1, 13),
> +	ALTRA_ECAM_QUIRK(1, 14),
> +	ALTRA_ECAM_QUIRK(1, 15),
>  };
>  
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index 8f065a42fc1a..b54d32a31669 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -168,4 +168,14 @@ const struct pci_ecam_ops pci_32b_ops = {
>  		.write		= pci_generic_config_write32,
>  	}
>  };
> +
> +/* ECAM ops for 32-bit read only (non-compliant) */
> +const struct pci_ecam_ops pci_32b_read_ops = {
> +	.bus_shift	= 20,
> +	.pci_ops	= {
> +		.map_bus	= pci_ecam_map_bus,
> +		.read		= pci_generic_config_read32,
> +		.write		= pci_generic_config_write,
> +	}
> +};
>  #endif
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 1af5cb02ef7f..033ce74f02e8 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -51,6 +51,7 @@ extern const struct pci_ecam_ops pci_generic_ecam_ops;
>  
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>  extern const struct pci_ecam_ops pci_32b_ops;	/* 32-bit accesses only */
> +extern const struct pci_ecam_ops pci_32b_read_ops; /* 32-bit read only */
>  extern const struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
>  extern const struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 1.x & 2.x */
>  extern const struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
> -- 
> 2.18.4
> 
