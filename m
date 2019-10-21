Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C30DE186
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 02:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfJUAkm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Oct 2019 20:40:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40491 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJUAkl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Oct 2019 20:40:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so11389519ljw.7
        for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2019 17:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6Xo9B6o9SIZMKltywI4CiX1SZ99OwUFgC+m3ay2Ymo=;
        b=zroUUUrfgfHLCjgOyR2uQ2lLhWyKSM7uEj1yfxnkSSToT1Elup+0aFqlDLFwh9G/n2
         KmTyKhUQBndxk5V92CCxunqRlxvT1jz39Hi0bjTlcO8/JBejG5joPR6goquCAbY1q8r5
         c4pKHfEl0bulWgTXTtr+82ImDmgMw2jNre53NjUrfx2uQJugQo9wuJWUaquqK5XdTNWa
         wWxphcewpaq4w17KtJTsfDZ/G/9tO6b1j3OEyi+2KchtoK+DEqJnQ+3c6IUkzZHm7KCf
         s5m8n4Dl+/ZQ+m8Jd5Kh/kDLz/KDGqnFn1t5nhMws+ktDfHLGN+r3tgJ4NqeOx0DdF9m
         GLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6Xo9B6o9SIZMKltywI4CiX1SZ99OwUFgC+m3ay2Ymo=;
        b=N5OdPni5QZZOHKdslmHG3ikZSgSsvkQWF7+rTwr2OjcouE2qvw9yTT5+wA4ef6Ih4Z
         wuZUko4Ih1MM1b1LqmfFcnvqyxr6+fb3t7YwBZuGhnMOAvE5CvcZ3RnZjjSVki4SxMq7
         BmjYIRHaXd0ZYXObo21Fz63yZQSr8t5cbmclzV7kWcF5x9UDz6mT8V2b0jSPqyC4uF16
         Rqi2E0lcorLLHMPS7Gh0LJSAyotJ1or6swtkf0I3wSwtx8mfjnHWLh/3ZejeYU7rDxOv
         JHWEFBQVHUpNZc/EGLCjlcOOzajbPmUm/gzofywtudUO1OBd35AHwrDD7KhZgIh4xeuK
         ks2A==
X-Gm-Message-State: APjAAAWRcM7oQp0WCKzW1rPJDtdxtnP2FcKO99vmlz7mNp/zKjtkjsD7
        WDO2djX7fnJmHTkAum5MB9r72iTMVVfj4yqdxRT7rA==
X-Google-Smtp-Source: APXvYqzrokn9M/Ubcg0CEqbAzJJBvsXnB3LI0TFr0LTW5W/Xiku2p7auDuAK7OWy/bhF9IEAr+uI2BTb4+ImUhUhYhk=
X-Received: by 2002:a2e:a0c9:: with SMTP id f9mr13031793ljm.77.1571618440273;
 Sun, 20 Oct 2019 17:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191016200647.32050-1-robh@kernel.org> <20191016200647.32050-18-robh@kernel.org>
In-Reply-To: <20191016200647.32050-18-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Oct 2019 02:40:27 +0200
Message-ID: <CACRpkdbhPPRDixrR4rWSopFEd-5AKpjHF1-Su-ViAGMDLQiKkw@mail.gmail.com>
Subject: Re: [PATCH v2 17/25] PCI: versatile: Remove usage of PHYS_OFFSET
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 10:07 PM Rob Herring <robh@kernel.org> wrote:

> PHYS_OFFSET is not universally defined on all arches and using it prevents
> enabling COMPILE_TEST. PAGE_OFFSET and __pa() are always available, so use
> them to get the physical start of memory address.
>
> This should have probably used 'dma-ranges' to get the address, but we
> don't want to force a DT update to do that. At least in QEMU, the SMAP
> registers have no effect (or perhaps the only value that is handled is 0).
>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - New patch to fix build failure on some arches.

Always wondered how to do this right, now I can fix other stuff!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
