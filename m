Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2D33C706
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 20:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhCOTqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 15:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhCOTqA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 15:46:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D9EC06175F
        for <linux-pci@vger.kernel.org>; Mon, 15 Mar 2021 12:45:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ci14so68163935ejc.7
        for <linux-pci@vger.kernel.org>; Mon, 15 Mar 2021 12:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rewt4Y5CDvOZfbURc6I+uT85qtMzlB+of7cZ28W2RoI=;
        b=ZaTry7UO4x+w4RTpjteI6csoc0UQVXrzmPZlkQzqK66GWMgJJnyTnemCWRQcbnF6Ak
         vXrOEw+QrbShMnJfSsJqpWd4T92MxGfcdOcvSsq3Z4vnUYPPPoI6rG+uu3OgoRu59RPm
         IDxdBIly2IeIcJ66JLmOZF3Dvov7vPsht/M9WyCKV/287yqqaboST+HQcHhoDHth/22Z
         ZBUJd7yD9llJB+rIyTI9dAeDOwiPKbyga9jWArB4S7OB9Hfj/1znXCJuEMNkf8Tzp7HA
         QUdDbY/9baDvjKqkRqnZ9CT4ETvgJSavngqiFUIFXTciV3pNgyW8LXD1EvIqWOuuibax
         Qtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rewt4Y5CDvOZfbURc6I+uT85qtMzlB+of7cZ28W2RoI=;
        b=Taw4RtFM2nR+apTaI1YqmHwDYerAiTIdKy6pAZfkdfmrVoGaUSLAMRfWQjuGGvhhfJ
         sCbyKqDVkzOUzDYeNS84r47PuovJI1sKmLAGnkqhmrxGWgJaOhrqDGh7xhYrYHQSkNvw
         5/ZHNs24vR3b1rZ0hoOBFQunV7FAvnyCxwVXQN/7AfF53eRm8h8HP9EfdYR0apSteL+A
         K0Phe+rx+kCy2W7byp7eHTwrqnp520POD5NmZlEqpMZbzxocMpct2KXu41tI7ScyLBax
         p7XdzUyjTOsZFKIzvm+SExasSSFgUvK8ttJMisssoWwIxRArXu4I1SSkzuo5y9/gz+oc
         Uwew==
X-Gm-Message-State: AOAM533EIZjin1cVnd42hDD3NcXD4QheTpxrtLC8+dJQbS3hyuyt+cz5
        gY+EKIos9gLuMPlIVx+ObRPE0odutsf19gzY2hmyEw==
X-Google-Smtp-Source: ABdhPJyFFaa5c1z/wZR4l0TwP+ot6QwT7jkyIFpn87ObYvfS5qMgel2NauJ4mjQsGdHh2CMQ5dvw8p15kEyuOVl2vpo=
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr24635957ejb.264.1615837557645;
 Mon, 15 Mar 2021 12:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com> <20210310180306.1588376-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20210310180306.1588376-2-Jonathan.Cameron@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 15 Mar 2021 12:45:49 -0700
Message-ID: <CAPcyv4gG-==Vj9w3d7=gRRSPaoD5eZHZZ2hAA0h3c07eMT_x1A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] PCI/doe: Initial support PCI Data Object Exchange
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey Jonathan, happy to see this, some comments below...

On Wed, Mar 10, 2021 at 10:08 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Introduced in an ECN to the PCI 5.0, DOE provides a config space
> based mailbox with standard protocol discovery.  Each mailbox
> is accessed through a DOE PCIE Extended Capability.
>
> A device may have 1 or more DOE mailboxes, each of which is allowed
> to support any number of protocols (some DOE protocols
> specifications apply additional restrictions).  A given protocol
> may be supported on more than one DOE mailbox on a given function.

Are all those protocol instances shared? I'm trying to mental model
whether, for example, an auxiliary driver instance could be loaded per
DOE mailbox, or if there would need to be coordination of a given
protocol no matter how many DOE mailboxes on that device implemented
that protocol.

>
> The current infrastructure is fairly simplistic and pushes the burden
> of handling this many-to-many relantionship to the drivers. In many

s/relantionship/relationship/

> cases the arrangement will be static, making this straight forward.
>
> Open questions:
> * timeouts: The DOE specification allows for 1 second for some
>   operations, but notes that specific protocols may have different
>   requirements. Should we introduce the flexiblity now, or leave

