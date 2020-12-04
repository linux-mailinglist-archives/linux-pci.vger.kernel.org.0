Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF412CE348
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgLDABo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 19:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbgLDABo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 19:01:44 -0500
Date:   Thu, 3 Dec 2020 18:01:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607040062;
        bh=TFeruPkgbrSDGbzzbRUgiuSOMyk5TmQH2Xk0ks8OuLI=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=RBVSuwd9iPqp64UZa1U3c9mdkVt2FhO1qP51apmg1x6OyvkCyZHF6eVJqgoEf89fX
         YIp1+gLW9XwOttLDxf+D1upX29fddCE5bNFxXxgwrkzUwW9WoChor3KIuNYb+vgx3R
         +TubFcCeoPmUZuvt5/rlCsM5nOjhDp+BR8SDOQOotJfhRXD3X0sAldAG9l00bcWqMp
         fL2FIxljMNfBV+HHxoTHB3p0PlTzuQVoVKfkOZPYPjHGeiuHWBLTREMYFx+o/kLWfE
         6zvBczfHDopnW7GOgOtahtRuHZ5Xw8t0biHSfKKmzP7tLBlUfVj6Y4gkZcfopli3a0
         bb++lD5Jwo6ZA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kelley, Sean V" <sean.v.kelley@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "xerces.zhao@gmail.com" <xerces.zhao@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Message-ID: <20201204000100.GA1606573@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6E339ABE-2F55-486B-833A-BDDAF27A114D@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 03, 2020 at 12:51:40AM +0000, Kelley, Sean V wrote:
