Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F115B87DE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 14:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiINMK7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 08:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiINMKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 08:10:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54647FFBE
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 05:10:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y3so34275184ejc.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FqrsaO7+mEwEpioRKATgloJ10+QM+/cB58bQ3+4dp5M=;
        b=3ZzWtVRdsZPrUXGxn0Qt6WlAedOqYVxlPHkp6kNc9C3ddTB0szCRpmIDODQota/WGL
         all8CziUkR78153lbchMPecG3kDeC3kZoAgFIYZKZRrzvDWq/b2p+wa9aBKBPgJvbH/0
         TM30WUNl9iH1tcAqq7HwNkoliE76c6V+JvHrzBXha8xMzLJCz8raV0O2It47jJ9gvfJN
         6LnfS8S/La2rMiNKpmivF3YJRzSJaZXFWTNOmRqV3oUA6VKKqacCGj4g8Zl2SdZs7igL
         kin69leUUoCFCxja9ttW/w+K2rsiYYYt6edwlYRgmduSDMeVEoIbLp98YWKMXgBKggPR
         Wtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FqrsaO7+mEwEpioRKATgloJ10+QM+/cB58bQ3+4dp5M=;
        b=idhs6Yb77IV57bmUbAZBAL9rKMABjKhsLEy5/4yLt5QgZnF6WTu9RZJMY59ZlhwzR+
         JwPyzuUB+qq56I6dJQSF/1sDLaFA1ldS49W5nq1X+Ae4/spymrAnVMU7Rm57Zl+U0AZw
         Wq2fTERL+oKeY+QGUE8UxD4s75hUVhieVnHOaXreHoJGVJ7BwoRvYeh1Sr6/n2AeSk1p
         xsJEKpoQkZg/wa+ath9JsY69tJtfvUhKkuhrhCsc3XUWgu4HbQ0USucetR/Yfw/pqOE8
         NpSyot0Fw0UUWdi7HUVp4m/SLQyUebRVJ5X/Z1LfBBQrJKgVuueaDlFUBvS/2E1ozPkJ
         ktkA==
X-Gm-Message-State: ACgBeo1uUnPVze81tvZRDOJAdahraAyFL9K7tufBgOEARKhgMV59cdJQ
        TegKrq5Y+S/kvTnJTywWPnbJpm6vq0wU7qtVIaPjrA==
X-Google-Smtp-Source: AA6agR6/wFqnDCY8DdjL30UHxs7x4T6E8GyHJaVBbU6IhFxLGUpqktPxpxHNPWftwHziaT0tpo4M0CONWbbdA0zPIDE=
X-Received: by 2002:a17:907:3e07:b0:774:53ba:6b27 with SMTP id
 hp7-20020a1709073e0700b0077453ba6b27mr20640334ejc.286.1663157432337; Wed, 14
 Sep 2022 05:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com> <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com> <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com> <20220906220901.p2c44we7i4c35uvx@pali>
 <YxfMkzW+5W3Hm1dU@google.com> <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
In-Reply-To: <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 14 Sep 2022 14:10:21 +0200
Message-ID: <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 12:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Sep 7, 2022 at 12:41 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>
> > Linus, do you think we should introduce GPIOD_OUT_INACTIVE /
> > GPIOD_OUT_ACTIVE or GPIOD_OUT_DEASSERTED / GPIOD_OUT_ASSERTED and
> > deprecate existing GPIOD_OUT_LOW and GPIO_OUT_HIGH?
>
> They should rather be replaced everywhere in one go.
>
> I think it is just a half-measure unless we also add
> #define GPIOD_ASSERTED 1
> #define GPIOD_DEASSERTED 0
> to be used instead of 1/0 in gpiod_set_value().
>

We've had that discussion for libgpiod and went with
GPIOD_VALUE_ACTIVE and GPIOD_VALUE_INACTIVE but...

> It would also imply changing the signature of the function
> gpiod_set_value() to gpiod_set_state() as we are not
> really setting a value but a state.
>

... now that you've mentioned it it does seem like
GPIOD_STATE_ACTIVE/INACTIVE makes much more sense as well as naming
the relevant functions gpiod_line_request_set_line_state() etc.

> I have thought about changing this, but the problem is that I felt
> it should be accompanied with a change fixing as many users
> as possible.
>
> I think this is one of those occasions where we should merge
> the new defines, and then send Linus Torvalds a sed script
> that he can run at the end of the merge window to change all
> gpiod_set_value(...., 1) -> gpiod_set_state(...., GPIOD_ASSERTED);
> everywhere.
>
> After all users are changed, the GPIOD_ASSERTED/DEASSERTED
> defined can be turned into an enum.
>
> That would be the silver bullet against a lot of confusion IMO.
>
> We would need Bartosz' input on this.
>

We can also let Linus know that we'll do it ourselves late in the
merge window and send a separate PR on Saturday before rc1?

Bart

> Yours,
> Linus Walleij
