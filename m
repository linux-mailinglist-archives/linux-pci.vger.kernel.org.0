Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763502DDA65
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 21:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbgLQUzq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Dec 2020 15:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgLQUzp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2020 15:55:45 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370CCC0617B0
        for <linux-pci@vger.kernel.org>; Thu, 17 Dec 2020 12:55:05 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id x16so32861ejj.7
        for <linux-pci@vger.kernel.org>; Thu, 17 Dec 2020 12:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/n4tISLwBWk29kv4VE5wRujA6v3nJCLjKvZIzt5Hta4=;
        b=SJW3EA72ybrI18iwZSP0MSV6M3gM3ysCkyka+RHfdOd93IJc8BcHohM4DtZcY55xvj
         fpMWIBhYpwFLYe/MLNtxuTgD8GtaGYRBtAmjDc0j5z9SsJXVMbSCVWvV7vkvW6uShMBe
         Eq1YJpBTm7yYwRm1/Kd8L2Hj2Wf0a8hSz2tvI2MOmzj6ZHwQOdnVaYD+yxhG1zz5rkg/
         d5fDctyzlrLprR9amfpySw+2mrF3EYbPegD8PiFyI4FAEFs8hhNY+GpKfi3uNL2HRoHt
         Bgj9oarw0kXgrvKOHGAHBwz0SFt8yCHN4RorYanjc0LmmNvTdagYSvzejLXzIY5STY5p
         cDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/n4tISLwBWk29kv4VE5wRujA6v3nJCLjKvZIzt5Hta4=;
        b=LUAjoz8vYzI0YNiHiMEW6GvnyBblRLyuwqMyzYHhqzyvn7iHKpB2jRoMJDeSLWF52C
         nzOqDmpCD8uKsGB0skCCWN+kiC5LvGQF4KzhWzfhL8AMgW04yRM7JVG7zW3R+GXyCW4E
         IGXR/L7owCTdJ46r5hE9n9e2XCFHSYBxWtfMvL2xNSvOcBNnuGEXaWMPOjlusERvE8xc
         zCycZ/pi77J7ttJ2NPTAvGUPW/k9pxN8wq/7sHkAnnDNG1RxV2fETAj/mnkZJsMDvr/1
         4JIs9T7d35hNUua90vA2UfdYn+RbSxVvINV3czEIZAieLVFYMxbywdN69Xv//kIfcVwk
         ILcA==
X-Gm-Message-State: AOAM5323dhjbPXJRmMkamBvXryNXS/tzhZzbfOtB+knO53/7foFDS81s
        8MRoLM3NbIeIXjCElnIqNRZS8gGZgMY=
X-Google-Smtp-Source: ABdhPJzM7Q/R04GU0LUPD3wEzo1t46USdwjApj3pl5XHaBqQBHVJt/Ss773gWits+nWnz9DHMxBvmw==
X-Received: by 2002:a17:906:3949:: with SMTP id g9mr802222eje.493.1608238503739;
        Thu, 17 Dec 2020 12:55:03 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:c095:d389:734d:8e2a? (p200300ea8f065500c095d389734d8e2a.dip0.t-ipconnect.de. [2003:ea:8f06:5500:c095:d389:734d:8e2a])
        by smtp.googlemail.com with ESMTPSA id b7sm4600754ejz.4.2020.12.17.12.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 12:55:03 -0800 (PST)
Subject: Re: [PATCH] PCI/VPD: Remove not any longer needed Broadcom NIC quirk
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20201217204759.GA21701@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <77417d1d-5f25-13a1-773b-9d7c5399c421@gmail.com>
Date:   Thu, 17 Dec 2020 21:55:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201217204759.GA21701@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 17.12.2020 um 21:47 schrieb Bjorn Helgaas:
> On Thu, Dec 17, 2020 at 09:29:19PM +0100, Heiner Kallweit wrote:
>> This quirk was added in 2008 when we didn't have the logic yet to
>> determine VPD size based on checking for the VPD end tag. Now that we
>> have this logic and don't read beyond the end tag this quirk can be
>> removed.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> This is basically the same as what you're currently discussing
>> for the Marvell / QLogic 1077 quirk.
> 
> We need to reference the commit that makes the quirk unnecessary so
> people can tell how far it is safe to backport this patch.
> 
OK, will add the info in a v2.

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
>> - * We believe that it is legal to read beyond the end tag and
>> - * therefore the solution is to limit the read/write length.
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

