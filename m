Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C122F339
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 17:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgG0PAM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgG0PAL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 11:00:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8917DC0619D2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:00:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so8118234ply.11
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=wjEW0lREFus8EI322SDRPKgG4j1s1AWKdt5U75Ucocc=;
        b=EhL6stLZi9wXPCL91sPuosEnsHWJbKk9Huug49YnPVjbUNqt32xBzbOgTDmvpxweJ9
         Mmnuxhh3VI1wQeBK15SysbYmCZomp+RVSRJKUd5kBXJfKLVeerU60eYAxcxxJmXRDezb
         R6IEB5/T4UvxqW1ERE/LOVMRdWVYsWy1y8Gajm7BknSsSlkGUTKVeMuV1hcFqTrq9Mup
         BVbrQMNg/dJdMXh++TcHYmKs5OE/GS/8cbPY5Mdd4tUDByBfQ3mCvE+vkgR4Xvew4x2v
         wR/8QKXJgER+56PR9FV16ALqyDUL1a78qsINV/0mCh3Ib32sdbrwHFAhBEOjT0IY9g6y
         0JYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=wjEW0lREFus8EI322SDRPKgG4j1s1AWKdt5U75Ucocc=;
        b=fo/VZ0AQKzI9JdarKJI/IxxYBZPCPDdO5HhOnFpKqL0wnegdjUxLqpwyKrHmsG8AIo
         Qk3IsKHsEMWkFIyr7NjdCNUfOKKelpN3SRZT2Lej+pFWjzLCk2CGAeZVkzz3jJnkC4XO
         bh6ethRz7mX/Dy470MTrusYvG80GwG8GQwkLXcOXXa9pkQLJGxrU+1zciU4+GJdliLf4
         DmBnd4OVgeB/3jTysTSAIMhail+489y3lKH/yB/N52+EvaPPezqZVadcUfXCE74hnB2W
         ugwn6POXhUmcuD+zE+SVTEZLkpS3y3jxbm0vWn7+R+pz28qUv/Y/86VOjy55820VDBxL
         U7Tw==
X-Gm-Message-State: AOAM530wC9dA+mHATsWJbL73bszkaHfguex1SMDxicxlkh/R9jeaNzw+
        Y0kD/IEzKeOB6k0huq/yVeQRSw==
X-Google-Smtp-Source: ABdhPJzQuLg+aYWabdbry4azYJ1VOJKYgI2dyAGxpZQ56GRxowjKpwzOHLjsRgFU11k/hqWmIFOalw==
X-Received: by 2002:a17:90a:3fc7:: with SMTP id u7mr19110663pjm.231.1595862011095;
        Mon, 27 Jul 2020 08:00:11 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id h15sm16174872pjc.14.2020.07.27.08.00.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 08:00:10 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, tony.luck@intel.com,
        "Raj, Ashok" <ashok.raj@intel.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/9] PCI/AER: Extend AER error handling to RCECs
Date:   Mon, 27 Jul 2020 08:00:11 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <BBEF2C05-521A-42D9-9AA4-F0B537E063F5@intel.com>
In-Reply-To: <20200727150426.00005cde@huawei.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200724172223.145608-5-sean.v.kelley@intel.com>
 <20200727150426.00005cde@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27 Jul 2020, at 7:04, Jonathan Cameron wrote:

> On Fri, 24 Jul 2020 10:22:18 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Currently the kernel does not handle AER errors for Root Complex 
>> integrated
>> End Points (RCiEPs)[0]. These devices sit on a root bus within the 
>> Root Complex
>> (RC). AER handling is performed by a Root Complex Event Collector 
>> (RCEC) [1]
>> which is a effectively a type of RCiEP on the same root bus.
>>
>> For an RCEC (technically not a Bridge), error messages "received" 
>> from
>> associated RCiEPs must be enabled for "transmission" in order to 
>> cause a
>> System Error via the Root Control register or (when the Advanced 
>> Error
>> Reporting Capability is present) reporting via the Root Error Command
>> register and logging in the Root Error Status register and Error 
>> Source
>> Identification register.
>>
>> In addition to the defined OS level handling of the reset flow for 
>> the
>> associated RCiEPs of an RCEC, it is possible to also have a firmware 
>> first
>> model. In that case there is no need to take any actions on the RCEC 
>> because
>> the firmware is responsible for them. This is true where APEI [2] is 
>> used
>> to report the AER errors via a GHES[v2] HEST entry [3] and relevant
>> AER CPER record [4] and Firmware First handling is in use.
>>
>> We effectively end up with two different types of discovery for
>> purposes of handling AER errors:
>>
>> 1) Normal bus walk - we pass the downstream port above a bus to which
>> the device is attached and it walks everything below that point.
>>
>> 2) An RCiEP with no visible association with an RCEC as there is no 
>> need to
>> walk devices. In that case, the flow is to just call the callbacks 
>> for the actual
>> device.
>>
>> A new walk function, similar to pci_bus_walk is provided that takes a 
>> pci_dev
>> instead of a bus. If that dev corresponds to a downstream port it 
>> will walk
>> the subordinate bus of that downstream port. If the dev does not then 
>> it
>> will call the function on that device alone.
>>
>> [0] ACPI PCI Express Base Specification 5.0-1 1.3.2.3 Root Complex 
>> Integrated
>>     Endpoint Rules.
>> [1] ACPI PCI Express Base Specification 5.0-1 6.2 Error Signalling 
>> and Logging
>> [2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error Interface 
>> (APEI)
>> [3] ACPI Specification 6.3 18.2.3.7 Generic Hardware Error Source
>> [4] UEFI Specification 2.8, N.2.7 PCI Express Error Section
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> ---
> ...
>
>
>>  	pci_dbg(dev, "broadcast resume message\n");
>> -	pci_walk_bus(bus, report_resume, &status);
>> +	pci_walk_dev_affected(dev, report_resume, &status);
>>
>> -	pci_aer_clear_device_status(dev);
>> -	pci_aer_clear_nonfatal_status(dev);
>
> This code had changed a little in Bjorn's pci/next branch so do a 
> rebase on that
> before v2.

Will ensure rebase includes pci/next.

Thanks,

Sean

>
>> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
>> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
>> +		pci_aer_clear_device_status(dev);
>> +		pci_aer_clear_nonfatal_status(dev);
>> +	}
>>  	pci_info(dev, "device recovery successful\n");
>>  	return status;
>>
