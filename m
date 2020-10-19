Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4FF292D95
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 20:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbgJSSbS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 14:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgJSSbS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 14:31:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675CCC0613CE
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 11:31:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id g16so234764pjv.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nN/y6WrCYAjhicfS1AOY7YPS8cKcq8Aw03kn4aPB58=;
        b=0NFCd1HPRyMs+EpHC33zKfqWmQ/rgzJB5lBxVDX7Er7MHKZOHk9gVhTxmR9HBCSZvc
         isstnw2lQlvuQpgCi9odOUvU+8Dy5LD+HzZIqmvSJcF7TIuDkjxUwD+XKFehk/5g57D6
         +bXzk7Ywp836IcrOe9MACEwMDwBnC+8jS5wff6jCff/Vu5ZUlwVi0hW5MDmcPjBxSeRJ
         4AVn8aIEbInIhCqo9E4tCkjTJvRap0Uhrd6LMPpIw/BfEDGZCChgXn4wqLk0MB/5SmlH
         nmU6WOCxx6hKblr1F8o79UGjPD8quW3Q9RL+8WtUqkX53yDV4dIK7oGexRuE6my83oqq
         mfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nN/y6WrCYAjhicfS1AOY7YPS8cKcq8Aw03kn4aPB58=;
        b=rMd95ndWQapD3k6HXCyqXPZCP9zQUr8hxZ1Q6hNfAh2LRmf7wmjjSho+XolpPcQX1i
         hRI3jo0Qlp8ozFtAs3bStljwhKUG5jMt65eu1JFvoj2dNGrdSmJAJpqtzXX1EXp/RK0H
         wNJwAhbpsS0WcxysEKe0XQyG/7LyQY69JUUxOg+0zNSs0f3GhvF/fsNKfTJVNcJEZDAf
         jDnEKYXEvH1gGPEBSl8MRcq5rlFG243fwBBCNK7ArpORQtTviqp3fP9Ya6sHr6W4Rkqf
         c/E4UGut3xn5dLJfuwUoP63CzBOWAVaWwf1Ohm0yx2tSjP6TtSxMO4af+IP5HNPK6vrV
         XD5Q==
X-Gm-Message-State: AOAM530EFNAidKwca/7Ln8BI1mwYvA9HpOiTCIA4N2bbb4rMwkZwzxMK
        /HnkRjdbOf9f7h1rjOOPRPfBqQ==
X-Google-Smtp-Source: ABdhPJxWt8wvexhpPrnYeCQzFEwDN0QQRGl+VTCpYfyQbHbt5R2YsRGxxmLycJvjlTsngwxMinpWwQ==
X-Received: by 2002:a17:902:eed4:b029:d5:ebe3:fc29 with SMTP id h20-20020a170902eed4b02900d5ebe3fc29mr1034105plb.20.1603132277783;
        Mon, 19 Oct 2020 11:31:17 -0700 (PDT)
Received: from [10.209.12.57] ([134.134.137.79])
        by smtp.gmail.com with ESMTPSA id n15sm316037pgt.75.2020.10.19.11.31.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 11:31:16 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Ethan Zhao" <xerces.zhao@gmail.com>
Cc:     "Bjorn Helgaas" <helgaas@kernel.org>,
        "Sean V Kelley" <seanvk.dev@oregontracks.org>,
        Jonathan.Cameron@huawei.com, "Bjorn Helgaas" <bhelgaas@google.com>,
        rafael.j.wysocki@intel.com, "Ashok Raj" <ashok.raj@intel.com>,
        tony.luck@intel.com,
        "Sathyanarayanan Kuppuswamy" <sathyanarayanan.kuppuswamy@intel.com>,
        qiuxu.zhuo@intel.com, linux-pci <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>, "Sinan Kaya" <okaya@kernel.org>,
        "Keith Busch" <kbusch@kernel.org>
