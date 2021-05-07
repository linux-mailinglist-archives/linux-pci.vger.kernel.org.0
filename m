Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5763763EA
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 12:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhEGKhK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhEGKhI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 06:37:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA756C061574
        for <linux-pci@vger.kernel.org>; Fri,  7 May 2021 03:36:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x19so12119877lfa.2
        for <linux-pci@vger.kernel.org>; Fri, 07 May 2021 03:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4ThqpCDApZFuKAxB9K1Ka8qEg9mB3V4qA9vC26YVkk=;
        b=MzBtlSZzpJAr8tnd/5RIekuBw6l7vSZhO7ebB0heZLPlmkGV24vqwNOwHxJUG4uD1f
         6iBrnIqOoL762HGPJJhI4a9V4bbf/fWM8+2GUZ61ack7UtkNvUhQ3SntvC6/1htbrkMU
         eSQ3yuCa5R3VSLwgJZbKiw+yx8hyvaNLSeX/p5qCV38hh/6ibjxEaGoUGhdVZ66wsbt+
         mpZ4PTCWBvIU37spzVs/kK1pr9/phRVM/CcXDDbOvSBB3mKb8o7vq9jv3hlQIiWIvRZ0
         DCqCwph8yg77C3Ctt6jSsLSeeLQJJhSoaNsG9xcLadrW0I2N6KxY8DkLV4H0gAiIY/+I
         UbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4ThqpCDApZFuKAxB9K1Ka8qEg9mB3V4qA9vC26YVkk=;
        b=ltK0vWGcxZZrkqSkx7ILgJMbCzZkietMqNqHZbXg/Y8UKPfiwML0XaoQHG3PM2I9B7
         nTsCUZ5d8C221eN9M7wuOp/bWZq+t0JBm/1SuACu8/Xm84hfILf8OFX/YgIHnRRI19UU
         Ul8Dkxgm9Ds0q9CczUHtiN0q2z+Wiwj44ruUz8QA8pi9G6Sfm+TbnNh79AdU3bYnZBmB
         1R0Yi95Q+UlBsG5FuE9JvjqWmKO0YoYqQGlke228aG6K+JIHINXf8qeu5ZtlSzxs0uOJ
         W9XYV8P+C5C9FPha5Q3kNdogD7WbdqbrTIY5kxCRtQZOi1oc+RdxJKP6/DGqr8HNlZde
         GDCw==
X-Gm-Message-State: AOAM532v1F4AfY+5lAziQbUjRqj3c9fvbxcj7Vo/gi1V+JtELTLAFeTd
        j4vRAheVLffHJgDOrPjsnQgV1UzCZFOGf6xz+zIVZQ==
X-Google-Smtp-Source: ABdhPJwGVrIFfrGyONppHY8teuB2o77I8NbBL50oT/QlnGc0e3NLmIlNMMRGerTGeyuxvd3Sqtw8r/iA8CTP7iSiP8g=
X-Received: by 2002:a05:6512:6d5:: with SMTP id u21mr6084637lff.586.1620383767209;
 Fri, 07 May 2021 03:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210507103040.132562-1-linus.walleij@linaro.org> <20210507103040.132562-4-linus.walleij@linaro.org>
In-Reply-To: <20210507103040.132562-4-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 May 2021 12:35:56 +0200
Message-ID: <CACRpkdbposbGrihN2S6Vo7czmkhMrKRMbdumdG4M3xJ+=FwX_Q@mail.gmail.com>
Subject: Re: [PATCH 3/4 v2] PCI: ixp4xx: Add device tree bindings for IXP4xx
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 7, 2021 at 12:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds device tree bindings for the Intel IXP4xx
> PCI controller which can be used as both host and
> option.

Ooops I see I missed some review comments on the bindings,
ignore this v2 for the bindings and I'll fix and send a v3.

Yours,
Linus Walleij
