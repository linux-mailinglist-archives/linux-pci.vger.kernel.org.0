Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12189293CA8
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 15:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407190AbgJTNBY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 20 Oct 2020 09:01:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2996 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406964AbgJTNBX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 09:01:23 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 4B906B52A297A4B66437;
        Tue, 20 Oct 2020 14:01:20 +0100 (IST)
Received: from localhost (10.52.123.192) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 20 Oct
 2020 14:01:17 +0100
Date:   Tue, 20 Oct 2020 13:59:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ethan Zhao <xerces.zhao@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Sean V Kelley <seanvk.dev@oregontracks.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <rafael.j.wysocki@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <qiuxu.zhuo@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sinan Kaya <okaya@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v9 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Message-ID: <20201020125920.0000399b@Huawei.com>
In-Reply-To: <E5E378D7-B2F8-49E2-AC8C-01E70D58B64C@intel.com>
References: <20201016203037.GA90074@bjorn-Precision-5520>
        <20201016222902.GA112659@bjorn-Precision-5520>
        <CAKF3qh3NDvQAwb922faHgja+YoDydCtg5sugEQ8T2ti+3WSn5Q@mail.gmail.com>
        <4F54EEC0-3933-4A2E-87BC-23FABECB0C0A@intel.com>
        <240932c3-2cf4-5fbd-9cda-520bbd953fa6@linux.intel.com>
        <E5E378D7-B2F8-49E2-AC8C-01E70D58B64C@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.123.192]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 19 Oct 2020 13:50:17 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> On 19 Oct 2020, at 11:59, Kuppuswamy, Sathyanarayanan wrote:
> 
> > On 10/19/20 11:31 AM, Sean V Kelley wrote:  
> >> On 19 Oct 2020, at 3:49, Ethan Zhao wrote:
> >>  
> >>> On Sat, Oct 17, 2020 at 6:29 AM Bjorn Helgaas <helgaas@kernel.org> 
> >>> wrote:  
> >>>>
> >>>> [+cc Christoph, Ethan, Sinan, Keith; sorry should have cc'd you to
> >>>> begin with since you're looking at this code too. Particularly
> >>>> interested in your thoughts about whether we should be touching
> >>>> PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS when we don't own 
> >>>> AER.]  
> >>>
> >>> aer_root_reset() function has a prefix  'aer_', looks like it's a
> >>> function of aer driver, will
> >>> only be called by aer driver at runtime. if so it's up to the
> >>> owner/aer to know if OSPM is
> >>> granted to init. while actually some of the functions and runtime 
> >>> service of
> >>> aer driver is also shared by GHES driver (running time) and DPC 
> >>> driver
> >>> (compiling time ?)
> >>> etc. then it is confused now.
> >>>
> >>> Shall we move some of the shared functions and running time service 
> >>> to
> >>> pci/err.c ?
> >>> if so , just like pcie_do_recovery(), it's share by firmware_first  
> >>> mode GHES
> >>> ghes_probe()  
> >>> ->ghes_irq_func  
> >>>   ->ghes_proc
> >>>     ->ghes_do_proc()
> >>>       ->ghes_handle_aer()
> >>>         ->aer_recover_work_func()
> >>>           ->pcie_do_recovery()
> >>>             ->aer_root_reset()
> >>>
> >>> and aer driver etc.  if aer wants to do some access might conflict
> >>> with firmware(or
> >>> firmware in embedded controller) should check _OSC_ etc first. 
> >>> blindly issue
> >>> PCI_ERR_ROOT_COMMAND  or clear PCI_ERR_ROOT_STATUS *likely*
> >>> cause errors by error handling itself.  
> >>
> >> If _OSC negotiation ends up with FW being in control of AER, that 
> >> means OS is not in charge and should not be messing with AER I guess. 
> >> That seems appropriate to me then.  
> > But APEI based notification is more like a hybrid approach (frimware 
> > first detects the
> > error and notifies OS). Since spec does not clarify what OS is allowed 
> > to do, its bit of a
> > gray area now. My point is, since firmware allows OS to process the 
> > error by sending
> > the notification, I think its OK to clear the status once the error is 
> > handled.  
> 
> I don’t disagree as long as AER is granted to the OS via _OSC. But if 
> it’s not granted explicitly via _OSC even in the APEI case where 
> it’s either an SCI or NMI and not an MSI, I’m unsure whether the OS 
> should be touching those registers.

My assumption was indeed this.  If AER hasn't been granted to the OS,
it shouldn't be doing anything involving AER itself.  It should constrain
itself to dealing with the End Points etc due to the need there for
driver interaction.

I fully agree with the comment that the specifications aren't entirely
clear on these cases.

