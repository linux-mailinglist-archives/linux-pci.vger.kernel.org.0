Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6A35B929A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 04:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIOCX6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 22:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIOCX5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 22:23:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512EC8B9A8;
        Wed, 14 Sep 2022 19:23:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso4762718pjq.1;
        Wed, 14 Sep 2022 19:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pS8NU8d68X7zklElxG4nZCs0ZD7RmAf3lpoaFItGexA=;
        b=Q/ejU6RyApXqUkDpagJdflz/TX+AZnirDlkyhrkrc2Pjg6qpZ6Tb5uleg4j89pBP4a
         CuANpbs7qiirapWAHxRgNIePI1a3aFz8fwPT83dYhCn0ZKG4vIIPbwdA0dZSHJB12xlP
         Zdz7L7smstDjg6slV8DU/vysjStMvz0B6DL+iJKm1E4GpzF/I9XaXHzfJsLvpEplqMyZ
         f/mefdn6q3KYxYG1hSQ6IyVazNsa50Ug4dHG93oa/mLpQ/w3JImG6rtE2/eikCeJN/1/
         /ofjT2kQYTS9OouTr3bYz+fvve/FGEHNbJaN4G938N8RWQhOlT8vknT8LGYoOGyZyavh
         G7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pS8NU8d68X7zklElxG4nZCs0ZD7RmAf3lpoaFItGexA=;
        b=5J6olOpGYUkiqBFnkUWeC9x5fuYZfOX1QbUmHOmWjDLrxnvUtL0X7mlsswptUBhkOJ
         Ns+jNNyXZPQxW5gi62SHw5njuZMSfzJwnqCGuV55+VXWEHiWFXrMi3/1ecqF29+l1KOW
         KWqAKuf5zulFCCVjxqNpVnXTGVDLrWDUsgCZfjkLYII3IBjMvf3r0OSvODfLsHQTA3d1
         RZgqDKjN0rW1kdxok052TBL5GNXSrbup3gOHV+aeFo2wDTqfoNK/kCTLkqlmu+qCM/ha
         ZvjpUDwIi8OeFtlc2GMhG5qHjZJe0E/pFxQ9dp+4YDfWwKiXmFT/jSFsIzxoOHZ12p1N
         eR4w==
X-Gm-Message-State: ACrzQf3L80J7jyDBN2RGcRe0bur+FKROeiSaWX1nWRkdOwmXBhLsOLa3
        WQ1mrpm0dR56zVE4By0W8nc=
X-Google-Smtp-Source: AMsMyM7Cbow9eNG6deOSSOrO7v+34xT+oyCdf372fYsN4ZZw3nswfZy3iJjTjPuhECpX1M+wFWu4BQ==
X-Received: by 2002:a17:902:8e88:b0:172:d1f8:efcb with SMTP id bg8-20020a1709028e8800b00172d1f8efcbmr1967360plb.27.1663208635740;
        Wed, 14 Sep 2022 19:23:55 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78f36000000b0052d200c8040sm10997648pfr.211.2022.09.14.19.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 19:23:55 -0700 (PDT)
Date:   Thu, 15 Sep 2022 10:23:47 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
Message-ID: <YyKMsyI961Mo1EQE@sol>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
 <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com>
 <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com>
 <20220906220901.p2c44we7i4c35uvx@pali>
 <YxfMkzW+5W3Hm1dU@google.com>
 <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
 <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 02:10:21PM +0200, Bartosz Golaszewski wrote:
> On Wed, Sep 14, 2022 at 12:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Wed, Sep 7, 2022 at 12:41 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >
> > > Linus, do you think we should introduce GPIOD_OUT_INACTIVE /
> > > GPIOD_OUT_ACTIVE or GPIOD_OUT_DEASSERTED / GPIOD_OUT_ASSERTED and
> > > deprecate existing GPIOD_OUT_LOW and GPIO_OUT_HIGH?
> >
> > They should rather be replaced everywhere in one go.
> >
> > I think it is just a half-measure unless we also add
> > #define GPIOD_ASSERTED 1
> > #define GPIOD_DEASSERTED 0
> > to be used instead of 1/0 in gpiod_set_value().
> >
> 
> We've had that discussion for libgpiod and went with
> GPIOD_VALUE_ACTIVE and GPIOD_VALUE_INACTIVE but...
> 
> > It would also imply changing the signature of the function
> > gpiod_set_value() to gpiod_set_state() as we are not
> > really setting a value but a state.
> >
> 
> ... now that you've mentioned it it does seem like
> GPIOD_STATE_ACTIVE/INACTIVE makes much more sense as well as naming
> the relevant functions gpiod_line_request_set_line_state() etc.
> 

After sleeping on this, I'm even more in disagreement with renaming
value to state.

AIUI, the confusion here is distinguishing between the physical and
logical cases.  libgpiod doesn't have this problem, as it only deals
with logical.

By convention, gpiolib uses _raw in the function name when referring to
physical, and otherwise deals with logical. e.g. gpiod_set_value() and
gpiod_set_raw_value().  Changing "value" to "state" is orthogonal to the
actual problem.

Further, "state" is a more broad term than "value", i.e. state may
include a number of attributes, whereas value indicates an individial
attribute.

For lines, state and value are typically synonymous, as the line level
(just to throw in another term for it) is what usually springs to
mind when considering a line.  But a line's state could also be
interpreted to include direction, bias, drive,...
You may argue that those form the configuration state, and I would agree
with you - the "configuration" indicating a subset of the overall line
state. i.e. "state" is a broad term.

If you are trying to reduce confusion, switching from a more specific
to a more broad term is going in the wrong direction.

OTOH, I totally agree with the addition of GPIOD_ACTIVE/INACTIVE to be
used for the logical cases, and even a script to apply it globally.
Ideally that script would change both the calls to the logical functions
to use ACTIVE/INACTIVE, and the physical to HIGH/LOW.

Introducing enums for those, and changing the function signatures to
use those rather than int makes sense to me too.  Though I'm not sure
why that has to wait until after all users are changed to the new macros.
Would that generate lint warnings?

Cheers,
Kent.

> > I have thought about changing this, but the problem is that I felt
> > it should be accompanied with a change fixing as many users
> > as possible.
> >
> > I think this is one of those occasions where we should merge
> > the new defines, and then send Linus Torvalds a sed script
> > that he can run at the end of the merge window to change all
> > gpiod_set_value(...., 1) -> gpiod_set_state(...., GPIOD_ASSERTED);
> > everywhere.
> >
> > After all users are changed, the GPIOD_ASSERTED/DEASSERTED
> > defined can be turned into an enum.
> >
> > That would be the silver bullet against a lot of confusion IMO.
> >
> > We would need Bartosz' input on this.
> >
> 
> We can also let Linus know that we'll do it ourselves late in the
> merge window and send a separate PR on Saturday before rc1?
> 
> Bart
> 
> > Yours,
> > Linus Walleij
