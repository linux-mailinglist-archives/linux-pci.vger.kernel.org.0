Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1486184F46
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 20:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCMT2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 15:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCMT2T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 15:28:19 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 495BD206B1;
        Fri, 13 Mar 2020 19:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584127698;
        bh=yapCUX29JNfAWIVIeh7jsoA5HNjFmMIPVC77TJPQL1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PGO1SC2kjiJuHd7q8l3Oaw4ZZKtP6j31JDY4vXHzBeg1ywBssky/guA6yQU9k2Dnl
         fX7r1N94x1hYtIrLL3hXICnruOlAlswFrwb6N/duu63CCAgKeW1BLk88fiwd9L4vrt
         Fb8y/jT5nn3vIzysClfOi6bnWO6eEMJpxToD0TBk=
Date:   Fri, 13 Mar 2020 14:28:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200313192816.GA127896@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d06c72d-7f77-84d5-4163-187bc62b903a@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Russell, Sam, Oliver since we're talking about the error recovery
flow.  The code we're talking about is at [1]]

On Thu, Mar 12, 2020 at 11:22:13PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> On 3/12/2020 3:32 PM, Bjorn Helgaas wrote:
> > On Thu, Mar 12, 2020 at 02:59:15PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > On 3/12/20 12:53 PM, Bjorn Helgaas wrote:
> > > > On Wed, Mar 11, 2020 at 04:07:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > > > On 3/11/20 3:23 PM, Bjorn Helgaas wrote:
> > > > > > Is any synchronization needed here between the EDR path and the
> > > > > > hotplug/enumeration path?
> > > > > If we want to follow the implementation note step by step (in
> > > > > sequence) then we need some synchronization between EDR path and
> > > > > enumeration path. But if it's OK to achieve the same end result by
> > > > > following steps out of sequence then we don't need to create any
> > > > > dependency between EDR and enumeration paths. Currently we follow
> > > > > the latter approach.
> > > > What would the synchronization look like?
> > > we might need some way to disable the enumeration path till
> > > we get response from firmware.
> > > 
> > > In native hot plug case, I think we can do it in two ways.
> > > 
> > > 1. Disable hotplug notification in slot ctl registers.
> > >      (pcie_disable_notification())
> > > 2. Some how block hotplug driver from processing the new
> > >      events (not sure how feasible its).
> > > 
> > > Following method 1 would be easy, But I am not sure whether
> > > its alright to disable them randomly. I think, unless we
> > > clear the status as well, we might get some issues due to stale
> > > notification history.
> > > 
> > > For ACPI event case, I am not sure whether we have some
> > > communication protocol in place to disable receiving ACPI
> > > events temporarily.
> > > 
> > > For polling model, we need to disable to the polling
> > > timer thread till we receive _OST response from firmware.
> > > > 
> > > > Ideally I think it would be better to follow the order in the
> > > > flowchart if it's not too onerous.
> > > None of the above changes will be pretty and I think it will
> > > not be simple as well.
> > > >    That will make the code easier to
> > > > understand.  The current situation with this dependency on pciehp and
> > > > what it will do leaves a lot of things implicit.
> > > > 
> > > > What happens if CONFIG_PCIE_EDR=y but CONFIG_HOTPLUG_PCI_PCIE=n?
> > > > 
> > > > IIUC, when DPC triggers, pciehp is what fields the DLLSC interrupt and
> > > > unbinds the drivers and removes the devices.
> > > 
> > > >   If that doesn't happen, and Linux clears the DPC trigger to bring
> > > >   the link back up, will those drivers try to operate uninitialized
> > > >   devices?
> > > 
> > > I don't think this will happen. In DPC reset_link before we bring up
> > > the device we wait for link to go down first using
> > > pcie_wait_for_link(pdev, false) function.
> > 
> > I understand that, but these child devices were reset when DPC
> > disabled the link.  When the link comes back up, their BARs
> > contain zeros.
> > 
> > If CONFIG_HOTPLUG_PCI_PCIE=y, the DLLSC interrupt will cause
> > pciehp to unbind the driver.  It seems like the unbind races with
> > the EDR notify handler.
> 
> Agree. But even if there is a race condition, after clearing DPC
> trigger status, if hotplug driver properly removes/re-enumerates the
> driver then the end result will still be same. There should be no
> functional impact.
> 
> > If pciehp unbinds the driver before edr_handle_event() calls
> > pcie_do_recovery(), this seems fine -- we'll call
> > dpc_reset_link(), which brings up the link, we won't call any
> > driver callbacks because there's no driver, and another DLLSC
> > interrupt will cause pciehp to re-enumerate, which will
> > re-initialize the device, then rebind the driver.
> > 
> > If the EDR notify handler runs before pciehp unbinds the driver,
>
> In the above case, from the kernel perspective device is still
> accessible and IIUC, it will try to recover it in pcie_do_recovery()
> using one of the callbacks.
> 
> int (*mmio_enabled)(struct pci_dev *dev);
> int (*slot_reset)(struct pci_dev *dev);
> void (*resume)(struct pci_dev *dev);
> 
> One of these callbacks will do pci_restore_state() to restore the
> device, and IO will not attempted in these callbacks until the device
> is successfully recovered.

