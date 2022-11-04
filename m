Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205EE619E5C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 18:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiKDRVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 13:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiKDRVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 13:21:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B2D4199D
        for <linux-pci@vger.kernel.org>; Fri,  4 Nov 2022 10:20:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso5089589pjc.5
        for <linux-pci@vger.kernel.org>; Fri, 04 Nov 2022 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OczEUwDaDCJagzs0QtMr8aHYN/ko8ymZX7lVummJVOs=;
        b=uAw80S9vBEJp3aHojoMEpA/68sS1rwm2/DWeE+ULXnA6VihFLM1tIcWa71PfRN9kBY
         0Dv2ncNI3cIHP1goXyeXZom0/uBfoDaO30ASdZEL4aGfHRhvJUIMCG8nrQlvfooqmoJO
         hUAuGLtFkFgLnDesYbOIb/h2RG1W4Vfgffao9TGfEveZhdIZofkxgjiB9PJaysiRvxez
         qh27EMHRn8B9dhv5bFV0Gj3bOcrEvWTaLB9Ua8Lz3QnnrjBVMODvXVdUSprTVXviQ9hj
         D+qpWlXKArSY4d+JaCwNiIRypZgFLSZR3fDUcNuaeyz///hny0BZ0cHpkYlDAwWb4Z7k
         HJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OczEUwDaDCJagzs0QtMr8aHYN/ko8ymZX7lVummJVOs=;
        b=qtjQcZlmB58QQ40Oszp/wt5gBBVhnSDUXCsIziIrNkm/RGG33MVE3f2U94gdp3CqWx
         QEER2Sc60f5h5e0JL2szeMVtYFC987GvvaLLKY5TPdh+tlo4obbg0mhtII4X5oxHyJdB
         eQdo4TCDuItnW7Kgfi+o7tS60SU8g/JYrdr2AVyz+xzeh/HjjQ9ya39xfZ3EKbIEFrxL
         nUxswTPNx+jBHFLbryxuXd++DsDf9UztgiuWc58LVepOBHuRQJO459tfOpkpO+xN8Gmv
         Y61AnJNR4GWvRSWIGw0gNM5ldatyU/1+RbDK+iRCQLqwaGfACZ3ONqOHLOBtsaNlmBDW
         Qqdw==
X-Gm-Message-State: ACrzQf35oPJ0jc/mzr1AvJQa7mV0Kmk3aKK3Rf3aOljM1cFieCCzhM5F
        gc0noT/L199FEpGKgEtmaGGE3Q==
X-Google-Smtp-Source: AMsMyM7qXmb1tKLbXoG2RN7MYH+OBDKZmahcKO3ZgUlIGFzbY77VBHGSlWccWa4sVOHz9dNTYKbNgg==
X-Received: by 2002:a17:90a:6045:b0:212:fe9a:5792 with SMTP id h5-20020a17090a604500b00212fe9a5792mr53370678pjm.178.1667582458816;
        Fri, 04 Nov 2022 10:20:58 -0700 (PDT)
Received: from [10.255.167.72] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b0056e0ff577edsm2990000pfj.43.2022.11.04.10.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:20:58 -0700 (PDT)
Message-ID: <17b88750-53c2-0653-045a-dde921e37e0c@bytedance.com>
Date:   Sat, 5 Nov 2022 01:20:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v3 0/9] PCI/AER: Fix and optimize usage of status clearing
 api
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
Content-Language: en-US
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
In-Reply-To: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, a gentle reminder.

Thanks and regards.

On 9/28/22 6:59 PM, Zhuo Chen wrote:
> Hello.
> 
> Here comes patch v3, which contains some fixes and optimizations of
> aer api usage. The v1 and v2 can be found on the mailing list.
> 
> v3:
> - Modifications to comments proposed by Sathyanarayanan. Remove
>    pci_aer_clear_nonfatal_status() call in NTB and improve commit log.
> 
> v2:
> - Modifications to comments proposed by Bjorn. Split patch into more
>    obvious parts.
> 
> Zhuo Chen (9):
>    PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
>    PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear
>      uncorrectable error status
>    NTB: Remove pci_aer_clear_nonfatal_status() call
>    scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
>    PCI/AER: Unexport pci_aer_clear_nonfatal_status()
>    PCI/AER: Move check inside pcie_clear_device_status().
>    PCI/AER: Use pcie_aer_is_native() to judge whether OS owns AER
>    PCI/ERR: Clear fatal error status when pci_channel_io_frozen
>    PCI/AER: Refine status clearing process with api
> 
>   drivers/ntb/hw/idt/ntb_hw_idt.c |  2 --
>   drivers/pci/pci.c               |  7 +++--
>   drivers/pci/pci.h               |  2 ++
>   drivers/pci/pcie/aer.c          | 45 +++++++++++++++++++--------------
>   drivers/pci/pcie/dpc.c          |  3 +--
>   drivers/pci/pcie/err.c          | 15 ++++-------
>   drivers/pci/pcie/portdrv_core.c |  3 +--
>   drivers/scsi/lpfc/lpfc_attr.c   |  4 +--
>   include/linux/aer.h             |  4 +--
>   9 files changed, 44 insertions(+), 41 deletions(-)
> 

-- 
Zhuo Chen
