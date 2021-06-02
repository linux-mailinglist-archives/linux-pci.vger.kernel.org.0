Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F049C398ADD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 15:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFBNjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhFBNju (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 09:39:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94E9C061574;
        Wed,  2 Jun 2021 06:38:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y15so2170721pfn.13;
        Wed, 02 Jun 2021 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=f1v5FHYhbCvM3rkiC5mXWqe4jF0O7VDT+9Sw8nt4QrE=;
        b=la37kS2tGZ5wS+YOFc4ipjnpe4YfjPKArof4KNyXApYXdRMjeDnRkN16sya48NGrAr
         eWf1+DfUAZxLTCfGm8/uZdWj63+jPTcyRqkvZPRyAznfKPnSW1vJvfizzLydGXnpTrIB
         +IZC4EHJZIIOm+6CyF7x8b9tSWEN/R+a/Zi0PvQPLgehfZm3y1TpBpMsCUBrL0XtQEZA
         Uwbt/LT9cQHc4XF1Es6PlE5ld12hasixV2HIkVzIJNZVoUl5qFr/GlJp2tnsIDxy7aTe
         f7uSFNsW5XwD6Irz5m3lLrxFGx8X0DyIsbz+/ARI20OMKwO45YEJ8n6dF65uaZ0W4xOn
         PZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version;
        bh=f1v5FHYhbCvM3rkiC5mXWqe4jF0O7VDT+9Sw8nt4QrE=;
        b=dajjmGhlk7KlHIRcBvfZeIECtr4bGq6hI/1wQd9H0bKRLp2F20aJ1gmo/SkSNY1l2G
         vwCh4iU4UxpNCyFEKGwluYgyv8v5YZa6Us7PnIt1SKnO1/r25QW9/j43XYDBdGnaAOfC
         ULN3puOQNHPVwjNh1wNqRaq2SKbJsfldDFXSDlrH08FSYaKiy0mz+Kc00MUnMnJs0aN3
         6g8nL6cU72r/lOI6B3uGgsTx5hATRvZ2gAd8L4fBcCQlVg3t1xvjb5vcSY3ulABsRBiJ
         MncNKxm4ELMS3nG6ZZC7tT8cYsRzkrTJLjxb2Ji9p9jdN/mK8CAF/qT/F02ORALIGcO/
         keqw==
X-Gm-Message-State: AOAM532meMmMA6LaBcSk5TGleavy4AEdWFq9gig5aPXhovt46WYFAL+j
        SLsS9oOieVLZj/tZOLz6qZyFGVOEKw+Ns/Ti
X-Google-Smtp-Source: ABdhPJxDYB9rTt3yq2YQf2X9F06I256GfXEOXkwci5Oxy32nY12/dDyYWEsAwcQcd2TKN6+xi86aYw==
X-Received: by 2002:a63:7b52:: with SMTP id k18mr22562463pgn.381.1622641087130;
        Wed, 02 Jun 2021 06:38:07 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id l5sm15602287pff.20.2021.06.02.06.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:38:06 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>, briannorris@chromium.org,
        shawn.lin@rock-chips.com, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/4] PCI: of: Override 64-bit flag for
 non-prefetchable memory below 4GB
References: <20210531221057.3406958-1-punitagrawal@gmail.com>
        <20210531221057.3406958-2-punitagrawal@gmail.com>
        <CAMj1kXHkZhgp3y_1dvKjfiEbwWDooCY0X+0HZutn5ZrsRGk15w@mail.gmail.com>
Date:   Wed, 02 Jun 2021 22:38:03 +0900
Message-ID: <87tumgl744.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ard,

Thanks for the comments.

Ard Biesheuvel <ardb@kernel.org> writes:

> Hi Punit,
>
> On Tue, 1 Jun 2021 at 00:11, Punit Agrawal <punitagrawal@gmail.com> wrote:
>>
>> Some host bridges advertise non-prefetable memory windows that are
>
> typo ^

Oops. Fixed locally.

>> entirely located below 4GB but are marked as 64-bit address memory.
>>
>> Since commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
>> flags for 64-bit memory addresses"), the OF PCI range parser takes a
>> stricter view and treats 64-bit address ranges as advertised while
>> before such ranges were treated as 32-bit.
>>
>> A PCI host bridge that is modelled as PCI-to-PCI bridge cannot forward
>
> It is the root port which is modeled as a P2P bridge. The root port(s)
> together with the host bridge is what makes up the root complex.
>
>
>> 64-bit non-prefetchable memory ranges. As a result, the change in
>> behaviour due to the commit causes allocation failure for devices that
>> require non-prefetchable bus addresses.
>>
>
> AIUI, the problem is not that the device requires a non-prefetchable
> bus address, but that it fails to allocate a 32-bit BAR from a 64-bit
> non-prefetchable window.

That's right. Is the below (borrowed from your explanation) clearer?

    A PCI root port modelled as a PCI-to-PCI bridge cannot forward 64-bit
    non-prefetchable memory ranges. As a result, the change in behaviour due
    to the commit causes failure to allocate 32-bit BAR from a 64-bit
    non-prefetchable window.


If there are no further comments on the set, I'll send an update in a
couple of days.

Thanks,
Punit

>> In order to not break platforms, override the 64-bit flag for
>> non-prefetchable memory ranges that lie entirely below 4GB.
>>
>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
>> Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>>
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> ---
>>  drivers/pci/of.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index da5b414d585a..e2e64c5c55cb 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -346,6 +346,14 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>>                                 dev_warn(dev, "More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
>>                                          dev_node);
>>                         *io_base = range.cpu_addr;
>> +               } else if (resource_type(res) == IORESOURCE_MEM) {
>> +                       if (!(res->flags & IORESOURCE_PREFETCH)) {
>> +                               if (res->flags & IORESOURCE_MEM_64)
>> +                                       if (!upper_32_bits(range.pci_addr + range.size - 1)) {
>> +                                               dev_warn(dev, "Clearing 64-bit flag for non-prefetchable memory below 4GB\n");
>> +                                               res->flags &= ~IORESOURCE_MEM_64;
>> +                                       }
>> +                       }
>>                 }
>>
>>                 pci_add_resource_offset(resources, res, res->start - range.pci_addr);
>> --
>> 2.30.2
>>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
