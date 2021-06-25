Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3F63B4217
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFYLHB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 07:07:01 -0400
Received: from foss.arm.com ([217.140.110.172]:53246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhFYLG4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 07:06:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A208CED1;
        Fri, 25 Jun 2021 04:04:35 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC2183F694;
        Fri, 25 Jun 2021 04:04:34 -0700 (PDT)
Date:   Fri, 25 Jun 2021 12:04:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/3] PCI: aardvark: Fix checking for PIO status
Message-ID: <20210625110429.GA17337@lpieralisi>
References: <20210624213345.3617-1-pali@kernel.org>
 <20210624213345.3617-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210624213345.3617-3-pali@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 24, 2021 at 11:33:44PM +0200, Pali Rohár wrote:

[...]

> -static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> +static int advk_pcie_check_pio_status(struct advk_pcie *pcie, u32 *val)
>  {
>  	struct device *dev = &pcie->pdev->dev;
>  	u32 reg;
> @@ -472,15 +476,50 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
>  	status = (reg & PIO_COMPLETION_STATUS_MASK) >>
>  		PIO_COMPLETION_STATUS_SHIFT;
>  
> -	if (!status)
> -		return;
> -
> +	/*
> +	 * According to HW spec, the PIO status check sequence as below:
> +	 * 1) even if COMPLETION_STATUS(bit9:7) indicates successful,
> +	 *    it still needs to check Error Status(bit11), only when this bit
> +	 *    indicates no error happen, the operation is successful.
> +	 * 2) value Unsupported Request(1) of COMPLETION_STATUS(bit9:7) only
> +	 *    means a PIO write error, and for PIO read it is successful with
> +	 *    a read value of 0xFFFFFFFF.
> +	 * 3) value Completion Retry Status(CRS) of COMPLETION_STATUS(bit9:7)
> +	 *    only means a PIO write error, and for PIO read it is successful
> +	 *    with a read value of 0xFFFF0001.
> +	 * 4) value Completer Abort (CA) of COMPLETION_STATUS(bit9:7) means
> +	 *    error for both PIO read and PIO write operation.
> +	 * 5) other errors are indicated as 'unknown'.
> +	 */
>  	switch (status) {
> +	case PIO_COMPLETION_STATUS_OK:
> +		if (reg & PIO_ERR_STATUS) {
> +			strcomp_status = "COMP_ERR";
> +			break;
> +		}
> +		/* Get the read result */
> +		if (val)
> +			*val = advk_readl(pcie, PIO_RD_DATA);
> +		/* No error */
> +		strcomp_status = NULL;
> +		break;
>  	case PIO_COMPLETION_STATUS_UR:
> -		strcomp_status = "UR";
> +		if (val) {
> +			/* For reading, UR is not an error status */
> +			*val = CFG_RD_UR_VAL;
> +			strcomp_status = NULL;
> +		} else {
> +			strcomp_status = "UR";
> +		}
>  		break;
>  	case PIO_COMPLETION_STATUS_CRS:
> -		strcomp_status = "CRS";
> +		if (val) {
> +			/* For reading, CRS is not an error status */
> +			*val = CFG_RD_CRS_VAL;

Need Bjorn's input on this. I don't think this is what is expected from
from a root complex according to the PCI specifications (depending on
whether CSR software visibility is supported or not).

Here we are fabricating a CRS completion value for all PCI config read
transactions that are hitting a CRS completion status (and that's not
the expected behaviour according to the PCI specifications and I don't
think that's correct).

> +			strcomp_status = NULL;
> +		} else {
> +			strcomp_status = "CRS";
> +		}
>  		break;
>  	case PIO_COMPLETION_STATUS_CA:
>  		strcomp_status = "CA";
> @@ -490,6 +529,9 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
>  		break;
>  	}
>  
> +	if (!strcomp_status)
> +		return 0;
> +
>  	if (reg & PIO_NON_POSTED_REQ)
>  		str_posted = "Non-posted";
>  	else
> @@ -497,6 +539,8 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
>  
>  	dev_err(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
>  		str_posted, strcomp_status, reg, advk_readl(pcie, PIO_ADDR_LS));
> +
> +	return -EFAULT;
>  }
>  
>  static int advk_pcie_wait_pio(struct advk_pcie *pcie)
> @@ -703,8 +747,17 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  						 size, val);
>  
>  	if (advk_pcie_pio_is_running(pcie)) {
> -		*val = 0xffffffff;
> -		return PCIBIOS_SET_FAILED;
> +		/*
> +		 * For PCI_VENDOR_ID register, return Completion Retry Status
> +		 * so caller tries to issue the request again insted of failing
> +		 */
> +		if (where == PCI_VENDOR_ID) {
> +			*val = CFG_RD_CRS_VAL;
> +			return PCIBIOS_SUCCESSFUL;

Mmmm..here we are faking a CRS completion value to coerce the kernel
into believing a CRS completion was received (which is not necessarily
true) ?

if advk_pcie_pio_is_running(pcie) == true, is that an HW error ?

Lorenzo

> +		} else {
> +			*val = 0xffffffff;
> +			return PCIBIOS_SET_FAILED;
> +		}
>  	}
>  
>  	/* Program the control register */
> @@ -729,15 +782,27 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	advk_writel(pcie, 1, PIO_START);
>  
>  	ret = advk_pcie_wait_pio(pcie);
> +	if (ret < 0) {
> +		/*
> +		 * For PCI_VENDOR_ID register, return Completion Retry Status
> +		 * so caller tries to issue the request again instead of failing
> +		 */
> +		if (where == PCI_VENDOR_ID) {
> +			*val = CFG_RD_CRS_VAL;
> +			return PCIBIOS_SUCCESSFUL;
> +		} else {
> +			*val = 0xffffffff;
> +			return PCIBIOS_SET_FAILED;
> +		}
> +	}
> +
> +	/* Check PIO status and get the read result */
> +	ret = advk_pcie_check_pio_status(pcie, val);
>  	if (ret < 0) {
>  		*val = 0xffffffff;
>  		return PCIBIOS_SET_FAILED;
>  	}
>  
> -	advk_pcie_check_pio_status(pcie);
> -
> -	/* Get the read result */
> -	*val = advk_readl(pcie, PIO_RD_DATA);
>  	if (size == 1)
>  		*val = (*val >> (8 * (where & 3))) & 0xff;
>  	else if (size == 2)
> @@ -801,7 +866,9 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  	if (ret < 0)
>  		return PCIBIOS_SET_FAILED;
>  
> -	advk_pcie_check_pio_status(pcie);
> +	ret = advk_pcie_check_pio_status(pcie, NULL);
> +	if (ret < 0)
> +		return PCIBIOS_SET_FAILED;
>  
>  	return PCIBIOS_SUCCESSFUL;
>  }
> -- 
> 2.20.1
> 
