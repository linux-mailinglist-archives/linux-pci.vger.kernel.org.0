Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B775B88C0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiINNAr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 09:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiINNAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 09:00:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447F25F9B9;
        Wed, 14 Sep 2022 06:00:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b21so15057306plz.7;
        Wed, 14 Sep 2022 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=E86UqW0NjXan1+5ekrU8xgvKtMBJZ+2zIIp8Nn+Sa48=;
        b=MykP4eiQ2nzoFwKY+WdzqvOY2/brwsCFaPmAe24a14xGBSPD9wm5eaJW9EiTOWwJcP
         qsqVWj7GOR7XIM2YOT97H9QsApnWjTT7979TBEk5xCyE5NclQbveQGEitsN2zIaxa6rP
         OJQFFrQ4pLoH2hdSnzztkttCWmbezb+0IT431mwE/LAlksy5uKDVmtAGEGjP26KZIAFK
         zbJp9HIHQVD9wfSMVlcOK3VZVn+mJ0LU6HSwr5UHoQ53g8FP0QmmKzk77PNqEK1T5I7f
         4DBWtnaVk8GjRd74zCAcUPV7xMtuW5iP5IwjgeK+Xfck6+PmDENDf4ArqKVOGbRmPKo1
         PgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=E86UqW0NjXan1+5ekrU8xgvKtMBJZ+2zIIp8Nn+Sa48=;
        b=ETNYd2SdFwtpXrLl0LIsefichNzFmOTqlqGvwuokRRNRSPF+JgXZv6YNG166+0uzA9
         JAfWnOP5XGbx7muO5BXsrQDs4jodznHtKA1xsmqonon0VPabfUxOwjcjuqYc31aw4zvu
         ubT1jgeDwGROqmlTRvgrMOid2XQV8nL4G3j93vHvzZ13mvBdTkzdAWjbMPedJBv/NcZb
         d2N6WuhvKHdcmexntDTXi4ExyU2WDoSyQHCejR+tVAlEL+MRhhy3Sc93aEtXmcP5vua2
         uBKMxwsC6YS+864Wvbti6nKpvZzDvrs2DhjxgLzwoQCtYxnNzObm2YvrWhs6tScjcnt2
         Q1dw==
X-Gm-Message-State: ACrzQf15bUsV/Mry9oERwUsc1B3cFpPpxF8nkuBj2COS7DQ4kqe8wTka
        AQSFShTs92ZripjMm4MkxfU=
X-Google-Smtp-Source: AMsMyM4jgLBKUPxVNHITlKs3mnFnoqFaqYuNHVi7Sacfdoh6eLUtvZFX56/q2Ak//FKe1/mgHWoqKg==
X-Received: by 2002:a17:90b:4a03:b0:202:8495:627a with SMTP id kk3-20020a17090b4a0300b002028495627amr4793908pjb.186.1663160443729;
        Wed, 14 Sep 2022 06:00:43 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id o187-20020a625ac4000000b00537e40747adsm10030558pfb.36.2022.09.14.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 06:00:43 -0700 (PDT)
Date:   Wed, 14 Sep 2022 21:00:36 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
Message-ID: <YyHQdN14bI4WeCKp@sol>
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

I might be in the minority here, but in this context value and state mean
the same thing to me, so changing from one to the other provides no
additional clarity and is at best pointless.

The key distinction is whether you are describing a physical or logical
value/state.
High/low should be reserved for physical.
Active/inactive describe logical.

(I personally dislike "deassert" as it is a manufactured word that feels
very awkward.)

So for gpiod_set_value(), which expects a logical value, you would use
ACTIVE/INACTIVE.  For gpiod_set_raw_value(), which expects a physical
value, you would use HIGH/LOW.

Given there are gpiod functions that expect both, there is a case for
both to pairings exist, and for the caller to use the appropriate one
for the call.

Changing gpiod_set_value() to gpiod_set_state(), while leaving
gpiod_set_raw_value() as is, does not reduce confusion - at least not for
me.

Cheers,
Kent.

> ... now that you've mentioned it it does seem like
> GPIOD_STATE_ACTIVE/INACTIVE makes much more sense as well as naming
> the relevant functions gpiod_line_request_set_line_state() etc.
> 
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
