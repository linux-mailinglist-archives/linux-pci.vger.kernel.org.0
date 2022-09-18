Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48C25BBE7B
	for <lists+linux-pci@lfdr.de>; Sun, 18 Sep 2022 16:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIROiB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Sep 2022 10:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiIROho (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Sep 2022 10:37:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE212559A
        for <linux-pci@vger.kernel.org>; Sun, 18 Sep 2022 07:37:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f20so33329900edf.6
        for <linux-pci@vger.kernel.org>; Sun, 18 Sep 2022 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Rlg0/ZYnRtBFDzMZxXf5GS6F9a3najBH1vMHMWoExj0=;
        b=k9RNeF+avOEI2E4SLM1Bqmu/o8xiuXG0PsspBP3jZ9ZtKqaoZX4hD5f+viONmzsq8f
         /rJuVgo9WDsioBHPQqImmPEbgBjXG1hiyfILZsrnkdWlud84P898eyiWCk0GEy9TRwTi
         hfBFnJWZJsqjnxceuGLK+FJrpQwHr399zi33ei/iQsD1h9nCxOAD/W9O6iwSYmFz0Whp
         EBri77hU9anSTlALAolse6UsiFQTxH92dsprae5Na/Ay37xmi8F+caxE+pHvEJ7qyl3k
         wBn4DD5NNB0cnnRvum9+bRPRoe6RQZeVzexSLjptOQpxiH0mRjGBeuq2YmHUfGKHUe+R
         fy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Rlg0/ZYnRtBFDzMZxXf5GS6F9a3najBH1vMHMWoExj0=;
        b=Kk0AcW2/KWAh8JdngaYEOPF3FgRmETkd/v3tB0hU1Bagq03V3MvMgYW30pMmEBp2gn
         GPdsQsRjVn8vknqm3QyXdpJZQl3bRZleCCRGp5E3a8sURFrtBRImOyytBcDslF0xSyYG
         6NxMBWAXAH5AbFljRcEW82gE4LmYQCOz/iPgU7QFggY31I2a+NMiqknMY36re8P7M9vh
         qKbAbbcpJvcKRgSxPmT4eDQO+M8Bkyo/piJcCf7ZKfjk9a5XHHq3VD3xDqODmzKMJ3uD
         7KYrKEuc0ctUiplEGTZ1okIqb/EGDrtcCG7jHodg/XHP+wn21AkBc8rsO3iAKhCfe/V7
         wFLQ==
X-Gm-Message-State: ACrzQf2ZrSxB3mQeOhFQv5/5g2qs4qr7XwGBw0YDmzszpx44/xY9g6kK
        LPYHd241EiliG1xCdqamda+QlS42bXEZvX6gW2PVjQ==
X-Google-Smtp-Source: AMsMyM5Wl8ZJ7WqDthqk4Br/EAT2b/keFxbgHyOWdYbcmMI9IUCSfXOex7sktdU3JLZ9Tt+TxuSeMHhazf1YKzoLTKU=
X-Received: by 2002:a05:6402:2690:b0:452:3a85:8b28 with SMTP id
 w16-20020a056402269000b004523a858b28mr11451311edd.158.1663511843470; Sun, 18
 Sep 2022 07:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220906211628.6u4hbpn4shjcvqel@pali> <Yxe7CJnIT5AiUilL@google.com>
 <20220906214114.vj3v32dzwxz6uqik@pali> <YxfBKkqce/IQQLk9@google.com>
 <20220906220901.p2c44we7i4c35uvx@pali> <YxfMkzW+5W3Hm1dU@google.com>
 <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
 <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com>
 <YyKMsyI961Mo1EQE@sol> <CACRpkdYB6dZf4TBhfXB2Z5E2PJ46ctAM_QKLiW-fykbCopcVGQ@mail.gmail.com>
 <YyLwsOBXv9jRw/+n@sol> <CAMRc=MeF2uNmx_-mZikg=3nMV4aHK+bCUBEcLGEgJ6JY4jZ_Sg@mail.gmail.com>
In-Reply-To: <CAMRc=MeF2uNmx_-mZikg=3nMV4aHK+bCUBEcLGEgJ6JY4jZ_Sg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 18 Sep 2022 16:37:11 +0200
Message-ID: <CACRpkdZWirbY9KRH4r3Q_SU0my-5BUDNkjEUei_May4=_yVZvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 16, 2022 at 9:23 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> > Enums work for me - especially if the goal is to differentiate
> > logical from physical - there should be a distinct enum for each.
> >
>
> We won't even have to change the function signatures if we go with
> enums - they already take an int and I'm in general against putting
> enum types into function signatures in C as they give you a false
> sense of a strong type.

We are adding Rust to the kernel soon ;) then it's good for
documentation of what it is actually expected to be.

But I get your point.

Yours,
Linus Walleij
