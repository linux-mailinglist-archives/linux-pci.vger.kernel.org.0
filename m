Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FC3637829
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 12:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiKXLzu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 06:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiKXLzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 06:55:49 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95939C6218
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 03:55:48 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b11so1219299pjp.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 03:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tFoaZJ9Zngdk5YXFm9CRQu0l0Dt7f+Q0OVbqus0B9g=;
        b=Szq1aC9Wra2IsZFqObHsGmeRI22JZDC77KB/fn/y5FDl1j/mH9t1bt2oRO2s/VsJg7
         7++YyfrZAapEEDfLW0AwNAOxQj2JqhfS2eyYXsf83BRjBsaGqzALFQUn9U/JszeJRktf
         4HqbJk+4e6lzOTNxBu3E14KsUMxicRA6V93jEnLg9JNNLXUcDSEIbwXmlHdBRVR0b9IJ
         89QLi93nA9G6E7Cy9sfDxGpbYmsM/TtKM6qMLLLbwwcP7FdsCcg8PzWXqNKRVlzBaN7s
         zesRFiiIFCpF7es4an9DB8E4QRu/X6DYVBbH4mUAbiePl2Xh9xTnkMT+Js/iC/OTZk0z
         LILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tFoaZJ9Zngdk5YXFm9CRQu0l0Dt7f+Q0OVbqus0B9g=;
        b=gxBV+0Z0TFjYRqgilIwCkuAHjYGhEF6Ag60x9lb/FDYB9aWRwyC41wuM0rTr084w8Y
         u3qOzQmqN+G9OOfWPa7njmACBu6+XvdKO6rBwSBMywD0O36ecnF6Ug8xllQResvCoybf
         ROkfhLNT2JWDv1BCXE701BUxe7hNqYr6uRyQcDDIOP5zWsFzk+80oPiJV4U4ggw4psjy
         eNB503q7PMVLt9cZqE/vtLNGueN4Ab9TphzXcVnzj2LHIGmXk5jW3sKiLHdEPR4w9uum
         J6OGN8FawIxPQhZH49xslKPhQXzuAJLyATcVM7fWUPbTDsiH+ViB5wfY3ykpAyICF5Ys
         m0Cg==
X-Gm-Message-State: ANoB5plOtbTb9Llpa/7dnoiBZnqDGs74KtXQooxT2BIHrMN1GPnWFMJS
        0vdaNs5LJtBxg3lT9eebk3pR+jHjRy8KOg==
X-Google-Smtp-Source: AA0mqf5ErK/yTLbHh6wS925owcGQFojLs0Qt5kfkDM8yW/n5AlgaTkNUM7UboZPZKsKTOdXfrMbQOA==
X-Received: by 2002:a17:902:e294:b0:17c:620f:13ac with SMTP id o20-20020a170902e29400b0017c620f13acmr16312497plc.9.1669290948065;
        Thu, 24 Nov 2022 03:55:48 -0800 (PST)
Received: from [10.255.190.159] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b0018685257c0dsm1139212plb.58.2022.11.24.03.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:55:47 -0800 (PST)
Message-ID: <af5c0fb7-0de7-7ca4-4dab-16f41e1d8ec6@bytedance.com>
Date:   Thu, 24 Nov 2022 19:55:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v3 0/9] PCI/AER: Fix and optimize usage of status clearing
 api
Content-Language: en-US
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
 <17b88750-53c2-0653-045a-dde921e37e0c@bytedance.com>
In-Reply-To: <17b88750-53c2-0653-045a-dde921e37e0c@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Ping. Gentle reminder


On 11/5/22 1:20 AM, Zhuo Chen wrote:
> Hi Bjorn, a gentle reminder.
> 
> Thanks and regards.
> 
> On 9/28/22 6:59 PM, Zhuo Chen wrote:
>> Hello.
>>
>> Here comes patch v3, which contains some fixes and optimizations of
>> aer api usage. The v1 and v2 can be found on the mailing list.
>>
>> v3:
>> - Modifications to comments proposed by Sathyanarayanan. Remove
>>    pci_aer_clear_nonfatal_status() call in NTB and improve commit log.
>>
>> v2:
>> - Modifications to comments proposed by Bjorn. Split patch into more
>>    obvious parts.
>>
>> Zhuo Chen (9):
>>    PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
>>    PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear
>>      uncorrectable error status
>>    NTB: Remove pci_aer_clear_nonfatal_status() call
>>    scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
>>    PCI/AER: Unexport pci_aer_clear_nonfatal_status()
>>    PCI/AER: Move check inside pcie_clear_device_status().
>>    PCI/AER: Use pcie_aer_is_native() to judge whether OS owns AER
>>    PCI/ERR: Clear fatal error status when pci_channel_io_frozen
>>    PCI/AER: Refine status clearing process with api
>>
>>   drivers/ntb/hw/idt/ntb_hw_idt.c |  2 --
>>   drivers/pci/pci.c               |  7 +++--
>>   drivers/pci/pci.h               |  2 ++
>>   drivers/pci/pcie/aer.c          | 45 +++++++++++++++++++--------------
>>   drivers/pci/pcie/dpc.c          |  3 +--
>>   drivers/pci/pcie/err.c          | 15 ++++-------
>>   drivers/pci/pcie/portdrv_core.c |  3 +--
>>   drivers/scsi/lpfc/lpfc_attr.c   |  4 +--
>>   include/linux/aer.h             |  4 +--
>>   9 files changed, 44 insertions(+), 41 deletions(-)
>>
> 

-- 
Zhuo Chen
