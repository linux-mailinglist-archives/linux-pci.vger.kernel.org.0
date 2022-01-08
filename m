Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C024880F9
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jan 2022 03:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiAHCqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 21:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiAHCqD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 21:46:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F05C061574
        for <linux-pci@vger.kernel.org>; Fri,  7 Jan 2022 18:46:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D927A61FED
        for <linux-pci@vger.kernel.org>; Sat,  8 Jan 2022 02:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B1DC36AEB;
        Sat,  8 Jan 2022 02:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641609962;
        bh=cspEsY9ZpTyEH7sTDnf18KueqiaVzWPYtEPG2Q9WarE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gT6aY5koueFx45EyjauKhM69vhyf3OZRxAtsie0PRB2VRE/Vheiu52m1Ys38EZRLK
         5t/Li3xjFiZgwJQhjzfgdQS+oyxFveMoR1V54hFPz47xmA+3UOaNRitmHbcsGosiJH
         E4vYBnt3zM3fb+mHnontZNYnYx7Xm+xwpHBtBT3VYFP9qkSTwGW65y9rOYYlt+Jmpa
         v6wOvRPdMasYVrJFLcd9ywwThoeZBG3xMRzcOSl/CbtpPxqn2UQEPbYGcT2klrqoDS
         JFlNT9NM6db0gvy2uDVZJGCLsy3puCQdq/Sw8CGhTepuOFkdfPL7nyiLSDnn6W0NzI
         v2+DYAguVwc2A==
Date:   Fri, 7 Jan 2022 20:45:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Correct misspelled words
Message-ID: <20220108024559.GA440111@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107225942.121484-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 07, 2022 at 10:59:42PM +0000, Krzysztof Wilczyński wrote:
> Fix a number misspelled words, and while at it, correct two phrases used
> to indicate a status of an operation where words used have been cleverly
> truncated and thus always trigger a spellchecking error while performing
> a static code analysis over the PCI tree.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/misc, thanks!

> ---
>  drivers/pci/controller/cadence/pcie-cadence.h | 2 +-
>  drivers/pci/controller/pcie-mediatek-gen3.c   | 2 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
>  drivers/pci/of.c                              | 2 +-
>  drivers/pci/quirks.c                          | 4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 262421e5d917..c8a27b6290ce 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -310,7 +310,7 @@ struct cdns_pcie {
>   *            single function at a time
>   * @vendor_id: PCI vendor ID
>   * @device_id: PCI device ID
> - * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
> + * @avail_ib_bar: Status of RP_BAR0, RP_BAR1 and RP_NO_BAR if it's free or
>   *                available
>   * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
>   * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 17c59b0d6978..7de82da0bd6d 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -303,7 +303,7 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
>  	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
>  
>  	/*
> -	 * Described in PCIe CEM specification setctions 2.2 (PERST# Signal)
> +	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
>  	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
>  	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
>  	 * for the power and clock to become stable.
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 5a03401f4571..9a00448c7e61 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -1262,7 +1262,7 @@ static void epf_ntb_db_mw_bar_cleanup(struct epf_ntb *ntb,
>  }
>  
>  /**
> - * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
> + * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capability
>   * @ntb: NTB device that facilitates communication between HOST1 and HOST2
>   * @type: PRIMARY interface or SECONDARY interface
>   *
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 0b1237cff239..cb2e8351c2cc 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -247,7 +247,7 @@ void of_pci_check_probe_only(void)
>  	else
>  		pci_clear_flags(PCI_PROBE_ONLY);
>  
> -	pr_info("PROBE_ONLY %sabled\n", val ? "en" : "dis");
> +	pr_info("PROBE_ONLY %s\n", val ? "enabled" : "disabled");
>  }
>  EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 003950c738d2..e16bde66e735 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -980,8 +980,8 @@ static void quirk_via_ioapic(struct pci_dev *dev)
>  	else
>  		tmp = 0x1f; /* all known bits (4-0) routed to external APIC */
>  
> -	pci_info(dev, "%sbling VIA external APIC routing\n",
> -	       tmp == 0 ? "Disa" : "Ena");
> +	pci_info(dev, "%s VIA external APIC routing\n",
> +	       tmp == 0 ? "Disabling" : "Enabling");
>  
>  	/* Offset 0x58: External APIC IRQ output control */
>  	pci_write_config_byte(dev, 0x58, tmp);
> -- 
> 2.34.1
> 
