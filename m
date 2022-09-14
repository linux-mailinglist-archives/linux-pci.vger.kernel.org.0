Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4D25B8672
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 12:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiINKfw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 06:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiINKfu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 06:35:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84BE53D01
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 03:35:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e18so21584552edj.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9R4Qb6/eZoL08cSuhU5zbiGZtzfSBbdj1XMsqivoRDc=;
        b=FeNv4kze+PUgBxeZ8u20xM7vWicI3MDzZN1ratQf5K6w2MATkfQjfgFdvM7/ZG2B2Q
         6A6oZnJFpXAivJM8IM+ZWPMFPA8B9VhzWX5vnkNRqbbnQLoJGF5yFZ+gRiR7O3n8jYuY
         3FuQmRa9wHuVbav7zdboUdF+ISLpFG3x2hNQGZ9veed2C3O9BEYZpQqQFRXX41LCHxsX
         tYpgb80AHMFideH+lHoGtUPJAgX/MRI9FVRKqkqE79RYAn9EmnjmsJG1rQJ93q+SjHmu
         0eqX5aEnACOVD1I3fEUCRU/5wKnubHbx9/R+v4XZuqwChr2/Kp6NWherCeBGqn8ZMre9
         6Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9R4Qb6/eZoL08cSuhU5zbiGZtzfSBbdj1XMsqivoRDc=;
        b=yO54eWbJ4x/NSKGqHLndwh+C7k3dAzDciW1WUEwCQ3/VvAk3L6cllKUGEaQGAdq+J0
         jbeBdvUFqsYhwmbKGTV3H4xhF2AC2anIauFlNdRQbgR7o2y5mSFISBxdoQLMFVDhIDwf
         Pq1jTJmDb9YhT/a6q77cOUPXGeGPt133n3T0jSKyTNKE4Go0i54+vtfpY2h0NxbTdRg3
         MRaahLmO64WeEKBER+wKcBCN63I692Ub5+QdpQaRLmdNMmUCpPqXra9dkBjtcVHpt+Y3
         /YFzAoKbC2cwp2csfn8m/S0dIR1pMMdJ4MLCxqK2ej7GwPoKEbyjkojUMz/6euhkGyYq
         gRag==
X-Gm-Message-State: ACgBeo2JuKUWyQ1UjGO8+p5cgAAx60TftFBiAzDz/zzUuN236fxzSPb1
        2rvW1NVPvl+q0evJNyV7mMupChVYniySq0s3wSTqEg==
X-Google-Smtp-Source: AA6agR6ozhdIMePkvj6txPi/h/TnaiD7gHVJV++34/XV5xh2tnc5f+zK9Kf5UtfhMq+zusS28ejyMIOp44ZO6N+3S8w=
X-Received: by 2002:a05:6402:2690:b0:452:3a85:8b28 with SMTP id
 w16-20020a056402269000b004523a858b28mr7914423edd.158.1663151748276; Wed, 14
 Sep 2022 03:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com> <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com> <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com> <20220906220901.p2c44we7i4c35uvx@pali> <YxfMkzW+5W3Hm1dU@google.com>
In-Reply-To: <YxfMkzW+5W3Hm1dU@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 12:35:36 +0200
Message-ID: <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Sep 7, 2022 at 12:41 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Linus, do you think we should introduce GPIOD_OUT_INACTIVE /
> GPIOD_OUT_ACTIVE or GPIOD_OUT_DEASSERTED / GPIOD_OUT_ASSERTED and
> deprecate existing GPIOD_OUT_LOW and GPIO_OUT_HIGH?

They should rather be replaced everywhere in one go.

I think it is just a half-measure unless we also add
#define GPIOD_ASSERTED 1
#define GPIOD_DEASSERTED 0
to be used instead of 1/0 in gpiod_set_value().

It would also imply changing the signature of the function
gpiod_set_value() to gpiod_set_state() as we are not
really setting a value but a state.

I have thought about changing this, but the problem is that I felt
it should be accompanied with a change fixing as many users
as possible.

I think this is one of those occasions where we should merge
the new defines, and then send Linus Torvalds a sed script
that he can run at the end of the merge window to change all
gpiod_set_value(...., 1) -> gpiod_set_state(...., GPIOD_ASSERTED);
everywhere.

After all users are changed, the GPIOD_ASSERTED/DEASSERTED
defined can be turned into an enum.

That would be the silver bullet against a lot of confusion IMO.

We would need Bartosz' input on this.

Yours,
Linus Walleij
