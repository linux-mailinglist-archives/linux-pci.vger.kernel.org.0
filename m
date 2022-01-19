Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D27949426B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 22:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbiASVTD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 16:19:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52624 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiASVTC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 16:19:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 612596119D
        for <linux-pci@vger.kernel.org>; Wed, 19 Jan 2022 21:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29297C004E1;
        Wed, 19 Jan 2022 21:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642627141;
        bh=FidAGZXvH754XxYdED8EUCT+Ugw69ffO6kfAp8NvP8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmalF7qquroZfI3t+og1noxg/qvEOW40+svmB5L1mJsq0MiQe6q9tqraDC3eVhGxz
         URvicb1byaDsWA+fHeKJ3xX1dibYUI0gfmKJykiWaMBVfMSKCz7GocyjK71lfuCnTb
         YB7ePF0okwrDKSObzHvt6COjkuXNIxUrDMUGpuwxmFca60frO1zhjVSqa+vWnYqEyO
         wEWPFx3x1AG/wrcCgt/5kmRK4trSEuCbAGsbAJCjwVK8YC5NZdEqvim8dgnKPn/LLU
         ad8wkdGL4cAlSBfhn5JAxFb3gpzXZICmGM1faOviiGYIlb218aGQqH6iUdp9G/ssvR
         aBsrUnBqzPOpQ==
Date:   Wed, 19 Jan 2022 13:18:59 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v3 2/2] PCI/AER: Enable AER on all PCIe devices
 supporting it
Message-ID: <20220119211859.GC13301@dhcp-10-100-145-180.wdc.com>
References: <20220119182550.GB13301@dhcp-10-100-145-180.wdc.com>
 <20220119210002.GA963573@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119210002.GA963573@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 19, 2022 at 03:00:02PM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 19, 2022 at 10:25:50AM -0800, Keith Busch wrote:
> > On Wed, Jan 19, 2022 at 10:22:00AM +0100, Stefan Roese wrote:
> > > @@ -387,6 +387,10 @@ void pci_aer_init(struct pci_dev *dev)
> > >  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
> > >  
> > >  	pci_aer_clear_status(dev);
> > > +
> > > +	/* Enable AER if requested */
> > > +	if (pci_aer_available())
> > > +		pci_enable_pcie_error_reporting(dev);
> > >  }
> > 
> > Hasn't it always been the device specific driver's responsibility to
> > call this function?
> 
> So far it has been done by the driver, because the PCI core doesn't do
> it.  But is there a reason it should be done by the driver?  It
> doesn't seem necessarily device-specific.

I was thinking the device driver knows if it provides .err_handler
callbacks in order to respond to AER handling, so it would know if it is
ready for its device to enable error reporting. But I guess it doesn't
really matter if the driver provides callbacks anyway.
