Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB17368C68
	for <lists+linux-pci@lfdr.de>; Fri, 23 Apr 2021 07:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhDWFLX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Apr 2021 01:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWFLW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Apr 2021 01:11:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075DC061574
        for <linux-pci@vger.kernel.org>; Thu, 22 Apr 2021 22:10:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f29so34401601pgm.8
        for <linux-pci@vger.kernel.org>; Thu, 22 Apr 2021 22:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:message-id:cc:from:to;
        bh=wv06ln7jUx5RhDbCP3yp9Aqv9te0/cVOv02q2bnuehY=;
        b=g8L5eXN96akk8Lkciek2Sc0gsTJvNnKVFJHZfByuKNxnTF709JIIdd1RvDUwe0Fotv
         uOrf1P0hSbehB0KgZ8nYI7bCZnuPK/WfGayN/8XW+ee3EOFU77ib+pPbhYPlf38BuLQI
         6iAoHlfMq91h33qEw7vJh72HvkBw10cAc+zsMucNTFDQulPKFsWaAieKVrIj30doGYEg
         x1/B0qDkMht91pk2+ny4eO2XXyd5qqJC9gIhfwpeKaESCT7M98mHALmsvu2MAUIkFW/8
         VNChTnpZreSFnuKDuzAlTgzvSy2JRMwW87dkQjuhELi3wdjFZFuX3/MuG7omwQXg3R0Y
         c56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:message-id:cc:from:to;
        bh=wv06ln7jUx5RhDbCP3yp9Aqv9te0/cVOv02q2bnuehY=;
        b=mXerLMc0AqZdJdHVzt49uU/Yn/Pxu33V/wBM2qdP31djtL+pUMDqcGz5iS+VpyiJrb
         xw/6mW2qfYlT+MzEVodc7xMehqQ9MJYq+TXW2AhsP3bmZ8HdWvsRwJpv1PXXuIHmB6xg
         lP0sakp10P1hMFZK2FG1bzMkc1RQeNg1ejmf+pmR0ahPzeH6iDH8gU7D9YhwBVTlcN4+
         aOOQZMCGTr6+ojEeQPZC0gPcrJSLMSKZ7ekDRHjyDp56+yyzbHVg7vkdvHae2l9S17Qv
         VkfZ0694/eHS3+bMiZLZlV6mzMUy57q3UoKyHkx1mB0kMAWQaJh9TjBv92TdkOr3I2hS
         z4qQ==
X-Gm-Message-State: AOAM533lcHQPeFjfGIqOnfqFebU0zrENwKIORJYsL1fkgOBkgGVlNcpR
        gWmzsAqr6JVsQE1UYo5uXpZALA==
X-Google-Smtp-Source: ABdhPJxAXNMAM3pbHXlafBsbQ1tQ98EYr8RHKCZNVARlwL9Xm7cohhJFdzcmZgPH8Ggl2r6bDRvi5w==
X-Received: by 2002:a63:3d48:: with SMTP id k69mr2050932pga.239.1619154646285;
        Thu, 22 Apr 2021 22:10:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id nh24sm3535434pjb.38.2021.04.22.22.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 22:10:45 -0700 (PDT)
Date:   Thu, 22 Apr 2021 22:10:45 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 22:10:08 PDT (-0700)
Subject:     Re: [PATCH v5 0/6] Add SiFive FU740 PCIe host controller driver support
In-Reply-To: <mhng-f3dd2202-8d2b-4e17-9067-c4521aac8125@palmerdabbelt-glaptop>
Message-ID: <mhng-41850660-4a95-462a-9b1e-33dfc67815a4@palmerdabbelt-glaptop>
CC:     greentime.hu@sifive.com, lorenzo.pieralisi@arm.com,
        jh80.chung@samsung.com, zong.li@sifive.com, robh+dt@kernel.org,
        vidyas@nvidia.com, alex.dewar90@gmail.com, erik.danie@sifive.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com, aou@eecs.berkeley.edu, sboyd@kernel.org,
        hayashi.kunihiko@socionext.com, hes@sifive.com,
        khilman@baylibre.com, p.zabel@pengutronix.de, bhelgaas@google.com,
        helgaas@kernel.org, devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com, lorenzo.pieralisi@arm.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 22 Apr 2021 21:43:03 PDT (-0700), Palmer Dabbelt wrote:
> On Sun, 11 Apr 2021 19:37:50 PDT (-0700), greentime.hu@sifive.com wrote:
>> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> 於 2021年4月9日 週五 下午4:54寫道：
>>>
>>> On Tue, 6 Apr 2021 17:26:28 +0800, Greentime Hu wrote:
>>> > This patchset includes SiFive FU740 PCIe host controller driver. We also
>>> > add pcie_aux clock and pcie_power_on_reset controller to prci driver for
>>> > PCIe driver to use it.
>>> >
>>> > This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon R5
>>> > 230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based on
>>> > v5.11 Linux kernel.
>>> >
>>> > [...]
>>>
>>> Applied to pci/dwc [dropped patch 6], thanks!
>>>
>>> [1/6] clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
>>>       https://git.kernel.org/lpieralisi/pci/c/f3ce593b1a
>>> [2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
>>>       https://git.kernel.org/lpieralisi/pci/c/0a78fcfd3d
>>> [3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
>>>       https://git.kernel.org/lpieralisi/pci/c/8bb1c66a90
>>> [4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
>>>       https://git.kernel.org/lpieralisi/pci/c/b86d55c107
>>> [5/6] PCI: fu740: Add SiFive FU740 PCIe host controller driver
>>>       https://git.kernel.org/lpieralisi/pci/c/327c333a79
>>>
>>> Thanks,
>>> Lorenzo
>>
>> Hi Palmer,
>>
>> Since the PCIE driver has been applied, would you please pick patch 6
>> to RISC-V for-next tree?
>> Thank you. :)
>
> Sorry, I got this confused between the Linux patch set and the u-boot
> patch set so I thought more versions of this had kept comming.  The DT
> is on for-next now.

I spoke too soon: this actually dosn't even build for me.  It's the 
"clocks = <&prci PRCI_CLK_PCIE_AUX>;" line

    Error: arch/riscv/boot/dts/sifive/fu740-c000.dtsi:319.20-21 syntax error
    FATAL ERROR: Unable to parse input tree
    make[2]: *** [scripts/Makefile.lib:336: arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dtb] Error 1
    make[1]: *** [scripts/Makefile.build:514: arch/riscv/boot/dts/sifive] Error 2
    make: *** [Makefile:1388: dtbs] Error 2
    make: *** Waiting for unfinished jobs....

I'm not sure what the issue is, I see an anchor for "prci".  Do you mind 
sending along a new version that compiles on top of for-next?  If I need 
the definiton of PRCI_CLK_PCIE_AUX from a PCIe tree then it's probably 
best to just keep the DTS along with the rest of the patches.  IIRC I 
alredy Acked it, but just to be clear

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