s/flexiblity/flexibility/

>   that to be implemented when support for such a protocol is added?

If the timeout is property of the protocol then perhaps it should wait
and not be modeled at the transport level, but that's just an initial
reaction. I have not spent quality time with the DOE spec.

> * DOE mailboxes may use MSI / MSIX to signal that the have prepared
>   a response. These require normal conditions are setup by the driver.
>   Should we move some of this into the DOE support (such as ensuring
>   bus mastering is enabled)?

DOE support seems suitable to just be a library and leave the
host-device management to the host driver.

> Testing conducted against QEMU using:
>
> https://lore.kernel.org/qemu-devel/1612900760-7361-1-git-send-email-cbrowy@avery-design.com/
> + fix for interrupt flag mentioned in that thread.
>

I came across this the other day and made me wonder about SPDM
emulation as another test case:

https://cfp.osfc.io/media/osfc2020/submissions/ECQ88N/resources/An_open_source_SPDM_implementation_for_secure_devi_kmIgAQe.pdf


> Additional testing to be done, particularly around error handling.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/pcie/Kconfig      |   8 +
>  drivers/pci/pcie/Makefile     |   1 +
>  drivers/pci/pcie/doe.c        | 284 ++++++++++++++++++++++++++++++++++
>  include/linux/pcie-doe.h      |  35 +++++
>  include/uapi/linux/pci_regs.h |  29 +++-
>  5 files changed, 356 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 45a2ef702b45..f1cada7790fd 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -142,3 +142,11 @@ config PCIE_EDR
>           the PCI Firmware Specification r3.2.  Enable this if you want to
>           support hybrid DPC model which uses both firmware and OS to
>           implement DPC.
> +
> +config PCIE_DOE
> +       bool "PCI Express Data Object Exchange support"

Make this tristate. It's a library that a driver can use and there's
nothing in the implementation that I can see that requires this
support to be built-in.

> +       help
> +         This enables library support PCI Data Object Exchange capability.

I'm not sure this option deserves help text to make it selectable by
the user. It should only be something that a driver selects. I.e.
unlike the other port services (DPC, PME, AER, etc...), nothing
happens by default if the user turns this on.

> +         DOE provides a simple mailbox in PCI express config space that is
> +         used by a number of different protocols.
> +         It is defined in he Data Object Exchnage ECN to PCI 5.0.

If the help text stays, or gets turned into a comment:

s/he Data Object Exchnage/the Data Object Exchange (DOE)/

> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index b2980db88cc0..801fdd5fbfc1 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)                += pme.o
>  obj-$(CONFIG_PCIE_DPC)         += dpc.o
>  obj-$(CONFIG_PCIE_PTM)         += ptm.o
>  obj-$(CONFIG_PCIE_EDR)         += edr.o
> +obj-$(CONFIG_PCIE_DOE)         += doe.o
> diff --git a/drivers/pci/pcie/doe.c b/drivers/pci/pcie/doe.c
> new file mode 100644
> index 000000000000..b091ef379362
> --- /dev/null
> +++ b/drivers/pci/pcie/doe.c
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Data Object Exchange was added to the PCI spec as an ECN to 5.0.

Perhaps just put the ECN link here?

> + *
> + * Copyright (C) 2021 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/jiffies.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pcie-doe.h>
> +
> +static irqreturn_t doe_irq(int irq, void *data)
> +{
> +       struct pcie_doe *doe = data;
> +       struct pci_dev *pdev = doe->pdev;
> +       u32 val;
> +
> +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS, &val);
> +       if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> +               pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS,
> +                                      val);
> +               complete(&doe->c);
> +               return IRQ_HANDLED;
> +       }
> +       /* Leave the error case to be handled outside irq */
> +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> +               complete(&doe->c);
> +               return IRQ_HANDLED;
> +       }

Only one DOE command can be outstanding at a time per PCI device? This
seems insufficient in the multi-mailbox case / feels like there should
be a 'struct pcie_doe_request' object to track what it is to be
completed.

> +
> +       return IRQ_NONE;
> +}
> +
> +static int pcie_doe_abort(struct pcie_doe *doe)
> +{
> +       struct pci_dev *pdev = doe->pdev;
> +       int retry = 0;
> +       u32 val;
> +
> +       pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_CTRL,
> +                              PCI_DOE_CTRL_ABORT);
> +       /* Abort is allowed to take up to 1 second */
> +       do {
> +               retry++;
> +               pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS,
> +                                     &val);
> +               if (FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> +                   !FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> +                       return 0;
> +               usleep_range(1000, 2000);
> +       } while (retry < 1000);
> +
> +       return -EIO;

