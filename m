Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2530E933F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 00:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfJ2XDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 19:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfJ2XDt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 19:03:49 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D693F20862;
        Tue, 29 Oct 2019 23:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572390229;
        bh=xS/gtwg727NcOmPFy9DTKtdkMOp07cxQA9xVcYmo6TA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hhiA+fs6NWDBjh2CncPxUxLeFxIWwyPBrnodiVZfjrvycvGHszYBwP4Rtw7QQktCw
         gnoqAFCrp5m/FhYFZeAYasXKAdRpHIlbYkMzCYcf/G3Xhq8CSrVpSSw3Y2FzcS12JX
         zZege/ff2Y+E8Uh+8mp8r6plvMYdouiILYTzYXkU=
Date:   Tue, 29 Oct 2019 18:03:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v9 5/8] PCI/AER: Allow clearing Error Status Register in
 FF mode
Message-ID: <20191029230346.GA123765@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be6df02f-a14f-d80e-0fa2-ff34f19cbcb9@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 12:58:14PM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> On 10/28/19 4:22 PM, Bjorn Helgaas wrote:
> > On Thu, Oct 03, 2019 at 04:39:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> > > @@ -430,9 +424,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> > >   	if (!pos)
> > >   		return -EIO;
> > > -	if (pcie_aer_get_firmware_first(dev))
> > > -		return -EIO;
> > > -
> > >   	port_type = pci_pcie_type(dev);
> > >   	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
> > >   		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
> > > @@ -455,7 +446,8 @@ void pci_aer_init(struct pci_dev *dev)
> > >   	if (dev->aer_cap)
> > >   		dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
> > > -	pci_cleanup_aer_error_status_regs(dev);
> > > +	if (!pcie_aer_get_firmware_first(dev))
> > > +		pci_cleanup_aer_error_status_regs(dev);
> >
> > This effectively moves the "if (pcie_aer_get_firmware_first())" check
> > from pci_cleanup_aer_error_status_regs() into one of the callers.  But
> > there are two other callers: pci_aer_init() and pci_restore_state().
> > Do they need the change, or do you want to cleanup the AER error
> > registers there, but not here?
>
> Good catch. I have added this check to pci_aer_init(). But it needs
> to be added to pci_restore_state() as well. Instead of moving the
> checks to the caller, If you agree, I could change the API to
> pci_cleanup_aer_error_status_regs(struct pci_dev *dev, bool
> skip_ff_check) and let the caller decide whether they want skip the
> check or not.

If all callers of pci_cleanup_aer_error_status_regs() would have to
check pcie_aer_get_firmware_first(), I don't understand why you're
moving the check at all.
