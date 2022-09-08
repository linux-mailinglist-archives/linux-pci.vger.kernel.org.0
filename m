Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D765B173C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 10:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIHIhk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 04:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiIHIhg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 04:37:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B78DFF77
        for <linux-pci@vger.kernel.org>; Thu,  8 Sep 2022 01:37:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gb36so36313970ejc.10
        for <linux-pci@vger.kernel.org>; Thu, 08 Sep 2022 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GbG2nhzmmss+G+c6SA6X2YAIAHWx8rKRjK8Vj+ZZWPM=;
        b=KD+Iq3mtB6MLe4CjByKTs35ETQx8kt5r8obKdnXLZ7AUjXLjIlHpL+oJwVmoy9Xrh3
         6j6KoTYMAyRuXbruQbRtWzbF6TEyM+ETuP0bynmc3x72xeMtZIKg5rD7auczbgdHjm3O
         UoTxxs5QCss2VW941KUjZQl+9Gg40k1xZUQTsNYA9yRphGaeCHyxBevLq4ElFChatrju
         pFIC0paBfhI5CCM6VTR1Fg7SJ1KYf7u+8VkV3aH6yxtgaidWTpELL+IntcK0RPQZGO5o
         8pm6cP6XZ94P/1fCRKeXW6y+5pqwq95eWyzvuvFKe8Ymazt08R4eSaViUvb63IMsGkM9
         Z1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GbG2nhzmmss+G+c6SA6X2YAIAHWx8rKRjK8Vj+ZZWPM=;
        b=f4eITniaSS3TKEPiAHKS1uiLRlBFXuIP0+/fJw9QezCZB0B9gytzaRPf0mRZ5tULzt
         QWh3RpMA9eLwkp++LWQSKOftA/sAGwb5C+4iDOMZT6z+7UcVhtR5WfwSt+wCR6BGA4dM
         Xljfs5FuCwtuSi9pAmahyBOF5awmImOqd2JNsW6aYjOfy3BeePhRgEq1ItNUwy2p66xl
         x/prm2xjNFRyy8skC/7mmHOyrvpuroHQ/4750uyP6H4oMuNUDFYLrYZU22FYkAjWDUf7
         dUIgRhGY7Jv7vyDuBVmU0Qhr27uKu5tgFLAk1X5TgglRhTdk9zESCTQRG37dHTRURwUI
         RrUw==
X-Gm-Message-State: ACgBeo1bY7CFrnzbKXaggyVJ7wC+4tf7tNmPVi7yGpXYqcExg41r0T3j
        KzV8O6q0rDVHngFapHPqs9ggZ+fAnIUf9SWiuuzifQ==
X-Google-Smtp-Source: AA6agR7K2YSY0iF9ow7wVo6J+7idiXW229KpqRLBf+wEVc5EvDig8jY8Jl19Octj2OVVNsvtG+V7P3nxLcUQYiXS30k=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr5327012ejc.440.1662626254482; Thu, 08
 Sep 2022 01:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 10:37:23 +0200
Message-ID: <CACRpkdYwkurfb+BOc0-AnutedY9gBPAzD=z9TOW7dJLpG+RJCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: histb: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 6, 2022 at 10:43 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
