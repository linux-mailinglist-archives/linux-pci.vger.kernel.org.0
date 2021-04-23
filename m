Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E6A368C4A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Apr 2021 06:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbhDWEnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Apr 2021 00:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhDWEnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Apr 2021 00:43:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B657C06138B
        for <linux-pci@vger.kernel.org>; Thu, 22 Apr 2021 21:43:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u11so18816326pjr.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Apr 2021 21:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vmwMfJKV2MTnV8e34ZcnkdOiNEV3WHgx/mF/LO5zhjc=;
        b=RYueedh/cAfcFVTIodUVgv+DSG8NBbF0QpyZO+xaUpKWH18+PY4lPB29KMYH9dUfOR
         lJkdYWiDlbqCIBtzV8KIBo73ujgxGIGMCRfFlA+cAjqHMCT2hGpklHCiIU9J1geUVXkx
         DH9CKKHwPPMhWh2oeqjVn1gnki1vuhFplYKQxzuSSxg3FujyaQ6Av2i6GWw6B4Ehpkmg
         qCpONwsOlQRCSI0lHafPMHKeMQxeJhkHv3ENcuT/vZEpnamG3FXylHBQXHBTeU6eKX3R
         R70dPddH4xPRuDHa8omrcc67GVQucJt0VUnKNl0J61GfTo2KqHRfFck06uEM9pROj6bX
         oqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vmwMfJKV2MTnV8e34ZcnkdOiNEV3WHgx/mF/LO5zhjc=;
        b=VS174We8wuzSmo18dS/boRSw8h7OrYdfgZEHqVxgXBBELm0JYO5evnj/d42DGmLJC0
         FJogvvYRCs/cLz83D9fXCmgadVNy4m4Cimw0nlDHIjkuXT9Dot0ubyeaHf8U5dHiRnPE
         xsorUlun9B10YbaJOH3lLorSF/6cXsAm8Oj8ZuVVF8BqcU0DASJwy71GV3ApRv41a2LH
         Byr5kDesG0dxtG58pk8/yT0Lp0nwbaMEJFlUqTFm5SPwkURIFI3S08gCeu5EIQoT16Ja
         UCPnf9I+7/+wDQEZOIRkma/HEYAQON6rlOSmsW2yXzvcWFxczjDh4H6lJ4hmOc1d1qkf
         n++g==
X-Gm-Message-State: AOAM531k0IxIkuGPBGhIqOQDD2GgpQFepL5GHjwb4w5dNmzGuVfba7F9
        vNvI/7+jN8ptv5DdSttcS2usLw==
X-Google-Smtp-Source: ABdhPJxK2Og4+NYNGBddpr8IYw3HqTOQjisfWTquNVdzdYRnApFSJvMMN5algJYF50FdZYhhcfRV3w==
X-Received: by 2002:a17:90a:6c88:: with SMTP id y8mr2462165pjj.38.1619152983812;
        Thu, 22 Apr 2021 21:43:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u17sm3351189pfm.113.2021.04.22.21.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 21:43:03 -0700 (PDT)
Date:   Thu, 22 Apr 2021 21:43:03 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 21:43:00 PDT (-0700)
Subject:     Re: [PATCH v5 0/6] Add SiFive FU740 PCIe host controller driver support
In-Reply-To: <CAHCEehJajVGWnAwvX+Jg3_U=WNxaNq89Xq3uvcfcHzt04qNfMQ@mail.gmail.com>
CC:     lorenzo.pieralisi@arm.com, jh80.chung@samsung.com,
        zong.li@sifive.com, robh+dt@kernel.org, vidyas@nvidia.com,
        alex.dewar90@gmail.com, erik.danie@sifive.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com, aou@eecs.berkeley.edu, sboyd@kernel.org,
        hayashi.kunihiko@socionext.com, hes@sifive.com,
        khilman@baylibre.com, p.zabel@pengutronix.de, bhelgaas@google.com,
        helgaas@kernel.org, devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-f3dd2202-8d2b-4e17-9067-c4521aac8125@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 11 Apr 2021 19:37:50 PDT (-0700), greentime.hu@sifive.com wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> 於 2021年4月9日 週五 下午4:54寫道：
>>
>> On Tue, 6 Apr 2021 17:26:28 +0800, Greentime Hu wrote:
>> > This patchset includes SiFive FU740 PCIe host controller driver. We also
>> > add pcie_aux clock and pcie_power_on_reset controller to prci driver for
>> > PCIe driver to use it.
>> >
>> > This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon R5
>> > 230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based on
>> > v5.11 Linux kernel.
>> >
>> > [...]
>>
>> Applied to pci/dwc [dropped patch 6], thanks!
>>
>> [1/6] clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
>>       https://git.kernel.org/lpieralisi/pci/c/f3ce593b1a
>> [2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
>>       https://git.kernel.org/lpieralisi/pci/c/0a78fcfd3d
>> [3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
>>       https://git.kernel.org/lpieralisi/pci/c/8bb1c66a90
>> [4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
>>       https://git.kernel.org/lpieralisi/pci/c/b86d55c107
>> [5/6] PCI: fu740: Add SiFive FU740 PCIe host controller driver
>>       https://git.kernel.org/lpieralisi/pci/c/327c333a79
>>
>> Thanks,
>> Lorenzo
>
> Hi Palmer,
>
> Since the PCIE driver has been applied, would you please pick patch 6
> to RISC-V for-next tree?
> Thank you. :)

Sorry, I got this confused between the Linux patch set and the u-boot 
patch set so I thought more versions of this had kept comming.  The DT 
is on for-next now.
