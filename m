Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584502CCAB1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 00:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgLBXpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 18:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgLBXpJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Dec 2020 18:45:09 -0500
Date:   Wed, 2 Dec 2020 17:44:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606952667;
        bh=Hjr4DVBreL8iEXDK9CP4F8iXSxkY9+dL8DDsHRnTOqA=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=sY0zHtuQx4D6hXnv6zX+xhhHzrsUhLC+wjpbjI8wuEmGXY75DnVw45q19V1QqNccJ
         n0b/U8j1n+/7yHvkvYaGbYWh3KtlnhaLliJwyXPG7kTLCxGwfDAt/4j3tzT0/cAZGR
         j51amvYVkj+6e/Xl2vsX3mj4C5/F0MwwM+cfvuePmvLG9vD0p9kCRzuAoH2HqGYvq/
         kcaFholIbCAbWZpKyDwZS4RoIIPy2+99tyHlcz3UDIacUMMMG8qbbPKTv7fH/IzJo3
         l0txHUN9APvhZAzzJ/N6FgHqiIHO7cgZgg2OBGuSnnbLvJ8w6B3grs4TGtwkpYdi2U
         +lXr6ib9wHcCQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Message-ID: <20201202234425.GA1486740@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121001036.8560-13-sean.v.kelley@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 20, 2020 at 04:10:33PM -0800, Sean V Kelley wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> When attempting error recovery for an RCiEP associated with an RCEC device,
> there needs to be a way to update the Root Error Status, the Uncorrectable
> Error Status and the Uncorrectable Error Severity of the parent RCEC.  In
> some non-native cases in which there is no OS-visible device associated
> with the RCiEP, there is nothing to act upon as the firmware is acting
> before the OS.
> 
> Add handling for the linked RCEC in AER/ERR while taking into account
> non-native cases.
> 
> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Link: https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@oregontracks.org
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/pcie/aer.c | 46 +++++++++++++++++++++++++++++++-----------
>  drivers/pci/pcie/err.c | 20 +++++++++---------
>  2 files changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 0ba0b47ae751..51389a6ee4ca 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1358,29 +1358,51 @@ static int aer_probe(struct pcie_device *dev)
>   */
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  {
> -	int aer = dev->aer_cap;
> +	int type = pci_pcie_type(dev);
> +	struct pci_dev *root;
> +	int aer = 0;
> +	int rc = 0;
>  	u32 reg32;
> -	int rc;
>  
> -	if (pcie_aer_is_native(dev)) {
> +	if (type == PCI_EXP_TYPE_RC_END)
> +		/*
> +		 * The reset should only clear the Root Error Status
> +		 * of the RCEC. Only perform this for the
> +		 * native case, i.e., an RCEC is present.
> +		 */
> +		root = dev->rcec;
> +	else
> +		root = dev;
> +
> +	if (root)
> +		aer = dev->aer_cap;
> +
> +	if ((aer) && pcie_aer_is_native(dev)) {
>  		/* Disable Root's interrupt in response to error messages */
> -		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>  		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
>  	}
>  
> -	rc = pci_bus_error_reset(dev);
> -	pci_info(dev, "Root Port link has been reset (%d)\n", rc);
> +	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
> +		if (pcie_has_flr(dev)) {
> +			rc = pcie_flr(dev);
> +			pci_info(dev, "has been reset (%d)\n", rc);

Maybe:

  +             } else {
  +                     rc = -ENOTTY;
  +                     pci_info(dev, "not reset (no FLR support)\n");

Or do we want to pretend the device was reset and return
PCI_ERS_RESULT_RECOVERED?

> +	} else {
> +		rc = pci_bus_error_reset(dev);
> +		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
> +	}
>  
> -	if (pcie_aer_is_native(dev)) {
> +	if ((aer) && pcie_aer_is_native(dev)) {
>  		/* Clear Root Error Status */
> -		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> -		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
>  
>  		/* Enable Root Port's interrupt in response to error messages */
> -		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>  		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
>  	}
>  
>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 7883c9791562..cbc5abfe767b 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -148,10 +148,10 @@ static int report_resume(struct pci_dev *dev, void *data)
>  
>  /**
>   * pci_walk_bridge - walk bridges potentially AER affected
> - * @bridge:	bridge which may be a Port, an RCEC with associated RCiEPs,
> - *		or an RCiEP associated with an RCEC
> - * @cb:		callback to be called for each device found
> - * @userdata:	arbitrary pointer to be passed to callback
> + * @bridge   bridge which may be an RCEC with associated RCiEPs,
> + *           or a Port.
> + * @cb       callback to be called for each device found
> + * @userdata arbitrary pointer to be passed to callback.
>   *
>   * If the device provided is a bridge, walk the subordinate bus, including
>   * any bridged devices on buses under this bus.  Call the provided callback
> @@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev *bridge,
>  			    int (*cb)(struct pci_dev *, void *),
>  			    void *userdata)
>  {
> +	/*
> +	 * In a non-native case where there is no OS-visible reporting
> +	 * device the bridge will be NULL, i.e., no RCEC, no Downstream Port.

I don't quite understand this comment.  I see that in the non-native
case, the reporting device may not be OS-visible.  But I don't
understand why the comment is *here*.

If "bridge" can be NULL here, we should test that before dereferencing
"bridge->subordinate".

>  	if (bridge->subordinate)
>  		pci_walk_bus(bridge->subordinate, cb, userdata);
> +	else if (bridge->rcec)
> +		cb(bridge->rcec, userdata);

And I don't understand what's going on here.  In this case, I *think*
"bridge" is an RCiEP and "bridge->rcec" is the related RCEC, so it
looks like we'll call report_frozen_detected(), report_mmio_enabled(),
etc for the RCEC driver.  I would think we'd want the RCiEP driver.

Sorry if I'm missing the obvious.

>  	else
>  		cb(bridge, userdata);
>  }
> @@ -194,12 +200,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(bridge, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bridge(bridge, report_frozen_detected, &status);
> -		if (type == PCI_EXP_TYPE_RC_END) {
> -			pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
> -			status = PCI_ERS_RESULT_NONE;
> -			goto failed;
> -		}
> -
>  		status = reset_subordinates(bridge);
>  		if (status != PCI_ERS_RESULT_RECOVERED) {
>  			pci_warn(bridge, "subordinate device reset failed\n");
> -- 
> 2.29.2
> 
