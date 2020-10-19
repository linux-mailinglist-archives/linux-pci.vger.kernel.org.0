Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FD8293016
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 22:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbgJSUuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 16:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgJSUuX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 16:50:23 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CD5C0613CE
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 13:50:23 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so1523118ior.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XiqWYtYPhN+m+Vl5S/fIo6vlyn4EUwRyDDE6vZadkw=;
        b=BxeZXLPOwYocuZ6yS7ZrOtfFlpP4tfaQfebX2H5505yC62KU5F4q99x+nVq+N8ncjX
         2X+Zcn8pDnkZ1xeATsF3wWjyUQAh/lQbLI0ujWAoyEbYj5eWcfYz3IJ76a1mfexKC3ch
         lrWhwa9EDfmSXAFAQFPvPvrx25vWJYXbEkg2tWBcPU9G3izSdETvTbuZK8dFgarfRJ+m
         JCqCEy3SK903rlGHNQKguxoRv0dHJWUWqmVZcPSbN3bUDCdzMnjO401ZTnNS+U2ZgMsD
         kKNtqgzfDb7weNowc1q/nZTsc/OUBBVa8XB7EMZMd+zaNx36GQXjWoGVPto1IlbY7AQf
         FPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XiqWYtYPhN+m+Vl5S/fIo6vlyn4EUwRyDDE6vZadkw=;
        b=Ry2sD1PsOmWJD+5JMljh4Jw1PlfCdPjeCfZjHVgZVbuT11ZIYd/x6CBcl/lmCOp4bq
         1pM26zGv7FZxM8q4XSvXheoUnroorrfxikRy/QtincJ/Bnlc4wYsz5/kCOYLrRZVaV1f
         TByFHLRSuhRcEFqbUAI382XR7QKIbMRSML5U6pCA99EZtadw5OroXwFzEiFxjmvfnmtR
         yYp3wpU5NdhVDSx58qEcvTkGCKlUjo4OFGwWz34oY7ObUM8SO4Ch4O4O07Q2xKh9xNxM
         eb+iyh5bYpaDU4YZSosM/mMAHk48CXLLoCLpnBwOjgYAB2lBGfIYYg0IB7wI3UoB09IG
         zl8A==
X-Gm-Message-State: AOAM532S9XLomth1nc4gmWPAhj6K8Yee0X1IlVIQghlowK9lDpR9/Jha
        67v7FJlQzkwqT2w59iWABC50MA==
X-Google-Smtp-Source: ABdhPJwUzCxxcfNpAQcG5V9YyfVAL6yQUW5rxq9ZZvJUwrNBAGLUYb+CiLj8LzXiQNcLTmfbRlZVeA==
X-Received: by 2002:a6b:5c06:: with SMTP id z6mr1083229ioh.49.1603140622717;
        Mon, 19 Oct 2020 13:50:22 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id m13sm818709ioo.9.2020.10.19.13.50.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 13:50:22 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Ethan Zhao" <xerces.zhao@gmail.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        "Sean V Kelley" <seanvk.dev@oregontracks.org>,
        Jonathan.Cameron@huawei.com, "Bjorn Helgaas" <bhelgaas@google.com>,
        rafael.j.wysocki@intel.com, "Ashok Raj" <ashok.raj@intel.com>,
        tony.luck@intel.com, qiuxu.zhuo@intel.com,
        linux-pci <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>, "Sinan Kaya" <okaya@kernel.org>,
        "Keith Busch" <kbusch@kernel.org>
