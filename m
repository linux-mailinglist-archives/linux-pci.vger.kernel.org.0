Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4B487B54
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 18:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348563AbiAGRXk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 12:23:40 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:57422 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348558AbiAGRXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 12:23:39 -0500
Received: from [192.168.1.18] ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5sxancGFrwEZf5sxgnfr6r; Fri, 07 Jan 2022 18:23:36 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 07 Jan 2022 18:23:36 +0100
X-ME-IP: 90.11.185.88
Message-ID: <cfabcc1c-16cd-80f7-7d28-6d817c29a7a0@wanadoo.fr>
Date:   Fri, 7 Jan 2022 18:23:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 16/16] PCI: Remove usage of the deprecated
 "pci-dma-compat.h" API
Content-Language: en-US
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <e965573211f8c81c8ba978cfbc21925810a662b1.1641500561.git.christophe.jaillet@wanadoo.fr>
 <20220106222804.GA330366@bhelgaas>
 <0e381699-8bfa-186b-3688-5346e42a63cd@wanadoo.fr>
In-Reply-To: <0e381699-8bfa-186b-3688-5346e42a63cd@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Le 07/01/2022 à 07:34, Christophe JAILLET a écrit :
> Le 06/01/2022 à 23:28, Bjorn Helgaas a écrit :
>> On Thu, Jan 06, 2022 at 10:55:33PM +0100, Christophe JAILLET wrote:
>>> Final step, remove pci-dma-compat.h
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Obviously this has to be applied after all the others, so I assume
>> somebody else will take this.
>>
>>> ---
>>>   include/linux/pci-dma-compat.h | 129 ---------------------------------
>>>   include/linux/pci.h            |   3 -
>>>   2 files changed, 132 deletions(-)
>>>   delete mode 100644 include/linux/pci-dma-compat.h
>>>
>>> diff --git a/include/linux/pci-dma-compat.h 
>>> b/include/linux/pci-dma-compat.h
>>> deleted file mode 100644
>>> index 249d4d7fbf18..000000000000
>>> --- a/include/linux/pci-dma-compat.h
>>> +++ /dev/null
>>> @@ -1,129 +0,0 @@
>>> -/* SPDX-License-Identifier: GPL-2.0 */
>>> -/* include this file if the platform implements the dma_ DMA Mapping 
>>> API
>>> - * and wants to provide the pci_ DMA Mapping API in terms of it */
>>> -
>>> -#ifndef _ASM_GENERIC_PCI_DMA_COMPAT_H
>>> -#define _ASM_GENERIC_PCI_DMA_COMPAT_H
>>> -
>>> -#include <linux/dma-mapping.h>
>>> -
>>> [...]
>>>  >>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index d4308f847e58..ba8771eaf380 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -2455,9 +2455,6 @@ static inline bool 
>>> pci_is_thunderbolt_attached(struct pci_dev *pdev)
>>>   void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result 
>>> err_type);
>>>   #endif
>>> -/* Provide the legacy pci_dma_* API */
>>> -#include <linux/pci-dma-compat.h>
>>> -
> 
> After one more night, I should have mentionned that the way have removed 
> "pci-dma-compat.h" may break OTHER drives because of indirect include.
> 
> The line above should maybe be replaced by:
>    #include <linux/dma-mapping.h>
> which is hidden in "pci-dma-compat.h".
> 
> Will see if built-bots complain.

And so they did.

What is the best option?
1. Add    #include <linux/dma-mapping.h>?		or
2. Add this "missing" include in needed place?

I would say 2, but I would need help, because I don't have a built farm 
at home! :)



This breaks:

    drivers/s390/net/ism_drv.c: In function 'register_sba':
    drivers/s390/net/ism_drv.c:93:15: error: implicit declaration of 
function 'dma_alloc_coherent' [-Werror=implicit-function-declaration]
       93 |         sba = dma_alloc_coherent(&ism->pdev->dev, PAGE_SIZE, 
&dma_handle,
          |               ^~~~~~~~~~~~~~~~~~
[...]



I got another built failure that I don't understand:

    In file included from drivers/scsi/fdomain.c:87:
 >> include/scsi/scsicam.h:16:31: warning: 'struct block_device' 
declared inside parameter list will not be visible outside of this 
definition or declaration
       16 | int scsicam_bios_param(struct block_device *bdev, sector_t 
capacity, int *ip);
          |                               ^~~~~~~~~~~~
    include/scsi/scsicam.h:17:27: warning: 'struct block_device' 
declared inside parameter list will not be visible outside of this 
definition or declaration
       17 | bool scsi_partsize(struct block_device *bdev, sector_t 
capacity, int geom[3]);
          |                           ^~~~~~~~~~~~
    include/scsi/scsicam.h:18:40: warning: 'struct block_device' 
declared inside parameter list will not be visible outside of this 
definition or declaration
       18 | unsigned char *scsi_bios_ptable(struct block_device *bdev);
          |                                        ^~~~~~~~~~~~
    drivers/scsi/fdomain.c: In function 'fdomain_biosparam':
 >> drivers/scsi/fdomain.c:468:45: error: passing argument 1 of 
'scsi_bios_ptable' from incompatible pointer type 
[-Werror=incompatible-pointer-types]
      468 |         unsigned char *p = scsi_bios_ptable(bdev);
          |                                             ^~~~
          |                                             |
          |                                             struct 
block_device *
    In file included from drivers/scsi/fdomain.c:87:
    include/scsi/scsicam.h:18:54: note: expected 'struct block_device *' 
but argument is of type 'struct block_device *'
       18 | unsigned char *scsi_bios_ptable(struct block_device *bdev);
          |                                 ~~~~~~~~~~~~~~~~~~~~~^~~~


CJ