What's the state of the mailbox after an abort failure?

> +}
> +
> +/**
> + * pcie_doe_init() - Initialise a Data Object Exchange mailbox
> + * @doe: state structure for the DOE mailbox
> + * @pdev: pci device which has this DOE mailbox
> + * @doe_offset: offset in configuration space of the DOE extended capability.
> + * @use_int: whether to use the optional interrupt
> + * Returns: 0 on success, <0 on error
> + *
> + * Caller responsible for calling pci_alloc_irq_vectors() including DOE
> + * interrupt.
> + */
> +int pcie_doe_init(struct pcie_doe *doe, struct pci_dev *pdev, int doe_offset,
> +                 bool use_int)
> +{
> +       u32 val;
> +       int rc;
> +
> +       mutex_init(&doe->lock);
> +       init_completion(&doe->c);
> +       doe->cap_offset = doe_offset;
> +       doe->pdev = pdev;
> +       /* Reset the mailbox by issuing an abort */
> +       rc = pcie_doe_abort(doe);
> +       if (rc)
> +               return rc;
> +
> +       pci_read_config_dword(pdev, doe_offset + PCI_DOE_CAP, &val);
> +
> +       if (use_int && FIELD_GET(PCI_DOE_CAP_INT, val)) {
> +               rc = devm_request_irq(&pdev->dev,

Lets not hide devm semantics from the caller, so at a minimum this
function should be called pcim_pcie_doe_init() to indicate to the
caller that it has placed something into the devm stack. However, this
may not be convenient for the caller. I'd leave it to the user to call
a pcie_doe() unregister routine via devm_add_action_or_reset() if it
wants.

Lastly, I don't expect _init() routines to fail so perhaps split this
into pure "init" and "register" functionality?

> +                                     pci_irq_vector(pdev,
> +                                                    FIELD_GET(PCI_DOE_CAP_IRQ, val)),
> +                                     doe_irq, 0, "DOE", doe);
> +               if (rc)
> +                       return rc;
> +
> +               doe->use_int = use_int;
> +               pci_write_config_dword(pdev, doe_offset + PCI_DOE_CTRL,
> +                                      FIELD_PREP(PCI_DOE_CTRL_INT_EN, 1));
> +       }
> +
> +       return 0;
> +}
> +
> +
> +/**
> + * pcie_doe_exchange() - Send a request and receive a response
> + * @doe: DOE mailbox state structure
> + * @request: request data to be sent
> + * @request_sz: size of request in bytes
> + * @response: buffer into which to place the response
> + * @response_sz: size of available response buffer in bytes
> + *
> + * Return: 0 on success, < 0 on error
> + * Excess data will be discarded.
> + */
> +int pcie_doe_exchange(struct pcie_doe *doe, u32 *request, size_t request_sz,
> +                     u32 *response, size_t response_sz)

Are requests made against a specific protocol?

This interface feels under-decorated for a public API for host-drivers to use.

