Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22D36DB6A1
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 00:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDGWmM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 18:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjDGWmL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 18:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77290D30D;
        Fri,  7 Apr 2023 15:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D79716544F;
        Fri,  7 Apr 2023 22:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFACC433D2;
        Fri,  7 Apr 2023 22:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680907304;
        bh=oU9YWGke34o2CXW/4PVaF6b6aPeOElbQjqDUFQFrfvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=acEZK0S69gp0XtPgWqLPemetud9eCJPg+TSfmnr1MSU4qTXi/pUD4SwPyZtpb6Erl
         1dBXqYh8QwIQKbFtSc+/WNjMneaEAOkPIB1axXbaB7+lrHpD9DvEgQE7B5YWEsHM5H
         sa01jPj7TXUNEPRQx8FtBtwcefZmvrBMp1daJDOjgJ0Ta0couT4LyhuOJIOZAO1Vdh
         tp6WD2C7pKwyOIOkz+NYVxyshtkZB5V0tmINZ5ikufmfW+DiVELeMelCiApKffyeCA
         xuFw+/o9Dto4Lw9akYx97/Uol1B3iH5AIZ8WJ77hfaZKw/DoyHeSpBMmZaaYM4iiUc
         CA8sh2aMn0/2w==
Date:   Fri, 7 Apr 2023 17:41:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Natu, Mahesh" <mahesh.natu@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Message-ID: <20230407224142.GA3829056@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc7cc268-f614-beaf-da5a-a4db9137c38a@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 07, 2023 at 03:19:32PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 4/7/23 9:46 AM, Bjorn Helgaas wrote:
> > On Thu, Apr 06, 2023 at 10:31:20PM -0700, Sathyanarayanan Kuppuswamy wrote:
> >> On 4/6/23 3:21 PM, Bjorn Helgaas wrote:
> >>> On Thu, Apr 06, 2023 at 02:52:02PM -0700, Sathyanarayanan Kuppuswamy wrote:
> >>>> On 4/6/23 2:07 PM, Bjorn Helgaas wrote:
> >>>>> On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >>>>>> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
> >>>>>> OS owns AER") adds support to clear error status in the Device Status
> >>>>>> Register(DEVSTA) only if OS owns the AER support. But this change
> >>>>>> breaks the requirement of the EDR feature which requires OS to cleanup
> >>>>>> the error registers even if firmware owns the control of AER support.

> ...
> > An EDR notification is issued on a bus device that is still present,
> > i.e., a DPC port or parent, but child devices have been disconnected
> > (ACPI v6.3, sec 5.6.6).
> 
> IMO, instead of bus device, we can call it as root port or down stream
> port. Please check the PCI firmware specification, r3.3, section 4.3.13.

Yeah, that makes sense.  I just used the "bus device" language because
that's what's in the ACPI spec.  But I think the PCI terms would
probably be more helpful here.  And I'll cite the r6.5 spec instead of
v6.3.

> Firmware may wish to issue Error Disconnect Recover notification on a port
> that is parent of the port that experienced the containment event.
> 
> So it is either a downstream port or a root port.

Right.

> > That box *does* suggest clearing the port error status before bringing
> > the port out of DPC, and we're doing it in the opposite order:
> > 
> >   edr_handle_event(pdev)
> >     edev = acpi_dpc_port_get(pdev)
> >     # Both pdev and edev are present; pdev is same as edev or a
> >     # parent of edev; children of edev are disconnected
> >     dpc_process_error(edev)
> >     pcie_do_recovery(edev, dpc_reset_link)
> >       if (state == pci_channel_io_frozen)
> >         dpc_reset_link                  # (reset_subordinates)
> >           pci_write_config_word(PCI_EXP_DPC_STATUS_TRIGGER) # exit DPC
> >       if (AER native)
> >         pcie_clear_device_status(edev)
> >           clear PCI_EXP_DEVSTA          # doesn't happen
> >     if (PCI_ERS_RESULT_RECOVERED)
> >       pcie_clear_device_status
> >         clear PCI_EXP_DEVSTA            # added by this patch
> > 
> > Does it matter?  I dunno, but I don't *think* so.  We really don't
> > care about the value of PCI_EXP_DEVSTA anywhere except
> > pci_wait_for_pending_transaction(), which isn't applicable here.  And
> > I don't think the fact that it probably has an Error Detected bit set
> > when exiting DPC is a problem.
> 
> Agree that it is not a fatal issue. But leaving the stale error state
> is something that needs to be fixed.

Definitely agree we should clear the stale state.  I just meant that I
don't think it matters that we clear the status *after* exiting DPC,
instead of clearing it before exiting DPC as shown in the flowchart.

Bjorn
