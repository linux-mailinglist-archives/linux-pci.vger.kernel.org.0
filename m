Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C876D2CC8E9
	for <lists+linux-pci@lfdr.de>; Wed,  2 Dec 2020 22:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgLBV22 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 16:28:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgLBV21 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Dec 2020 16:28:27 -0500
Date:   Wed, 2 Dec 2020 15:27:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606944466;
        bh=Ht4X84SyFBSTDCluLH3RQa1Lz07FrTFhNwYE1VCAIlw=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=dO8Drxok7ImaOcnV8rIQSKfhjgkWS7tEnvaiCngWdW4lgptlGvvuj+vRF7rLYg3lD
         PzXYXFirJredQ0qBWj6CnVh0+EdhwXa3eF2ndbJsjllG8naBvhD4pNWrqDjXmmqPB2
         Dz+u87vJEgudtUzajIVo1fyFYwQxqt2alxCMjRFcVlMUrg8UN99BJ3aCw306KJMQ55
         WNececm9W21Efm+FXoAhpJ+AoaiXtmk4gclnZISJmJxFxqp0NAgYZr0nwjc5BoAn+L
         1Da5KVu/1FU81M04fH7LdQJDxdmlgxZn9HZ5A3W1M5gZfJe5tHHEC1pcohLpfG/stW
         bAngTuHhdhXaA==
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
Subject: Re: [PATCH v12 10/15] PCI/ERR: Limit AER resets in pcie_do_recovery()
Message-ID: <20201202212745.GA1472565@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56F6F057-83B5-4CC0-AF32-E548FBAAD25D@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 02, 2020 at 08:53:54PM +0000, Kelley, Sean V wrote:
> > On Nov 30, 2020, at 4:25 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Nov 30, 2020 at 07:54:37PM +0000, Kelley, Sean V wrote:

> >> -	if (pcie_aer_is_native(bridge))
> >> -		pcie_clear_device_status(bridge);
> >> -	pci_aer_clear_nonfatal_status(bridge);
> >> 
> >> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> >> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> >> +	    type == PCI_EXP_TYPE_RC_EC) {
> >> +		if (pcie_aer_is_native(bridge))
> >> +			pcie_clear_device_status(bridge);
> >> +		pci_aer_clear_nonfatal_status(bridge);
> >> +	}

Back to this specific hunk, what if we made it this?

  struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);

  if (host->native_aer || pcie_ports_native) {
    pcie_clear_device_status(bridge);
    pci_aer_clear_nonfatal_status(bridge);
  }

Previously, if "bridge" didn't have an AER Capability, we didn't
pcie_clear_device_status().  In the case of a DPC bridge without AER,
I think we *should* call pcie_clear_device_status().

Otherwise, I think this should work the same and would be a little
simpler.

> > It seems like there are basically two devices of interest in
> > pcie_do_recovery(): the endpoint where we have to call the driver
> > error recovery, and the port that generated the interrupt.  I wonder
> > if this would make more sense if the caller passed both of them in
> > explicitly instead of having pcie_do_recovery() check the type of
> > "dev" and try to figure things out after the fact.
> 
> On this last point I wanted to add that this is a possibility that
> could provide a clearer distinction, especially where actions need
> to be taken or not taken as a part of pcie_do_recovery(), i.e.,
> bridge versus dev.  In this patch series we have taken steps to
> minimize the need for the distinction by pushing the awareness into
> the driver’s error recovery routine, i.e., dev->rcec.  A future
> evolution after this series could lead to both devices of interest
> being passed explicitly for the larger scope EDR/DPC/AER/etc.

Yeah, not worth doing in *this* series.

Bjorn
