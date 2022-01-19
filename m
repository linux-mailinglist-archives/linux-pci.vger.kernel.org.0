Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D90494243
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 22:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiASVAH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 16:00:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37822 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiASVAG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 16:00:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FC01B81BE0
        for <linux-pci@vger.kernel.org>; Wed, 19 Jan 2022 21:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2903C004E1;
        Wed, 19 Jan 2022 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642626004;
        bh=vmTI1VI9wlbT1qeFcPGtp7biuhV1Tm49mAKTAMP87ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ONRbjNE50w/Ch9q9W85I47CHYq2T/TZD1PvlDDblSyQhIXbZ6YKJhxzu1CgpTAwQe
         fLTA1cEXaX/lmUYbr3aek5OHJWR7WANLSWvs/zZAv8RI9yZ+ikfcB3W4svq2YC4R3U
         9gsh6woMUTafCyJX5j+4c5FubpVSEuWgZi5QA6/fVUhO6C8235Vw2ucZL5ZwdwUpQG
         zwPBvXccWRSs/AK5EfZtwmrVlkSqOFjrbWfkvSVMcvwZ/VTIFgzjfaVUXFeaDAYle8
         4xaKG+blYYJdNLDlBq/zKYyw+KsgFLeHgNNht1MjztxpzKR5bWea8HZXzIW0f91/Oz
         SgKljEB1xjCaA==
Date:   Wed, 19 Jan 2022 15:00:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v3 2/2] PCI/AER: Enable AER on all PCIe devices
 supporting it
Message-ID: <20220119210002.GA963573@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119182550.GB13301@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 19, 2022 at 10:25:50AM -0800, Keith Busch wrote:
> On Wed, Jan 19, 2022 at 10:22:00AM +0100, Stefan Roese wrote:
> > @@ -387,6 +387,10 @@ void pci_aer_init(struct pci_dev *dev)
> >  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
> >  
> >  	pci_aer_clear_status(dev);
> > +
> > +	/* Enable AER if requested */
> > +	if (pci_aer_available())
> > +		pci_enable_pcie_error_reporting(dev);
> >  }
> 
> Hasn't it always been the device specific driver's responsibility to
> call this function?

So far it has been done by the driver, because the PCI core doesn't do
it.  But is there a reason it should be done by the driver?  It
doesn't seem necessarily device-specific.

Bjorn
