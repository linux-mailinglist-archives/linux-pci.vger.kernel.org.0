Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2CD63991C
	for <lists+linux-pci@lfdr.de>; Sun, 27 Nov 2022 02:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiK0BKN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Nov 2022 20:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiK0BKL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Nov 2022 20:10:11 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C42313DD7;
        Sat, 26 Nov 2022 17:10:10 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so12274789lfv.2;
        Sat, 26 Nov 2022 17:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7tb2mXbdsR6eQa3wvtplNTYB5kFT59Ed36tfjNJz7Go=;
        b=peqDeBsB+scWRJ971h6/MynvTpfitF/7/U01yUR9FKOx7ivOJSkSt7aDrGH0wYNCz4
         YniIVyOWfT0+K1WVwq0v6yFnOknNLVUt2FRgVgjHB90OkbvczjufZfnXbbFv0IRk2Gpw
         0naEecLHad0xQyMdij71NsDxDrTdfYxpV0d435UQJcVAayhiH/LBfSF/0bGdOBo0Eqt9
         32YYMnteQh13PF9ioOkhLK9X2Zw9PLOHxka/HtF7etEL307aJ3qVK+rUilq48K84H4Mo
         KHA8N7MV8ahLKhEmQZf3RiXaRzUsew6b5of2wn2uvMvg+2FcDElWyHGrtMgDUah3kppb
         /qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tb2mXbdsR6eQa3wvtplNTYB5kFT59Ed36tfjNJz7Go=;
        b=nTaEvM1YB/Aac0uMP7xwUiHwoPe37xh2tATBIlkwmJ94gPKxbMZFuaPRzzqumysLow
         FJgeuPFtkLCBw4yhhn/UMaZAtGkZpOhQ7N96x7LNKUuhyl7r8W5JTyG70Q1lkm0dI9c5
         KUoowEzn0/6HWL0RnWSpSgrd5LxTVlh83gq2xISIC+i9gBQktVhl05jrvkr+pSkfHWOM
         xWd5JO7xzxkIwNoBD8q9cNi8SFpNcNdM/S7zx3fWyA+OYDbUQmKG1PlktpbboED13MGv
         DfV9RftAc7cCcGyoeowgNwptNkbdeMyIn+1pKzc/eYCguylvNttcS5Mz4j1s3aISZSdh
         2nwg==
X-Gm-Message-State: ANoB5pkwDVQH/ay/JviPX9h2LCUgYuwaAV9VTbHaRKfiY6G7ZOSp1VoZ
        DkM70A1FgdmZcbV6bO2oKP0=
X-Google-Smtp-Source: AA0mqf4Wx8+3aBzxVXvpROh9wAShu+Gtv4ckpYWVntL/AiibLP0wWFLl+jsVY9FrpfkqTRMzQ8nDcg==
X-Received: by 2002:a05:6512:3084:b0:4aa:83e6:53e4 with SMTP id z4-20020a056512308400b004aa83e653e4mr14801390lfd.13.1669511408444;
        Sat, 26 Nov 2022 17:10:08 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id o18-20020a056512053200b00497b198987bsm1106423lfc.26.2022.11.26.17.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 17:10:07 -0800 (PST)
Date:   Sun, 27 Nov 2022 04:10:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 17/20] PCI: dwc: Introduce generic resources getter
Message-ID: <20221127011005.cjzcd6slb6ezy7ix@mobilestation>
References: <20221113191301.5526-18-Sergey.Semin@baikalelectronics.ru>
 <20221123194436.GA277209@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123194436.GA277209@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, Nov 23, 2022 at 01:44:36PM -0600, Bjorn Helgaas wrote:
> Hi Serge,
> 
> On Sun, Nov 13, 2022 at 10:12:58PM +0300, Serge Semin wrote:
> > Currently the DW PCIe Root Port and Endpoint CSR spaces are retrieved in
> > the separate parts of the DW PCIe core driver. It doesn't really make
> > sense since the both controller types have identical set of the core CSR
> > regions: DBI, DBI CS2 and iATU/eDMA. Thus we can simplify the DW PCIe Host
> > and EP initialization methods by moving the platform-specific registers
> > space getting and mapping into a common method. It gets to be even more
> > justified seeing the CSRs base address pointers are preserved in the
> > common DW PCIe descriptor. Note all the OF-based common DW PCIe settings
> > initialization will be moved to the new method too in order to have a
> > single function for all the generic platform properties handling in single
> > place.
> > 
> > A nice side-effect of this change is that the pcie-designware-host.c and
> > pcie-designware-ep.c drivers are cleaned up from all the direct dw_pcie
> > storage modification, which makes the DW PCIe core, Root Port and Endpoint
> > modules more coherent.
> 

> Thanks for these new generic interfaces in the DWC core!  And thanks
> for the changes in this patch to take advantage of them in the
> pcie-designware drivers.
> 
> Do you plan similar changes to other drivers to take advantage of
> these DWC-generic data and interfaces?  If you add generic things to
> the DWC core but only take advantage of them in your driver, I don't
> think they are really usefully generic.

Could you be more specific what generic things you are referring to? I
am asking because the only part of the changes which is used in my
low-level driver only is introduced in another patch of this series.
It's
< [PATCH v7 19/20] PCI: dwc: Introduce generic platform clocks and resets
The new clock/reset request interface has been implemented the way it
is due to reasons I in details described to Rob here:
Link: https://lore.kernel.org/linux-pci/20220520160246.guczq52v2ycfgc6c@mobilestation
To cut it short it can't be used by the most of the already available
low-level drivers since they already have their own versions of the
names for the clock and reset resources (or don't have any name
defined at all). The only driver for which the interface could be
utilized is Toshiba Visconti PCIe host controller driver. The device
DT-bindings defines the clock names matching the generic names
introduced in the patches of this series. If you find it appropriate
enough I can provide a patch for that driver.

Note the main goal of the patch
[PATCH v7 19/20] PCI: dwc: Introduce generic platform clocks and resets
was to create some interface to stop the developers of the new drivers
from creating the platform-specific DT-bindings to the same clock and
reset resources. Since the already defined DT-bindings can't be
changed anyway I don't think it would worth risking to catch
regressions on an attempt to provide a more complicated interface
utilized in the old drivers too.

-Serge(y)

> 
> Bjorn
