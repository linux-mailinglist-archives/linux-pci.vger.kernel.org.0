Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B20290DB4
	for <lists+linux-pci@lfdr.de>; Sat, 17 Oct 2020 00:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390233AbgJPW3G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 18:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732630AbgJPW3G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Oct 2020 18:29:06 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44F8722201;
        Fri, 16 Oct 2020 22:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602887344;
        bh=57jZQev6khFOlir44BK/u6v4ejlmSsH2k2aT3l2Og+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AUVydrnBeAGBJVpBEhrCSAxJsDIKCq7BmuHCmE/BlPZug/S9OxlF0iGO6rDRBCSVa
         +N5XPfoyTIIKlp0Vs+2FOeDyOEC+BJeytb+C/hzveBaC0qWRTDGYr4JYiuLWAJjS97
         flFWvcnA2BWio4WOHn3A8EkkptkewP9F4mLw3H48=
Date:   Fri, 16 Oct 2020 17:29:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>,
        Jonathan.Cameron@huawei.com
Cc:     bhelgaas@google.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Ethan Zhao <xerces.zhao@gmail.com>,
        Sinan Kaya <okaya@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v9 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Message-ID: <20201016222902.GA112659@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016203037.GA90074@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christoph, Ethan, Sinan, Keith; sorry should have cc'd you to
begin with since you're looking at this code too.  Particularly
interested in your thoughts about whether we should be touching
PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS when we don't own AER.]

