Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235E9285BBD
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 11:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgJGJRy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 05:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJGJRy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 05:17:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF0FC061755
        for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2020 02:17:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m16so1231549ljo.6
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2020 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uGh7FwCQVsEaQRU10K3At5FG2/9JxC6uGho+Uy5WLc=;
        b=ZMS9/cveuDXMSwvbiHVUdNS/sgKoK13pgzqeUFPU59/WIF9oXdaca+YvED7s3BfwzW
         9UuBhNQoTOQPd9LrtPqbQUCI5PDAXN0pOGjko8yChPSAdQ1yjmpCxf+4yLx0E84c0Gi+
         WwvhbqXrKCuLurT50RFhcAH6nlljW06Q+QCKzerzY9+cfMVPygmYKdIuohTS3WZRN1NZ
         FXCYzQ70GGKpk1N1JboJQ0CFkVSBlZSn1xFIVeqDWPBwXaZx3QX1OQFdFAdwEGkURHPs
         +cvrcW2BbRJWPD6ck611GV7NU1QoaLRP+0+AaYZELuUHw7WnkeaPvAjfcwp5R5oegfSQ
         xePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uGh7FwCQVsEaQRU10K3At5FG2/9JxC6uGho+Uy5WLc=;
        b=nSraFACgcW0ddi7HCp1dCbxPRG/DZgc/Emab3SwdwTzHZdnidGKggY1pdVGfxdhxjd
         ZjY1ay0cnIVypH+cef/lWsAXQwPehg3bHkEDytA02vODcoBPv/3Qv10YJhJfsxCuEwb4
         JjH+3Y+FMB+5rgS+oWYPQPmSaWayfxUEaBS8o5TZ0qg5PEXJRpHLrh3SlG2/aTsvjfiG
         rUXzPg6OtPtwAjNXw7krbAQZucKPGBsQvtdsFBqBMAHsMrGAKmU/RJWuS/Y2iCtY4qYk
         UhAEjZtk1cwSlefWqn9lv0Hl3YXHljbSX3WnpNfJXvzNASYliORww2llCmrReWksTGVw
         0IHQ==
X-Gm-Message-State: AOAM5335Z9RmxJ/6VfVnELeQ1Toye4VkrRltYPf4q/ww7GWNdkJo2Wdn
        n19qnq3cuPmajBXikuJ8m9JyI7oZx9Wg+jidvHgf1Q==
X-Google-Smtp-Source: ABdhPJxjuQXpk5FIl/0qqksgxzAprDeL1Wj2TwDzK3bXwtDKVnpHw6xmqCKyi5kIfQtVHeDXLKfAkFV7IEjJ2ME0TSI=
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr767730lji.338.1602062272121;
 Wed, 07 Oct 2020 02:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Oct 2020 11:17:41 +0200
Message-ID: <CACRpkdZdAs_FK8NU+KE5hZBVTZ-fBRDi7=zn0PqxZhPJR+zxwA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] GPIO support on the Etron EJ168/EJ188/EJ198 xHCI controllers
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb <linux-usb@vger.kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, systemchip@etron.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 4, 2020 at 8:00 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> The goal of this series to add support for the GPIO controller on the
> Etron EJ168/EJ188/EJ198 controllers.

This overall is a fine driver, but have you considered the option of just
implementing the GPIO chip in drivers/usb/host/xhci-pci.c?

There are several USB serial adapters that have a GPIO chip
embedded and we just add the GPIO chip into the serial driver.
I have done the same with some networking switches. It is
perfectly fine for drivers outside of drivers/gpio to occasionally
define a minor GPIO chip if GPIO is not their primary function.

Please consider simply activating the XHCI driver and make it
instantiate a GPIO chip if it happens to be an
EJ168/EJ188/EJ198 controller.

Yours,
Linus Walleij
