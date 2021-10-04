Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDDD42168C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 20:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhJDScl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbhJDScl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 14:32:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAA4C061745
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 11:30:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u18so75664311lfd.12
        for <linux-pci@vger.kernel.org>; Mon, 04 Oct 2021 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYaHpNPd5iNfSgVGQsCT7+Pa41+xpBTvkNAX6en4bmk=;
        b=YW0KtJsTP5rI4zjU6hpQY7S4u6k9lUh4EEB+CsI+CIfSgEr7C3MO0cObLf7h2xjjx5
         WtKYIF9M6s+d95as+hNn45lVSRYcprnbK4s0lb5tsF2xJxullrt/g3PaI/WIx9/mYJRA
         BINausv0nynG979PoLxCE2wr8xooR3Udqj5LHdwwBvE2D820cC6rUQkh6wKhdKqZFCMI
         UEwvzLQuU9bZ15aBxVwzMgKT3C+LApE2rhuQqn+VHQhGm7cMO2XOGpqwID/PkA3zp5Jv
         h8G+a8pwKxwEMo0yPYTw91VCgh9K4U8PJjS0rbDRcBhutKgw5WPctumnmpctt/IqlbM3
         fn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYaHpNPd5iNfSgVGQsCT7+Pa41+xpBTvkNAX6en4bmk=;
        b=WDPZIUYRxdsEAydYFaz06E6KRZOow6jELUx6wbhRQi2caoHacxSm8Nncqa+XrDYPHm
         UHCFJ+div7Ll5sO2+0xTicQh6SScxOY9+Y8irMNrDVOyfrcXbJE5nCqq5LZATgmQVJDT
         tlygIC/sZTpbaJohc1SNI9HIcGAiJW1b1oJWUcALFuZkHAIWFFau0FjeeRNaq54Cn+32
         9X96Jx8TkFfX/3CYXmQHX4ybkOdnAhlDVVHmxoZD91OY+KsjA+Wyy2kELKFecneDsqhV
         xwQkYs66wENT54R9QosxJbRubK6kKz0O1oNCXkT6CJYySG2qiLLEcIialaeVPsTDcS8w
         2CGQ==
X-Gm-Message-State: AOAM531Daar60x8Stky2Uphd80QZh39oF9c6+FOXabetxi/r26kv0uyI
        mXLayizVEI1AgaClSTEw5etl5uhXLL437KPDc+UqTg==
X-Google-Smtp-Source: ABdhPJzwPMLixmNEteJfYTYbQ05qYkqCLS3fY+3QFW/RcZFdO8U3LfG8R6lZnCdHdRy5zRPcTCePjhzKrDRf131zPjE=
X-Received: by 2002:a19:c10d:: with SMTP id r13mr15971449lff.339.1633372247707;
 Mon, 04 Oct 2021 11:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210929163847.2807812-1-maz@kernel.org> <20211004083845.GA22336@lpieralisi>
 <87czolrwgn.wl-maz@kernel.org>
In-Reply-To: <87czolrwgn.wl-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Oct 2021 20:30:36 +0200
Message-ID: <CACRpkdZzdzJmatnYe2pcKCSW2=WJBa-DZQPib7aGW9m_GLrAwg@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] PCI: Add support for Apple M1
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Android Kernel Team <kernel-team@android.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 4, 2021 at 11:05 AM Marc Zyngier <maz@kernel.org> wrote:

> Yes, that's absolutely fine. I hope we can resolve the issue on the
> pinctrl binding pretty quickly, and get the arm-soc folks to pull the
> DT changes in for 5.16 too.

I think I ACKed a patch for apple,npins = <> yesterday.

> This would make the Mini a usable machine with a mainline kernel.

That seems useful.

Yours,
Linus Walleij
