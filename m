Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7A46DB0D2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 18:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDGQqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 12:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjDGQqT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 12:46:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB9F76AA;
        Fri,  7 Apr 2023 09:46:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF0F865055;
        Fri,  7 Apr 2023 16:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2158C4339C;
        Fri,  7 Apr 2023 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680885977;
        bh=h+43W5Y7xKcIzevd8mxD8pi56Jm7fW0KJPju+M292eU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qCa/Agimw9L08qIP2+YiwM4kmhSEgwcz3TZoOMzj3pG+PC9JlNepjw4n/frvNJZA+
         QH7wCDDzgmQxOExPgI8M67nI2Q3C/l+0tI/JXnKloeHrT6rjaTNr8sdRK8PjnDOHQ7
         WXDCFC6SjZlP+Gnian3YPhst0I1OOl/UU8Dza6kUhiBHkUEPq6q8pqQzJQxrENwt6s
         NGpkNy8axAI8NCqEU3EWYH/50RGCvzufL5d1P0fzXdkBRQb6XtjawMs/5JkBDNa/5z
         hQO7aZKtBSgV3AExY+gs4UCj8wsI6OcARXDlozwF/odT8rHWkbl8TwDdto2T/nKOL7
         XmADdQgJtQ7Aw==
Date:   Fri, 7 Apr 2023 11:46:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Natu, Mahesh" <mahesh.natu@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Message-ID: <20230407164615.GA3802863@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18ccb5e6-0bc3-82ab-0c54-653ccd994c7b@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 06, 2023 at 10:31:20PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 4/6/23 3:21 PM, Bjorn Helgaas wrote:
> > On Thu, Apr 06, 2023 at 02:52:02PM -0700, Sathyanarayanan Kuppuswamy wrote:
> >> On 4/6/23 2:07 PM, Bjorn Helgaas wrote:
> >>> On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >>>> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
> >>>> OS owns AER") adds support to clear error status in the Device Status
> >>>> Register(DEVSTA) only if OS owns the AER support. But this change
> >>>> breaks the requirement of the EDR feature which requires OS to cleanup
> >>>> the error registers even if firmware owns the control of AER support.
> >>>>
> >>>> More details about this requirement can be found in PCIe Firmware
> >>>> specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
> >>>> If the OS supports the Error Disconnect Recover (EDR) feature and
> >>>> firmware sends the EDR event, then during the EDR recovery window, OS
> >>>> is responsible for the device error recovery and holds the ownership of
> >>>> the following error registers.
> >>>>
> >>>> • Device Status Register
> >>>> • Uncorrectable Error Status Register
> >>>> • Correctable Error Status Register
> >>>> • Root Error Status Register
> >>>> • RP PIO Status Register
> >>>>
> >>>> So call pcie_clear_device_status() in edr_handle_event() if the error
> >>>> recovery is successful.
> >>>>
> >>>> Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
> >>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >>>> ---
> >>>>
> >>>> Changes since v1:
> >>>>  * Rebased on top of v6.3-rc1.
> >>>>  * Fixed a typo in pcie_clear_device_status().
> >>>>
> >>>>  drivers/pci/pcie/edr.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> >>>> index a6b9b479b97a..87734e4c3c20 100644
> >>>> --- a/drivers/pci/pcie/edr.c
> >>>> +++ b/drivers/pci/pcie/edr.c
> >>>> @@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
> >>>>  	 */
> >>>>  	if (estate == PCI_ERS_RESULT_RECOVERED) {
> >>>>  		pci_dbg(edev, "DPC port successfully recovered\n");
> >>>> +		pcie_clear_device_status(edev);
> >>>>  		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
> >>>
> >>> The implementation note in PCI Firmware r3.3, sec 4.6.12, shows the OS
> >>> clearing error status *after* _OST is evaluated.
> >>>
> >>> On the other hand, the _OSC DPC control bit in table 4-6 says that if
> >>> the OS does not have DPC control, it can only write the Device Status
> >>> error bits between the EDR Notify and invoking _OST.
> >>>
> >>> Is one of those wrong, or am I missing something?
> >>
> >> Agree. It is conflicting info. IMO, the argument that the OS is allowed to
> >> clear the error registers during the EDR windows makes more sense. If OS
> >> is allowed to touch error registers owned by firmware after that window,
> >> it would lead to race conditions.
> >>
> >> Mahesh, let us know your comments. Maybe we need to fix this in the firmware
> >> specification.
> > 
> > My assumption was this sequence is something like this, where firmware
> > *can't* collect error status from devices below the Downstream Port
> > because DPC has been triggered and they are not accessible:
> > 
> >   - Hardware triggers DPC in a Downstream Port
> >   - Firmware fields error interrupt
> >   - Firmware captures Downstream Port error info (devices below are
> >     not accessible because of DPC)
> >   - Firmware sends EDR Notify to OS
> >   - OS brings Downstream Port out of DPC
> >   - OS collects error status from devices below Downstream Port
> >   - OS evaluates _OST
> >   - Firmware captures error status from devices below Downstream Port
> > 
> > But that doesn't explain why *firmware* could not clear the error
> > status of those devices after it captures it.
> > 
> > I guess the flowchart *does* show firmware clearing the error status
> > in the "do not continue recovery" path.
> 
> In this patch, we are clearing the port error status. So I think it is
> fine to do it in EDR window. Agree?

Ah, right, of course, thanks for pulling me back out of the weeds!
Yes, I do agree.

An EDR notification is issued on a bus device that is still present,
i.e., a DPC port or parent, but child devices have been disconnected
(ACPI v6.3, sec 5.6.6).

So in edr_handle_event(), pdev is the bus device that receives the
notification, edev is a bus device (possibly the same as pdev, or
possibly a child, but one that is still present), and child devices of
edev have been disconnected.

Prior to 068c29a248b6, pcie_do_recovery(edev) always cleared DEVSTA
for edev.  Afterwards it only clears DEVSTA if the OS owns AER.  This
patch makes edr_handle_event() clear DEVSTA for edev (the Port
device).

I had been looking at the bottom blue OS "Clear error status, ..." box
in the PCI Firmware implementation note, but that's the wrong one.
This is actually the "Clear port error status, bring Port out of DPC,
..." box higher up.  That's clearly before _OST and thus inside the
window.

That box *does* suggest clearing the port error status before bringing
the port out of DPC, and we're doing it in the opposite order:

  edr_handle_event(pdev)
    edev = acpi_dpc_port_get(pdev)
    # Both pdev and edev are present; pdev is same as edev or a
    # parent of edev; children of edev are disconnected
    dpc_process_error(edev)
    pcie_do_recovery(edev, dpc_reset_link)
      if (state == pci_channel_io_frozen)
        dpc_reset_link                  # (reset_subordinates)
          pci_write_config_word(PCI_EXP_DPC_STATUS_TRIGGER) # exit DPC
      if (AER native)
        pcie_clear_device_status(edev)
          clear PCI_EXP_DEVSTA          # doesn't happen
    if (PCI_ERS_RESULT_RECOVERED)
      pcie_clear_device_status
        clear PCI_EXP_DEVSTA            # added by this patch

Does it matter?  I dunno, but I don't *think* so.  We really don't
care about the value of PCI_EXP_DEVSTA anywhere except
pci_wait_for_pending_transaction(), which isn't applicable here.  And
I don't think the fact that it probably has an Error Detected bit set
when exiting DPC is a problem.

Bjorn
