Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EBE6DA5B0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 00:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjDFWVk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 18:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDFWVj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 18:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5DA59DA;
        Thu,  6 Apr 2023 15:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AE3064272;
        Thu,  6 Apr 2023 22:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CA1C433EF;
        Thu,  6 Apr 2023 22:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680819697;
        bh=loBUikWknrpn/iXVH1Gwh7V+JZYKVvtJIqs39q/UxDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QyDjrY8DeTPQ2+fBmMWhTCQAlW0GIOFtcvGjykP4Lfu1fHE58veAJCYbgfKTACxLb
         B31i9rURXYBRK5leAj9+xo04gi4BrKIJhGSJ2ikSVzkR0ZLp8u+nTf0o/u/llb1JCx
         NFTILc27nqnS7z9x1VZlqy+CNQLhXLcSmtKkRq20W1oBVf7qN5XuYjePfNOPGPyVe6
         G27DswAtra+PQFAnb3pHqxsqBowmVx0lauyKPGUQR8oJbfTgNZynnam07pshH5WgYQ
         tDgBg3F37VEFHkzY4Zls6Gm/fzCU46lHFPSu+jzMCFD7DFa55hjhkB4s8XvClNKS0X
         NbRceP7tT5N9A==
Date:   Thu, 6 Apr 2023 17:21:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Natu, Mahesh" <mahesh.natu@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Message-ID: <20230406222135.GA3743643@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4803e7e-bbfe-8925-88e9-935775960e63@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 06, 2023 at 02:52:02PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 4/6/23 2:07 PM, Bjorn Helgaas wrote:
> > On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
> >> OS owns AER") adds support to clear error status in the Device Status
> >> Register(DEVSTA) only if OS owns the AER support. But this change
> >> breaks the requirement of the EDR feature which requires OS to cleanup
> >> the error registers even if firmware owns the control of AER support.
> >>
> >> More details about this requirement can be found in PCIe Firmware
> >> specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
> >> If the OS supports the Error Disconnect Recover (EDR) feature and
> >> firmware sends the EDR event, then during the EDR recovery window, OS
> >> is responsible for the device error recovery and holds the ownership of
> >> the following error registers.
> >>
> >> • Device Status Register
> >> • Uncorrectable Error Status Register
> >> • Correctable Error Status Register
> >> • Root Error Status Register
> >> • RP PIO Status Register
> >>
> >> So call pcie_clear_device_status() in edr_handle_event() if the error
> >> recovery is successful.
> >>
> >> Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> ---
> >>
> >> Changes since v1:
> >>  * Rebased on top of v6.3-rc1.
> >>  * Fixed a typo in pcie_clear_device_status().
> >>
> >>  drivers/pci/pcie/edr.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> >> index a6b9b479b97a..87734e4c3c20 100644
> >> --- a/drivers/pci/pcie/edr.c
> >> +++ b/drivers/pci/pcie/edr.c
> >> @@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
> >>  	 */
> >>  	if (estate == PCI_ERS_RESULT_RECOVERED) {
> >>  		pci_dbg(edev, "DPC port successfully recovered\n");
> >> +		pcie_clear_device_status(edev);
> >>  		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
> > 
> > The implementation note in PCI Firmware r3.3, sec 4.6.12, shows the OS
> > clearing error status *after* _OST is evaluated.
> > 
> > On the other hand, the _OSC DPC control bit in table 4-6 says that if
> > the OS does not have DPC control, it can only write the Device Status
> > error bits between the EDR Notify and invoking _OST.
> > 
> > Is one of those wrong, or am I missing something?
> 
> Agree. It is conflicting info. IMO, the argument that the OS is allowed to
> clear the error registers during the EDR windows makes more sense. If OS
> is allowed to touch error registers owned by firmware after that window,
> it would lead to race conditions.
> 
> Mahesh, let us know your comments. Maybe we need to fix this in the firmware
> specification.

My assumption was this sequence is something like this, where firmware
*can't* collect error status from devices below the Downstream Port
because DPC has been triggered and they are not accessible:

  - Hardware triggers DPC in a Downstream Port
  - Firmware fields error interrupt
  - Firmware captures Downstream Port error info (devices below are
    not accessible because of DPC)
  - Firmware sends EDR Notify to OS
  - OS brings Downstream Port out of DPC
  - OS collects error status from devices below Downstream Port
  - OS evaluates _OST
  - Firmware captures error status from devices below Downstream Port

But that doesn't explain why *firmware* could not clear the error
status of those devices after it captures it.

I guess the flowchart *does* show firmware clearing the error status
in the "do not continue recovery" path.
