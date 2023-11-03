Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6077E07FA
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 19:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjKCSU7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 14:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCSU6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 14:20:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC1D4D;
        Fri,  3 Nov 2023 11:20:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9CCC433C8;
        Fri,  3 Nov 2023 18:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699035655;
        bh=7tsGjmrJ/IXbOi51N3JxFSTY9p457HkH2KZbbUbO1iE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IqXu1JfP1CdmSvVNo4GhiVPq19YApTjCfV10gbi+4ezSJBuhOQLrV7Lld2xJM2LUx
         puek0io2gVD/ianpjw+DsgRCFgXKFqvgMh2EJ219wgEkW/tE8N7OiaSdFhk2kqu2w5
         kKxQmgUkpWFKi6oiKTUG09k7i4ZA6/r78auAsFNwwVP31aP4ENBsfSzoCSxTMO/WYg
         MeOqfdN0yFZ9GgzpMZ5z7Tq1oPXGtTP7pVkkWorYHbWofeKhVFz7VsGNk5fSnIpYcR
         e5ZuduAjfrGeozEFDZXcOJ5gXMOZ9YZ/c/aH1dXMq79ehpg4meXTG0jK8gBKcqjl8t
         uLu7wzcWes8gA==
Date:   Fri, 3 Nov 2023 13:20:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: Clearing error bits in the root port post enumeration
Message-ID: <20231103182053.GA160440@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR12MB29005068F39DE028F19084EDB8A0A@BN8PR12MB2900.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 12:26:31PM +0000, Vidya Sagar wrote:
> Hi folks,
> 
> I would like to know your comments on the following scenario where
> we are observing the root port logging errors because of the
> enumeration flow being followed.
> 
> DUT information:
> - Has a root port and an endpoint connected to it
> - Uses ECAM mechanism to access the configuration space
> - Booted through ACPI flow
> - Has a Firmware-First approach for handling the errors
> - System is configured to treat Unsupported Requests as
>   AdvisoryNon-Fatal errors
> 
> As we all know, when a configuration read request comes in for a
> device number that is not implemented, a UR would be returned as per
> the PCIe spec.
> 
> As part of the enumeration flow on DUT, when the kernel reads offset
> 0x0 of B:D:F=0:0:0, the root port responds with its valid Vendor-ID
> and Device-ID values.  But, when B:D:F=0:1:0 is probed, since there
> is no device present there, the root port responds with an
> Unsupported Request and simultaneously logs the same in the Device
> Status register (i.e. bit-3).  Because of it, there is a UR logged
> in the Device Status register of the RP by the time enumeration is
> complete.
> 
> In the case of AER capability natively owned by the kernel, the AER
> driver's init call would clear all such pending bits.
> 
> Since we are going with the Firmware-First approach, and the system
> is configured to treat Unsupported Requests as AdvisoryNon-Fatal
> errors, only a correctable error interrupt can be raised to the
> Firmware which takes care of clearing the corresponding status
> registers.  The firmware can't know about the UnsupReq bit being set
> as the interrupt it received is for a correctable error hence it
> clears only bits related to correctable error.
> 
> All these events leave a freshly booted system with the following
> bits set.
> 
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-          (MAbort)
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-                                                              (UnsupReq)
> UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-   (UnsupReq)
> 
> Since the reason for UR is well understood at this point, I would
> like to weigh in on the idea of clearing the aforementioned bits in
> the root port once the enumeration is done particularly to cater to
> the configurations where Firmware-First approach is in place.
> Please let me know your comments on this approach.

I think Secondary status (PCI_SEC_STATUS) is always owned by the OS
and is not affected by _OSC negotiation, right?  Linux does basically
nothing with that today, but I think it *could* clear the "Received
Master Abort" bit.

I'm not very familiar with Advisory Non-Fatal errors.  I'm curious
about the UESta situation: why can't firmware know about UnsupReq
being set?  I assume PCI_ERR_COR_ADV_NFAT is the Correctable Error
Status bit the firmware *does* see and clear.

But isn't the whole point of Advisory Non-Fatal errors that an error
that is logged as an Uncorrectable Error and that normally would be
signaled with ERR_NONFATAL is signaled with ERR_COR instead?  So
doesn't PCI_ERR_COR_ADV_NFAT being set imply that some
PCI_ERR_UNCOR_STATUS must be set as well?  If so, I would think
firmware *could* figure that out and clear the PCI_ERR_UNCOR_STATUS
bit.

Bjorn
