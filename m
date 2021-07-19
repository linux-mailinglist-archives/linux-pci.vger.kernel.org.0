Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3653CF1C8
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 04:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355172AbhGSX1U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 19:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353767AbhGSWbu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jul 2021 18:31:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 260D160FE9;
        Mon, 19 Jul 2021 23:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626736349;
        bh=68nOdQ5/2pKUcYAjH5i5cDKkBtVtAMGRD++HZhIFCGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CLcru/WqpG34RYDQpxSqwfk1CoOtjh1MRrZPrUG87YNfFJ7Rz1JvjgR7dzROu9SLo
         Dl2fwhzccODQ187AlgOsTVrP6ZX7H8aKLrH32T+p1EJ1H0SCTijOhnOTLvKOaTIdc7
         GAvVnn8Pfn1l8LFhEFavvF41O5K4WTozZTQRt/ScJJJ3EUJizg4Uje3OJPkL8rUwyt
         INuaovozOeY5li7HYhXjWZgLrWy//dy+Phdl0krCRAekLAmIxQfWINVPtDU8+SOnAD
         AnOdpM2M66Tw6f3fOKWnspAAJ63XFJYmky/92bseMYuTvAYSk+nOH3oOOzXL8yGgZ8
         FN2Tmd76Ax+Gg==