> > On Dec 2, 2020, at 3:44 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Nov 20, 2020 at 04:10:33PM -0800, Sean V Kelley wrote:
> >> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >> 
> >> When attempting error recovery for an RCiEP associated with an RCEC device,
> >> there needs to be a way to update the Root Error Status, the Uncorrectable
> >> Error Status and the Uncorrectable Error Severity of the parent RCEC.  In
> >> some non-native cases in which there is no OS-visible device associated
> >> with the RCiEP, there is nothing to act upon as the firmware is acting
> >> before the OS.
> >> 
> >> Add handling for the linked RCEC in AER/ERR while taking into account
> >> non-native cases.
> >> 
> >> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> >> Link: https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@oregontracks.org
> >> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> >> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> ---
> >> drivers/pci/pcie/aer.c | 46 +++++++++++++++++++++++++++++++-----------
> >> drivers/pci/pcie/err.c | 20 +++++++++---------
> >> 2 files changed, 44 insertions(+), 22 deletions(-)
> >> 
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index 0ba0b47ae751..51389a6ee4ca 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -1358,29 +1358,51 @@ static int aer_probe(struct pcie_device *dev)
> >>  */
> >> static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> >> {
> >> -	int aer = dev->aer_cap;
> >> +	int type = pci_pcie_type(dev);
> >> +	struct pci_dev *root;
> >> +	int aer = 0;
> >> +	int rc = 0;
> >> 	u32 reg32;
> >> -	int rc;
> >> 
> >> -	if (pcie_aer_is_native(dev)) {
> >> +	if (type == PCI_EXP_TYPE_RC_END)
> >> +		/*
> >> +		 * The reset should only clear the Root Error Status
> >> +		 * of the RCEC. Only perform this for the
> >> +		 * native case, i.e., an RCEC is present.
> >> +		 */
> >> +		root = dev->rcec;
> >> +	else
> >> +		root = dev;
> >> +
> >> +	if (root)
> >> +		aer = dev->aer_cap;
> >> +
> >> +	if ((aer) && pcie_aer_is_native(dev)) {
> >> 		/* Disable Root's interrupt in response to error messages */
> >> -		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> >> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> >> 		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> >> -		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> >> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> >> 	}
> >> 
> >> -	rc = pci_bus_error_reset(dev);
> >> -	pci_info(dev, "Root Port link has been reset (%d)\n", rc);
> >> +	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
> >> +		if (pcie_has_flr(dev)) {
> >> +			rc = pcie_flr(dev);
> >> +			pci_info(dev, "has been reset (%d)\n", rc);
> > 
> > Maybe:
> > 
> >  +             } else {
> >  +                     rc = -ENOTTY;
> >  +                     pci_info(dev, "not reset (no FLR support)\n");
> > 
> > Or do we want to pretend the device was reset and return
> > PCI_ERS_RESULT_RECOVERED?
> 
> We are currently doing the latter now with the default of rc = 0
> above and so  I’m not sure the extra detail here on the absence of
> FLR support is of value.

So to make sure I understand the proposal here, for RCECs and RCiEPs
that don't support FLR, you're saying you want to continue silently
and return PCI_ERS_RESULT_RECOVERED and let the drivers assume their
device was reset when it was not?

> >> +	} else {
> >> +		rc = pci_bus_error_reset(dev);
> >> +		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
> >> +	}
> >> 
> >> -	if (pcie_aer_is_native(dev)) {
> >> +	if ((aer) && pcie_aer_is_native(dev)) {
> >> 		/* Clear Root Error Status */
> >> -		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> >> -		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
> >> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
> >> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
> >> 
> >> 		/* Enable Root Port's interrupt in response to error messages */
> >> -		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> >> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> >> 		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> >> -		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> >> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> >> 	}
> >> 
> >> 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;

> >> @@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev *bridge,
> >> 			    int (*cb)(struct pci_dev *, void *),
> >> 			    void *userdata)
> >> {
> >> +	/*
> >> +	 * In a non-native case where there is no OS-visible reporting
> >> +	 * device the bridge will be NULL, i.e., no RCEC, no Downstream Port.
> > 
> > I don't quite understand this comment.  I see that in the non-native
> > case, the reporting device may not be OS-visible.  But I don't
> > understand why the comment is *here*.
> > 
> > If "bridge" can be NULL here, we should test that before dereferencing
> > "bridge->subordinate".
> 
> Wrongly worded.  The subordinate may be NULL or the associated RCEC
> may be NULL, not the “bridge”.  However, per below, we should not be
> trying to call report_frozen_detected(), report_mmio_enabled() via
> the associated RCEC’s driver, but rather the CB for the RCiEP
> itself.

OK, so if we want a comment here, I assume it would be along the lines
of:

  If "bridge" has no subordinate bus, it's an RCEC or an RCiEP.  In
  either of those cases, we want to call the callback on "bridge"
  itself.

> Going back to this conversation,
> 
> https://lore.kernel.org/linux-pci/20201016172210.GA86168@bjorn-Precision-5520/
> 
> "Looks like *this* is the patch where the "no subordinate bus" case
> becomes possible?  If you agree, I can just move the test here, no
> need to repost.”
> 
> It is actually the case we are only dealing with the absence of a
> subordinate bus.
> 
> >> 	if (bridge->subordinate)
> >> 		pci_walk_bus(bridge->subordinate, cb, userdata);
> >> +	else if (bridge->rcec)
> >> +		cb(bridge->rcec, userdata);
> > 
> > And I don't understand what's going on here.  In this case, I *think*
> > "bridge" is an RCiEP and "bridge->rcec" is the related RCEC, so it
> > looks like we'll call report_frozen_detected(), report_mmio_enabled(),
> > etc for the RCEC driver.  I would think we'd want the RCiEP driver.
> 
> Indeed, the bridge->rcec here is the dev->rcec in which the dev is
> the RCiEP.
> 
> And we don’t need that conditional here, it should just hit the
> device driver’s routines.

So IIUC, the code would be:

  if (bridge->subordinate)
    pci_walk_bus(bridge->subordinate, cb, userdata);
  else
    cb(bridge, userdata);    /* RCEC or RCiEP */

Right?

I pushed a pci/err branch
(https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/err)
with some tweaks in these areas.  Diff from your v12 posting appended
below.  I split the RCEC/RCiEP error recovery pieces up a little bit
differently than in your posting.  Let me know if you see anything
that should be changed.  I dropped one of Jonathan's
reviewed/tested-by but probably should have dropped others to avoid
putting words in his mouth.

Not sure we're completely done, but we'll get there yet.  I definitely
want to make sure this happens this cycle.

Bjorn


diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b86a92494345..4aa118edde35 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1366,33 +1366,38 @@ static int aer_probe(struct pcie_device *dev)
 }
 
 /**
- * aer_root_reset - reset link on Root Port
- * @dev: pointer to Root Port's pci_dev data structure
+ * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
+ * @dev: pointer to Root Port, RCEC, or RCiEP
  *
- * Invoked by Port Bus driver when performing link reset at Root Port.
+ * Invoked by Port Bus driver when performing reset.
  */
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
 	struct pci_dev *root;
-	int aer = 0;
-	int rc = 0;
+	int aer;
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	u32 reg32;
+	int rc;
 
+	/*
+	 * Only Root Ports and RCECs have AER Root Command and Root Status
+	 * registers.  If "dev" is an RCiEP, the relevant registers are in
+	 * the RCEC.
+	 */
 	if (type == PCI_EXP_TYPE_RC_END)
-		/*
-		 * The reset should only clear the Root Error Status
-		 * of the RCEC. Only perform this for the
-		 * native case, i.e., an RCEC is present.
-		 */
 		root = dev->rcec;
 	else
 		root = dev;
 
-	if (root)
-		aer = dev->aer_cap;
+	/*
+	 * If the platform retained control of AER, an RCiEP may not have
+	 * an RCEC visible to us, so dev->rcec ("root") may be NULL.  In
+	 * that case, firmware is responsible for these registers.
+	 */
+	aer = root ? root->aer_cap : 0;
 
-	if ((aer) && pcie_aer_is_native(dev)) {
+	if ((host->native_aer || pcie_ports_native) && aer) {
 		/* Disable Root's interrupt in response to error messages */
 		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
@@ -1403,13 +1408,15 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 		if (pcie_has_flr(dev)) {
 			rc = pcie_flr(dev);
 			pci_info(dev, "has been reset (%d)\n", rc);
+		} else {
+			pci_info(dev, "not reset (no FLR support)\n");
 		}
 	} else {
 		rc = pci_bus_error_reset(dev);
 		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
 	}
 
-	if ((aer) && pcie_aer_is_native(dev)) {
+	if ((host->native_aer || pcie_ports_native) && aer) {
 		/* Clear Root Error Status */
 		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
 		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index cbc5abfe767b..510f31f0ef6d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -148,30 +148,23 @@ static int report_resume(struct pci_dev *dev, void *data)
 
 /**
  * pci_walk_bridge - walk bridges potentially AER affected
- * @bridge   bridge which may be an RCEC with associated RCiEPs,
- *           or a Port.
- * @cb       callback to be called for each device found
- * @userdata arbitrary pointer to be passed to callback.
+ * @bridge:	bridge which may be a Port, an RCEC, or an RCiEP
+ * @cb:		callback to be called for each device found
+ * @userdata:	arbitrary pointer to be passed to callback
  *
  * If the device provided is a bridge, walk the subordinate bus, including
  * any bridged devices on buses under this bus.  Call the provided callback
  * on each device found.
  *
- * If the device provided has no subordinate bus, call the callback on the
- * device itself.
+ * If the device provided has no subordinate bus, e.g., an RCEC or RCiEP,
+ * call the callback on the device itself.
  */
 static void pci_walk_bridge(struct pci_dev *bridge,
 			    int (*cb)(struct pci_dev *, void *),
 			    void *userdata)
 {
-	/*
-	 * In a non-native case where there is no OS-visible reporting
-	 * device the bridge will be NULL, i.e., no RCEC, no Downstream Port.
-	 */
 	if (bridge->subordinate)
 		pci_walk_bus(bridge->subordinate, cb, userdata);
-	else if (bridge->rcec)
-		cb(bridge->rcec, userdata);
 	else
 		cb(bridge, userdata);
 }
@@ -183,11 +176,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	int type = pci_pcie_type(dev);
 	struct pci_dev *bridge;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
 	/*
-	 * Error recovery runs on all subordinates of the bridge.  If the
-	 * bridge detected the error, it is cleared at the end.  For RCiEPs
-	 * we should reset just the RCiEP itself.
+	 * If the error was detected by a Root Port, Downstream Port, RCEC,
+	 * or RCiEP, recovery runs on the device itself.  For Ports, that
+	 * also includes any subordinate devices.
+	 *
+	 * If it was detected by another device (Endpoint, etc), recovery
+	 * runs on the device and anything else under the same Port, i.e.,
+	 * everything under "bridge".
 	 */
 	if (type == PCI_EXP_TYPE_ROOT_PORT ||
 	    type == PCI_EXP_TYPE_DOWNSTREAM ||
@@ -232,11 +230,15 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast resume message\n");
 	pci_walk_bridge(bridge, report_resume, &status);
 
-	if (type == PCI_EXP_TYPE_ROOT_PORT ||
-	    type == PCI_EXP_TYPE_DOWNSTREAM ||
-	    type == PCI_EXP_TYPE_RC_EC) {
-		if (pcie_aer_is_native(bridge))
-			pcie_clear_device_status(bridge);
+	/*
+	 * If we have native control of AER, clear error status in the Root
+	 * Port or Downstream Port that signaled the error.  If the
+	 * platform retained control of AER, it is responsible for clearing
+	 * this status.  In that case, the signaling device may not even be
+	 * visible to the OS.
+	 */
+	if (host->native_aer || pcie_ports_native) {
+		pcie_clear_device_status(bridge);
 		pci_aer_clear_nonfatal_status(bridge);
 	}
 	pci_info(bridge, "device recovery successful\n");
