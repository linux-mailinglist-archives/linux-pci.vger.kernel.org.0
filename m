Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C2839435A
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhE1NZt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhE1NZt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 09:25:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4DC061574;
        Fri, 28 May 2021 06:24:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so4480981pjb.2;
        Fri, 28 May 2021 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XZxKZYYhRdMgsx3AaVQx5MeKzRXu4NQ7JSlA+sHAgEs=;
        b=mraF9r984dsIkQsxnqkpHQWbcKxx1tEtELRMjGqQfqtAk6RBlxC13YGn+Txg+G1YqV
         nZxiCy59j+fiJlpYQbRrXUg+RlTxmBkb5JaloSa1rJpqMWntbBnadkhO5JSZIP8NyzXL
         3oMjfgDJknWcM5R/QbJAujRH/3WH04xUaxacX4OQwIkTk9kyrdBcGb/nYJjT2YQS0Udy
         MK3hYsVa0YCyQDYhfWPS6FzNxQmaEtQjw6yzK/gt5+wKXwkbIRhpQFOS9KzJXL3/5wd6
         DgLWspHyey/dMBdhO6taaK66EM4x4jHqnNPVRiorUcGKBCg85zLc2Or9y6e29MR156No
         +8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=XZxKZYYhRdMgsx3AaVQx5MeKzRXu4NQ7JSlA+sHAgEs=;
        b=CN3ct7vT4qdD7WuXIik41sfosHduNGzB9/bl97gNKjw/B70rxQq8a6khRJg2GXqnD1
         AnMPdHUaiDulhvWsrUrjhkW8V1yyOkga3+mmAkrwJ9ehfCHMDGyHccnI1VPTRkyDffRz
         htnXFWDU7q8kF1Lb4m8C6UKKXpam5w8GUfX3bN+fqVUrdEPNvEv6lVdD3OG/PW5NGKoy
         4vfMbhiyOPQP7sl5McEB9BsNGR9mlGwDlYOYJRRK5kRnECfg1iT4bows+LE0TmVzKLs0
         sK9JTCiwjSDevg3neTBSo5BjC5SUcCGhb/0zzKwcn1+/tVNuUAyUOIaOoCUYg79XDeW2
         qH6w==
X-Gm-Message-State: AOAM531bwqDg/HYBtpEUcE0VFS1LZYE4ljvOw0HHlOIKGf25wXC9Jnus
        T7VU+jTLP4YK0pKlfCaLPPk+u/zmJ1p0xA==
X-Google-Smtp-Source: ABdhPJxzQnRfEf+8rX9sKKQCix8COHH0CUiOVMrb3LwALp7WjJLs+JHLz2MIpglOh0XUY6iM2HBTxQ==
X-Received: by 2002:a17:90b:1955:: with SMTP id nk21mr4494591pjb.208.1622208252425;
        Fri, 28 May 2021 06:24:12 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id t24sm4397544pji.56.2021.05.28.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 06:24:11 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI: of: Override 64-bit flag for non-prefetchable
 memory below 4GB
References: <20210527150541.3130505-1-punitagrawal@gmail.com>
        <20210527150541.3130505-2-punitagrawal@gmail.com>
        <CAL_Jsq+Sp_Owe4V4WNh4jnuNJZ5jXxA+j4fW7564oPCy5Lu3ew@mail.gmail.com>
Date:   Fri, 28 May 2021 22:24:06 +0900
In-Reply-To: <CAL_Jsq+Sp_Owe4V4WNh4jnuNJZ5jXxA+j4fW7564oPCy5Lu3ew@mail.gmail.com>
        (Rob Herring's message of "Thu, 27 May 2021 11:38:46 -0500")
Message-ID: <87h7inm1op.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob Herring <robh+dt@kernel.org> writes:

> On Thu, May 27, 2021 at 10:06 AM Punit Agrawal <punitagrawal@gmail.com> wrote:
>>
>> Some host bridges advertise non-prefetable memory windows that are
>> entirely located below 4GB but are marked as 64-bit address memory.
>>
>> Since commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
>> flags for 64-bit memory addresses"), the OF PCI range parser takes a
>> stricter view and treats 64-bit address ranges as advertised while
>> before such ranges were treated as 32-bit.
>>
>> A PCI-to-PCI bridges cannot forward 64-bit non-prefetchable memory
>> ranges. As a result, the change in behaviour due to the commit causes
>> allocation failure for devices that are connected behind PCI host
>> bridges modelled as PCI-to-PCI bridge and require non-prefetchable bus
>> addresses.
>>
>> In order to not break platforms, override the 64-bit flag for
>> non-prefetchable memory ranges that lie entirely below 4GB.
>>
>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
>> Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> ---
>>  drivers/pci/of.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index da5b414d585a..b9d0bee5a088 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -565,10 +565,14 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>>                 case IORESOURCE_MEM:
>>                         res_valid |= !(res->flags & IORESOURCE_PREFETCH);
>>
>> -                       if (!(res->flags & IORESOURCE_PREFETCH))
>> +                       if (!(res->flags & IORESOURCE_PREFETCH)) {
>>                                 if (upper_32_bits(resource_size(res)))
>>                                         dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
>
> Based on Ard's explanation, doesn't this need to also check for
> !IORESOURCE_MEM_64?

Right - I was too focussed on the below case.
>
>> -
>> +                               if ((res->flags & IORESOURCE_MEM_64) && !upper_32_bits(res->end)) {
>
> res->end is the CPU address space. Isn't it the PCI address space we
> care about?

Indeed. I suspect the easiest way to check PCI addresses would be to
move the check to where the range property is being parsed.

I'll address both the comments with the next update.

Thanks,
Punit

>
>> +                                       dev_warn(dev, "Overriding 64-bit flag for non-prefetchable memory below 4GB\n");
>> +                                       res->flags &= ~IORESOURCE_MEM_64;
>> +                               }
>> +                       }
>>                         break;
>>                 }
>>         }
>> --
>> 2.30.2
>>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
