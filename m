Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2B45C228
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfGARmA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 13:42:00 -0400
Received: from foss.arm.com ([217.140.110.172]:37878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbfGARmA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 13:42:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A200228;
        Mon,  1 Jul 2019 10:41:59 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155A33F703;
        Mon,  1 Jul 2019 10:41:57 -0700 (PDT)
Subject: Re: [PATCH v3 8/9] iommu/arm-smmu-v3: Add support for PCI ATS
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     zhongmiao@hisilicon.com, okaya@kernel.org, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, lenb@kernel.org
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
 <20190417182448.12382-9-jean-philippe.brucker@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7fcd5263-8a20-11cb-0c20-9fee35fe65c1@arm.com>
Date:   Mon, 1 Jul 2019 18:41:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417182448.12382-9-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean-Philippe,

I realise it's a bit late for a "review", but digging up the original 
patch seemed as good a place as any to raise this...

On 17/04/2019 19:24, Jean-Philippe Brucker wrote:
[...]
> @@ -1740,6 +1906,9 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>   
>   	master->domain = NULL;
>   	arm_smmu_install_ste_for_dev(master);
> +
> +	/* Disabling ATS invalidates all ATC entries */
> +	arm_smmu_disable_ats(master);
>   }

Is that actually true? I had initially overlooked this entirely while 
diagnosing something else and thought that we were missing any ATC 
invalidation on detach at all, but even having looked again I'm not 
entirely convinced it's bulletproof.

Firstly, the ATS spec only seems to say that *enabling* the ATS 
capability invalidates all ATC entries, although I think any corner 
cases that that alone opens up should be at best theoretical. More 
importantly though, pci_disable_ats() might not actually touch the 
capability - given that, it seems possible to move a VF to a new domain, 
and if it's not reset, end up preserving now-bogus ATC entries despite 
the old domain being torn down and freed. Do we need an explicit ATC 
invalidation here to be 100% safe, or is there something else I'm missing?

Robin.
