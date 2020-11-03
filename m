Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2D2A5A6B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 00:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgKCXIw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 18:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgKCXIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 18:08:52 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1318C0613D1
        for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2020 15:08:51 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 13so15665792pfy.4
        for <linux-pci@vger.kernel.org>; Tue, 03 Nov 2020 15:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2BtKqohaVimYm3JYZpiBY5vH1S7B671OHmw6gVL2WBU=;
        b=dfV9c69glUI8cTJE5KxhYnSkdH5RZaIREIstIxf0GaULID2vdqdUTZZEZUs4GMwbvJ
         HXIUEDV03PzkuKmgMQy4uR1m75touThJ0HeVe1P9Fouo1bzjD9KC5pM4zi1WHlSpxxK9
         D2ZLizjPUc182Kujje1Sp45hRvbmkJiJ752Yn6NG2LNzcGtXlsu6ABpzq/dkjqqkUWWn
         j0HmkeSdevzlxMoBAfQg2736qD1PwyzaSwY+S9XDwtk++dPAIkWrjMPesG/SwUqAUHRa
         uqkehrJYPr6+WTaNTXLWQerzGE1Z5ZCf7nL2K2UB+CH4hV20i403oeLSBxWbblach8bG
         XjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2BtKqohaVimYm3JYZpiBY5vH1S7B671OHmw6gVL2WBU=;
        b=LSJW6fTxkkVCftFWahFnrG4BeI1sp4tISz+kegsI+B4hLkacjsW0nMtCrwOrFQSrcD
         2XC32zI8RcG/TzEWt7sxdc+nmVST19HMlr51bpy+cJeqhBSXNbqsd9+PZ67pp7f7qavI
         d9OKBU5EZ/4REW6IfqJMZQrmkN4y0MkNL9zKLU1uwwuwxJ/hirtIsaf0OmJ2Ikdm/5R/
         5mQHrDRNWucqdLE6VBnKUHlvLnl4S+3Ggvvz0D3swt1kO7+yk4t8Aqago8rzyOU+EBuA
         4/w9MaMIChlLa6HGB3hCrUhsGo3Dva3gwRKEJZKCnJ+6ekL3SYWJe/XuCFgRulb/hb44
         nnOw==
X-Gm-Message-State: AOAM531srB2rMUr2DcPHG71FN4r+PhcHvC9lNcvQRdXS5oakonKOwf/b
        TUvqvc5x4e1Jmiz1werVjrZC1g==
X-Google-Smtp-Source: ABdhPJyOmMhlPf5JarM005LlcvS/Pi3ut+ak3P1EI4ecLXYV2A32NQVD9deQjE+geYrb9x5bYccaTg==
X-Received: by 2002:aa7:8154:0:b029:156:4b89:8072 with SMTP id d20-20020aa781540000b02901564b898072mr28620817pfn.51.1604444931322;
        Tue, 03 Nov 2020 15:08:51 -0800 (PST)
Received: from [10.212.88.145] ([134.134.137.79])
        by smtp.gmail.com with ESMTPSA id 9sm173597pfp.102.2020.11.03.15.08.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 15:08:50 -0800 (PST)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Ethan Zhao" <xerces.zhao@gmail.com>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, "Ashok Raj" <ashok.raj@intel.com>,
        tony.luck@intel.com,
        "Sathyanarayanan Kuppuswamy" <sathyanarayanan.kuppuswamy@intel.com>,
        qiuxu.zhuo@intel.com, linux-pci <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AER: aer_root_reset() non-native handling
Date:   Tue, 03 Nov 2020 15:08:48 -0800
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <F304B3D0-05A6-4611-8972-51544CB96E3E@intel.com>
In-Reply-To: <CAKF3qh3H6daTZtWLj=RjEFoaWazVCvQ=svGO2wGm84K7cnwv_g@mail.gmail.com>
References: <20201030223443.165783-1-sean.v.kelley@intel.com>
 <CAKF3qh3H6daTZtWLj=RjEFoaWazVCvQ=svGO2wGm84K7cnwv_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1 Nov 2020, at 22:27, Ethan Zhao wrote:

