Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE0A3AAFFB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhFQJoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 05:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhFQJoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jun 2021 05:44:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F018C061574
        for <linux-pci@vger.kernel.org>; Thu, 17 Jun 2021 02:42:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r5so9439954lfr.5
        for <linux-pci@vger.kernel.org>; Thu, 17 Jun 2021 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbpqkoKsc31/jLOAOeg4hOtPi4qiHNyJHA2Q4XhgWbI=;
        b=K/5olOdFgfeGN2DWVuOegXfmG7d3HZ09Cr+Jw6YXJpneRDCrzDY1Di9FOudD26vjYg
         HhMfd9hNLwtSlKF1JzRjez80TdpmGHgsNG+K2x6Sf5BwtJ72Mbz2jkOIjncUl2OzS1//
         hf3gSzvv6DQcZ0BbKN07i4ppBlwzCUP9VnzhSD2NlxtMfu6oFAADk+Y4BGz0U+ONt6na
         GGiLEMhoufoXVrQ1rR7gNjwZC/nNK78y37OYfeIsahRjHBfbqqtEEafmexF2rcGb07dt
         e99aPQHqYdVuJu2zV76nEb/YAsTmPRBMSC7c6htdRrqrBiP9F9u2tBZJs6HgGlMlhOLG
         kBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbpqkoKsc31/jLOAOeg4hOtPi4qiHNyJHA2Q4XhgWbI=;
        b=W6kTQTDDLVIH4qGdQQSaFcbmGGJNb0Kh31CWCFWd3P3LjLPFE5jUeMPq84A+KvwDlN
         3ecnGr4r/gMPjKlyZDfj6O4nJrjX96irCjScF3NAGZ3Fh5hnIwcEEjqYSYPxzoenzjMv
         KzF2eiVMgN6qbmnNaFWhl0bRxrK8dfhB0nv/PaP+qI9UUwrLfJzeE1YJscI5es6SZVry
         uU4kucleBE0g+EJgxHmwvl+/dsKx2zcYchYeFN6HiOL77254rhS6ypYkJ4QIlgd/dAQb
         RGLLOJkLG6ymHWcNZ9uHHH1Hwj/lxlWqxs6CqVFO9Qf9ucPI3oKkD2aktyaROPwnV6Sm
         Z02w==
X-Gm-Message-State: AOAM5327Of9YsGpyESjOd1hDnLPtE3So/CXdUiLc8X4Rq33LuUvi6kN+
        OHh4FATT091aRXK969vgQCi+n3OoOErlsHXUeqdSAg==
X-Google-Smtp-Source: ABdhPJxsWiJ2QblNjiP6NTa5fHvAso5h5zcSrO38zuLsp7/kkxV8EkA+Infukhu+7V0sSbjj6/Zm6csA0M150idSIj8=
X-Received: by 2002:a05:6512:2105:: with SMTP id q5mr3185820lfr.649.1623922935673;
 Thu, 17 Jun 2021 02:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210615232425.1253281-1-linus.walleij@linaro.org> <20210616151953.GA2973960@bjorn-Precision-5520>
In-Reply-To: <20210616151953.GA2973960@bjorn-Precision-5520>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Jun 2021 11:42:04 +0200
Message-ID: <CACRpkdZJTnrRwaDk+FB2Pzsytz0My0C+SdxdYjTn5YENQP5UoQ@mail.gmail.com>
Subject: Re: [PATCH v6] PCI: ixp4xx: Add a new driver for IXP4xx
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "John W. Linville" <linville@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

thanks for your help!

On Wed, Jun 16, 2021 at 5:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> I'm a little sorry to merge a driver that isn't as functional as the
> old one, but I guess this doesn't actually *remove* the old one yet.
> Maybe the Kconfig help should reference the other driver with a hint
> about this case?  I hate for some user that uses the 1GB of space to
> switch to the new improved driver and see breakage without a hint
> about what happened.

I have tried to find these users but it seems they do not exist.
users need to set IXP4XX_INDIRECT_PCI to make use of it
and the only existing userspace for IXP4XX is OpenWrt and
they do not enable this.

Krzysztof Halasa talks about using it for a VGA card at one
point:
https://lore.kernel.org/linux-arm-kernel/m37edwuv8m.fsf@t19.piap.pl/

The plan is to locate these users (if I can) and in case they
need this use an idea from Linville for indirect PCI access,
if they can provide testing (I have nothing to test on
unfortunately...) I can't find Linville's patch right now but Arnd
pointed it out to me.

I fixed all the other comments in my tree.

Yours,
Linus Walleij
