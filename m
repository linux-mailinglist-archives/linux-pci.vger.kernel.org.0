Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12EA65D23C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2019 16:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfGBO7q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 10:59:46 -0400
Received: from foss.arm.com ([217.140.110.172]:51348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfGBO7q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 10:59:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A1821424;
        Tue,  2 Jul 2019 07:59:45 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FE533F703;
        Tue,  2 Jul 2019 07:59:43 -0700 (PDT)
Subject: Re: [PATCH v3 8/9] iommu/arm-smmu-v3: Add support for PCI ATS
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     "zhongmiao@hisilicon.com" <zhongmiao@hisilicon.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "lenb@kernel.org" <lenb@kernel.org>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
 <20190417182448.12382-9-jean-philippe.brucker@arm.com>
 <7fcd5263-8a20-11cb-0c20-9fee35fe65c1@arm.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <433038b1-048b-57ab-db0e-5f9f940d52ce@arm.com>
Date:   Tue, 2 Jul 2019 15:59:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7fcd5263-8a20-11cb-0c20-9fee35fe65c1@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01/07/2019 18:41, Robin Murphy wrote:
> Hi Jean-Philippe,
> 
> I realise it's a bit late for a "review", but digging up the original 
> patch seemed as good a place as any to raise this...
> 
> On 17/04/2019 19:24, Jean-Philippe Brucker wrote:
> [...]
>> @@ -1740,6 +1906,9 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>>   
>>   	master->domain = NULL;
>>   	arm_smmu_install_ste_for_dev(master);
>> +
>> +	/* Disabling ATS invalidates all ATC entries */
>> +	arm_smmu_disable_ats(master);
>>   }
> 
> Is that actually true? I had initially overlooked this entirely while 
> diagnosing something else and thought that we were missing any ATC 
> invalidation on detach at all, but even having looked again I'm not 
> entirely convinced it's bulletproof.
> 
> Firstly, the ATS spec only seems to say that *enabling* the ATS 
> capability invalidates all ATC entries, although I think any corner 
> cases that that alone opens up should be at best theoretical. More 
> importantly though, pci_disable_ats() might not actually touch the 
> capability - given that, it seems possible to move a VF to a new domain, 
> and if it's not reset, end up preserving now-bogus ATC entries despite 
> the old domain being torn down and freed. Do we need an explicit ATC 
> invalidation here to be 100% safe, or is there something else I'm missing?

Good points, yes the comment is wrong and it looks like we need an
explicit invalidation given the current pci_disable_ats()
implementation. I'll send a fix shortly.

Thanks,
Jean