Subject: Re: [PATCH v9 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Mon, 19 Oct 2020 11:31:14 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <4F54EEC0-3933-4A2E-87BC-23FABECB0C0A@intel.com>
In-Reply-To: <CAKF3qh3NDvQAwb922faHgja+YoDydCtg5sugEQ8T2ti+3WSn5Q@mail.gmail.com>
References: <20201016203037.GA90074@bjorn-Precision-5520>
 <20201016222902.GA112659@bjorn-Precision-5520>
 <CAKF3qh3NDvQAwb922faHgja+YoDydCtg5sugEQ8T2ti+3WSn5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19 Oct 2020, at 3:49, Ethan Zhao wrote:

> On Sat, Oct 17, 2020 at 6:29 AM Bjorn Helgaas <helgaas@kernel.org> =

> wrote:
>>
>> [+cc Christoph, Ethan, Sinan, Keith; sorry should have cc'd you to
>> begin with since you're looking at this code too.  Particularly
>> interested in your thoughts about whether we should be touching
>> PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS when we don't own AER.]
>
> aer_root_reset() function has a prefix  'aer_', looks like it's a
> function of aer driver, will
> only be called by aer driver at runtime. if so it's up to the
> owner/aer to know if OSPM is
> granted to init. while actually some of the functions and runtime =

> service of
> aer driver is also shared by GHES driver (running time) and DPC driver
> (compiling time ?)
> etc. then it is confused now.
>
> Shall we move some of the shared functions and running time service to
> pci/err.c ?
> if so , just like pcie_do_recovery(), it's share by firmware_first  =

> mode GHES
> ghes_probe()
> ->ghes_irq_func
>   ->ghes_proc
>     ->ghes_do_proc()
>       ->ghes_handle_aer()
>         ->aer_recover_work_func()
>           ->pcie_do_recovery()
>             ->aer_root_reset()
>
> and aer driver etc.  if aer wants to do some access might conflict
> with firmware(or
> firmware in embedded controller) should check _OSC_ etc first.  =

> blindly issue
> PCI_ERR_ROOT_COMMAND  or clear PCI_ERR_ROOT_STATUS *likely*
> cause errors by error handling itself.

If _OSC negotiation ends up with FW being in control of AER, that means =

OS is not in charge and should not be messing with AER I guess. That =

seems appropriate to me then.

Thanks,

Sean



>
> Thanks,
> Ethan
>
>>
>> On Fri, Oct 16, 2020 at 03:30:37PM -0500, Bjorn Helgaas wrote:
>>> [+to Jonathan]
>>>
>>> On Thu, Oct 15, 2020 at 05:11:10PM -0700, Sean V Kelley wrote:
>>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>>
>>>> When attempting error recovery for an RCiEP associated with an RCEC =

>>>> device,
>>>> there needs to be a way to update the Root Error Status, the =

>>>> Uncorrectable
>>>> Error Status and the Uncorrectable Error Severity of the parent =

>>>> RCEC.  In
>>>> some non-native cases in which there is no OS-visible device =

>>>> associated
>>>> with the RCiEP, there is nothing to act upon as the firmware is =

>>>> acting
>>>> before the OS.
>>>>
>>>> Add handling for the linked RCEC in AER/ERR while taking into =

>>>> account
>>>> non-native cases.
>>>>
>>>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>>>> Link: =

>>>> https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@orego=
ntracks.org
>>>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>  drivers/pci/pcie/aer.c | 53 =

>>>> ++++++++++++++++++++++++++++++------------
>>>>  drivers/pci/pcie/err.c | 20 ++++++++--------
>>>>  2 files changed, 48 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index 65dff5f3457a..083f69b67bfd 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -1357,27 +1357,50 @@ static int aer_probe(struct pcie_device =

>>>> *dev)
>>>>   */
>>>>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>>>  {
>>>> -   int aer =3D dev->aer_cap;
>>>> +   int type =3D pci_pcie_type(dev);
>>>> +   struct pci_dev *root;
>>>> +   int aer =3D 0;
>>>> +   int rc =3D 0;
>>>>     u32 reg32;
>>>> -   int rc;
>>>>
>>>> +   if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_END)
>>>
>>> "type =3D=3D PCI_EXP_TYPE_RC_END"
>>>
>>>> +           /*
>>>> +            * The reset should only clear the Root Error Status
>>>> +            * of the RCEC. Only perform this for the
>>>> +            * native case, i.e., an RCEC is present.
>>>> +            */
>>>> +           root =3D dev->rcec;
>>>> +   else
>>>> +           root =3D dev;
>>>>
>>>> -   /* Disable Root's interrupt in response to error messages */
>>>> -   pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>>>> -   reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
>>>> -   pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>>>> +   if (root)
>>>> +           aer =3D dev->aer_cap;
>>>>
>>>> -   rc =3D pci_bus_error_reset(dev);
>>>> -   pci_info(dev, "Root Port link has been reset\n");
>>>> +   if (aer) {
>>>> +           /* Disable Root's interrupt in response to error =

>>>> messages */
>>>> +           pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, =

>>>> &reg32);
>>>> +           reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
>>>> +           pci_write_config_dword(root, aer + =

>>>> PCI_ERR_ROOT_COMMAND, reg32);
>>>
>>> Not directly related to *this* patch, but my assumption was that in
>>> the APEI case, the firmware should retain ownership of the AER
>>> Capability, so the OS should not touch PCI_ERR_ROOT_COMMAND and
>>> PCI_ERR_ROOT_STATUS.
>>>
>>> But this code appears to ignore that ownership.  Jonathan, you must
>>> have looked at this recently for 068c29a248b6 ("PCI/ERR: Clear PCIe
>>> Device Status errors only if OS owns AER").  Do you have any insight
>>> about this?
>>>
>>>> -   /* Clear Root Error Status */
>>>> -   pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
>>>> -   pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
>>>> +           /* Clear Root Error Status */
>>>> +           pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, =

>>>> &reg32);
>>>> +           pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, =

>>>> reg32);
>>>>
>>>> -   /* Enable Root Port's interrupt in response to error messages =

>>>> */
>>>> -   pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>>>> -   reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
>>>> -   pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>>>> +           /* Enable Root Port's interrupt in response to error =

>>>> messages */
>>>> +           pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, =

>>>> &reg32);
>>>> +           reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
>>>> +           pci_write_config_dword(root, aer + =

>>>> PCI_ERR_ROOT_COMMAND, reg32);
>>>> +   }
>>>> +
>>>> +   if ((type =3D=3D PCI_EXP_TYPE_RC_EC) || (type =3D=3D =

>>>> PCI_EXP_TYPE_RC_END)) {
>>>> +           if (pcie_has_flr(root)) {
>>>> +                   rc =3D pcie_flr(root);
>>>> +                   pci_info(dev, "has been reset (%d)\n", rc);
>>>> +           }
>>>> +   } else {
>>>> +           rc =3D pci_bus_error_reset(root);
>>>
>>> Don't we want "dev" for both the FLR and pci_bus_error_reset()?  I
>>> think "root =3D=3D dev" except when dev is an RCiEP.  When dev is an
>>> RCiEP, "root" is the RCEC (if present), and we want to reset the
>>> RCiEP, not the RCEC.
>>>
>>>> +           pci_info(dev, "Root Port link has been reset (%d)\n", =

>>>> rc);
>>>> +   }
>>>
>>> There are a couple changes here that I think should be split out.
>>>
>>> Based on my theory that when firmware retains control of AER, the OS
>>> should not touch PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS, and =

