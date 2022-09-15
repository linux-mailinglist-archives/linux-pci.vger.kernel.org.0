Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B837E5B976F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 11:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIOJaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Sep 2022 05:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIOJae (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2022 05:30:34 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B04C12A88;
        Thu, 15 Sep 2022 02:30:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q9so7670419pgq.8;
        Thu, 15 Sep 2022 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=LSuUjN23nOfC/jh6HADsC6Jpj10f77UtFVq8cZc91gY=;
        b=nFuQ7S/kLLD7RN+w5dvH+VYpygYmWNDwqiN1DARe3jLt0V41PSqikB0z16ejEA1TvF
         dv5ZZIid8Qkyqedsvk5G60fqwlWEmOD6OsBVuNg63/+79Vo17t9hFK/vcai7lGiNdrDm
         3QXzZKDzKzQNFWwryyu1HLBRy8FPChbeiIAX8wgy+z+TFtRQh8NMbwf3qiC8kBXo6LBR
         NcIc0SJt4BaqHg+yP7MT1wnpNbDYUChgKgC9KNcEOKejpS5K/BICR8zUctRah61ABQ2F
         LL1FLdOnN68TRP6es+UXjv3XYEFNRJHUFYvyv7ZhSVhKyRG3zTAPH8P62NN97oVM11FT
         9Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LSuUjN23nOfC/jh6HADsC6Jpj10f77UtFVq8cZc91gY=;
        b=T93npBg1GI+cS4OThBm1pZHFOyf8qtR6XVet6iwcP/E76t1+zLNnFHwXgiNHEihkv2
         cglbvZt3vUNE73w2svrgg2zUJNxzoJS+F02/aK1HH2+HQlGbtW9Z7egaEj5ic/MvHCmJ
         jQ23gv1pc9ZPR1WVDCf/cREsFJPSbnZpYRljzbgE41zcvXg8DRhVmwcYweZeXvC4azLC
         GBhMgB+Dy03gWbnAg77HB6QN2iPJhg7nm+8w+h8Lovd33rgSkWpZyx7ijkmyr8jhpkrS
         6ndCQwf3njEHYEWbN1/whGz3LWMvNFj1Tqy1hjsE+t75bPNz3YE+Hh8Pe7jkjK0s4VPT
         nV8w==
X-Gm-Message-State: ACgBeo3TDfYq782Lhmiw0WYeHvdrnD82cNYv62UIEBbZKjFJBrY6P8f+
        JALEmjr47BmNrAW3VeuATqg=
X-Google-Smtp-Source: AA6agR7lu82NQj5MbTGXIwzV5MaOPSt9XzUkhpU+k6EgVsjpvNyQGHyheEedsv4ICnQdAbhroPmpvQ==
X-Received: by 2002:a63:698a:0:b0:41c:8dfb:29cb with SMTP id e132-20020a63698a000000b0041c8dfb29cbmr35309895pgc.170.1663234231668;
        Thu, 15 Sep 2022 02:30:31 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f70500b0017555cef23asm12238859plo.232.2022.09.15.02.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:30:31 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:30:24 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
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
Message-ID: <YyLwsOBXv9jRw/+n@sol>
References: <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com>
 <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com>
 <20220906220901.p2c44we7i4c35uvx@pali>
 <YxfMkzW+5W3Hm1dU@google.com>
 <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
 <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com>
 <YyKMsyI961Mo1EQE@sol>
 <CACRpkdYB6dZf4TBhfXB2Z5E2PJ46ctAM_QKLiW-fykbCopcVGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYB6dZf4TBhfXB2Z5E2PJ46ctAM_QKLiW-fykbCopcVGQ@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 15, 2022 at 10:51:02AM +0200, Linus Walleij wrote:
> On Thu, Sep 15, 2022 at 4:23 AM Kent Gibson <warthog618@gmail.com> wrote:
> 
> > After sleeping on this, I'm even more in disagreement with renaming
> > value to state.
> 
> OK let's not do that then.
> 
> > OTOH, I totally agree with the addition of GPIOD_ACTIVE/INACTIVE to be
> > used for the logical cases, and even a script to apply it globally.
> > Ideally that script would change both the calls to the logical functions
> > to use ACTIVE/INACTIVE, and the physical to HIGH/LOW.
> 
> OK we have consensus on this.
> 
> > Introducing enums for those, and changing the function signatures to
> > use those rather than int makes sense to me too.
> 
> Either they can be enum or defined to bool true/false. Not really
> sure what is best. But intuitively enum "feels better" for me.
> 

Enums work for me - especially if the goal is to differentiate
logical from physical - there should be a distinct enum for each.

> > Though I'm not sure
> > why that has to wait until after all users are changed to the new macros.
> > Would that generate lint warnings?
> 
> I rather want it all to happen at once. One preparatory commit
> adding the new types and one sed script to refactor the whole
> lot. Not gradual switchover.
> 
> The reason is purely administrative: we have too many refactorings
> lagging behind, mainly the GPIO descriptors that have been
> lagging behind for what is it? 5 years? 10? GPIO irqchips also dragged
> out for way too long. We can't keep doing things gradually like
> this, it takes too much time and effort.
> 
> I don't want any more "in-transition-indefinitely" stuff in the GPIO
> subsystem if I can avoid it.
> 
> Therefore I would advice to switch it all over at the end of a merge
> window and be done with it.
> 

Agreed - do it all at once.  My question was specific to the change of the
function signatures to using enums - what is to prevent us doing that
before running the sed script, and have the script switch usage over to
the enums?

Cheers,
Kent.