> On Sat, Oct 31, 2020 at 6:36 AM Sean V Kelley =

> <sean.v.kelley@intel.com> wrote:
>>
>> If an OS has not been granted AER control via _OSC, then
>> the OS should not make changes to PCI_ERR_ROOT_COMMAND and
>> PCI_ERR_ROOT_STATUS related registers. Per section 4.5.1 of
>> the System Firmware Intermediary (SFI) _OSC and DPC Updates
>> ECN [1], this bit also covers these aspects of the PCI
>> Express Advanced Error Reporting. Further, the handling of
>> clear/enable of PCI_ERROR_ROOT_COMMAND when wrapped around
>> PCI_ERR_ROOT_STATUS should have no effect and be removed.
>> Based on the above and earlier discussion [2], make the
>> following changes:
>>
>> Add a check for the native case (i.e., AER control via _OSC)
>> Re-order and remove some of the handling:
>> - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>> - do reset
>> - clear PCI_ERR_ROOT_STATUS
>> - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>>
>> to this:
>>
>> - clear PCI_ERR_ROOT_STATUS
>> - do reset
>>
>> The current "clear, reset, enable" order suggests that the reset
>> might cause errors that we should ignore. But I am unable to find a
>> reference and the clearing of PCI_ERR_ROOT_STATUS does not require =

>> them.
>>
>> [1] System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb =

>> 24,
>>     2020, affecting PCI Firmware Specification, Rev. 3.2
>>     https://members.pcisig.com/wg/PCI-SIG/document/14076
>> [2] =

>> https://lore.kernel.org/linux-pci/20201020162820.GA370938@bjorn-Precis=
ion-5520/
>>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> ---
>>  drivers/pci/pcie/aer.c | 21 ++++++---------------
>>  1 file changed, 6 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 65dff5f3457a..bbfb07842d89 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1361,23 +1361,14 @@ static pci_ers_result_t aer_root_reset(struct =

>> pci_dev *dev)
>>         u32 reg32;
>>         int rc;
>>
>> -
>> -       /* Disable Root's interrupt in response to error messages */
>> -       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, =

>> &reg32);
>> -       reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
>> -       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, =

>> reg32);
> There may be some reasons to disable interrupt first and then do =

> resetting,
> clear status and re-enable interrupt.
> Perhaps to avoid error noise,  what would happen if the resetting
> causes errors itself ?

I don=E2=80=99t have the historical context, but in looking at pci_bus_re=
set() =

it=E2=80=99s clear that it will probe slots for reset capability and then=
 fall =

back to secondary bus reset.  It=E2=80=99s possible that an attempt to re=
set a =

slot could result in an error on some hardware.  This would potentially =

result in repeated error reporting. Not having the historical context, =

it=E2=80=99s best to leave in the clear/re-enabling of the interrupt when=
 =

performing the reset.

Sean


>
> Thanks,
> Ethan
>
>> +       if (pcie_aer_is_native(dev)) {
>> +               /* Clear Root Error Status */
>> +               pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, =

>> &reg32);
>> +               pci_write_config_dword(dev, aer + =

>> PCI_ERR_ROOT_STATUS, reg32);
>> +       }
>>
>>         rc =3D pci_bus_error_reset(dev);
>> -       pci_info(dev, "Root Port link has been reset\n");
>> -
>> -       /* Clear Root Error Status */
>> -       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, =

>> &reg32);
>> -       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, =

>> reg32);
>> -
>> -       /* Enable Root Port's interrupt in response to error messages =

>> */
>> -       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, =

>> &reg32);
>> -       reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
>> -       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, =

>> reg32);
>> +       pci_info(dev, "Root Port link has been reset (%d)\n", rc);
>>
>>         return rc ? PCI_ERS_RESULT_DISCONNECT : =

>> PCI_ERS_RESULT_RECOVERED;
>>  }
>> --
>> 2.29.2
>>
