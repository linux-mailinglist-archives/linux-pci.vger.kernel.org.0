Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B917B11C0AC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 00:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLKXk3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 18:40:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36634 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLKXk3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2019 18:40:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so252484wma.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2019 15:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=foUeHKYwxZENesR/ao95Ojl4028wWw6rXK6q1y1Jq8o=;
        b=c4/VFQMjZwBHv/1qLuUhvwKovfNcFTdSXXSmMx7SXdYPr9rkKSTM6uuYEzt2VR97b1
         Xtylarf3eP94fhPSx86BASo8ILrGR/3S0v0Uy+IIgdta572YPsFoXffXhDvbbGKltiM6
         6QCJLzYas2Sge1eoKjIL76EOy2IrFib0mVVQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=foUeHKYwxZENesR/ao95Ojl4028wWw6rXK6q1y1Jq8o=;
        b=TNvZoULouKErQW7n6rP3QEuVLklc8KXxbxi7FqXRE00Sx5ndxTweIf+nisjVk8Qgoj
         ChflAdFrvfdYuauYkWWaHuAbTZBNbgwgDxuXKGsPP3AIlXhukvRHx7480jmiiz98Dv0g
         ojScOy4pzHIMYb321KPzqwCIotu9IPSlv8IRqcDM6Nw2iixJzFqw0O5A/r075SIdY9Yd
         Swb4WB+MV7mxvr2er/1ONZDWpxjT1zRU2jbh/BUpMeDqJ9DLq6bUMc3wCG1zPaFfn93b
         WSiW5b7lgfjUaY3yzCaRBbD38aYx9kt84MTCuXSaWKzq1J9bBG9rDb9ZAN8LUpeQfOuo
         XT9Q==
X-Gm-Message-State: APjAAAU24b22B19jOrS+xaBvjzJ0vZQVt+J/V7lJBU2S8KOEfdTD++3n
        2XWd3Nug6CWtOC7puFBxKjumKw==
X-Google-Smtp-Source: APXvYqxo9xVmMjfj4H0mTQrLDUJ7/QhWaShBP5oQJPPpUzWdQNEeYbsXE1F8ciZtOy4AMxJF8d3LXg==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr2705412wmb.47.1576107625065;
        Wed, 11 Dec 2019 15:40:25 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z11sm4008381wrt.82.2019.12.11.15.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 15:40:24 -0800 (PST)
Subject: Re: [PATCH] PCI: iproc: move quirks to driver
To:     Bjorn Helgaas <helgaas@kernel.org>, Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org, rjui@broadcom.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20191211223438.GA121846@google.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <afbb14fb-e114-d6de-0bfe-d39be354842e@broadcom.com>
Date:   Wed, 11 Dec 2019 15:40:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211223438.GA121846@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/11/19 2:34 PM, Bjorn Helgaas wrote:
> On Wed, Dec 11, 2019 at 05:45:11PM +0000, Wei Liu wrote:
>> The quirks were originally enclosed by ifdef. That made the quirks not
>> to be applied when respective drivers were compiled as modules.
>>
>> Move the quirks to driver code to fix the issue.
>>
>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> 
> This straddles the core and native driver boundary, so I applied it to
> pci/misc for v5.6.  Thanks, I think this is a great solution!  It's
> always nice when we can encapsulate device-specific things in a
> driver.
> 

Opps! I was going to review and comment and you are quick, :)

I was going to say, I think it's better to keep this quirk in 
"pcie-iproc.c" instead of "pcie-iproc-platform.c".

The quirk is specific to certain PCIe devices under iProc (activated 
based on device ID), but should not be tied to a specific bus 
architecture (i.e., platform vs BCMA).

Thanks,

Ray

>> ---
>>   drivers/pci/controller/pcie-iproc-platform.c | 24 ++++++++++++++++++
>>   drivers/pci/quirks.c                         | 26 --------------------
>>   2 files changed, 24 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
>> index ff0a81a632a1..4e6f7cdd9a25 100644
>> --- a/drivers/pci/controller/pcie-iproc-platform.c
>> +++ b/drivers/pci/controller/pcie-iproc-platform.c
>> @@ -19,6 +19,30 @@
>>   #include "../pci.h"
>>   #include "pcie-iproc.h"
>>   
>> +static void quirk_paxc_bridge(struct pci_dev *pdev)
>> +{
>> +	/*
>> +	 * The PCI config space is shared with the PAXC root port and the first
>> +	 * Ethernet device.  So, we need to workaround this by telling the PCI
>> +	 * code that the bridge is not an Ethernet device.
>> +	 */
>> +	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
>> +		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
>> +
>> +	/*
>> +	 * MPSS is not being set properly (as it is currently 0).  This is
>> +	 * because that area of the PCI config space is hard coded to zero, and
>> +	 * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
>> +	 * so that the MPS can be set to the real max value.
>> +	 */
>> +	pdev->pcie_mpss = 2;
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
>> +
>>   static const struct of_device_id iproc_pcie_of_match_table[] = {
>>   	{
>>   		.compatible = "brcm,iproc-pcie",
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 4937a088d7d8..202837ed68c9 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2381,32 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
>>   			 PCI_DEVICE_ID_TIGON3_5719,
>>   			 quirk_brcm_5719_limit_mrrs);
>>   
>> -#ifdef CONFIG_PCIE_IPROC_PLATFORM
>> -static void quirk_paxc_bridge(struct pci_dev *pdev)
>> -{
>> -	/*
>> -	 * The PCI config space is shared with the PAXC root port and the first
>> -	 * Ethernet device.  So, we need to workaround this by telling the PCI
>> -	 * code that the bridge is not an Ethernet device.
>> -	 */
>> -	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
>> -		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
>> -
>> -	/*
>> -	 * MPSS is not being set properly (as it is currently 0).  This is
>> -	 * because that area of the PCI config space is hard coded to zero, and
>> -	 * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
>> -	 * so that the MPS can be set to the real max value.
>> -	 */
>> -	pdev->pcie_mpss = 2;
>> -}
>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
>> -#endif
>> -
>>   /*
>>    * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
>>    * hide device 6 which configures the overflow device access containing the
>> -- 
>> 2.20.1
>>
