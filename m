Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A2F289AA1
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 23:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391303AbgJIVaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 17:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391548AbgJIVaN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 17:30:13 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3929721D41;
        Fri,  9 Oct 2020 21:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602279012;
        bh=3L1LEUvWoZd759ld2o3+wyhfDKcWBWBMEw6BL1ZOAJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kwB6BBW9yNH+Z9G2Wo6zITQFpsFsSNBMGo/lFfWqWW9iG602M03pm0gZcLq9TMt1c
         8fNOAsXu+3fbPysY7JRV95x8Ovx88EoOWj+DVnJ4gnbI23JeNR+dWroKo1Vu72Z+33
         93n40bBqwcs9LdC4zeZ0d7rRkLQqejzG56PYMDc8=
Date:   Fri, 9 Oct 2020 16:30:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v8 11/14] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Message-ID: <20201009213011.GA3504871@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009175745.GA3489710@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 09, 2020 at 12:57:45PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 02, 2020 at 11:47:32AM -0700, Sean V Kelley wrote:
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > 
> > When attempting error recovery for an RCiEP associated with an RCEC device,
> > there needs to be a way to update the Root Error Status, the Uncorrectable
> > Error Status and the Uncorrectable Error Severity of the parent RCEC.
> > In some non-native cases in which there is no OS visible device
> > associated with the RCiEP, there is nothing to act upon as the firmware
> > is acting before the OS. So add handling for the linked 'rcec' in AER/ERR
> > while taking into account non-native cases.
> > 
> > Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/pci/pcie/aer.c |  9 +++++----
> >  drivers/pci/pcie/err.c | 39 ++++++++++++++++++++++++++++-----------
> >  2 files changed, 33 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 65dff5f3457a..dccdba60b5d9 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1358,17 +1358,18 @@ static int aer_probe(struct pcie_device *dev)
> >  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> >  {
> >  	int aer = dev->aer_cap;
> > +	int rc = 0;
> >  	u32 reg32;
> > -	int rc;
> > -
> >  
> >  	/* Disable Root's interrupt in response to error messages */
> >  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> >  	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> >  	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> >  
> > -	rc = pci_bus_error_reset(dev);
> > -	pci_info(dev, "Root Port link has been reset\n");
> > +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
> > +		rc = pci_bus_error_reset(dev);
> > +		pci_info(dev, "Root Port link has been reset\n");
> > +	}
> >  
> >  	/* Clear Root Error Status */
> >  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index 38abd7984996..956ad4c86d53 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -149,7 +149,8 @@ static int report_resume(struct pci_dev *dev, void *data)
> >  /**
> >   * pci_walk_bridge - walk bridges potentially AER affected
> >   * @bridge   bridge which may be an RCEC with associated RCiEPs,
> > - *           an RCiEP associated with an RCEC, or a Port.
> > + *           or a Port.
> > + * @dev      an RCiEP lacking an associated RCEC.
> >   * @cb       callback to be called for each device found
> >   * @userdata arbitrary pointer to be passed to callback.
> >   *
> > @@ -160,13 +161,20 @@ static int report_resume(struct pci_dev *dev, void *data)
> >   * If the device provided has no subordinate bus, call the provided
> >   * callback on the device itself.
> >   */
> > -static void pci_walk_bridge(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
> > +static void pci_walk_bridge(struct pci_dev *bridge, struct pci_dev *dev,
> > +			    int (*cb)(struct pci_dev *, void *),
> >  			    void *userdata)
> >  {
> > -	if (bridge->subordinate)
> > +	/*
> > +	 * In a non-native case where there is no OS-visible reporting
> > +	 * device the bridge will be NULL, i.e., no RCEC, no PORT.
> > +	 */
> > +	if (bridge && bridge->subordinate)
> >  		pci_walk_bus(bridge->subordinate, cb, userdata);
> > -	else
> > +	else if (bridge)
> >  		cb(bridge, userdata);
> > +	else
> > +		cb(dev, userdata);
> >  }
> >  
> >  static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
> > @@ -196,16 +204,25 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >  	type = pci_pcie_type(dev);
> >  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> >  	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> > -	    type == PCI_EXP_TYPE_RC_EC ||
> > -	    type == PCI_EXP_TYPE_RC_END)
> > +	    type == PCI_EXP_TYPE_RC_EC)
> >  		bridge = dev;
> > +	else if (type == PCI_EXP_TYPE_RC_END)
> > +		bridge = dev->rcec;
> >  	else
> >  		bridge = pci_upstream_bridge(dev);
> >  
> >  	pci_dbg(dev, "broadcast error_detected message\n");
> >  	if (state == pci_channel_io_frozen) {
> > -		pci_walk_bridge(bridge, report_frozen_detected, &status);
> > +		pci_walk_bridge(bridge, dev, report_frozen_detected, &status);
> >  		if (type == PCI_EXP_TYPE_RC_END) {
> > +			/*
> > +			 * The callback only clears the Root Error Status
> > +			 * of the RCEC (see aer.c). Only perform this for the
> > +			 * native case, i.e., an RCEC is present.
> > +			 */
> > +			if (bridge)
> > +				reset_subordinate_devices(bridge);
> 
> Help me understand this.  There are lots of callbacks in this picture,
> but I guess this "callback only clears Root Error Status" must refer
> to aer_root_reset(), i.e., the reset_subordinate_devices pointer?
> 
> Of course, the caller of pcie_do_recovery() supplied that pointer.
> And we can infer that it must be aer_root_reset(), not
> dpc_reset_link(), because RCECs and RCiEPs are not allowed to
> implement DPC.
> 
> I wish we didn't have either this assumption about what
> reset_subordinate_devices points to, or the assumption about what
> aer_root_reset() does.  They both seem a little bit tenuous.
> 
> We already made aer_root_reset() smart enough to check for RCECs.  Can
> we put the FLR there, too?  Then we wouldn't have this weird situation
> where reset_subordinate_devices() does a reset and clears error
> status, EXCEPT for this case where it only clears error status and we
> do the reset here?

Just as an example to make this concrete.  Doesn't even compile.


diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d6927e6535e5..e389db7cbba6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1372,28 +1372,45 @@ static int aer_probe(struct pcie_device *dev)
  */
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 {
-	int aer = dev->aer_cap;
+	int type = pci_pcie_type(dev);
+	struct pci_dev *root;
+	int aer = 0;
 	int rc = 0;
 	u32 reg32;
 
-	/* Disable Root's interrupt in response to error messages */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	if (type == PCI_EXP_TYPE_RC_END)
+		root = dev->rcec;
+	else
+		root = dev;
+
+	if (root)
+		aer = root->aer_cap;
 
-	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
+	if (aer) {
+		/* Disable Root's interrupt in response to error messages */
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	}
+
+	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
+		rc = flr_on_rciep(dev);
+		pci_info(dev, "has been reset (%d)\n", rc);
+	} else {
 		rc = pci_bus_error_reset(dev);
-		pci_info(dev, "Root Port link has been reset\n");
+		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
 	}
 
-	/* Clear Root Error Status */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
+	if (aer) {
+		/* Clear Root Error Status */
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
 
-	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+		/* Enable Root Port's interrupt in response to error messages */
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	}
 
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 79ae1356141d..08976034a89c 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -203,36 +203,19 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 */
 	if (type == PCI_EXP_TYPE_ROOT_PORT ||
 	    type == PCI_EXP_TYPE_DOWNSTREAM ||
-	    type == PCI_EXP_TYPE_RC_EC)
+	    type == PCI_EXP_TYPE_RC_EC ||
+	    type == PCI_EXP_TYPE_RC_END)
 		bridge = dev;
-	else if (type == PCI_EXP_TYPE_RC_END)
-		bridge = dev->rcec;
 	else
 		bridge = pci_upstream_bridge(dev);
 
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, dev, report_frozen_detected, &status);
-		if (type == PCI_EXP_TYPE_RC_END) {
-			/*
-			 * The callback only clears the Root Error Status
-			 * of the RCEC (see aer.c). Only perform this for the
-			 * native case, i.e., an RCEC is present.
-			 */
-			if (bridge)
-				reset_subordinates(bridge);
-
-			status = flr_on_rciep(dev);
-			if (status != PCI_ERS_RESULT_RECOVERED) {
-				pci_warn(dev, "Function Level Reset failed\n");
-				goto failed;
-			}
-		} else {
-			status = reset_subordinates(bridge);
-			if (status != PCI_ERS_RESULT_RECOVERED) {
-				pci_warn(dev, "subordinate device reset failed\n");
-				goto failed;
-			}
+		status = reset_subordinates(bridge);
+		if (status != PCI_ERS_RESULT_RECOVERED) {
+			pci_warn(bridge, "subordinate device reset failed\n");
+			goto failed;
 		}
 	} else {
 		pci_walk_bridge(bridge, dev, report_normal_detected, &status);
