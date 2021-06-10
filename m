Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6DD3A2D26
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhFJNhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhFJNhL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 09:37:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13606C0617A6;
        Thu, 10 Jun 2021 06:35:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m7so1634337pfa.10;
        Thu, 10 Jun 2021 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=25QHYDZU/33GobJcVDtQ/GuUkx9D2Ms/u7IzN+8Cqkg=;
        b=IWtVLYEDFrwtyBXWN2I0UMn125oAptlDnMrRMYqy/T8Thb6CgZyjwUh9fks114+MF/
         w+g32AlBbaqXBjqvWJpbM0rA3L8lyq9VwBk+mrz9HpVH19Bs8Xj2wrw+tb2rwHOOq2EI
         DnO9b3YgmsMX6XAPbW/HdnN+dkkrpiIzPAzj+cf5+nlw+WUJlzIRT6s9E6kj6F5MqLDn
         svkN/JLoSzf9DpJHX4pbkPoDClYDrjKHiB3rsIKrrEWsw1c3Z81nsUE0xI4agGr4bKg1
         tVx/WcOnKi4o5z4D7fzb1na4/bhZZIuJJcZKRDED++zWGtG8sjRJjLphVlsY+dNzN1DO
         27TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=25QHYDZU/33GobJcVDtQ/GuUkx9D2Ms/u7IzN+8Cqkg=;
        b=Yt7cfLvF9MbHQOS/sqzecduJXsMjhP+K1+F2HitAl5F7YpoAQ+bGnf3aUEu1SS0Bz9
         5vHnc4HWy9Wtjg9+aCSR0+RHJ2IAkECrvYjcJck14wmuGl64HaRu7vv/2hyJj2e1DAt5
         JiHxXCs7sZ/NIyAnvH9tES69geql6JW7L8QTA43s9e+cauca29E26KcLy59JsBeIjeXq
         flUNFbrVo17pgOfXcRA0uFCUZ6UHGraJWpql3zvqe39Z3DylNzABaDv6qC1lCHlVNkXb
         C00DCbI3bmSnAO1xXBm6QuvmNThnctuvKyBx02DxdQzj7z+1iI1810lKEbKUvV+EtnlN
         iqIw==
X-Gm-Message-State: AOAM530btOy9XwIICaPb0Ne0S1fD2yghc/6CZ1P+1jdrwiTQuO76DUum
        EEI9guxRmmNqYf5VtcJGBs4=
X-Google-Smtp-Source: ABdhPJyhFxvLk1xekJg/Dy/pjyr0knLRFl07mRH6qfp7h73cB2pobMSsBT58W3WKwz/ziNQeFI8tHg==
X-Received: by 2002:a63:6c84:: with SMTP id h126mr5011352pgc.54.1623332100417;
        Thu, 10 Jun 2021 06:35:00 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id k15sm2473875pff.19.2021.06.10.06.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:34:59 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Leonardo Bras <leobras.c@gmail.com>
Subject: Re: [PATCH v3 1/4] PCI: of: Clear 64-bit flag for non-prefetchable
 memory below 4GB
References: <20210610002256.GA2680171@bjorn-Precision-5520>
Date:   Thu, 10 Jun 2021 22:34:56 +0900
In-Reply-To: <20210610002256.GA2680171@bjorn-Precision-5520> (Bjorn Helgaas's
        message of "Wed, 9 Jun 2021 19:22:56 -0500")
Message-ID: <875yyllu67.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:

