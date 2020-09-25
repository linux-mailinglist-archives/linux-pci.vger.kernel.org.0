Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AD52793AD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 23:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgIYVkA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 17:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgIYVkA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 17:40:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD3C0613CE
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 14:40:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x16so2898928pgj.3
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QmafiPpDZbVY4DMisW5kzbNf40EP7isLeadTAsoh5x8=;
        b=0hmcMVXQnMNYDdihlk8d+BigaxwjlFUKEWFJygyC7crtrjFYF5HVpZBV4BMMXrl6wh
         g4zM7i8Qx0Cg+y/SILRSBeGnudsKB8sQJyuD9ZVItsW5kJ2J+kk6JlR3tAep1e5faA+A
         bpZLtRF3bgjctigvr+/YCirJkP5KP+WcFXFr6vYWkQ6wiqbfxB+Jrp7m1t1tB711/pVo
         oUbFOGNeObzQDAvpvh5YKKvWqNPzo2MD/9riMMcOOFjOWOoNmJ8ureamrqBiB8mf+BWJ
         AJNmkmgnGDv9dFj5ktZKA3XZvG2O7IAShpcekjNNgZ8zhZbZvWXKvNFOOM+VpxjaamPs
         ay9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmafiPpDZbVY4DMisW5kzbNf40EP7isLeadTAsoh5x8=;
        b=lUhkVBXJir9wsuWW46HZKJbk9vYhNNatfyLmrCw5TNoRH1kITZc3O6p4rYNw1fBojL
         KP4lkNLIiwGzosJjsfk/aQgIO9fg6lMHKcq8ezYp4+pyhd4wFc5BEOS3r4NaoitfAQMp
         EpmO/JY8JACAfr/FC7dSfcPmuWrxh3gCe5jlnJ2R6LWjpp/Iwe44qCG7MFh7TJNf+ycu
         uc7n5x3lB/lus3YmNDpAUqFSOCt0XH7y6DunK3nnGbH5MInelyzqN40oXq2crPycJBiJ
         08hTfkvsFgXYJW4XoJ+bOlcZArvZmAm/huFDVjDSikfwiFZWq6lrjYDJi2T3kddUD9Os
         f2uw==
X-Gm-Message-State: AOAM530VZTK8tOqpdoIfmRY46hXITF/YWaKuBCbbIekYJ/2DgsW6Lv6e
        1gccOGsCgQmT2WT6kVJQf4q1V9II9Ukgqg==
X-Google-Smtp-Source: ABdhPJyDGTEY5Iecp1lQPV3mBvl+zW3o+Szp0F3pV38ayi3WvjRD1hCPSnL+DrX8aKq+u7PdZnvgSw==
X-Received: by 2002:aa7:9157:0:b029:142:2501:3984 with SMTP id 23-20020aa791570000b029014225013984mr1093626pfi.73.1601069999565;
        Fri, 25 Sep 2020 14:39:59 -0700 (PDT)
Received: from [10.212.51.97] ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id y10sm3694581pfp.77.2020.09.25.14.39.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 14:39:58 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/10] PCI/RCEC: Bind RCEC devices to the Root Port
 driver
Date:   Fri, 25 Sep 2020 14:39:56 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <CD5CCACF-114C-4F61-AC06-CED19149ADB7@intel.com>
In-Reply-To: <20200925195913.GA2455203@bjorn-Precision-5520>
References: <20200925195913.GA2455203@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25 Sep 2020, at 12:59, Bjorn Helgaas wrote:

> On Tue, Sep 22, 2020 at 02:38:51PM -0700, Sean V Kelley wrote:
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>
>> If a Root Complex Integrated Endpoint (RCiEP) is implemented, errors 
>> may
>> optionally be sent to a corresponding Root Complex Event Collector 
>> (RCEC).
>> Each RCiEP must be associated with no more than one RCEC. Interface 
>> errors
>> are reported to the OS by RCECs.
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
>> Given the commonality with Root Ports and the need to also support 
>> AER
>> and PME services for RCECs, extend the Root Port driver to support 
>> RCEC
>> devices through the addition of the RCEC Class ID to the driver
>> structure.
>>
>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  drivers/pci/pcie/portdrv_core.c | 8 ++++----
>>  drivers/pci/pcie/portdrv_pci.c  | 5 ++++-
>>  2 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c 
>> b/drivers/pci/pcie/portdrv_core.c
>> index 50a9522ab07d..99769c636775 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -234,11 +234,11 @@ static int get_port_device_capability(struct 
>> pci_dev *dev)
>>  #endif
>>
>>  	/*
>> -	 * Root ports are capable of generating PME too.  Root Complex
>> -	 * Event Collectors can also generate PMEs, but we don't handle
>> -	 * those yet.
>> +	 * Root ports and Root Complex Event Collectors are capable
>> +	 * of generating PME.
>>  	 */
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>
> It seems like this change belongs in patch 09/10, where we change
> pme.c so it claims both Root Ports and RCECs.  Does this hunk
> accomplish anything before 09/10?

You are right.  It’s not needed until 09/10.  Will move.

Thanks,

Sean

>
>>  	    (pcie_ports_native || host->native_pme)) {
>>  		services |= PCIE_PORT_SERVICE_PME;
>>
>> diff --git a/drivers/pci/pcie/portdrv_pci.c 
>> b/drivers/pci/pcie/portdrv_pci.c
>> index 3a3ce40ae1ab..4d880679b9b1 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -106,7 +106,8 @@ static int pcie_portdrv_probe(struct pci_dev 
>> *dev,
>>  	if (!pci_is_pcie(dev) ||
>>  	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
>>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
>> -	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
>> +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM) &&
>> +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
>>  		return -ENODEV;
>>
>>  	status = pcie_port_device_register(dev);
>> @@ -195,6 +196,8 @@ static const struct pci_device_id port_pci_ids[] 
>> = {
>>  	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
>>  	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
>>  	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
>> +	/* handle any Root Complex Event Collector */
>> +	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
>>  	{ },
>>  };
>>
>> -- 
>> 2.28.0
>>
