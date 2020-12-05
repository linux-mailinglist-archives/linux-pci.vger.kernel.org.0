Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CD62CFF3C
	for <lists+linux-pci@lfdr.de>; Sat,  5 Dec 2020 22:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgLEVbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Dec 2020 16:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLEVbU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Dec 2020 16:31:20 -0500
Date:   Sat, 5 Dec 2020 15:30:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607203839;
        bh=08ajMu/SVS32zG1XETlIFJODw1n6pbDvQdzFGcZLX94=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=AFKy+nRBJTlczOp+IAcz3vgMUPmqk2kycHBY4czn/Dr+JVDs8jjYp51+s1tRsBK5X
         WJ6anBCgcMFafy+NvQ0mIOB/9c1V1fB08NE3mEv0gQGhWHwHhLRypDP1kCQtAHvB6q
         jKcZVZRF5xFZJXb/9dUVkd6BlFRMyn7U/yF+edvE2rPunYknBv3bg3DCI6diYrJ2Sv
         EiP9FfC626HNlM0DhIKGWRu33ItA0KBD1JiXO8A5Grfs/XcqB87yuZUCxz9owi4OB5
         FaahramUZ6aIvEAhUdbjMOgnLtNTSUxVTzfY1B6uu0HLwvaAEzlVnXduHh9WYBcz6t
         mjQgVlN11OeFg==
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
        Linux List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Message-ID: <20201205213038.GA2093063@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4FD8E577-2F6A-4829-B92F-45D5E13BF9A4@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 04, 2020 at 05:17:58PM +0000, Kelley, Sean V wrote:
> > On Dec 3, 2020, at 4:01 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Dec 03, 2020 at 12:51:40AM +0000, Kelley, Sean V wrote:
> >>> On Dec 2, 2020, at 3:44 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> On Fri, Nov 20, 2020 at 04:10:33PM -0800, Sean V Kelley wrote:
> >>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >>>> 
> >>>> When attempting error recovery for an RCiEP associated with an RCEC device,
> >>>> there needs to be a way to update the Root Error Status, the Uncorrectable
> >>>> Error Status and the Uncorrectable Error Severity of the parent RCEC.  In
> >>>> some non-native cases in which there is no OS-visible device associated
> >>>> with the RCiEP, there is nothing to act upon as the firmware is acting
> >>>> before the OS.
> >>>> 
> >>>> Add handling for the linked RCEC in AER/ERR while taking into account
> >>>> non-native cases.
> >>>> 
> >>>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> >>>> Link: https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@oregontracks.org
> >>>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> >>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>> ---
> >>>> drivers/pci/pcie/aer.c | 46 +++++++++++++++++++++++++++++++-----------
> >>>> drivers/pci/pcie/err.c | 20 +++++++++---------
> >>>> 2 files changed, 44 insertions(+), 22 deletions(-)
> >>>> 
> >>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >>>> index 0ba0b47ae751..51389a6ee4ca 100644
> >>>> --- a/drivers/pci/pcie/aer.c
> >>>> +++ b/drivers/pci/pcie/aer.c
> >>>> @@ -1358,29 +1358,51 @@ static int aer_probe(struct pcie_device *dev)
> >>>> */
> >>>> static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> >>>> {
> >>>> -	int aer = dev->aer_cap;
> >>>> +	int type = pci_pcie_type(dev);
> >>>> +	struct pci_dev *root;
> >>>> +	int aer = 0;
> >>>> +	int rc = 0;
> >>>> 	u32 reg32;
> >>>> -	int rc;
> >>>> 
> >>>> -	if (pcie_aer_is_native(dev)) {
> >>>> +	if (type == PCI_EXP_TYPE_RC_END)
> >>>> +		/*
> >>>> +		 * The reset should only clear the Root Error Status
> >>>> +		 * of the RCEC. Only perform this for the
> >>>> +		 * native case, i.e., an RCEC is present.
> >>>> +		 */
> >>>> +		root = dev->rcec;
> >>>> +	else
> >>>> +		root = dev;
> >>>> +
> >>>> +	if (root)
> >>>> +		aer = dev->aer_cap;
> >>>> +
> >>>> +	if ((aer) && pcie_aer_is_native(dev)) {
> >>>> 		/* Disable Root's interrupt in response to error messages */
> >>>> -		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> >>>> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> >>>> 		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> >>>> -		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> >>>> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> >>>> 	}
> >>>> 
> >>>> -	rc = pci_bus_error_reset(dev);
> >>>> -	pci_info(dev, "Root Port link has been reset (%d)\n", rc);
> >>>> +	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
> >>>> +		if (pcie_has_flr(dev)) {
> >>>> +			rc = pcie_flr(dev);
> >>>> +			pci_info(dev, "has been reset (%d)\n", rc);
> >>> 
> >>> Maybe:
> >>> 
> >>> +             } else {
> >>> +                     rc = -ENOTTY;
> >>> +                     pci_info(dev, "not reset (no FLR support)\n");
> >>> 
> >>> Or do we want to pretend the device was reset and return
> >>> PCI_ERS_RESULT_RECOVERED?
> >> 
> >> We are currently doing the latter now with the default of rc = 0
> >> above and so  I’m not sure the extra detail here on the absence of
> >> FLR support is of value.
> > 
> > So to make sure I understand the proposal here, for RCECs and RCiEPs
> > that don't support FLR, you're saying you want to continue silently
> > and return PCI_ERS_RESULT_RECOVERED and let the drivers assume their
> > device was reset when it was not?
> 
> The setting of the ‘rc’ on the FLR support is fine to add to the
> else condition.  I had simply recalled in earlier discussion that
> pcie_has_flr() was needed due to quirky behavior in some hardware
> and so was not sure that detail of having or not having flr was in
> fact consitent/accurate.

I think we should do the following, unless you object:

    if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
	    if (pcie_has_flr(dev)) {
		    rc = pcie_flr(dev);
		    pci_info(dev, "has been reset (%d)\n", rc);
	    } else {
		    pci_info(dev, "not reset (no FLR support)\n");
		    rc = -ENOTTY;
	    }
    } else {
	    rc = pci_bus_error_reset(dev);
	    pci_info(dev, "Root Port link has been reset (%d)\n", rc);
    }
    ...
    return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;

Sorry, I should have done that in the proposed patch earlier; it's
what I was *thinking* but didn't get it transcribed into the code.

Bjorn
