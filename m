Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57C033E218
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 00:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCPX2U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 16 Mar 2021 19:28:20 -0400
Received: from server.avery-design.com ([198.57.169.184]:52906 "EHLO
        server.avery-design.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCPX2L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 19:28:11 -0400
Received: from ool-44c0a99c.dyn.optonline.net ([68.192.169.156]:55986 helo=[192.168.1.180])
        by server.avery-design.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <cbrowy@avery-design.com>)
        id 1lMJ5R-0005MW-Cb; Tue, 16 Mar 2021 23:26:53 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH 1/2] PCI/doe: Initial support PCI Data Object Exchange
From:   Chris Browy <cbrowy@avery-design.com>
In-Reply-To: <CAPcyv4h6hHCuO=0vHbPz2m4qw6-0=wW9swBrWimBsz6_GJu4Aw@mail.gmail.com>
Date:   Tue, 16 Mar 2021 19:26:50 -0400
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Reply-To: CAPcyv4h6hHCuO=0vHbPz2m4qw6-0=wW9swBrWimBsz6_GJu4Aw@mail.gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <6F0B8DDD-E661-40C8-839B-1B77998EFF23@avery-design.com>
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
 <20210310180306.1588376-2-Jonathan.Cameron@huawei.com>
 <CAPcyv4gG-==Vj9w3d7=gRRSPaoD5eZHZZ2hAA0h3c07eMT_x1A@mail.gmail.com>
 <20210316162952.00001ab7@Huawei.com>
 <CAPcyv4h6hHCuO=0vHbPz2m4qw6-0=wW9swBrWimBsz6_GJu4Aw@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.avery-design.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avery-design.com
X-Get-Message-Sender-Via: server.avery-design.com: authenticated_id: cbrowy@avery-design.com
X-Authenticated-Sender: server.avery-design.com: cbrowy@avery-design.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please address and clarify 2 queries below...


> On Mar 16, 2021, at 2:14 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> 
> On Tue, Mar 16, 2021 at 9:31 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>> 
>> On Mon, 15 Mar 2021 12:45:49 -0700
>> Dan Williams <dan.j.williams@intel.com> wrote:
>> 
>>> Hey Jonathan, happy to see this, some comments below...
>> 
>> Hi Dan,
>> 
>> Thanks for taking a look!
>> 
>>> 
>>> On Wed, Mar 10, 2021 at 10:08 AM Jonathan Cameron
>>> <Jonathan.Cameron@huawei.com> wrote:
>>>> 
>>>> Introduced in an ECN to the PCI 5.0, DOE provides a config space
>>>> based mailbox with standard protocol discovery.  Each mailbox
>>>> is accessed through a DOE PCIE Extended Capability.
>>>> 
>>>> A device may have 1 or more DOE mailboxes, each of which is allowed
>>>> to support any number of protocols (some DOE protocols
>>>> specifications apply additional restrictions).  A given protocol
>>>> may be supported on more than one DOE mailbox on a given function.
>>> 
>>> Are all those protocol instances shared?
>>> I'm trying to mental model
>>> whether, for example, an auxiliary driver instance could be loaded per
>>> DOE mailbox, or if there would need to be coordination of a given
>>> protocol no matter how many DOE mailboxes on that device implemented
>>> that protocol.
>> 
>> Just to check I've understood corectly, you mean multiple instances of same
>> protocol across different DOE mailboxes on a given device?
>> 
> 
> Right.

Could you confirm this case for clarity?  A CXL device may have multiple VF/PF.
For example, PF=0 could have one or more DOE instances for CDAT protocol.  
The driver will scan PF=0 for all DOE instances and finding one or more of CDAT 
protocol will combine/manage them.  I had not considered multiple CDAT tables 
for single PF.  For CXL devices with multiple PF’s the same process would be 
carried out on PF=1-N.

