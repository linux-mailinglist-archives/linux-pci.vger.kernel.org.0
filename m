Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E5022F3C4
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 17:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgG0PWd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgG0PWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 11:22:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8140BC061794
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:22:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so2172181pjb.4
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=WuC1tb7x6BvGKECYdAj7+6Xq8ux4z2ArO6V4hSqf9AI=;
        b=YsRU7599SfR3atuSMTgfO+82rworsYawNL+SFlR7K4yxmzA8kced131hV/TIMD2ISK
         P1DsnOytkQQI3VZFZM9YXG+X7w3CF94OS5mJzL3KTdiYUKbe4y3/I81W1NO1hQfiS7Vl
         ywewvfg6YGOUYgp8HdkJ7X0xVvlYI4jMnWmVRc83zQJSRRiB7/UK9esy3oT34I477iCM
         MyUaT/VzXb34HottKU4GBXQZZbF+wkV1bpd/4A6aU4l+B1sDHhS50Cib2NvfkfsHPts3
         sbFG94sDNiUr5hWyM4HWb0AZRcHnjmh98+D05MpCHyhCoiznM0fywjImzzoprdG+dg0p
         p9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=WuC1tb7x6BvGKECYdAj7+6Xq8ux4z2ArO6V4hSqf9AI=;
        b=OZWwLQ1mndkPx9lphgx3E3DxtSV9ofAG+t19c/g11YyR6mlrQT+Pk0ggNtpY0z28eo
         OUQW6yl3eRAUiKkxA9fCqs6nYICmJ6IJyXxylc/t/M9NsSXlWW0odVz41lYCWJsQFgT8
         CxstQVpMg6CjvafB2ABDtDjdIjtvn/8kdcNMl9Q/91WXCTBdWYpk4pxsj+9ljeUZPm6x
         rMp8bQwsWyIyMc/bg2Njy/eQiX7fvzXm6GUrk0ohUnMO3jdKa7cd3Wj/Q1m91DaqaN7o
         9X9IgJHVRaexLF5gWABTsVXWULr2+dPZQ0NSaVMikuklbATWIdw7eDsz3A55fb8X/xQ2
         /bBA==
X-Gm-Message-State: AOAM531H0ouG/eKAIN68dFMF2u7U/kAP3NUHvhLqgTr6dvZ1Wf3b1rsh
        I5cG1K7xmUMDlupjOmQNpLFa8A==
X-Google-Smtp-Source: ABdhPJxn578JPxUHbJg2Rzf/Arc8hfPOep4kNjExc3YQaChXVmlnG+GQatw85eg1Gzvp1O2gzoPQHw==
X-Received: by 2002:a17:90a:14a5:: with SMTP id k34mr19914708pja.37.1595863353074;
        Mon, 27 Jul 2020 08:22:33 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id 141sm16274919pfw.72.2020.07.27.08.22.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 08:22:32 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net,
        "Raj, Ashok" <ashok.raj@intel.com>, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 1/9] pci_ids: Add class code and extended capability
 for RCEC
Date:   Mon, 27 Jul 2020 08:22:33 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <4B3D13E2-4512-4CDE-A853-A4DB96B8258D@intel.com>
In-Reply-To: <20200727112121.00007653@Huawei.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200724172223.145608-2-sean.v.kelley@intel.com>
 <20200727110010.00005042@Huawei.com> <20200727112121.00007653@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27 Jul 2020, at 3:21, Jonathan Cameron wrote:

> On Mon, 27 Jul 2020 11:00:10 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
>> On Fri, 24 Jul 2020 10:22:15 -0700
>> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>>
>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>
>>> A PCIe Root Complex Event Collector(RCEC) has the base class 0x08,
>>> sub-class 0x07, and programming interface 0x00. Add the class code
>>> 0x0807 to identify RCEC devices and add the defines for the RCEC
>>> Endpoint Association Extended Capability.
>>>
>>> See PCI Express Base Specification, version 5.0-1, section "1.3.4
>>> Root Complex Event Collector" and section "7.9.10 Root Complex
>>> Event Collector Endpoint Association Extended Capability"
>>
>> Add a reference to the document
>> "PCI Code and ID Assignment Specification"
>> for the class number.
>
> Actually probably no need. I'd somehow managed to fail to notice the
> class code is also given in section 1.3.4 of the main spec.

Okay, will leave as is.

Thanks,

Sean

>
>>
>> From the change log on latest version seems like it's been there 
>> since
>> version 1.4.
>>
>> There is a worrying note (bottom of page 16 of 1.12 version of that 
>> docs)
>> in there that says some older specs used 0x0806 for RCECs and that we
>> should use the port type field to actually check if we have one.
>>
>> Hopefully we won't encounter any of those in the wild.
>>
>> Otherwise, it's exactly what the spec says.
>> We could bike shed on naming choices, but the ones you have seem 
>> clear enough
>> to me.
>>
>> FWIW
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>>
>> Jonathan
>>>
>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>> ---
>>>  include/linux/pci_ids.h       | 1 +
>>>  include/uapi/linux/pci_regs.h | 7 +++++++
>>>  2 files changed, 8 insertions(+)
>>>
>>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>> index 0ad57693f392..de8dff1fb176 100644
>>> --- a/include/linux/pci_ids.h
>>> +++ b/include/linux/pci_ids.h
>>> @@ -81,6 +81,7 @@
>>>  #define PCI_CLASS_SYSTEM_RTC		0x0803
>>>  #define PCI_CLASS_SYSTEM_PCI_HOTPLUG	0x0804
>>>  #define PCI_CLASS_SYSTEM_SDHCI		0x0805
>>> +#define PCI_CLASS_SYSTEM_RCEC		0x0807
>>>  #define PCI_CLASS_SYSTEM_OTHER		0x0880
>>>
>>>  #define PCI_BASE_CLASS_INPUT		0x09
>>> diff --git a/include/uapi/linux/pci_regs.h 
>>> b/include/uapi/linux/pci_regs.h
>>> index f9701410d3b5..f335f65f65d6 100644
>>> --- a/include/uapi/linux/pci_regs.h
>>> +++ b/include/uapi/linux/pci_regs.h
>>> @@ -828,6 +828,13 @@
>>>  #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system 
>>> budget */
>>>  #define PCI_EXT_CAP_PWR_SIZEOF	16
>>>
>>> +/* Root Complex Event Collector Endpoint Association  */
>>> +#define PCI_RCEC_RCIEP_BITMAP	4	/* Associated Bitmap for RCiEPs */
>>> +#define PCI_RCEC_BUSN		8	/* RCEC Associated Bus Numbers */
>>> +#define  PCI_RCEC_BUSN_REG_VER	0x02	/* Least capability version 
>>> that BUSN present */
>>> +#define  PCI_RCEC_BUSN_NEXT(x)	(((x) >> 8) & 0xff)
>>> +#define  PCI_RCEC_BUSN_LAST(x)	(((x) >> 16) & 0xff)
>>> +
>>>  /* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
>>>  #define PCI_VNDR_HEADER		4	/* Vendor-Specific Header */
>>>  #define  PCI_VNDR_HEADER_ID(x)	((x) & 0xffff)
>>
