Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D057A23CE1F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgHESQD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 14:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgHESOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Aug 2020 14:14:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D693C061757
        for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2020 11:14:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d19so1390066pgl.10
        for <linux-pci@vger.kernel.org>; Wed, 05 Aug 2020 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=8+iseODG04wj2eQO70zdThix4Rye+QSBpwL+Z103cec=;
        b=qBE/U4w5v3/PEh7qno2eXuu83vEsnK8s8+DJkK9G4lCqAhGKG3voGon1dgWZhwoQm0
         tWkw6W9bk+fjUqbrxY+fI72gc4AnW2jpmUEny/lFxlaCJ7ds9KRavw+zurxz+Copl5RQ
         caJV7uAWmexn355HzhMpRe73tGsNLid0xb3pXXdhDe3shPCqblIS2TXs+T4FTW+Zo58K
         oDD9oQFd560qZo4dY3wViREH6z60NNDsMzEyLnp61+pJt39Cavu7W+X4J0JeDnLGuFvS
         HOe658YI4iGOQXOCA7hXzPkvh6YQqyD6acrKDNewoXwFx1OqX1fKhIMpFUtVaoDwPOlI
         kFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=8+iseODG04wj2eQO70zdThix4Rye+QSBpwL+Z103cec=;
        b=ktmDdL+GYZMANx30+1RT2slnBsYcyzEA2acdDo/37x9O1pkZ4ub/GiP0cUVZfDTOgV
         qz1VKbF+JwMaRs5O1W3yQjWteyWPlilNudgL3TkV1w4i+sNi0pRbtUzayNRfy98iutMU
         ov/BThoIZz7xOLtsuZy7V5jsgSmOxC0Ik9/SRf2MQT02EgjyzDTm6clPnyWCJTY/Z5nJ
         jO+1+DeE+eIGo+XqMH5bLRVYWqkDkgV0ALTqmbS/PrxxlOlNq86F01Vi5F3dW+iWPD5p
         E9VSfunDjjeSknwa2KUM95BAPSD0Wk6panWrQ6uBRmYU+YAveod1d+Cu+PPr2jT/b4qA
         6Qcw==
X-Gm-Message-State: AOAM532B3UkfBUodk6lm5v+Abc77yL6XinomrwqaTRzAFNOeaBax3ZVe
        5W7fTtidM5N7KHZdz0AJ/gtlgg==
X-Google-Smtp-Source: ABdhPJxNIX8R5bxM2jjZWyxDUzlqJE6j/Lv8pzaiJlKUmXuVOBEC9paLpU3JILYqHPiBKwUd8ETMoQ==
X-Received: by 2002:a62:a101:: with SMTP id b1mr4279847pff.306.1596651291969;
        Wed, 05 Aug 2020 11:14:51 -0700 (PDT)
Received: from [10.213.170.159] (fmdmzpr04-ext.fm.intel.com. [192.55.55.39])
        by smtp.gmail.com with ESMTPSA id z67sm4852718pfc.162.2020.08.05.11.14.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 11:14:51 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH V2 2/9] PCI: Extend Root Port Driver to support RCEC
Date:   Wed, 05 Aug 2020 11:14:48 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <E3F966D9-DBD4-4392-84FF-F012D1F16615@intel.com>
In-Reply-To: <20200805174328.GA521293@bjorn-Precision-5520>
References: <20200805174328.GA521293@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5 Aug 2020, at 10:43, Bjorn Helgaas wrote:

> "git log --oneline" again.

Rewording lost track of the first line.  Argh, will fix.
>
> On Tue, Aug 04, 2020 at 12:40:45PM -0700, Sean V Kelley wrote:
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
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> ---
>>  drivers/pci/pcie/portdrv_core.c | 8 ++++----
>>  drivers/pci/pcie/portdrv_pci.c  | 5 ++++-
>>  2 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c 
>> b/drivers/pci/pcie/portdrv_core.c
>> index 50a9522ab07d..5d4a400094fc 100644
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
>> +	 * of generating PME too.
>>  	 */
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
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
>> 2.27.0
>>
