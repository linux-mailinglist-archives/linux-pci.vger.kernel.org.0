Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E478C524187
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 02:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349664AbiELA3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 20:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349655AbiELA3t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 20:29:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68F11A90D9;
        Wed, 11 May 2022 17:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652315388; x=1683851388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QVmwNynkT04gSDeDkYvO4d7kGnKP1A1Q5Qz1j6zm5lk=;
  b=NC5miKZ91AejrLui23NrzpXvZrOXwhojnV6iBkH6q7l0y8mgD67hi/zt
   TR0NV4AAsnAaNSo0h7Oyp+KkHJ+uYIDj/AZ6VgddE3tGfcOarGMj3WH+e
   q+JyxCqUVlXgnNpTI1RJNvTpSeBqbukHSmM+z7aUjDQTvxKJLyFWcnt6z
   P5rMjyUkjanRq1a+RYBGUYlGZgqxybwQUZQZf0My2iyaNiZYu87/giXR/
   F+kio9BuGrOXMv+GHVjY5CBypUaFRonCrmFEi3pL5Nb00/6VpWGpSXoJp
   iRSvwfJ70AmVThqBqxaMs3AV4gE35oE/aEqNnRCTGFEvA++tRktJPAiXM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="268683462"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="268683462"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:29:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="572305211"
Received: from wancheny-mobl.amr.corp.intel.com (HELO [10.209.114.21]) ([10.209.114.21])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:29:47 -0700
Message-ID: <54ab824c-44a9-239a-9380-2f051f26a079@linux.intel.com>
Date:   Wed, 11 May 2022 17:29:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3] PCI/AER: Handle Multi UnCorrectable/Correctable errors
 properly
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220511234024.GA831116@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220511234024.GA831116@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/11/22 4:40 PM, Bjorn Helgaas wrote:
> On Mon, Apr 18, 2022 at 03:02:37PM +0000, Kuppuswamy Sathyanarayanan wrote:
>> Currently the aer_irq() handler returns IRQ_NONE for cases without bits
>> PCI_ERR_ROOT_UNCOR_RCV or PCI_ERR_ROOT_COR_RCV are set. But this
>> assumption is incorrect.
>>
>> Consider a scenario where aer_irq() is triggered for a correctable
>> error, and while we process the error and before we clear the error
>> status in "Root Error Status" register, if the same kind of error
>> is triggered again, since aer_irq() only clears events it saw, the
>> multi-bit error is left in tact. This will cause the interrupt to fire
>> again, resulting in entering aer_irq() with just the multi-bit error
>> logged in the "Root Error Status" register.
>>
>> Repeated AER recovery test has revealed this condition does happen
>> and this prevents any new interrupt from being triggered. Allow to
>> process interrupt even if only multi-correctable (BIT 1) or
>> multi-uncorrectable bit (BIT 3) is set.
>>
>> Also note that, for cases with only multi-bit error is set, since this
>> is not the first occurrence of the error, PCI_ERR_ROOT_ERR_SRC may have
>> zero or some junk value. So we cannot cleanly process this error
>> information using aer_isr_one_error(). All we are attempting with this
>> fix is to make sure error interrupt processing can continue in this
>> scenario.
>>
>> This error can be reproduced by making following changes to the
>> aer_irq() function and by executing the given test commands.
>>
>>   static irqreturn_t aer_irq(int irq, void *context)
>>           struct aer_err_source e_src = {};
>>
>>           pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS,
>> 				&e_src.status);
>>   +       pci_dbg(pdev->port, "Root Error Status: %04x\n",
>>   +		e_src.status);
>>           if (!(e_src.status & AER_ERR_STATUS_MASK))
> 
> Do you mean
> 
>    if (!(e_src.status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV)))
> 
> here?  AER_ERR_STATUS_MASK would be after this fix.

Yes. You are correct. Do you want me to update it and Fixes tag
and send next version?

> 
>>                   return IRQ_NONE;
>>
>>   +       mdelay(5000);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