> +{
> +       struct pci_dev *pdev = doe->pdev;
> +       int ret = 0;
> +       int i;
> +       u32 val;
> +       int retry = -1;
> +       size_t length;
> +
> +       /* DOE requests must be a whole number of DW */
> +       if (request_sz % sizeof(u32))
> +               return -EINVAL;
> +
> +       /* Need at least 2 DW to get the length */
> +       if (response_sz < 2 * sizeof(u32))
> +               return -EINVAL;
> +
> +       mutex_lock(&doe->lock);
> +       /*
> +        * Check the DOE busy bit is not set.
> +        * If it is set, this could indicate someone other than Linux is
> +        * using the mailbox.
> +        */

Ugh, makes me think we need to extend the support for blocking pci
device MMIO while a driver is attached to config-space as well. How
can a communication protocol work if initiators can trample each
other's state?

> +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS, &val);
> +       if (FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> +               ret = -EBUSY;
> +               goto unlock;
> +       }
> +
> +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> +               ret = pcie_doe_abort(doe);
> +               if (ret)
> +                       goto unlock;
> +       }
> +
> +       for (i = 0; i < request_sz / 4; i++)
> +               pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_WRITE,
> +                                      request[i]);
> +
> +       reinit_completion(&doe->c);
> +       pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_CTRL,
> +                              PCI_DOE_CTRL_GO);
> +
> +       if (doe->use_int) {
> +               /*
> +                * Timeout of 1 second from 6.xx.1 ECN - Data Object Exchange
> +                * Note a protocol is allowed to specify a different timeout, so
> +                * that may need supporting in future.
> +                */
> +               if (!wait_for_completion_timeout(&doe->c,
> +                                                msecs_to_jiffies(1000))) {

s/msecs_to_jiffies(1000)/HZ/

> +                       ret = -ETIMEDOUT;
> +                       goto unlock;
> +               }
> +
> +               pci_read_config_dword(pdev,
> +                                     doe->cap_offset + PCI_DOE_STATUS,
> +                                     &val);
> +               if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> +                       pcie_doe_abort(doe);
> +                       ret = -EIO;
> +                       goto unlock;
> +               }
> +       } else {
> +               do {
> +                       retry++;
> +                       pci_read_config_dword(pdev,
> +                                             doe->cap_offset + PCI_DOE_STATUS,
> +                                             &val);
> +                       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> +                               pcie_doe_abort(doe);
> +                               ret = -EIO;
> +                               goto unlock;
> +                       }
> +
> +                       if (FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val))
> +                               break;
> +                       usleep_range(1000, 2000);
> +               } while (retry < 1000);
> +               if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> +                       ret = -ETIMEDOUT;
> +                       goto unlock;

Rather than a lock and polling loop I'd organize this as a single
threaded delayed_workqueue that periodically services requests or
immediately runs the workqueue upon receipt of an interrupt. This
provides a software queuing model that can optionally be treated as
async / sync depending on the use case.


> +               }
> +       }
> +
> +       /* Read the first two dwords to get the length */
> +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
> +                             &response[0]);
> +       pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
> +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
> +                             &response[1]);
> +       pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
> +       length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
> +                          response[1]);
> +       if (length > SZ_1M)
> +               return -EIO;
> +
> +       for (i = 2; i < min(length, response_sz / 4); i++) {
> +               pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
> +                                     &response[i]);
> +               pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
> +       }
> +       /* flush excess length */
> +       for (; i < length; i++) {
> +               pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
> +                                     &val);
> +               pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
> +       }
> +       /* Final error check to pick up on any since Data Object Ready */
> +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS, &val);
> +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> +               pcie_doe_abort(doe);
> +               ret = -EIO;
> +       }
> +unlock:
> +       mutex_unlock(&doe->lock);
> +
> +       return ret;
> +}
> +
> +
> +static int pcie_doe_discovery(struct pcie_doe *doe, u8 *index, u16 *vid, u8 *protocol)
> +{
> +       u32 request[3] = {

Should this be a proper struct with named fields rather than an array?

> +               [0] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, 0001) |
> +               FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, 0),
> +               [1] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, 3),
> +               [2] = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, *index)
> +       };
> +       u32 response[3];
> +       int ret;
> +
> +       ret = pcie_doe_exchange(doe, request, sizeof(request), response, sizeof(response));
> +       if (ret)
> +               return ret;
> +
> +       *vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response[2]);
> +       *protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL, response[2]);
> +       *index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX, response[2]);
> +
> +       return 0;
> +}
> +
> +/**
> + * pcie_doe_protocol_check() - check if this DOE mailbox supports specific protocol
> + * @doe: DOE state structure
> + * @vid: Vendor ID
> + * @protocol: Protocol number as defined by Vendor
> + * Returns: 0 on success, <0 on error
> + */
> +int pcie_doe_protocol_check(struct pcie_doe *doe, u16 vid, u8 protocol)

Not clear to me that this is a comfortable API for a driver. I would
expect that at registration time all the supported protocols would be
retrieved and cached in the 'struct pcie_doe' context and then the
host driver could query from there without going back to the device
again.

