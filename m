Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2A3119FFC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 01:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLKA2y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 19:28:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54676 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLKA2x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2019 19:28:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so5162598wmj.4
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2019 16:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3sW7gMU+F2b+xwZQKgKI5q/o9LTsi7O+qOH9Fp9a4jI=;
        b=IT2ZaEahG6H5AixZzI/cIlgTeAMPRFxydq1a3QVCfyEH98licRgpPwwnp5LOyGyaTV
         QTgzBtgsmtlo8aZhTsZX1JXGbYHQrtkUfCXRXHGPjRGxq8vZdSv8DCxECV5OVHFO/PQE
         3ZgIadvFvBAw2wBKN7ZXkty60A0IcG1wgU6MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3sW7gMU+F2b+xwZQKgKI5q/o9LTsi7O+qOH9Fp9a4jI=;
        b=Vw204eA6bI//hEm9q/za6NCP7CXNfiKu7krbGPt48FW7JsSkuh1IfTqH5OY4hF+sev
         xG8zJFG47oZDkPALnABmm1ghHe8f1jMyp5fk8gXhFzNv0gfJGse6Ab+sNF7m63fkk+CX
         DvJM2hIvZ5YeAaEN3djH/jKbc9HFq61smPDysRSwroepfp6PN6J9sBUMuMR8dZiSrrr8
         41buAFj7Hw7x8vrbWmcJg18uTH+tCL0HsCU0z/Grcce9FfrjD4mqzzGggjuGqd7ZXmrE
         ZdnmGGDsD+1vQf/wSIu3BMaa5WiyD8aP0pBaQ3MUxsVQgemZpD1Pb/XqWF3WVYB1Krel
         UmJA==
X-Gm-Message-State: APjAAAXFtmOzaY94k3iSqe8UW8ft5OTG+qmJlr1nTILnMb6Mi36QTUAv
        icOl5tQGdPdGdgzBHnf+I6XBkQ==
X-Google-Smtp-Source: APXvYqwVGEWNNKfe8z13WODiiBovExaSLFk25Zjz/qyQ7H0+RSSoHPEh5W8IygN4McDjUHlvQSbXYw==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr110743wmj.41.1576024132427;
        Tue, 10 Dec 2019 16:28:52 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g23sm285024wmk.14.2019.12.10.16.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 16:28:51 -0800 (PST)
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
To:     Bjorn Helgaas <helgaas@kernel.org>, Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org, rjui@broadcom.com
References: <20191211000932.GA178707@google.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <8d3b9565-1426-20a8-4982-c680001bbbbf@broadcom.com>
Date:   Tue, 10 Dec 2019 16:28:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211000932.GA178707@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/10/19 4:09 PM, Bjorn Helgaas wrote:
> On Fri, Nov 15, 2019 at 01:58:42PM +0000, Wei Liu wrote:
>> CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
>> in.  Removing the ifdef will allow us to build the driver as a module.
>>
>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
>> ---
>> Alternatively, we can change the condition to:
>>
>>    #ifdef CONFIG_PCIE_IPROC_PLATFORM || CONFIG_PCIE_IPROC_PLATFORM_MODULE
>> .
>>
>> I chose to remove the ifdef because that's what other quirks looked like
>> in this file.
>> ---
>>   drivers/pci/quirks.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 320255e5e8f8..cd0e7c18e717 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2381,7 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
>>   			 PCI_DEVICE_ID_TIGON3_5719,
>>   			 quirk_brcm_5719_limit_mrrs);
>>   
>> -#ifdef CONFIG_PCIE_IPROC_PLATFORM
>>   static void quirk_paxc_bridge(struct pci_dev *pdev)
>>   {
>>   	/*
>> @@ -2405,7 +2404,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
>> -#endif
> 
> Is there a reason this quirk can't be moved to
> drivers/pci/controller/pcie-iproc-platform.c?  That would make it much
> less subtle because it would be compiled if and only if the driver
> itself is compiled.
> 
> If it needs to be here in quirks.c, please include a note about the
> reason.
> 

There's no particular reason and yes it could be moved to pcie-iproc.c.

If that's preferred (and it sounds like it is) then we can do that.

Thanks,

Ray

>>   /*
>>    * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
>> -- 
>> 2.24.0
>>
