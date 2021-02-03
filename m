Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCCC30D4A1
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 09:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhBCIE4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 03:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhBCIEt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 03:04:49 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842CBC061573
        for <linux-pci@vger.kernel.org>; Wed,  3 Feb 2021 00:04:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f16so4544114wmq.5
        for <linux-pci@vger.kernel.org>; Wed, 03 Feb 2021 00:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LrXyx5RUpsxhDP5/kRLw5d7Zt4ABHkqMSv12ZbxrYyA=;
        b=alwI0ZXBMhQx09vkjv1wQbCGQFI+deVb0tmejZ6i34YdtiHK8znIvHtMo6+jtQXm2f
         1Vgq+fHHMLeu4WXodnp4nSKa1R77emEZxVzfH9Utni92sLrN0sVlUL5wlabCwC60fq1T
         UwM2acAGg6zzg5u7PUe/ci7Bmi9q/rd/2U+bqDfEzj1dEImmk7kl8PESCKugGhbTYt23
         6FRKwNQ0ZS4DqsuaC+NhyhJnDUb/+dJw8DIhHBKsq9DrqW6cMirl2OGNivXiQ3dB5RFN
         /AJOI9FaTKFvapNpBlE3TUIt6RG5/IWM+x1MAoVZXtzi0H2mO1G8y8GvTP2xYeYa4RFG
         Kvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LrXyx5RUpsxhDP5/kRLw5d7Zt4ABHkqMSv12ZbxrYyA=;
        b=QahM5sOJ8jE/4tqhNaBbI7GjqAwUtusjtFmz2qNktSX4yGyyjZTxf3MlvPcVeW2oEj
         EMt5rVdvmX4BSO1tS5gK65361xPimPk2do84uYezXUgzM+OilU6CZB3+sjcMi20lLhbV
         2IfIPYClsHW/yKTX04MPGsboZ+9tLsouZ1wIk2VmI/MqDvB8rV3CMulhuwQ/NoWsC598
         9e92X49fAiq/vdM8Ji43DbE74nPrz7FXA9ztIV+4GZXbLOA4uAlEebaXxIHKUbEdYJS3
         osIoi44FSIQAaO+PyLBzoy0qLKWy2J9KCcbe8TB3eJzQKS0qAxfHfVJWy9jGB7jKqS/r
         lDsw==
X-Gm-Message-State: AOAM533xt3RU9U2BOzMGh5yCgnhLMjrw/W+ttY1TWSGxdr5ci6y5Dp5x
        uq2TbbhlRMFmuQcgtgAt1J5eJbNn648=
X-Google-Smtp-Source: ABdhPJwBsiiwv0O3NA8LubjLBnFeaQP0SiIegHu1S+Zx+WfTNr6RNel4Gsx6/az6SsPgmGzuiXg39Q==
X-Received: by 2002:a7b:c4d4:: with SMTP id g20mr1625089wmk.144.1612339447842;
        Wed, 03 Feb 2021 00:04:07 -0800 (PST)
Received: from ?IPv6:2003:ea:8f1f:ad00:f08f:200e:76bc:9fee? (p200300ea8f1fad00f08f200e76bc9fee.dip0.t-ipconnect.de. [2003:ea:8f1f:ad00:f08f:200e:76bc:9fee])
        by smtp.googlemail.com with ESMTPSA id w2sm1707033wmg.27.2021.02.03.00.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:04:06 -0800 (PST)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210202231210.GA148198@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2] PCI/VPD: Remove not any longer needed Broadcom NIC
 quirk
