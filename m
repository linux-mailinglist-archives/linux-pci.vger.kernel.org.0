Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615A03DDD07
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 18:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhHBQEq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 12:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhHBQEq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 12:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42CFC610FF;
        Mon,  2 Aug 2021 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627920276;
        bh=wTsKAJkhhZxowPgSi1Utfu7yQXZgGHcpluFKm4xQcP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BkUzgygFMdkfMobhw13cAvRcAwlwiBYw2UYzFjYK7Pt+3Ig8xn8s7qiJd0WfmGraX
         d4P1DTYj3a3tiaFql9PL5IJO+LADACRE4nz6cgH2bUMYoe1CYAof1DH/RwaA4Alv/P
         x3cL/9p2U1QMqVBlDdwsCTaKU0aC4Cba3iJeNknqR7/r1BnBHnI3lMxO/Yz5mvhU6r
         +QT11D83RXZKwmQ6Hwxj+Lk3vd/lqcVmYn5uIze6P/3nrhuiIBCvBJjui7zL+E3iFz
         N74dHnloPrRu3wXS0SP0DND+L9TCHKVrmxiD5MHqJXEhKqrxjRghsOCkDNpe3R5DVJ
         UMaIEUdQ4bGqQ==
Date:   Mon, 2 Aug 2021 11:04:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wasim Khan <wasim.khan@oss.nxp.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com,
        Wasim Khan <wasim.khan@nxp.com>
Subject: Re: [PATCH v2] PCI: Add ACS quirk for NXP LX2160 and LX2162 C/E/N
 platforms
Message-ID: <20210802160434.GA1383714@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802155644.3089929-1-wasim.khan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 02, 2021 at 05:56:44PM +0200, Wasim Khan wrote:
> From: Wasim Khan <wasim.khan@nxp.com>
> 
> LX2160C : security features + CAN-FD
> LX2160E : security features + CAN
> LX2160N : without security features + CAN
> LX2162C : security features + CAN-FD
> LX2162E : security features + CAN
> LX2162N : without security features + CAN

Can you associate these with the device IDs, please?  Ideally a
one-line comment in the code, but if that doesn't fit nicely, at least
include the device ID for each here in the commit log.

> Root Ports in NXP LX2160 and LX2162 where each Root Port
> is a Root Complex with unique segment numbers do provide
> isolation features to disable peer transactions and
> validate bus numbers in requests, but do not provide an
> actual PCIe ACS capability.
> 
> Enable ACS quirk for NXP LX2160C/E/N and LX2162C/E/N platforms
> 
> Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
> ---
> Changes in v2:
> - removed duplicate entry of 0x8d80 and 0x8d88
> 
>  drivers/pci/quirks.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 24343a76c034..1ad158066d39 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4787,6 +4787,23 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
>  	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
>  	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d90, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d91, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8da1, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8db0, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d92, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d82, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d93, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8da0, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8db1, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d99, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d8a, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d9b, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8da8, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8db9, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d98, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8db8, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d9a, pci_quirk_nxp_rp_acs },

Sort these in order of device ID so it's easier to see duplicates and
to find the one you're looking for.

>  	/* Zhaoxin Root/Downstream Ports */
>  	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID, pci_quirk_zhaoxin_pcie_ports_acs },
>  	{ 0 }
> -- 
> 2.25.1
> 
