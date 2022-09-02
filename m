Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9A85AB6B7
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 18:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbiIBQi2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiIBQi0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 12:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A5BF5CCA;
        Fri,  2 Sep 2022 09:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A65EA62171;
        Fri,  2 Sep 2022 16:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D5AC433B5;
        Fri,  2 Sep 2022 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662136700;
        bh=cJ8N01KrHp2VSQq/w6MNL7RCLUq6UXqAB56nIwq18Z0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oydKaHJafJQ2V8VD14FbcXquqkG9lI0YwzM50ERRko3iKJAmo1GvDC1mX0+bDgLII
         QllaO/oNBOtVOQf4ZQs88gN1BZJgs8PzV7Cm6D/Jv0X8bOD9vnIbP3ptQeV9XRTW2x
         7BV/SWbRCao2GWRW/k3sWi8oKLm8jox4HrAf/WQPYBfr++/MQpJR1z/6z1xI6uNaoi
         F7U4MTwenK8RKsQDKdfRf9OKSONmpQVMDmht24Og8FKQfzammv4cx4xr98xpHjbuox
         vIK+uWSPyMoyAK345ZAwrtm1bZIUOdNpqL0dbjLkDTbqGhxhaJha/x1E06Vr5GWmtm
         AgmPOH+xw6pjw==
Received: by mail-vs1-f47.google.com with SMTP id i12so2563826vsr.10;
        Fri, 02 Sep 2022 09:38:20 -0700 (PDT)
X-Gm-Message-State: ACgBeo1hu1jbw2co/rlAHmnOE6Pz3Hm2YcLBuCGUTVFhqyl2Il1+MiRQ
        DMbLaEaMIG3HAYVgOxht2m9bZTWQJ8MZxphwpg==
X-Google-Smtp-Source: AA6agR7vWuBFhfi7I5Z8ZPdQ2mCDo3z/s0pgcDsK3FstW/dr55Irrace5HVetTWI4eTGXgUrXqr8DXlfVbt1wlBaBog=
X-Received: by 2002:a05:6102:3353:b0:38c:9170:a96b with SMTP id
 j19-20020a056102335300b0038c9170a96bmr12077095vse.26.1662136698991; Fri, 02
 Sep 2022 09:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220830183310.48541-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220830183310.48541-1-andriy.shevchenko@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 2 Sep 2022 11:38:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKjQ0PpSYhYW0MUh1WdsPta4OzVbsnYK8PuEQYomXfAYA@mail.gmail.com>
Message-ID: <CAL_JsqKjQ0PpSYhYW0MUh1WdsPta4OzVbsnYK8PuEQYomXfAYA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PCI: dwc: Replace of_gpio_named_count() by gpiod_count()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 30, 2022 at 1:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> As a preparation to unexport of_gpio_named_count(), convert the
> driver to use gpiod_count() instead.

I'm always in favor of removing DT APIs.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