On Fri, Oct 16, 2020 at 03:30:37PM -0500, Bjorn Helgaas wrote:
> [+to Jonathan]
> 
> On Thu, Oct 15, 2020 at 05:11:10PM -0700, Sean V Kelley wrote:
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > 
> > When attempting error recovery for an RCiEP associated with an RCEC device,
> > there needs to be a way to update the Root Error Status, the Uncorrectable
> > Error Status and the Uncorrectable Error Severity of the parent RCEC.  In
> > some non-native cases in which there is no OS-visible device associated
> > with the RCiEP, there is nothing to act upon as the firmware is acting
> > before the OS.
> > 
> > Add handling for the linked RCEC in AER/ERR while taking into account
> > non-native cases.
> > 
> > Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Link: https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@oregontracks.org
> > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/pci/pcie/aer.c | 53 ++++++++++++++++++++++++++++++------------
> >  drivers/pci/pcie/err.c | 20 ++++++++--------
> >  2 files changed, 48 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 65dff5f3457a..083f69b67bfd 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1357,27 +1357,50 @@ static int aer_probe(struct pcie_device *dev)
> >   */
> >  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> >  {
> > -	int aer = dev->aer_cap;
> > +	int type = pci_pcie_type(dev);
> > +	struct pci_dev *root;
> > +	int aer = 0;
> > +	int rc = 0;
> >  	u32 reg32;
> > -	int rc;
> >  
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END)
> 
> "type == PCI_EXP_TYPE_RC_END"
> 
> > +		/*
> > +		 * The reset should only clear the Root Error Status
> > +		 * of the RCEC. Only perform this for the
> > +		 * native case, i.e., an RCEC is present.
> > +		 */
> > +		root = dev->rcec;
> > +	else
> > +		root = dev;
> >  
> > -	/* Disable Root's interrupt in response to error messages */
> > -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > -	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> > -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> > +	if (root)
> > +		aer = dev->aer_cap;
> >  
> > -	rc = pci_bus_error_reset(dev);
> > -	pci_info(dev, "Root Port link has been reset\n");
> > +	if (aer) {
> > +		/* Disable Root's interrupt in response to error messages */
> > +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > +		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> > +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> 
> Not directly related to *this* patch, but my assumption was that in
> the APEI case, the firmware should retain ownership of the AER
> Capability, so the OS should not touch PCI_ERR_ROOT_COMMAND and
> PCI_ERR_ROOT_STATUS.
> 
> But this code appears to ignore that ownership.  Jonathan, you must
> have looked at this recently for 068c29a248b6 ("PCI/ERR: Clear PCIe
> Device Status errors only if OS owns AER").  Do you have any insight
> about this?
> 
> > -	/* Clear Root Error Status */
> > -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> > -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
> > +		/* Clear Root Error Status */
> > +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
> > +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
> >  
> > -	/* Enable Root Port's interrupt in response to error messages */
> > -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > -	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> > -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> > +		/* Enable Root Port's interrupt in response to error messages */
> > +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > +		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> > +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> > +	}
> > +
> > +	if ((type == PCI_EXP_TYPE_RC_EC) || (type == PCI_EXP_TYPE_RC_END)) {
> > +		if (pcie_has_flr(root)) {
> > +			rc = pcie_flr(root);
> > +			pci_info(dev, "has been reset (%d)\n", rc);
> > +		}
> > +	} else {
> > +		rc = pci_bus_error_reset(root);
> 
> Don't we want "dev" for both the FLR and pci_bus_error_reset()?  I
> think "root == dev" except when dev is an RCiEP.  When dev is an
> RCiEP, "root" is the RCEC (if present), and we want to reset the
> RCiEP, not the RCEC.
> 
> > +		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
> > +	}
> 
> There are a couple changes here that I think should be split out.
> 
> Based on my theory that when firmware retains control of AER, the OS
> should not touch PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS, and any
> updates to them would have to be done by firmware before we get here,
> I suggested reordering this:
> 
>   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>   - do reset
>   - clear PCI_ERR_ROOT_STATUS (for APEI, presumably done by firmware?)
>   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> 
> to this:
> 
>   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>   - clear PCI_ERR_ROOT_STATUS
>   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>   - do reset
> 
> If my theory is correct, I think we should still reorder this, but:
> 
>   - It's a significant behavior change that deserves its own patch so
>     we can document/bisect/revert.
> 
>   - I'm not sure why we clear the PCI_ERR_ROOT_COMMAND error reporting
>     bits.  In the new "clear COMMAND, clear STATUS, enable COMMAND"
>     order, it looks superfluous.  There's no reason to disable error
>     reporting while clearing the status bits.
> 
>     The current "clear, reset, enable" order suggests that the reset
>     might cause errors that we should ignore.  I don't know whether
>     that's the case or not.  It dates from 6c2b374d7485 ("PCI-Express
>     AER implemetation: AER core and aerdriver"), which doesn't
>     elaborate.
> 
>   - Should we also test for OS ownership of AER before touching
>     PCI_ERR_ROOT_STATUS?
> 
>   - If we remove the PCI_ERR_ROOT_COMMAND fiddling (and I tentatively
>     think we *should* unless we can justify it), that would also
>     deserve its own patch.  Possibly (1) remove PCI_ERR_ROOT_COMMAND
>     fiddling, (2) reorder PCI_ERR_ROOT_STATUS clearing and reset, (3)
>     test for OS ownership of AER (?), (4) the rest of this patch.
> 
> >  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
> >  }
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index 7883c9791562..cbc5abfe767b 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -148,10 +148,10 @@ static int report_resume(struct pci_dev *dev, void *data)
> >  
> >  /**
> >   * pci_walk_bridge - walk bridges potentially AER affected
> > - * @bridge:	bridge which may be a Port, an RCEC with associated RCiEPs,
> > - *		or an RCiEP associated with an RCEC
> > - * @cb:		callback to be called for each device found
> > - * @userdata:	arbitrary pointer to be passed to callback
> > + * @bridge   bridge which may be an RCEC with associated RCiEPs,
> > + *           or a Port.
> > + * @cb       callback to be called for each device found
> > + * @userdata arbitrary pointer to be passed to callback.
> >   *
> >   * If the device provided is a bridge, walk the subordinate bus, including
> >   * any bridged devices on buses under this bus.  Call the provided callback
> > @@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev *bridge,
> >  			    int (*cb)(struct pci_dev *, void *),
> >  			    void *userdata)
> >  {
> > +	/*
> > +	 * In a non-native case where there is no OS-visible reporting
> > +	 * device the bridge will be NULL, i.e., no RCEC, no Downstream Port.
> > +	 */
> >  	if (bridge->subordinate)
> >  		pci_walk_bus(bridge->subordinate, cb, userdata);
> > +	else if (bridge->rcec)
> > +		cb(bridge->rcec, userdata);
> >  	else
> >  		cb(bridge, userdata);
> >  }
> > @@ -194,12 +200,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >  	pci_dbg(bridge, "broadcast error_detected message\n");
> >  	if (state == pci_channel_io_frozen) {
> >  		pci_walk_bridge(bridge, report_frozen_detected, &status);
> > -		if (type == PCI_EXP_TYPE_RC_END) {
> > -			pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
> > -			status = PCI_ERS_RESULT_NONE;
> > -			goto failed;
> > -		}
> > -
> >  		status = reset_subordinates(bridge);
> >  		if (status != PCI_ERS_RESULT_RECOVERED) {
> >  			pci_warn(bridge, "subordinate device reset failed\n");
> > -- 
> > 2.28.0
> > 