Message-ID: <3f5b1d49-1f7f-e32b-7060-8d11afedd964@gmail.com>
Date:   Wed, 3 Feb 2021 08:09:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202231210.GA148198@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03.02.2021 00:12, Bjorn Helgaas wrote:
> On Thu, Dec 17, 2020 at 09:59:03PM +0100, Heiner Kallweit wrote:
>> This quirk was added in 2008 [0] when we didn't have the logic yet to
>> determine VPD size based on checking for the VPD end tag. Now that we
>> have this logic [1] and don't read beyond the end tag this quirk can
>> be removed.
>>
>> [0] 99cb233d60cb ("PCI: Limit VPD read/write lengths for Broadcom 5706, 5708, 5709 rev.")
>> [1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> This is basically the same as what you're currently discussing
>> for the Marvell / QLogic 1077 quirk.
>> ---
>>  drivers/pci/vpd.c | 46 ----------------------------------------------
>>  1 file changed, 46 deletions(-)
>>
>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>> index 7915d10f9..ef5165eb3 100644
>> --- a/drivers/pci/vpd.c
>> +++ b/drivers/pci/vpd.c
>> @@ -578,52 +578,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
>>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
>>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
>>  
>> -/*
>> - * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
>> - * VPD end tag will hang the device.  This problem was initially
>> - * observed when a vpd entry was created in sysfs
>> - * ('/sys/bus/pci/devices/<id>/vpd').   A read to this sysfs entry
>> - * will dump 32k of data.  Reading a full 32k will cause an access
>> - * beyond the VPD end tag causing the device to hang.  Once the device
>> - * is hung, the bnx2 driver will not be able to reset the device.
> 
>> - * We believe that it is legal to read beyond the end tag and
>> - * therefore the solution is to limit the read/write length.
> 
> So was this comment supposed to say it's *illegal* to read beyond the
> end tag?
> 

I think it's supposed to say that the PCI spec doesn't forbid accessing
VPD addresses not backed by actual VPD. But after 104daa71b396 this
isn't really relevant any longer, now we prevent such access beyond the
end tag.

>> - */
>> -static void quirk_brcm_570x_limit_vpd(struct pci_dev *dev)
>> -{
>> -	/*
>> -	 * Only disable the VPD capability for 5706, 5706S, 5708,
>> -	 * 5708S and 5709 rev. A
>> -	 */
>> -	if ((dev->device == PCI_DEVICE_ID_NX2_5706) ||
>> -	    (dev->device == PCI_DEVICE_ID_NX2_5706S) ||
>> -	    (dev->device == PCI_DEVICE_ID_NX2_5708) ||
>> -	    (dev->device == PCI_DEVICE_ID_NX2_5708S) ||
>> -	    ((dev->device == PCI_DEVICE_ID_NX2_5709) &&
>> -	     (dev->revision & 0xf0) == 0x0)) {
>> -		if (dev->vpd)
>> -			dev->vpd->len = 0x80;
> 
> And for these devices we just assume the valid VPD area is only 0x80
> bytes long?
> 

99cb233d60cb was submitted by someone from Broadcom, therefore I'd
assume that he had access to the device and data sheet, and 0x80
is the actual VPD size.

> And we believe that whatever 104daa71b396 ("PCI: Determine actual VPD
> size on first access") figures out is safe?  I'm guessing the actual
> VPD size on these NICs is determined by something on the device and it
> may not be 0x80.
> 
> So I guess the risk is that 104daa71b396 figures out the actual VPD
> size is, e.g., 0x100, and we now read the [0x80-0xff] region that we
> didn't read before, right?
> 
> If it works, great, but it is a potential change.  I'd love to remove
> these quirks.  I'm just slightly hesitant because the 99cb233d60cb
> commit log and comment seem to be exactly backwards.  Am I reading
> something wrong?
> 

After 104daa71b396 the code traverses the VPD structure until it finds
the end tag. Having said that we don't read beyond the end tag and
don't risk to hang the device, no matter whether the actual VPD size
is exactly 0x80, or less or more.

>> -	}
>> -}
>> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
>> -			PCI_DEVICE_ID_NX2_5706,
>> -			quirk_brcm_570x_limit_vpd);
>> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
>> -			PCI_DEVICE_ID_NX2_5706S,
>> -			quirk_brcm_570x_limit_vpd);
>> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
>> -			PCI_DEVICE_ID_NX2_5708,
>> -			quirk_brcm_570x_limit_vpd);
>> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
>> -			PCI_DEVICE_ID_NX2_5708S,
>> -			quirk_brcm_570x_limit_vpd);
>> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
>> -			PCI_DEVICE_ID_NX2_5709,
>> -			quirk_brcm_570x_limit_vpd);
>> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
>> -			PCI_DEVICE_ID_NX2_5709S,
>> -			quirk_brcm_570x_limit_vpd);
>> -
>>  static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
>>  {
>>  	int chip = (dev->device & 0xf000) >> 12;
>> -- 
>> 2.29.2
>>

