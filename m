Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78952A114
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 14:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbiEQMCZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 08:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345715AbiEQMCD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 08:02:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521542A709;
        Tue, 17 May 2022 05:01:42 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d15so30885934lfk.5;
        Tue, 17 May 2022 05:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1XEfcTfh5IBE4Hjq7tgRfCnyVEzUbgopQ2XduZTHdoY=;
        b=JsoIPfQZlAqsSaswROdKslKyG/uZD3znk3WFv+pc2Cjlwgs8av4+twevvWm9xqngtE
         qBhT3LmHzN93yhSzjBckOWuSoOj162DzbXzGdHMCi/7byVkjMITOwZmsw6YVsTOzErB9
         9EuPWUL9A9mpwqNpFhrPEA54Ptp+D4/cNopmpOQ8FTtxb6+s1HC0s7l216032h2qixBK
         sb8mtRG0V/p8VmT09slzOqk5HZqLRy5QSAY4MYtZnNFTKcH3Ji0Q/+BXg/7gzrnJffWe
         NVYUDdSkUj5q97JDjff9uT2Rcu3hNEuao+cEWu1KzvAm/tmUGjQLndkq4v4+yNrCKisU
         EnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1XEfcTfh5IBE4Hjq7tgRfCnyVEzUbgopQ2XduZTHdoY=;
        b=FEDV0CCHg7TFvP7STxFHLuQk0p8x9CRoVR3o3qoGsW4fcH3XLG4vfdzDjTKJ6WSURq
         jJFe4xlbj7jIg3aLwJMwWPUQXlD+FaHOcFvfl/aCqz79yWFp4BfkBTmv2GVeK14CF2mR
         30s5wt53yrAAiNqmEcuUQsVAx6ZdfR7jBuMTso/8ZPSdR/LcAA+a70TEbx0hRTIvncI7
         yx884dmeG6n/43pPyiBnTBZXWZO6ZthkIA6qGgJA+8bmckLSHDM1jIYVxG2u1LV9Tg9S
         jX2MZHT9jnSejIH2kg4ZDXjzFVtHhr66mk02cvxHHw1R1yUAGp0f4OAlrbChVgLsFwdS
         LHIQ==
X-Gm-Message-State: AOAM5307vUiZzyM1EBZ1IK0U2mbI7rcRSmyH2YCtziMduJzpKh50ocDl
        7L2eq/06j7NIx3940M6+kas=
X-Google-Smtp-Source: ABdhPJyw6crfKTxgnFRCnsGY6+gLCyX9jN1UKVLmG7EouLUk9AG2WbNzvsc1rSStulGPSfMQci/JcA==
X-Received: by 2002:a05:6512:b10:b0:477:a556:4ab6 with SMTP id w16-20020a0565120b1000b00477a5564ab6mr1938339lfu.385.1652788898914;
        Tue, 17 May 2022 05:01:38 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id p17-20020a2eb7d1000000b0024f3d1dae8csm1869603ljo.20.2022.05.17.05.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:01:38 -0700 (PDT)
Date:   Tue, 17 May 2022 15:01:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] clk: baikal-t1: Move reset-controls code into a
 dedicated module
Message-ID: <20220517120136.mg6ihyzjb6rme6lc@mobilestation>
References: <20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru>
 <20220503205722.24755-4-Sergey.Semin@baikalelectronics.ru>
 <20220517073729.2FAE2C385B8@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517073729.2FAE2C385B8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 17, 2022 at 12:37:26AM -0700, Stephen Boyd wrote:
> Quoting Serge Semin (2022-05-03 13:57:21)
> > Before adding the directly controlled resets support it's reasonable to
> > move the existing resets control functionality into a dedicated object for
> > the sake of the CCU dividers clock driver simplification. After the new
> > functionality is added clk-ccu-div.c would have got to a mixture of the
> > weakly dependent clocks and resets methods. Splitting the methods up into
> > the two objects will make code easier to read especially seeing it isn't
> > that hard to do.
> > 
> > As before the CCU reset module will support the trigger-like CCU resets
> > only, which are responsible for the AXI-bus, APB-bus and SATA-ref blocks
> > reset. The assert/de-assert-capable reset controls support will be added
> > in the next commit.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/clk/baikal-t1/Kconfig       |  12 +-
> >  drivers/clk/baikal-t1/Makefile      |   1 +
> >  drivers/clk/baikal-t1/ccu-rst.c     | 258 ++++++++++++++++++++++++++++
> >  drivers/clk/baikal-t1/ccu-rst.h     |  60 +++++++
> >  drivers/clk/baikal-t1/clk-ccu-div.c |  94 ++--------
> 

> Perhaps this should be done via the auxiliary bus by having the clk
> driver register the reset driver and have some private API to pass any
> data to the reset driver? Then the whole file could be in
> drivers/reset/, reviewed and maintained by the reset maintainer.

I'd rather stick to the current design in the same way as the most of
the OF-based platform clock drivers. Completely splitting the reset
and clock parts isn't that easy is it seems like (though the main part
has been done in the framework of this patchset). AXI/APB-interface
reset controls are tightly coupled with the AXI/APB-clock domains at
least by having the same CSRs. Due to that the corresponding AXI-clock
domains reset functionality will need to be left in the
drivers/clk/baikal-t1/clk-ccu* module. It makes the movement isn't
that justified and will result in needless code complications and the
code coherency worsening.

-Sergey
