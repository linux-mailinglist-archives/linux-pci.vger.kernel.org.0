Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79AA55E8CD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347570AbiF1O4y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 10:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiF1O4x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 10:56:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2386C31904;
        Tue, 28 Jun 2022 07:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5278B81EA5;
        Tue, 28 Jun 2022 14:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B19C341CA;
        Tue, 28 Jun 2022 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656428210;
        bh=FpYf0SlQahcdeYvJriPJvjnOf7C9xV8g57eQjO7fZWM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WIFVhByV74zwuCWDj9NOr7gweJA/MU7ypj9anILIwZRJPQMAtHayzpzlXTKleekgY
         ew03twYkTVAN2wpGohiscIhg0XwAywpu9W5+GRpfddnSt0YU/K6yDbSL2pUKjL8JhM
         kKeJxGz0OEekmSr2WQsgLVj3yck7eeUW/YqcmtsWCgGuOPL9XxMHvLowvv12hu4fiq
         nMJSVr6qd0owkAMllRS3VJosofHfnX+hHLM38CkVOO4kQIE18FvoT5T/qVDwhjRL+g
         yOGHGcUOItAb85qlfNo0RlHT1ikaCbbYLrnOn6YkuddybhZv2jl4MM3lESB+pe0sfz
         y+Q/4FTe3eclA==
Received: by mail-vk1-f173.google.com with SMTP id b4so6088912vkh.6;
        Tue, 28 Jun 2022 07:56:50 -0700 (PDT)
X-Gm-Message-State: AJIora+OmGFePTaat94cE1KK1mf+VvefGd+jD11SFGFswRiqhD6Me4ui
        3cZ6IzAJAQqS7Fn0w/NtHeE4A+jsItmMAxnfMA==
X-Google-Smtp-Source: AGRyM1v7ts7QCGWn5jMJaO12bLBmyuqRQy/vzjWKK3ktgVkmNHjY+hGi8Hr/iGaA0/AJCFRL13AUuOXdWG9b07GiO7Y=
X-Received: by 2002:a1f:2bd5:0:b0:370:23aa:ead7 with SMTP id
 r204-20020a1f2bd5000000b0037023aaead7mr1601828vkr.26.1656428209495; Tue, 28
 Jun 2022 07:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-5-Sergey.Semin@baikalelectronics.ru>
 <20220615145550.GA1069883-robh@kernel.org> <20220619142720.tzfgefunvf3kirul@mobilestation>
 <20220628121540.oilmolkhqa43tf4e@mobilestation>
In-Reply-To: <20220628121540.oilmolkhqa43tf4e@mobilestation>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Jun 2022 08:56:38 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+N=HD78j7MZ2UXbfr36ozg-+kjZaoENSXr1M1qhJMmXA@mail.gmail.com>
Message-ID: <CAL_Jsq+N=HD78j7MZ2UXbfr36ozg-+kjZaoENSXr1M1qhJMmXA@mail.gmail.com>
Subject: Re: [PATCH v3 04/17] dt-bindings: PCI: dwc: Add max-link-speed common property
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 6:15 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Rob,
> Could you please get your attention back to this this thread?

I'll get to it. I'm catching up from a week of vacation.

Rob