It is possible that no one is currently generating the particular
combination of severity bits in the APEI path to actually hit this.
It requires the outer record to be marked recoverable, but the inner
part to be marked fatal.  Kind of an odd mix.

In the GHES case, you get to this path by having a
Generic Error Status Block - recoverable (must not be fatal to avoid panic()
in APEI layer) containing one more more Generic Error Blocks, one of
which is fatal.

Response of our firmware team is that this particularly combination is
probably crazy.

So good to clean up this corner, but it is probably not a problem
anyone has actually hit so far.

Jonathan


> 
> Sean
> 
> >>
> >> Thanks,
> >>
> >> Sean
> >>
> >>
> >>  
> >>>
> >>> Thanks,
> >>> Ethan
> >>>  
> >>>>
> >>>> On Fri, Oct 16, 2020 at 03:30:37PM -0500, Bjorn Helgaas wrote:  
> >>>>> [+to Jonathan]
> >>>>>
> >>>>> On Thu, Oct 15, 2020 at 05:11:10PM -0700, Sean V Kelley wrote:  
> >>>>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >>>>>>
> >>>>>> When attempting error recovery for an RCiEP associated with an 
> >>>>>> RCEC device,
> >>>>>> there needs to be a way to update the Root Error Status, the 
> >>>>>> Uncorrectable
> >>>>>> Error Status and the Uncorrectable Error Severity of the parent 
> >>>>>> RCEC.  In
> >>>>>> some non-native cases in which there is no OS-visible device 
> >>>>>> associated
> >>>>>> with the RCiEP, there is nothing to act upon as the firmware is 
> >>>>>> acting
> >>>>>> before the OS.
> >>>>>>
> >>>>>> Add handling for the linked RCEC in AER/ERR while taking into 
> >>>>>> account
> >>>>>> non-native cases.
> >>>>>>
> >>>>>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> >>>>>> Link: 
> >>>>>> https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@oregontracks.org
> >>>>>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> >>>>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >>>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>>> ---
> >>>>>>  drivers/pci/pcie/aer.c | 53 
> >>>>>> ++++++++++++++++++++++++++++++------------
> >>>>>>  drivers/pci/pcie/err.c | 20 ++++++++--------
> >>>>>>  2 files changed, 48 insertions(+), 25 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >>>>>> index 65dff5f3457a..083f69b67bfd 100644
> >>>>>> --- a/drivers/pci/pcie/aer.c
> >>>>>> +++ b/drivers/pci/pcie/aer.c
> >>>>>> @@ -1357,27 +1357,50 @@ static int aer_probe(struct pcie_device 
> >>>>>> *dev)
> >>>>>>   */
> >>>>>>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> >>>>>>  {
> >>>>>> -   int aer = dev->aer_cap;
> >>>>>> +   int type = pci_pcie_type(dev);
> >>>>>> +   struct pci_dev *root;
> >>>>>> +   int aer = 0;
> >>>>>> +   int rc = 0;
> >>>>>>     u32 reg32;
> >>>>>> -   int rc;
> >>>>>>
> >>>>>> +   if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END)  
> >>>>>
> >>>>> "type == PCI_EXP_TYPE_RC_END"
> >>>>>  
> >>>>>> +           /*
> >>>>>> +            * The reset should only clear the Root 
> >>>>>> Error Status
> >>>>>> +            * of the RCEC. Only perform this for the
> >>>>>> +            * native case, i.e., an RCEC is present.
> >>>>>> +            */
> >>>>>> +           root = dev->rcec;
> >>>>>> +   else
> >>>>>> +           root = dev;
> >>>>>>
> >>>>>> -   /* Disable Root's interrupt in response to error messages 
> >>>>>> */
> >>>>>> -   pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, 
> >>>>>> &reg32);
> >>>>>> -   reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> >>>>>> -   pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, 
> >>>>>> reg32);
> >>>>>> +   if (root)
> >>>>>> +           aer = dev->aer_cap;
> >>>>>>
> >>>>>> -   rc = pci_bus_error_reset(dev);
> >>>>>> -   pci_info(dev, "Root Port link has been reset\n");
> >>>>>> +   if (aer) {
> >>>>>> +           /* Disable Root's interrupt in response to 
> >>>>>> error messages */
> >>>>>> +           pci_read_config_dword(root, aer + 
> >>>>>> PCI_ERR_ROOT_COMMAND, &reg32);
> >>>>>> +           reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> >>>>>> +           pci_write_config_dword(root, aer + 
> >>>>>> PCI_ERR_ROOT_COMMAND, reg32);  
> >>>>>
> >>>>> Not directly related to *this* patch, but my assumption was that 
> >>>>> in
> >>>>> the APEI case, the firmware should retain ownership of the AER
> >>>>> Capability, so the OS should not touch PCI_ERR_ROOT_COMMAND and
> >>>>> PCI_ERR_ROOT_STATUS.
> >>>>>
> >>>>> But this code appears to ignore that ownership.  Jonathan, you 
> >>>>> must
> >>>>> have looked at this recently for 068c29a248b6 ("PCI/ERR: Clear 
> >>>>> PCIe
> >>>>> Device Status errors only if OS owns AER").  Do you have any 
> >>>>> insight
> >>>>> about this?
> >>>>>  
> >>>>>> -   /* Clear Root Error Status */
> >>>>>> -   pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, 
> >>>>>> &reg32);
> >>>>>> -   pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, 
> >>>>>> reg32);
> >>>>>> +           /* Clear Root Error Status */
> >>>>>> +           pci_read_config_dword(root, aer + 
> >>>>>> PCI_ERR_ROOT_STATUS, &reg32);
> >>>>>> +           pci_write_config_dword(root, aer + 
> >>>>>> PCI_ERR_ROOT_STATUS, reg32);
> >>>>>>
> >>>>>> -   /* Enable Root Port's interrupt in response to error 
> >>>>>> messages */
> >>>>>> -   pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, 
> >>>>>> &reg32);
> >>>>>> -   reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> >>>>>> -   pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, 
> >>>>>> reg32);
> >>>>>> +           /* Enable Root Port's interrupt in response 
> >>>>>> to error messages */
> >>>>>> +           pci_read_config_dword(root, aer + 
> >>>>>> PCI_ERR_ROOT_COMMAND, &reg32);
> >>>>>> +           reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> >>>>>> +           pci_write_config_dword(root, aer + 
> >>>>>> PCI_ERR_ROOT_COMMAND, reg32);
> >>>>>> +   }
> >>>>>> +
> >>>>>> +   if ((type == PCI_EXP_TYPE_RC_EC) || (type == 
> >>>>>> PCI_EXP_TYPE_RC_END)) {
> >>>>>> +           if (pcie_has_flr(root)) {
> >>>>>> +                   rc = pcie_flr(root);
> >>>>>> +                   pci_info(dev, "has been 
> >>>>>> reset (%d)\n", rc);
> >>>>>> +           }
> >>>>>> +   } else {
> >>>>>> +           rc = pci_bus_error_reset(root);  
> >>>>>
> >>>>> Don't we want "dev" for both the FLR and pci_bus_error_reset()?  
> >>>>> I
> >>>>> think "root == dev" except when dev is an RCiEP.  When dev is an
> >>>>> RCiEP, "root" is the RCEC (if present), and we want to reset the
> >>>>> RCiEP, not the RCEC.
> >>>>>  
> >>>>>> +           pci_info(dev, "Root Port link has been 
> >>>>>> reset (%d)\n", rc);
> >>>>>> +   }  
> >>>>>
> >>>>> There are a couple changes here that I think should be split out.
> >>>>>
> >>>>> Based on my theory that when firmware retains control of AER, the 
> >>>>> OS
> >>>>> should not touch PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS, and 
> >>>>> any
> >>>>> updates to them would have to be done by firmware before we get 
> >>>>> here,
> >>>>> I suggested reordering this:
> >>>>>
> >>>>>   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> >>>>>   - do reset
> >>>>>   - clear PCI_ERR_ROOT_STATUS (for APEI, presumably done by 
> >>>>> firmware?)
> >>>>>   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> >>>>>
> >>>>> to this:
> >>>>>
> >>>>>   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> >>>>>   - clear PCI_ERR_ROOT_STATUS
> >>>>>   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> >>>>>   - do reset
> >>>>>
> >>>>> If my theory is correct, I think we should still reorder this, 
> >>>>> but:
> >>>>>
> >>>>>   - It's a significant behavior change that deserves its own 
> >>>>> patch so
> >>>>>     we can document/bisect/revert.
> >>>>>
> >>>>>   - I'm not sure why we clear the PCI_ERR_ROOT_COMMAND error 
> >>>>> reporting
> >>>>>     bits.  In the new "clear COMMAND, clear STATUS, enable 
> >>>>> COMMAND"
> >>>>>     order, it looks superfluous.  There's no reason to disable 
> >>>>> error
> >>>>>     reporting while clearing the status bits.
> >>>>>
> >>>>>     The current "clear, reset, enable" order suggests that the 
> >>>>> reset
> >>>>>     might cause errors that we should ignore.  I don't know 
> >>>>> whether
> >>>>>     that's the case or not.  It dates from 6c2b374d7485 
> >>>>> ("PCI-Express
> >>>>>     AER implemetation: AER core and aerdriver"), which doesn't
> >>>>>     elaborate.
> >>>>>
> >>>>>   - Should we also test for OS ownership of AER before touching
> >>>>>     PCI_ERR_ROOT_STATUS?
> >>>>>
> >>>>>   - If we remove the PCI_ERR_ROOT_COMMAND fiddling (and I 
> >>>>> tentatively
> >>>>>     think we *should* unless we can justify it), that would 
> >>>>> also
> >>>>>     deserve its own patch.  Possibly (1) remove 
> >>>>> PCI_ERR_ROOT_COMMAND
> >>>>>     fiddling, (2) reorder PCI_ERR_ROOT_STATUS clearing and 
> >>>>> reset, (3)
> >>>>>     test for OS ownership of AER (?), (4) the rest of this 
> >>>>> patch.
> >>>>>  
> >>>>>>     return rc ? PCI_ERS_RESULT_DISCONNECT : 
> >>>>>> PCI_ERS_RESULT_RECOVERED;
> >>>>>>  }
> >>>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> >>>>>> index 7883c9791562..cbc5abfe767b 100644
> >>>>>> --- a/drivers/pci/pcie/err.c
> >>>>>> +++ b/drivers/pci/pcie/err.c
> >>>>>> @@ -148,10 +148,10 @@ static int report_resume(struct pci_dev 
> >>>>>> *dev, void *data)
> >>>>>>
> >>>>>>  /**
> >>>>>>   * pci_walk_bridge - walk bridges potentially AER affected
> >>>>>> - * @bridge:        bridge which may be a Port, an RCEC 
> >>>>>> with associated RCiEPs,
> >>>>>> - *         or an RCiEP associated with an RCEC
> >>>>>> - * @cb:            callback to be called for each 
> >>>>>> device found
> >>>>>> - * @userdata:      arbitrary pointer to be passed to 
> >>>>>> callback
> >>>>>> + * @bridge   bridge which may be an RCEC with associated 
> >>>>>> RCiEPs,
> >>>>>> + *           or a Port.
> >>>>>> + * @cb       callback to be called for each device found
> >>>>>> + * @userdata arbitrary pointer to be passed to callback.
> >>>>>>   *
> >>>>>>   * If the device provided is a bridge, walk the subordinate 
> >>>>>> bus, including
> >>>>>>   * any bridged devices on buses under this bus.  Call the 
> >>>>>> provided callback
> >>>>>> @@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev 
> >>>>>> *bridge,
> >>>>>>                         int (*cb)(struct 
> >>>>>> pci_dev *, void *),
> >>>>>>                         void *userdata)
> >>>>>>  {
> >>>>>> +   /*
> >>>>>> +    * In a non-native case where there is no OS-visible 
> >>>>>> reporting
> >>>>>> +    * device the bridge will be NULL, i.e., no RCEC, no 
> >>>>>> Downstream Port.
> >>>>>> +    */
> >>>>>>     if (bridge->subordinate)
> >>>>>>             pci_walk_bus(bridge->subordinate, cb, 
> >>>>>> userdata);
> >>>>>> +   else if (bridge->rcec)
> >>>>>> +           cb(bridge->rcec, userdata);
> >>>>>>     else
> >>>>>>             cb(bridge, userdata);
> >>>>>>  }
> >>>>>> @@ -194,12 +200,6 @@ pci_ers_result_t pcie_do_recovery(struct 
> >>>>>> pci_dev *dev,
> >>>>>>     pci_dbg(bridge, "broadcast error_detected message\n");
> >>>>>>     if (state == pci_channel_io_frozen) {
> >>>>>>             pci_walk_bridge(bridge, 
> >>>>>> report_frozen_detected, &status);
> >>>>>> -           if (type == PCI_EXP_TYPE_RC_END) {
> >>>>>> -                   pci_warn(dev, "subordinate 
> >>>>>> device reset not possible for RCiEP\n");
> >>>>>> -                   status = 
> >>>>>> PCI_ERS_RESULT_NONE;
> >>>>>> -                   goto failed;
> >>>>>> -           }
> >>>>>> -
> >>>>>>             status = reset_subordinates(bridge);
> >>>>>>             if (status != PCI_ERS_RESULT_RECOVERED) {
> >>>>>>                     pci_warn(bridge, 
> >>>>>> "subordinate device reset failed\n");
> >>>>>> -- 
> >>>>>> 2.28.0
> >>>>>>  
> > -- 
> > Sathyanarayanan Kuppuswamy
> > Linux Kernel Developer  


