Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192B53CFFA4
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 18:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhGTP6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 11:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235483AbhGTPyP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 11:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1344161019;
        Tue, 20 Jul 2021 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626798893;
        bh=Ilb8XrKqovfkMymDUiC3+G3Jga4jcmrm2aQtv8zfkuY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tk8iHGCX6WbQoSZHsutVoIKam7nasApg6kOb1F6Omqqau+RZeJFC740bcDM9UJBkD
         Ijlwo7lzsdWha7QWw8pwPfvh5zfxX6GEliA58pBZ33TGX/KaKuJBPHEo95K3PD6OZW
         ipoGeDSam4UfQnvY/Ej5GjRc3O2nglHuNJMPOz4PEsQYK5MsAaeUgniZegJg2XXXsg
         mneRkD5GpTh+bDDLeMtUEijogM78ENzeae09hsyMwOmWUKyTW9VmaLnxCd26ptX7gk
         TQcPoElhF3+F1lUuuVZ8Qp4CKPU7O1Ikozr3j8tpRKjR7XQt158CunLxAIi+sh7Isl
         YtZeDNKg7slfg==
Date:   Tue, 20 Jul 2021 11:34:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/3] PCI: aardvark: Fix checking for PIO status
Message-ID: <20210720163451.GA86309@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210720144955.eq564e756ghtpkfo@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 20, 2021 at 04:49:55PM +0200, Pali Rohár wrote:
> On Monday 19 July 2021 18:12:27 Bjorn Helgaas wrote:
> > On Fri, Jun 25, 2021 at 12:04:29PM +0100, Lorenzo Pieralisi wrote:
> > > On Thu, Jun 24, 2021 at 11:33:44PM +0200, Pali Rohár wrote:
> > >
> > > [...]
> > > 
> > > > -static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> > > > +static int advk_pcie_check_pio_status(struct advk_pcie *pcie, u32 *val)
> > > >  {
> > > >  	struct device *dev = &pcie->pdev->dev;
> > > >  	u32 reg;
> > > > @@ -472,15 +476,50 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> > > >  	status = (reg & PIO_COMPLETION_STATUS_MASK) >>
> > > >  		PIO_COMPLETION_STATUS_SHIFT;
> > > >  
> > > > -	if (!status)
> > > > -		return;
> > > > -
> > > > +	/*
> > > > +	 * According to HW spec, the PIO status check sequence as below:
> > > > +	 * 1) even if COMPLETION_STATUS(bit9:7) indicates successful,
> > > > +	 *    it still needs to check Error Status(bit11), only when this bit
> > > > +	 *    indicates no error happen, the operation is successful.
> > > > +	 * 2) value Unsupported Request(1) of COMPLETION_STATUS(bit9:7) only
> > > > +	 *    means a PIO write error, and for PIO read it is successful with
> > > > +	 *    a read value of 0xFFFFFFFF.
> > > > +	 * 3) value Completion Retry Status(CRS) of COMPLETION_STATUS(bit9:7)
> > > > +	 *    only means a PIO write error, and for PIO read it is successful
> > > > +	 *    with a read value of 0xFFFF0001.
> > > > +	 * 4) value Completer Abort (CA) of COMPLETION_STATUS(bit9:7) means
> > > > +	 *    error for both PIO read and PIO write operation.
> > > > +	 * 5) other errors are indicated as 'unknown'.
> > > > +	 */
> > > >  	switch (status) {
> > > > +	case PIO_COMPLETION_STATUS_OK:
> > > > +		if (reg & PIO_ERR_STATUS) {
> > > > +			strcomp_status = "COMP_ERR";
> > > > +			break;
> > > > +		}
> > > > +		/* Get the read result */
> > > > +		if (val)
> > > > +			*val = advk_readl(pcie, PIO_RD_DATA);
> > > > +		/* No error */
> > > > +		strcomp_status = NULL;
> > > > +		break;
> > > >  	case PIO_COMPLETION_STATUS_UR:
> > > > -		strcomp_status = "UR";
> > > > +		if (val) {
> > > > +			/* For reading, UR is not an error status */
> > > > +			*val = CFG_RD_UR_VAL;
> > 
> > I think the comment is incorrect.  Unsupported Request *is* an error
> > status.  But most platforms log it and fabricate ~0 data
> > (CFG_RD_UR_VAL) to return to the CPU, and I think that's what you're
> > doing here.  So I think the code is fine, but the "not an error
> > status" comment is wrong.
> 
> Ok, and what we should driver set as return value for pci_ops.read
> callback in this case?

On most platforms, pci_ops.read() does not check for failure, so it
returns PCIBIOS_SUCCESSFUL in this case.

> > Per the flowchart in PCIe r5.0, sec 6.2.5., fig 6-2, I think the
> > hardware should be setting the "Unsupported Request Detected" bit in
> > the Device Status register when this occurs.
> 
> Yes there is register in kernel's emulated PCIe bridge which at bit 19
> has: Unsupported Request Detected - The core sets this bit to 1 when an
> unsupported request is received. Write this bit to 1 to clear.

I guess this bit 19 is the same as bit 3 in the 16-bit Device Status
register?  Bit 19 if you look at Device Control + Device Status as a
single 32-bit register?

> > > > +			strcomp_status = NULL;
> > > > +		} else {
> > > > +			strcomp_status = "UR";
> > > > +		}
> > > >  		break;
> > > >  	case PIO_COMPLETION_STATUS_CRS:
> > > > -		strcomp_status = "CRS";
> > > > +		if (val) {
> > > > +			/* For reading, CRS is not an error status */
> > > > +			*val = CFG_RD_CRS_VAL;
> > > 
> > > Need Bjorn's input on this. I don't think this is what is expected from
> > > from a root complex according to the PCI specifications (depending on
> > > whether CSR software visibility is supported or not).
> > > 
> > > Here we are fabricating a CRS completion value for all PCI config read
> > > transactions that are hitting a CRS completion status (and that's not
> > > the expected behaviour according to the PCI specifications and I don't
> > > think that's correct).
> > 
> > Right.  I think any config access (read or write) can be completed
> > with a CRS completion (sec 2.3.1).
> > 
> > Per sec 2.3.2, when CRS SV (in Root Control register, sec 7.5.3.12) is
> > enabled and a config read that includes both bytes of the Vendor ID
> > receives a CRS completion, we must return 0x0001 for the Vendor ID and
> > 0xff for any additional bytes.  Note that a config read of only the
> > two Vendor ID bytes is legal and should receive 0x0001 data.
> > 
> > But if CRS SV is disabled, I think config reads that receive CRS
> > completions should fail the normal way, i.e., fabricate ~0 data.
> 
> In PCIe base 2.0 is:
> 
> For other Configuration Requests, or when CRS Software Visibility is not
> enabled, the Root Complex will generally re-issue the Configuration
> Request until it completes with a status other than CRS as described in
> Section 2.3.2.

That text is from the "Configuration Request Retry Status"
implementation note in PCIe r2.0, sec 2.3.1, "Request Handling Rules",
and PCIe r5.0 contains the same text.

PCIe r4.0, sec 2.3.2, says (r5.0 contains the same text but with a
formatting error that changes the meaning):

  Root Complex handling of a Completion with Configuration Request
  Retry Status for a Configuration Request is implementation specific,
  except for the period following system reset (see Section 6.6). For
  Root Complexes that support CRS Software Visibility, the following
  rules apply:

    * If CRS Software Visibility is not enabled, the Root Complex must
      re-issue the Configuration Request as a new Request.

    * If CRS Software Visibility is enabled (see below):

      - For a Configuration Read Request that includes both bytes of
	the Vendor ID field of a device Function's Configuration Space
	Header, the Root Complex must complete the Request to the host
	by returning a read-data value of 0001h for the Vendor ID
	field and all ‘1’s for any additional bytes included in the
	request. This read-data value has been reserved specifically
	for this use by the PCI-SIG and does not correspond to any
	assigned Vendor ID.

      - For a Configuration Write Request or for any other
	Configuration Read Request, the Root Complex must re-issue the
	Configuration Request as a new Request.

  A Root Complex implementation may choose to limit the number of
  Configuration Request/CRS Completion Status loops before determining
  that something is wrong with the target of the Request and taking
  appropriate action, e.g., complete the Request to the host as a
  failed transaction.

> So what should pci-aardvark driver in this case do? Return ~0 or re-send
> this config read request (and how many times)?

That's a good question.  I don't know what other hardware
implementations do, but I doubt they retry forever.  Since the spec
doesn't specify a number of retries, I think you can choose to do
none and immediately return ~0.

> Also this relates to previous discussion about PCI_EXP_RTCTL_CRSSVE:
> https://lore.kernel.org/linux-pci/20210507152542.sd54lk7bk56qapf3@pali/
> 
> > > > +			strcomp_status = NULL;
> > > > +		} else {
> > > > +			strcomp_status = "CRS";
> > > > +		}
> > > >  		break;
> > > >  	case PIO_COMPLETION_STATUS_CA:
> > > >  		strcomp_status = "CA";
> > > > @@ -490,6 +529,9 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> > > >  		break;
> > > >  	}
> > > >  
> > > > +	if (!strcomp_status)
> > > > +		return 0;
> > > > +
> > > >  	if (reg & PIO_NON_POSTED_REQ)
> > > >  		str_posted = "Non-posted";
> > > >  	else
> > > > @@ -497,6 +539,8 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> > > >  
> > > >  	dev_err(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
> > > >  		str_posted, strcomp_status, reg, advk_readl(pcie, PIO_ADDR_LS));
> > > > +
> > > > +	return -EFAULT;
> > > >  }
> > > >  
> > > >  static int advk_pcie_wait_pio(struct advk_pcie *pcie)
> > > > @@ -703,8 +747,17 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > > >  						 size, val);
> > > >  
> > > >  	if (advk_pcie_pio_is_running(pcie)) {
> > > > -		*val = 0xffffffff;
> > > > -		return PCIBIOS_SET_FAILED;
> > > > +		/*
> > > > +		 * For PCI_VENDOR_ID register, return Completion Retry Status
> > > > +		 * so caller tries to issue the request again insted of failing
> > > > +		 */
> > > > +		if (where == PCI_VENDOR_ID) {
> > > > +			*val = CFG_RD_CRS_VAL;
> > > > +			return PCIBIOS_SUCCESSFUL;
> > > 
> > > Mmmm..here we are faking a CRS completion value to coerce the kernel
> > > into believing a CRS completion was received (which is not necessarily
> > > true) ?
> > > 
> > > if advk_pcie_pio_is_running(pcie) == true, is that an HW error ?
> > > 
> > > Lorenzo
> > > 
> > > > +		} else {
> > > > +			*val = 0xffffffff;
> > > > +			return PCIBIOS_SET_FAILED;
> > > > +		}
> > > >  	}
> > > >  
> > > >  	/* Program the control register */
> > > > @@ -729,15 +782,27 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > > >  	advk_writel(pcie, 1, PIO_START);
> > > >  
> > > >  	ret = advk_pcie_wait_pio(pcie);
> > > > +	if (ret < 0) {
> > > > +		/*
> > > > +		 * For PCI_VENDOR_ID register, return Completion Retry Status
> > > > +		 * so caller tries to issue the request again instead of failing
> > > > +		 */
> > > > +		if (where == PCI_VENDOR_ID) {
> > > > +			*val = CFG_RD_CRS_VAL;
> > > > +			return PCIBIOS_SUCCESSFUL;
> > > > +		} else {
> > > > +			*val = 0xffffffff;
> > > > +			return PCIBIOS_SET_FAILED;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	/* Check PIO status and get the read result */
> > > > +	ret = advk_pcie_check_pio_status(pcie, val);
> > > >  	if (ret < 0) {
> > > >  		*val = 0xffffffff;
> > > >  		return PCIBIOS_SET_FAILED;
> > > >  	}
> > > >  
> > > > -	advk_pcie_check_pio_status(pcie);
> > > > -
> > > > -	/* Get the read result */
> > > > -	*val = advk_readl(pcie, PIO_RD_DATA);
> > > >  	if (size == 1)
> > > >  		*val = (*val >> (8 * (where & 3))) & 0xff;
> > > >  	else if (size == 2)
> > > > @@ -801,7 +866,9 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> > > >  	if (ret < 0)
> > > >  		return PCIBIOS_SET_FAILED;
> > > >  
> > > > -	advk_pcie_check_pio_status(pcie);
> > > > +	ret = advk_pcie_check_pio_status(pcie, NULL);
> > > > +	if (ret < 0)
> > > > +		return PCIBIOS_SET_FAILED;
> > > >  
> > > >  	return PCIBIOS_SUCCESSFUL;
> > > >  }
> > > > -- 
> > > > 2.20.1
> > > > 
