Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D131020B923
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 21:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgFZTOY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 15:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFZTOY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jun 2020 15:14:24 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 311D3206A1;
        Fri, 26 Jun 2020 19:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593198863;
        bh=z2oF+alcajhjxoNUuykiKixvNasruwuFGTQMBcBskD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cvleF0UdnEtliTWMUd/EQkLaX5l7SVtigqGUCDB5YsAXJBr/9xo9IBRtfT1DSQuvA
         Bu56ZM0JGSAEM9Qw9Pxql4eRma9YpwgfVZexqcN72JvG/RS3HBuqIgMDI2eLlXqiIh
         /W0oL64GDhIozpKiRgk2+Z8MEBHmyucoUdZcf//M=
Date:   Fri, 26 Jun 2020 14:14:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     refactormyself@gmail.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: pciehp: Fix wrong failure check on
 pcie_capability_read_*()
Message-ID: <20200626191421.GA2924609@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620090936.3khh3gj46pnojnrw@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 20, 2020 at 11:09:36AM +0200, Lukas Wunner wrote:
> On Fri, Jun 19, 2020 at 10:12:19PM +0200, refactormyself@gmail.com wrote:
> > On failure, pcie_capabiility_read_*() will set the status value,
> > its last parameter to 0 and not ~0.
> > This bug fix checks for the proper value.
> 
> If a config space read times out, the PCIe controller fabricates
> an "all ones" response.  The code is checking for such a timeout,
> not for an error.  Hence the code is fine.

In the typical case, the pci_read_config_word() done by
pcie_capability_read_word() will not return an error, so if the read
times out, we should see slot_status == ~0.

But if it's possible to set dev->error_state ==
pci_channel_io_perm_failure, pci_read_config_word() will return an
error because pci_dev_is_disconnected(), so slot_status would be 0.

There are a dozen or so places that set dev->error_state.  It doesn't
look *likely* that any of them would cause this, but it doesn't
instill confidence.

It would be a lot nicer if we didn't have to worry about both the 0
and ~0 cases.  I keep coming back to the idea of removing the "*val
= 0" code from pcie_capability_read_word() so we wouldn't have that
special case.

In any case, this particular patch doesn't seem like quite the right
fix, so I'll drop it.

> > Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> > ---
> >  drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> > index 53433b37e181..c1a67054948a 100644
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -89,7 +89,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
> >  
> >  	do {
> >  		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> > -		if (slot_status == (u16) ~0) {
> > +		if (slot_status == (u16)0) {
> >  			ctrl_info(ctrl, "%s: no response from device\n",
> >  				  __func__);
> >  			return 0;
> > @@ -165,7 +165,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
> >  	pcie_wait_cmd(ctrl);
> >  
> >  	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
> > -	if (slot_ctrl == (u16) ~0) {
> > +	if (slot_ctrl == (u16)0) {
> >  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
> >  		goto out;
> >  	}
> > @@ -236,7 +236,7 @@ int pciehp_check_link_active(struct controller *ctrl)
> >  	int ret;
> >  
> >  	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> > -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
> > +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)0)
> >  		return -ENODEV;
> >  
> >  	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> > @@ -440,7 +440,7 @@ int pciehp_card_present(struct controller *ctrl)
> >  	int ret;
> >  
> >  	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> > -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)~0)
> > +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)0)
> >  		return -ENODEV;
> >  
> >  	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
> > @@ -592,7 +592,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
> >  
> >  read_status:
> >  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
> > -	if (status == (u16) ~0) {
> > +	if (status == (u16)0) {
> >  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
> >  		if (parent)
> >  			pm_runtime_put(parent);
> > -- 
> > 2.18.2
