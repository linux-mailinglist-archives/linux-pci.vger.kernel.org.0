Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA3529ED8
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 12:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbiEQKHw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 06:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245760AbiEQKFl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 06:05:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02E949C9F;
        Tue, 17 May 2022 03:05:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y32so30390182lfa.6;
        Tue, 17 May 2022 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=25GtIoitw+ZTlzSdukQ7WOPmbkJJHbA+G1F2JqOUPCg=;
        b=OD/oBRJQvC09yFulvynVFmg5bIQgbGkZh5k15Ylg2dYQR/LVFqVH5v2UBGviF1S2+R
         1Gj0BSqWsra1NjlBMun1RetI2YgmIGm5zHF8TnRwNCgU6gPc1WvPPErI6Z/cfo7MOlo5
         I2hVY0N9fVt9Ui62nZpice02zg83O1TIdgO5+upw1IPyNFH47kZYsLAc2pB09nE2zF0W
         jnrklqqpBsdK0sqFkFNpCXllL2zUhMzfZ9D9La76wohjWLHSECu/1cI46IbRyBSl26bG
         LrjhqS6ZC4IBQ+p74Czp5xdFmDS7K5XeBBFzubUbI/TkfZM6MvS/My6TFFIPSYu0N7o6
         tCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=25GtIoitw+ZTlzSdukQ7WOPmbkJJHbA+G1F2JqOUPCg=;
        b=by7k7hXWtmA4zDTa7k9RdYNI7i+WnxJRa6Jt4x61aSa27ImHr8Z4HfNNhqcxhDlFgm
         bUtvns6d2DVAYsUi3J7gTbx07zBE2kftzMIfZvX9KdaRMSuppUOzMMSLquJzZlsljOYe
         4qIvkj14OZ5QU5yUDJO5YMXrMlEWwBeZb5vkh3UgAACPX4jN83lU7GwDqrp3Ogj6RcYe
         vVzKFmAZAFby4J+aFTd0FnQNJwfYCq1mOxneSnUV6VKmKyvyUIrbvj9JR/+g0e28tMdT
         BeCnaOJH6zqm4kWvZ2EBAq/snBhSBpNrL4hXC/Sv+uxJeP3khxEm34QwOOGPqmmAcRqi
         V3GA==
X-Gm-Message-State: AOAM5338ctLcFDoIXI06pC+J143k9deMdDrwx0IFVPE+K1dt1jp8bR7E
        lgC3I1REggWO/c6Z1Ncmgcc=
X-Google-Smtp-Source: ABdhPJxLVyTObUX+R4E5Tn6dZ4YNA2w3W0p4AvbybfDxgisgorYGKfA4XMH8NTFJdPuV3IVe2suFiA==
X-Received: by 2002:a05:6512:3090:b0:473:a636:dbee with SMTP id z16-20020a056512309000b00473a636dbeemr16124368lfd.119.1652781909895;
        Tue, 17 May 2022 03:05:09 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id a3-20020ac25e63000000b0047255d211acsm1541267lfr.219.2022.05.17.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:05:09 -0700 (PDT)
Date:   Tue, 17 May 2022 13:05:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clk: Baikal-T1 DDR/PCIe resets and some xGMAC
 fixes
Message-ID: <20220517100507.2ng3se7bbl2eqbz3@mobilestation>
References: <20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru>
 <20220512001156.x6kqyhi3vjjpqch6@mobilestation>
 <20220512152705.GA2506@lpieralisi>
 <20220512171150.GA164627@thinkpad>
 <20220512211431.r23r6daua36lty7d@mobilestation>
 <20220517074020.56093C34100@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517074020.56093C34100@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 17, 2022 at 12:40:18AM -0700, Stephen Boyd wrote:
> Quoting Serge Semin (2022-05-12 14:14:31)
> > On Thu, May 12, 2022 at 10:41:50PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, May 12, 2022 at 04:27:05PM +0100, Lorenzo Pieralisi wrote:
> > > > So in short, this series has to go through the usual clock tree review
> > > > process.
> > > > 
> > 
> > I do know the normal procedure. But if patches concern different
> > subsystems but for some reason inter-depended somehow it's ok to merge
> > them in via a single repo. In my case the platform clock driver has
> > been updated in a way so to support the reset-controls utilized in the
> > PCIe driver altered in another patchset. So I didn't want to leave the
> > kernel not working in the framework of my platform on any git hash
> > state. That's why I asked to merge the patchsets in via the same repo.
> > The kernel would be still buildable though.
> > 
> 

> Is it going to be broken if I merge the clk patches through clk tree?

No. It won't be broken.

> Has it ever worked?

It has and is working well except some minor fixes provided in this
petchset:
[PATCH v3 1/4] clk: baikal-t1: Fix invalid xGMAC PTP clock divider
[PATCH v3 2/4] clk: baikal-t1: Define shared xGMAC ref/ptp clocks parent

> Does the kernel still boot, just PCIe fails if the
> patches are applied?

Yes, the kernel will be bootable. There won't be any problem if the patches
in this series are applied because it is self-consistent. As I
said in the cover letter there is an implicit dependency of another series
"[PATCH v2 00/17] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support"
(https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/T/#me3c5c248adad9760702b545bd4bacd89d5f8a2bd)
from this one. In particular the functionality implemented in the
patch
"[PATCH v2 17/17] PCI: dwc: Add Baikal-T1 PCIe controller support"
(https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/T/#m219e11c38c4ab8db0c2520c4050366d641598600)
depends on the patches 3 and 4 of this patchset. But the
dependency is implicit hidden under the DT clock/reset bindings layer.
The Baikal-T1 PCIe platform driver will just fail to probe the host
controller device if this series isn't applied. So the clock/reset
patchset can be freely merged in via the clk tree especially seeing
the PCIe Host/EP subsystem maintainer is going to be AFK from
Wednesday and my series will sadly but likely hang up in limbo for a
while.

-Sergey

