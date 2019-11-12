Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F78F8D41
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 11:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfKLKuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 05:50:16 -0500
Received: from ozlabs.org ([203.11.71.1]:36799 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKLKuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 05:50:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47C4Jj58Swz9sPV;
        Tue, 12 Nov 2019 21:50:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573555813;
        bh=F4zIi7Ev9vWkeY7yqeo1rh9T8D/ad0kk2nzZVQFOXc0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pXnLlq5/EqRZ0L4exvsIpDEfbr1olj6uQ6V7p50H98drEMBG7EoQkhYDkxDO65F4L
         mwY4+LR38hyfwayTsz9OwpkH4eJrkpQmObJfknseCefs+AzWr6GEFSi5fO4CLClQVt
         RTleZxf+l2Atmlgk9s9wcjskbMQ2EZhTmYbp48oRWwkP6GXa8F1AQj4OC03vO79r5D
         UAzq2X8NjASLpfEOFZNFiUhSMq6GkCVWNSbFYYOJSmNQJ4ZSVV4NvvGfrYTqSHhpF1
         OJJdX/RmKm8aFqo+FknHLX+2FHKzkAR3b1jytp+xFOnkzzTPaBqF2O9vUBMUFK2aB4
         dSBmmaNIzwiTQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        tlfalcon@linux.ibm.com, nathanl@linux.ibm.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Fixes and Enablement of ibm,drc-info property
In-Reply-To: <20191111194928.GA38342@google.com>
References: <20191111194928.GA38342@google.com>
Date:   Tue, 12 Nov 2019 21:50:13 +1100
Message-ID: <877e452wt6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Sun, Nov 10, 2019 at 11:21:27PM -0600, Tyrel Datwyler wrote:
>> There was a previous effort to add support for the PAPR
>> architected ibm,drc-info property. This property provides a more
>> memory compact representation of a parition's Dynamic Reconfig
>> Connectors (DRC). These can otherwise be thought of as currently
>> partitioned, or available but yet to be partitioned system resources
>> such as cpus, memory, and physical/logical IOA devices.
>> 
>> The initial implementation proved buggy and was fully turned off by
>> disabling the bit in the appropriate CAS support vector. We now have
>> PowerVM firmware in the field that supports this new property, and
>> further to support partitions with 24TB+ of possible memory this
>> property is required to perform platform migration.
>> 
>> This series fixs the short comings of the previous submission
>> in the areas of general implementation, cpu hotplug, and IOA hotplug.
>> 
>> v2 changelog:
>> 	Cover Letter: fixed up spelling errors (mpe, tfalcon)
>> 	Patch 3: added comment regarding indexing of drc values (tfalcon)
>> 		 split drc-index and drc-info logic into multiple
>> 		 functions for collecting cpu drc's for dlpar (mpe)
>> 	Patch 7: fix up a couple more sparse warnings (mpe)
>> 
>> Tyrel Datwyler (9):
>>   powerpc/pseries: Fix bad drc_index_start value parsing of drc-info
>>     entry
>>   powerpc/pseries: Fix drc-info mappings of logical cpus to drc-index
>>   powerpc/pseries: Add cpu DLPAR support for drc-info property
>>   PCI: rpaphp: Fix up pointer to first drc-info entry
>>   PCI: rpaphp: Don't rely on firmware feature to imply drc-info support
>>   PCI: rpaphp: Add drc-info support for hotplug slot registration
>>   PCI: rpaphp: Annotate and correctly byte swap DRC properties
>>   PCI: rpaphp: Correctly match ibm,my-drc-index to drc-name when using
>>     drc-info
>>   powerpc/pseries: Enable support for ibm,drc-info property
>> 
>>  arch/powerpc/kernel/prom_init.c                 |   2 +-
>>  arch/powerpc/platforms/pseries/hotplug-cpu.c    | 127 +++++++++++++++++++++---
>>  arch/powerpc/platforms/pseries/of_helpers.c     |   8 +-
>>  arch/powerpc/platforms/pseries/pseries_energy.c |  23 ++---
>>  drivers/pci/hotplug/rpaphp_core.c               | 127 +++++++++++++++++-------
>
> For the drivers/pci/* parts:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I added it to the PCI touching patches.

> I assume they will be merged along with the rest of the series via
> powerpc.

Yep. Thanks for the review.

cheers