>>> any
>>> updates to them would have to be done by firmware before we get =

>>> here,
>>> I suggested reordering this:
>>>
>>>   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>>>   - do reset
>>>   - clear PCI_ERR_ROOT_STATUS (for APEI, presumably done by =

>>> firmware?)
>>>   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>>>
>>> to this:
>>>
>>>   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>>>   - clear PCI_ERR_ROOT_STATUS
>>>   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>>>   - do reset
>>>
>>> If my theory is correct, I think we should still reorder this, but:
>>>
>>>   - It's a significant behavior change that deserves its own patch =

>>> so
>>>     we can document/bisect/revert.
>>>
>>>   - I'm not sure why we clear the PCI_ERR_ROOT_COMMAND error =

>>> reporting
>>>     bits.  In the new "clear COMMAND, clear STATUS, enable COMMAND"
>>>     order, it looks superfluous.  There's no reason to disable error
>>>     reporting while clearing the status bits.
>>>
>>>     The current "clear, reset, enable" order suggests that the reset
>>>     might cause errors that we should ignore.  I don't know whether
>>>     that's the case or not.  It dates from 6c2b374d7485 =

>>> ("PCI-Express
>>>     AER implemetation: AER core and aerdriver"), which doesn't
>>>     elaborate.
>>>
>>>   - Should we also test for OS ownership of AER before touching
>>>     PCI_ERR_ROOT_STATUS?
>>>
>>>   - If we remove the PCI_ERR_ROOT_COMMAND fiddling (and I =

>>> tentatively
>>>     think we *should* unless we can justify it), that would also
>>>     deserve its own patch.  Possibly (1) remove PCI_ERR_ROOT_COMMAND
>>>     fiddling, (2) reorder PCI_ERR_ROOT_STATUS clearing and reset, =

>>> (3)
>>>     test for OS ownership of AER (?), (4) the rest of this patch.
>>>
>>>>     return rc ? PCI_ERS_RESULT_DISCONNECT : =

>>>> PCI_ERS_RESULT_RECOVERED;
>>>>  }
>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>> index 7883c9791562..cbc5abfe767b 100644
>>>> --- a/drivers/pci/pcie/err.c
>>>> +++ b/drivers/pci/pcie/err.c
>>>> @@ -148,10 +148,10 @@ static int report_resume(struct pci_dev *dev, =

>>>> void *data)
>>>>
>>>>  /**
>>>>   * pci_walk_bridge - walk bridges potentially AER affected
>>>> - * @bridge:        bridge which may be a Port, an RCEC with =

>>>> associated RCiEPs,
>>>> - *         or an RCiEP associated with an RCEC
>>>> - * @cb:            callback to be called for each device found
>>>> - * @userdata:      arbitrary pointer to be passed to callback
>>>> + * @bridge   bridge which may be an RCEC with associated RCiEPs,
>>>> + *           or a Port.
>>>> + * @cb       callback to be called for each device found
>>>> + * @userdata arbitrary pointer to be passed to callback.
>>>>   *
>>>>   * If the device provided is a bridge, walk the subordinate bus, =

>>>> including
>>>>   * any bridged devices on buses under this bus.  Call the provided =

>>>> callback
>>>> @@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev =

>>>> *bridge,
>>>>                         int (*cb)(struct pci_dev *, void *),
>>>>                         void *userdata)
>>>>  {
>>>> +   /*
>>>> +    * In a non-native case where there is no OS-visible reporting
>>>> +    * device the bridge will be NULL, i.e., no RCEC, no Downstream =

>>>> Port.
>>>> +    */
>>>>     if (bridge->subordinate)
>>>>             pci_walk_bus(bridge->subordinate, cb, userdata);
>>>> +   else if (bridge->rcec)
>>>> +           cb(bridge->rcec, userdata);
>>>>     else
>>>>             cb(bridge, userdata);
>>>>  }
>>>> @@ -194,12 +200,6 @@ pci_ers_result_t pcie_do_recovery(struct =

>>>> pci_dev *dev,
>>>>     pci_dbg(bridge, "broadcast error_detected message\n");
>>>>     if (state =3D=3D pci_channel_io_frozen) {
>>>>             pci_walk_bridge(bridge, report_frozen_detected, =

>>>> &status);
>>>> -           if (type =3D=3D PCI_EXP_TYPE_RC_END) {
>>>> -                   pci_warn(dev, "subordinate device reset not =

>>>> possible for RCiEP\n");
>>>> -                   status =3D PCI_ERS_RESULT_NONE;
>>>> -                   goto failed;
>>>> -           }
>>>> -
>>>>             status =3D reset_subordinates(bridge);
>>>>             if (status !=3D PCI_ERS_RESULT_RECOVERED) {
>>>>                     pci_warn(bridge, "subordinate device reset =

>>>> failed\n");
>>>> --
>>>> 2.28.0
>>>>