That might be what *should* happen, but I don't think it's what
*does* happen.

I don't think we use .mmio_enabled() and .slot_reset() for EDR
because Linux EDR currently depends on DPC, so we'll be using
dpc_reset_link(), which normally returns PCI_ERS_RESULT_RECOVERED,
so pcie_do_recovery() skips .mmio_enabled() and .slot_reset().

I looked at the first few .resume() implementations (FWIW, I used [2]
to find them), and none of them calls pci_restore_state() before doing
I/O to the device:

  ioat_pcie_error_resume()
  pci_resume() (hfi1)
  qib_pci_resume()
  cxl_pci_resume()
  genwqe_err_resume()
  ...

But I assume you've tested EDR with some driver that *does* call
pci_restore_state()?  Or maybe you have pciehp enabled, and it always
wins the race and unbinds the driver before the EDR notification?  It
would be interesting to make pciehp *lose* the race and see if
anything breaks.

pci-error-recovery.rst does not mention any requirement for the driver
to call pci_restore_state(), and I think any state restoration like
that should be the responsibility of the PCI core, not the driver.

> > couldn't EDR bring up the link and call driver .mmio_enabled() before
> > the device has been initialized?
>
> Calling mmio_enabled in this case should not be a problem right?
>
> Please check the following content from
> Documentation/PCI/pci-error-recovery.rst. IIUC (following content),
> IO will not be attempted until the device is successfully
> re-configured.
> 
> STEP 2: MMIO Enabled
> --------------------
> This callback is made if all drivers on a segment agree that they can
> try to recover and if no automatic link reset was performed by the HW.
> If the platform can't just re-enable IOs without a slot reset or a link
> reset, it will not call this callback, and instead will have gone
> directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
> 
> > If CONFIG_HOTPLUG_PCI_PCIE=n and CONFIG_HOTPLUG_PCI_ACPI=y, I could
> > believe that the situations are similar to the above.
> > 
> > What if CONFIG_HOTPLUG_PCI_PCIE=n and CONFIG_HOTPLUG_PCI_ACPI=n?  Then
> > I assume there's nothing to unbind the driver, so pcie_do_recovery()
> > will call the driver .mmio_enabled() and other recovery callbacks on a
> > device that hasn't been initialized?
> 
> probably in .slot_reset() callback device config will be restored and it
> will make the device functional again.

I don't think .mmio_enabled() is a problem because IIUC, the device
should not have been reset before calling .mmio_enabled().

But I think .slot_reset() *is* a problem.  I looked at several
.slot_reset() implementations ([3]); some called pci_restore_state(),
but many did not.

If no hotplug driver is enabled, I think the .slot_reset() callbacks
that do not call pci_restore_state() are broken.

> Also since in above case hotplug is not supported, topology change will
> not be supported.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=review/edr
[2] F='\.resume'; git grep -A 10 "struct pci_error_handlers" | grep "$F\s*=" | sed -e "s/.*$F\s*=\s*//" -e 's/,\s*$//'
[3] F='\.slot_reset'; git grep -A 10 "struct pci_error_handlers" | grep "$F\s*=" | sed -e "s/.*$F\s*=\s*//" -e 's/,\s*$//'
