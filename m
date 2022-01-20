Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BB34951B8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 16:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376519AbiATPqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 10:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346016AbiATPqS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 10:46:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582A9C061574
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 07:46:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9CC2611E1
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 15:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B2AC340E0;
        Thu, 20 Jan 2022 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642693577;
        bh=dTMk8Gw51lEiU78KiW/nHaKoQP1IdjBC2pdtclyIjgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fK0VBNMl76AragmwqWSYecv5x2zvVlAmYBuFnCFBwkqFrCzZi2JYg+zQfFi7tma+L
         /+L6olHB4d7xJqsBZaH9ihrnvOJwgOO7vmWbdSDz6LEINo06boMrHI/Nt7S6MycoNh
         MZRoHCar9tcNGtQDmeOKHWga8MVmkNf6+Z+p4SoE5nYrJSXKg8jotmM9v/sYwkyb60
         PTztmt3iH+0bfpHxtrcjS9KTtPmBNCiFiFEWdEqPL0O9Ugc8GOxyCVcHFdOvxOnq3q
         LvLd3Vq+/1R5Een9IZfSz90nQ0T2ZMEmT7tkxdmrIR2fwT1dFOrgAjGWr2lOSKHhGj
         Eb67SYeOoM5VQ==
Date:   Thu, 20 Jan 2022 09:46:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v3 2/2] PCI/AER: Enable AER on all PCIe devices
 supporting it
Message-ID: <20220120154615.GA1044459@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <487c2f8f-a02d-1ddb-ff17-339cbac7e1a7@denx.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 20, 2022 at 08:31:31AM +0100, Stefan Roese wrote:
> On 1/19/22 11:37, Pali Rohár wrote:

> > And when you opened this issue with hotplugging, another thing for
> > followup changes in future is calling pcie_set_ecrc_checking() function
> > to align ECRC state of newly hotplugged device with "pci=ecrc=..."
> > cmdline option. As currently it is done only at that function
> > set_device_error_reporting().
> 
> Agreed, this is another area to look into. Not sure if it's okay to
> address this, once this patch-set has been accepted (if it will be).

ECRC might be something that could be peeled off first to reduce the
complexity of AER itself.

The ECRC capability and enable bits are in the AER Capability, so I
think it should be moved to pci_aer_init() so it happens for every
device as we enumerate it.

As far as I can tell, there is no requirement that every device in the
path support ECRC, so it can be enabled independently for each device.
I think devices that don't support ECRC checking must handle TLPs with
ECRC without error.

Per Table 6-5, ECRC check failures result in a device logging the
prefix/header of the TLP and sending ERR_NONFATAL or ERR_COR.  I think
this is useful regardless of whether AER interrupts are enabled
because error information is logged where the ECRC failure was
detected.

Bjorn