> [+cc Leonardo]
>
> On Mon, Jun 07, 2021 at 08:28:53PM +0900, Punit Agrawal wrote:
>> Some host bridges advertise non-prefetchable memory windows that are
>> entirely located below 4GB but are marked as 64-bit address memory.
>> 
>> Since commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
>> flags for 64-bit memory addresses"), the OF PCI range parser takes a
>> stricter view and treats 64-bit address ranges as advertised while
>> before such ranges were treated as 32-bit.
>> 
>> A PCI root port modelled as a PCI-to-PCI bridge cannot forward 64-bit
>> non-prefetchable memory ranges. As a result, the change in behaviour
>> due to the commit causes failure to allocate 32-bit BAR from a 64-bit
>> non-prefetchable window.
>> 
>> In order to not break platforms where non-prefetchable memory ranges
>> lie entirely below 4GB, clear the 64-bit flag.
>
> I don't think we should care about the address width DT supplies for a
> host bridge window.  Prior to 9d57e61bf723, I don't think we *did*
> care because of_bus_pci_get_flags() threw away that information.
>
> My proposal for a commit log, including information about the problem
> report and a "Fixes:" tag:
>
>   Alexandru and Qu reported this resource allocation failure on
>   ROCKPro64 v2 and ROCK Pi 4B, both based on the RK3399:
>
>     pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
>     pci 0000:00:00.0: PCI bridge to [bus 01]
>     pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
>     pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
>
>   "BAR 14" is the PCI bridge's 32-bit non-prefetchable window, and our
>   PCI allocation code isn't smart enough to allocate it in a host
>   bridge window marked as 64-bit, even though this should work fine.
>
>   A DT host bridge description includes the windows from the CPU
>   address space to the PCI bus space.  On a few architectures
>   (microblaze, powerpc, sparc), the DT may also describe PCI devices
>   themselves, including their BARs.
>
>   Before 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
>   flags for 64-bit memory addresses"), of_bus_pci_get_flags() ignored
>   the fact that some DT addresses described 64-bit windows and BARs.
>   That was a problem because the virtio virtual NIC has a 32-bit BAR
>   and a 64-bit BAR, and the driver couldn't distinguish them.

Many thanks for demystifying the motivation for 9d57e61bf723. Not being
familiar with the usage of DT to describe PCI devices I was missing this
context.

>   9d57e61bf723 set IORESOURCE_MEM_64 for those 64-bit DT ranges, which
>   fixed the virtio driver.  But it also set IORESOURCE_MEM_64 for host
>   bridge windows, which exposed the fact that the PCI allocator isn't
>   smart enough to put 32-bit resources in those 64-bit windows.
>
>   Clear IORESOURCE_MEM_64 from host bridge windows since we don't need
>   that information.
>
>   Fixes: 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
>   Reported-at: https://lore.kernel.org/lkml/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com/
>   Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
>   Reported-by: Qu Wenruo <wqu@suse.com>

Thank you for commit log - without all the pieces I was struggling to
clearly describe the details. And I missed the appropriate tags as
well. I've updated the commit log based on your suggestion.

>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
>> Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> ---
>>  drivers/pci/of.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 85dcb7097da4..1e45186a5715 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -353,6 +353,14 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>>  				dev_warn(dev, "More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
>>  					 dev_node);
>>  			*io_base = range.cpu_addr;
>> +		} else if (resource_type(res) == IORESOURCE_MEM) {
>> +			if (!(res->flags & IORESOURCE_PREFETCH)) {
>> +				if (res->flags & IORESOURCE_MEM_64)
>> +					if (!upper_32_bits(range.pci_addr + range.size - 1)) {
>> +						dev_warn(dev, "Clearing 64-bit flag for non-prefetchable memory below 4GB\n");
>> +						res->flags &= ~IORESOURCE_MEM_64;
>> +					}
>> +			}
>
> Why do we need to check IORESOURCE_PREFETCH, IORESOURCE_MEM_64, and
> upper_32_bits()?  If I understand this correctly, prior to
> 9d57e61bf723, IORESOURCE_MEM_64 was *never* set here.  Isn't something
> like this sufficient?
>
>   } else if (resource_type(res) == IORESOURCE_MEM) {
>     res->flags &= ~IORESOURCE_MEM_64;
>   }

Based on the discussion in the original thread[0], I was working with
the assumption that we don't want to lose the IORESOURCE_MEM_64 flag
other than in the problem scenario, i.e., non-prefetchable memory below
4GB.

You suggestion is simpler and also solves the issue by effectively
reverting the impact of 9d57e61bf723 on BAR allocation. If there are no
objections I will take this approach for the next update.

To aid future readers I will also add the following comment -

    /*
     * PCI allocation cannot correctly allocate 32-bit non-prefetchable BAR
     * in host bridge windows marked as 64-bit.
     */

> I'm not sure we need a warning either.  We didn't warn before
> 9d57e61bf723, and there's nothing the user needs to do anyway.

The warning was a nudge (probably too subtle) to get the user to upgrade
their DT to drop the 64-bit marker on the host bridge window. With your
suggestion, the DT change is not needed anymore - though it may still be
worth dropping the 64-bit marker.

Thanks,
Punit

[0] https://lore.kernel.org/linux-pci/CAMj1kXGF_JmuZ+rRA55-NrTQ6f20fhcHc=62AGJ71eHNU8AoBQ@mail.gmail.com/