> 
>> At DOE ECN level I don't think it is actually defined if they can
>> interact or not.  I've trawled though the released protocols that I know of
>> to see if there is a consensus but not finding much information.
>> 
>> I would argue however that there would be no reason to have the OS make
>> use of more than one DOE mailbox for the same protocol. Bit fiddly to
>> handle, but doesn't seem impossible to only register a protocol with first
>> DOE that supports it.
>> 
>> CMA does talk about use of multiple methods to communicate with the device
>> and the need for results consistency. However that is referring to out of
>> band vs DOE rather than multiple DOEs.  Plus it isn't making statements
>> about protocol coordination just responses to particular queries.
>> 
>> Things might get crazy if you tried to do IDE setup from two different DOE
>> mailboxes. The IDE ECN refers to "the specific instance of DOE used for..."
>> implying I think that there might be multiple but software should only
>> use one of them?
>> 
>> My other gut feeling is that only some of the DOE mailboxes are ever going
>> to be in the control of Linux. IDE calls out models where firmware or a TEE is
>> responsible for it for example. I'm not sure how that is going to be communicated
>> to the OS (can guess of course)
>> 
>> Sub drivers are a plausible model that I'll think about some more - but
>> for now it feels like too early to go that way..
> 
> Ok, fair enough.
> 
>> 
>>> 
>>>> 
>>>> The current infrastructure is fairly simplistic and pushes the burden
>>>> of handling this many-to-many relantionship to the drivers. In many
>>> 
>>> s/relantionship/relationship/
>>> 
>>>> cases the arrangement will be static, making this straight forward.
>>>> 
>>>> Open questions:
>>>> * timeouts: The DOE specification allows for 1 second for some
>>>>  operations, but notes that specific protocols may have different
>>>>  requirements. Should we introduce the flexiblity now, or leave
>>> 
>>> s/flexiblity/flexibility/
>> 
>> Gah. One day I'll remember to spell check. Sorry about that.
>> 
>>> 
>>>>  that to be implemented when support for such a protocol is added?
>>> 
>>> If the timeout is property of the protocol then perhaps it should wait
>>> and not be modeled at the transport level, but that's just an initial
>>> reaction. I have not spent quality time with the DOE spec.
>> 
>> I'm not sure it's possible to do so without breaking the abstraction of
>> DOE request / response into a bunch of messy sub steps.  Perhaps there is
>> a clean way of doing it but I can't immediately think of it.
>> 
>> If a protocol comes along that varies the timeout we can just add
>> a parameter to say what it is on a call by call basis.
> 
> Now that I've had a chance to take a look the spec seems to
> unequivocally mandate the timeouts in "6.xx.1 Operation", where was
> the per-protocol timeout implied?
> 
>>>> * DOE mailboxes may use MSI / MSIX to signal that the have prepared
>>>>  a response. These require normal conditions are setup by the driver.
>>>>  Should we move some of this into the DOE support (such as ensuring
>>>>  bus mastering is enabled)?
>>> 
>>> DOE support seems suitable to just be a library and leave the
>>> host-device management to the host driver.
>> 
>> Agreed.  Though might be worth some debug checks.
>> 
>> Speaking from experience it's easy to spend half a day wondering why your
>> interrupts aren't turning up (I was blaming QEMU) because bus mastering
>> wasn't enabled.
> 
> Sure, no concern about validating assumptions in the library, but
> leave control to the host.
> 
>>>> Testing conducted against QEMU using:
>>>> 
>>>> https://lore.kernel.org/qemu-devel/1612900760-7361-1-git-send-email-cbrowy@avery-design.com/
>>>> + fix for interrupt flag mentioned in that thread.
>>>> 
>>> 
>>> I came across this the other day and made me wonder about SPDM
>>> emulation as another test case:
>>> 
>>> https://cfp.osfc.io/media/osfc2020/submissions/ECQ88N/resources/An_open_source_SPDM_implementation_for_secure_devi_kmIgAQe.pdf
>> 
>> Nice!  Looking at CMA / IDE emulation was on my todo list and that looks like
>> it might make that job a lot easier.

