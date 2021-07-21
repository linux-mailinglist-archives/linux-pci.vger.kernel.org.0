Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFDE3D189F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 23:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhGUUZE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 16:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhGUUZE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 16:25:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0054B613CF;
        Wed, 21 Jul 2021 21:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901540;
        bh=tj/psHZVOLlDkwuiz1uuoYF+xeG3Zg+lxZvapxYfkpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l7LN4F5AMUXzx0HjrWRoUkDi6oNjl+za5SCJ/CMWfTesN1H3FK83CIn5sl/dWj+cf
         jjOWUtiUiGWFwPFa1gDtYm1hemWSb5aaQ3g9cNhcoPzfT+0uOE9xul5OXWoLpjNCZn
         CEcZMdki6MMLDefpIk+ewP0mVVaSQARa2J347D22ukn24Bbzg869y6oyAofjrpSC7s
         1HAs211kisbI4tgdcnsMTtJtSJVya/TvUaYTZvYVK2s0FC5kdPOVXcDEPgTQ2Lodr8
         rL7TnMj2f/0dkeBgM1P4mnNKPnW1EQLVSMdktFcXV2gxLWFbZmcox7iLdmQHcFIMbH
         PiRc0gHB4E4rw==
Date:   Wed, 21 Jul 2021 16:05:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/3] PCI: aardvark: Fix checking for PIO status
Message-ID: <20210721210538.GA209436@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210720181155.lhmbrcvlnkhdj32o@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 20, 2021 at 08:11:55PM +0200, Pali Rohár wrote:
> On Tuesday 20 July 2021 11:34:51 Bjorn Helgaas wrote:
> > On Tue, Jul 20, 2021 at 04:49:55PM +0200, Pali Rohár wrote:
> > > On Monday 19 July 2021 18:12:27 Bjorn Helgaas wrote:
> > > > On Fri, Jun 25, 2021 at 12:04:29PM +0100, Lorenzo Pieralisi wrote:
> > > > > On Thu, Jun 24, 2021 at 11:33:44PM +0200, Pali Rohár wrote:
> > > > >
> > > > > [...]
> > > > > 
> > > > > > -static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> > > > > > +static int advk_pcie_check_pio_status(struct advk_pcie *pcie, u32 *val)
> > > > > >  {
> > > > > >  	struct device *dev = &pcie->pdev->dev;
> > > > > >  	u32 reg;
> > > > > > @@ -472,15 +476,50 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> > > > > >  	status = (reg & PIO_COMPLETION_STATUS_MASK) >>
> > > > > >  		PIO_COMPLETION_STATUS_SHIFT;
> > > > > >  
> > > > > > -	if (!status)
> > > > > > -		return;
> > > > > > -
> > > > > > +	/*
> > > > > > +	 * According to HW spec, the PIO status check sequence as below:
> > > > > > +	 * 1) even if COMPLETION_STATUS(bit9:7) indicates successful,
> > > > > > +	 *    it still needs to check Error Status(bit11), only when this bit
> > > > > > +	 *    indicates no error happen, the operation is successful.
> > > > > > +	 * 2) value Unsupported Request(1) of COMPLETION_STATUS(bit9:7) only
> > > > > > +	 *    means a PIO write error, and for PIO read it is successful with
> > > > > > +	 *    a read value of 0xFFFFFFFF.
> > > > > > +	 * 3) value Completion Retry Status(CRS) of COMPLETION_STATUS(bit9:7)
> > > > > > +	 *    only means a PIO write error, and for PIO read it is successful
> > > > > > +	 *    with a read value of 0xFFFF0001.
> > > > > > +	 * 4) value Completer Abort (CA) of COMPLETION_STATUS(bit9:7) means
> > > > > > +	 *    error for both PIO read and PIO write operation.
> > > > > > +	 * 5) other errors are indicated as 'unknown'.
> > > > > > +	 */
> > > > > >  	switch (status) {
> > > > > > +	case PIO_COMPLETION_STATUS_OK:
> > > > > > +		if (reg & PIO_ERR_STATUS) {
> > > > > > +			strcomp_status = "COMP_ERR";
> > > > > > +			break;
> > > > > > +		}
> > > > > > +		/* Get the read result */
> > > > > > +		if (val)
> > > > > > +			*val = advk_readl(pcie, PIO_RD_DATA);
> > > > > > +		/* No error */
> > > > > > +		strcomp_status = NULL;
> > > > > > +		break;
> > > > > >  	case PIO_COMPLETION_STATUS_UR:
> > > > > > -		strcomp_status = "UR";
> > > > > > +		if (val) {
> > > > > > +			/* For reading, UR is not an error status */
> > > > > > +			*val = CFG_RD_UR_VAL;
> > > > 
> > > > I think the comment is incorrect.  Unsupported Request *is* an error
> > > > status.  But most platforms log it and fabricate ~0 data
> > > > (CFG_RD_UR_VAL) to return to the CPU, and I think that's what you're
> > > > doing here.  So I think the code is fine, but the "not an error
> > > > status" comment is wrong.
> > > 
> > > Ok, and what we should driver set as return value for pci_ops.read
> > > callback in this case?
> > 
> > On most platforms, pci_ops.read() does not check for failure, so it
> > returns PCIBIOS_SUCCESSFUL in this case.
> 
> Ok. Most platforms do not check for failure. But it is generally
> correct? Probably more platforms do not provide error flag and only
> return value. But aardvark hw provides this kind error information, so
> should pci-aardvark's pci_ops.read() on error returns PCIBIOS_SUCCESSFUL
> on some other return value?

By all means, if you have the error information handy, return
PCIBIOS_DEVICE_NOT_FOUND or whatever you think is appropriate.  Of
course, most callers of pci_read_config_word() et al don't check.  I
think you should set the returned data to ~0 in this case, too.
