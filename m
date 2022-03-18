Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ABC4DE285
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 21:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiCRU3p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 16:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbiCRU3n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 16:29:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF6128E34A;
        Fri, 18 Mar 2022 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647635303; x=1679171303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bYWaejF1aAGMIe6zGaNynSygYXsQ9N7J6Zt5R6d87uw=;
  b=JZaJgVyeAsZJaMHs6y+DmuL9ofccna6Lp/0Wyms43oLEROF+DwKK6CkA
   jpblwA1Dl/DX0jmaZra6LIInQh+sU/MQLaDzW32kKut4C9AZrlzu0SsU6
   Ut4Aqe4PUJjWDxr1JBCtOWMNsCN7AEHMAuue9XRjEKj2TJt1VBluHt36W
   GvGKBnu0zZ7YNtz0YZsuBvK6YmwPzpqqUft/j2KqUHrjhuhOgM8LnjXR5
   WlyJJJDXZSLK6h57MRqCsdjiKD/N1nDuvehtNXu+9NnVfJ+xIy0akgGys
   KqGCkt6qAzcwroF7CjOMnPnyRMUu2gnmcjxD813Dm734FMGEf8Gia2BDg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="320425631"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="320425631"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 13:28:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558633118"
Received: from reaganlo-mobl.amr.corp.intel.com (HELO [10.212.159.210]) ([10.212.159.210])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 13:28:17 -0700
Message-ID: <fca6704b-686a-e478-03bb-091337162e02@linux.intel.com>
Date:   Fri, 18 Mar 2022 13:28:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v1] PCI/AER: Handle Multi UnCorrectable/Correctable errors
 properly
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Eric Badger <ebadger@purestorage.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20220317225944.GA765564@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220317225944.GA765564@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/17/22 3:59 PM, Bjorn Helgaas wrote:
> Thanks for the additional details!
> 
> After this patch, I guess aer_irq() still reads 0x2
> (PCI_ERR_ROOT_MULTI_COR_RCV), but now it writes 0x2 back which clears
> PCI_ERR_ROOT_MULTI_COR_RCV.
> 
> In addition, aer_irq() will continue on to read PCI_ERR_ROOT_ERR_SRC,
> which probably contains either 0 or junk left over from being captured
> when PCI_ERR_ROOT_COR_RCV was set.
> 
> And aer_irq() will queue an e_src record with status ==
> PCI_ERR_ROOT_MULTI_COR_RCV.  But since PCI_ERR_ROOT_COR_RCV is not set
> in status, aer_isr_one_error() will do nothing, right?
> 
> That might not be*terrible*  and is definitely better than not being
> able to handle future interrupts.  But we basically threw away the
> information that multiple errors occurred, and we queued an e_src
> record that occupies space without being used for anything.

Yes, you are correct.  One other way to minimize this race window is to
clear the Root status register as soon as possible. Maybe we can move
it before source ID read as below.

--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1204,8 +1204,8 @@ static irqreturn_t aer_irq(int irq, void *context)
         if (!(e_src.status & AER_ERR_STATUS_MASK))
                 return IRQ_NONE;

-       pci_read_config_dword(rp, aer + PCI_ERR_ROOT_ERR_SRC, &e_src.id);
         pci_write_config_dword(rp, aer + PCI_ERR_ROOT_STATUS, 
e_src.status);
+       pci_read_config_dword(rp, aer + PCI_ERR_ROOT_ERR_SRC, &e_src.id)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
