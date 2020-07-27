Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9532A22F3BC
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 17:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgG0PVQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 11:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgG0PVQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 11:21:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49304C0619D2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:21:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so9574536pjd.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=6WFDCMR/aFsGCXIkLo1qPpoIrdqBYyn4pKaRRaw1Gwk=;
        b=x1tV6OzPQIMrgM4u3XM1ii/clG8BQpLhka+0vnDNLT4XeYJYluC5eo6n5D5ZYhgOOL
         hE8xXW+Op1mFpNgem7FZY/oS1qw2j7E2+jsi+NQ+gfHEUagIzmsJj64zTfFacj7zoIou
         0Or1vyzmYEZ7GmX5WdKPYBJsGoLYQpWDl0053wIbzg2iviWsHhu/Z1JfZFJg6IlHTuvM
         U2JpXfGn/I10X7xXnMLiUoejuLRI2BoSav/j2RZBCUcldwf2UKg1UWxrFy72c77GYi9E
         TJKp9EX2hWLZ/8W1xtZBqwQ6bFAdgZqQ/jEV6ZjqkQUasx69DFg3tOfG2WkTO4ED2WIU
         kCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=6WFDCMR/aFsGCXIkLo1qPpoIrdqBYyn4pKaRRaw1Gwk=;
        b=mrQHANbS/Zl0YAJhJciRhivpWqxmu+MaYu/+Dss2b4zE2+qm2PEkxsOQT51bcCfavA
         sac8cU6OgyffejwBUawQZk6rnKftFbmWkUBzliGqX7dDesP2K7Cq9kMjsWjA8LJIMnFW
         N2gaAWUlWlVvdTky7TNsQs7vax8pe8OTO/b+ZKQfAMxxdQ/x8wUUcvVNKyh4JWHawJqT
         qquMs42i6cwiecAV9Avbhtzsf5k/7JbM7m/IjMQB/Ybq27AXuzBuBI4Ugcgmp8vuwiuP
         H+/ZODI1OY88ZgoE/PyRYfBV18LSVuWfiE8MeLkXTg/1LX1Kep7x6cOKrpOsE+0LfPm8
         jh4Q==
X-Gm-Message-State: AOAM532N3oL2FBolc6Sk9i2Tcv50abzcjs9+4A1X9xFXMLH3o9Ppn9d4
        eGCme+McEr6vx1kS9DugDPH0IA==
X-Google-Smtp-Source: ABdhPJyueCO2OCESPqGz7tCrLs5TrjuN99neCKuO+ygLD97ZIVDsNWyU93Ahp5LsjTR40VmGz3+JoQ==
X-Received: by 2002:a17:90a:cf05:: with SMTP id h5mr18621723pju.219.1595863275764;
        Mon, 27 Jul 2020 08:21:15 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id r8sm15585582pfg.147.2020.07.27.08.21.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 08:21:15 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net,
        "Raj, Ashok" <ashok.raj@intel.com>, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 3/9] PCI/portdrv: Add pcie_walk_rcec() to walk RCiEPs
 associated with RCEC
Date:   Mon, 27 Jul 2020 08:21:15 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <069BD0BC-4377-4107-A828-1E842C29BD83@intel.com>
In-Reply-To: <20200727114932.00002c33@Huawei.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200724172223.145608-4-sean.v.kelley@intel.com>
 <20200727114932.00002c33@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Comments below:

On 27 Jul 2020, at 3:49, Jonathan Cameron wrote:

