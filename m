Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DFD3A2DC3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFJONM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 10:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJONL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 10:13:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34D0C061574;
        Thu, 10 Jun 2021 07:11:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e1so1075119pld.13;
        Thu, 10 Jun 2021 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AKAb5TeB5GVwZN1dfSsZMkCOE2IQAp/s3a/nTdKL9s8=;
        b=RguhKcjDLAidIuWmMdjadAJrThv8iL+sGlVO6ohEOOamg+UnR1Rk3sGHHdB/aVnnnx
         KHaDwtnZm0YaZ0bNfp6TG5uVuuTEWMK52WRIh7tRcHBeAZ2anbRj48GefXe8Az2mcgFe
         wrYq/Cl6Qh3gsZjnb+krZxTL62YdKQU8gvKf+vVtgOY8zKksoTLUFBKJiOyOU5AucnpY
         tzlb/T3McMQvIZ95cQgvXJT/87cIaVl2DzBjdsXrBvyjNJAC1eiMfDHz734+P7g5ZES3
         2qrvAzTOYSvAYhOIcNvft/nlmBF0pm1bCoEEd0Atrbs6RVWUrBJHTqFhWZ7ScnEqXAZ2
         M5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=AKAb5TeB5GVwZN1dfSsZMkCOE2IQAp/s3a/nTdKL9s8=;
        b=oYYSkc2qeNc22yqDrWgQztiz0JjYVFtnUmmor2hDMCJLsbabR6VUEs4RYIR6Fv1Jh9
         LYqCH+8UsBXQL6aNnYXMI8kholyywGFBJ0kUL3EtddDdwRJl1D5Q36wz5KjiYfNVaGtW
         rhHCzTwj3TqpJ8TmMzNdvspX6kbbzFfkzPI4aYW0mscPbDkiIFIdCtD84KZtwuwgTZhh
         6Z/wLargnXnoI5e6lRvPF1+ssHLatt61vr1n+yvr1/ku72YPYDUqr8HDTpfjrX76KrBO
         zajH/0n4hEiGjJG7LfvzxYMsEBPSmEylywDyvr54Aw1lEOAcxvRto9+Y4lbwlo6ZwYgJ
         /4EQ==
X-Gm-Message-State: AOAM532kOBoferINJiUrqTniH1NADbN+r3T8y9u2Mk6EAqYabjNyefck
        3tIk1a2YAYUplPQZSZPETIM=
X-Google-Smtp-Source: ABdhPJxSS23KMky7aWpo6xT/GMWrgwMd0tgex+K2wIOykt1ER6+OlUghonXSCmSC03AKRZ33FdfJbg==
X-Received: by 2002:a17:90a:d205:: with SMTP id o5mr3633905pju.181.1623334274948;
        Thu, 10 Jun 2021 07:11:14 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id q4sm2663079pfg.3.2021.06.10.07.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:11:12 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com
Subject: Re: [PATCH v3 2/4] PCI: of: Relax the condition for warning about
 non-prefetchable memory aperture size
References: <20210610040427.GA2696540@bjorn-Precision-5520>
Date:   Thu, 10 Jun 2021 23:11:10 +0900
In-Reply-To: <20210610040427.GA2696540@bjorn-Precision-5520> (Bjorn Helgaas's
        message of "Wed, 9 Jun 2021 23:04:27 -0500")
Message-ID: <87y2bhkdxd.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Wed, Jun 09, 2021 at 12:36:08AM +0530, Vidya Sagar wrote:
>> On 6/7/2021 4:58 PM, Punit Agrawal wrote:
>> > 
>> > Commit fede8526cc48 ("PCI: of: Warn if non-prefetchable memory
>> > aperture size is > 32-bit") introduced a warning for non-prefetchable
>> > resources that need more than 32bits to resolve. It turns out that the
>> > check is too restrictive and should be applicable to only resources
>> > that are limited to host bridge windows that don't have the ability to
>> > map 64-bit address space.
>>
>> I think the host bridge windows having the ability to map 64-bit address
>> space is different from restricting the non-prefetchable memory aperture
>> size to 32-bit.
>
>> Whether the host bridge uses internal translations or not to map the
>> non-prefetchable resources to 64-bit space, the size needs to be programmed
>> in the host bridge's 'Memory Limit Register (Offset 22h)' which can
>> represent sizes only fit into 32-bits.
>
>> Host bridges having the ability to map 64-bit address spaces gives
>> flexibility to utilize the vast 64-bit space for the (restrictive)
>> non-prefetchable memory (i.e. mapping non-prefetchable BARs of endpoints to
>> the 64-bit space in CPU's view) and get it translated internally and put a
>> 32-bit address on the PCIe bus finally.
>
> The vastness of the 64-bit space in the CPU view only helps with
> non-prefetchable memory if you have multiple host bridges with
> different CPU-to-PCI translations.  Each root bus can only carve up
> 4GB of PCI memory space for use by its non-prefetchable memory
> windows.
>
> Of course, if we're willing to give up the performance, there's
> nothing to prevent us from using non-prefetchable space for
> *prefetchable* resources, as in my example below.
>
> I think the fede8526cc48 commit log is incorrect, or at least
> incomplete:
>
>   As per PCIe spec r5.0, sec 7.5.1.3.8 only 32-bit BAR registers are defined
>   for non-prefetchable memory and hence a warning should be reported when
>   the size of them go beyond 32-bits.
>
> 7.5.1.3.8 is talking about non-prefetchable PCI-to-PCI bridge windows,
> not BARs.  AFAIK, 64-bit BARs may be non-prefetchable.  The warning is
> in pci_parse_request_of_pci_ranges(), which isn't looking at
> PCI-to-PCI bridge windows; it's looking at PCI host bridge windows.
> It's legal for a host bridge to have only non-prefetchable windows,
> and prefetchable PCI BARs can be placed in them.
>
> For example, we could have the following:
>
>   pci_bus 0000:00: root bus resource [mem 0x80000000-0x1_ffffffff] (6GB)
>   pci 0000:00:00.0: PCI bridge to [bus 01-7f]
>   pci 0000:00:00.0:   bridge window [mem 0x80000000-0xbfffffff] (1GB)
>   pci 0000:00:00.0:   bridge window [mem 0x1_00000000-0x1_7fffffff 64bit pref] (2GB)
>   pci 0000:00:00.1: PCI bridge to [bus 80-ff]
>   pci 0000:00:00.1:   bridge window [mem 0xc0000000-0xffffffff] (1GB)
>   pci 0000:00:00.1:   bridge window [mem 0x1_80000000-0x1_ffffffff 64bit pref] (2GB)
>
> Here the host bridge window is 6GB and is not prefetchable.  The
> PCI-to-PCI bridge non-prefetchable windows are 1GB each and the bases
> and limits fit in 32 bits.  The prefetchable windows are 2GB each, and
> we're allowed but not required to put these in prefetchable host
> bridge windows.
>
> So I'm not convinced this warning is valid to begin with.  It may be
> that this host bridge configuration isn't optimal, and we might want
> an informational message, but I think it's *legal*.

By "optimal" - are you referring to the use of non-prefetchable space
for prefetchable window?

Also, if the warning doesn't apply to PCI host bridge windows, should I
drop it in the next update? Or leave out this and the next patch to be
dealt with separately.

Thanks,
Punit

[...]

