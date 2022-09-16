Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC4C5BA75E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 09:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIPHXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 03:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIPHXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 03:23:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52877A50DD
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 00:23:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w28so6248877edi.7
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 00:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ROqLBReQE/7GkbmtaIhshZARplN5wkq7A//qiLQq9kA=;
        b=nxgYfvnLNrk+I96j5O2yz93N3SfOABT5E9o6l1hADwyr3tOCILnrCPzEDFHTnDSP3W
         YXTL8Ru8oR2hFRwtaKCfX3q71e6P5jfk12F4q6GgaNiOe5JHECDeqB8n35iEYxqjD2Tq
         gBZjbEBBszCurcyPlLpx5skqBkBxFUMXZP75U4yy+zBHxOlEKQwrdDdYbPWqXowcHCLk
         tyUHuUNDi4iLIGQkRfcKfVnm8oUmJZ83Eg3e8vKY7HNxhB25VFIJPr83CGLRs44c34VT
         +um9qJeGlhsTtoGOcaZp9X7nDi1UuC8xvZVtrWkH0W+Uz+WZQ9/xUiRla8rZN91SEEFd
         zjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ROqLBReQE/7GkbmtaIhshZARplN5wkq7A//qiLQq9kA=;
        b=l3xkMQGptKwNc2bjmWGOVkYTDITYilBVodOes0RyY+1UtNyr6Ma0GjcIblNhoZbwAS
         J83NZqM8GWtOr1AdoGZSoGzD9mlEJGYyRHdzcLh6A1h18VNOLT/rCSnM5MAPnWRnRj8W
         g68R+WsEXkX3Pughbu3cplnQqqgpgsByAQFqV0J+clx8z9ON3H6v8h69q33u9aCno12j
         zzeFKOCCJCOZPPypPKOLCTIDB5CumKMPLQsKyfmjGQAS1yL8nrpckH8W5KsX6zi2v2KN
         02n9kh2vayOLFuD2H4f2UKAXD6kSIBAu917WKNBaO7UueciQEpUM9U9wlj/UzdexxkUb
         3L4g==
X-Gm-Message-State: ACrzQf0U+oGvRxsRKEkwu9/4R/fyYo9SnFzlltlMSpoVRTr6P59yVcSX
        ZEVnj6TG9AaVs6SCAGeB8b0ewPrI005sR7M6p7L4jA==
X-Google-Smtp-Source: AMsMyM74RLbjFMtpNGct0Ozwlha2WJplFjDI0j00KfUxbeOXQV5fKwafkxSRCZBcwfMfUHTVYRXkledc1oWhwynzbD0=
X-Received: by 2002:a05:6402:5243:b0:451:6d52:5928 with SMTP id
 t3-20020a056402524300b004516d525928mr2846752edd.328.1663312989854; Fri, 16
 Sep 2022 00:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220906211628.6u4hbpn4shjcvqel@pali> <Yxe7CJnIT5AiUilL@google.com>
 <20220906214114.vj3v32dzwxz6uqik@pali> <YxfBKkqce/IQQLk9@google.com>
 <20220906220901.p2c44we7i4c35uvx@pali> <YxfMkzW+5W3Hm1dU@google.com>
 <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
 <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com>
 <YyKMsyI961Mo1EQE@sol> <CACRpkdYB6dZf4TBhfXB2Z5E2PJ46ctAM_QKLiW-fykbCopcVGQ@mail.gmail.com>
 <YyLwsOBXv9jRw/+n@sol>
In-Reply-To: <YyLwsOBXv9jRw/+n@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 16 Sep 2022 09:22:59 +0200
Message-ID: <CAMRc=MeF2uNmx_-mZikg=3nMV4aHK+bCUBEcLGEgJ6JY4jZ_Sg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 15, 2022 at 11:30 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Thu, Sep 15, 2022 at 10:51:02AM +0200, Linus Walleij wrote:
> > On Thu, Sep 15, 2022 at 4:23 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > > After sleeping on this, I'm even more in disagreement with renaming
> > > value to state.
> >
> > OK let's not do that then.
> >
> > > OTOH, I totally agree with the addition of GPIOD_ACTIVE/INACTIVE to be
> > > used for the logical cases, and even a script to apply it globally.
> > > Ideally that script would change both the calls to the logical functions
> > > to use ACTIVE/INACTIVE, and the physical to HIGH/LOW.
> >
> > OK we have consensus on this.
> >
> > > Introducing enums for those, and changing the function signatures to
> > > use those rather than int makes sense to me too.
> >
> > Either they can be enum or defined to bool true/false. Not really
> > sure what is best. But intuitively enum "feels better" for me.
> >
>
> Enums work for me - especially if the goal is to differentiate
> logical from physical - there should be a distinct enum for each.
>

We won't even have to change the function signatures if we go with
enums - they already take an int and I'm in general against putting
enum types into function signatures in C as they give you a false
sense of a strong type.

Bart

> > > Though I'm not sure
> > > why that has to wait until after all users are changed to the new macros.
> > > Would that generate lint warnings?
> >
> > I rather want it all to happen at once. One preparatory commit
> > adding the new types and one sed script to refactor the whole
> > lot. Not gradual switchover.
> >
> > The reason is purely administrative: we have too many refactorings
> > lagging behind, mainly the GPIO descriptors that have been
> > lagging behind for what is it? 5 years? 10? GPIO irqchips also dragged
> > out for way too long. We can't keep doing things gradually like
> > this, it takes too much time and effort.
> >
> > I don't want any more "in-transition-indefinitely" stuff in the GPIO
> > subsystem if I can avoid it.
> >
> > Therefore I would advice to switch it all over at the end of a merge
> > window and be done with it.
> >
>
> Agreed - do it all at once.  My question was specific to the change of the
> function signatures to using enums - what is to prevent us doing that
> before running the sed script, and have the script switch usage over to
> the enums?
>
> Cheers,
> Kent.
