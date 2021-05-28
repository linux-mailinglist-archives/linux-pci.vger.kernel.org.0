Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B603942D1
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 14:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhE1MoL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbhE1Mnx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 08:43:53 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C0C06138A;
        Fri, 28 May 2021 05:42:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z4so1561193plg.8;
        Fri, 28 May 2021 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=h7kb/AUKQGRZBz4BjzTEhKlIFz8hYG49Mug/6+/Z8Uo=;
        b=AdalC0K0UroTAAUP/D2e1VtZe/wl0mmBp6Wd6V0bIkwPgwpaIgMDcIYegZwsVBpquW
         YM1ymSRlnxohw9XBNoJ9wnYMxEemUDcdlLvMfIcFsvFCWB335uIuLKHqZMlsiIds+bxM
         kRpwCNvyfGjuDLhi6/ff+Nz6UctS/bJFlUDwqKGuzihm38ngxWFw4JykpgV5Uu9iCkRy
         UOvFBg8Ne2SRmLQMZhTntBV5oBpdnacznGas5zpRe8yLSJBSy7KKx7WsLyQ+uGTJC6TG
         f9zaHICAcwz8FRMWFeP13AJS7/qJyeWrvciU+sVUY2HFqnyz8UtvxD9uVIiKxpp518NT
         /KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version;
        bh=h7kb/AUKQGRZBz4BjzTEhKlIFz8hYG49Mug/6+/Z8Uo=;
        b=dJw2GcsQoYM/JRMkbBfJdfNso27QbdwH61N3usUMfD02tMGtOZimVgsZxni92YP0z/
         cRqXLe5p+aOWDUmDMmgGXiCQcqYxU9GDrtwY2myaM8YVBETne3tAQxHHezyweMkVf1D/
         14s2jRMoLAIC7LNqVMq8cJv3ZHAO0jzVpBSSbbX7tTUzJwxDRUT1xlhu/f8EJjsBXa1M
         Oy5WISDyNcCGw5q4llmEyMwZY4KukvGRGskrm2qemdBYIv1vXOz0o82V4TMCedIKk7r6
         hRjSVE6sTC1IXvJPBroRXJfPSc9GFUQNgG6U2QK+7B5djdwH30jQWvQCQy46q/vkQwqi
         VarA==
X-Gm-Message-State: AOAM531o3VyqJ2xwWtBX0v/qO+WT8BeeXqo0E+MvOLvowGrfcBem+WKJ
        Jn51zMkjcTJTVR8R27OrDSg=
X-Google-Smtp-Source: ABdhPJykAzgytDlnvZD+DQ65emO1XRGQMzFYlndgWWq0LfFuaDwKlTlclqk2CfzTiJnuy0bGuo1DXQ==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr4266598pjz.42.1622205736205;
        Fri, 28 May 2021 05:42:16 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id 63sm4306924pfz.26.2021.05.28.05.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:14 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandru.elisei@arm.com, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, robh+dt@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI: of: Override 64-bit flag for non-prefetchable
 memory below 4GB
References: <20210527162130.GA1401058@bjorn-Precision-5520>
Date:   Fri, 28 May 2021 21:42:12 +0900
Message-ID: <87o8cvm3mj.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for taking a look.

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, May 28, 2021 at 12:05:41AM +0900, Punit Agrawal wrote:
>> Some host bridges advertise non-prefetable memory windows that are
>> entirely located below 4GB but are marked as 64-bit address memory.
>> 
>> Since commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
>> flags for 64-bit memory addresses"), the OF PCI range parser takes a
>> stricter view and treats 64-bit address ranges as advertised while
>> before such ranges were treated as 32-bit.
>
> Conceptually, I'm not sure why we need IORESOURCE_MEM_64 at all on
> resources we get from DT.  I think the main point of IORESOURCE_MEM_64
> is to convey the information that "this register, e.g., a PCI BAR, has
> space for 64-bit values if you need to write to it."
>
> When we're parsing this from DT, I think we're just getting a fixed
> value and there's no concept of writing anything back, so it doesn't
> seem like we should need to know how wide the hardware register is, or
> even whether there *is* a hardware register.
>
> But I'm sure the PCI resource allocation code probably depends on
> IORESOURCE_MEM_64 in those host bridge windows in very ugly ways.

Thanks for the explanation. From what I can tell, the IORESOURCE_MEM_64
flag is used in pci_bus_alloc_resource() to allocate from high PCI
addresses. Without the flag allocations above 4GB will fail. Not sure
that's legitimate use of the flag though.

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
>>  		case IORESOURCE_MEM:
>>  			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
>>  
>> -			if (!(res->flags & IORESOURCE_PREFETCH))
>> +			if (!(res->flags & IORESOURCE_PREFETCH)) {
>>  				if (upper_32_bits(resource_size(res)))
>>  					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
>> -
>> +				if ((res->flags & IORESOURCE_MEM_64) && !upper_32_bits(res->end)) {
>> +					dev_warn(dev, "Overriding 64-bit flag for non-prefetchable memory below 4GB\n");
>
> Maybe "Clearing 64-bit flag"?
>
> Can you include %pR, so we see the resource in question?

I'll follow your suggestions in the next update.

>
> Unrelated but close by, would be nice if the preceding warning ("size
> exceeds max") also included %pR.

Makes sense. I'll add the resource print to improve the message.

Thanks,
Punit

>
>> +					res->flags &= ~IORESOURCE_MEM_64;
>> +				}
>> +			}
>>  			break;
>>  		}
>>  	}
>> -- 
>> 2.30.2
>> 
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
