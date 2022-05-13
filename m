Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790E952614A
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 13:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380013AbiEMLpO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379988AbiEMLpF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 07:45:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D9F66AE8;
        Fri, 13 May 2022 04:45:04 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d19so14050150lfj.4;
        Fri, 13 May 2022 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lrkOSYGyb2W5e8iUM5z5KtK2vG4OpEu1byRK8zMbpr4=;
        b=hdk5ctyCFq20dAvLLQVvmATc9nh/gLK5FRKmtF0qJxZZtXibHJw9r45AlNa1rsEV7T
         zwbd6akbuu2CharSzyM8gIkxHOZFeLfKMrdX0FIoh7XicFhmd2BX2I+g9AoKqZ4tmsmE
         ndwmf0WYoer/+z+pK5HWQ2H5z2eTXC1jErOzjaVTHDFU/zfpwjS+KPtvqzMyv1WDPhbv
         +PIkmHHiuZoRkhoa7JMi0LKsc4a0aMZR9rK8jjd2ZPi8G2xFXHKalylXNCUlCHaZwmo5
         +WG5sfF/fm0dd85Be6STYv083tuIWFyV4reLUscOg82z/Q2jhL34aESg8Dt+OOYE0bAj
         SpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lrkOSYGyb2W5e8iUM5z5KtK2vG4OpEu1byRK8zMbpr4=;
        b=REcxcvEdy2dDaCmlzY0JPIrYOxA7kukC9F+LMc3BeWJUbCmUMRo2MRUctKp6kNRs6p
         ud1X0XdhqNQI0YYNoUWIN2PZPZL4jkLsdxs+wf/jVDvBivKq/VtWZU8OAHgAyLwkgTgx
         XJeAiXcVkGbyCuBYgNKUqH2NZ9xzD5Q2VcOUmo0dzA7LtXD5tNtm2huYNWMtfwiyWSK4
         JWjfdRXC123P0j631ymHgDQAmb4FwgKCFSz8vETeoE1NwJIsWE3JpELm80IyVlw6UgqV
         Utpztte0cu1EIzfdfz7ntR+chCBGHGTay9MXWj6g7yJ8Razb/DD1024PS7ANCJ+Rc5o5
         66uA==
X-Gm-Message-State: AOAM531JxuL2lEJbc8f3njXh1Wq5XTuZX5UTj0dXGjHNGcfQea6b99Jk
        OsfiFWsgYMv7jB1F9Y4lrPw=
X-Google-Smtp-Source: ABdhPJxChqikX4BilmRZa0+BBqRiME9trRNKbm4ZJLV3xG0dsMbRFGTdEGanqLwyuWZv1OWz16FShA==
X-Received: by 2002:a05:6512:3045:b0:473:d457:1541 with SMTP id b5-20020a056512304500b00473d4571541mr3230896lfb.308.1652442302168;
        Fri, 13 May 2022 04:45:02 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id f19-20020a19ae13000000b0047255d211b4sm346402lfc.227.2022.05.13.04.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 04:45:01 -0700 (PDT)
Date:   Fri, 13 May 2022 14:44:58 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clk: Baikal-T1 DDR/PCIe resets and some xGMAC
 fixes
Message-ID: <20220513114458.lgnrrejnwolak5sj@mobilestation>
References: <20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Stephen, Michael

The series has been here for about two months with no comments. Seeing
the dependent patches won't be merged in before the next merge window,
could you please merge this series in through your repo?

-Sergey

On Tue, May 03, 2022 at 11:57:18PM +0300, Serge Semin wrote:
> This patchset is an initial one in the series created in the framework
> of my Baikal-T1 PCIe/eDMA-related work:
> 
> [1: In-progress v3] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> Link: https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru/
> [2: In-progress v1] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
> [3: In-progress v1] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
> [4: In-progress v1] dmaengine: dw-edma: Add RP/EP local DMA controllers support
> Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/
> 
> Since some of the patches in the later patchsets depend on the
> modifications introduced here, @Lorenzo could you please merge this series
> through your PCIe subsystem repo? After getting all the required ack'es of
> course.
> 
> Short summary regarding this patchset. A few more modifications are
> introduced here to finally finish the Baikal-T1 CCU unit support up and
> prepare the code before adding the Baikal-T1 PCIe/xGMAC support. First of
> all it turned out I specified wrong DW xGMAC PTP reference clock divider
> in my initial patches. It must be 8, not 10. Secondly I was wrong to add a
> joint xGMAC Ref and PTP clock instead of having them separately defined.
> The SoC manual describes these clocks as separate fixed clock wrappers.
> Finally in order to close the SoC clock/reset support up we need to add
> the DDR and PCIe interfaces reset controls support. It's done in two
> steps. First I've moved the reset-controls-related code into a dedicated
> module. Then the DDR/PCIe reset-control functionality is added.
> 
> Link: https://lore.kernel.org/linux-pci/20220324010905.15589-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Resubmit the series with adding @Philipp to the list of the recipients.
> 
> Link: https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v3:
> - Rebased from v5.17 onto v5.18-rc3.
> - No comments. Just resend the series.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (4):
>   clk: baikal-t1: Fix invalid xGMAC PTP clock divider
>   clk: baikal-t1: Define shared xGMAC ref/ptp clocks parent
>   clk: baikal-t1: Move reset-controls code into a dedicated module
>   clk: baikal-t1: Add DDR/PCIe directly controlled resets support
> 
>  drivers/clk/baikal-t1/Kconfig       |  12 +-
>  drivers/clk/baikal-t1/Makefile      |   1 +
>  drivers/clk/baikal-t1/ccu-div.c     |   1 +
>  drivers/clk/baikal-t1/ccu-div.h     |   6 +
>  drivers/clk/baikal-t1/ccu-rst.c     | 373 ++++++++++++++++++++++++++++
>  drivers/clk/baikal-t1/ccu-rst.h     |  64 +++++
>  drivers/clk/baikal-t1/clk-ccu-div.c | 102 ++------
>  include/dt-bindings/reset/bt1-ccu.h |   9 +
>  8 files changed, 482 insertions(+), 86 deletions(-)
>  create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
>  create mode 100644 drivers/clk/baikal-t1/ccu-rst.h
> 
> -- 
> 2.35.1
> 