> +{
> +       u8 index = 0;
> +
> +       do {
> +               u8 this_protocol;
> +               u16 this_vid;
> +               int ret;
> +
> +               ret = pcie_doe_discovery(doe, &index, &this_vid, &this_protocol);
> +               if (ret)
> +                       return ret;
> +               if (this_vid == vid && this_protocol == protocol)
> +                       return 0;
> +       } while (index);
> +
> +       return -ENODEV;
> +}
> diff --git a/include/linux/pcie-doe.h b/include/linux/pcie-doe.h
> new file mode 100644
> index 000000000000..36eaa8532254
> --- /dev/null
> +++ b/include/linux/pcie-doe.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Data Object Exchange was added to the PCI spec as an ECN to 5.0.
> + *
> + * Copyright (C) 2021 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/mutex.h>
> +
> +#ifndef LINUX_PCIE_DOE_H
> +#define LINUX_PCIE_DOE_H
> +/**
> + * struct pcie_doe - State to support use of DOE mailbox
> + * @lock: Ensure users of the mailbox are serialized
> + * @cap_offset: Config space offset to base of DOE capability.
> + * @pdev: PCI device that hosts this DOE.
> + * @c: Completion used for interrupt handling.
> + * @use_int: Flage to indicate if interrupts rather than polling used.
> + */
> +struct pcie_doe {
> +       struct mutex lock;
> +       int cap_offset;

s/cap_offset/cap/

...to save some typing and be more idiomatic with other PCIE
capability based drivers.

> +       struct pci_dev *pdev;
> +       struct completion c;
> +       bool use_int;

Typically the polarity of this variable is flipped to whether polled
operation is enabled or not. I.e. s/use_int/poll/.

> +};
> +
> +int pcie_doe_init(struct pcie_doe *doe, struct pci_dev *dev, int doe_offset,
> +                 bool use_int);
> +int pcie_doe_exchange(struct pcie_doe *doe, u32 *request, size_t request_sz,
> +                     u32 *response, size_t response_sz);
> +int pcie_doe_protocol_check(struct pcie_doe *doe, u16 vid, u8 protocol);


> +#endif
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e709ae8235e7..4d8a5fee2cdf 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -730,7 +730,8 @@
>  #define PCI_EXT_CAP_ID_DVSEC   0x23    /* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF     0x25    /* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT 0x26    /* Physical Layer 16.0 GT/s */
> -#define PCI_EXT_CAP_ID_MAX     PCI_EXT_CAP_ID_PL_16GT
> +#define PCI_EXT_CAP_ID_DOE     0x2E    /* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_MAX     PCI_EXT_CAP_ID_DOE
>
>  #define PCI_EXT_CAP_DSN_SIZEOF 12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1092,4 +1093,30 @@
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK                0x000000F0
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT       4
>
> +/* Data Object Exchange */
> +#define PCI_DOE_CAP            0x04    /* DOE Capabilities Register */
> +#define  PCI_DOE_CAP_INT                       0x00000001  /* Interrupt Support */
> +#define  PCI_DOE_CAP_IRQ                       0x00000ffe  /* Interrupt Message Number */
> +#define PCI_DOE_CTRL           0x08    /* DOE Control Register */
> +#define  PCI_DOE_CTRL_ABORT                    0x00000001  /* DOE Abort */
> +#define  PCI_DOE_CTRL_INT_EN                   0x00000002  /* DOE Interrupt Enable */
> +#define  PCI_DOE_CTRL_GO                       0x80000000  /* DOE Go */
> +#define PCI_DOE_STATUS         0x0C    /* DOE Status Register */
> +#define  PCI_DOE_STATUS_BUSY                   0x00000001  /* DOE Busy */
> +#define  PCI_DOE_STATUS_INT_STATUS             0x00000002  /* DOE Interrupt Status */
> +#define  PCI_DOE_STATUS_ERROR                  0x00000004  /* DOE Error */
> +#define  PCI_DOE_STATUS_DATA_OBJECT_READY      0x80000000  /* Data Object Ready */
> +#define PCI_DOE_WRITE          0x10    /* DOE Write Data Mailbox Register */
> +#define PCI_DOE_READ           0x14    /* DOE Read Data Mailbox Register */
> +
> +/* DOE Data Object - note not actually registers */
> +#define PCI_DOE_DATA_OBJECT_HEADER_1_VID       0x0000FFFF
> +#define PCI_DOE_DATA_OBJECT_HEADER_1_TYPE      0x00FF0000
> +#define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH    0x0003FFFF
> +
> +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX   0x000000FF
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID     0x0000FFFF
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL        0x00FF0000
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX 0xFF000000
> +
>  #endif /* LINUX_PCI_REGS_H */
> --
> 2.19.1
>
