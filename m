Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33A2345D10
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 12:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCWLg4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 07:36:56 -0400
Received: from foss.arm.com ([217.140.110.172]:44326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229670AbhCWLgD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 07:36:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0CD1042;
        Tue, 23 Mar 2021 04:36:02 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B28473F719;
        Tue, 23 Mar 2021 04:36:01 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:35:59 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dilip Kota <eswara.kota@linux.intel.com>
Cc:     robh@kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc/intel-gw: Fix enabling the legacy PCI interrupt
 lines
Message-ID: <20210323113559.GE29286@e121166-lin.cambridge.arm.com>
References: <20210106135540.48420-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106135540.48420-1-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 06, 2021 at 02:55:40PM +0100, Martin Blumenstingl wrote:
> The legacy PCI interrupt lines need to be enabled using PCIE_APP_IRNEN
> bits 13 (INTA), 14 (INTB), 15 (INTC) and 16 (INTD). The old code however
> was taking (for example) "13" as raw value instead of taking BIT(13).
> Define the legacy PCI interrupt bits using the BIT() macro and then use
> these in PCIE_APP_IRN_INT.
> 
> Fixes: ed22aaaede44 ("PCI: dwc: intel: PCIe RC controller driver")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pci/controller/dwc/pcie-intel-gw.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 0cedd1f95f37..ae96bfbb6c83 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -39,6 +39,10 @@
>  #define PCIE_APP_IRN_PM_TO_ACK		BIT(9)
>  #define PCIE_APP_IRN_LINK_AUTO_BW_STAT	BIT(11)
>  #define PCIE_APP_IRN_BW_MGT		BIT(12)
> +#define PCIE_APP_IRN_INTA		BIT(13)
> +#define PCIE_APP_IRN_INTB		BIT(14)
> +#define PCIE_APP_IRN_INTC		BIT(15)
> +#define PCIE_APP_IRN_INTD		BIT(16)
>  #define PCIE_APP_IRN_MSG_LTR		BIT(18)
>  #define PCIE_APP_IRN_SYS_ERR_RC		BIT(29)
>  #define PCIE_APP_INTX_OFST		12
> @@ -48,10 +52,8 @@
>  	PCIE_APP_IRN_RX_VDM_MSG | PCIE_APP_IRN_SYS_ERR_RC | \
>  	PCIE_APP_IRN_PM_TO_ACK | PCIE_APP_IRN_MSG_LTR | \
>  	PCIE_APP_IRN_BW_MGT | PCIE_APP_IRN_LINK_AUTO_BW_STAT | \
> -	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTA) | \
> -	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTB) | \
> -	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTC) | \
> -	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTD))
> +	PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \
> +	PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)
>  
>  #define BUS_IATU_OFFSET			SZ_256M
>  #define RESET_INTERVAL_MS		100

This looks like a significant bug - which in turn raises the question
on how well this driver has been tested.

Dilip, can you review and ACK asap please ?

Thanks,
Lorenzo
