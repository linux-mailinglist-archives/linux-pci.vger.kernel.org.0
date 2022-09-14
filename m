Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DE75B8893
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 14:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiINMsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 08:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiINMsv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 08:48:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C3A7969E
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 05:48:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh9so34473514ejc.8
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 05:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4sG1tF+3JU0nq3EIIFZjKqQR03IbcnuuC2yQCxX+cMI=;
        b=b1DuZAAmP+7KHBQONrsAvDzL4e+QTXSfSJjC22Hm3Xb4xT3Mtpx2whstR9aDKlTgzD
         MSOzN3T/RXkqjxfD5tecr7I98165vpgcjM4nK5gbRjPdLBtGPTuY8LCchOCP4OPF658F
         eRXbFstvnVnA2Ma+m0VVdqxNa1u63k5zC8WR1bHhpIMNhTQvGZ4nbzRZmsXfH0lEpXKl
         8ChMVI+FU1i/4EhX6A/gZgsFZJMG3D9Sf8WAAcgzJHdu1+6iofnToOWSazM6kMowji+/
         1ha1PNk8C71HbAKcv1wVN27hJc2dlt7kWnrVIk20ui4xVfI/yJI7J2LMVo/PAIHqyI6S
         fkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4sG1tF+3JU0nq3EIIFZjKqQR03IbcnuuC2yQCxX+cMI=;
        b=BUl+0ynvSNVRWKiIx4PvQXczBVzKyn/iz78RgY7nzSV1brfPUhvVVp7VNndr69Xesm
         zD6AHArvLnGm6G14KL9HXtogtV1oBBCAVMAPn67iMadevGOgDcr+EO/cKKROssfzrgmJ
         uJOFcfoyha4y2pJ+4A6yjGL9UHN4BXVEZAwn5AAsNxNqXauUUIji6oI9/npYEVcGuu40
         m8eA7ogrkAaG0rH9nNg3vWk0b9vqrfD+osIZJ22hsKJwMgmxXKHORbAv+up/knH6gjZp
         Kxxn9UanzojgK5zurzmrYrUfXwW6DZc62BZM33uHoPMUEFpSpLyVOC2JGcokAXicViWO
         U3ew==
X-Gm-Message-State: ACrzQf3TREE6pX0zxIjX4tYfUdx95EdYKaGeVvJw49esxu9L+ZLuo1Ie
        hNxf9Xx2aeK87hFuvHLvI12w5zIuTcKrQebxQgJd6Q==
X-Google-Smtp-Source: AA6agR4wFOLJvnDE2tl+91nTMXNl3vsVtJ3vBjONbLYnvDgls+K4zz468Z+m/tWJQ503m1nRvSmmYGHeI2LbflqFDqM=
X-Received: by 2002:a17:907:7f19:b0:780:375d:61ec with SMTP id
 qf25-20020a1709077f1900b00780375d61ecmr1796370ejc.203.1663159728857; Wed, 14
 Sep 2022 05:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com> <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com> <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com> <20220906220901.p2c44we7i4c35uvx@pali>
 <YxfMkzW+5W3Hm1dU@google.com> <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
 <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com>
In-Reply-To: <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 14:48:37 +0200
Message-ID: <CACRpkdY2-kaywR=vk7dPCj8DB1XZZvRoZcxfGrM5ZuNtBJOkXw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 2:10 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Wed, Sep 14, 2022 at 12:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> > I think this is one of those occasions where we should merge
> > the new defines, and then send Linus Torvalds a sed script
> > that he can run at the end of the merge window to change all
> > gpiod_set_value(...., 1) -> gpiod_set_state(...., GPIOD_ASSERTED);
> > everywhere.
>
> We can also let Linus know that we'll do it ourselves late in the
> merge window and send a separate PR on Saturday before rc1?

I suppose, it's a matter of taste. It's probably easier for him to
check the sanity of a sed script than of all the changes it generates
though.

Yours,
Linus Walleij