Subject: Re: [PATCH v9 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Mon, 19 Oct 2020 13:50:17 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <E5E378D7-B2F8-49E2-AC8C-01E70D58B64C@intel.com>
In-Reply-To: <240932c3-2cf4-5fbd-9cda-520bbd953fa6@linux.intel.com>
References: <20201016203037.GA90074@bjorn-Precision-5520>
 <20201016222902.GA112659@bjorn-Precision-5520>
 <CAKF3qh3NDvQAwb922faHgja+YoDydCtg5sugEQ8T2ti+3WSn5Q@mail.gmail.com>
 <4F54EEC0-3933-4A2E-87BC-23FABECB0C0A@intel.com>
 <240932c3-2cf4-5fbd-9cda-520bbd953fa6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19 Oct 2020, at 11:59, Kuppuswamy, Sathyanarayanan wrote:

> On 10/19/20 11:31 AM, Sean V Kelley wrote:
>> On 19 Oct 2020, at 3:49, Ethan Zhao wrote:
>>
>>> On Sat, Oct 17, 2020 at 6:29 AM Bjorn Helgaas <helgaas@kernel.org> =

>>> wrote:
>>>>
>>>> [+cc Christoph, Ethan, Sinan, Keith; sorry should have cc'd you to
>>>> begin with since you're looking at this code too. Particularly
>>>> interested in your thoughts about whether we should be touching
>>>> PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS when we don't own =

>>>> AER.]
>>>
>>> aer_root_reset() function has a prefix=C2=A0 'aer_', looks like it's =
a
>>> function of aer driver, will
>>> only be called by aer driver at runtime. if so it's up to the
>>> owner/aer to know if OSPM is
>>> granted to init. while actually some of the functions and runtime =

>>> service of
>>> aer driver is also shared by GHES driver (running time) and DPC =

>>> driver
>>> (compiling time ?)
>>> etc. then it is confused now.
>>>
>>> Shall we move some of the shared functions and running time service =

>>> to
>>> pci/err.c ?
>>> if so , just like pcie_do_recovery(), it's share by firmware_first=C2=
=A0 =

>>> mode GHES
>>> ghes_probe()
>>> ->ghes_irq_func
>>> =C2=A0 ->ghes_proc
>>> =C2=A0=C2=A0=C2=A0 ->ghes_do_proc()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->ghes_handle_aer()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->aer_recover_work_func()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->pcie_do_reco=
very()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->=
aer_root_reset()
>>>
>>> and aer driver etc.=C2=A0 if aer wants to do some access might confli=
ct
>>> with firmware(or
>>> firmware in embedded controller) should check _OSC_ etc first. =

>>> blindly issue
>>> PCI_ERR_ROOT_COMMAND=C2=A0 or clear PCI_ERR_ROOT_STATUS *likely*
>>> cause errors by error handling itself.
>>
>> If _OSC negotiation ends up with FW being in control of AER, that =

>> means OS is not in charge and should not be messing with AER I guess. =

>> That seems appropriate to me then.
> But APEI based notification is more like a hybrid approach (frimware =

> first detects the
> error and notifies OS). Since spec does not clarify what OS is allowed =

> to do, its bit of a
> gray area now. My point is, since firmware allows OS to process the =

> error by sending
> the notification, I think its OK to clear the status once the error is =

> handled.

I don=E2=80=99t disagree as long as AER is granted to the OS via _OSC. Bu=
t if =

it=E2=80=99s not granted explicitly via _OSC even in the APEI case where =

it=E2=80=99s either an SCI or NMI and not an MSI, I=E2=80=99m unsure whet=
her the OS =

should be touching those registers.

Sean

>>
>> Thanks,
>>
>> Sean
>>
>>
>>
>>>
>>> Thanks,
>>> Ethan
>>>
>>>>
>>>> On Fri, Oct 16, 2020 at 03:30:37PM -0500, Bjorn Helgaas wrote:
>>>>> [+to Jonathan]
>>>>>
>>>>> On Thu, Oct 15, 2020 at 05:11:10PM -0700, Sean V Kelley wrote:
>>>>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>>>>
>>>>>> When attempting error recovery for an RCiEP associated with an =

>>>>>> RCEC device,
>>>>>> there needs to be a way to update the Root Error Status, the =

>>>>>> Uncorrectable
>>>>>> Error Status and the Uncorrectable Error Severity of the parent =

>>>>>> RCEC.=C2=A0 In
>>>>>> some non-native cases in which there is no OS-visible device =

>>>>>> associated
>>>>>> with the RCiEP, there is nothing to act upon as the firmware is =

>>>>>> acting
>>>>>> before the OS.
>>>>>>
>>>>>> Add handling for the linked RCEC in AER/ERR while taking into =

>>>>>> account
>>>>>> non-native cases.
>>>>>>
>>>>>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>>>>>> Link: =

>>>>>> https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@ore=
gontracks.org
>>>>>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>>>>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>> ---
>>>>>> =C2=A0drivers/pci/pcie/aer.c | 53 =

>>>>>> ++++++++++++++++++++++++++++++------------
>>>>>> =C2=A0drivers/pci/pcie/err.c | 20 ++++++++--------
>>>>>> =C2=A02 files changed, 48 insertions(+), 25 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>>>> index 65dff5f3457a..083f69b67bfd 100644
>>>>>> --- a/drivers/pci/pcie/aer.c
>>>>>> +++ b/drivers/pci/pcie/aer.c
>>>>>> @@ -1357,27 +1357,50 @@ static int aer_probe(struct pcie_device =

>>>>>> *dev)
>>>>>> =C2=A0 */
>>>>>> =C2=A0static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>>>>> =C2=A0{
>>>>>> -=C2=A0=C2=A0 int aer =3D dev->aer_cap;
>>>>>> +=C2=A0=C2=A0 int type =3D pci_pcie_type(dev);
>>>>>> +=C2=A0=C2=A0 struct pci_dev *root;
>>>>>> +=C2=A0=C2=A0 int aer =3D 0;
>>>>>> +=C2=A0=C2=A0 int rc =3D 0;
>>>>>> =C2=A0=C2=A0=C2=A0 u32 reg32;
>>>>>> -=C2=A0=C2=A0 int rc;
>>>>>>
>>>>>> +=C2=A0=C2=A0 if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_END)
>>>>>
>>>>> "type =3D=3D PCI_EXP_TYPE_RC_END"
>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * The reset should only clear the Root =

>>>>>> Error Status
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * of the RCEC. Only perform this for the
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * native case, i.e., an RCEC is present.
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root=
 =3D dev->rcec;
>>>>>> +=C2=A0=C2=A0 else
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root=
 =3D dev;
>>>>>>
>>>>>> -=C2=A0=C2=A0 /* Disable Root's interrupt in response to error mes=
sages =

>>>>>> */
>>>>>> -=C2=A0=C2=A0 pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAN=
D, =

>>>>>> &reg32);
>>>>>> -=C2=A0=C2=A0 reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
>>>>>> -=C2=A0=C2=A0 pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMA=
ND, =