Would it be useful to integrate the openspdm’s SpdmResponderEmu.c onto the QEMU’s CXL Type3 Device’s
DOE backend for CMA/IDE testing?  Doesn’t look hard to do.

>> 
>>> 
>>> 
>>>> Additional testing to be done, particularly around error handling.
>>>> 
>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> 
>> Anything not commented on should be in v2.
>> 
>>>> ---
>>>> drivers/pci/pcie/Kconfig      |   8 +
>>>> drivers/pci/pcie/Makefile     |   1 +
>>>> drivers/pci/pcie/doe.c        | 284 ++++++++++++++++++++++++++++++++++
>>>> include/linux/pcie-doe.h      |  35 +++++
>>>> include/uapi/linux/pci_regs.h |  29 +++-
>>>> 5 files changed, 356 insertions(+), 1 deletion(-)
>>> 
>>>> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
>>>> index b2980db88cc0..801fdd5fbfc1 100644
>>>> --- a/drivers/pci/pcie/Makefile
>>>> +++ b/drivers/pci/pcie/Makefile
>>>> @@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)                += pme.o
>>>> obj-$(CONFIG_PCIE_DPC)         += dpc.o
>>>> obj-$(CONFIG_PCIE_PTM)         += ptm.o
>>>> obj-$(CONFIG_PCIE_EDR)         += edr.o
>>>> +obj-$(CONFIG_PCIE_DOE)         += doe.o
>>>> diff --git a/drivers/pci/pcie/doe.c b/drivers/pci/pcie/doe.c
>>>> new file mode 100644
>>>> index 000000000000..b091ef379362
>>>> --- /dev/null
>>>> +++ b/drivers/pci/pcie/doe.c
>>>> @@ -0,0 +1,284 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Data Object Exchange was added to the PCI spec as an ECN to 5.0.
>>> 
>>> Perhaps just put the ECN link here?
>> 
>> It's by number so I've left the title here as well as a link.
> 
> Ok.
> 
>> 
>>> 
>>>> + *
>>>> + * Copyright (C) 2021 Huawei
>>>> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> + */
>>>> +
>>>> +#include <linux/bitfield.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/jiffies.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/pci.h>
>>>> +#include <linux/pcie-doe.h>
>>>> +
>>>> +static irqreturn_t doe_irq(int irq, void *data)
>>>> +{
>>>> +       struct pcie_doe *doe = data;
>>>> +       struct pci_dev *pdev = doe->pdev;
>>>> +       u32 val;
>>>> +
>>>> +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS, &val);
>>>> +       if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
>>>> +               pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS,
>>>> +                                      val);
>>>> +               complete(&doe->c);
>>>> +               return IRQ_HANDLED;
>>>> +       }
>>>> +       /* Leave the error case to be handled outside irq */
>>>> +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
>>>> +               complete(&doe->c);
>>>> +               return IRQ_HANDLED;
>>>> +       }
>>> 
>>> Only one DOE command can be outstanding at a time per PCI device?
>> 
>> No, unless I'm missing something, that is one command per DOE mailbox at a time.
>> The completion is part of the pcie_doe structure, not the pci_dev.
>> That represents a single DOE mailbox.
>> 
>> There can be multiple commands in flight to multiple DOE mailboxes. Not clear
>> that there ever will be in real use cases however.
>> 
>> This comes up later wrt to async operation.  The mailbox only
>> supports one request / response cycle at a time, they cannot be overlapped.
> 
> "6.xx.1 Operation" says "If a single DOE instance supports multiple
> data object protocols, system firmware/software is permitted to
> interleave requests/responses with different data object protocols."
> 
> ...although I must say I don't understand how system software tracks
> which response belongs to which request if the transactions are
> interleaved.
> 
>>> This
>>> seems insufficient in the multi-mailbox case / feels like there should
>>> be a 'struct pcie_doe_request' object to track what it is to be
>>> completed.
>> 
>> No need for the complexity with one request / response in flight per
>> mailbox at a time and each mailbox having separate state maintenance.
> 
> I think the workqueue proposal removes the need for pcie_doe_request,
> but still allows for the possibility of interleaving requests.
> 
>> 
>>> 
>>>> +
>>>> +       return IRQ_NONE;
>>>> +}
>>>> +
>>>> +static int pcie_doe_abort(struct pcie_doe *doe)
>>>> +{
>>>> +       struct pci_dev *pdev = doe->pdev;
>>>> +       int retry = 0;
>>>> +       u32 val;
>>>> +
>>>> +       pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_CTRL,
>>>> +                              PCI_DOE_CTRL_ABORT);
>>>> +       /* Abort is allowed to take up to 1 second */
>>>> +       do {
>>>> +               retry++;
>>>> +               pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS,
>>>> +                                     &val);
>>>> +               if (FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
>>>> +                   !FIELD_GET(PCI_DOE_STATUS_BUSY, val))
>>>> +                       return 0;
>>>> +               usleep_range(1000, 2000);
>>>> +       } while (retry < 1000);
>>>> +
>>>> +       return -EIO;
>>> 
>>> What's the state of the mailbox after an abort failure?
>> 
>> Good question.  I think the answer to that is dead device, reboot the machine
>> or at least the device if you can do a hard enough slot reset.
> 
> ...and hopefully that device is not part of an active interleave
> otherwise a reset can take down "System RAM".
> 
>> 
>> The specification goes with...
>> "It is strongly recommend that implementations ensure that the functionality
>> of the DOE Abort bit is resilient, including that DOE Abort functionality is
>> maintained even in cases where device firmware is malfunctioning"
> 
> Ok.
> 
>> 
>> So cross our fingers everyone obeys that strong recommendation or try to
>> work out what to do?
> 
> What's the worst that can happen? </famous last words>
> 
>> 
>>> 
>>>> +}
>>>> +
>>>> +/**
>>>> + * pcie_doe_init() - Initialise a Data Object Exchange mailbox
>>>> + * @doe: state structure for the DOE mailbox
>>>> + * @pdev: pci device which has this DOE mailbox
>>>> + * @doe_offset: offset in configuration space of the DOE extended capability.
>>>> + * @use_int: whether to use the optional interrupt
>>>> + * Returns: 0 on success, <0 on error
>>>> + *
>>>> + * Caller responsible for calling pci_alloc_irq_vectors() including DOE
>>>> + * interrupt.
>>>> + */
>>>> +int pcie_doe_init(struct pcie_doe *doe, struct pci_dev *pdev, int doe_offset,
>>>> +                 bool use_int)
>>>> +{
>>>> +       u32 val;
>>>> +       int rc;
>>>> +
>>>> +       mutex_init(&doe->lock);
>>>> +       init_completion(&doe->c);
>>>> +       doe->cap_offset = doe_offset;
>>>> +       doe->pdev = pdev;
>>>> +       /* Reset the mailbox by issuing an abort */
>>>> +       rc = pcie_doe_abort(doe);
>>>> +       if (rc)
>>>> +               return rc;
>>>> +
>>>> +       pci_read_config_dword(pdev, doe_offset + PCI_DOE_CAP, &val);
>>>> +
>>>> +       if (use_int && FIELD_GET(PCI_DOE_CAP_INT, val)) {
>>>> +               rc = devm_request_irq(&pdev->dev,
>>> 
>>> Lets not hide devm semantics from the caller, so at a minimum this
>>> function should be called pcim_pcie_doe_init() to indicate to the
>>> caller that it has placed something into the devm stack. However, this
>>> may not be convenient for the caller. I'd leave it to the user to call
>>> a pcie_doe() unregister routine via devm_add_action_or_reset() if it
>>> wants.
>> 
>>> 
>>> Lastly, I don't expect _init() routines to fail so perhaps split this
>>> into pure "init" and "register" functionality?
>> 
>> I'm a bit doubtful on naming of register() but will go with that for v2.
>> 
>> It's not registering with anything so that feels a bit wrong as a description
>> for part 2 of setup.  Can leave that bike shedding for now though.
>> 
> 
> Ok, just searching for a name that implies symmetrical teardown
> register/unregister, enable/disable, ... etc. init/deinit doesn't do
> it for me.
> 
>>> 
>>>> +                                     pci_irq_vector(pdev,
>>>> +                                                    FIELD_GET(PCI_DOE_CAP_IRQ, val)),
>>>> +                                     doe_irq, 0, "DOE", doe);
>>>> +               if (rc)
>>>> +                       return rc;
>>>> +
>>>> +               doe->use_int = use_int;
>>>> +               pci_write_config_dword(pdev, doe_offset + PCI_DOE_CTRL,
>>>> +                                      FIELD_PREP(PCI_DOE_CTRL_INT_EN, 1));
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +
>>>> +/**
>>>> + * pcie_doe_exchange() - Send a request and receive a response
>>>> + * @doe: DOE mailbox state structure
>>>> + * @request: request data to be sent
>>>> + * @request_sz: size of request in bytes
>>>> + * @response: buffer into which to place the response
>>>> + * @response_sz: size of available response buffer in bytes
>>>> + *
>>>> + * Return: 0 on success, < 0 on error
>>>> + * Excess data will be discarded.
>>>> + */
>>>> +int pcie_doe_exchange(struct pcie_doe *doe, u32 *request, size_t request_sz,
>>>> +                     u32 *response, size_t response_sz)
>>> 
>>> Are requests made against a specific protocol?
>> 
>> Yes, but the descriptive header is very brea.
>> 
>>> 
>>> This interface feels under-decorated for a public API for host-drivers to use.
>> 
>> I'll see what I can come up with for v2.
>> Likely to look something like
>> 
>> int pcie_doe_exchange(struct pci_doe *doe, u16 vid, u8 type,
>>                      u32 *request_pl, size_t request_pl_sz,
>>                      u32 *response_pl, size_t response_pl_sz)
> 
> I was thinking something like 'struct pcie_doe_object' pointers rather
> than u32 arrays.
> 
>> 
>> and return received length or negative on error.
>> 
>> The disadvantage is that at least some of the specs just have the
>> header as their first few DW.  So there isn't a clear distinction
>> between header and payload. May lead to people getting offsets wrong
>> in a way they wouldn't do if driver was responsible for building the
>> whole message.
> 
> Aren't they more likely to get offsets wrong with u32 arrays rather
> than data structures?
> 
>> 
>>> 
>>>> +{
>>>> +       struct pci_dev *pdev = doe->pdev;
>>>> +       int ret = 0;
>>>> +       int i;
>>>> +       u32 val;
>>>> +       int retry = -1;
>>>> +       size_t length;
>>>> +
>>>> +       /* DOE requests must be a whole number of DW */
>>>> +       if (request_sz % sizeof(u32))
>>>> +               return -EINVAL;
>>>> +
>>>> +       /* Need at least 2 DW to get the length */
>>>> +       if (response_sz < 2 * sizeof(u32))
>>>> +               return -EINVAL;
>>>> +
>>>> +       mutex_lock(&doe->lock);
>>>> +       /*
>>>> +        * Check the DOE busy bit is not set.
>>>> +        * If it is set, this could indicate someone other than Linux is
>>>> +        * using the mailbox.
>>>> +        */
>>> 
>>> Ugh, makes me think we need to extend the support for blocking pci
>>> device MMIO while a driver is attached to config-space as well. How
>>> can a communication protocol work if initiators can trample each
>>> other's state?
>> 
>> Agreed. It is crazy. At very least we need a means of saying
>> keep your hands off this DOE to the OS.
>> 
>> We can't do it on a per protocol basis, which was what I was previously
>> thinking, because we can't call the discovery protocol to see what
>> a given DOE is for.
> 
> I'm specifically thinking of a mechanism that blocks pci-sysfs from
> initiating config-cycles if a driver has claimed that range.
> 
> However, these MCTP to DOE tunnels that the SPDM presentation alluded
> to make me nervous as there is no protocol to prevent an OS driver
> agent and an MCTP agent from clobbering each other.
> 
>> 
>>> 
>>>> +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS, &val);
>>>> +       if (FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
>>>> +               ret = -EBUSY;
>>>> +               goto unlock;
>>>> +       }
>>>> +
>>>> +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
>>>> +               ret = pcie_doe_abort(doe);
>>>> +               if (ret)
>>>> +                       goto unlock;
>>>> +       }
>>>> +
>>>> +       for (i = 0; i < request_sz / 4; i++)
>>>> +               pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_WRITE,
>>>> +                                      request[i]);
>>>> +
>>>> +       reinit_completion(&doe->c);
>>>> +       pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_CTRL,
>>>> +                              PCI_DOE_CTRL_GO);
>>>> +
>>>> +       if (doe->use_int) {
>>>> +               /*
>>>> +                * Timeout of 1 second from 6.xx.1 ECN - Data Object Exchange
>>>> +                * Note a protocol is allowed to specify a different timeout, so
>>>> +                * that may need supporting in future.
>>>> +                */
>>>> +               if (!wait_for_completion_timeout(&doe->c,
>>>> +                                                msecs_to_jiffies(1000))) {
>>> 
>>> s/msecs_to_jiffies(1000)/HZ/
>> 
>> huh. Missed that :)
> 
> Yeah, the shorthand that X*HZ == "X seconds worth of jiffies" is just
> something I picked up from other drivers not explicit documentation.
> 
>> 
>>> 
>>>> +                       ret = -ETIMEDOUT;
>>>> +                       goto unlock;
>>>> +               }
>>>> +
>>>> +               pci_read_config_dword(pdev,
>>>> +                                     doe->cap_offset + PCI_DOE_STATUS,
>>>> +                                     &val);
>>>> +               if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
>>>> +                       pcie_doe_abort(doe);
>>>> +                       ret = -EIO;
>>>> +                       goto unlock;
>>>> +               }
>>>> +       } else {
>>>> +               do {
>>>> +                       retry++;
>>>> +                       pci_read_config_dword(pdev,
>>>> +                                             doe->cap_offset + PCI_DOE_STATUS,
>>>> +                                             &val);
>>>> +                       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
>>>> +                               pcie_doe_abort(doe);
>>>> +                               ret = -EIO;
>>>> +                               goto unlock;
>>>> +                       }
>>>> +
>>>> +                       if (FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val))
>>>> +                               break;
>>>> +                       usleep_range(1000, 2000);
>>>> +               } while (retry < 1000);
>>>> +               if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
>>>> +                       ret = -ETIMEDOUT;
>>>> +                       goto unlock;
>>> 
>>> Rather than a lock and polling loop I'd organize this as a single
>>> threaded delayed_workqueue that periodically services requests or
>>> immediately runs the workqueue upon receipt of an interrupt. This
>>> provides a software queuing model that can optionally be treated as
>>> async / sync depending on the use case.
>> 
>> Given it's single element in flight I don't think there is any benefit
>> to enabling async.  The lock has to be held throughout anyway.
>> It is always possible a particular caller wants to overlap this
>> transaction with some other actions, but I'd rather put the burden
>> on that clever caller which can spin this out to a thread of one type
>> or another.
>> 
>> We can revisit and split this in half if we have a user who benefits
>> from the complexity.
> 
> I don't think it's complex. I think it's simpler to rationalize than
> this pattern of taking a lock and going to sleep with the lock held.
> You can eliminate the lock completely if the only access to a given
> DOE is a single dedicated kthread. There are other examples of this
> single-thread protocol handler pattern in the kernel, like libsas SMP
> protocol.
> 
>>>> +               }
>>>> +       }
>>>> +
>>>> +       /* Read the first two dwords to get the length */
>>>> +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
>>>> +                             &response[0]);
>>>> +       pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
>>>> +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
>>>> +                             &response[1]);
>>>> +       pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
>>>> +       length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
>>>> +                          response[1]);
>>>> +       if (length > SZ_1M)
>> 
>> oops. That's exiting with mutex held. Fixed in v2.
>> 
>>>> +               return -EIO;
>>>> +
>>>> +       for (i = 2; i < min(length, response_sz / 4); i++) {
>>>> +               pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
>>>> +                                     &response[i]);
>>>> +               pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
>>>> +       }
>>>> +       /* flush excess length */
>>>> +       for (; i < length; i++) {
>>>> +               pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
>>>> +                                     &val);
>>>> +               pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
>>>> +       }
>>>> +       /* Final error check to pick up on any since Data Object Ready */
>>>> +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS, &val);
>>>> +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
>>>> +               pcie_doe_abort(doe);
>>>> +               ret = -EIO;
>>>> +       }
>>>> +unlock:
>>>> +       mutex_unlock(&doe->lock);
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +
>>>> +static int pcie_doe_discovery(struct pcie_doe *doe, u8 *index, u16 *vid, u8 *protocol)
>>>> +{
>>>> +       u32 request[3] = {
>>> 
>>> Should this be a proper struct with named fields rather than an array?
>> 
>> Well the field names are going to end up as dw0 dw1 etc as there isn't a lot more
>> meaningful to call them.  We also want to keep them as u32 values throughout to
>> avoid fiddly packing manipulation on different endian machines.
> 
> The DOE object format has dedicated space for type and length.
> 
> If anything the endian issue is more reason to have a proper data structure.
> 
>> 
>> This becomes rather simpler when it's just the payload due to changes in the
>> interface in v2.
>> 
>>> 
>>>> +               [0] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, 0001) |
>>>> +               FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, 0),
>>>> +               [1] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, 3),
>>>> +               [2] = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, *index)
>>>> +       };
>>>> +       u32 response[3];
>>>> +       int ret;
>>>> +
>>>> +       ret = pcie_doe_exchange(doe, request, sizeof(request), response, sizeof(response));
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       *vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response[2]);
>>>> +       *protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL, response[2]);
>>>> +       *index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX, response[2]);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * pcie_doe_protocol_check() - check if this DOE mailbox supports specific protocol
>>>> + * @doe: DOE state structure
>>>> + * @vid: Vendor ID
>>>> + * @protocol: Protocol number as defined by Vendor
>>>> + * Returns: 0 on success, <0 on error
>>>> + */
>>>> +int pcie_doe_protocol_check(struct pcie_doe *doe, u16 vid, u8 protocol)
>>> 
>>> Not clear to me that this is a comfortable API for a driver. I would
>>> expect that at registration time all the supported protocols would be
>>> retrieved and cached in the 'struct pcie_doe' context and then the
>>> host driver could query from there without going back to the device
>>> again.
>> 
>> I'm not sure I follow.
>> 
>> Any driver will fall into one of the following categories:
>> a) Already knows what protocols are available on a
>>   given DOE instance perhaps because that's a characteristic of the hardware
>>   supported, in which case it has no reason to check (unless driver writer
>>   is paranoid)
>> b) It has no way to know (e.g. class driver), then it makes sense to query
>>   the DOE instance to find out what protocols are available.
> 
> I was more thinking that the public interface is a protocol rather
> than the raw DOE. So the library knows CDAT, SPDM, IDE... and drivers
> never need to query the interface.
> 
> So this more of a question about where to draw the line of common code.
> 
> For example in the nfit driver there is usage of:
> 
> acpi_label_write()
> 
> ...and:
> 
> acpi_evaluate_dsm()
> 
> ...where the former abstracts the protocol and the latter is the raw
> interface. Both can write to a label area, but only one is idiomatic.

