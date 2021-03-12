Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143543399EC
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 00:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhCLXOq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 18:14:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235714AbhCLXOS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 18:14:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A13364F1C;
        Fri, 12 Mar 2021 23:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615590857;
        bh=g/BO4+bHFFc89CoR6zk85ugHxQLjqixx+j0XKy26FXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ByFkK4HHVW+3eHZvdet6pl+EDmDFY7uFwGI+ngbDq82fYY3HeS3s/XTTulyQoOtpw
         Ljvk7Ca98ZVYtts4iDgd2qXgRKyTpEryNeyB4DyCe8CaZRMtpfuNYsEyUa73U2IT26
         bCHh4jSvWhUuLqKFfix4b3HeO/qOXkrBzd9J1z+Iuy47u1tELm65lqJh5lq4VFxoQQ
         GhIMx1H5uu3I6JszuLqK+YPGu7LSq1/HMddnAAO3wf7xW0iS2uge9tVFHljLC3zs0F
         WxM2kkj7C/v73HMsgYIXV00FT2fFNsRRn1mzKG/UmxaqR7EgbJdFvBTorw4rxXUU4V
         /WLvq480bXVFQ==
Date:   Fri, 12 Mar 2021 17:14:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        knsathya@kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
Message-ID: <20210312231416.GA2304029@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a137e4aa-22fb-5683-7d58-847408c6bf2b@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 12, 2021 at 02:11:03PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> On 3/12/21 1:33 PM, Bjorn Helgaas wrote:
> > On Mon, Mar 08, 2021 at 10:34:10PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> > > +bool is_dpc_reset_active(struct pci_dev *dev)
> > > +{
> > > +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> > > +	u16 status;
> > > +
> > > +	if (!dev->dpc_cap)
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * If DPC is owned by firmware and EDR is not supported, there is
> > > +	 * no race between hotplug and DPC recovery handler. So return
> > > +	 * false.
> > > +	 */
> > > +	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
> > > +		return false;
> > > +
> > > +	if (atomic_read_acquire(&dev->dpc_reset_active))
> > > +		return true;
> > > +
> > > +	pci_read_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
> > > +
> > > +	return !!(status & PCI_EXP_DPC_STATUS_TRIGGER);
> > 
> > I know it's somewhat common in drivers/pci/, but I'm not really a
> > big fan of "!!".
> I can change it to use ternary operator.
> (status & PCI_EXP_DPC_STATUS_TRIGGER) ? true : false;

Ternary isn't terrible, but what's wrong with:

  if (status & PCI_EXP_DPC_STATUS_TRIGGER)
    return true;
  return false;

which matches the style of the rest of the function.

Looking at this again, we return "true" if either dpc_reset_active or
PCI_EXP_DPC_STATUS_TRIGGER.  I haven't worked this all out, but that
pattern feels racy.  I guess the thought is that if
PCI_EXP_DPC_STATUS_TRIGGER is set, dpc_reset_link() will be invoked
soon and we don't want to interfere?