>>>>>> reg32);
>>>>>> +=C2=A0=C2=A0 if (root)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aer =
=3D dev->aer_cap;
>>>>>>
>>>>>> -=C2=A0=C2=A0 rc =3D pci_bus_error_reset(dev);
>>>>>> -=C2=A0=C2=A0 pci_info(dev, "Root Port link has been reset\n");
>>>>>> +=C2=A0=C2=A0 if (aer) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* D=
isable Root's interrupt in response to =

>>>>>> error messages */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_=
read_config_dword(root, aer + =

>>>>>> PCI_ERR_ROOT_COMMAND, &reg32);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg3=
2 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_=
write_config_dword(root, aer + =

>>>>>> PCI_ERR_ROOT_COMMAND, reg32);
>>>>>
>>>>> Not directly related to *this* patch, but my assumption was that =

>>>>> in
>>>>> the APEI case, the firmware should retain ownership of the AER
>>>>> Capability, so the OS should not touch PCI_ERR_ROOT_COMMAND and
>>>>> PCI_ERR_ROOT_STATUS.
>>>>>
>>>>> But this code appears to ignore that ownership.=C2=A0 Jonathan, you=
 =

>>>>> must
>>>>> have looked at this recently for 068c29a248b6 ("PCI/ERR: Clear =

>>>>> PCIe
>>>>> Device Status errors only if OS owns AER").=C2=A0 Do you have any =

>>>>> insight
>>>>> about this?
>>>>>
>>>>>> -=C2=A0=C2=A0 /* Clear Root Error Status */
>>>>>> -=C2=A0=C2=A0 pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS=
, =

>>>>>> &reg32);
>>>>>> -=C2=A0=C2=A0 pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATU=
S, =

>>>>>> reg32);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* C=
lear Root Error Status */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_=
read_config_dword(root, aer + =

>>>>>> PCI_ERR_ROOT_STATUS, &reg32);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_=
write_config_dword(root, aer + =

>>>>>> PCI_ERR_ROOT_STATUS, reg32);
>>>>>>
>>>>>> -=C2=A0=C2=A0 /* Enable Root Port's interrupt in response to error=
 =

>>>>>> messages */
>>>>>> -=C2=A0=C2=A0 pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAN=
D, =