> On Fri, 24 Jul 2020 10:22:17 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>
>> When an RCEC device signals error(s) to a CPU core, the CPU core
>> needs to walk all the RCiEPs associated with that RCEC to check
>> errors. So add the function pcie_walk_rcec() to walk all RCiEPs
>> associated with the RCEC device.
>>
>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>
> A few trivial points inline. With those tidied up.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>  drivers/pci/pcie/portdrv.h      |  2 +
>>  drivers/pci/pcie/portdrv_core.c | 82 
>> +++++++++++++++++++++++++++++++++
>>  2 files changed, 84 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
>> index af7cf237432a..c11d5ecbad76 100644
>> --- a/drivers/pci/pcie/portdrv.h
>> +++ b/drivers/pci/pcie/portdrv.h
>> @@ -116,6 +116,8 @@ void pcie_port_service_unregister(struct 
>> pcie_port_service_driver *new);
>>
>>  extern struct bus_type pcie_port_bus_type;
>>  int pcie_port_device_register(struct pci_dev *dev);
>> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev 
>> *, void *),
>> +		    void *userdata);
>>  #ifdef CONFIG_PM
>>  int pcie_port_device_suspend(struct device *dev);
>>  int pcie_port_device_resume_noirq(struct device *dev);
>> diff --git a/drivers/pci/pcie/portdrv_core.c 
>> b/drivers/pci/pcie/portdrv_core.c
>> index 50a9522ab07d..bdcbb34764c2 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/string.h>
>>  #include <linux/slab.h>
>> +#include <linux/bitops.h>
>>  #include <linux/aer.h>
>>
>>  #include "../pci.h"
>> @@ -365,6 +366,87 @@ int pcie_port_device_register(struct pci_dev 
>> *dev)
>>  	return status;
>>  }
>>
>> +static int pcie_walk_rciep_devfn(struct pci_bus *pbus, int 
>> (*cb)(struct pci_dev *, void *),
>> +				 void *userdata, unsigned long bitmap)
>> +{
>> +	unsigned int dev, fn;
>> +	struct pci_dev *pdev;
>> +	int retval;
>> +
>> +	for_each_set_bit(dev, &bitmap, 32) {
>> +		for (fn = 0; fn < 8; fn++) {
>> +			pdev = pci_get_slot(pbus, PCI_DEVFN(dev, fn));
>> +
>> +			if (!pdev || pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
>> +				continue;
>> +
>> +			retval = cb(pdev, userdata);
>> +			if (retval)
>> +				return retval;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/** pcie_walk_rcec - Walk RCiEP devices associating with RCEC and 
>> call callback.
>
> /**
>  * pcie...

Will correct.


>
>> + *  @rcec     RCEC whose RCiEP devices should be walked.
>> + *  @cb       Callback to be called for each RCiEP device found.
>> + *  @userdata Arbitrary pointer to be passed to callback.
>> + *
>> + *  Walk the given RCEC. Call the provided callback on each RCiEP 
>> device found.
>> + *
>> + *  We check the return of @cb each time. If it returns anything
>> + *  other than 0, we break out.
>> + *
>> + */
>> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev 
>> *, void *),
>> +		    void *userdata)
>> +{
>> +	u32 pos, bitmap, hdr, busn;
>> +	u8 ver, nextbusn, lastbusn;
>> +	struct pci_bus *pbus;
>> +	unsigned int bnr;
>> +
>> +	pos = pci_find_ext_capability(rcec, PCI_EXT_CAP_ID_RCEC);
>> +	if (!pos)
>> +		return;
>> +
>> +	pbus = pci_find_bus(pci_domain_nr(rcec->bus), rcec->bus->number);
>> +	if (!pbus)
>> +		return;
>> +
>> +	pci_read_config_dword(rcec, pos + PCI_RCEC_RCIEP_BITMAP, &bitmap);
>> +
>> +	/* Find RCiEP devices on the same bus as the RCEC */
>> +	if (pcie_walk_rciep_devfn(pbus, cb, userdata, (unsigned 
>> long)bitmap))
>> +		return;
>> +
>> +	/* Check whether RCEC BUSN register is present */
>> +	pci_read_config_dword(rcec, pos, &hdr);
>> +	ver = PCI_EXT_CAP_VER(hdr);
>> +	if (ver < PCI_RCEC_BUSN_REG_VER)
>> +		return;
>> +
>> +	pci_read_config_dword(rcec, pos + PCI_RCEC_BUSN, &busn);
>> +	nextbusn = PCI_RCEC_BUSN_NEXT(busn);
>> +	lastbusn = PCI_RCEC_BUSN_LAST(busn);
>> +
>> +	/* All RCiEP devices are on the same bus as the RCEC */
>> +	if (nextbusn == 0xff && lastbusn == 0x00)
>> +		return;
>> +
>> +	for (bnr = nextbusn; bnr < (lastbusn + 1); bnr++) {
>
> Why not bnr <= lastbusn?  Seems more intuitive way of making it clear 
> the
> range is inclusive.

Good suggestion.  Will change.

Thanks,

Sean

>
>
>> +		pbus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
>> +		if (!pbus)
>> +			continue;
>> +
>> +		/* Find RCiEP devices on the given bus */
>> +		if (pcie_walk_rciep_devfn(pbus, cb, userdata, 0xffffffff))
>> +			return;
>> +	}
>> +}
>> +
>>  #ifdef CONFIG_PM
>>  typedef int (*pcie_pm_callback_t)(struct pcie_device *);
>>
