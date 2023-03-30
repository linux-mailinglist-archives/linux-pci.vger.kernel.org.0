Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8676D0A45
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjC3PqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 11:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjC3PqZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 11:46:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28AD72A2;
        Thu, 30 Mar 2023 08:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B51BB82623;
        Thu, 30 Mar 2023 15:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3A1C4339B;
        Thu, 30 Mar 2023 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680191144;
        bh=vBf3ZDCn9/BnGZpzaUPwfDKfdZZd0/B3ixt5lveXnIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qgzeyIjHgH9m7RMjjkGalBu1lyxVSDC6TDWKe1ZH8JknzxkqriYOVBYJTeR8KadYP
         SCcq5p9cZzu7DDfUeSWueuU9TToSDCRvHHTqx+B3Cyx3lgPzxOxmJqsiocKZwqqn+k
         KB/vGWWnmVX0e9Bm2Kt+bb0MamWVPjsIQcgicmIqP3+kWgU5Y6dsdlP3DlFope8Nxa
         2GqsCGflzY3lt2L1DvzyXtOpOknWGwYVAYbTF2V5q0RLfJ+f4d1Nlxbd7VCgvCCULF
         bkiG32luPdIDOtuf4hNDi+C/gzwWloQlvLPSA+FLPaqKw4Y6vN/X9qtN06bBwOBgIn
         5ebvwK23UkPOQ==
Date:   Thu, 30 Mar 2023 10:45:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Message-ID: <20230330154542.GA3147375@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6fd4af3-18f7-0a7e-96e7-4ca3c4ada279@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 03:38:04PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 3/29/23 3:09 PM, Bjorn Helgaas wrote:
> > On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
> >> OS owns AER") adds support to clear error status in the Device Status
> >> Register(DEVSTA) only if OS owns the AER support. But this change
> >> breaks the requirement of the EDR feature which requires OS to cleanup
> >> the error registers even if firmware owns the control of AER support.

> > I assume we should have a Fixes: tag here, since this patch should be
> > backported to every kernel that contains 068c29a248b6.  Possibly even
> > a stable tag, although it's arguable whether it's "critical" per
> > Documentation/process/stable-kernel-rules.rst.
> 
> Yes. But this error is only reproducible in the EDR use case. So I
> am not sure whether it can be considered a critical fix. 

I don't know how widespread EDR implementation is.  What is the
user-visible issue without this fix?  "lspci" shows status bits set
even after recovery?  Subsequent EDR notifications cause us to report
errors that were previously reported and recovered?  Spurious EDR
notifications because of status bits that should have been cleared?
This kind of information would be useful in the commit log anyway.

Since the risk is low (the change only affects EDR processing) and the
the experience without this change might be poor (please clarify what
that experience is), I think I would be inclined to mark it for
stable.

> > It's a little weird to work around a change inside pcie_do_recovery()
> > by clearing it here, and that means we clear it twice in the AER
> > native case, but I don't see any simpler way to do this, so this seems
> > fine as the fix for the current issue.
> 
> In AER native case, edr_handle_event() will never be triggered. So it
> won't be cleared twice.

This sounds like a plausible assumption.  But is there actually spec
language that says EDR notification is not allowed in the AER native
case (when OS owns the AER Capability)?  I looked but didn't find
anything.

> Other way is to add a new parameter to pcie_do_recovery(..., edr) and use
> it to conditionally call pcie_clear_device_status(). But I think current
> way is less complex.

I agree.

> > Question though: in the AER native case, pcie_do_recovery() calls
> > both:
> > 
> >   pcie_clear_device_status() and
> >   pci_aer_clear_nonfatal_status()
> > 
> > In this patch, you only call pcie_clear_device_status().  Do you care
> > about pci_aer_clear_nonfatal_status(), too?
> 
> Yes, we care about it. Since we call dpc_process_error() in EDR handler,
> it will eventually clear error status via pci_aer_clear_nonfatal_status()
> and pci_aer_clear_fatal_status() within dpc_process_error().

dpc_process_error() calls pci_aer_clear_nonfatal_status() in *some*
(but not all) cases.  I didn't try to work out whether those match the
cases where pcie_do_recovery() called it before 068c29a248b6.  I guess
we can assume it's equivalent for now.

> > The overall design for clearing status has gotten pretty complicated
> > as we've added error handling methods (firmware-first, DPC, EDR), and
> > there are so many different places and cases that it's hard to be sure
> > we do them all correctly.
> > 
> > I don't really know how to clean this up, so I'm just attaching my
> > notes about the current state:
> 
> Good summary! I can see a lot of overlap in clearing
> PCI_ERR_UNCOR_STATUS and PCI_EXP_DEVSTA.

Actually I do have one idea: in the firmware-first case, firmware
collects all the status information, clears it, and then passes the
status on to the OS.  In this case we don't need to clear the status
registers in handle_error_source(), pcie_do_recovery(), etc.

So I think the OS *should* be able to do something similar by
collecting the status information and clearing it first, before
starting error handling.  This might let us collect the status
clearing together in one place and also converge the firmware-first
and native error handling paths.

Obviously that would be a major future project.

Bjorn