>>>>>> &reg32);
>>>>>> -=C2=A0=C2=A0 reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
>>>>>> -=C2=A0=C2=A0 pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMA=
ND, =

>>>>>> reg32);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* E=
nable Root Port's interrupt in response =

>>>>>> to error messages */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_=
read_config_dword(root, aer + =

>>>>>> PCI_ERR_ROOT_COMMAND, &reg32);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg3=
2 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_=
write_config_dword(root, aer + =

>>>>>> PCI_ERR_ROOT_COMMAND, reg32);
>>>>>> +=C2=A0=C2=A0 }
>>>>>> +
>>>>>> +=C2=A0=C2=A0 if ((type =3D=3D PCI_EXP_TYPE_RC_EC) || (type =3D=3D=
 =

>>>>>> PCI_EXP_TYPE_RC_END)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
pcie_has_flr(root)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D pcie_flr(root);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_info(dev, "has been =

>>>>>> reset (%d)\n", rc);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> +=C2=A0=C2=A0 } else {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D=
 pci_bus_error_reset(root);
>>>>>
>>>>> Don't we want "dev" for both the FLR and pci_bus_error_reset()?=C2=A0=
 =

>>>>> I
>>>>> think "root =3D=3D dev" except when dev is an RCiEP.=C2=A0 When dev=
 is an
>>>>> RCiEP, "root" is the RCEC (if present), and we want to reset the
>>>>> RCiEP, not the RCEC.
>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_=
info(dev, "Root Port link has been =

>>>>>> reset (%d)\n", rc);
>>>>>> +=C2=A0=C2=A0 }
>>>>>
>>>>> There are a couple changes here that I think should be split out.
>>>>>
>>>>> Based on my theory that when firmware retains control of AER, the =

>>>>> OS
>>>>> should not touch PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS, and =

>>>>> any
>>>>> updates to them would have to be done by firmware before we get =

>>>>> here,
>>>>> I suggested reordering this:
>>>>>
>>>>> =C2=A0 - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>>>>> =C2=A0 - do reset
>>>>> =C2=A0 - clear PCI_ERR_ROOT_STATUS (for APEI, presumably done by =

>>>>> firmware?)
>>>>> =C2=A0 - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>>>>>
>>>>> to this:
>>>>>
>>>>> =C2=A0 - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>>>>> =C2=A0 - clear PCI_ERR_ROOT_STATUS
>>>>> =C2=A0 - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>>>>> =C2=A0 - do reset
>>>>>
>>>>> If my theory is correct, I think we should still reorder this, =

>>>>> but:
>>>>>
>>>>> =C2=A0 - It's a significant behavior change that deserves its own =

>>>>> patch so
>>>>> =C2=A0=C2=A0=C2=A0 we can document/bisect/revert.
>>>>>
>>>>> =C2=A0 - I'm not sure why we clear the PCI_ERR_ROOT_COMMAND error =

>>>>> reporting
>>>>> =C2=A0=C2=A0=C2=A0 bits.=C2=A0 In the new "clear COMMAND, clear STA=
TUS, enable =

>>>>> COMMAND"
>>>>> =C2=A0=C2=A0=C2=A0 order, it looks superfluous.=C2=A0 There's no re=
ason to disable =

>>>>> error
>>>>> =C2=A0=C2=A0=C2=A0 reporting while clearing the status bits.
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 The current "clear, reset, enable" order suggest=
s that the =

>>>>> reset
>>>>> =C2=A0=C2=A0=C2=A0 might cause errors that we should ignore.=C2=A0 =
I don't know =

>>>>> whether
>>>>> =C2=A0=C2=A0=C2=A0 that's the case or not.=C2=A0 It dates from 6c2b=
374d7485 =

>>>>> ("PCI-Express
>>>>> =C2=A0=C2=A0=C2=A0 AER implemetation: AER core and aerdriver"), whi=
ch doesn't
>>>>> =C2=A0=C2=A0=C2=A0 elaborate.
>>>>>
>>>>> =C2=A0 - Should we also test for OS ownership of AER before touchin=
g
>>>>> =C2=A0=C2=A0=C2=A0 PCI_ERR_ROOT_STATUS?
>>>>>
>>>>> =C2=A0 - If we remove the PCI_ERR_ROOT_COMMAND fiddling (and I =

>>>>> tentatively
>>>>> =C2=A0=C2=A0=C2=A0 think we *should* unless we can justify it), tha=
t would =

>>>>> also
>>>>> =C2=A0=C2=A0=C2=A0 deserve its own patch.=C2=A0 Possibly (1) remove=
 =

>>>>> PCI_ERR_ROOT_COMMAND
>>>>> =C2=A0=C2=A0=C2=A0 fiddling, (2) reorder PCI_ERR_ROOT_STATUS cleari=
ng and =

>>>>> reset, (3)
>>>>> =C2=A0=C2=A0=C2=A0 test for OS ownership of AER (?), (4) the rest o=
f this =

>>>>> patch.
>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0 return rc ? PCI_ERS_RESULT_DISCONNECT : =

>>>>>> PCI_ERS_RESULT_RECOVERED;
>>>>>> =C2=A0}
>>>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>>>> index 7883c9791562..cbc5abfe767b 100644
>>>>>> --- a/drivers/pci/pcie/err.c
>>>>>> +++ b/drivers/pci/pcie/err.c
>>>>>> @@ -148,10 +148,10 @@ static int report_resume(struct pci_dev =

>>>>>> *dev, void *data)
>>>>>>
>>>>>> =C2=A0/**
>>>>>> =C2=A0 * pci_walk_bridge - walk bridges potentially AER affected
>>>>>> - * @bridge:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bridge whic=
h may be a Port, an RCEC =

>>>>>> with associated RCiEPs,
>>>>>> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or an RCiEP as=
sociated with an RCEC
>>>>>> - * @cb:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 callback to be called for each =

>>>>>> device found
>>>>>> - * @userdata:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arbitrary pointer to =
be passed to =

>>>>>> callback
>>>>>> + * @bridge=C2=A0=C2=A0 bridge which may be an RCEC with associate=
d =

>>>>>> RCiEPs,
>>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or=
 a Port.
>>>>>> + * @cb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 callback to be called =
for each device found
>>>>>> + * @userdata arbitrary pointer to be passed to callback.
>>>>>> =C2=A0 *
>>>>>> =C2=A0 * If the device provided is a bridge, walk the subordinate =

>>>>>> bus, including
>>>>>> =C2=A0 * any bridged devices on buses under this bus.=C2=A0 Call t=
he =

>>>>>> provided callback
>>>>>> @@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev =

>>>>>> *bridge,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
int (*cb)(struct =

>>>>>> pci_dev *, void *),
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
void *userdata)
>>>>>> =C2=A0{
>>>>>> +=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0 * In a non-native case where there is no OS-vi=
sible =

>>>>>> reporting
>>>>>> +=C2=A0=C2=A0=C2=A0 * device the bridge will be NULL, i.e., no RCE=
C, no =

>>>>>> Downstream Port.
>>>>>> +=C2=A0=C2=A0=C2=A0 */
>>>>>> =C2=A0=C2=A0=C2=A0 if (bridge->subordinate)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pci_walk_bus(bridge->subordinate, cb, =

>>>>>> userdata);
>>>>>> +=C2=A0=C2=A0 else if (bridge->rcec)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cb(b=
ridge->rcec, userdata);
>>>>>> =C2=A0=C2=A0=C2=A0 else
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 cb(bridge, userdata);
>>>>>> =C2=A0}
>>>>>> @@ -194,12 +200,6 @@ pci_ers_result_t pcie_do_recovery(struct =

>>>>>> pci_dev *dev,
>>>>>> =C2=A0=C2=A0=C2=A0 pci_dbg(bridge, "broadcast error_detected messa=
ge\n");
>>>>>> =C2=A0=C2=A0=C2=A0 if (state =3D=3D pci_channel_io_frozen) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pci_walk_bridge(bridge, =

>>>>>> report_frozen_detected, &status);
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
type =3D=3D PCI_EXP_TYPE_RC_END) {
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_warn(dev, "subordinate =

>>>>>> device reset not possible for RCiEP\n");
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D =

>>>>>> PCI_ERS_RESULT_NONE;
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto failed;
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> -
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 status =3D reset_subordinates(bridge);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (status !=3D PCI_ERS_RESULT_RECOVERED) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_warn(bridge, =

>>>>>> "subordinate device reset failed\n");
>>>>>> -- =

>>>>>> 2.28.0
>>>>>>
> -- =

> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