Date:   Mon, 19 Jul 2021 18:12:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/3] PCI: aardvark: Fix checking for PIO status
Message-ID: <20210719231227.GA32839@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625110429.GA17337@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 12:04:29PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Jun 24, 2021 at 11:33:44PM +0200, Pali Rohár wrote:
>
> [...]
> 
> > -static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> > +static int advk_pcie_check_pio_status(struct advk_pcie *pcie, u32 *val)
> >  {
> >  	struct device *dev = &pcie->pdev->dev;
> >  	u32 reg;
> > @@ -472,15 +476,50 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> >  	status = (reg & PIO_COMPLETION_STATUS_MASK) >>
> >  		PIO_COMPLETION_STATUS_SHIFT;
> >  
> > -	if (!status)
> > -		return;
> > -
> > +	/*
> > +	 * According to HW spec, the PIO status check sequence as below:
> > +	 * 1) even if COMPLETION_STATUS(bit9:7) indicates successful,
> > +	 *    it still needs to check Error Status(bit11), only when this bit
> > +	 *    indicates no error happen, the operation is successful.
> > +	 * 2) value Unsupported Request(1) of COMPLETION_STATUS(bit9:7) only
> > +	 *    means a PIO write error, and for PIO read it is successful with
> > +	 *    a read value of 0xFFFFFFFF.
> > +	 * 3) value Completion Retry Status(CRS) of COMPLETION_STATUS(bit9:7)
> > +	 *    only means a PIO write error, and for PIO read it is successful
> > +	 *    with a read value of 0xFFFF0001.
> > +	 * 4) value Completer Abort (CA) of COMPLETION_STATUS(bit9:7) means
> > +	 *    error for both PIO read and PIO write operation.
> > +	 * 5) other errors are indicated as 'unknown'.
> > +	 */
> >  	switch (status) {
> > +	case PIO_COMPLETION_STATUS_OK:
> > +		if (reg & PIO_ERR_STATUS) {
> > +			strcomp_status = "COMP_ERR";
> > +			break;
> > +		}
> > +		/* Get the read result */
> > +		if (val)
> > +			*val = advk_readl(pcie, PIO_RD_DATA);
> > +		/* No error */
> > +		strcomp_status = NULL;
> > +		break;
> >  	case PIO_COMPLETION_STATUS_UR:
> > -		strcomp_status = "UR";
> > +		if (val) {
> > +			/* For reading, UR is not an error status */
> > +			*val = CFG_RD_UR_VAL;

I think the comment is incorrect.  Unsupported Request *is* an error
status.  But most platforms log it and fabricate ~0 data
(CFG_RD_UR_VAL) to return to the CPU, and I think that's what you're
doing here.  So I think the code is fine, but the "not an error
status" comment is wrong.

Per the flowchart in PCIe r5.0, sec 6.2.5., fig 6-2, I think the
hardware should be setting the "Unsupported Request Detected" bit in
the Device Status register when this occurs.

> > +			strcomp_status = NULL;
> > +		} else {
> > +			strcomp_status = "UR";
> > +		}
> >  		break;
> >  	case PIO_COMPLETION_STATUS_CRS:
> > -		strcomp_status = "CRS";
> > +		if (val) {
> > +			/* For reading, CRS is not an error status */
> > +			*val = CFG_RD_CRS_VAL;
> 
> Need Bjorn's input on this. I don't think this is what is expected from
> from a root complex according to the PCI specifications (depending on
> whether CSR software visibility is supported or not).
> 
> Here we are fabricating a CRS completion value for all PCI config read
> transactions that are hitting a CRS completion status (and that's not
> the expected behaviour according to the PCI specifications and I don't
> think that's correct).

Right.  I think any config access (read or write) can be completed
with a CRS completion (sec 2.3.1).

Per sec 2.3.2, when CRS SV (in Root Control register, sec 7.5.3.12) is
enabled and a config read that includes both bytes of the Vendor ID
receives a CRS completion, we must return 0x0001 for the Vendor ID and
0xff for any additional bytes.  Note that a config read of only the
two Vendor ID bytes is legal and should receive 0x0001 data.

But if CRS SV is disabled, I think config reads that receive CRS
completions should fail the normal way, i.e., fabricate ~0 data.

> > +			strcomp_status = NULL;
> > +		} else {
> > +			strcomp_status = "CRS";
> > +		}
> >  		break;
> >  	case PIO_COMPLETION_STATUS_CA:
> >  		strcomp_status = "CA";
> > @@ -490,6 +529,9 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> >  		break;
> >  	}
> >  
> > +	if (!strcomp_status)
> > +		return 0;
> > +
> >  	if (reg & PIO_NON_POSTED_REQ)
> >  		str_posted = "Non-posted";
> >  	else
> > @@ -497,6 +539,8 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> >  
> >  	dev_err(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
> >  		str_posted, strcomp_status, reg, advk_readl(pcie, PIO_ADDR_LS));
> > +
> > +	return -EFAULT;
> >  }
> >  
> >  static int advk_pcie_wait_pio(struct advk_pcie *pcie)
> > @@ -703,8 +747,17 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> >  						 size, val);
> >  
> >  	if (advk_pcie_pio_is_running(pcie)) {
> > -		*val = 0xffffffff;
> > -		return PCIBIOS_SET_FAILED;
> > +		/*
> > +		 * For PCI_VENDOR_ID register, return Completion Retry Status
> > +		 * so caller tries to issue the request again insted of failing
> > +		 */
> > +		if (where == PCI_VENDOR_ID) {
> > +			*val = CFG_RD_CRS_VAL;
> > +			return PCIBIOS_SUCCESSFUL;
> 
> Mmmm..here we are faking a CRS completion value to coerce the kernel
> into believing a CRS completion was received (which is not necessarily
> true) ?
> 
> if advk_pcie_pio_is_running(pcie) == true, is that an HW error ?
> 
> Lorenzo
> 
> > +		} else {
> > +			*val = 0xffffffff;
> > +			return PCIBIOS_SET_FAILED;
> > +		}
> >  	}
> >  
> >  	/* Program the control register */
> > @@ -729,15 +782,27 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> >  	advk_writel(pcie, 1, PIO_START);
> >  
> >  	ret = advk_pcie_wait_pio(pcie);
> > +	if (ret < 0) {
> > +		/*
> > +		 * For PCI_VENDOR_ID register, return Completion Retry Status
> > +		 * so caller tries to issue the request again instead of failing
> > +		 */
> > +		if (where == PCI_VENDOR_ID) {
> > +			*val = CFG_RD_CRS_VAL;
> > +			return PCIBIOS_SUCCESSFUL;
> > +		} else {
> > +			*val = 0xffffffff;
> > +			return PCIBIOS_SET_FAILED;
> > +		}
> > +	}
> > +
> > +	/* Check PIO status and get the read result */
> > +	ret = advk_pcie_check_pio_status(pcie, val);
> >  	if (ret < 0) {
> >  		*val = 0xffffffff;
> >  		return PCIBIOS_SET_FAILED;
> >  	}
> >  
> > -	advk_pcie_check_pio_status(pcie);
> > -
> > -	/* Get the read result */
> > -	*val = advk_readl(pcie, PIO_RD_DATA);
> >  	if (size == 1)
> >  		*val = (*val >> (8 * (where & 3))) & 0xff;
> >  	else if (size == 2)
> > @@ -801,7 +866,9 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> >  	if (ret < 0)
> >  		return PCIBIOS_SET_FAILED;
> >  
> > -	advk_pcie_check_pio_status(pcie);
> > +	ret = advk_pcie_check_pio_status(pcie, NULL);
> > +	if (ret < 0)
> > +		return PCIBIOS_SET_FAILED;
> >  
> >  	return PCIBIOS_SUCCESSFUL;
> >  }
> > -- 
> > 2.20.1
> > 
